Received: from fout-b7-smtp.messagingengine.com (fout-b7-smtp.messagingengine.com [202.12.124.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70626238C03
	for <git@vger.kernel.org>; Thu, 28 Aug 2025 14:53:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756392806; cv=none; b=d9VTMRm1uo2N6fL+vdtYiZIklvm+fkPY3njgfv8cFGiE3HcN07a+YTDCcCFBcRUhgOjgJNCUUfjzV7YO8m0uMO9addbG7ede3kx70gy4YBzkC3sSW+CXcWJkuMURnjXTSmsG2ytlZ1pQL/Fa7wwCV9DLCNvW4EC0ur08lbL9trY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756392806; c=relaxed/simple;
	bh=MuT2kstOWAaIuxRcBUkcRqLpejFadMZl4MLG60txdhM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=CG4Ev5Mlb3LwoXGOJUscV1Kl7kZVnaoZhBtH9yAXkyobvsEHePWsnu/amfDfupn3pyeTcQWfZQwzaQG2Pny1dYMbIwcrg+Jb+YyV3+h2Ug4RqCzrG1iPQhlqeuepEJtQhN3kH9DzIDMjldWjQNsvnsDZN2PZXtt1Pu9jfiNGg2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=n2F+w7Nn; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=kKEEiTXx; arc=none smtp.client-ip=202.12.124.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="n2F+w7Nn";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="kKEEiTXx"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfout.stl.internal (Postfix) with ESMTP id 461111D0017B;
	Thu, 28 Aug 2025 10:53:22 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-03.internal (MEProxy); Thu, 28 Aug 2025 10:53:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1756392802; x=1756479202; bh=YXzxetj2b+
	RaG20hrFFtb2XVktsgPDr59l0Je61qr/E=; b=n2F+w7NndNZJ0t3aqbhy9TbmlQ
	j2r+y7ebLSGCp2NFfnYchgp33Bj/zNjHmf1r4O/iTbmq+LJ/IHXz9WKF/tQSvPHf
	Xf9hnRMjd9WiZdq1e0MT6fVd8cGAgmVh0lbvxnKe3WFmBycVfBmb+tJP6zD36EzS
	x2+7AvjaF0lTbnG5RcmTTM2RYoJqmmU9zNuivr+X8Z9IcE1NV0l3xyKEBWdwma8E
	HJPMqFeiNTEDoRvtq5EnlshL7gnkg31IyJ1MtMPnmJPeG1f1p6tDqeYReBk+HNtt
	mMk7HGAWw+4Tqr8vM1dVXBQ6TiSTFV8KM5Y8bN25fhb/9C78sMTB5dS3+/3w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1756392802; x=1756479202; bh=YXzxetj2b+RaG20hrFFtb2XVktsgPDr59l0
	Je61qr/E=; b=kKEEiTXx6RmEeYp5B29i2H0FE14tAP2PcWeCtaaPUw6hXZjDXSK
	LF/BtWaH0j6qpI0V+nA76c8jH3RBphXy5+2wX42c+hzXMbcq2OQiM5+PJCjPCQff
	JnFz3SpeJ15ZB1BaoGLTJPQm09ELDyD84/8eR1fjtDKhJZW7Qe3aiCiavJx4SeM9
	0SqmdJ79TzqmI6Kyy5R9gfzwl9Uhc4LVUqw/ZmfLlCtPWeA2PNyR4jFL9/ii2Bli
	JffDthqJv/9kC5UauiTwzRDzZCXdIWduQFi1gTE4MH1acWzqiHujFff49YzVvKXr
	JHUq17pS+W4zl+HxwMK/rA3OXugzfGGEhqA==
X-ME-Sender: <xms:YW2waJXmuIlTMHaTC7YBELpau-Be2IBkaNzt8Gq8px6ERdVb3rKVvg>
    <xme:YW2waGfgXRG0_obCUjm1C2GGOheS6_DuHP5xcoT2ggGpRs5qDU45awcFK62FnUXyZ
    1coTvrEVfftULfqfQ>
X-ME-Received: <xmr:YW2waFLLFfulc2lNuntC8ErqF6wAbj6eXfJ-VxKCLT3gFzKB5JSPZQVx5srbDfGJUM61f7KP8K4ICr_bq7UmU4E4yfgclcvbKl603NM>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgddukedufedvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttderjeenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepgfetheeukeejkeffheduhffglefgvdevhfelleduudduffejjefgteeltdei
    ueeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepledpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepvgeskedtgidvgedrohhrghdprhgtphhtthhopehsrg
    hnuggrlhhssegtrhhushhthihtohhothhhphgrshhtvgdrnhgvthdprhgtphhtthhopehg
    ihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepphgvfhhfsehpvghffh
    drnhgvthdprhgtphhtthhopehmvgesthhtrgihlhhorhhrrdgtohhmpdhrtghpthhtohep
    shhtohhlvggvsehgmhgrihhlrdgtohhmpdhrtghpthhtohepphhssehpkhhsrdhimhdprh
    gtphhtthhopehjrhhnihgvuggvrhesghhmrghilhdrtghomhdprhgtphhtthhopehgihht
    shhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:YW2waLxtC4oLIbYiIe9fCWHAbhy4Nl_wQgij40123qNPxx7X0JZNsA>
    <xmx:YW2waDtXZk6CacLN9Y_iC6v6oOM1gHU-yN9HTmVwUyQXED79xHSE7g>
    <xmx:YW2waGAiXbEeGzm1j3CBbq5OF6QVa0LOwzggzmPSd7pycGmot1vD7g>
    <xmx:YW2waNHJ1ZnVz0oam2jxlgi9MipddBYLfeVqLD4iy6izIGAwLASv-g>
    <xmx:Ym2waD3lOrzUu1UJWvcC72oE1HveLdMa19cJpXB0u413JI4L0uCUM9Pj>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 28 Aug 2025 10:53:21 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Eric Wong <e@80x24.org>
Cc: "brian m. carlson" <sandals@crustytoothpaste.net>,  git@vger.kernel.org,
  Jeff King <peff@peff.net>,  Taylor Blau <me@ttaylorr.com>,  Derrick
 Stolee <stolee@gmail.com>,  Patrick Steinhardt <ps@pks.im>,  Jonathan
 Nieder <jrnieder@gmail.com>
Subject: Re: Efficiently storing SHA-1 =?utf-8?Q?=E2=86=94?= SHA-256
 mappings in compatibility mode
In-Reply-To: <20250827190817.M36986@dcvr> (Eric Wong's message of "Wed, 27 Aug
	2025 19:08:16 +0000")
References: <aJ03RTHaE_JvHA1t@fruit.crustytoothpaste.net>
	<20250827190817.M36986@dcvr>
Date: Thu, 28 Aug 2025 07:53:19 -0700
Message-ID: <xmqqtt1rxzts.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Eric Wong <e@80x24.org> writes:

> I don't like SQLite's approach to rejecting outside
> contributions; but otherwise it's served me well with various
> bits of Perl code for the last 15 years or so.  Yeah, the SQLite
> developer doesn't have the highest opinion of git, but we
> shouldn't let that affect our decision making.

They're in "public domain", IIRC.  And portable than we are ;-)

> [1] Fwiw, I enjoyed working on git a lot more when it used more
>     high-level scripting glue.  I'm disappointed in the overall
>     movement towards AOT languages (C, now Rust) due to large
>     toolchains, slow builds + linkers.  Hacking was much more
>     discoverable when I could just edit installed scripts like
>     config files and not have to deal with builds at all :>

Ahh, the halcyon days...
