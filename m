Received: from fhigh-b4-smtp.messagingengine.com (fhigh-b4-smtp.messagingengine.com [202.12.124.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F1613EFFB8
	for <git@vger.kernel.org>; Wed, 17 Jun 2026 13:24:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781702648; cv=none; b=G7ehw6JdhAQpTpAgCuzZI+zVmLIcLCkkO8TI4zAHQhUjAfUmN47v0gRdHYx8F7DEMqxBs5dpBsN3oYnIpz0hc6dIqQFWRQErBj74pKMbxzkv9TtAM/Ju4+3t+pndxIBz5K9q+rqGAgOzQ3G35qrPF2VzSIUoImq+F9GktCqoPbQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781702648; c=relaxed/simple;
	bh=bUjo17reYZntrFgnXH2Wfjq5Qw8yYMoKTHgElOkoM9w=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=YBaNz67GUcLauAZNGlALdZfJKd6I25na4r6q8zXyo/GZGULIi+v9wMGjtItV3s6Rs9hiMUJxXtj9HdfpJb027+xyJiAbDw46CJ5VNHncjOceDU1fv3YdMZolSPSB8vfUIFZ86YEGI2SxQjDfYAhFJtHFIrPxBgad8fhWyofUxYk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=CnzfJc+q; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=FPxNb4JU; arc=none smtp.client-ip=202.12.124.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="CnzfJc+q";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="FPxNb4JU"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 87CA47A0110;
	Wed, 17 Jun 2026 09:24:05 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-02.internal (MEProxy); Wed, 17 Jun 2026 09:24:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1781702645;
	 x=1781789045; bh=7CtPmREMDuxWq/y4u9BOWpa16Hu6PzI+kZ/sB0yAaqE=; b=
	CnzfJc+q7k2Nu+5IP93BvTpKscZL/LugUks4Fbl6DQf+4eqZgOtT9kweEXhPQbbt
	5srC7Zjv3S1AOjgmQtdk+IJn+nx8p80ijUOhb8+W288SvJpZkrBrCnK/4+Q7FIvB
	vWwzSfwZVaaCn/73AyklicUqaeuNbGobUpvo2057+8aBeVsgklXlycPjK8t+TD8L
	gdUHt3t9m5hEQYX9OLEZRqdFBRmtNloyn607Sl9/53vie7bNkHJcRUtNvt7a+gur
	j3w0JhASuRFrmbxo2vNRv7jvzS1/AA3LjNZ8PivD6Q1UMPiXJJ+l7iKnhLHqN29v
	9tmQfZ7FmaD2xzpLicbAzQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1781702645; x=
	1781789045; bh=7CtPmREMDuxWq/y4u9BOWpa16Hu6PzI+kZ/sB0yAaqE=; b=F
	PxNb4JUBh/zNK6rkb2Yk7RJq1KTy39uFPbQ52MDhQ/weHeTXxwdClLbR1Vsmlmjz
	Z7HdrbRu3tIv8fhuXPUl0vnBuAJmBM92dNeGybTE4fVqR4kd/Q21AyczfxIG62nZ
	RdVnr0cKjkkqUqhzb0qXquYZ2nZBuGyFviD5RpHSbSlqAq6k3fgaGcsoG/NGCkSH
	skHc4wX/pedzeoGi3lJCajVWIj3W+ne0uC/biMoG1dbSUKp1mRiZ26jXSZ2Cmkt4
	t1a4JhEKD5neBlMm0EhnrU5+8gSuMs8KCNHTxRoIK4DMhFB9KVfleBJGQrwlAmgt
	5BxcsXRfM59RRPoxTRlkQ==
X-ME-Sender: <xms:9Z8yamEAknl62epsvnIZ5rNFNsJMg9YuK7k6paiLNhmN3aJxs7jQ_Q>
    <xme:9Z8yauUPHMpdLOLTUaL8rKnbyXVjbYpHQtpyXs2-ObNCXlpyfhZ3VxmyHYnuGW2gI
    o4zr0fnnfRlzX1EhT-UKyZn2IZuCk_4n6VK1qE6zGVJ-_H0j0SRTw>
X-ME-Received: <xmr:9Z8yalKQQO9lk9KyyFtlV6g08Y_PTLr2UoFib9fzaxSg1CqajNwNL-q2vY795R6CQafmgqz78q2ijWXCZrozYRKcFk-6Cd7Koepn>
X-ME-Proxy-Cause: dmFkZTGc6aLVr93OyPhX+eFAeEY6RL4fFCl0IgOI04uqfsjywLXqwOQHO5VOoa/oL44JYK
    ihFiiy+xaf0jDhHEcdjadOgsdDwW7krWW0RAcLsIwWTl8WDB3Q6Gu4f7oJHctS75TswJMU
    AXpxg/3sBzWEgdKg26OsRmLkwNABlyh7EOwtoxw2Sfn1JfEXp58RnGMiAFoUQihX2126SK
    nmmzQ6ezHTwY/LqTpXu4thos88oORLfYKsM//fKeVemaQM2swwOsw6WF1NbVX32oWa3wAO
    24wdbOmelB+08ceHxAFJ9idnZYNGCTO8SMEx7gl1XeanDk5wbFsWx2RpA+WXNp3UaumKPY
    fSjqlppoMQPGDbGSdCbMP1d1BK6wUWDbIubpYfcu/VgHNs3q+IN6dF7s+EC6ETvIM4qbR2
    0K4z65xStFf8kteDUyFiNKMbtRK929cOrc0QLx+mSLvfXNPRxi5WSd8PIz1j4SBqtRct4l
    sUxLvmobEZJc3iRr8S7ZtfTAZFRcSM2n6yHKWGiUXF/QuEjO5JeGDmDxEv4ize0ImjtMJK
    YlC51l7dj2uahVEHtnbbGNfv2pKa/meC7QHEDOtReyD0fBpTAKPhyqGqX+70F00R3TJ/Qh
    Ii4cI263FVSVt2Qaan8zTQ2IV/Xmuq6ESEGeR+Xc8SMIvHyFuocmeowDWdCw
X-ME-Proxy: <xmx:9Z8yau8s3-AmfzR3lVrip2SCvN7E5hXf14XGw9e96YAooHYnRgqMeA>
    <xmx:9Z8yaoIR-pzUs6VPcwwYeSdMmJRmqaovohWnPNEsYJ8ynWMSVMoG5w>
    <xmx:9Z8yajmOorA35SYhSATt2oW5Z3_hHPINfeKVh-vu_L830yL10Fgyhg>
    <xmx:9Z8yasPXdFMFpaWJJspfqUX3FEBTF4diLTXt29SmJcdM7tguRaWsBw>
    <xmx:9Z8yaohf3baHwgShOQdd8k66VUxQNi-xQrNotycJ-X04A21DfxFHC_Y_>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 17 Jun 2026 09:24:04 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
Cc: git@vger.kernel.org,  Phillip Wood <phillip.wood123@gmail.com>
Subject: Re: [PATCH] sequencer: Skip copying notes for commits that
 disappear during rebase
In-Reply-To: <20260616174012.601651-2-u.kleine-koenig@baylibre.com> ("Uwe
	=?utf-8?Q?Kleine-K=C3=B6nig=22's?= message of "Tue, 16 Jun 2026 19:40:12
 +0200")
References: <20260616174012.601651-2-u.kleine-koenig@baylibre.com>
Date: Wed, 17 Jun 2026 06:24:03 -0700
Message-ID: <xmqqzf0txpu4.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

Uwe Kleine-König <u.kleine-koenig@baylibre.com> writes:

> Note that Phillip also suggested to integrete the test into
> t3400-rebase.sh . IMHO it doesn't matter much if this is considered a
> rebase test or a notes test. I kept it where I have it because I'm lazy
> and failed to understand the git history created in that test.

I do not think his suggestion was about "is this rebase or notes?"
at all.  It was a lot more about "let's not add a new test script
that does only one thing, when there is already a script that covers
the same command and the same option for the command".  In fact,
around 3400.28 there are test pieces that rebases commits that have
notes.

>  sequencer.c             | 20 ++++++++++----------
>  t/meson.build           |  1 +
>  t/t3322-notes-rebase.sh | 37 +++++++++++++++++++++++++++++++++++++
>  3 files changed, 48 insertions(+), 10 deletions(-)
>  create mode 100755 t/t3322-notes-rebase.sh

We need some documentation updates to describe that the users can
lose notes by doing a rebase and under what condition, no?

It is not yet clear to me if we want to _always_ discard a note from
a commit that would become "empty" during a rebase session (in other
words, a commit that becomes empty during a rebase is _always_ a
sign that the change it brings in is _already_ in the new base of
the rebase and the necessary information the note wanted to carry to
the target branch is there without need to _duplicate_ it by copying
the note).  But assuming that we want the behaviour, the code change
to sequencer.c looks very reasonable to me, except for one thing that
I am not clear about.

> diff --git a/sequencer.c b/sequencer.c
> index 57855b0066ac..da2185a37c5d 100644
> --- a/sequencer.c
> +++ b/sequencer.c
> ...
> @@ -4965,7 +4965,7 @@ static int pick_one_commit(struct repository *r,
>  		return error_with_patch(r, commit,
>  					arg, item->arg_len, opts, res, !res);
>  	}
> -	if (is_rebase_i(opts) && !res)
> +	if (is_rebase_i(opts) && !res && !dropped_commit)
>  		record_in_rewritten(&item->commit->object.oid,
>  				    peek_command(todo_list, 1));

If we have a sequence of commits where a commit that was *not*
dropped is followed by a fixup commit that *is* dropped (e.g.,
because it became empty/redundant), wouldn't it prevent the
previously pending commit from being flushed to skip
`record_in_rewritten` entirely for the dropped fixup commit?

For example, if we have

    pick X (with note)
    fixup B (dropped because it is redundant)
    pick C

1. `pick X`: calls `record_in_rewritten(X, TODO_FIXUP)`. `X` is
   written to `pending`, but not flushed because the next insn is
   `TODO_FIXUP` (B).

2. `fixup B`: gets dropped. `dropped_commit` is 1 in the code above,
   so `record_in_rewritten` is skipped.

3. `pick C`: calls `record_in_rewritten(C, -1)`. `C` is written to
   `pending`. Since next insn is not a fixup, it flushes `pending`
   (which contains both `X` and `C`) to the commit created for `C`.

Wouldn't it map the note for `X` to rewritten `C`?

> diff --git a/t/t3322-notes-rebase.sh b/t/t3322-notes-rebase.sh
> new file mode 100755
> index 000000000000..0eddde7f9961
> --- /dev/null
> +++ b/t/t3322-notes-rebase.sh
> @@ -0,0 +1,37 @@
> +#!/bin/sh
> +
> +test_description='Test notes on rebase'
> +
> +. ./test-lib.sh
> +
> +test_expect_success setup '
> +	git init &&
> +	git config notes.rewriteRef refs/notes/commits &&
> +	git version > version &&
> +	echo A > A &&

Style.  In our codebase, redirection operator sticks to the
redirection target without SP in between, i.e.

	git version >version &&
	echo A >A &&

> +	git notes add -m "This is B" @ &&

'@' is hard to read; when you refer to HEAD, please write HEAD.


> +test_expect_success 'rebase B + C on top of BD' '
> +	git rebase @ master
> +'
> +
> +test_expect_success 'assert there is no note on BD' '
> +	if git notes list branch >/tmp/lalaa; then return 1; fi
> +'

Do not step outside of $TRASH_DIRECTORY without a good reason.

Style.  In our codebase, shell scripts do not use ';' and written
more like

	if git notes list branch >notes-list
	then
		return 1
	fi

But more importantly, if you want to make sure the command makes a
controlled exit (not crash), use

	test_must_fail git notes list branch

That will pass the test happily if "git notes list branch" makes a
controlled die() call (e.g., when there is no notes attached to that
commit, the command exits with 1), but still makes the test fail if
"git notes list branch" segfaults.

Again, we do not want to add a new test script that does only one
thing, when there is already a script that covers the same command
and the same option for the command.

Thanks.
