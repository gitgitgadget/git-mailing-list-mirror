Received: from mail-oa1-f43.google.com (mail-oa1-f43.google.com [209.85.160.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD570157491
	for <git@vger.kernel.org>; Wed, 24 Jul 2024 11:42:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721821353; cv=none; b=PPmmXPq2joPXFVX/ZcLk5+aMOikrE9emFra2zUfq5AdXbJKQRKAl+bLuz+zr2o8yENXJrzLnmYqnCVrVBRWaCblU02GAAzAA4szRoMy5KffCkZ5vtuMVnyJpAp7n6jDbdIlxtguDB/NazUOVyy4uhnpNZKGJU+0K+7pBe5I1EPM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721821353; c=relaxed/simple;
	bh=sDb+4YnGiRat5S8DW8SRTe4myykwv2BfwtaIsJX0dy0=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Content-Type; b=gDjSHiErY7Z4w6KW8AzJdBaS5izhJ7A3pGL+zG/cqF/G8jK1kSUG/1dfLhhp5llwBZa6HCtN6Vg4QiFVjQ7ehovbbzcToxwlwDtn80hYrIZapKnEqx0JCcrAFoB6Kaor2wIHkyzYmiPeH+qJwO1J3/iNezFMi07PyqhU2gFbO2I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QNLroJCM; arc=none smtp.client-ip=209.85.160.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QNLroJCM"
Received: by mail-oa1-f43.google.com with SMTP id 586e51a60fabf-260dde65a68so3610526fac.2
        for <git@vger.kernel.org>; Wed, 24 Jul 2024 04:42:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721821350; x=1722426150; darn=vger.kernel.org;
        h=to:subject:message-id:date:mime-version:references:in-reply-to:from
         :from:to:cc:subject:date:message-id:reply-to;
        bh=lx9nHHRR6/uMgBgMJTfklpK37ikc2uxONRKJ/XMZXh8=;
        b=QNLroJCMRGZ/3bJKPNv8XTKPDg90b7QVPYmOpWKn5L1Q6j55JXkECUMaemHl0gc67i
         36qimTvFmIcnlHGIir3BbVspLdjRJLFbzyq95PA+MCc7+cvJ2hQZ1W8EolxTgojL89y+
         v3UpBN9aaPEKA0bSGv1vOOatvqScssApVlq9NKR2pXGmEjJdwn67EtqxA+rca7KV3xBt
         pGwyKaHvaAzlPooWbUPtAy+0xSOtgu3lOQWF6JdJAWshWfNh4VMToThes/7ZEkmLvoEW
         3FaVMh5W+Hy8YNozLSCo38RVBQCdaLq4lVazroo8RHh+Ih3irOGfTX4VmgZ4JUD0GONy
         qmuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721821350; x=1722426150;
        h=to:subject:message-id:date:mime-version:references:in-reply-to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lx9nHHRR6/uMgBgMJTfklpK37ikc2uxONRKJ/XMZXh8=;
        b=MBuz1mcWLJIFshwfu8VblsldPNG0SRx0jtYu9xcTjdLz9QcT/ob9DcLcmKGW9HBcBz
         NVO1xw2t9JQQfy2fpQ0tiZLwyOPboSpnGp0338jQhdyKTmgd8hUhwhmW4SCBENCm25HB
         3YcLhTcYuxulELyKgDQYqZf21XqVWmLAoqD6RAoQr0jxTv0VGH2jA023lkV02Ihx9DfX
         tPhwEGSEgEw9wP+Bs3J9/1aeqj7La0Z/Y+bBvajvjtGs2mT8WXuDv06DyxCZhJsFtyaB
         dOrCGSgprTLMq0efyRr8ReRH03KextGvGJ7c4zFn+sVC6ZJOqn6g8DKEEJfAw9bHKUPr
         1nrQ==
X-Forwarded-Encrypted: i=1; AJvYcCX/VuHueZK1pLTC7LDcvoo9N8AzCY7T8EyhgpaqRwMhrZCRPhI8mESFtHOXvZ3/S8YmaVqwG3Z+vPJdwf5+nKS6DPUR
X-Gm-Message-State: AOJu0YwC1XpKy3/mgv+Oe5G2jxwpFa6b5mCV3ggocSl27vyHSqVaHue5
	+dQunyHvmNcFSj2GXtOVZ3IhJge2gwdAu/x4uQdx5O7gRI1+k4hiJfXMKUr2Y1+nhnbM83/22z6
	H8GWy1Cmqz/RjqyhJKU31W52mnt0=
X-Google-Smtp-Source: AGHT+IHCPwnX5B2MQU/eTsG8GtEkYexVH4s1Zadb0yMs+1tIcjLQjq2IlpcFb+Z9jRMgX6fWDM51WqEAGeAHzDm2Le4=
X-Received: by 2002:a05:6870:891f:b0:25d:efdb:ae23 with SMTP id
 586e51a60fabf-2648cabf203mr1596061fac.27.1721821350544; Wed, 24 Jul 2024
 04:42:30 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 24 Jul 2024 04:42:29 -0700
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <7f07bf1f3beee2f74a3572d2b9a8d28b6535053e.1721818488.git.ps@pks.im>
References: <cover.1721818488.git.ps@pks.im> <7f07bf1f3beee2f74a3572d2b9a8d28b6535053e.1721818488.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Wed, 24 Jul 2024 04:42:29 -0700
Message-ID: <CAOLa=ZQn1uYSd0089+jOguVBSnKfZjak4766V3B8mXn2hBgAkg@mail.gmail.com>
Subject: Re: [PATCH 2/3] Documentation: document naming schema for
 struct-related functions
To: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Content-Type: multipart/mixed; boundary="000000000000f7655f061dfcc523"

--000000000000f7655f061dfcc523
Content-Type: text/plain; charset="UTF-8"

Patrick Steinhardt <ps@pks.im> writes:

> We nowadays have a proper mishmash of struct-related functions that are
> called `<verb>_<struct>` (e.g. `clear_prio_queue()`) versus functions
> that are called `<struct>_<verb>` (e.g. `strbuf_clear()`). While the
> former style may be easier to tie into a spoken conversation, most of
> our communication happens in text anyway. Furthermore, prefixing
> functions with the name of the structure they operate on makes it way
> easier to group them together, see which functions are related, and will
> also help folks who are using code completion.
>
> Let's thus settle on one style, namely the one where functions start
> with the name of the structure they operate on.
>
> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---
>  Documentation/CodingGuidelines | 19 +++++++++++++++++++
>  1 file changed, 19 insertions(+)
>
> diff --git a/Documentation/CodingGuidelines b/Documentation/CodingGuidelines
> index 1d09384f28..34fcbcb5a4 100644
> --- a/Documentation/CodingGuidelines
> +++ b/Documentation/CodingGuidelines
> @@ -541,6 +541,25 @@ For C programs:
>     use your own debugger and arguments. Example: `GIT_DEBUGGER="ddd --gdb"
>     ./bin-wrappers/git log` (See `wrap-for-bin.sh`.)
>
> + - Functions that operate on a specific structure and which are used by
> +   other subsystems shall be named after the structure. The function
> +   name should start with the name of the structure followed by a verb.
> +   E.g.
> +

Nit: It would be nice to add `<struct>_<verb>` here, since we do something
similar in the next patch.

> +	struct strbuf;
> +
> +	void strbuf_add(struct strbuf *buf, ...);
> +
> +	void strbuf_reset(struct strbuf *buf);
> +
> +    is preferred over:
> +
> +	struct strbuf;
> +
> +	void add_string(struct strbuf *buf, ...);
> +

I first thought this was a typo and should've been `add_strbuf` instead,
but I'm sure your intention was to show _other forms_ instead of
`<struct>_<verb>` here.

Maybe we could do s/is preferred over/is preferred over other forms,
like/. I dunno. It is probably fine as is :)

> +	void reset_strbuf(struct strbuf *buf);
> +
>  For Perl programs:
>
>   - Most of the C guidelines above apply.
> --
> 2.46.0.rc1.dirty

--000000000000f7655f061dfcc523
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: 789282ea5448546b_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1hZzZLSVdIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1meEFIQy85UWM5UXlBMisxR3RJbURjZE1tYXU4aHhQTQorYmhnQk9ocUgx
WElJOVBhQnFaekFMRjJ6aEdYZ1A2ek5zQVRjT0Z2czJaL0YzejF0ZzFEY3JxZEdibFpMRlgrCkIw
bXF5T0dWMklzeWVRUlRNZ3dvRUVRWmdmNGY0U2lOR0xzMFYweVZrUExmUGJySWUwOUFRQzd6VC9l
QVNRdXAKeExnb2JhU1kyOGR2SzJob2pxSHd3Snhhb0NWYzMrODAwNWtuNSs2b0VEemtLRVV4S0RM
NkhVNUVkelpIc25xagpkSUdPeG92N3JtTHJOZXpXeW8zUldQZk9IaDU4QkN2QXJGdFRtUVUxcmJq
TVhLc2lGRmpiRXI4TU1KNXN5V0xwCjc0RXowdFlDWHJaR3lsWHJxVU9YNzJJUG0zU2ZCSERDK2hY
Snp0V2daaWZ2WmZMVE51WExocW9Zd0lYZ0E5ZU8KeGpUaHhOU3dnUEp4dW96MFpEMGlCOFRmazdD
NWl2c2Y0dWFxYTgyeituTW5ua1VEam9kOTNrbzVxaFRoU0lQVwpWWG1YcDB4SXpDSkhrSGxtcHBw
OENMQ0tGZHdMMmdOVkJMRWVFVHZtN2dvU3JjWnB6Rmd3ZUxMcVg4eVFGSHc4ClNPR2JWRUdEL3RC
SkN1S2N2UUFzVldacGFzaGFiMnJ2WlB2UVRFbz0KPTNXczIKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--000000000000f7655f061dfcc523--
