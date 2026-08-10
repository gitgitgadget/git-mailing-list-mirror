Received: from fhigh-a1-smtp.messagingengine.com (fhigh-a1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 755253D902E
	for <git@vger.kernel.org>; Mon, 10 Aug 2026 12:44:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786365854; cv=none; b=Dev0HCVOE4kNmRwlyFxgc4E/Mo2zs6UCcSCekMck6lIxVpPxhpRL+WQCaxa9XJ7BF/NOty+ueRvx/HcgwP5iM7XFCmXKSihX2xXRiKguf3hn3f4AXHG7veIBWB2zUFcN0c9sLW6pm0dlE4mniWEU1Zt71pSDGIOEGrMaveBAV44=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786365854; c=relaxed/simple;
	bh=Uc+phyGyyBGweOVGYaz1OCRfPiOvnWcJg8u1V4Vm4kc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=czNyyBMpmr5X/XbhgNjWeAmcCvPtHPs7hvEcifuX+JAK/eRwXsI52h9vnYU6AWIK7geAR+AQRHce3n0aJscTZAX+16mt2edkr876haD3OTvY/ufbBE8BAlKUDPRduYZQGY0MsEr6v7LZhYMRB7n5bn7qNcFV+Kam1c0ISyUgQEU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=mVOn1MS5; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=JlELojd6; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="mVOn1MS5";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="JlELojd6"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 86997140009B;
	Mon, 10 Aug 2026 08:44:11 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Mon, 10 Aug 2026 08:44:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1786365851;
	 x=1786452251; bh=/9E4C7VjmTy0Du3c7TRRoBI3GKYFyAGQgmHdya15kws=; b=
	mVOn1MS5VN3p1OAqqvlDAH8mDJlU8b9lT0OLrQqSQ0E1vWAwkEU8ERisGCbPqmFx
	ZGDo9etf/dI08gw7vx2HPz7DWKla7Uajg2ZjWEij+sB3wmjedPJpF99yekzJTcjI
	FnOhwEfgKI46wet46RkZlZssUWQ9QtmCB8vytn05HWf1AGjQWlN9ixr5heprhMea
	duR7NoWKBwEXzNQBErd4RzDP+d0LvkJyhzjkHVYXF94IC5fA8QhMjsM9XrQBhiMh
	E6GYKPtwQq2H4hjY8xqJz6PvDfRSYnT8wR5UTHG2YTyjo8BBqAT21U5/qMwkzJPB
	fUKkNUKUrexzkSDZLDmtxA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1786365851; x=
	1786452251; bh=/9E4C7VjmTy0Du3c7TRRoBI3GKYFyAGQgmHdya15kws=; b=J
	lELojd62tL1rn4dINp01cPdOP4Bs6YcRwtE+RVMVsdRJIy1Wwn/ESIt7sqTMEny2
	8QjjOPTqzOEPOCtgk5pFs/Oqaj0ecZHD4AxK8h+7MUWbuo3Fpnj5bQnVHFnfjcJP
	knXJNPEeMrzNrpL8ihKaTCUEaMMqIedDuLhGN/qf1QHs5pxIdprAYy/djNfcG5LR
	SXAvB1out2Aqhes7KoWnggljlZ6gpL4AifF9lgDMxEgwHqb02V3PsR9uac8YzjHX
	w4mdvZufQv4PBScWnszab2QdZlZmAf5Po27eEK8ZCpk66Clt4m6njCk4Md/2NmhV
	2FC9GS81MSS32aH5gk+rA==
X-ME-Sender: <xms:m8d5aqPOJPk6oqFZvOGJDyRBGgaXjQs7aVdfbLod1PSAhUigP67Dpg>
    <xme:m8d5asquB_aCky_mNGTSYyZXzjtWWSRUuZwpOZjtgFN2_i2VwV3T4JftZ4a6qfmw8
    47ni8XrXbYQJbjKIXq-Mdif-USQuosoIsLfV1EqrsXqfrFMCEEMHZs>
X-ME-Received: <xmr:m8d5arFCSj_rP4G2cuaLDnlg8DUrOpyLaxpN2aPKDrZXXfVI5hsXM36IPasc2JqACyWic74smy_fxd6HacNQI2NVYJjpmIKNFZuXVebKKw>
X-ME-Proxy-Cause: dmFkZTFR3znwB3352mJkmlTy/SwW2rp/I5Ex3bYqlpFnE1ojEhCUQfPKh6SIdwQKkz8LSV
    0v7xqAyZh87vusqKyRAU9xXs0O8ocV7wdG2orRhNGPpNxS5TnJtL4aOZH4wIUNyGSBCJdV
    xPtw4j26k1LhTMem1mNI5c/i9frxe169jSE99kwarUEizVe+JSutaFyq6pjgfVCgZ0iK//
    g7KPhC3no1nPAZsWnAsz1OsifDGMMJLAJOSZiKP6eV9jLvpMRutdzZmc/CXZYo0ydeFxpd
    VnKP5mGDoN7xknRsZoyZoM8JhKKr7H4xfKsSxp0KJBYFSYX1B+zabXvOJ8xHOYQix+tYqa
    9xen7lvuKuKwXhFXbxLarG5zVP94MbLpzmtffvDVbVpdRiGve/oQGwFrxUcUpKSu3e95tg
    LWcAqhjlfvBC1/Rfk7Ca/wH62aOP7BsWeigm8OWvVZes81uJjm4dLvTQIRED3i2JPPFC3S
    shLMVNOfeWCCi6LKRC4PT37s4QnauY7gl6tKLomjYKqnfV91Q5olMpXyi1wo2elz2oGe8B
    cVi8OdObiIRb/xt2ZKiWsW4dS8GLTWs3gQcEmrZ9AGtzIatuyIooUyZeU6gANdkq4QY+XD
    ky93+Fr2b46Pe1SPruuZv18xCYl1OBgK2GHgDsOjeK71z55gdZYlCUqu5DfQ
X-ME-Proxy: <xmx:m8d5ahrbooda1JjPM8YeouD-gCVee8yWoEuMcmtspgpgPvf_oP6hnw>
    <xmx:m8d5akZ1nv8xfJFGqyPUprcx7yTAAXQ1KUZ8NbFqXNLy9ikz7eld1Q>
    <xmx:m8d5aqXxjJM17A2GQK_50QvYPNsn9T1jKkk0YLsNKvcbmtscBopM4A>
    <xmx:m8d5at-XQVwx2iuXkYu29L-p40E38i1atXU0Tc68L0eB5Shy_oSWww>
    <xmx:m8d5ak45-7gyjNePQZSHIDXHsfcFpUpnoA1fLn_etlwEb31xdc8X6FbV>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 10 Aug 2026 08:44:09 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 022b39b1 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 10 Aug 2026 12:44:07 +0000 (UTC)
Date: Mon, 10 Aug 2026 14:44:04 +0200
From: Patrick Steinhardt <ps@pks.im>
To: "D. Ben Knoble" <ben.knoble@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Tian Yuchen <cat@malon.dev>, Todd Zullinger <tmz@pobox.com>,
	Olamide Caleb Bello <belkid98@gmail.com>
Subject: Re: [PATCH 3/3] core: convert build-time USE_NSEC into runtime
 core.useNanosec
Message-ID: <annHlFwu4NKwmcLr@pks.im>
References: <cover.1786103607.git.ben.knoble@gmail.com>
 <dbbd96d50811e4c2decb6f754b56dc1f7ee0944a.1786103607.git.ben.knoble@gmail.com>
 <xmqqv79ld40c.fsf@gitster.g>
 <CALnO6CBm4g27mWBvD9m6yL0e5YZu3M9_zcUeLZk7QwTgnxMLQA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CALnO6CBm4g27mWBvD9m6yL0e5YZu3M9_zcUeLZk7QwTgnxMLQA@mail.gmail.com>

On Mon, Aug 10, 2026 at 08:27:51AM -0400, D. Ben Knoble wrote:
[snip]
> Back down to being on-par with original code. So that's good. The next
> version will include some variant that reads a struct member instead
> of going through repo_config_get_bool().
> 
> But which? Reading the private_ member is obviously wrong; I suppose
> I'm supposed to use repo_config_values() there. Or, rework the series
> to put this member in repo_settings. I think I originally assumed that
> struct is for things that are settings that aren't configured by
> git-config, but… now I'm not sure. Looking at prepare_repo_settings()
> shows lots of repo_cfg_*() calls. So I think I see how to adapt to
> using repo_settings,
> 
> Patrick, Junio, and Tian had a brief discussion in
> <anlmwaEtwcCPse1N@pks.im> about the split creating confusion. I don't
> really want to wait for it to settle to land this change, but we might
> want to work together on identifying the best path forward for
> core.useNanosec :)
> 
> I don't suppose it really matters to me which struct I put the member
> in. As I said, v2 will definitely fix the hot path lookup here. Just a
> matter of input on which struct we want to use this time, I guess.

I think `repo_config_values()` is the modern variant that we're slowly
migrating stuff into. But that struct only works with `the_repository`,
so the question is whether we ever use "core.useNsec" for a different
repository. My hunch would be yes, for example when recusing into
submodules, but I'm not sure.

Patrick
