Return-Path: <SRS0=tbmj=EA=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74257C2D0A3
	for <git@archiver.kernel.org>; Sun, 25 Oct 2020 00:09:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1CD40222C3
	for <git@archiver.kernel.org>; Sun, 25 Oct 2020 00:09:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DPidM1Kt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1762979AbgJYAGF (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 24 Oct 2020 20:06:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731873AbgJYAGE (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 24 Oct 2020 20:06:04 -0400
Received: from mail-oo1-xc29.google.com (mail-oo1-xc29.google.com [IPv6:2607:f8b0:4864:20::c29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD43FC0613CE
        for <git@vger.kernel.org>; Sat, 24 Oct 2020 17:06:04 -0700 (PDT)
Received: by mail-oo1-xc29.google.com with SMTP id v123so1505745ooa.5
        for <git@vger.kernel.org>; Sat, 24 Oct 2020 17:06:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hoCCtTM2e7gN3MJnE7uj70v6PjKq11/csxTf/jp7JXU=;
        b=DPidM1KtCYqg4gD3c8hJvBuwi+FyrmIH8vDBqc1kuySlLxmo4k2QLUy6D/OjH82Ny0
         NQcWL/FqG8uQeN0mj6qprs8QWvjhotCh+l2SUJR2hcU5NRcuixwgS7vYEz8SG8s1FUAK
         4r1q/XYiH4N709cjqX1rdFdQgrJPh0UOda2ynUf0lDyvB9ZjQM7s6Qn/wMRP4V4V+CCj
         7XtBYyiFl37Ml/hTqAm4PPYJi+ttwxlHMxsVx+50oUO132uyxBr3BdRqZNncwkuKtOBI
         iRxkisKIJ7Ipw4DvQ6sxavGVXCJtUmOZVsFlbYGuKV0oQdsYgheb29+Oa3RfU4DMW0GG
         iTAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hoCCtTM2e7gN3MJnE7uj70v6PjKq11/csxTf/jp7JXU=;
        b=uRCq861duog8BH0i23vy52dLya4HFNbrTMVRVXQRtvAHUMxNwbYRpgrpyypSKn3WG3
         n4oaRypQ+krVThUexTOjnrczre2WMIag89NKwe43/zJPcqdNxtq5bOWyjpC0RKzGaUrM
         U4rHu8DmBoUvPJYsawiueY4aNnpeWoCPzZ/PTQ22boJG5Dd98ORkOPWHYaWySwqnZCxQ
         YimXmXBPYvyVxJDtRozYuqpxcxZmydFiklV8TQdFNOrg6u4cEXT8XVT5xuVsNn6rFGF+
         6ZprRweKLYDU+NBScV1sYh6tfv5ceR3Uz64p0c1vlxhBlNkav34r1YDrF7BPDqZaj5P0
         HT/g==
X-Gm-Message-State: AOAM533AqtNZ3VlCfGJ+cGn2v2jARYacxANr8zXinB8JVmAGkjNkJzT5
        ONEF7lfxd4piPPURa+l+zuN6IMOHhq5t7SzVxOX/TebVrcUmew==
X-Google-Smtp-Source: ABdhPJyHOkpinunZ99Ht0rnH7IwKiHRavVlXJWFzBgUweX7bWsaPC4BFkMYB6aX6MRe0cF2aWd4gHvsktobQ6uLEWAQ=
X-Received: by 2002:a4a:b308:: with SMTP id m8mr8100792ooo.7.1603584363482;
 Sat, 24 Oct 2020 17:06:03 -0700 (PDT)
MIME-Version: 1.0
References: <CAD6JFnNX03MLBSUjdTjvK1TsBR-sntqgXMDKR9z2OjdUKBERKQ@mail.gmail.com>
In-Reply-To: <CAD6JFnNX03MLBSUjdTjvK1TsBR-sntqgXMDKR9z2OjdUKBERKQ@mail.gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Sat, 24 Oct 2020 17:05:52 -0700
Message-ID: <CABPp-BF80aMFWgNdr_seQkj+UvZ3=hPoT3cv5bxNhE1APCmCkQ@mail.gmail.com>
Subject: Re: Please explain why this merge ignored changes from one branch in
 favor of another rather than showing a conflict
To:     Johnathon Wright <jw@mustmodify.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

On Sat, Oct 24, 2020 at 2:39 PM Johnathon Wright <jw@mustmodify.com> wrote:
>
> Your Excellencies:

I'll respond despite not being one of the ones to whom your email was
addressed...  ;-)

> I'm a new tech lead trying to figure out what caused a significant
> production issue. I want to know why the merge described below
> discards the content of a certain file from one branch and uses
> content from another branch, while saying that the file was "added by
> them". More importantly, I want to know how to prevent this in the
> future.

Well, I've got bad news and good news for you, but mostly bad news...

> DETAILS
>
> A dev wrote a feature across many files, including
> app/events/checkout_event.rb. Once merged and deployed, it was
> discovered that his changes to that file didn't make it to
> production... but many other changes from the same commit(s) did make
> it.
>
> After much research, we have isolated the issue to a specific ref -- a
> merge. It appears that, during the merge where both branches had
> changed that file, git decided to throw out changes to a from one
> branch and to use the other branch.

This doesn't quite match what you show below.  git _did_ report a
conflict for this path, and left the user to resolve.  Granted, there
was content on the other side that git should have notified the user
about with the conflict to make the conflict easier to resolve, but
git did not "decide" how this path should be resolved and it
explicitly marked it as conflicted.

All that said, I do lay the blame mostly at git's feet and not to your
developers here.  Being unable to correctly detect and report a
rename/add/delete conflict and misreporting it as a rename/delete,
with only one side's content shown does seem likely to lead to this
kind of error.  Someone would have to be very cautious in inspecting
the conflicts to resolve this correctly.

> I created three tags so my small brain didn't have to remember refs:
> * "working" (aa29d0f4)
> * other_parent (7f9ebfa5).
> * broken (ccbeb88)
>
> ----
> jw@logopolis:/projects/unity/atlantis$ git show broken
>
> commit cbbeb883428a468e9c906c646becdf751ecff99a (broken)
> Merge: 7f9ebfa5 aa29d0f4
> Author: Johnathon Wright <jw@mustmodify.com>
> Date:   Fri Oct 16 13:17:43 2020 -0400
>
>     merge
>
> ...
> ----
>
> 'git show broken' doesn't show any changes to the file in question.

That's because git doesn't show file changes within a merge regardless
of whether someone tweaked the merge commit by modifying every single
file.  You would need to add --cc or something to see some of the
differences.  Or, when --remerge-diff is complete then you'd be able
to use it, but it's still only half-baked.

> Here, you can see that the files were different:
>
> ----
> jw@logopolis:/projects/unity/atlantis$ git ls-tree working
> app/events/checkout_event.rb
>
> 100644 blob 077013dc52f03b336143b892c1468516cae29dce
> app/events/checkout_event.rb
> ----
>
> and
>
> ----
> jw@logopolis:/projects/unity/atlantis$ git ls-tree other_parent
> app/events/checkout_event.rb
>
> 100644 blob 21b3d4e9b5ac4903c2aadbed28ab5b60eb77e8ce
> app/events/checkout_event.rb
> -----

This doesn't state what version of the file existed in the merge base,
or merge bases.  How many merge bases where there between these two
commits?  What version(s) of the file existed in that commit (or those
commits)?  (I think I can deduce the answer from the conflicts below,
though, so don't worry too much about answering this.)

> Then I tried to reproduce the merge:
>
> ----
> jw@logopolis:/projects/unity/atlantis$ git checkout working
>
> HEAD is now at aa29d0f4 Track instances of price changing
>
> jw@logopolis:/projects/unity/atlantis$ git merge other_parent
...
> CONFLICT (rename/delete): app/events/single_payment_event.rb deleted
> in HEAD and renamed to app/events/checkout_event.rb in other_parent.
> Version other_parent of app/events/checkout_event.rb left in tree.
...


> jw@logopolis:/projects/unity/atlantis$ git status
...
>         added by them:   app/events/checkout_event.rb
...
>
> note that even though app/events/checkout_event.rb exists in both the
> "working" and "other_parent" branches, git here says "added by them".
>
> Note that "working" and "other_parent" both have parent nodes which
> rename the file in question from something else TO
> app/events/checkout_event.rb (same for the spec.) The two ancestors
> have different refs but the same datetime and commit message.

Yes, but in particular I think that git won't detect the rename on one
of the two sides of history because the file has been modified too
much.

> This might also be of interest, or perhaps not.
>
> ----
> jw@logopolis:/projects/unity/atlantis$ git diff working..broken --
> app/events/checkout_event.rb | grep "^-" | wc -l
>
> 158
>
> jw@logopolis:/projects/unity/atlantis$ git diff working..broken --
> app/events/checkout_event.rb | grep "^+" | wc -l
>
> 51

It'd be more helpful to see the output of both (note: three dots, not two)
   git diff --name-status working...broken | grep -e checkout_event.rb
-e single_payment_event.rb
   git diff --name-status broken...working | grep -e checkout_event.rb
-e single_payment_event.rb

I suspect the output looks like
    R071    single_payment_event.rb   checkout_event.rb
for one of those two commands (with the number 071 likely changing),
and for the other it looks like
    A       checkout_event.rb
    D       single_payment_event.rb

In other words, the files were similar enough on one branch to detect
the rename, but not on the other.  You could tweak this with git diff
--find-renames=<percentage> ..., and tweak it for the merge with git
merge -Xfind-renames=<percentage>, but that's just attempting to work
around the problem.

> ----
>
> Final bit of information:
>
> ----
> jw@logopolis:/projects/unity/atlantis$ git --version
>
> git version 2.17.1
> ----

This is pretty old version of git so I'd like to encourage you to
upgrade...but it won't help with this bug.  This bug is present in all
released git versions; it's test t6422.17 in our testsuite, marked as
test_expect_failure.

> So, why does git say that this file was "added by them" instead of
> saying it had a conflict that needed merging?

Bug.

> It has been suggested that this might have something to do with some
> team members using merge and others using rebase. Or possibly rebasing
> shared history. I don't know how to determine whether that's the case
> or whether that might have caused this.
>
> If so, I would appreciate seeing a set of instructions from a blank
> repo that cause this same thing to happen, so that I can help my team
> to understand the situation and how it can be avoided.

Nope, git bug.  You can create a simple repository and trigger it
pretty easily, as follows:

# Create testcase in new temporary repo
git init stupid
cd stupid/
seq 10 20 >original.file
git add original.file
git commit -m Initial
git branch A
git branch B
git checkout A
git mv original.file new.file
seq 5 21 >new.file
git add new.file
git commit -m "Change on A"
git checkout B
git mv original.file new.file
seq 10 50 >new.file
git add new.file
git commit -m "Change on B"

# Switch to branch A and merge B in
git checkout A
git merge B

> If it is not related to rebasing and then merging, any help would be
> appreciated in diagnosing this issue.

Okay, so I said I had bad news and good news.  The good news: this
testcase passes if you use a special version of git -- the 'ort'
branch of my fork of git at https://github.com/newren/git.  I am
working on pushing this upstream; see e.g.
https://lore.kernel.org/git/a8d4825a323d5c1e7b2dc1edc8621c51c030ae1e.1603468885.git.gitgitgadget@gmail.com/
which marks t6422.17 as passing under the new ort merge backend.  But
unless you want to download someone's randomly tweaked git version
with hundreds of patches, and build and use it, you might want to wait
for it to go through the review process first.  But, at least a
solution is on it's way...

Hope that helps,
Elijah
