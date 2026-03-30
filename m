Received: from fhigh-a1-smtp.messagingengine.com (fhigh-a1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 192D6391E65
	for <git@vger.kernel.org>; Mon, 30 Mar 2026 20:04:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774901065; cv=none; b=UfF4BelZzckhFSMm0IYsFaH3quwJ0rvi45tOevVyjlNWmkkplCWcyCj39yCzPdXSzwaMkP1vyvSGng32FnSsW/rnKS40uUAEDRUDWcHsH/aaySHT6kteLDXObmyg+hRJwnaTu71bchpDk9Qrnwe58C2LQRNXZRlEdWJj67waAzo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774901065; c=relaxed/simple;
	bh=aQg51WCNl+zu/tEf/lvEPkzdr1YP246lOhyqX1ha5OQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=amhqg74Vm9W+JavZf6O3xtgGPPLrPRXg09EVvF74jJ4s9pb92SboUvkK/Z1PFZqI6VqukGv2gHl+XledUNHgTeoyxUyCL9wCnHWsFmyRpumbQqrT83352T/l8ctwdsjoQcjq2DlSwyl3XeUr8rpjU122NcpyXbXnMaZS1RA0Tg8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=BuaSppeO; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=rMt4rdC3; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="BuaSppeO";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="rMt4rdC3"
Received: from phl-compute-08.internal (phl-compute-08.internal [10.202.2.48])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 530C014002DF;
	Mon, 30 Mar 2026 16:04:23 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-08.internal (MEProxy); Mon, 30 Mar 2026 16:04:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1774901063; x=1774987463; bh=pEkubpR1rk
	dZLAunuxzDudI0vNTtxqhR+UwMV+MDRXI=; b=BuaSppeOHAYbW8X3ZhXzUe/SV+
	hbp5wtnQBjYSYQw0YkuL7Wy7hQTdmygWsR967uWO4qNBoD+rCaAE/SqtTqJaWnME
	XlwhECJlhSQcTSh70RnyzU/WoFVJIkq+Y0XrQ8Jpb2es2lMr6tw/bYFojL+8pc7M
	50/8uAp1m2dbuA/Aw5ARLbgp2Js9qPE88Hafj0L4qr7n/xE55wxiS18TMgKwProD
	blogXKaSWJ6XGs6Kr3nzU7wd88HTg2ZFqP61S7Qbcy3vQ9CiDHGyv33cTtIbto4Z
	FmpceWFg8pxL6j8UuoL/0QgfI6PZ+YyJdCWPk4owPCpECcdXr+uWsASLqVaA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1774901063; x=1774987463; bh=pEkubpR1rkdZLAunuxzDudI0vNTtxqhR+Uw
	MV+MDRXI=; b=rMt4rdC3gKSG6rL4Ib3Ldw6uLLo6DzGVFOyaPFy7cUmbbC29Xb8
	Ab3Q1mDi0Qo82xR/Fkq0D4bhWNpDPat7OdC+9RgNVw16E3ExYVrjVZB9pZlJRiNO
	npaCLRcd7pcs2HpAtgxptgVHUn8peVbcZMG6qnvpIWVJgSajddcki3nKNOsSVeJQ
	2bo/a2GDpUraFLHFVRbstq2qFU9+RooG17NPGL0ll1t1WsA6GD9U4HmutK5kPqB8
	WLk87vJtV6Q/2mgGofuFlJRbuKT5PQ5CfZu7XxHCrgxL1kV4nSO6ccA6R5F6mtDm
	kR6uwkR4lCZbQvjftJqfpXzt3C/tRIUTcUw==
X-ME-Sender: <xms:R9fKafFPyWA-aJT1t3AaB_2HeSgPqW76ecASDC3spL3Do2Wm1Jp0mQ>
    <xme:R9fKaTVQ5Ca_lCv6oshmIm59uq0CSLTYEmmZffAeXp_0TRi8_stoSPiNRFZAovtAN
    KKMLxfBCtaJ0thiz1jvYOgrWprWtssOJqfmutSsBPCQZV1yfbCaag>
X-ME-Received: <xmr:R9fKaWLSCwTvDHKe3UE7mLw3nniS1B9aC07ascB88ntTW125iGN9pmTIO0fFhQOyVgNhd0pVtuSPn2hxyCc17NE9xRdqhWebgw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdeffeelkeelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepgedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepghhithhgihhtghgrughgvghtsehgmhgrihhlrdgtoh
    hmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthho
    pehjrgihvghshhgurghgrgelleesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsh
    htvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:R9fKab-thB9MW7VSA29xnCort2HwCrHhDneR7r99ow4jaavmDt_Q3w>
    <xmx:R9fKaRLK7Bo7D2PKc-cuJiP9JWOlT9UcDs8cKl_tOY1yzRmWQHmI3Q>
    <xmx:R9fKaYmDjGdoW-pO_qnDAjqGC9PlZg2O2fbuoNGgCLbTUpueNJbXWA>
    <xmx:R9fKadMqOO1U9Nn4Kmlxl54gKX2vjIZKhuURtCPJsJGKEURRShtBlg>
    <xmx:R9fKaRoHJ6H8YJOWGoLw9ou4YOFKAoF-y0ek23V_yOruO2AIHkhQpjOP>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 30 Mar 2026 16:04:22 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "Jayesh Daga via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Jayesh Daga <jayeshdaga99@gmail.com>
Subject: Re: [PATCH v4] read-cache: use istate->repo for trace2 logging
In-Reply-To: <pull.2253.v4.git.git.1774895886678.gitgitgadget@gmail.com>
	(Jayesh Daga via GitGitGadget's message of "Mon, 30 Mar 2026 18:38:06
	+0000")
References: <pull.2253.v3.git.git.1774891667.gitgitgadget@gmail.com>
	<pull.2253.v4.git.git.1774895886678.gitgitgadget@gmail.com>
Date: Mon, 30 Mar 2026 13:04:21 -0700
Message-ID: <xmqqpl4ldqyi.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Jayesh Daga via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Jayesh Daga <jayeshdaga99@gmail.com>
>
> trace2 calls in read-cache.c use the global 'the_repository',
> even though the relevant index_state provides an explicit
> repository pointer via 'istate->repo'.
>
> Using the global repository can result in incorrect trace2
> output when multiple repository instances are in use, as
> events may be attributed to the wrong repository.
>
> Use 'istate->repo' instead to ensure correct repository
> attribution.
>
> Signed-off-by: Jayesh Daga <jayeshdaga99@gmail.com>
> ---
> Range-diff vs v3:
>
>  1:  5a8165b05d < -:  ---------- repo: add paths.git_dir repo info key
>  2:  9bb6d0fa01 = 1:  c99d731efa read-cache: use istate->repo for trace2 logging

A range-diff with v2 would have been much more relevant, but the
patch below looks super boring compared to v2 which is very good.
Just replacing the_repository with istate->repo and nothing else,
which is exactly we expect to see from the patch title above ;-)

Will queue.  Thanks.

