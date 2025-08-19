Received: from fhigh-a4-smtp.messagingengine.com (fhigh-a4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 023031C5F27
	for <git@vger.kernel.org>; Tue, 19 Aug 2025 20:09:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755634171; cv=none; b=Mc7qjZWIY1i//RbBDdJ4klAxqdjpP9BxAI1lnvsEveRYUUOtY7AguHk3jAWUMEVhfKl+CNCbGWDtuBoU+nKcWgK3uRckgowNO2AVAFzil49q+ko+duRfaXsMJ62owl4pGNGxEsEcFwb+8RYYzRrr2u1kI7HPSY4n9VbR13yTr8g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755634171; c=relaxed/simple;
	bh=4lXP4WMoX7vWj3f/4jGs54Bm489+jLRRuiJeJcUtkIA=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=qIarmj4YQ+7CwnT2My5JfSPCANkaN6AQSRmEsj1TjbKBYluw3fu5MG5giJE1PlwDwecYwBnaO7l6MUgFJYQ/9sjfdtj/kFUtd968LVvOAC5d5JJ0PZAHwhxvmowB0un7vatU1b2uFhkSGtKWO3Std3u9s4nnweRFWmcqHkpRUBM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jvns.ca; spf=pass smtp.mailfrom=jvns.ca; dkim=pass (2048-bit key) header.d=jvns.ca header.i=@jvns.ca header.b=tHzGoTtJ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=kl/gPP11; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jvns.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jvns.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jvns.ca header.i=@jvns.ca header.b="tHzGoTtJ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="kl/gPP11"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 09182140011F;
	Tue, 19 Aug 2025 16:09:29 -0400 (EDT)
Received: from phl-imap-15 ([10.202.2.104])
  by phl-compute-04.internal (MEProxy); Tue, 19 Aug 2025 16:09:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jvns.ca; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1755634169;
	 x=1755720569; bh=s2Bn+Pg8hwQZ5R4r2DWAgY392ewMc5tjM2zfFMVrDto=; b=
	tHzGoTtJQRpHanc+7dVU4LixiusUNpC3jqG+sOHqgLRGZSruV2jAN2Dp2Lcq8yBT
	N4Xk8pLMASjAr3r0zH0ZQlmXuKOJ16Xsopz3OGWsSkqlwT5zCQSRML7geuRV9SPu
	ILAZtCqr37AruFxdGA2XzWmJ65H9t5KxyyB1SN2+nmQv7SWxXlkWXZVoNrGgb0xu
	/RadS/mN2E3FKbKdeQZOJwt9aKw+xf/qomPQBli92l7s1RIuW29ml3WEkZ4AG+9l
	J5Zv1bbQl4Yzb+0GgboTj5s5Vh4uKjA/GWp9lX4CG3ZynSB3SS+5YyLoPnElEDuA
	nNkzNZCUNz//3RNEjFh+Vw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1755634169; x=
	1755720569; bh=s2Bn+Pg8hwQZ5R4r2DWAgY392ewMc5tjM2zfFMVrDto=; b=k
	l/gPP11v+RvmndfMapcYAn8vOhu1kSGaSCA1zWvh1DA2hwg5ktUy+lb7civ6fL+5
	oWnW/bLHFCgdungONGzKo6IrAnIaSsOUe0/IQSWK4CfKbA0H5woSAtdI/9VZfePP
	Tiriu1QGRy0MM8YDZ0jgjFngUp8SYuew7P2OcuXLHHEid1FxNTtfzsL/b+4F491o
	lWFJkkyjJjayygFT539x8ll/A3jTEI6OPsC1s6jlfNfJbIlKpwCQa6ZUwhtmujjs
	vZRmOUcxtSA9cirovoxFaKHSDXC7rR86DBCLD+r6cSTNqzkwlKzxbhvkULeNH2oy
	/odo6VQn+2dMgMcUWa9+g==
X-ME-Sender: <xms:-NmkaIhTtjYqNXyaX9anNCNNv9oVEq4lfmRwqr9wfbl3XC8HYyY8vQ>
    <xme:-NmkaBDdA1Qz0A6iHM2hRESW0mL_ASHnssQFM9_KjpwjRHmdWta_h0b8syNPf7orU
    K5oru-IN34eEgIBBco>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdduheeigeduucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepofggfffhvfevkfgjfhfutgfgsehtjeertdertddtnecuhfhrohhmpedflfhulhhi
    rgcugfhvrghnshdfuceojhhulhhirgesjhhvnhhsrdgtrgeqnecuggftrfgrthhtvghrnh
    epgfevkeduveeivdevueehhfdvteeggfffudefgedutdekgedtledtvefhtddutddtnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepjhhulhhirg
    esjhhvnhhsrdgtrgdpnhgspghrtghpthhtohepiedpmhhouggvpehsmhhtphhouhhtpdhr
    tghpthhtohepjhhnrdgrvhhilhgrsehfrhgvvgdrfhhrpdhrtghpthhtohepsggvnhdrkh
    hnohgslhgvsehgmhgrihhlrdgtohhmpdhrtghpthhtoheptghhrhhishdrthhorhgvkhes
    ghhmrghilhdrtghomhdprhgtphhtthhopehgihhtghhithhgrggughgvthesghhmrghilh
    drtghomhdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhmpdhrtghpthht
    ohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:-NmkaO89A8XvnVPzYq34TmgMRs5kRLZ39ZbSOqtER59bSxGUcSjnUA>
    <xmx:-NmkaPfnz4wnWDQ4Q_RnIt_mbErHlQSth0pDp1JO1O5DKRrTNJEFow>
    <xmx:-NmkaALN0VdNSNbx5dqPVCxfCmZb_l6-IfvOFWHVTtHuvL_Phi6JOg>
    <xmx:-NmkaHiMZKrZVh9Cgv_PzonJ5tjMi-gyHwXvFXiTFiscPdxRaxKqEw>
    <xmx:-dmkaNVRZmEn-CSBoJxXt5cXBRFSbkQ_6inczEQw4lOgU4nJ3HjvQP48>
Feedback-ID: i2aa947c3:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id B22C67840B0; Tue, 19 Aug 2025 16:09:28 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AnFdSGTAqLu3
Date: Tue, 19 Aug 2025 16:09:08 -0400
From: "Julia Evans" <julia@jvns.ca>
To: "Junio C Hamano" <gitster@pobox.com>,
 "Julia Evans" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, "Chris Torek" <chris.torek@gmail.com>,
 "D. Ben Knoble" <ben.knoble@gmail.com>,
 =?UTF-8?Q?Jean-No=C3=ABl_AVILA?= <jn.avila@free.fr>
Message-Id: <f168115c-1ec4-4723-94ac-7e22dfcedb39@app.fastmail.com>
In-Reply-To: <xmqqldnlwmc5.fsf@gitster.g>
References: <pull.1952.git.1755029249.gitgitgadget@gmail.com>
 <pull.1952.v2.git.1755127218.gitgitgadget@gmail.com>
 <9e595f9ad59776d74a431731824410c7b73795dd.1755127218.git.gitgitgadget@gmail.com>
 <xmqqldnlwmc5.fsf@gitster.g>
Subject: Re: [PATCH v2 4/4] doc: git-add: explain inconsistent terminology
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

> Here is my attempt to improve the situation by giving a definition
> of "staging area" in the glossary.  Luckily, "cache" already has its
> own entry, describing it as an old synonym to the 'index', so I
> didn't have to do anything there.  Also the description of 'index'
> has a bit too much implementation detail, which I toned down.

I love the idea of improving the glossary, but I'm concerned that
glossary isn't very discoverable -- I didn't even know Git had
a glossary until relatively recently.

I think we can be much more brief about resolving this confusion though --
from the user feedback, all users seem to want to know is whether "index" and
"staging area" mean the same thing, and that we can clear that up in just a few
words -- 'index (also known as "staging area")'.
