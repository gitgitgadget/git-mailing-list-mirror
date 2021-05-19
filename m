Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 041DCC433B4
	for <git@archiver.kernel.org>; Wed, 19 May 2021 19:13:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E3D356135F
	for <git@archiver.kernel.org>; Wed, 19 May 2021 19:13:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231970AbhESTPC (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 19 May 2021 15:15:02 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:39831 "EHLO
        out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231889AbhESTO6 (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 19 May 2021 15:14:58 -0400
Received: from compute2.internal (compute2.nyi.internal [10.202.2.42])
        by mailout.nyi.internal (Postfix) with ESMTP id 072D95C0103
        for <git@vger.kernel.org>; Wed, 19 May 2021 15:13:38 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Wed, 19 May 2021 15:13:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=date
        :from:to:subject:message-id:references:mime-version:content-type
        :in-reply-to; s=fm1; bh=kri4+NReiWrG8mL6/s39X0QgR/ffmmdi2gzmlXUD
        dZQ=; b=cO7iK8ejSsatsW3orI0gXNXzQaHRcf6OuFoMaahOa3S5nAl7sDdZ18D7
        fIofmwcFpwl8z7/sS1RVjDCZu5QExanozx9wTje2btUW4Dr+MAnMkE6QL/bkIG2C
        x4qFK0taJrUiF403KfPD5NNHTyVw/MwN2iKPpMEHjchBOb3rsQgKb26oxC0ul5Jo
        wf4GhCN7rBhh5NTwUoD5OK3e6Eo/iqiKJmOcZqxwQ/b69+CM1dPiP8uk4E/Hs1xX
        ZSoyoJsrT/Pr83Cy8rZaDO8Wm6Q2B4m6GDTeE5QGQ+npCyu231KJehD17anHhaTd
        4QHBlGXWkw7nj83gy+qyVxDjXmGYDA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=kri4+N
        ReiWrG8mL6/s39X0QgR/ffmmdi2gzmlXUDdZQ=; b=J1VRxw0Gg1e02J1xIppeEY
        VmNCoH/75nb2snnxuJyDqUEfJyx2BE9OlLNh0NE/g91S2Xp45s2NiAA8tvDCOIwL
        Q5HfYZZMnEqtEOW/aPueJ4KfNMYA4n9k2382bj8KpFZ9qkpm++6q5M2de+zIcugU
        0PF6wBdJn3RYhNX1PX3sPQSU9nPNpPQ11aAlhPuTjNAVfmQHhCgb4AzTCX/qi57u
        g7ox9HgVdpPKMxLZFHid2S8RJq8h3Z1eLzUjupKYFTIx0jtvHVeQKb81Uwm2MJ4U
        ca6cwL53l3mLwkYcN5+jcy8wNddGX5Yv49LFJcEgBQkC4XrTtVChE6fD1TnyjDAA
        ==
X-ME-Sender: <xms:YWOlYCZfj3XaaT4fOv1N-O8L4XufF3OensAQaXF7F3UOCkTyeTVjnQ>
    <xme:YWOlYFbDhdCj_utEtsCs1zb5u8QKeWb6uGMkWOGeGMTykyO6mfsvYYVbhyqfpaWtN
    W-ytJ01KRwsGxcVcw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledrvdeiledgudefudcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecunecujfgurhepfffhvffukfhfgggtuggjsehgtd
    erredttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshes
    phhkshdrihhmqeenucggtffrrghtthgvrhhnpeehgefhtdefueffheekgfffudelffejtd
    fhvdejkedthfehvdelgfetgfdvtedthfenucfkphepjeejrddukeefrdefjedrudehieen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhm
X-ME-Proxy: <xmx:YWOlYM_HG5WKsTenoqhCTRAGOZ6iU_U893lII241QWOm46dBGSQrQw>
    <xmx:YWOlYEp5D2zKUqgOHwKbmgUFnCJ3YmEUL8osrBhjmwoRjpB8eYG7PQ>
    <xmx:YWOlYNrkCiKhn_HlikWwNMjwzhwiOnjjm2LQBih08sTcQkLIZFz6ow>
    <xmx:YmOlYK1IYhpU4GEAlO8H3E8HZ3xuNckyzrvttscYidsh0pp1dbdLsg>
Received: from vm-mail.pks.im (x4db7259c.dyn.telefonica.de [77.183.37.156])
        by mail.messagingengine.com (Postfix) with ESMTPA
        for <git@vger.kernel.org>; Wed, 19 May 2021 15:13:37 -0400 (EDT)
Received: from localhost (ncase [10.192.0.11])
        by vm-mail.pks.im (OpenSMTPD) with ESMTPSA id 42328069 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
        for <git@vger.kernel.org>;
        Wed, 19 May 2021 19:13:36 +0000 (UTC)
Date:   Wed, 19 May 2021 21:13:35 +0200
From:   Patrick Steinhardt <ps@pks.im>
To:     git@vger.kernel.org
Subject: [PATCH 4/8] packfile: have `for_each_file_in_pack_dir()` return
 error codes
Message-ID: <64a1bcf2c11d180542e06f67c451f9f90019dea4.1621451532.git.ps@pks.im>
References: <cover.1621451532.git.ps@pks.im>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="Iq9wOyVJiYCvjD9B"
Content-Disposition: inline
In-Reply-To: <cover.1621451532.git.ps@pks.im>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--Iq9wOyVJiYCvjD9B
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

The function `for_each_file_in_pack_dir()` doesn't ever return error
codes right now: any errors it hits are simply swallowed. A new user
we're about to add would like to know what's going on though such that
it can decide whether the call was successful or not.

Refactor the function to return an error code, and adapt the signature
of the callback function to also return an error code. This enables the
callback to abort iteration and have its error code passed through.
Existing callers are adapted to this change, but keep ignoring errors.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 midx.c     | 22 +++++++++++++---------
 packfile.c | 26 ++++++++++++++++----------
 packfile.h | 10 +++++-----
 3 files changed, 34 insertions(+), 24 deletions(-)

diff --git a/midx.c b/midx.c
index 21d6a05e88..f87a3d36ab 100644
--- a/midx.c
+++ b/midx.c
@@ -470,15 +470,15 @@ struct write_midx_context {
 	int preferred_pack_idx;
 };
=20
-static void add_pack_to_midx(const char *full_path, size_t full_path_len,
-			     const char *file_name, void *data)
+static int add_pack_to_midx(const char *full_path, size_t full_path_len,
+			    const char *file_name, void *data)
 {
 	struct write_midx_context *ctx =3D data;
=20
 	if (ends_with(file_name, ".idx")) {
 		display_progress(ctx->progress, ++ctx->pack_paths_checked);
 		if (ctx->m && midx_contains_pack(ctx->m, file_name))
-			return;
+			return 0;
=20
 		ALLOC_GROW(ctx->info, ctx->nr + 1, ctx->alloc);
=20
@@ -489,7 +489,7 @@ static void add_pack_to_midx(const char *full_path, siz=
e_t full_path_len,
 		if (!ctx->info[ctx->nr].p) {
 			warning(_("failed to add packfile '%s'"),
 				full_path);
-			return;
+			return 0;
 		}
=20
 		if (open_pack_index(ctx->info[ctx->nr].p)) {
@@ -497,7 +497,7 @@ static void add_pack_to_midx(const char *full_path, siz=
e_t full_path_len,
 				full_path);
 			close_pack(ctx->info[ctx->nr].p);
 			FREE_AND_NULL(ctx->info[ctx->nr].p);
-			return;
+			return 0;
 		}
=20
 		ctx->info[ctx->nr].pack_name =3D xstrdup(file_name);
@@ -505,6 +505,8 @@ static void add_pack_to_midx(const char *full_path, siz=
e_t full_path_len,
 		ctx->info[ctx->nr].expired =3D 0;
 		ctx->nr++;
 	}
+
+	return 0;
 }
=20
 struct pack_midx_entry {
@@ -1110,19 +1112,21 @@ struct clear_midx_data {
 	const char *ext;
 };
=20
-static void clear_midx_file_ext(const char *full_path, size_t full_path_le=
n,
-				const char *file_name, void *_data)
+static int clear_midx_file_ext(const char *full_path, size_t full_path_len,
+			const char *file_name, void *_data)
 {
 	struct clear_midx_data *data =3D _data;
=20
 	if (!(starts_with(file_name, "multi-pack-index-") &&
 	      ends_with(file_name, data->ext)))
-		return;
+		return 0;
 	if (data->keep && !strcmp(data->keep, file_name))
-		return;
+		return 0;
=20
 	if (unlink(full_path))
 		die_errno(_("failed to remove %s"), full_path);
+
+	return 0;
 }
=20
 static void clear_midx_files_ext(struct repository *r, const char *ext,
diff --git a/packfile.c b/packfile.c
index b79cbc8cd4..f488a214cf 100644
--- a/packfile.c
+++ b/packfile.c
@@ -792,14 +792,15 @@ static void report_pack_garbage(struct string_list *l=
ist)
 	report_helper(list, seen_bits, first, list->nr);
 }
=20
-void for_each_file_in_pack_dir(const char *objdir,
-			       each_file_in_pack_dir_fn fn,
-			       void *data)
+int for_each_file_in_pack_dir(const char *objdir,
+			      each_file_in_pack_dir_fn fn,
+			      void *data)
 {
 	struct strbuf path =3D STRBUF_INIT;
 	size_t dirnamelen;
 	DIR *dir;
 	struct dirent *de;
+	int ret =3D 0;
=20
 	strbuf_addstr(&path, objdir);
 	strbuf_addstr(&path, "/pack");
@@ -809,7 +810,7 @@ void for_each_file_in_pack_dir(const char *objdir,
 			error_errno("unable to open object pack directory: %s",
 				    path.buf);
 		strbuf_release(&path);
-		return;
+		return -1;
 	}
 	strbuf_addch(&path, '/');
 	dirnamelen =3D path.len;
@@ -820,11 +821,14 @@ void for_each_file_in_pack_dir(const char *objdir,
 		strbuf_setlen(&path, dirnamelen);
 		strbuf_addstr(&path, de->d_name);
=20
-		fn(path.buf, path.len, de->d_name, data);
+		ret =3D fn(path.buf, path.len, de->d_name, data);
+		if (ret)
+			break;
 	}
=20
 	closedir(dir);
 	strbuf_release(&path);
+	return ret;
 }
=20
 struct prepare_pack_data {
@@ -834,8 +838,8 @@ struct prepare_pack_data {
 	struct multi_pack_index *m;
 };
=20
-static void prepare_pack(const char *full_name, size_t full_name_len,
-			 const char *file_name, void *_data)
+static int prepare_pack(const char *full_name, size_t full_name_len,
+			const char *file_name, void *_data)
 {
 	struct prepare_pack_data *data =3D (struct prepare_pack_data *)_data;
 	struct packed_git *p;
@@ -858,13 +862,13 @@ static void prepare_pack(const char *full_name, size_=
t full_name_len,
 	}
=20
 	if (!report_garbage)
-		return;
+		return 0;
=20
 	if (!strcmp(file_name, "multi-pack-index"))
-		return;
+		return 0;
 	if (starts_with(file_name, "multi-pack-index") &&
 	    ends_with(file_name, ".rev"))
-		return;
+		return 0;
 	if (ends_with(file_name, ".idx") ||
 	    ends_with(file_name, ".rev") ||
 	    ends_with(file_name, ".pack") ||
@@ -874,6 +878,8 @@ static void prepare_pack(const char *full_name, size_t =
full_name_len,
 		string_list_append(data->garbage, full_name);
 	else
 		report_garbage(PACKDIR_FILE_GARBAGE, full_name);
+
+	return 0;
 }
=20
 static void prepare_packed_git_one(struct repository *r, char *objdir, int=
 local)
diff --git a/packfile.h b/packfile.h
index 3ae117a8ae..eac930cd27 100644
--- a/packfile.h
+++ b/packfile.h
@@ -39,11 +39,11 @@ const char *pack_basename(struct packed_git *p);
=20
 struct packed_git *parse_pack_index(unsigned char *sha1, const char *idx_p=
ath);
=20
-typedef void each_file_in_pack_dir_fn(const char *full_path, size_t full_p=
ath_len,
-				      const char *file_pach, void *data);
-void for_each_file_in_pack_dir(const char *objdir,
-			       each_file_in_pack_dir_fn fn,
-			       void *data);
+typedef int each_file_in_pack_dir_fn(const char *full_path, size_t full_pa=
th_len,
+				     const char *file_pach, void *data);
+int for_each_file_in_pack_dir(const char *objdir,
+			      each_file_in_pack_dir_fn fn,
+			      void *data);
=20
 /* A hook to report invalid files in pack directory */
 #define PACKDIR_FILE_PACK 1
--=20
2.31.1


--Iq9wOyVJiYCvjD9B
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmClY14ACgkQVbJhu7ck
PpT5GA/+JUcYCvU0UsJluxTzMjwgDLjue9dpOqVVZt30MQIbKPsXR12zYJ/Fhd+g
aFLeMpimdaC11ENV4t86NjDXif2klTXYlQQxXY/72Rzjpjyd6XuFLQfOdUKlrAh3
uwEPs80fths+XkYmfGBzDC1Gmmbw0vZr+y3og9/MhdodnzguNlpaAU2pGChuRGXT
iTQZQGVfR7I2mUbu4DaC9ZEQDucKCI+aUvbKBdmORGI+n+Wq9FWZksuVlYhJDSCN
pQoqLq1Kb7w4ajiKBMj4hNK56JY3LBSYFbRuDijtZ9Rf2h/X33Wx9cEQeS1H9GnW
QN4WMiX0diitZwiLib/TOt/e3LAPEE7Km8NkQA7dhZgejd92CFBWvHOdCUBJE1ng
3MiUeNSYCqezU39zKlOMt/5ti0P/BiCLxqEb5i8SOdx1ytuPy56OhuKWDrslU3zt
fvhKA76ZfvraXhLyyNFUQLNxySgFjWd4uAeSRwotkFVDNBmfIi9BulgVVs/qYsK3
cJQzWkwLuHMfzRQIrGC2S+08FWx9vp2u96LT/WCLDJYgccuLt14uVEcoZzYOar++
Ci/+1IBuELjlIjkFa5DCZQvy/WunaFeaF7DBnQn85tYLXVvSq3YsxgdEsRFgpDSj
HnF8G0lxG5DUPG3HR9DwS/iBFYgVa2kdPircTRz4Vd3wgcWtBGs=
=CS+N
-----END PGP SIGNATURE-----

--Iq9wOyVJiYCvjD9B--
