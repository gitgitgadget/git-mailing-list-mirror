Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D231AC05027
	for <git@archiver.kernel.org>; Fri, 10 Feb 2023 15:42:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232788AbjBJPmU (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 10 Feb 2023 10:42:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232083AbjBJPmS (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 Feb 2023 10:42:18 -0500
Received: from mail-ot1-x331.google.com (mail-ot1-x331.google.com [IPv6:2607:f8b0:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1E635FDA
        for <git@vger.kernel.org>; Fri, 10 Feb 2023 07:42:17 -0800 (PST)
Received: by mail-ot1-x331.google.com with SMTP id g15-20020a9d6b0f000000b0068db1940216so1639313otp.5
        for <git@vger.kernel.org>; Fri, 10 Feb 2023 07:42:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=XjHc6i0qXGKXIFU9YokzePXe38e0l0T07DZSohabncA=;
        b=Bp3xVdJGx05BxAbwkOLj3FdEEExxlUawIsC3ND5ac+PmiwPzwsL1f3J1wYP6UmTHda
         DHvoV6/K0NYtiImsAZHjGS/foVJaSw4izRoL9sEIf1uP2UGKVphGOOj4DNUCvIhdSssZ
         fvf+w+RSGCp6zcoCLztAXz3pBaoGKeP/1qlkjS+ect0JKyTEhHdcLLHKFrlk+ewOS2h1
         gkhHxcztRqJ0q1Ahoh7MfzwZAsgr4ybJf84xmHnVfkRzdmZqvJB9LREX2ElBg7ZSPlh3
         rdSsaqi4x5RUbJic8CNhvEH0HPNBE7xaci1nsBpzWwSHhxW51V7YGYFj8ViHrWec0Ouj
         mP4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XjHc6i0qXGKXIFU9YokzePXe38e0l0T07DZSohabncA=;
        b=wcIhzFN1KKWlSLkEO7de5TvP5+r6b4KwoIxGRusHLD34g+gpVv/mZRzdI4mm09qAZj
         HYmPcrUYZo3Asq6BDwLg4Zsstnwy8n3tHv4mXALTKom3tJP6QlIYSR9ugzHfDkOErE0R
         AmIrP1ynlW7SZBwJwauvDjD1jDxtCQCViSzK0+ZEof8pdcDThLXzLzhsRSzofGhKou3a
         oEjNlmvN5ZZXKD/Mx0R359lr1bRcyud4P/Oy3d6acgdhnCLaJITA/Wk4JZNM+0CEAoQk
         efuVDGD0LHA57XqlttrZtRECBTMfLEnPMOM0Q8EIXrptmCXnLYkUqBzQeA8Nrz3gQi6i
         3i/Q==
X-Gm-Message-State: AO0yUKXS0DjcrLuzZ53fGFcRb/VIKH66yCDykaSrFin92y5IB9/NT+6y
        z/dYXOhp+4GFSAdQAaQgqOxX
X-Google-Smtp-Source: AK7set87WMBQLbYuRqT6NtO5imCJDENNLG/2RaD/kHNGktEbV8n18h5gD/hRHe3QacFsrJnuanRlPw==
X-Received: by 2002:a05:6830:3903:b0:68b:cdd3:3b93 with SMTP id br3-20020a056830390300b0068bcdd33b93mr10814151otb.26.1676043736807;
        Fri, 10 Feb 2023 07:42:16 -0800 (PST)
Received: from ?IPV6:2600:1700:e72:80a0:cd86:2daf:969b:78ad? ([2600:1700:e72:80a0:cd86:2daf:969b:78ad])
        by smtp.gmail.com with ESMTPSA id g5-20020a9d6185000000b006865223e532sm2087612otk.51.2023.02.10.07.42.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 Feb 2023 07:42:15 -0800 (PST)
Message-ID: <4ab0b2b0-b045-2346-ccc1-19f9b23d0a02@github.com>
Date:   Fri, 10 Feb 2023 10:42:13 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH] blame-tree: add library and tests via "test-tool
 blame-tree"
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Taylor Blau <me@ttaylorr.com>
References: <patch-1.1-0ea849d900b-20230205T204104Z-avarab@gmail.com>
Content-Language: en-US
From:   Derrick Stolee <derrickstolee@github.com>
In-Reply-To: <patch-1.1-0ea849d900b-20230205T204104Z-avarab@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2/5/2023 3:47 PM, Ævar Arnfjörð Bjarmason wrote:

I've been meaning to get to this all week, but today was my first chance.

> The "blame-tree" library allows for finding the most recent
> modification to paths in a tree. It does so by expanding the tree at a
> given commit, taking note of the current state of each path, and then
> walking backwards through history looking for commits where each path
> changed into its final sha1.
>
> The "git blame-tree" command was first noted on the ML 2011[1], and
> over the years there have been mentions of it[2][3], and whether it
> could be upstreamed. The sources have been available at [4]'s
> "jk/blame-tree-wip" and "jk/faster-blame-tree-wip" branches.
>
> This change attempts to start upstreaming this command, but rather
> than adding a command whose interface & semantics may be controversial
> starts by exposing & testing the core of its library through a new
> test helper.

One thing that I think is important for this work and the future we build
on top of it is that we need to reconsider every fact about the existing
contribution and make sure the new thing is built for the actual needs.

In that vein, I think your use of a test-tool is a really good one. It can
help us define an API boundary that could then be reflected in a CLI in
independent review from improved algorithms underneath the API.

> +struct blame_tree_options {
> +	struct object_id oid;
> +	const char *prefix;
> +	unsigned int recursive;
> +	struct strvec args;
> +};
> +#define BLAME_TREE_OPTIONS_INIT(...) { \
> +	.args = STRVEC_INIT, \
> +	__VA_ARGS__ \
> +}
> +void blame_tree_opts_release(struct blame_tree_options *bto);
> +
> +struct blame_tree {
> +	struct string_list paths;
> +	struct rev_info rev;
> +};
> +#define BLAME_TREE_INIT { \
> +	.paths = STRING_LIST_INIT_DUP, \
> +	.rev = REV_INFO_INIT, \
> +}
> +
> +void blame_tree_init(struct blame_tree *bt,
> +		     const struct blame_tree_options *opts);
> +void blame_tree_release(struct blame_tree *);
> +
> +typedef void (*blame_tree_fn)(const char *path, const struct commit *commit,
> +			      void *data);
> +int blame_tree_run(struct blame_tree *bt, blame_tree_fn cb, void *data);

However, this API is too leaky. Specifically, it allows passing arbitrary
'args' instead of structured options.

Before I get into what I think needs to change here, let's look at the
initial implementation:

> +int blame_tree_run(struct blame_tree *bt, blame_tree_fn cb, void *cbdata)
> +{
> +	struct blame_tree_callback_data data;
> +
> +	data.paths = &bt->paths;
> +	data.num_interesting = bt->paths.nr;
> +	data.callback = cb;
> +	data.callback_data = cbdata;
> +
> +	bt->rev.diffopt.output_format = DIFF_FORMAT_CALLBACK;
> +	bt->rev.diffopt.format_callback = blame_diff;
> +	bt->rev.diffopt.format_callback_data = &data;
> +
> +	prepare_revision_walk(&bt->rev);
> +
> +	while (data.num_interesting) {
> +		data.commit = get_revision(&bt->rev);
> +		if (!data.commit)
> +			break;
> +
> +		if (data.commit->object.flags & BOUNDARY) {
> +			diff_tree_oid(the_hash_algo->empty_tree,
> +				       &data.commit->object.oid,
> +				       "", &bt->rev.diffopt);
> +			diff_flush(&bt->rev.diffopt);
> +		} else {
> +			log_tree_commit(&bt->rev, data.commit);
> +		}
> +	}
> +
> +	return 0;
> +}

When I think of 'blame-tree', I think of the following output:

  For each path (within a pathspec, recursive or not), output the first
  commit that changed that path according to simplified file history. This
  history walk begins at a single commit, but may be terminated by a
  negative commit range, so the output could indicate that we reached the
  boundary.

With that definition, the most-obvious first implementation would be to
first generate the path list, then run
`git rev-list -n 1 <revisions> -- <path>` for each path in the pathspec.
This could be done by N prepare_revision_walk()/get_revision() executions
within a loop instead of actually executing subcommands.

The implementation in this patch is simultaneously smarter than that basic
approach, but also not smart enough for the best performance. In order to
get the optimal performance, the following parts of my output definition
are critical:

 1. We use simplified file history.
 2. The history walk begins at a single commit.

If either of these conditions are broken, then the current-best algorithm
cannot be used (and even more: our proactive caching mechanism cannot be
used).

The API as currently defined does not allow us to enforce that restriction
because the arbitrary arguments could specify `--full-history`, or worse
`--simplify-merge` (and also `--first-parent`) to modify the history mode
or even `--all` to modify the number of starting commits.

The version we use in our custom fork has the historical baggage of this
open-ended argument-parsing, but because we have full control of the
callers to the CLI, we have enforced that those arguments are not being
used. While we are not currently reviewing the CLI of a builtin, the API
layer is essentially providing a pass-through of arbitrary revision options.

I am happy to see that the 'struct blame_tree_options' includes a callback
for the output, as that is valuable for both reporting results to stdout
or to collect results into a list for caching purposes, in the future
where we have that ability.

--- Recommended API ---

Using 'struct blame_tree_options' instead of many parameters creates a
good future-proof method prototype, so we can always _add_ options when
explicitly understood as important to callers of one kind or another.

However, to drop the arbitrary 'args' we need to instead make it very
explicit which commits are being used in the history walk.

struct blame_tree_options {
	struct object_id oid;
	const char *prefix;
	unsigned int recursive;
	struct commit *start;
	struct commit_list *uninteresting;
};

This definition of the struct should be enough to demonstrate the behavior
we are describing. However, for the v1 of the API, we may even want to
completely remove the 'uninteresting' choice, and instead focus only on a
single starting position ('start'). If we decide that 'uninteresting' is
valuable, then it can be added again later, hopefully after the primary
use of this command is established.

Again, thinking about the lifetime of this command in our infrastructure,
the commit range behavior was used at one point as a performance improvement
where a cache was given for a specific starting commit B, then we
dynamically computed the blame-tree for the range B..A when given a new
commit A, and merged the two results together. However, this was not always
correct due to complexities around parallel changes. A different caching
mechanism was built into the low-level algorithm itself which resolves
these complications, but also _that cache cannot be used when given range
queries_.

Further, I recommend building the simplest implementation first, since it
is actually closer to the very fast implementation in that it has two
parts:

 1. Compute the list of paths at the tip.
 2. Perform history walks for those paths.

The fast implementation does a single history walk that essentially walks
the simplified history for all of the paths simultaneously, but it is
critical to have that list of paths at the start of that walk. In that way
it's actually easier to adapt the simpler algorithm to the current-best
algorithm than it is to adapt the smart algorithm from this patch to the
current-best algorithm.

All this is to say, that I'd like to see this API start with the smallest
possible surface area and with the simplest implementation, and then I'd
be happy to contribute those algorithms within the API boundary while the
CLI is handled independently.

Thanks,
-Stolee
