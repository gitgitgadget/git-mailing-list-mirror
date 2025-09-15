Received: from fout-a5-smtp.messagingengine.com (fout-a5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8401D19ABD8
	for <git@vger.kernel.org>; Mon, 15 Sep 2025 17:44:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757958270; cv=none; b=bp8cuUE7bzHGNcMqSpJTnhWP7Ha7U+pNcSYKh1dqZPBxDFuXsjgXu6Fe/QOIbXBiVyx3JWfUxz7UhWnQ1txrhVM+7fEMK1Krc4pU38nm9UUM++xnB+4WLqc55W3boFCQXXngGM+s7OUzqNv/JIdKmr7s8EtwIZuj5G1RZn2vHk0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757958270; c=relaxed/simple;
	bh=PzC16XBR5LoiNNSWwKbxGsInxWTBja2W9f+WkiQqUH4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=VMsYGuGjLjCKDAKIdxnZadYoE65gAvdLnrRDcmTabDGmqRjeoNEUv+UadDL8n75nDqVWHjYUr79OS33muaAe8RmIpssTx2X4TX2I5nIcOcvoMi2xtT14kTN7RRUqFA8nIZnLcyHiBZwk/vIL7SUROP9ppo05ouVvZqaMrtQVrgQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=CrW3IpIa; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=NOdRlt58; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="CrW3IpIa";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="NOdRlt58"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.phl.internal (Postfix) with ESMTP id AF70AEC01EC;
	Mon, 15 Sep 2025 13:44:27 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-01.internal (MEProxy); Mon, 15 Sep 2025 13:44:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1757958267; x=1758044667; bh=PzC16XBR5L
	oiNNSWwKbxGsInxWTBja2W9f+WkiQqUH4=; b=CrW3IpIajKgRQEMvttADHsbuYf
	IYqZVUp3dMWWjEX4JKC/cwLObEbiEn04mn0hSZim2rUvRm7H3qesaTONjMSlL6RV
	eMYZBJBTYl/dMcRXHCx7peco5lWBjVVuKelVsRD30Cm01Q+gpDtHWjmm3jIXMvoI
	y1UTEhKEtDuoBMHbgFUyk6Z66MRC1vHSnWN9nTyiMYZ04qe5lH2RdD5gt6ZgyG6f
	vBnNI9HknIC23OMOcU4pLpKLXjKyjvAcE3KT+Qjh4qmvZ273iWuhvFhGVdP9riZD
	sOodHH9oEzv2bqq9YC4W1xhunRTEhs251C4JEchozik8wOOkJU9aBMdCjmzQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1757958267; x=1758044667; bh=PzC16XBR5LoiNNSWwKbxGsInxWTBja2W9f+
	WkiQqUH4=; b=NOdRlt58XRlXkqgPWkK+6YJiIpsr8WrMofimD2hiTFed4byOPiI
	V+7GjPzHputtQvPny5mCmqa1/E+CYInQEcsxRIOLCAmy6pqWt1flI0y3SaeqKXap
	tKl/G8dgxJpS0cSIKh8YH3jIkInMtwnTcYyeUZmbQCCBtQ5nLaLq2fxy9tR2eM4U
	yCEZYxaS+IDi9PLtWKMTeXuGCNiKYLXJtLEf3Oj6uPiBD7yzLHYYj3tvZ0jbmg13
	F0YULeWkT0msmVfNgO8XSEiBOkzJHAA38fakyrmho1SE18X5OjLq8H8cmvBs9jx3
	Oa/KL1KQBuEopH5mHFBAzV5PkpTNrLrisXw==
X-ME-Sender: <xms:e1DIaJXadta_jV6ReB-WbZpcy2REqsuq5ar5Mo69wdnCB8jLXa3HBQ>
    <xme:e1DIaKW-zjZRU8rYvc0BK4FOprLHrQ3QpqSQyL2PqjiV9AraiQetqAH_qrfXf1P2k
    -dFYaNfbEmH59ZFag>
X-ME-Received: <xmr:e1DIaBiJm3pLZHAqAOPrE873jJXVzF3sERGnA2In-W72bX0NU1sGgGz1bGW796_36UzcNkx-zJxn1h7pluPrCTL8PCgqblxVtRsywTI>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdefkeefvdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtsehttdfotddtredtnecuhfhrohhmpefluhhnihhoucev
    ucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtth
    gvrhhnpeeikeeufefhtedvffdtgeefkefhffeggfefiedvudegfffgffffveevvdeileff
    udenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgih
    htshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeeipdhmohguvgepshhm
    thhpohhuthdprhgtphhtthhopehgihhtghhithhgrggughgvthesghhmrghilhdrtghomh
    dprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohep
    jhhlthhosghlvghrsehgmhgrihhlrdgtohhmpdhrtghpthhtohepphhhihhllhhiphdrfi
    hoohguuddvfeesghhmrghilhdrtghomhdprhgtphhtthhopehphhhilhhlihhprdifohho
    ugesughunhgvlhhmrdhorhhgrdhukhdprhgtphhtthhopehgihhtshhtvghrsehpohgsoh
    igrdgtohhm
X-ME-Proxy: <xmx:e1DIaNZljTFVQnYrL6vY1nPGU-kfBbbMXsZmX-_UV-MgjYH9IcNZaQ>
    <xmx:e1DIaGqkyJZpYCmtIx4wcmNmMyXg9jY1RORAGR0aVtfPD8HgNHoL4w>
    <xmx:e1DIaCMZIeCWWoJHZwjhFOCf0JurcJ9XpfSl_gsktrvGX2wtGiJlAg>
    <xmx:e1DIaBqUoD-NCLwvkVHtIpBl7g9xBRqmE60WHcTnvEH0juMnwlxOhA>
    <xmx:e1DIaPRPbSuo_HpFqNeyNc4d8RSE1qhIel2JSc0-xeR33bJXcoQskce3>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 15 Sep 2025 13:44:26 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "Phillip Wood via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Justin Tobler <jltobler@gmail.com>,  Phillip Wood
 <phillip.wood123@gmail.com>,  Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: Re: [PATCH v2 1/2] add -p: mark split hunks as undecided
In-Reply-To: <3e2ec7b37f1935c5b091fc4b47b6209beb384d3a.1757950144.git.gitgitgadget@gmail.com>
	(Phillip Wood via GitGitGadget's message of "Mon, 15 Sep 2025 15:29:03
	+0000")
References: <pull.1863.git.1740149837.gitgitgadget@gmail.com>
	<pull.1863.v2.git.1757950144.gitgitgadget@gmail.com>
	<3e2ec7b37f1935c5b091fc4b47b6209beb384d3a.1757950144.git.gitgitgadget@gmail.com>
Date: Mon, 15 Sep 2025 10:44:25 -0700
Message-ID: <xmqqbjnbhapy.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Phillip Wood via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Phillip Wood <phillip.wood@dunelm.org.uk>
>
> When a hunk is split, each of the new hunks inherits whether it is
> selected or not from the original hunk. If a selected hunk is split
> all of the new hunks are marked as "selected" and the user is only
> prompted with the first of the split hunks. The user is not asked
> whether or not they wish to select the rest of the new hunks. This
> means that if they wish to deselect any of the new hunks apart from
> the first one they have to navigate back to the hunk they want to
> deselect before they can deselect it. This is unfortunate as the user
> is presumably splitting the original hunk because they only want to
> select some sub-set of it.
>
> Instead mark all the new hunks as "undecided" so that the user is
> prompted whether they wish to select each one in turn. In the case
> where the user only wants to change the selection of the first of
> the split hunks they will now have to do more work re-selecting the
> remaining split hunks. However, changing the selection of any of the
> other newly created hunks is now much simpler as the user no-longer has
> to navigate back to them in order to change their selected state.

That is great, but ...

> Due
> to concerns that users may be relying on the current behaviour [1]
> this change is guarded by WITH_BREAKING_CHANGES.

... this does not really sound like a good candidate for "before
version X we used to do this, but after X we no longer do so".

Unless it is a mere bugfix, in which case such a change does not
deserve a huge-version-bump switchover like this.

On the other hand, assuming it is not a bugfix but introducing a
different behaviour, where both the original and the new ones are
useful depending on the situation, wouldn't it be better to give
users choices at runtime instead, with a configuration variable at
least, but possibly with a interactive command to choose which
behaviour is used on demand?

