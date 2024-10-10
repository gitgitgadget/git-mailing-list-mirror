Received: from fhigh-a6-smtp.messagingengine.com (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A002C153
	for <git@vger.kernel.org>; Thu, 10 Oct 2024 00:52:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728521542; cv=none; b=N8aSpZldjmc8PyyKZoF4DeqwbUIKL2kr+Pt+VTwPp0EFRwO3r61r5+gegNyJGCN0Od7JSppOsrZIFu7mgGCfYrs82rS7DT0+ZcHKfGER6Us8twVwMwez0V7RkGYqBLr/Qz+VtZF+TP/E6/GiYjmxXmpBkgqt8imjj3OYEPMPwiU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728521542; c=relaxed/simple;
	bh=w8R/kisBlks3u6DK65dBpoaEGJ+59LQYg4IG0vQG5JE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=luv57+nWl4bDg/PWVCZi3VR4e6Y+0UCDgNeJzN1bJjQ52JqtrBep4TUw4hgr8zTVsoZl+FPv6VjLieuTBcADGK/Xwd1CIbXj519I5JTeVkREIg3GWkr+PAVDzvl/B0BLtuQwdhPgVTZA7Ts75YwHDcd0XJtVMTf91+KXqgbzzhI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=HwN7Gejy; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=J9fWIaXB; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="HwN7Gejy";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="J9fWIaXB"
Received: from phl-compute-09.internal (phl-compute-09.phl.internal [10.202.2.49])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 2189A1140168;
	Wed,  9 Oct 2024 20:52:19 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-09.internal (MEProxy); Wed, 09 Oct 2024 20:52:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1728521539; x=1728607939; bh=w8R/kisBlk
	s3u6DK65dBpoaEGJ+59LQYg4IG0vQG5JE=; b=HwN7Gejy//oDdGgbnujVLONNcI
	yYhXyS8YY9rppU74ocRBlxe7FWCCTrAfGYdTuxZjvdwj8dId8eNNcNB+1Dq2YtH3
	DUdL0A+jjiDkOOjD/FCg/O2KiEwdgFyFijIPd+8RaX9BG9OfjpMJ9qOTPDbGWFLK
	oril08DasPjsA8KfteAOzlVMez/C2af8JKPlL7ttaoP2ehKnjpYNJvxB0SE7wkFK
	9v3MK9QjCjZBd0yswE8Cowq7eMuTTfx1ZAoyGW9P7H4sZMQCRlQAsVMghXOG2iP8
	HYCvKy1mEJIPaT9xyWM/IY8FhaIjq6JLK2BlP7eKaN+mcO8ZCq4H5JgUaQjg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1728521539; x=1728607939; bh=w8R/kisBlks3u6DK65dBpoaEGJ+5
	9LQYg4IG0vQG5JE=; b=J9fWIaXBuSAw8hj0Q28+H82Hk9rMCsplPDvg7EAeDXGm
	oiaJLF1a0O96trPDoHxOi/ur7Gxo+WVFUgNLb6swHtvEUrU9MJwaR8QAW9hTEakK
	ajnbMsuCGoV6YZ9wnwr/cSt0fyoftg/K0eEh82Tm2RKb94/VLSKe9ln7cOZrqet3
	FGDOhMe//r5Hb/ZpVZWy2I3Svv+HMX9/U36CG2kvOXMHqV+Ix/DQK9QK6xohkjmM
	VlmX0eTKLx71ZLFw29zicmvmGyMT3WPWHq9US7ihpAGZdc5onbQmvBU9q/E0/W7G
	Alasj+uvz40PYJkmk1IP/BravuWmfwda5DfNCyQNXQ==
X-ME-Sender: <xms:QiUHZwN-eLRBvfDWXoH6yEJEoqqA_PPh6sxqN8Z2NDbbm4Ce9_M7Qg>
    <xme:QiUHZ291PiXOFChg3TMlr7twt2WcMx9H92LAYsI-gfzcfPJgd4Ob8y-PU0CRPH_ZT
    5R7oiJxCpDVVvcHtA>
X-ME-Received: <xmr:QiUHZ3QSznSyTwuevlar27ZysYcNjKg6bnT2DSOTauag1myEqWPXxcLu166Q1tDaEIaBag079w9y2rg7_CjLdSNC_qkpZxggCVbX>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdefgedggedtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgesthdtredttdertden
    ucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogi
    drtghomheqnecuggftrfgrthhtvghrnhepfeevteetjeehueegffelvdetieevffeufeej
    leeuffetiefggfeftdfhfeeigeeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrg
    hmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghp
    thhtohepudefpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehsthgvrggumhhonh
    esghhoohhglhgvrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdr
    ohhrghdprhgtphhtthhopegtrghlvhhinhifrghnsehgohhoghhlvgdrtghomhdprhgtph
    htthhopehsphgvtghtrhgrlhesghhoohhglhgvrdgtohhmpdhrtghpthhtohepvghmihhl
    hihshhgrfhhfvghrsehgohhoghhlvgdrtghomhdprhgtphhtthhopegvmhhrrghsshesgh
    hoohhglhgvrdgtohhmpdhrtghpthhtohepmhhhsehglhgrnhguihhumhdrohhrghdprhgt
    phhtthhopehsrghnuggrlhhssegtrhhushhthihtohhothhhphgrshhtvgdrnhgvthdprh
    gtphhtthhopehpshesphhkshdrihhm
X-ME-Proxy: <xmx:QiUHZ4t_JcDcT_nl_gsGlfta8ugk6OwQL9yuiL0x0iRYM5UwDLjKGA>
    <xmx:QiUHZ4f09doWhZpKmS7QlYKq6gt88_E3AppkOKNZggJGGxoTLtSJJA>
    <xmx:QiUHZ80DxTPsROrxiY-xz-03UTjht_J-WNNc45Vjg60VhvpG3NJGAA>
    <xmx:QiUHZ89d5sXiZKDd4zhUKCTPHVEHQtInexrjhdQ-JFCFVSofHFLS5A>
    <xmx:QyUHZ38R-RiffFqtgKlrAPzKX6jYWoGUBAAH6SUs0KLDIcqtS60MasBf>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 9 Oct 2024 20:52:18 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Josh Steadmon <steadmon@google.com>
Cc: git@vger.kernel.org,  calvinwan@google.com,  spectral@google.com,
  emilyshaffer@google.com,  emrass@google.com,  mh@glandium.org,
  sandals@crustytoothpaste.net,  ps@pks.im,  sunshine@sunshineco.com,
  phillip.wood123@gmail.com,  allred.sean@gmail.com
Subject: Re: [PATCH v4 5/5] Makefile: add option to build and test libgit-rs
 and libgit-rs-sys
In-Reply-To: <yynolodpcv43doqcab4bin7z7gembixqfhvqdzpcoeipnyjwl4@ek3gr4l2ycrr>
	(Josh Steadmon's message of "Wed, 9 Oct 2024 14:53:17 -0700")
References: <cover.1723054623.git.steadmon@google.com>
	<cover.1728429158.git.steadmon@google.com>
	<2ed503216f8e14d7b516c488caf3c76ffcb15697.1728429158.git.steadmon@google.com>
	<xmqq7caixhz0.fsf@gitster.g>
	<yynolodpcv43doqcab4bin7z7gembixqfhvqdzpcoeipnyjwl4@ek3gr4l2ycrr>
Date: Wed, 09 Oct 2024 17:52:16 -0700
Message-ID: <xmqq7cagok3j.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Josh Steadmon <steadmon@google.com> writes:

> Hmm, I think this may be an unfortunate interaction between Git's `make
> all`, followed by libgit-sys's `build.rs` calling make again (with
> different CFLAGS, specifically '-fvisibility=hidden') to build
> libgitpub.a. So then the second `make all` has to rebuild everything due
> to changing the CFLAGS back, and then libgit-sys has to rebuild
> libgitpub.a once again.

Ah, OK, if we need to compile in two different ways, then it is a
matter of giving a dedicated *.o build directory to each, and until
that happens, the object files for Git proper and libgit-sys would
try to stomp on each other.

I thought Patrick's build procedure update has out-of-tree build as
one of its goals, in which case we may be able to piggy-back on the
effort once it starts to stabilize.

Thanks.
