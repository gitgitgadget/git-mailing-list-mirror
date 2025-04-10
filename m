Received: from fhigh-b8-smtp.messagingengine.com (fhigh-b8-smtp.messagingengine.com [202.12.124.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0DE71E98FB
	for <git@vger.kernel.org>; Thu, 10 Apr 2025 08:29:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744273785; cv=none; b=ZErawEe6A+YqkEcDVr39s3DhpSZOV7ue+FQIz29d2UkmEu9l9BQe4KxCvGrDBapBRjwhaZGgUiB9L6/RWBh2+D3rdCuaV+nfrO9URfhK5aC62ZGyttfHcJ4NF6f+paoWi+/9M33kqEpHB0J8vOKfzdHeZ7jAQHQy9xz+sjK0TLA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744273785; c=relaxed/simple;
	bh=Blm7kQ6y/n4Hs+j9p4tpe3fyS2buIcrOzRB6oVT8ljw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=tqqdiShrb3REovfte7yaMhXJlmYAgqQ5UD5vHEq/gPCVCvFMPudK6yTe+GGqeXlAWJ3LM8NLI1mPwSgXFJgsuN5XkewlM25HfF3Equ8vKpbmBooSoJoFHGNKZe733eeUMjJRfRNcCt/pKo2DSTjyUhChrSrMXEfbpKRr7EghGx0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=lJuJh3pT; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Na9H3zUT; arc=none smtp.client-ip=202.12.124.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="lJuJh3pT";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Na9H3zUT"
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 7D8F925401DE;
	Thu, 10 Apr 2025 04:29:41 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-03.internal (MEProxy); Thu, 10 Apr 2025 04:29:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1744273781; x=1744360181; bh=8i/SMYDjs6
	vZ07at31SbipIrZXW8yFzV1eaxyk9euXU=; b=lJuJh3pTNOJ42fGOn5N8gBR6J/
	Hm0gSK1ZFz7W1Jt6g0AHE2LuJCH8AWgtqPIbkdcxc6tMwUkugU14AkWaSNYTr8N1
	0/+H/RNmAiVHPR4zouqYC5gbrrUzWyBw3kNhGc/yYFsB1W6AXK9KpFjN7Mk2vc2A
	Aa98eeLKbjYvjUJBWqlMQV7rLUteOLq0HG7jfxqEafV5m+ny+MBb385tv/BURAA7
	miDhDXwVhErAa5J/8zSzajhuyyZriM0yr3UnDQi/JjmhP9eiaMiiTee/Nb2vlcVG
	PF/uy7a5OtSQDR/Qt+lIxLhNXlb3+xayfEtPB/71OZjztbtJWhwaWYHyGPHw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1744273781; x=1744360181; bh=8i/SMYDjs6vZ07at31SbipIrZXW8yFzV1ea
	xyk9euXU=; b=Na9H3zUT1VfHBv84ZX3HZJcZyvsQxcNpLsrYcuVNtrvmViOiqm7
	P0Y0mFHVgv1Pwe+xLW1aGHxM0QSBcdDymAf+BCVSvqe3w4eDSg/Stu6Usr5kwGqN
	ovdCLpdkX21DgcV0abdB75A0/5uLhYEC8C3rgksKfv7lp+2J/ypzbqHn8yDV6Pie
	9B+dlEQas9RruoqLE0oo9jz6FJYesdrS9DAadTZWh4yA1di9/zzoq/r93K9nHJfm
	Y6pw3Bm3UBt/lwXS6qQ4zO6XZXHzzAhftQPY1kbg8VxJSVZ4aX2v0YjEAl5reJiG
	7HYVljILMaoj61yFjPQ82QhToPqsMqg+nfA==
X-ME-Sender: <xms:dIH3Z-hX-5VpSLolFabpMI4RP8pQ-cQqDysWEH-MCDE_azuMGfTGHA>
    <xme:dIH3Z_D51C7vBdV9JEVAvlwtv2rjmubA74GNcsCJjeFrO8cH9SEuGVX-0agFXvkjp
    7-3PS09i3gMHIbooQ>
X-ME-Received: <xmr:dIH3Z2Fj3MlF2BOgw7zirLeOfWuzKMe7yYqDMWbmy8mi6RXQBOYgIRJTJ6vbmVCG0VpmGYVEj_WxIegmkWYq9eqYYXqi-VwIyTku>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvtdekgedvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgesthdtofdttder
    tdenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosg
    hogidrtghomheqnecuggftrfgrthhtvghrnhepieekueefhfetvdfftdegfeekhfffgefg
    feeivddugeffgfffffevvedvieelffdunecuvehluhhsthgvrhfuihiivgeptdenucfrrg
    hrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghr
    tghpthhtohepledpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepnhhitghosegtrh
    ihphhtohhnvggtthhorhdrtghomhdprhgtphhtthhopehthihtshhosehmihhtrdgvughu
    pdhrtghpthhtohepmhgrrhhtihhnvhhonhiisehgohhoghhlvgdrtghomhdprhgtphhtth
    hopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepvghkvghmphhi
    nhesghhoohhglhgvrdgtohhmpdhrtghpthhtohepshgtohhtthesghhithgsuhhtlhgvrh
    drtghomhdprhgtphhtthhopehrvghmohessghuvghniihlihdruggvvhdprhgtphhtthho
    pehphhhilhhiphhmvghtiihgvghrsegslhhuvgifihhnrdgthhdprhgtphhtthhopehgih
    htshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:dIH3Z3TibvQL8C0Ok4ffzTyQ15KJoZuTXgqywfg3CeQbu6lGNJIOWw>
    <xmx:dIH3Z7xn3kmVIdVwvLqqzN0XLYUTa0jmV7RtD0uSg3vxM_q2u8qUkQ>
    <xmx:dIH3Z16vG28MSUxvX6MejYmIGfxjlLr4ktEWOsuFqYsSobECV7po7A>
    <xmx:dIH3Z4ywnc8CpwDCPiq-4bzA2xkEsEh7IG7UTuZ5QifPIgy9LRXUWg>
    <xmx:dYH3Zw74w2ovAJIl3-JRoe5cXZGV4qry2QFrO2b8vaP8cC1O6FlABhcx>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 10 Apr 2025 04:29:40 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Nico Williams <nico@cryptonector.com>
Cc: Theodore Ts'o <tytso@mit.edu>,  Martin von Zweigbergk
 <martinvonz@google.com>,  Git Mailing List <git@vger.kernel.org>,  Edwin
 Kempin <ekempin@google.com>,  Scott Chacon <scott@gitbutler.com>,
  remo@buenzli.dev,  "philipmetzger@bluewin.ch" <philipmetzger@bluewin.ch>
Subject: Re: Gerrit, GitButler, and Jujutsu projects collaborating on
 change-id commit footer
In-Reply-To: <Z/bGzvDfsIcclBW+@ubby> (Nico Williams's message of "Wed, 9 Apr
	2025 14:13:18 -0500")
References: <CAESOdVAspxUJKGAA58i0tvks4ZOfoGf1Aa5gPr0FXzdcywqUUw@mail.gmail.com>
	<xmqq4iyzn0vn.fsf@gitster.g> <Z/RFQY433muaCW44@ubby>
	<20250408125521.GA17892@mit.edu> <Z/VGYrrVZYQ13TLj@ubby>
	<20250409121924.GA148735@mit.edu> <xmqqlds9trwv.fsf@gitster.g>
	<Z/bGzvDfsIcclBW+@ubby>
Date: Thu, 10 Apr 2025 01:29:38 -0700
Message-ID: <xmqqsemgpggd.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Nico Williams <nico@cryptonector.com> writes:

> argument against similarity heuristics over change IDs.  I still think
> that explicit change IDs would be better than using only commit
> similarity heuristics.

I do think it makes sense to explicitly record that this commit was
(or "these commits were") created to refine and replace that commit
(or "these other commits"), if we want to keep track of how a set of
patches evolved, if such a determination can be reliably done.  And

I suspect that IDEs can do a much better job keeping track of such
correspondence than they can keep track of renames and copies, which
I mentioned in an earlier message.

It is insufficient to just record a single "change ID" to each
commit, in order to handle anything other than "a single commit gets
updated by another single commit" case.  It is insufficient to even
keep track of "a single commit gets updated by another single
commit, which in turn gets updated by yet another single commit"
case, without assuming globally synchronised clock in a distributed
environment, simply because you only have three commit objects that
share the same "change ID" string among themselves, and you cannot
tell between A becoming B becoming C (in which case people would
consider C is the latest in the iterations), or two developers
started from A to produce B and C indenendently (in which case it is
not yet decided which one between B and C should be considered the
latest).

Since we are all human, it is possible that we think things through
and make a design as complete as humanly possible but it later turns
out to be insufficient.  If we make such a mistake, we'd then need
to deal with it and that is just simply a part of developers' life.

But something that is _known_ to be structurally insufficient before
it is added to the system?  We should refuse to make such a thing a
part of very core part of the data structure, like the header fields
in commit objects.

Thanks.
