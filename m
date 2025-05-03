Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58E5C125B2
	for <git@vger.kernel.org>; Sat,  3 May 2025 14:58:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746284321; cv=none; b=tqUN4tsWUiKySyVFnxTcO38a+tO+xzKcdpOJfe+OMcjaTwUzHv6Ijx9IAvWRdGRlYShhBQ6ardrDMGQhSMGpQoOPaGS5U5QFtC3bqE9z42OqJa/+0NZVjbhnZ0EaxVJtOL9aZ9R2bjFBkIYOstM1mNHdu8f5leD9ZEb9dbK+xsQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746284321; c=relaxed/simple;
	bh=0jTMVBo68/CfJHKAzVW0Ul3od+5eCIkcUjvwSSY40c0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gQQtoggebEbXYdanGNj51PrCtro/q5gA+76SYiAYgJBX+X4Vv9tz6KQizHdTlnR5rGIZ3j1C3lEh7sHmdcDEnbD+7XOWq9QYp4JoMJX/+YK6D63U63Sovwc6JkOw9SE4/lO4WDblr1mHwzfNVRhHwSiabYdUAaAztAo9MuF9U4g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gXmFRje7; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gXmFRje7"
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2295d78b433so30923385ad.2
        for <git@vger.kernel.org>; Sat, 03 May 2025 07:58:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746284318; x=1746889118; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=H5T73E/OiJ8aoq8zDkhH/B2zUZ0ftygpiF9mm02mKeg=;
        b=gXmFRje72MW+6vb51cXJxLFIIReNOySS0p036XnRedaeL+oXi8e1alUQnadRl5l5Yw
         WOc5LYXKJ75vO3B/1m/jhjZfQRPBfykE2NZAvye7XlIVSyFK77SbelRxp8c6/8SxFqCa
         fQSfdPgigFsXsdNL+b6K3xp5ijN0jlE5FMDgnYMj1Had7MXPYv/Lj9JHh+81TRmCOHDj
         Or+yBoKK5Uk/lVokUqjAUU/evj/krqHnswS/751WuUBsnAjqlmz3WxVXHTDKn+H575tO
         A4E8qABAoD16VuO52mF/GARS4RF0oUewAJd6oyThCWGxCdwhArFRYRK3Er+DnSImbUfZ
         C9Pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746284318; x=1746889118;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=H5T73E/OiJ8aoq8zDkhH/B2zUZ0ftygpiF9mm02mKeg=;
        b=UvIJgXAQo/ngelzJFH5kDLx05kQeg6QIDAG3OkcrZYWCQ3h7pwoeSLavcX7TkHa8A4
         GSkAch79z+T63m1+5bPAZiMHHVICxr0DUi2/Vfcu90QTxAr7erNBHt0DnbhUwlhtDprx
         ISgcbNw1Z22IiaxtyYTDNJz5WRF3AzoLT7ogV01gtpv/Vbaw0OTw1DltVoqtrQDPc/hI
         UbEoH5Hj2rtcq+iIhPFHeLqlNEqltjjhiGIG5OIqI8YQbwbaGd67xrUi6zXGf8woqva/
         6nmloDraWhiyKbnJg4R9PINQ2lPvg7DQVgJIqEnPx0DRcNDtHdyCcQ9G7oeQ/Hu6yYA6
         kECQ==
X-Forwarded-Encrypted: i=1; AJvYcCWxJowV/4Jok3oCMjVORt/H1DIR3NMK+FP4J1IfNinUZEVdUm7/gHc5bZSYnvuXDowzNKI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwUnflkiImfMWIPIrIQxxB1IH1OFhh03EimKcB+Lso6RrZUV7XV
	0MgbADy887byx6yrFyao17Sq1NNnVYINSefUl9mnpCmLzYpcqSG+YbozBzQT
X-Gm-Gg: ASbGnctPuHjOjMZhtTjRpodikYmF/H/jWlhui7AJcCiP6pHprcobBnaGWgqOXFfeTY0
	eh/WHUiCrMZpFyeCmOgRaKb7IVaBcV8dHw8q9w/CTfnpHvycTU1OTjaCU1vKGslMWdNVmbrDYAs
	EcgEPxlTQlux9rxlRi8YDWUcuU6EZcjhJ0KhbjUInbcAO1Dxe+8UZxCreNgJZ6Uy8HmNmh9Fsfl
	81dIHpyAyerAZpvh2ZJKSLHl8zp24pWnEdDWGP26ZsKJ3Xo/ykVLRSgIEZg9h+UMw0uFRcLN6nb
	bUA2OKBPwaZcXG4AJNQ470sJwhSuxascEXOU
X-Google-Smtp-Source: AGHT+IGwOtfqANv6L/jsCPWd3bx2VdDz6ytFOdEj7UY8jkSUZWS3na67NLwT/QLBVP1b0Op2vmv2vA==
X-Received: by 2002:a17:902:f689:b0:224:93e:b5d7 with SMTP id d9443c01a7336-22e1ea4ad68mr18586115ad.34.1746284318387;
        Sat, 03 May 2025 07:58:38 -0700 (PDT)
Received: from localhost ([2605:52c0:1:4cf:6c5a:92ff:fe25:ceff])
        by smtp.gmail.com with UTF8SMTPSA id d2e1a72fcca58-74058d7beb2sm3429441b3a.1.2025.05.03.07.58.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 03 May 2025 07:58:37 -0700 (PDT)
Date: Sat, 3 May 2025 22:58:58 +0800
From: shejialuo <shejialuo@gmail.com>
To: Jeff King <peff@peff.net>
Cc: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Collin Funk <collin.funk1@gmail.com>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] wrapper: Fix a errno discrepancy on NetBSD.
Message-ID: <aBYvMjtGjzEhKg4s@ArchLinux>
References: <20250502233403.289761-1-collin.funk1@gmail.com>
 <aBVp51yLwxBpRskt@tapette.crustytoothpaste.net>
 <20250503133158.GA4450@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250503133158.GA4450@coredump.intra.peff.net>

On Sat, May 03, 2025 at 09:31:58AM -0400, Jeff King wrote:
> On Sat, May 03, 2025 at 12:57:11AM +0000, brian m. carlson wrote:
> 
> > > diff --git a/wrapper.c b/wrapper.c
> > > index 3c79778055..4d448d7c57 100644
> > > --- a/wrapper.c
> > > +++ b/wrapper.c
> > > @@ -737,7 +737,19 @@ int is_empty_or_missing_file(const char *filename)
> > >  int open_nofollow(const char *path, int flags)
> > >  {
> > >  #ifdef O_NOFOLLOW
> > > -	return open(path, flags | O_NOFOLLOW);
> > > +	int ret = open(path, flags | O_NOFOLLOW);
> > > +#ifdef __NetBSD__
> > > +	/*
> > > +	 * NetBSD sets errno to EFTYPE when path is a symlink. The only other
> > > +	 * time this errno occurs when O_REGULAR is used. Since we don't use
> > > +	 * it anywhere we can avoid an lstat here.
> > > +	 */
> > > +	if (ret < 0 && errno == EFTYPE) {
> > > +		errno = ELOOP;
> > > +		return -1;
> > > +	}
> > > +#endif
> > > +	return ret;
> > 
> > This patch seems reasonable and correct.  I don't use NetBSD, but I do
> > often test there, and I'm aware of this infelicity.  I'm surprised we
> > haven't hit it before.
> > 
> > I suspect we'll also hit this on FreeBSD, which has a similar issue in
> > that it returns `EMLINK` instead of `ELOOP`.  I do wish these two OSes
> > would provide an appropriate POSIX-compatible `open` call when set with
> > `_POSIX_SOURCE`, since this is one of the biggest portability problems
> > with them.
> 
> The inconsistency in errno has been there since open_nofollow() was
> added years ago. But we didn't notice it because in general we try not
> to be too particular about which errno value we receive.
> 
> That changed in cfea2f2da8 (packed-backend: check whether the
> "packed-refs" is regular file, 2025-02-28), which uses open_nofollow()
> to check for symlinks while we open it. But it feels like it would be
> more direct to just lstat() the file in the first place (which we end up
> doing anyway to check for other things besides symlinks!).
> 
> I.e., I'd think this would just work everywhere:
> 
> diff --git a/refs/packed-backend.c b/refs/packed-backend.c
> index 3ad1ed0787..a247220df9 100644
> --- a/refs/packed-backend.c
> +++ b/refs/packed-backend.c
> @@ -2071,35 +2071,32 @@ static int packed_fsck(struct ref_store *ref_store,
>  	if (o->verbose)
>  		fprintf_ln(stderr, "Checking packed-refs file %s", refs->path);
>  
> -	fd = open_nofollow(refs->path, O_RDONLY);
> -	if (fd < 0) {
> +	if (lstat(refs->path, &st) < 0) {
>  		/*
>  		 * If the packed-refs file doesn't exist, there's nothing
>  		 * to check.
>  		 */
>  		if (errno == ENOENT)
>  			goto cleanup;
>  
> -		if (errno == ELOOP) {
> -			struct fsck_ref_report report = { 0 };
> -			report.path = "packed-refs";
> -			ret = fsck_report_ref(o, &report,
> -					      FSCK_MSG_BAD_REF_FILETYPE,
> -					      "not a regular file but a symlink");
> -			goto cleanup;
> -		}
> -
> -		ret = error_errno(_("unable to open '%s'"), refs->path);
> -		goto cleanup;
> -	} else if (fstat(fd, &st) < 0) {
>  		ret = error_errno(_("unable to stat '%s'"), refs->path);
>  		goto cleanup;
> -	} else if (!S_ISREG(st.st_mode)) {
> +	}
> +
> +	if (!S_ISREG(st.st_mode)) {
>  		struct fsck_ref_report report = { 0 };
>  		report.path = "packed-refs";
>  		ret = fsck_report_ref(o, &report,
>  				      FSCK_MSG_BAD_REF_FILETYPE,
>  				      "not a regular file");
> +		/* XXX optionally could keep going here and actually
> +		 * check the contents we do find */
> +		goto cleanup;
> +	}
> +
> +	fd = open(refs->path, O_RDONLY);
> +	if (fd < 0) {
> +		ret = error_errno(_("unable to open '%s'"), refs->path);
>  		goto cleanup;
>  	}
>  
> diff --git a/t/t0602-reffiles-fsck.sh b/t/t0602-reffiles-fsck.sh
> index 9d1dc2144c..34d54a7c05 100755
> --- a/t/t0602-reffiles-fsck.sh
> +++ b/t/t0602-reffiles-fsck.sh
> @@ -632,7 +632,7 @@ test_expect_success SYMLINKS 'the filetype of packed-refs should be checked' '
>  		ln -sf packed-refs-back .git/packed-refs &&
>  		test_must_fail git refs verify 2>err &&
>  		cat >expect <<-EOF &&
> -		error: packed-refs: badRefFiletype: not a regular file but a symlink
> +		error: packed-refs: badRefFiletype: not a regular file
>  		EOF
>  		rm .git/packed-refs &&
>  		test_cmp expect err &&
> 
> It's not as "atomic" as open_nofollow() and fstat(), but I don't think
> we care about that for fsck. This is about consistency checking, not
> trying to beat races against active adversaries (not to mention that our
> open_nofollow() is best-effort anyway, and may be racy).
> 

The motivation why I use "open_nofollow" is that we want to avoid race
conditions as many as possible. However, as you have said, our
"open_nofollow" function still has the race. And it would be a little
cumbersome to make "open_nofollow" compatible. So, I rather prefer that
we simply use this way to solve the problem.

> I dunno. I don't mind making errno returns more consistent to prevent a
> future foot-gun, but I think as a general rule we may be better off not
> looking too hard at errno for exotic conditions.
> 

I don't mind either.

> -Peff
> 
> PS I notice that this same function reads the whole packed-refs file
>    into a strbuf. That may be a problem, as they can grow pretty big in
>    extreme cases (e.g., GitHub's fork networks easily got into the
>    gigabytes, as it was every ref of every fork). We usually mmap it.
>    Not related to this discussion, but just something I noticed while
>    reading the function.

Peff, thanks for notifying me. I want to know more background.
Initially, the reason why I don't use `mmap` is that when checking the
ref consistency, we usually don't need to share the "packed-refs"
content for multiple processes via `mmap`.

I don't know how Github executes "git fsck" for the forked repositories.
Is there any regular tasks for "git fsck"? And would "packed-refs" file
be shared for all these repositories?

If above is the case, I agree that we should reuse the logic of
"load_contents" to enhance. But I don't know whether we need to do this
in the first place.

Thanks,
Jialuo
