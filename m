Received: from mail-yb1-f170.google.com (mail-yb1-f170.google.com [209.85.219.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3409F125B9
	for <git@vger.kernel.org>; Wed, 16 Oct 2024 22:11:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729116712; cv=none; b=T6prd1ilN9BMyM6kwxpx7JoMhuHlmC05gaZ4vVxR/EGqMAWEYYauVOP2kB+z1igq4RGvaRmP5tYFtQrylXF117bnZWtV0xcj6XNhuOgaz3dhSa4Qzz86QOxGv3kmaADPxyDK0StOQ+DZtWbXFlpre8HA7K7vDPYHkVxeFWRB3Kk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729116712; c=relaxed/simple;
	bh=aDF4WwYeuuqump+i69/0KkKluHm5cIWcnrr+DQaYWKI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OQbPI814O9DVRk6FMzqB4PPHBEnh/d460psz0Q1D+mpAmgma8SyZptw9Hgp2UPETnQKPehppA2HgninlLji4gIrYYmSl0YoZfA8eGwIpZJV+LgmXYxVa78Rk05S8W66AfkL6/Cyo/JRWjuM8Z7+yPFJyltu2Tqf2qvCLaM2wew0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=iALmFWuJ; arc=none smtp.client-ip=209.85.219.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="iALmFWuJ"
Received: by mail-yb1-f170.google.com with SMTP id 3f1490d57ef6-e28e4451e0bso300720276.0
        for <git@vger.kernel.org>; Wed, 16 Oct 2024 15:11:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1729116710; x=1729721510; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=4EYPVkwmb60URDe/lmFP+FCFLOhfryOG7iu/3sg0YcA=;
        b=iALmFWuJOl4RphOW8HZLSawcwD0wo/kp22OiTSPyH7Cu6E1ef8AJYEh71NHDEAJV0q
         TYfWQ0HKpNSwvIlhauqSeZTcuj4Uu5fQ8v+wby/3ZazI7hz95QzfsE9RdHIBIPkBKKl8
         W8uDVL78tGOYTUHHnIAgptssTpJ+BGtFCqvZTGPV8hKptSXn3wmJVKUItg8VNtoZjqhg
         UxucnGX3dPvyJ3dSRaP/EXw1XHdFSAXE7sevYI9niUTsSIJ1IO26lCzJibcD5wbdnWqd
         a3ZoTCmTUtMbB16v5Fj+4fiqpw0MN6CxumxeB50irDJMr3ezioCfagHk9Dyes9RJnw1x
         bgwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729116710; x=1729721510;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4EYPVkwmb60URDe/lmFP+FCFLOhfryOG7iu/3sg0YcA=;
        b=TW6S2eXYEBtFsJng0pSOTGv1hdn/inx64Ehd706LKvXdT81zTJ7LwwBKUOFd1Uc5CE
         satWL8e6mJmi98zbgQceyV9hABQbEYLkt9JtPgyChRSTrRmkT+ZAUER+3RGWkPumv3Of
         UJ2llm5FPZdjCXDbr3C3cZFptahRJbVj9RiHLmhlJQueWu9Gww6dMksaZErAG2P5yNvO
         EkMkplAPKE1Rht7x7F+yCJIXsEQFrio+gCrxUP6VEXVUo023P2k5cdvSTD/d/bUpsYJX
         xPCD/lQ4fY6WWnb4UJ5kRawjK1htMnnbK0MwdN/n5+ZJER6XQ/cAtQeANmJtGm/ym+/8
         pcDA==
X-Gm-Message-State: AOJu0YzGJw5WaN8Ot+fmR3B5M/oqYQWnNEsrqYJNfis8VGmvRLy3Kn0D
	DPxe1yxBD1UUpe/CCM5hGzNG/Ro7sqAw86jNspxkcwwKkOA8Bf90VRLmkaQlkmI=
X-Google-Smtp-Source: AGHT+IEhQInMxr5VeITtcq/Urvdr4WDdiApWMTBcAkLyrGxl6lYXJUkOMxHJxGrv+xKshsB3NjD26w==
X-Received: by 2002:a05:690c:3502:b0:6e2:aa89:9d0 with SMTP id 00721157ae682-6e3d409b3e0mr64013337b3.10.1729116710233;
        Wed, 16 Oct 2024 15:11:50 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6e3c6a76e21sm8700777b3.41.2024.10.16.15.11.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Oct 2024 15:11:49 -0700 (PDT)
Date: Wed, 16 Oct 2024 18:11:47 -0400
From: Taylor Blau <me@ttaylorr.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Victoria Dye <vdye@github.com>,
	Derrick Stolee <stolee@gmail.com>
Subject: Re: [PATCH] ref-filter: format iteratively with lexicographic
 refname sorting
Message-ID: <ZxA6I67FfPe4fV2F@nand.local>
References: <a873ed828ccae426214cc8f87610df97ff9a269e.1729055871.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <a873ed828ccae426214cc8f87610df97ff9a269e.1729055871.git.ps@pks.im>

On Wed, Oct 16, 2024 at 08:00:30AM +0200, Patrick Steinhardt wrote:
> But there is one exception here where we _can_ get away with sorting
> refs while streaming: ref backends sort references returned by their
> iterators in lexicographic order. So if the following conditions are all
> true we can do iterative streaming:
>
>   - The caller uses at most a single name pattern. Otherwise we'd have
>     to sort results from multiple invocations of the iterator.
>
>   - There must be at most a single sorting specification, as otherwise
>     we're not using plain lexicographic ordering.
>
>   - The sorting specification must use the "refname".
>
>   - The sorting specification must not be using any flags, like
>     case-insensitive sorting.

Perhaps a niche case, but what about ancient packed-refs files that were
written before the 'sorted' capability was introduced?

Thanks,
Taylor
