Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C346DC63777
	for <git@archiver.kernel.org>; Sat, 21 Nov 2020 06:33:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7DF3022252
	for <git@archiver.kernel.org>; Sat, 21 Nov 2020 06:33:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BSn/1v7l"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726189AbgKUG3x (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 21 Nov 2020 01:29:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725958AbgKUG3x (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 21 Nov 2020 01:29:53 -0500
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF06CC0613CF
        for <git@vger.kernel.org>; Fri, 20 Nov 2020 22:29:51 -0800 (PST)
Received: by mail-pg1-x542.google.com with SMTP id f17so768888pge.6
        for <git@vger.kernel.org>; Fri, 20 Nov 2020 22:29:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:reply-to:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=aPEOJBgkDDhUR6P/yvMbyXgszx1C4V3HBIfOL6smrns=;
        b=BSn/1v7lZNaBYE9Q6/nst7XlxpkPJXXz8ygMmkldAipxdB8PYRe10BtTlHpwn0xzmY
         mzYcSHpPZFFtPIXozaKwGywUvB32ISpCS8uHMjLRtyjAEeiK+wcTkXFSf53ND8BZw0Gb
         Qb8LI4eU3sOF8NmZq7hok4T6ypcoTC5qRba09kmOVSmTIyQCfnAr3R5/Yx2HEy77bRvK
         Q3Lkjf6Lrdgf4Hc4JnzyaGKWntvcWfHaJ0yXcZNMvfYcwIUqguu9vxSo3eKTU4TvdRpw
         6kx3k/zjtPQnB44j6MHZ504X0rGCGpZ4/5j18yjsIeCpvU5vZLA3F9bAwsyb8S226pnw
         WE/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:reply-to
         :references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to;
        bh=aPEOJBgkDDhUR6P/yvMbyXgszx1C4V3HBIfOL6smrns=;
        b=V3OQ3Nx6lo+AGoSFiIDe5QlzeR3xQUJCufq7HXC4oYyTnjapDt4ismSXqn4PcFWfN/
         5WuQOHRvP/9wMphGAagSnF19clH/qkYP5wAjsCfI9mY6eAB7WHZZ4xHlfdltOb+FW0ZP
         qDtt5yC6paPIrtmTTTmyruiJHOv7h2N8MlRWs49UkHp7ZrSXmp4g1fpyAQxC1c9wCLdH
         VUFstskjdeTP8Iry9kHoPg5aHr8jzatQ80jGYMmHKjoQcTp2ik9Wv13WF7LBIQ34JELU
         8qSgAUof3KKp22z+Z6d3AW/0Ie3OoAeTXHASgBoofeydzkbBhlxmIy4q5gqfMC2JWbFc
         c2ow==
X-Gm-Message-State: AOAM532YctCLUh1fr4BVUrHlTDtB0qfRpDpIgFpQ6MTTKftmMhKXLSyo
        MbHBE8DUDLYrvztTE+FF/mg=
X-Google-Smtp-Source: ABdhPJw2hI2nNSSTicKvTcaElwa8S7/Yai6WLiLTbmk91UiFwj9Q/d1ie9t4N8B/Thj+a8ztpP/Btw==
X-Received: by 2002:a63:181b:: with SMTP id y27mr19770812pgl.408.1605940191050;
        Fri, 20 Nov 2020 22:29:51 -0800 (PST)
Received: from Abhishek-Arch ([2409:4064:4e1b:7df9:8c64:9dfe:9e83:35c8])
        by smtp.gmail.com with ESMTPSA id c11sm6548662pjn.26.2020.11.20.22.29.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Nov 2020 22:29:50 -0800 (PST)
Date:   Sat, 21 Nov 2020 12:00:13 +0530
From:   Abhishek Kumar <abhishekkumar8222@gmail.com>
To:     Jakub =?utf-8?B?TmFyxJlic2tp?= <jnareb@gmail.com>
Cc:     abhishekkumar8222@gmail.com, git@vger.kernel.org,
        gitgitgadget@gmail.com, stolee@gmail.com
Subject: Re: [PATCH v4 10/10] doc: add corrected commit date info
Message-ID: <X7iz9VhjHG5sbe9p@Abhishek-Arch>
Reply-To: 85tuu5q4uy.fsf@gmail.com
References: <pull.676.v3.git.1597509583.gitgitgadget@gmail.com>
 <pull.676.v4.git.1602079785.gitgitgadget@gmail.com>
 <9ada43967d29a3ec717b6a8db0de5b09e6d916b1.1602079786.git.gitgitgadget@gmail.com>
 <85tuu5q4uy.fsf@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <85tuu5q4uy.fsf@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Nov 04, 2020 at 02:37:41AM +0100, Jakub Narębski wrote:
> "Abhishek Kumar via GitGitGadget" <gitgitgadget@gmail.com> writes:
> 
> > From: Abhishek Kumar <abhishekkumar8222@gmail.com>
> >
> > With generation data chunk and corrected commit dates implemented, let's
> > update the technical documentation for commit-graph.
> >
> > Signed-off-by: Abhishek Kumar <abhishekkumar8222@gmail.com>
> 
> Nice.
> 
> > ---
> >  .../technical/commit-graph-format.txt         | 21 +++++--
> >  Documentation/technical/commit-graph.txt      | 62 ++++++++++++++++---
> >  2 files changed, 69 insertions(+), 14 deletions(-)
> >
> > diff --git a/Documentation/technical/commit-graph-format.txt b/Documentation/technical/commit-graph-format.txt
> > index b3b58880b9..08d9026ad4 100644
> > --- a/Documentation/technical/commit-graph-format.txt
> > +++ b/Documentation/technical/commit-graph-format.txt
> > @@ -4,11 +4,7 @@ Git commit graph format
> >  The Git commit graph stores a list of commit OIDs and some associated
> >  metadata, including:
> >  
> > -- The generation number of the commit. Commits with no parents have
> > -  generation number 1; commits with parents have generation number
> > -  one more than the maximum generation number of its parents. We
> > -  reserve zero as special, and can be used to mark a generation
> > -  number invalid or as "not computed".
> > +- The generation number of the commit.
> 
> All right, because we could store both generation number v1 and
> generation number v2 in the commit-graph file, and we need to describe
> both, the description is now consolidated and in only one place.
> 
> >  
> >  - The root tree OID.
> >  
> > @@ -86,13 +82,26 @@ CHUNK DATA:
> >        position. If there are more than two parents, the second value
> >        has its most-significant bit on and the other bits store an array
> >        position into the Extra Edge List chunk.
> > -    * The next 8 bytes store the generation number of the commit and
> > +    * The next 8 bytes store the topological level (generation number v1)
> > +      of the commit and
> 
> All right, this is updated information about CDAT chunk.
> 
> >        the commit time in seconds since EPOCH. The generation number
> >        uses the higher 30 bits of the first 4 bytes, while the commit
> >        time uses the 32 bits of the second 4 bytes, along with the lowest
> >        2 bits of the lowest byte, storing the 33rd and 34th bit of the
> >        commit time.
> >  
> > +  Generation Data (ID: {'G', 'D', 'A', 'T' }) (N * 4 bytes)
> 
> Should we mark this chunk as "[Optional]"?  Its absence is not an error.

I think we should mark it as "optional", although optional might not
have been the best choice word. 

Optional (for me) implies that it is configurable and decided by the end-user
directly.  However, it is *conditional* - on the existing commit graph file(s)
(if any) and the version of Git.

> > +    * This list of 4-byte values store corrected commit date offsets for the
> > +      commits, arranged in the same order as commit data chunk.
> > +    * If the corrected commit date offset cannot be stored within 31 bits,
> > +      the value has its most-significant bit on and the other bits store
> > +      the position of corrected commit date into the Generation Data Overflow
> > +      chunk.
> 
> All right.
> 
> > +
> > +  Generation Data Overflow (ID: {'G', 'D', 'O', 'V' }) [Optional]
> > +    * This list of 8-byte values stores the corrected commit dates for commits
> > +      with corrected commit date offsets that cannot be stored within 31 bits.
> 
> A question: do we store 8-byte / 64-bit corrected commit date *directly*,
> or do we store corrected commit date *offset* as 8-byte / 64-bit value?
> 

We store the dates directly rather 8-byte offsets. Will clarify.

> Perhaps we should add the information that [like the EDGE chunk] it is
> present only when necessary, and that it is present only when GDAT chunk
> is present (it might be obvious, but it could be better to state
> this explicitly).
> 

It's always better to be explicit. Thanks for the detailed review.

> > +
> 
> All right, this is the information about two new chunks (with the
> mentioned above caveat about the clarity of the description of
> overflow-handling chunk).
> 
> >    Extra Edge List (ID: {'E', 'D', 'G', 'E'}) [Optional]
> >        This list of 4-byte values store the second through nth parents for
> >        all octopus merges. The second parent value in the commit data stores
> > diff --git a/Documentation/technical/commit-graph.txt b/Documentation/technical/commit-graph.txt
> > index f14a7659aa..75f71c4c7b 100644
> > --- a/Documentation/technical/commit-graph.txt
> > +++ b/Documentation/technical/commit-graph.txt
> > @@ -38,14 +38,31 @@ A consumer may load the following info for a commit from the graph:
> >  
> >  Values 1-4 satisfy the requirements of parse_commit_gently().
> >  
> > -Define the "generation number" of a commit recursively as follows:
> > +There are two definitions of generation number:
> > +1. Corrected committer dates (generation number v2)
> > +2. Topological levels (generation nummber v1)
> 
> All right.
> 
> >  
> > - * A commit with no parents (a root commit) has generation number one.
> > +Define "corrected committer date" of a commit recursively as follows:
> >  
> > - * A commit with at least one parent has generation number one more than
> > -   the largest generation number among its parents.
> > +  * A commit with no parents (a root commit) has corrected committer date
> > +    equal to its committer date.
> 
> Minor nitpick: the above point has been accidentally indented one space
> more than necessary, and than is indented in other places.  Or maybe
> that fixes / unifies the formatting... I am not sure.
> 

That's a force of habit - I like to write markdown with greater
indentation. Should have been indented with one space instead of two.

> >  
> > -Equivalently, the generation number of a commit A is one more than the
> > +  * A commit with at least one parent has corrected committer date equal to
> > +    the maximum of its commiter date and one more than the largest corrected
> > +    committer date among its parents.
> > +
> > +  * As a special case, a root commit with timestamp zero has corrected commit
> > +    date of 1, to be able to distinguish it from GENERATION_NUMBER_ZERO
> > +    (that is, an uncomputed corrected commit date).
> 
> All right.  Looks good.
> 
> > +
> > +Define the "topological level" of a commit recursively as follows:
> > +
> > + * A commit with no parents (a root commit) has topological level of one.
> > +
> > + * A commit with at least one parent has topological level one more than
> > +   the largest topological level among its parents.
> > +
> 
> All right, this just repeats what was written before, or in other words
> move existing contents lower/later, just with 'generation number'
> replaced by 'topological level' (though it might be not obvious from the
> patch because of the latter change).
> 
> > +Equivalently, the topological level of a commit A is one more than the
> >  length of a longest path from A to a root commit. The recursive definition
> >  is easier to use for computation and observing the following property:
> >  
> > @@ -60,6 +77,9 @@ is easier to use for computation and observing the following property:
> >      generation numbers, then we always expand the boundary commit with highest
> >      generation number and can easily detect the stopping condition.
> >  
> > +The properties applies to both versions of generation number, that is both
> > +corrected committer dates and topological levels.
> > +
> 
> I think it should be "This property" or "The property", not "The
> properties"; it is a single property, a single condition.
> 
> We can alternatively say "This condition is fulfilled by both versions...",
> or "This condition is true for both versions...".
> 
> >  This property can be used to significantly reduce the time it takes to
> >  walk commits and determine topological relationships. Without generation
> >  numbers, the general heuristic is the following:
> > @@ -67,7 +87,9 @@ numbers, the general heuristic is the following:
> >      If A and B are commits with commit time X and Y, respectively, and
> >      X < Y, then A _probably_ cannot reach B.
> >  
> > -This heuristic is currently used whenever the computation is allowed to
> > +In absence of corrected commit dates (for example, old versions of Git or
> > +mixed generation graph chains),
> > +this heuristic is currently used whenever the computation is allowed to
> >  violate topological relationships due to clock skew (such as "git log"
> >  with default order), but is not used when the topological order is
> >  required (such as merge base calculations, "git log --graph").
> 
> All right, this explains when commit date heuristics is used (which is
> less often than before).
> 
> > @@ -77,7 +99,7 @@ in the commit graph. We can treat these commits as having "infinite"
> >  generation number and walk until reaching commits with known generation
> >  number.
> >  
> > -We use the macro GENERATION_NUMBER_INFINITY = 0xFFFFFFFF to mark commits not
> > +We use the macro GENERATION_NUMBER_INFINITY to mark commits not
> 
> All right, 64-bit GENERATION_NUMBER_INFINITY = 0xFFFFFFFFFFFFFFFF is a
> bit unwieldy...
> 
> >  in the commit-graph file. If a commit-graph file was written by a version
> >  of Git that did not compute generation numbers, then those commits will
> >  have generation number represented by the macro GENERATION_NUMBER_ZERO = 0.
> > @@ -93,7 +115,7 @@ fully-computed generation numbers. Using strict inequality may result in
> >  walking a few extra commits, but the simplicity in dealing with commits
> >  with generation number *_INFINITY or *_ZERO is valuable.
> >  
> > -We use the macro GENERATION_NUMBER_MAX = 0x3FFFFFFF to for commits whose
> > +We use the macro GENERATION_NUMBER_MAX for commits whose
> 
> This should be
> 
>   +We use the macro GENERATION_NUMBER_V1_MAX = 0x3FFFFFFF to for commits whose
>   +topological levels (generation number v1) are computed to be at least this value. We limit at
>    this value since it is the largest value that can be stored in the
>   +commit-graph file using the 30 bits available to topological levels. This
> 
> We need to use "topological levels" or "generation numbers v1" thorough
> the rest of this section.
> 
> >  generation numbers are computed to be at least this value. We limit at
> >  this value since it is the largest value that can be stored in the
> >  commit-graph file using the 30 bits available to generation numbers. This
> > @@ -267,6 +289,30 @@ The merge strategy values (2 for the size multiple, 64,000 for the maximum
> >  number of commits) could be extracted into config settings for full
> >  flexibility.
> >
> 
> All right, I agree that we don't need to write about overflow handling
> for storing corrected committer dates (generation number v2) as offsets;
> this is something format-specific, and this documentation is more about
> using commit-graph data.  What is present in commit-graph-format.txt
> should be enough information.
> 
> Sidenote: I wonder if other Git implementations such as JGit, Dulwich,
> Gitoxide (gix), go-git have support for the commit-graph file...
> 
> > +## Handling Mixed Generation Number Chains
> > +
> > +With the introduction of generation number v2 and generation data chunk, the
> > +following scenario is possible:
> > +
> > +1. "New" Git writes a commit-graph with the corrected commit dates.
> > +2. "Old" Git writes a split commit-graph on top without corrected commit dates.
> > +
> > +A naive approach of using the newest available generation number from
> > +each layer would lead to violated expectations: the lower layer would
> > +use corrected commit dates which are much larger than the topological
> > +levels of the higher layer. For this reason, Git inspects each layer to
> > +see if any layer is missing corrected commit dates. In such a case, Git
> > +only uses topological level
> 
> This should end in full stop:
> 
>   +only uses topological levels.
> 
> Or maybe we should expand the last sentence a bit:
> 
>   +only uses topological levels for generation numbers.
> 
> Sidenote: it is a good explanation, even if Git can make use of the
> property described below that only topmost layers might be missing
> corrected commit graph by the construction (so it needs to check only
> the top layer).
> 
> > +
> > +When writing a new layer in split commit-graph, we write corrected commit
> > +dates if the topmost layer has corrected commit dates written. This
> > +guarantees that if a layer has corrected commit dates, all lower layers
> > +must have corrected commit dates as well.
> > +
> > +When merging layers, we do not consider whether the merged layers had corrected
> > +commit dates. Instead, the new layer will have corrected commit dates if and
> > +only if all existing layers below the new layer have corrected commit dates.
> > +
> 
> Perhaps we should explicitly say that when rewriting split commit-graph
> as a single file (`--split=replace`) then the newly created single layer
> would store corrected commit dates.
> 

Rewriting split commit-graph as a single file is a case where there are
no "existing layers below the new layer". We should clarify that if the
new layer is the only layer, it will always have corrected commit dates
when written by compatible versions of Git. 

I have appended a paragraph at the end:

  While writing or merging layers, if the new layer is the only layer,
  it will have corrected commit dates when written by compatible
  versions of Git. Thus, rewriting split commit-graph as a singel file
  (`--split=replace`) creates a single layer with corrected commit
  dates.

> >  ## Deleting graph-{hash} files
> >  
> >  After a new tip file is written, some `graph-{hash}` files may no longer
> 
> Best,
> -- 
> Jakub Narębski

Thanks
- Abhishek
