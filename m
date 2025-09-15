Received: from fout-b4-smtp.messagingengine.com (fout-b4-smtp.messagingengine.com [202.12.124.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B5DB1F5825
	for <git@vger.kernel.org>; Mon, 15 Sep 2025 21:49:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757972943; cv=none; b=dCHZcnXIY4SMnqIBRu4kkOW8RmsZ/43Ga80xwatDb0C9J412l663eoHgoOKQOB863t0mkGR+hN1QNl68wXWB2GU62H0cjkIcGbw1UG33Gknzmu8kUikf5KSmiJrCxPO0bhMyq1jsYayjbsHp4wbFsl77rDGhjZZjq31YEUJMONk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757972943; c=relaxed/simple;
	bh=M39Jn8RRKKkpdX5A7GybMzs3q6eFn03WB3U3TGoEoD0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Kf5xbw0kzPOe15zUkLYyF9RbTPLJvlFPe4VTAaEUG+Qm6IuNdzujAOHO7++bcjdEimlZyBTmvWxYJU4vHzcrqfDvaVQBxFwcfC2TilqUZaEIza9GXm+3wvJ6kRF/SJukH9cV7hiiE2DoyaqA4mcQrrGFl9d/MD6xb0elfmbLKRE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=YRp0YRQC; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=i2eFL4n3; arc=none smtp.client-ip=202.12.124.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="YRp0YRQC";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="i2eFL4n3"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.stl.internal (Postfix) with ESMTP id 124B51D002C5;
	Mon, 15 Sep 2025 17:49:00 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-02.internal (MEProxy); Mon, 15 Sep 2025 17:49:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1757972939; x=1758059339; bh=P6B+AUcOkM
	9NFgAfGv7tzCEY6ibjBNI/8nquSbpSSuw=; b=YRp0YRQCfz6QTtWcOzTA1BTlUW
	QzZcxnVmsht8QiLLVC7mY+xbHNjXcqBiSFZZsB2/8d6II3+gMwHJuw/iyIQ+Qtsl
	WcFEKFkrefDW+g3Vh+WGMF4im8eoevyZNWMAeQ1c4dl2tXCxgSgLGbI3b5KUge7H
	rz0g43Pc1gMJLgHeKkhMeR9EP2rr2/osMoxtevOo8+V3DlcYiEdbcR286zsIa4yD
	CDp6hQFncBYj4Rc8IX1v+7fJ9E2RDzEdwJzbkwD+JglxCGKvv02uqhSpffsICP29
	LqFy/5S5kgPDBO/WFkX4YLLBMTBNpnaGxpb5vXiVMZlIdYxpAvTc494Uxv/g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1757972939; x=1758059339; bh=P6B+AUcOkM9NFgAfGv7tzCEY6ibjBNI/8nq
	uSbpSSuw=; b=i2eFL4n3Iy7W+1tefFT0plmG4MJhQz26hyNgM3FskmXlA0NPrVJ
	9CgIjcaqx8SA+eszoQlkzZQ/OidzpKah/GD5TfBg6lZGYvHUyr2gwkxASXue8f3N
	UrQ8WnS2NhDcYXD1ds7eicrIDjLEA0ceMtHI4ETwqfkChwQXq1ZVJMYUcqom0iHC
	/BgucU0LYf5zI10hKLXBPML1o8SZOt4WCg1+qyAyBxw+H1CQ3M0s3PyuKB2de4F2
	G2mgdkpZjYXdx7o8cmur4CvIv524qYRewukEBlnHFKSatyfNZR4p/QzYQ9+Oca+u
	iCNxxXl6KP+f1RQyNL2uIQZ+74Gp30Qvvmw==
X-ME-Sender: <xms:y4nIaAqPVf0Tc4mLErjaoWNCE_Wy7h9Ll2NmAr3pDn4oyiCeXilFnw>
    <xme:y4nIaPE97I0CgVOBrsw2ImD4UqHTeIvccO0xViSaFneLBZbgGLid6K5GBklqFFzrr
    yvL0f3papuL7H-Nsg>
X-ME-Received: <xmr:y4nIaFpVVqmAPg-w4AwRGdER5IEMK6JQwlWV6i2s6dPJoUWn9uzBVzz3cidg2ny0ScGN2HRlLywbylvqtHUI6VrBNVi55i_qLgo2ORc>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdefkeekudcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecuhfhrohhmpefluhhnihhoucev
    ucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtth
    gvrhhnpeefveetteejheeugeffledvteeiveffueefjeelueffteeigffgfedthfefieeg
    ieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgih
    htshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeeipdhmohguvgepshhm
    thhpohhuthdprhgtphhtthhopehjuhhlihgrsehjvhhnshdrtggrpdhrtghpthhtohepgh
    hithhgihhtghgrughgvghtsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhg
    vghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopegsvghnrdhknhhosghlvgesghhmrg
    hilhdrtghomhdprhgtphhtthhopehkrhhishhtohhffhgvrhhhrghughhssggrkhhksehf
    rghsthhmrghilhdrtghomhdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtoh
    hm
X-ME-Proxy: <xmx:y4nIaIYC38uThFBd4yrPF7_lHiA0jvuCR2wArA6FX-HsRrFwHlrdNg>
    <xmx:y4nIaOWV8EAmq6RwRGJ3So6TgPFBC687igorUyoha7OiAN6njCbVhA>
    <xmx:y4nIaB8HQKDFcmQaSl3KAHH38kKpQOY5M05HKM6IFP1iwvqgiSdMQA>
    <xmx:y4nIaH_mCjMeOIvpkp_5Xx-MaaVTCOWRy7kRuHfp_kmqyHn9BKLWZw>
    <xmx:y4nIaFP6yH2AfR1VZRdL2y_0yUbQihB5j-My2iqcmDytGoZnmoyIzotL>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 15 Sep 2025 17:48:59 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "Julia Evans" <julia@jvns.ca>
Cc: "Julia Evans" <gitgitgadget@gmail.com>,  git@vger.kernel.org,  "D. Ben
 Knoble" <ben.knoble@gmail.com>,  "Kristoffer Haugsbakk"
 <kristofferhaugsbakk@fastmail.com>
Subject: Re: [PATCH v2 2/4] doc: add an UPSTREAM BRANCHES section to
 pull/push/fetch
In-Reply-To: <fbde4659-6191-44ab-a713-7b47f989de96@app.fastmail.com> (Julia
	Evans's message of "Mon, 15 Sep 2025 16:19:05 -0400")
References: <pull.1964.git.1756240823.gitgitgadget@gmail.com>
	<pull.1964.v2.git.1757703309.gitgitgadget@gmail.com>
	<0ec629d4037bf5d1ccc248ca1bbd87ccc08119a3.1757703309.git.gitgitgadget@gmail.com>
	<xmqqa52zl6ar.fsf@gitster.g>
	<fbde4659-6191-44ab-a713-7b47f989de96@app.fastmail.com>
Date: Mon, 15 Sep 2025 14:48:57 -0700
Message-ID: <xmqqsegne69i.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Julia Evans" <julia@jvns.ca> writes:

> I'm not comfortable with calling this a "triangular workflow" since

But it has been for a long time known as a "triangular workflow"
already, so it is not like you are in your documentation update
inventing the terminology.  You do not have to feel unconfortable.

And this "each developer may internally use many branches, but at
the public meeting points they share small number of branches (or
just one) that integrate their work" is the most basic form of
triangular workflow.

If you want to exclude all the advanced forms, without specifically
singling out the triangular workflow, you can say "if you are not
using the centralized workflow, and pushing to somewhere other than
where you are fetching from, then do this..." and it would work
fine, I guess.


