Received: from fhigh-b3-smtp.messagingengine.com (fhigh-b3-smtp.messagingengine.com [202.12.124.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9017B190473
	for <git@vger.kernel.org>; Mon,  4 May 2026 00:59:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777856390; cv=none; b=kmsXXcuksl8Xf7s51BYFUJAkk6/u9kvkgvcA2aRHlR9K44CHpYuw1mke1dsbJqgZT3SiagnlgvBjr/V4BHJ4XCjTMvrVxKQEvRyUMm75nTiM3gYBDz/mR8MfRXP5RU0O1T6lvUfj4fqgkNfKgJO39YaPdbb2nE+WPgOr9Z0fCUs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777856390; c=relaxed/simple;
	bh=lXfvGBkqz16ou0ayHHKPRXsL+tpxJsbWgzj9M5aps90=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=s5qX18l0PJGQd1jOnWN1LE1SAHL7VYcRsxdQDcQxUz7gdsvjAGSPbQYcoUPRXMYew7eAaC6Eh4NAqw70TeiulQ5TBmNXhyEsQ8VbP1I0MyhXY29K/qkOAftepJetmZbZsnSCpLcHl3IaxSmmjWhagwo/8x+hH3TGrOPcHaVruaQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=dccDjdLY; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Dwc5Kz5B; arc=none smtp.client-ip=202.12.124.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="dccDjdLY";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Dwc5Kz5B"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.stl.internal (Postfix) with ESMTP id A1EE57A0049;
	Sun,  3 May 2026 20:59:48 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-04.internal (MEProxy); Sun, 03 May 2026 20:59:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1777856388; x=1777942788; bh=HkYV9zISgc
	e90taBSB5Av/EIyL7aUX5nRIjaAt0IZqc=; b=dccDjdLY1U2nTu1OGC4keH52fr
	giezFf8pECTA4DdPD+RIQkghc9ko2g032WZxA7xZdPJFGc4m8P8dp+3tiFRZU++5
	ZvN9gE7COaNnGEz181XI5wWoelCe9Ni8hCeqggOBx9loK+PZCRfsA7gMyhYFHvNC
	nO5yWfI5NQ4owtf9HKZtLiYr9PprhsdhgRCTL4yhnssufcXBDU/obopNS/h1wq8F
	4GLOD60oGERz3I7D2/IzSQ+XiKv19N38JXtP20+wvEZtXYAR2OrTIm7RUsJcLjwv
	ELP4HlfJpyuO8h+RwbYlK9Q2fTZwc1fN/ZU4qWTUd0EKxVnDFckijLDGlKMA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1777856388; x=1777942788; bh=HkYV9zISgce90taBSB5Av/EIyL7aUX5nRIj
	aAt0IZqc=; b=Dwc5Kz5BoAo7+5GTgCAtBIqpf3HujQOSkaps30zE6vP6ZisxWY5
	COZpf9fbqTMfdZSgSvuL9zLZ7HnUH19YUs2zaXHSMy8MaSouPYVj/Mt+arDMXUGM
	ngPm8DO8Ch4VlJjxRwzqi+x0SCDjEBksJEcsEYfWudMpit4JwC2nuYFNNnjagVwn
	XGPgZBixavSjnVirqDhYzRepVdAXWOdobGyB0CXnH9R6RZ2oY9YQdLUcbobhlIrf
	EKIGtOKvkZrpnyH3wf4DzKPbKVwY8op85Bj7g8Gs3lzbM1p3IUq/iYoSM8cLXLMv
	pmGeZYcfL8Huw/5XCkfzzbZ3ZJ+hjxXpygg==
X-ME-Sender: <xms:hO_3aYvCmpmFcbytIElY2Z45qj6VuM8nxWH0OsjaGdHM72DXZeFk_A>
    <xme:hO_3aSCencv7ULYJ5pLagkr0rKBFFquRWVx7Ll8FJNzVgjrlYTkKpCqDxgnLeIX98
    pknBGYTXElLnF4pdEusIVOgrYHLwN539wh057vViXkckG5rugs7hI8>
X-ME-Received: <xmr:hO_3aYNMU0dX797NHrMT7oxk4Btuz-nrNoCegfCcIoTE9CHaHYrpVunGk2KUc58hcaytyAXX60adtfijRPHJItdnkG3QmU_H9Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdeljeegiecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecuhfhrohhmpefluhhnihhoucev
    ucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtth
    gvrhhnpeefveetteejheeugeffledvteeiveffueefjeelueffteeigffgfedthfefieeg
    ieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgih
    htshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopedutddpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepphhhihhllhhiphdrfihoohguuddvfeesghhmrghilh
    drtghomhdprhgtphhtthhopehgihhtghhithhgrggughgvthesghhmrghilhdrtghomhdp
    rhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohephi
    gthhhinhdrghhithesghhmrghilhdrtghomhdprhgtphhtthhopehlrdhsrdhrseifvggs
    rdguvgdprhgtphhtthhopehpvghffhesphgvfhhfrdhnvghtpdhrtghpthhtohepsggvnh
    drkhhnohgslhgvsehgmhgrihhlrdgtohhmpdhrtghpthhtohepshiivgguvghrrdguvghv
    sehgmhgrihhlrdgtohhmpdhrtghpthhtohepvgiivghkihgvlhhnvgifrhgvnhesghhmrg
    hilhdrtghomh
X-ME-Proxy: <xmx:hO_3aSBHbojWiVL8iHwIDBgNKFx7gO_zdwZt2eGkaFRcTtgg7pz3WQ>
    <xmx:hO_3aZ7geNixNY_yddIBnViqWogj0eqG7dsqtkigLi3wtK2CNdSowA>
    <xmx:hO_3ac4O8LNOyCV5M-6S5B9YauwUPTMKO8XYzcuh9iWZ483v-KciNg>
    <xmx:hO_3abTKKyjJa1UhHj2dCVNow4WN-tdotfuXN2VRuxRRKleSRyJyMw>
    <xmx:hO_3aWdwW08IRPLgwZjDpvcE6W2fNeRScHV0M6i1ZtdVQYCff8-mC1uU>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 3 May 2026 20:59:48 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Phillip Wood <phillip.wood123@gmail.com>
Cc: Ezekiel Newren via GitGitGadget <gitgitgadget@gmail.com>,
  git@vger.kernel.org,  Yee Cheng Chin <ychin.git@gmail.com>,  =?utf-8?Q?R?=
 =?utf-8?Q?en=C3=A9?= Scharfe
 <l.s.r@web.de>,  Jeff King <peff@peff.net>,  "D. Ben Knoble"
 <ben.knoble@gmail.com>,  SZEDER =?utf-8?Q?G=C3=A1bor?=
 <szeder.dev@gmail.com>,  Ezekiel
 Newren <ezekielnewren@gmail.com>
Subject: Re: [PATCH v6 0/6] Xdiff cleanup part 3
In-Reply-To: <c8b48c6a-5a20-4981-9cd4-999b40c618fc@gmail.com> (Phillip Wood's
	message of "Thu, 30 Apr 2026 14:35:49 +0100")
References: <pull.2156.v5.git.git.1775679988.gitgitgadget@gmail.com>
	<pull.2156.v6.git.git.1777500495.gitgitgadget@gmail.com>
	<c8b48c6a-5a20-4981-9cd4-999b40c618fc@gmail.com>
Date: Mon, 04 May 2026 09:59:47 +0900
Message-ID: <xmqq8qa0q9a4.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Phillip Wood <phillip.wood123@gmail.com> writes:

> Juino - are you happy to rebase pw/xdiff-shrink-memory-consumption, or 
> do you want be to send a re-roll?

I'd rather not risk botched rebase by a third-party and prefer to
take a fresh submission by the original author.  Thanks.
