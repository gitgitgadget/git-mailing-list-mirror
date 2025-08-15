Received: from fout-a3-smtp.messagingengine.com (fout-a3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC48013FEE
	for <git@vger.kernel.org>; Fri, 15 Aug 2025 19:47:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755287237; cv=none; b=qWVWJ1yzkPYBf3WjY20IOTEsGeXV5v7fSPgDmefC8XyH/wYzODuFMk9q1Y2wXCOegPtK75KHgwzSxKoc0fEFDjPsQBIaRPukB+5fRS3zdJIi5j0+XOUGXxzqjiZuDBEn3k/fOrzx7OXs/0sEWPXw7SemcP468pg6GKBOTmimIDo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755287237; c=relaxed/simple;
	bh=YYyj8G221Mx4W0/1vZzA7gBS4wLB7ajyGlrCbe05CFk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=bNhNmWrqleL41fDuBpwbORpFlYO1+QbTTTTnXc1yAGyu78eFuNS37CIa/Fnmi7DvtZbrDNMaa4GTbwJjJj7Nbgkwq/qJaGfg0SmKiu/mhfxw6nxDoZ0WcR4ywEwQoxJhGXqh5psEzXbdl1elzWM0hF8BTKJ9e1YywJK0k18oeBU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=XqndDldI; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Yp7BcmDx; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="XqndDldI";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Yp7BcmDx"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.phl.internal (Postfix) with ESMTP id 9E8B4EC00A7;
	Fri, 15 Aug 2025 15:47:14 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-06.internal (MEProxy); Fri, 15 Aug 2025 15:47:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1755287234; x=1755373634; bh=JTvTsdSPWS
	80DpyCq9x9Lk9MV8KC/XBJMkFRP1pIKkI=; b=XqndDldILnCH0DakeZKej6v4fA
	Km+Kdxi2Qv9Ky6McZVvxdGuiv7/YX41iy3ld/GBTW4iE34d8WuPV+zRYCupLWdx1
	LdYdScWUuU7kF+zdGnCmS4o2bl8+r6mFf1FUkz7KITyM2kaK2VNiUhVY3N2i3Nvo
	vHqB5kRBbcIpIR3aKWDi/JoS/zKkk3/O6SuW0IxxBXYVwMP3ZFhEQ1+GUMfFlCkV
	ygZemcNz+cleJ8ou/79BL7S6V1r0ycUi9wlpM8sLbjkXnqFKKefPuRLeNCXv1oW+
	x4XBwOYb+fo9JaW7HGQsl6dVOvrVCXT4AyUn0hPFXx+vH+mSlcQmMBUr09UA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1755287234; x=1755373634; bh=JTvTsdSPWS80DpyCq9x9Lk9MV8KC/XBJMkF
	RP1pIKkI=; b=Yp7BcmDxthBuoVmqLgyaOhEYRYJ0w2541eAZ2wvVvnlijF7/1Tu
	AVHFn9ts99K7S5T/wvPvOuEyjkeL5CtX/08O9ijp1sU1ri/09u1PfovB7jyAdR7/
	LVuuPHGne4nz5fdN3OviKxwc5m1WlmHNOAVS8tc8gDvwllyzd77SexOVR4yYqDba
	99MhDZ7WG9Q9i2AurZomeC3I1AKSnIambOF3bLFm4tqsSDog57Sfy0cV+dlQUz7h
	setnLeFryp61cCyM05xAMb/wBM4MvbNujB63Wglz//RS8JQjsqO+zRXbWCQ9QdSq
	ncmvqrS3vN7WSRYjkbYqvsztLRZG8vg8wYw==
X-ME-Sender: <xms:wo6faFPLom1G0T7UV7AYCLYupFDQednSD-uOq9dJYPO42MJ2vM7kKg>
    <xme:wo6faFgAxUbijfQqMmPRiNb6trfs6oR67_OQbE_t2YSqwBluS6T3bkM2htUTeXCh9
    aVQEP3KOC4y7FKR3g>
X-ME-Received: <xmr:wo6faKuj_096LgyUHKlaTRmnhhA_6WBn9YUTpEIdy1czj7qvKtkJek4i0EU2hBhOqHhXRxzEIYXiK6hD_uV1huRqTGNCm0kifIt3MsU>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgddugeegkeegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtofdttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepieekueefhfetvdfftdegfeekhfffgefgfeeivddugeffgfffffevvedvieel
    ffdunecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepjedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepjhhulhhirgesjhhvnhhsrdgtrgdprhgtphhtthhope
    hgihhtghhithhgrggughgvthesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehv
    ghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheptghhrhhishdrthhorhgvkhesgh
    hmrghilhdrtghomhdprhgtphhtthhopegsvghnrdhknhhosghlvgesghhmrghilhdrtgho
    mhdprhgtphhtthhopehjnhdrrghvihhlrgesfhhrvggvrdhfrhdprhgtphhtthhopehgih
    htshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:wo6faDQmPTDTXsyjIgAYmLpBapgUyAMaiuLyPAilbanELxkLa_0ePA>
    <xmx:wo6faO1bmRzRz0G-0dJvkQdrsFxN32to9Aj7_Tgp8l4dt0mceLNHzg>
    <xmx:wo6faIttOa43t39242lbR21vMDPjIaM3IebTcLTAuM-4LRxpSBDV5g>
    <xmx:wo6faEiBa9s3L6WnjWXbTw5PoGVb7XFu5Jrw2FWwOEXyXKrWlwQoxQ>
    <xmx:wo6faDYpn9USRL8jw0IleJEiUI32_KTcS3zgkiL_tmjjBEGgwfXGHrvq>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 15 Aug 2025 15:47:13 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "Julia Evans" <julia@jvns.ca>
Cc: "Julia Evans" <gitgitgadget@gmail.com>,  git@vger.kernel.org,  "Chris
 Torek" <chris.torek@gmail.com>,  "D. Ben Knoble" <ben.knoble@gmail.com>,
  =?utf-8?Q?Jean-No=C3=ABl?= AVILA <jn.avila@free.fr>
Subject: Re: [PATCH v2 3/4] doc: git-add: make explanation less dry
In-Reply-To: <886787d2-26b5-4451-a105-9ab522e38ad6@app.fastmail.com> (Julia
	Evans's message of "Fri, 15 Aug 2025 12:10:23 -0400")
References: <pull.1952.git.1755029249.gitgitgadget@gmail.com>
	<pull.1952.v2.git.1755127218.gitgitgadget@gmail.com>
	<ce1eafb02860b390da9359f92fcf098b7cdd3a94.1755127218.git.gitgitgadget@gmail.com>
	<xmqq349ty254.fsf@gitster.g>
	<886787d2-26b5-4451-a105-9ab522e38ad6@app.fastmail.com>
Date: Fri, 15 Aug 2025 12:47:12 -0700
Message-ID: <xmqqsehspdtr.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Julia Evans" <julia@jvns.ca> writes:

> ... Then I ask them to give feedback on what's
> confusing to them about the explanation or what questions they have.
>
> I do this because I find that often people who are extremely comfortable
> with using the software (including me, which is why I usually spend so much
> time collecting feedback like this!) can lose sight of what's confusing to an
> "average user".

Yes, you can lose your novice status and it is hard to take it back
;-)  I agree with you that the next best thing you can do is to see
how well folks who still have that status do.

> And every time I'm part of a discussion about documentation for
> an open source project it seems a bit strange to me for a group of people who
> all already understand the concept to be discussing what would be clearest to an
> "average user": surely the users themselves should be the judge of what's clear
> to them!

Yes, with one caveat, which is that you need to be careful to avoid
throwing them into local optima.  A simplified world view may make
it look easier to swallow, but depending on the kind of white lies
you throw at them, some of them they may have to unlearn to further
understand the system.
