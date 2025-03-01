Received: from mail-yb1-f180.google.com (mail-yb1-f180.google.com [209.85.219.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63BED635
	for <git@vger.kernel.org>; Sat,  1 Mar 2025 00:12:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740787973; cv=none; b=V1kZYHklZIhLa8vCl6fyB8jVP+QzxxIsIcfo6MY8RelIvTh7V/jjz03ha038JECbuONjS3ob1TKmUefi6wkyiueYP2Q9coLrvnre9xiB/FsqCdFJS1kWNY59geaGVUB00K/QERyJr1sYhqkh8fk6pomvmHuKRpJwLxpNpZAO/9s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740787973; c=relaxed/simple;
	bh=HSnnD8u+XSCoQ15NdTUddcjEvDF+dDNhGlJ+qUud/eY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WTtAMZnclrouUpYNuvev53O5iTqPW2hRjM06Cyv/0dPtSFFk9K5PhlWTwTYbyALHY8DwozVe449rqtBrQlD4Ds4rDJlhHbNRXgaR+qKohoShfZIzHvX9z++V7cuwF55h66qIKsFHj2UZDahjNFhxm9EK6XR9yW8ELz0lugBpsPM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=ylyfa9uO; arc=none smtp.client-ip=209.85.219.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="ylyfa9uO"
Received: by mail-yb1-f180.google.com with SMTP id 3f1490d57ef6-e60ad903382so1384855276.0
        for <git@vger.kernel.org>; Fri, 28 Feb 2025 16:12:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1740787970; x=1741392770; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=vH9H7rNQ0+h26X29s80a8CViH0M8O3tW66R4sp701bo=;
        b=ylyfa9uOcBwib/KUsfpRr+6PkOgHJQJwYEsbpxZmZkV/7anTRdQsds2kVmbTb3mPy2
         coQ4RK+KiqKnDxBwnp8r1AY18szDomzOuXHOKw9uzKYxvFNukOLA+Knv0XwTMs8RIOcl
         1kwlu42WczLL+lh7E/lOy6Od+BjytDcUotZwMY8WLPH9CfVO4SIbhDibOKwLP0witv8e
         QmPtDkXF/9VmvqVzgezh6y7L6MB8/ToC2jiUMTbYuLyWiYa1qF/OP7SOnzKiOb1fVKzp
         UYycXl8OrkZLfmQ6HR0z9j4Cpno0UNrzYlnR3GnaXbTZ8OlysvxxCRvr6+wnT+YM0Iwq
         7ycg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740787970; x=1741392770;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vH9H7rNQ0+h26X29s80a8CViH0M8O3tW66R4sp701bo=;
        b=XLxKylBsjX0uHwlATpAvl6AmlaNtlI+citqHOkKtBiCr/MHQnASSG6kW01p/CQuUQT
         bt+Z2KOyeSubJFvpWt2M+M5mQzlpI8Zcscc7bs7v5sHbrevkgf/Oh0r1QlCNjfuiiruD
         JAsw4OVf/rpM5Yf6Bkh7520pP7Voqqy0gFTJknoVp8y+hZ6ewz1Xr/5UEtLONRqmDXCC
         bPliJ5/hxc6SKmOmW0mHOp9F6AApNVSzN1aH9kkv9s2fgfO/YTOkt+cJM/cIvtC8JHOL
         kw9D4lxbP02rU1zBhFNnqEm6Lrz+Tgh3n69W3dgqlSOhEAf6n44M9NF5rUwg9HvOXM45
         UOzQ==
X-Gm-Message-State: AOJu0YzvOpUgxBW1JK5wqi3R0kbJQc2YGBbzEzFeeOcQfC5qrAzo2+QR
	PdChGycOQAMamyVwx745UP7S9jDkpZLt0D2cHkV36HHdkad4ePM3rp1l3il2D4E=
X-Gm-Gg: ASbGnctDgUlv55sMDteEPUxK274SZufmUbpUQ/GhK5kud0Ck23H9/ibD+nSg6VWd9QF
	dZqu84Y8ivYPpVVqyaQ8AlBtGS+U0kpqNN4ewScBsY1EBVc0P5nanddkWMpN8kyJtku0Li8F/2b
	e6TEJu6lb0zW75JuU0Fym2W1Q22s5dhnqpHkiAfbi0lYETygIufq2lzJlvCkiVMHfgbH7lV073F
	GalWXzWjs/y7qhTBHYwEETS6eVpH1Sb4uh0rtINz7kHLa7yC3PZ0pJBXsKHwT6PelI9OsdjK3ny
	00oPiLc835AU7oRmXmSPHnLIV4VKN182qKXzJls9b4bOIayfcbX0pfdRgpwZLQT+Bn6IlMILCOs
	w11eA50pZz5FZpxWh
X-Google-Smtp-Source: AGHT+IHfBdk8kopwYmxsJU1LkfJi2YVADZDFyibbcZwHq4yjdL22FURLif2oR8+cSydmiGsXyywuYA==
X-Received: by 2002:a05:690c:7484:b0:6e9:e097:718c with SMTP id 00721157ae682-6fd4a088fb2mr86679347b3.6.1740787970066;
        Fri, 28 Feb 2025 16:12:50 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with UTF8SMTPSA id 00721157ae682-6fd3cb7e155sm9530167b3.85.2025.02.28.16.12.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Feb 2025 16:12:49 -0800 (PST)
Date: Fri, 28 Feb 2025 19:12:43 -0500
From: Taylor Blau <me@ttaylorr.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Elijah Newren <newren@gmail.com>,
	Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 04/13] pack-bitmap.c: teach `bitmap_for_commit()`
 about incremental MIDXs
Message-ID: <Z8JQ+1mg/iYe7OCw@nand.local>
References: <cover.1723755667.git.me@ttaylorr.com>
 <cover.1732054032.git.me@ttaylorr.com>
 <16259667fb4d7534458bb458afd6cefe032c3b6f.1732054032.git.me@ttaylorr.com>
 <Z8GJb4y7yui7rvxZ@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Z8GJb4y7yui7rvxZ@pks.im>

On Fri, Feb 28, 2025 at 11:01:19AM +0100, Patrick Steinhardt wrote:
> On Tue, Nov 19, 2024 at 05:07:29PM -0500, Taylor Blau wrote:
> > diff --git a/pack-bitmap.c b/pack-bitmap.c
> > index 41675a69f68..e3fdcf8a01a 100644
> > --- a/pack-bitmap.c
> > +++ b/pack-bitmap.c
> > @@ -946,18 +946,21 @@ static struct stored_bitmap *lazy_bitmap_for_commit(struct bitmap_index *bitmap_
> >  struct ewah_bitmap *bitmap_for_commit(struct bitmap_index *bitmap_git,
> >  				      struct commit *commit)
> >  {
> > -	khiter_t hash_pos = kh_get_oid_map(bitmap_git->bitmaps,
> > -					   commit->object.oid);
> > +	khiter_t hash_pos;
> > +	if (!bitmap_git)
> > +		return NULL;
> > +
> > +	hash_pos = kh_get_oid_map(bitmap_git->bitmaps, commit->object.oid);
> >  	if (hash_pos >= kh_end(bitmap_git->bitmaps)) {
> >  		struct stored_bitmap *bitmap = NULL;
> >  		if (!bitmap_git->table_lookup)
> > -			return NULL;
> > +			return bitmap_for_commit(bitmap_git->base, commit);
> >
> >  		/* this is a fairly hot codepath - no trace2_region please */
> >  		/* NEEDSWORK: cache misses aren't recorded */
> >  		bitmap = lazy_bitmap_for_commit(bitmap_git, commit);
> >  		if (!bitmap)
> > -			return NULL;
> > +			return bitmap_for_commit(bitmap_git->base, commit);
> >  		return lookup_stored_bitmap(bitmap);
> >  	}
> >  	return lookup_stored_bitmap(kh_value(bitmap_git->bitmaps, hash_pos));
>
> One of the things that worries me a bit is that by recursing, we
> essentially are bound in the depth of MIDX layers as we may otherwise
> bust the stack. Not that I expect us to typically have thousands of
> layers, but if there ever was a bug this may fail in bad ways.

I think it's a valid concern, but in practice I suspect we are unlikely
to run into it. If we have enough MIDX layers to blow the stack, we
probably have much bigger problems to worry about ;-).

> I already asked this for a previous commit, but what is the current
> state regarding compaction of the layers? Do we need to be worried about
> this or do we already know to keep things limited in general?

I mentioned upthread, but briefly: we don't compact MIDX layers today,
but the design is such that it is possible (and planned) to do in the
future (part three of this multi-series thing).

Thanks,
Taylor
