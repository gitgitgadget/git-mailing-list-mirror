Received: from fout-a3-smtp.messagingengine.com (fout-a3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11D192EBDFD
	for <git@vger.kernel.org>; Mon, 12 Jan 2026 14:22:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768227735; cv=none; b=bh/qGMskeMDafbzVvlHaQc6JtKmUVXowd61/VbJwXQgkrpiFOD3SxEJ3qYENP/jj0/brY+zBv4nzOA+Xq7kPjLNg1X3MYWZ+L/Z8w45IaJNWN2RNqcj7Z3VNV+xz4N0bdvcctn1NOZ+8xQskYrdckCZnWH9P+7RVqAFEG1VEupQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768227735; c=relaxed/simple;
	bh=cFGLwsWAeU4ZekcC/pIo9BX+JI1WTa9bNrSx156yRpk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=jyqaymiCPMtMIKQmu1JlFtoa76eIBrdY+RHnfwxdRv+JKrK5Jgsh1B3JJO9Fa5SVNJTbHlGpBmXyFQETOXWMS4lfWMk6oZ07WmcgOZ76EMn8jqo8KkVLRnY8Bc40FiGUyJfljG2G+Z1VVemEDEOwI5AeN4HFQDQpWUbJCNnMIis=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=ee//oeuB; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Hl/q20mG; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="ee//oeuB";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Hl/q20mG"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.phl.internal (Postfix) with ESMTP id 26306EC0553;
	Mon, 12 Jan 2026 09:22:13 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-01.internal (MEProxy); Mon, 12 Jan 2026 09:22:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1768227733;
	 x=1768314133; bh=td4mUQPdvTeg9Xu2qSbvX5U9rRPUGl46eypzg8cCRBQ=; b=
	ee//oeuBv7ideMc4Dv/8mgquz/+025y+kvtA4993h1xbttpB7YlEFtbvFfg6ml3A
	cKuNCM/71b4zArGguXZirn0ZZs5BV+kJ4YiT3KTP4PPrdgaju70U3+dSxjWy7b8O
	jDZK6pqr2ySWZNz8nwp06KulkRIrHTHQTHRa4RFXATNZbOqeECkh7q4uc+K6gS0w
	dARCeI0Km/taksuHHCSJkoHtGNsqhyR+WspcGjEN84XI+jygBNx/O2JiFf7RkeF1
	n5/wK6pR8zrc+Qqrfa83HKrcRlOwZLocJgl3TKX4ID1SMYkMFup3wCulRYZV5oUa
	NRpDc/V4iqZvosUXxDyLEA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1768227733; x=
	1768314133; bh=td4mUQPdvTeg9Xu2qSbvX5U9rRPUGl46eypzg8cCRBQ=; b=H
	l/q20mGWl6zzisUKjAkkAyNOejo31/XB0S9ddN7B/3EMvGhoVQ8sKjK1rk4H6urC
	YFNwDDVfjOMHQU9cd1KWZ0kI8EaRv7wmAmnCghXrXLZf/3t1/BJadOtF0vUcOvO4
	/bUwa+MpGQyMbkXWye1bPkXOwnIY25PC6cVdQNO8Y+lTPECXVaihHxe3anJWohbT
	/gOjBXoqe1fqbIZwsQ++v7P/KXPyaULU0o8raN+XiNnSC546qupT0bguxQxp6r37
	2gOcwkJn3X+uPx0ocPBGVorqhpTy++GmUly2s3+01U1311fG5kAUntVJC8SaABoA
	yolymF4F5GOkRJmq8ELsA==
X-ME-Sender: <xms:lQNlaYfrrFScOY5uhxkXTHIQtsIZT670p8pbCi0eZJMRtqFUGbf5gw>
    <xme:lQNlaRNT3v6a2EROfTUtuF3ykk7uH0yA56QKuQAhTu4qsW9MgvdDUa59RmmzUg7OC
    CmZ_jDTRn9I0bUMOob9-byWyrTSFa63-9yA-s_clyD0puDRm5U06w>
X-ME-Received: <xmr:lQNlaeh-usCJy3frXpyiOlqeSAYg_R_lG-INY_Bw1_9HGZO39amzUMYRzFTu9rLvx2j84YI7rrEp4lCrlwQo3eLESiFXwrtEDk_0OPQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdduudejieekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgfgsehtkeertddtreejnecuhfhrohhmpefluhhnihho
    ucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrg
    htthgvrhhnpedtffdvteegvddtkeetfeevueevlefgkeefheeigfehveehvdekheelveev
    fedtheenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    hgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeegpdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopehpshesphhkshdrihhmpdhrtghpthhtoheplhdrsh
    drrhesfigvsgdruggvpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhr
    ghdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:lQNlac2GbKTmHZf1l-XW3Pj4nUv4ri-4JZ5XRSRZ-7DxKX694noWdA>
    <xmx:lQNlaQjJjjth4Lsc756tcRBted14USJ_u1vchOQexkiRQ2wRRunWvQ>
    <xmx:lQNlaUcWXzZpRkU6w9FB2ix2O00F6wkHZKRyS-kP6Si-uEKRr_F-tQ>
    <xmx:lQNlablZ3zcMoV8vu5U8k_URtGrC8rcuylRFMFt0N50IL7PefaKcfQ>
    <xmx:lQNlabdIaNvyXHr2WT7GWy4N1Qe1tRQkla6xQFeYPR0JEJsZe1fETk5p>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 12 Jan 2026 09:22:12 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,  git@vger.kernel.org
Subject: Re: [PATCH 09/10] tree: stop using the_repository
In-Reply-To: <aWS9Ll8CQ3eILx3z@pks.im> (Patrick Steinhardt's message of "Mon,
	12 Jan 2026 10:21:50 +0100")
References: <20260109213021.2546-1-l.s.r@web.de>
	<20260109213021.2546-10-l.s.r@web.de> <aWS9Ll8CQ3eILx3z@pks.im>
Date: Mon, 12 Jan 2026 06:22:11 -0800
Message-ID: <xmqqh5sqoqr0.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

Patrick Steinhardt <ps@pks.im> writes:

> On Fri, Jan 09, 2026 at 10:30:20PM +0100, René Scharfe wrote:
>> Push the use of the_repository to the remaining callers by turning the
>> compatibility wrappers into macros, whose use still requires
>> USE_THE_REPOSITORY_VARIABLE to be defined.
>
> Can't we make this step a bit more explicit by adapting all callers to
> parse `repo_parse_tree()` with `the_repository`? That makes it way more
> obvious that we rely on the global repository.
>
> Edit: I see that you _do_ edit all callsites in the next commit, nice.
>
> In any case, I'd propose to move the compatibility macros into a section
> that says something like:
>
>     /* Deprecated wrappers that will be removed once Git 2.53 is released. */

Please do not take release schedule hostage to one particular fix-up
series of patches.  Thanks.

>
> We can then have a follow-up patch in a couple weeks to convert any new
> callsites that were added meanwhile and then purge the compatibility
> wrappers.
>
> Thanks!
>
> Patrick
