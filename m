Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1BAFC47080
	for <git@archiver.kernel.org>; Tue,  1 Jun 2021 16:54:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D2F96613B6
	for <git@archiver.kernel.org>; Tue,  1 Jun 2021 16:54:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233698AbhFAQ4Q (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 1 Jun 2021 12:56:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230288AbhFAQ4O (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 1 Jun 2021 12:56:14 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31744C061574
        for <git@vger.kernel.org>; Tue,  1 Jun 2021 09:54:33 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id ce15so3542231ejb.4
        for <git@vger.kernel.org>; Tue, 01 Jun 2021 09:54:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=klerks-biz.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6fL9gyCGBqX8XiilCvFbftGPRjms7upjmKhVRubTKOc=;
        b=hdWgb8JEZosGV+OiMbb1mba4VEX1J8EplHs6Wa57jFkXWjoyDd0RAcAeJJhXN5YAZn
         1vSA1+RadwBZMUHxGFSYnAhGHPDKOnR5cyJv0UrFrQrWCm1t74ogri9j8+dvLCLIznMi
         VQWWETN5Nr27ML+tNqjkZLtax0dazodX/Migbu+Y4nKVd6tBf62P8JEcAmrKiepBFttv
         NIKvc2+vbdmm7noU5TcEDxKr/tonXOAUJlZNRLrk7oQrb8N9hHYiWqyM0uCa+ws7S03h
         2eY9rGh5ux0sLwgBh6Ef9x9jiCeL2H/OhPzmSFtnouGufyiVIriHti8I7AzxpxpXkHOD
         cPyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6fL9gyCGBqX8XiilCvFbftGPRjms7upjmKhVRubTKOc=;
        b=FqvIPy69XS9wS+JjNLdxMDvFyY5QcCCB+VhB/MmvEMbO+sk0QeBSYgS8ruYfOqzsLw
         JiRJDS0yQOA5C+ibWM8Lzy/+0/7PdymyXppKeyDg+HmjSpjQaJFZ5uodCg0C0V7BNRx+
         k2/cs3FYsS06bWuRrX9MPyabYk4TsKORF63+IZwdGiqbSbECTuQRDFuQECfLlFH33ULL
         DTrQirLiP1dHq08BtZxxD2HYk27e1ijS4IzrgH8qsakizdSEbHR2nv2xPPLqGOgvixgH
         Bcug3hKWRTrTVtc1iB5josk/+n0ErUKV+Kgiv4PKh5U/b2NkU/mPIZuq1gmNiSQDGKTz
         YTgQ==
X-Gm-Message-State: AOAM530p4yiAz3+2BRsy1uTxlZNNCMfLW5DHedGglV/a2pDiSwuw5r9Z
        JBOKZnT+W+JHWwBbtEur2c82/fuwhGljt0T1lf3lEvcc0Urn2I3+gyY=
X-Google-Smtp-Source: ABdhPJz2JS8VMGFU/ZkygOMehZ1871SJC5fFXPjnOKX+ucJVRXF+w55gweHZOgEBEM61wR6ScWxTVLHt36XRd8+EUbA=
X-Received: by 2002:a17:907:6ef:: with SMTP id yh15mr5850204ejb.151.1622566471630;
 Tue, 01 Jun 2021 09:54:31 -0700 (PDT)
MIME-Version: 1.0
References: <CAPMMpoim38J3=4pd0_fM2h=DN_PrEE_Osg2duU5Ur8WUZ5S1Pg@mail.gmail.com>
 <032cabb2-652a-1d88-2e12-601b40a4020c@gmail.com> <CAPMMpohOuXX-0YOjV46jFZFvx7mQdj0p7s8SDR4SQxj5hEhCgg@mail.gmail.com>
 <0b57cba9-3ab3-dfdf-5589-a0016eaea634@gmail.com>
In-Reply-To: <0b57cba9-3ab3-dfdf-5589-a0016eaea634@gmail.com>
From:   Tao Klerks <tao@klerks.biz>
Date:   Tue, 1 Jun 2021 18:54:20 +0200
Message-ID: <CAPMMpoi_XSLJXtxGD74r-uoao+Z6Xcg8xkXuZCYix4=tBWD8rw@mail.gmail.com>
Subject: Re: Removing Partial Clone / Filtered Clone on a repo
To:     Derrick Stolee <stolee@gmail.com>
Cc:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jun 1, 2021 at 3:40 PM Derrick Stolee <stolee@gmail.com> wrote:
> > you want to be able to get something useful to the user as fast as
> > possible [...] but where a user might later (eg overnight) want to get the
> > rest of the repo, to avoid history inconsistency issues.
>
> As you describe below, the inconsistency is in terms of performance,
> not correctness. I thought it was worth a clarification.

Sorry I was not clear here - I did not mean formal correctness nor
performance, when referring to the incentive to get the rest of the
repo - I was referring to the fact that a medium-shallow clone (eg 15
months of a 20-year project) provides an inconsistent perspective on
the code history:
 * On the one hand, most of the time you have everything you need, and
when you bump up against *available* history limits from a file or
branch history view, it's reasonably clear that's what's happening (in
some UI tools this is more explicit than in others).
 * On the other hand, when you happen to look at something older, it
is easy for the history to seem to "lie", showing changes made in a
file by a person that really *didn't* make those changes. Their commit
just happened to be selected as the shallow graft, and so seems to
have "added" all the files in the project. This reasonably
intelligible when looking at file history, but extremely non-obvious
when looking at git blame (in a medium-shallow clone).

> I'm aware that the first 'git blame' on a file is a bit slow in the
> partial clone case.

Without wanting to harp on about it, it can easily be pathologically
slow, eg in my case a random well-trafficked file has 300 in-scope
commits, at 10 seconds per independent blob fetch - and so ends up
taking an hour to git blame (the first time for such a file, as you
noted).

> It's been on my list for improvement whenever I
> get the "spare" time to do it. However, if someone else wants to work
> on it I will briefly outline the approach I was going to investigate:

One reason I wasn't asking about / angling for this, particularly, is
that I expect there will be other tools doing their own versions of
this. I haven't tested "tig" on this, for example, but I suspect it
doesn't do a plain git blame, given what I've seen of its instantly
showing the file contents and  "gradually" filling in the authorship
data. I for one rarely use plain git blame, I don't know much about
the usage patterns of other users. Most of "my" users will be using
Intellij IDEA, which seems to have a surprisingly solid/scalable git
integration (but I have not yet tested this case there yet)

There also other related reasons to go for a "get most of the relevant
blobs across history" approach, specifically around tooling: there are
lots of tools & integrations that use git libraries (or even homebrew
implementations) rather than the git binaries / IPC, and many of those
tend to lag *far* behind in support for things like shallow clone,
partial clone, mailmap, core.splitindex, replace refs, etc etc. My
current beef is with Sublime Merge, which is snappy as one could wish
for, really lovely to use within its scope, but doesn't have any idea
what a promisor is, and simply says "nah, no content here" when you
look at a missing blob. (for the moment)

> > the most "blameable"
> > files will tend to be the larger ones... :)
>
> I'm interested in this claim that 'the most "blameable" files will
> tend to be the larger ones.' I typically expect blame to be used on
> human-readable text files, and my initial reaction is that larger
> files are harder to use with 'git blame'.

Absolutely, I meant "the larger text/code files", not including other
stuff that tends to accumulate in the higher filesize brackets. I
meant that I, for one, in this project at least, often find myself
using git blame (or equivalent) to "spelunk" into who touched a
specific line, in cases where looking at the plain history is useless
because there have been many hundreds or thousands of changes - and in
my limited experience, files with that many reasons to change tend to
be large.

> Your concern about slow commands is noted, but also blindly
> downloading every file in history will slow the repo due to the
> full size of the objects on disk.

I have in the past claimed that "larger repo" (specifically, a deeper
clone that gets many larger blobs) is slower, but haven't actually
found any significant evidence to back my claim. Obviously something
like "git gc" will be slower, but is there anything in the practical
day-to-day that cares whether the commit depth is 10,000 commits or
200,000 commits for a given branch, or whether you only have the blobs
at the "tip" of the branch/project, or all the blobs in history?
(besides GC, specifically)

> it would be good to design such a feature to have other
> custom knobs, such as:
> * Get only "recent" history, perhaps with a "--since=<date>"
>   kind of flag. This would walk commits only to a certain date,
>   then find all missing blobs reachable from their root trees.

As long as you know at initial clone time that this is what you want,
combining shallow clone with sparse clone already enables this today
(shallow clone, set up filter, unshallow, and potentially remove
filter). You can even do more complicated things like unshallowing
with different increasingly-aggressive filters in multiple
steps/fetches over different time periods. The main challenge that I
perceive at the moment is that you're effectively locked into "one
shot". As soon as you've retrieved the commits with blobs missing,
"filling them in" at scale seems to be orders of magnitude more
expensive than an equivalent clone would have been.

> If we had a refiltering feature, then you could even
> start with a blobless clone to have an extremely fast initial
> clone, followed by a background job that downloads the remaining
> objects.

Yes please!


I think one thing that I'm not clearly understanding yet in this
conversation, is whether the tax on explicit and specialized blob list
fetching could be made much lower. As far as I can tell, in a blobless
clone with full trees we have most of the data one could want, to
decide what blobs to request - paths, filetypes, and commit dates.
This leaves three pain points that I am aware of:
* Filesizes are not (afaik) available in a blobless clone. This sounds
like a pretty deep limitation, which I'll gloss over.
* Blob paths are available in trees, but not trivially exposed by git
rev-list - could a new "--missing" option value make sense? Or does it
make just as much sense to expect the caller/scripter to iterate
ls-tree outputs? (I assume doing so would be much slower, but have not
tested)
* Something about the "git fetch <remote> blob-hash ..." pattern seems
to scale very poorly - is that something that might see change in
future, or is it a fundamental issue?


Thanks again for the detailed feedback!
Tao
