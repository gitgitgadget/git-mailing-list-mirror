Received: from mail-ot1-f46.google.com (mail-ot1-f46.google.com [209.85.210.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7ABCA4087C
	for <git@vger.kernel.org>; Thu,  1 Aug 2024 20:39:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722544753; cv=none; b=Tqh1NpLe15BeoGW6z6UkyRoteiavolHjg+jaB0aJe8DlAueYr5jFa5EMz5ZD1xl+r0GorLNrHD4RusuQDDgDrwrea+Mj+h7jDOS7i4lPyHc2puCzZTLwATES2Vm8cMDuIdeb3lghLfkzgXXH8VK3fducTgDsCQ5HQhQIMiQLykQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722544753; c=relaxed/simple;
	bh=66kg3jo6WQXdACAMm/0tSn88y02NgGIL8IKBHpHtGKc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cl7P46WIuzQtN38S4E5GQPVsxXQNTSsNvg022iNCBhYY6+UR86UZ2rJVK+bR02KiHJFP6p1TWGCztPPxO42ekd0yiI5vas5FNA0aYFEokK1ymctlfJrXzgp80T0eAGOBOcuVh3se3e2UQvo0MU2hj6rM+UFxatFCUu2jqg7U3D8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=none smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=AMhHa3jq; arc=none smtp.client-ip=209.85.210.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="AMhHa3jq"
Received: by mail-ot1-f46.google.com with SMTP id 46e09a7af769-70942ebcc29so4490224a34.0
        for <git@vger.kernel.org>; Thu, 01 Aug 2024 13:39:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1722544751; x=1723149551; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=B1HyHu78uv9tKC/MjneaaX2ssF0OCPkbKKPXedfabYc=;
        b=AMhHa3jq4xwwcQ+BM9kCWOPd3seGhDn6fnQMSSBvACr7TFB4etFJGgMSWDDGbbemmM
         VqywdWFw9AldmUmK8EeMIpfxWecYSU2ddx2cjMiLLlIBOP0iqIkhAakSHF8l9nw09DWM
         O6J2vbcCCStci+xB9YjhK73i4W/xatScLb4Jy9SVxjYWHvr3aB1P23tmbpsX+8NALWJs
         LVfFdohwnaSc/Rmc+R68lsTc48NyC9hxHeBRR1hXdLL0Rq1rVr903lHYXgpE8iVNc2PG
         BEDtyt25SBIxTswJSecaKQyscXC92ZCRCD9OLg8RQB/hDqzpRZ+tTZ+I5RU1ueWcsXfg
         ROAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722544751; x=1723149551;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=B1HyHu78uv9tKC/MjneaaX2ssF0OCPkbKKPXedfabYc=;
        b=OUWmntvNRtBjorofDh7De7/0dq84FcXGyPxru864EqGuxTCSgp8p7E8jizQ8vlYP7h
         s0QQq2tIsPWO3Xt3swhvyQx6aktGg65RKLuuMjsp8lAyRE67T9ACQrt8Z9UH/xHCTsVq
         aqwDuVZAzE3QiR4BB7qxEe5hkC5HKv8Y2hGZmHGv03jZ7pqNabDnSz8CtmaBcOsyo2ct
         Hbm+o9kKR3iHDS3QAVR7AGWBe6z9FSzH6J5C/SEl/PL47k/2ZLz7zAbMQES7/wUVF66c
         LqgDvIQPMyAM+oB6avOjCyR5r5Kc8lu0E9pJnYvPZuGy82CsbqRoEpB54u5iw0Ve606G
         h6MA==
X-Gm-Message-State: AOJu0YwtJ4nIxsCAccz8EW2vodRd0VrEfArsMdv5KKZWHRJi8ia6PmOp
	jIiMS0jVoJl92EgY96FjBNnCNXVCSiI/qJFKxHOLzNYm0EO/Lkm3xBvOlMzDmUY=
X-Google-Smtp-Source: AGHT+IHBe6KxSm8OTJEhXzZ+kepqzhXv2nBcvSsrkhd/pA4ho8xWCe4wC0m0JK+dPefWGlDLRokMjw==
X-Received: by 2002:a05:6358:c117:b0:1ad:d2a:75ea with SMTP id e5c5f4694b2df-1af3bad7725mr101311455d.14.1722544751566;
        Thu, 01 Aug 2024 13:39:11 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6bb9c76b88esm417076d6.5.2024.08.01.13.39.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Aug 2024 13:39:11 -0700 (PDT)
Date: Thu, 1 Aug 2024 16:39:10 -0400
From: Taylor Blau <me@ttaylorr.com>
To: Jeff King <peff@peff.net>
Cc: git@vger.kernel.org, Elijah Newren <newren@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 19/19] midx: implement support for writing incremental
 MIDX chains
Message-ID: <ZqvybqlvW/wcKV5g@nand.local>
References: <cover.1717715060.git.me@ttaylorr.com>
 <cover.1721250704.git.me@ttaylorr.com>
 <e2b5961b4556122e594b657efe2f1d3337368cdd.1721250704.git.me@ttaylorr.com>
 <20240801110722.GR1159276@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240801110722.GR1159276@coredump.intra.peff.net>

On Thu, Aug 01, 2024 at 07:07:22AM -0400, Jeff King wrote:
> > The tests explicitly exercising the new incremental MIDX feature are
> > relatively limited for two reasons:
> >
> >   1. Most of the "interesting" behavior is already thoroughly covered in
> >      t5319-multi-pack-index.sh, which handles the core logic of reading
> >      objects through a MIDX.
> >
> >      The new tests in t5334-incremental-multi-pack-index.sh are mostly
> >      focused on creating and destroying incremental MIDXs, as well as
> >      stitching their results together across layers.
>
> Do you mean here that t5319 will get coverage when
> GIT_TEST_MULTI_PACK_INDEX_WRITE_INCREMENTAL is set? In the long run, I
> wonder if we should pull t5319's tests into lib-midx.sh and run them in
> incremental and non-incremental modes.

I don't know. Part of me thinks that that would be a good idea, but part
of me also thinks that it would be (a) painful (since many of those
tests assume that exactly one MIDX exists in the repository
before/during/after each test), and (b) not particularly useful (since
much of the interesting behavior occurs when multiple MIDXs contain
packs with overlapping objects, see (a)).

Thanks,
Taylor
