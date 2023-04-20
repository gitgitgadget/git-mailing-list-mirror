Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A746BC7618E
	for <git@archiver.kernel.org>; Thu, 20 Apr 2023 21:00:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232385AbjDTVAQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 20 Apr 2023 17:00:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232600AbjDTVAN (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 Apr 2023 17:00:13 -0400
Received: from mail-qv1-xf2a.google.com (mail-qv1-xf2a.google.com [IPv6:2607:f8b0:4864:20::f2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43C2749D3
        for <git@vger.kernel.org>; Thu, 20 Apr 2023 13:59:58 -0700 (PDT)
Received: by mail-qv1-xf2a.google.com with SMTP id 6a1803df08f44-5ef4885bc39so5229946d6.2
        for <git@vger.kernel.org>; Thu, 20 Apr 2023 13:59:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682024397; x=1684616397;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uyw7jrUayGvLLvQuhuo56WvirP4n9LFAc6RaTWhsWYs=;
        b=cK7+x8EX4EN9Ozvt1P2LMoN57OCFb5ZlpMq8dMF/PoZWBKOolT20qLm/YpJ5l3/jCI
         mA66g8HNMq2J088JdiCDZbw2qU/UBLG+mijInxs5OMHMfvquTvcLWV9mXSc08z0A9N83
         ic8XdO6W62hsHU+n6YoXhebpAGqu37ey3GhgQF1OnntLsedG3Tcv6tGiJSM9C+qX169X
         82GGHaHItkJBXGU2CVMeyOeb1ga9s3yAb89kcjnZIDRzNvSozEdRHNgdyP4gEClrnLmH
         9hV3k7dgeWqse4jA/xZ2OnniL2xe17ULa1/ckXFc/n2nLp0u3P/w7TUlyhrKqBqgElu/
         Vtqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682024397; x=1684616397;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uyw7jrUayGvLLvQuhuo56WvirP4n9LFAc6RaTWhsWYs=;
        b=SFjo4pzMrqc2XoG0UVzEgjQXNle1XO9xPYCFXpHkCsutTtFikGLQ3L4e2SDTOfzgxo
         wGwmCFck3rPCJVoheRoU4rwnYzeCXvIbG3mbgEsuzUXHyYpgx1sXnCK4DzZFsrXdw33G
         lmKaQ+CgpCQxvJY5FI2fw8AMhiN8bNNLp7dtMy4ObyMahe0fsuUF1oMtZF8Yob3gJZTd
         n1MSnJL54N1aFkymfMfFFda3VLJ1CSbDByenW67Anhl1bfqH6soRHBwoQ2L9Jh/YyRTK
         8VqtVYnnCehJrhY73gqc+wYTjHxBXCqkRJ2p4NXpwET+f0JR2Ds7Yfq7luJ2TicC41xF
         +zMg==
X-Gm-Message-State: AAQBX9cQn3E6DvPnD1Z3TdqoYEj7L6nUbsr4QHR/WSGJeWin1oreyWq5
        OaB5eqohk3DzUSEK0zFBbJ4wpp3c4siv0EQuyBA=
X-Google-Smtp-Source: AKy350apcjaj9EzQwOz3DYaw+6ifKBjRk7lK/3I4E3u4Lh/Hhi7sCq8jIEMgN6wSxtFFi7GKnvtDrJLcJdE6holENMA=
X-Received: by 2002:a05:6214:258d:b0:5ee:8960:ac90 with SMTP id
 fq13-20020a056214258d00b005ee8960ac90mr1405328qvb.24.1682024397352; Thu, 20
 Apr 2023 13:59:57 -0700 (PDT)
MIME-Version: 1.0
References: <20230420074616.1642742-1-myoga.murase@gmail.com> <xmqqh6ta3485.fsf@gitster.g>
In-Reply-To: <xmqqh6ta3485.fsf@gitster.g>
From:   Koichi Murase <myoga.murase@gmail.com>
Date:   Fri, 21 Apr 2023 05:59:21 +0900
Message-ID: <CAFLRLk-uSOucgkHJSATkQVmYc_pxZO6qrJWYg2ofiWHVWPGRcw@mail.gmail.com>
Subject: Re: [PATCH 1/2] completion: quote arguments of test and [
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Justin Donnelly <justinrdonnelly@gmail.com>,
        Denton Liu <liu.denton@gmail.com>,
        =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>,
        Edwin Kofler <edwin@kofler.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thank you for the review and comments.

2023=E5=B9=B44=E6=9C=8821=E6=97=A5(=E9=87=91) 1:31 Junio C Hamano <gitster@=
pobox.com>:
> The above sounded good before I looked at the patch, and it still is
> good in theory, but it start to look mostly academic especially with
> enclosing $# inside a pair of double-quotes, and the variable would
> have only digits.  The same for $i and $j that appear in the loop
> control "for ((i=3D0, j=3D0; ...)); do".  The story is pretty much the
> same for local variables we set outselves to signal our findings,
> like $pcmode that is only set to either 'yes' or 'no'.

I need to admit that this report is not associated with a problem that
has actually happened in real-world uses.  In that sense, maybe you
could regard these changes as more and less academic.  To be fair, I
think I first need to explain the background.  We first received the
change as a part of the commits for a consistent code style in our
project, which contains copies of git-completion.bash and
git-prompt.sh.  Since these files came from the upstream Git project
and are not something we are maintaining in our project, we rejected
the changes to these two files.  However, I still think it's worth
forwarding the contributions from Edwin to the upstream, so I expanded
the changes to similar cases in the same files and posted them here.

> Is there a practical use case for an IFS that is set to split a run
> of digits somewhere in between (e.g. "IFS=3D5")? Is there any
> realistic setting of IFS that breaks the command line completion
> without this patch,

If you are talking about the ``default'' settings of IFS in an
interactive session, I don't think there would be a practical use to
set IFS to something other than <space><tab><newline>.  However, the
expected usage of IFS is to ``temporarily'' set a non-trivial value to
IFS, run some commands referencing IFS (such as word splitting of
unquoted variable expansions or the `read' builtin), and finally
restore IFS to the original state.  These three steps can be performed
in three separate command lines in an interactive shell.  The problem
is that git prompt and completion settings can be invoked between
these command lines, where IFS has the temporary value, regardless of
whether the user intends so.

> but the IFS is usable without breaking all other
> things people wrote as shell scripts and you use everyday?

First, an independent shell script will never be affected by IFS in
interactive sessions because IFS is reset to <space><tab><newline> at
the startup of the shell as requested by POSIX [XCU 2.5.3 IFS =C2=B63], so
the only relevant scripts here are the settings of interactive shells.
I assume you are not including random personal settings written by
beginners (where we can easily find broken settings), and then there
are not too many projects of widely used Bash interactive settings.
Among such projects, recent projects are carefully written so that
they won't be affected by random IFS. An old project, bash-completion,
still contains the parts affected by random IFS, but the discussions
for possible solutions are ongoing (e.g. in the following refs):

https://github.com/scop/bash-completion/issues/723
https://github.com/scop/bash-completion/issues/720#issuecomment-1093764792
https://github.com/scop/bash-completion/pull/739

> If there is no such realistic setting of IFS, most, if not all, of
> the changes presented here, while they may not be incorrect per-se,
> look purely academic.
>
> It's not like this patch was produced by enclosing each and every
> variable reference machanically inside a pair of double-quotes,
> right?  If there were variable references that ought to be split at
> IFS whitespace, the patch would have left them alone.  The readers
> also need to assume the opposite for those variable references that
> are touched by this patch while reviewing it.

I think I miss the intent of this paragraph.  I made this patch
manually, i.e., edited each line of `test' and `[' by hand, but the
procedure is actually mechanical. There can be use cases to split
words by IFS for the other commands or shell constructs, but
specifically for the `test' and `[' builtins, the words should never
be split because it totally breaks the semantics that these builtins
process.

> Is there any change in this patch that do fix a real problem with
> some more realistic IFS setting?

No, this patch focuses on solely the problems of `test' and `[' caused
by custom IFS, (though I'm not convinced that the problem caused by
the custom IFS would be ``virtual'').

> Setting IFS to a digit does not
> count.  If there is, then mixing such a real fix in many academic
> changes is even worse, as the latter clutters the patch and makes it
> harder to assess the former.  It is like hiding a gem in a lot of
> cobblestones.
>
> In other words, this patch looks way too noisy to be reviewed to
> discover its real worth.
>
> Thanks.

By the way, in the original patch, I tried to minimize the changes so
just continued to use `test' and `[', but a solution that is generally
considered preferable would be actually to switch to `[[ ... ]]'. If
requested so, I can edit the patch.
