Received: from fout-b6-smtp.messagingengine.com (fout-b6-smtp.messagingengine.com [202.12.124.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3051C27D784
	for <git@vger.kernel.org>; Tue, 27 May 2025 16:50:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748364657; cv=none; b=kqPBk7ESESzVi2g75CQ22tVuUCovPmUpMkmCL3dEAWw8G2gKNJiAGh1O0Zc1/QN3Z6oCtv15RM1omf7QF8vq++7DG1e5BpzZrLU0wLXMR70P605TszoYbk6BhGk/a7h2gfwA9sKt16X5UrayFaM0LlEOWO4MHJmSO1+xaMxf5wE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748364657; c=relaxed/simple;
	bh=s9oeonYcaB7Y/Zd43irttBlpm+jqipGPNxLrTww6oxM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Ho8HX1fJ9WwIVAZBvB5c0uJlqsG83wlKV/Yof+VETDiK7r0WtG0ESWoWAjReJyW4+SiArfFr92sAGjlrCkOp6utroMvc1UCIY9+sGJAvn09vW0CaLOQdore9R5JeDN+BF4c/SoKqYzzrlfNe25nBltCNvIloqip0++cCpzZwjS4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=Lje3UFjD; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=BkR8rT6a; arc=none smtp.client-ip=202.12.124.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="Lje3UFjD";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="BkR8rT6a"
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfout.stl.internal (Postfix) with ESMTP id 34F9E1140139;
	Tue, 27 May 2025 12:50:54 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-01.internal (MEProxy); Tue, 27 May 2025 12:50:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1748364654; x=1748451054; bh=cEost3321a
	mVrfg18w0175Kp9vFJc8jBsPHbT6vpdLI=; b=Lje3UFjDLnXGFkk6nKeiW4qW8D
	XQ6amwzYetxpA4ktz71Wndjh2WgUGBmgH1uE5ls2wFdm3KO4e1W47Rett2bud1VB
	PT/m7dwNoGs/XJx2WPUrtfIB0S8Ulbhs8zL+jL3SGH5K5MpU4kMRUosbrMMZj08d
	8yG3Ve0rba6IHa0VA+vAwEuUIDvSeUvIb1IV744M2RjSywg59EPLZT73qAzOYG3p
	J1MdahtC69WC7sQGuPN7gcMmA+spvFH/uAhEV6pn6QaoaN8+3YkLkus4aLxvVfZc
	vGzPztxyjlbrTGv3Ozk+Dz870bll4MFCI+EDdu9taCefsAQYCk8xhzKlCqww==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1748364654; x=1748451054; bh=cEost3321amVrfg18w0175Kp9vFJc8jBsPH
	bT6vpdLI=; b=BkR8rT6am0tcUrO1d1VOvlF2V9TUkb2WrSm81drQ0apfdIZjgFa
	nfV7jvFwt+YZGzY3Ui5DVNBQVlMSBxF8ZezGrQFmNE4eO8U/fVaYcWrpvRFxtoYG
	OUB1qoPZmajb9jKKt9L/uAMGCH2dOhCaMYSDDGUE89c2oYxVR0/DZqvTZl4LkrAR
	AGHrmjT4su40X1IDzyQFqehO4IkuFZdijfX8ipHHqBQCocDjqOFncfkV5Lz7WehV
	kxYA2EaaKmDLdy/QPCqAszxfvSTFR+8/H8O//EFrt7pKhOjgh6ZK9UkBZT1W+qei
	VYxQ84yF+SXyAW1jXs44FOVPon9OARxKbWA==
X-ME-Sender: <xms:be01aFJQDWoffnhXrFL9lszXW3FSKIheJ6DoCD4RKkFVnbTTNC3bTw>
    <xme:be01aBL7Yo3HB0TXpYWaj4GFFDCTLt4AAIGwrCHZ463nORBHpeUUVK3EmFjfzD6oN
    fZH3d0fw0gLNxsslA>
X-ME-Received: <xmr:be01aNtqryh8noXB_TT-EslUH-Yvwvzjn0REyTWUDY1eascYo7NiQB95DBXmKhtNj-BRSeJFhCZAAkwvIqwLOx5Xpf6Nc6yyTzMbwMA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddtgddvtdeludculddtuddrgeefvddrtd
    dtmdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggft
    fghnshhusghstghrihgsvgdpuffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftd
    dtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvfevufgjfhff
    kfgfgggtsehttdertddtredtnecuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoe
    hgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtthgvrhhnpeefveetteej
    heeugeffledvteeiveffueefjeelueffteeigffgfedthfefieegieenucevlhhushhtvg
    hrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgs
    ohigrdgtohhmpdhnsggprhgtphhtthhopeehpdhmohguvgepshhmthhpohhuthdprhgtph
    htthhopehpshesphhkshdrihhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgv
    lhdrohhrghdprhgtphhtthhopehjlhhtohgslhgvrhesghhmrghilhdrtghomhdprhgtph
    htthhopehmvgesthhtrgihlhhorhhrrdgtohhmpdhrtghpthhtohepghhithhsthgvrhes
    phhosghogidrtghomh
X-ME-Proxy: <xmx:be01aGateJ01NaSHT0GKpUjV7hiD8tRbTr1q-oWsUqtH1551ibd0wg>
    <xmx:be01aMY8dwJClRkbu9cxMD0fx1ufTJDrUpRuF2TSv1lUCE468u4lSw>
    <xmx:be01aKBgzWiGT2z7PaLaPIodEsQIpHDvGUH7M0wscWeZ4kJEvXqpcQ>
    <xmx:be01aKZ1X2oM09k4Q6Nd2b8K0bsuiaPcgAlH9Pr6Vqu0duLaEnGdiA>
    <xmx:bu01aMHuyKFdJIu6VJAOGqBd3R5TrcY7GAk-lQBjGhNfVDdDlw8jMUMq>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 27 May 2025 12:50:53 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org,  Justin Tobler <jltobler@gmail.com>,  Taylor Blau
 <me@ttaylorr.com>
Subject: Re: What's cooking in git.git (May 2025, #07; Fri, 23)
In-Reply-To: <aDV0jwaQ2DlcM0lZ@pks.im> (Patrick Steinhardt's message of "Tue,
	27 May 2025 10:15:11 +0200")
References: <xmqqtt5au523.fsf@gitster.g> <aDV0jwaQ2DlcM0lZ@pks.im>
Date: Tue, 27 May 2025 09:50:51 -0700
Message-ID: <xmqqtt56ov4k.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Patrick Steinhardt <ps@pks.im> writes:

> On Fri, May 23, 2025 at 07:16:04PM -0700, Junio C Hamano wrote:
>> * ps/midx-negative-packfile-cache (2025-05-20) 2 commits
>>  - midx: stop repeatedly looking up nonexistent packfiles
>>  - packfile: explain ordering of how we look up auxiliary pack files
>> 
>>  When a stale .midx file refers to .pack files that no longer exist,
>>  we ended up checking for these non-existent files repeatedly, which
>>  has been optimized by memoizing the non-existence.
>> 
>>  Will merge to 'next'?
>>  source: <20250520-pks-pack-avoid-stats-on-missing-v2-0-333c5217fb05@pks.im>
>
> I wanted to send one more iteration of this where I hide the ugliness of
> `(void *)(intptr_t)-1` behind a macro, as suggested. But I saw that
> Taylor has built on top of these patches, so I don't want to make his
> life harder. Cc'd him.

Yeah, I do not think I've merged Taylor's work anywhere yet, but I
did notice that it was built on top of this topic.  I think it is
perfectly OK to clean it up before your topic hits 'next'; adjusting
to such a change is a responsibility of the author of a topic that
depends on anything not in 'next' yet.

> I think the only outstanding discussion is whether to name things
> `odb_alternate` or `odb_source` [1]. In case others agree that
> `odb_source` is a better name I'm happy to revise, but if not I'd rather
> keep it as-is.

The model in which the term "alternates" was born is "A repository
has its own object directory, the primary one, and in addition it
can borrow from zero or more alternate object directories that are
used by other repositories".  The presence of the primary makes the
word "alternate" meaningful.

Is the model now "A repository has one object store, which consists
of one or more X, all of which are equals"?  If there is no primary
that is more special than others, then calling X an "alternate" may
indeed sound funny, although (1) I do not find it terribly confusing
and (2) I do not find "source" much better, either.

The names we use to call the collection and the underlying
implementations of the collection in the reference world
unfortunately does not quite help to guide us, as we do not take two
implementations and compose into one unified view, which is what we
are doing in the object store.  Hmmm...

We call pathspec elements given on the command line collectively a
pathspec.  "Object store elements like loose object directories and
packfiles form the object store"?  That may be a mouthful.  I dunno.



