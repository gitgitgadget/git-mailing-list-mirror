Received: from fhigh-a6-smtp.messagingengine.com (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B84E19F421
	for <git@vger.kernel.org>; Fri, 15 Aug 2025 01:23:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755221010; cv=none; b=TaNFIiCppuSqmMYu9usm5+l8TOSWDfFA5kJuoYys1CLul24aVtQrTK0hs8g94JiBOQUC6EmyLSD4Fi9euyFBxF4E6jvl1fMGZuaIJPc7+1T7ZAZaW7+fImEXtKQ7nSFSmU8pV0q2SirISkXlIaWL8WImlDtFvGQwwaZJJm44XOw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755221010; c=relaxed/simple;
	bh=0z6y3A7TSgW46sW2IRZQTbALlLwb8xEL/uMEvoVSsUU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=mX+mgluFgZLISSdNpyfD121qIaAhVNnV6weVtZeo2GQI63szFraP0/R8qtt2rJTxmv1nUjIZ+wpBn312Ovg73HgFWT05X7fvl1r3G4nnaV/J9SC8H9g/u4PtkgFJWt9swyQALj0kDNpJ9ip1fepmUA5YBrcgPAXWfjK4thdnUP0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=mGWlWjIJ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=E0Qgxmcr; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="mGWlWjIJ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="E0Qgxmcr"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 4649E1400169;
	Thu, 14 Aug 2025 21:23:27 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-05.internal (MEProxy); Thu, 14 Aug 2025 21:23:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1755221007; x=1755307407; bh=NsWzNQfaSW
	d/G1UDIchqKjMjqKuWmsK8e1Xbu3nFKv0=; b=mGWlWjIJE+aO7Q++lPqqRWQUkg
	hfoO2biavbjg57OHiZ+hIjCT9fjZ5f/e1BEZ5G64fXzCgG7BJGQSCPH8bB0J2VB3
	dx4g/4kEXTe3Pi3AQru/WHM7tk/yUE1WCU3aJmu2fab3ypMr/NAIyx56AFJi4QqQ
	coVP53CtCcJuRfoI//Xm06A7TDzz/gNYmuED+g4z3qG/89PLIrikBf/Ks/Z2046b
	Zhr+6xg5FxYdNZcDU1NVFJJ1MhNcB5WYoY1oVUMHp/oIE6ALyHbGl2P4keS+/yEW
	cFBuVoGmE0yArsWy/l4RMh+stIvUTNAPcVelQqmIJk54hfZ5VZOdXnVoZTRQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1755221007; x=1755307407; bh=NsWzNQfaSWd/G1UDIchqKjMjqKuWmsK8e1X
	bu3nFKv0=; b=E0QgxmcrJCJ7Ebf+m6qUr9cMPlEHH0y64XjzgcPMHrwjx1TUbds
	aCTlTHo2XZEHWe5sO3anvHhOVfqoJQbM3E7H9kt0voe9LsrW4RRlMjulfVdI8y4P
	oFNcDBJOMNUYaJyFP0dXOS2lc6+ptU3boRsoQYnp0pWHBCkFkBdTcmqgznGlkwQj
	Ok4oIpS0m/+WtQs7DjvUq+JS7M/lrRMlK9Tcze9SMsXb9+0jmj22knfpkN4yLL5f
	L+FqEkkQUpHi4H9XL2PmQDp5B+nRx80QDFhFGvE9wHGCuf9B4QJxP+p/uU36iXbk
	WE+BQMST9DpU8r1HhG3BLLFFd2v/Al03yEQ==
X-ME-Sender: <xms:D4yeaNcqtxjF03_-WQ02md15kG_aoFX31yRtIj0AlTR6Jv5oYJ--Fg>
    <xme:D4yeaOdvLDuPXKZTXd6aBjCQ3lkwHN32toZFJT5aCRU2B-L2urVt0V37hW_1MS5if
    DHOwz5lmSgMTISUXg>
X-ME-Received: <xmr:D4yeaP-yM4KQGqmPLjQJaQFaUuoExf4uXYxrGP_CdEv-mPOXcvwvM_tlpmFhQE7unl8d2EWOWLiwaxoUu3eC1Yo49GfDkwH02HUTprw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgddugedvieefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertd
    dtredtnecuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehp
    ohgsohigrdgtohhmqeenucggtffrrghtthgvrhhnpeefveetteejheeugeffledvteeive
    ffueefjeelueffteeigffgfedthfefieegieenucevlhhushhtvghrufhiiigvpedtnecu
    rfgrrhgrmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsg
    gprhgtphhtthhopeefpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopegtrghlvghs
    thihohesshgtihgvnhhtihgrrdhorhhgpdhrtghpthhtohepghhithesvhhgvghrrdhkvg
    hrnhgvlhdrohhrghdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:D4yeaCnMSXLIW45mmZNMBOCtuFJmdpg2QzhegRMHWv9kNY4Stow6Mw>
    <xmx:D4yeaJ9ENsXi2Seq10DnKn5FsTl5rl0MUarjPe92IE4hrUljKiezbg>
    <xmx:D4yeaIkbKUxQBMvECQAItxFH2uhiJ1i1Nh--uYC7CHzxd9QmFVZulQ>
    <xmx:D4yeaO2PuO8wIMyRouPlxACfbRieAfWu4Vs5btwS8r1aEAYMMAXxlg>
    <xmx:D4yeaCQdxgzk5rQFpn382eIjL5r6VEMiwQ6m3K-8-f-aIhV7HsFj0AUa>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 14 Aug 2025 21:23:26 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Christoph Anton Mitterer <calestyo@scientia.org>
Cc: git@vger.kernel.org
Subject: Re: why can't one alias `git stash`?
In-Reply-To: <a24d0d237b9f57535c768da4c00d72bad68cf411.camel@scientia.org>
	(Christoph Anton Mitterer's message of "Fri, 15 Aug 2025 02:33:20
	+0200")
References: <a24d0d237b9f57535c768da4c00d72bad68cf411.camel@scientia.org>
Date: Thu, 14 Aug 2025 18:23:25 -0700
Message-ID: <xmqq7bz5v0mq.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Christoph Anton Mitterer <calestyo@scientia.org> writes:

> So I tried to solve this via an alias like:
> [alias]
>         stash = "!c(){ if [ \"$#\" -eq 0 ]; then git stash list; else git stash \"$@\"; fi; }; c"
>
> which seems however to be ignored when the alias name is "stash" (it
> works as it should when I use e.g. foo = ...).

Look for "alias.*" in "git help config".

        To avoid
	confusion and troubles with script usage, aliases that
	hide existing Git commands are ignored. 

> Also when using such shell functions seems to be not extensively
> documented (or I didn't find it)... the example in git-config gives the
> "!c()..." syntax but doesn't seem to tell what the ! is for?

	If the alias expansion is prefixed with an exclamation
        point, it will be treated as a shell command.

