Received: from fhigh-a2-smtp.messagingengine.com (fhigh-a2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA4355013AB
	for <git@vger.kernel.org>; Wed, 30 Sep 2026 14:46:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790779576; cv=none; b=TQIiWQJahbTiRp9GoUt5n+eJWImac1WcYZUTsgbMF8j/JUcIkXuHWZOVlRhRXPVJK6wl9h1XXKj1sGm0hUizUjSYdn43uRLnbm6kGKeWwo9onPzpNXZk4zax0F+U7nnpLydo1EZRPs7YSFTfPxEYNNW7FbcM6pJ8RyeTy7Rv0LU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790779576; c=relaxed/simple;
	bh=9IYa9TiUy78wHPXixD84UkpHq9PSjwB3JDRscOFjmhE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Hh91JtJ9FK3ybcF66JTGyJDmxIGYOBQBDHE6RMvk5RgJljwnAufyrFI6jta+Z/o86fSwT0toLn5WDdNM3GXXopfEFJWQa4nwLGRQq/NQpAMaWHtfm3PdqGA6yr1RkjyxIk/wig3FFoFynCApCK8adUM7zPsn2W/GDxtM+HYFAJ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=szAFNVyd; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=fO+Z2TOx; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="szAFNVyd";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="fO+Z2TOx"
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 94DBC1400231;
	Wed, 30 Sep 2026 10:45:55 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-09.internal (MEProxy); Wed, 30 Sep 2026 10:45:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1790779555; x=1790865955; bh=y08bnbUM+7
	FAecA9zpzo9MZmRefzn6cyUmU7h5bSCI0=; b=szAFNVydirO2hfpJIMsQKnLzfm
	YNEhIXlDgG1tXdF/V5MTxubUQjUV3RPXfVebcSyHOEAO8EtPC18z8BIyGPQSdiom
	qnAHYu1+xyBAyU46IgwX0eeCORfT0stfEHx+CEyNnfo011gCiQB+oVjCVPtXzUcx
	Tl7XDXzDYPT5RGErFZC0HPUhbqXj9yUWVJCDonuELhHLjHHVeU2icy8Wk5v2WUTv
	zoDhcdSWAqNeWCuNsd5aM4HJ5me4vlMiQXuDZvLKBLMRpSbKwf/tDFUykuu0MrkH
	4zcJ/9u8LSDwPzu5d2bYY9cHp4ZO5K8KBG0vYVNCE48mP2K7AluTERFyhGDg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1790779555; x=1790865955; bh=y08bnbUM+7FAecA9zpzo9MZmRefzn6cyUmU
	7h5bSCI0=; b=fO+Z2TOxXHOsoflVMGyVKc2KeYmkadMmoHtXdQd6vmKYfmazWZp
	NAjoGvUmOVaGdlaatzbJa3KhLc6MmXt6NssUlpfzt1KRW/b8vVHDmFdwxAJmb1ez
	Zup4zoqhsENXYXxXKcLdPFLknMVsoHNWxz8f0iqbWLgIeAQ5kZ4n+2wjMCbaEN79
	MDmNHZIkTiC6y16hpn3vUA4AeznKWZt7v6wVinUjH/dPf9s9KI5+QodDbC2tf1sH
	u1oKQj9+a/HppFP0hklEDLWqzIV5ShSqhZhYX5pFwiY7+t99ic8yGUQmwR1cVZIR
	nKh3HrHAQXanxyFnaArujMfeEZtKD97NhGw==
X-ME-Sender: <xms:oyC9akTqE3P1VOTgneBuAgjt-o2cUplnusxIjec3xMlT_DRDfO94Tw>
    <xme:oyC9aoyX0jW_Qg6id-EhnhaZvB-FymlcQARHInafzTlhJ9pYPDuujET066MIVbPsd
    U-n6V-x9r7wvtfSpLfYUGHt_yIsfpiOLPqymNNklHdPqR5EBgc190g>
X-ME-Received: <xmr:oyC9am1czKnrhOSLRGTiQHUCxcpaN_lTV-VmWdHFBWuNTHbGEeLGlQ>
X-ME-Proxy-Cause: dmFkZTFDx5j7ASUHAV9rerQlG4lhW0XE1LQN8DLDGscKimK3YF0Ru2sA4mHVCTDHwx5d2f
    N/rLiA6DcNXCyAJbjXlqqSZaI6eMFy6lNcCnaNXO7HJLc5qkGY3tRobUphfQinOkYZegED
    ePUemaQ3zW/ZpVPytC3yPo0+A0N1T+y6/u/pHEIw6GyNSVOGmVpK3DwJ9GkV32xDvkXXDh
    uWJVY0Ip1pkU4b9B4nhnLFa+fpB+8dNpOj+sFfoMpSxTVIJgQwglWMXVaGmb/qOaOHIgoK
    Yb6HYFTDJIHT1XA0Ng1fy1wN8wNH61UuWeOHGWYrYDlq46rhf/5FPcER9JY21D0bcMZbCM
    H0ttUd5BzbBnHPLe9XJz2HX6nFpz0ad72ROhtJc0WYcqympDf446olwNypXaTAQsKNoixB
    fDqxjoYnpiIV9Lz8yX0h+RxcUya7MzqfRdlsqnaT+uMouk8ezSrZ15kTulLFNncWAq28P5
    Y5URLcNPvoRSWQvSqRzUpb3m+z/yDRUo1HZcg0qK1zna0sXNdVW9JVP1WCXSRx6w3FnoQg
    AHNygTzC/0hxPLy0ZcRD2XWvlGPY+sM5NJ70+ZotKWjiB/MU9iO5MGK6HtYOMurj8mXsjv
    ReIHVEe85sh3TehuQtwJdJQoWSVk6a5EzFYzxRbVhlRSD8m9Z+bm25Iko1pQ
X-ME-Proxy: <xmx:oyC9am5WqXpeX1XgAYHPP5mkWk7Y_Ot_8q2a6oUn5xbApfDsPkaxrw>
    <xmx:oyC9apXWaRyOJUz1ZDcOPLcyZR43glugGkSp_Sdo6UqG7eYgCeGvLQ>
    <xmx:oyC9alCJzIUWmzU5hZ-sKPrP3F8qd7vrDoxdzcoeysZOPfHnc7rR1g>
    <xmx:oyC9ao5qHzlrAVxOvPKAkReqY_13TB6W2f0xzbDo1MB6IJ3pfrLi-g>
    <xmx:oyC9aoy2kGP3WHlZF2_ctBEN-Krhjbx92ozoV6Nqmiqa5eO1QrntPaPV>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 30 Sep 2026 10:45:54 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 5f773e08 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 30 Sep 2026 14:45:52 +0000 (UTC)
Date: Wed, 30 Sep 2026 16:45:50 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Tamir Duberstein <tamird@gmail.com>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>
Subject: Re: [PATCH v3 2/2] ci: use twice the CPU count on both providers
Message-ID: <ar0gnpgH7CJqN_w2@pks.im>
References: <20260930-ci-large-test-resources-v3-0-d65ac7c21b5f@gmail.com>
 <20260930-ci-large-test-resources-v3-2-d65ac7c21b5f@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260930-ci-large-test-resources-v3-2-d65ac7c21b5f@gmail.com>

On Wed, Sep 30, 2026 at 10:20:35AM -0400, Tamir Duberstein wrote:
> GitHub Actions sets JOBS to ten regardless of runner size, while
> GitLab CI uses the detected CPU count. Use twice the CPU count for
> Make and prove on both providers, doubling GitLab's job count.
> 
> Five GitHub Actions attempts per policy, with the long tests enabled,
> gave these sums of per-job median successful build/test-step times
> (minutes; four or five samples per job) [1-3]:
> 
>                       Fixed 10   CPU count   2x CPU count
>   Linux Make             278.9       273.9          259.9
>   macOS Make              94.5       119.1           99.8
>   Windows Make           102.2       103.8          100.8
> 
> Workflow overhead is excluded; Windows runner images varied.
> 
> Use twice the CPU count to scale concurrency with runner size while
> avoiding the larger macOS slowdown observed with one job per CPU.
> Compared with ten jobs, this trades a lower Linux total for a higher
> macOS total.

Right. We could of course special-case macOS. But I don't feel like it
makes sense to squeeze every single second out of a job that's already
the fastest anyway.

Patrick
