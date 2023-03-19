Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1C3DC6FD1F
	for <git@archiver.kernel.org>; Sun, 19 Mar 2023 04:29:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229983AbjCSE3P (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 19 Mar 2023 00:29:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229593AbjCSE3L (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 19 Mar 2023 00:29:11 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7A99DBFC
        for <git@vger.kernel.org>; Sat, 18 Mar 2023 21:29:08 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id g17so11149921lfv.4
        for <git@vger.kernel.org>; Sat, 18 Mar 2023 21:29:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679200147;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6z/frFza1z2ZLG+VyAEjfZ86hkuBBg8/n/rBzqufXD8=;
        b=qqSM8e+2w/IWN2np6BHFzwwSXwjZOyyOMslHNkpqlHhxmpXgsoV08w5oLjVIrJ3sc2
         u92nH6RnAgkSUmI6i8rbWZbvLheYDIO92/qvwjd0YnhrjxqVpO+aPzTf6mjv4IMEOtk8
         UShyvcgkgLDDy+FDEm8QVx/SLOkkS0VmclX3w8p+p/rqVziwWfsuj/CQ/Gs1D1Ujpqud
         NryceYa548WnTlbycoz9Oi002Z3siCjNbDDtdIVzt3j2umILQYTTUyHILolCAFptzHHs
         CtibJdu8LJstxzAuWp1fUsqbP+MW8vU+vYGyFtVs0Z6dFZPjxH77VRHqs0vWo/ldCOEq
         52Pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679200147;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6z/frFza1z2ZLG+VyAEjfZ86hkuBBg8/n/rBzqufXD8=;
        b=ThDa6273xF8fofKnF3WPUUo2yOkekX1tlOf6dOgCPsOHiDLI5yFcaXY431V8w3jNM2
         zRc7gmklVnPHaWpgziPcAvXuSfmaY2jmmsEflAYiePoy6+NcY4idTMRxu5YDxYZpkoFd
         zMD7RJGK406WZdc2BBp8bzjiVSmqM5PSyjJJTJzqnAKIr9i5chNkU5+KYsolJZ5B4fIM
         4+c6nN7rJ/QJimCjAhoTwWlTVMCcXcallD03h3fIMH7mo9CIRjLx1M/o0av+BwnJfLwb
         aAHXpBa+4C2uRl98YrHhPUUsgniQTK9Ur6ORomb04Q3f8CHkSos9SJTaxjfMIdHV7vnV
         faKw==
X-Gm-Message-State: AO0yUKUyYRvl22ujCtRHSKPUSxQh437JztmVMQBfYRzi9PeViA8zFtk3
        EldjLy+1AFofWKmrwCOpPIiQXdRKR8J/+6NkNHrRwr0n84Y=
X-Google-Smtp-Source: AK7set9hDqOlgpVr4qyhyEnEsgI+xdUqGXcCc91ChyCLsrYMkf/cPlZMvI9FtM5leJ2zYRuDNZ/j1lmDlf9hmj62sfc=
X-Received: by 2002:a05:6512:3d22:b0:4e8:4409:bb76 with SMTP id
 d34-20020a0565123d2200b004e84409bb76mr4307104lfv.2.1679200146952; Sat, 18 Mar
 2023 21:29:06 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1488.git.1678283349.gitgitgadget@gmail.com>
In-Reply-To: <pull.1488.git.1678283349.gitgitgadget@gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Sat, 18 Mar 2023 21:28:52 -0700
Message-ID: <CABPp-BGBBptR-BLGzd43w26uzKazK77f9goPbVCXv+Y0-FzbvQ@mail.gmail.com>
Subject: Re: [PATCH 0/2] builtin/sparse-checkout: add check-rules command
To:     William Sprent via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Victoria Dye <vdye@github.com>,
        William Sprent <williams@unity3d.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

On Wed, Mar 8, 2023 at 5:49=E2=80=AFAM William Sprent via GitGitGadget
<gitgitgadget@gmail.com> wrote:
>
> Hi
>
> Back in January I submitted a patch which suggested to teach 'ls-tree' to=
 be
> able to filter its output based on sparse checkout specifications [1]. My
> main motivation for doing so was (is) to enable building more tooling on =
top
> of sparse checkouts, which is currently hampered a bit by the fact that g=
it
> doesn't expose the pattern matching rules for the sparse checkouts.
>
> I think the main point from that thread was that the 'ls-tree' change was
> conceptually a larger change that I had initially thought it was. It was
> suggested that perhaps it would be more straight-forward to initially add=
 a
> command in the vein of 'git-check-ignore' before teaching all the other
> commands about sparse checkout specifics, and I think that makes sense. S=
o I
> am proposing here a new 'check-rules' sub-command to 'sparse-checkout'. T=
his
> exposes the sparse checkout pattern matching logic while still keeping th=
e
> pattern specification local to the sparse-checkout command.
>
> Since the intention is that this new behavior would not need a work tree =
as
> it allows the user to supply a set of rules to verify the paths against, =
the
> change that introduces the sub-command is preceded by one that removes th=
e
> 'NEEDS_WORK_TREE' flag for 'sparse-checkout' and replaces it with calls t=
o
> 'setup_work_tree()' to keep current behavior.
>
> 1:
> https://public-inbox.org/git/pull.1459.git.1673456518993.gitgitgadget@gma=
il.com/

Sorry for the delay in reviewing.  Patch 1 looks good to me.  Patch 2
looks really good as well, but there were a few minor things that we
might be able to touch up.

And now that I've played with it and tested a little bit locally, I
really like the idea of having this functionality around.  Thanks for
sending it in.

> William Sprent (2):
>   builtin/sparse-checkout: remove NEED_WORK_TREE flag
>   builtin/sparse-checkout: add check-rules command
>
>  Documentation/git-sparse-checkout.txt |  23 +++-
>  builtin/sparse-checkout.c             | 132 +++++++++++++++++----
>  git.c                                 |   2 +-
>  t/t1091-sparse-checkout-builtin.sh    | 162 +++++++++++++++++++++++++-
>  4 files changed, 295 insertions(+), 24 deletions(-)
>
>
> base-commit: d15644fe0226af7ffc874572d968598564a230dd
> Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1488%2F=
williams-unity%2Fsparse-doodle-v1
> Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1488/willi=
ams-unity/sparse-doodle-v1
> Pull-Request: https://github.com/gitgitgadget/git/pull/1488
> --
> gitgitgadget
