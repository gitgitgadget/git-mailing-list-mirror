Received: from fout-b5-smtp.messagingengine.com (fout-b5-smtp.messagingengine.com [202.12.124.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CB0E25CC5B
	for <git@vger.kernel.org>; Fri,  8 Aug 2025 21:54:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754690059; cv=none; b=Qmdk8A6EbcVqH3wI9T2eH0tfKwq5FUU4LzvpQ0VUUEpVpMk50DzvR8+sF+mDnORO2XcGo1i1Sk54/pJIHNwdXpb9dFAuBribxlNqkmKvrUxrYkysZx7/VbMNQCksa45AZD0KcnOQ3PGLHfnuKscbmHZ/7HVgli+1FU8ROQF+uWQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754690059; c=relaxed/simple;
	bh=TAPgtmexE4d7eZs5besxL3QFbjOujiTXOYVtGYOoCOM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Wmgz7VDD29nGDLucS8+EDOA1hK9W5mbAzeGLwp8V1RwVn6kLhF+TagTMI5EkxbEOwpnDoadZH1UfPsIkB67agDWrG3KqmeA1MOz+nPpvfse26oRMSAwXyGWRZi3Aywaw0UMa/7Vd/qOPDAG6E954rMKFhh3ZL3+ADXLPMX1sJBk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=KK5rn+rg; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=AIK9vhwh; arc=none smtp.client-ip=202.12.124.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="KK5rn+rg";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="AIK9vhwh"
Received: from phl-compute-12.internal (phl-compute-12.internal [10.202.2.52])
	by mailfout.stl.internal (Postfix) with ESMTP id 83C5C1D0003C;
	Fri,  8 Aug 2025 17:54:15 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-12.internal (MEProxy); Fri, 08 Aug 2025 17:54:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1754690055; x=1754776455; bh=aSMZvPhDfD
	RBLxxjuZ7aOkpQkMItAyMwWRJmXt6XNbc=; b=KK5rn+rg4oAE2Q6Om3Fdkh8FrP
	MRp7VbEcT6P1CDGcjSCwzJf3+yKItSAp/yg6RqYVJZKKTWADoOc1teDzPCiBuM0a
	FtF/I7fckJnwN+lIztsY95Y/Uacz8hAooglneCFfOeLC6otXvvp+O5cjPDsVjcWh
	515O4MREWS04BxyRdVzYGD3+s6QK8iXZZfj4EjKpEKoiwsbfPzxeYN589sOC45ZD
	xl15bJI8pwWj1DiRxVpNbPHDTPNRY2N1P0WmVI8hfLVEsDXOzulJGnEKOC7w82oO
	rX1rW9Ma3sXRtRDT1zTW4iLSCHOWN8SQ6dixOOZ/NjD9LfMCyMbWdD54MTHw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1754690055; x=1754776455; bh=aSMZvPhDfDRBLxxjuZ7aOkpQkMItAyMwWRJ
	mXt6XNbc=; b=AIK9vhwhrzi2cSETzPSABpiqoRfcQe+Nn9j81mb+lLCp+lbxKO2
	/AsMOqBswDFSwkzVz4AoK3RRpO83iExc3Qs9qHFn9toYEXsW1kGM4U5VDZKBN6gq
	h9MG+N3moC04TocaYl+8vnGw5AVk+p8C9oW19fsUyGRXcJ/H8ftXaaXgAVY1C+0a
	EGD2jWJPh035ZsJm3nvONn6QZ1IcnZ4fFMPXnYoL2kP6vu2v01Z/OQANNbFlTlmi
	g6GyZZmsVQI0FmBIntNYsg+TcjonGr0vWZOelK1JcifSzCXJANwQfFrAoIwNheTq
	85uRwK1FOb5BRFz+iuJDWskMEat5G4wGYCQ==
X-ME-Sender: <xms:B3KWaFVRlsCfLlF7_bN-eriP7w4iRSXpwcBqhP7dUp2tTqLGSUUymg>
    <xme:B3KWaAINWSuleACNFaTMqfMakHBjk1PTQSL-OUw1CffZweAa6o6kNzeBTMWTkYu7s
    kQoQFwR_H5vvs7-1w>
X-ME-Received: <xmr:B3KWaN9jkgmBIJcgKbvK7rq-3LM57nplnD1gXlvVxa3Kx6Hr63jBGxmIxfwQNZwFaycPJjCUIxgT7Mqi276e07DGW0tNaeXpuJej5ig>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdduvdegleegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtofdttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepieekueefhfetvdfftdegfeekhfffgefgfeeivddugeffgfffffevvedvieel
    ffdunecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepgedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepghhithhgihhtghgrughgvghtsehgmhgrihhlrdgtoh
    hmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthho
    pehjuhhlihgrsehjvhhnshdrtggrpdhrtghpthhtohepghhithhsthgvrhesphhosghogi
    drtghomh
X-ME-Proxy: <xmx:B3KWaLIV5Llvzzcal2wyAmSe54rbAX_F8Ko0FyGrr2uzBaw_XWB-VQ>
    <xmx:B3KWaKl2Sbw4v4gxPcYmh0WqSo4vemDEftleceAJ28VaArJb_VSZVA>
    <xmx:B3KWaHNvmqUuilZHSKDhFsjo_-Ew-2WTHqaLgyTJfNRxBdwSdtMxYw>
    <xmx:B3KWaI2sE9ZX-xoDtyWlQC2yiYABorR2_LwFB2BPhVZGj4QVOl6eYw>
    <xmx:B3KWaIgu61JDnVM1FV3Z_DXXG2xLv7u2d2i-DG-BdJq1UL-Yp79UNZ2Y>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 8 Aug 2025 17:54:14 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "Julia Evans via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Julia Evans <julia@jvns.ca>
Subject: Re: [PATCH v2 5/5] doc: git-rebase: update discussion of internals
In-Reply-To: <ad97cd9e6718be2540657c2c820f29b9efafa883.1754680525.git.gitgitgadget@gmail.com>
	(Julia Evans via GitGitGadget's message of "Fri, 08 Aug 2025 19:15:25
	+0000")
References: <pull.1949.git.1754666665.gitgitgadget@gmail.com>
	<pull.1949.v2.git.1754680525.gitgitgadget@gmail.com>
	<ad97cd9e6718be2540657c2c820f29b9efafa883.1754680525.git.gitgitgadget@gmail.com>
Date: Fri, 08 Aug 2025 14:54:13 -0700
Message-ID: <xmqqbjopfpiy.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Julia Evans via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Julia Evans <julia@jvns.ca>
>
> - make it clearer that we're talking about three steps of a process

A good call.  "First, then, then" does make it clear where each new
step begins.  "First, then, finally" would make it even more obvious
which step concludes the sequence, though.

> - delete a duplicate explanation of how git rebase skips commits with
>   the same textual changes (it's explained in more detail a few lines
>   further down)

OK.

> - move the `ORIG_HEAD` note down so that it doesn't interrupt the
>   discussion of the mechanics.

I thought you moved the "finally we reapply" up, instead of moving
the note down ;-) And when viewed that way, a more direct way to
justify this change is that you made sure these three steps are kept
together.

Again, good change.

> -All changes made by commits in the current branch but that are not
> +Here is a more detailed description of what `git rebase <upstream>` does:
> +
> +First, all changes made by commits in the current branch but that are not
>  in `<upstream>` are saved to a temporary area.  This is the same set
>  of commits that would be shown by `git log <upstream>..HEAD`; or by
>  `git log 'fork_point'..HEAD`, if `--fork-point` is active (see the
>  description on `--fork-point` below); or by `git log HEAD`, if the
>  `--root` option is specified.

If we are ambitious, we may want to rewrite this first step to put
almost no stress on "saving" and "temporary area".  Especially when
you rebase with merge backend, it would be morally a sequence of
cherry-pick, without us having to save anything---we only need to
figure out which commits to replay in what order.

    First, the command figures out changes from which commits to
    replay in what order.  The set of commits are those shown by
    `git log <base>..HEAD`, where <base> is the <upstream> if given,
    or computed fork-point if the `--fork-point` option is active,
    or all commits that lead to `HEAD` if `--root` is given.


> -The current branch is reset to `<upstream>` or `<newbase>` if the
> +Then the current branch is reset to `<upstream>` or `<newbase>` if the
>  `--onto` option was supplied.  This has the exact same effect as
>  `git reset --hard <upstream>` (or `<newbase>`). `ORIG_HEAD` is set
>  to point at the tip of the branch before the reset.

"This has the exact same effect as" made my reading hiccup.

    Then `git reset --hard` rewinds the current branch to the commit
    given by `--onto`, if specified, or to `<upstream>`.

I am not sure if it is worth talking about ORIG_HEAD at this point,
as that is part of what `git reset --hard` does with this step.
Given especially that we have NOTE that says ORIG_HEAD cannot be
relied upon once the replaying of commits begin, mentioning the
value of ORIG_HEAD before the replaying begins does not seem to add
much value to the explanation.

> +Then the commits that were previously saved into the temporary area are
> +reapplied to the current branch, one by one, in order.

Yup.  As I suggested, "Then" -> "Finally".

I do not know how much detail we want to give to readers, and I do
to prefer to tell some white lie in end-user facing documentation if
simplified description helps the initial understanding, so I am not
yet decided if I recommend rewriting these "three step" explanation,
but FYI, the modern rebase machinery works slightly differently:

    First the command figures out what to replay, on which commit,
    and in what order.

    Then the HEAD is detached ("git checkout --detach <onto>") to
    the commit the first change is replayed onto.

    Then the changes are replayed, one by one, in the order.
    Optionally a mergy history can be rebased while retaining
    the topology.

    Finally, the branch being rebased is made to point at the
    resulting HEAD (i.e. equivalent to "git checkout -B <branch>"
    to jump back from the detached HEAD state).

The difference between the simplified procedure and this "replaying
is done while on detached HEAD" procedure gives us a somewhat big
usability improvement, as a rebasing will be recorded in a single
reflog event for the branch getting rebased, no matter how many
commits are on the branch.
