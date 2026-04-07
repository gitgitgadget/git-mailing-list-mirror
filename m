Received: from fout-a2-smtp.messagingengine.com (fout-a2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3613296BC1
	for <git@vger.kernel.org>; Tue,  7 Apr 2026 14:33:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775572399; cv=none; b=YT7ijkUSTKf70utFJ+me96vCaLGtb7Z6SYyHYPcvU1yrJu7Gp8cAZzCAX+pHirstLV4gLRYUc1ThmbOg1OTkb4be6QX5Rmjgl2RWAaSbxuPxbp1yps5MayLWqRl0DqaIQwpK8QZTD8O51ESD7bEHjlRGPL+FvIZpnx1ufqot84Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775572399; c=relaxed/simple;
	bh=pOZNHlRKlAnWjdGlnIF1ZafySZJGkTNoV48y3OoUzEQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ECEnlfXgrXhWlbJzVFK2eNqzQzAdmkxvGSfhBxcD6ze3t7afhJpcjmpS48qtl8ty3/Gj6YtF2/3p5B3CuKtg+wiQIQD18mf+AmfV1SA8zLx5ozpLvhJ4GynmcXBJEdYIy6d0tZPxpCyqrvjD2bybiYbYuu53KP6K0eJpSvrmXeQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=EycHm9+/; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=vveMUL4R; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="EycHm9+/";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="vveMUL4R"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfout.phl.internal (Postfix) with ESMTP id 18D76EC017E;
	Tue,  7 Apr 2026 10:33:17 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-03.internal (MEProxy); Tue, 07 Apr 2026 10:33:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1775572397; x=1775658797; bh=7aatUH7UaK
	CQJV/7piZ+8kvkSJMV1tVsF/HfK24Y5ys=; b=EycHm9+/xWfQaojALj0Bv5q8mA
	hgIXD4JNGauz+a08XPzp4ql6Rw1UtzdHvlrRGBrtGXnf00rWo6jq2LVvN3cyzfdB
	U//W3Yk5GmfwSLTHJ4bkJQgEqAPG81WyWwZd8K2MjG0TcrZzigu6k8HKy5Q1q0yL
	7Fa5/zc6W/JOVOgP1afyzPf58c6nIJPcLEJZPcaCZXleXYOUNGaRgfKE1rhcXYeT
	rggYrOE02MtVA04f6ay2seX73W38dA1ilTw88gd/sjcmTnqCElf5Mfr9KsA6j55a
	7JjNGRJQksY8AgtI52rKb2zoJQ1Igs1Yg4OMFNTRbUAjWaI2IErfxG5n+j6w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1775572397; x=1775658797; bh=7aatUH7UaKCQJV/7piZ+8kvkSJMV1tVsF/H
	fK24Y5ys=; b=vveMUL4RWRjwWBuJiPTsSz9SLnftPRj93d5zBItA4R4VHocDiqM
	r5PeixfIaZIYAaAUdCu6IDE/7mxXi6bcGYXXc32fDE2hP/Totew+lgQ8kyDWVQeo
	omXbYW17BxDXfgth+czHqIWScnaDFMQy9KRBAGm15rnFcL197CNrO084oBmt0o9s
	iKPRy8M7er2XZKzT3MdQjs6MKSGMy3Yd9o6o2mQwINB5AkG0LmTUDEuZjo0btEV/
	IuFwkuIXnkL2YULG4YODfdtR0nfKEBEIr12Ijyj2ieOEGHqIkLFb9ZJG6mhRWtIS
	8PM4OzXu/6ykoVjx1scK5QuGAJLUVu3RfKQ==
X-ME-Sender: <xms:qxXVaU8Hv79maCa6-fPqvSIl6rPQFqdaOnIOAZ77B-DUC-jJaiaG4g>
    <xme:qxXVaXEr8ApYHLBfxfwKvyldWfkErKenpQe8DVeoSzJ2EvvBZcdmoktEdgNgDB2Pj
    q-FYJMq81R3z5IuMQ1Jd1EjAdzec-D4CQMk4JWUxCqqDwRtvxn4ob0>
X-ME-Received: <xmr:qxXVaQKlPCbfiLZpTP2997_abbJyJYBD6VL0MSwMJrj81VW8U-htI1Q94f9ahaq_CLl-63iF35FgZ7eCIG-t_UGQmkEBfRZfpg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgddvtdeklecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecuhfhrohhmpefluhhnihhoucev
    ucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtth
    gvrhhnpeefveetteejheeugeffledvteeiveffueefjeelueffteeigffgfedthfefieeg
    ieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgih
    htshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeduhedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepnhhitghosegtrhihphhtohhnvggtthhorhdrtghomh
    dprhgtphhtthhopehmshhtrgesghhoohhglhgvrdgtohhmpdhrtghpthhtohepghhithes
    vhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehpshesphhkshdrihhmpdhrtg
    hpthhtohepphhhihhllhhiphdrfihoohguseguuhhnvghlmhdrohhrghdruhhkpdhrtghp
    thhtohepmhgrrhhtihhnvhhonhiisehgohhoghhlvgdrtghomhdprhgtphhtthhopehrvg
    hmohessghuvghniihlihdruggvvhdprhgtphhtthhopegvkhgvmhhpihhnsehgohhoghhl
    vgdrtghomhdprhgtphhtthhopehstghhrggtohhnsehgmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:qxXVafkxUbkBCw8o9lIG2GE4jcx-EH4RY0-cui7qDOOiWRPabDPUMg>
    <xmx:qxXVaRwCL25wqallRG8T-sxaJrLfh8s6Yn8amx6OsHlaiQT3OX6Srw>
    <xmx:qxXVaRuBY5N875yrLv9ZwI1YeKVMn0Hd_Fv0wGgzoiNWES4VAyl68g>
    <xmx:qxXVabGqI_euYChyRFL9I4bXWNhKzy_8ta28MxUhSWUWv5X5z4w1Hw>
    <xmx:rRXVaajDOYvFlQofA0TdDiCVfX119g9ED1PNmZi5-Z8tFLG0c-fsfNlO>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 7 Apr 2026 10:33:15 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Nico Williams <nico@cryptonector.com>
Cc: Matt Stark <msta@google.com>,  git@vger.kernel.org,  ps@pks.im,
  phillip.wood@dunelm.org.uk,  Martin von Zweigbergk
 <martinvonz@google.com>,  remo@buenzli.dev,  Edwin Kempin
 <ekempin@google.com>,  schacon@gmail.com,  philipmetzger@bluewin.ch,
  konstantin@linuxfoundation.org,  newren@gmail.com,  tytso@mit.edu,
  rikingcoding@gmail.com
Subject: Re: [PATCH] headers: Preserve 'change-id' header in rebase /
 cherry-pick.
In-Reply-To: <adSPznztKWo63Tjr@ubby> (Nico Williams's message of "Tue, 7 Apr
	2026 00:02:06 -0500")
References: <CAH7WC73-4p0RrqKNSh2G-xfpfO7QHZiXHbU_UFRkM3Q=bMWTDw@mail.gmail.com>
	<xmqqqzor76nh.fsf@gitster.g> <adSO6zPwtFOWBcOw@ubby>
	<adSPznztKWo63Tjr@ubby>
Date: Tue, 07 Apr 2026 07:33:14 -0700
Message-ID: <xmqqh5pm7sd1.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Nico Williams <nico@cryptonector.com> writes:

> On Mon, Apr 06, 2026 at 11:58:19PM -0500, Nico Williams wrote:
>> Maybe that's the trick: local configuration for determining the
>> copy-or-drop semantic for different operations, and maybe hooks for
>> altering when copying.  [...]
>
> I should add that I would want an original-change-id header that could
> be used (again, optionally) to relate commits that get cherry-picked or
> rebased but end up having different change-ids.

With these people with (possibly just slightly) different wants
different project may have, wouldn't it work to record this kind of
random pieces of information either in notes (the benefit being that
it can be corrected without having to rewrite history) or in
trailers?

