Received: from fhigh-b6-smtp.messagingengine.com (fhigh-b6-smtp.messagingengine.com [202.12.124.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 910493EF670
	for <git@vger.kernel.org>; Thu, 19 Mar 2026 16:48:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773938937; cv=none; b=PTgMVxFNT0PiIEhAslIxlxytUXevvLnVVLmmQJsqRpIcb2uPGSkuffYXBy1kbVGQKZuof+pP6jkXrjpWTY1nkx6haVWmHUiBser0v6+qLFBFngoA1diH/dXDc7qmKIv+locbMLtBOz94lo+gGEwDLr8uyFkdQWvKBPIC3240tCo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773938937; c=relaxed/simple;
	bh=vgW6wn0yVgv/OQkslSxXuS2+T0P6F2OISRU2JS3yUOY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ikwBhikCulSMW93Ahy1abh9ZEqL/rPyJG1LdjQzf7tDek7Na34BFJD7HJR12IVMZRl/VRjhY0WonjiyXGN9xyraIdusR9nNQ08ol0Zd2kY10fmaGH9jfKRHQ/0oYi+NHArgjqkKMEN7GdNUIeKlOqM6wPEK2EdsUCnjPfLAGbxQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=iBQHSqOj; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=o2iik+KX; arc=none smtp.client-ip=202.12.124.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="iBQHSqOj";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="o2iik+KX"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.stl.internal (Postfix) with ESMTP id B55807A0164;
	Thu, 19 Mar 2026 12:48:49 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-06.internal (MEProxy); Thu, 19 Mar 2026 12:48:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1773938929; x=1774025329; bh=aKwU7Uln0W
	ovVkDUYV3pKdlkFPoKSdduuDnz7dlDEXg=; b=iBQHSqOjfDJQuuP2TbGUNo6Bg4
	RtBzizCXn57ONl+HKPvd1VkUak6nGnHQMWmxo747Bj/lYJjO6veKHWpYNzuRqTfg
	Yl2REJ0aGo54C+Ey1Mi2dxPSj72FEC4c279pF/t4rF1fKSmop2Dj63AFwlmxBW4P
	aCUBdPoBEf7Uexd4+ZjTY/xweQ4Q2Z9RZNZgB5s8VqVJbIMCiP38gp7b6UGnrF9Z
	Nlit/hiDxc2PBu+DppXyjp/5EFAkd1iW7h1KPfIYJ2X0CbXfzPdsDnU8Luu0RRXr
	FTQPo+fb0DsyECn1BHCzLdVEscM91iiLtcRJZG+O11kvfAiStZ3UkTbkS3aw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1773938929; x=1774025329; bh=aKwU7Uln0WovVkDUYV3pKdlkFPoKSdduuDn
	z7dlDEXg=; b=o2iik+KXLx28zyefUW2HaGBXyV+B3/DIB1X9V4XDyeT6cVyu8x3
	Mp9i4k9DQSAjsXabPuJp4XfEwdGg7RLMa9ac4z3y9pePBENUawGlLmK0uotWI5qU
	xxzn8rQTVZZlsq1/qcJk1nJAUb/Y+45C0w8Ni/RC0g/z9bi7oB0cvP7qRpQw11PE
	Yg59uImdivT8CsrHrfVA+PGbSVghspwBVXbFBSA6avNa1HRlYyOYGkqWx7g8kx3c
	amgyl9kiDnFNNXp9eFXIaMK+g9fecCNu7ZwzSJdY6UId1rnTuXsdGGKlcFzQQ3+E
	pF83CrAHoRdjwPmauGjPPd3i2wnLqPJi7UA==
X-ME-Sender: <xms:8Si8aTRBFLCYctVWQe6iTlFhSRQFOH2VlgjUQi8DHrorH4_0bkxzHA>
    <xme:8Si8abphUXruabra8YRlK2D8avQU8129mDUGPHCrHQrfAHvWvRwdLIUQItR76pak6
    jhLw9phNNwZZq6TV2RHY1MzJ_dnnKowUv9VQa91K6hSOozRgHk8bA>
X-ME-Received: <xmr:8Si8aRJL_jiJ0rAb8D_y_RQ6gEFeWvYZdCsYluF8NuygyhaolivYLVX3N62fO9MpPiE2_9TWY7svVNXGg7vnRIT3g6kDNAeTzA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdeftdejheefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohephedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohephhgrrhgrlhgunhhorhgughhrvghnsehgmhgrihhlrd
    gtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphht
    thhopehgihhtghhithhgrggughgvthesghhmrghilhdrtghomhdprhgtphhtthhopehphh
    hilhhlihhprdifohhougduvdefsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithhs
    thgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:8Si8aepM8RF5kJVAhBKSW-EbI8ismCLfdvQcdGHt7Sv-Z-73FYYxYA>
    <xmx:8Si8aZy4pXe0JiZOYXkad25dViSbpeWi58YlijNjRt-ALmGA1ilDmQ>
    <xmx:8Si8aSMcOFHx4th-FqKSlwUwKFHwCxeObGYbOtH-jA1VQ7YmczSZLg>
    <xmx:8Si8ae60qJ6qZFOMpXdj8BjGLW_EJy8WUcV3t_gAHL4T1PFKw2tPgw>
    <xmx:8Si8aZ43rzebRJ9Hi3tGFKJ8elb77QqtyqHVJXQEypXSxSm9xIEbRspx>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 19 Mar 2026 12:48:49 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Harald Nordgren <haraldnordgren@gmail.com>
Cc: git@vger.kernel.org,  gitgitgadget@gmail.com,  phillip.wood123@gmail.com
Subject: Re: [PATCH] checkout: add --autostash option for branch switching
In-Reply-To: <20260319082514.49717-1-haraldnordgren@gmail.com> (Harald
	Nordgren's message of "Thu, 19 Mar 2026 09:25:14 +0100")
References: <20260317094716.43654-1-haraldnordgren@gmail.com>
	<20260319082514.49717-1-haraldnordgren@gmail.com>
Date: Thu, 19 Mar 2026 09:48:47 -0700
Message-ID: <xmqq4imbn4sw.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Harald Nordgren <haraldnordgren@gmail.com> writes:

> Hi Junio and Jeff!
>
> Did you get a chance to look at the latest changes?
>
> The scope of this grew a lot from my original idea of auto-stashing, so I'm
> not 100% convinced that changing '-m' is necessary here. My fear is to
> break something, especially since 'checkout -m' is a feature I never used
> before touching it here, so I don't have a good sense of how it should
> work.

FWIW, I very much like what I see in 

   $ git checkout hn/git-checkout-m-with-stash && git diff @{1}

output.  It is great that we do not have to do any dry-run, because
the "real" run safely aborts, we can do the "stash && merge && unstash"
dance as a fallback instead.  All the credit goes to Phillip and you
for the idea and the execution of this.

I do use "checkout -m" a few times a week, but I do not do anything
complex with submodules or run the command with unrelated local
modifications, so there may be changes in behaviour I haven't seen
in corner cases that I do not exercise.


