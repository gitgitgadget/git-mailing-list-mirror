Received: from fhigh-a5-smtp.messagingengine.com (fhigh-a5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F2971AC435
	for <git@vger.kernel.org>; Thu, 27 Feb 2025 17:01:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740675714; cv=none; b=D++ITdmCeeAs/e+gcG5fReWffV+2Yd05I2Sb1J+vFpe9xsUY6MEERTdQ3dsCGHwUh9g7kwQx0pVvfIEb7tPtU6F4eGDXaCJN/rTR/UIJc8TbburkAC/giS4BO2Bbrld4GjpolfpKGXW92n+5Cvo5JaTXVkt5LZ2r37srmuGw9hg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740675714; c=relaxed/simple;
	bh=YMhsuLkF6KE7khAVVw6MazdudKJu622Cgerr0Yc12PA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=RuBFiEUcw/NDejXFSJIPJtZLRHLQXmYsDPOnf0qd0ILnUHKE8T79ieXeQI1ssBq4W5KBPc9z20zJ/0jTFRtSn+boNH0DBfXMJcvXUdJdZaDNNaT9rNWE8qWRusRiy2wVrlrr43r3aK/MQSTTmYmaeXCbncro0Ncl5nHFj3/uHm0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=UCiBHKAu; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=fZ+lWCUr; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="UCiBHKAu";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="fZ+lWCUr"
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 4C55D1140B5F;
	Thu, 27 Feb 2025 12:01:51 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-06.internal (MEProxy); Thu, 27 Feb 2025 12:01:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1740675711; x=1740762111; bh=7ycZbYI9MZ
	qLCI2zqRNAtjl3FaPUzMXIracP8EjciwU=; b=UCiBHKAuKcFaakSeMgRjq0XlaO
	mb6HPD+H+Xidmtv7IX6ttZoqXKEJfosYvr2H0aEXH0nLOWYo3Ho4Yx8RsWM2y8Lk
	wUHcsLIQKeSDVqitJiIWcg3RXx3Bctv/QG0g3xwUuiwjj0gseZ1/i+UkA044tttr
	1F6/8EZDSMw9Xi73qYYBcnCw4LMxkyDqsqLbE9Q0TWOsifC6dk2QqarFOmZNusI6
	WCPvTsRwSqrpkOgkwAR3rxktNRHW0UiZCZxPQzUbZAfy6P2N2T9eXxFl8IjvY3ww
	B+68GmsH+1QKVQSX3YlWDLJnl7mio8Q4hDyLTDwXvGvlJsZbjlmX7fGAv60w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1740675711; x=1740762111; bh=7ycZbYI9MZqLCI2zqRNAtjl3FaPUzMXIrac
	P8EjciwU=; b=fZ+lWCUr49DfX3dX/XB9AZSypmLPRItja7oQqHGPU+uH1r1NboN
	wkwFMiz9Yf1bdtEtK1yq+/d9FdgwH3pk2T0HNpCRIrg/trWnmDH2NmiGiWVknAtH
	JgJZneCI+/DE5BJclFQAIkE03sKi7lm1fMQn5j+YusLidBKWtOc4laaDOizdY7cM
	9saXDE25Kd0OozAtGivD5lAPrc9+LPey+E8z+SiAAxRGgqGUojw8pR8Heicj7mn0
	Vs0//+SR6dEk+g09h9SM2DiqZ70Ce1Wb2qCjDdIMBrGtQV7cabTAW+7YfD+O+TAx
	pA7WWORgX20+MLYPcMVVmV7lNW9bmUkXeLg==
X-ME-Sender: <xms:fprAZwO28vOuQeTcmon48R2lZSBQEVeO6HgQObaNL1n0PA35qXB9hg>
    <xme:fprAZ29NmJpv417tvV_FhAJ_FMdTs0Kg0Hg3qpM2dhX1DwD8ecu-D9wlEngq1tQQK
    ohoADJXEVjhoDY3bA>
X-ME-Received: <xmr:fprAZ3QKH0RbSOj8mo_xxwmH_xv5YkplufvUdtgeds5bw43D7yXXhBES-KPJk5WuAzHZPudpMMwoBE_4oFKji3v04ck71yXkzgX_>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdekkedtudcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertddtredt
    necuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsoh
    igrdgtohhmqeenucggtffrrghtthgvrhhnpeefveetteejheeugeffledvteeiveffueef
    jeelueffteeigffgfedthfefieegieenucevlhhushhtvghrufhiiigvpedtnecurfgrrh
    grmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgt
    phhtthhopeehpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehpshesphhkshdrih
    hmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthho
    pedvtddvheesuhigphdruggvpdhrtghpthhtohepshhtohhlvggvsehgmhgrihhlrdgtoh
    hmpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:fprAZ4sXb2R3VdIO40CMDVfeR63xtJPITLcbuXbaqWjAJu5aliJslg>
    <xmx:fprAZ4es2wzqZH3F9zI2rTcLV65ZcMvHquowP67QGk8erZMDxA31kw>
    <xmx:fprAZ81b5HUtQbcKPjjZ0HLPFr-y3jfXTadEkuIk0T_FkBtVOGkEiQ>
    <xmx:fprAZ8_VTjaN6ezFW7iE6yWN8jsG9KVtX38JPdQBrxIiPZH-9e9urw>
    <xmx:f5rAZ9HiYwRpdz85TCbDG9WywJs4Y3APixktAmlovyxduVB4JJhGsqxB>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 27 Feb 2025 12:01:50 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org,  Markus Gerstel <2025@uxp.de>,  Derrick Stolee
 <stolee@gmail.com>
Subject: Re: [PATCH 0/6] builtin/maintenance: introduce "reflog-expire" task
In-Reply-To: <Z8Auzjw29t91tEuq@pks.im> (Patrick Steinhardt's message of "Thu,
	27 Feb 2025 10:22:22 +0100")
References: <20250226-pks-maintenance-reflog-expire-v1-0-a1204a814952@pks.im>
	<xmqqikow9o5d.fsf@gitster.g> <Z8Auzjw29t91tEuq@pks.im>
Date: Thu, 27 Feb 2025 09:01:49 -0800
Message-ID: <xmqq8qpr9v9e.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Patrick Steinhardt <ps@pks.im> writes:

> On Wed, Feb 26, 2025 at 05:23:10PM -0800, Junio C Hamano wrote:
>> Patrick Steinhardt <ps@pks.im> writes:
>> 
>> > this patch series introduces a new "reflog-expire" task to
>> > git-maintenance(1). This task is designed to plug a gap when the "gc"
>> > task is disabled, as there is no way to expire reflog entries in that
>> > case.
>> 
>> I think in the longer run, "maintenance" users should be able to
>> treat the single ball of wax "gc" task as a mere short-hand to
>> invoke a set of often used maintenance tasks, and we would want to
>> break down the component tasks grouped in it and make them
>> independently available.  This is a good step along that journey.
>> 
>> Are there other things that the "gc" task covers that are not
>> available elsewhere?  "git gc --help" suggests there are things
>> related to pruning (unused?) worktrees and stale rerere database
>> entries.
>
> These are more gaps indeed. I'm happy to work on them once this patch
> series has landed. I don't know about any other gaps.

Or maybe leave breadcrumbs and invite others to help advance the
cause?  If we know we have achieved consensus that it is a good
direction to go in, that is (we already saw a mention that indicates
that there are populations of us who do not care too much about
extending maintenance but are familiar with gc).

