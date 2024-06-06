Received: from wfout6-smtp.messagingengine.com (wfout6-smtp.messagingengine.com [64.147.123.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB9681EB3E
	for <git@vger.kernel.org>; Thu,  6 Jun 2024 05:29:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717651768; cv=none; b=cMgUd5tD7pDlRybJo5c2S6rPSdkAMCTl4W5wT4yCn8Utuvbszrwh7VlhBQElkfF26KV3Zg8EforxqNUyXdSAP0QLFkcPuWDVu/YRIMK/9/agFKDrbw50sNdtzLTg1c718Ck2FsydEO4vhwend3ngHSWZpTWCGmcsr+O82Z4Q9SE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717651768; c=relaxed/simple;
	bh=KIEow5x8ANkf91C51IUkchPizzQarlOpQ8kcOeN1XpE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dXzIKgRZ3Hq91aB7+Kue43fazHQtVas51k4buZtr4BChEBiiCRN4OMoOLeIRfprPupN3Lr6Dp0fPnpIbB3svrXy+X9p9nhUzRxEAtC0LCFHo4OtWikNAVu8vYV9WhsQxbiHSFa23HQTMojjW6mI/TuKP0ByiZ4wmkidCeU1+hS0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=V1REwk4i; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=fH7VtIP3; arc=none smtp.client-ip=64.147.123.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="V1REwk4i";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="fH7VtIP3"
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailfout.west.internal (Postfix) with ESMTP id 9A3CC1C001D3;
	Thu,  6 Jun 2024 01:29:25 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Thu, 06 Jun 2024 01:29:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1717651765; x=1717738165; bh=WQJP1pnefI
	aouRU8eOongE19YDHwuzNv0UWTEwiZDgk=; b=V1REwk4iowKxpqLm0ql+dHdSkB
	h4sp75g8iicCCBZfwS5WmgYc8WcC4t4TABKO9CBg9XHD0AHSiE5B9TgnnuC8tx4M
	Lpayb+20YZkIEIel/OBtXyToEFNOTO3x5IUbZ3/stbxqhrFQmEfqmP8UFjDd+dHB
	1SrNlDl8907pmrSI2rXIz48aJ8ZSq6K6gvjVLioTs4zC36XdP/xTXcm/4sUPB0Tx
	x/GNXT5m7Ar6cve/cBDKpwab46OJ20JTaEf8Ktwf+DzUVNRslPZMnisMI18ofZLf
	KSzyakXKFXho4J/A0HRTOiquZIrWhXVssad/gUUCSxXWbtybjGPKjY7SjMyQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1717651765; x=1717738165; bh=WQJP1pnefIaouRU8eOongE19YDHw
	uzNv0UWTEwiZDgk=; b=fH7VtIP3kWr0dPl1eIA9AI5vHSvQYS08v3W8uavMVEm/
	yGR96icOAv2gbMMUvSUuwaRT00nJDe/Wd3rqgGQ72zmNiYa+RSRo58+IoTHUvWzl
	aSrgAct5j8+VbjUtxxZy5EhbqPtwX44mXMv/WZDOxpKPu9Phf5VumNijMmDBwEix
	FtURXsrqc3zMCVHMAxMH25Z/+hAW30gzMZVvwQNYHD31k2iFjcVziv9DNvh6eyH/
	9qgvvSrE3soZ9JiXobue2n7VchVpFgbmJqqU0nRhvNU3fjullDw69pRx6ArEBvyu
	e2KNZzubvm+RHRNAElRX/Iwvq8iUuUZhjSSxTZkLYw==
X-ME-Sender: <xms:NUlhZjPY9HB5FOt6ijrYQhr5UO193abiFTa0kwIfUTxNA7zr4WIlTA>
    <xme:NUlhZt_7d-Nj5oz7AJQLSZCYnTttLBf6bpB50g8aqyhFHLEVuGkny6KbZCIB4kWP7
    uRuizcBY5-FB64Rgg>
X-ME-Received: <xmr:NUlhZiTwVDEO2QqlBONTbYmK2msYDNXBa5-0KKzfzm0UW2X41jO-a-pNoCpWAeWj7PkRyVhrfQ2g7JRmxfEMDTnpqQFn1c2_CGt6eoZiM7H2FT6E>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdeljedgleeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepueektdevtdffveeljeetgfehheeigeekleduvdeffeeghefgledttdehjeelffet
    necuvehluhhsthgvrhfuihiivgepudenucfrrghrrghmpehmrghilhhfrhhomhepphhsse
    hpkhhsrdhimh
X-ME-Proxy: <xmx:NUlhZnsD_i5x5NY0ut-_5qW8PG27X16-xFzw-rrYqRWNuahqxCmJBg>
    <xmx:NUlhZrfB71Swh6YykKaBcVxOh46rasawPhtOPLDEwDMN1U0XtPtsGA>
    <xmx:NUlhZj2Buln72MbzOIhFPt28FQPqc3DhKxx7-WzGJYqioo1Hi2ib9w>
    <xmx:NUlhZn9mX0GDceSSqkLSHCxlstAeUFNLoz5B8U6gRwU4prhJbolPTQ>
    <xmx:NUlhZts75GQUg28g3gKC2SJbHX8oL3aNoNl8jkQWPwb4qeNFIFp3k0CR>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 6 Jun 2024 01:29:23 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id c501f3c2 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 6 Jun 2024 05:28:53 +0000 (UTC)
Date: Thu, 6 Jun 2024 07:29:20 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	Junio C Hamano <gitster@pobox.com>,
	Ramsay Jones <ramsay@ramsayjones.plus.com>,
	Justin Tobler <jltobler@gmail.com>,
	Karthik Nayak <karthik.188@gmail.com>, Jeff King <peff@peff.net>
Subject: [PATCH v5 06/12] refs/files: extract function to iterate through
 root refs
Message-ID: <86cf0c84b121f23e7cbc3ba96299d9264123b485.1717649802.git.ps@pks.im>
References: <cover.1716451672.git.ps@pks.im>
 <cover.1717649802.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="clW9gKAcxbEeunV0"
Content-Disposition: inline
In-Reply-To: <cover.1717649802.git.ps@pks.im>


--clW9gKAcxbEeunV0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Extract a new function that can be used to iterate through all root refs
known to the "files" backend. This will be used in the next commit,
where we start to teach ref backends to remove themselves.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 refs/files-backend.c | 51 ++++++++++++++++++++++++++++++++++++--------
 1 file changed, 42 insertions(+), 9 deletions(-)

diff --git a/refs/files-backend.c b/refs/files-backend.c
index b4e5437ffe..de8cc83174 100644
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
@@ -357,14 +355,49 @@ static void add_root_refs(struct files_ref_store *ref=
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
+	ret =3D 0;
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
2.45.2.409.g7b0defb391.dirty


--clW9gKAcxbEeunV0
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmZhSS8ACgkQVbJhu7ck
PpSzuA/9FhXveFb0D0aSuLF6NnTCFinOOozVJ3BW1lafvELE3Q/R5/a105yl8R7V
/VFlK+vvb2qFEksbc29zSFSYRLcUQGXDmLeaDGdf+CTbL44JKtIvq8TL/rvXPltp
Mq0Gx0hn96ktKoR9EksjLDZpjHOM7pl106gYaInXYBRx4f+GRbUV+Ks61fb4PKig
C8RYkZMcueIPADwNlNxlOOwAC3wHIsKwJ/4Nsjbj9zCP+3excbKhDKGwXYNTK6WZ
dKh8U4vQEOjwjlwhQFNHIDTYoKkychHbjjwDViPKQWGRar4LQQaUEarRE4lwJc2n
Xer1LvEQvb1ZUwqC1xeZBk0vjngkgS5w/cJjRKcqpLA2vHgmWSxNkvxjNd7+0C15
j4uBKw0ifw5gEXE2PcwHIvIMtWUGNZfKIScGqQTX2G5KADj8IMEyig5aATMMLthL
IyUncQq9asRNf9TbaUCsgt1o+xEmNZ+0a7PAI+0JWU8og/AUtcbWT18uhvSNhFlX
6DDarByHQeC3cVNDZWjsc3kGhLPHu8Bpmi1LhwDiYFfdyp3p/KNb7+vELhvEVn9q
oR5jX6l+jpbPh+7qXCqbv50JFtj+PvaxSOSBHcyfoS7RVs1n9GtLxWOsGLOkfFm5
sh2axza1AF08Y1G6rmxYQ/I6PSqwwfRiyAQ9nLThBXOT1kG/VOk=
=g8en
-----END PGP SIGNATURE-----

--clW9gKAcxbEeunV0--
