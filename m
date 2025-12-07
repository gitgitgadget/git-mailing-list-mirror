Received: from fhigh-b7-smtp.messagingengine.com (fhigh-b7-smtp.messagingengine.com [202.12.124.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 612E22AD37
	for <git@vger.kernel.org>; Sun,  7 Dec 2025 21:58:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765144698; cv=none; b=cAfkr2keRjBUYvglV5AhNNPjNui8xM4ERT1fff4BQNt+mcd0+LU8CKBSqcmGU/zp0WynoKG17hnMzX1AvUuO8b/ltVRyltcLTewhER/PifV5lNb3GKE965SX1UBOYicCShbJQox27XBb7G0bUYC/mb6JFCN4BPp5I+fnzOCo+TE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765144698; c=relaxed/simple;
	bh=+8VaEBGJgcu/VIngjbPxHDi89bnCbk2OvcGtPLiYlVc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=AONZxfNHu239tV6KHVAUuOy7DU56WOUrlw48kFsj3aemYAdIRzD8u353j7KoQ+1p9pbDT9E2bpoHJgMellNairgC4p8ADk+7CXtuLMOeEM5J7GPwfCjDY1dsGwLHIOQts7TiuRaLAOHb+0XVp+ORUagfC/QZh+sLWl8VLvso5hE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=gdyhUfTO; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=rqmH787K; arc=none smtp.client-ip=202.12.124.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="gdyhUfTO";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="rqmH787K"
Received: from phl-compute-11.internal (phl-compute-11.internal [10.202.2.51])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 740117A017D;
	Sun,  7 Dec 2025 16:58:15 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-11.internal (MEProxy); Sun, 07 Dec 2025 16:58:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1765144695; x=1765231095; bh=dmmn9jBneG
	n57wahRN5U5onUIszmrfrsVoBX6ENSL/w=; b=gdyhUfTOA2w/y1eGIjdxCbR8rC
	h9tBMtDldRvPwdQwy11f1dHy9t8u8fq83LJOj9yzX6rEU5qDCvIbzoD2NhHA/pha
	K69Srxi8OezZOcsW+mFupDy4PSm+XFU7hH5WTdGNovrH3V4vUPUfKSsujRIK0x4V
	KF2iJeBAe4ZX6ZcEiMNlwOryTuvqfUojh6l13M7ddFk6J4FEABIW1g2FSlTcTlfc
	THGqFZzB4GtwgLarP3AsPXXeWWn1/55h6xDsP32CzqCp5G33XTktTEd2pANe+5kU
	Epa1z24pruoHV0ygyYFDhtlPERXz1//9sWplkQkodI1WCKyIwEmfvejpre8g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1765144695; x=1765231095; bh=dmmn9jBneGn57wahRN5U5onUIszmrfrsVoB
	X6ENSL/w=; b=rqmH787KkGCdXyhgEnlu8NPlJx+CRXv9XRarPKOqs51frf83ELn
	ty4JuTdWq0NFdm9YA6ndib5zL2QPxQIpc8dkMbRxjSxiODwJWhW9Ndzr4GTEcH2d
	aEFZXW4mbqON6vazWTEACe8p1xfz/742389n9CJnwV2spn9lTyYIXqN5cSeONN0m
	kOKyOzKEsp7rShtWbKcdXGRwpNvDDh0nLohn3IT8327DewkpULsUs3SocBIvGhvo
	lWS7CBOW3k+j6f6GzhJdS9z7L6hVTCnvhlOG8pwFeGOEypZhmRs0+aEmqyBrJzHm
	1ikGNIjNAvMhWJgAgM5ed/5NXKEBdGEtJaQ==
X-ME-Sender: <xms:d_g1aeFyAnRRn3iUjiQeK8G-aRPFcQcWWSRBcIeTD8OdFm9hYBQJqw>
    <xme:d_g1aRkUe5x6NLQjWR8SSRyASDD97rPeHJQvBa8LhdhtzjQjhXrs4FtjAyRhEMu7I
    FGoUFEazcyKOzrfmHvfMkjyfa0zaBXFMXG5u8OOUdDM941ga0qR0Jk>
X-ME-Received: <xmr:d_g1aabgxVQ-jDqj4KL_cEJdkGEjZtemhWOCFq2OZJRndV9CTzS6wLctoUi2CLB3S9MZEvQo4jLTGmO6408oz7dSVHa1rQoCDQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddugeelgecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecuhfhrohhmpefluhhnihhoucev
    ucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtth
    gvrhhnpeefveetteejheeugeffledvteeiveffueefjeelueffteeigffgfedthfefieeg
    ieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgih
    htshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeejpdhmohguvgepshhm
    thhpohhuthdprhgtphhtthhopehkrhhishhtohhffhgvrhhhrghughhssggrkhhksehfrg
    hsthhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdho
    rhhgpdhrtghpthhtoheptghouggvsehkhhgruhhgshgsrghkkhdrnhgrmhgvpdhrtghpth
    htoheptghhrhhishhtihgrnhdrtghouhguvghrsehgmhgrihhlrdgtohhmpdhrtghpthht
    ohepnhgvfihrvghnsehgmhgrihhlrdgtohhmpdhrtghpthhtohepshhiugguhhgrrhhthh
    grshhthhgrnhgrfedusehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithhsthgvrhes
    phhosghogidrtghomh
X-ME-Proxy: <xmx:d_g1aeE4zXtwMqR2-TjmW2nxTw8EJ0KFDufDLw2MLdxi1sMdxuvwNw>
    <xmx:d_g1aTIynOxWLdp_KO0FdZLdUhUmAYamV9DCqy2ErJgMGVY9jQU7Ww>
    <xmx:d_g1aROr_we7xFiLeVsfwMz2FEtwQ9bLaT-epROCk2ri1p6GfsnRiw>
    <xmx:d_g1ablE7b4Fyg-12Nv480O0aGrCWduP0cDy4oIzJj7Yo1-xzeLhTw>
    <xmx:d_g1aRbVdGMg8iR4IWM_u90cyNyJRLT92mBudsV-ulchs_FOVo0kbSr7>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 7 Dec 2025 16:58:14 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: kristofferhaugsbakk@fastmail.com
Cc: git@vger.kernel.org,  Kristoffer Haugsbakk <code@khaugsbakk.name>,
  christian.couder@gmail.com,  newren@gmail.com,  Siddharth Asthana
 <siddharthasthana31@gmail.com>
Subject: Re: [PATCH 0/3] doc: replay: improvements like "mention no output
 on conflicts"
In-Reply-To: <CV_replay_conflict.101@msgid.xyz>
	(kristofferhaugsbakk@fastmail.com's message of "Sun, 7 Dec 2025
	18:55:08 +0100")
References: <CV_replay_conflict.101@msgid.xyz>
Date: Mon, 08 Dec 2025 06:58:13 +0900
Message-ID: <xmqq1pl6lzt6.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

kristofferhaugsbakk@fastmail.com writes:

> From: Kristoffer Haugsbakk <code@khaugsbakk.name>
>
> Explicitly say that conflicts do not give any output. I found this a bit
> confusing with the current doc since I am used to other commands
> complaining loudly.
>
> Also two other things:
>
> Kristoffer Haugsbakk (3):
>   doc: replay: mention no output on conflicts
>   doc: replay: document --contained
>   doc: replay: link section using markup
>
>  Documentation/git-replay.adoc | 10 +++++++++-
>  1 file changed, 9 insertions(+), 1 deletion(-)
>
>
> base-commit: bdc5341ff65278a3cc80b2e8a02a2f02aa1fac06

All looked sensible.

The second one looked a bit sketchy, but that was the phrase used by
the log message for c4611130 (replay: add --contained to rebase
contained branches, 2023-11-24).
