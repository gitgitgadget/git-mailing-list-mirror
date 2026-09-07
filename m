Received: from fout-a3-smtp.messagingengine.com (fout-a3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B260E199FAB
	for <git@vger.kernel.org>; Mon,  7 Sep 2026 06:15:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788761729; cv=none; b=arJ4YHkFwMkdcXfLopZQKvKp4/l2eBsmpZeC16rt+i90WNVthD6DBIgjRIKd0Q5S4Zo4aVlP0gjusYzlFWQcADxAqCWk7Lg8jHeRMUiiO6CGomFbzNdh8/TtjqwjWcgu5clDeyrSPKXTElKyyaK0HSO3SaGG+bc0jEOkEJxfDVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788761729; c=relaxed/simple;
	bh=z9YvMkisz+uTOIN4ZpfEud8LF0kpk3iHcQBv9QfxPN4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XX9SvqN4JEsoLGc/ppWCmsL/GfUPrLW7LnEYEK5ePvYp5bA9ohrkoz3Xa62Y+/aA66AT5r4HUl4U8SnK8d4xqX1zLTbcLEs5rIaEs68S421efkFPVtjY44+/LUYe+PZExld7excGrdTe0buphdaqYZBV31viipy20391JcCYjsY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=FQDLslKI; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=F1gOYPFr; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="FQDLslKI";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="F1gOYPFr"
Received: from phl-compute-08.internal (phl-compute-08.internal [10.202.2.48])
	by mailfout.phl.internal (Postfix) with ESMTP id B2508EC0227;
	Mon,  7 Sep 2026 02:15:26 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-08.internal (MEProxy); Mon, 07 Sep 2026 02:15:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1788761726; x=1788848126; bh=0JZjYHnplo
	P4THb9XddRNacbXeAevzWUTH1FCXQ9mbY=; b=FQDLslKIwP3iJJldaXQN31Crhh
	/lB9wEtt9PrxWhXuQ3zZ5LFzv7j4tF2Sebrl1l/2gddgRepEXwyueSEWOGzWi2aM
	uE6OXmGXS2GqIdEgcvBMuW7Tv0Sp0gvvydpE+8O8tEqS4M1PMwfZl4R0QMgyTI9y
	vICvjcOvwqqCYGqLXwIGSxv3k+oSK++siL22vmj5+UW5z+j2egtDwENHEovA4UsZ
	hOqjPomwyX17vjKhj7ioABfWMBWss2XsGwKT+6a74X5fT1Eq30+ip8hepnjNfheu
	NLznUgCH0Pje7vMf07LEg8vQN6yUhutqA/JS8hvSBULIPF1UlazFdopXLxKQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1788761726; x=1788848126; bh=0JZjYHnploP4THb9XddRNacbXeAevzWUTH1
	FCXQ9mbY=; b=F1gOYPFrL2Zqz8DrNIDglcJC7X0N6t4nxjTEiDqlKMdy4QpjJ0y
	c8uBnIyXrXr/Eu/Fvblp1TqJDOpZUc1S2BG4criL7S5Iw9XEe79bcADG4bHxJKNO
	bhb0Y8LXsBimMqSZNE8SAgbR6dPIy73fBRaWh6+1j0VCefe0VFFeNy9B0USNQVaY
	EMSdPgtJov8oKLgqh7CiRkyJLY3F60TeGHJAlTBw9fNSJK5SlF9OSGY+lKscHJqD
	kf/jZEVKrzH6ljLLgEnzlXRv2g2SzNqp4cG8TCgHxKiVc7MiIBMDh3kER56K3wq8
	B8dHHpGMbNQez8YZM5uqw9oV4x0RO8eJeyw==
X-ME-Sender: <xms:flaeav4yKrkdXhK18v2eI1JFHTk4jFro6jVIIex-h6nxzZ46VFcryw>
    <xme:flaeamYUkYxLkvEt_i9nM6xe4d_JAPe4_SkrBq5jkytygpz-KuntGahSRAYzrhb6O
    XOu6DGGlFSGf8imj80Yb1NW6dKByES-QZxoID6kum1Sa1RB4NqXRg>
X-ME-Received: <xmr:flaeamgQN6lo2iojaGATxPFQST-8KdlNpHOXCEI1okJMIqL5M-4UYw>
X-ME-Proxy-Cause: dmFkZTE0AyAuaVxbZi/PBNv0uN//DYIx28tgM9JAlbiaZAJ234l2zK+Kt99kWWORAqDWXd
    o7diYktMrzAonSq5J9VpyiMXzRTM4zTk4/j58gxGh0MaVIyRnREOoS4mKpubLyvYTUNYuW
    VGb7nGU9kVk/XLU6l7lHZu1hR5jw9il4whmrFvyEMqWoWpCuGlC71fQcVynTyoU2m+AE3i
    bG7ROBTtcnI/RxNYoLubOE7zvpDcIz8K5D3gp+OfhAD/dHlesVFVizD6Qf50XTxNJCJ/5E
    BGqezYxprZ2n+DgR5tUMAXD8C44gI4Ir/eyRTSuzzCH2TgYSscCWeOUUWOMj+EMbAnutBc
    +EBYcVRsGfRJjOlhH5Rs/W7wecQRAOoX2eC0njnjHD7lGJFcpoaHLfJKFJJqwgrPtCD93M
    MNp+RyE3N7E6222CFT52nZqFsb0UgDKYtJCIoUepT9Pai6HDJRGqEoJ0Zdwzo5/jrG97OH
    po+3QNrRFLLU0uWOCsFfw72ye1HIuiPV2DUEEZvmZ8zgCliBvcF0MyZE9dfiuqMCvpf5rb
    P5onuDLZODSmFzZDNZb0xrdpjTE4soiopyWe3Eb7D/CHNvW36BxSdgZk4gBK7Z83n0YmyX
    AALoP+dC0JOHZOkFrYV/4JwWnFjTbZGxuCBO5beW9mctnALVIJWctR87sHWA
X-ME-Proxy: <xmx:flaeav_FC9n-UNrAo_0_-cseL2p16uXxk-jl6v-Kb4AyqUcFosLFuQ>
    <xmx:flaeapqvM_1IXAUuXWZJCrmLSFMOcq40w8hm8j-CJdx826jCbggPww>
    <xmx:flaeavVhL6R83geiJKHGxMkcAj9h9BfRX1YkE0QzMMUte06lt3zrxQ>
    <xmx:flaeagAuzoaKwejstcfsN1B81n3qdvzmBSz17sYLM3gFtatgDPV3_Q>
    <xmx:flaeatCPH4xw_UoNKC5KtF63dq-9s7RWR3_5OooCWa5kusfy2EwiMYJ9>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 7 Sep 2026 02:15:25 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 7efa8ef6 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 7 Sep 2026 06:15:24 +0000 (UTC)
Date: Mon, 7 Sep 2026 08:15:21 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Thomas Bachem <mail@thomasbachem.com>
Cc: gitster@pobox.com, git@vger.kernel.org, stolee@gmail.com,
	phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v2 0/2] builtin/maintenance: improve heuristic for
 "rerere gc"
Message-ID: <ap5WeY7o2dmAIn2B@pks.im>
References: <20260903-b4-pks-maintenance-rerere-gc-heuristic-v1-0-9929c45a9788@pks.im>
 <20260904-b4-pks-maintenance-rerere-gc-heuristic-v2-0-b1691121fe1c@pks.im>
 <xmqqfqzp6pir.fsf@gitster.g>
 <xmqqld9h56yt.fsf@gitster.g>
 <CAA0xjtrL8DJp61jp7s0L6L+RviwQz=-PEo7qZvCTh+8nT2cdfw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAA0xjtrL8DJp61jp7s0L6L+RviwQz=-PEo7qZvCTh+8nT2cdfw@mail.gmail.com>

On Fri, Sep 04, 2026 at 06:53:59PM +0200, Thomas Bachem wrote:
> Hi Junio,
> 
> On 04/09/2026 18:14, Junio C Hamano wrote:
> > So the two-patch series is not about what happens when two "rerere
> > gc" trigger in quick successions, and even with the "improve"d
> > heuristic, the second "rerere gc" would fail the same way when when
> > another one is already running?
> 
> Right, Patrick's series only makes the gc run less often. The lock
> itself is the subject of
> 
>   [PATCH v3] rerere: keep a background gc from killing a rebase
>   <pull.2214.v3.git.1788537081930.gitgitgadget@gmail.com>
> 
> where setup_rerere() waits rerere.lockTimeout for it and then goes on
> without rerere, and a gc that finds it held gives up at once.

Yes, exactly. This is really two issues:

  - rerere cannot handle concurrent writes at all, and will die
    immediately when somebody else has taken the lock. This is a
    long-standing issue, and should be fixed via Thomas' series that
    introduces a timeout for the lock.

  - The heuristic for garbage collecting rerere entries is way too
    trigger-friendly, which wastes resources and makes the above issue
    more likely to trigger.

So in the end, we want to have both patch series merged to address the
issue from both ends.

Thanks!

Patrick
