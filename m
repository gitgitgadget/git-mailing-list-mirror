Received: from fout-b8-smtp.messagingengine.com (fout-b8-smtp.messagingengine.com [202.12.124.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B02EC23A578
	for <git@vger.kernel.org>; Thu,  5 Jun 2025 13:30:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749130213; cv=none; b=urf5z2/TkeunqMIij3Em0VMdPzUfx1cyeW6Q7c9xqwy/SbbzNApX6GSQ0niT5wS2oMNeafTn/4xrd+0k6boKV6z5/dJeoyHA+v/0aXyeFzWUH4sQzjaykFcDsEfY0ce1dR+FnrkQNHi4HeC4lL0tptEI0tcobPNPeHwUsnzKHnI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749130213; c=relaxed/simple;
	bh=lqAnkooIeV/gLfBe41GHZHu2JcQmUkBFVtynqPDxlzk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Ad8XxJBWFiHNTOVxnoDEvfjyNJWoBI5e37NMh7HSgjWnL7Y8dexBsB8wKopw5og6fo5bOIvk/Tv9C7h9nkyL5+eJTjktoZdX9OWPgaMAcVT+3VATjZjqheN7h/7D39CGhDy7qpu2OJJ1yG7F9GdCwShs+APl8gZMwM+LtuBUwXM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=wVBRgV6h; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=GeHBgNJz; arc=none smtp.client-ip=202.12.124.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="wVBRgV6h";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="GeHBgNJz"
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfout.stl.internal (Postfix) with ESMTP id 92324114012F;
	Thu,  5 Jun 2025 09:30:09 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-06.internal (MEProxy); Thu, 05 Jun 2025 09:30:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1749130209; x=1749216609; bh=3eXKw5eUw9
	c8RxF5WmtnNY01XrWIyOcuJ4nuxwkDJyc=; b=wVBRgV6hRCWAD8OgDhk9ZR0GvQ
	KYCj27CDC6oNXVBMr0Pc0JytJo/pAH7qeabRI8s6h6KDh1iEbBKGuFN7M2x+Hod8
	jnoRjzeevoRaiETUOwbseZgu2ciBQ6v1tUTyfHrZOVfkCjzMwlxpf9ZoBRhhHMoH
	pNAXo1mTcwqIl1u26CpXsJezC1XIQS1KCcr+YygPEiAGpZDgte3+j0Qqo/7TfV4+
	KaVPOAmfzm6AhRXeGMjDrjssvxI4Y8QDtGoSQpdNpNL3QDqZ+g0buozNepD/dd7y
	XJOTfQCC/pnA/FbuJapSZxXyZuf3qqugKM9+/pquesR+XK2HLuEl9ZrBJORw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1749130209; x=1749216609; bh=3eXKw5eUw9c8RxF5WmtnNY01XrWIyOcuJ4n
	uxwkDJyc=; b=GeHBgNJz/pjgrHPSAGb/VF9eU8zADGXPpZpX2SHkOsR7C+1EyCf
	kcyl/ROMo5DOxjoWw7J1SlakH9JQZPFhcIjB8lPuB8yxspztUA0B5Uubrl6+xB3n
	eYFXFYxPsBsEv0vEQ8UwoRX9fwzC9CMC2kDH4AL/nDcahgRpUjHh+09rB/B3nZEK
	hIa41RAkjDyquB8+/wkIVovR2tWFtbxUJ1u2rqfGFHB3nCezj7upLjibxbV62H2M
	sJpsz8uebRWN6xdQ/VWfHXNoQGpjajTyzpFx6unyLPvVjL9yP3BC6yLTphvY/rng
	p7SnNOxuSwvM1mQS9mATN97LdiDKW5o+d8A==
X-ME-Sender: <xms:4ZtBaGtDjlQqy3GYJZ8AfdP10B3hXUV75321XWl1iRijsufUt2AUdQ>
    <xme:4ZtBaLfyvgnzuRiLa2Bogw4dVLU-remdHxmfqqAU4yDA3FlBQ7KP-nvyVYw00itDb
    -T8ZAmBF4Xz8J-rdg>
X-ME-Received: <xmr:4ZtBaBwach6PwwbdbJIoMUuuqljioHoXfeoozlXzqXbw8l8UTcqWEj1mEDZIevdJJZ6SkBx3i9-0BUugmFnMgY038yTudVIY3IBN>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddugdefieelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgesthdtredttdertden
    ucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogi
    drtghomheqnecuggftrfgrthhtvghrnheptedttdevffeuieeilefffedtiefgfeekveet
    veevuedtlefhtddugfeltdejledunecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenuc
    evlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgihhtshht
    vghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeehpdhmohguvgepshhmthhpoh
    huthdprhgtphhtthhopehgihhtghhithhgrggughgvthesghhmrghilhdrtghomhdprhgt
    phhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepphhsse
    hpkhhsrdhimhdprhgtphhtthhopehjohhhrghnnhgvshdrshgthhhinhguvghlihhnsehg
    mhigrdguvgdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:4ZtBaBOyvRiIpoim6_-It5I4gQQfhBQ-hING8A8GFYCQRUcxbHWRzQ>
    <xmx:4ZtBaG-oidZRaF6iAEKnvNdU83lpjf1FE60QS_iPoeK7_H55Z1PMMg>
    <xmx:4ZtBaJUNKw9RoYIplUUFg-nGA5OhkqWKlc6vi2xKMqm8jM7zIdEo8A>
    <xmx:4ZtBaPc3glFOSOhUePl0psYLfsZ6o5xX2q2Dt3qGoMsfCW6YpI1JVg>
    <xmx:4ZtBaP18562GijgEvve9hnNM0eouH0HcS3Q2ojY_SoqzMdtuakGx09qK>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 5 Jun 2025 09:30:08 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Patrick Steinhardt <ps@pks.im>,  Johannes
 Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH] t5410: avoid hangs in CI runs in the win+Meson test jobs
In-Reply-To: <pull.1932.git.1749118606047.gitgitgadget@gmail.com> (Johannes
	Schindelin via GitGitGadget's message of "Thu, 05 Jun 2025 10:16:45
	+0000")
References: <pull.1932.git.1749118606047.gitgitgadget@gmail.com>
Date: Thu, 05 Jun 2025 06:30:07 -0700
Message-ID: <xmqqseke9uzk.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
writes:

> ...
> This bug in the MSYS2 runtime has been fixed in the meantime, which is
> the reason why the same test case causes no problems in the `win test`
> and the `vs test` jobs.
>
> This will continue to be the case until the Git for Windows version on
> the GitHub runners is upgraded to a version that distributes a newer
> MSYS2 runtime version. However, as of time of writing, this _is_ the
> latest Git for Windows version, and will be for another 1.5 weeks, until
> Git v2.50.0 is scheduled to appear (and shortly thereafter Git for
> Windows v2.50.0). Traditionally it takes a while before the runners pick
> up the new version.
> ...
>     I finally had a chance to look more closely at this problem. Here is my
>     alternative to what Patrick proposed in
>     https://lore.kernel.org/git/aD7tKfXD7YxprSZh@pks.im/.

Superb.  It must have taken a truly heroic effort.

Thanks and congratulations for finally solving the puzzle.

I do agree that Patrick's "wrap the same in a script" smelled like
shifting a timing issue and not truly a solution.

> +# The `tee.exe` shipped in Git for Windows v2.49.0 is known to hang frequently
> +# when spawned from `git.exe` and piping its output to `git.exe`. This seems
> +# related to MSYS2 runtime bug fixes regarding the signal handling; Let's just
> +# skip the tests that need to exercise this when the faulty MSYS2 runtime is
> +# detected; The test cases are exercised enough in other matrix jobs of the CI
> +# runs.
> +test_lazy_prereq TEE_DOES_NOT_HANG '
> +	test_have_prereq !MINGW &&
> +	case "$(uname -a)" in *3.5.7-463ebcdc.x86_64*) false;; esac
> +'

That's very specific ;-).

As this is not in a library-ish part, it does not have to be lazy.
Anybody running this test script need to tell if their environment
satisfies the prerequisite, but lazy one does have a documentation
value, I guess, and a bit of extra indirection does not hurt.

Will queue.  Thanks again.
