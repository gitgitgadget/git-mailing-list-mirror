Received: from fhigh-a7-smtp.messagingengine.com (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE85910E4
	for <git@vger.kernel.org>; Tue,  4 Feb 2025 00:18:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738628329; cv=none; b=hjO1TC9CuFZ4A9VKI/8D4JmT5TGcvJCIpS9gHf4O/XZvsPAClo/pO/Q+6ktv2FiBqMY3eaZPRlPBRgxR4RSgkE8kfHySpi/iAQGXr+WCOgGdZhyUkiYkU2Ac1IekqjejHOOZ+mbV0GlFvfFFIA2rdg55hRTEcxlnMVS1AkUyr4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738628329; c=relaxed/simple;
	bh=iBqi6CYdz+I2Ys25oeL/Jb0AqOeIysZ5hgwjtKASgGM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=SJ2SrcaPJnLVWI3g8iJdTfbNRBT76dkXpOp/Svv6AMiLnicyIx5EJe+H/vrR9Lmx8u2d4L85xPWrW+tnmM9MnLI7YXUh2rO7CRZZxILEJfPZ/UkyuF3o2F4TBAPNb+mCUf1ZonNEj6lYot8z47Zgz+MvkSztC6zVMdvDiUcHlYk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=OSzy8kpP; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=DFDffZ+k; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="OSzy8kpP";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="DFDffZ+k"
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id B136211401D0;
	Mon,  3 Feb 2025 19:18:46 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-06.internal (MEProxy); Mon, 03 Feb 2025 19:18:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1738628326; x=1738714726; bh=slS0QT9Yyn
	sE80m2dcKoZTtinxt4ZiS2F2U2XodaBP0=; b=OSzy8kpPkXoSVDbUu41+ma9c74
	AluL/E3V2aMpeTYMruV2UA6VDRdI4k2/laaohxeOVBHS0KqOmdYuj2l8hsJ1VL71
	ylmvmmTjgLadxTGQDBsQEVbyhnpwSQdKVopeQdyawHGH0ixZjPOrYSE3MiwfkBTG
	wPgEmFIsVDw8JAKGRjHuVjKw7dzmPoftDs/CvHaKNjla+qBPMdYXNPYEMzahCVIS
	TcFIi1spLxHMcCVYz78mtgjVBSHC8QmEMbNh2n04nGCYXYVtqhhiQLcRz9mTCoE1
	zrOlQPZC+X6vYsPmUwFeqSC93Li6qFyrSZAnNRNT/9b9uyroW3v5dzACWy0g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1738628326; x=1738714726; bh=slS0QT9YynsE80m2dcKoZTtinxt4ZiS2F2U
	2XodaBP0=; b=DFDffZ+kFeCigjp2CUp0eyrgI5BGGtkDD9CryZUtJvOkGshgA5F
	M0mAIIDDAz9sxp993o7gXZUNfXJq1ah7C4RneP83/M6Z+NBbFSukRyI8agnfTu6d
	NceWeva39JRyElAoxJYa8L2Y+ZjzXnf1ixt9O8w45x3B9dQtHGNA2/ZpHq+lgZRo
	1rKA04JBGXDUb/6OOb049Mtop19r6mOEyT4dzQSBBnQ1oMdIUVh2GR9VHd4LIpoA
	XnSz199hsHCpYYCn9xPYqxCCF6cjSQH4LUJxcV3mngnNB/0gCJ1Lc9XDXy42NfzP
	DTyvm0EFFX71Wbu5XbFYDj5GYEcznI7hIhw==
X-ME-Sender: <xms:5lyhZ5KNbz8Wd2KCbrLXr4vQcj-nnOnMunBuKsyXuqt-Aeym4zTVQA>
    <xme:5lyhZ1KPPqKCTapPp5fii3vK3LG_0GAwZ4VOgug4QS8DxWbdfZMYTLoUZiF-jRI34
    s-b5i2YNp-6vTZVIg>
X-ME-Received: <xmr:5lyhZxsKX3yVaV0MFAy4gBO1YZYJl5chtMNFmtXGf4ej38QVtWxyOiS3HygnK2rH546V1gDdhJSXuSLkGN41J0nIuUumugVeSJfs>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdduledtfecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertddtredt
    necuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsoh
    igrdgtohhmqeenucggtffrrghtthgvrhhnpeefveetteejheeugeffledvteeiveffueef
    jeelueffteeigffgfedthfefieegieenucevlhhushhtvghrufhiiigvpedtnecurfgrrh
    grmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgt
    phhtthhopeduhedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithhgihhtgh
    grughgvghtsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghr
    nhgvlhdrohhrghdprhgtphhtthhopehjohhhrghnnhgvshdrshgthhhinhguvghlihhnse
    hgmhigrdguvgdprhgtphhtthhopehpvghffhesphgvfhhfrdhnvghtpdhrtghpthhtohep
    phhssehpkhhsrdhimhdprhgtphhtthhopehmvgesthhtrgihlhhorhhrrdgtohhmpdhrtg
    hpthhtohepjhhohhhntggrihekieesghhmrghilhdrtghomhdprhgtphhtthhopehnvgif
    rhgvnhesghhmrghilhdrtghomhdprhgtphhtthhopegthhhrihhsthhirghnrdgtohhuug
    gvrhesghhmrghilhdrtghomh
X-ME-Proxy: <xmx:5lyhZ6b7Ulf-r9juJ9NoIeWQZLP850-Y2lS-IkwMp5repG6HOhBQZw>
    <xmx:5lyhZwYOuOnb4QqyiGKSaLw_qlYfIR95yVkYoqvMS1TcK6XZ14lkvQ>
    <xmx:5lyhZ-D4ZYKfqTACWdcnbqlNbKrnc9V7QzUg2wPF0nMCGR6r0MpcrQ>
    <xmx:5lyhZ-bIIUTwjDG8LQAnR3m7qq4AuGKr3RVFFk-e2rl8cXma7fxQeQ>
    <xmx:5lyhZ9KRf4MvorNALiNKjwFDyckM228EvoyQXVjH8dYcNsv4Q4r2_Qjd>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 3 Feb 2025 19:18:46 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  johannes.schindelin@gmx.de,  peff@peff.net,
  ps@pks.im,  me@ttaylorr.com,  johncai86@gmail.com,  newren@gmail.com,
  christian.couder@gmail.com,  kristofferhaugsbakk@fastmail.com,
  jonathantanmy@google.com,  karthik.188@gmail.com,  =?utf-8?Q?Jean-No?=
 =?utf-8?Q?=C3=ABl?= AVILA
 <jn.avila@free.fr>,  Derrick Stolee <stolee@gmail.com>
Subject: Re: [PATCH v3 0/5] PATH WALK III: Add 'git backfill' command
In-Reply-To: <pull.1820.v3.git.1738602667.gitgitgadget@gmail.com> (Derrick
	Stolee via GitGitGadget's message of "Mon, 03 Feb 2025 17:11:02
	+0000")
References: <pull.1820.v2.git.1734712193.gitgitgadget@gmail.com>
	<pull.1820.v3.git.1738602667.gitgitgadget@gmail.com>
Date: Mon, 03 Feb 2025 16:18:44 -0800
Message-ID: <xmqqwme6y32z.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com> writes:

> Updates in v3
> =============
>
>  * Rebased onto 'master' now that the path-walk API is merged.

I was going to object to this rebase, as the same path-walk was
contained already while building the base of the series for the
previous rounds.  IOW, "now that the path-walk API is merged" is not
a good excuse to rebase onto 'master'.

But then I forgot that there are other topics, like 'meson based
build' and 'synopsis formatting', that were in flight at the same
time that have been merged to 'master'.  They are good reasons why
we may want to rebase the updated version to 'master'.

IOW ...

>  * New builtin boilerplate is updated with new standards, including:
>
>  * Doc formatting uses [synopsis] formatting.
>  * Add builtin/backfill.c to meson.build.
>  * Add Documentation/git-backfill.txt to Documentation/meson.build.
>  * Add t/t5620-backfill.sh to t/meson.build.
>  * Update handling of -h due to f66d1423f5 (builtin: send usage() help text
>    to standard output, 2025-01-16).

... these are all good reasons, even if path-walk were still cooking
in 'next' (in which case, we'd prepare a custom base by merging path-walk
into 'master' and then apply these patches).

>  * Doc formatting is updated to use back-ticks on options and mark the
>    builtin as experimental.
>
>  * The batch_size member of 'struct backfill_context' is now named
>    'min_batch_size' in all patches.
>
>  * Some mentions of '--batch-size' are updated to '--min-batch-size'.
>
>  * An additional test is included for non-cone-mode sparse-checkout patterns
>    to further check the return values of path_matches_pattern_list() within
>    the path-walk API with sparse mode.
>
>  * A use of oid_object_info_extended() is replaced with has_object().
>
>  * The backfill_context_clear() method is called by the proper owner of the
>    struct.
>
> Thanks, -Stolee

Everything looked great from a quick look.  I'll have a more
detailed look later, but this round looks quite promising.

Thanks.
