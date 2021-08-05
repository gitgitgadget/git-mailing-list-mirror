Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAE5AC4338F
	for <git@archiver.kernel.org>; Thu,  5 Aug 2021 11:25:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AB10B61108
	for <git@archiver.kernel.org>; Thu,  5 Aug 2021 11:25:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240971AbhHELZk (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 5 Aug 2021 07:25:40 -0400
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:44155 "EHLO
        out3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S240623AbhHELZk (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 5 Aug 2021 07:25:40 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.nyi.internal (Postfix) with ESMTP id 6CB245C008E;
        Thu,  5 Aug 2021 07:25:25 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Thu, 05 Aug 2021 07:25:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=date
        :from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm1; bh=rt3UI1XOOWitgc2uLRW1pdrI1xb
        Pgtk9GdB5bkhHQlM=; b=VuZP4tu75913jY7H2C1phRPEbzbgJhdxfhbuytKpBLV
        t1fgbJTCdT2s1HMq6iQPxwLIDqh1R6jtTO0HtDFRVFZfoU81m6kGB3Oz0U7SrrWq
        qog2iqPkT7bumZsyPetnkx+k4cTDevwd98dvma7jjtYWY0RkfIdbHLRXfbky2aVj
        sV4M8M3o/yrRzZPnGdJOxf+P7L1aH7zTtuGiEfvxEC0mG2tWOZLD++yqQPohQKe3
        0qhvHytHqaqNcezjyA9/0EmpN66e1vGoIYfDnh6ODNulNnwnHRTb9EeXO6ccq/8A
        7X1pF9h2Yin+4riUVV4s5KfjJxBpowX9bh2AHrg4erw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=rt3UI1
        XOOWitgc2uLRW1pdrI1xbPgtk9GdB5bkhHQlM=; b=bLCNPWj4wAAxPLQWd01bIv
        nCvDNuxtW/PIWI6nyPoomgm8GFiChr8AxZ7yr/jihPzEXZFKoVLTYiInbRIh+y3V
        DJ992DgOagd6RViqmmCdjDpuAlrC4JbcM8UZ91H8vRSz5isdUFPsimlHHaqvs8CM
        SPBlq/bNndi1e/rLxsVj+Yx6YJs0jOH8emh06Xbp7q9q3fg1We/g/8P+6lh/csxb
        ySfsvX6vE/OQ51jehlahXK4HuLYjvhJfec/oXUTEmyqdmNhJNbyhF0hJDyrkWeBe
        zYGRU6bedIRX6rLndaJ6GArEOj4CuyPnVy/AV5Q3ei61iu5RiNFTuh8O/Xo+NNeQ
        ==
X-ME-Sender: <xms:pcoLYXwaj5nRCXn6J8pzLvJjOmt_OzUJq7-f5_sgr5K6qdUxLc3WQA>
    <xme:pcoLYfTK_y1X8iFb7EAbvPOPcN1jJouWF8brOZ0UdS9IAxQYznGVUcq_aVZjR4Wmm
    YA0FH_zaX0IAQIIBg>
X-ME-Received: <xmr:pcoLYRX6kA7n4Zlm6cc9aeCWMJokooRxCL22ZbCiBbaJMyo9vzqa5raeBs2d4iqcGCALalqc_vQl13GNi5Djo3yjEWTEXLjcg5Dth9Bat4dWSzGn3uubeC4>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvtddrieelgdefkecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvuffkfhggtggujgesghdtreertddtjeenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    ephefgjeeuveejteduhefgffefffdvjeefjeeivdekfffgkeeugfehveetueefleeknecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimh
X-ME-Proxy: <xmx:pcoLYRjFqHo1tvXsh-8FqtPBK7fE0YTFVU6_hqrNVD2_I-S9WP0Svw>
    <xmx:pcoLYZA_U5k2oj4fhatP4u0969YdYqIJ9BPvHKEw-cxbVWH4qrHC0Q>
    <xmx:pcoLYaIMNA0Z4rRUnOROAvA0R0U1fc2ZCeSVVPEA4zuU6dKqGzy2JA>
    <xmx:pcoLYb0WKEdcHx2alaoDkQ8DhhJB-IXCWNBNkBfFH7NxD1CU_BuW-A>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 5 Aug 2021 07:25:23 -0400 (EDT)
Received: from localhost (ncase [10.192.0.11])
        by vm-mail.pks.im (OpenSMTPD) with ESMTPSA id e9057f9f (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Thu, 5 Aug 2021 11:25:20 +0000 (UTC)
Date:   Thu, 5 Aug 2021 13:25:19 +0200
From:   Patrick Steinhardt <ps@pks.im>
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        SZEDER =?iso-8859-1?Q?G=E1bor?= <szeder.dev@gmail.com>,
        Chris Torek <chris.torek@gmail.com>,
        =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Taylor Blau <me@ttaylorr.com>
Subject: [PATCH v4 0/6] Speed up connectivity checks
Message-ID: <cover.1628162156.git.ps@pks.im>
References: <cover.1627896460.git.ps@pks.im>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="ORyOJyGFPjfiSM9a"
Content-Disposition: inline
In-Reply-To: <cover.1627896460.git.ps@pks.im>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--ORyOJyGFPjfiSM9a
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

this is version 4 of my series to speed up connectivity checks. Given
that v3 has received positive feedback, I finally stuck to the approach
and only have a bunch of iterative changes based on your feedback.

Changes compared to v3:

    - Patch 1/6 is new and splits up revs->no_walk into revs->no_walk
      which now only indicates whether to walk and revs->unserted_input,
      which indicates whether to sort input.

    - Patch 2/6 got some documentation for the new `--unsorted-input`
      option. Furthermore, we refuse `--no-walk`/`--no-walk=3Dsorted` and
      `--unsorted-input` if used together. I've also added some tests
      for the new option.

    - Patch 3/6 has an updated commit message, detailing that
      `add_pending_oid()` only is a thin wrapper around
      `add_pending_object()`.

    - Patch 4/6 has an update commit message, stating that it's a
      prerequisite for 6/6.

    - Patch 5/6 is new, splitting out the logic to find a commit ID in
      the commit graph as a prerequisite for 6/6.

    - Patch 6/6 now also verifies that commits parsed only via the
      commit-graph exist in the ODB. I've also renamed
      `find_object_in_graph()` to `parse_commit_in_graph_gently()` to
      better reflect what the function does.

With the added existence check in 6/6, the speedup is not as big as
before (1.47x faster instead of 1.55x). But it's still very much worth
it. In total, this patch series decreases `git rev-list --objects
--unsorted --not --all --not $newrev` from 7.6s to 3.0s in my test
repository.

Thanks for all your feedback!

Patrick

Patrick Steinhardt (6):
  revision: separate walk and unsorted flags
  connected: do not sort input revisions
  revision: stop retrieving reference twice
  revision: avoid loading object headers multiple times
  commit-graph: split out function to search commit position
  revision: avoid hitting packfiles when commits are in commit-graph

 Documentation/rev-list-options.txt |  8 +++-
 builtin/log.c                      |  2 +-
 builtin/revert.c                   |  3 +-
 commit-graph.c                     | 75 +++++++++++++++++++++---------
 commit-graph.h                     |  7 +++
 connected.c                        |  1 +
 revision.c                         | 52 +++++++++++++++++----
 revision.h                         |  7 +--
 t/t6000-rev-list-misc.sh           | 38 +++++++++++++++
 9 files changed, 153 insertions(+), 40 deletions(-)

Range-diff against v3:
-:  ---------- > 1:  67232910ac revision: separate walk and unsorted flags
1:  1fd83f726a ! 2:  9d7f484907 connected: do not sort input revisions
    @@ Commit message
    =20
         Signed-off-by: Patrick Steinhardt <ps@pks.im>
    =20
    + ## Documentation/rev-list-options.txt ##
    +@@ Documentation/rev-list-options.txt: list of the missing objects.  O=
bject IDs are prefixed with a ``?'' character.
    + 	objects.
    + endif::git-rev-list[]
    +=20
    ++--unsorted-input::
    ++	Show commits in the order they were given on the command line instead
    ++	of sorting them in reverse chronological order by commit time. Cannot
    ++	be combined with `--no-walk` or `--no-walk=3Dsorted`.
    ++
    + --no-walk[=3D(sorted|unsorted)]::
    + 	Only show the given commits, but do not traverse their ancestors.
    + 	This has no effect if a range is specified. If the argument
    +@@ Documentation/rev-list-options.txt: endif::git-rev-list[]
    + 	given on the command line. Otherwise (if `sorted` or no argument
    + 	was given), the commits are shown in reverse chronological order
    + 	by commit time.
    +-	Cannot be combined with `--graph`.
    ++	Cannot be combined with `--graph`. Cannot be combined with
    ++	`--unsorted-input` if `sorted` or no argument was given.
    +=20
    + --do-walk::
    + 	Overrides a previous `--no-walk`.
    +
      ## connected.c ##
     @@ connected.c: int check_connected(oid_iterate_fn fn, void *cb_data,
      	if (opt->progress)
    @@ revision.c: static int handle_revision_opt(struct rev_info *revs, in=
t argc, cons
      		revs->sort_order =3D REV_SORT_BY_AUTHOR_DATE;
      		revs->topo_order =3D 1;
     +	} else if (!strcmp(arg, "--unsorted-input")) {
    ++		if (revs->no_walk && !revs->unsorted_input)
    ++			die(_("--unsorted-input is incompatible with --no-walk and --no-wa=
lk=3Dsorted"));
     +		revs->unsorted_input =3D 1;
      	} else if (!strcmp(arg, "--early-output")) {
      		revs->early_output =3D 100;
      		revs->topo_order =3D 1;
    -@@ revision.c: int prepare_revision_walk(struct rev_info *revs)
    -=20
    - 	if (!revs->reflog_info)
    - 		prepare_to_use_bloom_filter(revs);
    --	if (revs->no_walk !=3D REVISION_WALK_NO_WALK_UNSORTED)
    -+	if (revs->no_walk !=3D REVISION_WALK_NO_WALK_UNSORTED && !revs->unso=
rted_input)
    - 		commit_list_sort_by_date(&revs->commits);
    - 	if (revs->no_walk)
    - 		return 0;
    +@@ revision.c: static int handle_revision_pseudo_opt(const char *submo=
dule,
    + 	} else if (!strcmp(arg, "--not")) {
    + 		*flags ^=3D UNINTERESTING | BOTTOM;
    + 	} else if (!strcmp(arg, "--no-walk")) {
    ++		if (revs->unsorted_input)
    ++			die(_("--no-walk is incompatible with --no-walk=3Dunsorted and --u=
nsorted-input"));
    + 		revs->no_walk =3D 1;
    + 	} else if (skip_prefix(arg, "--no-walk=3D", &optarg)) {
    + 		/*
    +@@ revision.c: static int handle_revision_pseudo_opt(const char *submo=
dule,
    + 		 * not allowed, since the argument is optional.
    + 		 */
    + 		revs->no_walk =3D 1;
    +-		if (!strcmp(optarg, "sorted"))
    ++		if (!strcmp(optarg, "sorted")) {
    ++			if (revs->unsorted_input)
    ++				die(_("--no-walk=3Dsorted is incompatible with --no-walk=3Dunsort=
ed "
    ++				    "and --unsorted-input"));
    + 			revs->unsorted_input =3D 0;
    +-		else if (!strcmp(optarg, "unsorted"))
    ++		} else if (!strcmp(optarg, "unsorted"))
    + 			revs->unsorted_input =3D 1;
    + 		else
    + 			return error("invalid argument to --no-walk");
    =20
    - ## revision.h ##
    -@@ revision.h: struct rev_info {
    - 			simplify_history:1,
    - 			show_pulls:1,
    - 			topo_order:1,
    -+			unsorted_input:1,
    - 			simplify_merges:1,
    - 			simplify_by_decoration:1,
    - 			single_worktree:1,
    + ## t/t6000-rev-list-misc.sh ##
    +@@ t/t6000-rev-list-misc.sh: test_expect_success 'rev-list --count --o=
bjects' '
    + 	test_line_count =3D $count actual
    + '
    +=20
    ++test_expect_success 'rev-list --unsorted-input results in different s=
orting' '
    ++	git rev-list --unsorted-input HEAD HEAD~ >first &&
    ++	git rev-list --unsorted-input HEAD~ HEAD >second &&
    ++	! test_cmp first second &&
    ++	sort first >first.sorted &&
    ++	sort second >second.sorted &&
    ++	test_cmp first.sorted second.sorted
    ++'
    ++
    ++test_expect_success 'rev-list --unsorted-input compatible with --no-w=
alk=3Dunsorted' '
    ++	git rev-list --unsorted-input --no-walk=3Dunsorted HEAD HEAD~ >actua=
l &&
    ++	git rev-parse HEAD >expect &&
    ++	git rev-parse HEAD~ >>expect &&
    ++	test_cmp expect actual
    ++'
    ++
    ++test_expect_success 'rev-list --unsorted-input incompatible with --no=
-walk=3Dsorted' '
    ++	cat >expect <<-EOF &&
    ++		fatal: --no-walk is incompatible with --no-walk=3Dunsorted and --un=
sorted-input
    ++	EOF
    ++	test_must_fail git rev-list --unsorted-input --no-walk HEAD 2>error =
&&
    ++	test_cmp expect error &&
    ++
    ++	cat >expect <<-EOF &&
    ++		fatal: --no-walk=3Dsorted is incompatible with --no-walk=3Dunsorted=
 and --unsorted-input
    ++	EOF
    ++	test_must_fail git rev-list --unsorted-input --no-walk=3Dsorted HEAD=
 2>error &&
    ++	test_cmp expect error &&
    ++
    ++	cat >expect <<-EOF &&
    ++		fatal: --unsorted-input is incompatible with --no-walk and --no-wal=
k=3Dsorted
    ++	EOF
    ++	test_must_fail git rev-list --no-walk --unsorted-input HEAD 2>error =
&&
    ++	test_cmp expect error &&
    ++	test_must_fail git rev-list --no-walk=3Dsorted --unsorted-input HEAD=
 2>error &&
    ++	test_cmp expect error
    ++'
    ++
    + test_done
2:  db85480649 ! 3:  d8e63d0943 revision: stop retrieving reference twice
    @@ Commit message
         revision: stop retrieving reference twice
    =20
         When queueing up references for the revision walk, `handle_one_ref=
()`
    -    will resolve the reference's object ID and then queue the ID as pe=
nding
    -    object via `add_pending_oid()`. But `add_pending_oid()` will again=
 try
    -    to resolve the object ID to an object, effectively duplicating the=
 work
    -    its caller already did before.
    +    will resolve the reference's object ID via `get_reference()` and t=
hen
    +    queue the ID as pending object via `add_pending_oid()`. But given =
that
    +    `add_pending_oid()` is only a thin wrapper around `add_pending_obj=
ect()`
    +    which fist calls `get_reference()`, we effectively resolve the ref=
erence
    +    twice and thus duplicate some of the work.
    =20
    -    Fix the issue by instead calling `add_pending_object()`, which tak=
es the
    -    already-resolved object as input. In a repository with lots of ref=
s,
    -    this translates in a nearly 10% speedup:
    +    Fix the issue by instead calling `add_pending_object()` directly, =
which
    +    takes the already-resolved object as input. In a repository with l=
ots of
    +    refs, this translates into a near 10% speedup:
    =20
             Benchmark #1: HEAD~: rev-list --unsorted-input --objects --qui=
et --not --all --not $newrev
               Time (mean =C2=B1 =CF=83):      5.015 s =C2=B1  0.038 s    [=
User: 4.698 s, System: 0.316 s]
3:  b9897e102a ! 4:  ba8df5cad0 revision: avoid loading object headers mult=
iple times
    @@ Commit message
         either a tag or a commit, we'd have a modest increase in memory
         consumption of about 12.5% here.
    =20
    +    Note that on its own, this patch may not seem like a clear win. Bu=
t it
    +    is a prerequisite for the following patch, which will result in an=
other
    +    37% speedup.
    +
         Signed-off-by: Patrick Steinhardt <ps@pks.im>
    =20
      ## revision.c ##
-:  ---------- > 5:  e33cd51ebf commit-graph: split out function to search =
commit position
4:  f6fc2a5e6d ! 6:  900c5a9c60 revision: avoid hitting packfiles when comm=
its are in commit-graph
    @@ Commit message
         directly fill in the commit object, otherwise we can still hit the=
 disk
         to determine the object's type.
    =20
    -    Expose a new function `find_object_in_graph()`, which fills in an =
object
    -    of unknown type in case we find its object ID in the graph. This
    -    provides a big performance win in cases where there is a commit-gr=
aph
    -    available in the repository in case we load lots of references. The
    -    following has been executed in a real-world repository with about =
2.2
    -    million refs:
    +    Expose a new function `parse_commit_in_graph_gently()`, which fill=
s in
    +    an object of unknown type in case we find its object ID in the gra=
ph.
    +    This provides a big performance win in cases where there is a
    +    commit-graph available in the repository in case we load lots of
    +    references. The following has been executed in a real-world reposi=
tory
    +    with about 2.2 million refs:
    =20
             Benchmark #1: HEAD~: rev-list --unsorted-input --objects --qui=
et --not --all --not $newrev
    -          Time (mean =C2=B1 =CF=83):      4.465 s =C2=B1  0.037 s    [=
User: 4.144 s, System: 0.320 s]
    -          Range (min =E2=80=A6 max):    4.411 s =E2=80=A6  4.514 s    =
10 runs
    +          Time (mean =C2=B1 =CF=83):      4.508 s =C2=B1  0.039 s    [=
User: 4.131 s, System: 0.377 s]
    +          Range (min =E2=80=A6 max):    4.455 s =E2=80=A6  4.576 s    =
10 runs
    =20
             Benchmark #2: HEAD: rev-list --unsorted-input --objects --quie=
t --not --all --not $newrev
    -          Time (mean =C2=B1 =CF=83):      2.886 s =C2=B1  0.032 s    [=
User: 2.570 s, System: 0.316 s]
    -          Range (min =E2=80=A6 max):    2.826 s =E2=80=A6  2.933 s    =
10 runs
    +          Time (mean =C2=B1 =CF=83):      3.072 s =C2=B1  0.031 s    [=
User: 2.707 s, System: 0.365 s]
    +          Range (min =E2=80=A6 max):    3.040 s =E2=80=A6  3.144 s    =
10 runs
    =20
             Summary
               'HEAD: rev-list --unsorted-input --objects --quiet --not --a=
ll --not $newrev' ran
    -            1.55 =C2=B1 0.02 times faster than 'HEAD~: rev-list --unso=
rted-input --objects --quiet --not --all --not $newrev'
    +            1.47 =C2=B1 0.02 times faster than 'HEAD~: rev-list --unso=
rted-input --objects --quiet --not --all --not $newrev'
    =20
         Signed-off-by: Patrick Steinhardt <ps@pks.im>
    =20
      ## commit-graph.c ##
    -@@ commit-graph.c: static int fill_commit_in_graph(struct repository *=
r,
    - 	return 1;
    +@@ commit-graph.c: static int find_commit_pos_in_graph(struct commit *=
item, struct commit_graph *g,
    + 	}
      }
     =20
    -+static int find_object_id_in_graph(const struct object_id *id, struct=
 commit_graph *g, uint32_t *pos)
    -+{
    -+	struct commit_graph *cur_g =3D g;
    -+	uint32_t lex_index;
    -+
    -+	while (cur_g && !bsearch_graph(cur_g, (struct object_id *)id, &lex_i=
ndex))
    -+		cur_g =3D cur_g->base_graph;
    -+
    -+	if (cur_g) {
    -+		*pos =3D lex_index + cur_g->num_commits_in_base;
    -+		return 1;
    -+	}
    -+
    -+	return 0;
    -+}
    -+
    -+int find_object_in_graph(struct repository *repo, struct object *obje=
ct)
    ++int parse_commit_in_graph_gently(struct repository *repo, struct obje=
ct *object)
     +{
     +	struct commit *commit;
     +	uint32_t pos;
    @@ commit-graph.c: static int fill_commit_in_graph(struct repository *r,
     +	if (!repo->objects->commit_graph)
     +		return -1;
     +
    -+	if (!find_object_id_in_graph(&object->oid, repo->objects->commit_gra=
ph, &pos))
    ++	if (!search_commit_pos_in_graph(&object->oid, repo->objects->commit_=
graph, &pos))
     +		return -1;
     +
     +	commit =3D object_as_type(object, OBJ_COMMIT, 1);
    @@ commit-graph.c: static int fill_commit_in_graph(struct repository *r,
     +	return 0;
     +}
     +
    - static int find_commit_in_graph(struct commit *item, struct commit_gr=
aph *g, uint32_t *pos)
    - {
    - 	uint32_t graph_pos =3D commit_graph_position(item);
    -@@ commit-graph.c: static int find_commit_in_graph(struct commit *item=
, struct commit_graph *g, uin
    - 		*pos =3D graph_pos;
    - 		return 1;
    - 	} else {
    --		struct commit_graph *cur_g =3D g;
    --		uint32_t lex_index;
    --
    --		while (cur_g && !bsearch_graph(cur_g, &(item->object.oid), &lex_ind=
ex))
    --			cur_g =3D cur_g->base_graph;
    --
    --		if (cur_g) {
    --			*pos =3D lex_index + cur_g->num_commits_in_base;
    --			return 1;
    --		}
    --
    --		return 0;
    -+		return find_object_id_in_graph(&item->object.oid, g, pos);
    - 	}
    - }
    -=20
    + static int parse_commit_in_graph_one(struct repository *r,
    + 				     struct commit_graph *g,
    + 				     struct commit *item)
    =20
      ## commit-graph.h ##
    -@@ commit-graph.h: int write_commit_graph(struct object_directory *odb,
    - 		       enum commit_graph_write_flags flags,
    - 		       const struct commit_graph_opts *opts);
    +@@ commit-graph.h: int open_commit_graph(const char *graph_file, int *=
fd, struct stat *st);
    +  */
    + int parse_commit_in_graph(struct repository *r, struct commit *item);
     =20
    -+int find_object_in_graph(struct repository *repo, struct object *obje=
ct);
    ++/*
    ++ * Given an object of unknown type, try to fill in the object in case=
 it is a
    ++ * commit part of the commit-graph. Returns 0 if the object is a pars=
ed commit
    ++ * or if it could be filled in via the commit graph, otherwise it ret=
urns -1.
    ++ */
    ++int parse_commit_in_graph_gently(struct repository *repo, struct obje=
ct *object);
     +
    - #define COMMIT_GRAPH_VERIFY_SHALLOW	(1 << 0)
    -=20
    - int verify_commit_graph(struct repository *r, struct commit_graph *g,=
 int flags);
    + /*
    +  * It is possible that we loaded commit contents from the commit buff=
er,
    +  * but we also want to ensure the commit-graph content is correctly
    =20
      ## revision.c ##
     @@ revision.c: static struct object *get_reference(struct rev_info *re=
vs, const char *name,
    @@ revision.c: static struct object *get_reference(struct rev_info *rev=
s, const cha
      	if (object->type =3D=3D OBJ_NONE) {
     -		int type =3D oid_object_info(revs->repo, oid, NULL);
     -		if (type < 0 || !object_as_type(object, type, 1)) {
    --			object =3D NULL;
    --			goto out;
    -+		if (find_object_in_graph(revs->repo, object) < 0) {
    ++		/*
    ++		 * It's likely that the reference points to a commit, so we
    ++		 * first try to look it up via the commit-graph. If successful,
    ++		 * then we know it's a commit and don't have to unpack the
    ++		 * object header. We still need to assert that the object
    ++		 * exists, but given that we don't request any info about the
    ++		 * object this is a lot faster than `oid_object_info()`.
    ++		 */
    ++		if (parse_commit_in_graph_gently(revs->repo, object) < 0) {
     +			int type =3D oid_object_info(revs->repo, oid, NULL);
     +			if (type < 0 || !object_as_type(object, type, 1)) {
     +				object =3D NULL;
     +				goto out;
     +			}
    ++		} else if (!repo_has_object_file(revs->repo, oid)) {
    + 			object =3D NULL;
    + 			goto out;
      		}
    - 	}
    -=20
--=20
2.32.0


--ORyOJyGFPjfiSM9a
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmELyp4ACgkQVbJhu7ck
PpTEJQ//cSblV3vv4++3LcD9oMBCvrxXF0xVKuJ9yZNCf+D8BgWBjditBYtaHC6n
MLr90XkLJl5aw+UsY1iKdH5U7qTMIqkuEg3NuUnrSFgPtEEqagHphfaUPwNs22L4
nvpjH6+0OzirZLJ3NnflJO6NW6Q95KDn1XDk/93dTZvUYRwLtHRDrR5w3lJjESDf
B/uC2NYMFCNMJ0c+9sNCX6eMHWiIhfGAI1+lFoHyVZYJwX6h1the02I+3GXp2Lan
Pqfp0hGnb3UIqTJwIFeI+AXSJ2rcRcuoMNK8ojJQOLBxlktWSE1PSmOkEjEYzW7b
u4ERh/uFohPF/SqPjIW3K0rMs+TU1OZ9Ero+b6+WTHQAqr54jneBuNvub2hHY/vc
fCDPK41skg4hFIU+59eL7m4KGP6e9s3TUa5P5utWE0w7Un1lc5BiR4BRZLiRvDMH
rmfvMai8SZqnKZen2T8K1cBvH3luEP0U+kcV3scHIyAis1XJZ8WRIkS6nSdY/rvO
tzTOyLDTdt5iHSqwJcCXUb1VNH4Pczw0GFdfnNPaCeAEZLgb8PW3LbbTRO27Aygj
GxIwH1byr9PtM6vN2ChwFaq/QMdqrZMMtackKLAuAzhVDFrAZWy5RpCMWLabS1N9
MTe6KfqZEtrd37Xcdfl4+wtO1F8Zr8mrQ38zTCPZQZCHluVv/b8=
=L3G2
-----END PGP SIGNATURE-----

--ORyOJyGFPjfiSM9a--
