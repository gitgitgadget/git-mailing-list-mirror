Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6126BC4332F
	for <git@archiver.kernel.org>; Thu,  6 Oct 2022 07:53:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230438AbiJFHxy (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 6 Oct 2022 03:53:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230428AbiJFHxe (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 6 Oct 2022 03:53:34 -0400
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com [IPv6:2a00:1450:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C112A8FD6C
        for <git@vger.kernel.org>; Thu,  6 Oct 2022 00:53:32 -0700 (PDT)
Received: by mail-lj1-x22b.google.com with SMTP id bs18so1303339ljb.1
        for <git@vger.kernel.org>; Thu, 06 Oct 2022 00:53:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date;
        bh=ZIZ4BbLE3qZqyhnVaPpX/v1u+SbOkbjOa0hHCn6HJps=;
        b=VA1LRR5pjf63ncSQaZGvue2hU9lDb7dalB83nJCUVgiTJqkX5s3VxVMAEgvh1YWeOR
         6MEyAxGPYHNoXAqjJZbwROgWAyVZirHC4FcrGSsg0unyIro8/IoPJ/qMNFVgHFfprUjd
         GnPlLAvVmDgujG1WKoRAOxPNaGIYfOsaDHOUPNtZzB15Mf+KxZiQzNqCV6JOakl/gsbG
         HTtl5MiK9ij0jmd3isTl+7oUaoUYEtaibCpuGypeVQvLfNfRiareA0uDwB368suHxaMd
         LABmAOa7hoKHV1hegcskgzcDAEPe2rPP8H+U/jtw+d+7FOAfCBzx5AhyiSx3wK3ipRi4
         NA+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date;
        bh=ZIZ4BbLE3qZqyhnVaPpX/v1u+SbOkbjOa0hHCn6HJps=;
        b=ZPEIysVjf2F/h9YTGAS6KZUWkc/0totTrkhjnJqdxjXf1Rgha5TJezdav6zGdLeu5A
         elvTNSjgUQdts0RSsSi5TW8BouZEPpC6HajH/5lBG92MQnoOszc8LrF46GYqDWVn7N8T
         g4fwWbh4aGaro9gDHMUDcCqoEmNaESg3J5GUjprqdnvuS3vnkHDO1QmLjtj9PJuVO+rE
         vbn55ep2BLAnhsmm0uLtWLc/3LWEcicIX8RPDyFLb1IGua63aVqquKw5CtBoAk9ehEX3
         thsqyjma8lvN4boXRoFDYbYGJtRmyZXx8RRu54ekZ2wMxwKRcf3SugnEiyRDadyIMCUs
         nwLg==
X-Gm-Message-State: ACrzQf0Ba7AgcnWQJE1xiShF6CjdaD+LidgVTDNjhhTPw5nLYiRe45v6
        PepJyF2bc0EGN5QXVGz0d6IvHBOG/A4u7m5bxro=
X-Google-Smtp-Source: AMsMyM65Zn69wiuuSEKfcjEPQYp9T/FoVGrR8p4a0twcIBC065/UpmPI89CPLb+pKu3WWW5w696Mn+PYlqisaXSp6rM=
X-Received: by 2002:a2e:2205:0:b0:26c:2423:a508 with SMTP id
 i5-20020a2e2205000000b0026c2423a508mr1278264lji.163.1665042810976; Thu, 06
 Oct 2022 00:53:30 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1367.git.1664064588846.gitgitgadget@gmail.com>
 <07a25d48-e364-0d9b-6ffa-41a5984eb5db@github.com> <CABPp-BEjVv1ASdQhXGh6KuDfPt_nhZpRO_Q0i1pCqrV2wVQ9yQ@mail.gmail.com>
 <CAOLTT8T7V0oYpS5XMWbhRi75z7cSVTcWsK76BdwGXAYYh=skPQ@mail.gmail.com>
In-Reply-To: <CAOLTT8T7V0oYpS5XMWbhRi75z7cSVTcWsK76BdwGXAYYh=skPQ@mail.gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Thu, 6 Oct 2022 00:53:18 -0700
Message-ID: <CABPp-BFwiMrgm+_sO6TsLUj77r_krgzYEWZanbyx2Fnn4rM8tg@mail.gmail.com>
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

On Fri, Sep 30, 2022 at 2:54 AM ZheNing Hu <adlternative@gmail.com> wrote:
>
> I am not sure if these ideas are feasible.
>
> Elijah Newren <newren@gmail.com> =E4=BA=8E2022=E5=B9=B49=E6=9C=8828=E6=97=
=A5=E5=91=A8=E4=B8=89 13:38=E5=86=99=E9=81=93=EF=BC=9A
> >
[...]
> > > There's nothing Git can do to help those engineers that do cross-tree
> > > work.
> >
> > I'm going to partially disagree with this, in part because of our
> > experience with many inter-module dependencies that evolve over time.
> > Folks can start on a certain module and begin refactoring.  Being
> > aware that their changes will affect other areas of the code, the can
> > do a search (e.g. "git grep --cached ..." to find cases outside their
> > current sparse checkout), and then selectively unsparsify to get the
> > relevant few dozen (or maybe even few hundred) modules added.  They
> > aren't switching to a dense checkout, just a less sparse one.  When
> > they are done, they may narrow their sparse specification again.  We
> > have a number of users doing cross-tree work who are using
> > sparse-checkouts, and who find it productive and say it still speeds
> > up their local build/test cycles.
> >
> > So, I'd say that ensuring Git supports behavior B well in
> > sparse-checkouts, is something Git can do to help out both some of the
> > engineers doing cross-tree work, and some of the engineers that are
> > doing cross-tree testing.
> >
> > (For full disclosure, we also have users doing cross-tree work using
> > regular dense checkouts and I agree there's not a lot we can do to
> > help them.)
> >
>
> Let me guess where the cross tree users using sparse-checkout are
> getting their revenue from:

Is "revenue" perhaps a case of auto-correct choosing the wrong word?

> 1. they don't have to download the entire repository of blobs at once
> 2. their working tree can be easily resized.
> 3. they could have something like sparse-index to optimize the performanc=
e
> of git commands.

These correspond to partial clone, sparse-checkout, and sparse-index.
I think these 3 features and the various work done to support them,
plus submodule (which is a different kind of solution) are the
features Git provides to work with repository subsets.  Some
repositories (especially the big monorepos like the Microsoft ones)
will benefit from using all three of these features.  Others might
only want to use one or two of them.

As an example, the repository where we first applied sparse-checkouts
to (and which had the complicated dependencies) does not use partial
clones or a sparse-index.   While partial clone and sparse-index might
help a little, the .git directory for a full clone is merely 2G, and
there are less than 100K entries in the index.  However,
sparse-checkout helps out a lot.

> But it's still worth worrying about the size of the git repository blobs,
> even if it's just only blobs in mono-repo's HEAD, that may also be too bi=
g
> for the user's local area to handle.
>
> Perhaps it would make more sense to place this integration testing work o=
n
> a remote server.
>
> I am not sure if these ideas are feasible:
>
> 1. mount the large git repo on the server to local.
> 2. just ssh to a remote server to run integration tests.
> 3. use an external tool to run integration tests on the remote server.

Are you suggesting #1 as a way for just handling the git history, or
also for handling the worktree with some kind of virtual file system
where not all files are actually written locally?  If you're only
talking about the history, then you're kind of going on a tangent
unrelated to this document.  If you're talking about worktrees and
virtual file systems, then Git proper doesn't have anything of the
sort currently.  There are at least two solutions in this space --
Microsoft's Git-VFS (which I think they are phasing out) and Google's
similar virtual file system -- but I'm not currently particularly
interested in either one.

#3 is precisely what we did first (except "*a* remote server" rather
than "*the* remote server").  I think I called it out in the email
you're responding to; it's often good enough for many people.
However, sometimes those tests fail and people want to run locally so
it's easier to inspect.  Or they just want to be able to run locally
anyway.  So, while #3 helped, it wasn't good enough.

#2 is also something we did.  Using tools like Coder or GitHub
codespaces or other offerings in that area, you can provide developers
a nice beefy box with good network connectivity to the main Git
repository, on which they can do development and running of tests.
Then developers can connect to such machines from a variety of
different external locations.  Works great for some people...but build
times and ability of IDEs to handle the code base are still an issue,
so doing smarter things with sparse-checkouts is still important.
And, even if #2 works for some people, others still want to develop
and run integration tests on their (beefy) laptops.

All three of these, as far as I can tell, are just things that
individual teams setup and aren't anything that would affect Git's
development one way or another.


However, I'll note that while we internally definitely did two of the
three things you suggested here, it wasn't a complete enough solution
for us and sparse-checkout adoption was still pretty minimal at that
point.  So, we went back to our sparse-checkouts and asked how we
could modify the build system to allow us to not check out the in-tree
dependencies of the things we are tweaking, but still get a correct
build and allow us to run tests.  Once we got that working, we finally
really unlocked the value of sparse checkouts for us (both improving
things for developers on laptops, and for developers on the
development box in the cloud).  It went from very few folks using
sparse checkouts with that repository, to being the default and
recommended usage at that point.

While the build changes were internal things we did, I think that the
underlying usage scenario matters to Git development because it helps
inform how sparse-checkout can be used.  In particular, it suggests
why some sparse-checkout users may be interested in finding results
for files that do not match their sparse-checkout patterns -- in-tree
dependencies may not necessarily be checked out, but those are related
enough to the code that developers are working on, that developers are
still potentially interested in using e.g. "git grep" or "git log -p"
to find out information about code or changes in those other areas.
(And, of course, developers are also potentially interested in finding
out what other code depends on what they are changing, but I suspect
folks were already aware of that usecase.)  It's certainly not the
only usecase, but it's an additional one that I didn't think was quite
reflected in Stolee's description of why users would want searches to
turn up results for files not found in their working tree.

> > > The only thing I can think about is that the diffstat might want to s=
how
> > > the stats for the conflicted files, in which case that's an important
> > > perspective on the distinction from --restrict.
> >
> > We only show the diffstat on a successful merge, so there's no
> > diffstat to show if there are any conflicted files.
> >
>
> Sorry, I have some questions here: how does git merge know there are
> no conflicts without downloading the blobs?

Not sure how that's related to the above, but to answer your question:

Sometimes merge has to download blobs to know if there are conflicts
or not.  But only sometimes.  Since tree objects have the hashes of
the blobs, having the tree objects is sufficient to determine which
side(s) of history modified each path.

If both sides of history modified the same file, then you *might* have
conflicts, and you indeed need the blobs to verify.  But if only one
side of history modified a file and the other left it alone, then
there is no conflict.
