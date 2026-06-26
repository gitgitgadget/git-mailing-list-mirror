Received: from fout-b7-smtp.messagingengine.com (fout-b7-smtp.messagingengine.com [202.12.124.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93D9037C910
	for <git@vger.kernel.org>; Fri, 26 Jun 2026 17:10:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782493821; cv=none; b=Geu8UGAYuiJ19dNZpaoZ3XGQGY/8pMCH9o+CROY55tNR6rpNpRGl0jW5Ns0kxqDo70/jJHHA8qwv7FnDERY5Dr45l9eT9UiYk3fiihkgFHKseJ40k/H0b9hZY72wyxn0IbPkB8f5dAPjaDomUjwqATwQ9kCfpqib6pWqO+u8enE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782493821; c=relaxed/simple;
	bh=bv2y1b/Lg+Ew7Gp8uldIOFu/ta5veQgZ5rbAc9ToArE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=EbR2te/CtwpKn0oPR7+gXC0swt4lSMTh423FayGIaJH13DplAPg8/0CGsEum4kdHR3zrBQUxLzvN5v2QWg56y6uG+mfCz0/be6K1sXjcSfd8ZJ0l5FBBnpZEH70yVB+yej+NnzZlD+LC8NUdnoiymo0wqsInbGp2B3zZEsWteAw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=IeEqSwmQ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=LM184eZr; arc=none smtp.client-ip=202.12.124.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="IeEqSwmQ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="LM184eZr"
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfout.stl.internal (Postfix) with ESMTP id DC8611D00194;
	Fri, 26 Jun 2026 13:10:18 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-10.internal (MEProxy); Fri, 26 Jun 2026 13:10:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1782493818; x=1782580218; bh=ABDxSVd+Xt
	dcqy1DxsuBl50JkLfAWG2nO0pDK1ZdID8=; b=IeEqSwmQsKSrwVaGdMYHEVpIFe
	I87SZ+yPMGRce1VPz0QoNbTAGOZU6hwYqk1HnojajKgLyEo7bVxhyDY/6B90XZbp
	lQF/pIEAvNcnD7/HtPNAl6xr0dVfnzjM7xanF+JGar+QhOVPSZsG7f+MBP8dDb3Y
	yCt5m+SrZccpcyXq6DrhXXh0cAbZ2yN/bpy1z+oWXNa4iihQECKiG1vX7i2hQ37T
	7YbBmGLf8qjo9f7KW6omi6N+4Xcm3a+X3OMKG5bWh0sR8XhudvJmIdSpEAp0DRNp
	tuza29WmUP/nAu2vkzu6ytMVhl2LzduzX5z33DP8Y4tOb7+623v1RXzoiv+w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1782493818; x=1782580218; bh=ABDxSVd+Xtdcqy1DxsuBl50JkLfAWG2nO0p
	DK1ZdID8=; b=LM184eZrH3x1TMxKfBM4B0e9ciD5DE7tg3M4zWPHd+sZtr1fYCw
	+eGtgyo51R1JcJUs5ovJr9nqi1KhadtQjMOr0YXvUAJNiQVw8ol2MvbzRmetBkXj
	TN7xBSjLSqN4/qaRQYLrIhiYNI09I9O5EBvU0n3RyfTTOnTP125jaRD4HzjxI8wO
	EpsfYRca+vlz7PMpE0bhvGG9kbrWX+v39HdPCxqrhxd3ZBZ2OeplQu7vmi4XAFvx
	0RChpyCSKPMdq/i90GBdCR4C2OYOgFFrbiNkqBOmBUgtR36rSm5cR3pPK9OulEih
	V5opeWYi9fNP8UdCgFFxFOQtkzgsrRCbg3A==
X-ME-Sender: <xms:erI-agZNYApOljH3dcRC6ew7szyWzvI_MU-okdlZ5lpUTPjG0xmHBA>
    <xme:erI-am7Czsi-Mm0Oy-7Z4kZjTLyGff7mUL0RISNTeuluX6sk2YCfUR0ZSNOaye0s5
    EAN4b6SUFXqcaQsMYxI_8y8ftp1slQ7ekQ_JIIcyBrWg5Z0jckiKw>
X-ME-Received: <xmr:erI-ahbHwGn8vnXNfaQMGaUswz9ndi_mFb7sHUDlE3NcS1aP9MDRGmwbsFDN-MS0sfkhgVZ189FdYw_Sj5RNzvkMXBfEIHZZpLJMfQE>
X-ME-Proxy-Cause: dmFkZTE77MqrSnbs46vT+9lVetdGabzpH/l85R4ZD3QhtQRl9OK5ptN5bLCFGUinRyJsr2
    WIYPo9wKtErOuaYN+hYAmbAOi5X5kH8TYlildD/4IRijtMT20iZvj4MOumQLE/iGGO4BK+
    J2DG2zVAz3BtsZLrMTkxQ68wqJHNH68kfMgdtVRWD2So3cZrXXlh3zk4L7LSAMBzaZVBIF
    NYFkH4Cu01BvZN1QfRHsF0i7AL7/FBFdy/IF6/U5NNbKljDGDPg892quvLF9dTBSz1mDiu
    GePy00Ix0pyDeO1kzc+9P+gXuWJxyjTBmu9vUPhs5tLKsK0ltd5D0f0ezq993w7hFuxaVi
    z6JQVxSVQd5FPy0v0zhPBobOYV9cFSY0u1OmtBteLxfVx1BLzTgtXZAVg3wz8QeDgIM1jn
    zFp3UfxlYUvqaS2px4+gCdILboYCWO9FP8H+7ZS06SbxqxytR8T8x7uqFyO5oIo4utsRf9
    MZm9+95q5/bjsM7+W6I4hZK0VAhdOPE1gru9ZiEJDWiTo9BlRqhz19pG9r1/DfNKxR/QAH
    Cbmd8jPBZaA+cJRJIYyoYwc6fIZN7PTZgQC5liaQ+aFZwdJYnrVKMmkchhpoDkFWhboJyc
    Hsg2ziNcB9JiAfIjVqctjLPBTqgFbdh/oC49whcVB3MshmAku9xQiGHbQV/w
X-ME-Proxy: <xmx:erI-alhFUAucWUhuwiCpr9I7L3ne7pgST5zN6LhCcQBy9fUCSDrEbg>
    <xmx:erI-ai_wljCmxJT5Fat89Uo3DWxwRGoFW3A0jm6FNMz-9BL-jcXF4g>
    <xmx:erI-agrGm8-vb0gBwyZj_FMbOOfffo7u-bxV15OEcSyEvtvq1IYU4g>
    <xmx:erI-aqWP6Y0JCuvUnAyu5uVYVSmqIbM7XILxoQB5OXDQUOeF2FEHUg>
    <xmx:erI-aiLe3dmWbgBJ8P95SeH2lqTwZA3f25nh72ojeC623oFYXNLnwq0f>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 26 Jun 2026 13:10:18 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Toon Claes <toon@iotcl.com>
Cc: git@vger.kernel.org,  Elijah Newren <newren@gmail.com>,  Johannes
 Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH v5 3/3] replay: offer an option to linearize the commit
 topology
In-Reply-To: <20260626-toon-git-replay-drop-merges-v5-3-5e120738b9d0@iotcl.com>
	(Toon Claes's message of "Fri, 26 Jun 2026 07:48:13 +0200")
References: <20260626-toon-git-replay-drop-merges-v5-0-5e120738b9d0@iotcl.com>
	<20260626-toon-git-replay-drop-merges-v5-3-5e120738b9d0@iotcl.com>
Date: Fri, 26 Jun 2026 10:10:16 -0700
Message-ID: <xmqq5x358byf.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Toon Claes <toon@iotcl.com> writes:

>  Documentation/git-replay.adoc |  8 ++++-
>  builtin/replay.c              |  6 +++-
>  replay.c                      | 50 ++++++++++++++++----------
>  replay.h                      |  5 +++
>  t/t3650-replay-basics.sh      | 84 ++++++++++++++++++++++++++++++++++++++++++-
>  5 files changed, 132 insertions(+), 21 deletions(-)

"replay --linearize" behaves differently from the flattening rebase
in a case where X and Y that forked from A are merged at Z, and we
ask to flatten the history leading to Z, doesn't it?

     A----X
      \    \
       Y----Z (tip)

A typical flattening rebase would rewrite X to X', Y to Y', while
dropping Z, and would leave us a flattened history, like

     A---X'---Y' (updated tip, the order of X' and Y' may be swapped)

I may be misreading the logic, but doesn't "replay --linearize"
instead produce

     A----X' (dangling)
      \ 
       Y' (tip -- Z is dropped and gets mapped)

and leave X' dangling (or Y'; the point is that only one of them
will survive), never incorporating it in the resulting history?

> +		if (commit->parents && commit->parents->next) {
> +			if (!opts->linearize)
> +				die(_("replaying merge commits is not supported yet!"));
> +			/*
> +			 * Drop the merge commit: do not pick it, leave
> +			 * `last_commit` unchanged, and fall through to the
> +			 * rest of the loop. As a result:
> +			 * - the merge commit is mapped to `last_commit` in
> +			 *   `replayed_commits`, this will become the parent for
> +			 *   the child commits.
> +			 * - refs previously pointing to the merge commit are
> +			 *   rewritten to point to the previous non-merge commit.
> +			 */
> +		} else {
> +			/*
> +			 * pick_regular_commit() looks up the parent of `commit` in
> +			 * `replayed_commits` to determine the ancestor to replay onto.
> +			 * The `default_base` parameter is used when no ancestor is found,
> +			 * which happens for the first commit in the revision range.
> +			 * When reverting, commits are replayed in reverse order, so the
> +			 * lookup never succeeds, and we need to pass `last_commit`.
> +			 */
> +			struct commit *base = onto;
> +			if (mode == REPLAY_MODE_REVERT)
> +				base = last_commit;
> +
> +			last_commit = pick_regular_commit(revs->repo, commit, base,
> +							  replayed_commits,
> +							  &merge_opt, &result,
> +							  mode, opts->empty);
> +		}
> +
>  		if (!last_commit)
>  			break;

Immediately after this hunk beyond the post-context are these lines.

		/* Record commit -> last_commit mapping */
		put_mapped_commit(replayed_commits, commit, last_commit);

Let's imagine X gets processed first. X (and other commits on its
branch) gets replayed, last_commit is set to X' (which is the
rewritten X).  replayed_commits mapping holds X->X' mapping.

Then let's imagine the history leading to Y is replayed next.
last_commit becomes Y', and Y->Y' mapping is stored in
replayed_commits.

Finally, we see Z.  We are going to _drop_ it.  last_commit is left
unchanged, pointing at Y'.  Then last_commit (i.e., Y') is used as
the merge commit Z maps to (i.e., correctly dropping Z).

Any descendants of Z, if any, will be grafted as descendants of Y'.
If X did not have any descendants other than Z in the rewritten part
of the history, then X' (and commits leading to it) would be lost,
no?

This "loss of the other branch" may be an inherent characteristic of
this feature (i.e., I do not think it is necessarily a bug, and it
may even be that the "bug" is in the way I am reading the patch),
but then I wonder if the user may want to have control over which
side branch should survive, perhaps?  It would probably need to be
documented, and a test or two to cast this behaviour in stone.

> diff --git a/t/t3650-replay-basics.sh b/t/t3650-replay-basics.sh
> index 3353bc4a4d..34c038eab9 100755
> --- a/t/t3650-replay-basics.sh
> +++ b/t/t3650-replay-basics.sh
> @@ -52,8 +52,12 @@ test_expect_success 'setup' '

The pre-context here has

	git switch --detach topic4 &&
	test_commit N &&
	test_commit O &&
	git switch -c topic-with-merge topic4 &&

>  	test_merge P O --no-ff &&
>  	git switch main &&

The above does prepare topic-with-merge branch, but ...

> +test_expect_success 'replay to rebase merge commit with --linearize' '
> +	git replay --ref-action=print --linearize \
> +		--onto main I..topic-with-merge >result &&

... this does not really exersize linearizing replay in a typical
mergy history.  P merges O with --no-ff because otherwise there
won't be a merge, since O is a descendant of the commit "test_merge
P O" runs on (i.e., topic4 == topic-with-merge).

    topic4 --- N --- O
          \           \
           .-----------P

So, as long as O is replayed later than the parent of N (which is
true), O' will be the surviving tip (corresponds to Y' that the
dropped Z was mapped to in the earlier example), and nothing gets
orphaned, I think.

Perhaps a test to try a real merge may look something like this.

diff --git c/t/t3650-replay-basics.sh w/t/t3650-replay-basics.sh
index 34c038eab9..bb737f729a 100755
--- c/t/t3650-replay-basics.sh
+++ w/t/t3650-replay-basics.sh
@@ -647,4 +647,37 @@ test_expect_success 'replay with --linearize to rebase multiple divergent branch
 	test_cmp expect actual
 '
 
+test_expect_success 'replay with --linearize of a divergent merge drops one branch' '
+	git switch -c topic-divergent-base main &&
+	test_commit base &&
+	# Fork 1: base -> X
+	git switch -c topic-divergent-x &&
+	test_commit X &&
+	# Fork 2: base -> Y
+	git switch topic-divergent-base &&
+	git switch -c topic-divergent-y &&
+	test_commit Y &&
+	# Merge them at Z
+	git switch topic-divergent-x &&
+	test_merge Z topic-divergent-y --no-ff &&
+
+	# History is now:
+	#
+	#       X - Z (topic-divergent-x)
+	#      /   /
+	#  base - Y
+	#
+
+	git replay --ref-action=print --linearize \
+		--onto main topic-divergent-base..topic-divergent-x >result &&
+	test_line_count = 1 result &&
+	tip=$(cut -f 3 -d " " result) &&
+	# Get the commits replayed onto main
+	git log --format=%s main..$tip >actual &&
+	# We expect exactly one commit to be replayed (either X or Y)
+	# because the other one is left dangling due to the merge being dropped.
+	test_line_count = 1 actual &&
+	test_grep "^[XY]$" actual
+'
+
 test_done
