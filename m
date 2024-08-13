Received: from mail-ot1-f46.google.com (mail-ot1-f46.google.com [209.85.210.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B63EA183CA6
	for <git@vger.kernel.org>; Tue, 13 Aug 2024 09:58:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723543112; cv=none; b=CJnQwYMjUB9/IFc2zMbt4XyBHHVZDffqsr68s3YbLSE2GnSc1zaOB3hD3uK8Bs20md3k+vLugOs7HUu2bk11Y1QJH88MVC4HiT+8cJES4d0sWL6b85ZD5+yurzefG/HOPe787Pgg/l3aMCdLzuTnCJKHXdt6DG97NfnU4bSk49A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723543112; c=relaxed/simple;
	bh=pmDCUXWTuzYkzmwgZcbK+CM/LkfAR0sjx59eHvXj+AM=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Content-Type; b=RAyTeKQ30DtPtqVZwZHMJNPsg4Rb4r0JckfMRioLaGBHXMY1RkHcO1ewJKesshRiTWH1z9EIcFBYJJEYqGEl14u/8D7Rc5HbnIEl5YIoga7etG5TUaT2TtYgmloUXNUWjLGIEKDJtkdCFr2A1sOpH7WqLJIK17nwPhJxe2tn23s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lVX1H0Ju; arc=none smtp.client-ip=209.85.210.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lVX1H0Ju"
Received: by mail-ot1-f46.google.com with SMTP id 46e09a7af769-70944d76a04so2909618a34.0
        for <git@vger.kernel.org>; Tue, 13 Aug 2024 02:58:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723543109; x=1724147909; darn=vger.kernel.org;
        h=to:subject:message-id:date:mime-version:references:in-reply-to:from
         :from:to:cc:subject:date:message-id:reply-to;
        bh=d585kw+C1Sj6HeRfy7Tsq37g5X0S17kV2BNwoiYn9XI=;
        b=lVX1H0Ju2eUAtiky7twoBjA7wBrKJOOWQWktsM3fLkAogt5A8CNMBzdzSFpsteeu/d
         4lugIHJalLXj8oM52IdL/V5i6su3j9cHuELFzW8jQG980TW5qXn6hASXEQ3lSMwg8RK7
         n5bcBvBYLHfsk2eZRw/vGJ/3Kpn28nWOnJdd9ZaT2gIWWzHG+OOZozC8ImZv17q6sJgz
         UiVmMOmbiIx6pXA40m1EMPmst35ZDlwIV2kqZ600cwAuSe1RnfQ+k7nyxuwl89Q37n3f
         /KjtLHU9ynra42+odav/DS7Np7cLVfMBsKTWIHYVeEIMgy9jPja6u6EyTbMIYr1aRFiY
         vVfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723543109; x=1724147909;
        h=to:subject:message-id:date:mime-version:references:in-reply-to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=d585kw+C1Sj6HeRfy7Tsq37g5X0S17kV2BNwoiYn9XI=;
        b=TH3dARzOouIbwgzBBfVlEPACIUo+Q6/qtYrxi1lrWhG/whwZTOL29ArOC3ZGQZUO5W
         tFV81aX1LCLlWZojzuQdmDI4GfrwaeM10GWvPQAS63pwdtc8M70ZVVyjYL0mKlajBR/j
         KhyhyyaSIki4KEKz058fKICpM28B1zw7eXb9RvNiUENlZMdj9kqMYSvivlguFj937rsb
         cSng26Q9OmMnLmrHL8zcdbpHn9htwhlzmj74Fcp95bV39ZX7W8XSbWmCyYouNxeZ0W9P
         MR6uvm81Iyt00RzYxNjUpsIWNnBtjPFjcSNrDcSzBl7DU9YacHY5TQZx6r5H+MWpEn1f
         PdCw==
X-Forwarded-Encrypted: i=1; AJvYcCVGRrt06vTdVk8IO/G/UC32Y4XWs9W6I5Wxq+v8XPUKVIzayJ42Wozb4rqLWiLfoxt6Gg3ihTrRC8VgHn1RHzpkwohB
X-Gm-Message-State: AOJu0YwDi3rGr2S7V9cdoSc0+LkWAOfTktyLqnwVKt3qUx1U4WKoM7G3
	PpRvbx5iza7eeCw4IArmJ8iT+F0xNMxLdHi2iCLISVqaJdJpshZhhhJeDNxoFqGpa0rWkQ4HwTb
	5DzMUhuybP5KXHMWRbFwyABajU065YQ==
X-Google-Smtp-Source: AGHT+IFXE671u84DEX4XJQuVmdXQE627gASpBuxnTzK+D8W92Lj0CLBKm8+P4oHdUX3jTjZyHccGqdrUvyyQu46fyEw=
X-Received: by 2002:a05:6830:6011:b0:709:3e6c:a7d5 with SMTP id
 46e09a7af769-70c956d3763mr1193415a34.14.1723543109655; Tue, 13 Aug 2024
 02:58:29 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 13 Aug 2024 05:58:29 -0400
From: karthik nayak <karthik.188@gmail.com>
In-Reply-To: <86e2f9f5dc64eee97510e597820791287032ba29.1723528765.git.ps@pks.im>
References: <cover.1723528765.git.ps@pks.im> <86e2f9f5dc64eee97510e597820791287032ba29.1723528765.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Tue, 13 Aug 2024 05:58:29 -0400
Message-ID: <CAOLa=ZSe75TW88omzYXc1t2iUxLDiY4haBGigA7VP2=ARsDObA@mail.gmail.com>
Subject: Re: [PATCH 03/10] reftable/merged: stop using generic tables in the
 merged table
To: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Content-Type: multipart/mixed; boundary="000000000000ce78bc061f8da666"

--000000000000ce78bc061f8da666
Content-Type: text/plain; charset="UTF-8"

Patrick Steinhardt <ps@pks.im> writes:

[snip]

> diff --git a/reftable/stack.c b/reftable/stack.c
> index 64c7fdf8c4..7f4e267ea9 100644
> --- a/reftable/stack.c
> +++ b/reftable/stack.c
> @@ -225,13 +225,11 @@ static int reftable_stack_reload_once(struct reftable_stack *st,
>  				      const char **names,
>  				      int reuse_open)
>  {
> -	size_t cur_len = !st->merged ? 0 : st->merged->stack_len;
> +	size_t cur_len = !st->merged ? 0 : st->merged->readers_len;
>  	struct reftable_reader **cur = stack_copy_readers(st, cur_len);
>  	size_t names_len = names_length(names);
>  	struct reftable_reader **new_readers =
>  		reftable_calloc(names_len, sizeof(*new_readers));
> -	struct reftable_table *new_tables =
> -		reftable_calloc(names_len, sizeof(*new_tables));
>

Before we had both `reftable_reader` and `reftable_table` here and we
used to set `reftable_table` from the reader and use it to create a
merged table. Now we will simply use the readers directly.

>  	size_t new_readers_len = 0;
>  	struct reftable_merged_table *new_merged = NULL;
>  	struct strbuf table_path = STRBUF_INIT;
> @@ -267,17 +265,15 @@ static int reftable_stack_reload_once(struct reftable_stack *st,
>  		}
>
>  		new_readers[new_readers_len] = rd;
> -		reftable_table_from_reader(&new_tables[new_readers_len], rd);

This being the part where we convert `reftable_reader` array to
`reftable_table` array.

>  		new_readers_len++;
>  	}
>
>  	/* success! */
> -	err = reftable_merged_table_new(&new_merged, new_tables,
> +	err = reftable_merged_table_new(&new_merged, new_readers,
>  					new_readers_len, st->opts.hash_id);
>

And this being the part where we create the merged table.

>  	if (err < 0)
>  		goto done;
>
> -	new_tables = NULL;
>  	st->readers_len = new_readers_len;
>  	if (st->merged)
>  		reftable_merged_table_free(st->merged);
> @@ -309,7 +305,6 @@ static int reftable_stack_reload_once(struct reftable_stack *st,

[snip]

The entire patch is along the lines of what I explained above, so looks
good!

--000000000000ce78bc061f8da666
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: 31a820a4a6aa7227_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ0FBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1hN0xrTVdIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mL0pTQy85SDJLbkMvZjhSWXc4bHFqb2JWdktxL2xDZApJUXc1SzVVVDBQ
NWMwNkFOMStTQURFem03ejlvTmxyYUZFTnRwaG1YVGs1NUxDTm9senJ4b3hhV0F5VWtKMG81CkFJ
dHloeWIyK1pRNXQydmZJRENUazNCZk1TLy85d1JkWjBtUnNJMzlseU9IaGg5QllkUnh2b01QU2o5
NVYwckoKQXc4c1ViRENMeXFBWXV5ZlVUM2szVlBLR2ltVWFBZXlKRk1oSmVia0NFUDN2OWJaMmtq
VFNLb3F2YlZQVnBMdwo4M2hGMSt0MHlWNUVXUGhITWRoc2JFSHluYjZiVEhNVXlwL3dwQXlOazc5
d2ZPTndTd21qVjNITDYwZWFHZEQrCnE4VUxPTHpQMG5aR3gvWVhiakpmTHUvcTkrMFppTkxHS0pk
VkhSbjlNbmF6d0NyVVNCa25uTzd6Q0RCd0ZnTGEKUlV4SVRUckxFdnpuczR0Q2NpaGVyenJJVW1t
b1U2Vmo1bmlWMW5xSEFlR01xMmJUYmV6cmFGUWROR3VkVUdydgp4SS9kcFMyLzVoZzY3Y0pmeitC
TExZOVR2ZzVoamxidlMvNjBieC9iMXhxOExQbHNLb2NvWlhjWUcvMm9IbFVFCkV1bmI5dW9IM1gz
VkJidDFXaC9La2pxbmdLdzljT3RkYnNJWFJjQT0KPVVnVGMKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--000000000000ce78bc061f8da666--
