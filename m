Received: from fhigh-a3-smtp.messagingengine.com (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7608F26F280
	for <git@vger.kernel.org>; Wed, 10 Sep 2025 21:20:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757539230; cv=none; b=GNfPYK4HU4KKknpvIN714z87DNFX0gJr7tsNFPC/9LT5QyQrADYVJbKzoyBE/kiR782zts4clSwOMPjYOavjFyna+cbOFXCJ6/P2VM1G/ph2yNLJs3i1NjWH7HSOrBvSFGz/hN4Ox82Mz31kaTqIbP931b8SDjhEd54GIfuRr80=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757539230; c=relaxed/simple;
	bh=YimhtMpIydembTHZGS0s81fpkJuWFmG/VsZKBeHwfh8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=QByL7sEhlyTQn5DbsgF3ixou82VTd6BTDgjbC5GuNzq+0l5PaDplESJ7B0edqnhZCSV3sHQyPTplsAHXr6WfsjJXjUtYRyT4DQAtfL9TKDLncvH+cIC+yxWZ/AXxE8GY8Cdj5NrJPAeV9GTS7IzPmo0Je+34aGk5E5WUuRn9CHk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=glLy8NHL; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=hkrfpOGa; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="glLy8NHL";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="hkrfpOGa"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 9DB6D1400087;
	Wed, 10 Sep 2025 17:20:27 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-03.internal (MEProxy); Wed, 10 Sep 2025 17:20:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1757539227; x=1757625627; bh=H44JjbRLAj
	2yLs/d8IVxpwSYYapg3XheRC8nefwUa8Y=; b=glLy8NHLOO5pv+DEuXkmbwlC/Q
	4+8kZdjZUy2yoDuQfbrZEE+IwC119TLLM6BBEU9jNDvDmiGJRm+V7sGJCh/JmSnB
	JohbFiPsWfpV0uD0Bw7xsxEG6ZhCHZqiGlQmM2dL+la74FTcmMJAHVeE34IEepoB
	dzIJCi0Ij3e+EgoOlrDice/u4ZPiRRTX/nUi6TROiNqaLbsFYEFFsNcNzKhPcSGZ
	Ubzo8MarBxEOi+SHxFvcWDXZFkfBCF5sw6ymPOU2kc5RqOT6sVeoOs6cHjZtADNQ
	Qi3BKdhspCMf7MNRkS48ahr0daYm+FiadhLTnxfmZzTsYk1A0ygj40bCAfKg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1757539227; x=1757625627; bh=H44JjbRLAj2yLs/d8IVxpwSYYapg3XheRC8
	nefwUa8Y=; b=hkrfpOGabcZ8i03Za8uQaOLqHKwtqwidYzSQCUrq2+gP/ZPnFc+
	1SUXO7SpeOaasNOPbQYgZJ+qiBQwMJyxiNOwp9+ai4WD1Hbo4hoNswdkwdvWjIxe
	vXELhyPibnk2L/XvoMe9dEu09cliQ6SyMxeOV7zLTEqC2RoeRJh4X9OX1hZ0dSId
	WWeK9FN5inGv/kE4ohnbYtMiW4+gKsdrP1WybgyGt0L1vNPwE3AV5B+QYVkLsWGY
	id/9Jxt51KyFkCg3402+UJvxzFMjHOJlsZZ8/fycjLcP8NHW94BNrlmdAWPnHwO9
	NGoSX2QPfT9njJu6zeruV8sAtQgrWE5Syyg==
X-ME-Sender: <xms:muvBaGKx08DYp26Ra-2VA69O-6-Flcu-4T-iFbARNWGlHglXojFDQA>
    <xme:muvBaOwCvC40CLG8hLQ5B5R-0kAkF_OnZ0E_p-TnRFyfSbXFZ8KEVewtfJCdK9_0E
    gpW9-AsJ4YpdpLcVg>
X-ME-Received: <xmr:muvBaB0Wz4DT5CeWLBQ2lK5cV4pC-KV8sjwaxtGMMUfFwTt6mf-LhfSTBsMdOiJVZ6TNh3MaQAeDVRzrU2iH_MCJ40k7xfJjT-5h1vg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvgeefhecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecuhfhrohhmpefluhhnihhoucev
    ucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtth
    gvrhhnpeefveetteejheeugeffledvteeiveffueefjeelueffteeigffgfedthfefieeg
    ieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgih
    htshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeduiedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepphhssehpkhhsrdhimhdprhgtphhtthhopehgihhtse
    hvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheptghonhhtrggttheshhgrtghk
    thhivhhishdrmhgvpdhrtghpthhtohepshgrnhgurghlshestghruhhsthihthhoohhthh
    hprghsthgvrdhnvghtpdhrtghpthhtohepsggvnhdrkhhnohgslhgvsehgmhgrihhlrdgt
    ohhmpdhrtghpthhtoheptggssedvheeisghithdrohhrghdprhgtphhtthhopegtohhllh
    hinhdrfhhunhhkudesghhmrghilhdrtghomhdprhgtphhtthhopegvshgthhifrghrthii
    sehgvghnthhoohdrohhrghdprhgtphhtthhopehnvgifrhgvnhesghhmrghilhdrtghomh
X-ME-Proxy: <xmx:muvBaP-CcYmB_pimIkOq4wvyH-tYC-96jPUmWzOqsNfBbcnpCjumgg>
    <xmx:muvBaBRAzRmKtglaKghgooSGiKK9WV7o6kKuEfwdWJ7FgvPfi_h01A>
    <xmx:muvBaGnIt-Kv3gtEhB2f7vy7PhE2xjr8iQmOr3TDRh0YOmRVxKPU5Q>
    <xmx:muvBaMXooFT8ne3S578X3G3n-h78yaaB_zqRnGDur36xP3Zta4VoUQ>
    <xmx:m-vBaN4jNpKF9N4qfWGMd9yDGApucPkMc6BkW-yxtotyr57_ELTTF594>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 10 Sep 2025 17:20:26 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org,  "Haelwenn (lanodan) Monnier"
 <contact@hacktivis.me>,  "brian m. carlson"
 <sandals@crustytoothpaste.net>,  Ben Knoble <ben.knoble@gmail.com>,
  Christian Brabandt <cb@256bit.org>,  Collin Funk
 <collin.funk1@gmail.com>,  Eli Schwartz <eschwartz@gentoo.org>,  Elijah
 Newren <newren@gmail.com>,  Ezekiel Newren <ezekielnewren@gmail.com>,
  Johannes Schindelin <Johannes.Schindelin@gmx.de>,  Phillip Wood
 <phillip.wood123@gmail.com>,  Pierre-Emmanuel Patry
 <pierre-emmanuel.patry@embecosm.com>,  Sam James <sam@gentoo.org>,  Taylor
 Blau <me@ttaylorr.com>
Subject: Re: [PATCH RFC v4 7/9] BreakingChanges: announce Rust becoming
 mandatory
In-Reply-To: <20250910-b4-pks-rust-breaking-change-v4-7-4a63fc69278d@pks.im>
	(Patrick Steinhardt's message of "Wed, 10 Sep 2025 17:35:53 +0200")
References: <20250910-b4-pks-rust-breaking-change-v4-0-4a63fc69278d@pks.im>
	<20250910-b4-pks-rust-breaking-change-v4-7-4a63fc69278d@pks.im>
Date: Wed, 10 Sep 2025 14:20:24 -0700
Message-ID: <xmqqldmmqa1z.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Patrick Steinhardt <ps@pks.im> writes:

> +* Git will require Rust as a mandatory part of the build process. While Git
> +  already started to adopt Rust in Git 2.52, all parts written in Rust are
> +  optional for the time being. This includes:
> ++
> +  ** Subsystems that have an alternative implementation in Rust to test
> +     interoperability between our C and Rust codebase.
> +  ** Newly written features that are not mission critical for a fully functional
> +     Git client.

This is a bit funny way to phrase the intent, even though I do fully
support the intent expressed here.

When this topic becomes part of the code base, we are likely to have
varint in the first category, but if we have nothing that falls in
the second category, that would feel somewhat odd.

> +These changes are meant as test balloons to allow distributors of Git to prepare
> +for Rust becoming a mandatory part of the build process. There will be multiple

Are they still "test balloons"?  I thought that we established that
the point of these breaking changes is quite different from what we
have called "test balloons" for.  It is not like allowing them
anything (like interfering to delay or stop, which would not likely
to happen at this point if this patch gets part of the code base),
but is used as a bit more forceful way for us to tell them and make
sure they are aware of the upcoming change.

> +milestones for the introduction of Rust:
> ++
> +1. Initially, with Git 2.52, support for Rust will be auto-detected by Meson and
> +   disabled in our Makefile so that the project can sort out the initial
> +   infrastructure.
> +2. In Git 2.53, both build systems will default-enable support for Rust.
> +   Consequently, builds will break by default if Rust is not available on the
> +   build host. The use of Rust can still be explicitly disabled via build
> +   flags.
> +3. In Git 3.0, the build options will be removed and support for Rust is
> +   mandatory.

I like the vagueness of the gap between step 2 and 3 here ;-)

> +The Git project will declare the last version before Git 3.0 to be a long-term
> +support release. This long-term release will receive important bug fixes for at
> +least four release cycles and security fixes for six release cycles. The Git
> +project will hand over maintainership of the long-term release to distributors
> +in case they need to extend the life of that long-term release even further. In
> +that case, the backporting process will be handled by these distributors, but
> +the backported patches will be reviewed on the mailing list and pulled in by the
> +Git maintainer.

I am having a hard time imagining the practicality of this "hand
over but we still review" arrangement.  Some of the security fixes
are embargoed, and the reason why we are jetissoning the stale
codebase is presumably because nobody is willing to work on it other
than the "community support" folks.  I can imagine that we would
qualify them into the git-security cabal and let them use the forum
to coordinate among themselves, but then to what degree in the
"community support themselves" process is our involvement expected?
As long as we can make sure that they do not leak before the
official embargoed release, they do not need an official stamp of
approval from the project or by the Git maintainer---that is what it
means to "hand over maintainer ship", at least to me.

In other words, I like what I see in this paragraph, but I do not
think we can practically live with the part of the sentence after
the last ", but".

Thanks.
