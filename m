Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94F19C433F5
	for <git@archiver.kernel.org>; Wed, 23 Feb 2022 12:35:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240476AbiBWMgS (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 23 Feb 2022 07:36:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240478AbiBWMgK (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 23 Feb 2022 07:36:10 -0500
Received: from wout2-smtp.messagingengine.com (wout2-smtp.messagingengine.com [64.147.123.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDD1BA1479
        for <git@vger.kernel.org>; Wed, 23 Feb 2022 04:35:42 -0800 (PST)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.west.internal (Postfix) with ESMTP id 7233D3201805
        for <git@vger.kernel.org>; Wed, 23 Feb 2022 07:35:42 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Wed, 23 Feb 2022 07:35:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc
        :content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm3; bh=Giu0OPHv20pjZgogtRRyrp+R+l/l7a8KO7ceBo
        byli0=; b=k5vqDuhrNDfC6mREJGJg9jxOj5L5FpCobswR2gHy5/p8uMfan/1BkQ
        Xyugg+6yKzDTxak+Z+07pIXz110r3cnebTeDas01MY9dIrdN+7Gejz+aYe6WZmht
        4BlclWVOkmQ55qSq9EtYdLhT7PE7bd171zQowM0NaQZEnKfoKFjTcvsHQ21wcYxC
        AaXBportp7MH5fPEgiDTie6CzE6ao5WzwEMTcyVwz69Yv3Gj4b/SdH4VPA72IOi1
        ZZTL3EbpE7S4ds5NhO4cFB5bk4ymtQwDWULLzOFYhrYo2C/g+kZJVr7H4g2j1NtH
        jLlYTHBSW6d0MvmIXp7PBF2rxJTCSd/A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=Giu0OPHv20pjZgogt
        RRyrp+R+l/l7a8KO7ceBobyli0=; b=ZLmMdcUNGQFZuPOnFBCOdyqsxpmJkrLMX
        NuWyvP3wRhsDNgRYZSN40Q60VSRrOh6v+HmHKwCjbKmrjG3/Z7yErAKj9igc08zq
        GP6hU2VL2O8HBWU03NofZf16Y8Kki4gFn7z/FZbMXu14wt34MPejaZOSCGeik8UU
        0F5EuMlI98HPwkcwYUuvXv4sa5Xh7OblhRIA+hdJV7lKCpBsbG9WMoJv7pVrgWMD
        VsAiyoDU+mziUEFnquJe/78MnESfwLWVlbcYVVR5ZxWB/cnWWRAPnrRHJyVKfGyb
        /44bvLGH569uQnG3rYoR/EwKmM6CGlDLnx/A7uK2BNt3fCYzbywjw==
X-ME-Sender: <xms:HSoWYglXWv16ZwKrfC5NdjTH0C7S5M3NLQ_jGrrSmdzbqZF134XJCQ>
    <xme:HSoWYv1A61sAIr-2rcOWuM6hHxCHnpq_-npPsNaydvZtyLDhuigJNz9yVvh0yCuot
    sqjw-4KGfyEUsAvPw>
X-ME-Received: <xmr:HSoWYupRKsa_OxMxwJlRxikcYBL7_VHOB3HE0bX6i091WNiTuNHRTVjpOVhM_Q7WckUObPe6rlwpSozBh7YalzRug0rjNWhHoob9YGCmYqz45ZZSspKi9uA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvvddrledtgdegudcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhepfffhvffukfhfgggtuggjsehgtderre
    dttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhk
    shdrihhmqeenucggtffrrghtthgvrhhnpeehgefhtdefueffheekgfffudelffejtdfhvd
    ejkedthfehvdelgfetgfdvtedthfenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgr
    mhepmhgrihhlfhhrohhmpehpshesphhkshdrihhm
X-ME-Proxy: <xmx:HSoWYsmIOBqw-YLTK31b3aQgcH7yv4ebYaedv6HM-p7M8VUWaWU5xA>
    <xmx:HSoWYu2XhphvI2tPwDrA9ERiIxhgP2NUrrX72hvDU0YcxqVQ4xf0wA>
    <xmx:HSoWYjs6MPNiyykCilW0UEgAZ6N8v0QUUqqv2bp0vrFxAgYAnSETTw>
    <xmx:HioWYni2Be4kLp2oATprmQpXLhlGBZoEUERorP9MVR-p9qi9l_gIjA>
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Wed, 23 Feb 2022 07:35:41 -0500 (EST)
Received: from localhost (ncase [10.192.0.11])
        by vm-mail.pks.im (OpenSMTPD) with ESMTPSA id 71224808 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
        for <git@vger.kernel.org>;
        Wed, 23 Feb 2022 12:35:40 +0000 (UTC)
Date:   Wed, 23 Feb 2022 13:35:39 +0100
From:   Patrick Steinhardt <ps@pks.im>
To:     git@vger.kernel.org
Subject: [PATCH 4/5] remote: read symbolic refs via `refs_read_symbolic_ref()`
Message-ID: <1d24101fe4fb296257110eb82da67c95b5e03189.1645619224.git.ps@pks.im>
References: <cover.1645619224.git.ps@pks.im>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="yAaKvcoGiXS+ltt2"
Content-Disposition: inline
In-Reply-To: <cover.1645619224.git.ps@pks.im>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--yAaKvcoGiXS+ltt2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

We have two cases in the remote code where we check whether a reference
is symbolic or not, but don't mind in case it doesn't exist or in case
it exists but is a non-symbolic reference. Convert these two callsites
to use the new `refs_read_symbolic_ref()` function, whose intent is to
implement exactly that usecase.

No change in behaviour is expected from this change.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/remote.c |  8 +++++---
 remote.c         | 14 +++++++-------
 2 files changed, 12 insertions(+), 10 deletions(-)

diff --git a/builtin/remote.c b/builtin/remote.c
index 6f27ddc47b..0142ed09b5 100644
--- a/builtin/remote.c
+++ b/builtin/remote.c
@@ -766,13 +766,15 @@ static int mv(int argc, const char **argv)
 	for_each_ref(read_remote_branches, &rename);
 	for (i =3D 0; i < remote_branches.nr; i++) {
 		struct string_list_item *item =3D remote_branches.items + i;
-		int flag =3D 0;
+		struct strbuf referent =3D STRBUF_INIT;
=20
-		read_ref_full(item->string, RESOLVE_REF_READING, NULL, &flag);
-		if (!(flag & REF_ISSYMREF))
+		if (refs_read_symbolic_ref(get_main_ref_store(the_repository), item->str=
ing,
+					   &referent))
 			continue;
 		if (delete_ref(NULL, item->string, NULL, REF_NO_DEREF))
 			die(_("deleting '%s' failed"), item->string);
+
+		strbuf_release(&referent);
 	}
 	for (i =3D 0; i < remote_branches.nr; i++) {
 		struct string_list_item *item =3D remote_branches.items + i;
diff --git a/remote.c b/remote.c
index c97c626eaa..42a4e7106e 100644
--- a/remote.c
+++ b/remote.c
@@ -1945,13 +1945,9 @@ const char *branch_get_push(struct branch *branch, s=
truct strbuf *err)
 	return branch->push_tracking_ref;
 }
=20
-static int ignore_symref_update(const char *refname)
+static int ignore_symref_update(const char *refname, struct strbuf *scratc=
h)
 {
-	int flag;
-
-	if (!resolve_ref_unsafe(refname, 0, NULL, &flag))
-		return 0; /* non-existing refs are OK */
-	return (flag & REF_ISSYMREF);
+	return !refs_read_symbolic_ref(get_main_ref_store(the_repository), refnam=
e, scratch);
 }
=20
 /*
@@ -1964,6 +1960,7 @@ static int ignore_symref_update(const char *refname)
 static struct ref *get_expanded_map(const struct ref *remote_refs,
 				    const struct refspec_item *refspec)
 {
+	struct strbuf scratch =3D STRBUF_INIT;
 	const struct ref *ref;
 	struct ref *ret =3D NULL;
 	struct ref **tail =3D &ret;
@@ -1971,11 +1968,13 @@ static struct ref *get_expanded_map(const struct re=
f *remote_refs,
 	for (ref =3D remote_refs; ref; ref =3D ref->next) {
 		char *expn_name =3D NULL;
=20
+		strbuf_reset(&scratch);
+
 		if (strchr(ref->name, '^'))
 			continue; /* a dereference item */
 		if (match_name_with_pattern(refspec->src, ref->name,
 					    refspec->dst, &expn_name) &&
-		    !ignore_symref_update(expn_name)) {
+		    !ignore_symref_update(expn_name, &scratch)) {
 			struct ref *cpy =3D copy_ref(ref);
=20
 			cpy->peer_ref =3D alloc_ref(expn_name);
@@ -1987,6 +1986,7 @@ static struct ref *get_expanded_map(const struct ref =
*remote_refs,
 		free(expn_name);
 	}
=20
+	strbuf_release(&scratch);
 	return ret;
 }
=20
--=20
2.35.1


--yAaKvcoGiXS+ltt2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmIWKhoACgkQVbJhu7ck
PpSYfxAAhy7Ga80Du9vAQEgCEC3+Wef1qxInTSXmPLnGVcyWrVasBffQZjIlQojU
eflrXhpPVF+LbV74Y2RWmo4Ju586O/Hj29r84v7b+YK4yyLJLImOJElxKtbO6XVx
Vkj9+O9dbfp8HNRu4WM1bdPlvK3AJhe1BReVQfkyOMMX8YYphbHCp7FWA4cibfNp
0VRakhyBvRyovFpDJwpfgOOkWpivkQ4TT8tKp/a4IBLJsYwAJ2W+m0BHGoaH+1gn
VCJUfkUCKEueRSY37WmVQZnjpwzF4g/xtdHNJQuAJvruaITtHddZL5gHh0h45171
e2X+lca+3Jcv32O7lCTYlp1GDXjXF6lDJtQ1Zv6M+qJU2oe3kp0DqeuWyhIyfFcx
2DXw/knPIqxOpCzP7BYUGo+HDK4rdeF3/dnelyBCok33zyXGdZ8wBiRJ8YvcCi+z
lI1y6XgKj4aZAAocCojHhU/BsgK7Tu02dxZCO0G+0arBPOaYLevlr4nuPSgTgIQk
3WL1wD5vZ5G+v1kVz1EM34OnBPkPMSYbqu7MYuQQs9Og/Xpsyuk5tJ6ToF13V1LJ
aBrmkMkBIkavaCPmYwXfyM7OrgkrUSke/BmsE7QeQZIYb6miSRoxJfgMlGjRQHP1
22FOpfYTPUwPCTRYccxxD6ALdv0uIPgzD07u+UHuIo2XdYQiOIo=
=MqLl
-----END PGP SIGNATURE-----

--yAaKvcoGiXS+ltt2--
