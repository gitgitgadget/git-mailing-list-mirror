Return-Path: <SRS0=fhRL=6M=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 772C9C83002
	for <git@archiver.kernel.org>; Tue, 28 Apr 2020 02:20:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4F4B420728
	for <git@archiver.kernel.org>; Tue, 28 Apr 2020 02:20:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="q/X+jvMF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726303AbgD1CU4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 27 Apr 2020 22:20:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726261AbgD1CU4 (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 27 Apr 2020 22:20:56 -0400
Received: from mail-vk1-xa41.google.com (mail-vk1-xa41.google.com [IPv6:2607:f8b0:4864:20::a41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8462C03C1A8
        for <git@vger.kernel.org>; Mon, 27 Apr 2020 19:20:55 -0700 (PDT)
Received: by mail-vk1-xa41.google.com with SMTP id g129so5455335vkh.9
        for <git@vger.kernel.org>; Mon, 27 Apr 2020 19:20:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7WArTskR53DfRcSE8fxI7LSPGKncNf2rBZ/lol2uK3E=;
        b=q/X+jvMFak6y4XLlsshj0x+d9vvw8Au/QXPCobN+6R/5DYvdJzlJaGCVImlIyA0cST
         AnqE/s6QojeTV3WUJGTf/0lw1Jz0r25be96jbTm16hSNVUrkN10Jtj8BCCE37e2SuVGs
         z4zEnxxhdsnDoBv7eqgf4WEUVf+iQzjJmRHOWQ/TdceWdl9j4gvAcX3mBa2+JWw0xP6i
         u1dah9yiofuDetQtqeXs8qOCXFln0pbBGmlyUBFZj6eawWzgMlL0/Jq8MRO+5vgWUuUV
         CdVs9eaT3cPvR49wFi9RYonZkPMYKhTXo0lw6t9ClXdddkhi10zjnSGL8s94jFZWazMy
         oEGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7WArTskR53DfRcSE8fxI7LSPGKncNf2rBZ/lol2uK3E=;
        b=e6NfE+vSR5Ib/RaH2jf1wyk4Q930QqvBH0p6KwpLJnSiJoFMz/J7TJYPQ1ZPyLlpFd
         iJV4mbjtE+KFah6thjasnZP81vOz66wmwUV+RylfyGseJ59LZNeF/gU96dTLs/q9WG4P
         CZ5a4fkWc7aoQMlMbws4vCUi4+ySiyiXPsvG3HZl03fH5EasoKHluxVIPqnAhrb12eWF
         YGN85w9l4cY48LK2P4uqYmYWMPR2RoIt4NlTbZyTLF2Q3t776C+erTeCGG/VxgvUJX36
         DG8rFOlEkqS5M10xoJ+CIc+/p8cqdzEOpa7WCy5ZpGv3IESC7VLIez2CtVvSU2FynEG9
         U8ug==
X-Gm-Message-State: AGi0Puah+NTroevMUp9CdVTAXcggtmr87C73P40rSWBjk5eEK5G/mWNI
        JOWmpNsElR/uiC4A3HQjN9uFuHyXwP4nYf+wquwy7K6T
X-Google-Smtp-Source: APiQypI8y80htVPrO3xlcFPM5zpgROVxolOlEeMQhEw5NoNYN9Bkj6L+AqkLnKZbGL+w5ARFWyMWTgfNllQgVGOrZRQ=
X-Received: by 2002:a1f:9645:: with SMTP id y66mr19029720vkd.40.1588040454921;
 Mon, 27 Apr 2020 19:20:54 -0700 (PDT)
MIME-Version: 1.0
References: <20200425022045.1089291-1-jacob.e.keller@intel.com>
 <20200425022045.1089291-6-jacob.e.keller@intel.com> <xmqqv9lk5wqy.fsf@gitster.c.googlers.com>
In-Reply-To: <xmqqv9lk5wqy.fsf@gitster.c.googlers.com>
From:   Jacob Keller <jacob.keller@gmail.com>
Date:   Mon, 27 Apr 2020 19:20:44 -0700
Message-ID: <CA+P7+xpEMb-A1cOkOxdWf0pM=5o8Cyn9=5HLZPtFNMcLUaypsg@mail.gmail.com>
Subject: Re: [PATCH 05/11] completion: add test showing subpar completion for
 git switch --orphan
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jacob Keller <jacob.e.keller@intel.com>,
        Git mailing list <git@vger.kernel.org>,
        Jonathan Nieder <jrnieder@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The proposed SQUASH you have in gitster/jk/complete-git-switch is
correct. The commit message body is correct, but the title could be
reworded to

"completion: stop completing refs for git switch --orphan"

I can send a v2 if that would be helpful, and I've got it fixed up
locally if other review increases the need for a new spin.

Thanks,
Jake

On Mon, Apr 27, 2020 at 4:34 PM Junio C Hamano <gitster@pobox.com> wrote:
>
> Jacob Keller <jacob.e.keller@intel.com> writes:
>
> > From: Jacob Keller <jacob.keller@gmail.com>
> >
> > git switch with the --orphan option is used to create a new branch that
> > is not connected to any history and is instead based on the empty tree.
> >
> > It does not make sense for completion to return anything in this case,
> > because there is nothing to complete. Check for --orphan, and if it's
> > found, immediately return from _git_switch() without completing
> > anything.
> >
> > Add a test case which documents this expected behavior.
> >
> > Signed-off-by: Jacob Keller <jacob.keller@gmail.com>
> > ---
> >  contrib/completion/git-completion.bash | 11 ++++++++++-
> >  t/t9902-completion.sh                  |  7 +++++++
> >  2 files changed, 17 insertions(+), 1 deletion(-)
> >
> > diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
> > index c21786f2fd00..08d3406cf3e4 100644
> > --- a/contrib/completion/git-completion.bash
> > +++ b/contrib/completion/git-completion.bash
> > @@ -2223,9 +2223,18 @@ _git_switch ()
> >               __gitcomp_builtin switch
> >               ;;
> >       *)
> > +             local track_opt="--track" only_local_ref=n
> > +
> > +             # --orphan is used to create a branch disconnected from the
> > +             # current history, based on the empty tree. Since the only
> > +             # option required is the branch name, it doesn't make sense to
> > +             # complete anything here.
> > +             if [ -n "$(__git_find_on_cmdline "--orphan")" ]; then
> > +                     return
> > +             fi
> > +
> >               # check if --track, --no-track, or --no-guess was specified
> >               # if so, disable DWIM mode
> > -             local track_opt="--track" only_local_ref=n
> >               if [ "$GIT_COMPLETION_CHECKOUT_NO_GUESS" = "1" ] ||
> >                  [ -n "$(__git_find_on_cmdline "--track --no-track --no-guess")" ]; then
> >                       track_opt=''
> > diff --git a/t/t9902-completion.sh b/t/t9902-completion.sh
> > index a134a8791076..9d02de167219 100755
> > --- a/t/t9902-completion.sh
> > +++ b/t/t9902-completion.sh
> > @@ -1351,6 +1351,13 @@ test_expect_failure 'git switch - with -C and --no-track, complete all reference
> >       EOF
> >  '
> >
> > +# TODO: completion does not yet recognize --orphan
> > +test_expect_failure 'git switch - with --orphan, do not complete anything' '
> > +     test_completion "git switch --orphan " <<-\EOF
> > +
> > +     EOF
> > +'
> > +
>
> I am getting "TODO passed" at 7276ffe0 (completion: add test showing
> subpar completion for git switch --orphan, 2020-04-24), which hasn't
> hit 'next' yet.
>
> Perhaps we got some rebase gotcha here?
>
> >  test_expect_success 'teardown after ref completion' '
> >       git branch -d matching-branch &&
> >       git tag -d matching-tag &&
