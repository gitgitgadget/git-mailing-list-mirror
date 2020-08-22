Return-Path: <SRS0=iV/m=CA=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6062C433E1
	for <git@archiver.kernel.org>; Sat, 22 Aug 2020 17:15:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 938CF20724
	for <git@archiver.kernel.org>; Sat, 22 Aug 2020 17:15:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sTjY8PbG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728120AbgHVROn (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 22 Aug 2020 13:14:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727945AbgHVROm (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 22 Aug 2020 13:14:42 -0400
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DA6FC061573
        for <git@vger.kernel.org>; Sat, 22 Aug 2020 10:14:42 -0700 (PDT)
Received: by mail-lj1-x244.google.com with SMTP id f26so5184894ljc.8
        for <git@vger.kernel.org>; Sat, 22 Aug 2020 10:14:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:in-reply-to:references:user-agent:date
         :message-id:mime-version:content-transfer-encoding;
        bh=P66Ugs6axfrHRanA3B6vMpHxIuQtpuY5WKlDeqE32/k=;
        b=sTjY8PbG8SDLS2DG2Ubv5i3WYtdQOSvFFLBEbhHh7GfksBRne4YGim7aSZQmdgs+f9
         amZEb3qqFbwS7rsrGGaJA6GkScNHruEPVINq6km0CW47SW/oL11IbnaJA8o8rljTkDkg
         Di+73EDLOEgq+6InypeeVa1Y5jzVtNBt7mYAPt90KcILKnOofMWDj85nxBWrN3Bchuh5
         d2tj62LF3aUiag61z+fI6GJJX0uOCUctV0zdT97ZQAp40oGZ6eCMMSzNO0lGqDbBEHQj
         9LMvQrJaJIFAlVHwmk878FThKpuANYxeV6PFAs97xt1p4/QZW3GuAAgrL+TNqslviDPi
         zP4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references
         :user-agent:date:message-id:mime-version:content-transfer-encoding;
        bh=P66Ugs6axfrHRanA3B6vMpHxIuQtpuY5WKlDeqE32/k=;
        b=FYL43/fBeywOmDZjJ5C1bfXUEMIDr2CTDTHQma2rdSFyNSzCw8eaUa9/4LHVmJKGqY
         46dtGFyy7ZiltAB5ELXhWjjHm8k0WWNFogUWNBerSJC4HYfUuEW1DYpXFboJFt1Nj+EY
         2JAhHRl7TGtTLcMleCFqIDAnMmBxcI+67Rgro+t13472NaDPqTGXVQ/yCmVb6v2pxfau
         btzB3hsa2RPL8fdE3VEvWHQXXi7yMO8c12OFErEKKB3U51z5vFExmR/O+8Pm+tU+p9Qh
         wszupjSAt8Y7moDnCCG3zOnNf+O1N135Skvn3aT74vWwVBc2s7vaQgVtd2h3nrg06Zkl
         7dTQ==
X-Gm-Message-State: AOAM533NXSi0889acOKZYEdUgfqr3iyz/Kr2OOE4Aa+3vIHgBwH0HbXa
        kaISlxxrp7OsdGh8eKGPtfG59HHXXMDaJw==
X-Google-Smtp-Source: ABdhPJwDP0RJe2JcLBX7uLnCXyoM18a/xBTGf/oupNGfuUfEXpTJnc79bhPJo7vsl9ZLt5AtMKFQjg==
X-Received: by 2002:a2e:b4e1:: with SMTP id s1mr3782704ljm.433.1598116480064;
        Sat, 22 Aug 2020 10:14:40 -0700 (PDT)
Received: from LAPTOP-ACER-ASPIRE-F5 (host-89-229-7-83.dynamic.mm.pl. [89.229.7.83])
        by smtp.gmail.com with ESMTPSA id r14sm1112369ljm.92.2020.08.22.10.14.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 22 Aug 2020 10:14:39 -0700 (PDT)
From:   jnareb@gmail.com (Jakub =?utf-8?Q?Nar=C4=99bski?=)
To:     "Abhishek Kumar via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Derrick Stolee <stolee@gmail.com>,
        Taylor Blau <me@ttaylorr.com>,
        Abhishek Kumar <abhishekkumar8222@gmail.com>,
        Jakub =?utf-8?Q?Nar=C4=99bski?= <jnareb@gmail.com>
Subject: Re: [PATCH v3 09/11] commit-graph: use generation v2 only if entire chain does
In-Reply-To: <5a147a9704f0f8d8644c92ea38583e966378b931.1597509583.git.gitgitgadget@gmail.com>
        (Abhishek Kumar via GitGitGadget's message of "Sat, 15 Aug 2020 16:39:41
        +0000")
References: <pull.676.v2.git.1596941624.gitgitgadget@gmail.com>
        <pull.676.v3.git.1597509583.gitgitgadget@gmail.com>
        <5a147a9704f0f8d8644c92ea38583e966378b931.1597509583.git.gitgitgadget@gmail.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (windows-nt)
Date:   Sat, 22 Aug 2020 19:14:38 +0200
Message-ID: <85pn7ihabl.fsf@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Abhishek,

"Abhishek Kumar via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Abhishek Kumar <abhishekkumar8222@gmail.com>
>
> Since there are released versions of Git that understand generation
> numbers in the commit-graph's CDAT chunk but do not understand the GDAT
> chunk, the following scenario is possible:
>
> 1. "New" Git writes a commit-graph with the GDAT chunk.
> 2. "Old" Git writes a split commit-graph on top without a GDAT chunk.
>
> Because of the current use of inspecting the current layer for a
> chunk_generation_data pointer, the commits in the lower layer will be
> interpreted as having very large generation values (commit date plus
> offset) compared to the generation numbers in the top layer (topological
> level). This violates the expectation that the generation of a parent is
> strictly smaller than the generation of a child.

All right, this explains changes to the *reading* side.  If there is
split commit-graph layer without GDAT chunk (or to be more exact,
current code checks if there is any layer without GDAT chunk), then we
fall back to using topological levels, as if all layers / all graphs
were without GDAT.  This allows to avoid the issue explained above,
where for some commits 'generation' holds corrected commit date, and for
some it holds topological levels, breaking the reachability condition
guarantee.


However the commit message do not say anything about the *writing* side.

We have decided to not write the GDAT chunk when writing the new layer
in split commit-graph, and top layer doesn't itself have GDAT chunks.
That makes for easier reasoning and safer handling: in mixed-version
environment the only possible arrangement is for the lower layers
(possibly zero) have GDAT chunk, and higher layers (possibly zero) not
have GDAT chunks.

Rewriting layers follows similar approach: if the topmost layer below
set of layers being rewritten (in the split commit-graph chain) exists,
and it does not contain GDAT chunk, then the result of rewrite should
not have GDAT chunks either.


To be more detailed, without '--split=3Dreplace' we would want the following
layer merging behavior:

   [layer with GDAT][with GDAT][without GDAT][without GDAT][without GDAT]
           1              2           3             4            5

In the split commit-graph chain above, merging two topmost layers
(layers 4 and 5) should create a layer without GDAT; merging three
topmost layers (and any other layers, e.g. two middle ones, i.e. 3 and
4) should create a new layer with GDAT.

   [layer with GDAT][with GDAT][without GDAT][-------without GDAT-------]
           1              2           3               merged

   [layer with GDAT][with GDAT][-------------with GDAT------------------]
           1              2                    merged

I hope those ASCII-art pictures help understanding it

>
> It is difficult to expose this issue in a test. Since we _start_ with
> artificially low generation numbers, any commit walk that prioritizes
> generation numbers will walk all of the commits with high generation
> number before walking the commits with low generation number. In all the
> cases I tried, the commit-graph layers themselves "protect" any
> incorrect behavior since none of the commits in the lower layer can
> reach the commits in the upper layer.
>
> This issue would manifest itself as a performance problem in this case,
> especially with something like "git log --graph" since the low
> generation numbers would cause the in-degree queue to walk all of the
> commits in the lower layer before allowing the topo-order queue to write
> anything to output (depending on the size of the upper layer).

Wouldn't breaking the reachability condition promise make some Git
commands to return *incorrect* results if they short-circuit, stop
walking if generation number shows that A cannot reach B?

I am talking here about commands that return boolean, or select subset
from given set of revisions:
- git merge-base --is-ancestor <B> <A>
- git branch branch-A <A> && git branch --contains <B>
- git branch branch-B <B> && git branch --merged <A>

Git assumes that generation numbers fulfill the following condition:

  if A can reach B, then gen(A) > gen(B)

Notably this includes commits not in commit-graph, and clamped values.

However, in the following case

* if commit A is from higher layer without GDAT
  and uses topological levels for 'generation', e.g. 115 (in a small repo)
* and commit B is from lower layer with GDAT
  and uses corrected commit date as 'generation', for example 1598112896,

it may happen that A (later commit) can reach B (earlier commit), but
gen(B) > gen(A).  The reachability condition promise for generation
numbers is broken.

>
> Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
> Signed-off-by: Abhishek Kumar <abhishekkumar8222@gmail.com>
> ---

I have reordered files in the patch itself to make it easier to review
the proposed changes.

>  commit-graph.h                |  1 +
>  commit-graph.c                | 32 +++++++++++++++-
>  t/t5324-split-commit-graph.sh | 70 +++++++++++++++++++++++++++++++++++
>  3 files changed, 102 insertions(+), 1 deletion(-)
>
> diff --git a/commit-graph.h b/commit-graph.h
> index f78c892fc0..3cf89d895d 100644
> --- a/commit-graph.h
> +++ b/commit-graph.h
> @@ -63,6 +63,7 @@ struct commit_graph {
>  	struct object_directory *odb;
>
>  	uint32_t num_commits_in_base;
> +	uint32_t read_generation_data;
>  	struct commit_graph *base_graph;
>

First, why `read_generation_data` is of uint32_t type, when it stores
(as far as I understand it), a "boolean" value of either 0 or 1?

Second, couldn't we simply set chunk_generation_data to NULL?  Or would
that interfere with the case of rewriting, where we want to use existing
GDAT data when writing new commit-graph with GDAT chunk?

>  	const uint32_t *chunk_oid_fanout;
> diff --git a/commit-graph.c b/commit-graph.c
> index b7a72b40db..c1292f8e08 100644
> --- a/commit-graph.c
> +++ b/commit-graph.c
> @@ -597,6 +597,27 @@ static struct commit_graph *load_commit_graph_chain(=
struct repository *r,
>  	return graph_chain;
>  }
>
> +static void validate_mixed_generation_chain(struct repository *r)
> +{
> +	struct commit_graph *g =3D r->objects->commit_graph;
> +	int read_generation_data =3D 1;
> +
> +	while (g) {
> +		if (!g->chunk_generation_data) {
> +			read_generation_data =3D 0;
> +			break;
> +		}
> +		g =3D g->base_graph;
> +	}

This loop checks whole split commit-graph chain for existence of layers
without GDAT chunk.

On one hand it is more than needed _if_ we assume that the fact that
only topmost layers can be without GDAT holds true. On the other hand it
is safer (an example of defensive coding), and as the length of chain is
limited it should be not much of a performance penalty.

> +
> +	g =3D r->objects->commit_graph;
> +
> +	while (g) {
> +		g->read_generation_data =3D read_generation_data;
> +		g =3D g->base_graph;
> +	}

All right... though one of earlier commits introduced similar loop, but
it set chunk_generation_data to NULL instead.  Or did I remember it wrong?

> +}
> +
>  struct commit_graph *read_commit_graph_one(struct repository *r,
>  					   struct object_directory *odb)
>  {
> @@ -605,6 +626,8 @@ struct commit_graph *read_commit_graph_one(struct rep=
ository *r,
>  	if (!g)
>  		g =3D load_commit_graph_chain(r, odb);
>
> +	validate_mixed_generation_chain(r);
> +

All right, when reading the commit-graph, check if we are in forced
backward-compatibile mode, and we need to use topological levels for
generation numbers.

>  	return g;
>  }
>
> @@ -763,7 +786,7 @@ static void fill_commit_graph_info(struct commit *ite=
m, struct commit_graph *g,
>  	date_low =3D get_be32(commit_data + g->hash_len + 12);
>  	item->date =3D (timestamp_t)((date_high << 32) | date_low);
>
> -	if (g->chunk_generation_data)
> +	if (g->chunk_generation_data && g->read_generation_data)

All right, when deciding whether to use corrected commit date
(generation number v2 from GDAT chunk), or fall back to using
topological levels (generation number v1 from CDAT chunk), we need to
take into accout other layers, to not mix v1 and v2.

We have earlier checked whether we can use generation number v2, now we
use the result of this check, propagated down the commit-graph chain.

>  		graph_data->generation =3D item->date +
>  			(timestamp_t) get_be32(g->chunk_generation_data + sizeof(uint32_t) * =
lex_index);
>  	else
> @@ -885,6 +908,7 @@ void load_commit_graph_info(struct repository *r, str=
uct commit *item)
>  	uint32_t pos;
>  	if (!prepare_commit_graph(r))
>  		return;
> +
>  	if (find_commit_in_graph(item, r->objects->commit_graph, &pos))
>  		fill_commit_graph_info(item, r->objects->commit_graph, pos);
>  }

This is unrelated whitespace fix, a "while at it" in neighbourhood of
changes.  All right then.

> @@ -2192,6 +2216,9 @@ int write_commit_graph(struct object_directory *odb,
>
>  		g =3D ctx->r->objects->commit_graph;
>
> +		if (g && !g->chunk_generation_data)
> +			ctx->write_generation_data =3D 0;
> +
>  		while (g) {
>  			ctx->num_commit_graphs_before++;
>  			g =3D g->base_graph;
> @@ -2210,6 +2237,9 @@ int write_commit_graph(struct object_directory *odb,
>
>  		if (ctx->split_opts)
>  			replace =3D ctx->split_opts->flags & COMMIT_GRAPH_SPLIT_REPLACE;
> +
> +		if (replace)
> +			ctx->write_generation_data =3D 1;
>  	}


The previous commit introduced `write_generation_data` member in
`struct write_commit_graph_context`, then used to handle support for
GIT_TEST_COMMIT_GRAPH_NO_GDAT environment variable.

Those two hunks of changes above are both inside

   if (ctx->split) {
      ...
   }

Here we examine the topmost layer of split commit-graph chain, and if it
does not contain GDAT chunk, then we do not store the GDAT chunk, unless
`git commit-graph write` is ru with `--split=3Dreplace` option.

However this is overly strict condition.  If we merge layer without GDAT
with layer with GDAT below, then we surely can write GDAT; the condition
for GDAT-less layers would be still fulfilled (met).  However we can
consider it 'good enough' for now, and relax this condition in later
commits.


Note that it is the first time in this patch were we make use of
assumption that if there are layers without GDAT then topmost layer is
without GDAT.

>
>  	ctx->approx_nr_objects =3D approximate_object_count();
> diff --git a/t/t5324-split-commit-graph.sh b/t/t5324-split-commit-graph.sh
> index 531016f405..ac5e7783fb 100755
> --- a/t/t5324-split-commit-graph.sh
> +++ b/t/t5324-split-commit-graph.sh
> @@ -424,4 +424,74 @@ done <<\EOF
>  0600 -r--------
>  EOF
>

It would be nice to have an ASCII-art graph of commits, but earlier
tests do not have it either...

> +test_expect_success 'setup repo for mixed generation commit-graph-chain'=
 '
> +	mkdir mixed &&
> +	graphdir=3D".git/objects/info/commit-graphs" &&
> +	cd "$TRASH_DIRECTORY/mixed" &&
> +	git init &&
> +	git config core.commitGraph true &&
> +	git config gc.writeCommitGraph false &&
> +	for i in $(test_seq 3)
> +	do
> +		test_commit $i &&
> +		git branch commits/$i || return 1
> +	done &&
> +	git reset --hard commits/1 &&
> +	for i in $(test_seq 4 5)
> +	do
> +		test_commit $i &&
> +		git branch commits/$i || return 1
> +	done &&
> +	git reset --hard commits/2 &&
> +	for i in $(test_seq 6 10)
> +	do
> +		test_commit $i &&
> +		git branch commits/$i || return 1
> +	done &&
> +	git commit-graph write --reachable --split &&
> +	git reset --hard commits/2 &&
> +	git merge commits/4 &&
> +	git branch merge/1 &&
> +	git reset --hard commits/4 &&
> +	git merge commits/6 &&
> +	git branch merge/2 &&
> +	GIT_TEST_COMMIT_GRAPH_NO_GDAT=3D1 git commit-graph write --reachable --=
split=3Dno-merge &&
> +	test-tool read-graph >output &&
> +	cat >expect <<-EOF &&
> +	header: 43475048 1 1 4 1
> +	num_commits: 2
> +	chunks: oid_fanout oid_lookup commit_metadata
> +	EOF
> +	test_cmp expect output &&
> +	git commit-graph verify
> +'

Looks all right to me.

> +
> +test_expect_success 'does not write generation data chunk if not present=
 on existing tip' '
> +	cd "$TRASH_DIRECTORY/mixed" &&
> +	git reset --hard commits/3 &&
> +	git merge merge/1 &&
> +	git merge commits/5 &&
> +	git merge merge/2 &&
> +	git branch merge/3 &&
> +	git commit-graph write --reachable --split=3Dno-merge &&
> +	test-tool read-graph >output &&
> +	cat >expect <<-EOF &&
> +	header: 43475048 1 1 4 2
> +	num_commits: 3
> +	chunks: oid_fanout oid_lookup commit_metadata
> +	EOF
> +	test_cmp expect output &&
> +	git commit-graph verify
> +'
> +
> +test_expect_success 'writes generation data chunk when commit-graph chai=
n is replaced' '
> +	cd "$TRASH_DIRECTORY/mixed" &&
> +	git commit-graph write --reachable --split=3Dreplace &&
> +	test_path_is_file $graphdir/commit-graph-chain &&
> +	test_line_count =3D 1 $graphdir/commit-graph-chain &&
> +	verify_chain_files_exist $graphdir &&
> +	graph_read_expect 15 &&
> +	git commit-graph verify
> +'

It would be nice to have an example with merging layers (whether we
would handle it in strict or relaxed way).

> +
>  test_done

Best,
--=20
Jakub Nar=C4=99bski
