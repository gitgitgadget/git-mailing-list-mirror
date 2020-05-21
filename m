Return-Path: <SRS0=Ny9l=7D=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C351DC433DF
	for <git@archiver.kernel.org>; Thu, 21 May 2020 17:19:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9C2AC20759
	for <git@archiver.kernel.org>; Thu, 21 May 2020 17:19:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mxTIuhnB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728730AbgEURTK (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 21 May 2020 13:19:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728456AbgEURTK (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 May 2020 13:19:10 -0400
Received: from mail-ot1-x344.google.com (mail-ot1-x344.google.com [IPv6:2607:f8b0:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 208E6C061A0E
        for <git@vger.kernel.org>; Thu, 21 May 2020 10:19:10 -0700 (PDT)
Received: by mail-ot1-x344.google.com with SMTP id o13so6107913otl.5
        for <git@vger.kernel.org>; Thu, 21 May 2020 10:19:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=keVJkeNzr7fFTx6uNE1zhGwPMN6GtEOf0nmeZvXOeWk=;
        b=mxTIuhnB8rGdA+RGntDXEMcJLnnwrkYT5GHLsOJpGefTcs4BY2kWkOj8aZXzFP5/+/
         hHP88YaffxKTH64X7Ttkf1zSjhEaVhU8jUfCt7PzMOzZJOmNBhsazRapE3uvSn3t+8oR
         eEEEVxhS40dya/qSoFzCGrWTHo3RLpjweckoEmiRITrggkrMj5K1012+XNwyeLZU3QLa
         5HoeSEJ3Ir/CvWviD5voPw2EsUIwumeEkPEHokBgNQ+fSGQIMiUieyaGkEw8S10mG+6R
         ALWeGlYlvSpY4qbaba8aE/zBB58GjyTn6xpQ6FYyJB3HPbaOT/OsDfHL5mw4frsbcNWG
         NZjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=keVJkeNzr7fFTx6uNE1zhGwPMN6GtEOf0nmeZvXOeWk=;
        b=PVynpvKBxhlEd4scVymqIGdqDE+vjqu4y4++HHIk3xj2g2lzzZvSaSw4pFV0ugfjej
         vl+BPiBgS5CoQAWyxMyrxxTIJWgZmY8CNaMUYX6cHjVow0T6pasdS8JonO/cuN6K6x5P
         1KIwA9sfLbxDGGiW5LT4/a0kVFuTkCWyjc86hJtPon6kP/bEcXXuuUwWIQ6m2EOFFkEC
         z3QJgPJ/pElZ/jGVwyDZonJH+Fb1Dlk8N8Nw6t/IrjV3S903TXHYa9hvKHwIMJjJBX2j
         /RwGstdkW78o2EzyPmaESp8Oyg4s1VKl9Lx3dse9Limji+MgjyQWaT/8OPjm+/S6GIs9
         dxSQ==
X-Gm-Message-State: AOAM531HDX+K426uEDQ04qEyItoj96MFOFK1vmrGoqWNZkN5pz3KhbWx
        qZKAJcTJGJB6DnMPp0zE57jwlt5Bn/DcRhPbxC0=
X-Google-Smtp-Source: ABdhPJzRe1BjneSxt5xy7ms0AxWzdL8GdaY2KbQFXNvWFo9Qe3UvEdxCdTv2hXRBZNBU6iwak1Cc8dpbJhrXzqgHK40=
X-Received: by 2002:a9d:7998:: with SMTP id h24mr5036660otm.316.1590081549218;
 Thu, 21 May 2020 10:19:09 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1589058209.git.matheus.bernardino@usp.br>
 <3e9e90624901113fd5c5670c0c2023c709f71d6d.1589058209.git.matheus.bernardino@usp.br>
 <CAHd-oW6-A6_3FTskMWHvD5=23SLRFU19s2JrYMx3f94i-uB27Q@mail.gmail.com>
In-Reply-To: <CAHd-oW6-A6_3FTskMWHvD5=23SLRFU19s2JrYMx3f94i-uB27Q@mail.gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Thu, 21 May 2020 10:18:57 -0700
Message-ID: <CABPp-BFKHivKffBPO0M_s-JtpiLyEMLZr+sX9_yZk9ZX7ULtbw@mail.gmail.com>
Subject: Re: [RFC PATCH v2 4/4] config: add setting to ignore sparsity
 patterns in some cmds
To:     Matheus Tavares Bernardino <matheus.bernardino@usp.br>
Cc:     git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <stolee@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, May 9, 2020 at 9:23 PM Matheus Tavares Bernardino
<matheus.bernardino@usp.br> wrote:
>
> On Sat, May 9, 2020 at 9:42 PM Matheus Tavares
> <matheus.bernardino@usp.br> wrote:
> >
> > diff --git a/t/t7817-grep-sparse-checkout.sh b/t/t7817-grep-sparse-checkout.sh
> > index 3bd67082eb..8509694bf1 100755
> > --- a/t/t7817-grep-sparse-checkout.sh
> > +++ b/t/t7817-grep-sparse-checkout.sh
> > @@ -63,12 +63,28 @@ test_expect_success 'setup' '
> >         test_path_is_file sub/B/b
> >  '
> >
> > +# The two tests bellow check a special case: the sparsity patterns exclude '/b'
> > +# and sparse checkout is enable, but the path exists on the working tree (e.g.
> > +# manually created after `git sparse-checkout init`). In this case, grep should
> > +# honor --restrict-to-sparse-paths.
>
> I just want to highlight a small thing that I forgot to comment on:
> Elijah and I had already discussed about --restrict-to-sparse-paths
> being relevant in grep only with --cached or when a commit-ish is
> given. But it had not occurred to me, before, the possibility of the
> special case mentioned above. I.e. when searching in the working tree
> and a path that should be excluded by the sparsity patterns is
> present. In this patch, I let --restrict-to-sparse-paths control the
> desired behavior for grep in this case too. But please, let me know if
> that doesn't seem like a good idea.

Wow, that is an interesting edge case.  But it can come up during a
merge or rebase or checkout -m, could be manually changed by various
plumbing commands, and might just not be enforced well in various
areas of the system (see e.g. [1]).  Perhaps the most interesting
case, given recent discussion, is submodules -- those might be left in
the working tree despite not matching sparsity paths.  So, should `git
-c sparse.restrictCmds=true grep PATTERN` look at these paths or not?
Currently, you've chosen contradictory answers -- yes to submodules,
and no to other entries.  I'm not certain here, but I've given it a
little thought and think there's a few things to take into
consideration:

Users are used to the fact that
    grep -r PATTERN *
searches existing files for PATTERN.  If you delete a file, then a
subsequent grep isn't going to search through it.  Similarly, git grep
is billed as a grep which limits searches to tracked files, thus they
expect
    git grep PATTERN
to search for files in their working copy but limiting it to files
which are tracked.  From this angle, I think users would be surprised
if `git grep` searched through deleted files, and they would also be
surprised if it ignored tracked and present files.

That is a basic answer, but let's go a bit further.  Since git grep
also has history at its disposal, it has more options.  For example:
    git grep REVISION PATTERN
means to search through all tracked files (those are the only kinds
that are recorded in revisions anyway) as of REVISION for the given
PATTERN, without checking it out.  Users probably expect this to
behave the same as:
    git checkout REVISION
    git grep PATTERN
and since checkout pays attention to sparsity rules, this is why we'd
want to have both "git grep PATTERN" and "git grep REVISION PATTERN"
pay attention to sparsity rules.

When we think in terms of "git grep REVISION PATTERN" as an optimized
version of "git checkout REVISION && git grep PATTERN" it puts us in
the frame of mind of asking the following question:
   For each path, would it be marked as SKIP_WORKTREE if we were to
check it out right now?  If so, we should skip it for the grepping.
Usually, the SKIP_WORKTREE bit is set for files if and only if they
don't match the sparsity patterns.  Also, we can't use the
SKIP_WORKTREE bit of the current index to decide whether to grep
through an old REVISION, because there are paths that exists in the
old revision that don't exist in the current index.  The sparsity
rules are the only things that can tell us whether such a path would
be marked as SKIP_WORKTREE if we were to check it out.  So it makes
sense to use the sparsity patterns when looking at REVISIONS.  When
dealing with the current worktree, we can check SKIP_WORKTREE
directly.  Usually that'll give the same answer as asking the sparsity
rules but as per [1] the two aren't always identical.  Rather than
asking "Would we mark this as SKIP_WORKTREE if we were to checkout
this version right now?", perhaps we should ask "Since we have this
version checked out right now, let's just check the path directly.  Is
it marked as SKIP_WORKTREE?".

Does that sound reasonable?

[1] https://lore.kernel.org/git/xmqqbmb1a7ga.fsf@gitster-ct.c.googlers.com/
