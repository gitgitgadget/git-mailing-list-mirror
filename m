Received: from fhigh-a1-smtp.messagingengine.com (fhigh-a1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D077626AABB
	for <git@vger.kernel.org>; Tue, 18 Feb 2025 17:14:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739898845; cv=none; b=mX6QEyLNLae4w/KZYdjED+KDPoIf1J8y7jBAhv3/XYeH04Kx2O9RtOba9miTzM6zDaEMAGoDhha5VLEhXJ2Hlo+mgCIz4+fp51zO6HTHOE02ZKw3LLe9SKWDPgPbizB0QavmT+2CygKhb6zc5xXINDAXuPeOtq1A1LoKdWft7W4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739898845; c=relaxed/simple;
	bh=oLXmHp5zKaLDPFWJ960np0ClszTY72jI5E8a8IBVeME=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=nPtFUPUTO9ajAu+vjCt7f0tXqSqDGX8QTj8a28dbSje+TfC4bj8+iMEKPg+YV5/RHQ/Ydj5Uqg7udSOZCx4JdPlf+QAfZ4lQsobdvJbE3YZzw0WRdUB7yRwMbRHpx94W/QJTe9JzmqgdfXvLJDOWLJgChSOPX3fnIQGMEVjH/oc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=eBpVpGGw; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=UH9t+sN5; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="eBpVpGGw";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="UH9t+sN5"
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id D378C1140177;
	Tue, 18 Feb 2025 12:14:02 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-06.internal (MEProxy); Tue, 18 Feb 2025 12:14:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1739898842; x=1739985242; bh=ZxnZgomEVN
	KN+3vujg/lKf5wFF+T1aF265lNizFSvlE=; b=eBpVpGGwQ9b7ARhCIQ1JNbTnos
	Dd0J/cAvqNUpnhu7bsX5UiKKeYNd/c5D0wPmaI+v//GM5+sOEKZscRWh7vVLtX5s
	bM6YEWGmtEH466Ej+H8umaOtfO6dcWwH57mXx0I1qtr/8v20115Q2zjIkIpZ2M4R
	HECXmrn6wJkRC4q9hxhJEBDGPFgxKGgclz3G+iQ2/o8aS/nCkmNVDZ8fAEELh6V5
	yiNT9mJ6axUdQkqMzqzzTgrC4SfMOzJyz2yGJKRD2+epdGdKWRCLSf4FWYOhL82U
	uPH5vG+ltP0e229qWS6eYNdznJQJc3DhiVQuRkaDenC8xzmbf1A9vXE5ec1A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1739898842; x=1739985242; bh=ZxnZgomEVNKN+3vujg/lKf5wFF+T1aF265l
	NizFSvlE=; b=UH9t+sN5ORwBiXyESkLwEnm+4l6OXuB+7RYM8kxwSFxYqgWp/Fm
	GWyhfIONcUWRBjrIHZSQcvLjicIteNsURt2ig1h/xbDZaTPbVZTPMrgIrqMjXYvc
	IQhitTlCUOv7w3A3/MAySczmEwVpsTQOxUCQk4r6tTXJ2/bXxUZATU8FAKwvxjaq
	Ztt4oGTpP+aN8ha4NXTqXXKdeaSGSrGzs+ye9b2CLvWN7F2XSwWCurb2O1KWabFP
	K7TyKfYwfn5FiA4ylNyK06X5dArMbjthWgP6wbRPcbJPoBHL4ZXGYUDxmdKUYWPn
	svaY6jblgX4HJjThvKi6H202Pb7J3j7YmiQ==
X-ME-Sender: <xms:2r-0Z-_Nw-bZyTrHbeSKlyDwNIrJbflB5iX1mYn7WZQQiewtOImVaQ>
    <xme:2r-0Z-uErY594KU_wzauJI2Das6e6xCRCJzx25ScYvI5Jnpwng10K_5_GTwe5YPYz
    yft28E7ropBpl8Vbg>
X-ME-Received: <xmr:2r-0Z0ASUe8Zsw2-HaWXS0uYpFESC2PRF5TWYMXaNOc_eSZkjzl-ka7EWM8HW6vU37ohE1eG0nRQUsQ8tiset80EiL-SdjrUP8qEi9Y>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdeiudekkecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertddtredt
    necuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsoh
    igrdgtohhmqeenucggtffrrghtthgvrhhnpeefveetteejheeugeffledvteeiveffueef
    jeelueffteeigffgfedthfefieegieenucevlhhushhtvghrufhiiigvpedtnecurfgrrh
    grmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgt
    phhtthhopeduvddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepuhhsmhgrnhgrkh
    hinhihvghmihdvtddvsehgmhgrihhlrdgtohhmpdhrtghpthhtoheptghhrhhishhtihgr
    nhdrtghouhguvghrsehgmhgrihhlrdgtohhmpdhrtghpthhtohepjhhohhgrnhhnvghsrd
    hstghhihhnuggvlhhinhesghhmgidruggvpdhrtghpthhtohepghhithesvhhgvghrrdhk
    vghrnhgvlhdrohhrghdprhgtphhtthhopehjohhhnhgtrghikeeisehgmhgrihhlrdgtoh
    hmpdhrtghpthhtohepmhgvsehtthgrhihlohhrrhdrtghomhdprhgtphhtthhopehphhhi
    lhhlihhprdifohhougesughunhgvlhhmrdhorhhgrdhukhdprhgtphhtthhopehpshesph
    hkshdrihhmpdhrtghpthhtoheprhhssggvtghkvghrsehnvgigsghrihgughgvrdgtohhm
X-ME-Proxy: <xmx:2r-0Z2exzVMWgw9G8oyVMuQFCaOC8u_Hq0M_nEPM9FcAILvrcvoNsA>
    <xmx:2r-0ZzPXLpUEOTHqkCM3QiyfReaogjuhnaaL9hBdExhnzyXQWj5p_w>
    <xmx:2r-0ZwkPNLhD8jn3_sKd4zXuOruswH5sS6K16OFjzp4BNaJyHVBEcA>
    <xmx:2r-0Z1sOllAvWeLXMrdePVcdPBduEpvo7lZgUg0akWGOJnXQ0O64Kw>
    <xmx:2r-0Z3lbHuowBinnrpVqg0GhHFLmBluf2JKie-3Kw_gBYFwGYtSYs-s5>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 18 Feb 2025 12:14:01 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Usman Akinyemi <usmanakinyemi202@gmail.com>
Cc: christian.couder@gmail.com,  Johannes.Schindelin@gmx.de,
  git@vger.kernel.org,  johncai86@gmail.com,  me@ttaylorr.com,
  phillip.wood@dunelm.org.uk,  ps@pks.im,  rsbecker@nexbridge.com,
  sunshine@sunshineco.com,  Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH v6 6/6] agent: advertise OS name via agent capability
In-Reply-To: <20250215155130.1756934-7-usmanakinyemi202@gmail.com> (Usman
	Akinyemi's message of "Sat, 15 Feb 2025 21:20:52 +0530")
References: <20250214123734.1403120-1-usmanakinyemi202@gmail.com>
	<20250215155130.1756934-1-usmanakinyemi202@gmail.com>
	<20250215155130.1756934-7-usmanakinyemi202@gmail.com>
Date: Tue, 18 Feb 2025 09:14:00 -0800
Message-ID: <xmqq5xl7yy3r.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Usman Akinyemi <usmanakinyemi202@gmail.com> writes:

> diff --git a/Documentation/gitprotocol-v2.txt b/Documentation/gitprotocol-v2.txt
> ...
>  advertise the agent capability). The `X` and `Y` strings may contain any
> -printable ASCII characters except space (i.e., the byte range 32 < x <
> -127), and are typically of the form "package/version" (e.g.,
> ...
> -the presence or absence of particular features.
> +printable ASCII characters (i.e., the byte range 33 <= x <= 126), and are
> +typically of the form "package/version-os" (e.g., "git/1.8.3.1-Linux")

THe above updates the way the byte range is expressed as inequality
but the series does not change the byte range itself.  Hence, "any
printable ASCII chavacters except space" should stay the same as-is,
without losing "except space", I would think.

No need to resend just to update this.

Thaskn.
