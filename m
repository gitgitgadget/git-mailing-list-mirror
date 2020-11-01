Return-Path: <SRS0=MFMM=EH=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BABC9C388F7
	for <git@archiver.kernel.org>; Sun,  1 Nov 2020 00:55:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5A63420888
	for <git@archiver.kernel.org>; Sun,  1 Nov 2020 00:55:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VDMZ4ICH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726234AbgKAAzP (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 31 Oct 2020 20:55:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726159AbgKAAzO (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 31 Oct 2020 20:55:14 -0400
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52211C0617A6
        for <git@vger.kernel.org>; Sat, 31 Oct 2020 17:55:14 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id b1so12702036lfp.11
        for <git@vger.kernel.org>; Sat, 31 Oct 2020 17:55:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=XI/xpOI27G7IJgF2+vIK7nYVkfptyYad7yTaJGLlVwg=;
        b=VDMZ4ICHGhyCBprHr6kPQe/F3sQyKsoubIc6C7l7dMamZsuDIxxPLWH8lhfH6wOD0w
         HbNxyzrZmfpcFaIbSFBZc0YqIcwQjGhOrRPVlv+yE/33vmavhMGzj5hjNNR9jxz3cHhS
         z7IzhLDwyTDrfyiJOHN/IGHMyjA5tsEK3ns2V4HvDwLf1oR18vr1eR9TcKDEuKslet8B
         aSkEjcCDjlPge9nkMT3L+qarzDoyAmH0hO3X9yTho9Dj1Se8SuMEbJrRq1J9hWSJnlB4
         DqNyMkmJ5qWFRJ6oBv6/bbu6sx9K7vFSzKkYq+FDtlU63hK7uJa5MIfowkzQSQKTKM18
         S14Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:date:in-reply-to
         :message-id:user-agent:mime-version:content-transfer-encoding;
        bh=XI/xpOI27G7IJgF2+vIK7nYVkfptyYad7yTaJGLlVwg=;
        b=Esivjv6J8I5u2DkeHbD66iNWJxEtwAoL8/9qHsxObWc1CxQV88QCrj1g8d2xIhtvf5
         r2zByuksiMy1IxpNrMiSLmUJGVSWEb+R664uj4Gc2H/exmk2XRwpoXjNprCbAVtmV07F
         SBZ99FKdii7r08yy9MQotmmPQxuudPz2zcqEDQbUg88iqkhWal6KVwKJdwg9c/4aEI3v
         FW4CSA2siuuhTzJovRzcWjRsYZEGidPzfefkZKDi8NpBx1ArGO68jimMiiW0qMW4CfEK
         r6d94IMVn/McK1gi7Xk55+KprDboviITri4qQ73zt1G8hPGxd76s/M0ubNeRikuhXZOg
         9sVA==
X-Gm-Message-State: AOAM533B2/3HBLHA7OkDsZidCTgK4Kc+T/x+hcHxL0ONOOiebu1ZY3sH
        1Ce5J2PS5r60QDXQWNOaH7s=
X-Google-Smtp-Source: ABdhPJx14jn3sdsDLgnd45Im2GG+fP6/Ezz2gjgSZW9Z6eae3t3YvQoO4Hm9DLHWvW+3nUFoqnwjEA==
X-Received: by 2002:ac2:52ad:: with SMTP id r13mr3098487lfm.534.1604192112270;
        Sat, 31 Oct 2020 17:55:12 -0700 (PDT)
Received: from LAPTOP-ACER-ASPIRE-F5 (host-89-229-7-83.dynamic.mm.pl. [89.229.7.83])
        by smtp.gmail.com with ESMTPSA id r7sm1181014lfc.206.2020.10.31.17.55.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 31 Oct 2020 17:55:11 -0700 (PDT)
From:   Jakub =?utf-8?Q?Nar=C4=99bski?= <jnareb@gmail.com>
To:     "Abhishek Kumar via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Derrick Stolee <stolee@gmail.com>,
        Taylor Blau <me@ttaylorr.com>,
        Abhishek Kumar <abhishekkumar8222@gmail.com>
Subject: Re: [PATCH v4 08/10] commit-graph: use generation v2 only if entire chain does
References: <pull.676.v3.git.1597509583.gitgitgadget@gmail.com>
        <pull.676.v4.git.1602079785.gitgitgadget@gmail.com>
        <8ec119edc66814ad4d63908c79437a7f9dd3c08c.1602079786.git.gitgitgadget@gmail.com>
Date:   Sun, 01 Nov 2020 01:55:11 +0100
In-Reply-To: <8ec119edc66814ad4d63908c79437a7f9dd3c08c.1602079786.git.gitgitgadget@gmail.com>
        (Abhishek Kumar via GitGitGadget's message of "Wed, 07 Oct 2020 14:09:43
        +0000")
Message-ID: <85zh41sxow.fsf@gmail.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (windows-nt)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
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

All right.

>
> Because of the current use of inspecting the current layer for a
> chunk_generation_data pointer, the commits in the lower layer will be
> interpreted as having very large generation values (commit date plus
> offset) compared to the generation numbers in the top layer (topological
> level). This violates the expectation that the generation of a parent is
> strictly smaller than the generation of a child.

I think this paragraphs tries too much to be concise, with the result it
is less clear than it could be.  Perhaps it would be better to separate
"what-if" from the current behavior.

  If each layer of split commit-graph is treated independently, as it
  were the case before this commit, with Git inspecting only the current
  layer for chunk_generation_data pointer, commits in the lower layer
  (one with GDAT) would have corrected commit date as their generation
  number, while commits in the upper layer would have topological levels
  as their generation.  Corrected commit dates have usually much larger
  values than topological levels.  This means that if we take two
  commits, one from the upper layer, and one reachable from it in the
  lower layer, then the expectation that the generation of a parent is
  smaller than the generation of a child would be violated.

>
> It is difficult to expose this issue in a test. Since we _start_ with
> artificially low generation numbers, any commit walk that prioritizes
> generation numbers will walk all of the commits with high generation
> number before walking the commits with low generation number. In all the
> cases I tried, the commit-graph layers themselves "protect" any
> incorrect behavior since none of the commits in the lower layer can
> reach the commits in the upper layer.

I don't quite understand the issue here. Unless none of the following
query commands short-circuit and all walk the commit graph regardless of
what generation numbers tell them, they should give different results
with and without the commit graph, if we take two commits one from lower
layer of split commit graph with GDAT, and one commit from the higher
layer without GDAT, one lower reachable from the other higher.

We have the following query commands that we can check:
  $ git merge-base --is-ancestor <lower> <higher>
  $ git merge-base --independent <lower> <higher>
=20=20
  $ git tag --contains <tag-to-lower>
  $ git tag --merged <tag-to-higher>
  $ git branch --contains <branch-to-lower>
  $ git branch --merged <branch-to-higher>

The second set of queries require for those commits to be tagged, or
have branch pointing at them, respectively.

Also, shouldn't `git commit-graph verify` fail with split commit graph
where the top layer is created with GIT_TEST_COMMIT_GRAPH_NO_GDAT=3D1?


Let's assume that we have the following history, with newer commits
shown on top like in `git log --graph --oneline --all`:

          topological     corrected         generation
          level           commit date       number^*

      d    3                                3
      |
   c  |    3                                3
   |  |                                                 without GDAT
 ..|..|.....[layer.boundary]........................................
   |  |                                                    with GDAT
   |  b    2              1112912113        1112912113
   |  |
   a  |    2              1112912053        1112912053
   | /
   |/
   r       1              1112911993        1112911993

*) each layer inspected individually.

With such history, we can for example reach 'a' from 'c', thus
`git merge-base --is-ancestor a b` should return true value, but
without this commit gen(a) > gen(c), instead of gen(a) <=3D gen(c);
I use here weaker reachability condition, but the one that works
also for commits outside the commit-graph (and those for which
generation numbers overflows).

>
> This issue would manifest itself as a performance problem in this case,
> especially with something like "git log --graph" since the low
> generation numbers would cause the in-degree queue to walk all of the
> commits in the lower layer before allowing the topo-order queue to write
> anything to output (depending on the size of the upper layer).

All right, that's good explanation.

>
> When writing the new layer in split commit-graph, we write a GDAT chunk
> only if the topmost layer has a GDAT chunk. This guarantees that if a
> layer has GDAT chunk, all lower layers must have a GDAT chunk as well.
>
> Rewriting layers follows similar approach: if the topmost layer below
> the set of layers being rewritten (in the split commit-graph chain)
> exists, and it does not contain GDAT chunk, then the result of rewrite
> does not have GDAT chunks either.

All right, very good explanation; the only minor suggestion would be to
add some 'intro' to the first of those two paragraphs, for example:

  Therefore, when writing the new layer in split commit-graph...

Though I am not sure if it is necessary.

>
> Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
> Signed-off-by: Abhishek Kumar <abhishekkumar8222@gmail.com>
> ---
>  commit-graph.c                | 29 +++++++++++-
>  commit-graph.h                |  1 +
>  t/t5324-split-commit-graph.sh | 86 +++++++++++++++++++++++++++++++++++
>  3 files changed, 115 insertions(+), 1 deletion(-)
>
> diff --git a/commit-graph.c b/commit-graph.c
> index 71d0b243db..5d15a1399b 100644
> --- a/commit-graph.c
> +++ b/commit-graph.c
> @@ -605,6 +605,21 @@ static struct commit_graph *load_commit_graph_chain(=
struct repository *r,
>  	return graph_chain;
>  }
>=20=20
> +static void validate_mixed_generation_chain(struct commit_graph *g)
> +{
> +	int read_generation_data;
> +
> +	if (!g)
> +		return;
> +
> +	read_generation_data =3D !!g->chunk_generation_data;
> +
> +	while (g) {
> +		g->read_generation_data =3D read_generation_data;
> +		g =3D g->base_graph;
> +	}
> +}

All right, this function checks assumedly topmost layer if it is
GDAT-less, and if it is propagates this status down the layers of split
commit graph.  This is needed because if we have mixed-generation commit
graph, then for each and every layer we need to use topological levels
as generation number.

The only minor issue is the name of this function (it does not hint that
it propagates the GDAT status downwards), but I don't have a better
idea, unfortunately.  And it does reflect what this function is used for.

> +
>  struct commit_graph *read_commit_graph_one(struct repository *r,
>  					   struct object_directory *odb)
>  {
> @@ -613,6 +628,8 @@ struct commit_graph *read_commit_graph_one(struct rep=
ository *r,
>  	if (!g)
>  		g =3D load_commit_graph_chain(r, odb);
>=20=20
> +	validate_mixed_generation_chain(g);
> +

All right, this looks like a good place to put this new check: just
after reading commit-graph chain.

>  	return g;
>  }
>=20=20
> @@ -782,7 +799,7 @@ static void fill_commit_graph_info(struct commit *ite=
m, struct commit_graph *g,
>  	date_low =3D get_be32(commit_data + g->hash_len + 12);
>  	item->date =3D (timestamp_t)((date_high << 32) | date_low);
>=20=20
> -	if (g->chunk_generation_data) {
> +	if (g->chunk_generation_data && g->read_generation_data) {
>  		offset =3D (timestamp_t) get_be32(g->chunk_generation_data + sizeof(ui=
nt32_t) * lex_index);

All right, instead of simply checking if the current layer has
generation data chunk, we need to also check if the whole graph allows
for it (if there are no mixed-generation layers).

The g->read_generation_data should be filled correctly, because
fill_commit_graph_info() is always preceded by read_commit_graph(), if I
understand it correctly.

>=20=20
>  		if (offset & CORRECTED_COMMIT_DATE_OFFSET_OVERFLOW) {
> @@ -2030,6 +2047,9 @@ static void split_graph_merge_strategy(struct write=
_commit_graph_context *ctx)
>  		}
>  	}
>=20=20
> +	if (!ctx->write_generation_data && g->chunk_generation_data)
> +		ctx->write_generation_data =3D 1;
> +

This needs more careful examination, and looking at larger context of
those lines.

At this point, unless `--split=3Dreplace` option is used, 'g' points to
the bottom layer out of all topmost layers being merged. We know that if
there are GDAT-less layers then these must be top layers, so this means
that we can write GDAT chunk in the result of the merge -- because we
would be replacing all possible GDAT-less layers (and maybe some with
GDAT) with a single layer with the GDAT chunk.

The ctx->write_generation_data is set to true unless environment
variable GIT_TEST_COMMIT_GRAPH_NO_GDAT is true, and that in
write_commit_graph() it would be set to false if topmost layer doesn't
have GDAT chunk, and to true if `--split=3Dreplace` option is used; see
below.

Looks good to me.


NOTE that this means that GIT_TEST_COMMIT_GRAPH_NO_GDAT prevents from
writing GDAT chunk with generation data v2 unless we are merging layers,
or replacing all of them with a single layer: then it is _ignored_.

Should we clarify this fact in the description of GIT_TEST_COMMIT_GRAPH_NO_=
GDAT
in t/README?  Currently it reads:

  GIT_TEST_COMMIT_GRAPH_NO_GDAT=3D<boolean>, when true, forces the
  commit-graph to be written without generation data chunk.

>  	if (flags !=3D COMMIT_GRAPH_SPLIT_REPLACE)
>  		ctx->new_base_graph =3D g;
>  	else if (ctx->num_commit_graphs_after !=3D 1)
> @@ -2274,6 +2294,7 @@ int write_commit_graph(struct object_directory *odb,
>  		struct commit_graph *g =3D ctx->r->objects->commit_graph;
>=20=20
>  		while (g) {
> +			g->read_generation_data =3D 1;
>  			g->topo_levels =3D &topo_levels;
>  			g =3D g->base_graph;
>  		}

All right, when writing the commit graph we want to make use of existing
generation data chunks.  This is safe, because when computing generation
numbers for writing we have separate place to store topoogical levels
(`topo_levels`) so they would not be mixed with corrected commit dates:
generation number v1 and v2 are kept separate.

> @@ -2300,6 +2321,9 @@ int write_commit_graph(struct object_directory *odb,
>=20=20
>  		g =3D ctx->r->objects->commit_graph;
>=20=20
> +		if (g && !g->chunk_generation_data)
> +			ctx->write_generation_data =3D 0;
> +

All right, if current (topmost) layed does not have GDAT, then when
creating a new layer do not create GDAT layer either (merging layers and
rewriting the commit-graph is handled separately).

>  		while (g) {
>  			ctx->num_commit_graphs_before++;
>  			g =3D g->base_graph;
> @@ -2318,6 +2342,9 @@ int write_commit_graph(struct object_directory *odb,
>=20=20
>  		if (ctx->opts)
>  			replace =3D ctx->opts->split_flags & COMMIT_GRAPH_SPLIT_REPLACE;
> +
> +		if (replace)
> +			ctx->write_generation_data =3D 1;

All right, when replacing all layers (`git commit-graph write --split=3Drep=
lace`),
then we can safely write the GDAT chunk.

Note however that here we don't take into account the value of the
environment variable GIT_TEST_COMMIT_GRAPH_NO_GDAT.  Which maybe is what
we want...

>  	}
>=20=20
>  	ctx->approx_nr_objects =3D approximate_object_count();
> diff --git a/commit-graph.h b/commit-graph.h
> index 19a02001fd..ad52130883 100644
> --- a/commit-graph.h
> +++ b/commit-graph.h
> @@ -64,6 +64,7 @@ struct commit_graph {
>  	struct object_directory *odb;
>=20=20
>  	uint32_t num_commits_in_base;
> +	unsigned int read_generation_data;
>  	struct commit_graph *base_graph;

All right, this new field is here to propagate to each layer the
information whether we can read from the generation number v2 data
chunk.

Though I am not sure whether this field should be added here, and
whether it should be `unsigned int` (we don't have to be that careful
about saving space for this type).

>=20=20
>  	const uint32_t *chunk_oid_fanout;
> diff --git a/t/t5324-split-commit-graph.sh b/t/t5324-split-commit-graph.sh
> index 651df89ab2..d0949a9eb8 100755
> --- a/t/t5324-split-commit-graph.sh
> +++ b/t/t5324-split-commit-graph.sh
> @@ -440,4 +440,90 @@ test_expect_success '--split=3Dreplace with partial =
Bloom data' '
>  	verify_chain_files_exist $graphdir
>  '
>=20=20
> +test_expect_success 'setup repo for mixed generation commit-graph-chain'=
 '
> +	mkdir mixed &&

This should probably go just before cd-ing into just created
subdirectory.

> +	graphdir=3D".git/objects/info/commit-graphs" &&
> +	test_oid_cache <<-EOM &&
> +	oid_version sha1:1
> +	oid_version sha256:2
> +	EOM

Minor nitpick: Why use "EOM", which is used only twice in Git the test
suite, and not the conventional "EOF" (used at least 4000 times)?

> +	cd "$TRASH_DIRECTORY/mixed" &&

The t/README says:

   - Don't chdir around in tests.  It is not sufficient to chdir to
     somewhere and then chdir back to the original location later in
     the test, as any intermediate step can fail and abort the test,
     causing the next test to start in an unexpected directory.  Do so
     inside a subshell if necessary.

Though I am not sure if it should apply also to this situation.

> +	git init &&
> +	git config core.commitGraph true &&
> +	git config gc.writeCommitGraph false &&

All right.

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

Is there a reason why we do not check just written commit-graph file
with `test-tool read-graph >output-layer-1`?

> +	git reset --hard commits/2 &&
> +	git merge commits/4 &&

Shouldn't we use `test_merge` instead of `git merge`; I am not sure when
to use one or the other?

> +	git branch merge/1 &&
> +	git reset --hard commits/4 &&
> +	git merge commits/6 &&
> +	git branch merge/2 &&

It would be nice to have ASCII-art of the history (of the graph of
revisions) created here for subsequent tests:

=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20
           /- 6 <-- 7 <-- 8 <-- 9 <-- 10*
          /    \-\
         /        \
  1 <-- 2 <-- 3*   \--\
  |      \             \=20
  |       \-----\       \
   \             \       \
    \-- 4*<------ M/1     M/2
        |\               /=20=20
        | \-- 5*        /
        \              /
         \------------/

  * - 1st layer=20=20

Though I am not sure if what I have created is readable; I think a
better way to draw this graph is possible, for example:

               /- 3*
              /
             /
  1 <------ 2 <---- 6 <-- 7 <-- 8 <-- 9 <-- 10*
   \         \       \
    \         \       \
     \         \       \
      \- 4* <-- M/1     \=20=20=20=20
         |\              \
         | \------------- M/2
         \
          \---- 5*

Edit: as I see the history gets even more complicated, so perhaps
ASCII-art diagram of the history with layers marked would be too
complicated, and wouldn't bring much.

Why do we need such shape of the history in the repository?

> +	GIT_TEST_COMMIT_GRAPH_NO_GDAT=3D1 git commit-graph write --reachable --=
split=3Dno-merge &&
> +	test-tool read-graph >output &&
> +	cat >expect <<-EOF &&
> +	header: 43475048 1 $(test_oid oid_version) 4 1
> +	num_commits: 2
> +	chunks: oid_fanout oid_lookup commit_metadata
> +	EOF
> +	test_cmp expect output &&

All right, we check that we have 2 commits, and that there is no GDAT
chunk.

> +	git commit-graph verify

All right, we verify commit-graph as a whole (both layers).

> +'
> +
> +test_expect_success 'does not write generation data chunk if not present=
 on existing tip' '

Hmmm... I wonder if we can come up with a better name for this test;
for example should it be "does not write" or "do not write"?

> +	cd "$TRASH_DIRECTORY/mixed" &&
> +	git reset --hard commits/3 &&
> +	git merge merge/1 &&
> +	git merge commits/5 &&
> +	git merge merge/2 &&
> +	git branch merge/3 &&

The commit graph gets complicated, so it would not be easy to visualize
it with ASCII-art diagram without any crossed lines.  Maybe `git log
--graph --oneline --all` would help:

*   (merge/3) Merge branch 'merge/2'
|\
| *   (merge/2) Merge branch 'commits/6'
| |\
* | \   Merge branch 'commits/5'
|\ \ \
| * | | (commits/5) 5
| |/ /
* | |   Merge branch 'merge/1'
|\ \ \
| * | | (merge/1) Merge branch 'commits/4'
| |\| |
| | * | (commits/4) 4
* | | | (commits/3) 3
|/ / /
| | | * (commits/10) 10
| | | * (commits/9) 9
| | | * (commits/8) 8
| | | * (commits/7) 7
| | |/
| | * (commits/6) 6
| |/
|/|
* | (commits/2) 2
|/
* (commits/1) 1


> +	git commit-graph write --reachable --split=3Dno-merge &&
> +	test-tool read-graph >output &&
> +	cat >expect <<-EOF &&
> +	header: 43475048 1 $(test_oid oid_version) 4 2
> +	num_commits: 3
> +	chunks: oid_fanout oid_lookup commit_metadata
> +	EOF
> +	test_cmp expect output &&
> +	git commit-graph verify

All right, so here we check that we have layer without GDAT at the top,
and we request not to merge layers thus new layer will be created, then
the new layer also does not have GDAT chunk (and has 3 commits).

Minor nitpick: shouldn't those test be indented?

> +'
> +
> +test_expect_success 'writes generation data chunk when commit-graph chai=
n is replaced' '
> +	cd "$TRASH_DIRECTORY/mixed" &&
> +	git commit-graph write --reachable --split=3Dreplace &&
> +	test_path_is_file $graphdir/commit-graph-chain &&
> +	test_line_count =3D 1 $graphdir/commit-graph-chain &&
> +	verify_chain_files_exist $graphdir &&

All right, this checks that we have split commit-graph chain that
consist of a single layer, and that the commit-graph file for this
single layer exists.

> +	graph_read_expect 15 &&

Shouldn't we use `test-tool read-graph` to check whether generation_data
chunk is present... ah, sorry, I have realized that after previous
patches `graph_read_expect 15` implicitly checks the latter, because in
its' use of `test-tool read-graph` it does expect generation_data chunk.

So we use `test-tool read-graph` manually to check that generation_data
chunk is absent, and we use graph_read_expect to check that it is
present (and in both cases that the number of commits matches).  I
wonder if it would be possible to simplify that...

> +	git commit-graph verify

All right.

> +'
> +
> +test_expect_success 'add one commit, write a tip graph' '
> +	cd "$TRASH_DIRECTORY/mixed" &&
> +	test_commit 11 &&
> +	git branch commits/11 &&
> +	git commit-graph write --reachable --split &&
> +	test_path_is_missing $infodir/commit-graph &&
> +	test_path_is_file $graphdir/commit-graph-chain &&
> +	ls $graphdir/graph-*.graph >graph-files &&
> +	test_line_count =3D 2 graph-files &&
> +	verify_chain_files_exist $graphdir
> +'

What it is meant to test?  That adding single-commit to a 15 commit
commit-graph file in split mode does not result in layers merging, and
actually adds a new layer: we check that we have exactly two layers and
that they are all OK.

We don't check here that the newly created top layer commit-graph does
have GDAT chunk, as it should be if the top layer (in this case the only
layer) has GDAT chunk.

> +
>  test_done

One test we are missing is testing that merging layers is done
correctly, namely that if we are merging layers in split commit-graph
file, and the layer below the ones we are merging lacks GDAT chunk, then
the result of the merge should also be without GDAT chunk.  This would
require at least two GDAT-less layers in a setup.

I'm not sure how difficult writing such test should be.

Best,
--=20
Jakub Nar=C4=99bski
