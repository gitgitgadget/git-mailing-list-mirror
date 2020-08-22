Return-Path: <SRS0=iV/m=CA=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,LOTS_OF_MONEY,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD502C433DF
	for <git@archiver.kernel.org>; Sat, 22 Aug 2020 13:09:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 92B442072D
	for <git@archiver.kernel.org>; Sat, 22 Aug 2020 13:09:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FvxnnvNK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727948AbgHVNJn (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 22 Aug 2020 09:09:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727827AbgHVNJm (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 22 Aug 2020 09:09:42 -0400
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4671CC061573
        for <git@vger.kernel.org>; Sat, 22 Aug 2020 06:09:40 -0700 (PDT)
Received: by mail-lj1-x244.google.com with SMTP id w25so4727277ljo.12
        for <git@vger.kernel.org>; Sat, 22 Aug 2020 06:09:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=pckmu5td79LG/O/peWw3BMv6XE87p+ox/ZK/r4Kl+XI=;
        b=FvxnnvNKP48avU2z7ZLDFC1Sy85l3SUGVgTFMf59pvSAPPBJh1oApMrXIUk/jRwCTZ
         PM5A+78a6j1sl60/kA6aqXWMRyfhzAOVvrrYuziKQ2r0Kvn6nmX3/m6+p8BsbhjgyPQx
         E7mHPnLOm98nPYvjzUbRzHOR+ulMbUdc5IVBFcXV9psrtetiuz1TGKMI8rqESmOakbYV
         y3yCv4FN4clLg6HLAucFCwZNJWmzUUzdDNifpyX2MGmZplAUy8yyxIqeDnNYkZ6pEaOU
         1X8BLNIXB2ljbhO4NTuN18W8TPPzvNkzODb6YdJN6nsUPJbPQfLCyTghd5lkKCNRjG9r
         cw5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:date:in-reply-to
         :message-id:user-agent:mime-version:content-transfer-encoding;
        bh=pckmu5td79LG/O/peWw3BMv6XE87p+ox/ZK/r4Kl+XI=;
        b=Ylgu7697X/AdmaelM07P0hNlnxnQObrTw6INjVQ9ZmgU1J4cmXmt4oxxuYDsQggjZT
         tEEudQenZ0n+QBaylEKRKt8fuqDxcfgmH7dLhieAqW1lhTo8t69YbpFbxAzifUYujan5
         yniGEyoAV6EpGDcbQ+eRIQLELmcTgRx0NaxthZu4bpN4yOxCnlrf8ORLFMrfD/zypyW8
         ruxAUix8HZ+j+xIq0+PBO7NxQgv+vZy4teo/hcj/L6CngMlhCjC4KZ++FD+X36lK2sHH
         FbouUhIGoord3GTPqoUTUrOWDOMXhsOERcPGlo2ynVyro5o8w6St3IQ69baZFJaIOGp8
         cRIw==
X-Gm-Message-State: AOAM532ubgWYhbPvddgIADzfGywYt/Bj9S4OVQPopn6yKzCYpxyekuOE
        Um8KBmmx+8+c9EAhrckBm28=
X-Google-Smtp-Source: ABdhPJzu/2dM3JO72Vajp/n183Qz5vzXTEVkEMzixFE51n3SRr5fwgcSMuZgCZ64icTjnmP1I74d/Q==
X-Received: by 2002:a2e:4e09:: with SMTP id c9mr3824089ljb.283.1598101778208;
        Sat, 22 Aug 2020 06:09:38 -0700 (PDT)
Received: from LAPTOP-ACER-ASPIRE-F5 (host-89-229-7-83.dynamic.mm.pl. [89.229.7.83])
        by smtp.gmail.com with ESMTPSA id h6sm1019214lfc.84.2020.08.22.06.09.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 22 Aug 2020 06:09:37 -0700 (PDT)
From:   jnareb@gmail.com (Jakub =?utf-8?Q?Nar=C4=99bski?=)
To:     "Abhishek Kumar via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Derrick Stolee <stolee@gmail.com>,
        Taylor Blau <me@ttaylorr.com>,
        Abhishek Kumar <abhishekkumar8222@gmail.com>,
        Jakub =?utf-8?Q?Nar=C4=99bski?= <jnareb@gmail.com>
Subject: Re: [PATCH v3 08/11] commit-graph: implement generation data chunk
References: <pull.676.v2.git.1596941624.gitgitgadget@gmail.com>
        <pull.676.v3.git.1597509583.gitgitgadget@gmail.com>
        <4e746628acdb49af5e8eb788864156f54724d4fa.1597509583.git.gitgitgadget@gmail.com>
Date:   Sat, 22 Aug 2020 15:09:35 +0200
In-Reply-To: <4e746628acdb49af5e8eb788864156f54724d4fa.1597509583.git.gitgitgadget@gmail.com>
        (Abhishek Kumar via GitGitGadget's message of "Sat, 15 Aug 2020 16:39:40
        +0000")
Message-ID: <85tuwuj08g.fsf@gmail.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (windows-nt)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

All right, it looks like this patch implements first part of step 2.)
and step 3.) in the following plan of adding support for geeration
number v2:

1. compute generation numbers v2, i.e. corrected commit date
2. store corrected commit date [offsets] in new GDAT chunk,
   unless backward-compatibility concerns require us to not to
3. load [and compute] corrected commit date from commit-graph
   storing it as 'generation' field of `struct commit_graph_data`,
   unless backward-compatibility concerns require us to store
   topological levels (generation number v1) in there instead
4. use generation number v2 in more places, where we had to turn
   off using v1 for performance reasons


"Abhishek Kumar via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Abhishek Kumar <abhishekkumar8222@gmail.com>
>
> As discovered by =C3=86var, we cannot increment graph version to
> distinguish between generation numbers v1 and v2 [1]. Thus, one of
> pre-requistes before implementing generation number was to distinguish
> between graph versions in a backwards compatible manner.

Fortunately, we have fixed this issue, and Git does no longer die when
it encounters commit-graph format version that it does not understand.

>
> We are going to introduce a new chunk called Generation Data chunk (or
> GDAT). GDAT stores generation number v2 (and any subsequent versions),
> whereas CDAT will still store topological level.

Should we say anything about storing 64 bit corrected commit date
(geeration number v2) as 32 bit corrected commit date offset?

>
> Old Git does not understand GDAT chunk and would ignore it, reading
> topological levels from CDAT. New Git can parse GDAT and take advantage
> of newer generation numbers, falling back to topological levels when
> GDAT chunk is missing (as it would happen with a commit graph written
> by old Git).

Note that the fact that we do not have special code for handling
mixed-version layers in split commit-graph is not [that] dangerous, as
we don't read this new data yet.  Splitting it to patch 09/11 (next
patch) makes this patch simpler.

>
> We introduce a test environment variable 'GIT_TEST_COMMIT_GRAPH_NO_GDAT'
> which forces commit-graph file to be written without generation data
> chunk to emulate a commit-graph file written by old Git.

All right.

>
> [1]: https://lore.kernel.org/git/87a7gdspo4.fsf@evledraar.gmail.com/
>
> Signed-off-by: Abhishek Kumar <abhishekkumar8222@gmail.com>
> ---
>  commit-graph.c                | 48 ++++++++++++++++++++++++---
>  commit-graph.h                |  2 ++
>  t/README                      |  3 ++
>  t/helper/test-read-graph.c    |  2 ++
>  t/t4216-log-bloom.sh          |  4 +--
>  t/t5318-commit-graph.sh       | 27 +++++++--------
>  t/t5324-split-commit-graph.sh | 12 +++----
>  t/t6600-test-reach.sh         | 62 +++++++++++++++++++----------------
>  8 files changed, 107 insertions(+), 53 deletions(-)

It might be a good idea to add documentation of this chunk (and only
about this chunk) to Documentation/technical/commit-graph-format.txt

>
> diff --git a/commit-graph.c b/commit-graph.c
> index fd69534dd5..b7a72b40db 100644
> --- a/commit-graph.c
> +++ b/commit-graph.c
> @@ -38,11 +38,12 @@ void git_test_write_commit_graph_or_die(void)
>  #define GRAPH_CHUNKID_OIDFANOUT 0x4f494446 /* "OIDF" */
>  #define GRAPH_CHUNKID_OIDLOOKUP 0x4f49444c /* "OIDL" */
>  #define GRAPH_CHUNKID_DATA 0x43444154 /* "CDAT" */
> +#define GRAPH_CHUNKID_GENERATION_DATA 0x47444154 /* "GDAT" */
>  #define GRAPH_CHUNKID_EXTRAEDGES 0x45444745 /* "EDGE" */
>  #define GRAPH_CHUNKID_BLOOMINDEXES 0x42494458 /* "BIDX" */
>  #define GRAPH_CHUNKID_BLOOMDATA 0x42444154 /* "BDAT" */
>  #define GRAPH_CHUNKID_BASE 0x42415345 /* "BASE" */
> -#define MAX_NUM_CHUNKS 7
> +#define MAX_NUM_CHUNKS 8

All right, define new chunk and increase the maximum number of chunks
commit-graph file can have.

>
>  #define GRAPH_DATA_WIDTH (the_hash_algo->rawsz + 16)
>
> @@ -389,6 +390,13 @@ struct commit_graph *parse_commit_graph(void *graph_=
map, size_t graph_size)
>  				graph->chunk_commit_data =3D data + chunk_offset;
>  			break;
>
> +		case GRAPH_CHUNKID_GENERATION_DATA:
> +			if (graph->chunk_generation_data)
> +				chunk_repeated =3D 1;
> +			else
> +				graph->chunk_generation_data =3D data + chunk_offset;
> +			break;
> +

All right.  The size of GDAT chunk is defined by the number of commits,
so nothink more is needed.

>  		case GRAPH_CHUNKID_EXTRAEDGES:
>  			if (graph->chunk_extra_edges)
>  				chunk_repeated =3D 1;
> @@ -755,7 +763,11 @@ static void fill_commit_graph_info(struct commit *it=
em, struct commit_graph *g,
>  	date_low =3D get_be32(commit_data + g->hash_len + 12);
>  	item->date =3D (timestamp_t)((date_high << 32) | date_low);
>
> -	graph_data->generation =3D get_be32(commit_data + g->hash_len + 8) >> 2;
> +	if (g->chunk_generation_data)
> +		graph_data->generation =3D item->date +
> +			(timestamp_t) get_be32(g->chunk_generation_data + sizeof(uint32_t) * =
lex_index);

WARNING: The above does not properly handle clamped data.

If the offset is maximum value that can be stored in 32 bit field, that
is GENERATION_NUMBER_V2_OFFSET_MAX for more that one commit, we wouldn't
know which commit has greater generation number v2 because of this clamping.
The 'generation' data needs to be set to GENERATION_NUMBER_V2_MAX (which
in turn needs to be smaller than GENERATION_NUMBER_INFINITY).  This is
not done here!

All the above complication would not be an issue if we stored 64 bit
corrected commit date directly, instead of storing 32 bit corrected
commit date offsets. Storing offsets saves at most 4/(2*H + 16 + 4) =3D 7%
of commit-graph file size (OIDL + CDAT + GDAT with offsets), when
160-bit/20-byte SHA-1 hash is used.

> +	else
> +		graph_data->generation =3D get_be32(commit_data + g->hash_len + 8) >> =
2;

Should we convert GENERATION_NUMBER_V1_MAX into GENERATION_NUMBER_MAX
here, for easier handling of clamped values of generation numbers later
on in backward-compatibile way, without special-casing for v1 and v2?


Here we load and perhaps compute generation number, using v2 if possible
(from GDAT + commit date), with fallback to v1 (from CDAT).

Almost all right... but should this reading be a part of this patch, or
split off into separate patch?

>
>  	if (g->topo_levels)
>  		*topo_level_slab_at(g->topo_levels, item) =3D get_be32(commit_data + g=
->hash_len + 8) >> 2;
> @@ -951,7 +963,8 @@ struct write_commit_graph_context {
>  		 report_progress:1,
>  		 split:1,
>  		 changed_paths:1,
> -		 order_by_pack:1;
> +		 order_by_pack:1,
> +		 write_generation_data:1;

All right, here we store the iformation if we should write the GDAT
chunk, taking into account among other things state of the
GIT_TEST_COMMIT_GRAPH_NO_GDAT enviroment variable.

>
>  	struct topo_level_slab *topo_levels;
>  	const struct split_commit_graph_opts *split_opts;
> @@ -1106,8 +1119,25 @@ static int write_graph_chunk_data(struct hashfile =
*f,
>  	return 0;
>  }
>
> +static int write_graph_chunk_generation_data(struct hashfile *f,
> +					      struct write_commit_graph_context *ctx)
> +{
> +	int i;
> +	for (i =3D 0; i < ctx->commits.nr; i++) {

Side note: it is a bit funny that some of write_graph_chunk_*()
functions use `for` loop, and some `while` loop to process commits.

> +		struct commit *c =3D ctx->commits.list[i];
> +		timestamp_t offset =3D commit_graph_data_at(c)->generation - c->date;
> +		display_progress(ctx->progress, ++ctx->progress_cnt);
> +
> +		if (offset > GENERATION_NUMBER_V2_OFFSET_MAX)
> +			offset =3D GENERATION_NUMBER_V2_OFFSET_MAX;

This GENERATION_NUMBER_V2_OFFSET_MAX symbolic constant (or equivalet)
should be defined in this patch and not in previous one, in my opinion.

> +		hashwrite_be32(f, offset);
> +	}
> +
> +	return 0;
> +}
> +
>  static int write_graph_chunk_extra_edges(struct hashfile *f,
> -					 struct write_commit_graph_context *ctx)
> +					  struct write_commit_graph_context *ctx)

This change in whitespace is, I think, incorrect.

>  {
>  	struct commit **list =3D ctx->commits.list;
>  	struct commit **last =3D ctx->commits.list + ctx->commits.nr;
> @@ -1726,6 +1756,15 @@ static int write_commit_graph_file(struct write_co=
mmit_graph_context *ctx)
>  	chunks[2].id =3D GRAPH_CHUNKID_DATA;
>  	chunks[2].size =3D (hashsz + 16) * ctx->commits.nr;
>  	chunks[2].write_fn =3D write_graph_chunk_data;
> +
> +	if (git_env_bool(GIT_TEST_COMMIT_GRAPH_NO_GDAT, 0))
> +		ctx->write_generation_data =3D 0;

All right, here we handle newly introduced GIT_TEST_COMMIT_GRAPH_NO_GDAT
environment variable.

> +	if (ctx->write_generation_data) {
> +		chunks[num_chunks].id =3D GRAPH_CHUNKID_GENERATION_DATA;
> +		chunks[num_chunks].size =3D sizeof(uint32_t) * ctx->commits.nr;
> +		chunks[num_chunks].write_fn =3D write_graph_chunk_generation_data;
> +		num_chunks++;
> +	}

Hmmm... so the GDAT chunk does not have a header, and is not versioned.
Does this mean that to move to generation number v3, or add some
additional reachability labeling we would need to either rename the
chunk or add new one?

>  	if (ctx->num_extra_edges) {
>  		chunks[num_chunks].id =3D GRAPH_CHUNKID_EXTRAEDGES;
>  		chunks[num_chunks].size =3D 4 * ctx->num_extra_edges;
> @@ -2130,6 +2169,7 @@ int write_commit_graph(struct object_directory *odb,
>  	ctx->split =3D flags & COMMIT_GRAPH_WRITE_SPLIT ? 1 : 0;
>  	ctx->split_opts =3D split_opts;
>  	ctx->total_bloom_filter_data_size =3D 0;
> +	ctx->write_generation_data =3D 1;

But by default we do write the GDAT chunk.

>
>  	if (flags & COMMIT_GRAPH_WRITE_BLOOM_FILTERS)
>  		ctx->changed_paths =3D 1;
> diff --git a/commit-graph.h b/commit-graph.h
> index 1152a9642e..f78c892fc0 100644
> --- a/commit-graph.h
> +++ b/commit-graph.h
> @@ -6,6 +6,7 @@
>  #include "oidset.h"
>
>  #define GIT_TEST_COMMIT_GRAPH "GIT_TEST_COMMIT_GRAPH"
> +#define GIT_TEST_COMMIT_GRAPH_NO_GDAT "GIT_TEST_COMMIT_GRAPH_NO_GDAT"
>  #define GIT_TEST_COMMIT_GRAPH_DIE_ON_PARSE "GIT_TEST_COMMIT_GRAPH_DIE_ON=
_PARSE"
>  #define GIT_TEST_COMMIT_GRAPH_CHANGED_PATHS "GIT_TEST_COMMIT_GRAPH_CHANG=
ED_PATHS"
>

All right.

(Though I wonder about the ordering -- but better not to start "bike
shed" discussion).

> @@ -67,6 +68,7 @@ struct commit_graph {
>  	const uint32_t *chunk_oid_fanout;
>  	const unsigned char *chunk_oid_lookup;
>  	const unsigned char *chunk_commit_data;
> +	const unsigned char *chunk_generation_data;
>  	const unsigned char *chunk_extra_edges;
>  	const unsigned char *chunk_base_graphs;
>  	const unsigned char *chunk_bloom_indexes;

All right, we need to store position of new GDAT chunk.

> diff --git a/t/README b/t/README
> index 70ec61cf88..6647ef132e 100644
> --- a/t/README
> +++ b/t/README
> @@ -379,6 +379,9 @@ GIT_TEST_COMMIT_GRAPH=3D<boolean>, when true, forces =
the commit-graph to
>  be written after every 'git commit' command, and overrides the
>  'core.commitGraph' setting to true.
>
> +GIT_TEST_COMMIT_GRAPH_NO_GDAT=3D<boolean>, when true, forces the
> +commit-graph to be written without generation data chunk.
> +

All right.

This description could have been more detailed, but I think it is good
enough.

>  GIT_TEST_COMMIT_GRAPH_CHANGED_PATHS=3D<boolean>, when true, forces
>  commit-graph write to compute and write changed path Bloom filters for
>  every 'git commit-graph write', as if the `--changed-paths` option was
> diff --git a/t/helper/test-read-graph.c b/t/helper/test-read-graph.c
> index 6d0c962438..1c2a5366c7 100644
> --- a/t/helper/test-read-graph.c
> +++ b/t/helper/test-read-graph.c
> @@ -32,6 +32,8 @@ int cmd__read_graph(int argc, const char **argv)
>  		printf(" oid_lookup");
>  	if (graph->chunk_commit_data)
>  		printf(" commit_metadata");
> +	if (graph->chunk_generation_data)
> +		printf(" generation_data");
>  	if (graph->chunk_extra_edges)
>  		printf(" extra_edges");
>  	if (graph->chunk_bloom_indexes)

All right, we examine if GDAT chunk is present.

Many commit-graph tests would probably need to be updated; at least
those that make use if `git test-tool read-graph`.

> diff --git a/t/t4216-log-bloom.sh b/t/t4216-log-bloom.sh
> index c21cc160f3..55c94e9ebd 100755
> --- a/t/t4216-log-bloom.sh
> +++ b/t/t4216-log-bloom.sh
> @@ -33,11 +33,11 @@ test_expect_success 'setup test - repo, commits, comm=
it graph, log outputs' '
>  	git commit-graph write --reachable --changed-paths
>  '
>  graph_read_expect () {
> -	NUM_CHUNKS=3D5
> +	NUM_CHUNKS=3D6
>  	cat >expect <<- EOF
>  	header: 43475048 1 1 $NUM_CHUNKS 0
>  	num_commits: $1
> -	chunks: oid_fanout oid_lookup commit_metadata bloom_indexes bloom_data
> +	chunks: oid_fanout oid_lookup commit_metadata generation_data bloom_ind=
exes bloom_data
>  	EOF
>  	test-tool read-graph >actual &&
>  	test_cmp expect actual

All right.

> diff --git a/t/t5318-commit-graph.sh b/t/t5318-commit-graph.sh
> index 044cf8a3de..b41b2160c6 100755
> --- a/t/t5318-commit-graph.sh
> +++ b/t/t5318-commit-graph.sh
> @@ -71,7 +71,7 @@ graph_git_behavior 'no graph' full commits/3 commits/1
>  graph_read_expect() {
>  	OPTIONAL=3D""
>  	NUM_CHUNKS=3D3
> -	if test ! -z $2
> +	if test ! -z "$2"
>  	then
>  		OPTIONAL=3D" $2"
>  		NUM_CHUNKS=3D$((3 + $(echo "$2" | wc -w)))

All right, a fix for issue that is relevant only after this change, now
that there can be more than one extra chunk.

Side note: how I wish that helper function in tests were documented...

> @@ -98,14 +98,14 @@ test_expect_success 'exit with correct error on bad i=
nput to --stdin-commits' '
>  	# valid commit and tree OID
>  	git rev-parse HEAD HEAD^{tree} >in &&
>  	git commit-graph write --stdin-commits <in &&
> -	graph_read_expect 3
> +	graph_read_expect 3 generation_data

All right, we need to treat generation_data as extra, because it can be
not there (it's existence is conditional).

>  '
>
>  test_expect_success 'write graph' '
>  	cd "$TRASH_DIRECTORY/full" &&
>  	git commit-graph write &&
>  	test_path_is_file $objdir/info/commit-graph &&
> -	graph_read_expect "3"
> +	graph_read_expect "3" generation_data

Side note: I wonder why here we have

  	graph_read_expect "3" generation_data

but one test earlier we have

  	graph_read_expect 3 generation_data

without quotes.

>  '
>
>  test_expect_success POSIXPERM 'write graph has correct permissions' '
> @@ -214,7 +214,7 @@ test_expect_success 'write graph with merges' '
>  	cd "$TRASH_DIRECTORY/full" &&
>  	git commit-graph write &&
>  	test_path_is_file $objdir/info/commit-graph &&
> -	graph_read_expect "10" "extra_edges"
> +	graph_read_expect "10" "generation_data extra_edges"

All right.  It is why we needed to fix graph_read_expect().

>  '
>
>  graph_git_behavior 'merge 1 vs 2' full merge/1 merge/2
> @@ -249,7 +249,7 @@ test_expect_success 'write graph with new commit' '
>  	cd "$TRASH_DIRECTORY/full" &&
>  	git commit-graph write &&
>  	test_path_is_file $objdir/info/commit-graph &&
> -	graph_read_expect "11" "extra_edges"
> +	graph_read_expect "11" "generation_data extra_edges"
>  '
>
>  graph_git_behavior 'full graph, commit 8 vs merge 1' full commits/8 merg=
e/1
> @@ -259,7 +259,7 @@ test_expect_success 'write graph with nothing new' '
>  	cd "$TRASH_DIRECTORY/full" &&
>  	git commit-graph write &&
>  	test_path_is_file $objdir/info/commit-graph &&
> -	graph_read_expect "11" "extra_edges"
> +	graph_read_expect "11" "generation_data extra_edges"
>  '
>
>  graph_git_behavior 'cleared graph, commit 8 vs merge 1' full commits/8 m=
erge/1
> @@ -269,7 +269,7 @@ test_expect_success 'build graph from latest pack wit=
h closure' '
>  	cd "$TRASH_DIRECTORY/full" &&
>  	cat new-idx | git commit-graph write --stdin-packs &&
>  	test_path_is_file $objdir/info/commit-graph &&
> -	graph_read_expect "9" "extra_edges"
> +	graph_read_expect "9" "generation_data extra_edges"
>  '
>
>  graph_git_behavior 'graph from pack, commit 8 vs merge 1' full commits/8=
 merge/1
> @@ -282,7 +282,7 @@ test_expect_success 'build graph from commits with cl=
osure' '
>  	git rev-parse merge/1 >>commits-in &&
>  	cat commits-in | git commit-graph write --stdin-commits &&
>  	test_path_is_file $objdir/info/commit-graph &&
> -	graph_read_expect "6"
> +	graph_read_expect "6" "generation_data"
>  '
>
>  graph_git_behavior 'graph from commits, commit 8 vs merge 1' full commit=
s/8 merge/1
> @@ -292,7 +292,7 @@ test_expect_success 'build graph from commits with ap=
pend' '
>  	cd "$TRASH_DIRECTORY/full" &&
>  	git rev-parse merge/3 | git commit-graph write --stdin-commits --append=
 &&
>  	test_path_is_file $objdir/info/commit-graph &&
> -	graph_read_expect "10" "extra_edges"
> +	graph_read_expect "10" "generation_data extra_edges"
>  '
>
>  graph_git_behavior 'append graph, commit 8 vs merge 1' full commits/8 me=
rge/1
> @@ -302,7 +302,7 @@ test_expect_success 'build graph using --reachable' '
>  	cd "$TRASH_DIRECTORY/full" &&
>  	git commit-graph write --reachable &&
>  	test_path_is_file $objdir/info/commit-graph &&
> -	graph_read_expect "11" "extra_edges"
> +	graph_read_expect "11" "generation_data extra_edges"
>  '
>
>  graph_git_behavior 'append graph, commit 8 vs merge 1' full commits/8 me=
rge/1
> @@ -323,7 +323,7 @@ test_expect_success 'write graph in bare repo' '
>  	cd "$TRASH_DIRECTORY/bare" &&
>  	git commit-graph write &&
>  	test_path_is_file $baredir/info/commit-graph &&
> -	graph_read_expect "11" "extra_edges"
> +	graph_read_expect "11" "generation_data extra_edges"
>  '

All right, those were the straightforward changes.

>
>  graph_git_behavior 'bare repo with graph, commit 8 vs merge 1' bare comm=
its/8 merge/1
> @@ -420,8 +420,9 @@ test_expect_success 'replace-objects invalidates comm=
it-graph' '
>
>  test_expect_success 'git commit-graph verify' '
>  	cd "$TRASH_DIRECTORY/full" &&
> -	git rev-parse commits/8 | git commit-graph write --stdin-commits &&
> -	git commit-graph verify >output
> +	git rev-parse commits/8 | GIT_TEST_COMMIT_GRAPH_NO_GDAT=3D1 git commit-=
graph write --stdin-commits &&
> +	git commit-graph verify >output &&
> +	graph_read_expect 9 extra_edges
>  '

What this change is about?  Is it about the fact that we have not added
support for checking correctness of GDAT chunk to `git commit-graph
verify`?  But in previous commit we did modify verify_commit_graph()...

>
>  NUM_COMMITS=3D9
> diff --git a/t/t5324-split-commit-graph.sh b/t/t5324-split-commit-graph.sh
> index ea28d522b8..531016f405 100755
> --- a/t/t5324-split-commit-graph.sh
> +++ b/t/t5324-split-commit-graph.sh
> @@ -13,11 +13,11 @@ test_expect_success 'setup repo' '
>  	infodir=3D".git/objects/info" &&
>  	graphdir=3D"$infodir/commit-graphs" &&
>  	test_oid_cache <<-EOM
> -	shallow sha1:1760
> -	shallow sha256:2064
> +	shallow sha1:2132
> +	shallow sha256:2436
>
> -	base sha1:1376
> -	base sha256:1496
> +	base sha1:1408
> +	base sha256:1528
>  	EOM
>  '

I guess this change is because with GDAT chunk present the positions of
relevant bits that we want to corrupt change (I guess because we have
extra chunk in chunk lookup section).

Someone else would have to verify if this change is in fact correct, if
it was not done already.

>
> @@ -28,9 +28,9 @@ graph_read_expect() {
>  		NUM_BASE=3D$2
>  	fi
>  	cat >expect <<- EOF
> -	header: 43475048 1 1 3 $NUM_BASE
> +	header: 43475048 1 1 4 $NUM_BASE
>  	num_commits: $1
> -	chunks: oid_fanout oid_lookup commit_metadata
> +	chunks: oid_fanout oid_lookup commit_metadata generation_data

All right, we now have 4 chunks not 3 (old ones + generation_data).

>  	EOF
>  	test-tool read-graph >output &&
>  	test_cmp expect output
> diff --git a/t/t6600-test-reach.sh b/t/t6600-test-reach.sh
> index 475564bee7..d14b129f06 100755
> --- a/t/t6600-test-reach.sh
> +++ b/t/t6600-test-reach.sh
> @@ -55,10 +55,13 @@ test_expect_success 'setup' '
>  	git show-ref -s commit-5-5 | git commit-graph write --stdin-commits &&
>  	mv .git/objects/info/commit-graph commit-graph-half &&
>  	chmod u+w commit-graph-half &&
> +	GIT_TEST_COMMIT_GRAPH_NO_GDAT=3D1 git commit-graph write --reachable &&
> +	mv .git/objects/info/commit-graph commit-graph-no-gdat &&
> +	chmod u+w commit-graph-no-gdat &&
>  	git config core.commitGraph true
>  '

All right, we add setup for testing no GDAT case (as if the commit-graph
file was written by "Old" Git).

>
> -run_three_modes () {
> +run_all_modes () {

All right, we compare more modes, among others the no-GDAT case.

Nice futureproofing!

>  	test_when_finished rm -rf .git/objects/info/commit-graph &&
>  	"$@" <input >actual &&
>  	test_cmp expect actual &&
> @@ -67,11 +70,14 @@ run_three_modes () {
>  	test_cmp expect actual &&
>  	cp commit-graph-half .git/objects/info/commit-graph &&
>  	"$@" <input >actual &&
> +	test_cmp expect actual &&
> +	cp commit-graph-no-gdat .git/objects/info/commit-graph &&
> +	"$@" <input >actual &&
>  	test_cmp expect actual
>  }

OK, now we test yet another variant of commit-graph file: one without
the GDAT chunk (testing for backward compatibility with "Old" Git).

>
> -test_three_modes () {
> -	run_three_modes test-tool reach "$@"
> +test_all_modes () {
> +	run_all_modes test-tool reach "$@"
>  }

All right.

>
>  test_expect_success 'ref_newer:miss' '
> @@ -80,7 +86,7 @@ test_expect_success 'ref_newer:miss' '
>  	B:commit-4-9
>  	EOF
>  	echo "ref_newer(A,B):0" >expect &&
> -	test_three_modes ref_newer
> +	test_all_modes ref_newer
>  '
>
>  test_expect_success 'ref_newer:hit' '
> @@ -89,7 +95,7 @@ test_expect_success 'ref_newer:hit' '
>  	B:commit-2-3
>  	EOF
>  	echo "ref_newer(A,B):1" >expect &&
> -	test_three_modes ref_newer
> +	test_all_modes ref_newer
>  '
>
>  test_expect_success 'in_merge_bases:hit' '
> @@ -98,7 +104,7 @@ test_expect_success 'in_merge_bases:hit' '
>  	B:commit-8-8
>  	EOF
>  	echo "in_merge_bases(A,B):1" >expect &&
> -	test_three_modes in_merge_bases
> +	test_all_modes in_merge_bases
>  '
>
>  test_expect_success 'in_merge_bases:miss' '
> @@ -107,7 +113,7 @@ test_expect_success 'in_merge_bases:miss' '
>  	B:commit-5-9
>  	EOF
>  	echo "in_merge_bases(A,B):0" >expect &&
> -	test_three_modes in_merge_bases
> +	test_all_modes in_merge_bases
>  '
>
>  test_expect_success 'is_descendant_of:hit' '
> @@ -118,7 +124,7 @@ test_expect_success 'is_descendant_of:hit' '
>  	X:commit-1-1
>  	EOF
>  	echo "is_descendant_of(A,X):1" >expect &&
> -	test_three_modes is_descendant_of
> +	test_all_modes is_descendant_of
>  '
>
>  test_expect_success 'is_descendant_of:miss' '
> @@ -129,7 +135,7 @@ test_expect_success 'is_descendant_of:miss' '
>  	X:commit-7-6
>  	EOF
>  	echo "is_descendant_of(A,X):0" >expect &&
> -	test_three_modes is_descendant_of
> +	test_all_modes is_descendant_of
>  '
>
>  test_expect_success 'get_merge_bases_many' '
> @@ -144,7 +150,7 @@ test_expect_success 'get_merge_bases_many' '
>  		git rev-parse commit-5-6 \
>  			      commit-4-7 | sort
>  	} >expect &&
> -	test_three_modes get_merge_bases_many
> +	test_all_modes get_merge_bases_many
>  '
>
>  test_expect_success 'reduce_heads' '
> @@ -166,7 +172,7 @@ test_expect_success 'reduce_heads' '
>  			      commit-2-8 \
>  			      commit-1-10 | sort
>  	} >expect &&
> -	test_three_modes reduce_heads
> +	test_all_modes reduce_heads
>  '
>
>  test_expect_success 'can_all_from_reach:hit' '
> @@ -189,7 +195,7 @@ test_expect_success 'can_all_from_reach:hit' '
>  	Y:commit-8-1
>  	EOF
>  	echo "can_all_from_reach(X,Y):1" >expect &&
> -	test_three_modes can_all_from_reach
> +	test_all_modes can_all_from_reach
>  '
>
>  test_expect_success 'can_all_from_reach:miss' '
> @@ -211,7 +217,7 @@ test_expect_success 'can_all_from_reach:miss' '
>  	Y:commit-8-5
>  	EOF
>  	echo "can_all_from_reach(X,Y):0" >expect &&
> -	test_three_modes can_all_from_reach
> +	test_all_modes can_all_from_reach
>  '
>
>  test_expect_success 'can_all_from_reach_with_flag: tags case' '
> @@ -234,7 +240,7 @@ test_expect_success 'can_all_from_reach_with_flag: ta=
gs case' '
>  	Y:commit-8-1
>  	EOF
>  	echo "can_all_from_reach_with_flag(X,_,_,0,0):1" >expect &&
> -	test_three_modes can_all_from_reach_with_flag
> +	test_all_modes can_all_from_reach_with_flag
>  '
>
>  test_expect_success 'commit_contains:hit' '
> @@ -250,8 +256,8 @@ test_expect_success 'commit_contains:hit' '
>  	X:commit-9-3
>  	EOF
>  	echo "commit_contains(_,A,X,_):1" >expect &&
> -	test_three_modes commit_contains &&
> -	test_three_modes commit_contains --tag
> +	test_all_modes commit_contains &&
> +	test_all_modes commit_contains --tag
>  '
>
>  test_expect_success 'commit_contains:miss' '
> @@ -267,8 +273,8 @@ test_expect_success 'commit_contains:miss' '
>  	X:commit-9-3
>  	EOF
>  	echo "commit_contains(_,A,X,_):0" >expect &&
> -	test_three_modes commit_contains &&
> -	test_three_modes commit_contains --tag
> +	test_all_modes commit_contains &&
> +	test_all_modes commit_contains --tag
>  '
>
>  test_expect_success 'rev-list: basic topo-order' '
> @@ -280,7 +286,7 @@ test_expect_success 'rev-list: basic topo-order' '
>  		commit-6-2 commit-5-2 commit-4-2 commit-3-2 commit-2-2 commit-1-2 \
>  		commit-6-1 commit-5-1 commit-4-1 commit-3-1 commit-2-1 commit-1-1 \
>  	>expect &&
> -	run_three_modes git rev-list --topo-order commit-6-6
> +	run_all_modes git rev-list --topo-order commit-6-6
>  '
>
>  test_expect_success 'rev-list: first-parent topo-order' '
> @@ -292,7 +298,7 @@ test_expect_success 'rev-list: first-parent topo-orde=
r' '
>  		commit-6-2 \
>  		commit-6-1 commit-5-1 commit-4-1 commit-3-1 commit-2-1 commit-1-1 \
>  	>expect &&
> -	run_three_modes git rev-list --first-parent --topo-order commit-6-6
> +	run_all_modes git rev-list --first-parent --topo-order commit-6-6
>  '
>
>  test_expect_success 'rev-list: range topo-order' '
> @@ -304,7 +310,7 @@ test_expect_success 'rev-list: range topo-order' '
>  		commit-6-2 commit-5-2 commit-4-2 \
>  		commit-6-1 commit-5-1 commit-4-1 \
>  	>expect &&
> -	run_three_modes git rev-list --topo-order commit-3-3..commit-6-6
> +	run_all_modes git rev-list --topo-order commit-3-3..commit-6-6
>  '
>
>  test_expect_success 'rev-list: range topo-order' '
> @@ -316,7 +322,7 @@ test_expect_success 'rev-list: range topo-order' '
>  		commit-6-2 commit-5-2 commit-4-2 \
>  		commit-6-1 commit-5-1 commit-4-1 \
>  	>expect &&
> -	run_three_modes git rev-list --topo-order commit-3-8..commit-6-6
> +	run_all_modes git rev-list --topo-order commit-3-8..commit-6-6
>  '
>
>  test_expect_success 'rev-list: first-parent range topo-order' '
> @@ -328,7 +334,7 @@ test_expect_success 'rev-list: first-parent range top=
o-order' '
>  		commit-6-2 \
>  		commit-6-1 commit-5-1 commit-4-1 \
>  	>expect &&
> -	run_three_modes git rev-list --first-parent --topo-order commit-3-8..co=
mmit-6-6
> +	run_all_modes git rev-list --first-parent --topo-order commit-3-8..comm=
it-6-6
>  '
>
>  test_expect_success 'rev-list: ancestry-path topo-order' '
> @@ -338,7 +344,7 @@ test_expect_success 'rev-list: ancestry-path topo-ord=
er' '
>  		commit-6-4 commit-5-4 commit-4-4 commit-3-4 \
>  		commit-6-3 commit-5-3 commit-4-3 \
>  	>expect &&
> -	run_three_modes git rev-list --topo-order --ancestry-path commit-3-3..c=
ommit-6-6
> +	run_all_modes git rev-list --topo-order --ancestry-path commit-3-3..com=
mit-6-6
>  '
>
>  test_expect_success 'rev-list: symmetric difference topo-order' '
> @@ -352,7 +358,7 @@ test_expect_success 'rev-list: symmetric difference t=
opo-order' '
>  		commit-3-8 commit-2-8 commit-1-8 \
>  		commit-3-7 commit-2-7 commit-1-7 \
>  	>expect &&
> -	run_three_modes git rev-list --topo-order commit-3-8...commit-6-6
> +	run_all_modes git rev-list --topo-order commit-3-8...commit-6-6
>  '
>
>  test_expect_success 'get_reachable_subset:all' '
> @@ -372,7 +378,7 @@ test_expect_success 'get_reachable_subset:all' '
>  			      commit-1-7 \
>  			      commit-5-6 | sort
>  	) >expect &&
> -	test_three_modes get_reachable_subset
> +	test_all_modes get_reachable_subset
>  '
>
>  test_expect_success 'get_reachable_subset:some' '
> @@ -390,7 +396,7 @@ test_expect_success 'get_reachable_subset:some' '
>  		git rev-parse commit-3-3 \
>  			      commit-1-7 | sort
>  	) >expect &&
> -	test_three_modes get_reachable_subset
> +	test_all_modes get_reachable_subset
>  '
>
>  test_expect_success 'get_reachable_subset:none' '
> @@ -404,7 +410,7 @@ test_expect_success 'get_reachable_subset:none' '
>  	Y:commit-2-8
>  	EOF
>  	echo "get_reachable_subset(X,Y)" >expect &&
> -	test_three_modes get_reachable_subset
> +	test_all_modes get_reachable_subset
>  '

All right, s/test_three_modes/test_all_modes/... which admitedly could
have been separate pure refactoring patch, but it is not necessary.

>
>  test_done

Best,
--
Jakub Nar=C4=99bski
