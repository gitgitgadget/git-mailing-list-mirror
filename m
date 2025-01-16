Received: from fhigh-b4-smtp.messagingengine.com (fhigh-b4-smtp.messagingengine.com [202.12.124.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1185B19259A
	for <git@vger.kernel.org>; Thu, 16 Jan 2025 10:01:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737021666; cv=none; b=aYGV5adNi0dXPv5W0WecOkpt1BimOY6zGFRIciGIbgPvdgiUQQAqSt3+JP5xagaQC15qax7f32YEk3vjTGW34mULoCQDIRGLEhYn5wnYJrMuUAwOgS1VKBDJhWIAFAoNpVJOcJMt0hpEWaDJxOvoTvI6/wyB71t6BJGZiY+275E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737021666; c=relaxed/simple;
	bh=XqcpkkJ36dxQUi0vNSAhefus+tlau1MUwNH6oaTePs4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KtMRlC5pKFe9UHdRQSe7ybb2itG0jN2xHytCldMDX3AhG61qMu9A9G2mOjodvxS6ruZhsYnxxTVWFRnbUnJJA2OuHHpKZ9klicITv9DnMDZhKzaxW82jW6CXe+VIjqvtDioZiB0kZ7P8fGxZe+O4PI8Ml/m1Pxr7rqusgz+rst8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=rZ0CRxKn; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=foi/0QWa; arc=none smtp.client-ip=202.12.124.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="rZ0CRxKn";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="foi/0QWa"
Received: from phl-compute-11.internal (phl-compute-11.phl.internal [10.202.2.51])
	by mailfhigh.stl.internal (Postfix) with ESMTP id C8EE72540196;
	Thu, 16 Jan 2025 05:01:01 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-11.internal (MEProxy); Thu, 16 Jan 2025 05:01:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1737021661; x=1737108061; bh=XqcpkkJ36d
	xQUi0vNSAhefus+tlau1MUwNH6oaTePs4=; b=rZ0CRxKnf896h8j5qo7C+JbA0M
	jVp/4PSA5vy2uHfHzzs9DiRSdFLwK422a6o4qAjG6bD2nv4lbYFej4RzUI+N4HSt
	QqypW8TGJ3CjNoRhM5aWb6TN2FpyX3VXzt8lJKq/xqU2ZWS968c54YVTGlFIQnol
	8D6lNa2Z2hFCjddGx0Zovp9h82507pIs9Fip5gWFKbJ01AnlH5iSCNCF+AZlfxnH
	TzXrksC3jbWT+3sh3HiVBtttMMCK77fznt8gM2VJnYHfQYqdO/JU7m4lLDlCUqa+
	mANYAR/DVmiUPO1A2STp4fJmFLS/a9wFg1x5XhNisttRDxfycrcp7oGrNOOw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1737021661; x=1737108061; bh=XqcpkkJ36dxQUi0vNSAhefus+tlau1MUwNH
	6oaTePs4=; b=foi/0QWa0ONjoo1NMe7ARP3vLMPe2V1BNEofM70RqhHnzJLHdic
	L11lH0BGxAK1uvS5N8WCOvebHmu1avJTQyeX174H7Qxs0AAhzTgjxXrHH8K/vVkH
	Sg1EbhHeWljfi9/dvKnBYLGBSbUnBwmy+MYKGhoF0V7ZP1fVeBwp6UYNo16wE8A/
	xPVEbjYYnUDZbyH/n+KacoaN18GJy6nNPxX1Y84Jq3R+TYc2y7e0FqLBCsw3PBII
	I+RF6N8FBcE2Yc8smNrcdsjNyMTfaq3U/SPAUoTZroqro3XHrTS+nHDp9FikgJaJ
	5XhVgNwOHEHuV49YFjc9omWm09NhRCmzNkg==
X-ME-Sender: <xms:3diIZ1nVxOCDqQkNlR9xckT4MWipMRhoyFDpHJFwObrqEiLnT_A6VA>
    <xme:3diIZw3pfq8KLR5JwKbHyBZu6xrz0fpkP_4stomWH8UECtmAwQhwlj4jbfrcyjwbk
    352u3hUMv4635rj1g>
X-ME-Received: <xmr:3diIZ7pAx9Nss9NVj9F6k_S8p9Yam_ANrrpthO2JuRG03x7ocNF39A5tu5IwDQaGH-FFKUhl_5x1l97WKgs3Nx3TxTLbmuI08dm1EWKk1-1tiyEg6Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudeiuddgtdelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefgueeg
    udfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepudefpdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopehjohhhrghnnhgvshdrshgthhhinhguvghlihhnse
    hgmhigrdguvgdprhgtphhtthhopehkrghrthhhihhkrddukeeksehgmhgrihhlrdgtohhm
    pdhrtghpthhtohepshhtohhlvggvsehgmhgrihhlrdgtohhmpdhrtghpthhtohepjhhohh
    hntggrihekieesghhmrghilhdrtghomhdprhgtphhtthhopehmvgesthhtrgihlhhorhhr
    rdgtohhmpdhrtghpthhtohepjhhonhgrthhhrghnthgrnhhmhiesghhoohhglhgvrdgtoh
    hmpdhrtghpthhtohepkhhrihhsthhofhhfvghrhhgruhhgshgsrghkkhesfhgrshhtmhgr
    ihhlrdgtohhmpdhrtghpthhtohepghhithhgihhtghgrughgvghtsehgmhgrihhlrdgtoh
    hmpdhrtghpthhtoheptghhrhhishhtihgrnhdrtghouhguvghrsehgmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:3diIZ1kXWWwnBpX4NhVW6doEhmWS8los6yGyK0HQVL1VY_vjEuZcvw>
    <xmx:3diIZz2rOB3ebt_Ds8I0CZvvM4jjg7S2PYCF5nZPSsZFr_v0LYWgsQ>
    <xmx:3diIZ0tTHJ5NY0VDiAbmq707K-SCdqpirhhLDdFhDC5HWJB_Mr1AZQ>
    <xmx:3diIZ3VqpgqnYUSQiIZ9rXGBcgyx2v8wnNv85GrAWhJeyzALhP3Csw>
    <xmx:3diIZ62fqq2fxll_tWH87JKrdcM4LBzruQlm3REnsP6AFP1wSJqo1_lp>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 16 Jan 2025 05:00:59 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 3dd47ec5 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 16 Jan 2025 10:00:57 +0000 (UTC)
Date: Thu, 16 Jan 2025 11:00:56 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, gitster@pobox.com, johannes.schindelin@gmx.de,
	peff@peff.net, me@ttaylorr.com, johncai86@gmail.com,
	newren@gmail.com, christian.couder@gmail.com,
	kristofferhaugsbakk@fastmail.com, jonathantanmy@google.com,
	karthik.188@gmail.com, Derrick Stolee <stolee@gmail.com>
Subject: Re: [PATCH v2 0/5] PATH WALK III: Add 'git backfill' command
Message-ID: <Z4jY2Bj-e8i9Zuig@pks.im>
References: <pull.1820.git.1733515638.gitgitgadget@gmail.com>
 <pull.1820.v2.git.1734712193.gitgitgadget@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <pull.1820.v2.git.1734712193.gitgitgadget@gmail.com>

On Fri, Dec 20, 2024 at 04:29:48PM +0000, Derrick Stolee via GitGitGadget wrote:
> This is based on v4 of ds/path-walk-1 [1] and an earlier version was part of
> my initial path-walk RFC [2].

I've got a couple more nits, but other than that I think that this
series looks quite nice.

I was wondering whether we might want to mark the new command as
experimental at first to allow us to iterate, but the last set of
commands where we have done so are still experimental many years after
they have been introduced. So... probably not a good idea.

Patrick
