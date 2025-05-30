Received: from fout-a7-smtp.messagingengine.com (fout-a7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C8C9218E81
	for <git@vger.kernel.org>; Fri, 30 May 2025 20:55:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748638524; cv=none; b=sCx13jHIFmLFwUHfBea+vGdizRprAiQGdEKDx6UjQ9f2LqCuMPYO6rrTM+glRE66DldxUWS9WTdCDC9fKsxZDOt7ubOk8+vhwR1LsSoCmWnseLdYwgynsedkGvDd+IpWenN0h/nZSAxMroGtEy/HEsfWc6Qhv8yandfQkfU+UG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748638524; c=relaxed/simple;
	bh=DmI0tP0s2TUuZgEnwmxd4N7cl3kI6PNeVkg4+Yyj3FQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=DF82sJbdI1TXJNOMxxsTpWp9NZrSEpMVpQVZar/f16DsiMJfDbJfAmgPfAiq99Vw3Mazh8JCOO4zNO2f6wWxmRb/TAHmvFDmmGdaAXREFWDn/tq5tryOkwhlyQiRbL6vy0KYFba1AnKwEt2VV9oORV2aMdY6YiK3nLRbqiH6cZ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=Gelh0Xle; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=MZtMVvfT; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="Gelh0Xle";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="MZtMVvfT"
Received: from phl-compute-11.internal (phl-compute-11.phl.internal [10.202.2.51])
	by mailfout.phl.internal (Postfix) with ESMTP id 34C4F138012B;
	Fri, 30 May 2025 16:55:21 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-11.internal (MEProxy); Fri, 30 May 2025 16:55:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1748638521; x=1748724921; bh=DmI0tP0s2T
	UuZgEnwmxd4N7cl3kI6PNeVkg4+Yyj3FQ=; b=Gelh0Xlexd5twf3TnC9TY+OXDZ
	TXFXH16TftQk04tNzLWy08TO3uDzmt1KeAhyA8h/4GpZOdwoWmcFdOhVjGtNOMc3
	x2dd9laGLDeja8OLqTDBOejKTWhtzfELf4CAjAx80E8+5XG82WBB22kVKtwkuVL7
	vRSqtLUYxHvBiclKAfcgBZltYTnn67mqV0oLBnaw4fUxYz/5d2cgOWXhnY+tVaVF
	rh165AcqEgO4hdvWAfUK2ZUIpgJ3DQx1PFoSthnTCkgeFn/2rONV7Yb0KxRRwswz
	/k7Od0ngIVoGLBgszYzIMqog2X9tHZCd0WiLgjUFYVXDrnpNbMt1MoH+0KKw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1748638521; x=1748724921; bh=DmI0tP0s2TUuZgEnwmxd4N7cl3kI6PNeVkg
	4+Yyj3FQ=; b=MZtMVvfT9TaxZ8Qq7NDz4S4tguGTVDbTeqob7VKTylGl1agDh5h
	/0OQYrytHvxrrX2XsaIVoc2WLbY0DvGhjBjiUYxa0kRcAB3DZ0JqF18EJp3iHvvJ
	ZMFrFr2tX+HVYwbAtGztYFkVK2gdDY0Rz6Z3My1Sc7z7+/VaHwPlVkBvfalgFU1l
	zpJO9AXTXxZQazc38KDJfm80qz0qQV/gQD0ATG6GtGY6RN8zHGdWUHtZ6FhKSLSb
	W2Nyxib3R+KY6vUyhz8OBKbCbwKSZ/GGddLnVfsj5Pae8T9BYqD066WPu6fC9ax5
	F8UtXCDKMqn8hLNs7C3BUB5L17GC6uND/Og==
X-ME-Sender: <xms:OBs6aNThIOFtpOgGLQioPTZqqeJ7mAJNpYBtqkAFQcqW9hFdhclhEQ>
    <xme:OBs6aGy7SrVLZmMi0EHJ-rhTDLxODQM2tZTHMuPIVy4jB4-1wWq3ocw3BBeZIqc-w
    lgLnma6doYGvyv1Fw>
X-ME-Received: <xmr:OBs6aC0tJbxFhm5jBDXLBYzPRSQpLUtGLMKN4oHMIF288wFYN-bj2J6Ei8D5TBrMxwrVxpRoGg-cS31TJFGVI5ECK4PcIMZbMF5XyoU>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddtgdeftddtfeculddtuddrgeefvddrtd
    dtmdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggft
    fghnshhusghstghrihgsvgdpuffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftd
    dtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvfevufgjfhff
    kfgfgggtsehttdertddtredtnecuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoe
    hgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtthgvrhhnpeefveetteej
    heeugeffledvteeiveffueefjeelueffteeigffgfedthfefieegieenucevlhhushhtvg
    hrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgs
    ohigrdgtohhmpdhnsggprhgtphhtthhopeegpdhmohguvgepshhmthhpohhuthdprhgtph
    htthhopehprghtrhhikhdrfigvihhskhhirhgthhgvrhesnhhuthhrihgvnhhtrdhiohdp
    rhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheprg
    hpvghnfigrrhhrsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithhsthgvrhesphho
    sghogidrtghomh
X-ME-Proxy: <xmx:OBs6aFAWynIdG7-ldXIYdXAAswsUfwvz64H-XZq-ejRaHuSyK-QkQg>
    <xmx:ORs6aGgkG55y8nehpG5DLcP3EmliS3bROFUnrUOTQuhESS2yRBVeLg>
    <xmx:ORs6aJqMCvVD4GK0eoq-o-DaXL8hcX_8q9ev23yWzDfQPPQ6Li5gbw>
    <xmx:ORs6aBjLZWxyalNfCkzVDgUtzKBq4vL2P4ZwN_fITLLHk4hy32snBw>
    <xmx:ORs6aDqCeubhD5EBmoHCMtfY60TT7kwU73KJAV0QoofSw6zyz1i1Z6GD>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 30 May 2025 16:55:20 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Patrik Weiskircher <patrik.weiskircher@nutrient.io>
Cc: git@vger.kernel.org,  apenwarr@gmail.com
Subject: Re: [PATCH 0/2] contrib/subtree: Add -S/--gpg-sign option
In-Reply-To: <CANMzfzhhHX1J_vPH-DMD2kPmQ6G_6YUV=7aZ5JojGy-LU6guAQ@mail.gmail.com>
	(Patrik Weiskircher's message of "Fri, 30 May 2025 10:33:23 -0400")
References: <20250528130116.21534-1-patrik@pspdfkit.com>
	<xmqqfrgnhuuw.fsf@gitster.g>
	<CANMzfzhhHX1J_vPH-DMD2kPmQ6G_6YUV=7aZ5JojGy-LU6guAQ@mail.gmail.com>
Date: Fri, 30 May 2025 13:55:19 -0700
Message-ID: <xmqqo6v9es3s.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Patrik Weiskircher <patrik.weiskircher@nutrient.io> writes:

> This means my options become:
> 1. use --stuck-long or
> 2. make -S not take any parameter or
> 3. make -S require a parameter

4. accept "-S[<key-id>]" in stuck form, and --gpg-sign[=<key-id>]

which is a variant of #1 may be an option?

Thanks.

