Return-Path: <SRS0=kr1+=CK=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,LOTS_OF_MONEY,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0449AC433E6
	for <git@archiver.kernel.org>; Tue,  1 Sep 2020 14:36:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C3C5E20767
	for <git@archiver.kernel.org>; Tue,  1 Sep 2020 14:36:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TqKLObJb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728450AbgIAOgR (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 1 Sep 2020 10:36:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728419AbgIAOfz (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 1 Sep 2020 10:35:55 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 507A1C061244
        for <git@vger.kernel.org>; Tue,  1 Sep 2020 07:35:55 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id a9so1395195wmm.2
        for <git@vger.kernel.org>; Tue, 01 Sep 2020 07:35:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=xOEuDFaOZNAvTsGtDmt9WJYweQ/J8MzwfdG5chn525w=;
        b=TqKLObJbFKRas1JDRaABjR14dfE3W5QfdaQoQ+T15oMtOQX5dcDaWp+XtbLOmZ9Tx9
         aalt2/zIEliMzC6o7B+LHX/9bxtLYyE+dNxZWHf5Zyo8jrrCmPPwfjxSYTq39vX0K6ku
         /MXcmwZjTW3cmWR00twlEWmD5uDp9cHDEqtUEitcptLSb/jgND7Uam3s+zD2WqHm32C4
         F0lVKaEpOd12owb96hHh0Y6oLHI1lvHxpiNGVFXkDjb9KhhWRZDsaBh32t2SpuTWja+u
         r5xKpYz8eCKDlNmZgKA3MkbuwhVQh72ubccu0fPeWoMc3fqDC93YdctC0hfr30b0Jpd8
         Mhuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=xOEuDFaOZNAvTsGtDmt9WJYweQ/J8MzwfdG5chn525w=;
        b=QFDVf3gZPePwgQBTdadr/RkUrD7wcgEinha9KPqHgkG3JfibyF+MTD3XFlVgGDTrxA
         OsFkMm1QGB7kOYRzMQpJ0cewNScaZevNqUxwfVjRB9xvcoTteFPz1EBcmX57iSUJfuhv
         5D5lfWvHt1QumgIcXJz6hg2zJmRH+83yTTfFr/ceiTO//qB7mPuq7fevLP9cXhLVROAI
         dexUMwhBTZ1kvNiLIzx3nYX3X/X9w4KPqDQyMBW+/7oG/MQFjS6Q2frL+mKbfWD6ZQuN
         srnmsQ05NQg2QaOg2SAAhL1RNpBfeTu+8U8hSb6OefIqBhqGe/oslgvz3SX/1Q1JMcMQ
         55lA==
X-Gm-Message-State: AOAM532lC5aHElGY/2q1QKPhWRv3dfcGrKoaP3ejF+zyWtWQz+e2L6Sa
        BCWpqv0mEXe1gwV34eisOUw=
X-Google-Smtp-Source: ABdhPJzshB163ElkaROgO2nav81ZNHnbxy0MZnQU0TePPgjaaNXsfAzTU4K0fp/ra2/TTmzhAMNaSQ==
X-Received: by 2002:a05:600c:2246:: with SMTP id a6mr2195046wmm.38.1598970953538;
        Tue, 01 Sep 2020 07:35:53 -0700 (PDT)
Received: from szeder.dev (78-131-17-40.pool.digikabel.hu. [78.131.17.40])
        by smtp.gmail.com with ESMTPSA id 33sm2844656wri.16.2020.09.01.07.35.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 01 Sep 2020 07:35:52 -0700 (PDT)
Date:   Tue, 1 Sep 2020 16:35:46 +0200
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org, peff@peff.net, dstolee@microsoft.com,
        gitster@pobox.com
Subject: Re: [PATCH v3 12/14] commit-graph: add large-filters bitmap chunk
Message-ID: <20200901143546.GA5678@szeder.dev>
References: <cover.1596480582.git.me@ttaylorr.com>
 <cover.1597178914.git.me@ttaylorr.com>
 <619e0c619dd12e2bea2b80c7d249ba66fe2a315c.1597178915.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <619e0c619dd12e2bea2b80c7d249ba66fe2a315c.1597178915.git.me@ttaylorr.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Aug 11, 2020 at 04:52:07PM -0400, Taylor Blau wrote:
> When a commit has more than a certain number of changed paths (commonly
> 512), the commit-graph machinery represents it as a zero-length filter.
> This is done since having many entries in the Bloom filter has
> undesirable effects on the false positivity rate.
> 
> In addition to these too-large filters, the commit-graph machinery also
> represents commits with no filter and commits with no changed paths in
> the same way.
> 
> When writing a commit-graph that aggregates several incremental
> commit-graph layers (eg., with '--split=replace'), the commit-graph
> machinery first computes all of the Bloom filters that it wants to write
> but does not already know about from existing graph layers. Because we
> overload the zero-length filter in the above fashion, this leads to
> recomputing large filters over and over again.
> 
> This is already undesirable, since it means that we are wasting
> considerable effort to discover that a commit with too many changed
> paths, only to throw that effort away (and then repeat the process the
> next time a roll-up is performed).

Is this really the case?

If a commit has a corresponding entry in the Bloom filters chunks,
then the commit-graph machinery does know the Bloom filter associated
with that commit.  The size of that filter should not matter, i.e.
even if it is a zero-length filter, the commit-graph machinery should
know about it all the same.  And as far as I can tell it does indeed,
because load_bloom_filter_from_graph() sets a non-NULL 'filter->data'
pointer even if 'filter->len' is zero, which get_bloom_filter() treats
as "we know about this", and returns early without (re)computing the
filter.  Even the test 'Bloom generation does not recompute too-large
filters' added in this patch is expected to succeed, and my
superficial and makeshift testing seems to corroborate this; at least
I couldn't find a combination of commands and options that would
recompute any existing zero-length Bloom filters.

Am I missing something?

> In a subsequent patch, we will add a '--max-new-filters=<n>' option,
> which specifies an upper-bound on the number of new filters we are
> willing to compute from scratch. Suppose that there are 'N' too-large
> filters, and we specify '--max-new-filters=M'. If 'N >= M', it is
> unlikely that any filters will be generated, since we'll spend most of
> our effort on filters that we ultimately throw away. If 'N < M', filters
> will trickle in over time, but only at most 'M - N' per-write.
> 
> To address this, add a new chunk which encodes a bitmap where the ith
> bit is on iff the ith commit has zero or at least 512 changed paths.
> Likewise store the maximum number of changed paths we are willing to
> store in order to prepare for eventually making this value more easily
> customizable.

I don't understand how storing this value would make it any easier to
customize.

> When computing Bloom filters, first consult the relevant
> bitmap (in the case that we are rolling up existing layers) to see if
> computing the Bloom filter from scratch would be a waste of time.
> 
> This patch implements a new chunk instead of extending the existing BIDX
> and BDAT chunks because modifying these chunks would confuse old
> clients. (Eg., setting the most-significant bit in the BIDX chunk would
> confuse old clients and require a version bump).
> 
> To allow using the existing bitmap code with 64-bit words, we write the
> data in network byte order from the 64-bit words. This means we also
> need to read the array from the commit-graph file by translating each
> word from network byte order using get_be64() when loading the commit
> graph. (Note that this *could* be delayed until first-use, but a later
> patch will rely on this being initialized early, so we assume the
> up-front cost when parsing instead of delaying initialization).
> 
> By avoiding the need to move to new versions of the BDAT and BIDX chunk,
> we can give ourselves more time to consider whether or not other
> modifications to these chunks are worthwhile without holding up this
> change.
> 
> Another approach would be to introduce a new BIDX chunk (say, one
> identified by 'BID2') which is identical to the existing BIDX chunk,
> except the most-significant bit of each offset is interpreted as "this
> filter is too big" iff looking at a BID2 chunk. This avoids having to
> write a bitmap, but forces older clients to rewrite their commit-graphs
> (as well as reduces the theoretical largest Bloom filters we couldl

And it reduces the max possible size of the BDAT chunk, and thus the
max number of commits with Bloom filters as well.

s/couldl/could/

> write, and forces us to maintain the code necessary to translate BIDX
> chunks to BID2 ones). Separately from this patch, I implemented this
> alternate approach and did not find it to be advantageous.

Let's take a step back to reconsider what should be stored in this
bitmap for a moment.  Sure, setting a bit for each commit that doesn't
modify any paths or modifies too many makes it possible to repliably
identify commits that don't have Bloom filters yet.  But isn't it a
bit roundabout way?  I think it would be better to directly track
which commits don't have Bloom filters yet.  IOW what you really want
is a, say, BNCY "Bloom filter Not Computed Yet" chunk, where we set
the corresponding bit for each commit which has an entry in the BIDX
chunk but for which a Bloom filter hasn't been computed yet.

  - It's simpler and easier to explain (IMO).

  - This bitmap chunk can easily be made optional: if all Bloom
    filters have been computed, then the bitmap will contain all
    zeros.  So why bother writing it, when we can save a bit of space
    instead?

  - It avoids the unpleasentness of setting a bit in the _Large_ Bloom
    Filters chunks for commits _not_ modifying any paths.

  - Less incentive to spill implementation details to the format
    specification (e.g. 512 modified paths).

Now, let's take another step back: is such a bitmap really necessary?
We could write a single-byte Bloom filter with no bits set for commits
not modifying any paths, and a single-byte Bloom filter with all bits
set for commits modifying too many paths.  This is compatible with the
specs and any existing implementation should do the right thing when
reading such filters, this would allow us to interpret zero-length
filters as "not computed yet", and if that bitmap chunk won't be
optional, then this would save space as long as less than 1/8 of
commits modify no or too many paths.  Unfortunately, however, all
existing zero-length Bloom filters have to be recomputed.


> Signed-off-by: Taylor Blau <me@ttaylorr.com>
> ---
>  .../technical/commit-graph-format.txt         | 12 +++
>  bloom.h                                       |  2 +-
>  commit-graph.c                                | 96 ++++++++++++++++---
>  commit-graph.h                                |  4 +
>  t/t4216-log-bloom.sh                          | 25 ++++-
>  5 files changed, 124 insertions(+), 15 deletions(-)
> 
> diff --git a/Documentation/technical/commit-graph-format.txt b/Documentation/technical/commit-graph-format.txt
> index 440541045d..5f2d9ab4d7 100644
> --- a/Documentation/technical/commit-graph-format.txt
> +++ b/Documentation/technical/commit-graph-format.txt
> @@ -123,6 +123,18 @@ CHUNK DATA:
>        of length zero.
>      * The BDAT chunk is present if and only if BIDX is present.
>  
> +  Large Bloom Filters (ID: {'B', 'F', 'X', 'L'}) [Optional]
> +    * It starts with a 32-bit unsigned integer specifying the maximum number of
> +      changed-paths that can be stored in a single Bloom filter.

Should this value be the same in all elements of a commit-graph chain?
Note that in this case having different values won't affect revision
walks using modified path Bloom filters.

> +    * It then contains a list of 64-bit words (the length of this list is
> +      determined by the width of the chunk) which is a bitmap. The 'i'th bit is
> +      set exactly when the 'i'th commit in the graph has a changed-path Bloom
> +      filter with zero entries (either because the commit is empty, or because
> +      it contains more than 512 changed paths).

Please make clear the byte order of these 64 bit words in the specs as
well.

Furthermore, that 512 path limit is an implementation detail, so it
would be better if it didn't leak into the specification of this new
chunk.

> +    * The BFXL chunk is present only when the BIDX and BDAT chunks are
> +      also present.
> +
> +
>    Base Graphs List (ID: {'B', 'A', 'S', 'E'}) [Optional]
>        This list of H-byte hashes describe a set of B commit-graph files that
>        form a commit-graph chain. The graph position for the ith commit in this



> diff --git a/t/t4216-log-bloom.sh b/t/t4216-log-bloom.sh
> index 21b67677ef..6859d85369 100755
> --- a/t/t4216-log-bloom.sh
> +++ b/t/t4216-log-bloom.sh
> @@ -33,7 +33,7 @@ test_expect_success 'setup test - repo, commits, commit graph, log outputs' '
>  	git commit-graph write --reachable --changed-paths
>  '
>  graph_read_expect () {
> -	NUM_CHUNKS=5
> +	NUM_CHUNKS=6
>  	cat >expect <<- EOF
>  	header: 43475048 1 1 $NUM_CHUNKS 0
>  	num_commits: $1
> @@ -262,5 +262,28 @@ test_expect_success 'correctly report changes over limit' '
>  		done
>  	)
>  '
> +test_bloom_filters_computed () {
> +	commit_graph_args=$1
> +	bloom_trace_prefix="{\"filter_known_large\":$2,\"filter_found_large\":$3,\"filter_computed\":$4"
> +	rm -f "$TRASH_DIRECTORY/trace.event" &&
> +	GIT_TRACE2_EVENT="$TRASH_DIRECTORY/trace.event" git commit-graph write $commit_graph_args &&
> +	grep "$bloom_trace_prefix" "$TRASH_DIRECTORY/trace.event"
> +}
> +
> +test_expect_success 'Bloom generation does not recompute too-large filters' '
> +	(
> +		cd limits &&
> +
> +		# start from scratch and rebuild
> +		rm -f .git/objects/info/commit-graph &&
> +		GIT_TEST_BLOOM_SETTINGS_MAX_CHANGED_PATHS=10 \
> +			git commit-graph write --reachable --changed-paths \
> +			--split=replace &&
> +		test_commit c1 filter &&
> +
> +		test_bloom_filters_computed "--reachable --changed-paths --split=replace" \
> +			2 0 1
> +	)
> +'
>  
>  test_done
> -- 
> 2.28.0.rc1.13.ge78abce653
> 
