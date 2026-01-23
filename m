Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1F142F531F
	for <git@vger.kernel.org>; Fri, 23 Jan 2026 01:06:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769130408; cv=none; b=ioSNlOj9ZVoessyKXaznVSsMQFmbcaQbKOY9xY1T7FvzHgjVrJfsY8+SKSGe4C1kj9muKp6H8nV7XbnAREIM8yB5mGN6+Rr9GUe1RZYpkhqSCYHhpzEOkOar89sf6L+fADc9Gib+6+SBMLuVwV1HGXW9jXiuiXc7pFr6yGtrb7s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769130408; c=relaxed/simple;
	bh=qOLNx2dboO5QapMrMna+hg/Sc9gxIAFdP/sg6ESf3XU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BfHsB0+G+Qj0dgwz9A+9vA250I4Uc5kYC1lmmQCvEob7cqTr/sRVTLeiT5y3Q9Z289/YFP+l9ucYNAbx4MVLcxveSTwtBuJUmBcru+xUCZ6yEbLLE6sUxlpQm0TtwFVbbz/MsoxTyhhKqPM5pdYJl2jqvWFIuFS9Rvrl1bCcIiU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b=UlddWePR; arc=none smtp.client-ip=209.85.128.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b="UlddWePR"
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-794265fb73bso15692707b3.1
        for <git@vger.kernel.org>; Thu, 22 Jan 2026 17:06:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr.com; s=google; t=1769130402; x=1769735202; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=JfW+U4ba3fnJIrHOallX62Piz/BBF2EhLWlB5fpb6Jw=;
        b=UlddWePRdTqcDFIYRh0PkoqSYpiQqmTN9v1rtfYr6GzDGRayNKzIDVtDFWVzN03me3
         MeYREow+CzQOSLrIVFPbmABFn0/D0JgpdWBMWapUa5fgEsBb0a6qeRgFBZqw3rmVUuc6
         gXxVlYFHuhFNz8czip9eHn2KG93OpxK7gKPWMMBJUjR6G5+ivnu8z8zXnT44c2gP5+oY
         E2sZXfU9nTa+GLfywjo+u1YFgT7sAGxEXRIwUwSDL++0yzhnfYbfA2MX//FWAPvxsq1M
         Y/QCYQLJnjIXHsJ6GEcQL5entMwfR88DFafemBNGYjtvrjw9teI6kG+KxvtwVuRcethT
         6YZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769130402; x=1769735202;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JfW+U4ba3fnJIrHOallX62Piz/BBF2EhLWlB5fpb6Jw=;
        b=AQWiQEpWuVE/yGrmTVtT+HErdf6WP5EM2sk6ndijW9V6Xzc31+onSUBg0KYqSAtChk
         ZrJqtKndKQUSvVWfJQgek21/sIedVxUWGpyQlymW/QR/f0o7iS7jzivC+3+I3cIkfnjJ
         MHyACZSW26tBJJ5WxItdNB3U0w8D4HxB+fgREi5uad75jB+Q1GZ1xq5/sxmck/AD2tlV
         2KTtK7GY+y2FATF5hrdNsRWpln7LlFgQ8JeUQzDh55ZJGUhnzI74sSJQZIjH0ZFo7yUG
         KgtUlwI4/GgMrqBDMQ5P1BbSPy/cvAh1rJlGBnOJgeEpoPNL9zVb6Kl4EZlxv/jz90Ye
         MtXA==
X-Gm-Message-State: AOJu0YxWwH+/IUFQhYUAZHzqvOFLUUhmKu8sYVmgup02H9wV0o9+UDlK
	31Rd9qG0KPYX0hi5UM5D84rFTccD6veNdqtLctu4KWxD2hBbZrIA+xLq2fXM87z87QCZ4lXHnHc
	nf5wio6I=
X-Gm-Gg: AZuq6aLB+IJaR7ojnlsPLqCbF0LG/eh2zKdjiTe3i2Q6VCyh7Hdiv6/BaGRzpvpKDYE
	Rpy0SM24QBjQQpdFENt2jMKQHfX9RaP1GpVPgZCmJ9Bkm3gsHtK3rlgS3eDQ3kjwPKDM3aCI3gL
	B3ZlC5Dxd1qvh3qjT64sGnB6V1BTY7LI6x7fn9Wr6ddiCW73QbawMpmSzlqKJrSZoSPY4ksieo+
	b/frfNRLulJcacskDf+JS4+rJs8sokNvASdht1tw490hFDF7LSCRv2LDTecul7uOj9pehqngtC7
	7tOTZ5qrGzBCEWrrPiAvh/S8V7Md/VvNih/dq0BN3yUAR60pl2t6jmFdvqs2V36eSG1EBdcAra8
	BwSd+NsG0mHBd9zhBUaENIpuxvEe6dUQsM88j4g2EMDF/2L0L2xCKNkitBX2PW66J53fOoSBW09
	nD1BdywKa8FgNWHYDWLn0W0+8RiIyF3Ui7sPv6H0fFj5LeDLsJuibDVmEqZw+zSyGMvv6e5RlVp
	FzmMweDBp2rZ0xUog==
X-Received: by 2002:a05:690c:6809:b0:784:aec5:7042 with SMTP id 00721157ae682-794399d2cd2mr14581537b3.38.1769130401665;
        Thu, 22 Jan 2026 17:06:41 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7943ae2d7f9sm4544437b3.0.2026.01.22.17.06.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Jan 2026 17:06:41 -0800 (PST)
Date: Thu, 22 Jan 2026 20:06:40 -0500
From: Taylor Blau <me@ttaylorr.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Karthik Nayak <karthik.188@gmail.com>,
	Justin Tobler <jltobler@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 11/14] odb: introduce mtime fields for object info
 requests
Message-ID: <aXLJoDdoEyKXKtBf@nand.local>
References: <20260121-pks-odb-for-each-object-v3-0-12c4dfd24227@pks.im>
 <20260121-pks-odb-for-each-object-v3-11-12c4dfd24227@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260121-pks-odb-for-each-object-v3-11-12c4dfd24227@pks.im>

On Wed, Jan 21, 2026 at 01:50:27PM +0100, Patrick Steinhardt wrote:
> There are some use cases where we need to figure out the mtime for
> objects. Most importantly, this is the case when we want to prune
> unreachable objects. But getting at that data requires users to manually
> derive the info either via the loose object's mtime, the packfiles'
> mtime or via the ".mtimes" file.
>
> Introduce a new `struct object_info::mtimep` pointer that allows callers
> to request an object's mtime. This new field will be used in a
> subsequent commit.

The goal seems reasonable to me, but I am a little unsure about whether
or not this is the right place to expose this information. I have some
more thoughts below...

> diff --git a/object-file.c b/object-file.c
> index 65e730684b..c0f896673b 100644
> --- a/object-file.c
> +++ b/object-file.c
> @@ -409,6 +409,7 @@ static int read_object_info_from_path(struct odb_source *source,
>  	char hdr[MAX_HEADER_LEN];
>  	unsigned long size_scratch;
>  	enum object_type type_scratch;
> +	struct stat st;

I was a little confused why we were declaring a stat struct here...

>  	/*
>  	 * If we don't care about type or size, then we don't
> @@ -421,7 +422,7 @@ static int read_object_info_from_path(struct odb_source *source,
>  	if (!oi || (!oi->typep && !oi->sizep && !oi->contentp)) {
>  		struct stat st;
>
> -		if ((!oi || !oi->disk_sizep) && (flags & OBJECT_INFO_QUICK)) {
> +		if ((!oi || (!oi->disk_sizep && !oi->mtimep)) && (flags & OBJECT_INFO_QUICK)) {
>  			ret = quick_has_loose(source->loose, oid) ? 0 : -1;
>  			goto out;
>  		}
> @@ -431,8 +432,12 @@ static int read_object_info_from_path(struct odb_source *source,
>  			goto out;
>  		}
>
> -		if (oi && oi->disk_sizep)
> -			*oi->disk_sizep = st.st_size;
> +		if (oi) {
> +			if (oi->disk_sizep)
> +				*oi->disk_sizep = st.st_size;

...and then assigning it here without actually calling lstat() between
the two. But the diff context elides the fact that there is another stat
declaration within this block that we *do* lstat() into before reading
it.

That tripped me up a little while reviewing, but not a huge deal. I do
wonder whether or not there is a clearer way to structure all of these
conditionals. I *think* that what you wrote here is right, but the way
that it has grown organically over time (to be clear, not the fault of
your series) makes it a little difficult to follow.

> +			if (oi->mtimep)
> +				*oi->mtimep = st.st_mtime;
> +		}
>
>  		ret = 0;
>  		goto out;
> @@ -446,7 +451,21 @@ static int read_object_info_from_path(struct odb_source *source,
>  		goto out;
>  	}
>
> -	map = map_fd(fd, path, &mapsize);
> +	if (fstat(fd, &st)) {
> +		close(fd);
> +		ret = -1;
> +		goto out;
> +	}

Makes sense. We were previously letting map_fd() take care of stat()-ing
the file to know how large the mmap should be, but now we might need
that information for the mtime as well. So doing what map_fd() is doing
underneath here directly makes sense.

> diff --git a/odb.c b/odb.c
> index 65f0447aa5..67decd3908 100644
> --- a/odb.c
> +++ b/odb.c
> @@ -702,6 +702,8 @@ static int do_oid_object_info_extended(struct object_database *odb,
>  				oidclr(oi->delta_base_oid, odb->repo->hash_algo);
>  			if (oi->contentp)
>  				*oi->contentp = xmemdupz(co->buf, co->size);
> +			if (oi->mtimep)
> +				*oi->mtimep = 0;

Assuming that you do not change the object_info request/response
semantics, I wonder if it might make sense to zero out the entirety of
the response section as a belt-and-suspenders mechanism in case future
contributors forget to assign zero to the new fields themselves.

> @@ -1619,16 +1620,34 @@ int packed_object_info(struct packed_git *p,
>  		}
>  	}
>
> -	if (oi->disk_sizep) {
> -		uint32_t pos;
> -		if (offset_to_pack_pos(p, obj_offset, &pos) < 0) {
> +	if (oi->disk_sizep || (oi->mtimep && p->is_cruft)) {
> +		if (offset_to_pack_pos(p, obj_offset, &pack_pos) < 0) {
>  			error("could not find object at offset %"PRIuMAX" "
>  			      "in pack %s", (uintmax_t)obj_offset, p->pack_name);
>  			ret = -1;
>  			goto out;
>  		}
> +	}
> +
> +	if (oi->disk_sizep)
> +		*oi->disk_sizep = pack_pos_to_offset(p, pack_pos + 1) - obj_offset;
> +
> +	if (oi->mtimep) {
> +		if (p->is_cruft) {
> +			uint32_t index_pos;
> +
> +			if (load_pack_mtimes(p) < 0)
> +				die(_("could not load cruft pack .mtimes"));

Do you think it would be worth doing instead:

    die(_("could not load .mtimes for cruft pack '%s'"), pack_basename(p));

? Most repositories should only ever have one cruft pack in practice
(even so, there should still be some value in identifying it by its
checksum in case someone is repacking underneath us). But some
repositories will have >1 cruft pack, so knowing which one is busted may
be useful in that case.

> +
> +			if (maybe_index_pos)
> +				index_pos = *maybe_index_pos;
> +			else
> +				index_pos = pack_pos_to_index(p, pack_pos);
>
> -		*oi->disk_sizep = pack_pos_to_offset(p, pos + 1) - obj_offset;
> +			*oi->mtimep = nth_packed_mtime(p, index_pos);
> +		} else {
> +			*oi->mtimep = p->mtime;
> +		}

I am a little stuck here on whether or not this is the right layer to
determine an object's mtime. On the one hand, it makes sense to me that
callers would want to know the mtime of an object, either by the mtime
of the loose object on disk, or the mtime of the contain pack otherwise.

But I'm not sure whether the GC-specific definition of "mtime" is what
the caller would always want. For GC uses, yes, having mtime be aware of
cruft packs makes total sense to me. But for non-GC uses, would there
ever be a scenario where the caller would want to know the mtime of an
object's containing pack, regardless of whether or not that pack is
cruft?

I suppose they could get around that today by doing something like:

    if (oi->whence == OI_PACKED) {
        struct packed_git *p = oi->u.packed.p;
        if (p->is_cruft) {
            /* reinterpret the meaning of mtime... */
            *oi->mtimep = p->mtime;
        }
    }

, but that feels a little clunky. I dunno, maybe this hypothetical
doesn't really exist and I'm overthinking this. But I have this nagging
feeling that we are exposing this information at too low of a level as
to make the object store aware of cruft pack/GC-specific mechanics.

Thanks,
Taylor
