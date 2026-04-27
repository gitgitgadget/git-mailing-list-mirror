Received: from fhigh-a7-smtp.messagingengine.com (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 505C43890FE
	for <git@vger.kernel.org>; Mon, 27 Apr 2026 06:45:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777272339; cv=none; b=LZuphAwrJoZTOAjbv5/6Kl8StjzPmIMJy2VhKVPEs+tepbsZ9azBk0s6oMXp8aDa2i/v+ALS6OwBqpjeuGC12/M/ITDPwm8hOfUt/+Tcb6JfeX+oUCl56fTDShjdlU2jJPR65OWEUc49jX2ELxKC6fsByO8PBsijOzk5Wz4X1YU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777272339; c=relaxed/simple;
	bh=1t12KVtcNor3G2fhTqha2ZqpJEfQqqs6eWmMMHzo6+0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ELzej3+6eJNI7oK/FsZfv+ueNwf9IddyeSTkWXBtHRecOTqi5QuQxLdaVkSPTqFbJOXduHUR/TckpcFPL3f2JCCPHJJ734z8VuOJ5HcU0X8ThvBP8euBExAssgnKCKcc//cAehTpwXeXiUrbS4z6yUilCYneu8Lk6LhdgBcR4VY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=o3PLZcEu; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=fmb2jIJ/; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="o3PLZcEu";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="fmb2jIJ/"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 7AC8614000FF;
	Mon, 27 Apr 2026 02:45:36 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-03.internal (MEProxy); Mon, 27 Apr 2026 02:45:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1777272336; x=1777358736; bh=vqNb8grZZA
	OkheMNiaE/C78cq/RsyomuJLGpw1Cn7Nw=; b=o3PLZcEuk0ne39HWEpBciXQ8FE
	S6NHZXO/KhFXQyWlo+XqTIBjjaqCqgF/QPqFeSWxQNFVQ1MHMbNJOyXhDvBTiREx
	aImk8ndCZDAcLD5ZEw4w+UlFwGYaSO2INReX2g/6WbqZfYE811Tknjl2E2GBiICS
	wfO3oBipa8yQgCx1v6m7IiSru3CVtw+o3MXJQFM83ogrZVNhSchnBOlKSq7MzeD+
	uas+4Rg1SQZ9emAbv2UyPeaCYCOfRqhAKr4YbEr3ZxPZsAsvkmUvhTPplQRZ8SBo
	qyHsQC1P5T1z6B0ICcWNHqN4dVU1Lga79bLo1snf9U/RFTIqAYTZiyiZ5Rzw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1777272336; x=1777358736; bh=vqNb8grZZAOkheMNiaE/C78cq/RsyomuJLG
	pw1Cn7Nw=; b=fmb2jIJ/OTCpdwcfkxTPnJ6VYFAx+mXyWJ3nhMdRhrhMg7b/k2X
	zUcHJFOpLRieiix+2ZLS926VCANYs0u9pyLGMZ2c2FSTUwNKazBZSKah7L15vwla
	fbl8xjyw+kYfpmjhHklrI6zdiIp730hvO3aOlr2OA85VpRvAnDo2KaZjJbJlMrgQ
	9CxfpYgSt4XjO8rOPjab9jdU+C0uQIDxY4eT152BwCSySU9S5lViGWfsFmHqo5ly
	FtwtXlOk/xQDBCXKZpz9bY/eo+Lu+Vykt2KoDblMHHafSNR5Ef0l8M07krMEJoj6
	aWoMgGIh8Tu9Q5vlZQEgIZP2SYvipjNnwzQ==
X-ME-Sender: <xms:EAbvabL2HRN7WuFcVcT8VqXQWaJeaHUTI6DVRRl-3FNbqLqzzA8G7Q>
    <xme:EAbvaePw5mUgBcA00BJeLFTjsjkTo7yOc-3Hd1RNkmwFzHbk5jibgFoyr90BYgJ7J
    1diprsM4XwUEI7zX3JW7oCyoEXAjP3GBcDhnkpukGUyhgR_22K97Q>
X-ME-Received: <xmr:EAbvaZ5AkV7oW8EBaelCHDAXEmD8UiwH3Zu9w_OlLhb0_Oyu4LiYIOjCQQQvFrJmFYf1NFTusVpGxGHIG4xGXJkIT9VJo_At_w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdejkedttdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecuhfhrohhmpefluhhnihhoucev
    ucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtth
    gvrhhnpeefveetteejheeugeffledvteeiveffueefjeelueffteeigffgfedthfefieeg
    ieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgih
    htshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeekpdhmohguvgepshhm
    thhpohhuthdprhgtphhtthhopehmrhhoihhkseguvghlrgihvggurdhsphgrtggvpdhrtg
    hpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehpvghf
    fhesphgvfhhfrdhnvghtpdhrtghpthhtohepjhhnrdgrvhhilhgrsehfrhgvvgdrfhhrpd
    hrtghpthhtohepphhssehpkhhsrdhimhdprhgtphhtthhopegtrghtsehmrghlohhnrdgu
    vghvpdhrtghpthhtohepsggvnhdrkhhnohgslhgvsehgmhgrihhlrdgtohhmpdhrtghpth
    htohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:EAbvaQ6Vd86GOtGhmILfLDZddvmo2SPD4B_TgMwg2Vo7Z55wfgOYIQ>
    <xmx:EAbvaXGZ-w2QUPrGPx2UYqwzPMUf-4riy5rlyHS9UfIT6bXxC_908Q>
    <xmx:EAbvaQXZ31J63PReg-CD9mpGkWNiIUKjxcd1KmD-DBd9fBIhJRHb9A>
    <xmx:EAbvabU1qU-5dQXD6ejKy_qyDPoiRbReOBtXRURBWrWTrRLYADe_pw>
    <xmx:EAbvafWGNNfhTVQu-TxTitI26d1xpr2Iyn6_g82dM-jPpnM8dT-bIzZ1>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 27 Apr 2026 02:45:35 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Mirko Faina <mroik@delayed.space>
Cc: git@vger.kernel.org,  Jeff King <peff@peff.net>,  =?utf-8?Q?Jean-No?=
 =?utf-8?Q?=C3=ABl?= Avila
 <jn.avila@free.fr>,  Patrick Steinhardt <ps@pks.im>,  Tian Yuchen
 <cat@malon.dev>,  Ben Knoble <ben.knoble@gmail.com>
Subject: Re: [PATCH v4 1/2] revision.c: implement --reverse=before for walks
In-Reply-To: <4864ac46dd8ef4b704c29efc96c45f4e1412373b.1777249165.git.mroik@delayed.space>
	(Mirko Faina's message of "Mon, 27 Apr 2026 02:24:57 +0200")
References: <cover.1776984666.git.mroik@delayed.space>
	<cover.1777249165.git.mroik@delayed.space>
	<4864ac46dd8ef4b704c29efc96c45f4e1412373b.1777249165.git.mroik@delayed.space>
Date: Mon, 27 Apr 2026 15:45:34 +0900
Message-ID: <xmqq8qa852b5.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Mirko Faina <mroik@delayed.space> writes:

> In a revision walk `--reverse` can only be applied after any commit
> limiting option. This makes getting a limited amount of commits from the
> tail impossible. E.g.
>
>     git log --reverse --max-count=3

Can we rephrase "from the tail" somehow to reduce ambiguity?

Normally we generate a list of commits from newer to older, and you
are saying that it is not possible to take the oldest three commits
and show them from older to newer (i.e., in reverse).  But that, to
some readers, is showing commits from the beginning end, not from
the tail end.

Perhaps "... limited number of oldest commits impossible"?

> Teach `get_revision()` to accpet an argument `(after|before)` from the
> CLI, and apply the reversal before or after the commit limiting options
> based on this argument.

I think "after" and "before" comes from "Do other things (including
count limiting) and then apply reverse after all that" and would be
very much understandable to those who know how the machinery works,
but should mere mortals need to know the machinery only to use "git
log"?

To put it another way, do you tnink experienced Git users who
haven't seen the actual implementation of revision traversal can
immediately answer this question:

    Now we have --reverse=after and --reverse=before to let you take
    a limited history from both ends when used with --max-count.
    Which between after and before do you think corresponds to the
    traditional --reverse that allowed you to only see the newest
    part of the history?

I doubt that the population to answer correctly would not exceed a
half by large margin (if it is 50% then it means nobody understood
the difference correctly and they just flipped a coin).

I wonder --reverse=oldest and --reverse=newest is easier to teach
and explain?  I dunno.
