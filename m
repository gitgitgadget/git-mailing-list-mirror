Received: from fhigh-a7-smtp.messagingengine.com (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B56B16EB42
	for <git@vger.kernel.org>; Thu,  1 Jan 2026 23:09:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767308988; cv=none; b=jvRilU6gRZh+nOI/oZAbFoWOCRR5PF/kQQFPqjud0GATu9nsZVE+x3wHSSfbwK76Z1vo9m2pvdcwKeRXB3wRuTOiXwcDgsrsq5BIU08twRgha6L2Z0XN6bf1S+Gl6DaEWDpkzcO3nUZ9k3x2dwYjeCO02dM82pq1PYKvYY1rCVM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767308988; c=relaxed/simple;
	bh=Tc7ZU/3tcRppyO+XUZnDJW28YYlwu3lsVn1lBsaCQ7c=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=VPcAEGloSgsBlkxWkHbfRoQgLK7fYvHdiq7cJaMHtihBAaBqEG40YGELM2Qw2aN83UZA110l2YNw0gN3X9DMa2cII40ojoljX/1bxDt4J16Vzj/X51+HijNF0jug0UF5obnm77la8bwPlo0F3jlZwJVzZe3xxoTSYTtu0SRp6+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=ELO/BcBc; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=nDHIg7nf; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="ELO/BcBc";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="nDHIg7nf"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.phl.internal (Postfix) with ESMTP id C7DFD14000FA;
	Thu,  1 Jan 2026 18:09:45 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-05.internal (MEProxy); Thu, 01 Jan 2026 18:09:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1767308985; x=1767395385; bh=jta27OjhJJ
	nO4QNytbsqbmYc2Lp8nQQuTIgEUBOJPEI=; b=ELO/BcBcMNBVOW5QO+m4Tfr4/6
	Y27J4cBcBCnK4wuzAilTq4PCTi/kGr2GpOgeWJtLd3jmvR2H/W74EyURqEKgVRE/
	NfLGsAgrCHLB2IxgARLaw6dseiGgI+KgzJxuWkNbOLkSuAx6nIUiGu4xijry428Q
	XTewPDRsLCG7f4qEdIPP/apUOlVhSOl9PlDDuO/008OyLz+iGWr+49Rag71v5mSz
	XeSeo7m/S68JEP02aSiXBxAAs3tc0Gbf2hpWZGjnuNQX8m/RF8QJz4ItItrcZ5gt
	MwG4C3RhI1pv3Uc49hXgFQNyqYIJtLHYaqg7scOQ/aYz6CaSIus18tHXSvJQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1767308985; x=1767395385; bh=jta27OjhJJnO4QNytbsqbmYc2Lp8nQQuTIg
	EUBOJPEI=; b=nDHIg7nfGlGRc3l9ty3O0HzC2GRCYa/mWhp8U+cAJNSx8aCP95e
	3s43HuqBJ3cZcwfQwo5jVgMGseWjHb6KQRUPdAbZKphOrvNZpUyRsbjCmGlpaFFZ
	isnbLYRdYH9RXklLeUP8uoQ8hZOq6cTxFuo+/iBfRC3nZ5JP4V5R3zwBU+6VvHLH
	M4LLr47+FInDDWZQAupoMgTjb+NlSeUJvwYngVWaEf6LJDFY/GkxGD+av3C0a7Iy
	WP1RDGnpJVKCItvYAcx02t9X/wWxcgwZ1S4nBLnElnYE+/iS0o7G85Ido3tLFwtO
	tOuLCOVcXfq4U7akC6eKCcMzaYYAJMG6rJw==
X-ME-Sender: <xms:uf5Wae3L7BI2HC6huLdmr2-nn83VZ5Ba-mraSaJGvjh2hss0d6RACg>
    <xme:uf5WaYGCtLUfEW2FQTlzaXVPL1IWIRUo5gXx3ZIcMpoyxLef4V6qAcYDxs5EDpA4y
    hZc-gNRb1Dbg6denS6_PnOPxmBqt7sdJdsfQe0Py8_pKsqYle3afw>
X-ME-Received: <xmr:uf5Wab6E8SXkcFLnzToqUXaikbgDN6w6E8MrdKqXEceclksgfv4iXYZuimX7esNOgFKA83Mi0uEE-UdMPksydhouZeFShFaxlg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdekjedtiecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecuhfhrohhmpefluhhnihhoucev
    ucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtth
    gvrhhnpeefveetteejheeugeffledvteeiveffueefjeelueffteeigffgfedthfefieeg
    ieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgih
    htshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeegpdhmohguvgepshhm
    thhpohhuthdprhgtphhtthhopehgihhtghhithhgrggughgvthesghhmrghilhdrtghomh
    dprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohep
    hhgrrhgrlhgunhhorhgughhrvghnsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhith
    hsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:uf5WaetGYCGeroaGrEi3Hdk2AwE6uyRSLM2Qh97n7vOCN95823ZDbg>
    <xmx:uf5Wac6Jmo2bpT8XtKeBzZHx9BUAeeCXoUpmQFkyLo7TL5Z9wVXUjg>
    <xmx:uf5WaZUOGh9VJ7nC77yxcGkEE8C4GjpX-sQ4rkSrW8g9OjvzpYghaw>
    <xmx:uf5Wae8medbTGDCckOrbQWM3f5XI0b047SogsEqpM5hY_N0BcuStpQ>
    <xmx:uf5WaXbEZJSLt4x5Xmeu9io8I4uIfTabHSrW09_lgxY3QOswaxaUpYz5>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 1 Jan 2026 18:09:45 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: "Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Harald Nordgren <haraldnordgren@gmail.com>
Subject: Re: [PATCH v10 0/3] status: show additional comparison with push
 branch when different from tracking branch
In-Reply-To: <pull.2138.v10.git.git.1767110888.gitgitgadget@gmail.com> (Harald
	Nordgren via GitGitGadget's message of "Tue, 30 Dec 2025 16:08:05
	+0000")
References: <pull.2138.v9.git.git.1766936483.gitgitgadget@gmail.com>
	<pull.2138.v10.git.git.1767110888.gitgitgadget@gmail.com>
Date: Fri, 02 Jan 2026 08:09:44 +0900
Message-ID: <xmqqh5t5c4lj.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com> writes:

> cc: Chris Torek chris.torek@gmail.com cc: Yee Cheng Chin
> ychin.macvim@gmail.com cc: "brian m. carlson" sandals@crustytoothpaste.net
> cc: Ben Knoble ben.knoble@gmail.com
>
> Harald Nordgren (3):
>   status: show comparison with configured goal branch
>   improve tests
>   use pushRemote and tracking branch

Again this seems to do a "step 1 goes in a direction, step 2 fixes
its mistake, step 3 changes course" drunken-man's walk.

The same advice to restructure them into a logical incremental
progression that moves the codebase in one consistent direction to
eventually reach the goal at the end applies.

I see you are now using pushremote_for_branch() that is already used
by branch_get_push().  If that gives us "the other thing" that we
would want to compare, instead of adding yet another configuration
variable users need to be aware of, that is really good.

