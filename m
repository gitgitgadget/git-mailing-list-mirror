Received: from fhigh-b4-smtp.messagingengine.com (fhigh-b4-smtp.messagingengine.com [202.12.124.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C0563B95E7
	for <git@vger.kernel.org>; Thu, 23 Jul 2026 23:58:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784851105; cv=none; b=KftaVAEZOMFqHs8y5RodhQhXixBMv1/Pwv/08eSDx0AdwmrEmX4WfKuamM4FfG4pVjzD29aYHMjkCVPWbXVdisTDb6XQ0CFSaSKdoYJeIdB5o7LBxZEMgezPNY1W86WicgCKw+8Gc4KAuFvEignvgSVxoDJ2ybw5Kg5RF1M/V5Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784851105; c=relaxed/simple;
	bh=IGNfCMDTbojB+2U9pIAkEWvJ7qiPQSU0glqCL2fYHoY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=RuMeJkk7GOZWPFw/I/ekcRhjDulNTmB+31mp0AymEhtCRxX3elyzN7hVaFo95zo5VUTWkml9uw+ZRcV2aZjBsN8BjPRawtOE70IEJXAH46VA5V+S6BzUm6THK/vZSfRToOEzBOg51glpHnSZb36tKb3oi16n+LdY6nfNRKLEazU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=wFtVINZw; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=WvP8uu+l; arc=none smtp.client-ip=202.12.124.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="wFtVINZw";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="WvP8uu+l"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.stl.internal (Postfix) with ESMTP id D8F8B7A022A;
	Thu, 23 Jul 2026 19:58:22 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-06.internal (MEProxy); Thu, 23 Jul 2026 19:58:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1784851102; x=1784937502; bh=MOZP8XfX52
	J8+Iz8WzS1h0SNeecxYIw7pRHVYkIhrsY=; b=wFtVINZwWaqPImntKQLhp8HVl3
	0F9RXPvBpA55DIjKbc2uUHWayeQ8R/N5cFdF6/5O6Zt/Dv7XfNLTTcerKNqXz0bV
	B/z7XH1J6IniuRIWlxMsk8rJMcLc+CJFwk2qZEKycMBI7R3zfRtkeolvWtaVWlhR
	yTiUm2WWbXSNVKWzngYVLn1mdY+nWknR3R3Px0zc3EcPtQyfhYL8S8eJODQrzv6j
	Pb5wb+aqjdVOJZqqpvJfr4FemDMNrKVa5mJkfvHJMN7FbZxTCPaa25Gq1XtIaXGL
	ubqy5jBKy6ETyQkjHHmV1xUVStsMu2c66oD7xMuNjui5vBtO2IOlDKAjPqcQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1784851102; x=1784937502; bh=MOZP8XfX52J8+Iz8WzS1h0SNeecxYIw7pRH
	VYkIhrsY=; b=WvP8uu+lGk2MgEVmwowncfTB5TfvULk92R3Mbn/5CtmFwG7ao6x
	5J/OW1FTepVwKVWDIRMX0FBDSeGtGau/HPnGj8fEwYN+OKy2CKmvgFeMxbqL/lMg
	+7lasYMVmfAM5H6vsiXO45NNAuPLj2fk8Dkv4y9NqPCAEKO+9I6SZFiWriYIeNRk
	MeVC2ZP9d750VWfBgY15IMcu8eVxQmd2SPBUIp+YrwhzYNEDEM1oD3TTOyFX/TvL
	pe9U+PYg24cABxtRsb1rRCIPpk/qDdby3qiONVU81jFXRbDbBwNxWfjRB7y8U6yx
	CWT7ly9WLeBTmP+gfbb9FZLNfdCX3qSZzCw==
X-ME-Sender: <xms:nqpiajiAYIDmcpcaaAIrdM0dyIflbhFe2yUXSsmDs5ENebiLRYHvhQ>
    <xme:nqpiajspWhdegypSUyp2mpddpCsgVQY3gHCI4I7qSt5iCi46_Q4AavcuMdEu8vmH5
    udxcvpiPGgnpyPz-iy_fX3xlmYKvPIAF6I_ncfH01hbmGX4vyb-Sw>
X-ME-Received: <xmr:nqpias7qlWeAl7-lAfOVRPL41BF6zvJtZHe-rjR4mRPDcz5oYiqKgQjKNRRoxXu_VaB1Bx6uEOcQNUnGuz3s9J7lhYnBnisK7w>
X-ME-Proxy-Cause: dmFkZTEEoSXAWH3WAhwqKJVgCHdJybjyERfCP37zD3FzYE2By2JijZ/z8dubBMEWq1iS7R
    TkjMKD/moUKVdzMu3/6AsIv8Grcmptfue8Z33WfHsUG+QoZxScU9MVHYW8GdVW8y/MUV/T
    WKoFTfHpjId6hA3Zim5slttH5cajsypEGclPM5Fy7MMt21QvNsrMc3gUawQFW/uL7dJWhZ
    bfXdxFMFeDiTnQs9TxuIHA/tAJECxzgq/EiKbROitdOe12Tj98ZoxQqlRKVCvCkfoMNPVz
    XuSVoRg+bkXmM7R8rdYeQ8jO0hXi50olFB5+jwvT+Lp6TWGX+X1pt5PADUa20QM90Aw5Um
    KCG0GTyQTUJHui8cJCK/X1PQ/pOQCugAqVbR0UjVnngN6ZLj1pqVJGrtD4lCO4Ewc+1+4r
    22wdLcKluVZotNlmaK2Gr5OJ97setOMyDrhAyLb2zxLMaN4EIgAJCMkc/AH1nSG44CI9ag
    sNvgsP76Ellqn+axzuRWnDmGvQJfvFkEpSA3YjfjKT6PiswM8Ixd8AC0hy/52eZhIY8NED
    bOrk8PjxFrJwu9C+mfprqUSRA1QgLkYGYYVyXJt/+ctOu2svyCbfxm2UuuaWHiFI1MLYKA
    p5UUcc4FfiZeh7l3RX41hNB7eR2FaThVWjTpk3C5iJlulW9b2cv2yGjrxpFg
X-ME-Proxy: <xmx:nqpianN9n8kcoAIXp8xWYk_iNL8sGOjK48NVcZbOCE13HAw9_BzHDw>
    <xmx:nqpiaiuLF-qUW1kkJSYmUM9sUyPy56t180xTJQwxHxvXhgXuGzo26A>
    <xmx:nqpiaiYC4_e5F3Jw2DlVjLv34hzzv8QlMG41r4KV_zYyaqOuMPJ7MQ>
    <xmx:nqpiasyEpnyvC8Jg_NbJQNWNN6MO7_pWIZSbsSHwuaRZo7OL4YvgRA>
    <xmx:nqpiahGzg1d8-pk6teRsWbUOxzDF9U6d0kJJIDeBsqZNTBT2jyImLQdo>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 23 Jul 2026 19:58:22 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: kristofferhaugsbakk@fastmail.com
Cc: Kristoffer Haugsbakk <code@khaugsbakk.name>,  Siddharth Asthana
 <siddharthasthana31@gmail.com>,  git@vger.kernel.org,  Patrick Steinhardt
 <ps@pks.im>
Subject: Re: [PATCH v3 0/4] doc: replay: fix config link
In-Reply-To: <V3_CV_doc_replay_config.780@msgid.xyz>
	(kristofferhaugsbakk@fastmail.com's message of "Fri, 5 Jun 2026
	15:55:58 +0200")
References: <V2_CV_doc_replay_config.767@msgid.xyz>
	<V3_CV_doc_replay_config.780@msgid.xyz>
Date: Thu, 23 Jul 2026 16:58:20 -0700
Message-ID: <xmqqv7a5b6n7.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

kristofferhaugsbakk@fastmail.com writes:

> From: Kristoffer Haugsbakk <code@khaugsbakk.name>
>
> Topic name (applied): kh/doc-replay-config
>
> Topic summary: link to the config for git-replay(1) (one variable) in
> git-replay(1) and git-config(1). Also improve the doc for that config
> variable and `--ref-action`.

I was reviewing the draft of the What's Cooking report and noticed  
that this topic is among a handful of stalled efforts going nowhere.

It has been more than a month since this thread got a few good
comments by Toon Claes.  Would we see an update anytime soon?  If
not, let me mark the topic to be discarded in my draft of the
whats-cooking report.

Thanks.

