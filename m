Received: from fout-b1-smtp.messagingengine.com (fout-b1-smtp.messagingengine.com [202.12.124.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6C042DF6F6
	for <git@vger.kernel.org>; Thu, 12 Feb 2026 22:45:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770936310; cv=none; b=NC+vxUYb5gbahzQNZ9eMAncB9jT4mtYqHQf5mOEq+a2pxCtfhuUeNSgdwEn54kC5vW8pRnMnB8jXPXO89+JMVbNXhm1tlMJqgQFvQm40kP/J0jLMxU5Zl0EsF+wUrkv3Y6xx3OtDwi5FjCompLEx9j767Hr2WLbXEZAD9bvv4ic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770936310; c=relaxed/simple;
	bh=jTfBmQn2DULjCFvzWvwE2fcyo2ehCOvI66KOCYuCQ24=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=EvmfeAX8IfAwqAv/BNw53wx7C2YWc11UMnnIY6KBhs1lMSfZ7V9+g1437C4cahIDuBMN0UYhD6C3qG6HmN7adxR57XDUS4g3ZGuimym7kG2p5aP7HDy79L39cKKxx2iZpVcbiNrnfpXi8XeQ68g4feXRKJCX4PNtoJl4LoZ2nCY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=BYB83EvI; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=PsNHqx4l; arc=none smtp.client-ip=202.12.124.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="BYB83EvI";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="PsNHqx4l"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfout.stl.internal (Postfix) with ESMTP id CEB421D00129;
	Thu, 12 Feb 2026 17:45:07 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-03.internal (MEProxy); Thu, 12 Feb 2026 17:45:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1770936307; x=1771022707; bh=PJemJxFRAa
	Xpjt5MX7YdOnIgdAShF6sCqr83GfQfTw4=; b=BYB83EvIDbbw5QZ4sOfO7zqJKG
	1w0h39SBr/hiWA+E7ci+terbdmxgWwbzlroJDx+HVrdGbXamH2dVoT4bjs9fV+wf
	FczrnHzjwfjaS5SJd/q5vBObSxBS6tN2tEkgFCsxivru9E/Muxu28VADpMUKqJOi
	q00/+1cVkxp+YeXLCWGONU8p15qvdPwemszpsHoJDskosu+hX7qeqAMdl1MPe369
	MW252evYFt3gt1twfhT5BdbDdUg+T8EI50zEM2rV60Tvi51oIY0ysqOpHs3iPuNN
	nna4OjuLl3bF239zTENmBFdny17iF3ZmJhQLSGS3DQ0Gpt49aXACa256Idxg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1770936307; x=1771022707; bh=PJemJxFRAaXpjt5MX7YdOnIgdAShF6sCqr8
	3GfQfTw4=; b=PsNHqx4lgdv9fBdQUeIZf9Chlm4eOpII0m1Dh1b2g6lrFgJbqju
	psAcsBz709yKNjox4vJ37SA8gl3K/WndefHfaMcjyS7ilGWfV53pHrvT7VsPNVao
	OUK9Fk+G7wq1iDTDOk+z6RBY84TxwA8XdR8ypGfgO3E5XBcy0s8+0FC2nEzxLGhV
	Je6JDtVjLJ1uuRegAdystKUg+h7a8kSPK4sRPVcTffx2LwodNAGkPcWiJ1eE3+yZ
	9vQjApQRIAjWyJNamxamUMyRiVvbkUwt1A9uVNGNsU4KQP1pAlV3IHVidzqPf4rn
	4QaPTcgXdD/+KuPMx6BVAihEB17IbWTYsOA==
X-ME-Sender: <xms:81eOaZ4wWhlf0dHJvHnc7ne-nlXwDMCyvLMxxoscLGwLUPu9cWtNEQ>
    <xme:81eOad5n6wsbWfG9j1liiPoBNyp42yj8P54y3-Ma_6nYTzwq5EcWm6jIlD8Zliras
    SAwBWm01RW2M-LKjyq6KD7tFAWAgcuRxUhZwMSzzcBPd3oUEKu_gg>
X-ME-Received: <xmr:81eOaVe7HkW8s3LsThbfJUvYuLXXqD9-9NXL2pCQWXOG_mmbMO1UQZnfM8cdjXZ-H9aDzln-KrJt7jfZP5SjpgbRJv7hbHoLJg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvtdeiiedtucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertd
    dtredtnecuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehp
    ohgsohigrdgtohhmqeenucggtffrrghtthgvrhhnpeefveetteejheeugeffledvteeive
    ffueefjeelueffteeigffgfedthfefieegieenucevlhhushhtvghrufhiiigvpedtnecu
    rfgrrhgrmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsg
    gprhgtphhtthhopeegpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehsrghnuggr
    lhhssegtrhhushhthihtohhothhhphgrshhtvgdrnhgvthdprhgtphhtthhopegrfedvtd
    ehudehfeegudeisehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhk
    vghrnhgvlhdrohhrghdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:81eOaRD8uQkI_u9K25TQDMl9kpdW3kgrVjILL08TrqjKHmeY9Zjl_Q>
    <xmx:81eOaY_opyh5WJBfYnp8kLYBDAkbmwuvbr4GJllJ6rtKsRGOfONYGw>
    <xmx:81eOacLM2N61C-BkrKvnwNIppaEBmB83ebnavkUAFBxN8Jd3nc8MtA>
    <xmx:81eOaRiOCDEevqUScxbRxvah4H5wC2zeXKgz1HuHyQNwXezOZp9RxA>
    <xmx:81eOaZt10D7GqkEtwVBBvk19ahSEehmvSqmAwyM9spvzttIzlMRdTMv2>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 12 Feb 2026 17:45:07 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: "brian m. carlson" <sandals@crustytoothpaste.net>
Cc: Tian Yuchen <a3205153416@gmail.com>,  git@vger.kernel.org
Subject: Re: [RFC] setup: fail if .git is not a file or directory
In-Reply-To: <aY5Wid6eg1-LwZm8@fruit.crustytoothpaste.net> (brian m. carlson's
	message of "Thu, 12 Feb 2026 22:39:05 +0000")
References: <20260211182122.35352-1-a3205153416@gmail.com>
	<aY5Wid6eg1-LwZm8@fruit.crustytoothpaste.net>
Date: Thu, 12 Feb 2026 14:45:05 -0800
Message-ID: <xmqqy0kxlgy6.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"brian m. carlson" <sandals@crustytoothpaste.net> writes:

> We used to allow symlinks as well.  That was used instead of gitfiles
> for submodules at one point, I believe, and there may still be some
> people using that.  A brief test indicates that that functionality still
> works, so if we make a change here, we should be sure to accept symlinks
> as well.

In my review, I outlined a way to avoid this extra lstat(), and
instead reuse the result of stat() used in read_gitfile_gently()
already; the check in that function being stat() is exactly because
we want to follow such a symbolic link.

> In general, we should allow people to use symlinks wherever they can use
> a file or directory unless we can definitively prove that there's a
> clear security or functionality problem that cannot be avoided.  Git was
> originally written for Unix, after all.

Is this also an obvlique reference to a separate potential security
issue, I wonder.  It reminds me that I need to see if I have to ping
the thread again.

Thanks.
