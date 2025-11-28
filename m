Received: from fhigh-a1-smtp.messagingengine.com (fhigh-a1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81F3E1A9FB5
	for <git@vger.kernel.org>; Fri, 28 Nov 2025 16:41:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764348064; cv=none; b=OFE/cI5kIVEw8RhPCtT/hQj0yoAQ9YWQpdgULfStkSxuajXAy9b3ARwflQ0XE0maxpyv3n9fuH+wir8nQ/5NoeSSKjtWrutVI7AoXBVZpMTph5ALfHLB3eTeLr93mDwn0eCCU4aikIr9o3YpNfmx18wCmQIQ26++xtsAZfrcdrI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764348064; c=relaxed/simple;
	bh=LkgbEizDDGuuggsm/M30lMM0BDRcDurEV9HRT2YTUms=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=UGdBLcqAzU1KliGTTnFMwqrw1sxBi2F2Rkgujs1Ut3U6HqoEBitk5zHuFkCFi3aPHHGgSzX1zRCzpGxNnUfQUpaiKXjZ00mvDxQ3T9H1oMEGRrDc+/el0bHMeOLMokgVUuKrOi4HboiyATk8Y80zW8T/E8YW12U4cNWwWE1zBVs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=CdZHWPli; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=rLEZeUMS; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="CdZHWPli";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="rLEZeUMS"
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 7496F14001FD;
	Fri, 28 Nov 2025 11:41:01 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-09.internal (MEProxy); Fri, 28 Nov 2025 11:41:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1764348061;
	 x=1764434461; bh=5TKP/S7CrcVE50EgAy0WHgjvyagpseB3/TR1M6U7J34=; b=
	CdZHWPliF7NGyDkonJQFa8pFzNttOLHPr/TpVLiL+jbZxjNBWD3FWN4ynRS4cOMU
	oh/mLAB7D+YX7pGnszU2NEwnaSeZXnFnqjlyJ7iNo9PmCNioZ0Iegigfuw5u52OB
	BKrjukLJWe3Qa5m0i06e22hjBZELEVKS9VkdnWfVljJMtLtWmDIjEPfRPbdFxvsw
	2IXTJYchQY3gt7S3+RUCR8NANPYVcyQHtoOTBKgaBzbhr5nRJ8yi5/aWvtgk2XVG
	wpKnbFPK85jKid2DKGC3C2FTZUqV1K+hQFyjgUtmGehaZFAtoouhYcE93iNUV9+x
	ETOntL4oWnIG1y9CblCdCQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1764348061; x=
	1764434461; bh=5TKP/S7CrcVE50EgAy0WHgjvyagpseB3/TR1M6U7J34=; b=r
	LEZeUMSUOleLN83mhzfwXEt4lCjzbSInZejzG9IrR+dsz7UV0okLsoviuFvcsAWn
	Akqz7SIzk7BdOoAt6lT5wAyrGfbNAO4e5NJ5o1ew4Takji8EKTTJkR/5K4+UUtmO
	SGbqIQqNU9gb7gtW13Hs93N8IJ9b6p2eydYamirCbHy9uztCHQnstBncT4KM4QE1
	WRapqaBxIQsw2aA+oF81DPawPlsKEjw4YMr1qKBhEiWOjPDq1rtBq+yxg13HufAD
	GNoFFQ7ak0wr/t9XUYZtEECI1cDCoDkvlqc1lHT572sa6/KKB/maV/txGP8jamyf
	rHC0gJXR/ARKUY1eY4NEw==
X-ME-Sender: <xms:ndApafexXCmbeEFzDF0eN2ztbSoCV_MmW5Z4urmRzG3BDxxFZ5Lydg>
    <xme:ndApacNwPok5VFos5EpEmJc_VTgXUVrsDSju1mcOMpLGIYZToyIq6pALdZpzhObrd
    lSiDOzbM2Pk4jSsdICUCD4vcQiHEPmV4_hFi99wR26Rg0FVYiiWIA>
X-ME-Received: <xmr:ndApadhCkwSXzoB2iqU1VkNYjhyu4wKegDV26tXLeobINIrwAanalpGzPaAuJdv9fblDW0P-2yn4I4-2MzwKWyxHjeTMSCLPelsX>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvhedtfeekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefhvfevufgjfhffkfgfgggtgfesthekre
    dttderjeenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhes
    phhosghogidrtghomheqnecuggftrfgrthhtvghrnheptdffvdetgedvtdekteefveeuve
    elgfekfeehiefgheevhedvkeehleevveeftdehnecuvehluhhsthgvrhfuihiivgeptden
    ucfrrghrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnh
    gspghrtghpthhtohepgedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepkhhrihhs
    thhofhhfvghrhhgruhhgshgsrghkkhesfhgrshhtmhgrihhlrdgtohhmpdhrtghpthhtoh
    epghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopegtohguvgeskhhh
    rghughhssggrkhhkrdhnrghmvgdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrd
    gtohhm
X-ME-Proxy: <xmx:ndApaf2TAQnxLYWzaYpUpm04AJBuilch95xtANHEHYCK-3ZLOiNa9Q>
    <xmx:ndApaXiGHsF94LiR8FSpckYqh8Jd_BLKePIXmHE4mOG0LveRl4d1FQ>
    <xmx:ndApafdeBfzfKq-PDHIPcqtaqrRWDESaB04t-hIWsgmFbaFCCpCWjw>
    <xmx:ndApaalsOmdPmvQRkbdFkLqBzVf0NN0SrnunVhbTNV1aG6qSoKQbgA>
    <xmx:ndApaUIDQ7_ZHrmyvf1ugNPPDleWuIT8u93kNgBcXORx6V1b3U7BpOLG>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 28 Nov 2025 11:41:00 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: kristofferhaugsbakk@fastmail.com
Cc: git@vger.kernel.org,  Kristoffer Haugsbakk <code@khaugsbakk.name>
Subject: Re: [PATCH] branch: advice using git-help(1) instead of man(1)
In-Reply-To: <advice_git-help.64@msgid.xyz>
	(kristofferhaugsbakk@fastmail.com's message of "Fri, 28 Nov 2025
	13:54:29 +0100")
References: <advice_git-help.64@msgid.xyz>
Date: Fri, 28 Nov 2025 08:40:59 -0800
Message-ID: <xmqq345yjejo.fsf@gitster.g>
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

> From: Kristoffer Haugsbakk <code@khaugsbakk.name>
>
> 8fbd903e (branch: advise about ref syntax rules, 2024-03-05) added
> an advice about checking git-check-ref-format(1) for the ref syntax
> rules. The advice uses man(1). It’s better to use Git’s own git-help(1)
> instead of an external command.

Substatiate "better" a bit better?  If there were a universal help
facility, we wouldn't have had to invent our own, and that would
have been even better, but since we do not live in such an ideal
world, we cater to people who live in a man-less land by having our
own.

In other words, "An external command" is not the issue.  Some people
living in a man-less land is.

    ... for the ref syntax rules and refers to the man(1) command,
    which may not be available on some platforms.  Refer to 'git
    help' instead.

> Also change to using single quotes (') to quote the command since that
> is more conventional.

Yup.  We haven't added markdown or asciidoc interpreter to our
advise() machinery ;-)

