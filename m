Received: from fout-b4-smtp.messagingengine.com (fout-b4-smtp.messagingengine.com [202.12.124.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3886031282C
	for <git@vger.kernel.org>; Wed, 15 Apr 2026 21:04:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776287088; cv=none; b=PNwrnqDqfT9PdxatfUewpMWc5+Qz7thIWUUC/+/dVGdUWZQpbfsjR6tKCKFSPRb82EjPgrtZKm+VP0zU1NS0oOpCrbZluGE2aeWVhCTyVcIYvt5hIvXu5anYREd0u+VmZW0cALmnNyzUeB5lxT+2eaTbYnthxjeCUmTmMlbybIo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776287088; c=relaxed/simple;
	bh=TDp+x1YwPDjKUdu1pADLNCURhWOIZN3/0w6iYz9CIUY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=uwiHvuu8mHnFxYRXdbIcAp9nWkoodKu0bTyejpIMKRiGb7aWH6XEFTf0DaAoQGK3BVWsP/ErMURDIFvpn1XVS4dPKyuuRdiu4EUKvTjm51LTpe6n4pTg4M6l5bjxdoyB+Yiy8YIErQKnlUnVnDUIX8aPqhHubiE0ZqLMzLPBiK8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=tI+aQky9; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=eFS/tQ9U; arc=none smtp.client-ip=202.12.124.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="tI+aQky9";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="eFS/tQ9U"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfout.stl.internal (Postfix) with ESMTP id 26B761D0025C;
	Wed, 15 Apr 2026 17:04:46 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-03.internal (MEProxy); Wed, 15 Apr 2026 17:04:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1776287085; x=1776373485; bh=zeLdErpDQF
	TK/bsK4k8K/QWloGQMOjPGwFV9WzzlXJs=; b=tI+aQky929NBuWPxGcz2O/doPM
	2THiVJ6EIpynZnci0SyuRCguN8xieTY7TEJVHSYU8O/HqdPPRaVV9SpyU3CTxBhD
	7REvz2VClKj/NdtkPBURxOPT37KpBVgVKA/GqMJkyrNfPrSbYwGFjT//BVuzibTl
	KMkL3w6JZKdsNtIjD58kcjP4F//KV6PsIFFLErVuK5hgXUdKmmgWr9B6z0cEGIFy
	pUTP9UeicNeCpDrRSJZz4F6uKHDBPta+YUFVyHycpQDwhvwM7OcfBcONMOB4LGcK
	dXo6ROU8mOGqdJrqB6ykM9Tjb4qhuhiWGg5rnFyb0E4uYEov5aSWUIe0Y3og==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1776287085; x=1776373485; bh=zeLdErpDQFTK/bsK4k8K/QWloGQMOjPGwFV
	9WzzlXJs=; b=eFS/tQ9UQLeJC1BDGU4p4pcoXTSosRsmySQvk/JC/vnWhNFXzk5
	JoavKJHGmI6QeiD/liSpoMgPd4NpF1c4Eqf+NkEC+dsACJPkatSOJ8RIuAk1SC2v
	vO/soAfZuV9nqPA3nrR95tX60yibixUDB55vALj6a1G9rVWri6XkLpApGo/rr+bv
	3zILiZSAk7p5Z3ILqPR75nLRhHEcv4x2VscPQkuciyfrHVExURUzR42OB6MpLKjw
	OW0dtDmRliOi8TfuEhUEtITPNP+rEV5aVIz3Kql3YgCHMY4iyOtkX+Hd+9Zfzwrr
	bRiJZ8XFIS4pWqDXTESD60q2BkIXJQyt1uw==
X-ME-Sender: <xms:bf3faUqEy9nqClc0Ud-bT6QuI_ScfW2pDVTMx7XJZ3c0Kdr--DviDw>
    <xme:bf3faRqQ6BftC67mH0JHMMlppCQVC_2bgKATRd62o1fP4oo9Q7D7IVgUYQt39AphS
    -SrU_9sZbVqy1MHanGhpr7YmpWv1lzOgE0mXwjnxTjnIVqGRGWIpA>
X-ME-Received: <xmr:bf3faePEXvFjK0VWKXwi4NAOM2UWqcy01YjMAY9CK9wk2-8zpK3a9FYJbAZT1gzwwAwIjUHXQcqPkbYat9gBJ6U78Yb9rMgHSA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdeghedufecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecuhfhrohhmpefluhhnihhoucev
    ucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtth
    gvrhhnpeefveetteejheeugeffledvteeiveffueefjeelueffteeigffgfedthfefieeg
    ieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgih
    htshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeegpdhmohguvgepshhm
    thhpohhuthdprhgtphhtthhopehmvgesthhtrgihlhhorhhrrdgtohhmpdhrtghpthhtoh
    epghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehjohhhrghnnhgv
    shdrshgthhhinhguvghlihhnsehgmhigrdguvgdprhgtphhtthhopehgihhtshhtvghrse
    hpohgsohigrdgtohhm
X-ME-Proxy: <xmx:bf3faazUoR5FCmdZVJJBtefyHIeXYtGULxwYq9Z1W4yVjSbfLy-CrQ>
    <xmx:bf3faftKy1OycKc6z16-AwA-5eCDtnL2Jmm5D8y9OWluEhxsS4J-dw>
    <xmx:bf3fab685mpMUGUQTzJ7nD04_FGU7urUZaWeWm3u2FNqw0TIz4TL5A>
    <xmx:bf3faWQk5Bz70EXZwpPBdo3eBEu60dAHkON7a06qhxvmNKIIULj65Q>
    <xmx:bf3faULX8g0K1vAlPnMMJRm-dmfhCvd-P6d47ms6JBk7lQEOl0s8WYn3>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 15 Apr 2026 17:04:45 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Taylor Blau <me@ttaylorr.com>
Cc: git@vger.kernel.org, Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: MIDX woes, was Re: [ANNOUNCE] Git v2.54.0-rc2
In-Reply-To: <8c1def10-9039-aecd-4ce4-fb4676b47e9b@gmx.de> (Johannes
	Schindelin's message of "Wed, 15 Apr 2026 22:50:41 +0200 (CEST)")
References: <xmqqqzohd0sh.fsf@gitster.g>
	<8c1def10-9039-aecd-4ce4-fb4676b47e9b@gmx.de>
Date: Wed, 15 Apr 2026 14:04:44 -0700
Message-ID: <xmqq5x5s540j.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

>>  * Further work on incremental repacking using MIDX/bitmap
>
> I just noticed that a fetch with v2.54.0-rc2 into an existing repository
> rendered it unusable for Git v2.53.0:
>
>   fatal: multi-pack-index version 2 not recognized
>
> Is it possible that v2.54.0-rc2 forcefully uses a MIDX version that has
> _just_ been introduced?
>
> If so, that might have been a premature bump of the default MIDX version,
> if even the preceding Git version fails to handle that MIDX version. It is
> guaranteed to cause substantial problems in setups where e.g. libgit2 or
> JGit is expected to be used interchangeably with Git. It also causes
> problems when users have to downgrade Git, or use several Git versions
> side by side (e.g. using GitHub Desktop, which bundles its own version of
> Git).

Is b2ec8e90 (midx: do not require packs to be sorted in
lexicographic order, 2026-02-24), which says

    This change produces MIDXs which may not be correctly read with external
    tools or older versions of Git. Though older versions of Git know how to
    gracefully degrade and ignore any MIDX(s) they consider corrupt,
    external tools may not be as robust. To avoid unintentionally breaking
    any such tools, guard this change behind a version bump in the MIDX's
    on-disk format.
    
relevant?  The version bump seems to be doing more harm to "older
versions of Git" that "know how to gracefully degrade" by not
allowing them to degrade.

Taylor, perhaps you would want to add some instructions on how to
recover?  Like "rm -f .git/objects/pack/*.midx" or something?

Thanks, all.
