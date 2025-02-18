Received: from fhigh-a1-smtp.messagingengine.com (fhigh-a1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D34926D5DC
	for <git@vger.kernel.org>; Tue, 18 Feb 2025 17:00:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739898019; cv=none; b=ZzJYpc9biwk4HRHhbKmDYC8tEXWgmadGlO7hDkEQtc1HuQr/XrAwEGBm3qytCbPC4O2df9ulUJySE8m8eg8BgHyV7kH+aNC7hFGHaeSDNiK77xPCbI1P8G0VfDReVW9hHHB+ERyfwAYcjDonlN4mcdq3Y+fEGxRyt82wpqKfNHo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739898019; c=relaxed/simple;
	bh=6cL8bA8cPJFnHTba1qnAZhbHr6rxS4mwosiKOSGtwxs=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=kIXQ0LP1WHtPi7w+JBPcT7W/6B349GRA2Z4UCDqwcwEy1Z9O1CLDv4rtjidfCKW83k7XMuXgSZMQBTY7OeTsQT/UH5casJxHJRRDE/6I2XwWNstiivSZflyrKZhRocNt40dpYE9mpqWJGCTqdDcPLapxNquC2y11PmT44GVsMsE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=sY9bICW2; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=yZ/HHO6A; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="sY9bICW2";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="yZ/HHO6A"
Received: from phl-compute-10.internal (phl-compute-10.phl.internal [10.202.2.50])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 3DDA31140255;
	Tue, 18 Feb 2025 12:00:15 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-10.internal (MEProxy); Tue, 18 Feb 2025 12:00:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1739898015; x=1739984415; bh=bEbpxkt3ku
	E0j+zYXzzouJ+qe+g04LAdK59IqRCmS9o=; b=sY9bICW20Q8nWLDScBNBbOQQop
	RHyMP79Z0uN9nwFSuQAE0Nrw1fcaommRHeOK/F9odjDjkRwJXT9baymyQAxG8rH7
	hUnpyRhxnhKaOJNYrJJgqqsjuivRDQ64FeIlzvbl6FxtkaXO+3iLUpQ0BxyGGkwB
	cz55Ti+ciNvNRIPo42ayhtbdnPvroTs0R0pKmR6VuaEEc0m+0TQrd3nRlMGgGRG4
	KCVr0H0u4ymyu4MnvVuzR0Dx3YGsndwHP1DJd9wH7g4qMpUIexsFx0qXQ2XVAI7j
	ymz/FZsnijz+Dat1LaFkRVKDf5Xtq4jp5eFS0Uli8hobvQQ8agMTMoUuUHcw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1739898015; x=1739984415; bh=bEbpxkt3kuE0j+zYXzzouJ+qe+g04LAdK59
	IqRCmS9o=; b=yZ/HHO6Af6pMyXBT5fYy3YXWIKFIimgfrO/Ke0KxUnwCpKcwPY9
	vWL5uW5C8eFsFd5BHh9QxCneQU8cE1DPKO5cZrKlB0yJUOg7hPGSl/Ym7+p4mHxc
	5SBhJr7LxsQc4jX4TP7M+UEzGzTMqa+wHitpIbNXcCFd/EhfvZe581SRmTd5mJY6
	XVuXL0FDdZ3XAMp0sIjKO9A6c816EJn4/AxTTanU3oCMfVHu7yOGlAocB2BpD6V8
	kKPezgVkkoZ5Ax96Nfw09yoCVvBD0eyJh4PmsSmuj0Nec//67385yOAF61rXDz57
	QFmpkqZeM4DQzf8dlZqGLWcdkoe1Ki/XQTA==
X-ME-Sender: <xms:nry0ZylUBliCtfkbfo-Vfi5hNUbRcUbibcLJzvDaeI2n3TraZhVTrA>
    <xme:nry0Z53HEJbRSgOksyb1xtb83lSHF0D2HSZMhFEynvrFE8j4QHRs-JpFGi_wR7zvp
    wzjmwZpN3jbq_aS9Q>
X-ME-Received: <xmr:nry0ZwpkmBrfbDr-VlL744J9sSdKZL2wKiMEaE_pBLinJVffTj6NYygEwLSNVyku7Gklib2bmYz8gt8PcYjC86fnAm43WeaUtuMUrUI>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdeiudekhecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefhvfevufgjfhffkfgfgggtsehttdfotddtredt
    necuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsoh
    igrdgtohhmqeenucggtffrrghtthgvrhhnpeeikeeufefhtedvffdtgeefkefhffeggfef
    iedvudegfffgffffveevvdeileffudenucevlhhushhtvghrufhiiigvpedtnecurfgrrh
    grmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgt
    phhtthhopeehpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehpshesphhkshdrih
    hmpdhrtghpthhtoheprggurghmseguihhnfihoohguihgvrdhorhhgpdhrtghpthhtohep
    ghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopegrvhgrrhgrsgesgh
    hmrghilhdrtghomhdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:nry0Z2kA32YR0CYWX63LXCe5SAGQ79qgi708Qv7BcWKievgYF54jYg>
    <xmx:nry0Zw1HYdKmkoWhJEuwEqNwduSX9OI6GQyhELBstsJ6DhhnCAO5Hg>
    <xmx:nry0Z9uKI0A9IHBArkTiOezpYPkjo1OnXLv5LlXISirB0fwnI4RYXg>
    <xmx:nry0Z8VyZJw2JwSyruqCB286ky-o7IGFjg177wTG21hwRV3xP4MR2A>
    <xmx:n7y0Z0_Vk-mM3lppYyT47Ocln5zjQOggvZqq7lFqH3TCsWrXGj5Q33ky>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 18 Feb 2025 12:00:14 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: Adam Dinwoodie <adam@dinwoodie.org>,  git@vger.kernel.org,
  =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Subject: Re: [PATCH v2] Makefile: set default goals in makefiles
In-Reply-To: <Z7LZJ0tRz3iLPgmx@pks.im> (Patrick Steinhardt's message of "Mon,
	17 Feb 2025 07:37:27 +0100")
References: <xmqqy0y8ywc7.fsf@gitster.g>
	<20250215211904.41883-1-adam@dinwoodie.org> <Z7LZJ0tRz3iLPgmx@pks.im>
Date: Tue, 18 Feb 2025 09:00:12 -0800
Message-ID: <xmqqeczvyyqr.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Patrick Steinhardt <ps@pks.im> writes:

> On Sat, Feb 15, 2025 at 09:19:03PM +0000, Adam Dinwoodie wrote:
>> Explicitly set the default goal at the very top of various makefiles.
>> This is already present in some makefiles, but not all of them.
>> 
>> In particular, this corrects a regression introduced in a38edab7c8
>> (Makefile: generate doc versions via GIT-VERSION-GEN, 2024-12-06).  That
>> commit added some config files as build targets for the Documentation
>> directory, and put the target configuration in a sensible place.
>> Unfortunately, that sensible place was above any other build target
>> definitions, meaning the default goal changed to being those
>> configuration files only, rather than the HTML and man page
>> documentation.
>
> Thanks for the fix! The patch looks good to me, and I've double-checked
> that preexisting "all:" targets were all converted to "all::".

Thanks, both of you.  Will apply.
