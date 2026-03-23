Received: from fhigh-a4-smtp.messagingengine.com (fhigh-a4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FB191B424F
	for <git@vger.kernel.org>; Mon, 23 Mar 2026 21:30:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774301430; cv=none; b=jac9gZUfj8TkWmJETbTX66d4J2z7O3X0flHpFnN86Y2xghRQjM15OhTz0/+D2H5J1qqGGh3mW7LhyLUiB2gFFo0iCv1N0ZGKUZhky1kktrHht4FcmceW7mbKRXitCT86XOBt3+pz7ZCEHDRuDl6xbF3XojxkWPkBlAABGeEiM9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774301430; c=relaxed/simple;
	bh=7VSfu5q81bGbToB54JmoyhoOtwQXCq3WKFiedoYubIE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=kIKMCIz/8lefu5PJtlpS5/ahmh8/YtZDf6A9aCD5x9vIGD1Fo1WecipBOf9UCNRBMouHeveVBrTkQMWlKN2jJLRG/L3+RNthFQXFJ0UsNmdxtdoFPtwykdnl535rv9DKiP9es2mtXA8yTz3X8+lP6lqNglS1D34WrMN3NFFi4Qc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=D0a4LXcW; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=SmO/R+WK; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="D0a4LXcW";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="SmO/R+WK"
Received: from phl-compute-11.internal (phl-compute-11.internal [10.202.2.51])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 705AF140019F;
	Mon, 23 Mar 2026 17:30:28 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-11.internal (MEProxy); Mon, 23 Mar 2026 17:30:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1774301428; x=1774387828; bh=0xI7TtvHvp
	75vUXzV9b5UlIFkGGlQEd0NkOkz+flfBQ=; b=D0a4LXcWt0YOluT0J+RbEsnqh0
	4QUWtR0NhMyQVYmazi7EpNy24Brbp/2QzCpSWiduMzgTP04Zazlw3NvXFRw9lC5X
	kuvxX1jCpfwNfp0IWs9ov4vtg4RS5wa4HidUQlYyzOwDLMrZOh2TpVoBkX4X2gTM
	sDArng6RpoaYVUWWkHCuX8X1hSkLHGBpaNiV4tk73WYZdW5XAS/SFR90HjuTEJhm
	blalF1XxCtusoCjQfNt1uqnpcZAaRKKUsvXt8ELBBrfawF7ifCbn86D+VugYWQZT
	Ea37CqYsPz0G+K4jKQnsfQanW034jFCsISTnOV6lIjH5NGmd07WsZZ56PqPA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1774301428; x=1774387828; bh=0xI7TtvHvp75vUXzV9b5UlIFkGGlQEd0NkO
	kz+flfBQ=; b=SmO/R+WKRIkuyhyGVTSL16H9fBl13trnFgXu+Ce3VQFtXghgao0
	1Pk1OilFfoWiJ/u1bDFG9zWXQod0Y7JkGmEyUOS3lXq5sxPrYYuspmbmxC6i2fqx
	k99X9EHATW4uSDJZNiap+37ZFcs+2rH1ClN0bF/6pl2OEeJWbiL6obNHk2aBea9t
	bEQsN1uQdkKxIdzpxyaI7Z4hYvtqfleGhLua5I5vj5Bf5f9vJ4GlhyrRsQUZdc9q
	Ua+Z/70sJhdyNUwKDXPUUT47ZFYxL1ZXlgNAc5L4ekZZ3PQJWvtXZfABn4uaneTh
	yHfjPreOWN+nKp8JPTxCzwrcu3o8o2JtPZQ==
X-ME-Sender: <xms:9LDBaRHA8TN-wfFyP0SfxDP8KcsTaRFWLQOLHefmNSYv-iaYul_cpQ>
    <xme:9LDBaYkR-Bw-ZINrq91fvfeU4rG9tVh3Yr8OZ48MRPMYDnOHrGOiRIRr-C2620lpr
    dzDtt_mduTDkaIrTs-kIxGMrZrLIi8C5IBXBDUoo9pkvg83l3m5gA>
X-ME-Received: <xmr:9LDBaVZp8BjKX11BpDiJxtnH6nb6IEhLS4kIXhQ1RlD0Ic7m4Q2YRM6LnaffGh1aZwQedEUHaK8gG7As76DbMtXO3oo26405_A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdefudeljeelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepjedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtoheplhhorhgvnhiiohdrphgvghhorhgrrhhivddttddvse
    hgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhr
    ghdprhgtphhtthhopehnvgifrhgvnhesghhmrghilhdrtghomhdprhgtphhtthhopehpsh
    esphhkshdrihhmpdhrtghpthhtohepmhgvsehtthgrhihlohhrrhdrtghomhdprhgtphht
    thhopehsuhhnshhhihhnvgesshhunhhshhhinhgvtghordgtohhmpdhrtghpthhtohepgh
    hithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:9LDBadGL99pSZyQQAPx2WVHxWMjpSWovhKKWpq9DnAI5JPM_gJFoZA>
    <xmx:9LDBaWIiZQ3nYn75vpuxDoOSFe-bDlQsGcMTAdQElbgaD9fif-yPgA>
    <xmx:9LDBaYMPmZGWfyw2TmKxHLYxAA5OI7zJNpW_G2prAvwmoQ8XSB71Rg>
    <xmx:9LDBaWmoudxg_TfFhvZ7MQs0mtXlQE4zbTBTW6YYX_2yeAZ5BGCugQ>
    <xmx:9LDBaW__mYUuXR31VGAdgDdmMs1cb2plNgWRBQt64Im68Rw_2gT21JoN>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 23 Mar 2026 17:30:27 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: LorenzoPegorari <lorenzo.pegorari2002@gmail.com>
Cc: git@vger.kernel.org,  Elijah Newren <newren@gmail.com>,  Patrick
 Steinhardt <ps@pks.im>,  Taylor Blau <me@ttaylorr.com>,  Eric Sunshine
 <sunshine@sunshineco.com>
Subject: Re: [GSoC PATCH v2 2/4] pack-write: add helper to fill promisor
 file after repack
In-Reply-To: <0bb031e7443bb53abbbb0afaa347285d6d8cf7b8.1774205661.git.lorenzo.pegorari2002@gmail.com>
	(LorenzoPegorari's message of "Sun, 22 Mar 2026 20:18:05 +0100")
References: <cover.1774125871.git.lorenzo.pegorari2002@gmail.com>
	<cover.1774205661.git.lorenzo.pegorari2002@gmail.com>
	<0bb031e7443bb53abbbb0afaa347285d6d8cf7b8.1774205661.git.lorenzo.pegorari2002@gmail.com>
Date: Mon, 23 Mar 2026 14:30:26 -0700
Message-ID: <xmqqfr5q44jx.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

LorenzoPegorari <lorenzo.pegorari2002@gmail.com> writes:

> Create a `copy_all_promisor_files()` helper function used to copy the
> contents of all ".promisor" files in a `repository` inside another
> ".promisor" file.
>
> This function can be used to preserve the contents of all ".promisor"
> files inside a new ".promisor" file, for example when a repack happens.
>
> This function is written in such a way so that it will read all the
> ".promisor" files inside the given `repository` line by line, and copy
> only the lines that are not already present in the destination file. This
> is done to avoid copying the same lines multiple times that may come from
> multiple (redundant) packfiles. There might be another better/cleaner way
> to achieve this.

In the previous step, we extablished that these "back then their ref
X used to point at object Y" records are there so that we can
identify which refs were fetched at the time the packfile was
downloaded to help debugging.  When repacking, losing these records
certainly would lose information.

But would concatenating all into a single file help preserve the
useful information?  Don't we need do better than that?

A NEEDSWORK comment, as was discussed in another thread or two in
the recent past, is not necessarily a well thought out fully
finished specification of an additional piece of work.  "We know
this has a problem, we may need to do something about it, like
concatenating to save the contents, perhaps?  We do not know the
answer, and we do not bother thinking it through right at this
moment.  It is left to the future developers to figure it out" is
what a NEEDSWORK comment is about.

Your first response to such a comment may be "yeah, I agree that it
is bad to lose information we added to help debugging", but the
second one should be to wonder if the "like concatenating..." is the
best approach going forward.

In other words, we should take a NEEDSWORK comment as a mere
starting point, and what NEEDS your work begins at thinking what
needs to be done about the problem raised there.

By mixing them up all into a single list, you no longer can tell
when their ref X was observed to be pointing at object Y anymore.
You may have two packs originally, with a record for "ref X pointing
at object Y" in each of them, but by deduping them, you lose the
information that you cloned at one time, and made an additional
fetch on another day, and the fact the ref X was pointing at the
same value at both times.  I am not sure if it is a good
implementation if the objective of this topic is to preserve
information that is useful for debugging.

I wonder if it helps to append to each line the file timestamp of
the .promisor file we took the record originally?  For the sake of
completeness, we could consider adding the filename as well, but we
can quickly dismiss it as not so useful ;-)

If repacking already repacked promisor packfile, the records would
already contain such a timestamp at the end, so the code to copy
existing records must be prepared to see if the records are the
<ref, oid> tuple, or <ref, oid, timestamp> tuple, and act
accordingly.

I am *not* saying that without such a "preserve timestamp" column in
the record, copying existing records to a new .promisor file is
useless.  But we do not see any explanation why the author thinks
that it is sufficient to copy existing records while silently
deduping.  We can implement only one choice backed by series of
decisions like "timestamp might help" and "original filenames would
probably not help", and the design should describe what was
considered and rejected (as opposed to "we didn't think things
through---we just did what the original NEEDSWORK comment suggested
doing").

Thanks.
