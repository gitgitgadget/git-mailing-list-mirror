Received: from mail-yx1-f52.google.com (mail-yx1-f52.google.com [74.125.224.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7FFD31A81C
	for <git@vger.kernel.org>; Thu, 16 Apr 2026 20:29:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776371389; cv=none; b=Cz84j9AsXCYRM2uZyMOdFBiYs8pCrvpPdgWNCJk7vYvwxI0eZyLrZYOd035iyqYoKFvhnwzMG4iUcDvRkT/7LCgrCf8c98Iq7V/pJ+Rgwsqfnav7l9dd9CkTmo0VwQL/59acpxZNZNwd4QaMClt3pllyF57VK1D7ShJPxL2i/fs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776371389; c=relaxed/simple;
	bh=oymSH36VYn9HOdeR46PZxGOWp5EHfCGkAgdol4pXfus=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YJ86SRtfuO5EixyUT/eBm5cHHYnGMStUc+jp3/o6BYD8EfNsJS9wywApdiOcpJwr7B6QE5r92Jl5rINED15zSc7HcUYt7p0ylPsy1Cm1+MrGcThDH10wstf9zX0d41obCxOuVhJssB8dFcKHK9JyTLOLvFUA82xoLRbb6rh4RSM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b=jNAgGGD4; arc=none smtp.client-ip=74.125.224.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b="jNAgGGD4"
Received: by mail-yx1-f52.google.com with SMTP id 956f58d0204a3-651c3212b0bso3615d50.1
        for <git@vger.kernel.org>; Thu, 16 Apr 2026 13:29:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr.com; s=google; t=1776371388; x=1776976188; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=d8ZrvTvaDFUHMnjKfSduX48yOgQLUiUN/o2WpWrPnUM=;
        b=jNAgGGD44kDzbbcFd24zLNKpQcRXt+7/j8g+32bVLZRz8nNDlTml8ty0lj6HxPiChi
         P0XmvS4Nwfok2wjTQgvreK2wPAMPMwK5XXFUPZZSJjN6dkzjBbs2T5wWQswEet0Iy0rK
         BJ2vuqvcnbcPX4GN/vmNBsxLlKnCmrCbvJ7FTQTGbqP11voS0BCEhxknnbpdG3vbOHb9
         SYifhvvfgWhjyBoeZtl5vVIFvY9041OqSF+mtG1KBP75vI6kpiCfJDdtPQReGPK7f0Bw
         mzYNJFnhLNRnyyMQzX1sbo8ZKC/OY2WgIJv6SBfmtT1N2FmD5OnUVV00JqW8vLp0GzRH
         0aMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776371388; x=1776976188;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=d8ZrvTvaDFUHMnjKfSduX48yOgQLUiUN/o2WpWrPnUM=;
        b=MhUAXZSzULnyT7SzauyX59oKZwPLLNwCoUW/sNBh+Q29eGCcAPR82DaFZ7RZRvczcY
         aVB9eBPtITliWWr3ZI2RQDjNPDSwwHguv/UkswIfNuA87hZxbStJyJp54tWkus7cBpy1
         jjGHMF0G72iSGXawvw17UYRG5k4MtVjmlgXNQbGs+6Zz+402/Ou8UHvUq0+1fdCgZ8ae
         iqT6Ym3xhL+29va3R2tojV7BiH6Lo2CWRxrQh82SyCQzYlSAYYd2YUsvr9eKTo3nnoGz
         R3WnVSvCUR5jeOPmvbstgkH90hF/YW6i6235Z50aTm8o75tQLMBcbpwDrWFuWWeX5+GZ
         8+RA==
X-Forwarded-Encrypted: i=1; AFNElJ9Q5iSug7Oqf1L3ju0wnm+hrvGTcWNSQl9qJQ8kyAg0fMNP++c4WpanUDn5b7TK99matG0=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywdad1WoaHiKwaa5yvPZmOBhq34DFFf8088tteg2K6R2CjcGrOe
	SfU+d7apeoK/m2Q/sXhcXAfTujNb0JgHjA/+4otnGCDyvyBU8IWi50WtuncQE7MufF8mIpg1lYi
	5LXoGQUY=
X-Gm-Gg: AeBDieuqZ4YF1dCfABReZoUZF9KwssnXlzzXPq7F3AEbadXjhka0L3E9PVNVDZt9Vjd
	mXaBDumqUeCTQ/BQQeE6157LNeSfsb3E9SQj+wvulJRKGfMcbqJ0tFWPONDXwbjc/4Tog6Kb1J7
	MqurPYj8DVXsqRY0NSArZwKjNT5ynKdlcgEARsycPks2/VK1Ozikilt7KBhulnhF5WqdQOHVZlH
	Ho34adUQ1Xhw80i9ncx9gTzAGmF+Hb8es7tKl72PkI59SIEwWVIArMCyubaQhSZ6CAK3aQbTKta
	vmAn63uhSfjTe/rrBZ7hRr2RV/KIfLLHDiLU15kF4QNk9doXSPuOX/GdF3K94Kgm2XdjYgWWj6D
	9ZqhULUX7aKECm/YYkwp8HKMiBRPsfMBkygR4Zo5Da9I45CPJ1Y6YTcjIe/gKFtd41ZMRPyenbB
	Kf+8rNrCnXVdnxDYGx6y2ExlP8V7z8C/C+WTE6OXPWopSIOJmpEff8gOxlHnIPqaFntXM/36TOX
	wwy+d5ysGL58sxtlWnfArNX6LyKwOAevUp2TAUEV1bqOsdT7C0Fx3ZL/r/WUi21yKA1XbqSF/wP
	faEhWpjpzxjxpcjm/uNIgoGb+Mk=
X-Received: by 2002:a05:690e:484b:b0:650:314f:1108 with SMTP id 956f58d0204a3-65310b0450fmr87908d50.59.1776371387645;
        Thu, 16 Apr 2026 13:29:47 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-652e472492dsm2461142d50.12.2026.04.16.13.29.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Apr 2026 13:29:47 -0700 (PDT)
Date: Thu, 16 Apr 2026 16:29:46 -0400
From: Taylor Blau <me@ttaylorr.com>
To: Junio C Hamano <gitster@pobox.com>
Cc: Derrick Stolee <stolee@gmail.com>, Jeff King <peff@peff.net>,
	git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: MIDX woes, was Re: [ANNOUNCE] Git v2.54.0-rc2
Message-ID: <aeFGumIlw+vcOt2a@nand.local>
References: <xmqqqzohd0sh.fsf@gitster.g>
 <8c1def10-9039-aecd-4ce4-fb4676b47e9b@gmx.de>
 <xmqq5x5s540j.fsf@gitster.g>
 <20260416051732.GA48541@coredump.intra.peff.net>
 <20260416053435.GA646718@coredump.intra.peff.net>
 <621c9da9-2ec0-462d-ae51-0be5e0ca6ab2@gmail.com>
 <xmqqik9q3n15.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqik9q3n15.fsf@gitster.g>

On Thu, Apr 16, 2026 at 09:09:10AM -0700, Junio C Hamano wrote:
> > The part that is striking about Johannes' report is that this happens
> > on a fetch, so it is being written automatically by normal maintenance
> > activities in that case. Without downgrading the default version back
> > to a compatible version, deleting the multi-pack-index(es) will not
> > keep the repo in a good state.
>
> I am not sure what you mean by "deleting will not keep the
> repository in a good state".  Isn't multi-pack-index totall
> optional?

I am also having trouble following this.

Is this saying that fetching from a remote and having a local `git
maintenance` (run automatically after `git fetch`) write a v2 MIDX file
which is unable to be read by a separate local Git is causing the
problem?

If so, then I think we are operating in a mixed-version environment
where some newer Git that understands the v2 format is writing it, and
another older Git version that doesn't is trying to read an unknown
version.

Though I find it totally plausible that I am wildly misunderstanding
what happened for Johannes here, so please let me know if I'm not seeing
it.

Thanks,
Taylor
