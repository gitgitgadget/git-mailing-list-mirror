Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8A04C433EF
	for <git@archiver.kernel.org>; Tue,  1 Mar 2022 09:34:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233908AbiCAJe4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 1 Mar 2022 04:34:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233899AbiCAJeu (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 1 Mar 2022 04:34:50 -0500
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com [66.111.4.26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C176C61A18
        for <git@vger.kernel.org>; Tue,  1 Mar 2022 01:33:53 -0800 (PST)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id 2BE005C0222;
        Tue,  1 Mar 2022 04:33:53 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Tue, 01 Mar 2022 04:33:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
        :content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm3; bh=sHexnTpHGh004nhNBlhctc3vSj6gB6KihvkUSl
        cxXag=; b=TOb1weRPX5OYOu10GaUsnC9OD1+tHAhpyqKmNlCLUSE1TPSGORptmQ
        WdQGEW2TCnTTDu1lcaKlEmuIw1Wwh0jrsB9UciPp+UpUpbmUlTvV3dvLkD4AStIt
        FKAfN1DpLaoMJ/zsNZ6MpYm7peB/EJoUox3LqwG6AV1SUoIJr/ozW+EUkGRDJlsj
        WHy+pqApGIhh1wyGNr8+fv6ZbhQemMUkzOFZMwiiyQbBvXgY0HWagA1DTjG+vrgO
        j7c8Flqro5YiqpoevdtOKZp9yItGcg63lsaAgZSH9rMMD7WExQXY0J+xqwkxKAW0
        6gvETVcRa1XEkN2Hev13WyahOsNm5gBQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=sHexnTpHGh004nhNB
        lhctc3vSj6gB6KihvkUSlcxXag=; b=IS+/UcPFuMXx3LyYl2Mj4QZ1j1FuJb0nB
        0dDtWJzQKq5xDyFygl33RmXwuT3TfEwQZam1ZLyBIRDP+7P31YCVyTkLQXHjAHjy
        PyjHStRvTcmLhP/WHANoMX8SlPgNJgRGS7E/Pwou24hBDYeZ45cXBKiOxs5OoZ/a
        6ZTgiMvQ2QLmoJx715jpjYWVE4TV6RFUl9xSBL9jXFKgCkj6Fdms8hqIuyo8r2k4
        2CI05zF5sJUUBmDkmB7Jx2Gio2gYMS87maxDi5TTHbptgBul3TGd3WLJEhEnJMpo
        xpBwEt/OUj/P4z5MKveVNm5eMB4GXFGGUETz9gZ7Ok+Ll7QTkGRSQ==
X-ME-Sender: <xms:gegdYukfDdNJPShA8IkAeq_TjxsLtfFtlf4hhaZBCe7sZLBWv-DsGA>
    <xme:gegdYl0IBGhLEjVX17VL4iE8IzWL7QOVX6uuEMO4W1U34LELiy4EOVz8v-IaazS2S
    fWhnzZbvUphlTTcsg>
X-ME-Received: <xmr:gegdYsp1Vzxz-zUo9rjIC5webTJ3I3WLOG6pv151Obp5HEqDgogpuGeN0bPK6y1fcFX1DD9pUtYeHyBC6F99o4AgNf8JX8_L3e1Gyp9Px3DeSVVFn7fwWPkx>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvvddruddtvddgtdegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeehgefhtdefueffheekgfffudelffejtdfhvdejkedthfehvdelgfetgfdvtedthfen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhm
X-ME-Proxy: <xmx:gegdYikPLExygBTVhjXrm8wq9I_kuqiH5Dc1rYbB1hHb9PQZQtMxdw>
    <xmx:gegdYs0OcchZDQB0_o4QBiigU8frnP7eoNaeMyPwApDNUZiMVbAIVA>
    <xmx:gegdYpsXUtfuSWX5DMa4C18F_0qzXxykm0ZYJk0O2a6V8wJvVWtKLA>
    <xmx:gegdYh_C7b2IPEwBB7ZcxyLVZy_RLM2MZYdKqMfZmfPs8CofcbWUgw>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 1 Mar 2022 04:33:52 -0500 (EST)
Received: from localhost (ncase [10.192.0.11])
        by vm-mail.pks.im (OpenSMTPD) with ESMTPSA id 433632da (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Tue, 1 Mar 2022 09:33:51 +0000 (UTC)
Date:   Tue, 1 Mar 2022 10:33:50 +0100
From:   Patrick Steinhardt <ps@pks.im>
To:     git@vger.kernel.org
Cc:     Derrick Stolee <derrickstolee@github.com>
Subject: [PATCH v2 4/5] remote: read symbolic refs via
 `refs_read_symbolic_ref()`
Message-ID: <0489380e00357dcdd14e399a88d420eab66b19bb.1646127015.git.ps@pks.im>
References: <cover.1645619224.git.ps@pks.im>
 <cover.1646127015.git.ps@pks.im>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="cZEu1l5gr4zjcpWQ"
Content-Disposition: inline
In-Reply-To: <cover.1646127015.git.ps@pks.im>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--cZEu1l5gr4zjcpWQ
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


--cZEu1l5gr4zjcpWQ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmId6H0ACgkQVbJhu7ck
PpQK6g/9HDNn4HYv8dJGmrqzmI1/wkQmT7R95h6DfYJCo9q/RYysnYLRpjB4wpW2
a+yTLWnBimB4zJbnwA+5ZjTU5yGfvcj0G+fz0rlgtzbRnlYldgNLt7eWjj4Pi6zd
fFYaoqPPbIg1xlvIa1GXlG/DwjjNMNpRRmYDZTbxppwwVpw++TyM1ReXXl2K2x5f
Gj7H97hx6yuIca7uJu3CTEUkVY2Xk63NvnYdqkE7pNCsf7YKLvIo2NbcQEkWnzQ6
4CL4B4y7DgNHCB3ZWYt0/mL4GO17PGoGnlAb0gaG9xhpkR00cNx7RGj8DGHQrqRu
hmB89OL5+27pL5fOTc5qAzfuHsw0DzwGraS8G2y5N04tytUaAhYotwgGTWPQG2qR
ZTZAvJre/YFgNEmiPRbxTn6xwCqN6TfTQyFYj6243qKLVj6ennQX+kGDRXje5EUQ
8vJms3FsK5TVxBkhPZAy9tDvz0L6JcJv6MC0JlMHtpzYViVHQlxaXOclN28DI9Sr
QrA3qAKWqZ2iDDNw4Wl9EHk3o0AKiIFVa7kXtF1xvzYEo30CC8wRkOqCDBt3+uPJ
rG0kLNjGAvR3/dCqVsGr8LQv+ESEd8UA6OLctQAA5dFSGwvNEO8rGNvPZCUrEvK4
sTR3zlkjpu0t9n8sZ8LDV1VxElPGQ5Ol0Y1gk81GWLlihyKzp0U=
=Xtw0
-----END PGP SIGNATURE-----

--cZEu1l5gr4zjcpWQ--
