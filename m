Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB8BEC4338F
	for <git@archiver.kernel.org>; Mon,  9 Aug 2021 08:00:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BBF4960720
	for <git@archiver.kernel.org>; Mon,  9 Aug 2021 08:00:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233737AbhHIIBH (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 9 Aug 2021 04:01:07 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:41637 "EHLO
        out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233626AbhHIIBH (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 9 Aug 2021 04:01:07 -0400
Received: from compute2.internal (compute2.nyi.internal [10.202.2.42])
        by mailout.nyi.internal (Postfix) with ESMTP id 737405C0004;
        Mon,  9 Aug 2021 04:00:46 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Mon, 09 Aug 2021 04:00:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=date
        :from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm1; bh=88OK/I1ounZyDhVSiypKjP5aj5B
        AqdrM46MUCmCITdM=; b=IhOSLG2IkxMXpHuqyFo4PAVU4J2pw5ZahmloBdDju4Z
        qz9ECJbfbLq2uigYQPq8NmC4N/t9A/1r099tiino7xz5Q4zk229LO0kp77yuqUeQ
        4bBRNCnfT6fTpHQoF0uRLt7sTYAoVDnFuuaJZFcSYLDnkuVA0aOYmZmEDuJPAYLC
        1jVt92pNySmuuPcIZQIPS0Tva2rjVN0n2Tc08UuMulGJr7RTFYy4+E31+2TanfXF
        lmT+JXEMwF6V95yfK0+nyc5SEwfKZ8jrXclK/PD/kEny8x+KyTLoEGyY+LT6xPER
        5J0dEsnhPeUanW86mUt/pNbH4aRIIuuyjt9OKpkuO6g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=88OK/I
        1ounZyDhVSiypKjP5aj5BAqdrM46MUCmCITdM=; b=KFX2Yg6MIW85f1B1ih7oj0
        lJzxDYbkXBydWwaJV1wZA8Nn/UTLh6t6vlLF38F7bZ5Ez+UYLrLgyio8O6VnWtP3
        U4SuXl4iPRzOmrBRp/NBG3vzFXe6QCdZLe3r4OZRTMWvYL3Gia9vIrSidzKJ4buH
        y/KJk5Q0zhYt3KDIa2YL+IPrY+av0GtyCsIpJ8Y5SPNj5HmwdhltqhQFtknRUR3q
        YBsZr3L23Ef5JXSDVJ40cAVNaMQTU8CWlwAvpYA7hykWu3xdVreV8BnRdi5wHtge
        RSGjoO5XN0/SvHhXwzgWEdhn5bNyb1GWaLD3zQgzPQLvsad0bgcOh7XTM7SBu5ow
        ==
X-ME-Sender: <xms:ruAQYUye2xHm_ere2g0lxD-LjF8txQwjsRpCsRzpWH40R0LgaYv54Q>
    <xme:ruAQYYTKwAi3lcquWkscso1-pV87KsUIjI7om5F2gaJOwYqe9nVcwDdJNQZNXvJdb
    D29WxZghajO4YSYJQ>
X-ME-Received: <xmr:ruAQYWUqGRGq1HrLKSkoW3TYdKe5NbiF3PYTRpBrQ039EeE6U0EpC4uAySIlH3k-2U-Z_6CGsDvipKj_ktvzJmXe3d4fXDIuf3nnSNisIeGl_gdiodunCA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvtddrjeeigdduvdduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhfgggtuggjsehgtderredttdejnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeehgfejueevjeetudehgffffeffvdejfeejiedvkeffgfekuefgheevteeufeelkeen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhm
X-ME-Proxy: <xmx:ruAQYSg3zdNhRkSrjehcPvIiYNe9o-gYsslcChhHdsC7ABWXHa57yQ>
    <xmx:ruAQYWAwElPLomRFKF2_yYnnTvE9z53fXakl6ZVfquTl6-Agc6GISA>
    <xmx:ruAQYTJ1mw9eBkQB7SUnKAZ_RrqlCpzdKMJAhffJzTTUHfygE8grrw>
    <xmx:ruAQYY0u3SWAKynuHTjw4evlYsreKfFB2ieZZ-xLtGAW4OKhE6dQVg>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 9 Aug 2021 04:00:44 -0400 (EDT)
Received: from localhost (ncase [10.192.0.11])
        by vm-mail.pks.im (OpenSMTPD) with ESMTPSA id 2010a9e9 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Mon, 9 Aug 2021 08:00:40 +0000 (UTC)
Date:   Mon, 9 Aug 2021 10:00:39 +0200
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
Message-ID: <cover.1628495467.git.ps@pks.im>
References: <cover.1624858240.git.ps@pks.im>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="ok7PjBneY4D8Ntni"
Content-Disposition: inline
In-Reply-To: <cover.1624858240.git.ps@pks.im>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--ok7PjBneY4D8Ntni
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
 revision.c                         | 42 +++++++++-------
 revision.h                         |  7 +--
 t/t6000-rev-list-misc.sh           | 38 ++++++++++++++
 9 files changed, 138 insertions(+), 50 deletions(-)

Range-diff against v4:
1:  67232910ac =3D 1:  67232910ac revision: separate walk and unsorted flags
2:  9d7f484907 =3D 2:  9d7f484907 connected: do not sort input revisions
3:  d8e63d0943 =3D 3:  d8e63d0943 revision: stop retrieving reference twice
4:  ba8df5cad0 < -:  ---------- revision: avoid loading object headers mult=
iple times
5:  e33cd51ebf =3D 4:  549d85e5c2 commit-graph: split out function to searc=
h commit position
6:  900c5a9c60 ! 5:  4b893d943f revision: avoid hitting packfiles when comm=
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


--ok7PjBneY4D8Ntni
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmEQ4KcACgkQVbJhu7ck
PpTrsBAAorHvvdefmfrZ0vwFU07pP8mpN+QsB0HzsE9/1XPiCBeW/gXWRd8d43/3
xZYQPchWAysZoUoCFxTN8HJlJT5CosP6YRLS9TlEgDS7ecu5lARomd+wJ7VChLs8
5mohZF0ivJmlIUuxtpGC5qNcZl5ip0wBfMvbfOchAUMla61Cd2CK3u1WTbbW6itL
oxRthOhK4NopaRs/N4tOVN4qYoitj460bVny4yV5WEHsuoVv93UMqeCuA7JTIzKZ
z6UwTMHSzWB37cS8jaCd0VR1R9tfcmKtOtCkot1JZ3SDRoi86CwC+baK0sf7otS9
4huI0dv1pVBXv1lkjTuwbxHDv3EcL2sISUA3dqAwLoOgPK9B93qZCREQRN5aAnju
6DgtdSyeOQPq5XEyfG2ERZSoBCXlXont1vjvMuPToqN7iL3QpNdZTw9LEdzUoFNK
rzwZ7ujxUsZpMWR4FY0nXfUujIeMXiblK7AzvPqizrnOB8AEWHd4H7xt/3aoFiVN
nWpPkJtnzs0318tHj+ykI+QTAfwEtABzvmv+BB9RFo1TwGl36ujSBbHxVLApxPLt
mbsUZdwuhyYe1FlTgGSDXXPXObUMYmVa9mnpcQwv+x1LR0622DIKpCRpszGtxiOP
vDEM4PZY26o7RlQ0I8Z5FvX783paqxRsQFoQYYooJMKrj8JKJTc=
=sFzA
-----END PGP SIGNATURE-----

--ok7PjBneY4D8Ntni--
