Return-Path: <SRS0=4+BP=3K=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BC08C2D0CE
	for <git@archiver.kernel.org>; Tue, 21 Jan 2020 20:21:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 52FD524656
	for <git@archiver.kernel.org>; Tue, 21 Jan 2020 20:21:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="avSYtPTY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729080AbgAUUVU (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 21 Jan 2020 15:21:20 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:53668 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727383AbgAUUVU (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Jan 2020 15:21:20 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id DD3DAA2F61;
        Tue, 21 Jan 2020 15:21:17 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=JvOBMF4t+ulaQhEUKCN3nz9NPwo=; b=avSYtP
        TYZYvJGYNcu4/3NquBAHpDTkkoUrhCJR2PBnzW6j/WSiLZrSV501B0tQp77u2pI+
        kkM1Kx8q3tprVxKEAVvYNSP9kf7FBLwvF6X4BoGYyr+ny4q4GsMDSRarm7l6dpV6
        hfmrmNO2Fr+Kz6GZO5DIlhJLGFUXYuGRlru9w=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=ruqmbnl8iRr+I3JzcNV7t3t8D0ldHA13
        l1zAvQwCi3+kiCJIpU0RZveC9Pc/6ZAnRMpixwJW9pJ3Yj8N1Ro1vgTOrZD+9Yja
        3uitEXICKdU5DI7EcEZi0lfNNxjSwF3mWbyYUCqaSCZs1KbTaGZ/rpTnU7ewswUD
        8d+/eQ4EIVA=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id D5269A2F5F;
        Tue, 21 Jan 2020 15:21:17 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 012CCA2F5E;
        Tue, 21 Jan 2020 15:21:14 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Alexandr Miloslavskiy via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        Paul-Sebastian Ungureanu <ungureanupaulsebastian@gmail.com>,
        Alexandr Miloslavskiy <alexandr.miloslavskiy@syntevo.com>
Subject: Re: [PATCH 4/8] doc: stash: split options from description (2)
References: <pull.530.git.1579190965.gitgitgadget@gmail.com>
        <708363241f4940e5b627af8519345b762deb77ab.1579190965.git.gitgitgadget@gmail.com>
Date:   Tue, 21 Jan 2020 12:21:12 -0800
In-Reply-To: <708363241f4940e5b627af8519345b762deb77ab.1579190965.git.gitgitgadget@gmail.com>
        (Alexandr Miloslavskiy via GitGitGadget's message of "Thu, 16 Jan 2020
        16:09:21 +0000")
Message-ID: <xmqqblqwa7d3.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 92DB81B6-3C8B-11EA-9E8F-8D86F504CC47-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> diff --git a/Documentation/git-stash.txt b/Documentation/git-stash.txt
> index 2dedc21997..f75b80a720 100644
> --- a/Documentation/git-stash.txt
> +++ b/Documentation/git-stash.txt
> @@ -43,9 +43,6 @@ created stash, `stash@{1}` is the one before it, `stash@{2.hours.ago}`
>  is also possible). Stashes may also be referenced by specifying just the
>  stash index (e.g. the integer `n` is equivalent to `stash@{n}`).
>  
> -OPTIONS
> --------
> -
>  push [-p|--patch] [-k|--[no-]keep-index] [-u|--include-untracked] [-a|--all] [-q|--quiet] [-m|--message <message>] [--] [<pathspec>...]::
>  
>  	Save your local modifications to a new 'stash entry' and roll them
> @@ -152,40 +149,51 @@ store::
>  	reflog.  This is intended to be useful for scripts.  It is
>  	probably not the command you want to use; see "push" above.
>  
> -If the `--all` option is used instead then the
> -ignored files are stashed and cleaned in addition to the untracked files.
> -
> -If the `--include-untracked` option is used, all untracked files are also
> -stashed and then cleaned up with `git clean`, leaving the working directory
> -in a very clean state.
> -
> -If the `--index` option is used, then tries to reinstate not only the working
> -tree's changes, but also the index's ones. However, this can fail, when you
> -have conflicts (which are stored in the index, where you therefore can no
> -longer apply the changes as they were originally).
> -
> -If the `--keep-index` option is used, all changes already added to the
> -index are left intact.
> -
> -With `--patch`, you can interactively select hunks from the diff
> -between HEAD and the working tree to be stashed.  The stash entry is
> -constructed such that its index state is the same as the index state
> -of your repository, and its worktree contains only the changes you
> -selected interactively.  The selected changes are then rolled back
> -from your worktree. See the ``Interactive Mode'' section of
> -linkgit:git-add[1] to learn how to operate the `--patch` mode.
> +OPTIONS
> +-------
> +-a::
> +--all::
> +	All ignored and untracked files are also stashed and then cleaned
> +	up with `git clean`.
> +
> +-u::
> +--include-untracked::
> +	All untracked files are also stashed and then cleaned up with
> +	`git clean`.
> +
> +--index::
> +	Tries to reinstate not only the working tree's changes, but also
> +	the index's ones. However, this can fail, when you have conflicts
> +	(which are stored in the index, where you therefore can no longer
> +	apply the changes as they were originally).
> +
> +-k::
> +--keep-index::
> +--no-keep-index::
> +	All changes already added to the index are left intact.
> +
> +-p::
> +--patch::
> +	Interactively select hunks from the diff between HEAD and the
> +	working tree to be stashed.  The stash entry is constructed such
> +	that its index state is the same as the index state of your
> +	repository, and its worktree contains only the changes you selected
> +	interactively.  The selected changes are then rolled back from your
> +	worktree. See the ``Interactive Mode'' section of linkgit:git-add[1]
> +	to learn how to operate the `--patch` mode.

I have a mixed feelings about this approach.  While I am sympathetic
to the "have a single place to describe all" approach this patch
takes, the approach needs to be executed with care when subcommands
do not share much of the options at all.  Those readers who jump to
the "OPTIONS" section and try to ignore anything outside the section
may not easily notice that --keep-index only applies to subcommands
that creates a new stash, and meaningless to subcommands that lets
you inspect existing stashes, or apply one to the working tree (and
optionally to the index), for example.  If the orinal documentation
did not use "OPTIONS" as the section header and instead said perhaps
"SUBCOMMANDS", it would have been even better, but otherwise I would
suspect that the original "the options understood by 'push' are all
described under the part that begins with 'push [-p] [-k] ...'
command line" arrangement was much easier to understand when reading
them through for the first time to learn and also to find what the
user is looking for after learning the "concept" (e.g. "with
'stash', there is a way to stash-away the changes made to the
working tree") but before becoming familiar with exact set of
options for each subcommand (e.g. "and there was an option that let
me stash only partial changes piecemeal, but what was it spelled?").

If we were to make the result of "a single place to describe all"
approach anything useful, I think at least

 (1) the list itself should make it clear that it does not talk
     about options related to listing and showing at all,
     before enumerating dashed options.

 (2) each item in the enumeration should identify which
     subcommand(s) accept(s) it.

So, I dunno.



