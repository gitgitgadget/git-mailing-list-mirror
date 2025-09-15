Received: from fhigh-a4-smtp.messagingengine.com (fhigh-a4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 884511FDA61
	for <git@vger.kernel.org>; Mon, 15 Sep 2025 17:28:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757957308; cv=none; b=NJEW6EZlcAggfipoHrAnrQl5XlCLZsset7lhxxsUBBFgCFv55sVf7aD2V3mWjgS70l1SjW0CP2rpTIuoPJQKAhrwcZTPTxG243wvyn7WJZi3RmCOWRUKB6nLEMx1lyW0hIkjrL1kdfuVcET+A9nPzDYbrj7kkeU3wnjeIEiIQkY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757957308; c=relaxed/simple;
	bh=kKfyF7+ErNbIVEeDgpDiDx3TbcR80waKjW6LcARfLIY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=a4oN48czWaLsxBSwn5GlahPhSrhDqYIDRouhhPjRwuznVPhAbnI2m02/J3HPqRx8CVh1124kycm97wFQ5Y6K+kzlzMju7/babLyVjB4Keq1vfAGvZTs2vWIH8RUNnulHeVcMm/bNF/QgTd6p6Uake7yKdce5BTzbuocMmb6yjRg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=FHA8h58Z; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=FCHF72ip; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="FHA8h58Z";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="FCHF72ip"
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfhigh.phl.internal (Postfix) with ESMTP id BA1F914000B6;
	Mon, 15 Sep 2025 13:28:25 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-10.internal (MEProxy); Mon, 15 Sep 2025 13:28:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1757957305; x=1758043705; bh=Ui7HnW9UAu
	eq+XH9Llq/p86e1zfLPucKq7VzJS6WVAc=; b=FHA8h58ZO0EIM7iMk9R9SrZ5TY
	H3drfiNjBiaDMhjxzsr0hhyguMEFFDi7+3oU5uRM1kclwZk3uQYoIHuedtgvN3f0
	G+SMOMtAAGjFeFINyN7Q7gZhVWho20r7Ns+SGwjAWZ91VCo4Hph/iesCDXAZJXyK
	+GJXSDw4nqHHo7aDmV7IW0r9hcrKH0vphkHZN7bx5GQbNqkJgeFk/T82ZqRd+51g
	QMqq6pLqdhiz+gvuj8iKdY3MH4KCJI80f34yJXzilYk0bDfs6BYBGc6UoUeAFkaf
	EESMojGa48xEZVyoLbZSY5AcLOsmAHtVP8GzwNH+9iMlF/aFq7ZV0xFinuUA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1757957305; x=1758043705; bh=Ui7HnW9UAueq+XH9Llq/p86e1zfLPucKq7V
	zJS6WVAc=; b=FCHF72ipS6cENI1RgDG6CpX67lSEv6Ov6sBBOnrgot9Gyf+p9B6
	SyYrvHjsmCrkfVc0OGiwN8IR8JvPj496k4aeX07Ce62U90tQ41JwbtBorB4HAOdZ
	l53I6/+vQPfuk9ucOf4r9YKV6mKfZzMiyVGXhwidvILCt3jj7F/7YxuJS7d2jgvF
	dl04yK4rFWHStzDfKWD9WnGV9IEvANI6jkoUff03wpkMKz6lHoeHZwEvbP0brZ3L
	erOr5RK9+88aeCdANqJwEaGCzW9WaYKbzxLhCstikRqS3jY58tPLY3OuS+bPbjmi
	p3L8/ahoDUL+q0qO8nU+gS0vUJ1E/46HkEg==
X-ME-Sender: <xms:uUzIaBeefIsMRVMwsrx1N_VRZcaWEjdAoceEC20t_DU2JTssL-HuWw>
    <xme:uUzIaKuMXqzDh5VRTBcxK222mvSfR_2Ro7Fz5UsEM7sVo6pHcAYLrNmAKSsZ2LXg0
    LwqaQw5Ib9L5zOYng>
X-ME-Received: <xmr:uUzIaA-x6NM6TDKQSo8M1BZwiDdb_qNvc8oGfI4wCfZaAObPBZpDPMmFIcX6qnkJbPP8LU4Up0Fj_77v3GHo9Gb0Q139KPmhn3IN4N8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdefkedvlecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtsehttdfotddtredtnecuhfhrohhmpefluhhnihhoucev
    ucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtth
    gvrhhnpeeikeeufefhtedvffdtgeefkefhffeggfefiedvudegfffgffffveevvdeileff
    udenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgih
    htshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeehpdhmohguvgepshhm
    thhpohhuthdprhgtphhtthhopehpshesphhkshdrihhmpdhrtghpthhtohepghhithesvh
    hgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehsiigvuggvrhdruggvvhesghhm
    rghilhdrtghomhdprhgtphhtthhopehkrhhishhtohhffhgvrhhhrghughhssggrkhhkse
    hfrghsthhmrghilhdrtghomhdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgt
    ohhm
X-ME-Proxy: <xmx:uUzIaF2aELqs4j7Yq9HLjk2Ae6lAR2DNRfdmMFbQi4iLHMTJ_V7zPw>
    <xmx:uUzIaFCheRtahRLPMysdDY6p3mWjpe9CpitS2e3NGGXxpiYyKy2bMQ>
    <xmx:uUzIaBfXsGUhet966HNNGPoXLssw-FqWR7GjV_dWwuCYZkwtqUmIgA>
    <xmx:uUzIaC6AL2ASB9EKWANtmaa8jEsLimJe7_DJQDDLoxDlem428HLdfA>
    <xmx:uUzIaBOSx_vrOYzZiqzRe_KOGVTAED8gmnidhSupVbmBUKqvvRDDTt9E>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 15 Sep 2025 13:28:25 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org,  SZEDER =?utf-8?Q?G=C3=A1bor?=
 <szeder.dev@gmail.com>,  Kristoffer
 Haugsbakk <kristofferhaugsbakk@fastmail.com>
Subject: Re: [PATCH v2 5/5] builtin/config: do not spawn pager when printing
 color codes
In-Reply-To: <20250915-pks-config-color-v2-5-e4290bd8d13c@pks.im> (Patrick
	Steinhardt's message of "Mon, 15 Sep 2025 14:52:52 +0200")
References: <20250915-pks-config-color-v2-0-e4290bd8d13c@pks.im>
	<20250915-pks-config-color-v2-5-e4290bd8d13c@pks.im>
Date: Mon, 15 Sep 2025 10:28:23 -0700
Message-ID: <xmqqikhjhbgo.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Patrick Steinhardt <ps@pks.im> writes:

> With `git config get --type=color` the user asks us to parse a specific
> configuration key and turn the value into an ANSI color escape sequence.
> The printed string can then for example be used as part of shell scripts
> to reuse the same colors as Git.
>
> Right now though we set up the auto-pager, which means that the string
> may instead be written to the pager command. This is of course quite
> nonsensical; there shouldn't be any use case where the color code should
> end up in the pager instead of in the TTY.
>
> Fix this by disabling the pager in case the user is asking us to print
> color sequences.

I am of two minds.  Part of me obviously agrees that it is more
straight forward with this change.  But it may 

An interactive user experimenting while writing their own script
might say something like

 $ git config --type=color --default="reverse red" n.n

If the command emitted directly to the terminal, then everything
they type from then on will be bloody red, but the pager protects
them from such an accident.  Instead, they are forced to say

 $ C=$(git config get --type=color --default="reverse red" n.n)
 $ R=$(git config get --type=color --default="reset" n.n)
 $ echo "So$C Bloody ${R}Red"

but these are likely what they would be writing in their script
anyway, so...
