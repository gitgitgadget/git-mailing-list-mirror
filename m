Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28BD31C01
	for <git@vger.kernel.org>; Sun,  5 Oct 2025 14:11:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759673471; cv=none; b=RegrEzTjeCItwuBf1cCUuCESy5q1FvwLYquhtWxGF4hJ+UvTbJqYUaoHLUG0Q4/ChaugaOgX3v8l4gLPb9TAa5RW7z6tuHjs552v0QzxViJPy0YTw4odz4QYfTTxqHUrlULQT9inL9Mbb3q9fBZxGyXEmp38YWx5Z6LhgrRaMhc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759673471; c=relaxed/simple;
	bh=+ipeb7AmgFjoB6iT3060RnudL1+AXpyJnIHd7IsGlEM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JQLU70zDnUbAZrzTFsPNEv35tEZk+BxjL41gRP3sv2EmM+Au5YSv7+jAVsMGpzBVZVCi+hy2djafcjvgTERL98QmLTQcbdCsxAACl5rgEE5ASGm4MbhL4EcLFrRIkV5V+zaR8+Ve303HNtJDekr6/p1chwB0wzfxWJnIAj5a4Vo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ToHnShdu; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ToHnShdu"
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-7811a02316bso2794016b3a.3
        for <git@vger.kernel.org>; Sun, 05 Oct 2025 07:11:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759673469; x=1760278269; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=pBwxhSXKJ3E4289tR8PVgRlYfg1ynAXneAiUs2VWdW4=;
        b=ToHnShduJG2CqbkGPX/IAuYsHtnWpgDqAVeUAv3Tp72XrRFmHpwN/KlQ60l2sXIrJy
         T23vvwRn5eUK6m58JaSnr8rHR8p7Tiys08pUouKIHD0ig6/D8ZFT2daeW4V+ykxjY6QE
         T7uV4F4ZmHC6etTtrXRB6JZgzJgnjwIDJzo5RAPoYVc60pY8UqmD9N0T0+Is91EaFnSS
         qOqq069JuPYT1CbwreWxWEXMCIWKZ/HGMDGYeXvSnI7qUIMUpnJ8EoccQQYYULNMWEbo
         im3xVG62dwFQZxbeNZs3emtJXBDrJ2WZhR2PWDUC/fkD6WaFEOPqIoSCuV2ypMuWhD4e
         Ksrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759673469; x=1760278269;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pBwxhSXKJ3E4289tR8PVgRlYfg1ynAXneAiUs2VWdW4=;
        b=itd6+YiOdNcLvk7lX2OEfL+5ba30/K4J21/G8sdrSIF/bem0g8RDpq+Eb/MWAzlB5q
         9irrC24nx360ygpPybSJL/0JH+5qQtiW1gK4khWxNwgP/ZV/PLBaTbS7yKlcEqZp7PfR
         yfApaftVYwYgYRp54iprBW8EHCM5khjFW1hSrjfzHX5bU0uece0qDEWW3CsntEe+mmnj
         2y/sQooY72icida53wFQ8kTbwRmue55FjTOws//W1EOIQ1o8W4YRtILXEx/S42ZXX75j
         GBQyrR+OOwvwJ0nldioaYgXfltYUIAysPmGlRzO+tpmHc/5dhkAAF635D5GIPFZ988zH
         C0DQ==
X-Forwarded-Encrypted: i=1; AJvYcCV8pQ6NzxYYHjbutlp9Gy5Vjk0S7Bn4RWAwPwmf1tFCOsO7xovdQTl5x3k8jQR8YT7v4zM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyZqWfnUNV8iNkvRUXeNEnYgrL+zTK41JD238gTGcbBwdo1sySx
	1JYCUN+aBrCqKgK9WaigJNrtu8X0M9J8XdDjpyIbCGSZhg4A55AUlSaa
X-Gm-Gg: ASbGnctBptOW59gPpnYWZa8GvHGKHSa9fYuaQTVnCtQPnd+5dGBzt/mbt/47lX7069s
	aI0aPEQGNGvaiCZ9HvTiRv9eYKFlvHXeBHXoOedV8QiwFgwlnFzuNpkDJaqe4+eyY7rg/KDYOZB
	ZlimkKy+0qoKzgLNdEUfO9719VCJmsA5GOtUntQg55dF4fFOVYQvILFxQSnUGtM7FtfgtGjaU9a
	H0lWjUfz0iccyKMOl5XowJuRLq84MIQld9KiAvDdRfHTph+0pMtF/R7/SY9qlKFNQCQSNAstbN2
	vUwXHAr+MEN012S9djUTELdx9KEi/meJ9DVrq2b25rHVU+3K08UHRFBKHQkGOzxGEACPvLI2uc8
	psPeD8k1oG2YRidzD5ZrD5su03Ec2/D7SW4dacgMm/A==
X-Google-Smtp-Source: AGHT+IFfhooD0lm5VRRNymMcGQMmNFuXvI6jk4scKBkJJpppfThQ4h1+WAETGW64p6fpKfgfJSPnfw==
X-Received: by 2002:a05:6a00:b51:b0:781:645b:264d with SMTP id d2e1a72fcca58-78c98de3a29mr11018712b3a.25.1759673469283;
        Sun, 05 Oct 2025 07:11:09 -0700 (PDT)
Received: from localhost ([2605:52c0:1:4cf:6c5a:92ff:fe25:ceff])
        by smtp.gmail.com with UTF8SMTPSA id d2e1a72fcca58-78b01f9dadbsm10015773b3a.18.2025.10.05.07.11.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Oct 2025 07:11:08 -0700 (PDT)
Date: Sun, 5 Oct 2025 22:11:08 +0800
From: shejialuo <shejialuo@gmail.com>
To: Jeff King <peff@peff.net>
Cc: Junio C Hamano <gitster@pobox.com>,
	Karthik Nayak <karthik.188@gmail.com>, git@vger.kernel.org,
	Patrick Steinhardt <ps@pks.im>
Subject: Re: [PATCH v2 2/4] string-list: replace negative index encoding with
 "exact_match" parameter
Message-ID: <aOJ8fAZVQ8y1oMgR@ArchLinux>
References: <aMp8yNFiXDyk2hP4@ArchLinux>
 <aMp9OtXLfRw7dEwA@ArchLinux>
 <CAOLa=ZShms1D-cq=x04dtT2ULTVE3ZDo8DODFnJRP2wcJz0EgQ@mail.gmail.com>
 <xmqq348dovi3.fsf@gitster.g>
 <20250924053601.GC1173044@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250924053601.GC1173044@coredump.intra.peff.net>

On Wed, Sep 24, 2025 at 01:36:01AM -0400, Jeff King wrote:
> On Tue, Sep 23, 2025 at 11:48:36AM -0700, Junio C Hamano wrote:
> 
> > >> 1. It prevents us from using the full range of size_t, which is
> > >>    necessary for large string list.
> > 
> > It is a disease to think that countable things must be counted in
> > size_t and it needs to be somehow cured.
> > 
> > It is a type to count the size of memory allocations, nothing more.
> > If you are holding 1000-bytes per the stuff you are counting, you
> > would not need the full range of size_t --- you'll ran out your
> > memory way before you fill size_t with the things you are counting.
> > 
> > When there is no external constraints (like you need to specify
> > exact size to describe a file format to be interoperable), the most
> > appropriate type to count things in is a platform natural "int".
> > You wouldn't be handling billions of strings in string-list anyway
> > (and that is smaller than half of 32-bit size_t; 64-bit size_t is
> > much larger).
> 
> I agree that size_t is much more than one needs for counting most
> things. But the problem is that "int" is much too small, if you are
> worried about malicious input causing integer overflows that could cause
> memory access errors.
> 
> A nice property of counting everything as size_t is that if we are
> storing even a single byte per item, we will fail to allocate before
> hitting an integer overflow. So no, we do not expect to store billions
> of strings. But it is not that hard to convince Git to allocate billions
> of items in a list on a 64-bit system with 32-bit ints. And it is nice
> to know that iterating over them or trying to extend the array will
> never hit an integer overflow bug.
> 

Make sense.

> I'd say the "right" size for preventing overflows probably only needs to
> be 58-60 bits or so, since usually we are storing more than one byte
> (plus overhead). But 64-bit is the natural machine word size that
> matches what we want. However, we should _not_ be worried about losing
> one bit to making it signed, especially if that makes it less
> error-prone to convert instances of "int" to use "size_t". I would be
> surprised if an attacker could convince a program to truly use up half
> of its address space.
> 
> > >> 2. Using int for indices while other parts of the codebase use size_t
> > >>    creates signed comparison warnings when these values are compared.
> > 
> > The other thing may be (mis)using size_t when it should not be.  If
> > they were also using "int" that would also squelch the warnings from
> > "-Wsign-compare".
> 
> So I really care only about truncation and overflow above. Sign issues
> can cause bugs, of course, but the real issue is the size mismatch
> between "int" and "size_t". And while -Wsign-compare is sometimes an
> easy way to find those mismatches (because of the sign mismatch between
> them), it may bring more hassle than it's worth.
> 

That's right, I would improve my commit message to show the correct
motivation.

Thanks,
Jialuo
