Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89B2D18E1A
	for <git@vger.kernel.org>; Sat, 12 Oct 2024 15:58:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728748716; cv=none; b=ZxfEaGMBdnl8nlwBM1WzF53o3G9ZkZxznr7/FpPMGWnbq7C8NC7nmL8uYh+oyCXjDvk80NP0hDVC3zbLelz5X2dkkJhhL/EwOXfdCUZtY2WxtHLGvINkTsUxz2G/uXlOxW5kf0TwP2iV3d+QYyNKsFMkk9G/vvuv23PE1tQ+CZw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728748716; c=relaxed/simple;
	bh=1UrVwSoXG/3sw8g/N7hpk5RLQk1lwFqLUbnWpBsJ/Yc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=a4PCb0oA46KpYIfcRrbKXZqhyLOyo/Tz+74Hqgt2EjQJ/ZZcPpVAinyYvcegCGvdPCmaKNTN7rxr8w9aUA8928Vbb7rlxkr+q8CCDwsZ6WGLQuCoSO3rgCIvh387lnJGSc3QraG1+pJJV2w2P2uWNM50z871sxZgCoYpCVSmOU8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=Zj4B9TvA; arc=none smtp.client-ip=209.85.128.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="Zj4B9TvA"
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-6dbb24ee34dso25744877b3.2
        for <git@vger.kernel.org>; Sat, 12 Oct 2024 08:58:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1728748713; x=1729353513; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=9tWHYciC8n2ZFuwjCoSy9xupL1wAK5Nupk2vcaVz+Ns=;
        b=Zj4B9TvAsoJC2JXpzQdY4d5Bp3MW6TGGNu4fBXe6ftPDtF9zx+DoYJvFxNqsoexQt3
         Su+LhnfwB/ZxSIpK+pnU1Cy+2giLLdnvHS1J0qbJzYeHCvKFTkrvkAcOWNFt9vti6fAJ
         WjuEp3Js5VpBAbTtlhN9wgTkAFz84F2hjsFVY8ULmbx4eZ7PzwOOBxY6ZNr+D2CgrAZs
         viMOMTRsBrxV7SnlNB90pSRgcmkzBXh0OTtpbHyRagUmYOZJxqcUPJo7KuQVFsVLrY8w
         Q3/MtzOTd8GY5ykEyMxcCwlc1Ljbed8Sy2pBO96OOOLs8Dx9EeQgFzDmTCu5u1lZSTe0
         Yfvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728748713; x=1729353513;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9tWHYciC8n2ZFuwjCoSy9xupL1wAK5Nupk2vcaVz+Ns=;
        b=BS/EIZ+FLkHHwGORA3FKLD2hpqmUxWvf6GCqJh35/pXt+L1ufDzVVGqtv0ZjyXdWsm
         devPPaHWafuWxh4gnxujnysynw7owO5AvOrpIUExrgW6k6iam2o1vNCV2dCob0+rK9up
         +anlBpzKo6IwkTMOdZZej2xVJO7FHGzvz2ZF+LKru9KekZg5eovBg49sS9yveaNs9pou
         /wgyjTq3fGcl6yDQxglV/XN0Vc1tQfZExoqNXn02iKbGe+g2CJ3ADP+1PI7PDTv60gGw
         UkLWuCmg8zFmVwy0ka3CuRtK9ijQ43p+FU6+3hN5NxGYL4VWYBWyNRvNuk/fQR8iGTxH
         TPtw==
X-Forwarded-Encrypted: i=1; AJvYcCXTDslgDLmOo0lPnpA/QyZgO0g71lGZ0B8cOrSRtnGkxGDuAYKrZF1wbtPw3hCjXoMHxNM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yytwp/XTncpkQkPq+soxfYfr0zLOaYS72NJvwWdh+ybgAQKz434
	OFYa018KGhUGyRiDPu3mqtJ0EuKYoc1M2mOvXgVM95dRgpMa4JbKUhCnb///sXklKtuV/nYQPCR
	u
X-Google-Smtp-Source: AGHT+IHJ32LwN3R3nwdqCyIh8y7uYOPVEW5yh0mwvOWLQ+TjD7WPY4XJb/VaB1Muqs1TNcVmX8sVVA==
X-Received: by 2002:a05:690c:fc6:b0:6e3:178d:1873 with SMTP id 00721157ae682-6e347b2d88fmr50094597b3.33.1728748713509;
        Sat, 12 Oct 2024 08:58:33 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6e332bad6dasm9922017b3.73.2024.10.12.08.58.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 12 Oct 2024 08:58:33 -0700 (PDT)
Date: Sat, 12 Oct 2024 11:58:32 -0400
From: Taylor Blau <me@ttaylorr.com>
To: Junio C Hamano <gitster@pobox.com>
Cc: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org,
	Eli Schwartz <eschwartz@gentoo.org>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Phillip Wood <phillip.wood123@gmail.com>
Subject: Re: [RFC PATCH v2 00/24] Modernize our build system
Message-ID: <ZwqcqOsDspDwUAqZ@nand.local>
References: <cover.1727881164.git.ps@pks.im>
 <cover.1728485139.git.ps@pks.im>
 <xmqqh69i9ivd.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqh69i9ivd.fsf@gitster.g>

On Fri, Oct 11, 2024 at 07:04:38PM -0700, Junio C Hamano wrote:
> Patrick Steinhardt <ps@pks.im> writes:
>
> > this is the second version of the patch series that modernizes our build
> > system by introducing Meson. This series is still in an RFC state.
>
> I'll keep it in the broken-out repository (https://github.com/gitster/git)
> but eject it out of 'seen' for now.  Builds with the topic seem to
> be unhappy with circular dependency,

I'll do the same for now. The latest version of the topic is in my tree
as ps/build, and I'll keep it there until we can integrate it into
'seen' without breakage.

> cf. https://github.com/git/git/actions/runs/11299216196

Thanks,
Taylor
