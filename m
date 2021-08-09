Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A3B1C4338F
	for <git@archiver.kernel.org>; Mon,  9 Aug 2021 08:12:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3E0D261078
	for <git@archiver.kernel.org>; Mon,  9 Aug 2021 08:12:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233839AbhHIIM1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 9 Aug 2021 04:12:27 -0400
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:48943 "EHLO
        out3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233846AbhHIIM0 (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 9 Aug 2021 04:12:26 -0400
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id 73AF35C009A;
        Mon,  9 Aug 2021 04:12:06 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Mon, 09 Aug 2021 04:12:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=date
        :from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm1; bh=rMSRUGXpcyNqDjwvCPFhdvl0Zfu
        +IJwHroQ3lUFk36U=; b=AM2iIia/cz6NpJYRQSNCtaAyql1z63Hb+DxCZhUaOaq
        znHZ2VI7w3i26Jr6tnzWJmXWIUihXQRf5FJ1iVnkZ+6xUV72URLWcwvOUUhVgcFh
        3XMv+IuivF+LYhRZMuwQiUyaIZjZBnaJ6Z5WT1t+nqvgzjk1h/wO6dtEofGOgu6S
        wMgJhbszOBtZskMfMlb5GTwtLhOUa3Vhj8LamFinRPAoiDDmoW1m4u0dHsZzLBdR
        aSgdilQYEwZKspbHzx1Fd447J8g4EyEX9s9F2xz8eEDUOKgC8amq08He2NFhUS2R
        d/x7XkKl81Q7SsJIto2uc8qRt52qk/co4vazAiKP0rQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=rMSRUG
        XpcyNqDjwvCPFhdvl0Zfu+IJwHroQ3lUFk36U=; b=p+WP22Qdlvys9XsjnjYgYO
        75jKpTN0lfGJ+8QMhhqebTCTJBDAlBVIfPf6uALDZ/s9t+xqAMU9G4Cuvqto+opU
        9qmPvp2z9glvb8cVNbuE5z/Eg9MJvKxKOR46DlghhZFYclPMe3+s384RTCyKugDB
        XHMRmE8jZ3LgsW7onDJ6CW5vMxy4PTwejuNLQdkYQ71sM5D+gAZOQcqVasPxmplN
        ZbmuE50d0PC6Xw3+eNYbLuNBxB4VX7Q8Y1Ts1x97Y6uVR0awGDm785h04K/8wlqt
        7ThY+9gDYVGOm3RPlHRRddC9NwlpiPXPvdfAXvcO7fIg+JVZzX+IAJ5jqQsZ6+rg
        ==
X-ME-Sender: <xms:VuMQYeSdb21n5ecP8NY0EKwWo0KwCtMg1sbJdDua_0VN2PzFwm_mxg>
    <xme:VuMQYTwuh25CUi5mKP5GyqDTxfOZcr1n0q3eaYVl1fwhCfM7EhCKcbT8BHUgpC0CY
    d_LHoDq_laR67AYiQ>
X-ME-Received: <xmr:VuMQYb3vyCESA7zsdZrovt9TTcLLvDazT_-CBTH63gx7LEC2FWP3uzi0W5bFVhrkgWq-Yno0O4nsX55nTmXgkuHm4eEr7UXeFfBG5ZPkOnwtuVWhe3j86g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvtddrjeejgddtudcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvuffkfhggtggujgesghdtreertddtjeenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    ephefgjeeuveejteduhefgffefffdvjeefjeeivdekfffgkeeugfehveetueefleeknecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimh
X-ME-Proxy: <xmx:VuMQYaBNERd4dDRzZ8o-0QWVZewDQgGPvODLq7uU-K1BYQ30IVI18Q>
    <xmx:VuMQYXiR3-l5FTRdZhmhPEhrXifXWdJ_jLx7peU8pAQsCojrAVdgGg>
    <xmx:VuMQYWpcaRxr8v3aQ_Iy7EqvWzBs7vH8KB6kyPeoKy3ryNcuaUCoIA>
    <xmx:VuMQYSVEUF_ZswqU7iPQXVfR8LetFTV4vMK3UlfQX-dDnXKmhA8O7A>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 9 Aug 2021 04:12:05 -0400 (EDT)
Received: from localhost (ncase [10.192.0.11])
        by vm-mail.pks.im (OpenSMTPD) with ESMTPSA id f6bf1737 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Mon, 9 Aug 2021 08:12:04 +0000 (UTC)
Date:   Mon, 9 Aug 2021 10:12:03 +0200
From:   Patrick Steinhardt <ps@pks.im>
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        SZEDER =?iso-8859-1?Q?G=E1bor?= <szeder.dev@gmail.com>,
        Chris Torek <chris.torek@gmail.com>,
        =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Taylor Blau <me@ttaylorr.com>
Subject: [PATCH v5 5/5] revision: avoid hitting packfiles when commits are in
 commit-graph
Message-ID: <fdb1fa9d574a27500df7f16a165997a41a8cc8e8.1628496539.git.ps@pks.im>
References: <cover.1624858240.git.ps@pks.im>
 <cover.1628496538.git.ps@pks.im>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="6M04gA7dF3O5gN+l"
Content-Disposition: inline
In-Reply-To: <cover.1628496538.git.ps@pks.im>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--6M04gA7dF3O5gN+l
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

When queueing references in git-rev-list(1), we try to optimize parsing
of commits via the commit-graph. To do so, we first look up the object's
type, and if it is a commit we call `repo_parse_commit()` instead of
`parse_object()`. This is quite inefficient though given that we're
always uncompressing the object header in order to determine the type.
Instead, we can opportunistically search the commit-graph for the object
ID: in case it's found, we know it's a commit and can directly fill in
the commit object without having to uncompress the object header.

Expose a new function `lookup_commit_in_graph()`, which tries to find a
commit in the commit-graph by ID, and convert `get_reference()` to use
this function. This provides a big performance win in cases where we
load references in a repository with lots of references pointing to
commits. The following has been executed in a real-world repository with
about 2.2 million refs:

    Benchmark #1: HEAD~: rev-list --unsorted-input --objects --quiet --not =
--all --not $newrev
      Time (mean =C2=B1 =CF=83):      4.458 s =C2=B1  0.044 s    [User: 4.1=
15 s, System: 0.342 s]
      Range (min =E2=80=A6 max):    4.409 s =E2=80=A6  4.534 s    10 runs

    Benchmark #2: HEAD: rev-list --unsorted-input --objects --quiet --not -=
-all --not $newrev
      Time (mean =C2=B1 =CF=83):      3.089 s =C2=B1  0.015 s    [User: 2.7=
68 s, System: 0.321 s]
      Range (min =E2=80=A6 max):    3.061 s =E2=80=A6  3.105 s    10 runs

    Summary
      'HEAD: rev-list --unsorted-input --objects --quiet --not --all --not =
$newrev' ran
        1.44 =C2=B1 0.02 times faster than 'HEAD~: rev-list --unsorted-inpu=
t --objects --quiet --not --all --not $newrev'

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 commit-graph.c | 24 ++++++++++++++++++++++++
 commit-graph.h |  8 ++++++++
 revision.c     | 18 ++++++++----------
 3 files changed, 40 insertions(+), 10 deletions(-)

diff --git a/commit-graph.c b/commit-graph.c
index 8c4c7262c8..00614acd65 100644
--- a/commit-graph.c
+++ b/commit-graph.c
@@ -891,6 +891,30 @@ static int find_commit_pos_in_graph(struct commit *ite=
m, struct commit_graph *g,
 	}
 }
=20
+struct commit *lookup_commit_in_graph(struct repository *repo, const struc=
t object_id *id)
+{
+	struct commit *commit;
+	uint32_t pos;
+
+	if (!repo->objects->commit_graph)
+		return NULL;
+	if (!search_commit_pos_in_graph(id, repo->objects->commit_graph, &pos))
+		return NULL;
+	if (!repo_has_object_file(repo, id))
+		return NULL;
+
+	commit =3D lookup_commit(repo, id);
+	if (!commit)
+		return NULL;
+	if (commit->object.parsed)
+		return commit;
+
+	if (!fill_commit_in_graph(repo, commit, repo->objects->commit_graph, pos))
+		return NULL;
+
+	return commit;
+}
+
 static int parse_commit_in_graph_one(struct repository *r,
 				     struct commit_graph *g,
 				     struct commit *item)
diff --git a/commit-graph.h b/commit-graph.h
index 96c24fb577..04a94e1830 100644
--- a/commit-graph.h
+++ b/commit-graph.h
@@ -40,6 +40,14 @@ int open_commit_graph(const char *graph_file, int *fd, s=
truct stat *st);
  */
 int parse_commit_in_graph(struct repository *r, struct commit *item);
=20
+/*
+ * Look up the given commit ID in the commit-graph. This will only return a
+ * commit if the ID exists both in the graph and in the object database su=
ch
+ * that we don't return commits whose object has been pruned. Otherwise, t=
his
+ * function returns `NULL`.
+ */
+struct commit *lookup_commit_in_graph(struct repository *repo, const struc=
t object_id *id);
+
 /*
  * It is possible that we loaded commit contents from the commit buffer,
  * but we also want to ensure the commit-graph content is correctly
diff --git a/revision.c b/revision.c
index 80a59896b9..0dabb5a0bc 100644
--- a/revision.c
+++ b/revision.c
@@ -360,20 +360,18 @@ static struct object *get_reference(struct rev_info *=
revs, const char *name,
 				    unsigned int flags)
 {
 	struct object *object;
+	struct commit *commit;
=20
 	/*
-	 * If the repository has commit graphs, repo_parse_commit() avoids
-	 * reading the object buffer, so use it whenever possible.
+	 * If the repository has commit graphs, we try to opportunistically
+	 * look up the object ID in those graphs. Like this, we can avoid
+	 * parsing commit data from disk.
 	 */
-	if (oid_object_info(revs->repo, oid, NULL) =3D=3D OBJ_COMMIT) {
-		struct commit *c =3D lookup_commit(revs->repo, oid);
-		if (!repo_parse_commit(revs->repo, c))
-			object =3D (struct object *) c;
-		else
-			object =3D NULL;
-	} else {
+	commit =3D lookup_commit_in_graph(revs->repo, oid);
+	if (commit)
+		object =3D &commit->object;
+	else
 		object =3D parse_object(revs->repo, oid);
-	}
=20
 	if (!object) {
 		if (revs->ignore_missing)
--=20
2.32.0


--6M04gA7dF3O5gN+l
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmEQ41IACgkQVbJhu7ck
PpS59w/+It5lccX8cikPCLeQjHI7b1Jz4WKyaJkwLZNMMbeNMGNhhZdk/pj/R1rV
e5XPp5OMkQhX8eXd/Gs+epSlO5dYrNHgNtMP7KFaiMOX2V7WNwjX2ThjtnGbXiW2
xQGJ9RWZ04k2G25fu/s+4UlDVoviIAkEl6SAFhdyJf8M7X0jwxcMKXX/fRL+O65o
CNcw6sgP8DmG1keCr5ZaPTq1EoUOGJTQD/q+N+niAxwHyIbaohH/SO5VfVKtzMW/
luEEBG1OiTWOOy5DNDYIv66upQNClTPfnnRNxDIc6JbVqJKin4SnEE9DfgZu2BrE
U3UIVcM937TnQXt7M8ZA/eGidve9lCOFAdQ/xmcXS/WLr4kNyEIqFbPwQ8kkdWYy
Mi4X/ytwoQMxT8Wi2Fi3bI2ABrgsv+zK5GK4XSlbvA0XMOkKZ+5e0llAli+N/AOc
8PyM0PwKJut9zGFsfGyw5s85vvzsGvaRcSWsqR6JClszbtG6Z2kp7/PGlThmlHEV
YxL5yCv0FsBDqFW9AGtYn63ZkvXqFDv8jikpeFMd4tMFD+Rm2JZMbn7/En0mhu0k
fJ/F3MxaGxHBF+o4wwCdZRrwbx/oOt0SFd43625oWinvI4UvMMaviHj7v7v4jHWC
cI7qflMYeLdfB0uDqXC+DyhQTO9JZ7cacwJ2BAyZc08gjyBaZmI=
=YRUY
-----END PGP SIGNATURE-----

--6M04gA7dF3O5gN+l--
