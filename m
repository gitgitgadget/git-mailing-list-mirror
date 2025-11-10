Received: from fout-a7-smtp.messagingengine.com (fout-a7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A43D28727B
	for <git@vger.kernel.org>; Mon, 10 Nov 2025 19:13:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762802040; cv=none; b=b/ugHy7gOpSWTnAZJOIBgRLo/r8J6VzqWa0eBAbtZn3W+aDOfnHmof4IhtmwhkkbrQxbrlVfUOpKIV4F6tsXCcOS6boEaxx1iOIZcELujlrS+5MyAjA+Vl+J0vf9of7vWjjfM0vFE5MZKCtaW/q4ADs4sM4lCBEqILkcnsXNd+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762802040; c=relaxed/simple;
	bh=FkYaTkOs6WSAibnydq5tWmL088R3kunsmN27QteQGHs=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=qYJEagVd7NbhlObbQyqxHsbK0qfWMB+akh0TEtvo2PgKvKhbD24nnlRiQI1jgItl55KwfXfT12NmYlSeQRDwb/AQ85sG6oMNT055v/wp9OBBDPf0nY8E1v6rtz5B+F081P8LqKXsIon+GQ030C9wr+nhPKjmcVG5N1SkVpPJ2xA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=kQs+rExj; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=EHLRcOC9; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="kQs+rExj";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="EHLRcOC9"
Received: from phl-compute-12.internal (phl-compute-12.internal [10.202.2.52])
	by mailfout.phl.internal (Postfix) with ESMTP id 61AF0EC1EDE;
	Mon, 10 Nov 2025 14:13:58 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-12.internal (MEProxy); Mon, 10 Nov 2025 14:13:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1762802038; x=1762888438; bh=0LAB5V6EBg
	zh5f3g22PYTxC11Qd5TVZ/PoGX3dRBr+o=; b=kQs+rExjAJXQ+SsU8UF0WAa2px
	nmtemny50sNArcXiz6/dwl3TpVk2rQAAptdR0CVBZj63c0i8qHXQFFSbRl4c72f1
	bCiwVsY5Pw2zaP2KFuqehkgkAv1LcmDIm4EtRmIDVWLYYEy2LtxYbh6oM3hmpsd1
	CJ6t6TcVVzE6Yf5CCucWVx2Se9gtQTO9GUgC+cEZ/Xp1uDLorut2VfFvfok281qy
	T6vF2hxE0vxsf4SfHzYBpbT1Dlvbdg9yB8/t5ZMnju7OlGI8iKeMF1xHc3zYFB9k
	6aIc0qx6DiTXufSUA6mYRR0lPt7n0JIpTEsabG72Qp75sFSSJL2KOX5kM3Vg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1762802038; x=1762888438; bh=0LAB5V6EBgzh5f3g22PYTxC11Qd5TVZ/PoG
	X3dRBr+o=; b=EHLRcOC9pKkQmEgU3Rr208G6A2mJU+vNR3yco4mZf9ROU20jqyV
	3PuEIpqN+ggb1h0htzt6GVugQQ7t7rjCxco3SmJO+5je+TNuXRlVoxIeMw3oIBM8
	hvRlYLNLzRlfqrgOP1amZM+UuCZZykrlIlXSYOljIRuwdCdGEzYS0OQTot+7O/jo
	tgmrlcfhuQCuBLUrWeEReMERS8myM8IK0pV6/8LiXYJgbZNkfh7w1rAbb/+hAOyc
	je0tPSU8xb5f9Eqpks87aiByTC+4eOoo0IjJKnqGDApn4meL0bTBPZWulnHetjPJ
	r5oCftg4MJYBQlP8/8tY8hboHNCSnMwuWbA==
X-ME-Sender: <xms:dTkSaQEXpz6Yl8CRPdDzDxg3dRvSWrZwsq3yhwYelB5mh9-M8D28tg>
    <xme:dTkSaSohqcJ8Y_Ds2MbIiymioMP5xSJ-rwF2bW9tuPNAjVOoTHs4_TLqQdFE2yWa2
    3sGMjAKKcRdZg1MjuU0kpJ1E81R0idlFJ2m-iakL3_Bpqv42Xgwog>
X-ME-Received: <xmr:dTkSaRaq_Dpqn0vTtpW0ljTSAp5Lg6_1J3IAbCi1XZntSm9BQH2OJz7iITmltn827C-jZVgtvgLo3hk421Q3Yvx7VVzlJ6boaUB3>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdduleeluddvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtofdttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepieekueefhfetvdfftdegfeekhfffgefgfeeivddugeffgfffffevvedvieel
    ffdunecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepiedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepphgvfhhfsehpvghffhdrnhgvthdprhgtphhtthhope
    hlrdhsrdhrseifvggsrdguvgdprhgtphhtthhopegsvghnrdhknhhosghlvgesghhmrghi
    lhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtg
    hpthhtohepphhhihhllhhiphdrfihoohguseguuhhnvghlmhdrohhrghdruhhkpdhrtghp
    thhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:dTkSaTVO3I1zXd2WYzMdTYpNzh4bUct5VQFh5HGj5EVCA36IxXMibQ>
    <xmx:dTkSaS9h9XEVO385UyJbyXgeq41uf1HyCdGNl1RUNT6AsWezPkqhQw>
    <xmx:dTkSaU-f7FItCithG-30DPqZepQBjFrNc3DMr_Rbzdl-27qC3-f5Vg>
    <xmx:dTkSaaSq-C9BKvWncXKgg9oQ9WUWiLdpFPh26y110R3-4ubkZzQxig>
    <xmx:djkSaYyfKa1gQR20qaVPPooV5gsJKZAb-vNhipwhZFvDifQQnx7YoIby>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 10 Nov 2025 14:13:56 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
Cc: =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,  "D. Ben Knoble"
 <ben.knoble@gmail.com>,
  Git <git@vger.kernel.org>,  Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: Re: [PATCH v2] diff: disable rename detection with --quiet
In-Reply-To: <20251110175408.GB76603@coredump.intra.peff.net> (Jeff King's
	message of "Mon, 10 Nov 2025 12:54:08 -0500")
References: <CALnO6CBsj+aMvHJoUQ+LHAtXhcFhQeH8AuHyrX+rumur6MQQog@mail.gmail.com>
	<8796cd59-2335-4674-823d-d682ce7b7f8e@web.de>
	<20251110175408.GB76603@coredump.intra.peff.net>
Date: Mon, 10 Nov 2025 11:13:55 -0800
Message-ID: <xmqqseelzong.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jeff King <peff@peff.net> writes:

> This makes sense to me, and I can't think of a reason why you would want
> rename detection on if we're not going to show the results (and likewise
> I can't think of a way that a rename result would affect has_changes).
>
> I wonder if we should _also_ take the hunk from v1 that teaches
> can_quit_early() to avoid triggering when copy detection is on. It's
> probably redundant now, but it feels to me like that's the place where
> the correctness check should kick in. And the patch here is just
> optimizing out the unnecessary work, but also happens to align things
> for correctness downstream.

Concurred on both counts.

> You don't say in the commit message when this bug started. I briefly
> wondered if it was caused by the recent diff_from_contents stuff we've
> been discussing. But it's the opposite here (the bug happens when we
> _don't_ set diff_from_contents). And I think it goes all the way back to
> b4194828dc (diff-index --quiet: learn the "stop feeding the backend
> early" logic, 2011-05-31).

Yup, I think so.  Back then I think our assumptions are that the
user knows better than giving complex diffcore requests like
find-copies-harder only to discard the results with --quiet, and the
patch started this thread helps other users, which is good ;-).
