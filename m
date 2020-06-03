Return-Path: <SRS0=EE6k=7Q=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33C01C433E0
	for <git@archiver.kernel.org>; Wed,  3 Jun 2020 01:35:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 07636206E9
	for <git@archiver.kernel.org>; Wed,  3 Jun 2020 01:35:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jhZTvWkU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728299AbgFCBf1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 2 Jun 2020 21:35:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726894AbgFCBf0 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 2 Jun 2020 21:35:26 -0400
Received: from mail-ot1-x335.google.com (mail-ot1-x335.google.com [IPv6:2607:f8b0:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E7BAC08C5C0
        for <git@vger.kernel.org>; Tue,  2 Jun 2020 18:35:25 -0700 (PDT)
Received: by mail-ot1-x335.google.com with SMTP id g25so546396otp.13
        for <git@vger.kernel.org>; Tue, 02 Jun 2020 18:35:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ajSFv/+CBE8YXJqA9HdVsQqialydhPLPyEJcktn8Q8I=;
        b=jhZTvWkUJ+finv3jNFBJqdXEi3jnpNm83dh65KzfwFgcupCl5Smf3gAOordfwsrXV4
         gjc5wXC3FWTjmWUwMUSyPl9b5xlajHkGJjcNnIK8wdIhJ8El0dwMCI/DvSzRLrjqW0qW
         DmFSHfWJLc8vH2LpYgxAazWpF9UltmufuRO4d0SEvJ1EiJk8RwZFB2eYhzqqtNZY3x4H
         sDgjoSPcFGUpGaqJNPkBybZYy7puDnzXDUHkxz5IQmO1aij9HcN0W3+0B+OhCcx8q108
         mh920cq0MmzvS6PFteqj4RbH3UQv5ZmFFwciOmi18nw22gEE/u+bIFa3pRoXMkRDxpdX
         BbgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ajSFv/+CBE8YXJqA9HdVsQqialydhPLPyEJcktn8Q8I=;
        b=p/wnpsUP653ivbfjD4KVzFEpMe8ngTxPZWrcqD5Oe7I9KwSdek408X3Za5+krsy8Tq
         eU/mLfRr7ObXS8IwjPDtUfhsGcesyWYcTJXD3DqeEzhPFBqW/D068JHKlZzVB2aS3Xae
         Isyt6Un/b4V/OfX5DEVefAuAcaNHAEkntvae+q2tFVgV2pysBgSQgw4qqz+P36RD7AMw
         fKUpSZFokOtDEBvY8vRbH/nS6VHWovCt8RkXqReY0UL7/PGbHy4HDTpuWXuw6nsAqNgl
         d61DU/dUKxDB4RlkiotWpuYrN/JcLwJVwQfC+O/6sDCMf893YzUQ4wdyj5r1Om7SAv6n
         FUWw==
X-Gm-Message-State: AOAM530+WD6OfvPGxMe36+j6PsTYnyRmBjKlPPCHVgCqieHZTLQ7nqUD
        H1dvTLeGknhDlui2C2mBwffVi6nTG5B1s+/meHs=
X-Google-Smtp-Source: ABdhPJxIyaMwjHoWVg6LuxhseEGlRZhbVGSZAyqX5xURrIulgDpniL9esKAq1JT4x/w+WgbjUwqmx7O99clOO63k/jY=
X-Received: by 2002:a05:6830:4c3:: with SMTP id s3mr1534878otd.162.1591148124361;
 Tue, 02 Jun 2020 18:35:24 -0700 (PDT)
MIME-Version: 1.0
References: <CABPp-BEswHLhymQ1_07g3qqu=7kFR3eQyAHR0qMgSvi6THy=zQ@mail.gmail.com>
 <29e6c05e-2d79-d2ac-a033-dab6342ebcaa@gmail.com>
In-Reply-To: <29e6c05e-2d79-d2ac-a033-dab6342ebcaa@gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Tue, 2 Jun 2020 18:35:13 -0700
Message-ID: <CABPp-BGH=uqOP2x5w4ghLBv1sUiyKwdj1ox8kJKrELOp_OhudQ@mail.gmail.com>
Subject: Re: Huge push upload despite only having a tiny change
To:     Derrick Stolee <stolee@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Jonathan Nieder <jrnieder@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jun 2, 2020 at 12:40 PM Derrick Stolee <stolee@gmail.com> wrote:
>
> On 6/2/2020 3:21 PM, Elijah Newren wrote:
> > * The user was two commits behind the closely-related branch at the
> > time of the first push, and 10 commits behind at the time of the
> > second push.  Running format-patch on these 10 commits that were on
> > the server at the time shows their size is at most about ~55 k.
>
> This is most-likely the difference, since the pack-objects algorithm
> only looks at the _boundary_ between the server's commits and the
> commits-to-push. This also could have dramatically changed the delta-base
> matches.
>
> Do you have exact object counts? It would help to know if somehow the
> object discovery algorithm is at fault or the delta-base algorithm
> is to blame.

Output from the users' terminal for the two different runs, just
redacting URLs.  The first push was:

Enumerating objects: 23, done.
Counting objects: 100% (23/23), done.
Delta compression using up to 16 threads
Compressing objects: 100% (7/7), done.
Writing objects: 100% (12/12), 952 bytes | 952.00 KiB/s, done.
Total 12 (delta 5), reused 0 (delta 0), pack-reused 0
remote: Resolving deltas: 100% (5/5)
remote: Processing changes: refs: 1, new: 1, done
remote: commit 5efcf04: warning: subject >50 characters; use shorter
first paragraph
remote:
remote: SUCCESS
remote:
remote:   https://gerrit.internal.site/c/path/to/repo/+/341489 Remove
ambiguous method from ArtifactProducerPeeringService [NEW]
remote:
To gerrit.internal.site:path/to/repo.git
 * [new branch]                HEAD -> refs/for/develop

The second was:

Enumerating objects: 325816, done.
Counting objects: 100% (266559/266559), done.
Delta compression using up to 16 threads
Compressing objects: 100% (102457/102457), done.
Writing objects: 100% (257630/257630), 102.88 MiB | 619.00 KiB/s, done.
Total 257630 (delta 122169), reused 218776 (delta 87259), pack-reused 0
remote: Resolving deltas: 100% (122169/122169)
remote: Processing changes: refs: 1, updated: 1, done
remote: commit 360a266: warning: subject >50 characters; use shorter
first paragraph
remote:
remote: SUCCESS
remote:
remote:   https://gerrit.internal.site/c/path/to/repo/+/341489 Remove
ambiguous method from ArtifactProducerPeeringService
remote:
To gerrit.internal.site:path/to/repo.git
 * [new branch]                HEAD -> refs/for/develop

> For instance, `pack.useSparse` was enabled by default this release,
> and has some opportunity to push extra objects. See [1] for more
> details on both the "boundary" description (the "commit frontier")
> but also how that option changes the algorithm.
>
> The only case I know of that could lead to sending extra objects
> (that was not the case before) is described in t5322-pack-objects-sparse.sh
> and 4f6d26b1 (list-objects: consume sparse tree walk, 2019-01-16).
> It involves doing a full _copy_ of a tree from one position to
> another, without "disturbing" the parent of the original tree.
>
> (I mean: copy directory A/B to C/D and make sure nothing is
> different in directory A.)
>
> However, if these two pushes were with the same config setting,
> I'm not sure what could have changed between the pushes to hit
> this very narrow case.

So, after a day of attempting to figure out how to debug, I found out
we had a backup of the server between the first and second pushes and
fairly close to the second push.  I was able to launch a separate VM
of that backup, and then attempt to make a local repo that I hoped
mimic what the user had.  I can't duplicate the 100MB push (which is
about 25000x bigger than expected) as the user did, but I can with
some tweaking state that the push size should be closer to ~2.5 KB and
I can readly duplicate pushes in the 4-6 MB range -- i.e. about 1000x
bigger than expected.  pack.useSparse affects things, but not much.
So, some output of my own duplication attempts:

First, if I do a git fetch of the 'develop' branch (I can even nuke
.git/FETCH_HEAD afterwards; it only matters that I have the history
locally) from the place I'm pushing to, then the push size is tiny as
expected:

<Go to server, use rsync to make a pristine copy of repo>
<Go to server, rsync repo from pristine state, then on my laptop:>

$ git fetch git_over_ssh_url develop
$ rm .git/FETCH_HEAD
$ time git push git_over_ssh_url mike-push:refs/for/develop
Enumerating objects: 37, done.
Counting objects: 100% (37/37), done.
Delta compression using up to 8 threads
Compressing objects: 100% (11/11), done.
Writing objects: 100% (22/22), 2.54 KiB | 2.54 MiB/s, done.
Total 22 (delta 7), reused 14 (delta 1), pack-reused 0
remote: Checking connectivity: 22, done.
To git_over_ssh_url
 * [new branch]                mike-push -> refs/for/develop

real 0m13.044s
user 0m0.202s
sys 0m0.146s

<Remove the pack downloaded from the earlier fetch of develop>
<Without this step, I always get small pushes:>
$ ls -rt .git/objects/pack/ | tail -n 2 | xargs -n 1 -IPATH rm
.git/objects/pack/PATH

<Go to server, rsync repo from pristine state, then on my laptop:>
$ time git push git_over_ssh_url mike-push:refs/for/develop
Enumerating objects: 40785, done.
Counting objects: 100% (20543/20543), done.
Delta compression using up to 8 threads
Compressing objects: 100% (9032/9032), done.
Writing objects: 100% (16685/16685), 6.27 MiB | 208.00 KiB/s, done.
Total 16685 (delta 7103), reused 12412 (delta 3389), pack-reused 0
remote: Resolving deltas: 100% (7103/7103), completed with 1864 local objects.
remote: Checking connectivity: 22, done.
To git_over_ssh_url
 * [new branch]                mike-push -> refs/for/develop

real 0m59.703s
user 0m3.139s
sys 0m0.735s

<Also, this is only slightly affected by pack.useSparse...>
<Go to server, rsync repo from pristine state, then on my laptop:>
$ time git -c pack.useSparse=false push git_over_ssh_url
mike-push:refs/for/develop
Enumerating objects: 39891, done.
Counting objects: 100% (18953/18953), done.
Delta compression using up to 8 threads
Compressing objects: 100% (7687/7687), done.
Writing objects: 100% (14991/14991), 4.85 MiB | 228.00 KiB/s, done.
Total 14991 (delta 6665), reused 11301 (delta 3141), pack-reused 0
remote: Resolving deltas: 100% (6665/6665), completed with 1939 local objects.
remote: Checking connectivity: 22, done.
To git_over_ssh_url
 * [new branch]                mike-push -> refs/for/develop

real 0m49.295s
user 0m2.362s
sys 0m0.592s


Finally, you'll note that when I was reproducing, things were a bit
different than what Mike (the end user) was dealing with.  I was using
vanilla git-2.27.0.  Also, on the server, I was using plain old
git-over-ssh, with the server running git-2.19.0.  However, I also
tried it with gerrit (i.e. jgit) as the server and got identical
numbers for enumerating objects, counting objects, compressing
objects, and the size of the pushed data and the number of resolved
deltas was within 1% of the git-over-ssh case.  And that was also true
both with and without pack.useSparse.

Any ideas?  Anything else I should try or provide data on?
