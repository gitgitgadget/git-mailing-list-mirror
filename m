Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 753F117DFE3
	for <git@vger.kernel.org>; Tue, 15 Oct 2024 07:41:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728978089; cv=none; b=gr0ssiUYEylHBBrQ8q4vF1tQJxDYYzjBY/KsMvoFBhHHYd0/yy/b3prq1ubFmv8111XXA+lUSJ3lzQ5aaJiZz0XEopOZEWsqysCR0Sn4TUMFZCV1GSwoDKUwZNVFZX9abPHn4QQUOk0bYlOCJtKIXmONO/IYzhZdhk1RKARYWkw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728978089; c=relaxed/simple;
	bh=6ug8p6N5OPAfxgxJ7sMvtNZ8ppt7JoZkTkPlKHcz9YU=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RBz/Z4f3cBl/NsusHRT4tD4DxHrabSljBy182FZeq/aKvXGXLLUHDVxQJZTyAyjgpVXzxcjJ4ORkhYa+II2QbVSpr8G0rL3bJWhC+56uahbdov3UNI5miyjERArQGbCDFuGZFIBr0VqXzov/kMbHj7NlvLpSD9bUr9vgJO0ACXE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LwDFcbl4; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LwDFcbl4"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-20cbca51687so24769475ad.1
        for <git@vger.kernel.org>; Tue, 15 Oct 2024 00:41:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728978086; x=1729582886; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=Z04QhZ4CRRV7/cNO95TIwkzGf9NP4J5SBwKE3Fa9mKo=;
        b=LwDFcbl4WHtICUYCFFOfgURrcKk+43Qz+jsImZSl3F2Y0CMIfx+gokwkGkWp8Hev+X
         6h4um2PugQXR4hcmvEYi2bfMnCSSGnh9pPM1X3zrVPKEXIVoD/C+Wb3RBWE2vh+vgY+I
         AvwhQAj8x/EIFM8Dj5Fl7n1tQn86XV+Fol0atsrpxF6E1Qe0TLeYPHP4waVe7nDTVcFl
         WQs26Ypi0GXGKAfE6be3EUY8+o73iZ5olExbrEv7Uc0SGu5Pj5/oVzvtloDz0Lyt5D3r
         fb2Td2q17zOnHa5UmIOSUK4tW2aSeFh+LRwbrrLYLusmQF2tHrEfJ9+mNLWozmEOLnoP
         3Ojw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728978086; x=1729582886;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Z04QhZ4CRRV7/cNO95TIwkzGf9NP4J5SBwKE3Fa9mKo=;
        b=KHSN4NC5i/Lem3mQN2Up9Ldt8QElVuKU8IiPgMnw5OhJqVRXpAWdQq1A6xVBNU0E6N
         NAlnbpubYpA6L/9k5IS9u41njAUxbYK/JmvGsXjOEHXua5RgUR3WPR6QfdqR/1Rl+9SO
         4sR3WFEqXGKJLbI28Bduy0L6Ax1EC2Bfz+9Rw2dWxzJ8UqJQKJT/yL+s5+Wc7Y7LvCRt
         stMd80McAxhPLOrnUgz9FKeS8vj6Ca/8oeGMxzXSB2yAIIIeAUjtZscNbGX+MvrXL6IX
         lsH81AwdvJc/6L0gBp1lmiNeDb8HrxQ6W7yLNcxwT99dACLqsOSsH8HuuGDIy/W/qT/Z
         67bQ==
X-Forwarded-Encrypted: i=1; AJvYcCWQNCYoqFgkVo74eG7BP6NE1gBD02ZY2mhdai8WLBPtmfL//YuKw/XBoTpC/qIn4vM7nNw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy/Y0hUZrQ033Kx3Q+tyxE/lhh2YZz7QJr5fGcr2NiQ/8Yczsg8
	TtmxpSu3qefKILs9y9+lQDqWkL7pXkhdqlGwmnnwNwrkD5jYSyODf7dg3J+hRLJPfCLLq9MDPNf
	r0I4BMXgp1dLmwatWJeqGACY2mZY=
X-Google-Smtp-Source: AGHT+IGP5inkwqHdnDngcbqVWOpUqrdBXYrRGPl5ha2ukCi/fbxtRSB4XXUUExgZ9MZInSG09Q/UFwxC3BYjejW/w1k=
X-Received: by 2002:a17:90a:600f:b0:2e2:e159:8f7b with SMTP id
 98e67ed59e1d1-2e3151b787bmr13295354a91.3.1728978086521; Tue, 15 Oct 2024
 00:41:26 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 15 Oct 2024 03:41:24 -0400
From: karthik nayak <karthik.188@gmail.com>
In-Reply-To: <20241014225431.1394565-2-bence@ferdinandy.com>
References: <20241012230428.3259229-1-bence@ferdinandy.com>
 <20241014225431.1394565-1-bence@ferdinandy.com> <20241014225431.1394565-2-bence@ferdinandy.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Tue, 15 Oct 2024 03:41:23 -0400
Message-ID: <CAOLa=ZTMzz-9XE8AY8vk7Gpbm+U0T-5jWNJzKLyd621_URiDEA@mail.gmail.com>
Subject: Re: [PATCH v8 1/6] refs: atomically record overwritten ref in update_symref
To: Bence Ferdinandy <bence@ferdinandy.com>, git@vger.kernel.org
Cc: phillip.wood@dunelm.org.uk, Taylor Blau <me@ttaylorr.com>, 
	=?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>, 
	Johannes Schindelin <Johannes.Schindelin@gmx.de>, Junio C Hamano <gitster@pobox.com>
Content-Type: multipart/mixed; boundary="000000000000ac0c1a06247f142a"

--000000000000ac0c1a06247f142a
Content-Type: text/plain; charset="UTF-8"

Bence Ferdinandy <bence@ferdinandy.com> writes:

[snip]

> diff --git a/refs.c b/refs.c
> index 5f729ed412..b964ac44d0 100644
> --- a/refs.c
> +++ b/refs.c
> @@ -2114,7 +2114,8 @@ int peel_iterated_oid(struct repository *r, const struct object_id *base, struct
>  }
>
>  int refs_update_symref(struct ref_store *refs, const char *ref,
> -		       const char *target, const char *logmsg)
> +		       const char *target, const char *logmsg,
> +		       struct strbuf *referent)
>  {
>  	struct ref_transaction *transaction;
>  	struct strbuf err = STRBUF_INIT;
> @@ -2122,17 +2123,23 @@ int refs_update_symref(struct ref_store *refs, const char *ref,
>
>  	transaction = ref_store_transaction_begin(refs, &err);
>  	if (!transaction ||
> -	    ref_transaction_update(transaction, ref, NULL, NULL,
> +		ref_transaction_update(transaction, ref, NULL, NULL,
>  				   target, NULL, REF_NO_DEREF,
>  				   logmsg, &err) ||
> -	    ref_transaction_commit(transaction, &err)) {
> +		ref_transaction_prepare(transaction, &err)) {
>  		ret = error("%s", err.buf);
> +		goto cleanup;
>  	}
> +	if (referent)
> +		refs_read_symbolic_ref(refs, ref, referent);

Shouldn't we also check the return value here?

> +
> +	if (ref_transaction_commit(transaction, &err))
> +		ret = error("%s", err.buf);
>
> +cleanup:
>  	strbuf_release(&err);
>  	if (transaction)
>  		ref_transaction_free(transaction);
> -
>

Why remove this whiteline?

>  	return ret;
>  }
>

[snip]

--000000000000ac0c1a06247f142a
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: 78c5cb61ee84e8d4_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ0FBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1jT0hKNFdIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1meU1qQy80NVlYTnd3VG0rekZabmNsY05MNU5BckZPNApsQWxyaW9aMVph
VnlKY1ZDeXZjeHNVQ3dTd0JIbVhCaGw5WktveXVoWEpNeldrQkE0aENaYWhUZXAyNXZLTUFtCnpk
YzdvRWZHb09IUEN0R2tmcnpwcUJvSlpId1c5SjN5VXBUOWE2UlFOZk9uMmJCWlpPbkRhektSQ1dk
QXpodSsKUEdQTmdkQ0VyWkIyVTIrNjMzbWw3VVVwZG4rL2w3dnZldTF3NlgwbHJJamJtOGVsbVp5
N3NXYlA1dGJKc2xWZApQclM1YmVvMjkrVzMzWGFkLzFjRWY5TUE4N0kxeWdKQndiZHFWcUVRMkY2
Kzl4OFkySU9QUmg4Y1lveTVicy9kCjFUbHlhSmR4Y2NxRmxCem9mN3RDS3F1a3dydjVxaU1mRUJC
Y3h6NTkxWUJFZVMxU0tUekRWVFFQeEhka1hCZmgKZWE5UmZmdnJHaUp0Q3V1YXpQOUZyMUFuRkIz
YzJLVVltTElwd2tSVnd1Ry9XdjVYaXQyaC81OG96aEhNWHVQaQp1WTAweGpJQ1EwdmorVEhuM1ph
S010azdzSmtnaU9rYzdLcVJrUXB5RCswbzIyc01FT1dHKzZpSjJSVnZDdEh4CldLUjB4enMvRklU
STFvRWUzSC9KZXpnRURPbGtrUjlXejRKVy9jUT0KPWRZUUkKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--000000000000ac0c1a06247f142a--
