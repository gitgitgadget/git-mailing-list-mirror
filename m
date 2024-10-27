Received: from mail-yb1-f179.google.com (mail-yb1-f179.google.com [209.85.219.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C36313D297
	for <git@vger.kernel.org>; Sun, 27 Oct 2024 23:54:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730073257; cv=none; b=Vy6qfLY+3IAtO1zUq7Qe1wFuvGtrBxxKfukukBRvhpEuZ87Cl0Z01z+bLmuheoNNRufV689ING8gqC4svmVqbnU+YiQTncXGxOnhPYdPBJMOQ4jjkT9bMIJUX3WNARodBkNqP4rJAD/u0QIrrDNzzd+8dH+Y+RgSq8Z5gBNbwkk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730073257; c=relaxed/simple;
	bh=cxdvE1qN1Go69vhOAGBoZ91pCM1X2/NCzv8fOB9jJi0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ttc2kwnSBOLHKEcu3oUApGS4GoAS2kc/LB2bmyIySAQCinUIsgyEgRQW4BZg1kKK13teGF4Fk0l4anF6Xjt/3gd2T74vYAgG6Uj+/QixR2syhDmSkGCl0eX1l76ujRB3M8MD11qYRf8JrKKV5sPghVN9leDhcC3W73mvupEn/bs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=nnEJ47yv; arc=none smtp.client-ip=209.85.219.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="nnEJ47yv"
Received: by mail-yb1-f179.google.com with SMTP id 3f1490d57ef6-e2e33f614e1so3987803276.3
        for <git@vger.kernel.org>; Sun, 27 Oct 2024 16:54:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1730073254; x=1730678054; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=cxdvE1qN1Go69vhOAGBoZ91pCM1X2/NCzv8fOB9jJi0=;
        b=nnEJ47yvgUmGIXmoLN1Hy5NbkGH7WBFU2QZ795Jlj35WnycIu//fBj7tubJzfgWtVg
         9rZyiKfFGu4QGQWUt4SjYaDyg8BHFmwfg5iBwfHKg5p64TEs6EjtPf66HaLqj7rzlHjT
         Dn6KfxDHKGslnnpUgdsSYnGmzUHdlwynEw6PxSBGnnk9m7F98X4zXyuhN9jJOdrWdPk3
         cVH7T63dnbwqj3MaUh1IvhHNYpJmroHtevRx0R4UDHAHjEpNdkgI3rz6GFpSZNHc7VyP
         qnDvMjqgJW9q+vvbMCaCoxJV0S90PPSa3wZQlj5npKwLbUkr+iY5JmAAMKG5sbi/alM3
         atbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730073254; x=1730678054;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cxdvE1qN1Go69vhOAGBoZ91pCM1X2/NCzv8fOB9jJi0=;
        b=gEFKL6v3Wl3z2Ya1qejxjF10soiaS8POI+YsLKGHj44rgCJwHkgg2+Uu2D4VsDNMgV
         bFzrV26ZPIoN7QlZlSA1afeofk0ruZH3SYUFyTEbdUxCiMtaeK5yQrBKM9mZbArT+n44
         Yvgxd0ffyJ9pXMZ2QLipthhfW/Jh6FnyrjsBPLVu/u+lXCAvqzPs6/qF46j+3EllFeKj
         EHHHDNGEiTSCxLMUdsEsEsR+Lkwt9Su2lr2ZA95hQ7aC3zVjAyC4tNEAeKGnTyt4xm/r
         L9Ue8Dw8Ar6UtikThZ4DY72jCHOaSAMhrjHhLYrZeaFPMbVifv4FdNgi0gdo/ZSRM88q
         FSbg==
X-Gm-Message-State: AOJu0YzEFoOEFe0dU/qkeGsp0BCwAFz1Vo90/jhaGkZQD0TlZZp1fe4S
	bMZKGucGTCzqCSFrx+MdBt91ElPtp9Q1vT5b0fPGLuvjnLV3MpVXycFGOgHKo497w7XFAzF4GTH
	hnj0=
X-Google-Smtp-Source: AGHT+IFl7n0wLshH4hgz7BRR6+Z+ZgjBqJiTljqsycChS3sQhBivui5AHcWooVqfEdU683O6KjPNYQ==
X-Received: by 2002:a05:6902:11c8:b0:e28:fb97:cdf4 with SMTP id 3f1490d57ef6-e3087949b7cmr5400453276.1.1730073254537;
        Sun, 27 Oct 2024 16:54:14 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e3079d726f1sm1176419276.15.2024.10.27.16.54.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Oct 2024 16:54:14 -0700 (PDT)
Date: Sun, 27 Oct 2024 19:54:12 -0400
From: Taylor Blau <me@ttaylorr.com>
To: karthik nayak <karthik.188@gmail.com>
Cc: git@vger.kernel.org, Patrick Steinhardt <ps@pks.im>
Subject: Re: [PATCH 00/20] packfile: avoid using the 'the_repository' global
 variable
Message-ID: <Zx7SpAXPOAZSe1o2@nand.local>
References: <cover.1729504640.git.karthik.188@gmail.com>
 <ZxbBuyhfq1sFKBIU@nand.local>
 <CAOLa=ZS3XjxdeYxbZCTCdaUzW4jko8ZLaKMvQsvzUnsan2Ho9Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAOLa=ZS3XjxdeYxbZCTCdaUzW4jko8ZLaKMvQsvzUnsan2Ho9Q@mail.gmail.com>

On Sun, Oct 27, 2024 at 05:23:24PM -0400, karthik nayak wrote:
> While thinking about this over the last few days and also getting some
> advice from Patrick, I realized that we don't need to be this disruptive
> by simply adding the 'repository' variable to the already existing
> 'packed_git' struct. This allows us to leverage this information more
> easily, since most of the functions already have access to the
> 'packed_git' struct.

Great idea!

> This, plus the series by Jeff 'jk/dumb-http-finalize' which also removes
> some existing functions. We reduce the impact to only 3 functions being
> modified.
>
> I think with such low impact, it might make more sense to not go with
> the Coccinelle approach, since it is a lot simpler without it.
>
> I'll post a new version tomorrow showcasing this approach, but I'll
> leave the final decision to you whether it is still disruptive, and if
> the approach you mentioned would be better.

I'll have to see the end result to know for sure, but it sounds like
this would be a good way to move it forward without being too
disruptive.

I wonder how it interacts with alternates, though...

Thanks,
Taylor
