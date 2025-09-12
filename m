Received: from fhigh-a1-smtp.messagingengine.com (fhigh-a1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD38D283FC2
	for <git@vger.kernel.org>; Fri, 12 Sep 2025 22:19:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757715552; cv=none; b=LyZiTvMW08C5TIDYPoDXzcYnXPBY1BVxAs5luT0Y+F0e3I17eUvuW6y4MqAEYAOYqipy7lNYbRR7LyKLel71pmrMP8n2PgHZJH4iLp7ymQYcwuxWESuyqaSUqzamCUiEx8+4HcKxmLoq+iWOak9YOMOZOo/eidol+c196s0Uxo4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757715552; c=relaxed/simple;
	bh=aA5Vh7/9jMGXLOdhVUATYVIaUQMZd7WuD3ScBZLRGhw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=J+1m+Gq1ZGG7h50RCP/iWRjRluJ0tn7S8amjaEmcIUP5c4bOQXoEU5Btl1hke+Ge055WSy42bhNe8E0zeH+4X+n9UfDKuxnJNTCsOiVjxUBNq2OACKHc1ZAUaPzkcDCGgBUk/0IOF3Pthx13Xk2sDnfZMres8mU3Hu9bUGcU3qo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=hseX+ekh; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=mJ8WHiN5; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="hseX+ekh";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="mJ8WHiN5"
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailfhigh.phl.internal (Postfix) with ESMTP id A30F91400186;
	Fri, 12 Sep 2025 18:19:08 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-09.internal (MEProxy); Fri, 12 Sep 2025 18:19:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1757715548; x=1757801948; bh=8Y2OYQ9nsz
	MyRkFGBnphfcm0jK0GvELdn0d6UlDJ2OY=; b=hseX+ekh9gs38BAL4prxwlWV51
	KlVb4VlAAFBVqnudnPQyamomNdxABxagOZHSfQlE8vbmvNLRkEWcS7CWeYSB7udi
	FxoAGpjkk1uxe9w8byDMo2Os2TsPRotHIEM5uVOf8vKo0ZI1FltjGbhFK4ojmWbA
	lvbhNbUbRmMlkE6NxissmUxT1eM8194b2o+waTyRSHfivNLXt/CcTbpunFK/LMsQ
	Ilu+2nmosXPBNNQBKpJ6w8/cTlTcP5ho9IG7Ffb0mFhcLTbhuO7RHDy0zEGVWRDZ
	AwVCerNpsZbSQN8XmVKFItSycYvzNgkuuNSnv5OW19V2rM0iKG7Cuaj38+JA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1757715548; x=1757801948; bh=8Y2OYQ9nszMyRkFGBnphfcm0jK0GvELdn0d
	6UlDJ2OY=; b=mJ8WHiN5oT65v6W/fpN3HHoDfEaZQIF0oTM0mwl0ymonpUGhiMz
	bfYpCsZnxiE+NbuFICI3/xX4WhXZctO4VhAZ8XlgTGXLF1skY002+arelQkNYTG2
	7urn6+vc5cp+EAxmal0yVY6YjS2BJU3tVWgnpcpEVUw8PBL/cpfBvzZqyOCuvg+u
	b7uhYk1YqjZ0Azyqv/RKY4FCUSBSV2FBB19zK8cnQC/h8xJQbgyTlk126NcLGnwd
	L/LSYGfHr6PyJNDZsjS4DtKHmgIgrWWeV0cbhNPC/cdvgtBgdv9QiKfEANbR/4Xw
	xwvZysPukjHAtmqV24OecTVB81d2Q5RU9wQ==
X-ME-Sender: <xms:XJzEaKWukAsKQ16DS5I4PYuH8xL-ppQLVNqCKxOj5vvqwVEBuNoMdw>
    <xme:XJzEaCTTRHOwYZu-PGlHSgtGK1Wc9kX48fFLDBnEHO_dXomdsUirE4uahIdAub7r1
    b_r-ZZkz0zLJRsO3Q>
X-ME-Received: <xmr:XJzEaK0_pfdzhSvd0VErvbhK5DvbVQP8V0Xpd3kpV3ZmT5l5PuGscAKgIUQhrIhHdGvETWs2iPWWsH0_fpfbfSbsCMDKLuT1WMIlPuk>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdeftddvfecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecuhfhrohhmpefluhhnihhoucev
    ucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtth
    gvrhhnpeefveetteejheeugeffledvteeiveffueefjeelueffteeigffgfedthfefieeg
    ieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgih
    htshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopedutddpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepphhhihhllhhiphdrfihoohguuddvfeesghhmrghilh
    drtghomhdprhgtphhtthhopehgrggsrhhivghlrdhstghhvghrvghrsehgmhgrihhlrdgt
    ohhmpdhrtghpthhtohepkhhrihhsthhofhhfvghrhhgruhhgshgsrghkkhesfhgrshhtmh
    grihhlrdgtohhmpdhrtghpthhtohepphhssehpkhhsrdhimhdprhgtphhtthhopehgihht
    sehmrghtthhhihgvuhdqmhhohidrfhhrpdhrtghpthhtohepghhithesvhhgvghrrdhkvg
    hrnhgvlhdrohhrghdprhgtphhtthhopehnvgifrhgvnhesghhmrghilhdrtghomhdprhgt
    phhtthhopehsuhhnshhhihhnvgesshhunhhshhhinhgvtghordgtohhmpdhrtghpthhtoh
    epthhmiiesphhosghogidrtghomh
X-ME-Proxy: <xmx:XJzEaKdiK_4Gf6cq22QeaVQ7qgV9ECKV64svuvKwXfNM3cpAZAcLvQ>
    <xmx:XJzEaKOCEdAXrNjxLrbOKueaqQDNqkYhiGYwh6nLjxlJnhbzMvIilQ>
    <xmx:XJzEaGV6166RiYf6KkQBli-2D8hIG2eSGJH0cqv6FUNJYDOyuQgElQ>
    <xmx:XJzEaKzrQzeqPz7RQLQJcc_Mzq_53MY8KHZ5wDdK3IRxO3zAGUfq-Q>
    <xmx:XJzEaIm3a3zZY4gu1gRJYiZeCx8UQYKgKEHqyGPdwurhfMbtHu6yWmzd>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 12 Sep 2025 18:19:07 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Phillip Wood <phillip.wood123@gmail.com>
Cc: Gabriel Scherer <gabriel.scherer@gmail.com>,  Kristoffer Haugsbakk
 <kristofferhaugsbakk@fastmail.com>,  Patrick Steinhardt <ps@pks.im>,
  Matthieu Moy <git@matthieu-moy.fr>,  git@vger.kernel.org,  Elijah Newren
 <newren@gmail.com>,  Eric Sunshine <sunshine@sunshineco.com>,  Todd
 Zullinger <tmz@pobox.com>
Subject: Re: [PATCH v3 10/11] contrib: remove "git-new-workdir"
In-Reply-To: <4bd78e37-1d96-4d98-b77f-47520200376b@gmail.com> (Phillip Wood's
	message of "Fri, 12 Sep 2025 21:05:35 +0100")
References: <20250512-pks-contrib-spring-cleanup-v3-10-32e151b0bfb0@pks.im>
	<5580aa89-09f1-426e-8483-c99481c998ab@gmail.com>
	<2b3c951b-0400-4cc5-b790-17ff77154ec2@app.fastmail.com>
	<e6003a2c-bc1b-4cf5-aae7-ef5aa9c82f10@gmail.com>
	<4bd78e37-1d96-4d98-b77f-47520200376b@gmail.com>
Date: Fri, 12 Sep 2025 15:19:06 -0700
Message-ID: <xmqqwm63jov9.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Phillip Wood <phillip.wood123@gmail.com> writes:

> If you really want to checkout the same branch in more than one
> worktree you can use "git checkout --ignore-other-worktrees". "git
> checkout --force" predates that option and will, amongst other things,
> overwrite uncommitted changes. Having a separate option avoids nasty
> surprises such as overwriting you uncommitted changes when checking
> out the same branch in more than one worktree.

Very good suggestion.  Thanks.
