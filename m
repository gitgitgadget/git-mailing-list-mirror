Received: from mail-ua1-f50.google.com (mail-ua1-f50.google.com [209.85.222.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE9562765FF
	for <git@vger.kernel.org>; Mon, 12 Jan 2026 09:56:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768211767; cv=none; b=ThU95X0diNxhNYtZjgtBNxeOj74qlda0Ne8ainI9Iw3AxxEOeG+zEMnWr3In1wCXg/fIfJ9btjS908/jdt0awOUvPuajE19boDBYDreRwY6KwUrI1raQODb50o6cmjJ1SpP8tA3XLNZZuXFDhy9Yq4IZfEwTzDDSSQtwO4yANFk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768211767; c=relaxed/simple;
	bh=P3tIQHBLJLjJBUvgnI5wAujg7Ded9SJKEQZ3VZjtJx0=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JBvpF1EztnRhoze2AIQoCaYmIiGbRv2YFBrdYkdwGigTsZHVYb6sYgRkGD98T25jvxDG+yQ4bKdTJLyuexNksWRXigQay+s+AhonLuRtNmQZ/LMzq04ixgPO0h/ePjxyPn4BBm9ve9czJBzbO6ctH4TAywVA5ZUrebgTSLGuqtM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=N6GV00A7; arc=none smtp.client-ip=209.85.222.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N6GV00A7"
Received: by mail-ua1-f50.google.com with SMTP id a1e0cc1a2514c-93f6bd3a8f4so1887536241.3
        for <git@vger.kernel.org>; Mon, 12 Jan 2026 01:56:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768211764; x=1768816564; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=17V3+fUK5uVQT2ofbB2PDX6bp4qxR+6u9shykyrtfdQ=;
        b=N6GV00A7fn2h5mRO/ykQW6oJ6TpV1hqGHOV9wkObpYym4xZ4PwD309TVQHumsL9ort
         KHdG0MdAngeJPEn+XUPwr5K0VXs8I1WfEjtL9nqfQNifsQizJOH+kT37tE6hSuUha8Wr
         W6f4Vhw8tIl9QYMhQimdjzlURyOMp6vjMc9QHQl8Vr6izaWtKZ7KRzppGRrA3ghHh7YE
         1EQG6yD1HNTBmwn2d+F4i23+Q412s3+dpXlj29h9jpiOYeKUZNDFSe0ByteXHPhUpyHk
         E74AtMZSbsF5uDzoDKPTCBUBKyTe2yr4VEr+CQJKaIGTK/NXDysEz4jjB8USG29sMQjs
         fC1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768211764; x=1768816564;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=17V3+fUK5uVQT2ofbB2PDX6bp4qxR+6u9shykyrtfdQ=;
        b=Hlfyrhy0nqDkotE+aQnWh3IDDDAVfZCWzh4RRF1dHudI3gzr5xVfZObx5J3kaCI6jh
         G8DP3AnJ1QqF7xW8zZY3wmqxdqYv1+r8u+JRmLqrEpZNUIKpYh9zlaJ80QbxI5jHcma/
         IXc8yUeu4zrgrxKFN9Vqn4Yloq+/ANMsGDZDHN4uF6mAyXs++bfrbzNPZuUYtE3l7bCO
         EurlQRFVrMa/hgl2MEp40OH3KqjjtMrSONKxkQbt+mlzEP89Q4TNvr0HzdLj/lQyD1FY
         PjnwvoKuehkBtLKpW2wFoezxewz0AtRSfeCVjZwEvwRiNiVRiQsv5bejZokcnpMupBBh
         k2JQ==
X-Forwarded-Encrypted: i=1; AJvYcCVKxtSvmc6Whl1c4NQNUC309T3dSda8l2LUf0xJ4PI/WtLbMspeFXxfiCy+I7tMMO8uBn8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxNGNxMOWm0GNhJuSx1Ew6LEB2PKE75A1lU9BGU1V0JoK5CkLg2
	92eFtEJRtrRKDG479VbDtHjMnDAkx3FLdQ61CmqkMxZLWIy3Q/+HlnfaQNIRu2AXzNkwx4UHUxR
	qeqfEP2AfDvWzsvxxoQBYPm8FcCCiVhs=
X-Gm-Gg: AY/fxX69HlSeS9zzq6UVArkh4+KrGpE/OntVvr6r6wij0tztb3te0E6/sTCrKxEa7qc
	13+txkR4VNAHiFRXdIdBcg0tdbaVPGAfWqh0dsPTYzlcxZLpJ/c661/cXhcI4UY3Ebm1RQAJaNg
	GROCEQoOW81HZUZZlqjBbELPwpuWgYJ/WDxGlmVxjiykX6uBjUrVwGEuS4ciGVFpv3ZA3LZBM11
	uc4/vjwpCVi5pxBofwbWYGSFR10mIL0ZMrSMCvXX0T2gExEGYL7upYPI+Ii4w1Q7ui3WbqxpOlK
	wQF7V/EES9Ppo/5EpK3iR7OjspzX22NocsgphnB1
X-Google-Smtp-Source: AGHT+IE222nSvqUBmMrMtmOol7Q9iIBI9cd1P1PFrqUDgI999en787MiTknP2+Dpy886uCCtNkwDd/qh4qjq7/CGoEQ=
X-Received: by 2002:a05:6102:4a83:b0:5ee:a81a:dea4 with SMTP id
 ada2fe7eead31-5eea81ae785mr4398019137.27.1768211764595; Mon, 12 Jan 2026
 01:56:04 -0800 (PST)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 12 Jan 2026 04:56:03 -0500
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 12 Jan 2026 04:56:03 -0500
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <20260112-pks-refs-verify-fixes-v2-1-2e9e453bd6c3@pks.im>
References: <20260112-pks-refs-verify-fixes-v2-0-2e9e453bd6c3@pks.im> <20260112-pks-refs-verify-fixes-v2-1-2e9e453bd6c3@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Mon, 12 Jan 2026 04:56:03 -0500
X-Gm-Features: AZwV_QhzgXtyCVc8slpTCzfU8cEfHN6B4iZ1Ac9FmSOy-3OITGoxZFUAK5AaFao
Message-ID: <CAOLa=ZSu3MGejqN9n4NaytANNbU4bY1GEAK84-W0B94jcCddpA@mail.gmail.com>
Subject: Re: [PATCH v2 01/17] refs/files: simplify iterating through root refs
To: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Cc: shejialuo <shejialuo@gmail.com>
Content-Type: multipart/mixed; boundary="0000000000001df08906482de2b5"

--0000000000001df08906482de2b5
Content-Type: text/plain; charset="UTF-8"

Patrick Steinhardt <ps@pks.im> writes:

> When iterating through root refs we first need to determine the
> directory in which the refs live. This is done by retrieving the root of
> the loose refs via `refs->loose->root->name`, and putting it through
> `files_ref_path()` to derive the final path.
>
> This is somewhat redundant though: the root name of the loose files
> cache is always going to be the empty string. As such, we always end up
> passing that empty string to `files_ref_path()` as the ref hierarchy we
> want to start. And this actually makes sense: `files_ref_path()` already
> computes the location of the root directory, so of course we need to
> pass the empty string for the ref hierarchy itself. So going via the
> loose ref cache to figure out that the root of a ref hierarchy is empty
> is only causing confusion.
>
> But next to the added confusion, it can also lead to a segfault. The
> loose ref cache is populated lazily, so it may not always be set. It
> seems to be sheer luck that this is a condition we do not currently hit.
> The right thing to do would be to call `get_loose_ref_cache()`, which
> knows to populate the cache if required.
>
> Simplify the code and fix the potential segfault by simply removing the
> indirection via the loose ref cache completely.
>
> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---
>  refs/files-backend.c | 11 +++--------
>  1 file changed, 3 insertions(+), 8 deletions(-)
>
> diff --git a/refs/files-backend.c b/refs/files-backend.c
> index 6f6f76a8d8..297739f203 100644
> --- a/refs/files-backend.c
> +++ b/refs/files-backend.c
> @@ -354,13 +354,11 @@ static int for_each_root_ref(struct files_ref_store *refs,
>  			     void *cb_data)
>  {
>  	struct strbuf path = STRBUF_INIT, refname = STRBUF_INIT;
> -	const char *dirname = refs->loose->root->name;
>  	struct dirent *de;
> -	size_t dirnamelen;
>  	int ret;
>  	DIR *d;
>
> -	files_ref_path(refs, &path, dirname);
> +	files_ref_path(refs, &path, "");
>

Since refs->loose->root->name is always `""`, we directly pass that
instead. Makes sense.

>  	d = opendir(path.buf);
>  	if (!d) {
> @@ -368,9 +366,6 @@ static int for_each_root_ref(struct files_ref_store *refs,
>  		return -1;
>  	}
>
> -	strbuf_addstr(&refname, dirname);
> -	dirnamelen = refname.len;
> -

This too is unnecessary since the len here is 0.

>  	while ((de = readdir(d)) != NULL) {
>  		unsigned char dtype;
>
> @@ -378,6 +373,8 @@ static int for_each_root_ref(struct files_ref_store *refs,
>  			continue;
>  		if (ends_with(de->d_name, ".lock"))
>  			continue;
> +
> +		strbuf_reset(&refname);
>  		strbuf_addstr(&refname, de->d_name);
>
>  		dtype = get_dtype(de, &path, 1);
> @@ -386,8 +383,6 @@ static int for_each_root_ref(struct files_ref_store *refs,
>  			if (ret)
>  				goto done;
>  		}
> -
> -		strbuf_setlen(&refname, dirnamelen);

Earlier we were setting the length to 0, but thats the same as
strbuf_reset(), so we do that now. This gets rid of the `dirnamelen`
varible. Looks good.

>  	}
>
>  	ret = 0;
>
> --
> 2.52.0.590.g1f87b77810.dirty

--0000000000001df08906482de2b5
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: 5c6df7f5692289d9_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1sa3hUSVdIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mMTRKREFDUXVsc2JZWFF6SEVIWnVFSzJlNDU5RzVWUQphbjlheGtTZFh4
TVRLK3A2RHE0alBWNVJiRXc4WFRlWW1WU21sTzFJZXBjOUgxMGo2cGRBWWl3ZVFFZ1ZWSTk0Cjgv
ckx0eWtCN1BuUGpENC81N2hjREVqNDNSekVmcjZrMGJrNkE2QjNCYi96T0FGUHFKc0oxMFdpM0My
QTRaQ08KeEZZcXlMcm0wTXV6RUhPNmRZUnNOUkpkdTFWeUVWVXl4alFVdUhsNHVOTzFKN0xGYTBK
dTRiZDVkTGczbFNtMQp5V29Wd3dYQk5tQnZBQjJRc01NL3pNOWE4a3k5eTB1V3hSUW10bmlBZU5z
Q2NhT0dFQzl0SUJYb052VmpWcUxLClpnUXRURjlvamFodEtPRjdnelE4Z1BmR0dHSTNjdGxrTE1B
MTJRZis4RUsxNitFUk9aZ3BsbnJpSm5CN00zaTgKVTBodTlXTHlwbHA5ZlN6VkJjUm40bzdHNmR1
NkM2NHc5MldHMlBWd2FvV0dIMmhNSXJlbWdxTVFuUFRndzhEMQpIU0FVT2lObWo3bGRWd09CaW5L
UWdxRUpXbkRJb09obld3NmYwd3NUVmNzNnZ0NXBiQXFwNXNJcmU3anhWKzhuCnIxMUs0Y1VqVE96
R3hhVGJlaThzUDhtMlMySldaejBkck5jZ2J4RT0KPXM2b2EKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--0000000000001df08906482de2b5--
