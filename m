Received: from fhigh-a1-smtp.messagingengine.com (fhigh-a1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B13411DFD8F
	for <git@vger.kernel.org>; Fri, 12 Sep 2025 21:18:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757711919; cv=none; b=cnZAhjm3ykKihie/Q0hnnf9xfL7xZJ8z6MKgSfZkH48n+UCctpoyHzqmZkiOpsH60vFdEqFC7tcDSDbJ1CoOCfIGd5phkBYmCtJx7fx0nfSFRr2hleEq6gZd8nlyLho8XnQcR5X76JAM8D12ybgyrO2w0l73d41RlCCcVycyNPo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757711919; c=relaxed/simple;
	bh=sdxMnyZiHsO9ko0y1A4/qoFJSeLJXYRwUjvygEmJkHE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=nJcljGW3MSv+l5gE3AAP/n/8qhcsw9Bcy3aJtREK25h9QQz59zfjkwAWixyeXjrNbhBem+aMbD9FqZH/B/MGMuQEz+O4PybXuWpln4xOWdQZwTDsyYbo+KtnNqTq9w2G2+gVutD5oN5c5GFR2/SKm3L8ssNQg1AiKokPiznOWFg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=xRZqwwTl; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=D55Q2knU; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="xRZqwwTl";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="D55Q2knU"
Received: from phl-compute-12.internal (phl-compute-12.internal [10.202.2.52])
	by mailfhigh.phl.internal (Postfix) with ESMTP id CEF4614001B9;
	Fri, 12 Sep 2025 17:18:36 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-12.internal (MEProxy); Fri, 12 Sep 2025 17:18:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1757711916; x=1757798316; bh=uhdWYCd91B
	PVyMA8vy8Q+JdmzKVPem8kDlLiO4AbkFI=; b=xRZqwwTlX46zdWJvO1Fu77Qp2I
	mkoQh6+TdcsUhAWgDPxE3bfxDEJXlp7DULjRIuPCwFgebqyKxDPEfkDjzk4mvEaH
	E9p07b0ob94cuz5gpelxb+3rdKTRJyXHVNpT2YY9F24uLx3t4Iz/r0/sMZmQ84F+
	PN4lXIVp/rUzVnLFGguX0s1J95nlfhgy2n3pidxGe5w5zUj/vEJru3brfrQA7tq7
	2ahOR6s19rpdYrIgUyyg+ni4NAgQhOZg3E3N3xZhMNBlaCSRtVts9yieilFHIkpK
	g6cEqpU5QFRPAuvVbbTBi+XttRea1EmoszYIjh4nDxrEb0fo3GBsachtmITw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1757711916; x=1757798316; bh=uhdWYCd91BPVyMA8vy8Q+JdmzKVPem8kDlL
	iO4AbkFI=; b=D55Q2knUWUwv9kxm6kmkN1KbgDxFudNlqONKYAvZtduBinoPWvc
	20vna/JC75KE60PznLuc4kdM5Pb0tX3fpMsmXvkyPNngQwb0vVdMH24zp7Cr6Wj4
	xN8J1LfLDwZXURYWuVeuRBBDoTCi+b9bYBSGg9y5g+0kELFfRfy+/mNt1Rr8FjJs
	aNT/4fn+kSfULWuUDM/g+o4CiFausgOuVJvWCMF8xqV7ggUSF72YSgMBAISv13dW
	z5gQh7G4nfT/eINpnpMiPQLXiWx8yAgvDCdB0g8wKvF/zO5uCr8EAbAQr13/g1wl
	pJI/IRtNW87KugOZoJikeIsUWB7vl9Wu3xw==
X-ME-Sender: <xms:LI7EaL5A4HaaptefeM6yWaebroVHIA0052gDLL3LHJPZSUiN_XnJDQ>
    <xme:LI7EaJWfkdOcarnwpKM-MONO5zEqAe9IaKtJZKG1wkpyrKl8ZsUw5trIV3TiBCREh
    qE8rao7ytQN7GwI5A>
X-ME-Received: <xmr:LI7EaC5AqiEluETaGdvlR_0Uy-xgMzYGhv0MkrvQTjt8snqBcP95JI-F6FJkFf0JaiKicgH-VNke040PXpmMrecShHq_6-7oyeUlk_s>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdeftdduudcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecuhfhrohhmpefluhhnihhoucev
    ucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtth
    gvrhhnpeefveetteejheeugeffledvteeiveffueefjeelueffteeigffgfedthfefieeg
    ieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgih
    htshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeeipdhmohguvgepshhm
    thhpohhuthdprhgtphhtthhopehgihhtghhithhgrggughgvthesghhmrghilhdrtghomh
    dprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohep
    sggvnhdrkhhnohgslhgvsehgmhgrihhlrdgtohhmpdhrtghpthhtohepkhhrihhsthhofh
    hfvghrhhgruhhgshgsrghkkhesfhgrshhtmhgrihhlrdgtohhmpdhrtghpthhtohepjhhu
    lhhirgesjhhvnhhsrdgtrgdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtoh
    hm
X-ME-Proxy: <xmx:LI7EaMp2BMD2kv3shT-UXUD5I5hbrmRpq9I_u-b-DLQ9cpEB-jDclw>
    <xmx:LI7EaNkuCALulzlsEKMFpZxmLFAAI7lQEdZoqgxSgXVEECF8LU6Xuw>
    <xmx:LI7EaANfp6MhISESMUSxax2EDI_kaeRslUs_Y1aVWafho1d4QIhDzg>
    <xmx:LI7EaJMqMj33HxSzfBsPQJXBL1XAa2R_teHpffEfyGd3LAG10ios3g>
    <xmx:LI7EaEfMiRWAYXI_J_i4odplvXoyGEM7qyQwnrBaUTNYC1qULBfNmdWc>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 12 Sep 2025 17:18:36 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "Julia Evans via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  "D. Ben Knoble" <ben.knoble@gmail.com>,
  Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,  Julia Evans
 <julia@jvns.ca>
Subject: Re: [PATCH v2 3/4] doc: git-push: clarify "where to push"
In-Reply-To: <374740c678a62edd5cb5bace7517a36ce7ac00b5.1757703309.git.gitgitgadget@gmail.com>
	(Julia Evans via GitGitGadget's message of "Fri, 12 Sep 2025 18:55:08
	+0000")
References: <pull.1964.git.1756240823.gitgitgadget@gmail.com>
	<pull.1964.v2.git.1757703309.gitgitgadget@gmail.com>
	<374740c678a62edd5cb5bace7517a36ce7ac00b5.1757703309.git.gitgitgadget@gmail.com>
Date: Fri, 12 Sep 2025 14:18:35 -0700
Message-ID: <xmqq5xdnl68k.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Julia Evans via GitGitGadget" <gitgitgadget@gmail.com> writes:

> -When the command line does not specify where to push with the
> -`<repository>` argument, `branch.*.remote` configuration for the
> -current branch is consulted to determine where to push.  If the
> -configuration is missing, it defaults to 'origin'.
> +To decide which repository to push to, Git uses the `<repository>`
> +argument (for example `git push dev`), then if that's not specified the
> +upstream configuration for the current branch, and then defaults
> +to `origin`.

OK.  Much less awkward and much clearer.  Nice.
