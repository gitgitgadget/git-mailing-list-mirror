Received: from mail-ua1-f44.google.com (mail-ua1-f44.google.com [209.85.222.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D301850275
	for <git@vger.kernel.org>; Tue,  9 Apr 2024 20:29:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712694593; cv=none; b=HRJ4tgZEyXCUgPRf0vRPATDsX71Lp4ps1py8NgffDqodbo3VZ09ZG5ebig4xub3jD/gAQyXef/x22MZ2PAbiJ1TO6FaKdyHY2ETRmIXvcEs7yoiGhQkLPpQYdRVJQaP5gRwKDRIqZv86a9dSYQl/Roftn00p9wMNqOVcWtJEjBg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712694593; c=relaxed/simple;
	bh=C0fvJaupx3od8owt2HMNKcvNSp8DITLpiyfOEqSU27M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nl82bvXHUowfMRZrnj3m/O3MX9byMoC1ruL2MZuU1A5SUVncaqVDbg1KKdZMEK/BtSrOVg3vzQllu8xhpVSM/+hLhNqLhk97SU9gANc+KEoAizZ9JLuVJK6aRlZLYgV6TlTZfulLDKqm9VM6W+VmCHehUtjj+1x/0hhZ5OAWVPk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OqehfwS/; arc=none smtp.client-ip=209.85.222.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OqehfwS/"
Received: by mail-ua1-f44.google.com with SMTP id a1e0cc1a2514c-7e72677ead5so226804241.0
        for <git@vger.kernel.org>; Tue, 09 Apr 2024 13:29:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712694590; x=1713299390; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7HkoX2A/Z7x8FlLyoGBej8TFHM8+HQI5AcfStkbqNSY=;
        b=OqehfwS/o9Ufzg9kgsXrdRCsU3Ufm9vc8rRqUF0/xKnANmrtcS+QAHvBndZ70HOYHJ
         d4V9BUhPLvPtHDfOfnIY5JyM7bGBtLhCU4PVRw2vDuwod3vVmHYCiGlkamuTJm7IjwQ+
         WC0wwd+ns8FsMkW0+G4ZAfvbzFWPVGHYs2/RIK0F9FNh991X0bG0KwR4sXRiTBqkq8uV
         TNE/6DvvCHiq0WH5DWKchBs3+tsNwTvHHHWFCYyjzd6yHWJXOImgcm7URrNpx4lPtTZI
         N0CH+e4fv9Y/imSmpTNSw5KEL4Dxg7tzLJzc4jArJlxI3HzylkVp/3AFGBwv3HhDEVX3
         rECA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712694590; x=1713299390;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7HkoX2A/Z7x8FlLyoGBej8TFHM8+HQI5AcfStkbqNSY=;
        b=scJx4WkcCNHdQtOOKB3Ck28TK7mhtZiE1HyQGKDSNcsn4akA3A85vLbJI2gKAt+1Rh
         SG5qLwQWLJi8HbizRj57LVc/iUpfK2+apmRQWd9mIwZ4LD6Pc1gcIIHmBsbRT7EHqqhY
         9xCweNjmwUKygeRXNn5HDkFcL5vEwMUfppl3H03OsH4R2SdwKwm9L+DLUdkRVi+X9PYe
         oTGMWQuedsLt7DIvWTObS3NitqFmeNrp6FEl/TitvrQ3jR/r2e28EYDhQx7Z94spORBW
         wA8jsr6Zhsz7AcNEyEGD9FQn9eiHlkQ6QOI0MCQTnwy+/bPnOBR5HJyhJf0fbkPKZdYe
         3cpQ==
X-Forwarded-Encrypted: i=1; AJvYcCXKH1i6+YtnH6cNpyOLEpR8bzjeQZL9Ez3K1u9Fh9LFEnBexWrabK5ctpkRvr4BwW2apKzepzwFILQxm+/8JSp3kDu/
X-Gm-Message-State: AOJu0YyKpy1JsWg12zOLxHDYMULNFgjLBLsh0kqZlN3pURsnuD/xF4ol
	D5gsoZ8+8eu3s+icKm1mmakV5bf9ViQjr0e4uYCIYfOToYOpXr4c51GaQUia
X-Google-Smtp-Source: AGHT+IHQY8wgV7jVPyonXh5G8V4Jath/1rvFIeMisFCCYS+HGOHOUZAnR69cgC5wdewmyavBFU3fTg==
X-Received: by 2002:a05:6122:4586:b0:4d3:3a78:60e2 with SMTP id de6-20020a056122458600b004d33a7860e2mr925311vkb.1.1712694590492;
        Tue, 09 Apr 2024 13:29:50 -0700 (PDT)
Received: from [192.168.1.68] ([2607:fb91:139c:ba4:b56b:bd12:58d6:a047])
        by smtp.gmail.com with ESMTPSA id w8-20020a0cfc48000000b0069b114bcb2esm2814985qvp.46.2024.04.09.13.29.49
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 09 Apr 2024 13:29:49 -0700 (PDT)
From: John Cai <johncai86@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
Cc: John Cai via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org,
 Phillip Wood <phillip.wood123@gmail.com>,
 Kristoffer Haugsbakk <code@khaugsbakk.name>, Jeff King <peff@peff.net>,
 Patrick Steinhardt <ps@pks.im>,
 =?utf-8?q?Jean-No=C3=ABl_Avila?= <avila.jn@gmail.com>
Subject: Re: [PATCH v2 1/3] refs: keep track of unresolved reference value in
 iterator
Date: Tue, 09 Apr 2024 16:29:48 -0400
X-Mailer: MailMate (1.14r5937)
Message-ID: <DDF183A6-2840-4225-B459-8D9B4287D98F@gmail.com>
In-Reply-To: <xmqq34rv791a.fsf@gitster.g>
References: <pull.1684.git.git.1709592718743.gitgitgadget@gmail.com>
 <pull.1684.v2.git.git.1712597893.gitgitgadget@gmail.com>
 <6adc9dd26da4459d246591ce148c960b33bde336.1712597893.git.gitgitgadget@gmail.com>
 <xmqq34rv791a.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Hi Junio

On 8 Apr 2024, at 19:02, Junio C Hamano wrote:

>> diff --git a/refs.h b/refs.h
>> index 298caf6c618..2e740c692ac 100644
>> --- a/refs.h
>> +++ b/refs.h
>> @@ -71,9 +71,10 @@ struct pack_refs_opts {
>>  	struct ref_exclusions *exclusions;
>>  	struct string_list *includes;
>>  };
>> -
>>  const char *refs_resolve_ref_unsafe(struct ref_store *refs,
>> +
>>  				    const char *refname,
>> +				    char **referent,
>>  				    int resolve_flags,
>>  				    struct object_id *oid,
>>  				    int *flags);
>
> If referent is meant to be an out-parameter, it should sit next to
> oid that is also an out-parameter.  And as a late-comer sibling, it
> should sit after its elder brother.
>
> Also, I do not see the reason for the shuffling of blank lines.
> Shouldn't it be the other way around, even?  After an unrelated
> definition of "struct pack_refs_opts", there is (and should be)
> a blank line, then the first line of the declaration of function.
>
> Perhaps some fat-fingering.

This was indeed a case of fat-fingering.

>
>> @@ -1928,6 +1928,7 @@ int refs_read_symbolic_ref(struct ref_store *ref=
_store, const char *refname,
>>
>>  const char *refs_resolve_ref_unsafe(struct ref_store *refs,
>>  				    const char *refname,
>> +				    char **referent,
>>  				    int resolve_flags,
>>  				    struct object_id *oid,
>>  				    int *flags)
>> @@ -1989,6 +1990,8 @@ const char *refs_resolve_ref_unsafe(struct ref_s=
tore *refs,
>>  		}
>>
>>  		*flags |=3D read_flags;
>> +		if (referent && read_flags & REF_ISSYMREF && sb_refname.len > 0)
>> +			*referent =3D sb_refname.buf;
>
> Is this safe?  After this assignment, which "return" in this loop
> are you expecting to return from this function?  If you fail to
> return from the function during this iteration, you'll clobber the
> same strbuf with the next refs_read_raw_ref(), but I do not see how
> you are ensuring that you'll return from the function without such
> corruption happening.
>
> This assignment happens only when read_flags has REF_ISSYMREF set,
> so the next "if it is not, then return refname" would not even
> trigger.  If RESOLVE_REF_NO_RECURSE bit is on in resolve_flags,
> then we'd return without further dereferencing, but if that is the
> only safe exit from the function, shouldn't you be guarding the
> function with something like
>
> 	if (referent && !(resolve_flags & RESOLVE_REF_NO_RECURSE))
> 		BUG("recursive dereference can will clobber *referent");
>
> to protect its callers from their own mistakes?
>
> Another return before we start the next iteration of the loop and
> clobber sb_refname with another call to refs_read_raw_ref() is the
> error return codepath at the end of the loop, but that is a totally
> uninteresting case.
>
> Or am I totally confused?

Yeah good point. This probably not a good idea. In fact, perhaps adding a=
nother
argument to this function is unnecessary. We already have refs_read_symbo=
lic_ref
and we can just make a separate call to that once we know that a ref is a=

symbolic reference. Though a separate call is less efficient, I'm not sur=
e it's
worth adding this parameter.

thanks
John
