Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FABCC43334
	for <git@archiver.kernel.org>; Tue, 28 Jun 2022 16:56:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230063AbiF1Q41 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 28 Jun 2022 12:56:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233800AbiF1Qzx (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Jun 2022 12:55:53 -0400
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A993B86F
        for <git@vger.kernel.org>; Tue, 28 Jun 2022 09:54:39 -0700 (PDT)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id F049A144944;
        Tue, 28 Jun 2022 12:54:36 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=KduPyDFQC8rpZBkDLY39bW2b+MhhspLQ+YI3Et
        hk2n0=; b=wY2k+3syFHeDIZs1UJLQOHkOYI/4KOxt4L5e9aq3+sH8lGRmmIkjn4
        BWVzgaW5yxlxXLDEpK8oCG6zT9d4f1scAmlxZk26srYi/5oXbpLHCElS/xgXjwRr
        +MSNXlyQiNaPMigTm6x5DU+EHV7JKwV2fNaI8m1Y/OeHFk+pFcTfg=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id E57CC144943;
        Tue, 28 Jun 2022 12:54:36 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.82.80.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 4298F144942;
        Tue, 28 Jun 2022 12:54:36 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, me@ttaylorr.com, Johannes.Schindelin@gmx.de,
        Derrick Stolee <derrickstolee@github.com>
Subject: Re: [PATCH] git-rebase.txt: use back-ticks consistently
References: <pull.1270.git.1656364861242.gitgitgadget@gmail.com>
Date:   Tue, 28 Jun 2022 09:54:35 -0700
In-Reply-To: <pull.1270.git.1656364861242.gitgitgadget@gmail.com> (Derrick
        Stolee via GitGitGadget's message of "Mon, 27 Jun 2022 21:21:01
        +0000")
Message-ID: <xmqqmtdwlodw.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: FDE004E4-F702-11EC-80B8-CB998F0A682E-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com> writes:

>     I can see splitting it up in a few ways, but I wanted to check to first
>     see if that was necessary. If it is, then here are the strategies I
>     considered:
>     
>      1. Focus on type of update. This would mean a change for adding
>         back-ticks on all --<option> text, adding back-ticks on all "git
>         rebase" instances, adding back-ticks on things like <upstream>, and
>         doing other types of changes like whitespace updates or "git-rebase"
>         to "git rebase".

Unless each of these steps can be verified mechanically, I do not
think it is worth it.  If I have to choose between reading (1) 700+
line patch just once in the form as-posted, or (2) three 400+ line
patches along the "type/theme", the choice is fairly simple and
obvious.

>      2. Focus on the section of the document. This would limit the diff by
>         the section size, such as OPTIONS or the discussion on the backends.

This could work, but the reviewers can choose where to stop if they
feel that a 700+ line patch is a bit too much to read through in a
single sitting themselves.

>      3. Focus on the edits that most-recently edited these lines. Doing some
>         scripting, I was able to construct this date-sorted list of previous
>         edits (by diffing the git blame output before and after this
>         change). The most-recent changes before this are:
>     
>     2005-08-26: 52a22d1e726 ([PATCH] Subject: [PATCH] Add some documentation., 2005-08-26)
>...
>     2022-04-20: 9e5ebe9668a (rebase: use correct base for --keep-base when a branch is given, 2022-04-20)

That is a new concept ;-) 

It is an interesting exercise to see which previous changes had
these mark-up mistakes, but it is not immediately obvious to me how
we can take advantage of the information.

>     I look forward to feedback on how to do this better (if it is indeed a
>     good idea to do in the first place).

Correcting mark-up to result in an easier-to-read documentation is a
good idea, of course.  I wonder if we can also help the developers
mark-up correctly in their first attempt (e.g. do we have clear and
concise guidelines that are well publicized?)


>  Documentation/git-rebase.txt | 224 +++++++++++++++++------------------
>  1 file changed, 112 insertions(+), 112 deletions(-)

> @@ -348,10 +348,10 @@ See also INCOMPATIBLE OPTIONS below.
>  	Using merging strategies to rebase (default).
>  +
>  Note that a rebase merge works by replaying each commit from the working
> -branch on top of the <upstream> branch.  Because of this, when a merge
> +branch on top of the `<upstream>` branch.  Because of this, when a merge
>  conflict happens, the side reported as 'ours' is the so-far rebased
> -series, starting with <upstream>, and 'theirs' is the working branch.  In
> -other words, the sides are swapped.
> +series, starting with `<upstream>`, and 'theirs' is the working branch.
> +In other words, the sides are swapped.
>  +
>  See also INCOMPATIBLE OPTIONS below.
>  
> @@ -360,9 +360,9 @@ See also INCOMPATIBLE OPTIONS below.
>  	Use the given merge strategy, instead of the default `ort`.
>  	This implies `--merge`.
>  +
> -Because 'git rebase' replays each commit from the working branch
> -on top of the <upstream> branch using the given strategy, using
> -the 'ours' strategy simply empties all patches from the <branch>,
> +Because `git rebase` replays each commit from the working branch
> +on top of the `<upstream>` branch using the given strategy, using
> +the `ours` strategy simply empties all patches from the `<branch>`,
>  which makes little sense.
>  +
>  See also INCOMPATIBLE OPTIONS below.
> ...
>  --strategy-option=<strategy-option>::
>  	Pass the <strategy-option> through to the merge strategy.
>  	This implies `--merge` and, if no strategy has been
> -	specified, `-s ort`.  Note the reversal of 'ours' and
> -	'theirs' as noted above for the `-m` option.
> +	specified, `-s ort`.  Note the reversal of `ours` and
> +	`theirs` as noted above for the `-m` option.

These references to "ours" and "theirs" is what we called out
earlier in the "swapped" description (hunk -348,10), i.e.

	when a merge conflict happens, the side reported as 'ours'
	is the so-far rebased series ... and 'theirs' is the working
	branch.

which the patch left in 'emphasis' not `verbatim`.  I think this
section should do the same.

The 'ours' (but not 'theirs' because there is no such thing) that is
explained as useless as a strategy in the intervening paragraph
(hunk -360,9) refers to the name of a strategy, and it is correct to
mark it as `verbatim`.

>  --ignore-whitespace::
>  	Ignore whitespace differences when trying to reconcile
> -differences. Currently, each backend implements an approximation of
> -this behavior:
> +	differences. Currently, each backend implements an approximation of
> +	this behavior:
>  +
> -apply backend: When applying a patch, ignore changes in whitespace in
> +'apply backend:' When applying a patch, ignore changes in whitespace in
> ...
> -merge backend: Treat lines with only whitespace changes as unchanged
> +'merge backend:' Treat lines with only whitespace changes as unchanged

It somehow looks curious (at the source level---I haven't seen the
formatted HTML output) to have the punctuation colon as part of the
phrase marked up.  I wonder if these were meant to be more like so:

	apply backend;;
		When applying a patch, ...

	merge backend;;
		Treat lines with ...

> @@ -536,8 +536,8 @@ See also REBASING MERGES and INCOMPATIBLE OPTIONS below.
>  
>  -x <cmd>::
>  --exec <cmd>::
> -	Append "exec <cmd>" after each line creating a commit in the
> -	final history. <cmd> will be interpreted as one or more shell
> +	Append `exec <cmd>` after each line creating a commit in the
> +	final history. `<cmd>` will be interpreted as one or more shell
>  	commands. Any command that fails will interrupt the rebase,
>  	with exit code 1.

As noticed by others, "git help -m rebase" is somewhat harmed with
this change when rendered to plain text without any attributes.  The
roff output actually is

    .RS 4
    Append
    \fBexec <cmd>\fR
    after each line creating a commit in the final history\&.

and even on plain text tty, "exec <cmd>" part is now shown in bold
(as opposed to be in plain text inside double quotes, which was how
the original got rendered).  So I think this change is an
improvement.

> @@ -550,7 +550,7 @@ or by giving more than one `--exec`:
>  +
>  	git rebase -i --exec "cmd1" --exec "cmd2" --exec ...
>  +
> -If `--autosquash` is used, "exec" lines will not be appended for
> +If `--autosquash` is used, `exec` lines will not be appended for

Likewise.

Thanks.
