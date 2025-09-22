Received: from fout-a3-smtp.messagingengine.com (fout-a3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF77D2EC0A8
	for <git@vger.kernel.org>; Mon, 22 Sep 2025 15:54:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758556479; cv=none; b=LN+57FOZ2re0pRRclKyGMwX0TkS+l82QlzrmbJOi0dMxhbHh6Mvki0gT3V8wJpOK2mTNje4UZF3FBo2tkLMCWIHIS8Ed1rqC2p0/G1edWNO3KidwGkoEC75GmzsXG7gyMAT756mSuDHmGHnQPcUD5A1YE5bySDiUCYPJbrstBGU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758556479; c=relaxed/simple;
	bh=aV6COBIoLkppaYfA8DzRGB5tzwwwwQSvIRZSamwsMSA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Lz54mLpto156sACrVXLLkqkXvrlx26Hx18Ht84OCb/UkZX5gcGLZFRqhY2Q89m9JnbXDOLuWbJOxxZ6gxcjuDx8rISQr4JJysSBdOStNh6X5PpJdMjZcivS4XR7JzLwu1zxbwx+mYw9U5IcEk/IsaienbJI/5coBLKBluFPQ2jo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=fHcqZ6f8; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=RMe7QNFp; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="fHcqZ6f8";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="RMe7QNFp"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.phl.internal (Postfix) with ESMTP id BEE51EC00AA;
	Mon, 22 Sep 2025 11:54:36 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-04.internal (MEProxy); Mon, 22 Sep 2025 11:54:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1758556476; x=1758642876; bh=pCrHe92rSi
	ScHqsc9SyojlQ3eG44bjvqNj1BA2VH4Ac=; b=fHcqZ6f8OagRdcVVQpKseYoByZ
	16/nCn7NeCIafktSMwnYcbiW28TftjWnZ/J2Amy0xECwa2rNbat7IgXhZgTdi8AU
	GENmrBf3QEf2o/xXR5vj0OlwUReI6akVxsLIkyfiLKTomUp7il7GrlYvEauOvUHy
	rqSzteN5zviAL0SKPPhljOV8ey8WYEc/tsTHUiJ7gtGe73oThr4IKKpG6xzIxOOI
	A6WfA7/0Zq0qHCsK+xueJfqWsU3cp2u2Oihej8Is6g24ZAjZU/XGH+BnRSQZO0Pn
	hFwZPpws1qt9YZPEdgejunQv02YIhmjFdzXO0I0qr5BLy1igmNPlbXI0ZBKQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1758556476; x=1758642876; bh=pCrHe92rSiScHqsc9SyojlQ3eG44bjvqNj1
	BA2VH4Ac=; b=RMe7QNFpdPl6VAeVt4cs0phRSc05KSDrHvaU9xjAORpu9/C2G78
	phw4qeptmdJg7bMX0hfVEtEuzGOLdtqzPiwQcNlPYKWOKARsrWCZS4mXR/FW9OWa
	eTRlgfY96uzNnnQVmpPUmwDiCy59kx1oj2JCydRmCSjaWUsk4np7Iz3McJnG020T
	sZO5aXjWCG4WNBes8VWekjS7549xdJy3t2pGyPY0qb2oawPUGE5KLk2O0bbRF4xQ
	4tbbQ/74c+aX4hrABIbJEXG1rAd0J4TAj8NnB8bdiM0ZFfQN8Ys8n0Vqiseq+sWV
	2YsZxjovEFFsfLsJBeic6RDnTu3gjozb0HQ==
X-ME-Sender: <xms:O3HRaPJDUcT_pYUJZN_YffD0y_XMVdRGyoHIqeBgC4iV2CFBWIf7Jg>
    <xme:O3HRaKIa7HtwAEvp73KlmnFWa0STszwrASMtFDJhg6y2bmO9USRNFBscN4ixwytiZ
    cbeoMgctGTdqMK3tqkBJaVjIXvaeoD_dTuzfXURPJhRA7H73th0nQ>
X-ME-Received: <xmr:O3HRaMvwtlr6OL_i4SmcWsLOZhM1CrUdanFx25dJcFShTGynDYuk1QZHVVdg8o-QdQjf_gnM6Q0w-m0HjFhpv_38a1Q_9Fwb75gU>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdehkedviecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecuhfhrohhmpefluhhnihhoucev
    ucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtth
    gvrhhnpeefveetteejheeugeffledvteeiveffueefjeelueffteeigffgfedthfefieeg
    ieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgih
    htshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeegpdhmohguvgepshhm
    thhpohhuthdprhgtphhtthhopehtohhonhesihhothgtlhdrtghomhdprhgtphhtthhope
    hpvghffhesphgvfhhfrdhnvghtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgv
    lhdrohhrghdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:O3HRaHT2ftrvAo85VJO9yT52fvLxW-s4VPOvSAArlZEAanrZg7oKKA>
    <xmx:O3HRaCNdrJHkKxa7IbzUoWV9-P9hnmnkkzLlFLLIeeKXLIy4xKz75Q>
    <xmx:O3HRaMZn62ZIP25sNgMZOWfmFaEWnoCu8f7IOySWy-h7MiN5S4QhFw>
    <xmx:O3HRaMwm6jeBMADIk_AuSDiL656etWL_dzBI4vpPcT2aRSQTnLjH6w>
    <xmx:PHHRaDB4VB8wu24MJzhuloSEELSsJ0MouUWBxiktNAIQaLT4tQKjfu_0>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 22 Sep 2025 11:54:35 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Toon Claes <toon@iotcl.com>
Cc: peff@peff.net,  git@vger.kernel.org
Subject: Re: [PATCH 4/4] refs: do not clobber dangling symrefs
In-Reply-To: <20250922122332.584428-1-toon@iotcl.com> (Toon Claes's message of
	"Mon, 22 Sep 2025 14:23:32 +0200")
References: <20250819192934.GD1059295@coredump.intra.peff.net>
	<20250922122332.584428-1-toon@iotcl.com>
Date: Mon, 22 Sep 2025 08:54:34 -0700
Message-ID: <xmqqwm5qv5xh.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Toon Claes <toon@iotcl.com> writes:

> We use `update FOO_HEAD 000...000 000..000` to delete a symref, if that symref
> is dangling (otherwise the old oid would have resolved to something). I've
> attached a patch that would allow this (on top of your patches). Do you think it
> makes sense to allow this scenario?
> ...
> +	test_when_finished "git update-ref -d refs/heads/dangling" &&
> +	git symbolic-ref refs/heads/dangling refs/heads/does-not-exist &&
> +	echo "update refs/heads/dangling $Z $Z" >stdin &&
> +	git update-ref --no-deref --stdin <stdin &&

"git update-ref --help" seems to show that the "--stdin" mode has a
separate command that is designed for exactly the purpose of removing
a symbolic ref, though.  If you are changing the semantics of "update"
to make it safer while dealing with a dangling symbolic ref, do you
also need to touch the code path that handles "symref-delete" command?

> +	test_must_fail git rev-parse --verify refs/heads/dangling &&
> +	test_must_fail git rev-parse --verify refs/heads/does-not-exist
> +'
> +
>  test_done
> --
> 2.51.0
