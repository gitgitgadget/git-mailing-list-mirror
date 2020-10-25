Return-Path: <SRS0=tbmj=EA=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0785C388F7
	for <git@archiver.kernel.org>; Sun, 25 Oct 2020 13:48:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 73E8122259
	for <git@archiver.kernel.org>; Sun, 25 Oct 2020 13:48:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uF7Llp6g"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1416418AbgJYNsc (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 25 Oct 2020 09:48:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1416351AbgJYNsb (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 25 Oct 2020 09:48:31 -0400
Received: from mail-lf1-x141.google.com (mail-lf1-x141.google.com [IPv6:2a00:1450:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E9D0C0613CE
        for <git@vger.kernel.org>; Sun, 25 Oct 2020 06:48:31 -0700 (PDT)
Received: by mail-lf1-x141.google.com with SMTP id b1so8407415lfp.11
        for <git@vger.kernel.org>; Sun, 25 Oct 2020 06:48:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=4fEU8o1DX8/chukzo29/UmH4GlGiv1aZ/QU3x1kYDC8=;
        b=uF7Llp6g1shvt62iCErVY4vEZhsoO03P/P3046VJn0DXK/df3C4YtVPCAegnYOZQ0c
         rOpY/sRBlrZTWm70e3ae6BE2jUUUSNcrZ3/cB8QcaaGBU/aFLj/v9zPvjX+cgG4ZqpYe
         dA2BMSPQ/avNFcmwItFLZfjFu5gigXxPLN4sDjZ81irQmF8s6lvSdbqcF8e4jCYSTi4f
         CsEnipV1TCgmZirJeHkbPitJc5UG/QGm8ZlG2YAomJOHazqJUZmgvGfxSPoPzKwL4Ovg
         5xKQGqi0bWdkrLfcoBfsvZ5ypAEdSFrylRA0r3CmVh3Bb/8EnkjOiV3g6Y1ppNEXKE3V
         6NnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:date:in-reply-to
         :message-id:user-agent:mime-version:content-transfer-encoding;
        bh=4fEU8o1DX8/chukzo29/UmH4GlGiv1aZ/QU3x1kYDC8=;
        b=hQkn9icuwM+9e4f4wmHEj/UHG3RT2U5t4yRMOKyi7INShhNgTKqONGlgjNBlFWLIX0
         qgFIIUR9xeac+gyza/YmOfkgzXi2cg1N+2ls+i0ROCjhZa+dXvbhBy4+15ike2DRjT6j
         x8D5wEXp57e+NaoBApGdoCcvC9kPGTXmpWzgNfvPOXRwm0CIuNv+JqCd3kG+z69DD7u2
         0NMxEHEbwyaeyCVn8BvByLo9kgWzIJYfMDzRKiol72VCDsGULNyHhopiJ8ss5wjeaMrz
         XoPtKPvv7baYirLCXsymK6di+I9U3uNMgAbg6TJ2JU8A/Mk6MjR5rB2JenDR8I000JI0
         5STA==
X-Gm-Message-State: AOAM532Ksm+u1CL5CiLu8WIWRGY2QrnjPTUw+vqbX93gP2VbHyI6uEk1
        1LqBFmFQFKOhiQoKdRd203aUxdLXiX4Wpw==
X-Google-Smtp-Source: ABdhPJxhmDhQGKUQ6YLkyjEJY3Zyj9W7SYbBRMNSg5F3QCM3MkcireLhGhbrPHMBJ+YmwBujl/5oGQ==
X-Received: by 2002:ac2:53b9:: with SMTP id j25mr3847565lfh.457.1603633709158;
        Sun, 25 Oct 2020 06:48:29 -0700 (PDT)
Received: from LAPTOP-ACER-ASPIRE-F5 (host-89-229-7-83.dynamic.mm.pl. [89.229.7.83])
        by smtp.gmail.com with ESMTPSA id z17sm735971lfq.193.2020.10.25.06.48.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Oct 2020 06:48:28 -0700 (PDT)
From:   jnareb@gmail.com (Jakub =?utf-8?Q?Nar=C4=99bski?=)
To:     "Abhishek Kumar via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Derrick Stolee <stolee@gmail.com>,
        Taylor Blau <me@ttaylorr.com>,
        Abhishek Kumar <abhishekkumar8222@gmail.com>
Subject: Re: [PATCH v4 04/10] commit-graph: return 64-bit generation number
References: <pull.676.v3.git.1597509583.gitgitgadget@gmail.com>
        <pull.676.v4.git.1602079785.gitgitgadget@gmail.com>
        <011b0aa497d1352bf54ac6a9e2e22ed92d409e64.1602079786.git.gitgitgadget@gmail.com>
Date:   Sun, 25 Oct 2020 14:48:27 +0100
In-Reply-To: <011b0aa497d1352bf54ac6a9e2e22ed92d409e64.1602079786.git.gitgitgadget@gmail.com>
        (Abhishek Kumar via GitGitGadget's message of "Wed, 07 Oct 2020 14:09:39
        +0000")
Message-ID: <85imay2z84.fsf@gmail.com>
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
> In a preparatory step, let's return timestamp_t values from
> commit_graph_generation(), use timestamp_t for local variables and
> define GENERATION_NUMBER_INFINITY as (2 ^ 63 - 1) instead.

I think it would be easier to understand if it was explicitely said what
this preparatory step prepares for, e.g.:

  In a preparatory step for introducing corrected commit dates as
  generation number, let's return timestamp_t values from...

Or even

  generation number, let's change the return type of
  commit_graph_generation() to timestamp_t, and use ...

Otherwise it looks good.

>
> We rename GENERATION_NUMBER_MAX to GENERATION_NUMBER_V1_MAX to
> represent the largest topological level we can store in the commit data
> chunk.
>
> With corrected commit dates implemented, we will have two such *_MAX
> variables to denote the largest offset and largest topological level
> that can be stored.

All right, nice explanation.

>
> Signed-off-by: Abhishek Kumar <abhishekkumar8222@gmail.com>

Note that there are two changes that are not mentioned in the commit
message, namely adding 'const'-ness to generation_a/b local variables in
commit_gen_cmp() from commit-graph.c, and switching from
GENERATION_NUMBER_ZERO to GENERATION_NUMBER_INFINITY as the default
(initial) value for 'max_generation' in repo_in_merge_bases_many().

While the former is a simple "while-at-it" change that shouldn't affect
correctness, the latter needs an explanation (or fixing if it is wrong).

> ---
>  commit-graph.c | 22 +++++++++++-----------
>  commit-graph.h |  4 ++--
>  commit-reach.c | 36 ++++++++++++++++++------------------
>  commit-reach.h |  2 +-
>  commit.c       |  4 ++--
>  commit.h       |  4 ++--
>  revision.c     | 10 +++++-----
>  upload-pack.c  |  2 +-
>  8 files changed, 42 insertions(+), 42 deletions(-)
>
> diff --git a/commit-graph.c b/commit-graph.c
> index e8362e144e..bfc532de6f 100644
> --- a/commit-graph.c
> +++ b/commit-graph.c
> @@ -99,7 +99,7 @@ uint32_t commit_graph_position(const struct commit *c)
>  	return data ? data->graph_pos : COMMIT_NOT_FROM_GRAPH;
>  }
>=20=20
> -uint32_t commit_graph_generation(const struct commit *c)
> +timestamp_t commit_graph_generation(const struct commit *c)

All right.

>  {
>  	struct commit_graph_data *data =3D
>  		commit_graph_data_slab_peek(&commit_graph_data_slab, c);
> @@ -144,8 +144,8 @@ static int commit_gen_cmp(const void *va, const void =
*vb)
>  	const struct commit *a =3D *(const struct commit **)va;
>  	const struct commit *b =3D *(const struct commit **)vb;
>=20=20
> -	uint32_t generation_a =3D commit_graph_data_at(a)->generation;
> -	uint32_t generation_b =3D commit_graph_data_at(b)->generation;
> +	const timestamp_t generation_a =3D commit_graph_data_at(a)->generation;
> +	const timestamp_t generation_b =3D commit_graph_data_at(b)->generation;

All right... but this also adds 'const' qualifier.  I understand that
you don't want to create separate commit for this "while at it"
change...

>  	/* lower generation commits first */
>  	if (generation_a < generation_b)
>  		return -1;
> @@ -1350,7 +1350,7 @@ static void compute_generation_numbers(struct write=
_commit_graph_context *ctx)
>  					_("Computing commit graph generation numbers"),
>  					ctx->commits.nr);
>  	for (i =3D 0; i < ctx->commits.nr; i++) {
> -		uint32_t generation =3D commit_graph_data_at(ctx->commits.list[i])->ge=
neration;
> +		timestamp_t generation =3D commit_graph_data_at(ctx->commits.list[i])-=
>generation;

All right.

>=20=20
>  		display_progress(ctx->progress, i + 1);
>  		if (generation !=3D GENERATION_NUMBER_INFINITY &&
> @@ -1383,8 +1383,8 @@ static void compute_generation_numbers(struct write=
_commit_graph_context *ctx)
>  				data->generation =3D max_generation + 1;
>  				pop_commit(&list);
>=20=20
> -				if (data->generation > GENERATION_NUMBER_MAX)
> -					data->generation =3D GENERATION_NUMBER_MAX;
> +				if (data->generation > GENERATION_NUMBER_V1_MAX)
> +					data->generation =3D GENERATION_NUMBER_V1_MAX;

All right, this is the other mentioned change.

>  			}
>  		}
>  	}
> @@ -2404,8 +2404,8 @@ int verify_commit_graph(struct repository *r, struc=
t commit_graph *g, int flags)
>  	for (i =3D 0; i < g->num_commits; i++) {
>  		struct commit *graph_commit, *odb_commit;
>  		struct commit_list *graph_parents, *odb_parents;
> -		uint32_t max_generation =3D 0;
> -		uint32_t generation;
> +		timestamp_t max_generation =3D 0;
> +		timestamp_t generation;

All right.

>=20=20
>  		display_progress(progress, i + 1);
>  		hashcpy(cur_oid.hash, g->chunk_oid_lookup + g->hash_len * i);
> @@ -2469,11 +2469,11 @@ int verify_commit_graph(struct repository *r, str=
uct commit_graph *g, int flags)
>  			continue;
>=20=20
>  		/*
> -		 * If one of our parents has generation GENERATION_NUMBER_MAX, then
> -		 * our generation is also GENERATION_NUMBER_MAX. Decrement to avoid
> +		 * If one of our parents has generation GENERATION_NUMBER_V1_MAX, then
> +		 * our generation is also GENERATION_NUMBER_V1_MAX. Decrement to avoid
>  		 * extra logic in the following condition.
>  		 */
> -		if (max_generation =3D=3D GENERATION_NUMBER_MAX)
> +		if (max_generation =3D=3D GENERATION_NUMBER_V1_MAX)
>  			max_generation--;

All right.  Nice fixing a comment too.

>=20=20
>  		generation =3D commit_graph_generation(graph_commit);
> diff --git a/commit-graph.h b/commit-graph.h
> index f8e92500c6..8be247fa35 100644
> --- a/commit-graph.h
> +++ b/commit-graph.h
> @@ -144,12 +144,12 @@ void disable_commit_graph(struct repository *r);
>=20=20
>  struct commit_graph_data {
>  	uint32_t graph_pos;
> -	uint32_t generation;
> +	timestamp_t generation;
>  };

All right.

>=20=20
>  /*
>   * Commits should be parsed before accessing generation, graph positions.
>   */
> -uint32_t commit_graph_generation(const struct commit *);
> +timestamp_t commit_graph_generation(const struct commit *);
>  uint32_t commit_graph_position(const struct commit *);
>  #endif

All right.

> diff --git a/commit-reach.c b/commit-reach.c
> index 50175b159e..20b48b872b 100644
> --- a/commit-reach.c
> +++ b/commit-reach.c
> @@ -32,12 +32,12 @@ static int queue_has_nonstale(struct prio_queue *queu=
e)
>  static struct commit_list *paint_down_to_common(struct repository *r,
>  						struct commit *one, int n,
>  						struct commit **twos,
> -						int min_generation)
> +						timestamp_t min_generation)
>  {
>  	struct prio_queue queue =3D { compare_commits_by_gen_then_commit_date };
>  	struct commit_list *result =3D NULL;
>  	int i;
> -	uint32_t last_gen =3D GENERATION_NUMBER_INFINITY;
> +	timestamp_t last_gen =3D GENERATION_NUMBER_INFINITY;

All right.

>=20=20
>  	if (!min_generation)
>  		queue.compare =3D compare_commits_by_commit_date;
> @@ -58,10 +58,10 @@ static struct commit_list *paint_down_to_common(struc=
t repository *r,
>  		struct commit *commit =3D prio_queue_get(&queue);
>  		struct commit_list *parents;
>  		int flags;
> -		uint32_t generation =3D commit_graph_generation(commit);
> +		timestamp_t generation =3D commit_graph_generation(commit);

All right.

>=20=20
>  		if (min_generation && generation > last_gen)
> -			BUG("bad generation skip %8x > %8x at %s",
> +			BUG("bad generation skip %"PRItime" > %"PRItime" at %s",

All right; nice of you noticing this issue.

>  			    generation, last_gen,
>  			    oid_to_hex(&commit->object.oid));
>  		last_gen =3D generation;
> @@ -177,12 +177,12 @@ static int remove_redundant(struct repository *r, s=
truct commit **array, int cnt
>  		repo_parse_commit(r, array[i]);
>  	for (i =3D 0; i < cnt; i++) {
>  		struct commit_list *common;
> -		uint32_t min_generation =3D commit_graph_generation(array[i]);
> +		timestamp_t min_generation =3D commit_graph_generation(array[i]);
>=20=20
>  		if (redundant[i])
>  			continue;
>  		for (j =3D filled =3D 0; j < cnt; j++) {
> -			uint32_t curr_generation;
> +			timestamp_t curr_generation;
>  			if (i =3D=3D j || redundant[j])
>  				continue;
>  			filled_index[filled] =3D j;

All right.

> @@ -321,7 +321,7 @@ int repo_in_merge_bases_many(struct repository *r, st=
ruct commit *commit,
>  {
>  	struct commit_list *bases;
>  	int ret =3D 0, i;
> -	uint32_t generation, max_generation =3D GENERATION_NUMBER_ZERO;
> +	timestamp_t generation, max_generation =3D GENERATION_NUMBER_INFINITY;

The change of type from uint32_t to timestamp_t is expected, but the
change from GENERATION_NUMBER_ZERO to GENERATION_NUMBER_INFINITY is not.

This might be caused by the fact that repo_in_merge_bases_many()
switched from using min_generation and GENERATION_NUMBER_INFINITY to
using max_generation and GENERATION_NUMBER_ZERO. Or the reverse: I see
one version on https://github.com/git/git, and other version in 'master'
pulled from https://github.com/git-for-windows/git

Certainly max_generation should be paired with GENERATION_NUMBER_ZERO,
and min_generation with GENERATION_NUMBER_INFINITY.

>=20=20
>  	if (repo_parse_commit(r, commit))
>  		return ret;
> @@ -470,7 +470,7 @@ static int in_commit_list(const struct commit_list *w=
ant, struct commit *c)
>  static enum contains_result contains_test(struct commit *candidate,
>  					  const struct commit_list *want,
>  					  struct contains_cache *cache,
> -					  uint32_t cutoff)
> +					  timestamp_t cutoff)

All right.

Sidenote: this parameter should probably be named gen_cutoff, for
consistency and better readability (but that was the existing state),
but this would also mean more changes.


>  {
>  	enum contains_result *cached =3D contains_cache_at(cache, candidate);
>=20=20
> @@ -506,11 +506,11 @@ static enum contains_result contains_tag_algo(struc=
t commit *candidate,
>  {
>  	struct contains_stack contains_stack =3D { 0, 0, NULL };
>  	enum contains_result result;
> -	uint32_t cutoff =3D GENERATION_NUMBER_INFINITY;
> +	timestamp_t cutoff =3D GENERATION_NUMBER_INFINITY;

Sidenote: this variable should probably be named gen_cutoff, for
consistency and better readability (but that was the existing state).
However changing it would pollute this commit with unrelated changes;
it is not that big of an isseu that it *requires* fixing.

>  	const struct commit_list *p;
>=20=20
>  	for (p =3D want; p; p =3D p->next) {
> -		uint32_t generation;
> +		timestamp_t generation;
>  		struct commit *c =3D p->item;
>  		load_commit_graph_info(the_repository, c);
>  		generation =3D commit_graph_generation(c);

All right.

> @@ -566,8 +566,8 @@ static int compare_commits_by_gen(const void *_a, con=
st void *_b)
>  	const struct commit *a =3D *(const struct commit * const *)_a;
>  	const struct commit *b =3D *(const struct commit * const *)_b;
>=20=20
> -	uint32_t generation_a =3D commit_graph_generation(a);
> -	uint32_t generation_b =3D commit_graph_generation(b);
> +	timestamp_t generation_a =3D commit_graph_generation(a);
> +	timestamp_t generation_b =3D commit_graph_generation(b);

All right.

>=20=20
>  	if (generation_a < generation_b)
>  		return -1;
> @@ -580,7 +580,7 @@ int can_all_from_reach_with_flag(struct object_array =
*from,
>  				 unsigned int with_flag,
>  				 unsigned int assign_flag,
>  				 time_t min_commit_date,
> -				 uint32_t min_generation)
> +				 timestamp_t min_generation)
>  {
>  	struct commit **list =3D NULL;
>  	int i;

All right.

> @@ -681,13 +681,13 @@ int can_all_from_reach(struct commit_list *from, st=
ruct commit_list *to,
>  	time_t min_commit_date =3D cutoff_by_min_date ? from->item->date : 0;
>  	struct commit_list *from_iter =3D from, *to_iter =3D to;
>  	int result;
> -	uint32_t min_generation =3D GENERATION_NUMBER_INFINITY;
> +	timestamp_t min_generation =3D GENERATION_NUMBER_INFINITY;
>=20=20
>  	while (from_iter) {
>  		add_object_array(&from_iter->item->object, NULL, &from_objs);
>=20=20
>  		if (!parse_commit(from_iter->item)) {
> -			uint32_t generation;
> +			timestamp_t generation;
>  			if (from_iter->item->date < min_commit_date)
>  				min_commit_date =3D from_iter->item->date;
>

All right.

> @@ -701,7 +701,7 @@ int can_all_from_reach(struct commit_list *from, stru=
ct commit_list *to,
>=20=20
>  	while (to_iter) {
>  		if (!parse_commit(to_iter->item)) {
> -			uint32_t generation;
> +			timestamp_t generation;
>  			if (to_iter->item->date < min_commit_date)
>  				min_commit_date =3D to_iter->item->date;
>

All right.

> @@ -741,13 +741,13 @@ struct commit_list *get_reachable_subset(struct com=
mit **from, int nr_from,
>  	struct commit_list *found_commits =3D NULL;
>  	struct commit **to_last =3D to + nr_to;
>  	struct commit **from_last =3D from + nr_from;
> -	uint32_t min_generation =3D GENERATION_NUMBER_INFINITY;
> +	timestamp_t min_generation =3D GENERATION_NUMBER_INFINITY;
>  	int num_to_find =3D 0;
>=20=20
>  	struct prio_queue queue =3D { compare_commits_by_gen_then_commit_date };
>=20=20
>  	for (item =3D to; item < to_last; item++) {
> -		uint32_t generation;
> +		timestamp_t generation;
>  		struct commit *c =3D *item;
>=20=20
>  		parse_commit(c);

All right.

> diff --git a/commit-reach.h b/commit-reach.h
> index b49ad71a31..148b56fea5 100644
> --- a/commit-reach.h
> +++ b/commit-reach.h
> @@ -87,7 +87,7 @@ int can_all_from_reach_with_flag(struct object_array *f=
rom,
>  				 unsigned int with_flag,
>  				 unsigned int assign_flag,
>  				 time_t min_commit_date,
> -				 uint32_t min_generation);
> +				 timestamp_t min_generation);
>  int can_all_from_reach(struct commit_list *from, struct commit_list *to,
>  		       int commit_date_cutoff);
>

All right.

> diff --git a/commit.c b/commit.c
> index f53429c0ac..3b488381d5 100644
> --- a/commit.c
> +++ b/commit.c
> @@ -731,8 +731,8 @@ int compare_commits_by_author_date(const void *a_, co=
nst void *b_,
>  int compare_commits_by_gen_then_commit_date(const void *a_, const void *=
b_, void *unused)
>  {
>  	const struct commit *a =3D a_, *b =3D b_;
> -	const uint32_t generation_a =3D commit_graph_generation(a),
> -		       generation_b =3D commit_graph_generation(b);
> +	const timestamp_t generation_a =3D commit_graph_generation(a),
> +			  generation_b =3D commit_graph_generation(b);
>

All right (assuming that the indent after change looks all right; but
even if it doesn't t would be a very minor issue).

>  	/* newer commits first */
>  	if (generation_a < generation_b)
> diff --git a/commit.h b/commit.h
> index 5467786c7b..33c66b2177 100644
> --- a/commit.h
> +++ b/commit.h
> @@ -11,8 +11,8 @@
>  #include "commit-slab.h"
>=20=20
>  #define COMMIT_NOT_FROM_GRAPH 0xFFFFFFFF
> -#define GENERATION_NUMBER_INFINITY 0xFFFFFFFF
> -#define GENERATION_NUMBER_MAX 0x3FFFFFFF
> +#define GENERATION_NUMBER_INFINITY ((1ULL << 63) - 1)
> +#define GENERATION_NUMBER_V1_MAX 0x3FFFFFFF
>  #define GENERATION_NUMBER_ZERO 0
>

All right, we redefine GENERATION_NUMBER_INFINITY and rename
GENERATION_NUMBER_MAX.

>  struct commit_list {
> diff --git a/revision.c b/revision.c
> index c97abcdde1..2861f1c45c 100644
> --- a/revision.c
> +++ b/revision.c
> @@ -3308,7 +3308,7 @@ define_commit_slab(indegree_slab, int);
>  define_commit_slab(author_date_slab, timestamp_t);
>=20=20
>  struct topo_walk_info {
> -	uint32_t min_generation;
> +	timestamp_t min_generation;
>  	struct prio_queue explore_queue;
>  	struct prio_queue indegree_queue;
>  	struct prio_queue topo_queue;

All right.

> @@ -3354,7 +3354,7 @@ static void explore_walk_step(struct rev_info *revs)
>  }
>=20=20
>  static void explore_to_depth(struct rev_info *revs,
> -			     uint32_t gen_cutoff)
> +			     timestamp_t gen_cutoff)
>  {
>  	struct topo_walk_info *info =3D revs->topo_walk_info;
>  	struct commit *c;

All right.

> @@ -3397,7 +3397,7 @@ static void indegree_walk_step(struct rev_info *rev=
s)
>  }
>=20=20
>  static void compute_indegrees_to_depth(struct rev_info *revs,
> -				       uint32_t gen_cutoff)
> +				       timestamp_t gen_cutoff)
>  {
>  	struct topo_walk_info *info =3D revs->topo_walk_info;
>  	struct commit *c;

All right.

> @@ -3455,7 +3455,7 @@ static void init_topo_walk(struct rev_info *revs)
>  	info->min_generation =3D GENERATION_NUMBER_INFINITY;
>  	for (list =3D revs->commits; list; list =3D list->next) {
>  		struct commit *c =3D list->item;
> -		uint32_t generation;
> +		timestamp_t generation;
>=20=20
>  		if (repo_parse_commit_gently(revs->repo, c, 1))
>  			continue;

All right.

> @@ -3516,7 +3516,7 @@ static void expand_topo_walk(struct rev_info *revs,=
 struct commit *commit)
>  	for (p =3D commit->parents; p; p =3D p->next) {
>  		struct commit *parent =3D p->item;
>  		int *pi;
> -		uint32_t generation;
> +		timestamp_t generation;
>=20=20
>  		if (parent->object.flags & UNINTERESTING)
>  			continue;

All right.

> diff --git a/upload-pack.c b/upload-pack.c
> index 3b858eb457..fdb82885b6 100644
> --- a/upload-pack.c
> +++ b/upload-pack.c
> @@ -497,7 +497,7 @@ static int got_oid(struct upload_pack_data *data,
>=20=20
>  static int ok_to_give_up(struct upload_pack_data *data)
>  {
> -	uint32_t min_generation =3D GENERATION_NUMBER_ZERO;
> +	timestamp_t min_generation =3D GENERATION_NUMBER_ZERO;
>=20=20
>  	if (!data->have_obj.nr)
>  		return 0;

All right.

The only thing to check is if you have changed the type in all the
places that need it. My cursory examination shows that those are all
places than need fixing.

Note that the 'generation' variable in git-name-rev, git-fsck and in
git-show-branch (snd sha1-name.c) means something different.

Also, 'first_generation' variable in generation_numbers_enabled() (part
of commit-graph.c) examines and will examine generation number v1 i.e.
topological levels, and do not need type change... though it may require
name change in some time in the future; the generation number
computation path also does not require change type, though variables
would be renamed in the future commit.

Best,
--=20
Jakub Nar=C4=99bski
