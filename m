Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE39DC433FE
	for <git@archiver.kernel.org>; Sat, 15 Oct 2022 04:38:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229583AbiJOEiI (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 15 Oct 2022 00:38:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229557AbiJOEiG (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 15 Oct 2022 00:38:06 -0400
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E98B57887
        for <git@vger.kernel.org>; Fri, 14 Oct 2022 21:38:05 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id r14so10116596lfm.2
        for <git@vger.kernel.org>; Fri, 14 Oct 2022 21:38:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zKRyahQMJhUhdNqpmDoGBUivt371EpmFSXDomogoSoo=;
        b=lfNULcnQznhmp+N5xc19vDdlMk/FzOCIiR4ys25+hlhq62cCRdP82igVISt0ZkyPc4
         Y+2qXfry7Fj4YI0Oyv/V6K8s0bihpQJnYkz6gkARLs/pJ6FV02dwWoGk/rqBOJLgESjm
         MCY1GsNnwLffvtY10UayElU5TWA/YyS4dnFo3WiS1KgpVIhbX1ZECfS2zrlwT5Er/+X7
         I7ZaJu7Urp8K249pvq4BJ90wi5rEALtSSu6aWmbiXFdNj6LUNHJQmUsw4ijjGkf+6pKs
         jhmX4IpubY5M9Y0bhQEuZxQPh1yW20xQektA9MlGAwTflGMgI79u37oRClhn8eOswlQ/
         hezg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zKRyahQMJhUhdNqpmDoGBUivt371EpmFSXDomogoSoo=;
        b=1BYonw4Q7ofUJFlLyvdlndLA/uHrhsTWryMAwWGPjAVCBD0qR7pqIWffwf/ebNqMxc
         WAz2R7C56YhxfxFiAxY6lSxx7femd765j62pfH9G1hSeSrdLpv89C3+wnzR1Mg2wCmzQ
         BgHJixQrB6AbUHHQ1TpySHGuyJb208KIdeCx50wNdINh14FDRcxt9XOCpyt5RwCbCZOO
         E/zGVrGWRA0VL8AZ2cmTMGaP3P1sTotR2lRj7PVzc/IQcMerk8eTdoQArRDZ9bhogPgz
         XzHLxrBcX2Ofn56Tl+ouZix8qacs5ok4MlXBjJ/p+IhF6qYBXSf+yRqc6i1R1fVVvX+/
         9RoA==
X-Gm-Message-State: ACrzQf2XB2U6I9yC4xFGMecTaNGgDr0vJxONHSe31TgIYvkj55Bj3dKX
        wfT7dQIjIOPXZHy7cBut5qrBm4O3WwvP1E6ktI8=
X-Google-Smtp-Source: AMsMyM4tSKvQyMj+MrKiGTMz8nWmglEYzRJUDo7x2M09bC1Jx5xSmG5XPsOY9wiCMfb1usaLK1RXAsGh7YjWl1k98Z8=
X-Received: by 2002:a05:6512:22d3:b0:4a2:3f7e:95fb with SMTP id
 g19-20020a05651222d300b004a23f7e95fbmr397309lfu.32.1665808683650; Fri, 14 Oct
 2022 21:38:03 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1367.git.1664064588846.gitgitgadget@gmail.com>
 <07a25d48-e364-0d9b-6ffa-41a5984eb5db@github.com> <CABPp-BEjVv1ASdQhXGh6KuDfPt_nhZpRO_Q0i1pCqrV2wVQ9yQ@mail.gmail.com>
 <CAOLTT8T7V0oYpS5XMWbhRi75z7cSVTcWsK76BdwGXAYYh=skPQ@mail.gmail.com>
 <CABPp-BFwiMrgm+_sO6TsLUj77r_krgzYEWZanbyx2Fnn4rM8tg@mail.gmail.com> <CAOLTT8R0MxEWErrw80-F+b1higbuWuQjvkEGi2c4ARzuRzeNWw@mail.gmail.com>
In-Reply-To: <CAOLTT8R0MxEWErrw80-F+b1higbuWuQjvkEGi2c4ARzuRzeNWw@mail.gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Fri, 14 Oct 2022 21:37:50 -0700
Message-ID: <CABPp-BHX+qfWxkGvFx+SyGsiUbp5OVHx3MbWa96JtDnnows0ZA@mail.gmail.com>
Subject: Re: [PATCH] sparse-checkout.txt: new document with sparse-checkout directions
To:     ZheNing Hu <adlternative@gmail.com>
Cc:     Derrick Stolee <derrickstolee@github.com>,
        Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Victoria Dye <vdye@github.com>,
        Shaoxuan Yuan <shaoxuan.yuan02@gmail.com>,
        Matheus Tavares <matheus.bernardino@usp.br>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Oct 14, 2022 at 7:17 PM ZheNing Hu <adlternative@gmail.com> wrote:
>
> Elijah Newren <newren@gmail.com> =E4=BA=8E2022=E5=B9=B410=E6=9C=886=E6=97=
=A5=E5=91=A8=E5=9B=9B 15:53=E5=86=99=E9=81=93=EF=BC=9A
> >
> > On Fri, Sep 30, 2022 at 2:54 AM ZheNing Hu <adlternative@gmail.com> wro=
te:
> > >
> > > Elijah Newren <newren@gmail.com> =E4=BA=8E2022=E5=B9=B49=E6=9C=8828=
=E6=97=A5=E5=91=A8=E4=B8=89 13:38=E5=86=99=E9=81=93=EF=BC=9A
> > > >
[...]
> > As an example, the repository where we first applied sparse-checkouts
> > to (and which had the complicated dependencies) does not use partial
> > clones or a sparse-index.   While partial clone and sparse-index might
> > help a little, the .git directory for a full clone is merely 2G, and
> > there are less than 100K entries in the index.  However,
> > sparse-checkout helps out a lot.
>
> Yes, you make a good explanation here that we don't necessarily need
> to apply all these kinds of features. But I still feel a little confuse: =
Where
> does the time savings come from? Is it saved by the time reduction of
> git checkout? Or is it the reduction of some unnecessary working tree sca=
ns
> during test/build time?

It is neither git checkout time, nor tree scans; it's the ability to
avoid building larging parts of the project coupled with the
significantly better responsiveness of IDEs when project scope is
limited.  When directories are entirely missing, we don't need to
build any of the code in those directories and can instead just use
already built artifacts from the most recent point in history that has
been built on our continuous integration infrastructure.  (Note: our
sparsification tool will keep any modules/directories where there have
been modifications since the most recent upstream commit that has been
built, so we don't risk getting a wrong build via this strategy.)

[...]
> > > 1. mount the large git repo on the server to local.
> > > 2. just ssh to a remote server to run integration tests.
> > > 3. use an external tool to run integration tests on the remote server=
.
> >
> > Are you suggesting #1 as a way for just handling the git history, or
> > also for handling the worktree with some kind of virtual file system
> > where not all files are actually written locally?  If you're only
> > talking about the history, then you're kind of going on a tangent
> > unrelated to this document.  If you're talking about worktrees and
> > virtual file systems, then Git proper doesn't have anything of the
> > sort currently.  There are at least two solutions in this space --
> > Microsoft's Git-VFS (which I think they are phasing out) and Google's
> > similar virtual file system -- but I'm not currently particularly
> > interested in either one.
> >
>
> Here I mean git nfs, or some kind of git virtual file system, or some
> git workspace, I don't really understand why they are now
> phasing out?

You'd have to ask them, or read their comments on it.  I think they
believe sparse-checkout with a normal file system is or will be better
than the behavior they are getting from their virtual file system (and
they've put a lot of really good work behind making sure that is the
case).

[...]
> Some users may really want to focus only on their subprojects, so I think
> "git log -p" shouldn't show files that don't satisfy the
> sparse-checkout patterns,
> and "git grep" too. But some users may need to search something globally,
> and I think those people are in the minority, so maybe there should be a
> "git log -p --scrope=3Dall" or "git grep --scrope=3Dall" for them.

Good to know you're in the "Behavior A" camp and we've got another
vote for implementing things in that direction.  A couple of small
points, though:
  * It's --scope rather than --scrope.  ;-)
  * I have to disagree here slightly about people using a --scope=3Dall
flag -- I don't think users should have to specify it with every grep
or log invocation.  Users in the "Behavior B" camp would want
`--scope=3Dall` behavior for nearly every grep and log -p invocation
they make; it's annoying and unfair to force them to spell it out
every time.  So, I think we need a configuration option.

[...]
> > Sometimes merge has to download blobs to know if there are conflicts
> > or not.  But only sometimes.  Since tree objects have the hashes of
> > the blobs, having the tree objects is sufficient to determine which
> > side(s) of history modified each path.
> >
> > If both sides of history modified the same file, then you *might* have
> > conflicts, and you indeed need the blobs to verify.  But if only one
> > side of history modified a file and the other left it alone, then
> > there is no conflict.
>
> I think I probably get it. e.g. tree of HEAD of user1 have a tree entry
> "a4e1fc out/file1" which is same SHA1 to blob in merge base, because
> it's out of sparse-checkout specification, and it fetch a commit of user2=
,
> and its tree has a tree entry "13f91e out/file1", so git merge doesn't re=
ally
> need to check the contents of the file here, because only one side
> changes it.

Precisely.  :-)
