Received: from wfhigh7-smtp.messagingengine.com (wfhigh7-smtp.messagingengine.com [64.147.123.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEB7C84D10
	for <git@vger.kernel.org>; Mon,  3 Jun 2024 09:30:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717407042; cv=none; b=o97cM6cyHrzT+1rXtoYm/t00sKAjy1GV+weVBd/Xss/OqTrkvnYoOyl8Yppo3aS+r+ql82MxgJLYvy8HrPNrmWfTjjumi46TocvFv5xeo/72G9k3YqikAG9LQSTSvMhF1LRzVP9tMm7iWW9Bw59S9y/Itzq/SiH9wznNH/niy8E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717407042; c=relaxed/simple;
	bh=ttfpemtdJF5Kpy1D5pmGgOveD03rp8aCWzPk9ZaTeG4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=a6bSmsAbHZTsZQ/e1nA//YD0/mbmgWXEIc+bVV+/Nd7xVg0ZelutzBufyh/ut8nGR/R2/yRxKHbq/n8y1P4keNCPI8S9jo18rwtlR/ULndXeaTV29BcSAf0RrzYsQsX8oHaoiB7zjxRs0KMJLuH87XzGpf/FvoRPebyKBM7eCaQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=mfE7nA+5; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=M3ZV3UsY; arc=none smtp.client-ip=64.147.123.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="mfE7nA+5";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="M3ZV3UsY"
Received: from compute7.internal (compute7.nyi.internal [10.202.2.48])
	by mailfhigh.west.internal (Postfix) with ESMTP id AB0941800070;
	Mon,  3 Jun 2024 05:30:39 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute7.internal (MEProxy); Mon, 03 Jun 2024 05:30:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1717407039; x=1717493439; bh=x6HOnY1sK9
	+d1JgjEivzGthjmRq96ucMcbz4YNqqSIM=; b=mfE7nA+5jhJzSHbEOdg5mBoNeq
	IToNOkhBbWmYQ/UyPMWg7zBVHOHqbIqpZxTcMp+83flwcszHaMc7tlXQWHCr4nWD
	1kx1/P57lNfe2M9JGgY6q/6nTyQWrmpqLc3dR9nWZL2lUXRMQT5e7iqfVLe7YMzT
	TwNhR9pFar+a/LdU94BtJtt84hCwe0bMzJkC4i73T7W2Qr2rHoYVAbGWLP1LJqc+
	4rPdLa+x/u6ImqQam7MYPDPZjNm0pSSR0rVuXzFXlx6QXuHoaiJzWHd34hePT8Zy
	HehB3RfmAN+oSZ1NvqlMKanlfbK9W7CHi34pVoXG9ESCUcN8+0hFGW+l1QDw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1717407039; x=1717493439; bh=x6HOnY1sK9+d1JgjEivzGthjmRq9
	6ucMcbz4YNqqSIM=; b=M3ZV3UsY0Bc1zUr/0xyu2JdlG6Buc0DfSfy/X3Y+DKIq
	wvAuwmHxyunh+den28lycX6lTFpwufBP8lE1dfzIBGe+ki/7yQMHfhuHYGnB9TB/
	c4u35ouNvoYoshOYj4zvljBIIxZjcU1DR/t+6WOT/u3YZxKTBkul24iOI5grrj3e
	zB1eY87rcKFy1vQ00P6Ofj10iTzxm4KJnctjii/sKDL3GlHIk+Kge2YHjdD4BTYH
	QF8S4UHVndXkNy7fi9ghzwwofY1zfBhsC9uEX/YPhbVlka68nPfiVIL1YoOb6rY2
	+91e4szhZUI7oSDSBVZ7DP+tSEcrDTjewyUn74wsXw==
X-ME-Sender: <xms:P41dZuES66bn_UcvhuYhDwLTh7DjnxAF1bUn6seFCxwRAM166tKr-w>
    <xme:P41dZvVLbxLyw4QQXu12VCgUSNEJEX0GFsJTnw5yKu7hfbgBJOqxQtRmuBf3lEzvo
    7ds2qNdsWsJwix8sg>
X-ME-Received: <xmr:P41dZoLN3UoV5-BLXcQUKQ23GDyPGy7Oao-9iTwvLZBzktXHdcyC6KrR3QJOG_ilYayW8DfWuWv5dEC9AxsKxShtL4o1oEQacaQrllMHbDimcdvF>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdelvddgudejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepueektdevtdffveeljeetgfehheeigeekleduvdeffeeghefgledttdehjeelffet
    necuvehluhhsthgvrhfuihiivgepfeenucfrrghrrghmpehmrghilhhfrhhomhepphhsse
    hpkhhsrdhimh
X-ME-Proxy: <xmx:P41dZoG4zpvZs8Jz9TGQ7rk70hp5PvFT0ZznL_4J_nWEhInhheD8Rg>
    <xmx:P41dZkU5-EGYAG10WAaO10fEoFf7yy83LfuedJJWOcdSl0KOifzoOA>
    <xmx:P41dZrP8pjyyuGB50v_7-ymbIBhvUHzUI5VPHnwERG1euSDacq3Vqg>
    <xmx:P41dZr37w3sw8oqMvfokLX-fbw1kKu5rLfAeHf0vNnof8Sietxm8uA>
    <xmx:P41dZueRSVaJpkAWm4CEOpqdXzWpCCe0xVhW3vQmUXPhw_YSFE9zwZAU>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 3 Jun 2024 05:30:38 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id aef4185d (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 3 Jun 2024 09:30:13 +0000 (UTC)
Date: Mon, 3 Jun 2024 11:30:35 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	Junio C Hamano <gitster@pobox.com>,
	Ramsay Jones <ramsay@ramsayjones.plus.com>,
	Justin Tobler <jltobler@gmail.com>
Subject: [PATCH v4 06/12] refs/files: extract function to iterate through
 root refs
Message-ID: <f7577a0ab37988476cdb83e310f96f4841c9364a.1717402363.git.ps@pks.im>
References: <cover.1716451672.git.ps@pks.im>
 <cover.1717402363.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="IKjZvP4dzJD4OmyT"
Content-Disposition: inline
In-Reply-To: <cover.1717402363.git.ps@pks.im>


--IKjZvP4dzJD4OmyT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Extract a new function that can be used to iterate through all root refs
known to the "files" backend. This will be used in the next commit,
where we start to teach ref backends to remove themselves.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 refs/files-backend.c | 49 ++++++++++++++++++++++++++++++++++++--------
 1 file changed, 40 insertions(+), 9 deletions(-)

diff --git a/refs/files-backend.c b/refs/files-backend.c
index b4e5437ffe..b7268b26c8 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -323,17 +323,15 @@ static void loose_fill_ref_dir(struct ref_store *ref_=
store,
 	add_per_worktree_entries_to_dir(dir, dirname);
 }
=20
-/*
- * Add root refs to the ref dir by parsing the directory for any files whi=
ch
- * follow the root ref syntax.
- */
-static void add_root_refs(struct files_ref_store *refs,
-			  struct ref_dir *dir)
+static int for_each_root_ref(struct files_ref_store *refs,
+			     int (*cb)(const char *refname, void *cb_data),
+			     void *cb_data)
 {
 	struct strbuf path =3D STRBUF_INIT, refname =3D STRBUF_INIT;
 	const char *dirname =3D refs->loose->root->name;
 	struct dirent *de;
 	size_t dirnamelen;
+	int ret;
 	DIR *d;
=20
 	files_ref_path(refs, &path, dirname);
@@ -341,7 +339,7 @@ static void add_root_refs(struct files_ref_store *refs,
 	d =3D opendir(path.buf);
 	if (!d) {
 		strbuf_release(&path);
-		return;
+		return -1;
 	}
=20
 	strbuf_addstr(&refname, dirname);
@@ -357,14 +355,47 @@ static void add_root_refs(struct files_ref_store *ref=
s,
 		strbuf_addstr(&refname, de->d_name);
=20
 		dtype =3D get_dtype(de, &path, 1);
-		if (dtype =3D=3D DT_REG && is_root_ref(de->d_name))
-			loose_fill_ref_dir_regular_file(refs, refname.buf, dir);
+		if (dtype =3D=3D DT_REG && is_root_ref(de->d_name)) {
+			ret =3D cb(refname.buf, cb_data);
+			if (ret)
+				goto done;
+		}
=20
 		strbuf_setlen(&refname, dirnamelen);
 	}
+
+done:
 	strbuf_release(&refname);
 	strbuf_release(&path);
 	closedir(d);
+	return ret;
+}
+
+struct fill_root_ref_data {
+	struct files_ref_store *refs;
+	struct ref_dir *dir;
+};
+
+static int fill_root_ref(const char *refname, void *cb_data)
+{
+	struct fill_root_ref_data *data =3D cb_data;
+	loose_fill_ref_dir_regular_file(data->refs, refname, data->dir);
+	return 0;
+}
+
+/*
+ * Add root refs to the ref dir by parsing the directory for any files whi=
ch
+ * follow the root ref syntax.
+ */
+static void add_root_refs(struct files_ref_store *refs,
+			  struct ref_dir *dir)
+{
+	struct fill_root_ref_data data =3D {
+		.refs =3D refs,
+		.dir =3D dir,
+	};
+
+	for_each_root_ref(refs, fill_root_ref, &data);
 }
=20
 static struct ref_cache *get_loose_ref_cache(struct files_ref_store *refs,
--=20
2.45.1.410.g58bac47f8e.dirty


--IKjZvP4dzJD4OmyT
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmZdjToACgkQVbJhu7ck
PpTmchAArMdsUVDlwWyrSD4wtvJRnSvZu4kk69SNop8akwp8E6yVtyJrbS94+Fb/
XQ+i2qA3zq+7SZMyuTlWQA8YiqRZW5TDBX7IxmvwwTSN1o0jaKCP28VaoxbV/MxU
8+boBKhKsaa5Zy0fziETTumainWSjt8HnjBZA9SGgAcfkEULlkqya3Eun7zAbzc0
6cOE3ZkDPexYWs6sYx1gG7ay3VRq2P+MVxcsZ65ZV2wJUlaIXFfQ8DGbS/dJ9C0R
vVT6l5R0T8nsMK2riWin7ruS/ZgNPLT3ji89JvCjqfw8e0VrhW+d1dHT+4/y//H0
PZ13peIqXFW+iwTP2Jd0Cr+VtdaB2hV+j2Nt54S/4t95eDAQzLHdVCD9mDMTjTho
HDhagFPJMFFT7mOvdN4WOOAgF9xc42CzgCfM3/Sh16/JEG87OsoO/L5YokBui+nW
ZRLgkQdAzyr3dKDuDlRDL3yxWtrCdxH+7YggnRxXg0HpmOCcVvnh1hljjpWTd3Ff
uywH9DYGbFETL5EAHynWXMYDpyvN6gmQ7Zf+BCXndV335qEeoPwqLc2fqAq1SG09
Scz3regXodUQOVtQsF0qO7Rbegixve2QDWYPo7zZCuYluZItsjLKwQbQkwL983hk
mkV0Dj2m6n+/tRRoZnbumIhs0/34dqtEhzGfB/cc0/MW2RQ1DeA=
=dtoH
-----END PGP SIGNATURE-----

--IKjZvP4dzJD4OmyT--
