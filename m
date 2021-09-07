Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 712F6C433EF
	for <git@archiver.kernel.org>; Tue,  7 Sep 2021 06:24:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5031E610FE
	for <git@archiver.kernel.org>; Tue,  7 Sep 2021 06:24:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232111AbhIGGZ6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 7 Sep 2021 02:25:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230342AbhIGGZ5 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Sep 2021 02:25:57 -0400
Received: from mail-oi1-x22a.google.com (mail-oi1-x22a.google.com [IPv6:2607:f8b0:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A932EC061575
        for <git@vger.kernel.org>; Mon,  6 Sep 2021 23:24:51 -0700 (PDT)
Received: by mail-oi1-x22a.google.com with SMTP id w144so11469864oie.13
        for <git@vger.kernel.org>; Mon, 06 Sep 2021 23:24:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zvQcfVxIrklO0s0bp8KGzIbwLJNGAkBkTSF/5WVnwbM=;
        b=hKWIcmheBGwnHiwxljCMUxM7xUhfu8eXoSe2uQrm8YXnrLrZwL7GjGPuJd6QEr3QBe
         FC9Y8Ju9Dr7Furuw+cREfLdtVmB1N2uDZDF3T+O8RQSE2LRhEp4j9Rmp+/EJNFJlMyzX
         08QOW78QcSCXbXSmbXeqJhpWx7XeVW0tUpuG79/x80PJ3KcqE9lOwd1QOfAs6ToCFBA1
         kyMc0iNfv4nHxUKPnWIJeEBok836/LK5KX3Px0Rns3ff6ezhOYP8cZWrmfpXnDWXOGMx
         pSbmNpRVos0GJaPgIDgCKLYyubT/igyiv5MZPpSwwBpE761ba0VdBbI+eXe5tdMuQMSD
         A4xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zvQcfVxIrklO0s0bp8KGzIbwLJNGAkBkTSF/5WVnwbM=;
        b=bIV4K8kak+0WWHmtb35RtMxr0EgpaB7HlltBRte3c6dH+MgvxQH0V2ARJKCZZjc1ds
         SbvAXZ7wNYAfGWEGfs0DWPE+rRJEYjGOzxgiBrReFuue5qVXmtAzp7PZVsvcbSlFX5ER
         VmPSKhykDo9sV7cFVnxZ8L1swzkKytH6FdVJRmuWYgDy2GejAVJCRnYdiAHZW8Lv+xuO
         Dgk44eI/xSxYql9OzHIlMCSYePkYP0f9Ymh9CeXvzPdSTmuqGE2wHLkD+P2wZgNAoe/u
         iRmb2eYL3qBQJ+celMc2pjN7xAADcmr+x9FFNZPz6E0QxjuG3qNsXtl/nA6pkQbEckt5
         +epg==
X-Gm-Message-State: AOAM533CGpOh7p6t0QA8HYLZeiacF4DhqVqg7HXdKq45igWOfmodkfsf
        +NcIT4OgChQLAcyR9Jm8h/pbHIwFC0h1hoFrT5o=
X-Google-Smtp-Source: ABdhPJyvBvGCyFhWyFf1ZbhDDZaeD0ShvoMgnMGge/Jm+whzDmybEBoMKdWcs9Qi0cv3WSoDJ7Sd6qEOnanftqUOoP0=
X-Received: by 2002:a05:6808:2084:: with SMTP id s4mr1849337oiw.31.1630995890977;
 Mon, 06 Sep 2021 23:24:50 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1022.v4.git.1630902006.gitgitgadget@gmail.com> <pull.1022.v5.git.1630903140.gitgitgadget@gmail.com>
In-Reply-To: <pull.1022.v5.git.1630903140.gitgitgadget@gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Mon, 6 Sep 2021 23:24:39 -0700
Message-ID: <CABPp-BG_8DrqtvHrPxkqVEJtj5RHGu_Nv9+i=aFLPUfiq_6kzw@mail.gmail.com>
Subject: Re: [PATCH v5 0/3] test-lib-functions.sh: keep user's HOME, TERM and
 SHELL for 'test_pause' and 'debug'
To:     Philippe Blain via GitGitGadget <gitgitgadget@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jens Lehmann <Jens.Lehmann@web.de>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Taylor Blau <me@ttaylorr.com>,
        Carlo Arenas <carenas@gmail.com>, Jeff King <peff@peff.net>,
        Philippe Blain <levraiphilippeblain@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Sep 5, 2021 at 9:39 PM Philippe Blain via GitGitGadget
<gitgitgadget@gmail.com> wrote:
>
> Changes since v4:
>
>  * 3/3: use a for loop instead of while loop + heredoc, it's simpler and the
>    need for the later did not match the code.
>
> v4:
>
>  * 2/3: improved the wording for the warning and caution as suggested by
>    Elijah,, and moved the warning so it relates to the use of test_pause
>    itself, not just the new flags, as suggested by Junio. Adapted the commit
>    messages accordingly.
>  * 3/3: changed the approach: instead of changing HOME, just copy ~/.gdbinit
>    and ~/.lldbinit to the test HOME, as suggested by Carlo. This seems safer
>    as this way $USER_HOME/.gitconfig does not interfere with the behaviour
>    of the command being debugged (as Junio remarked in [1], but for
>    test_pause). If other config files are needed for other debuggers, they
>    can be added when the need arises.
>  * [23]/3: also adapted the synopsys of 'test_pause' and 'debug' in t/README
>    for better discoverability of the new features.
>
> [1] https://lore.kernel.org/git/xmqqa6kvoptx.fsf@gitster.g/
>
> v3:
>
>  * Added '-a' flag as suggested by Elijah, equivalent to '-t -s -h' for
>    'test_pause' and to '-t -h' for 'debug'
>
> v2:
>
>  * added 1/3 as a preliminary step to use TEST_SHELL_PATH in test_pause
>    instead of SHELL_PATH, as suggested by Carlo
>  * implemented the change in behaviour through optional flags in both
>    test_pause and debug. This seemed to be the simplest way to keep the
>    current behaviour but also provide a way to improve the UX.
>
> v1: This series proposes two small quality-of-life improvements (in my
> opinion) to the 'test_pause' and 'debug' test functions: using the original
> values of HOME and TERM (before they are changed by the test framework) and
> using SHELL instead of SHELL_PATH.
>
> The later might be too big of a change, but I think it makes sense. We could
> add a new GIT_TEST_* to conditionnaly change the behaviour, but I kept it
> simple for v1.

This round looks good to me (just eyeballed, didn't download or test);
you have an ack from me.

> Cheers, Philippe.
>
> Philippe Blain (3):
>   test-lib-functions: use 'TEST_SHELL_PATH' in 'test_pause'
>   test-lib-functions: optionally keep HOME, TERM and SHELL in
>     'test_pause'
>   test-lib-functions: keep user's debugger config files and TERM in
>     'debug'
>
>  t/README                |  11 +++--
>  t/test-lib-functions.sh | 107 ++++++++++++++++++++++++++++++++++------
>  t/test-lib.sh           |   6 ++-
>  3 files changed, 103 insertions(+), 21 deletions(-)
>
>
> base-commit: 225bc32a989d7a22fa6addafd4ce7dcd04675dbf
> Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1022%2Fphil-blain%2Ftest-pause-and-debug-easier-v5
> Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1022/phil-blain/test-pause-and-debug-easier-v5
> Pull-Request: https://github.com/gitgitgadget/git/pull/1022
>
> Range-diff vs v4:
>
>  1:  2f566f330e0 = 1:  2f566f330e0 test-lib-functions: use 'TEST_SHELL_PATH' in 'test_pause'
>  2:  a231d560e68 = 2:  a231d560e68 test-lib-functions: optionally keep HOME, TERM and SHELL in 'test_pause'
>  3:  a8b12788fa4 ! 3:  ebf92b6b2c3 test-lib-functions: keep user's debugger config files and TERM in 'debug'
>      @@ Commit message
>           HOME to USER_HOME as in 'test_pause' to avoid user configuration in
>           $USER_HOME/.gitconfig from interfering with the command being debugged.
>
>      -    Note that we use a while loop and a heredoc to protect against
>      -    $USER_HOME containing spaces.
>      -
>           Also, add a flag to launch the debugger with the original value of
>           TERM, and add the same warning as for 'test_pause'.
>
>      @@ t/test-lib-functions.sh: test_pause () {
>       +         shift
>       + done &&
>       +
>      -+ dotfiles="
>      -+ .gdbinit
>      -+ .lldbinit
>      -+ "
>      -+ while read -r dotfile
>      ++ dotfiles=".gdbinit .lldbinit"
>      ++
>      ++ for dotfile in $dotfiles
>       + do
>       +         dotfile="$USER_HOME/$dotfile" &&
>       +         test -f "$dotfile" && cp "$dotfile" "$HOME" || :
>      -+ done <<-EOF &&
>      -+ $dotfiles
>      -+ EOF
>      ++ done &&
>       +
>       + TERM="$DEBUG_TERM" GIT_DEBUGGER="${GIT_DEBUGGER}" "$@" <&6 >&5 2>&7 &&
>       +
>      -+ while read -r dotfile
>      ++ for dotfile in $dotfiles
>       + do
>       +         rm -f "$HOME/$dotfile"
>      -+ done <<-EOF
>      -+ $dotfiles
>      -+ EOF
>      ++ done
>        }
>
>        # Usage: test_commit [options] <message> [<file> [<contents> [<tag>]]]
>
> --
> gitgitgadget
