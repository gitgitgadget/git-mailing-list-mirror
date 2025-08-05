Received: from fhigh-a3-smtp.messagingengine.com (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C34B2749D3
	for <git@vger.kernel.org>; Tue,  5 Aug 2025 14:34:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754404486; cv=none; b=tshe60i+NVmjXyH7asi2UXQuqRnzrfj8kLgvxFxZ/nff+rpH2AJoKj65icqMWPfnVnO/djhYmsJUMApDnMkkqelgsSG4pH7ULYk0AOAvKDupnBD+6faQ4T7I2xLn31S7hrG/pbYt2MdfcllIRWIyxmbOAbM4rQmaThoOIqpc83A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754404486; c=relaxed/simple;
	bh=Zm2roIDcNybiMG2utKPsq2YCmOFuSSS8ts44YDf62N0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jvj5XMoLo6lc4vqLfXPHV8HJUrYWNOYQPSz9Z9WmUTzgl5FWH5xCv6Xy0K6mwlT7yzcYBjYqHcCsyBBUpm0YbL6ROKiWqAsXgwkWsGNUj4vHzSwUcoax96QOXbxgvE5rL0iw1AS7DEn6Xb5dKUagkUjNu+kNs2uX3nDZ8aufplw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=aq8EQ2VA; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=VoS+NWP2; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="aq8EQ2VA";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="VoS+NWP2"
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 98A1714001FD;
	Tue,  5 Aug 2025 10:34:43 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Tue, 05 Aug 2025 10:34:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1754404483; x=1754490883; bh=OufK6HZdlh
	IP739tlwQCsA/BMMpp3EkA7pN8s2XCyNw=; b=aq8EQ2VAONxSGYiFxaBiYLmP6X
	ahNjOSnTAEwDTZDDx9E0bCWoFgAP+KJY7lp6mTjqklhio/GHL16VGBTbHGJPHrHX
	bSQe8yNQ/t2zO0Yv4ZjKM2KVS/8LRmabnWlkb8g1dUDeOVChLcrm6PF/J1xtTnj1
	KadvD0cSOFL9of0drpJ3qUWlqr5MR2D0GMjecaoFkSuj9ITv9gw/k3WiCCs7Me32
	Rs6WnQGTXxFAGd1bg0Tq1QtssAnO6lBRTLv4OZVtr8L8Xh+ZeqR8GZRqEfMnB8vV
	+eP5XPovuKVs9LabfwGidDAp5HWMK4yx1X2v9Lhk30q1B5ONe/MTotvotpUg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1754404483; x=1754490883; bh=OufK6HZdlhIP739tlwQCsA/BMMpp3EkA7pN
	8s2XCyNw=; b=VoS+NWP2xMC1EYuMRo2GcV0KMVXJhJb8hhTi6CGqBDMoJsWVhFW
	s8rUNqbEB6eyY4/cnp2vphSQbdqafyB7km1ZcODa7LjyVJzBoVibdJ71fmgwPpEV
	DYgTIIq5hVEPwJIaJlHv5WDybgE793G8F+gBwe05kJ8JZ0yc7sAzH9qWh9NZBhOH
	NLfr9t4mB02NjhjEo27NP+Q5XwHyQVGGitKPCgYT+RsrnDM4U1s8/BHXYIeIQVFO
	xBIX6rW+03OmOKyJfxpEJwzMr3KiT7H/bCOqFjYoT7icynJ2h6u8Ow27CwvmkvA7
	l25mPcEynGvEYSshijANDVZY7Fx8c17+sVA==
X-ME-Sender: <xms:gxaSaL8scZJwaMpi2t3771-w-O6-Ii8LJVsMjoWRBqwmvuKTld-DxA>
    <xme:gxaSaEplBH5oJDPWycTJlk6avm4xrH96AEdzscPdr_jgjXiMONZduHSjlZtcyN4hw
    KybCmrKLGQaz1rqRw>
X-ME-Received: <xmr:gxaSaEq6AJxT-OknYdW-1dhpLlXitqq_VO609pE5yFiDpHmWGZKb8V3PnlOUoRK3d28ABP4zSUBG37EU_2bk_K38hbqKopyj21rx9zPF2g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdduudehgedvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epveekkeffhfeitdeludeigfejtdetvdelvdduhefgueegudfghfeukefhjedvkedtnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimhdpnhgspghrtghpthhtohepkedpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepphgvfhhfsehpvghffhdrnhgvthdprhgtphhtthhopehgihhtshhtvghrsehpohgsoh
    igrdgtohhmpdhrtghpthhtohepthhoohhnsehiohhttghlrdgtohhmpdhrtghpthhtohep
    ghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehkrhhishhtohhffh
    gvrhhhrghughhssggrkhhksehfrghsthhmrghilhdrtghomhdprhgtphhtthhopegthhhr
    ihhsthhirghnrdgtohhuuggvrhesghhmrghilhdrtghomhdprhgtphhtthhopehmvgesth
    htrgihlhhorhhrrdgtohhmpdhrtghpthhtohepshhtohhlvggvsehgmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:gxaSaP1bJCTG-1az_iQUaxYDA24XkbhQcWBXKsPCj2ax1l3OTYKLAQ>
    <xmx:gxaSaKF2FCJ2mf7GblL_Zf6x_jU-lcXeKvgY7tAKXKO7XifaeqFImg>
    <xmx:gxaSaCF5emLxP-VGBKt3RAzKwemg55VUOo4tQgFLKptdwISAi5vhhw>
    <xmx:gxaSaF4ZGXKz7yngx7mEPLx8iFvM_j8okKhvs0V143K2MG3mM-B-2g>
    <xmx:gxaSaBtvETzpVR843Afp4OM-CNhWz8-QWml6glzJwDVMMlYo2-y9PnSr>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 5 Aug 2025 10:34:41 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id b99c5bc4 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Tue, 5 Aug 2025 14:34:39 +0000 (UTC)
Date: Tue, 5 Aug 2025 16:34:36 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Toon Claes <toon@iotcl.com>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
	Taylor Blau <me@ttaylorr.com>, Derrick Stolee <stolee@gmail.com>,
	Christian Couder <christian.couder@gmail.com>,
	Jeff King <peff@peff.net>
Subject: Re: [PATCH v7 0/3] Introduce git-last-modified(1) command
Message-ID: <aJIWfLdMOqEL861r@pks.im>
References: <20250730175510.987383-1-toon@iotcl.com>
 <20250805093358.1791633-1-toon@iotcl.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250805093358.1791633-1-toon@iotcl.com>

On Tue, Aug 05, 2025 at 11:33:55AM +0200, Toon Claes wrote:
> Changes in v7:
> - Fix case when bloom filters were used and a commit range was given. This bug
>   was uncovered in CI.
> - Rename the long option for `-t` to `--show-trees`. This option no longer
>   implies option `-r`. And resemble these changes in the documentation, with a
>   few other small documentation tweaks.
> - Move prepare_commit_graph() into get_bloom_filter_settings() which no longer
>   requires last-modified to worry about it itself. This is similar to
>   repo_find_commit_pos_in_graph() and lookup_commit_in_graph()
> - Bring back the call to commit_graph_generation() in maybe_changed_path(). This
>   is also called in the same function in blame.c and in
>   check_maybe_different_in_bloom_filter() in revision.c. I couldn't find a test
>   case that triggers this exit condition, but it should not have negative
>   side-effects.
> - No longer call diff_free() on the copy we make when populating the `paths` of
>   `struct last_modified`. Because we weren't doing a deep copy, this could clean
>   up fields used later on by the original. Instead only call clear_pathspec(). A
>   comment to clarify this mechanism better is added.
> - Add BUG() call to exit condition that shouldn't happen.
> - Switch some int types to bool types.

This version looks good to me, thanks!

Patrick
