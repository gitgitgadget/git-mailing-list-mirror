Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07EA3C4332F
	for <git@archiver.kernel.org>; Sat, 15 Oct 2022 02:17:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229550AbiJOCRx (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 14 Oct 2022 22:17:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbiJOCRw (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 14 Oct 2022 22:17:52 -0400
Received: from mail-yb1-xb33.google.com (mail-yb1-xb33.google.com [IPv6:2607:f8b0:4864:20::b33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32F14696D8
        for <git@vger.kernel.org>; Fri, 14 Oct 2022 19:17:50 -0700 (PDT)
Received: by mail-yb1-xb33.google.com with SMTP id k3so7544342ybk.9
        for <git@vger.kernel.org>; Fri, 14 Oct 2022 19:17:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZGTeSjMo2eDAhId/GDg1yTolVihnwpIaZEokspjrZm8=;
        b=PKuiC2NUTqRX34eLVxozfsbmuFJ6S11Qm5FnP5farZGS2OXIt6moeQZyVhPQUOTaI5
         yRDht3gqfJrOCLRySeMt+1hF9tH9TnUQBt3qZPXHRpaJ8jQdnS1833Uc47bzgm+kWB+M
         XFM6jofx4xDDI0iY+/F3KDZSwQx1OK8uTv1eTfxXqdSGQer5zbwnM/avss9npFjHKm2W
         x4LFK6jnLFUhG3m+8ieRp40h3zEyVO780ILD79q+8mRyrraRZ89NEkqK03DFsFiBSho8
         TmTRgeWjHGuoUsh1UYHWWd8pwk7x7ESAjOslNEpD1KczMcWCt5jN/dHxtci/872owZxP
         9FRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZGTeSjMo2eDAhId/GDg1yTolVihnwpIaZEokspjrZm8=;
        b=DSkq7pOqjiS9gCJx2f9mdPWJ4fcrmLBnkJRbDAgfXGER6IJ/jnt4LuC/ReR/n0UwUg
         VYZiIKHLxasJXK59gJPi3qlqfq6UKkMqZ6UwIFIxtviNEaerBqkicA0hbkXO44IddPOC
         vyrD6ACUOmikAJmcT/VaesrjpJD/6nWEVwKW5V0U37OlWLzYDvHb2MKY5JHhmYfERAjE
         iZS8Zww7vObN5+guQUOLk7x1rv1KsZ7W658FfU1D9iM1jIaULm45IekbbNEtWMKIlvS+
         IeJ202kWqfonCilIjLw4Ye9brEzdDBJGzqGV518jaWe9vP7MPLkFfj7OtAhYbNEX6Rs7
         WKBA==
X-Gm-Message-State: ACrzQf23GFv43VDXtYzIhaBqysYz0nb/ocXsCcHGIgGlt38OUANns3NQ
        m8aIewn92Lqy0eR45tWcdD+MqB8G0uX1PZKU16c=
X-Google-Smtp-Source: AMsMyM5h4UgxPtxqos/WDLxiihS1FkJiYODcvdP0b5l6C4DTaaS0UTa6v7XPRe0kVzhK73qmZ2g/uKWFXQR5n/9NmhQ=
X-Received: by 2002:a25:81c7:0:b0:6be:c039:dc42 with SMTP id
 n7-20020a2581c7000000b006bec039dc42mr569016ybm.120.1665800269274; Fri, 14 Oct
 2022 19:17:49 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1367.git.1664064588846.gitgitgadget@gmail.com>
 <07a25d48-e364-0d9b-6ffa-41a5984eb5db@github.com> <CABPp-BEjVv1ASdQhXGh6KuDfPt_nhZpRO_Q0i1pCqrV2wVQ9yQ@mail.gmail.com>
 <CAOLTT8T7V0oYpS5XMWbhRi75z7cSVTcWsK76BdwGXAYYh=skPQ@mail.gmail.com> <CABPp-BFwiMrgm+_sO6TsLUj77r_krgzYEWZanbyx2Fnn4rM8tg@mail.gmail.com>
In-Reply-To: <CABPp-BFwiMrgm+_sO6TsLUj77r_krgzYEWZanbyx2Fnn4rM8tg@mail.gmail.com>
From:   ZheNing Hu <adlternative@gmail.com>
Date:   Sat, 15 Oct 2022 10:17:37 +0800
Message-ID: <CAOLTT8R0MxEWErrw80-F+b1higbuWuQjvkEGi2c4ARzuRzeNWw@mail.gmail.com>
Subject: Re: [PATCH] sparse-checkout.txt: new document with sparse-checkout directions
To:     Elijah Newren <newren@gmail.com>
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

Elijah Newren <newren@gmail.com> =E4=BA=8E2022=E5=B9=B410=E6=9C=886=E6=97=
=A5=E5=91=A8=E5=9B=9B 15:53=E5=86=99=E9=81=93=EF=BC=9A
>
> On Fri, Sep 30, 2022 at 2:54 AM ZheNing Hu <adlternative@gmail.com> wrote=
:
> >
> > I am not sure if these ideas are feasible.
> >
> > Elijah Newren <newren@gmail.com> =E4=BA=8E2022=E5=B9=B49=E6=9C=8828=E6=
=97=A5=E5=91=A8=E4=B8=89 13:38=E5=86=99=E9=81=93=EF=BC=9A
> > >
> [...]
> > > > There's nothing Git can do to help those engineers that do cross-tr=
ee
> > > > work.
> > >
> > > I'm going to partially disagree with this, in part because of our
> > > experience with many inter-module dependencies that evolve over time.
> > > Folks can start on a certain module and begin refactoring.  Being
> > > aware that their changes will affect other areas of the code, the can
> > > do a search (e.g. "git grep --cached ..." to find cases outside their
> > > current sparse checkout), and then selectively unsparsify to get the
> > > relevant few dozen (or maybe even few hundred) modules added.  They
> > > aren't switching to a dense checkout, just a less sparse one.  When
> > > they are done, they may narrow their sparse specification again.  We
> > > have a number of users doing cross-tree work who are using
> > > sparse-checkouts, and who find it productive and say it still speeds
> > > up their local build/test cycles.
> > >
> > > So, I'd say that ensuring Git supports behavior B well in
> > > sparse-checkouts, is something Git can do to help out both some of th=
e
> > > engineers doing cross-tree work, and some of the engineers that are
> > > doing cross-tree testing.
> > >
> > > (For full disclosure, we also have users doing cross-tree work using
> > > regular dense checkouts and I agree there's not a lot we can do to
> > > help them.)
> > >
> >
> > Let me guess where the cross tree users using sparse-checkout are
> > getting their revenue from:
>
> Is "revenue" perhaps a case of auto-correct choosing the wrong word?
>

s/revenue/benefits

> > 1. they don't have to download the entire repository of blobs at once
> > 2. their working tree can be easily resized.
> > 3. they could have something like sparse-index to optimize the performa=
nce
> > of git commands.
>
> These correspond to partial clone, sparse-checkout, and sparse-index.
> I think these 3 features and the various work done to support them,
> plus submodule (which is a different kind of solution) are the
> features Git provides to work with repository subsets.  Some
> repositories (especially the big monorepos like the Microsoft ones)
> will benefit from using all three of these features.  Others might
> only want to use one or two of them.
>

Here I am just amazed that cross-tree users can shorten the
test/build cycle when only using sparse-checkout. So this benefits
don't come from above there conjectures. Not partial clone, not
sparse-index, not resize repo frequently.

> As an example, the repository where we first applied sparse-checkouts
> to (and which had the complicated dependencies) does not use partial
> clones or a sparse-index.   While partial clone and sparse-index might
> help a little, the .git directory for a full clone is merely 2G, and
> there are less than 100K entries in the index.  However,
> sparse-checkout helps out a lot.
>

Yes, you make a good explanation here that we don't necessarily need
to apply all these kinds of features. But I still feel a little confuse: Wh=
ere
does the time savings come from? Is it saved by the time reduction of
git checkout? Or is it the reduction of some unnecessary working tree scans
during test/build time?

> > But it's still worth worrying about the size of the git repository blob=
s,
> > even if it's just only blobs in mono-repo's HEAD, that may also be too =
big
> > for the user's local area to handle.
> >
> > Perhaps it would make more sense to place this integration testing work=
 on
> > a remote server.
> >
> > I am not sure if these ideas are feasible:
> >
> > 1. mount the large git repo on the server to local.
> > 2. just ssh to a remote server to run integration tests.
> > 3. use an external tool to run integration tests on the remote server.
>
> Are you suggesting #1 as a way for just handling the git history, or
> also for handling the worktree with some kind of virtual file system
> where not all files are actually written locally?  If you're only
> talking about the history, then you're kind of going on a tangent
> unrelated to this document.  If you're talking about worktrees and
> virtual file systems, then Git proper doesn't have anything of the
> sort currently.  There are at least two solutions in this space --
> Microsoft's Git-VFS (which I think they are phasing out) and Google's
> similar virtual file system -- but I'm not currently particularly
> interested in either one.
>

Here I mean git nfs, or some kind of git virtual file system, or some
git workspace, I don't really understand why they are now
phasing out?

> #3 is precisely what we did first (except "*a* remote server" rather
> than "*the* remote server").  I think I called it out in the email
> you're responding to; it's often good enough for many people.
> However, sometimes those tests fail and people want to run locally so
> it's easier to inspect.  Or they just want to be able to run locally
> anyway.  So, while #3 helped, it wasn't good enough.
>

Agree, testing locally sometimes is necessary.

> #2 is also something we did.  Using tools like Coder or GitHub
> codespaces or other offerings in that area, you can provide developers
> a nice beefy box with good network connectivity to the main Git
> repository, on which they can do development and running of tests.
> Then developers can connect to such machines from a variety of
> different external locations.  Works great for some people...but build
> times and ability of IDEs to handle the code base are still an issue,
> so doing smarter things with sparse-checkouts is still important.
> And, even if #2 works for some people, others still want to develop
> and run integration tests on their (beefy) laptops.
>

Agree too.

> All three of these, as far as I can tell, are just things that
> individual teams setup and aren't anything that would affect Git's
> development one way or another.
>
>
> However, I'll note that while we internally definitely did two of the
> three things you suggested here, it wasn't a complete enough solution
> for us and sparse-checkout adoption was still pretty minimal at that
> point.  So, we went back to our sparse-checkouts and asked how we
> could modify the build system to allow us to not check out the in-tree
> dependencies of the things we are tweaking, but still get a correct
> build and allow us to run tests.  Once we got that working, we finally
> really unlocked the value of sparse checkouts for us (both improving
> things for developers on laptops, and for developers on the
> development box in the cloud).  It went from very few folks using
> sparse checkouts with that repository, to being the default and
> recommended usage at that point.
>

Yeah, I'm a big believer in sparse-checkout or partial-clone which are
good features but not many people realize that they can use them.

> While the build changes were internal things we did, I think that the
> underlying usage scenario matters to Git development because it helps
> inform how sparse-checkout can be used.  In particular, it suggests
> why some sparse-checkout users may be interested in finding results
> for files that do not match their sparse-checkout patterns -- in-tree
> dependencies may not necessarily be checked out, but those are related
> enough to the code that developers are working on, that developers are
> still potentially interested in using e.g. "git grep" or "git log -p"
> to find out information about code or changes in those other areas.
> (And, of course, developers are also potentially interested in finding
> out what other code depends on what they are changing, but I suspect
> folks were already aware of that usecase.)  It's certainly not the
> only usecase, but it's an additional one that I didn't think was quite
> reflected in Stolee's description of why users would want searches to
> turn up results for files not found in their working tree.
>

Some users may really want to focus only on their subprojects, so I think
"git log -p" shouldn't show files that don't satisfy the
sparse-checkout patterns,
and "git grep" too. But some users may need to search something globally,
and I think those people are in the minority, so maybe there should be a
"git log -p --scrope=3Dall" or "git grep --scrope=3Dall" for them.

> > > > The only thing I can think about is that the diffstat might want to=
 show
> > > > the stats for the conflicted files, in which case that's an importa=
nt
> > > > perspective on the distinction from --restrict.
> > >
> > > We only show the diffstat on a successful merge, so there's no
> > > diffstat to show if there are any conflicted files.
> > >
> >
> > Sorry, I have some questions here: how does git merge know there are
> > no conflicts without downloading the blobs?
>
> Not sure how that's related to the above, but to answer your question:
>

Ah, this question relates to my previous question in [1]. At first I always
thought it was git merge that caused the extra blob downloading.
In the end, it turned out to be caused by the last diffstat of merge...

> Sometimes merge has to download blobs to know if there are conflicts
> or not.  But only sometimes.  Since tree objects have the hashes of
> the blobs, having the tree objects is sufficient to determine which
> side(s) of history modified each path.
>
> If both sides of history modified the same file, then you *might* have
> conflicts, and you indeed need the blobs to verify.  But if only one
> side of history modified a file and the other left it alone, then
> there is no conflict.

I think I probably get it. e.g. tree of HEAD of user1 have a tree entry
"a4e1fc out/file1" which is same SHA1 to blob in merge base, because
it's out of sparse-checkout specification, and it fetch a commit of user2,
and its tree has a tree entry "13f91e out/file1", so git merge doesn't real=
ly
need to check the contents of the file here, because only one side
changes it.

Thanks for your answers!

[1]: https://lore.kernel.org/git/CABPp-BEBB1oqdVcXrWwMAdtb0TwHZvr-6KDa210j5=
ncw54Di_g@mail.gmail.com/
