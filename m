Received: from fout-a6-smtp.messagingengine.com (fout-a6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B52253A8B5
	for <git@vger.kernel.org>; Fri, 16 Oct 2026 17:03:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792170217; cv=none; b=aU4uFjOF29WEnerTGI1+pfA/xZiKWZ4tuJpVcyNpzkzpaHVBNas/vchLCvAYYf8Zb7471QtqXIXPnbq8poN9L8PqeVvzElNJ7V62b4ipwOx45hGF5YVgqEkHJTTy5Od+H6+ePIPslxo/uRt8Ly66F5oIQbhgKzMd2HLGIpYBp6c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792170217; c=relaxed/simple;
	bh=JA9eNGsuLtbYOCkAwAJ7bXSkOWz1r0KJUuZY8XJvfK4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=gFnpUnXjMIRDcekWLncbhy5C1gB5RvW0usxJzHnnkUe74uzVRDnK360vKR3DdPmEgrmBA+UFIZ5SCXCym29fAdxrOf0PuT1ygkhWWjxAa+yrnpxGeYBbj6pRbWNcEMUwPMspx9n5tTTdKpoIa2ktjw4WvqhjJhF14XcTX8Ddgr8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=d/H6+/u7; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ByPAW1Ts; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="d/H6+/u7";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ByPAW1Ts"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.phl.internal (Postfix) with ESMTP id 63508EC0201
	for <git@vger.kernel.org>; Fri, 16 Oct 2026 13:03:35 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-05.internal (MEProxy); Fri, 16 Oct 2026 13:03:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1792170215; x=1792256615; bh=JA9eNGsuLt
	bYOCkAwAJ7bXSkOWz1r0KJUuZY8XJvfK4=; b=d/H6+/u7YjxdSgw9JLjpPwCpJn
	2/dcUZC6Y8fIkwyyTgVLCcDQiUqspqE7RYrQLBciu9LPvNQ48B79GeQGQ9Nbcus2
	IdJX2uE6IHefhyBJ4axtfnQQy/IH9q4NpBIouQde2P65NQ6aoIRIxfgUoLh2v11l
	23kyM7YoSt7tYfOcYUsrT0+e8/fIuiVJH02Ib3FMg12WcxiY7X1pv6KgFM7h+BFs
	X02gM+ST5i80OOtsKfo+6JE7y6hoS+r4+0h9YLx8EXKgIooau8I2K/LqvBOg7eeV
	F4ZST1dVQbnYU8ngqZ1NDqY8bHcf1TYAyxns1EjbmvOhpRn39n2vIsBQApSg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1792170215; x=1792256615; bh=JA9eNGsuLtbYOCkAwAJ7bXSkOWz1r0KJUuZ
	Y8XJvfK4=; b=ByPAW1TsWgOEMh3nyavu2SCk378MxluvYh0xu5y9HIbWzaPe4wI
	DnWs/vgQi9qet+z6UoHDWm0UJdFhHE3R1cAqREt+6iXZPQOBrmU+GJ+YCvV26RxI
	0XLqv9/m5dv5XydShHSs3ZfGdVZjJZd1Sz+9zWh/UeXnimmcQuQdaldWzXhljXL4
	DNGnr5oA+5Sdr0zK3vTaKsT762I11v4Rs42edzMW6B1N10vfIdE0ZhgTQXQbWy/+
	jBgPrfA4KFjtycVEFv/kcRT8l7IwsNwaGZzKA6pwvfL09ViV+7vpZ67tABAumoEm
	8P6CJ73fsgTaggDnEK862qQFFQdv/LRLyBA==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-08; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1792170215; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm1:rsa-sha256:jS/Eq7hEbXzCPP4MhU3wuyk1CUm2zGnIIKQav+6JuE2aKPP
	EPvkXUhj8oB4d53P4n465Iv469pEfj/k1N/rYjbmFkKM41AUrGLawaSvARp5pmEJ
	dU7ivarmuMFgffuaOOXIRIB/+6XN33gzO7pagZBWnzyMSMaWeRWD/t8aZs+fiX8h
	+i9fPTGJfB3avXzepX1kiIuUpVh8Da0L1tT1CrX2g8rD7xljrUK+7hD9SFzhLh9P
	g2ITfspTB7ZrU5J5TeElxeSC9AapRsKDM5GxtVzmWMTWlGHGI4dSuEBbk/eMykjj
	c+0gt6CB34PMZdJm8s89HyvQype/RB5j98bGyOw==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-08; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:zmhTtiWNLYbu60uDzYeCRyXOqoawKWBIj1vrsvusr60=:JA9eNGsuLtbYOCkAwAJ7bXSkOWz1r0KJUuZY8XJvfK4=;
X-ME-Sender: <xms:51jSakUGgF3kifk2Id1lt93Vld3P_GnHTkZnDs8Y6WVKih4gtVHbiw>
    <xme:51jSaveP7Y1W3lxyP_e9KdOuaz7opTyB52gZ6AVowTR3mX7h-BcnBsdG6-Ob-rw3u
    CotHewId_kngxHUAhWTWVD1GqpVaL1twyhagf8fMh7W5hYFVkOSZFg>
X-ME-Received: <xmr:51jSagvJRGpUsfN2gBvAMrx1mB1TGsujVZ-vwVceLn1CBbYnFUTDM7VDD41vn5NKwGvxT1Oo4HfBSshhDNG0c6lQ6XX3R8rhApHO>
X-ME-Proxy-Cause: dmFkZTEPq3JTmQazIJt+lK/4XXVLY5tHOjFIMbAtrq8FYDue2B6NPWIFe+SSICQEMtoqYc
    PGR+khx/YmLHEd1tXRGS9KSFprIOeZ3i3AWoFvSwamfZb3ebaLlJvahUJwnptQ4J3Gb22l
    YxHaURoy0OXld4NEUUq1EpJeHc4r4wPYw6Ej/9HNhzNC08RM6zKiE80IRmrENzGwXyaaaR
    ETb0eibTVf2EyWmQUUksOyNHlnfnugu9vIXFKWtrYohgbN/TytEbABEwyhorCtqtZ0Dj05
    4FvjospYeHlpoZKND6W5Hbm433xtHoDV3v1utKuoCai4FzAmvCme914ccOPO/5ho6bquXq
    SUkLKZr1DzyZW0UBG6nwvFlaOHcnFALSXSbkZbSt3WJbfvPNIOa8jGTK7vzgM9jdmi6rmZ
    +tGYh+CBlG5K4KtSHqq1g1gBjOgcV8m0GOZmT9A9fsbeTASFtayFoXKdzQ+cErvS66d7Wk
    0768iCKfzPhqrED4SDA+LbXpqDYv2SRya4AYErj5L42UGYbpfNj1zfhpLBti3cjdFqzmmC
    PfIvAh4SXokeEHdz85+br+pOLpI5f3wohSY1YG3ii58Bquh4ziaAfN4/Bm5oqvhv3QiQLn
    WHeILRA/AVI+UiiQgnMFMcr65mq3ummbBp3XAcJG1mGFV5aadcY6LPsIf+8Q
X-ME-Proxy: <xmx:51jSau-lrnHFryG5MfYtwd1qlZLesTizAVQdO6FjA34HYZof-jidhw>
    <xmx:51jSar0d27-Pr2k6RY3-tUEgDLEBEGm_pug7KzOXmuGu90tJFqMslA>
    <xmx:51jSajDRO-EL60c0w1ZnT-j3J1TFNM_pPUahlZzoI_MD1vLL1qu8Xg>
    <xmx:51jSand54nItrRboR2vg4uRt9J3_52HyoqURpuEXkUMn0jhnMgIjwg>
    <xmx:51jSauMoD8ITVmuXkWucSieIxVYyS__Jmoak7xg4Sk34Iul3z5rQ1jA4>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 16 Oct 2026 13:03:34 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "Julia Evans" <julia@jvns.ca>
Cc: "Julia Evans" <gitgitgadget@gmail.com>,  git@vger.kernel.org,
  "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
Subject: Re: [PATCH v3] doc: checkout: rewrite detached HEAD state explanation
In-Reply-To: <01232f89-6f57-48d2-b6de-d51c91b6fdb3@app.fastmail.com> (Julia
	Evans's message of "Fri, 16 Oct 2026 10:55:38 -0400")
References: <pull.2250.git.1791384721919.gitgitgadget@gmail.com>
	<pull.2250.v3.git.1792097882327.gitgitgadget@gmail.com>
	<xmqqecdqk2qr.fsf@gitster.g>
	<01232f89-6f57-48d2-b6de-d51c91b6fdb3@app.fastmail.com>
Date: Fri, 16 Oct 2026 10:03:33 -0700
Message-ID: <xmqqzewdfuhm.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Julia Evans" <julia@jvns.ca> writes:

> This is a case where if we really want to make sure it's clear, we need
> to go get feedback from users. There's likely a better way to explain it
> but I don't think that this conversation will result in an improvement.
> Really doing a good job of explaining HEAD is a pretty big project.
>
> It's not clear to me if you think the current wording is unusable
> or if you just think it could be better.

Then let me make it clear.

I do not know if your version is unusable or good enough, but if you
are going to take one version to guinea-pig readers to test and
polish starting from that version, I think what I gave you would
give us a better starting point.

Otherwise I would not be suggesting replacements (this applies to
all other points in the message you are responding to).

Thanks.
