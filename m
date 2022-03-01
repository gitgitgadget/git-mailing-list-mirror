Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCFC0C433F5
	for <git@archiver.kernel.org>; Tue,  1 Mar 2022 09:34:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232895AbiCAJel (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 1 Mar 2022 04:34:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232098AbiCAJel (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 1 Mar 2022 04:34:41 -0500
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com [66.111.4.26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E42DF5F4D8
        for <git@vger.kernel.org>; Tue,  1 Mar 2022 01:33:45 -0800 (PST)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id 6EEA95C0163;
        Tue,  1 Mar 2022 04:33:40 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Tue, 01 Mar 2022 04:33:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
        :content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm3; bh=kOuViQxE6N2JUrM7hk0z5TXZTTF5+5+eGzXYGg
        EeoQo=; b=kx1hpmcXfiId8qiBhPgfDFhPKUltXXDJMSBGKRebLSM0imVU1oAPs8
        f5Z7kc2NOFSAphPMNYWFUJkfg7gypmVCeY3WVISRiRvZLh7W1KAqjH/O8m6lCD2L
        uEQCpArvn3n2Y5q7LxkKRzrAvvWqmwNSLxAQ5NL7bnSXwpNSEVDD8QmGDSlI6g4r
        iKZeJiUDZBR1ctTzzKrc3zMXLVC/KPLip7SvIgWBp33Xl3FYjrc0UTghajQ54g35
        lTU5o291EouA4Qn2uASWTjyhfZdgfo2a5MQMGY0g1FHsFS6BG4XX9As/18tb1xxp
        o1r9L6qr3GpOz+KaqehZo0stJfijclpg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=kOuViQxE6N2JUrM7h
        k0z5TXZTTF5+5+eGzXYGgEeoQo=; b=edGMequtnzSTFfhoeh1ja4z2jyhHVcvpC
        8dYZaMvD6FCsnpcxZz2iZBO9vXZJHf8fufP5xY9tog7PgAZBbHcW57D4/Y2qQbO5
        81nKjRYZPbemfxM+xGVuaZL3tVfb5z9SZyp50LGNv48wcn4aS1Xf5zGy7rKrzHWu
        gAwnOfCgFVfaquP5s2qMqECt9s29MxkyVDXnOi8NdU0SsTbSZKQwLxA2q2YHvgf9
        Aml82lsaXUiuCWCzM5Fn4TvpybWraYjK50FXtfr+UPQEAwJQGrcVwtmOKDparVsO
        UttocvquPH1cZ9FeMXS8+9pPeFvtw8nJht+5tkU4WoeBdSKEibucQ==
X-ME-Sender: <xms:dOgdYk95cnjltuHghFPRU0G32EmCF89iTPBBcpFMefTCNrj69c9NGw>
    <xme:dOgdYsu8hMCktA-x79YWQYUnuO9QVP--Cx66z7UeQcCWAuGTY9g4HwpW54NWHRpbu
    k_5yJeyjbdcRpsrlw>
X-ME-Received: <xmr:dOgdYqAcp0aG8P7y8CNh5cf3M2SVMCpwMEcdgdqj8jkEzwYwi3N8WuNt30EgKDDwbzIU6s40bPD3nSHRRH4BbaHwQ2FXg3qVNwa0DqGPT5w0RqsuNp7QGFhA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvvddruddtvddgtdefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhfgggtuggjsehgtderredttdejnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeehgfejueevjeetudehgffffeffvdejfeejiedvkeffgfekuefgheevteeufeelkeen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhm
X-ME-Proxy: <xmx:dOgdYkdcQqEMCiA9HAa-PHUP4gN8_595vL2QrFxC9xX9s1OZh8Q2kw>
    <xmx:dOgdYpPY4Cc2bwUhsSnqYvWGI9B-TYOUI4l0ec1gh_IRHAhXrkmxhQ>
    <xmx:dOgdYunkup95wSei3eTCeKqNgx6SFgxKJ83hIkqf4xt2kR027K4uFA>
    <xmx:dOgdYrUtv5EMCyBhpCh8RpAM5Fd915RvZEr-TFLG2Dn6Qa6rETMdcA>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 1 Mar 2022 04:33:39 -0500 (EST)
Received: from localhost (ncase [10.192.0.11])
        by vm-mail.pks.im (OpenSMTPD) with ESMTPSA id f60d94ff (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Tue, 1 Mar 2022 09:33:39 +0000 (UTC)
Date:   Tue, 1 Mar 2022 10:33:37 +0100
From:   Patrick Steinhardt <ps@pks.im>
To:     git@vger.kernel.org
Cc:     Derrick Stolee <derrickstolee@github.com>
Subject: [PATCH v2 1/5] upload-pack: look up "want" lines via commit-graph
Message-ID: <b5c696bd8e4b33e782e4837ad5051268e35f9828.1646127015.git.ps@pks.im>
References: <cover.1645619224.git.ps@pks.im>
 <cover.1646127015.git.ps@pks.im>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="3TWrTCZjCKfC+aiR"
Content-Disposition: inline
In-Reply-To: <cover.1646127015.git.ps@pks.im>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--3TWrTCZjCKfC+aiR
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

During packfile negotiation the client will send "want" and "want-ref"
lines to the server to tell it which objects it is interested in. The
server-side parses each of those and looks them up to see whether it
actually has requested objects. This lookup is performed by calling
`parse_object()` directly, which thus hits the object database. In the
general case though most of the objects the client requests will be
commits. We can thus try to look up the object via the commit-graph
opportunistically, which is much faster than doing the same via the
object database.

Refactor parsing of both "want" and "want-ref" lines to do so.

The following benchmark is executed in a repository with a huge number
of references. It uses cached request from git-fetch(1) as input to
git-upload-pack(1) that contains about 876,000 "want" lines:

    Benchmark 1: HEAD~
      Time (mean =C2=B1 =CF=83):      7.113 s =C2=B1  0.028 s    [User: 6.9=
00 s, System: 0.662 s]
      Range (min =E2=80=A6 max):    7.072 s =E2=80=A6  7.168 s    10 runs

    Benchmark 2: HEAD
      Time (mean =C2=B1 =CF=83):      6.622 s =C2=B1  0.061 s    [User: 6.4=
52 s, System: 0.650 s]
      Range (min =E2=80=A6 max):    6.535 s =E2=80=A6  6.727 s    10 runs

    Summary
      'HEAD' ran
        1.07 =C2=B1 0.01 times faster than 'HEAD~'

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 upload-pack.c | 20 +++++++++++++++++---
 1 file changed, 17 insertions(+), 3 deletions(-)

diff --git a/upload-pack.c b/upload-pack.c
index 8acc98741b..3a851b3606 100644
--- a/upload-pack.c
+++ b/upload-pack.c
@@ -1400,13 +1400,19 @@ static int parse_want(struct packet_writer *writer,=
 const char *line,
 	const char *arg;
 	if (skip_prefix(line, "want ", &arg)) {
 		struct object_id oid;
+		struct commit *commit;
 		struct object *o;
=20
 		if (get_oid_hex(arg, &oid))
 			die("git upload-pack: protocol error, "
 			    "expected to get oid, not '%s'", line);
=20
-		o =3D parse_object(the_repository, &oid);
+		commit =3D lookup_commit_in_graph(the_repository, &oid);
+		if (commit)
+			o =3D &commit->object;
+		else
+			o =3D parse_object(the_repository, &oid);
+
 		if (!o) {
 			packet_writer_error(writer,
 					    "upload-pack: not our ref %s",
@@ -1434,7 +1440,7 @@ static int parse_want_ref(struct packet_writer *write=
r, const char *line,
 	if (skip_prefix(line, "want-ref ", &refname_nons)) {
 		struct object_id oid;
 		struct string_list_item *item;
-		struct object *o;
+		struct object *o =3D NULL;
 		struct strbuf refname =3D STRBUF_INIT;
=20
 		strbuf_addf(&refname, "%s%s", get_git_namespace(), refname_nons);
@@ -1448,7 +1454,15 @@ static int parse_want_ref(struct packet_writer *writ=
er, const char *line,
 		item =3D string_list_append(wanted_refs, refname_nons);
 		item->util =3D oiddup(&oid);
=20
-		o =3D parse_object_or_die(&oid, refname_nons);
+		if (!starts_with(refname_nons, "refs/tags/")) {
+			struct commit *commit =3D lookup_commit_in_graph(the_repository, &oid);
+			if (commit)
+				o =3D &commit->object;
+		}
+
+		if (!o)
+			o =3D parse_object_or_die(&oid, refname_nons);
+
 		if (!(o->flags & WANTED)) {
 			o->flags |=3D WANTED;
 			add_object_array(o, NULL, want_obj);
--=20
2.35.1


--3TWrTCZjCKfC+aiR
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmId6HEACgkQVbJhu7ck
PpR/7hAAgJTisuZuoTosdIeUFGS8JU6dY8J/2mTYoOM93TSPJGLX4jFSNRhey2ko
r6JQ5HpW0TZQ9JaYUDF2nMUrA76sXdXuwtpWsJi08PjAVFR5M1XR0QdVeUnsiFGc
kB/9gH1KjixmwX2d/nxipytr3SDXyCChIS9Vj3pssG5rufNtoBuNL2QUpo2E+4Fz
NiKvrdI7koJFjxKTCUHjUP/QZ5lKKA/pAFdAbfBb5OY/10FrUQBPbSPFbbqeTlIZ
DG6uSgwxAMNQElWA73O7q98Pwv+PHyAyLEmvhrHXr1ods3NHy2FxFAGLycfdpl8H
hrwI27QPWL68sssZzu45L9uAEdVvf2xFEaqP19v4EKMG67CtlET2NNu0rKXtZS8w
DkAg+uV5cMUHyzB8YuPbcl93o4EFex+IA6cYXpjE3qdnnHd0KIBQ1iF3P+d3as74
6U8QWUu9OFU23zm0mPygra+6/FHrqkgDgkM19KeAwzuopaV9DZfYShen33f0XLkC
l6MQm9yG7H39P4htxYXx64m1NtSRFr67IhwzpkQ8EOXKEWXUNePzt4vggjhtg502
E1uionbRy7u7UW4Slf3BIWCjzj1sEFeNgYyiv06lDkgZupl05/DDhRA8gjU3R7Ga
jftGmzgA+WRvVIrxQfiV/Z4bImRzRMhEoTN1fTx0lF1xolyHQz4=
=f6Ge
-----END PGP SIGNATURE-----

--3TWrTCZjCKfC+aiR--
