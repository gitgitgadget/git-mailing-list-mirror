Received: from fhigh2-smtp.messagingengine.com (fhigh2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3491685C44
	for <git@vger.kernel.org>; Fri, 24 May 2024 10:15:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716545702; cv=none; b=Huo74jxBkD1N2hC0c4SqlU8aZcMI2Fs1fX0ZqmiOJR/MHrJp4NRCxd7gUHhj8x/D4cqbMITkVh1CCLtBm0i3OjtSmGh6pCi9YesBa/MxTJofmeXalWT/QFOI1tKMqDlTPc+nvZmNXpXFVQpOlNHhEgqwHUuPuq0BSBG+s88IwGg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716545702; c=relaxed/simple;
	bh=AexhNgyUFV/yKEosPlpOpfS9slBZ33mqWWY4P5gsF38=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ke7yY9Y2GzWS+chEJRjo12FyjUL+N1Hm4Z3GyN3vC7PUJv3tmzCoMyRx5aH+wzY63FifOOzapD5LJR9AEMUdNnyVS/DEQVkqdpcoQ/8U7vGxpnlZ/MgRoAN8E0KLXDldNef/UK2bwIsi/H4sXyzvSlad8yTnkjfp8lvtQYKisG4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=HvELSang; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=YfyIbzyk; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="HvELSang";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="YfyIbzyk"
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id 8971611401A9;
	Fri, 24 May 2024 06:15:00 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Fri, 24 May 2024 06:15:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1716545700; x=1716632100; bh=G/C+LQby/y
	axCHv8AEyLoTok+6w1WGr3bbgDUydAgoc=; b=HvELSangXD2V//t4Uu0h8oayMj
	lsxkycnqxEzPYgCU6tJaQgZ9R7AFz0fvWgTXCoHpApc2j82gn2qTeMASiz/0P1yt
	rW/7g/oTCxMTOrqN4Ga/D46w76zsgrGIN8MbpE5UPIVHzGGd5Kc9Lja00G9AUA8z
	BoWuI3/HaGGJAKYQtcPSWN0RKMuaH4IvR+tz0bNqKKyyOKoKQBGWeqBzvYjBvQ5D
	IuIRcbvKuMH/iwMXD1QLJyazJKynZrwmiQKiYaCs1ceAztZviVPOfJMYFBZRksAs
	ageAV6cslTP/uWu4ltJwBFeSm+iyRhMh51usfr8Kf5RnQukP776ecMWqmbUg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1716545700; x=1716632100; bh=G/C+LQby/yaxCHv8AEyLoTok+6w1
	WGr3bbgDUydAgoc=; b=YfyIbzyk7UntffwWwXWoHPiODCJS2oWak0Nj1FvrA3qd
	7C5AF4ecnMV/etV7U0brPqFTJVWoyYwG2nH2duQFFEg6sxL02gZtucnugvBObffz
	8+dHpPT7H+0NSs6mJrr01I2AOqOlI1ouvkoimzsrhCwIOrrS5TcV59Db92cnA+Jt
	2MnsJ2ZAvcV92MG6Pdgvfs0BKwMV6qnBWlIaqru/eCKHZC2MQ0fQg38nPbSgysTq
	eGlmGWvl7OJIt18g6spCH75TbhXlC9fMMTYtYSDFioTfdh3hZG1YNJS4sEcw6tmm
	em/DID4iDTE/X1kj+xwN1V32M8NoYmO0cgAPSQxGyg==
X-ME-Sender: <xms:pGhQZowp_vdfnAf8wSjra2YMPrBPfCAfVf4rxAqSNyom6gvDUA9Jog>
    <xme:pGhQZsSUke2paHXXkS_ggQCE2aUjE0BHiwnKSM7iQmSDKbHC5r3VPw2e02eyTWk5f
    BzglXYRn5cq3Q_MDA>
X-ME-Received: <xmr:pGhQZqXHtAaiAFAx_XeMkWyJmn0jTZBoypym-u_ByrHF7iHEiIYmvPIbW8zaPWdGKhpYj5zrruvdvA1fPf2Odwym8JKGXBEOzOJ5pWBLLYQPlvM>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdeikedgvdefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepueektdevtdffveeljeetgfehheeigeekleduvdeffeeghefgledttdehjeelffet
    necuvehluhhsthgvrhfuihiivgepvdenucfrrghrrghmpehmrghilhhfrhhomhepphhsse
    hpkhhsrdhimh
X-ME-Proxy: <xmx:pGhQZmirVq3Oxsh6x1JXIvfMvEnmGDv1sqmxD7Fhq7e06ZTVPhEsIQ>
    <xmx:pGhQZqAvChwizM0rhMrv7WcdlirDiFkkbrmZUwAMYPCWFErf-_SSaA>
    <xmx:pGhQZnKjhj8_7ySBfZP7BGOyBCEqmNJ07nWskDL1P9alI4B8k4T_6A>
    <xmx:pGhQZhCV4f4A0NAfKm4NDXgOGk6S4Ld63vHkIv5l_XhyUv5lq0Yszg>
    <xmx:pGhQZlNFASPYqffFZR3U37fV-oRUD1l1-Q3H-w89NASjVCfwzRUxRai9>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 24 May 2024 06:14:59 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id bb63380e (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 24 May 2024 10:14:56 +0000 (UTC)
Date: Fri, 24 May 2024 12:14:57 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 6/9] refs/files: extract function to iterate through root
 refs
Message-ID: <6b696690ca263b1e91de430f0ee740728d90b356.1716545235.git.ps@pks.im>
References: <cover.1716451672.git.ps@pks.im>
 <cover.1716545235.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="a1dWvh7iHwpJOzQm"
Content-Disposition: inline
In-Reply-To: <cover.1716545235.git.ps@pks.im>


--a1dWvh7iHwpJOzQm
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
2.45.1.216.g4365c6fcf9.dirty


--a1dWvh7iHwpJOzQm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmZQaKAACgkQVbJhu7ck
PpQYRw/9G8FK8cXtCtm8c4aUCTApSurbuSZwh63TSw+wGPYkvebKSvwVO4CRasg3
Qy6w0EIw83aLxBxqSWJCiPNNzstKDbhZiMGSFpLiWle44Dld+fIjqm4WhRbkAxek
QoNO5UEwsR6gZhSr0DsGe+QPAFz+CXgWOyjJPwuh/mTAaSZ9qLlMn/riguzgP2Fz
vWqCz8uB5PRWAUg3owT1SZmYl8a/P43s51raOsQCmMpk7KjVtTXqt3vZgNzQgDL1
paCmd5kAhakebr+oExSrj9lKZAJm45S4LP4iClmFthAGzxVH4mH8cFm98350f+7f
guKVnxBny5EBkUS5Xvh2PSYryNHVgPMslLBVdhJLceLocv2BOLxGcw8lHAWXKvZI
ibI0bExFUqyb1j2lyFpaDa+VOWfa8ucVdMeqtex7HVKxkSR9/5nGSv4IHBpwNG2C
yz6studYdVJoW2and4zkvKdAllK+cKG5IvFkINd8TW54WcL20WUSbsFHPxdGWG6z
J7NSc3gCGTCFQ4EVCGlRUWxln6qw9GMUvb1kOHyp6kqUG2qfQ59s0PZpklElDdda
jPdaVIdP2a0jxKt59XkuMGS28Fz/OG6y8ujbuJBt3APE/5PDYTj8VsVFX2tJ3bgO
1RaDdjWwJF+DJg7k5irmN12lJkXNbFkFPeRxl3cu0SuW9+/l4kQ=
=uqSI
-----END PGP SIGNATURE-----

--a1dWvh7iHwpJOzQm--
