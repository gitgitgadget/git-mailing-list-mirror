Received: from mail-ot1-f50.google.com (mail-ot1-f50.google.com [209.85.210.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5195055769
	for <git@vger.kernel.org>; Thu,  8 Aug 2024 18:09:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723140586; cv=none; b=A7+W/+KAaT8aZ/1Rzbzq+FWid2Fn2CZO9p9VZznQkEeYoOXBd6WFqcAouclvbVcrFetWU2fqJyI9f+T08zXr2mDemC4gLciuc5cD3IoAyN5wfZ2qwFDNm3zwzstaJtyJExBa2h5jm8XrwRzEabznbXKFggdZQ/+u/fdoeqIEcxE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723140586; c=relaxed/simple;
	bh=5hqu+1xmXiqrzAw2o6zfIEndaSWxvCCi5GI1EeNyJnQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=skte+yEkNrM9KdFfcAdxvaHQ5yvdWZTiv5bf47T+4d11juI47TbMvPn55bbtd0FX7hI+OJQDJnAMQLArb6/mVRSsX4vtY1CbWmHTv76pxnfYJLlenocmS1qGiiG81GUvqIcSkqpBkula3MYunTL+pKwryeVLJ8lS+NSjU+MZnf4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=O8F6m1MK; arc=none smtp.client-ip=209.85.210.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O8F6m1MK"
Received: by mail-ot1-f50.google.com with SMTP id 46e09a7af769-7093b8ffe01so32092a34.2
        for <git@vger.kernel.org>; Thu, 08 Aug 2024 11:09:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723140584; x=1723745384; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=f7hBHlRIGXQmx92Txp9kv7cfply7z27pFbHtayECEcw=;
        b=O8F6m1MKDzp74nzofu4Jw6oOGv+RYEPiCLgkTWyysEYyqmePbm4Nm9rx5ijiNJ4qwJ
         A40VBXsqwqPfBVuT0wjcaJspXagid7mG7PbC/My4SevvbvtS6R0NXHatGEioFOvohAVu
         DVzLzwqzNBegFq0Apn1OtbxpeQkUxHh1oVEpHlVIHH7AFurCpQik5fVwPy+s5BPoYHSy
         gut0RySlIMpUHDYRSYVpDfKqAdUVyf/SSH4RCmdvhd0YZSvkrn1aofwl5VD69AiD9vAl
         mH6+WY2q+cpetjrsow9fW3Rb/IusRhrKHQ9Ul2+ryk6SyclaNcCUKKYNSx5840eHBr5O
         1Cpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723140584; x=1723745384;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=f7hBHlRIGXQmx92Txp9kv7cfply7z27pFbHtayECEcw=;
        b=K4jdlHigpMyVIzOgBxoe0PNMAufC2G91Wr028GDniUF0IctkLLNSdZaKCNYOdAXWY2
         U1VhFBCBECsOSJ6b15+SkNoBMLxEUrOTsoiRAjua4880VHcWaEzwbqEcbQsPvk33n+ps
         ZlRYz8+uCqUwhblH4DUiIDdikV9BKIGG0MK9KoDOQ8a4QmknJRDxNxmqi00kuj1N82wa
         WJelPsxGc+k/pKBBMmHdVY2i1nun1rYx99j6GL7qtv1rRRLHGW8OUXAJy/BTTku9HKAn
         e7en4oBbONPR1uGrtQdDBFj0l5hTc0vhO5eXDPd6mdtVS2yz+64UjHiMf7ECFp++Lik1
         3CBQ==
X-Forwarded-Encrypted: i=1; AJvYcCVB1YeyyP34U2ZWyTJea2W3uFPn4C9bLdKK0Hugsf+6YfPYKS1P3D2HWh3qMrbFg6ixBbM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzt/nS7fCaaaWxmfQLg1c3imlWGdOD98X4BoXrBdebGWvP8RLJ3
	iOpofJ+l7jKEYsWt5LvNvn6B/zu7BF/x1Jb3pmnVanhC+5H5fSPY
X-Google-Smtp-Source: AGHT+IF4NVUZvNKHactuIIb3zLTb3rlCPFOwtz8tKAwWi/kyehaBfdJArYJkSiXOJr7vxtqvwTJVpw==
X-Received: by 2002:a05:6830:6309:b0:703:77c0:cedb with SMTP id 46e09a7af769-70b550d9804mr285881a34.1.1723140584142;
        Thu, 08 Aug 2024 11:09:44 -0700 (PDT)
Received: from [10.37.129.2] (pool-96-240-20-160.nwrknj.fios.verizon.net. [96.240.20.160])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6bb9c864c87sm69112326d6.115.2024.08.08.11.09.43
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 08 Aug 2024 11:09:43 -0700 (PDT)
From: John Cai <johncai86@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
Cc: John Cai via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org,
 Phillip Wood <phillip.wood123@gmail.com>,
 Kristoffer Haugsbakk <code@khaugsbakk.name>, Jeff King <peff@peff.net>,
 Patrick Steinhardt <ps@pks.im>,
 =?utf-8?q?Jean-No=C3=ABl_Avila?= <avila.jn@gmail.com>,
 Linus Arver <linusarver@gmail.com>
Subject: Re: [PATCH v3 1/3] refs: keep track of unresolved reference value in
 iterators
Date: Thu, 08 Aug 2024 14:09:43 -0400
X-Mailer: MailMate (1.14r5937)
Message-ID: <7935D449-F5AB-42CA-951A-E2A07053CC07@gmail.com>
In-Reply-To: <xmqqbk24nhad.fsf@gitster.g>
References: <pull.1712.v2.git.git.1722524334.gitgitgadget@gmail.com>
 <pull.1712.v3.git.git.1723059768.gitgitgadget@gmail.com>
 <fc3defd9c47e32bb23ba0fcb5c885274f3706b23.1723059769.git.gitgitgadget@gmail.com>
 <xmqqbk24nhad.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Hi Junio,

On 7 Aug 2024, at 17:40, Junio C Hamano wrote:

> "John Cai via GitGitGadget" <gitgitgadget@gmail.com> writes:
>
>> diff --git a/refs/files-backend.c b/refs/files-backend.c
>> index aa52d9be7c7..5ed69c23f74 100644
>> --- a/refs/files-backend.c
>> +++ b/refs/files-backend.c
>> @@ -245,9 +245,11 @@ static void loose_fill_ref_dir_regular_file(struc=
t files_ref_store *refs,
>>  {
>>  	struct object_id oid;
>>  	int flag;
>> -
>> -	if (!refs_resolve_ref_unsafe(&refs->base, refname, RESOLVE_REF_READI=
NG,
>
> Here, we had a nice blank line that separated the decls and the
> first statement.
>
>> -				     &oid, &flag)) {
>> +	const char *referent =3D refs_resolve_ref_unsafe(&refs->base,
>> +						       refname,
>> +						       RESOLVE_REF_READING,
>> +						       &oid, &flag);
>> +	if (!referent) {
>
> We lost it here, though.

Ah will restore the blank line.

>
>>  		oidclr(&oid, the_repository->hash_algo);
>>  		flag |=3D REF_ISBROKEN;
>>  	} else if (is_null_oid(&oid)) {
>> @@ -268,7 +270,11 @@ static void loose_fill_ref_dir_regular_file(struc=
t files_ref_store *refs,
>>  		oidclr(&oid, the_repository->hash_algo);
>>  		flag |=3D REF_BAD_NAME | REF_ISBROKEN;
>>  	}
>> -	add_entry_to_dir(dir, create_ref_entry(refname, &oid, flag));
>> +
>> +	if (!(flag & REF_ISSYMREF))
>> +		referent =3D NULL;
>
> OK, this is new in this round.  The idea is that everybody else can
> rely on the invariant that the referent being NULL is equivalent to
> REF_ISSYMREF bit in flag word being off from here on.
>
>> +	add_entry_to_dir(dir, create_ref_entry(refname, referent, &oid, flag=
));
>>  }
>>
>>  /*
>> @@ -886,6 +892,11 @@ static int files_ref_iterator_advance(struct ref_=
iterator *ref_iterator)
>>  		iter->base.refname =3D iter->iter0->refname;
>>  		iter->base.oid =3D iter->iter0->oid;
>>  		iter->base.flags =3D iter->iter0->flags;
>> +		if (iter->iter0->flags & REF_ISSYMREF)
>> +			iter->base.referent =3D iter->iter0->referent;
>> +		else
>> +			iter->base.referent =3D NULL;
>>  		return ITER_OK;
>>  	}
>
> Hmph, why not an unconditional
>
> 		iter->base.referent =3D iter->iter0->referent;
>
> instead?  This code is making sure (iter->base.flags & REF_ISSYMREF)
> is directly linked to non-NULL-ness or iter->base.referent, and we
> want to make everybody take it as invariant.  Shouldn't this code
> also rely on the same invariant?  If iter-iter0->referent is NULL,
> iter->iter0->flag has REF_ISSYMREF bit off, and vice versa.

That's a good point. Even though this code will be used in a loop, if we =
just
set it every time unconditionally then we won't end up with leftover valu=
es. Wil
l adjust in the next version.

