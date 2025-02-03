Received: from fout-a8-smtp.messagingengine.com (fout-a8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 066ED194AEC
	for <git@vger.kernel.org>; Mon,  3 Feb 2025 16:56:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738601785; cv=none; b=F9OP4rgXicTsCMOHH3FlP1vI31n92MiVUvpVc5pghi6m8x5sEJh0CNQ8ZK4z5hhhuN32hWHBbToXXfVR/ksiBLUBxnbTMqaFRVkQHXDHN7gfgYaR1cxHxoGbRWYgPBmYC1PRSc628JoX0ztj3yRl3dZ530wmaYOmaxkAFh9LHvU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738601785; c=relaxed/simple;
	bh=p87PJqOC6VEr7tk/frbUAeKLGHO07Jn45g0XIv3Yzag=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=pBCrhc6EauFcAuNbM0R936oAnnSCT++OIfatY/Vxy/bclLI+KxddAboEBWBV6x/hqxVSvhajwZeHSgw1F5LuaDGXUg3917w+VOpSkkTSSNPeWEw3E7AfsvSjaRyTV6D9aFPX7qOdAZwAGOUwvnF5WogcS+GLfdOW1Z2orHvxLYM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=GGm4WLw/; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=NuyuSZ3B; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="GGm4WLw/";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="NuyuSZ3B"
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfout.phl.internal (Postfix) with ESMTP id DC8EB13801E6;
	Mon,  3 Feb 2025 11:56:22 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-01.internal (MEProxy); Mon, 03 Feb 2025 11:56:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1738601782;
	 x=1738688182; bh=7lPzN4+crpzr93VJWZ5pQp8roE1Axli5eaaPmIhh/Yk=; b=
	GGm4WLw/ZmsSRumAnhCFWMHMRC4T8yBkcqpf96cXMTnEHKzoWExNMIXsOHR8Ofxd
	GUyQU3Kk9YZzGstXRIiq4zN9eFs2EVCJu0Bv9Ui5Rkg5fSFqtEqU59C3SzljpVrq
	x5axqdnmQ8PHGCovnhTUbKk6J9g0JXL32cPm6u2gowgJ3Xnuvvwl3czr097mP8W7
	4RX+wREGODc9nYb8qgf7TGHToQo2qXXPzQnvF/GXbC72v4fYKDL0oeQEl/QW7As0
	fGja9iG220WjRzvnCYCW6gEA684IuOeoIaAErAOSzfhaZzfCLXayeYoGnUFJjX5m
	sHH8ZCuMsJQfuSdEgxE50Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1738601782; x=
	1738688182; bh=7lPzN4+crpzr93VJWZ5pQp8roE1Axli5eaaPmIhh/Yk=; b=N
	uyuSZ3Bf3Cc45i83WmKr8z7J5wfZ+nNBdz2U8F6wwNjz7hbkfnh8eU5SUSkTcGVM
	Eg5iW8wlljb30b3tVRJ2m5VRK8vZicCAh9ZLyG073NWLSRgrALEvHVqbjDZT0O9L
	rRNeskzcnpN7X14rlwHIJkmxxiaqko06NrQlF+pxhCi0SmIRL5oTqcLZpvu+Rl/K
	E8AR1Ab9X2KoOdg3pEXPVgU3QzllEgojAqAyDpKo1JIJO/+WBpx82CAN/vMc1xL/
	AnKANVWnzw7sXCkgbfW1PdygiWckYieI9EexrX+e62RfXMdxQq4lGiEI5dgXkEIB
	BmK1sOmS9Volz7m/v9XXQ==
X-ME-Sender: <xms:NvWgZ27yvoDUZwlxS5PxpbuKgKTHQS3vVOeVnf-CUsaCrnJs6zm5FA>
    <xme:NvWgZ_4oeoivzx-8GZjizH2VOcIBZHVbKgUCqa1AOo74tNXQby_QaD_iUWqcyPsad
    CwRBq0kiwNBalz1cw>
X-ME-Received: <xmr:NvWgZ1cAYOJe-ZE0P3LyMjYhxY_6fLZ08r-DHZP3Nj5cZZ4MxoSCdYgw6O11K1Eo-fA-ntBVBwFn1BOJwmFOeTpKQRvstD7KUoLe>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddukedugecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecunecujfgurhephffvve
    fujghffffkfgggtgfgsehtkeertddtreejnecuhfhrohhmpefluhhnihhoucevucfjrghm
    rghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtthgvrhhnpe
    dtffdvteegvddtkeetfeevueevlefgkeefheeigfehveehvdekheelveevfedtheenucev
    lhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgihhtshhtvg
    hrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeefpdhmohguvgepshhmthhpohhu
    thdprhgtphhtthhopehmrghnuhgvlhdrphhorhdrrggtrgesghhmrghilhdrtghomhdprh
    gtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepghhi
    thhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:NvWgZzK7Raob8NFLky0nfNerajOwoGhE547V2ZeLVrvhAqvT2VBG-g>
    <xmx:NvWgZ6JkO1Ccw9tMm6pUc0MjImeb2KAdNNTB-SSFr25jA7E1RwZesA>
    <xmx:NvWgZ0wB8kfcO7bRJDJ0gSTWhnjBgCCzHt2lXKq2PoGUR3n1mksldg>
    <xmx:NvWgZ-Jm4pteaHLAgwofy1uq4JjNP4k9KwFAJ1AyjF9xf3V0hoFMNw>
    <xmx:NvWgZ23EpN7n2CmcWywfJ47KkPt5gxLGkFvNaoq0y2ZC8CmXa2ZVeYyc>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 3 Feb 2025 11:56:22 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Manuel =?utf-8?Q?Qui=C3=B1ones?= <manuel.por.aca@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: Usability issue: "Your branch is up to date"
In-Reply-To: <CAPpV+OaMcViVKok5U0-4HaYyPMKEA7BBzw4t113uAaMndjs5Cg@mail.gmail.com>
	("Manuel =?utf-8?Q?Qui=C3=B1ones=22's?= message of "Mon, 3 Feb 2025
 13:45:36 -0300")
References: <CAPpV+OaMcViVKok5U0-4HaYyPMKEA7BBzw4t113uAaMndjs5Cg@mail.gmail.com>
Date: Mon, 03 Feb 2025 08:56:20 -0800
Message-ID: <xmqqh65b2ci3.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

Manuel Quiñones <manuel.por.aca@gmail.com> writes:

> that can be fetched from the remote. My proposal: Add the timestamp of
> the last fetch to the message. For example:
>
> ```
> $ git switch main
> Switched to branch 'main'
> Your branch is up to date with 'origin/main'. Last check was 2 hours ago.
> ```
>
> It looks like the timestamp of file `.git/FETCH_HEAD` would be enough
> to implement it.

Not generally.  Your last fetch may not have been about origin/main
(e.g., "git fetch origin next"), or it may even have been about a
totally different remote (e.g., "git fetch elsewhere").

The timestamp of the last entry of the reflog of origin/main may be
a lot better place to look for the information, if available.
