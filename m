Received: from fout-b6-smtp.messagingengine.com (fout-b6-smtp.messagingengine.com [202.12.124.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFE533469EE
	for <git@vger.kernel.org>; Fri, 14 Aug 2026 11:07:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786705634; cv=none; b=g33BysosvHjJZ4JfPM6RXZlDALhbtz6+HHpUqTgpUwjzoSMA/+suMncHomrpTFWAv4B8567tLgP4VLUVS0/LmceDvMPUd1JPaLvlSa9Y2IjGTwt0Wu7Qj1rx4nLdf4nL3N6ywPWnPNkxgVitVrhzwOsOxkHi0iWmcr6xqY/UPOs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786705634; c=relaxed/simple;
	bh=ld9yVWvEADDjRbYkNwixG63moW1DinEi3pxONFHytQs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=s+O8QZ4YUuUpWh6BuW00eX/fBXC9kxsHNmhvDuyG5MBob/wrqeHdtmkt6z+vZzuJSK1IEhXiKNedkeX9YPAP1Xb7QOUM7SsDxuOZyXwIYKu1/d873D/c6NdYhrY2kYAEVmVG29A8MWEJ1GXIe/7692W9Y/zbG/Ey5iN9afo7M7o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=ZAXAb0tq; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=dqQj9Ylw; arc=none smtp.client-ip=202.12.124.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="ZAXAb0tq";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="dqQj9Ylw"
Received: from phl-compute-08.internal (phl-compute-08.internal [10.202.2.48])
	by mailfout.stl.internal (Postfix) with ESMTP id 330551D0032F;
	Fri, 14 Aug 2026 07:07:06 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-08.internal (MEProxy); Fri, 14 Aug 2026 07:07:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1786705626;
	 x=1786792026; bh=eFHXOswwlSZAatW46Vp+jbSU8o2P3eIxuuldMe8l/Fs=; b=
	ZAXAb0tqXSjaK/d8lMnvxPyoECnd9GEkmA4oAagL2e5yRzn4uuez9ro97qKqtpcL
	UT4EZlCDUdrFpnl97E3cYRKxyItf6PiP04flGIjqV58NDmbjXXKEW54wZt21Qmoe
	q/xqw/AXHthAIOOMz1rKqunlBWI37+3tbjt/xHLfU73hj1gHiUiJ4ZsPCI+DC+gk
	eRiOwUAzOO3623oOc7EPFV6cEY5TOxwYc2F0dHWtPdygGTh1rxA5q5TDXyt2tQRz
	LPXfDHQiT2CpFRgayoAxAwETH/c/2m9M0vgga3gOGWSNPYCQG1be5QCpuq/Z4Yog
	mWVpVR+EAgyxjrZv8fqAug==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1786705626; x=
	1786792026; bh=eFHXOswwlSZAatW46Vp+jbSU8o2P3eIxuuldMe8l/Fs=; b=d
	qQj9Ylw8PQz1c2FR6MS4a0ce4EjDMbPKnCvEqvUUG4bOhTLoFVyOJevUB87QJfyg
	NpyDBU8gItrc9BsVkb7f8iNoGT71TV4nHmDGCOWfGarkmh4q/UbAR6OZ74tApclf
	iCnjLAU1Wmzxvle0USP7kmEA7YmDsV4XyWGjg0WA1RZrxSGWr5SzkvJyYptfS/gG
	S8X1sw3RwpV9T06RjsGhjBM685YGgBbcSE+VdPumiRRQW4IuwueTWDYESxkw7J8a
	eYWOrPIjocgImpuvh87GQ+Z/4DvgNEGTM5DwVgVnwH2a05nSQ1ARUTWcecKGxw1h
	ZYz9rWYciYJDUzQ17UHgg==
X-ME-Sender: <xms:2fZ-avgMq-6zclcvr-jgZKF0ZrbMhkShfJyRGMCO_JMSJQARW2ZCRQ>
    <xme:2fZ-avuWjEjVKMImuyEyyE9VlHTx-T6RGX3bkmG5AoYjNF2bh2881miAhf6byGizy
    j-XyCZXNTFucWCJuTEKEQI_mIBPmt4Lscx8cKL1fuDUm0cDNJMGphI>
X-ME-Received: <xmr:2fZ-ao4lqVULSqdq86KJaWcCJazpUYugFA26BvunufSyONsdoOYfBzVZm2kCdtjWs23D9aFon0CTBzYvXUpysJKuwVt2shbO5dhZbInJbOM>
X-ME-Proxy-Cause: dmFkZTE5Vobj8nwkf41n+wt2An+/XnDbizSH/pVPSHMG9joOUdRok1pA9C71DOjloCyhT3
    vtfmktZLz7WfF/x7ZaY9+Mx71nWX9DLME+pVd7FLymNtFNCaFQHTWGYjwV/bwMwjefZRH+
    K6iuQ9lvzl7IcKE3CF0TyXm72t6Y03gyNtbKFHCBFe/+Y5/0DHbgSOQNTBU9JbUDPBe6xE
    DJ0wpd9rEj2h8ckatjTdOg8Lw85iNL7wVRKLgKuFyBgrDFP7dRAZI2hA/1vA4i16I3vAay
    FCUesmJUhCnFO2mwRWLDlyKTr2JihxcupuflOo3LNntjyoq4BT5ec2xthiKeGZkQS5xylc
    lBX3d24l19XC+KEESWH59chDIDvxfL968svBO1CnsfN0s/P6BXrsVItkXrLb52tkkRGWNS
    CEUCJ/VnLwymgmfrWB4XjT5LWAJf96BI72vOF6kNQKr9NPfzbyi4mjbYnxfgqV/JX2JyqY
    vJ62ErJP0N6W6jrQVjH9pMZJmvHPPJQa9/z/wxHSfAMhzZ5YSkXOwX8GztXfaxnLAwV/IX
    +dkf2UozjEdBMehuAGiyakar17Ia0H8QX4FlbCmepKIFIAPDc6ouPhci2pJuCh3Pr5cNLV
    Cv87e0Mdw0LFxRM5xRBoCBjeC+Mjbda8PRWMfTqzOW/2pdKDNAz5S80zOO6A
X-ME-Proxy: <xmx:2fZ-ajMBmBcstRcOJfcwtvkVCHTrYsqyFFruUnB648zjVjSIi1_SqQ>
    <xmx:2fZ-ausjRljbPOPxZcMKzLgB21BZbxGWQIrTWuMSpe6CEUr_LJj6HQ>
    <xmx:2fZ-auaL9g-OY2Rbr9vmp8zcQfRHqbnrotoZ-zmcACZg_oXbBlwyyA>
    <xmx:2fZ-aoyruseocmA67XWHmJSRgYgEuZbmsqNpSYPsa4Uvi5ktPm7bDQ>
    <xmx:2vZ-aguZU1gmgrGkJLeibNbmJrwW6_6KsatUGp1TAxYFXrsdVWelJLe8>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 14 Aug 2026 07:07:04 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 31c07956 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 14 Aug 2026 11:07:01 +0000 (UTC)
Date: Fri, 14 Aug 2026 13:06:58 +0200
From: Patrick Steinhardt <ps@pks.im>
To: "D. Ben Knoble" <ben.knoble@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Yuchen Tian <cat@malon.dev>, Todd Zullinger <tmz@pobox.com>,
	Olamide Caleb Bello <belkid98@gmail.com>
Subject: Re: [PATCH 3/3] core: convert build-time USE_NSEC into runtime
 core.useNanosec
Message-ID: <an720tZnot07HYiK@pks.im>
References: <annHlFwu4NKwmcLr@pks.im>
 <59E4039A-C9BA-4EFD-8022-77C73EB51ED0@gmail.com>
 <CALnO6CA5LdL74SqC9V_wJWi=Pf7+cHBDkuUFAJ7jCOVWZjBOzA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CALnO6CA5LdL74SqC9V_wJWi=Pf7+cHBDkuUFAJ7jCOVWZjBOzA@mail.gmail.com>

On Thu, Aug 13, 2026 at 05:40:31PM -0400, D. Ben Knoble wrote:
> On Tue, Aug 11, 2026 at 12:26 PM Ben Knoble <ben.knoble@gmail.com> wrote:
> > > Le 10 août 2026 à 08:44, Patrick Steinhardt <ps@pks.im> a écrit :
> > > ﻿On Mon, Aug 10, 2026 at 08:27:51AM -0400, D. Ben Knoble wrote:
> > > [snip]
> > >> Back down to being on-par with original code. So that's good. The next
> > >> version will include some variant that reads a struct member instead
> > >> of going through repo_config_get_bool().
> > >>
> > >> But which? Reading the private_ member is obviously wrong; I suppose
> > >> I'm supposed to use repo_config_values() there. Or, rework the series
> > >> to put this member in repo_settings. I think I originally assumed that
> > >> struct is for things that are settings that aren't configured by
> > >> git-config, but… now I'm not sure. Looking at prepare_repo_settings()
> > >> shows lots of repo_cfg_*() calls. So I think I see how to adapt to
> > >> using repo_settings,
> > >>
> > >> Patrick, Junio, and Tian had a brief discussion in
> > >> <anlmwaEtwcCPse1N@pks.im> about the split creating confusion. I don't
> > >> really want to wait for it to settle to land this change, but we might
> > >> want to work together on identifying the best path forward for
> > >> core.useNanosec :)
> > >>
> > >> I don't suppose it really matters to me which struct I put the member
> > >> in. As I said, v2 will definitely fix the hot path lookup here. Just a
> > >> matter of input on which struct we want to use this time, I guess.
> > >
> > > I think `repo_config_values()` is the modern variant that we're slowly
> > > migrating stuff into. But that struct only works with `the_repository`,
> > > so the question is whether we ever use "core.useNsec" for a different
> > > repository. My hunch would be yes, for example when recusing into
> > > submodules, but I'm not sure.
> > >
> > > Patrick
> >
> > Thanks. I’m working on control-flow analysis to see what kinds of repo values end up there. Of course I’ll also run the test suite and so on with the repo_config_values change. But the analysis will take some time.
> 
> Ok, CI run: https://github.com/benknoble/git/actions/runs/31701945211.
> This demonstrates that nothing our test suite does across the many CI
> configurations ends up where with a non-the_repository-repository
> (ahem).
> 
> I have been working on control-flow analysis by hand in my Git time
> this week. It's of the form "Z calls Y calls X …" until we can see
> what the repository that's (eventually) fed to repo_config_values()
> here in is_racy_stat() is. My notes are one node per line, which
> indentation showing callee relationships. Some lines are pointers to
> other nodes to avoid duplicating work.
> 
> With that in mind, filtering out the pointer nodes, I've analyzed 214
> nodes in the graph. If I'm lucky, I'm approaching the halfway mark,
> but I somewhat doubt it.
> 
> But since CI shows things work… I'd rather not continue the analysis
> if we're satisfied for now. (Esp. since that will give me more Git
> time back for reviewing ;) It being outside-of-work time, I only have
> so much of it.)
> 
> A few other related things:
> - Some of the edges of the graph appear to be public libgit.a
> interfaces. That means we can't guarantee that only the_repository is
> used.
> - On a related note, I don't know how large the current "must only use
> the_repository" (e.g., via repo_config_values()) surface area is right
> now. Based on the partial analysis I mentioned above, this feels like
> it's introducing (or at least contributing to) a rather large surface
> area. So, this change might make it more critical to resolve the
> limitation mentioned in the other thread. OTOH, I don't think this
> change is likely to represent the only pervasive the_repository-only
> limitation, and I'm afraid it will never land if it must be
> the_repository clean (unless repo_settings is the_repository clean and
> we decide that's an acceptable place for this member).
> 
> So, idk. If we're happy with the CI run + use of repo_config_values()
> overall, I can send a v2 shortly (in next 24h), I think.
> 
> Thoughts? Strong opinions?

No strong opinions from my side, other than that we should stop
converting everything to `repo_config_values()` until we have a plan for
how to make it work with repositories other than `the_repository`.

I don't feel like holding this series in hostage though, so if your
analysis and the test suite both say that this is probably fine then we
may want to pursue it. Or we just use a global variable for it for the
time being and then wait until the `repo_config_values()` dust has
settled.

Patrick
