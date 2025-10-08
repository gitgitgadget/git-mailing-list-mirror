Received: from mail-il1-f182.google.com (mail-il1-f182.google.com [209.85.166.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A73FB20296E
	for <git@vger.kernel.org>; Wed,  8 Oct 2025 21:59:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759960747; cv=none; b=XUUkKGRaaPVAOu5iD5u8sPvffCw5216NaMalX6FPPxqmKSUKpQR8CxWwcgiPHRqP3lmqKd1/53Qt9idIzVYh7f/9URzsDFqYqzaQjH2KHFw0Lf67sHui7cE+8X1l73eTyempVcT3uRJWzAH1iCWtOnqhKUdaaQBVU1hlmt1+TP0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759960747; c=relaxed/simple;
	bh=tKL/MBbTB/LDybjMCQzsYC83y6MEHLXDhUK1ttY6JrI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Lz2IADEFmtJYKfAqrFWTKKTbqSuwqTeySp9jjimLZ6wXsOcMOtJ2vRSB/5Yh25EBkP1MllxlvC+H+J+6W54HXU5OR7T3dfB3po3XIPtFjsWr4vlpDeAHDriUs+DcbriP93Y6s/UZ9Oo5SxnX6QLpO0/2ycqnUgSqTrF/z3KQ6O4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b=N054cp+M; arc=none smtp.client-ip=209.85.166.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b="N054cp+M"
Received: by mail-il1-f182.google.com with SMTP id e9e14a558f8ab-42d8bf52325so1561145ab.3
        for <git@vger.kernel.org>; Wed, 08 Oct 2025 14:59:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr.com; s=google; t=1759960744; x=1760565544; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=uOolZRnb7/s2S0b0XOYrgRXsCwIKQsZrHWqzxKSdxLA=;
        b=N054cp+MuBv9AfPp0tUGrzqMgHB8A3UdwCqaEJwKRniDG//TcrSc2aullFJ/SzHma3
         H5b92VxJed+W7g6MkYgH6GKoXI52Zj3xTpXS53B0/o/B7FuAwwDWRCaZ1W/e63CT/ww6
         /8xHQStJ+KdcZWaBCTDxHnDZp5swQhHw59S6wMyMXrgxazID8rY4A4Cm/P1y8rkhCK4O
         oa3Y59KfbHpitvQXy8Qlqayftl5NZSFbFY4gPUVz3rd9eZRm5HoLkKTVsUKzc1p/abMc
         u4Zh9VsbQoN6DkAedE//SgbrC2svDh27JsrF/cv6zM/41wriQt+zvxIIlasGqhKWyhWA
         zhCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759960744; x=1760565544;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uOolZRnb7/s2S0b0XOYrgRXsCwIKQsZrHWqzxKSdxLA=;
        b=ZdHftHtt/lnqpVfT6vk4E0yFCo7xUFuATei4qBuThmFo1zXNelCVYO9QOsuTCgJrfh
         E1OWd6/yZqnMZ9fZvWNLEWMqzMyLUGGxwOR5t9m7E2seU4fZ0smzj8pIJGVmTAk/65dg
         MD1pz4Fyp4YaWreGtE/tX34jn3LZNjlJ3VJkJwjqjPZAmdsuWCvIanaeidpyKxZ+ffOG
         hfB+h7bFcob43HdHHyL42x08DihMvIcTc0BKJMW+uRpYXy32ZOcHgmCUPv5RqgUgo/Tv
         w5Bqa5hbeN1Wto4MidztjDExR/GXHKtt95tmDKNiY53ggzSiLitHimveo3xUx2zK/fky
         U/lg==
X-Forwarded-Encrypted: i=1; AJvYcCV05Zowx7Qh9lmy1M79APZZBXrgOgL6VBIQYXkXYBTid77Ei7cANU5WXg5dOKb7NOADz5M=@vger.kernel.org
X-Gm-Message-State: AOJu0YxNFEPqJC1d9VCo+NXeyEAUqJ9NIYZfx/hAiv8HpfC/mLsUk0PA
	kuIqxD+y2+wvbdNqqitDgTkhwMRwFXw0fjYy0aGFrt+G9kb+k65ayDA+WducGiD5vX0=
X-Gm-Gg: ASbGnctX3EoeAGH/G/0RSdOW2Eqxh1Kx9Bvn5I6LwZqfETOlFVuZr0ohrFa8DraJYGV
	BYhJeKDYbY9Xpt5i5KbVx5apaOnX147ATo7BFdIhb6GOFwEYIb5/DcygUzfJgRlNeikdbkPI2jT
	+d3/lNOVFd9ZtncVtgP48xj/LOoONSztYxwsl2H69EMtv5BXWNRNQroK6FZJYbBe7IZCq2g4sTC
	Y64DLWv1P7Oi4d//qgqMCqqOWg+Y6O74gBF8PtE4+sOZz1eKvdF3wnrgq8vsSnDFISmwUhet5ZA
	vgGql++Ca5ArO/e74vwE/nOpEl40OtSdnYNCiK7mjc6/BMoWzaeuEeyQkNX46QoNpKy/di4xJmw
	kTC4I0I1uzEyE4z97DdaCYVrcBwxcVs0yoOe5rdK2FwOX05T3Mxheb5Br1wQQA43UdqCgMWGsSr
	D78EVgp1l3eIY4TBKB4IOrYoM+smXmgPpOcTWo3IJX2YHESgUvCQ==
X-Google-Smtp-Source: AGHT+IGmNG0QORIVMZZwCyXlvLv1OEbopqlBi2vfvnC7XF9+60W27KK2bGuEgGU3CvOiS1ZeJHZ7QA==
X-Received: by 2002:a05:6e02:2186:b0:42e:7273:a370 with SMTP id e9e14a558f8ab-42f87354820mr41303595ab.5.1759960744446;
        Wed, 08 Oct 2025 14:59:04 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with UTF8SMTPSA id 8926c6da1cb9f-57b5e9eba46sm7455008173.15.2025.10.08.14.59.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Oct 2025 14:59:04 -0700 (PDT)
Date: Wed, 8 Oct 2025 17:59:03 -0400
From: Taylor Blau <me@ttaylorr.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: Luca Milanesio <luca.milanesio@gmail.com>, git@vger.kernel.org
Subject: Re: When should we release Git 3.0?
Message-ID: <aObep4lUP8hcWXxG@nand.local>
References: <aNxivuJEnSHbQNdr@fruit.crustytoothpaste.net>
 <E03F997F-1738-4CF6-B7D5-206183FA5BD1@gmail.com>
 <aN1RFvz7uGPnepxe@nand.local>
 <aN5-n_ArhQqaQZgt@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aN5-n_ArhQqaQZgt@pks.im>

On Thu, Oct 02, 2025 at 03:31:11PM +0200, Patrick Steinhardt wrote:
> On Wed, Oct 01, 2025 at 12:04:38PM -0400, Taylor Blau wrote:
> > On Wed, Oct 01, 2025 at 08:13:12AM +0100, Luca Milanesio wrote:
> > > I am worried that if we rush into Git 3.0 with breaking changes that
> > > would make other “forges” (e.g. JGit) incompatible, we would be in a
> > > difficult situation with the other Git ecosystem that isn’t based on
> > > the C-Git implementation.
> >
> > That's a good point. I am not familiar enough with JGit (or really any
> > non-standard Git implementations) to know where SHA-256 support is in
> > those respective implementations.
> >
> > But regardless of whether we're talking about a forge that is based on
> > git.git or some other implementation, there is very likely lots of other
> > work to be done to support SHA-256 outside of flipping the hash function
> > within Git.
> >
> > (I'm thinking here about database migrations for columns that may store
> > 40-character SHA-1 hashes, for example, which can take a potentially
> > significant amount of time to migrate depending on the size of the
> > database, etc.)
> >
> > So my feeling here is that we should take into account not just the
> > readiness of the underlying Git implementation used by hosting providers
> > in the Git ecosystem, but also the readiness of the hosting providers
> > themselves to do the work necessary to facilitate that transition
> > outside of their Git implementation.
>
> We definitely should take into account the readiness. But what I think
> we'll need is a roadmap from impacted Git implementations and hosting
> providers so that we can answer the question when they plan to have
> SHA256 support ready.
>
> Without such a roadmap it's basically impossible for us to set up any
> realistic date. In that case, we only have one of two options:
>
>   - We just wait until eventually everyone has SHA256 support. This has
>     the effect that there is no pressure on anybody, and thus it is more
>     likely than not that it'll just never happen.
>
>   - We set a strict, "uninformed" deadline that may be too ambitious and
>     unrealistic.
>
> Once we have roadmaps, we should set a strict deadline that takes them
> into account. Any hosting provider or implementation of Git that doesn't
> provide a roadmap will not be taken into account in our planning.

I would imagine that the definition of "roadmap" here is fairly
lightweight, since I imagine that some organizations may not want to
share details beyond "we will have it done by X date".

I think I generally agree with you, but I would say that while I think
the project should take a firm stance on when it will release Git 3.0, I
do not think that we should entirely disregard the readiness of
forges/implementations by making the deadline so strict.

Thanks,
Taylor
