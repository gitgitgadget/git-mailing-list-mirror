Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 24B011F461
	for <e@80x24.org>; Mon, 26 Aug 2019 17:08:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732879AbfHZRIs (ORCPT <rfc822;e@80x24.org>);
        Mon, 26 Aug 2019 13:08:48 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:59046 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732817AbfHZRIs (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Aug 2019 13:08:48 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 133AF161690;
        Mon, 26 Aug 2019 13:08:46 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=VeKpITx6oYJjzF7Aza6mPkyKInQ=; b=kG8fD1
        dzrUclpN7yYghKpbsgVVcXjdfU+GGUudNeTL6sJLAnQVCmbVb+9RJKiTeQmnzKmf
        oyzGjE0Z59giZAtaGlnbSTsTxs1qI5/qcKBfP1ylAtcV1HwAC+ElAfydPzWnnU0d
        n3PEkKfda63Ln1rqIYc+ynIgTbua6bVaBbIlg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=azZiXAj21FCdbB/KQ+m/u1n7hsZRnyxt
        8j3vMOnIMHsYLH41u5brcFbqjsOUcwGtSoV9JhSQMpGMdOFzYAKj/URVO3o836Qi
        szsu8RiEwM9tzfjzlL4XheHw/lNeVLFWZctVFN5utcnU8RrwOFjyqPedr94HuzIu
        2HVjZ8onM5k=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 089DC16168F;
        Mon, 26 Aug 2019 13:08:46 -0400 (EDT)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 636E816168E;
        Mon, 26 Aug 2019 13:08:45 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 0/3] Handle worktrees at the top of a network drive
References: <pull.141.git.gitgitgadget@gmail.com>
Date:   Mon, 26 Aug 2019 10:08:44 -0700
In-Reply-To: <pull.141.git.gitgitgadget@gmail.com> (Johannes Schindelin via
        GitGitGadget's message of "Sat, 24 Aug 2019 15:10:44 -0700 (PDT)")
Message-ID: <xmqq36hnj1lv.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 29A00EC8-C824-11E9-9F4E-46F8B7964D18-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
writes:

> Windows' network drive concept is a quite useful and versatile one. Once
> authenticated, one can even change the working directory to a network drive
> (cd \\server\share, works in PowerShell and Git Bash).
>
> Some users want to have their Git repositories there, and with these
> patches, that works, even.

OK.  I see too many 'even' (iow, if it walks and quacks like any
other directory, it should be able to house a Git repository, so to
me it does not even deserve 'it even works'), but that's probably
just me.

Queued.  Thanks.

> This is yet another patch series in the seemingly endless stream of Git for
> Windows patches.
>
> Johannes Schindelin (3):
>   setup_git_directory(): handle UNC paths correctly
>   Fix .git/ discovery at the root of UNC shares
>   setup_git_directory(): handle UNC root paths correctly
>
>  setup.c | 10 ++++++++--
>  1 file changed, 8 insertions(+), 2 deletions(-)
>
>
> base-commit: 8104ec994ea3849a968b4667d072fedd1e688642
> Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-141%2Fdscho%2Fgitdir-at-unc-root-v1
> Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-141/dscho/gitdir-at-unc-root-v1
> Pull-Request: https://github.com/gitgitgadget/git/pull/141
