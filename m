Received: from fhigh-b3-smtp.messagingengine.com (fhigh-b3-smtp.messagingengine.com [202.12.124.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C750A17A2E1
	for <git@vger.kernel.org>; Thu,  2 Oct 2025 18:27:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759429650; cv=none; b=N4r2eu+OxaLUQIZBjTYpsrzI+sgbClVKlIUNjllXQwz3j0PL7JL7ICPJRwZoi5KHQ4gb7hgWCrX0inhmZtq+RRJkWp+m3pDu5cpOOamSUoNZL7uWaU0Th6wyUYRlQn/SfABw7xcQPgBxx01/x6i0Ky2Q/4aVnXwpEEZCwJp66PU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759429650; c=relaxed/simple;
	bh=tIBftkCY2ag4tfb+YX8Td2Rc97I54eQ4H/DIgGy0Bn4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=gkS+lEVPImbPUjtLGa8Fhk68QFzmrneFL8zQQL25G8OD6Nxt+hI2dw+UVAJG5dLUi1xzKu6f6HwjHHpNgDBafB+h6OS6qYXl3mKefklxU36S+bFkqLqMGyPOps2nI6NHiSLgfPldusybpHnyhP74gCRw2kNFrU1hMw4d9sRGcpo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=Tcmzzhzc; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=xAf1s0dh; arc=none smtp.client-ip=202.12.124.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="Tcmzzhzc";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="xAf1s0dh"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.stl.internal (Postfix) with ESMTP id BEF477A00F6;
	Thu,  2 Oct 2025 14:27:27 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-06.internal (MEProxy); Thu, 02 Oct 2025 14:27:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1759429647; x=1759516047; bh=U5D5OoKsIR
	wRYhJxeulCGkR6AqvLM/SmgI4d0oRgHzw=; b=Tcmzzhzc2luz2MDShl9w/w9Twv
	g54NJm+8VAWkUGO3Ucnwu/3HmDXq/kdRKdRhDlRUZiKP0Sr3QyHRvrIR5eqDl7ju
	Gp1PEzjlxRPJe3lt0vaU23A+hbrv037zpa774dQmNUY0K+AWpomM1Ies3XasT2Ys
	uLBBUEUl3FGwRYpDZQw5Hxuh2pVg+neVtH+FmqtoAJPj8wq6/YHBB3INu5K4CYA3
	YQaqp7qo32F7uLyuMc5JpnVGolDJn+86HyZQM2LO5P029PedzwT0yMuli95RQWVO
	s+wPOUeAKvbVpDXrWgcOFtaIFObtNVGRnuc98IhPYB7GzXKcuPqYbJrtv/oQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1759429647; x=1759516047; bh=U5D5OoKsIRwRYhJxeulCGkR6AqvLM/SmgI4
	d0oRgHzw=; b=xAf1s0dhunzEixpB8gyl5KvwOQ+3JO2szdnBxStS5EDsxBkCota
	fueIuiMYGqrgXG4X8zhEuRdPB1OuHyKksKTCdwlJUfiE+5ZWuETdHxokezsBMdkQ
	1h1Uw11YcS71KJYOByuMwBYiaxHa5JV+xTii570dhRCBiVkAHdeIauf+t/EFE/51
	VP6moId4+w8/kC/3h1cfVV+i6o7VLyEhhG3jR22OojM1ViviBgmdG5K6NV+oIOFf
	S75+Le5iXVymXPz/hit0mKwHj0DZPNNMN5KtHJX5z4A29GPOMUo/6pJCvOgV8rL+
	nJlmxYKg3LlrPT3vmyw1t9uSqyffIdVHjHw==
X-ME-Sender: <xms:DsTeaIrXahkIFVMYQtZ4wxil_i8ueBPodZk2S9IsCQZFgKhtetzWwg>
    <xme:DsTeaFBAxoEIlNU7q-lak8Dyx-Y9ILLl4_R7rDI_c5NaaS5F7083oC5k6L-swdk_c
    KoD2C_O5Raeuf2KNTxJm9eyLUGlq-T8xJszFs0uyRyYsZoBkCBU6w>
X-ME-Received: <xmr:DsTeaJdj4YVEQKjXIYzVGWrcCmZc_Enof9CCGiOp1OTO4J5d0JyCHPvo0t7KFiFYO6k-NpTySr7cnc3r4ETmO7zma6dSJY-9co9K>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdekieejgecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecuhfhrohhmpefluhhnihhoucev
    ucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtth
    gvrhhnpeefveetteejheeugeffledvteeiveffueefjeelueffteeigffgfedthfefieeg
    ieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgih
    htshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopedufedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepnhgvfihrvghnsehgmhgrihhlrdgtohhmpdhrtghpth
    htohepshhiugguhhgrrhhthhgrshhthhgrnhgrfedusehgmhgrihhlrdgtohhmpdhrtghp
    thhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopegthhhrih
    hsthhirghnrdgtohhuuggvrhesghhmrghilhdrtghomhdprhgtphhtthhopehpshesphhk
    shdrihhmpdhrtghpthhtoheptghouggvsehkhhgruhhgshgsrghkkhdrnhgrmhgvpdhrtg
    hpthhtoheprhihsggrkhdrrgdrvhesghhmrghilhdrtghomhdprhgtphhtthhopehkrghr
    thhhihhkrddukeeksehgmhgrihhlrdgtohhmpdhrtghpthhtohepjhhlthhosghlvghrse
    hgmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:DsTeaNuwEqdIuUCMVJA9eZW0F6AgL4Z-gcPqj2N68x_1WeYezgruCw>
    <xmx:DsTeaAgaqHrQdd9ve3uLZj5MMkVC7UgR8GKUOsS6nihdj0sp6GG-MQ>
    <xmx:DsTeaFuRAD4cVJHZHqneKpte_-HQEXOHzB-anSucYGhxTWeq3mTxRQ>
    <xmx:DsTeaL-Ip0zScwLM0MprLteq1TS5NdcP0vFU-XVDibcCn2wTzrW0Ag>
    <xmx:D8TeaCnBpS3kd3idWruMk4MeN1geiHkl1x3Uz6fpP71QQiRk5l3wxK3M>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 2 Oct 2025 14:27:26 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Elijah Newren <newren@gmail.com>
Cc: Siddharth Asthana <siddharthasthana31@gmail.com>,  git@vger.kernel.org,
  christian.couder@gmail.com,  ps@pks.im,  code@khaugsbakk.name,
  rybak.a.v@gmail.com,  karthik.188@gmail.com,  jltobler@gmail.com,
  toon@iotcl.com,  johncai86@gmail.com,  johannes.schindelin@gmx.de
Subject: Re: [PATCH v2 1/1] replay: make atomic ref updates the default
 behavior
In-Reply-To: <CABPp-BEh7VEM6UQjkK3CxJcv54vEmueTmh9+-SyTKUxgy7Mkcg@mail.gmail.com>
	(Elijah Newren's message of "Thu, 2 Oct 2025 09:32:51 -0700")
References: <20250908043620.57848-1-siddharthasthana31@gmail.com>
	<20250926230838.35870-1-siddharthasthana31@gmail.com>
	<20250926230838.35870-2-siddharthasthana31@gmail.com>
	<CABPp-BEh7VEM6UQjkK3CxJcv54vEmueTmh9+-SyTKUxgy7Mkcg@mail.gmail.com>
Date: Thu, 02 Oct 2025 11:27:25 -0700
Message-ID: <xmqq7bxdw44y.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Elijah Newren <newren@gmail.com> writes:

>   * it provided a natural low-level tool for the suite of hash-object,
> mktree, commit-tree, mktag, merge-tree, and update-ref, allowing users
> to have another building block for experimentation and making new
> tools.
>
> I was particularly focused on the last of those items for the intial
> version at the time, but it should be noted that all three of these
> are somewhat special cases, and the most common user desire is going
> to be replaying commits and updating the references at the end.

Yes.  We could even tweak the stream in the middle with "sed" or
"grep", I presume? ;-)

> Sure, but it's quite trivial to add, right -- as shown above with the
> extra "start", "prepare", "commit" directives?

Very true.

Completely a tangent but, isn't requiring "prepare" at this layer,
and possibly in the form of ref_transaction_prepare() at the C
layer, not so ergonomic API design?  Once you "start" a transaction
and threw a bunch of instruction, "commit" can notice that you are
in a transaction and should do whatever necessary (including
whatever "prepare" does).  I am not advocating to simplify the API
by making end-user/program facing "prepare" a no-op, but just
wondering why we decided to have "prepare" a so prominent API
element.

> ...
> Might I suggest a rewrite of the text of the commit message to this point?

I do think it makes more sense to the reader to know the reasoning
behind the _current_ design, and what its strengths are.

> =====
> The git replay command currently outputs update commands that can be
> piped to update-ref to achieve a rebase, e.g.
>
>   git replay --onto main topic1..topic2 | git update-ref --stdin
>
> This separation had advantages for three special cases:
>   * it made testing easy (when state isn't modified from one step to
> the next, you don't need to make temporary branches or have undo
> commands, or try to track the changes)
>   * it provided a natural can-it-rebase-cleanly (and what would it
> rebase to) capability without automatically updating refs, I guess
> kind of like a --dry-run
>   * it provided a natural low-level tool for the suite of hash-object,
> mktree, commit-tree, mktag, merge-tree, and update-ref, allowing users
> to have another building block for experimentation and making new
> tools.
>
> However, it should be noted that all three of these are somewhat
> special cases; users, whether on the client or server side, would
> almost certainly find it more ergonomical to simply have the updating
> of refs be the default.  Change the default behavior to update refs
> directly, and atomically (at least to the extent supported by the refs
> backend in use).
> ====

This reads very well.

> Why is --allow-partial helpful?  You discussed at length why you
> wanted atomic transactions, but you introduce this option with no
> rationale and instead just discuss that you implemented it and some
> design choices once you presuppose that someone wants to use it.
>
> Is there a usecase?  I asked for it last time, and suggested
> discarding the modes without one, but you only discarded one of the
> extras while leaving this one in.  I'd recommend discarding this one
> too and just having the two modes -- the output commands that get fed
> to update-ref, or the automatic transactional update of all or no
> refs.

I know there are people who like "best effort", but I too want to
learn a concrete use case where the "best effort" mode, which
updates only 3 refs among 30 that were to be updated, would give us
a better result than "all or none" transaction that fails.
