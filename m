Received: from fout-b6-smtp.messagingengine.com (fout-b6-smtp.messagingengine.com [202.12.124.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CA301A4F3C
	for <git@vger.kernel.org>; Tue,  3 Feb 2026 00:01:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770076876; cv=none; b=RjaCWop0K6KVisAxLTXY+2wJT9WaUIvmBOWnQIcajc6CDPGwnIQOgS3rYa+iC+guh96sq2KHeoQD7wz1zmZLWJsSOttdnSOYhfZ65mrbI0F/h7V1ekxFe4NMbJqu7Q4dJg7KUrUq2AhlSEYbAJ+lyN7SFzpdi38BskEE8hFlzpM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770076876; c=relaxed/simple;
	bh=BwfTxlZz7i//5fYvLY6WMqDBZXiTm2KTk7SiAS4Sw9M=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=itUloXipgFLuFxyYO8O6CGMU86dwTYK0nuXm2B/YL1V32h03Aeu58Uis/hNUuIkatYm5e+2Q3lvwImWe0Fcg5xXlQeR6VMB5vuODuCRuANPcrCums4J0Lo8Xz2bUc58abrPd/dx4VjkU2kBfx63hzjpUNT1nG8v0qJjSOnQvZWU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=YPdthKWh; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=I02mt15G; arc=none smtp.client-ip=202.12.124.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="YPdthKWh";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="I02mt15G"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.stl.internal (Postfix) with ESMTP id B25071D00070;
	Mon,  2 Feb 2026 19:01:12 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-05.internal (MEProxy); Mon, 02 Feb 2026 19:01:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1770076872;
	 x=1770163272; bh=G7MtBVIiD2qv6BLEGu7e+V9xML2ohWQqa5gmIFc/bRg=; b=
	YPdthKWhcocge2v7+jZT2PoFAjBw/wR3VLBk2LdWH5Vg1BKVGk+Pp/pNNwoyi/Y9
	VElA4C+m5vj4zromY/WODbs5zpceHUWSiHCqIKJ2VMUjNQtDrzhpAx84mp+KS/zj
	Sf/9+fmtFGOxYIO6x507KYct18A/8hu1BNyYCMa3YnP9Q9dgt3LwJVX0CvOEpxbz
	g8QdFrYmDfpfhg+ufu7fOT6zS2G1qThuV7gE8qOyFNbn0dMDQd/wqKzvFbD+MvZH
	lwzevcZC/Ccme3SqVp5xWTPNq7R14lAM4VYWl1Yd27TqsfMBIvT9+U5h8ea2ntPf
	iK0v9nik77Z78zgrX8zHCw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1770076872; x=
	1770163272; bh=G7MtBVIiD2qv6BLEGu7e+V9xML2ohWQqa5gmIFc/bRg=; b=I
	02mt15Ghay/XNoXRhW0E762GO4Y4cjyiAeA1RdU7AJA/p+MCrXg2s80ZCnX9OFZw
	ksJ/kI5mcVp2DK6KULDpOi1zq2Ze5Y04Q3vsayysldYegLOu3GT4478qvsSveV7k
	N5GJ6hJzth5Nf/tv5r30YPqBrvf4K/YOZbXqKXPynQ3jmb0zOPmf7CnXhj8GafLx
	cg5eInBNe4n5cJLJpe3TOm8rffBvdTQ2JNuAO6TV/cRetuOwV51dT7axvJBRnim5
	a9vZwI23UPWIiCx/V894WAFHP06OVZxN67gId6RlM1Q3CX5iGQq7ZoUK2JGR56i+
	vlTnrvfLnAJ1zt+8zYDrQ==
X-ME-Sender: <xms:xzqBaXwCIYiSE4JbrWvpwz8Krt4j59OuX0lWPv4TCDxW2LgYeDiLtA>
    <xme:xzqBaVr1A8NS6r0hNFZXPOR36VVVKeX1FoSMaIK7krkKGm_qxTBWlifCo50VruQmq
    7pSmC0Gif73QYzr044ZVELODgNGZImWG8ABMQ0mom5o5Ee2QO8fH6s>
X-ME-Received: <xmr:xzqBadl0Bk9zB-NN71T2fWSdU2tYp3Xlfu5bNChrHajFHwjjQOou3y_edkoh3qcl1JBpebM2nLcKoYBjzUTHYBA9jOn6VTcyKw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddujeeltddvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgfgsehtkefotddtreejnecuhfhrohhmpefluhhnihho
    ucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrg
    htthgvrhhnpeehveeiieefheeuvddvvdfghfehudetfffhudelvdetudevgedvgfefiedu
    ledtvdenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivg
    eptdenucfrrghrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtgho
    mhdpnhgspghrtghpthhtohepudefpdhmohguvgepshhmthhpohhuthdprhgtphhtthhope
    hnvgifrhgvnhesghhmrghilhdrtghomhdprhgtphhtthhopehsiigvuggvrhdruggvvhes
    ghhmrghilhdrtghomhdprhgtphhtthhopehpshesphhkshdrihhmpdhrtghpthhtohepgh
    hithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopegsvghnrdhknhhosghl
    vgesghhmrghilhdrtghomhdprhgtphhtthhopehsohhrghgrnhhovhesghhmrghilhdrtg
    homhdprhgtphhtthhopehjnhdrrghvihhlrgesfhhrvggvrdhfrhdprhgtphhtthhopehm
    rghrthhinhhvohhniiesghhmrghilhdrtghomhdprhgtphhtthhopehkrhhishhtohhffh
    gvrhhhrghughhssggrkhhksehfrghsthhmrghilhdrtghomh
X-ME-Proxy: <xmx:yDqBafVVNL7zRvA_-MncDdFIt9drxGBWrYArofpFCGoz3obcZHUByQ>
    <xmx:yDqBaRrCSE6L1i9SWLF0X6kvLKwM-WZVLOgUpIeHxhH6LP7cLq2nUw>
    <xmx:yDqBaQVNAD3NylsklGQCodeISYmbNm1Czua6ufIQclK0INYGOhvP6A>
    <xmx:yDqBaSEs3Q51oxzihJOmSkqvUn7wfqnenWGGesRkZif6kA7ZOWZ9qw>
    <xmx:yDqBafqGgSK0PgGTo29swe_BcSN9Ey6gMvvkGsMz7UZgIvhLH9UtDd6A>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 2 Feb 2026 19:01:11 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Elijah Newren <newren@gmail.com>, 
    SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
    Patrick Steinhardt <ps@pks.im>
Cc: Git Mailing List <git@vger.kernel.org>,
    "D. Ben Knoble" <ben.knoble@gmail.com>,
    Sergey Organov <sorganov@gmail.com>,
    =?utf-8?Q?Jean-No=C3=ABl?= AVILA <jn.avila@free.fr>,
    Martin von Zweigbergk <martinvonz@gmail.com>,
    Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
    Karthik Nayak <karthik.188@gmail.com>,
    Phillip Wood <phillip.wood123@gmail.com>,
    Matthias Beyer <mail@beyermatthias.de>
Subject: Re: [PATCH v11 8/8] builtin/history: implement "reword" subcommand
In-Reply-To: <CABPp-BHkNLdH4C7U4sFoVhrsSPH8KAaDtOdLEQGyajmXZz9hVg@mail.gmail.com>
	(Elijah Newren's message of "Sat, 17 Jan 2026 14:56:19 -0800")
References: <20260113-b4-pks-history-builtin-v11-0-e74ebfa2652d@pks.im>
	<20260113-b4-pks-history-builtin-v11-8-e74ebfa2652d@pks.im>
	<aWpnFqTmWB9XIWUW@szeder.dev>
	<CABPp-BHkNLdH4C7U4sFoVhrsSPH8KAaDtOdLEQGyajmXZz9hVg@mail.gmail.com>
Date: Mon, 02 Feb 2026 16:01:10 -0800
Message-ID: <xmqqsebivgop.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

Elijah Newren <newren@gmail.com> writes:

> On Fri, Jan 16, 2026 at 8:28 AM SZEDER Gábor <szeder.dev@gmail.com> wrote:
>>
> ...
> Personally, I'm having difficulty understanding your second stated
> advantage of picking the commit from the rebase instruction sheet.
> That instruction sheet is obtained by rebasing on top of something,
> and it seems as easy to me to see the commits since that point in a
> git log command and pick your desired commit from log output as it is
> to invoke an interactive rebase on top of that base commit to get the
> rebase instruction sheet and then pick out your desired commit from
> there.  Same number of operations and work either way, so I don't see
> how either is more or less work than the other.
>
> You did make a good point that one of the differences is that you
> don't have the commit checked out.  That's a useful distinction to be
> aware of.  To me, that seems to be somewhat implied already both by
> "in-memory" and "even if there are local changes in the working tree
> or index", though it wouldn't hurt to explicitly call it out.
>
> It feels like each of your complaints with the new proposed commands
> (given commit not checked out, rebase instruction sheet vs listing
> commit, and HEAD-only) can be boiled down to the fact that they don't
> behave like `git rebase`.  Is that accurate?  If you like rebase, is
> there a reason you are worried you can't just keep using it?  I don't
> see why others should be required to implement another exact copy of
> rebase, though.  Further, if we only wanted minor modifications, we
> could have just done those to git rebase.
>
>> I firmly believe that operating on all local branches must always be
>> the result of an explicit user action.
>
> Over at https://lore.kernel.org/git/aUVaEPGoOkATQGl3@szeder.dev/ , you
> alternatively suggested the idea of an "escape hatch".  I think that
> may be a good idea.  What if we had a "history.scope" config variable,
> with values like "descendant-branches", "current-branch", and
> "error-if-multiple-branches", corresponding to each of the requested
> defaults we've seen in response to this series?  I can't imagine using
> anything other than descendant-branches, and the preponderance of
> those who have commented on the default so far seem to be in
> agreement, but it would allow you and Matthias and others like you two
> to pick an alternative.  Thoughts?

The discussion stalled after this exchange.  What is the next move?
I think the it is SZEDER's turn to respond?

The topic is depended on Phillip's "git replay" tweak to drop
commits that are originally not-empty and become empty in the
replayed history, blocking its advance, which is doubly unfortunate.

Thanks.

