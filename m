Received: from fout-b7-smtp.messagingengine.com (fout-b7-smtp.messagingengine.com [202.12.124.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B9EF19A2A3
	for <git@vger.kernel.org>; Sun, 22 Dec 2024 16:31:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734885103; cv=none; b=YiSIUuK0O6H6brddSyq3CU6esd6c2IBt2joYWYJr5HypovAVpjwXxzq+voltWHDmzwWnslw/DNqJjRuWsjAVRDExdlEGqrLzE7t3gCWyz/4EdL67g4laBiz9m896vZRXVQ5Lz8ImFrtXYAk3i+SAScsf3avPP5APeo2nZIC+seo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734885103; c=relaxed/simple;
	bh=N1W+trLhJZYikPp5Jt/pGIzYlNMlZU2XOH8CxGoqwqk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=klOarLGSpqRwQTYALXzUtYcxbo3pY6FX1cHHcDvqCFct146N0lywks4pTyNuhwFamO2ZFHU10I1CeFyypEffKB7oJ6/btvF1OQe69YjZGKEOej2jH+SMNB0zmRf3/NfFzVAN50mU7xiB0548ePM7MVo6jBfewntc5pS5p7pDy78=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=yzCAOs04; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=dC3jsX+f; arc=none smtp.client-ip=202.12.124.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="yzCAOs04";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="dC3jsX+f"
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfout.stl.internal (Postfix) with ESMTP id 583351140100;
	Sun, 22 Dec 2024 11:31:40 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-03.internal (MEProxy); Sun, 22 Dec 2024 11:31:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1734885100; x=1734971500; bh=JoKG7SSADE
	pDi25mrA+lXPbU31MoLXwH79VGapSdax0=; b=yzCAOs04U+LXfZoACPYF7fkdsR
	1uCMD64icRiehKiU9961SUTC+JkUINJuA8iOh5Lvdu2An6zeGSP0/crTwmVQC4gH
	V4DdveOj8/tvhhL6H4wLKJbdN1Fw8+GFJb8rSEhSY57O3xz2I0M76ZmxcaBe+xhZ
	Izm66FRHyZvnEWQbpomc8MgTw0s/IvN4XfeDmjj6TIi6RMcXKSW+9bD9ZdtK9D24
	RoWd1qc6tr10MrIv6sXLbgHKCnJBvbsW8c82YiEnMHQ9+TZtYEIvKtmjsWiH5o3c
	bsSE3Q/GpTNzqbTs+/UsYQXSL+/Wi0pH88IwGYV1yfX5vKBG6TZ21ajiPO+A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1734885100; x=1734971500; bh=JoKG7SSADEpDi25mrA+lXPbU31MoLXwH79V
	GapSdax0=; b=dC3jsX+fFC/FwCH1kKYa4YyL0H0rp8oUjvaPV9L+r1mamb8Vnp8
	fXDr42yYne2z9UvVjwFUlSn045XrmhX7ecnPon7IOUYRABGlp6uowe2S35yl5MMp
	rczxZjAp+UtQZYkJB9lvw32RbHt0uxSqiKKW0LLj1cVXrkMxaeP07B+SwkBXGBQh
	stZVJFyo39T71LA8qxAE6WG0zkqI658oMJh6NBH3ThF4ClVfvLn9fu+evZ2vKHGC
	uvrfLfvLgPY5ka9DhyxQwi8RFlMe3FJG6RW393OTLH2GL/yBJp62nluKF4Foj1OG
	PtdkLO8hA+ndjZEJNrZvjVfJN/+Kyvhh9Yg==
X-ME-Sender: <xms:6z5oZzZ5O0RBTxUaiGwR__WeSx6ilu6RjKq2HwcDtLXWbOB5Vrwr4g>
    <xme:6z5oZyY891VWT3pQQ7tK_3T3ZN-MIDkuAPn5NciP6ANxG_wb6UknseQmChUaH3Wry
    Y_0svA3x5cNByFA1A>
X-ME-Received: <xmr:6z5oZ18YtxjMdYJZsNWOEL6kK_GQgvO646GDjx-T6f2Uk4OhVgT15wI9KW2hPxqgUnIMzxktLB6yuED9L_Aj61CmK7NyMK3Q4w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddruddtkedgkeelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgesthdtredttdertden
    ucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogi
    drtghomheqnecuggftrfgrthhtvghrnheptedttdevffeuieeilefffedtiefgfeekveet
    veevuedtlefhtddugfeltdejledunecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenuc
    evlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgihhtshht
    vghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeehpdhmohguvgepshhmthhpoh
    huthdprhgtphhtthhopehpshesphhkshdrihhmpdhrtghpthhtohepghhithesvhhgvghr
    rdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehkrhhishhtohhffhgvrhhhrghughhssg
    grkhhksehfrghsthhmrghilhdrtghomhdprhgtphhtthhopehrrghnuggrlhhlrdgsvggt
    khgvrhesnhgvgigsrhhiughgvgdrtggrpdhrtghpthhtohepghhithhsthgvrhesphhosg
    hogidrtghomh
X-ME-Proxy: <xmx:6z5oZ5omUiRacoWkkihtm2qBXex6Lal36DlJG3hNzQMk6A7YQLH_rg>
    <xmx:6z5oZ-qP5KP4Lt4RyEmMO7nlW4naR5DcrkAt6Kckm_ouuB2lqeGTVw>
    <xmx:6z5oZ_QePDrLiQtJUi3Xg8ttRpfV9w0EoVFYFxk9vQv8_seOrY7bCA>
    <xmx:6z5oZ2r39WKd_ItFlSCoV7P4LrbKIzUxYit6fLVO2xHtPcTpcJkHkQ>
    <xmx:7D5oZ7D0Xc72GLgaPrmANAzfce2zPMnaWA7BTJAmIswNRoZUWNmq9zlY>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 22 Dec 2024 11:31:39 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org,  Kristoffer Haugsbakk
 <kristofferhaugsbakk@fastmail.com>,  "Randall S. Becker"
 <randall.becker@nexbridge.ca>
Subject: Re: [PATCH v2 0/4] reftable: fix out-of-memory errors on NonStop
In-Reply-To: <20241222-b4-pks-reftable-oom-fix-without-readers-v2-0-19550090d15a@pks.im>
	(Patrick Steinhardt's message of "Sun, 22 Dec 2024 08:24:27 +0100")
References: <20241221-b4-pks-reftable-oom-fix-without-readers-v1-0-12db83a3267c@pks.im>
	<20241222-b4-pks-reftable-oom-fix-without-readers-v2-0-19550090d15a@pks.im>
Date: Sun, 22 Dec 2024 08:31:38 -0800
Message-ID: <xmqq34ifbrx1.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Patrick Steinhardt <ps@pks.im> writes:

> Changes in v2:
>
>   - Some small touchups to commit messages.
>   - Explain why it is safe to stop auto-compacting with less than two
>     tables.
>   - Adapt `reftable_stack_reload_once()` so that we only do the minimum
>     changes required to fix issue.
>   - Link to v1: https://lore.kernel.org/r/20241221-b4-pks-reftable-oom-fix-without-readers-v1-0-12db83a3267c@pks.im
>
> Thanks!

Thanks.  All four patches looked good.

Will merge to 'next' and then to 'master'.

