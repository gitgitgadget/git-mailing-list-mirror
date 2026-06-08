Received: from fout-a3-smtp.messagingengine.com (fout-a3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2606637B40B
	for <git@vger.kernel.org>; Mon,  8 Jun 2026 12:16:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780920998; cv=none; b=dz2BQkgnWWyA6+vCaNVfPGTljGb9pfyJ+mTfzjUFH7kW1RP4tKTAvvD918ja5hq0BxQn+2nnUOie58tTQlFdHEI/Wmy/T4ZHZYz29Qx+Qa50G8BBV5hmRadx1s/Oqh/+XBHoGvUteKMyq8Y4xJdR3Z7NuImiCTqhzSUk1E7Jvz4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780920998; c=relaxed/simple;
	bh=s52wvOeFkikSt+kiNF29cGEgpWIVOWGydLoZNOWI5kQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ttvV1OXEN7gxX9vyGH7s8TPHFY4OQRWeqh5Gf0uxLFLg/IZ3ApvZMadxavup76F+KbJE02cx/3DrCEEZ2u3OF/uez/LwdIvKAA8ErxnRfY8px32iDjXyvGzNynPCksVxd6AoBI4Kls2GULNcFQ2rhDw4+2Yz00OxDYp72UJyaUw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=mM9QlwlK; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=iclQnEi8; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="mM9QlwlK";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="iclQnEi8"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.phl.internal (Postfix) with ESMTP id 733A9EC021B;
	Mon,  8 Jun 2026 08:16:36 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-04.internal (MEProxy); Mon, 08 Jun 2026 08:16:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1780920996; x=1781007396; bh=v6xpweKc/e
	w262GIzaOZRaS8IJ1/y1p/+8Cdpq6Ntkk=; b=mM9QlwlKLZ49PRz4WYV4SINCvK
	llEuvdfn8OYWhe8Ge1QSRSNTHL9L1TXmqwT+5gWZ6cOn3upR/Kdq8ca2gGwR1kyW
	KSze3KHmmjNyS0IrJOy043LmoszHJ/XiUMjzQvMAK6v+0faCxwfZUky+m3QrXa6v
	uPu0tszWkG1CzfmsoiZCaCAPeABi4JMwF+UHb8KBkwP7NiNA/JvIZPtBA5czULWB
	7IQpr1ovkW8E0sEf/dCYPY6prCvjkQMZ6Jye270xfn/wMV2Boc7PaABLleeyyPXX
	PeULcJFM7ysihKbM4cGJqPxf0AKbuApnPdFCoco8Bkw/z04UufpUJhhZXJxg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1780920996; x=1781007396; bh=v6xpweKc/ew262GIzaOZRaS8IJ1/y1p/+8C
	dpq6Ntkk=; b=iclQnEi8lv6xOUZV8GQDPkoEpFH5gR/CG2aW1y9hSMMEr/b1rjZ
	ctCHg1HeItheIfi2lwvV5w/qOkxU++p8DWyihJseBDkABNv3AcJLMwddO+3uQZkY
	unmvrcbZwQx9IS+6Qebmm0mW7u8CLKEDHVJUaWI8mKo6kLbc7oq9wve2gTA1IRqt
	p7HXKRNTboMenJ0lyZlsNHJux5HYXTeYTqnMCWigrOkZ+EKSgDI12AgHRCCwAcR6
	3vHsSBUdaWLxDAsL0scGj+vHBw225neDmS0UYRS3WNgwXtx9jd6Oi3j2kBhogCQU
	Gx6t/0/ISI4lbFjsjpMUpfply/R7y7i9bFw==
X-ME-Sender: <xms:pLImaoxuSHoz6zUFDJ5iFyRiYRf0atJ8_7Zr-UU_Kz86mOBvxMj_cA>
    <xme:pLImajLAZZCT7wBfyHhSVG4nUF9b44nWCbTjTgKZPlLfTC3vIMv5M2yWGiZVdHW3b
    ILHKMUBWF7X_9L6UwB3TwFNeTZtiredQR9SNpntUv13hUwhQgcmPg>
X-ME-Received: <xmr:pLImaipUKhNoplvpcVIS-NeTb3WjVgU_ukT9zQ6aRk0SIJbW5IoF9MqKdyEvAScqA1a4QU9EoLQyXINze8HEu9CylyhfFUZrK3FB>
X-ME-Proxy-Cause: dmFkZTETtZqumtu51J9qQh5+/F3QLsgt4N7BSEKSO1Ta7a+LROkDtwmvMD945dSMI+IN2D
    V0P7NVrItwh0i985aV0V7I8E85LsLzDtC1syV05BOn8j4MlC8dz99iXnn85q6+8G1HSL6S
    6sjCd7V7a5JvcfI8YN50PLob1hAm4NwPIZ6lAnsbvH3iZcvqNklHmgbLiPhHSEMF/WN/EU
    EUfNL6DP1BEa26bUm+bP3qbBqVdBu/wLm9Vqw6wOX0RG+5+tbxYQ3fzJIWZhV9FF4Z7+Ef
    gH/5loizmn9tM60p3Wit3PKMfk2svsZXQuGvujjGqkdHZQnzy71OmVCcNQtiPnBPyXpknX
    dEsW352kynAtZ3n7yBEIJbBL2klk9lOi/6fg3E9T5T7Vh/yP1R4j9/QQS83c+4M3yAjYys
    1XOeAyUNJH915Cv/yrlJyjymitbX4XypNvM9OGQyXm3+xeOQBJW4ROSK9zGo+4wRsamkvj
    oBNkUCRkX9Aqf+0w9GU4tcPTQ85fYQTm/H7iF/MU+Q2e0oSZRVZSd2ivF3/Covp0i6fGJK
    10h8dsMUgZdGE4nzfj+O7osQqWIHxJKjYFQNA47Ybhi1PBLqzPxhVY6g/9bq9YmYwHNaYY
    miAktEgKH4K7vSKa52dymIHh60WRtAB8nzvS23HbWytj749lLPDvNr9acy5g
X-ME-Proxy: <xmx:pLImaiK8_Lg_bcSrdd53ONAoNT2tcrJ13bF3WsgEHgMm8adRMlupiQ>
    <xmx:pLImanRjEPUSLmyoRwIaYrtKxevnJO8VSvnRsU8d4Cm9n7vGLXPA4w>
    <xmx:pLImahvqQFzJp7c6mTEzTJ4I_btLb-xkonZ4k6zBIwQJEnaMY8f_nQ>
    <xmx:pLImaoY3FSvttvubALJdNPplt5lr_Wdbx14z5C4NJjXn0dEt0I8mpw>
    <xmx:pLImatbccHNdNrowX4AxntGvGa0MkS2IElxHs90PSdcVauu336axtB7w>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 8 Jun 2026 08:16:36 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Pablo Sabater <pabloosabaterr@gmail.com>
Cc: git@vger.kernel.org,  Patrick Steinhardt <ps@pks.im>,  Kaartic Sivaraam
 <kaartic.sivaraam@gmail.com>
Subject: Re: [PATCH RFC 1/2] builtin/history: abort reword on unchanged message
In-Reply-To: <20260607-ps-history-reword-v1-1-ba43a3cbb81b@gmail.com> (Pablo
	Sabater's message of "Sun, 07 Jun 2026 22:07:20 +0200")
References: <20260607-ps-history-reword-v1-0-ba43a3cbb81b@gmail.com>
	<20260607-ps-history-reword-v1-1-ba43a3cbb81b@gmail.com>
Date: Mon, 08 Jun 2026 05:16:35 -0700
Message-ID: <xmqqmrx5z0po.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Pablo Sabater <pabloosabaterr@gmail.com> writes:

> When using `git history reword` if the new message is the same as the
> original it continues anyway creating a new commit with the same
> message and updates its descendants, modifying the history after this
> 'reworded' commit even though there was no actual change.
>
> `git commit --amend` and `git rebase -i` + reword share this behavior,
> however `git history reword` is different:
> 1. Works in-memory without touching the index or the worktree [1], so
>    there are no side effects like staged files that could justify
>    rewriting the history when the commit message is the same.
> 2. `git history` by default updates all the branches [2] that contain the
>    original commit making it more costly than `git rebase -i` that only
>    updates the current branch.

I think the reasoning is flawed.

Both "git commit --amend" and "git rebase -i", even with no changes
to the tree, parents, or the message, update the committer timestamp
(and perhaps the committer identity running the command may be
different from the original).  Updating this info is one of the
important effects of the command.

And "history" being more capable than "rebase" is a wrong excuse to
make the system behave inconsistently between commands that have
similar features [*1*].  In a situation where letting 'history'
update all the relevant branches, if a command behaves differently
from the way the user likes (and if the way 'rebase -i' works is the
one the user likes), you'd end up forcing the user to use 'rebase
-i' when 'history' would have been more appropriate.

Having said that, I personally think that the current behaviour of
`commit --amend` and `history reword` are both _wrong_ [*2*].

You may start `git commit --amend`, and after staring at the
existing commit log message for some time in your editor, it is
quite natural for you to decide that leaving the commit as-is is the
right thing [*3*] in your situation.  It may have been a better
design for the system to notice this situation and leave the commit
as-is, with an override option `--force` to allow users to forcibly
update the committer ident and timestamp in the commit header.  I am
not a `history reword` user (yet), but from the motivation you
described for this patch, I sense that the story is the same there.

`git rebase -i A`, when A is truly an ancestor at the bottom of a
linear history leading to HEAD, behaves slightly better.  It gives
you a todo list with a bunch of `pick` insns, and when you do not
edit earliest 'pick's the todo list, these earliest commits are left
as-is.  It may still share the same issue that a 'reword' that you
ended up not rewording (or 'edit' that you ended up not touching its
tree or log message) does still recreate a new commit object, though.

`git rebase -i` may have an excuse that because it, unlike "git
commit --amend", operates on multiple commits by design.  A single
"--force" option given to the command would not have worked as an
escape hatch to allow the user to tell the command "in this reword
of this particular commit, I ended up doing nothing, but I still
want an updated committer log timestamp".  Perhaps giving the
"--force" (or --force-rewrite") option at "rebase --continue" time
may work, but in any case, unless we plan to transition to these
"better" default behaviour at a big version boundary, speculating
what a "better" behaviour would have been may be fun but not very
productive.


[Footnote]

 *1* Besides, doesn't "--update-refs" in "rebase -i" allow you to
     adjust the branches?

 *2* But it is an established behaviour people _rely_ on, so even
     though it may have been better if these commands behaved
     differently, it probably is a bit too late to change it now.

 *3* This includes the case where the original author is especially
     difficult to work with and would complain any change to their
     commits, even if the only change you made for them is a
     typofix.  Fixing a small typo/grammo may not be worth your time
     and unpleasant exchanges with them after touching their commit.
