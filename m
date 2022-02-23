Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02193C433EF
	for <git@archiver.kernel.org>; Wed, 23 Feb 2022 12:35:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240450AbiBWMgG (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 23 Feb 2022 07:36:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239950AbiBWMgE (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 23 Feb 2022 07:36:04 -0500
Received: from wout2-smtp.messagingengine.com (wout2-smtp.messagingengine.com [64.147.123.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F2E08AE46
        for <git@vger.kernel.org>; Wed, 23 Feb 2022 04:35:33 -0800 (PST)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.west.internal (Postfix) with ESMTP id 9CC5E3201D6A
        for <git@vger.kernel.org>; Wed, 23 Feb 2022 07:35:30 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Wed, 23 Feb 2022 07:35:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc
        :content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm3; bh=5UB2CChNp/T2WLHWQQhQiMy1WWeNyh4EH/YSJ9
        GAmDA=; b=FNPjHVCIa5Ufw0PW3ZoM16EIDfrcenJyOPP/yGURDoLAZO8Wjy7glp
        +CzfakPaL7IagQXUg3X8l84vV1f6PLqJgpgS4V185oYHdsGTbwxmOSA9ilojcxEm
        6l9F8KhVNY2+r+zYaA9CoPji/NlyumCN3HkRtWuaOBRmthWVaZNyDmK1nCbjDAoi
        56YV+uodixqVKppN5/dzy7EwpfJDhzaQ0GAPAwhbmox/BhwGA4t4iE46eInWJ8Pa
        xKv7JmGZKGOtLhJ7h2CeiiqfDW6BylsfG/Dy23pgEL9XkcqY7a3TsYLs5VpTs1uh
        1SFXrExnyKU+4XdjJW+UhO1TmR+AwAlQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=5UB2CChNp/T2WLHWQ
        QhQiMy1WWeNyh4EH/YSJ9GAmDA=; b=HVy7UVVtkI9Yy0dZHk8xuA5NLmoLixcvJ
        NwC3kN4Cvlgp4Ddv6vO0b++W1HzKHBNsSY37xgbw+s5OtFhqe7UDfZgbbR8bSLpq
        1vV4a/C9GpxMBVnbGiNCPF5KCdKt39CLpxJtm2VxHKgipemfaStEarQKYLlwfLJv
        F2oTnkWAlbo12tV2kMQjLOI11NEEXzj4lOIMXOzCVYheWkEd1rEXkOqI70ae3GNV
        rH6cYkQI4MJz8kUdPUNvDiAm0FVzeyCqu5+gF1n+KG9JsYROYdmGYGGgHO+jMZOw
        KiDQcUVwAPwYSwxQjkZb8eNtVYY+X2uZsCjiP4CBhmMwWcOgLjt0g==
X-ME-Sender: <xms:ESoWYiH8vLc-S2gs1jOqRDSZUEczPrZY1qdz-bYMSTy0uafKghcVGA>
    <xme:ESoWYjUcX1or4wo28UlS7l1Ou6z0MmqFvASzIRnhhUKezsztYC-8NAF_ZMFfnSChX
    m5_mUnobXJXXb8v7g>
X-ME-Received: <xmr:ESoWYsL4EtxEo7toluN8EHvzn53Imi03W3eikDWef5m3cUc5zGm_8pINQKRzuxmhGORkOPLxFZ2cyQVbyA58RgtvO-GSyJWGsv60CZkOsDGfLXmgP0miwZc>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvvddrledtgdegtdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhepfffhvffukfhfgggtuggjsehgtderre
    dttdejnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhk
    shdrihhmqeenucggtffrrghtthgvrhhnpeehgfejueevjeetudehgffffeffvdejfeejie
    dvkeffgfekuefgheevteeufeelkeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgr
    mhepmhgrihhlfhhrohhmpehpshesphhkshdrihhm
X-ME-Proxy: <xmx:ESoWYsGiTZOrqDEXtgJ2YRpc36A3xFD1LOpzNRGWzux7QHd66XAEsQ>
    <xmx:ESoWYoV2dxxrs68JNd0tEhkQU4DD2ermH1c7RbLRvk-HBhK0uPFH6A>
    <xmx:ESoWYvOQ24z9GjxfUXiKShJJhLYDU7Lv7eLN1NRMjLWKfUxX_AY7XQ>
    <xmx:EioWYrDANCdhnOcS2qmRS9VdXZr9dee5o5Smv5rPq9AsQpJGqbefSw>
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Wed, 23 Feb 2022 07:35:29 -0500 (EST)
Received: from localhost (ncase [10.192.0.11])
        by vm-mail.pks.im (OpenSMTPD) with ESMTPSA id 4d3e29f8 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
        for <git@vger.kernel.org>;
        Wed, 23 Feb 2022 12:35:28 +0000 (UTC)
Date:   Wed, 23 Feb 2022 13:35:27 +0100
From:   Patrick Steinhardt <ps@pks.im>
To:     git@vger.kernel.org
Subject: [PATCH 1/5] upload-pack: look up "want" lines via commit-graph
Message-ID: <ca5e136cca495c7d927e99f5ae8a672d93823eea.1645619224.git.ps@pks.im>
References: <cover.1645619224.git.ps@pks.im>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="AaGX7+af4SEkVC4o"
Content-Disposition: inline
In-Reply-To: <cover.1645619224.git.ps@pks.im>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--AaGX7+af4SEkVC4o
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
of references. It uses cached request from git-fetch(1) as input and
contains about 876,000 "want" lines:

    Benchmark 1: git-upload-pack (HEAD~)
      Time (mean =C2=B1 =CF=83):      7.113 s =C2=B1  0.028 s    [User: 6.9=
00 s, System: 0.662 s]
      Range (min =E2=80=A6 max):    7.072 s =E2=80=A6  7.168 s    10 runs

    Benchmark 2: git-upload-pack (HEAD)
      Time (mean =C2=B1 =CF=83):      6.622 s =C2=B1  0.061 s    [User: 6.4=
52 s, System: 0.650 s]
      Range (min =E2=80=A6 max):    6.535 s =E2=80=A6  6.727 s    10 runs

    Summary
      'git-upload-pack (HEAD)' ran
        1.07 =C2=B1 0.01 times faster than 'git-upload-pack (HEAD~)'

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


--AaGX7+af4SEkVC4o
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmIWKg4ACgkQVbJhu7ck
PpTlhhAAl+c5LNHMm20tER1bpqR4udjywHsJD5lxzs8JGH0hkDECmLm+a2kjTiw5
9+tfG+r9Rnpc/7Ev/MuFRfhFcboV6GpT9hPHfMbh3HZ3kGJuTKChr2ix8oxiQ7aY
qqhkEplhF23gz/fwdmxbaS2xu5hU9TFQOZSTDWY0ElnAT8J0wFRd/DepzWvi15QP
oCFwRueLyBaU4SvLnlXGPKdbBGal1fzqOSVF8Ko+AmdjcYoctuxIeW1iMDx6SSS6
H0pBeQA1NwwuDoDXHEmdzcKhmPuIHmVUJ34PBqQRJ7j672vJlFY1egS/NBCdGHVl
ScU/AwlsV2/6FdvVQzozyGkLbYo3rbXST9b80H+hOmjxZh/tHVk4wwtubwBWQelx
Q8XUzXhBQhoCYy8wlZtpLOuiFrVhWRYBAOB9++AuAo+KfRqmyo+el5OXqDWws+EO
xLjWFoQMc11OihPcSGYqvbvkgdM1QNSRPE0thV9CtydMP/zQEQ+lktFwYe5mHkKj
Di3gs0JUDOiXZjpl842WhWlfKhI0xlWs75+r+JfB2kMkeGtANSAfz2+5dMVRFFu/
M9nRuKB1bUiJGhO06CNpgR9um8Mu5C5XzzS2DDwQ6clZ3/fZfIW28zNmHqDtwrEy
cf/7cUyBk5k96uX3/MpxdN/w8azDcwHok7NZCsasMAnTKU9Gn94=
=AICv
-----END PGP SIGNATURE-----

--AaGX7+af4SEkVC4o--
