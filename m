Received: from fhigh-a7-smtp.messagingengine.com (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFD112853F9
	for <git@vger.kernel.org>; Mon, 15 Sep 2025 23:09:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757977766; cv=none; b=rinPAT48NeeX3UCQ5JAVo3SE/uam+2o6/3r/OZPNTTvDYXBLoO3tyyzPYfVi/8+TDugLSop7csR8MLzxhJI+BI/1z9KVTg2uixrILxGwqiOODtOorL14HJlMnwTUwxaZLGPkKESUMUNwfZbftAxerSnVzOxix/LPZrPbjUZkHI4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757977766; c=relaxed/simple;
	bh=wrTETthQwmUZzLzRvUEHkOw0GRtG1sMR6/OQlvi00gk=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=WqrsF7ALfpeunpaRiCvE32JRs5mVzS8oUjTyMChkeWOYJ93te7PQ6AUPa613LQKRkvq7nveSnYZCjqdFVEYdk/gQMx4lNczzSrsR2atB9+BNT59w/0dONck010KHc24SvgvCWFzV4U0S2Rz+8MziWDX1W4trllkQ7fgQHuDdr9Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jvns.ca; spf=pass smtp.mailfrom=jvns.ca; dkim=pass (2048-bit key) header.d=jvns.ca header.i=@jvns.ca header.b=PpVJmUhx; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=A76QOzGl; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jvns.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jvns.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jvns.ca header.i=@jvns.ca header.b="PpVJmUhx";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="A76QOzGl"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 12975140010C;
	Mon, 15 Sep 2025 19:09:23 -0400 (EDT)
Received: from phl-imap-15 ([10.202.2.104])
  by phl-compute-04.internal (MEProxy); Mon, 15 Sep 2025 19:09:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jvns.ca; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1757977763;
	 x=1758064163; bh=9z4RBGASEHJaaePslcEIg9DCPSw+B+zZ6ztsKBHD7JI=; b=
	PpVJmUhxw5wYCZCBJ91iqlMYl9wGYELdpkK9r04chBrPViPg3CYn2PrUjS5+AwiI
	v7p7W4+5aLmgiIVfYpTkNowGpCnFgM9USMvn3I560edfGSB39Rn183o99iiueHn2
	hYEFdGgNc+m16FmJzcW1YkvkJnuulH5/1+kCre1OabgvxW+E6nnKv06jK0K7V8dp
	CWuBiKknYPXEb0VWExl7LVWTyclzJsB8ni7E/bcEqGPAM2Hx+ThV8Ebe0B8pLH7/
	aVXRrJOQnXuOuis6S/k/fEIEyZ6/13eJJ0xZHF7Px3QIjziw6GBITvj+F7YWoOH6
	SuBqSoRCcQm73w9Y9WRUfg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1757977763; x=
	1758064163; bh=9z4RBGASEHJaaePslcEIg9DCPSw+B+zZ6ztsKBHD7JI=; b=A
	76QOzGlceQll6gVzgGJMPhhIWbzwxnFdT1pmmCqOS3xoorfNh/Tqw9XjERENS2kc
	BFxiP9Oal6ZvmNYHye8tjGME/2Ucja4K7JRVwl5hkrwchrvcJ7OmL3UocqMDpVty
	06bg8WLusx9sfE4zSQwl7BSitHyDnzZyLD0SrXmidPkgvSalOSF8iYeC3bGz4/aS
	6OJfwjybdD7Wmv4QDVbFBhBpsGfqM6d/MgaW3O2F81nTBvFe0Jq2nxNHfV786KOs
	vEja2bY5U+Zsa4/ff521LkBhxxSvUuHxwJCK0AMi5fQBMrCCUdq9Tu5lAlJwhul7
	80DrJCUqLwFBqLJ2+kQAQ==
X-ME-Sender: <xms:opzIaPErKeH_lgr4NZxYcIXO04fowQl4L_Altb9gsCg832-nGyOnZg>
    <xme:opzIaMVXJKTYJ0Z-7MkMuaZogltWPpM4RMaWJjdnFaYAFFV3cy6t3UKBYpn1vMsMH
    ySaXT3dXBqaybxQjGY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdefkeeljecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefoggffhffvvefkjghfufgtgfesthejredtredttdenucfhrhhomhepfdfluhhlihgr
    ucfgvhgrnhhsfdcuoehjuhhlihgrsehjvhhnshdrtggrqeenucggtffrrghtthgvrhhnpe
    fgveekudeviedvveeuhefhvdetgefgffdufeeguddtkeegtdeltdevhfdtuddttdenucev
    lhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehjuhhlihgrse
    hjvhhnshdrtggrpdhnsggprhgtphhtthhopeehpdhmohguvgepshhmthhpohhuthdprhgt
    phhtthhopehkrhhishhtohhffhgvrhhhrghughhssggrkhhksehfrghsthhmrghilhdrtg
    homhdprhgtphhtthhopegsvghnrdhknhhosghlvgesghhmrghilhdrtghomhdprhgtphht
    thhopehgihhtghhithhgrggughgvthesghhmrghilhdrtghomhdprhgtphhtthhopehgih
    htshhtvghrsehpohgsohigrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghr
    nhgvlhdrohhrgh
X-ME-Proxy: <xmx:opzIaDmIYVXrKFTXowaSTMx7w-jg8e_8EGawLAr5GgTELLgw_4j9Ug>
    <xmx:opzIaD_zizIbeMQh4ahiK5ohGWvUGV7EX5dmVWszARlJl4kLFfbTMw>
    <xmx:opzIaIqFMSZcwKOTWVq7sJgu1ekZRS3hgeQ3xAi_f2JuM8w-CIYYog>
    <xmx:opzIaMkfgd5ad5u_NlZdsq20kjLr27ngIXdja_8SNCR-uatNg8Z43A>
    <xmx:o5zIaK0LzogmmFXDaWtnnU_OJvfWXeV6qInhxsMvuQn5BS74zcxhCRI9>
Feedback-ID: i2aa947c3:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id BDD9778026F; Mon, 15 Sep 2025 19:09:22 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AiyWxa7EEqz3
Date: Mon, 15 Sep 2025 19:09:02 -0400
From: "Julia Evans" <julia@jvns.ca>
To: "Junio C Hamano" <gitster@pobox.com>
Cc: "Julia Evans" <gitgitgadget@gmail.com>, git@vger.kernel.org,
 "D. Ben Knoble" <ben.knoble@gmail.com>,
 "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
Message-Id: <40d2ea0e-07d0-4341-9962-8b2896640469@app.fastmail.com>
In-Reply-To: <xmqqsegne69i.fsf@gitster.g>
References: <pull.1964.git.1756240823.gitgitgadget@gmail.com>
 <pull.1964.v2.git.1757703309.gitgitgadget@gmail.com>
 <0ec629d4037bf5d1ccc248ca1bbd87ccc08119a3.1757703309.git.gitgitgadget@gmail.com>
 <xmqqa52zl6ar.fsf@gitster.g>
 <fbde4659-6191-44ab-a713-7b47f989de96@app.fastmail.com>
 <xmqqsegne69i.fsf@gitster.g>
Subject: Re: [PATCH v2 2/4] doc: add an UPSTREAM BRANCHES section to pull/push/fetch
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Mon, Sep 15, 2025, at 5:48 PM, Junio C Hamano wrote:
> "Julia Evans" <julia@jvns.ca> writes:
>
>> I'm not comfortable with calling this a "triangular workflow" since
>
> But it has been for a long time known as a "triangular workflow"
> already, so it is not like you are in your documentation update
> inventing the terminology.  You do not have to feel unconfortable.

I'm not sure what you mean by that: according to `git grep` the term
"triangular" is used only once in the Git documentation, somewhere
in the middle of the `gitrevisions` man page. There are also a couple
of mentions in the release notes.

It seems like the term "triangular workflow" has been used quite a bit on
this mailing list but it's important to differentiate between terms that are
commonly used internally in the Git developer community and terms
which are actually used in the Git documentation and understood by
users.

> And this "each developer may internally use many branches, but at
> the public meeting points they share small number of branches (or
> just one) that integrate their work" is the most basic form of
> triangular workflow.
>
> If you want to exclude all the advanced forms, without specifically
> singling out the triangular workflow, you can say "if you are not
> using the centralized workflow, and pushing to somewhere other than
> where you are fetching from, then do this..." and it would work
> fine, I guess.
