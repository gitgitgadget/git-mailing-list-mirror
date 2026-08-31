Received: from fhigh-a8-smtp.messagingengine.com (fhigh-a8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E1A13C10AA
	for <git@vger.kernel.org>; Mon, 31 Aug 2026 05:43:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788155031; cv=none; b=RaTmlhF44fVKq4dP2T3I4JdxjRqdq5IFikstkDN9y2nlX7xjxZMppSN0DZPq/PwAX3bhjdumCUhtg8oPLaFK/UAkc6GoNPVdYXjFveT9WoLyDxtFzTI0uDb6qd4OdRhnnLYhNtPvsGOWDToXXDyZzhLczE0PSToHdeg+7k/o1dI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788155031; c=relaxed/simple;
	bh=Wo9teadfHmARpQSxpkL0EBhEKVhR0+O909OZZrPfv8g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fSrKNufWSaGO8ZsvhBxBrSMCr/COS+oI79Z8CykImQHe0kfe2N1h/19HjHuv6iVkeMp4HbhBPRB9v2JWItdIkK0kkQ/ftoos05jgBA9PkuKNm3O2K/xSQ87MUinc6L0tZ4qepkUuzDoPVGMqdCp1M7+53Fr+WXIfWjSxRtGt7sA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=JyIaED/z; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ZwqCx4YR; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="JyIaED/z";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ZwqCx4YR"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.phl.internal (Postfix) with ESMTP id B18741400082;
	Mon, 31 Aug 2026 01:43:46 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Mon, 31 Aug 2026 01:43:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1788155026; x=1788241426; bh=dcpEfTlH4I
	pPgBPTODqtqNMImhf6tLvHtFI0qCvQCjc=; b=JyIaED/zrjyJdTWQHJ1q7wIpXd
	VZQisp24Z/qIBDOuYaV2lERitikTDnfIujnK8dowXUp5tecU/nZ8gZKlWhV2Xswq
	J0ZNFt+Lz3KtHwkmgSqdJ7NlNa9sU+yOq1vP2bz1cPxESbq4x8vAEfHv37tsnvE5
	O4g6sUMBMxT7OEzW8MEvatkftctNQ1ymFdLNF/yEgfr4sMbAE/sVoPCodixuEr1B
	nmgisRvr4t3agh2O1eIi1UQTGn9CD5lvlO1arlCI78WQQyviI0Zn6itTXoID6yHw
	VIP5sTP+kzVEsu24Afkps2OPQmLRdgPUwYLI8kzZBz+GfgLPwC5/cI59M9CQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1788155026; x=1788241426; bh=dcpEfTlH4IpPgBPTODqtqNMImhf6tLvHtFI
	0qCvQCjc=; b=ZwqCx4YR0yTb0QMi+isstNzu/XBQq6yuv+0GTGKlAvYz7omdlgM
	yJ8jOsEJZ4NjA5yyBRz2eb6zsq9e6Xo3gGdixl2rdGqEL/QCWxDuTjrM2IzZhQYH
	w8lTdRmI6kKJOGK3+gp7p2QEeeRD8Ub1cddA1AdRAleEu7BR5aT1Lavi1gsL3REh
	WZhw2Zx45lf+m4N+uCcClBq4oWAPLOudcc3ZH2Fpnm8flDyud3qKm+FXQ/PIdr1m
	eDk4eU8VfkYilG5GCGuu1HjAlpTjOz8A62TpTjt94k7LmTay9T2bAaPBneZsGS67
	MNVBSVFa6mQICMUY0PcP/mWR6Ckbh0Xby8g==
X-ME-Sender: <xms:khSVav6-1djhxcbNkIh7Qyei1etVBla-93vcWHfI3_rIQf48S_2KSQ>
    <xme:khSVasV9lGTNhHKSw7p3bCycW292oSiTaszfHdSHZQ54O_ik0CCwQxpGlaH9a8szE
    h5iIGVSSEt89FH2loz2cIcQxp6SJgzyCWjSOJuu58z1KyMUOMeW-w>
X-ME-Received: <xmr:khSVaj2TUji_dGrCmPqli2UOMvJgayvMIHZsyx2GGVoB_vCxr5OQXb0waKcVkngKou4Z4A>
X-ME-Proxy-Cause: dmFkZTE3d9gmLbQlmnKDgS+RjJAYb8FUvCz+nS7r4W2kkel1FgCjI9fTq+5CUC6zAWNFvv
    w9DOcSxaPHIwKTgteMaoGkg9E2XDwG9mR4YZX4H0JGUchJLR9OTevfb9jeXa3otbN2ymG4
    UksCDib+RbCTNUEqoqSmUWFa6uGd2621XyASN+E2+zBSY1QHQ1sTqSwIqDilRgLootR4eO
    kVAEvYpPmqJiJHV1sH62Q301zz45aMOHMtqpLOYWRXPDPrZJ4MppPmCu2ydvZwUtqNh4AE
    fNWUJsTFFFrE0NSng//DVVTZyDyOk4Ju3Q899GM/JLyq9LPQTbIVJeeBGJFvMU1hIrvVAz
    MxzSEw+47C9fWAfSvr604y1+U8tvGLZW4trqPAr64EicWHRK+TUh5NAheYMJLy/6EVxos8
    jeS4QjuT3TYjumxaExJok2nHefSASeFGZuHuCZk5OHevCoH9nGA/LBvlNvd4l8DogzcDAk
    eKHjJJ7SyVk+jlRf/bBjIc+Ed3MS1Al4bKgRh7kGogsn9MCZinaiPzbTH3ViLE4RBpc4zS
    FyEEShAP2uxKlpB6yU9bawuJPEWnQaqAALHrl2hWORWNb0QQRq8s6xTR+/0hti51UFKZG8
    zTzR+HiKKOHN13UEtDSqMVMiGPz8X0Jq1imtequWdqkR0LH4rWMmO5vZupnQ
X-ME-Proxy: <xmx:khSVap0CeLZVV2V_zcTq-Hez1IYpIAPOdhGseBOMJNJ76l9F8KwZLg>
    <xmx:khSVam-mj3wNe8caUWdq5ZeAH_50M-aC6Odu7mhGtdnthcq64rkpBw>
    <xmx:khSVam0Yl9N_7EP_CJm_R-oYSG6ZcNYxQqgXzNkSpDdN6mfyHkAIzQ>
    <xmx:khSVaj9elk_OLoaIa8wM1MUX_N0BadQ-h6qbGhQx84D5I42Zfaf3Iw>
    <xmx:khSVaho_ALAVtWr_GhjixZWtgigI9fdyVW6eBA4QsUxUeGx1jYOdkkaF>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 31 Aug 2026 01:43:45 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id b9bfd381 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 31 Aug 2026 05:43:50 +0000 (UTC)
Date: Mon, 31 Aug 2026 07:43:38 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Justin Tobler <jltobler@gmail.com>
Cc: git@vger.kernel.org, Ted Nyman <tnyman@openai.com>
Subject: Re: [PATCH 0/2] fetch-pack: allow parallelizing packfile URI fetches
Message-ID: <apUUiv4SD0-W8QS3@pks.im>
References: <20260821-pks-parallelize-fetching-packfile-uris-v1-0-0df52d9427ce@pks.im>
 <apSpaLf_Pu3G4Nqm@denethor>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <apSpaLf_Pu3G4Nqm@denethor>

On Sun, Aug 30, 2026 at 09:33:52PM -0500, Justin Tobler wrote:
> On 26/08/21 02:31PM, Patrick Steinhardt wrote:
> > Hi,
> > 
> > this patch series prepares git-fetch(1) and git-clone(1) to handle
> > fetches of packfile URIs in parallel. This can significantly speed up
> > fetches when the server announces a bunch of packfiles, as shown in the
> > benchmarks in the second patch.
> 
> So I've been working on a series to extend the use of the ODB
> transaction interface to also cover fetch-pack. As part of this, my
> current plan was to also refactor fetching packfile URIs so that they
> can be written through `odb_transaction_write_pack()`. I like what this
> series is doing, but I wonder if it might a bit more straightforward if
> we try to land transaction here first. Otherwise, I think we may end up
> having to redo some of these changes to get parallelizing packfile URI
> fetches to work.

I'm fine to drop this series for now in favor of yours. I'll resend once
your series has been merged. Thanks!

Patrick
