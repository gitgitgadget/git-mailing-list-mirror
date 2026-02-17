Received: from fhigh-b7-smtp.messagingengine.com (fhigh-b7-smtp.messagingengine.com [202.12.124.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE0B029C35A
	for <git@vger.kernel.org>; Tue, 17 Feb 2026 19:43:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771357382; cv=none; b=KzQbRB1rQsE2B4GDO2+LswHi81Q0COiPFnjy9kdkobbyXLWVkeLOR74wuklKQXzFQIg1IOp1GxosZFfKP1a1crwfcN9mKMB/1oRLtkRQHI6dwq6yVd4/+UWFaV4Yikc3ZpmsDwl9suAxIW1cESV7LOpMm68y/5JVe+lNsNmOsiI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771357382; c=relaxed/simple;
	bh=FYlouMOr7V9HpiHv8VzAMUUnR94Uu5pTeADE6GKE8u4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=JH0UNK6KeCflb+HDW4aF72scyFWEm9Y1uLiOTtZh9LXiVWXQ5HN16fqUt+qjpvpKpupSuEN6UwUKxuVVKXO/kLhxIpVi12bqcFxFQIS9/6Ha7sXLVTRgpiSMKuDtNlmxtkC/nZrBCBCztpaIISWazOelE+yu2Ro/jGqX38+lQKk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=cbI5X6lA; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=mDyuRzQl; arc=none smtp.client-ip=202.12.124.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="cbI5X6lA";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="mDyuRzQl"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 0F6C27A005F;
	Tue, 17 Feb 2026 14:42:59 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-01.internal (MEProxy); Tue, 17 Feb 2026 14:43:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1771357379;
	 x=1771443779; bh=e1CRZFWvFSP7JETp/Ul4iuHtf8DEItS7JQYRTvNgp2s=; b=
	cbI5X6lAVF4xpR47mKrjAwZ4iDySoeWyPiMQrr10Hf45dWPU8m8Em8WKdZ3qJWWk
	SI/nOIFvem9xG6M64qh/kbIzUinJaDQ/dnqUGUZyiM8GiVIJDe+hAz4zEHIPjU7s
	WVHCwiA/cg+I0w3/PxgnEbdZV++vjVqknxr7TpULiRzdveOrC9WUWBEv1FmfPL4O
	6NNatdMytyrIiREkOHaH+wusqNujCB01F54IZyQJHE3caX1FzOdgNPI/o2skiQ9j
	sP4o114yiihukYXJgeiecLixiJRrec5naKY7/ZShSlZTcN2k9++I3C7m+m/jz0bu
	0P0dISx0Dg09gN36srTu1Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1771357379; x=
	1771443779; bh=e1CRZFWvFSP7JETp/Ul4iuHtf8DEItS7JQYRTvNgp2s=; b=m
	DyuRzQlaZaNyShZCDnoce+J4XdUMoJcH7h1OrS8kgEw1aD/EXROVxERv/CYOQhkk
	kq59E1+vPgcf3g0xFaBTN66aCMPn0kspQgVFEC8lADego8o8GgLxqFWbWW729P87
	jzgLaLLHPKfElEx3GX40XnQkGPUCSrY51AHvHiNeRsC0zShIIByMGoqEt0m0vzxT
	RZG9kNSsH1leX8vpvzy4A/7ZVCiDaSxxraOdUuRHX/hIu6CdjBQwQQOKBsMRORU4
	kVYzQeTsb3E/if8X4INMB5PF5TbrVLXGqzy3kt5wbRQsfZvcTgZcnlaTRdUIDQkI
	S4IG1cggPVXW/WJEK/Omw==
X-ME-Sender: <xms:w8SUadEXSlljmd0fZnDuLJgHtdqgdHnwvOtGioRyXc6V6hDNnRZzog>
    <xme:w8SUaZzhb3pWad-K_v3qbdX_Pddq9ThstL-SmzwNwpO9WPokveo0Q5hoPJ-4aldvz
    QRPws5iZoRUQ2n9IszPcj2iMNddSHjLabQMjLLV2Xc9xQi1ejjJdjY>
X-ME-Received: <xmr:w8SUacg_ox6s6cWN2h9bFAirFOntFCNOT0itiAdoP-aZTGNtjnboREAdf6_CJzIJ0snN_uoBDo9tHL1rwHYHz92-2oJIvdLSeg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvvddtieefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgfgsehtkeertddtreejnecuhfhrohhmpefluhhnihho
    ucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrg
    htthgvrhhnpedtffdvteegvddtkeetfeevueevlefgkeefheeigfehveehvdekheelveev
    fedtheenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    hgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeefpdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopehlohhrvghniidrlhgvuhhtghgvsgesphhoshhtvg
    hordgvuhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghp
    thhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:w8SUacxb-tvlkrUvfqsuMc7_vPcAcUq9XKuQy8ILvACgcLHGUgZDUQ>
    <xmx:w8SUaXLZg4o5XRlav8vB9DtmRQak0Yzw8Hi7MNlKTKsN1GE6sm_e-A>
    <xmx:w8SUabSCKctUiitlGQF83Ig0ZhjKPTlz50zR6fEfQZnM0SwJ3AV9Cw>
    <xmx:w8SUaXpo3c9cYGpGFjzbck7ZZ-yJM-cNpGMO-F3VZ0xluUAMhFiMkQ>
    <xmx:w8SUaUAFrHs9BSu6NaRk2WdR5v4zAIANa9ZXSaVSGJSf6KxYi32HxwOh>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 17 Feb 2026 14:42:59 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Lorenz Leutgeb <lorenz.leutgeb@posteo.eu>
Cc: git@vger.kernel.org
Subject: Re: Push Certificates: Privacy Concerns Regarding the "pushee" Header
In-Reply-To: <d180884c-8108-4c8a-9cc7-5314a4f5a45a@posteo.eu> (Lorenz
	Leutgeb's message of "Sun, 15 Feb 2026 21:58:42 +0000")
References: <d180884c-8108-4c8a-9cc7-5314a4f5a45a@posteo.eu>
Date: Tue, 17 Feb 2026 11:42:57 -0800
Message-ID: <xmqqldgrb1ha.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

Lorenz Leutgeb <lorenz.leutgeb@posteo.eu> writes:

> This would result in push certificates of the following form (hashes 
> abbreviated, signature omitted):
>
> 	certificate version 0.1
> 	pusher SHA256:xX6bp…T0  1771188983 +0100
> 	pushee /home/lorenz/.example/storage/foo
> 	nonce 1771188983-345389c
> 	
> 	0000000 ccae4e0 refs/heads/main
>
> As you can see, this push certificate leaks a path on the application 
> users' filesystem.  Here it is quite obviously my home directory, but 
> actually the "storage path", is user-configurable at the application 
> level, and considered private.

Stepping back a bit, the most important question is what the signer
is trying to certify, isn't it?

"At this point in time, I am pushing to update these refs because I
want these objects to be sitting at the tip of them in the
repository listed as pushee" is the statement the pusher is
certifying.  The auditors can point at the certificate that the
hosting site having the object ccae4e0 is not because insiders of
the hosting site rewounded the tip to point at a stale object that
the pusher did not want to see at the ref, but with that signature,
this pusher expressed their desire to have it at the tip of the main
branch.

Making it possible to lift that certification and reusing it for a
push to different repository smells like opening a door for replay
attacks, doesn't it?  The pusher did not say anything about updating
these refs in other repositories that are different from the pushee
repository.

I am not sure what the implication of optionally allowing the pusher
to sign a certificate that lacks "pushee" is.  Would that be a
reasonable way to say "at this point in time, I want this object to
be at the tip of main branch in _any_ and _all_ clones of this
project anywhere in the world?"  Is that the kind of statement the
pusher would want to make in the first place?  Would such a
statement even make sense?  When you are dealing with two related
repositories of a project (e.g., one may be the main development
repository, the other being the repository for the maintenance
track), I may fully stand behind putting this commit at the tip of
'main' on the development track, but that no way means I would be OK
to put the same commit at the tip of 'main' on the maintenance
track.  Not naming "pushee" does not sound like it would fly well.

What implication does it have to allow the pusher to sign a
certificate that points at a "pushee" that is different from the
repository the signer directly pushed into?  You give the history
together with a signed "I want the object ccae4e0 at the tip of the
main branch" statement to your middleman, and your middleman does
the actual update and forwards your certificate.  I offhand do not
see a huge security problem in that arrangement.  Anybody can check
the certificate and the resulting history and verify the chain of
hashes to the same degree as you would trust SHA-1 (or SHA-256) for
the object integrity and GPG (or whatever you used to sign the push
certificate) for the certificate integrity.

