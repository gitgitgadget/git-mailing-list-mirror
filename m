Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80737C4338F
	for <git@archiver.kernel.org>; Mon,  9 Aug 2021 08:02:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 503B260C41
	for <git@archiver.kernel.org>; Mon,  9 Aug 2021 08:02:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233753AbhHIICw (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 9 Aug 2021 04:02:52 -0400
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:46495 "EHLO
        out3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233708AbhHIICf (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 9 Aug 2021 04:02:35 -0400
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id 1861C5C00FB;
        Mon,  9 Aug 2021 04:02:05 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Mon, 09 Aug 2021 04:02:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=date
        :from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm1; bh=+wZ79WkJ+l4Sr6fD6pdnCx5DLyW
        pJk5OkRmxHKxkH6Y=; b=P6UeT5EpAo2GcdovyudOQOWAZRHcPcc0L9EsSVai9X3
        eiIiWwU2GTz3PGVeH7bV1Tvyo85TieCW059BPC7VLb0zpmE3imWY38F+WC0joFPU
        bJsP2J6CNBXjdfjy94FoN4d0Q+JKhL+vKlbr79t5T9XISPDx1H0alq8QcoD7SIwx
        5JnZp1X+B2OSSMpyEoKmBpoOnLJYld/qXL77rPW3szeS0B8+Eatzlp7/bXDhsm3g
        NRNBsnlh5FKugISup7l4WeksEPE6OEXd8znqGEqjDGWh3f3i54ugjt320L9fjFzq
        JusbwaaoFrSkPSqgjRqag9x7cDeHdnfHLKLrXZurr5Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=+wZ79W
        kJ+l4Sr6fD6pdnCx5DLyWpJk5OkRmxHKxkH6Y=; b=klV7vPjoLkKoufcDb1+9T5
        THunLhb7tbSTAvRTsT3kmPYkGbRAlnjr1TC49Bo2Ob3rnTQePvPk9RclNV46wYYs
        rpca911eCtrhbpO5Oi0qPzMWwDkzheF+p7sC4kr97JEFeACpEd2Gbrv/aPCUCl95
        9EuTET23s7/RUBtR1JjssFGGzIHuvX9EKTtUxoDkyK4Rzfx9+73GIzF2QxXrsI/n
        1VJD2nqq94SmN02M7jzL5OANOC1IXAfPPTumnolEDzXz3n9iLH+pfHu6G72nAfVD
        tUQO0btS5wOQUnSiDrm6xPdhpkQFVg7CycXv3ddah3CDXw9ln6auZqcPPDdgRnsg
        ==
X-ME-Sender: <xms:_OAQYU6MFsDJkl8yytzpXICoyx98lqUun06fydxBdlsWAPqMETAU1A>
    <xme:_OAQYV7thU9Ybf5pObTMFx-ERMF4zAgchdM1qs4klpNpPW8KmpKsfizde7D6FqCSM
    p28hd2_NHilA-HNyA>
X-ME-Received: <xmr:_OAQYTfdUH2_vGMyzCKFx2-5Mdj7Cba135MnlL4OXimm-1OLfApjVQjXc7aXtJw3t8h6Loc7Pc_XxswyN5vGAD6OWQ9DQ5PIwwFb51ikljVNCxyr4Z8Tsg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvtddrjeeigdduvdduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhfgggtuggjsehgtderredttdejnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeehgfejueevjeetudehgffffeffvdejfeejiedvkeffgfekuefgheevteeufeelkeen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhm
X-ME-Proxy: <xmx:_OAQYZIGxeff_EuCOW6wx73NpNSp_gF-hezwCTDH4SDs2sWecrgTdg>
    <xmx:_OAQYYK8pplfOnp_eWCbZOvcxdkoB0_905Nxht774Cx2AsrA6eP46g>
    <xmx:_OAQYayrGT5anByDq77MI6hmQtscPWlBSw89YA_EDXqVjvp_FclGIA>
    <xmx:_eAQYQ-hl3GpgOD1v9ZT9U4ksik3xmeoCdOm-V1G04lpZo9UgUSEUw>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 9 Aug 2021 04:02:03 -0400 (EDT)
Received: from localhost (ncase [10.192.0.11])
        by vm-mail.pks.im (OpenSMTPD) with ESMTPSA id bfb01de7 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Mon, 9 Aug 2021 08:02:02 +0000 (UTC)
Date:   Mon, 9 Aug 2021 10:02:01 +0200
From:   Patrick Steinhardt <ps@pks.im>
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        SZEDER =?iso-8859-1?Q?G=E1bor?= <szeder.dev@gmail.com>,
        Chris Torek <chris.torek@gmail.com>,
        =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Taylor Blau <me@ttaylorr.com>
Subject: Re: [PATCH v5 0/5] Speed up connectivity checks
Message-ID: <YRDg+U0IJ3rcst9l@ncase>
References: <cover.1624858240.git.ps@pks.im>
 <cover.1628495467.git.ps@pks.im>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="hZSRAwa7N6LjH7AQ"
Content-Disposition: inline
In-Reply-To: <cover.1628495467.git.ps@pks.im>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--hZSRAwa7N6LjH7AQ
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

You can ignore this version. I realized I forgot to address some
feedback while I was sending mails out. I'll resend in some minutes.

Patrick

On Mon, Aug 09, 2021 at 10:00:39AM +0200, Patrick Steinhardt wrote:
> Hi,
>=20
> this is the fifth version of my series to speed up connectivity checks
> in the context of repos with many refs. While the original goal has been
> to speed up connectivity checks only, the series is now optimizing
> git-rev-list(1) in general to be able to more efficiently load
> references. Like this, `--not --all` is a lot faster in the context of
> many refs, but other usecases benefit, too.
>=20
> Changes compared to v4:
>=20
>     - I've changed the interface to load commits via the commit-graph.
>       Instead of the previous version where you'd had to pass in a
>       `struct object`, which forced us to use `lookup_unknown_object()`,
>       one now only passes in an object ID. If the object ID is found in
>       the commit graph and if the corresponding object exists in the
>       ODB, then we return the parsed commit object.
>=20
>       This also avoids a previous pitfal: we'd have parsed the commit
>       via the graph and thus had allocated the object even if the
>       corresponding object didn't exist. While we knew to handle this in
>       `get_reference()` by asserting object existence, any other caller
>       which executes `lookup_commit()` would get the parsed commit and
>       assume that it exists. This now cannot happen anymore given that
>       we only create the commit object in case we know the ID exists in
>       the ODB.
>=20
>     - With this change, I could now drop the patch which avoided loading
>       objects multiple times: we don't need `lookup_unknown_object()`
>       anymore and thus don't thave the memory/perf tradeoff. And with
>       the new interface to load commits via the graph, the deduplication
>       only resulted in a ~1% speedup.
>=20
> Patrick
>=20
> Patrick Steinhardt (5):
>   revision: separate walk and unsorted flags
>   connected: do not sort input revisions
>   revision: stop retrieving reference twice
>   commit-graph: split out function to search commit position
>   revision: avoid hitting packfiles when commits are in commit-graph
>=20
>  Documentation/rev-list-options.txt |  8 ++-
>  builtin/log.c                      |  2 +-
>  builtin/revert.c                   |  3 +-
>  commit-graph.c                     | 79 ++++++++++++++++++++----------
>  commit-graph.h                     |  8 +++
>  connected.c                        |  1 +
>  revision.c                         | 42 +++++++++-------
>  revision.h                         |  7 +--
>  t/t6000-rev-list-misc.sh           | 38 ++++++++++++++
>  9 files changed, 138 insertions(+), 50 deletions(-)
>=20
> Range-diff against v4:
> 1:  67232910ac =3D 1:  67232910ac revision: separate walk and unsorted fl=
ags
> 2:  9d7f484907 =3D 2:  9d7f484907 connected: do not sort input revisions
> 3:  d8e63d0943 =3D 3:  d8e63d0943 revision: stop retrieving reference twi=
ce
> 4:  ba8df5cad0 < -:  ---------- revision: avoid loading object headers mu=
ltiple times
> 5:  e33cd51ebf =3D 4:  549d85e5c2 commit-graph: split out function to sea=
rch commit position
> 6:  900c5a9c60 ! 5:  4b893d943f revision: avoid hitting packfiles when co=
mmits are in commit-graph
>     @@ Metadata
>       ## Commit message ##
>          revision: avoid hitting packfiles when commits are in commit-gra=
ph
>     =20
>     -    When queueing references in git-rev-list(1), we try to either re=
use an
>     -    already parsed object or alternatively we load the object header=
 from
>     -    disk in order to determine its type. This is inefficient for com=
mits
>     -    though in cases where we have a commit graph available: instead =
of
>     -    hitting the real object on disk to determine its type, we may in=
stead
>     -    search the object graph for the object ID. In case it's found, w=
e can
>     -    directly fill in the commit object, otherwise we can still hit t=
he disk
>     -    to determine the object's type.
>     +    When queueing references in git-rev-list(1), we try to optimize =
parsing
>     +    of commits via the commit-graph. To do so, we first look up the =
object's
>     +    type, and if it is a commit we call `repo_parse_commit()` instea=
d of
>     +    `parse_object()`. This is quite inefficient though given that we=
're
>     +    always uncompressing the object header in order to determine the=
 type.
>     +    Instead, we can opportunistically search the commit-graph for th=
e object
>     +    ID: in case it's found, we know it's a commit and can directly f=
ill in
>     +    the commit object without having to uncompress the object header.
>     =20
>     -    Expose a new function `parse_commit_in_graph_gently()`, which fi=
lls in
>     -    an object of unknown type in case we find its object ID in the g=
raph.
>     -    This provides a big performance win in cases where there is a
>     -    commit-graph available in the repository in case we load lots of
>     -    references. The following has been executed in a real-world repo=
sitory
>     -    with about 2.2 million refs:
>     +    Expose a new function `lookup_commit_in_graph()`, which tries to=
 find a
>     +    commit in the commit-graph by ID, and convert `get_reference()` =
to use
>     +    this function. This provides a big performance win in cases wher=
e we
>     +    load references in a repository with lots of references pointing=
 to
>     +    commits. The following has been executed in a real-world reposit=
ory with
>     +    about 2.2 million refs:
>     =20
>              Benchmark #1: HEAD~: rev-list --unsorted-input --objects --q=
uiet --not --all --not $newrev
>     -          Time (mean =C2=B1 =CF=83):      4.508 s =C2=B1  0.039 s   =
 [User: 4.131 s, System: 0.377 s]
>     -          Range (min =E2=80=A6 max):    4.455 s =E2=80=A6  4.576 s  =
  10 runs
>     +          Time (mean =C2=B1 =CF=83):      4.458 s =C2=B1  0.044 s   =
 [User: 4.115 s, System: 0.342 s]
>     +          Range (min =E2=80=A6 max):    4.409 s =E2=80=A6  4.534 s  =
  10 runs
>     =20
>              Benchmark #2: HEAD: rev-list --unsorted-input --objects --qu=
iet --not --all --not $newrev
>     -          Time (mean =C2=B1 =CF=83):      3.072 s =C2=B1  0.031 s   =
 [User: 2.707 s, System: 0.365 s]
>     -          Range (min =E2=80=A6 max):    3.040 s =E2=80=A6  3.144 s  =
  10 runs
>     +          Time (mean =C2=B1 =CF=83):      3.089 s =C2=B1  0.015 s   =
 [User: 2.768 s, System: 0.321 s]
>     +          Range (min =E2=80=A6 max):    3.061 s =E2=80=A6  3.105 s  =
  10 runs
>     =20
>              Summary
>                'HEAD: rev-list --unsorted-input --objects --quiet --not -=
-all --not $newrev' ran
>     -            1.47 =C2=B1 0.02 times faster than 'HEAD~: rev-list --un=
sorted-input --objects --quiet --not --all --not $newrev'
>     +            1.44 =C2=B1 0.02 times faster than 'HEAD~: rev-list --un=
sorted-input --objects --quiet --not --all --not $newrev'
>     =20
>          Signed-off-by: Patrick Steinhardt <ps@pks.im>
>     =20
>     @@ commit-graph.c: static int find_commit_pos_in_graph(struct commit =
*item, struct
>       	}
>       }
>      =20
>     -+int parse_commit_in_graph_gently(struct repository *repo, struct ob=
ject *object)
>     ++struct commit *lookup_commit_in_graph(struct repository *repo, cons=
t struct object_id *id)
>      +{
>      +	struct commit *commit;
>      +	uint32_t pos;
>      +
>     -+	if (object->parsed) {
>     -+		if (object->type !=3D OBJ_COMMIT)
>     -+			return -1;
>     -+		return 0;
>     -+	}
>     -+
>      +	if (!repo->objects->commit_graph)
>     -+		return -1;
>     ++		return NULL;
>     ++	if (!search_commit_pos_in_graph(id, repo->objects->commit_graph, &=
pos))
>     ++		return NULL;
>     ++	if (!repo_has_object_file(repo, id))
>     ++		return NULL;
>      +
>     -+	if (!search_commit_pos_in_graph(&object->oid, repo->objects->commi=
t_graph, &pos))
>     -+		return -1;
>     -+
>     -+	commit =3D object_as_type(object, OBJ_COMMIT, 1);
>     ++	commit =3D lookup_commit(repo, id);
>      +	if (!commit)
>     -+		return -1;
>     -+	if (!fill_commit_in_graph(repo, commit, repo->objects->commit_grap=
h, pos))
>     -+		return -1;
>     ++		return NULL;
>     ++	if (commit->object.parsed)
>     ++		return commit;
>      +
>     -+	return 0;
>     ++	if (!fill_commit_in_graph(repo, commit, repo->objects->commit_grap=
h, pos))
>     ++		return NULL;
>     ++
>     ++	return commit;
>      +}
>      +
>       static int parse_commit_in_graph_one(struct repository *r,
>     @@ commit-graph.h: int open_commit_graph(const char *graph_file, int =
*fd, struct st
>       int parse_commit_in_graph(struct repository *r, struct commit *item=
);
>      =20
>      +/*
>     -+ * Given an object of unknown type, try to fill in the object in ca=
se it is a
>     -+ * commit part of the commit-graph. Returns 0 if the object is a pa=
rsed commit
>     -+ * or if it could be filled in via the commit graph, otherwise it r=
eturns -1.
>     ++ * Look up the given commit ID in the commit-graph. This will only =
return a
>     ++ * commit if the ID exists both in the graph and in the object data=
base such
>     ++ * that we don't return commits whose object has been pruned. Other=
wise, this
>     ++ * function returns `NULL`.
>      + */
>     -+int parse_commit_in_graph_gently(struct repository *repo, struct ob=
ject *object);
>     ++struct commit *lookup_commit_in_graph(struct repository *repo, cons=
t struct object_id *id);
>      +
>       /*
>        * It is possible that we loaded commit contents from the commit bu=
ffer,
>     @@ commit-graph.h: int open_commit_graph(const char *graph_file, int =
*fd, struct st
>     =20
>       ## revision.c ##
>      @@ revision.c: static struct object *get_reference(struct rev_info *=
revs, const char *name,
>     - 	struct object *object =3D lookup_unknown_object(revs->repo, oid);
>     + 				    unsigned int flags)
>     + {
>     + 	struct object *object;
>     ++	struct commit *commit;
>      =20
>     - 	if (object->type =3D=3D OBJ_NONE) {
>     --		int type =3D oid_object_info(revs->repo, oid, NULL);
>     --		if (type < 0 || !object_as_type(object, type, 1)) {
>     -+		/*
>     -+		 * It's likely that the reference points to a commit, so we
>     -+		 * first try to look it up via the commit-graph. If successful,
>     -+		 * then we know it's a commit and don't have to unpack the
>     -+		 * object header. We still need to assert that the object
>     -+		 * exists, but given that we don't request any info about the
>     -+		 * object this is a lot faster than `oid_object_info()`.
>     -+		 */
>     -+		if (parse_commit_in_graph_gently(revs->repo, object) < 0) {
>     -+			int type =3D oid_object_info(revs->repo, oid, NULL);
>     -+			if (type < 0 || !object_as_type(object, type, 1)) {
>     -+				object =3D NULL;
>     -+				goto out;
>     -+			}
>     -+		} else if (!repo_has_object_file(revs->repo, oid)) {
>     - 			object =3D NULL;
>     - 			goto out;
>     - 		}
>     + 	/*
>     +-	 * If the repository has commit graphs, repo_parse_commit() avoids
>     +-	 * reading the object buffer, so use it whenever possible.
>     ++	 * If the repository has commit graphs, we try to opportunistically
>     ++	 * look up the object ID in those graphs. Like this, we can avoid
>     ++	 * parsing commit data from disk.
>     + 	 */
>     +-	if (oid_object_info(revs->repo, oid, NULL) =3D=3D OBJ_COMMIT) {
>     +-		struct commit *c =3D lookup_commit(revs->repo, oid);
>     +-		if (!repo_parse_commit(revs->repo, c))
>     +-			object =3D (struct object *) c;
>     +-		else
>     +-			object =3D NULL;
>     +-	} else {
>     ++	commit =3D lookup_commit_in_graph(revs->repo, oid);
>     ++	if (commit)
>     ++		object =3D &commit->object;
>     ++	else
>     + 		object =3D parse_object(revs->repo, oid);
>     +-	}
>     +=20
>     + 	if (!object) {
>     + 		if (revs->ignore_missing)
> --=20
> 2.32.0
>=20



--hZSRAwa7N6LjH7AQ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmEQ4PgACgkQVbJhu7ck
PpRSvhAApkR5nNbddhLsVBQ/xBrfmr4srTmS0b2/5c8cnt+/nI2Qr0zwVXqTHAod
3TzOx1enGn/SuClDbUFJ8Lrjw9faL7+a5oj+N/sCvQ6LzMQ8CG+tx6B6KHRrsRE/
JFc8YzUgKchAX6iSk+NFPrnSMPVJRwIsbSWaxqTzFRpTSSWqICI4CfxxRmDP4Izw
T3/qiYgPgSzPeHwpYelYbLNeik/VlhGcWZecRA7EucBQl0B2SKSOPEJY0SZVXjF9
Pb8e0qd/xGNhjMXTWZfyCMpHc0YGDXMoSjKHezoVVew5UjEALjzEc1b3ofNuvQ3Y
JHTph1tsk9WAaEK8bE3Qxvu54E//fLkSYplKQhFECL4YMstLKNXfo0Nd8A4z0d2L
PtgKiCbbBgNHi1SAOxLXcJtI5kzJaGKJDOR/C9cogfvjE381NGsUr0a/GM+JkFAo
QyQTsGH0sxBibA9glsw3+6lHtMTyJ/MrzlwTaaPD5TRG6biYUMlH7Gg1UUmCvyXN
9/fFaNl8fMPnfNHUbV5BxP5qjOl0UyD9RfSbb7VajxLphtdge7dZTVF098TRVdzK
bZfimA6f7fe3TAYSypjwdi9iJgzjjJ+3BosSxYUh4fHn+hlyPNF0uqI3F93OrpaO
4TASSPNbk0P3WZQGH7/HO2xaCHTqpd7NO/1vj9PMrrkMVj0+Sos=
=tXVo
-----END PGP SIGNATURE-----

--hZSRAwa7N6LjH7AQ--
