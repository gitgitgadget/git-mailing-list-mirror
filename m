Received: from fout-b3-smtp.messagingengine.com (fout-b3-smtp.messagingengine.com [202.12.124.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8EB33C6A5B
	for <git@vger.kernel.org>; Thu,  5 Mar 2026 15:50:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772725859; cv=none; b=UJAPWqpYjr5sn2hDcEixp0pajfYt936oXnXzq9c35KiY2O/Elc14kZrESyEE8WZTeJquGFMJx1GUEZaYpiFB7SZT2nN3QWq4nURlavv1HipBkaaNBtXK4xYkPpBVL785KmW9dIb1gL+cWn4itWBynzdt5jJ0stEBLAIXn9E3ooQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772725859; c=relaxed/simple;
	bh=KodHoholJwj/yc5GmEAnvuF2X19i7E2asOtp6DFkC1k=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=g0PSFoG3r9hpFL4CZSxjPrQ2txAsGj5P9IwP20yvoFgXUugX6+xGSZEYNybaKm/VV+lgIe+XbmXznylRv5IXahQmlbKjVGP6YFmn9hFoWlxt+udZXhp27ofC2wWwCwTmvmhdXO1gblvi++cOWfooLLkZDb5OrMxI22npj7lrX8M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=YcmKKvo8; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=3TCn1rOS; arc=none smtp.client-ip=202.12.124.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="YcmKKvo8";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="3TCn1rOS"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.stl.internal (Postfix) with ESMTP id E38201D00196;
	Thu,  5 Mar 2026 10:50:55 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-02.internal (MEProxy); Thu, 05 Mar 2026 10:50:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1772725855;
	 x=1772812255; bh=zYwRgwMTyNwsvjEakNThpd/zzjjiVY8yZ6QWjyNSQls=; b=
	YcmKKvo83E/RvWAzvD2P8SE3EA3XQwCBfdFDA+C78p6lWDBwJMHDGZnSF7TRxLQJ
	goRKTy9MBGs9IagX1h9zPLnlgwfWHp+mfLUKQbIEIRntTbNCjGYLNsX3Dw7E623e
	IiaKxi/FKSG+s8QRy2kWIGMSjkRGTp3MPvdWWX4dcDpDFjImt1q72FHHmxRUHvb8
	Wjx3c5phYV9Gou1xaBCVAt7ER20SNlEnt0AULMa4C79o1Rchckvx/Ofsoai1BJDq
	WHko79u5fdjnskD0JTYk03jdNQrevwbZKxMOWTCNOhYoqmjwIBgFgQhyz37Ld66/
	om8CmVXV/TCZRvw4RKa2ag==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1772725855; x=
	1772812255; bh=zYwRgwMTyNwsvjEakNThpd/zzjjiVY8yZ6QWjyNSQls=; b=3
	TCn1rOSpARQgdEJrhCX1Yn9Y/CN3q7hrsJHXpFD/vnovtj4tcC+TJMNjKlfynJuu
	E0TZZpQEIFV6ywjNenrZKsyJxkqL4suj/8SBmKKKZDDJrHmJvKG+JsyYHdc3/AX1
	4JRG9YSW4jVdUTMDD0YYdU1mdcQz3ou11JEpP+7TIfRB6hyTCi9LVEwRzhncnOdA
	/rjpYBtivwob15BdMJz9w41NCcF1Wk1Ei4hQrsQsZfQ31m7tn2MxXpJJaFGEGAVj
	6teLmfce/DTruETaz8S6JqaR6yhD1maEOZ4SEPMj2EM3m2sPIEP2l/s3WhaHXkkX
	kOADeu4HF5K0SiPbvfWBg==
X-ME-Sender: <xms:X6apaYL0d2FDMNk3hIY7FSwapBSl057o-32S8CYun07wilCjym2jKg>
    <xme:X6apafneaRtlibndeRAOisk5jOOiJrF63pPPrx_3V6gPQ_zc-BMVvGIMUJIPQOdAI
    MnY-49RA8iuDzyx_JKAsg3Uhy54XNDqbI0IGEw3IrCNgL4PzKjjJw>
X-ME-Received: <xmr:X6apaWGucXovddnzqXYOwqERk03tt2hyX_e4InEt8-YA0rsGUpqNBWD1lStal9seDE6pPFRaEKKZXYecm9Q4hoQGazPCwe5qHg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvieeijeelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgfgsehtkeertddtreejnecuhfhrohhmpefluhhnihho
    ucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrg
    htthgvrhhnpedtffdvteegvddtkeetfeevueevlefgkeefheeigfehveehvdekheelveev
    fedtheenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    hgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeefpdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopehnkhhivghsvghlsehgmhgrihhlrdgtohhmpdhrtg
    hpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehgihht
    shhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:X6apafHoSA2XvhUQV6eH4V0CzVl91uzYlBBhkkU8nAwwQDwu3KYnbQ>
    <xmx:X6apaTMw4U9n5Inb5HQhvkO8EhQN7jEst85mKdl8LkD2yRjmTmGfHg>
    <xmx:X6apaeHYxAeFHv_MkIZjPFgX4urrz6WTIWrIWUudiwPmeJ1fwCCpaw>
    <xmx:X6apaaOH6aRLR0B6F-LIL-Znv2JHAKVLBlEn9qc5Mxn2govTqNVyeA>
    <xmx:X6apaXmabRQea1VPPWkvyWLln_yqILPQOySYjSy_9MeUUWD-qLntFylT>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 5 Mar 2026 10:50:55 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Norbert Kiesel <nkiesel@gmail.com>
Cc: Git Mailing List <git@vger.kernel.org>
Subject: Re: Feature request: support listing worktrees sorted by creation time
In-Reply-To: <CAM+g_Nt8vZX4NxPvddJxNvSRgdMWQaLg2O9xzAU1pTHa=Et-gw@mail.gmail.com>
	(Norbert Kiesel's message of "Wed, 4 Mar 2026 23:14:41 -0800")
References: <CAM+g_Nt8vZX4NxPvddJxNvSRgdMWQaLg2O9xzAU1pTHa=Et-gw@mail.gmail.com>
Date: Thu, 05 Mar 2026 07:50:54 -0800
Message-ID: <xmqqqzpy46n5.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

Norbert Kiesel <nkiesel@gmail.com> writes:

> I have multiple repos with more than 20 worktrees, and sometimes
> forget the name of a recently added worktree. Therefore it would
> really be nice if I could use something like ‘git worktree list
> —created’ to list them by their creation timestamp. Is that something
> that makes sense to you as well? I could also create a pull request
> for this if you would like it.

I do not think we have any _record_ of when each of these worktrees
was created, so this is not a realistic request.

The output from "git worktree list" may be more than 20 lines, but
isn't your terminal taller than 20 lines ;-)?

Since very early days of Git, we have created .git/description file
that is not used very much (I think it is shown in gitweb).  Perhaps
worktree should have an equivalent in per-worktree part of their
.git/ directory and "git worktree list --verbose" can use its
contents in addition to the additional pieces information it already
shows, or something like that, perhaps?
