Received: from wfhigh3-smtp.messagingengine.com (wfhigh3-smtp.messagingengine.com [64.147.123.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 587A751016
	for <git@vger.kernel.org>; Thu, 23 May 2024 08:25:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716452745; cv=none; b=K53yI7+7mJmLQUwlxUyrcdbeYOtVOln9nTx9exYPemA2PSfEbpuCYvBOK5GeeFdLoGBqif/j3F3n1ZXDNUmMhidpsh/infu5/w42I/EaSi7d0tKHEQFmLI21i1CVmGTAYVfEtZjHkEUKVkGjYiZjflUAKVZpIQNbZXTeTymeAJE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716452745; c=relaxed/simple;
	bh=JMhinKITpfAso1qE6AzK0kFQBBxhzK7whFE4Hfx50+c=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=D8NxikHJ0xGunoVR7ZV6teWC6nloQnRAFld1EufQq1WrQZ12GeldhsGk/sjkkTAQyv8y3tCxd7ls5KrHgbKW2hhN7UhcEFT1VvZPFRIYlwRMEKfYC5EggkL2AatGlJkflzMAGDGo3/rLn7wX18jrEi4j+6IzCl1JQnZ8N9lCu2I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=EhwWgmt/; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=UJFNJcjS; arc=none smtp.client-ip=64.147.123.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="EhwWgmt/";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="UJFNJcjS"
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
	by mailfhigh.west.internal (Postfix) with ESMTP id CA39718000C3
	for <git@vger.kernel.org>; Thu, 23 May 2024 04:25:43 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Thu, 23 May 2024 04:25:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1716452743; x=1716539143; bh=kczGra99qO
	afax1s/n7jG8qZ2iuTcAXcgtyILbp2DXA=; b=EhwWgmt/TzlxRe8HApw6cnCbUQ
	YZJPS1R4mCwkPqaD5L8I7yGhmWoM9f24Cw5wYVequjUoco9vla2nJohfl89IPrws
	y64FlPi2HpMuFQ2bq0D3qy7/eqs667sCdUbHCJ460pEzvDF+zwwBxpB37EYD7dv5
	/IJIz/LIwZVxVreCLWRhfpbKm5Xobtmw1IJ9FziYNjP58Pq0lzoWX3Bcyff3lh5x
	8yNqOmtE+6pgBeSng0zDqTdx7ntNF5jBLfqusiMUXgDMYc9tRZqwGbOIhnCfBuvZ
	JawldIau9/SY9ME1hYfxUz5CwoCvmtRrk2EWAnpubImiMDZbCHbczkWphcWQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1716452743; x=1716539143; bh=kczGra99qOafax1s/n7jG8qZ2iuT
	cAXcgtyILbp2DXA=; b=UJFNJcjSMkCXKmpyzXKHeOUeNUJW4v/hYhRra5k9ckws
	okrS+ZqGwX5hfaafC3buHEqKODxl99hG1BejxhFHG4NVpJ68rCA6ckk9rm05CgwS
	ZipV51W62n8xTDsG2mxkKPzgCSfQA2n6ziPRuWernE54DW5sfPJyfYYyZBhuT1z9
	XU4MBwEA6QA96WiOzrxjfI1UxwIr2ftW3jqlaaCOXcH7nLQR2zXvuss7GAzwM8XG
	nTouHBQ9bPgYj4Z2hz3XgtQkRKF4oqMjTLy2J6MuoP51qpwBCQRpIarG+3GOd5+Q
	tTcvFJwuT27AuNSc4OeNz62F0/Zji+0DzFx02l7TYA==
X-ME-Sender: <xms:h_1OZpwcwTvHqGkMJkW9YG1tOtiwCwJ-b1zFLQc9zcKlEftxudY9mQ>
    <xme:h_1OZpRys-CYayO0UTJ7iJmYMc4J8zh2y7KxH0pwx_Mc-Fhdef8UtNMYBgg5loZwL
    xYUIyUf8R27X20Kqg>
X-ME-Received: <xmr:h_1OZjUZKdX-r07KK12chnSpWn4NL7gMyBI8sCn3Fev-JdkH8q7GcGUqsJrx32BBJgjSpgx8Hj9va71D1i3_elYDjYYOMY5vkjQOh1WQWeNRUUqA2g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdeiiedgtdefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvuffkfhggtggujgesghdtre
    ertddtvdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehp
    khhsrdhimheqnecuggftrfgrthhtvghrnhepheeghfdtfeeuffehkefgffduleffjedthf
    dvjeektdfhhedvlefgtefgvdettdfhnecuvehluhhsthgvrhfuihiivgeptdenucfrrghr
    rghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimh
X-ME-Proxy: <xmx:h_1OZrjF5Ca6fufJ-8fPaMc5Q1gBUn7C5q1lHWyN87B1EoWumxulHA>
    <xmx:h_1OZrBD7yrkhHxCl0Ia0WD18F_bL5Dh6yBAWCJY1GtLcd1RAHgGoA>
    <xmx:h_1OZkKO1sWjFkjhmwRewp2rNIJnNa0CnjrseI2-892VRTLTV2EYBg>
    <xmx:h_1OZqBvn9MtY0EjecwkiIHdQG-70TF57LBmu1hCa72XSI0v08a_Iw>
    <xmx:h_1OZg7QORGTR9r7SShspHzKks4KEERmbe8-XYYISBmgCA60rYFad3Tq>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Thu, 23 May 2024 04:25:42 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id 43ee5558 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Thu, 23 May 2024 08:25:37 +0000 (UTC)
Date: Thu, 23 May 2024 10:25:40 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Subject: [PATCH 6/9] refs/files: extract function to iterate through root refs
Message-ID: <6b696690ca263b1e91de430f0ee740728d90b356.1716451672.git.ps@pks.im>
References: <cover.1716451672.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="vN3bfifmGi9o/Yre"
Content-Disposition: inline
In-Reply-To: <cover.1716451672.git.ps@pks.im>


--vN3bfifmGi9o/Yre
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


--vN3bfifmGi9o/Yre
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmZO/YMACgkQVbJhu7ck
PpQ3/w//ZdCdoSomoKY7Yl7f3+QKSEEb+qsSfv0MMzGCpbFeYVsYSXpaKmdm60UK
k1TwQSP4FCvR4Tmt3qU9dL6N65angg/p3qlGznMrLBqk7Nf9RtU8HBGFu889+u5A
wapx3cDvI4axufvHx/nanyMyRLw8qfewS63jYcLWXuTrNcyVyzKv0je2fDNgFHfT
/lXzfdJPioHh54Kl1MTshonQFcP0lTDDs7ipDUaluS/FGcRL7Qj8l9NQ/G4AFxML
AJk9RcF9IzkzA8zq63L0leY1unBj2wxbene7x3A7LEJISvKrSwiT8wEg5K0c3po5
lOp3TuOtjMRhQfII67VvIP1u5jJS4wpAkM1l72wtztBLcUsaF5apyEp6cYBpeZkh
/0oEjHw/3wWxmfSIX9NZpKXdrunsjxOcNXpWqhBk4v034XJqbQvegHKFDOCWFNXw
A4NQcPxDL61CHhjOfV24iwjlU0ZjB+ZBCGn0yCu3zh6cQYuOQzKwX+6WzI9EQAr/
R1yJGkUEKu1i+bmF0tUsPpuhTozcjlWKlXlqfg63DYEkj+Mf5QOOukjyeWiCkluY
0dv0fpgH0xULl+VqlploVPd+uwHzXncGiZwyMqOhDrzFquIrs2w5VidUxm8jdWWy
dKZBG25QUOproLw97eVzLy4s6bWGePuNw4aTmS0Ltfly6MpnkAQ=
=ywzV
-----END PGP SIGNATURE-----

--vN3bfifmGi9o/Yre--
