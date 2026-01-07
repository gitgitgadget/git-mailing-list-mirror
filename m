Received: from fout-b4-smtp.messagingengine.com (fout-b4-smtp.messagingengine.com [202.12.124.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE1F33C0C
	for <git@vger.kernel.org>; Wed,  7 Jan 2026 03:55:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767758136; cv=none; b=RB5ijCxI+KKb5+0XZzN4Auy57dXk30K1ynnu4fxHJCGYt+BJovV2JQatE7VJ13PYoL2d4fZevZqAfm4Paxq50twh3gSnGbFV2HkuS/ebsiE2XoOmvNy3b+gubpzAfcRhPWhY4BVJ0t2obItwq5RI9dyZc/A7xHS5pJBtFpLC7QA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767758136; c=relaxed/simple;
	bh=4CFbEeitti4QDB/DXaQ9543PU+aMY20DjewpHGyqY6c=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=qHKskgHtzNsPlIu7s7pw3wuHKet8MW0NsZ+hcgEKD89OsQiP7qtCxo8fwiQ+TA7u1h1+/bN/lKJRq7h7QMJ6wVkhRDdnrRlNyGKyVZqPD4GCqUaV880eDXjQyNzY9uwyiISKfF+2TdrAeIsPrw7MGrKV2mxmYBJb/qnJk3cscE8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=FKMgLDAF; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Wp66dsTb; arc=none smtp.client-ip=202.12.124.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="FKMgLDAF";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Wp66dsTb"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.stl.internal (Postfix) with ESMTP id DC3391D000AC;
	Tue,  6 Jan 2026 22:55:33 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-06.internal (MEProxy); Tue, 06 Jan 2026 22:55:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1767758133;
	 x=1767844533; bh=oYoThzm/ygXc5kjAo9WmH9BHhOJsF8Xm5lrzqXdLwbI=; b=
	FKMgLDAFZJ80+9wvWqsS6VSTtZ/3cdJHcoAhLQBpFzgdrGock2l4o3Ahku7hbJwW
	72wJl54sr81smZbl4m2v61BCV+AgpQyNLXLBSnO6AbLJJ9hI2Ac1jdlLqnJPeoNa
	Z4cPla00deix1WUG/EaU3X6LwrDVJZewNhvhWmjT1TOLwF+SMMpoUUsIlMyhOr/Q
	DMRqGHIuaacx5RytGorMcB//x52+4dM5byzxOpkGWKIG0CeAQsSpdxBgOp7Xs89k
	29kUp3qneZ6sMdUw0rVx0T6NrJts8BlE/4J8ZMHFJ1PUhBhuzKC8n7Q+rv904IZD
	YECVPIDDXUiL7mT5DS5F2A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1767758133; x=
	1767844533; bh=oYoThzm/ygXc5kjAo9WmH9BHhOJsF8Xm5lrzqXdLwbI=; b=W
	p66dsTbtWx8U49aFZZtcFmeIDUkxsadXJ1zyV0OEpxxV3Ep2/HYvedpKxbwqn6NY
	XcZ97Zq4/pEqEsYmoOSbAYGqW/IjamfrWCleOSiFvNqgWuBdiws0bNDEDOGYYkQe
	QP6uKfh50jKqMDKftsaWY9OEPZuP3IRXMIIm3xkfojj3EGFs3Rxj6sRZYvLSwf06
	p3MtRvJlBzBNtJdCPpqusKUEDksyqDsQl1g92Cx/behVWFEABqpxVGvZkILimIId
	dumtGp3aIqolNcTQbNHBieQC/4TSlRiNMFN/NYhMBHahpdkqygF09bLPpyIhdnw3
	p2wvNdWIjpyrxXjy6b6mA==
X-ME-Sender: <xms:NdldaXPpcep0StXdlXYKCBYlPukI7XreBcS1EC6TBS3DKHL1LYqPvw>
    <xme:NdldaY2ebjXAlxI9-11SEERm53aKNlaIqIb7rpvk72oSN-Es7fextjgOeL20TYjEs
    vtaBzfSyTuIuJumhhapk1RxknX9AgraitjJ7DSBy1caacR1WH2CEQ>
X-ME-Received: <xmr:NdldaenCmjWW1PL4CbCiFUNm4beprDyM0O8zL4S1p01xzF3SSGw7yDHxqokbF3wVORDvB8xZ9xaJYlRagNc7Q-jDWm-IcfRH9Kqf59E>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddutddvtdegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgfgsehtkeertddtreejnecuhfhrohhmpefluhhnihho
    ucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrg
    htthgvrhhnpedtffdvteegvddtkeetfeevueevlefgkeefheeigfehveehvdekheelveev
    fedtheenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    hgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeehpdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopegsvghnrdhknhhosghlvgdoghhithhhuhgssehgmh
    grihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdp
    rhgtphhtthhopehjuhhlihgrsehjvhhnshdrtggrpdhrtghpthhtohepjhhnrdgrvhhilh
    grsehfrhgvvgdrfhhrpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:NdldaXV9byD-F11xf3qF3HovBt26SaEPcjrT6XZJ-VEVGFUi3I91Ow>
    <xmx:NdldactFIU0f0BBbFe750JT0h1IXmlELu12OjMplQ3XKZRR3iQuKGA>
    <xmx:NdldaSZz_yB9GVWLHI7kD1-DBqhJQzkYHxpMuSaZw0ub1mRaw3suzQ>
    <xmx:NdldaTVzef9E_tMThOuTzQjCc2RQSmWVvtmGbYDGxUl1JPAm8xAb2w>
    <xmx:NdldaZw_kcHiHRi_1d0j_ZFmPBUyZUD8seNgaAxW-4Csgs4JYWqccAsO>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 6 Jan 2026 22:55:33 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: "D. Ben Knoble" <ben.knoble+github@gmail.com>
Cc: git@vger.kernel.org,  Julia Evans <julia@jvns.ca>,  =?utf-8?Q?Jean-No?=
 =?utf-8?Q?=C3=ABl?= Avila
 <jn.avila@free.fr>
Subject: Re: [PATCH v4 0/4] doc: git-reset: clarify DESCRIPTION section
In-Reply-To: <cover.1767649692.git.ben.knoble+github@gmail.com> (D. Ben
	Knoble's message of "Mon, 5 Jan 2026 16:48:14 -0500")
References: <cover.1767307382.git.ben.knoble+github@gmail.com>
	<cover.1767649692.git.ben.knoble+github@gmail.com>
Date: Wed, 07 Jan 2026 12:55:31 +0900
Message-ID: <xmqqfr8ihya4.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

"D. Ben Knoble" <ben.knoble+github@gmail.com> writes:

> This continues Julia Evans's excellent work updating the git-reset docs.
>
> Changes in v4:
> - Adjust wording per Jean-Noël Avila's review
>
> base-commit: f229982df19c327876ce7ded40f6efefe20da5d4

Looking good.  Shall we mark it for 'next'?
