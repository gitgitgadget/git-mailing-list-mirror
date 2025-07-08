Received: from fout-a5-smtp.messagingengine.com (fout-a5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 315EB8488
	for <git@vger.kernel.org>; Tue,  8 Jul 2025 18:51:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752000672; cv=none; b=EXkyiQbikrxzQA4tcfKYt5VyRD+EnhoDJcoeg4fza/EGy04WrFJOdnYs2wVSS+EEAs7/HuavNHzlFdklQG1kRcOA9u5tAHCK1A39iKC8rnpQWDhNehklqKr76WmT/KBvykxo46UbDs4MN/ZWSmNmWrw7QH8C22fyfIuzp7tVtME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752000672; c=relaxed/simple;
	bh=etaFGkfvjO4iMKNeschonIrgIlnDCGg0ncHSRhtXHGA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=WHVkycuwN3lKMNdpNfUN2uXvWhnO076/nygcuIWgP2DNvYpTl17Oahuq1a8TkS05w0bVHr/pVWnZ++dK3uWfexS2sqoe2YF9ua7hWr5FgN7WQhV9LZNqkPLf0XjASrizMrWK9utvYmOE+7rI0m20oqTvIAPRsEacLhyGrzW6bYE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=X4pLmvQj; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=j/WTOO8t; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="X4pLmvQj";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="j/WTOO8t"
Received: from phl-compute-12.internal (phl-compute-12.phl.internal [10.202.2.52])
	by mailfout.phl.internal (Postfix) with ESMTP id 439CBEC0015;
	Tue,  8 Jul 2025 14:51:08 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-12.internal (MEProxy); Tue, 08 Jul 2025 14:51:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1752000668; x=1752087068; bh=7b2NCuflwa
	DyOzrou6OgGMfv2LhMv7I7rf+5M22s9Sc=; b=X4pLmvQjAjtXedJrgxvpS2ACyJ
	cNZFbA+NqH9KVNhZfd1n9fJEoCAPY7YbsW6+Dr94ct3b5C2+EzsU/tJ3IRjqI3t6
	H+NaCwj+i40G4TrpfttqjV+FX6HsjmbgJ6WFNvCle8l2RVMYMrHMzgwlQeHHsfDg
	BB2SEf7FxCo8k/5ZeCGsD4D1agEWU2LCDzAXpvRAn1nuONprkymyKf5RDxO6mLU0
	Wb52+Bxo3AFRLFXWYAORlT2rRZ+upqTAt2XsrxtlkFxPyKyVhL1ugzGWY8RdRH1O
	oXJz7OR+xWhpJPFIdKWzCug3if49q134rsmybWsqwHNqR0qK4OvlEaWvPQOw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1752000668; x=1752087068; bh=7b2NCuflwaDyOzrou6OgGMfv2LhMv7I7rf+
	5M22s9Sc=; b=j/WTOO8tVr/lh+Vr2zKvk0gJBE5JCPZCXl/3wT9iKO79081COlK
	xITYdm7WHlK1HqNHU4hem/x0yUQrcCUbcJqCtmnmCx9GUYVgqTILTJ+k58w1a2rQ
	n7qG0lPWhf963y8erukoSXQnQkQDwWJTBFFgkAXmdwcmbVXAji1iUcve1JE+YboN
	e7gnmH1H2M3SMcjaSx759A8TybJdk+x68Xm2WAEEL7FTO/aHz/Q8DZbFhPi7c8jE
	vfAGJKSDhykwIB+wSpZVKr54OvFMdIWiuIf3q3iqDdrwlxk3pBtQvMejjkK0haZE
	coaN3sVrHm4oDVJaUvqgnX4yIxXZTtlcpdg==
X-ME-Sender: <xms:nGhtaNc3KgOPhfd5yVvx9fIz3dnKvgpZqiblK5Yw1YP5SfR0eA1LWw>
    <xme:nGhtaL5eCMJgj5q79sj-pkJUR9ixbOlZt1zNLpFzYcAP26iiHwRvdZmm1DesBwl63
    hhQl7wGYxlvWcvaoA>
X-ME-Received: <xmr:nGhtaEvfi4UPpG9FGPU0wUqAsVltsCZqZDvqvqKPIfQdeh77V2iDghcbdQdbgzNA8A954h2Fb2_aY5ctA00uwYWSzN6tkhy6rtpgEtY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdefheeggecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecuhfhrohhmpefluhhnihhoucev
    ucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtth
    gvrhhnpeevleelhffgudfgtefgueetgedvffevgfevtefgteehgeekhfefueeviefghfeg
    ueenucffohhmrghinhepkhgvrhhnvghlrdhorhhgpdhgihhthhhusgdrtghomhenucevlh
    hushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgihhtshhtvghr
    sehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeejpdhmohguvgepshhmthhpohhuth
    dprhgtphhtthhopehphhhilhhlihhprdifohhougduvdefsehgmhgrihhlrdgtohhmpdhr
    tghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopegrhi
    hurdgthhgrnhguvghkrghrsehgmhgrihhlrdgtohhmpdhrtghpthhtohepohhsfigrlhgu
    rdgsuhguuggvnhhhrghgvghnsehgmhigrdguvgdprhgtphhtthhopehmvgesthhtrgihlh
    horhhrrdgtohhmpdhrtghpthhtohepkhhrihhsthhofhhfvghrhhgruhhgshgsrghkkhes
    fhgrshhtmhgrihhlrdgtohhmpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtg
    homh
X-ME-Proxy: <xmx:nGhtaLjUnLyOQ7mGI5x2M_CVJmmmNq9t8ocqIsl_DHrcvRPTMI45hQ>
    <xmx:nGhtaPo9XlP3hep5d_E-vEk9qiNBkbxoTm1XSuli9BAeYWAgAf47Mg>
    <xmx:nGhtaIv6r6eUy3PyP6YCtC3Jflle0omxj6XNKzm0x-LKtGm2Se7J9g>
    <xmx:nGhtaCZNt5Zlbqa7oHxuzCvy1Q-L0CzWXPDiue7dedpZYnMQV3ZFng>
    <xmx:nGhtaOLC9aNaGdFT_X_kXFSfctxvBT1E6J6xzV4d1iFpG8q93ExKrLAd>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 8 Jul 2025 14:51:07 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Phillip Wood <phillip.wood123@gmail.com>
Cc: git@vger.kernel.org,  Ayush Chandekar <ayu.chandekar@gmail.com>,  Oswald
 Buddenhagen <oswald.buddenhagen@gmx.de>,  Taylor Blau <me@ttaylorr.com>,
  Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>
Subject: Re: [PATCH 0/2] breaking-changes: deprecate support for
 core.commentChar=auto
In-Reply-To: <cover.1751983009.git.phillip.wood@dunelm.org.uk> (Phillip Wood's
	message of "Tue, 8 Jul 2025 14:56:50 +0100")
References: <cover.1751983009.git.phillip.wood@dunelm.org.uk>
Date: Tue, 08 Jul 2025 11:51:06 -0700
Message-ID: <xmqqjz4iv7mt.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Phillip Wood <phillip.wood123@gmail.com> writes:

> From: Phillip Wood <phillip.wood@dunelm.org.uk>
>
> This series implements the plan to deprecate and remove support for
> core.commentChar=auto outlined in [1]. This feature has been the
> source of a couple of bug reports recently [2,3] and as explained in
> the first patch the design is tricky to fix. When git sees the
> deprecated config setting it will print advice like the example below
> to help the user either remove the setting or set a custom comment
> string.
>
> hint: Support for 'core.commentChar=auto' is deprecated and will be removed in git 3.0
> hint:
> hint: To use the default comment string (#) please run
> hint:
> hint:     git config unset --file ~/.config/git/config --all core.commentString
> hint:     git config unset --file ~/.config/git/config core.commentChar
> hint:     git config unset --global core.commentChar

We'd need to clear both variants from all scopes, wouldn't we?

	for scope in "" --local --global --worktree
	do
		for variant in commentString commentChar
		do
			git config unset $scope --all core.$variant
		done
	done

> hint:
> hint: To set a custom comment string please run
> hint:
> hint:     git config set --global core.commentChar <comment string>
> hint:
> hint: where '<comment string>' is the string you wish to use.

I do not particulary find it sensible to nudge users to use the same
commentChar across all projects with possibly different project
conventions by suggesting use of the --global option here.

It would be necessary to special case "auto" after 3.0 boundary
anyway, whether we (1) die when we notice the value is set to
"auto", and refuse to work until the user chooses a comment char, or
(2) use "#" or something hardcoded.  Either would be better than
using literal string "auto" as comment char.

So, a simpler approach might be to treat literal string "auto" as if
"#" was specified under WITH_BREAKING_CHANGES so that the end-user
does not have to do anything when they want to "revert" to the
default comment string.  Then we do not have to give any large text
like the above.  We can instead say something like

	The 'auto' setting of core.commentChar (or core.commentString) 
	will change its meaning in Git 3.0 and later and will always
	use the default '#'.

Hmm?

> [1] https://lore.kernel.org/git/6a3154e0-e7bc-45ae-b554-67ccab18727a@gmail.com
> [2] https://lore.kernel.org/git/20250315140913.577404-1-oswald.buddenhagen@gmx.de
> [3] https://lore.kernel.org/git/20250626132233.414789-1-ayu.chandekar@gmail.com
>
> Base-Commit: f0135a9047ca37d4d117dcf21f7e3e89fad85d00
> Published-As: https://github.com/phillipwood/git/releases/tag/pw%2Fremove-auto-comment-char%2Fv1
> View-Changes-At: https://github.com/phillipwood/git/compare/f0135a904...83d0d3ece
> Fetch-It-Via: git fetch https://github.com/phillipwood/git pw/remove-auto-comment-char/v1
>
>
> Phillip Wood (2):
>   breaking-changes: deprecate support for core.commentString=auto
>   commit: print advice when core.commentString=auto
>
>  Documentation/BreakingChanges.adoc |   4 +
>  Documentation/config/core.adoc     |  20 ++-
>  builtin/commit.c                   | 192 +++++++++++++++++++++++++++++
>  config.c                           |   4 +
>  environment.c                      |   2 +
>  environment.h                      |   2 +
>  t/t3404-rebase-interactive.sh      |   2 +-
>  t/t7502-commit-porcelain.sh        |  32 ++++-
>  8 files changed, 252 insertions(+), 6 deletions(-)
