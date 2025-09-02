Received: from fhigh-a6-smtp.messagingengine.com (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C184303C87
	for <git@vger.kernel.org>; Tue,  2 Sep 2025 11:52:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756813965; cv=none; b=f1hf13xAYTr1byF8H16zQGRgoVYMQ45bL3mIZdcBJsyZ6RmSUtL85LeDTj9m/8kEkUVkJK05cRq3xl195F8coq8zBaNfR0rFuQsyWkh5xfV68vPZElOOBDG5yV8aXvYIexnJEavc4tC0PDau9CqPHVpHweQZTbZFlahRHPWXkt8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756813965; c=relaxed/simple;
	bh=+nz3cv2PxUC1D10Og9f1nNOGOaR1VUP2kcuyjtIWa8Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HFdMx5jWo/6WD0+1Acn/nx1OkzCbEKgbEXkiCnKstUQUPse/eCJVBbIh6cRkm8z5/3vjtZMQBRWPPGYP7ZI5/iQK2NNPlCCpLKt06Qmriuy/JGYDOKiFKUCCrErMNC4A8wUHLyVSqLBD3fVRLgEF5DWo6WlPuShF+jihSqrRgIo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=WPBI0E83; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=T84tNAdR; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="WPBI0E83";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="T84tNAdR"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 0CB9414001D9;
	Tue,  2 Sep 2025 07:52:43 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Tue, 02 Sep 2025 07:52:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1756813963; x=1756900363; bh=eLidWEQULH
	hki1SdZ0sC+MCAulOf/XCQ/DRDUj0m05Q=; b=WPBI0E836GsbFXclbPMdYVJj0Y
	XjMMYc1tS2sv92CcZV/LebvUWdD6WHDK/PR5RN5+EqYCINZSDZLlXirFYrOyKPrO
	4ftPxXfOvudOMPGsNJeOwykDR2pKts83on56+/hvvpG0Gfx1uQ+YCTyHvLsxMp2Y
	FkBCSIO33/f0dyxHwWiGjOe5MpQ7a+5Lckd44/duHIgJGoTbmrdCluWGE3pJ1HLk
	Dg2U1OsCeSH5RCLwZxMT67x6YVJ1cp+tCLmh+eWyK4GPuB9/XqRl3BRF/2C0v2VA
	MJ0w+BN9gmTR+zRmmHmlUB4ZJdyoKekKQw5k7TIfNaMl3zxvM/x6ZpsE2UeQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1756813963; x=1756900363; bh=eLidWEQULHhki1SdZ0sC+MCAulOf/XCQ/DR
	DUj0m05Q=; b=T84tNAdRWqsuct1lRO95ys7FQfUI0ciRkCXOE5eGU+lEhYgGmMS
	tyogLi7k00gFI6fye+SlDYYH4yWH/J/hRjanwiHZzasZNaoZMpKiYFw0nV+PJdDJ
	iJX2xp+ftbYHKSX+7QCnuy5BLJGwC7p0tmQ18SdNX5A14n52j/hwBChIFA+8qPDb
	4AfRpi+oQZOOCbZV2DKAEM504wv7V5DuU+zoP65ATnav0dgn5I/hWIM0U7jzM2IX
	1PcpR80pHtTWUpjuYzgrqrC0hAivXdlTbiEGnTrVhI4JN8Zwu4jRTZ8YBb25GIkQ
	1gmGRNImmJeKoqYfkMEMuNBEyow0xcc2dLA==
X-ME-Sender: <xms:itq2aPZ5lbx2R9wu84hOM-vQtz-JP8zDJl4dgK4WGUzItKcPfBXaOw>
    <xme:itq2aI__6cc9mZD0ZTulSC8znzWjxl6q8WGuwtbYyKa7RFi4MHoYy9nOt-dtZD2FF
    JBnbi0KjkxXMhJ3nw>
X-ME-Received: <xmr:itq2aOhXMM0nK2wYFhp7dGMECPr2Rlwr50hsEAhixfVLWhYsvq9BlkaytxlN0qmQhF03rQd0TvsclBnb1zalXUzadYUrpZSdNKZQluDugiMANQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddulecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegrihhl
    ohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpe
    ffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefrrghtrhhitghkucfu
    thgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpeevke
    ekfffhiedtleduiefgjedttedvledvudehgfeugedugffhueekhfejvdektdenucevlhhu
    shhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrih
    hmpdhnsggprhgtphhtthhopeegpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehs
    hhgvjhhirghluhhosehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithhsthgvrhesph
    hosghogidrtghomhdprhgtphhtthhopehmvggvthhsohhniheftddujeesghhmrghilhdr
    tghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:itq2aIcTsbM6yl4NH6CfpVBknMD-eW0MghaHTy7b-vdKqyK7Acv2YQ>
    <xmx:itq2aFro-vrUVUB5ukkV0w3U5c7ea2wB4CYsH5wMGO9uR0JKq3TVKg>
    <xmx:itq2aNDdeBDqFiWt1GTbo26e9pOQzH7m_rqZT83AiaDmvCzGsopU_w>
    <xmx:itq2aCY4rJGsUjW7DUO5_DCg5THeA7n0_6Sj3kn6cJ47cB5auHSi9g>
    <xmx:i9q2aLJ3fWU5YGToVxYmrfwyt7DIh8RFLfmx-6RObMR_Sod_oPOXuRM_>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 2 Sep 2025 07:52:42 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 9cdfdbc3 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Tue, 2 Sep 2025 11:52:40 +0000 (UTC)
Date: Tue, 2 Sep 2025 13:52:36 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Meet Soni <meetsoni3017@gmail.com>
Cc: git@vger.kernel.org, shejialuo@gmail.com, gitster@pobox.com
Subject: Re: [GSoC][PATCH v3 0/4] Add refs exists subcommand
Message-ID: <aLbahNFrs9jchnXZ@pks.im>
References: <20250823060012.540433-1-meetsoni3017@gmail.com>
 <20250826064110.10540-1-meetsoni3017@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250826064110.10540-1-meetsoni3017@gmail.com>

On Tue, Aug 26, 2025 at 12:11:06PM +0530, Meet Soni wrote:
> This series introduces `git refs exists` as a modern replacement for
> `git show-ref --exists`, continuing the effort to consolidate commands
> under the `git refs` namespace.
> 
> changes in v3:
>  - Reverted commit message.
>  - nit: added empty line.

Thanks, this version looks good to me.

Patrick
