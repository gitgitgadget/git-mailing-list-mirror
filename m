Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D31C3C433EF
	for <git@archiver.kernel.org>; Sun, 20 Feb 2022 20:42:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244972AbiBTUmg (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 20 Feb 2022 15:42:36 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:40520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240942AbiBTUme (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 20 Feb 2022 15:42:34 -0500
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA1952B197
        for <git@vger.kernel.org>; Sun, 20 Feb 2022 12:42:12 -0800 (PST)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 0D7BA103A25;
        Sun, 20 Feb 2022 15:42:12 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=0azzH7gwcigSGtDvavkHqzKeQzAoe4Eeq1g8+d
        g/VqY=; b=LDIhcm0aUWPvG7qyR84vMBCHvi/6IgdMqEJUFedosx9iv95dUTxuKr
        jOJS3M4+6R4iC83lOaPYtFucmkTize54VArlmBYl3q01+iabVOxz7dmbC3YarvQN
        mh1c8MK4fPfJdddNiBmxOqu2PBdakCwS+5q0nErqFY7EquN93Xx8k=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 03D1B103A24;
        Sun, 20 Feb 2022 15:42:12 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.82.80.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 63346103A23;
        Sun, 20 Feb 2022 15:42:11 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>,
        Elijah Newren <newren@gmail.com>,
        =?utf-8?Q?Jean-No=C3=ABl?= AVILA <avila.jn@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>
Subject: Re: [PATCH 05/11] worktree: use 'worktree' over 'working tree'
References: <pull.1154.git.1645379667.gitgitgadget@gmail.com>
        <a6a8eb8e7bb4520bfe37d3a79329cce7886af59c.1645379667.git.gitgitgadget@gmail.com>
Date:   Sun, 20 Feb 2022 12:42:10 -0800
In-Reply-To: <a6a8eb8e7bb4520bfe37d3a79329cce7886af59c.1645379667.git.gitgitgadget@gmail.com>
        (Derrick Stolee via GitGitGadget's message of "Sun, 20 Feb 2022
        17:54:21 +0000")
Message-ID: <xmqq7d9puv6l.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 94178C3C-928D-11EC-93C1-5E84C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Derrick Stolee <derrickstolee@github.com>
>
> It is helpful to distinguish between a 'working tree' and a 'worktree'.
> A worktree contains a working tree plus additional metadata. This
> metadata includes per-worktree refs and worktree-specific config.
>
> This is the first of multiple changes to git-worktree.txt, restricted to
> the DESCRIPTION section.

Looked almost perfect, except for one and a half iffy parts.

> -If a working tree is deleted without using `git worktree remove`, then
> ...
> +If a worktree is deleted without using `git worktree remove`, then
>  its associated administrative files, which reside in the repository
>  (see "DETAILS" below), will eventually be removed automatically (see

I think this one should be "working tree".  The administrative files
are integral part of a worktree, but from the point of view of a
working tree, it is "associated" with it and not part of it.  If you
delete without using "git worktree remove", that would be done with
a command like "rm -f", which removes the working tree but not the
worktree.

> -If a linked working tree is stored on a portable device or network share
> -which is not always mounted, you can prevent its administrative files from
> -being pruned by issuing the `git worktree lock` command, optionally
> -specifying `--reason` to explain why the working tree is locked.
> +If a linked worktree is stored on a portable device or network share which
> +is not always mounted, you can prevent its administrative files from being
> +pruned by issuing the `git worktree lock` command, optionally specifying
> +`--reason` to explain why the worktree is locked.

This one, because what is on a removal device is the working tree
half of a worktree that leaves the "administrative files" half still
on the mothership when it is removed, I think it is OK to call it a
working tree, but because we defined "a linked worktree" and removed
the definition of "a linked working tree" earlier, the original as-is
won't work well.

"If the working tree portion of a linked worktree is stored on ..."
may be more correct, but it is a bit mouthful.  I dunno (hence this
is not even a full "iffy" part, just halfway iffy).

>  add <path> [<commit-ish>]::
>  
> -Create `<path>` and checkout `<commit-ish>` into it. The new working directory
> -is linked to the current repository, sharing everything except working
> -directory specific files such as `HEAD`, `index`, etc. As a convenience,
> -`<commit-ish>` may be a bare "`-`", which is synonymous with `@{-1}`.
> +Create `<path>` and checkout `<commit-ish>` into it. The new worktree
> +is linked to the current repository, sharing everything except per-worktree
> +files such as `HEAD`, `index`, etc. As a convenience, `<commit-ish>` may
> +be a bare "`-`", which is synonymous with `@{-1}`.

The original has the problem, too, but it is unclear what is created
at <path> by reading only the first sentence, even though the
mention of "The new worktree" that immediately follows strongly
hints that we are creating a worktree.

    Create a new worktree at <path> and ...

perhaps?  This clarification is not even part of one and a half ;-)
