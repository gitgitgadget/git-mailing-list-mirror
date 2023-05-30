Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAD1FC7EE23
	for <git@archiver.kernel.org>; Tue, 30 May 2023 07:23:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230143AbjE3HXu (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 30 May 2023 03:23:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230311AbjE3HXX (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 30 May 2023 03:23:23 -0400
Received: from mail-qv1-xf36.google.com (mail-qv1-xf36.google.com [IPv6:2607:f8b0:4864:20::f36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8626C9
        for <git@vger.kernel.org>; Tue, 30 May 2023 00:22:53 -0700 (PDT)
Received: by mail-qv1-xf36.google.com with SMTP id 6a1803df08f44-6261890b4d7so19604206d6.1
        for <git@vger.kernel.org>; Tue, 30 May 2023 00:22:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685431373; x=1688023373;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Mm2p6zLW7iD8l+meYbUZCp3vn/bnSARP5PuTyJ4Lrhs=;
        b=XImd2GaqduUL99DCe6hsaKeQt3oWT1YTHYlaYzUok0vuIb038QuG329l4D7wBrhdye
         N6neuGwpO11G0e0Lln2YVkKAI2NnuCa/gur+YHN15Y2mKHq7oseKwbl/7aQoYJpcvBKX
         EOSFEjrtmWIzbEXdYgInRamF7wetyNPl9wWgVxuMzuuCOxBcKpM+IamPRXcKCbowWcv4
         /sGRchP/yI+PloB7kucUoy3EmyMadnWaRpVzTT+bFdrRpjv1/QgryOpi9PkWIedkdAsz
         S8Ix2HcY63qX6v7DLFxCHGT+gPcn38Oa8xwotNZP8HTpttACvnht9we5iBdVIXtBhPpB
         Hvlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685431373; x=1688023373;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Mm2p6zLW7iD8l+meYbUZCp3vn/bnSARP5PuTyJ4Lrhs=;
        b=HqUC4963rEH45AAt03SAccCm2TQGf2vjkgFUbU4oiyELUQ0pqU1H+bU2Z48HmjiAmb
         dox83YHGCMXAjtctdX8m1TTILOd9FjDnKZoQ6tf4LNKv2VRf36XWzZf1cHKW9QCxgDcg
         pgpYBjwXn1qSrQJQ+FO9Dta2LZZn7+GSuJCVujKVgGa6U0XlQH+LkwMR9IPQveteBesB
         6fYZuYydqvxtTRcoPb948QdJw7mlXurlTcWwLcc9tW8MKxqjt/EA9ZUp+3x6BBD6QLI4
         XIkKCKCp/bpCRtmMcWwhTdk1vIbLkkBCRlNFc0wzJKaeKDp2uvkOG0pLNftv1BK+uXk1
         F0zA==
X-Gm-Message-State: AC+VfDz2dNLFoM2WmdaUdYQo6F/pvsIAjJ1Rb0hX0h++1YVqaeaLNfts
        EwVX8juiAVj5hoa9aJ0OdLQaSFncOomNWKwGKLe/vunnV66sTA==
X-Google-Smtp-Source: ACHHUZ5r16VCfkKeVQwl/ija46gAzsIsuC1gBKrginQnv4uAPQqTyFA3w67eIogmqn9rBOTRz4tCW+3KEagLsNA9nbM=
X-Received: by 2002:a05:6214:76a:b0:626:32fc:999a with SMTP id
 f10-20020a056214076a00b0062632fc999amr1079753qvz.28.1685431372757; Tue, 30
 May 2023 00:22:52 -0700 (PDT)
MIME-Version: 1.0
References: <CACoUkn7TmZ=trtDKcQm0SG5qCqK=-+YxrDV-7xYnLH_XK7K7og@mail.gmail.com>
In-Reply-To: <CACoUkn7TmZ=trtDKcQm0SG5qCqK=-+YxrDV-7xYnLH_XK7K7og@mail.gmail.com>
From:   Son Luong Ngoc <sluongng@gmail.com>
Date:   Tue, 30 May 2023 09:22:41 +0200
Message-ID: <CAL3xRKfj6R9BfnKEcEqcD5Z+y_A1uocSgEsPyoaV95VXenjHbQ@mail.gmail.com>
Subject: Re: Automatically re-running commands during an interactive rebase or
 post commit
To:     Paul Jolly <paul@myitcv.io>
Cc:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hey Paul,

On Mon, May 29, 2023 at 3:44=E2=80=AFPM Paul Jolly <paul@myitcv.io> wrote:
>
> Hi all,
>
> I would appreciate some advice on the best way to solve the following pro=
blem.
>
...
>
> I've tried to experiment with how I might do this using git commit
> hooks. But so far, my git foo is failing me. It mainly fails because
> when doing an edit of an earlier commit via an interactive rebase,
> later changes might well conflict (in the generated file) with the
> results of the code generator having been re-run on the edited commit.
> At this point, my git rebase --continue stops until I have fixed the
> conflict. But in almost all situations, the conflict comes in the
> generated hash file. Which I fix by simply re-running the code
> generation script (I could optionally fix it by doing a git checkout
> --theirs, and then re-running the code generation script).
>
> This all feels tantalisingly close to being a perfect workflow! But I
> can't quite figure out how to make the git hooks "work" in such a way
> that doesn't require any intervention from me (except in those
> situations where there is a conflict during the rebase that is _not_
> in the code generated file and so does require my intervention).
>
> The code generation step is incredibly fast if there is nothing to do,
> and is quite fast even when there is something to do (in any case it
> can't avoid doing this work).
>
> Please can someone help nudge me in the right direction?

In general, there are 2 cases that you would want to handle:
1. Inserting format directive in between commit rebase that DOES NOT
    come with merge conflicts
2. Same but DOES come with merge conflicts.

For (1), you might be interested in tools such as
- Git Absorb(a) that automatically fixup your stack of commits with your
  current dirty changes.
- Git Branchless(b) "git test" feature

Both of these tools are heavily influenced by Meta's internal Phabricator
mercurial workflow. Since the release of these tools, Meta has also
open-sourced their internal tool at Sapling SCM(c) which they touted
to be git-compatible.

For (2), and if none of the tools above solve your problem,
then I recommend using git-rebase interactive with a vim macro to
generate the needed rebase todo. You can find my comment in (d)
to see what such a rebase todo list would look like.

Tools such as Restack (e) take it a step further by providing a custom Git
`sequence.editor` to programmatically generate the rebase todo for you.
This could be a bash script, or a perl script... or a custom Go binary of
your choosing. You might want to go down this route if a vim macro is
not sufficient and you require some custom logic.

Finally, I would recommend turning on rerere.enabled (f) config to store
the conflict resolution for subsequent rebase attempts. This way, you would
only need to resolve each rebase conflict once.

(a): https://github.com/tummychow/git-absorb
(b): https://github.com/arxanas/git-branchless/wiki/Command:-git-test#fixin=
g-formatting-and-linting-issues
(c): https://sapling-scm.com/docs/commands/absorb
(d): https://github.com/arxanas/git-branchless/discussions/45#discussioncom=
ment-3364792
(e): https://github.com/abhinav/restack
(f): https://git-scm.com/docs/git-config#Documentation/git-config.txt-rerer=
eenabled

>
> Many thanks,
>
>
> Paul

Cheers,
Son Luong.
