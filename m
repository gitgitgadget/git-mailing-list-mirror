Received: from fout-b5-smtp.messagingengine.com (fout-b5-smtp.messagingengine.com [202.12.124.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5799527A93A
	for <git@vger.kernel.org>; Mon, 15 Sep 2025 23:22:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757978533; cv=none; b=Tr1PgJKfq45+Ppr8a9IK3yrA8fpa1FkJ6wxqPUihlyV1+s3SCtx2TaBMWwwjTiJDuvClydyrTfCAFOOtQ7UxLwmTOERX61wL4H6XzkrJGZsVibIOQnySI+ekV11WaolBcTU5IMVpAid76aJCYsRAfIVejPPMYlC2Sz8ZFF47vCk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757978533; c=relaxed/simple;
	bh=YPczUWWSb2Xz9gzd/1f+nJ+FGB4CCG/5mnDRx6PeSzk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=mpOXQg50LgqoLgQNYBPP2p+k28BkBxnaZbLlRULQDrd9ZEebeslLDdQSctA9pFGENxhcOq5TvnsDm1g9JJ6wy4BwVKxhTun2n8x7Q7OEQouFhLQqQQCQfNvjNSt5dWjb7evSbqLxxpbyZng8CP41gjNdNL/IUP2F1PR2Q8hLVv8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=hhYs5ePV; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=gKk2HzDU; arc=none smtp.client-ip=202.12.124.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="hhYs5ePV";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="gKk2HzDU"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.stl.internal (Postfix) with ESMTP id 23F031D0018D;
	Mon, 15 Sep 2025 19:22:10 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-02.internal (MEProxy); Mon, 15 Sep 2025 19:22:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1757978529; x=1758064929; bh=LyOhaABJ3x
	dsvLEK0uAOQsYTH46b8Ml93DB7YVESRGY=; b=hhYs5ePVGqgQC+KsRGDxDwOKV1
	LsVFu7LoMDmCLxNDKJ4Tae/tzg+bGSZKT1CPw+6mDzrvP//KduNJ3njr6jhDIRkI
	4knkf7o6SuiPuInBmae03tg1q4L4axM+1B/U2KjHrpGJW9vG5QF13SXHZFKd8LvI
	1QxxBRvujsZn3EKSELlzt2LEF7N2JTrYEhz7pIyqdUxjamaAsk0kCm5n72HhMJkv
	wgMkXFi2I+MJT1iBVlgdzPYVOuliy/Jxn1b7A3jEpUl6Lx1bfH/yfytMGjGRoZtu
	MBcKFyRypeR5S8MMg+QH1PzJnC6NgNbq9/VXLNOI3+512tK2S5TtQcozq9hA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1757978529; x=1758064929; bh=LyOhaABJ3xdsvLEK0uAOQsYTH46b8Ml93DB
	7YVESRGY=; b=gKk2HzDUwtWlT36ANdNnDOgs52zbE/nQ5X3m1L+naiBltuVw067
	b2/UnOPa09aPB17UMmrORpCn9oJHpU8Tkq0ZaNRIcAWrFVtuZSX/4RGolKGzUN9B
	5+vQcVl8kbot3nKed5TlCgLJ42bqt3VFtJoZSQA5yi22bK5YE2wPNUjt2GGtbLrx
	0i6IJ2FdYq0WxU49tp5OF6DsUZiQRwR5xBppbmkq3RPrpB11GEWwi1/XJiJ0G0S0
	BoGhYxR+1yJmvKSk4+Zk0smqmhwlp3e35L0OPQHzrHizOjRpsZKLC//NulNvmx1M
	RYZFQMOcJXaiRnEV/Yazq2Cril6C7NFP0rw==
X-ME-Sender: <xms:oZ_IaEXIgbEc7TenoDEDLk2MPSK7VooaxuW8Ak5xWej9VsiL3It_zw>
    <xme:oZ_IaBCej-ywZWSwWZi1Qn23Rvp2rpbhUX8zq4qEPYduP8E99DASQ3Ow2xAO7Ztm7
    L3HL3kYt96RRTWWMg>
X-ME-Received: <xmr:oZ_IaI0c1jtJ7WCMiZtZvP7AtbzaaoQAgbhpHA43zc1Qb0_QUimUmvfH3e3N4Qo3_58r1o-3rzHKqJ3BfIS9imB9KKWtxWbxjzvh35Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdefledttdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecuhfhrohhmpefluhhnihhoucev
    ucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtth
    gvrhhnpeefveetteejheeugeffledvteeiveffueefjeelueffteeigffgfedthfefieeg
    ieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgih
    htshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeeipdhmohguvgepshhm
    thhpohhuthdprhgtphhtthhopehkrhhishhtohhffhgvrhhhrghughhssggrkhhksehfrg
    hsthhmrghilhdrtghomhdprhgtphhtthhopehjuhhlihgrsehjvhhnshdrtggrpdhrtghp
    thhtohepsggvnhdrkhhnohgslhgvsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhith
    hgihhtghgrughgvghtsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghr
    rdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtoh
    hm
X-ME-Proxy: <xmx:oZ_IaD2lQtZw6ThaPPVuM46Lht6pvBdSmKFsKkHk6Xt-uc5iox1Mdw>
    <xmx:oZ_IaNBHQeR_s-JBYm-Inb_klGhOSH9ZF68epdeMI6R6dZJ9Rx3CEQ>
    <xmx:oZ_IaC7qGHipHx4T4v4Zpui95T8nrrP7BdDUx_QULXNJZLUSqc4ErQ>
    <xmx:oZ_IaOINN0oSfWxCGrl-ZyuzeM8UCs9Gvcu3lrgrLSjS-6dfHnYDXg>
    <xmx:oZ_IaB3iyZnoBFztTPlAnvW_5mKOZjI4yT0tkTxn0EntDDct_djJW2xa>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 15 Sep 2025 19:22:09 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
Cc: "Julia Evans" <julia@jvns.ca>,  "D. Ben Knoble" <ben.knoble@gmail.com>,
  "Josh Soref" <gitgitgadget@gmail.com>,  git@vger.kernel.org
Subject: Re: [PATCH v4 0/7] doc: git-checkout: clarify DESCRIPTION section
In-Reply-To: <35faaf30-6326-4784-80ff-723c20ed6b13@app.fastmail.com>
	(Kristoffer Haugsbakk's message of "Fri, 12 Sep 2025 16:26:36 +0200")
References: <pull.1962.v4.git.1757531669.gitgitgadget@gmail.com>
	<1629C205-700F-4A8A-84BE-302D172416F8@gmail.com>
	<236a79f4-e9a2-4335-bbff-79ae0cc67e9b@app.fastmail.com>
	<35faaf30-6326-4784-80ff-723c20ed6b13@app.fastmail.com>
Date: Mon, 15 Sep 2025 16:22:08 -0700
Message-ID: <xmqq4it3e1y7.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com> writes:

> There should be a gitpathspecs(7).  Not just a glossary entry.

This sounds like a good #leftoverbits topic for new-ish people to
work on, with help from old timers?  I do agree that the entry in
the glossary has grown to be way too big.  The pathspec magic itself
should be mentioned there in the glossary, but the details of it
feels a bit too much and the topic probably deserves its own manual
page, just like gitrevisions(7) has one.

Thanks.
