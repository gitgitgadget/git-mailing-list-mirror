Received: from fout-b5-smtp.messagingengine.com (fout-b5-smtp.messagingengine.com [202.12.124.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6AAB20CCD1
	for <git@vger.kernel.org>; Thu,  7 Nov 2024 16:36:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730997420; cv=none; b=nf6sbSNiTFXGYb+z+yhbdplKdZRENQ+af8j8Ni6tBLf2MJpy0usIkNouDnaaszC68IGRl5YVTJFtwpyWlcf84DXurLshM30IDAmhYVI723YiaWRCnkX2uIS8eqpanmr47hkSL7McUKRaC4cHRRNE3TmVPRGFUtDbptYxbsAUgbI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730997420; c=relaxed/simple;
	bh=4bQ/Nn2IoGcSzGwj1Rs+IEiIyt6zl1bMYaIAi+m7+FE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=uTD2wDRgeDFuag/V36KU3ILHoFrpMHKRKeeVPXRKkVea/Z8SKBPkJ2TCCqbNhPmVJaJvjw+eYd53TqQFLNWhGQ8dd8LhbURciW7Y4WdV37SnWlOZ78YVhFQ7YGp7aPdsidLnqTDLUnP6fJr1jNdgK0P/asY9JyDPKb1Fv4mbg3M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=aPIeFLrt; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=SKMG8ZU4; arc=none smtp.client-ip=202.12.124.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="aPIeFLrt";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="SKMG8ZU4"
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfout.stl.internal (Postfix) with ESMTP id AE364114013D;
	Thu,  7 Nov 2024 11:36:56 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-01.internal (MEProxy); Thu, 07 Nov 2024 11:36:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1730997416;
	 x=1731083816; bh=3dxeSKV04LMY5fIPR6KSZEjy6q06yOKMcr1S6Ue3qFM=; b=
	aPIeFLrtbNkpCLJrrcVPX832rFwtR4riyYKDqO6sDDfRxj+MgD6L57mJT70ni6Jn
	/APa0a1mAQicdSamOQc6/G8b6ppda83QPQ3VlT9D4p01Ivg3ym+LlWczIkMpKHYZ
	PVcLrpdcvU4Y0jRCDPfwvM45yPQuRkIaiPgMJzXOzNU5ygM0TDpsWNWhJxd3L19J
	uYN17n/5z1gR4dD6YRyMtJkN1RJgmGNH64O7VQWdsle0uFnmDnvGBt2Cte24V1gM
	Qn5qDSn2/x+Q/Z5AMYyTads5J/5fRFVe033l07ydq05e5H2TSQU7/fjtu8D4XTks
	djT/cgTJ1X9GTswnNkUykA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1730997416; x=
	1731083816; bh=3dxeSKV04LMY5fIPR6KSZEjy6q06yOKMcr1S6Ue3qFM=; b=S
	KMG8ZU4K78BhTKqiLEuicKUBA/OzVD4wBE96bzpPGGy7/OUQZXiJGQcMYnmcbC3I
	CIs5Cn1UWYLmZeOrOy1yfBezkxdem4G3oQTsAgywslsTGud9sNBvzVI4DFCb71/D
	brP6X2AmHm1Hox80VPG2u2yqS9TDQDAHzOKaTGqXlsWpJyEeK5bUTIMKeBS9Clyn
	CQPYS7SvYMcSiewHwZ/Q8k2nmxYC58KQh7GxVnz8gwzfO8U/L3ZznLsWvHPZf0VX
	KJick9hBNIuKZebkQOX/fp4R6qT/ftSFxDWnw8kEdk2cMPZ/6OqRe6AhdFMvtMt0
	rllVA7K2lSsTiBRBx67ag==
X-ME-Sender: <xms:qOwsZxSZlbqn8oXd1vcvf8J916Art-TWMbdlgNV2pQdUo6McGBZHqQ>
    <xme:qOwsZ6xBoJfS3cxo7e9ORBiwqKuNEo5HC8bT7w__Vp6agpChe0hvpZvFPOxILdbHq
    3njM-zZ89peAI7e_A>
X-ME-Received: <xmr:qOwsZ23WLDQ4pRUkcHFa3yOVubgNtw9-CEAorKsbkmhOuFIbiitnBBRiZCdlOYXYrYK4Pnwd_fR_Hybyw-FJ81LYofIsuOWEgLLb>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrtdeggdeltdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecunecujfgurhephffvvefujg
    hffffkfgggtgfgsehtkeertddtreejnecuhfhrohhmpefluhhnihhoucevucfjrghmrghn
    ohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtthgvrhhnpedtff
    dvteegvddtkeetfeevueevlefgkeefheeigfehveehvdekheelveevfedtheenucevlhhu
    shhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgihhtshhtvghrse
    hpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeeipdhmohguvgepshhmthhpohhuthdp
    rhgtphhtthhopehkrhhishhtohhffhgvrhhhrghughhssggrkhhksehfrghsthhmrghilh
    drtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghp
    thhtoheptghouggvsehkhhgruhhgshgsrghkkhdrnhgrmhgvpdhrtghpthhtoheprghvrg
    hrrggssehgmhgrihhlrdgtohhmpdhrtghpthhtohepmhgvsehtthgrhihlohhrrhdrtgho
    mhdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:qOwsZ5CmHPew1ttF5TcQhk6v2AHnbVwGlpqoYLHfXid4LQ6Sms9qtQ>
    <xmx:qOwsZ6gP3J22oQU8wLLitIorab4_EFHIY5mBFybGwsbr-qZEo0iUcw>
    <xmx:qOwsZ9o2iox6kGD_LGpeVnPIKIk8NDxJLbXPi5hwV-zD-e0YvAOGXg>
    <xmx:qOwsZ1jIthNdBoqrldF5hmE7iSlC-cJn9mnOQ_tfPpz-zQpw3Ky1sA>
    <xmx:qOwsZ1VrqxMg0x4I6PFxyLJpm5NHV3sq8hvA2Pg42fgfaUldkpO98B3S>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 7 Nov 2024 11:36:56 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: kristofferhaugsbakk@fastmail.com
Cc: git@vger.kernel.org,  Kristoffer Haugsbakk <code@khaugsbakk.name>,
  avarab@gmail.com,  me@ttaylorr.com
Subject: Re: [PATCH v3 0/4] Documentation/git-bundle.txt: promote --all for
 full backup
In-Reply-To: <cover.1730979849.git.code@khaugsbakk.name>
	(kristofferhaugsbakk@fastmail.com's message of "Thu, 7 Nov 2024
	12:57:32 +0100")
References: <cover.1730234365.git.code@khaugsbakk.name>
	<cover.1730979849.git.code@khaugsbakk.name>
Date: Fri, 08 Nov 2024 01:36:54 +0900
Message-ID: <xmqqpln7q9uh.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

kristofferhaugsbakk@fastmail.com writes:

> The details are noted on the patches.
>
> Kristoffer Haugsbakk (4):
>   Documentation/git-bundle.txt: mention full backup example
>   Documentation/git-bundle.txt: remove old `--all` example
>   Documentation/git-bundle.txt: mention --all in spec. refs
>   Documentation/git-bundle.txt: discuss naïve backups

I gave them a cursory read and nothing stood out as iffy.  Looked
good.

One thing I wondered was, because it is not useful at all to take a
"backup" when the user does not know how to restore from the backup,
we may have to move things around to stress on _how_ the resulting
backup bundle(s) are used to restore the saved state.  I haven't
applied the patches to review these changes in wider context yet,
though.

Thanks.

