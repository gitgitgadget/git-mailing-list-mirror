Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8329C4338F
	for <git@archiver.kernel.org>; Mon,  9 Aug 2021 08:11:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A7D4761004
	for <git@archiver.kernel.org>; Mon,  9 Aug 2021 08:11:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233823AbhHIIMJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 9 Aug 2021 04:12:09 -0400
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:43375 "EHLO
        out3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233588AbhHIIMI (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 9 Aug 2021 04:12:08 -0400
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id 0460B5C009A;
        Mon,  9 Aug 2021 04:11:48 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Mon, 09 Aug 2021 04:11:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=date
        :from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm1; bh=j6SPvvLLzecab6X8hqlr0vhFL3T
        tReXx7Vrek6jVM3w=; b=n9nqXHLSxrxei5iNxb6EroFGpem63sUZ13se4wGElSa
        7G80H+qPMosaEsq3xWfWcutWdnweuTSdGA4ed40ny+gU9nbYuk2hK+YrWLURWgU/
        k4TYC76HQ/lqfh7uZI6ITy8hYgDjWFezUone+FrSkXIjITwSItDfrYTx7MOh+Q+K
        pfunQDJt7tt8g/0meEemNYG21O2JuqB9+jWnkR88LHmZByT6u88/aidAsWdL+do6
        bBl+0P6aLgOXpiaDVHWUqP5/h2vv/sCY/a7qmng6WBxtyF6eW7ET6vjlkvBiKEoR
        jJgWMrfshQpQwBKnnjNcMoT94e6/H/MPyn+QVxuVVtg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=j6SPvv
        LLzecab6X8hqlr0vhFL3TtReXx7Vrek6jVM3w=; b=FjcfxbYFKJspu3KtuSBO7P
        GZrOcni9hMZdB3aZNJoa24BI2Cm8Gcl6M7Y1MHXPYt3q2BQci1Afoqj6eRd0uBV0
        PRvqkNnSC0vSa5Uxt2RLcFMYqM4OW/CFNVQM6UxRfGSVwYSsZBnITEs38SmXJBOP
        xu0j5j88xeJl1Z1SwM1xhAZkXgHfDuUYNCvFvq/L50gutmgJReiLH7LfZRBGh24k
        xA5zoqB8VRuY71YSBbhn29sX81XxZb8JYPC7gbkdpzBo7zcjOL4mShjL0AFu43/v
        ivDJmQnP5fKG3aSkiLz9pnrEQez44qdW/ric0WrXtfNzxOBhDN275eFmK5cINfjw
        ==
X-ME-Sender: <xms:Q-MQYbxDMRqSj0bMevWvluOIWig7JRrvTFIXOiPlOryZ0q8_OFbKcw>
    <xme:Q-MQYTTbGiv3Z8dttNkRFdf0ct9gmhy97GGr04ItpXTMEHV-hcU6uvACkLrVSynz3
    iOnniu6ssEEa_kkhw>
X-ME-Received: <xmr:Q-MQYVVlsJ62eeC9a8h2_8Kt9o_y8JgrW4Pmr0ELm_Fs2OzKJzo7gWvRMaZDj_-cyKq0XZJ8_45HydBoZWIas4VyEibddnpjW_i_DsGutEDEWCJNaygMow>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvtddrjeejucetufdoteggodetrfdotffvucfrrh
    hofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgenuceurghi
    lhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurh
    epfffhvffukfhfgggtuggjsehgtderredttdejnecuhfhrohhmpefrrghtrhhitghkucfu
    thgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpeehgf
    ejueevjeetudehgffffeffvdejfeejiedvkeffgfekuefgheevteeufeelkeenucevlhhu
    shhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrih
    hm
X-ME-Proxy: <xmx:Q-MQYVjvZHHuzSffOKy8tYYgMCfpFA0C3kINyTHYP9nvP5fMLmBDnQ>
    <xmx:Q-MQYdC8Zig-14vsXXZ9hUHMmamTp0klB-kXdqgT6X23FbZpTaRtDg>
    <xmx:Q-MQYeLgB3JVMZf0Qlc5P3Jan9y8jk5Mgq3Kz-2xV3D4kAfS7khBVQ>
    <xmx:Q-MQYf0Pp-XqlEk5Ac2yLxxkxhMnmPJevi2fGmsUWJgyjZyC1D_YGg>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 9 Aug 2021 04:11:46 -0400 (EDT)
Received: from localhost (ncase [10.192.0.11])
        by vm-mail.pks.im (OpenSMTPD) with ESMTPSA id 1319935e (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Mon, 9 Aug 2021 08:11:43 +0000 (UTC)
Date:   Mon, 9 Aug 2021 10:11:42 +0200
From:   Patrick Steinhardt <ps@pks.im>
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        SZEDER =?iso-8859-1?Q?G=E1bor?= <szeder.dev@gmail.com>,
        Chris Torek <chris.torek@gmail.com>,
        =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Taylor Blau <me@ttaylorr.com>
Subject: [PATCH v5 0/5] Speed up connectivity checks
Message-ID: <cover.1628496538.git.ps@pks.im>
References: <cover.1624858240.git.ps@pks.im>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="S5HKVyNyBCsuBv20"
Content-Disposition: inline
In-Reply-To: <cover.1624858240.git.ps@pks.im>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--S5HKVyNyBCsuBv20
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

this is the fifth version of my series to speed up connectivity checks
in the context of repos with many refs. While the original goal has been
to speed up connectivity checks only, the series is now optimizing
git-rev-list(1) in general to be able to more efficiently load
references. Like this, `--not --all` is a lot faster in the context of
many refs, but other usecases benefit, too.

Changes compared to v4:

    - I've changed the interface to load commits via the commit-graph.
      Instead of the previous version where you'd had to pass in a
      `struct object`, which forced us to use `lookup_unknown_object()`,
      one now only passes in an object ID. If the object ID is found in
      the commit graph and if the corresponding object exists in the
      ODB, then we return the parsed commit object.

      This also avoids a previous pitfal: we'd have parsed the commit
      via the graph and thus had allocated the object even if the
      corresponding object didn't exist. While we knew to handle this in
      `get_reference()` by asserting object existence, any other caller
      which executes `lookup_commit()` would get the parsed commit and
      assume that it exists. This now cannot happen anymore given that
      we only create the commit object in case we know the ID exists in
      the ODB.

    - With this change, I could now drop the patch which avoided loading
      objects multiple times: we don't need `lookup_unknown_object()`
      anymore and thus don't thave the memory/perf tradeoff. And with
      the new interface to load commits via the graph, the deduplication
      only resulted in a ~1% speedup.

    - `--unsorted-input` and `--no-walk` are now mutually exclusive
      regardless of whether `--no-walk` is sorted or unsorted,
      simplifying the logic.

Patrick

Patrick Steinhardt (5):
  revision: separate walk and unsorted flags
  connected: do not sort input revisions
  revision: stop retrieving reference twice
  commit-graph: split out function to search commit position
  revision: avoid hitting packfiles when commits are in commit-graph

 Documentation/rev-list-options.txt |  8 ++-
 builtin/log.c                      |  2 +-
 builtin/revert.c                   |  3 +-
 commit-graph.c                     | 79 ++++++++++++++++++++----------
 commit-graph.h                     |  8 +++
 connected.c                        |  1 +
 revision.c                         | 38 ++++++++------
 revision.h                         |  7 +--
 t/t6000-rev-list-misc.sh           | 31 ++++++++++++
 9 files changed, 129 insertions(+), 48 deletions(-)

Range-diff against v4:
1:  67232910ac =3D 1:  67232910ac revision: separate walk and unsorted flags
2:  9d7f484907 ! 2:  d3f498a563 connected: do not sort input revisions
    @@ revision.c: static int handle_revision_opt(struct rev_info *revs, in=
t argc, cons
      		revs->sort_order =3D REV_SORT_BY_AUTHOR_DATE;
      		revs->topo_order =3D 1;
     +	} else if (!strcmp(arg, "--unsorted-input")) {
    -+		if (revs->no_walk && !revs->unsorted_input)
    -+			die(_("--unsorted-input is incompatible with --no-walk and --no-wa=
lk=3Dsorted"));
    ++		if (revs->no_walk)
    ++			die(_("--unsorted-input is incompatible with --no-walk"));
     +		revs->unsorted_input =3D 1;
      	} else if (!strcmp(arg, "--early-output")) {
      		revs->early_output =3D 100;
    @@ revision.c: static int handle_revision_pseudo_opt(const char *submod=
ule,
      	} else if (!strcmp(arg, "--not")) {
      		*flags ^=3D UNINTERESTING | BOTTOM;
      	} else if (!strcmp(arg, "--no-walk")) {
    -+		if (revs->unsorted_input)
    -+			die(_("--no-walk is incompatible with --no-walk=3Dunsorted and --u=
nsorted-input"));
    ++		if (!revs->no_walk && revs->unsorted_input)
    ++			die(_("--no-walk is incompatible with --unsorted-input"));
      		revs->no_walk =3D 1;
      	} else if (skip_prefix(arg, "--no-walk=3D", &optarg)) {
    ++		if (!revs->no_walk && revs->unsorted_input)
    ++			die(_("--no-walk is incompatible with --unsorted-input"));
    ++
      		/*
    -@@ revision.c: static int handle_revision_pseudo_opt(const char *submo=
dule,
    + 		 * Detached form ("--no-walk X" as opposed to "--no-walk=3DX")
      		 * not allowed, since the argument is optional.
    - 		 */
    - 		revs->no_walk =3D 1;
    --		if (!strcmp(optarg, "sorted"))
    -+		if (!strcmp(optarg, "sorted")) {
    -+			if (revs->unsorted_input)
    -+				die(_("--no-walk=3Dsorted is incompatible with --no-walk=3Dunsort=
ed "
    -+				    "and --unsorted-input"));
    - 			revs->unsorted_input =3D 0;
    --		else if (!strcmp(optarg, "unsorted"))
    -+		} else if (!strcmp(optarg, "unsorted"))
    - 			revs->unsorted_input =3D 1;
    - 		else
    - 			return error("invalid argument to --no-walk");
    =20
      ## t/t6000-rev-list-misc.sh ##
     @@ t/t6000-rev-list-misc.sh: test_expect_success 'rev-list --count --o=
bjects' '
    @@ t/t6000-rev-list-misc.sh: test_expect_success 'rev-list --count --ob=
jects' '
     +	test_cmp first.sorted second.sorted
     +'
     +
    -+test_expect_success 'rev-list --unsorted-input compatible with --no-w=
alk=3Dunsorted' '
    -+	git rev-list --unsorted-input --no-walk=3Dunsorted HEAD HEAD~ >actua=
l &&
    -+	git rev-parse HEAD >expect &&
    -+	git rev-parse HEAD~ >>expect &&
    -+	test_cmp expect actual
    -+'
    -+
    -+test_expect_success 'rev-list --unsorted-input incompatible with --no=
-walk=3Dsorted' '
    ++test_expect_success 'rev-list --unsorted-input incompatible with --no=
-walk' '
     +	cat >expect <<-EOF &&
    -+		fatal: --no-walk is incompatible with --no-walk=3Dunsorted and --un=
sorted-input
    ++		fatal: --no-walk is incompatible with --unsorted-input
     +	EOF
     +	test_must_fail git rev-list --unsorted-input --no-walk HEAD 2>error =
&&
     +	test_cmp expect error &&
    -+
    -+	cat >expect <<-EOF &&
    -+		fatal: --no-walk=3Dsorted is incompatible with --no-walk=3Dunsorted=
 and --unsorted-input
    -+	EOF
     +	test_must_fail git rev-list --unsorted-input --no-walk=3Dsorted HEAD=
 2>error &&
     +	test_cmp expect error &&
    ++	test_must_fail git rev-list --unsorted-input --no-walk=3Dunsorted HE=
AD 2>error &&
    ++	test_cmp expect error &&
     +
     +	cat >expect <<-EOF &&
    -+		fatal: --unsorted-input is incompatible with --no-walk and --no-wal=
k=3Dsorted
    ++		fatal: --unsorted-input is incompatible with --no-walk
     +	EOF
     +	test_must_fail git rev-list --no-walk --unsorted-input HEAD 2>error =
&&
     +	test_cmp expect error &&
     +	test_must_fail git rev-list --no-walk=3Dsorted --unsorted-input HEAD=
 2>error &&
    ++	test_cmp expect error &&
    ++	test_must_fail git rev-list --no-walk=3Dunsorted --unsorted-input HE=
AD 2>error &&
     +	test_cmp expect error
     +'
     +
3:  d8e63d0943 =3D 3:  c9a630927b revision: stop retrieving reference twice
4:  ba8df5cad0 < -:  ---------- revision: avoid loading object headers mult=
iple times
5:  e33cd51ebf =3D 4:  bc89325fdf commit-graph: split out function to searc=
h commit position
6:  900c5a9c60 ! 5:  fdb1fa9d57 revision: avoid hitting packfiles when comm=
its are in commit-graph
    @@ Metadata
      ## Commit message ##
         revision: avoid hitting packfiles when commits are in commit-graph
    =20
    -    When queueing references in git-rev-list(1), we try to either reus=
e an
    -    already parsed object or alternatively we load the object header f=
rom
    -    disk in order to determine its type. This is inefficient for commi=
ts
    -    though in cases where we have a commit graph available: instead of
    -    hitting the real object on disk to determine its type, we may inst=
ead
    -    search the object graph for the object ID. In case it's found, we =
can
    -    directly fill in the commit object, otherwise we can still hit the=
 disk
    -    to determine the object's type.
    +    When queueing references in git-rev-list(1), we try to optimize pa=
rsing
    +    of commits via the commit-graph. To do so, we first look up the ob=
ject's
    +    type, and if it is a commit we call `repo_parse_commit()` instead =
of
    +    `parse_object()`. This is quite inefficient though given that we're
    +    always uncompressing the object header in order to determine the t=
ype.
    +    Instead, we can opportunistically search the commit-graph for the =
object
    +    ID: in case it's found, we know it's a commit and can directly fil=
l in
    +    the commit object without having to uncompress the object header.
    =20
    -    Expose a new function `parse_commit_in_graph_gently()`, which fill=
s in
    -    an object of unknown type in case we find its object ID in the gra=
ph.
    -    This provides a big performance win in cases where there is a
    -    commit-graph available in the repository in case we load lots of
    -    references. The following has been executed in a real-world reposi=
tory
    -    with about 2.2 million refs:
    +    Expose a new function `lookup_commit_in_graph()`, which tries to f=
ind a
    +    commit in the commit-graph by ID, and convert `get_reference()` to=
 use
    +    this function. This provides a big performance win in cases where =
we
    +    load references in a repository with lots of references pointing to
    +    commits. The following has been executed in a real-world repositor=
y with
    +    about 2.2 million refs:
    =20
             Benchmark #1: HEAD~: rev-list --unsorted-input --objects --qui=
et --not --all --not $newrev
    -          Time (mean =C2=B1 =CF=83):      4.508 s =C2=B1  0.039 s    [=
User: 4.131 s, System: 0.377 s]
    -          Range (min =E2=80=A6 max):    4.455 s =E2=80=A6  4.576 s    =
10 runs
    +          Time (mean =C2=B1 =CF=83):      4.458 s =C2=B1  0.044 s    [=
User: 4.115 s, System: 0.342 s]
    +          Range (min =E2=80=A6 max):    4.409 s =E2=80=A6  4.534 s    =
10 runs
    =20
             Benchmark #2: HEAD: rev-list --unsorted-input --objects --quie=
t --not --all --not $newrev
    -          Time (mean =C2=B1 =CF=83):      3.072 s =C2=B1  0.031 s    [=
User: 2.707 s, System: 0.365 s]
    -          Range (min =E2=80=A6 max):    3.040 s =E2=80=A6  3.144 s    =
10 runs
    +          Time (mean =C2=B1 =CF=83):      3.089 s =C2=B1  0.015 s    [=
User: 2.768 s, System: 0.321 s]
    +          Range (min =E2=80=A6 max):    3.061 s =E2=80=A6  3.105 s    =
10 runs
    =20
             Summary
               'HEAD: rev-list --unsorted-input --objects --quiet --not --a=
ll --not $newrev' ran
    -            1.47 =C2=B1 0.02 times faster than 'HEAD~: rev-list --unso=
rted-input --objects --quiet --not --all --not $newrev'
    +            1.44 =C2=B1 0.02 times faster than 'HEAD~: rev-list --unso=
rted-input --objects --quiet --not --all --not $newrev'
    =20
         Signed-off-by: Patrick Steinhardt <ps@pks.im>
    =20
    @@ commit-graph.c: static int find_commit_pos_in_graph(struct commit *i=
tem, struct
      	}
      }
     =20
    -+int parse_commit_in_graph_gently(struct repository *repo, struct obje=
ct *object)
    ++struct commit *lookup_commit_in_graph(struct repository *repo, const =
struct object_id *id)
     +{
     +	struct commit *commit;
     +	uint32_t pos;
     +
    -+	if (object->parsed) {
    -+		if (object->type !=3D OBJ_COMMIT)
    -+			return -1;
    -+		return 0;
    -+	}
    -+
     +	if (!repo->objects->commit_graph)
    -+		return -1;
    ++		return NULL;
    ++	if (!search_commit_pos_in_graph(id, repo->objects->commit_graph, &po=
s))
    ++		return NULL;
    ++	if (!repo_has_object_file(repo, id))
    ++		return NULL;
     +
    -+	if (!search_commit_pos_in_graph(&object->oid, repo->objects->commit_=
graph, &pos))
    -+		return -1;
    -+
    -+	commit =3D object_as_type(object, OBJ_COMMIT, 1);
    ++	commit =3D lookup_commit(repo, id);
     +	if (!commit)
    -+		return -1;
    -+	if (!fill_commit_in_graph(repo, commit, repo->objects->commit_graph,=
 pos))
    -+		return -1;
    ++		return NULL;
    ++	if (commit->object.parsed)
    ++		return commit;
     +
    -+	return 0;
    ++	if (!fill_commit_in_graph(repo, commit, repo->objects->commit_graph,=
 pos))
    ++		return NULL;
    ++
    ++	return commit;
     +}
     +
      static int parse_commit_in_graph_one(struct repository *r,
    @@ commit-graph.h: int open_commit_graph(const char *graph_file, int *f=
d, struct st
      int parse_commit_in_graph(struct repository *r, struct commit *item);
     =20
     +/*
    -+ * Given an object of unknown type, try to fill in the object in case=
 it is a
    -+ * commit part of the commit-graph. Returns 0 if the object is a pars=
ed commit
    -+ * or if it could be filled in via the commit graph, otherwise it ret=
urns -1.
    ++ * Look up the given commit ID in the commit-graph. This will only re=
turn a
    ++ * commit if the ID exists both in the graph and in the object databa=
se such
    ++ * that we don't return commits whose object has been pruned. Otherwi=
se, this
    ++ * function returns `NULL`.
     + */
    -+int parse_commit_in_graph_gently(struct repository *repo, struct obje=
ct *object);
    ++struct commit *lookup_commit_in_graph(struct repository *repo, const =
struct object_id *id);
     +
      /*
       * It is possible that we loaded commit contents from the commit buff=
er,
    @@ commit-graph.h: int open_commit_graph(const char *graph_file, int *f=
d, struct st
    =20
      ## revision.c ##
     @@ revision.c: static struct object *get_reference(struct rev_info *re=
vs, const char *name,
    - 	struct object *object =3D lookup_unknown_object(revs->repo, oid);
    + 				    unsigned int flags)
    + {
    + 	struct object *object;
    ++	struct commit *commit;
     =20
    - 	if (object->type =3D=3D OBJ_NONE) {
    --		int type =3D oid_object_info(revs->repo, oid, NULL);
    --		if (type < 0 || !object_as_type(object, type, 1)) {
    -+		/*
    -+		 * It's likely that the reference points to a commit, so we
    -+		 * first try to look it up via the commit-graph. If successful,
    -+		 * then we know it's a commit and don't have to unpack the
    -+		 * object header. We still need to assert that the object
    -+		 * exists, but given that we don't request any info about the
    -+		 * object this is a lot faster than `oid_object_info()`.
    -+		 */
    -+		if (parse_commit_in_graph_gently(revs->repo, object) < 0) {
    -+			int type =3D oid_object_info(revs->repo, oid, NULL);
    -+			if (type < 0 || !object_as_type(object, type, 1)) {
    -+				object =3D NULL;
    -+				goto out;
    -+			}
    -+		} else if (!repo_has_object_file(revs->repo, oid)) {
    - 			object =3D NULL;
    - 			goto out;
    - 		}
    + 	/*
    +-	 * If the repository has commit graphs, repo_parse_commit() avoids
    +-	 * reading the object buffer, so use it whenever possible.
    ++	 * If the repository has commit graphs, we try to opportunistically
    ++	 * look up the object ID in those graphs. Like this, we can avoid
    ++	 * parsing commit data from disk.
    + 	 */
    +-	if (oid_object_info(revs->repo, oid, NULL) =3D=3D OBJ_COMMIT) {
    +-		struct commit *c =3D lookup_commit(revs->repo, oid);
    +-		if (!repo_parse_commit(revs->repo, c))
    +-			object =3D (struct object *) c;
    +-		else
    +-			object =3D NULL;
    +-	} else {
    ++	commit =3D lookup_commit_in_graph(revs->repo, oid);
    ++	if (commit)
    ++		object =3D &commit->object;
    ++	else
    + 		object =3D parse_object(revs->repo, oid);
    +-	}
    +=20
    + 	if (!object) {
    + 		if (revs->ignore_missing)
--=20
2.32.0


--S5HKVyNyBCsuBv20
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmEQ4z0ACgkQVbJhu7ck
PpQlAA//WD9+n0r9zcbow6tob/OwY+j7OTO6778UDesSQSkAbgG2vu8qvLKgkuL5
UWWnoEN9Ix8XBWgY82tIjPVIzHo6Kw8TdHxjGIkSSO2QgzxLMmpuPsXEZq9MEF1Z
MCMrIBktmrbw2Dhq0rR8MJSR8HIasu+PeyNGP7m8fDoaj+lAbLuqCZH9CYWRFbnf
BHXOgA56/MkQ6zEhxAyvs2NIWqgqqMgRH4Rsf+i6DGQWrLQSYq/NxalmY0Oq49KA
LRPJ3iQCeT5sA2f65fKah4I7WjYnrf3DFiUNphG/DAgDHhDKGClrlFi8rXAlic30
rW7OwFH4nscojZijS0PQi0RrVpzrBaGnpMNjwo6LS5micZVbpNK1SQsGJAjtRVSu
wB0KpZsh6lFV4qoW2NnH9lywkvLLulbfsh3Zdabyt74EYjLEwDZRQmAcmfbzxmyq
K6meWuieDz+s3xhwfw+E5kBQCnK/lMMZXHypYGVp2fpe8j/kIz6HRo0qMBBSG3HM
ICCriFJafC7YVe4Cu4DmSJqtO73lWa3V7HVE3iCazpIFCTh94gPR/dQ6QXvVzD8d
wBp54N4zxfQzVmQVujSEspDC0G7hSYmj2NRlVgxYb8nbWT3myE2FdOpndiDe0gjz
QwmDO+i2WhT/RkJzBQYWTXwpgy1G8/TnEql3H4ch0r6MIRO08iU=
=0Vf2
-----END PGP SIGNATURE-----

--S5HKVyNyBCsuBv20--
