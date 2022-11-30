Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E471EC352A1
	for <git@archiver.kernel.org>; Wed, 30 Nov 2022 18:30:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229690AbiK3Saa (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 30 Nov 2022 13:30:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229978AbiK3SaY (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 30 Nov 2022 13:30:24 -0500
Received: from mail-vs1-xe2d.google.com (mail-vs1-xe2d.google.com [IPv6:2607:f8b0:4864:20::e2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65BA68D672
        for <git@vger.kernel.org>; Wed, 30 Nov 2022 10:30:20 -0800 (PST)
Received: by mail-vs1-xe2d.google.com with SMTP id p15so10067238vsr.5
        for <git@vger.kernel.org>; Wed, 30 Nov 2022 10:30:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SdtYqib63gK6HjaTdUlDhieK/SpjniE+r6s5hLBR1CI=;
        b=pi1qVTWwB3n0XN2KyOrZKDvZ3PL5mRotafGcb7yEmhiAlkcjaxSqjG5Zn6FtpSXD7m
         fn/MAnlhGHod/nxA3JuCHF30Net8QHBJHyjzQuaNWRoox6i4Rr36LKbmx9YQFgHhGVM5
         m+byIxcXLuY+3pK8QXv2HW8lATFDrpAyopP59ado5GBbKitpRzuW+F2DRCWjxDmmq9Ni
         LeB0Z3NA7GMRwM7N3IzHPfAWbOwBGVYnTEEk5JR3EE/F/EBAMywQyOj1PpejZYs3e7Qi
         E+4BEkVBYCVnIuT8KLQ71o63kJT2zwcaWasvOavin63B8UtF2jI98TmIV2wFRDmsSAKK
         utQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SdtYqib63gK6HjaTdUlDhieK/SpjniE+r6s5hLBR1CI=;
        b=xlvZa+lblmRT3rTiRV64ONUbc11fn09rHUPNNcR98BkJHlMW7lvqgx0Y4u7DnwWVzA
         RUum8ljNL1W9ly921Ij9jQyYj9YNIQw4N4ZZPpzZWZ5Ojdu/HB2EYGla8VLnePQ6uqEX
         Cmccpns6sZ8gbTF7oLulghsKxR2HGrNMMCANpYPj0EKEil69+O1lX68/hT9WLeJWCPom
         NC42yTS5B2/mcfbAmgjJ3x7xn2uVHWA2AIBib4h8iSgbqrgWrw0YhQzW6L2bfVY6YHEF
         jwszy7EGVlSSSifmm/cB+zW5ESS8czcp4Wjy+ymzqDIpZ+kqZ12HcOoWKcK4S57XMXWE
         Gg8g==
X-Gm-Message-State: ANoB5pneuh4FPJ2wW1+yQaxfDBuytiP3n879iJJYDr/zgVmlpk8TLC6S
        /q9nlj4kaGWepcR9HrY3WNZwALGxMt3uuiYTPc1idj2+234w/A==
X-Google-Smtp-Source: AA0mqf75/YfMq4uhpXEJpFxPFgeG+YddCnpdhXQfXPJTi9i1t/hWV9IehurE/rygUR21gH8veMaz/uE+Bktbqmc5uwg=
X-Received: by 2002:a05:6102:2906:b0:3a6:5c53:ba22 with SMTP id
 cz6-20020a056102290600b003a65c53ba22mr23352241vsb.82.1669833019253; Wed, 30
 Nov 2022 10:30:19 -0800 (PST)
MIME-Version: 1.0
References: <pull.1408.git.1667846164.gitgitgadget@gmail.com>
 <CAFQ2z_MZd150kQNTcxaDRVvALpZcCUbRj_81pt-VBY8DRaoRNw@mail.gmail.com> <f1c45bd5-692e-85db-90c3-c516003f47e5@github.com>
In-Reply-To: <f1c45bd5-692e-85db-90c3-c516003f47e5@github.com>
From:   Han-Wen Nienhuys <hanwen@google.com>
Date:   Wed, 30 Nov 2022 19:30:06 +0100
Message-ID: <CAFQ2z_MLwUoaSTG04LJYHgJH-QYJEuZ9bQcTsV8mXwxBbz7Egg@mail.gmail.com>
Subject: Re: [PATCH 00/30] [RFC] extensions.refFormat and packed-refs v2 file format
To:     Derrick Stolee <derrickstolee@github.com>
Cc:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, jrnieder@gmail.com,
        John Cai <johncai86@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Nov 30, 2022 at 4:16 PM Derrick Stolee <derrickstolee@github.com> w=
rote:
> > * Symrefs are refs too, but for some reason the packed-refs file
> > doesn't support them. Does packed-refs v2 support symrefs too?  If you
> > want to snapshot the state of refs, do you want to snapshot the value
> > of HEAD too?
>
> I forgot that loose refs under .git/refs/ can be symrefs. This definitely
> is a limitation that I should mention. Again, pseudorefs like HEAD are no=
t
> included and are stored separately, but symrefs within refs/* are not
> available in packed-refs (v1 or v2). That should be explicitly called out
> in the extensions.refFormat docs.
>
> I imagine that such symrefs are uncommon, and users can make their own
> evaluation of whether that use is worth keeping loose refs or not. We can
> still have the {files, packed[-v2]} extension value while having a
> writing strategy that writes as much as possible into the packed layer.

To be honest, I don't understand why symrefs are such a generic
concept; I've only ever seen them used for HEAD.

> > * By not changing reflogs, you are making things simpler. (if a
> > transaction updates the branch that HEAD points to, the reflog for
> > HEAD has to be updated too. Because reftable updates the reflog
> > transactionally, this was some extra work)
> > Then again, I feel the current way that reflogs work are a bit messy,
> > because directory/file conflicts force reflogs to be deleted at times
> > that don't make sense from a user-perspective.
>
> I agree that reflogs are messy. I also think that reflogs have different
> needs than the ref storage, so separating their needs is valuable.

If the reflog records the history of the ref database, then ideally,
an update of a ref should be transactional across the ref database and
the reflog. I think you can never make this work unless you tie the
storage of both together.

I can't judge how many hosting providers really care about this. At
google, we really care, but we keep the ref database and the refllog
in a global Spanner database. Reftable is only used for per-datacenter
serving. (I discovered some bugs in the JGit reflog code when I ported
it to local filesystem repos, because it was never exercised at
Google)

> > * There are a lot of commands that store SHA1s in files under .git/,
> > and access them as if they are a ref (for example: rebase-apply/ ,
> > CHERRY_PICK_HEAD etc.).
>
> Yes, I think these pseudorefs are stored differently from usual refs, and
> hence the {packed[-v2]} extension value would still work, but I'll confir=
m
> this with more testing.

They will work as long as you keep support for loose refs, because
there is no distinction between "a entry in the ref database" and "any
file randomly written into .git/ ".

> >> In this RFC, I propose a different model that allows for more customiz=
ation
> >> and incremental updates. The extensions.refFormat config key is multi-=
valued
> >> and defaults to the list of files and packed. In the context of this R=
FC,
> >> the intention is to be able to add packed-v2 so the list of all three =
values
> >> would allow Git to write and read either file format version (v1 or v2=
). In
> >> the larger scheme, the extension could allow restricting to only loose=
 refs
> >> (just files) or only packed-refs (just packed) or even later when reft=
able
> >> is complete, files and reftable could mean that loose refs are the pri=
mary
> >> ref storage, but the reftable format serves as a drop-in replacement f=
or the
> >> packed-refs file. Not all combinations need to be understood by Git, b=
ut
> >
> > I'm not sure how feasible this is. reftable also holds reflog data. A
> > setting {files,reftable} would either not work, or necessitate hairy
> > merging of data to get the reflogs working correctly.
>
> In this setup, would it be possible to continue using the "loose reflog"
> format while using reftable as the packed layer? I personally think this
> combination of formats to be critical to upgrading existing repositories
> to reftable.

I suppose so? If you only store refs and tags (and don't handle
reflogs, symrefs or use the inverse object mapping) then the reftable
file format is just a highly souped-up version of packed-refs.

> (Note: there is a strategy that doesn't need this approach, but it's a bi=
t
> complicated. It would involve rotating all replicas to new repositories
> that are configured to use reftable upon creation, getting the refs from
> other replicas via fetches. In my opinion, this is prohibitively
> expensive.)

I'm not sure I understand the problem. Any deletion of a ref (that is
in packed-refs) today already requires rewriting the entire
packed-refs file ("all or nothing" operation). Whether you write a
packed-refs or reftable is roughly equally expensive.

Are you looking for a way to upgrade a repo, while concurrent git
process may write updates into the repository during the update? That
may be hard to pull off, because you probably need to rename more than
one file atomically. If you accept momentarily failed writes, you
could do

* rename refs/ to refs.old/ (loose ref writes will fail now)
* collect loose refs under refs.old/ , put into packed-refs
* populate the reftable/ dir
* set refFormat extension.
* rename refs.old/ to refs/ with a refs/heads a file (as described in
the reftable spec.)

See also https://gerrit.googlesource.com/jgit/+/ca166a0c62af2ea87fdedf2728a=
c19cb59a12601/org.eclipse.jgit/src/org/eclipse/jgit/internal/storage/file/F=
ileRepository.java#734

> >> I mentioned earlier that I had considered using reftable as a way to a=
chieve
> >> the stated goals. With the current state of that work, I'm not confide=
nt
> >> that it is the right approach here.
> >>
> >> My main worry is that the reftable is more complicated than we need fo=
r a
> >> typical Git repository that is based on a typical filesystem. This mak=
es
> >> testing the format very critical, and we seem to not be near reaching =
that
> >> approach.
> >
> > I think the base code of reading and writing the reftable format is
> > exercised quite exhaustively tested in unit tests. You say 'seem', but
> > do you have anything concrete to say?
>
> Our test suite is focused on integration tests at the command level. Whil=
e
> unit tests are helpful, I'm not sure if all of the corner cases would be
> covered by tests that check Git commands only.

It's actually easier to test all of the nooks of the format through
unittests, because you can tweak parameters (eg. blocksize) that
aren't normally available in the command-line

> >> That might even help the integration process to allow the reftable for=
mat to
> >> be tested at least by some subset of tests instead of waiting for a fu=
ll
> >> test suite update.
> >
> > I don't understand this comment. In the current state,
> > https://github.com/git/git/pull/1215 already passes 922 of the 968
> > test files if you set GIT_TEST_REFTABLE=3D1.
> >
> > See https://github.com/git/git/pull/1215#issuecomment-1329579459 for
> > details. As you can see, for most test files, it's just a few
> > individual test cases that fail.
>
> My point is that to get those remaining tests passing requires a
> significant update to the test suite. I imagined that the complexity of
> that update was the blocker to completing the reftable work.
>
> It seems that my estimation of that complexity was overly high compared t=
o
> what you appear to be describing.

To be honest, i'm not quite sure how significant the work is: for
things like worktrees, it wasn't that obvious to me how things should
work in the first place. That makes it hard to make estimates. I
thought there might be a month of full-time work left, but these days
I can barely make a couple of hours of time per week to work on
reftable  if at all.

> > For deleting refs quickly, it seems that you only need to support
> > $ZEROID in packed-refs and then implement a ref database as a stack of
> > packed-ref files? If you're going for minimal effort and minimal
> > disruption wouldn't that be the place to start?
>
> I disagree that jumping straight to stacked packed-refs is minimal effort
> or minimal disruption.
>
> Creating the stack approach does require changing the semantics of the
> packed-refs format to include $ZEROID, which will modify some meanings in
> the iteration code. The use of a stack, as well as how layers are combine=
d
> during a ref write or also during maintenance, adds complications to the
> locking semantics that are decently complicated.
>
> By contrast, the v2 format is isolated to the on-disk format. None of the
> writing or reading semantics are changed in terms of which files to look
> at or write in which order. Instead, it's relatively simple to see from
> the format exactly how it reduces the file size but otherwise has exactly
> the same read/write behavior. In fact, since the refs and OIDs are all
> located in the same chunk in a similar order to the v1 file, we can even
> deduce that page cache semantics will only improve in the new format.
>
> The reason to start with this step is that the benefits and risks are
> clearly understood, which can motivate us to establish the mechanism for
> changing the ref format by defining the extension.

I believe that the v2 format is a safe change with performance
improvements, but it's a backward incompatible format change with only
modest payoff. I also don't understand how it will help you do a stack
of tables,
which you need for your primary goal (ie. transactions/deletions
writing only the delta, rather than rewriting the whole file?).

> > You're concerned about the reftable file format (and maybe rightly
> > so), but if you're changing the file format anyway and you're not
> > picking reftable, why not create a block-based, indexed format that
> > can support storing reflog entries at some point in the future too,
> > rather than build on (the limitations) of packed-refs?
>
> My personal feeling is that storing ref tips and storing the history of a
> ref are sufficiently different problems that should have their own data
> structures. Even if they could be combined by a common format, I don't
> think it is safe to transition every part of every ref operation to a new
> format all at once.
>
> Looking at reftable from the perspective of a hosting provider, I'm very
> hesitant to recommend transitioning to it because of how it is an "all or
> nothing" switch. It does not fit with my expectations for safe deployment
> practices.

You'd have to consult with your SRE team, how to do this best, but
here's my $.02. If you are a hosting provider, I assume you have 3 or
5 copies of each repo in diffrent datacenters for
redundancy/availability. You could have one of the datacenters use the
new format for while, and see if there are any errors or discrepancies
(both in terms of data consistency and latency metrics)

> * The reftable work needs its refs backend implemented, but your draft PR
>   has a prototype of this and some basic test suite integration. There ar=
e
>   54 test files that have one or more failing tests, and likely these jus=
t
>   need to be adjusted to not care about loose references.
>
> * The reftable is currently fundamentally different enough that it could
>   not be used as a replacement for the packed-refs file underneath loose
>   refs (primarily due to its integration with the reflog). Doing so would
>   require significant work on top of your prototype.

It could, but I don't see the point.

> I'm going to take the following actions on my end to better understand th=
e
> situation:
>
> 1. I'll take your draft PR branch and do some performance evaluations on
>    the speed of ref updates compared to loose refs and my prototype of a
>    two-stack packed-ref where the second layer of the stack is only for
>    deleted refs.

(tangent) - wouldn't that design perform poorly once the number of
deletions gets large? You'd basically have to rewrite the
deleted-packed-refs file all the time.

--=20
Han-Wen Nienhuys - Google Munich
I work 80%. Don't expect answers from me on Fridays.
--

Google Germany GmbH, Erika-Mann-Strasse 33, 80636 Munich

Registergericht und -nummer: Hamburg, HRB 86891

Sitz der Gesellschaft: Hamburg

Gesch=C3=A4ftsf=C3=BChrer: Paul Manicle, Liana Sebastian
