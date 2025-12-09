Received: from mail-yx1-f50.google.com (mail-yx1-f50.google.com [74.125.224.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 064E3280A5B
	for <git@vger.kernel.org>; Tue,  9 Dec 2025 02:11:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765246296; cv=none; b=baolCJDr8XOLz+zv6AShjuG/5GKZAwU/UMChrta9a72PG3acRV/0oW35xD/2tT66Iv0HMIGjRllJiryWKfcjqBCLT5hnAtEDtKvU7qnl9F/kziZaNSVgrW6BkO7KBRp0sDWB2yYLldy9P9gNdBKUKYtwK2yQnQkx/PXbf03Hp/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765246296; c=relaxed/simple;
	bh=BE8nt5yX5l9+lUpwElGMj68bpcveCgwb9xglSZlZRNA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=U8pWaYea0PDDWjMoXtt/A50M69TGOSaNfe1/W61bXhcIDaI9d0+bS95FRQTTYB4GefUMC9WgVJn4YS7J1NdfHTRT8Qyx+/cshlY/CE3z+sVOSIyzYnKQKrUtVsyFRupEy4alNQUN46s0pu9azmlNmMaN+4kNd370uLe68LxA1aU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b=TeDspHAw; arc=none smtp.client-ip=74.125.224.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b="TeDspHAw"
Received: by mail-yx1-f50.google.com with SMTP id 956f58d0204a3-641e4744e59so4976172d50.2
        for <git@vger.kernel.org>; Mon, 08 Dec 2025 18:11:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr.com; s=google; t=1765246294; x=1765851094; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=BE8nt5yX5l9+lUpwElGMj68bpcveCgwb9xglSZlZRNA=;
        b=TeDspHAwj/VntURZt79KeTRcFVhFdXx0yDywgpPfXOSAXnrGprJmeKi8nlU0IdYdfw
         LEa64pgpnwsE9hOLNDL11AGdwoI0P0VadfOcwAFavUcRNRSO3LZ/zw++BLNJQ6AfMaNz
         9Q6Fvf0f8BIqjEc3+Esl0CoxqcOImLmf2wSl0j4TJd9KnTR5C2EjuKP3wHxRCVgsWGPc
         qeMGdfLiw/ar0xkZhExk5NU1sh2C8tjA5bPzoeTzblTp8vtRwBAgSQayAYVcX0vKXdJ3
         nEjKGBZ0+toF/Bo1N8WW2/hmUYNJYCASWdhgBPYFp9KT3aI8LFy0JZ4UjILDuRg5KHoo
         sMWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765246294; x=1765851094;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BE8nt5yX5l9+lUpwElGMj68bpcveCgwb9xglSZlZRNA=;
        b=g0VkHE6WIgjF3sAhsq3B7rwKdfrgmcM7Z6JCrkG8S3wtEP+zFRyVkZyNo8PMY8itC0
         Fwr6b13Cv0J/N+mtf+D5hOsFW0JbUHKCg5a7lcwNUDjw3kiQvFycY/1oTlLd/ZOytS3R
         YbcNjuk01MkBo1bYi+kaoA9FrnHiuupb415MhyojoF8g/tPsUII9c5d7kEW+fOJpz5CF
         TSvjitcH0NcvIpAInsXRn6DisRJiIewLvdLgi4NJkFO3UHFqR5ozVeF6JPLOhSs6lf/+
         KRS7JrfvM52CyBRS5KBWaRbn9y0LpgQRQ4wAga1floynsKdqL6s5uaRz/GlCiXFqCgCx
         W7MQ==
X-Gm-Message-State: AOJu0Ywgp/wZxj11atEtaUGzfD5PBZwlQLXVDF7XAyc93MdfsqC6vzjX
	PpkzXoOYC98G9TjQqb/BfvwQWAVlFfp60AK3gR81lZEN0qN4bmLXK1mnLOpyWSZ4gCw=
X-Gm-Gg: AY/fxX7YoNcE5V1g0byey9KDlHeApIWtZ+vEJJUpaYdRaIO2hvPEUaFOgtGKKnuNepr
	CDnRtR6d99Xx6LKEWaGPPR9K9CWOVjxjuCOiJfLONLcCgZybWNCL2pH5Sd2TUCuy/SJMAUCVsLs
	tc02hYYbnTQiXyJrrTCuPJNY6swGKlyV/6RBSeBGStH2xBJ5APbpOevuwkc79KVEczdjUwUmhb0
	e1pGSsRYDWnsJ6gj3DyTH/IJ2MSxBY+Fu1u6zk3v4pR0rQDHreRtZ4zvaRMh9o1DJGJYZpUsJzC
	97tSmQKUtCCJvNSPToz67xXAxmNCPhQ1k8GXeM7YXEaQejfudxFk9mvCCj47VeXDRU9+ervTj9F
	Ex86Ucm6FK1zlvioGMjB3yaErDiGZrL5xC2fiEzgtzM0/R3+Ea/8g/R/0/smARkevkleuaWNA+E
	uu11hjgw+mgAsQMPkQ444+7uKcDZYTlMuH1H/N3Sb5OwhveLPGB+9XCEAWOT0ojkCREXJVkuUQt
	/vBTjwQBUVXLYq/Q3CBK8QlCGmu
X-Google-Smtp-Source: AGHT+IEZRnhsPPUjUpoHOWSV849eHDxMSUJdDqnrX9xBUfsS2IHrDJw3AnGCaYYO+wIiuTrPlxdmBA==
X-Received: by 2002:a05:690e:15d0:b0:63f:ad90:ad6e with SMTP id 956f58d0204a3-6444e7bd873mr6244944d50.64.1765246293943;
        Mon, 08 Dec 2025 18:11:33 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with UTF8SMTPSA id 00721157ae682-78c2f0aaf83sm39729347b3.32.2025.12.08.18.11.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Dec 2025 18:11:33 -0800 (PST)
Date: Mon, 8 Dec 2025 21:11:32 -0500
From: Taylor Blau <me@ttaylorr.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Elijah Newren <newren@gmail.com>,
	Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 09/17] midx: do not require packs to be sorted in
 lexicographic order
Message-ID: <aTeFVDGo69ljiQP9@nand.local>
References: <cover.1765053054.git.me@ttaylorr.com>
 <d5389a93b16a4933b0c54f78f2d5ce84b9ecac53.1765053054.git.me@ttaylorr.com>
 <aTcYbRt-aUIcym77@pks.im>
 <aTeEZX4036A9YecX@nand.local>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <aTeEZX4036A9YecX@nand.local>

On Mon, Dec 08, 2025 at 09:07:33PM -0500, Taylor Blau wrote:
> On Mon, Dec 08, 2025 at 07:26:53PM +0100, Patrick Steinhardt wrote:
> > On Sat, Dec 06, 2025 at 03:31:25PM -0500, Taylor Blau wrote:
> > > Note that this produces MIDXs which may be incompatible with earlier
> > > versions of Git that have stricter requirements on the layout of packs
> > > within a MIDX. This patch does *not* modify the version number of the
> > > MIDX format, since existing versions of Git already know to gracefully
> > > ignore a MIDX with packs that appear out-of-order.
> >
> > Interesting. Did you verify how other implementations of Git behave if
> > we start to relax this requirement? It seems like a somewhat dangerous
> > assumption to me that this will just continue to work.
>
> That's a great point. It looks like current libgit2 assumes[1] that the
> list is sorted and complains loudly if it is not. Presumably other
> implementations behave similarly.
>
> I think that is a compelling enough argument to swing us towards
> bumping the version number to avoid compatibility issues.

I had another thought about how we might work around this without
forcing a compatibility issue, but it's a non-starter. I wanted to share
it on the list for posterity regardless.

I was going to add that we could instead consider adding a new chunk to
the MIDX format that lists the pack names in the order that they should
appear in the pseudo-pack order. Absent of that chunk, the pseudo-pack
order would be defined by the lexicographic order of pack names. If the
chunk exists, it would supersede that ordering.

But that just kicks the can down the road, since implementations like
libgit2 would think that they could read a *.midx file, but then they'd
produce all sorts of errors when trying to read its corresponding
*.bitmap file by permuting its bits out-of-order.

(I'm not sure off-hand whether or not libgit2 supports reading MIDX
bitmaps to begin with. Regardless, we should not introduce the
possibility for such a breakage in clients that *do* support reading
MIDX bitmaps, whether or not libgit2 is such a client.)

Thanks,
Taylor
