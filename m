Received: from fhigh-b5-smtp.messagingengine.com (fhigh-b5-smtp.messagingengine.com [202.12.124.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 754DD381B04
	for <git@vger.kernel.org>; Fri, 27 Mar 2026 17:16:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774631814; cv=none; b=cXtzmiF5XElatUZuo+Bai3yKfRyHaSBpUBe8nGIwstbasv13jQjCVudtN/yISguIwjb0fo34Xb62JwkBaIvGbo/KWX0kGH4+bWnMll2NIiP1k7iI+uQWGUNcrhP2h2w5jb/qLSoBuvsaRy0rJ8R3T/jnJakWUKBrDKec9fPoLjw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774631814; c=relaxed/simple;
	bh=9NjilsNdV/MC6YbnuZisjpzo77E0YcQMGx5GuuuOTv8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=V6MyWs4GN0prV0PUJXrtTAmGgv7uJAyg93aYDDKhoAMbF6Cf3KXTvMj6MAVunkr/QtxBF4DmrFc24LqmUMUo/XhVnrMRXK4drC+LIAQhOkVnPprrdbzAXK8Wt0Ff0ySUNzMNQOdU0TppGJOkQfy8VH35b2+9UeFKyv+4H5ReeYQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=VbTfCKEU; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=1s0xXWyL; arc=none smtp.client-ip=202.12.124.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="VbTfCKEU";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="1s0xXWyL"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.stl.internal (Postfix) with ESMTP id BB1F47A0158;
	Fri, 27 Mar 2026 13:16:52 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-03.internal (MEProxy); Fri, 27 Mar 2026 13:16:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1774631812; x=1774718212; bh=jnx/mIW6PV
	v0pXSb+xwNupHSGxNT0t+6HyPWPmDYjDU=; b=VbTfCKEUn5QUB5HnNwv0mYnkDm
	B1KwCSsq1ycEpTy1mr8XIMTVtVfKDhVCqSHBtqYGEQ2Qp9Vbw0sSbcyK7hGa4ISB
	XSYPZPz9kqRK8jtqVJDIOp/M7TLfUP7gG5+pUDx1HXizQo+3IsFZysCAMmCYAHAg
	8af6pV1+Aop4Ok4k5iRTyq00H+nnCfwcvPPqefEdNMtnIoHNcfjBpV3EI7Aocx2n
	DNnjkvSkio0QRmQsd/n5n2lwvLt2Xz39n4b46FC6GABrwcR0nBl89bwpPFfmtLBs
	D0UyuexnWDWPc3d0JvDwbWC1w9C4Id6ijTzR5Bc3tpp3RRvBhvvdJuGCGukg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1774631812; x=1774718212; bh=jnx/mIW6PVv0pXSb+xwNupHSGxNT0t+6HyP
	WPmDYjDU=; b=1s0xXWyLQPwpF7/L5euDksQliKhITX18owBN84J8LMjxxiaqjBF
	rRsNBdepW145nnuY+00EV9Sd+GeJyDyQF8UYGTh2AvdH/5Rrm8UkJRD4jEAripgA
	Jr+jjQGRKRyHdb6bq5ScxFIBwhKQDj58g7SjyU0hcGI++xOgUff7TnGCZZBm4fUy
	I0BJ+qUb/q5ZuJ4dwsNP2ojybIxf8Q77gwwR/ulwiFbAC+rhSvEHvydw4qfv0vI6
	QF84j8d0Lfl/8XYMhD/mTkVjmtKAT8M6rPT4HZN9ot5TtFdwYHQ6bkIxMKFQEPIt
	2Z3tuVTshi+8vS8bD6mj+kij+n4Yr282btw==
X-ME-Sender: <xms:hLvGacedUgjFC-bFiSPwsFRZLp7AwHt8dX3SsFomC51NRFw10xI1xQ>
    <xme:hLvGaR4508FhR8JI4CCLpY5WErJJhqq0MP9zIj9xTP_fI_NnjTibBqfO17GoXJ4s5
    zqpObPTciEgd414IsiWWfsPwPuf9Sc-CcWuobp8kjXGD1QMUSIW4A>
X-ME-Received: <xmr:hLvGaXWgq0D3kd8Ox2BnpcOuxOrLntkxqnZtOk6cAOaadhWJfv6PMf8BhhMCVN4JjvTdT452aMxSFc6RXGgCsfKW1bOaHpG9nA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdeffedtkeeiucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepiedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepqhhuvghnthhinhdrsggvrhhnvghtsegslhhuvgifih
    hnrdgthhdprhgtphhtthhopehmrhhoihhkseguvghlrgihvggurdhsphgrtggvpdhrtghp
    thhtohepsggvnhdrkhhnohgslhgvsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhith
    hgihhtghgrughgvghtsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghr
    rdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtoh
    hm
X-ME-Proxy: <xmx:hLvGaY7fBQHaDgzCATXGy0R4ANOPlzIGMuQrLHVA7aep4VjDdi8NtA>
    <xmx:hLvGaaqSt1ehPJxcJHNeEbSCX69x3upX_gPMXW7AsTy2Zm4TM6GRKA>
    <xmx:hLvGaTlN1nZE46_gNALuiaLe037KUJj5Nszxsq8O1TbMmRzUdjzbzw>
    <xmx:hLvGaeONNM_VQMXG-bSwKtxognpNdxNfjkb9nF_Lu0hMsvpbrGx9lQ>
    <xmx:hLvGaf2U4Tq2xS14VysUWrR7nrw7Vv6QCFuhD-kieusWNCRWkoLAo1Ni>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 27 Mar 2026 13:16:51 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Quentin Bernet <quentin.bernet@bluewin.ch>
Cc: Mirko Faina <mroik@delayed.space>,  "D. Ben Knoble"
 <ben.knoble@gmail.com>,  Quentin Bernet via GitGitGadget
 <gitgitgadget@gmail.com>,  git@vger.kernel.org
Subject: Re: [PATCH] docs: fix git stash grammar
In-Reply-To: <9d0befb7-4f2b-4b47-bf9c-784fcacfe418@bluewin.ch> (Quentin
	Bernet's message of "Fri, 27 Mar 2026 17:58:19 +0100")
References: <pull.2255.git.git.1774529148151.gitgitgadget@gmail.com>
	<CALnO6CD-5NBUoooMD+pQAxeyXCjkZ3Za6LJrLrJN57Nrz03xBw@mail.gmail.com>
	<acXIl2cuBv0ifiK6@exploit> <xmqqqzp5mfh5.fsf@gitster.g>
	<fbe531eb-b742-4cd1-ab6a-2eaaf8d236c5@bluewin.ch>
	<xmqq7bqxkyd5.fsf@gitster.g>
	<9d0befb7-4f2b-4b47-bf9c-784fcacfe418@bluewin.ch>
Date: Fri, 27 Mar 2026 10:16:50 -0700
Message-ID: <xmqqtsu1jipp.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Quentin Bernet <quentin.bernet@bluewin.ch> writes:

> Just so we're clear: my previous grammar did allow "git stash path1 
> path2" (no "push", no "--"), which is not allowed
> Do you still think it is good enough ?

Absolutely.

It is not huge enough issue to warrant separating synopsis form for
push into two almost identical pairs, and having to maintain both of
them.  It would be sufficient to make sure the readers understand
that they may have to disambiguate pathspec with "--" like any other
command (like "git log foo" when you have both file "foo" and tag
"foo") in the description part.

One thing that we may want to fix in the code is that we probably do
not want to require "--" when doing something like

    git stash -m foo <pathspec>

to assume that it is a lazy "push" that does not say "push".
Currently we complain against the lack of subcommand name.

Once "-m" (i.e., a potential option) is seen before seeing any
subcommand, we can commit to treat it as a lazy "push", and have the
parser pretend as if we got

    git stash push -m foo <pathspec>

We may see "git stash -m foo --no-such-option garbage arge" and the
option and argument parser of "git stash push" becomes responsible
for complaining about such a command line.

#leftoverbits obviously.

