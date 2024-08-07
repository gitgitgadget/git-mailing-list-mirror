Received: from fout4-smtp.messagingengine.com (fout4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F23DF1B1428
	for <git@vger.kernel.org>; Wed,  7 Aug 2024 06:56:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723013818; cv=none; b=j8IyXtgqZ0XoMCBBIF8il/mCpgCTo08jXn0Zw/Q7OQathbPVadacsrY7alL0SZeQ8k+/TDlDHkxOvJTD13XhDM4guSnwIz8tUdgP4+wG5n9fcSEPBML+UgfYDV9UorhQNvUcvpIIv/fCA/rHl8AodLqVvMPajpb2TClgaazj710=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723013818; c=relaxed/simple;
	bh=DJ/o3ltrq2xqIgs3blzbhAqeUBGVtq+AEBg8Yxy1uDU=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=p7csWX6JLdgzLNE4Zc6dpM8RS3aOBeTqDpb9G9bp8Gcbder7gFjFe9DTW3IuBEVttyLpwwvbBBTFt2srvVTZCLEs7n/bbd1AdSqx49bd6z72d6Qh07wSs7GotBbKNHMkULOFDOYbNGW5GZnBhfzpAsAXHqIYMWCVW9mXEPp/Mac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=otGtEv92; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=LwJsCFqa; arc=none smtp.client-ip=103.168.172.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="otGtEv92";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="LwJsCFqa"
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailfout.nyi.internal (Postfix) with ESMTP id 28AF3138FC5F
	for <git@vger.kernel.org>; Wed,  7 Aug 2024 02:56:55 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Wed, 07 Aug 2024 02:56:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1723013815; x=1723100215; bh=UQz2rZMzI/
	FunerOge2k+jn1V4DadtL9PoGE/sysOro=; b=otGtEv923KJAY7kPa5v1dy4uVb
	vIQ3jDYWl2gm5r/UD6LpHmVtshDh5R9W+V5kLHMcuA0FN65k4l5MlngwQLRtr/YK
	aY3215+jmSDVlNu43XspBkAmB3waE4vA7LKhGQ3V4yhPw+mZUi7pD9NgO8g66bHj
	KNBUGeRM59qJMPTmkiyWDUg7NlHX5MAFba4gsA6OzQ73zh52+eH+6wdWYAclrPwZ
	skrrapUDTJU8HXPrDj0Q8Ph1MU5WJN5y5MFiLSahIuLsMTjo8Dj0Q3BQzXD1aUut
	kdHjCJE9nlylolNg1sBt57W3MQOSqsPp07NI95laUhR3oio0bq3Z+lDnG1oQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1723013815; x=1723100215; bh=UQz2rZMzI/FunerOge2k+jn1V4Da
	dtL9PoGE/sysOro=; b=LwJsCFqazv1LOcatAIitvLiAfAMVvNviYNX5hNCC87VR
	5eLNIEplnr5Ri/AL7gnsojfywgSS+F7UhsqCcG4szAJn3pxyd+NCtH0Wyl2A+vig
	kjH2TTL5xohKZa2bNm1Ah0kJpmRTVjfE6cT10gxF5TG7m9euWmhxEgWN+FqV9KsK
	IVImhEPUFt9MRD4SVGtsvZ3B7Jy+mjlcHKFxkqJB+4dZEa91nBemsd5AL6Crx3cJ
	G5vvp+v8Iq0uaowoSWJU+9R62mVzuJav+sVlY5g0cR8M1lNBSTZHfnq0K9kxNtBq
	k17LwnK0P/e2AA8BkCiKNoa98IyPmV+Hm1WXSqBkZg==
X-ME-Sender: <xms:txqzZmPyk7RICKMn9e7ahNsXCJol1olX6jOKc8vVlOCAuwm91BNocA>
    <xme:txqzZk9C_WP5o5455hMi6TY4Il67eSnG6wHQeTnPN9CYrGZxV-Vlvx3Y-943ziWTQ
    lRG9kPn6mXrELv9VA>
X-ME-Received: <xmr:txqzZtSNnLZk0filP3V6uwZQYn_F7FQnVoDnjC_d2qLFHaZQX9Q2je15hPZ_6EJNF0o_OF4JvdbE3h9DSYrwLG82AjqtlDXZL86cfDKNBjv0-Kgc>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrkeelgdduudejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvuffkfhggtggujgesghdtre
    ertddtvdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehp
    khhsrdhimheqnecuggftrfgrthhtvghrnhepheeghfdtfeeuffehkefgffduleffjedthf
    dvjeektdfhhedvlefgtefgvdettdfhnecuvehluhhsthgvrhfuihiivgeptdenucfrrghr
    rghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtoheptd
X-ME-Proxy: <xmx:txqzZmtHaEQ222MlDCdUXWMU9tma0Ql-sRst78gNXB_IyPnLxfFuOA>
    <xmx:txqzZudOeK1qJWWhJNgs0EQlGCLg2sX_yW5uY6Fkn3GkU7VqhWkCcw>
    <xmx:txqzZq2-94LalEiRsq02AR1N0IJ5HYG3onatDzeQ828oX2vLlQ2RxQ>
    <xmx:txqzZi8v5ZjbrYOf76KGUapEvl6e8NLUvNpJsUbJ4WnUV6w2vyi4Tw>
    <xmx:txqzZiG1mnjPlPLWVal6tUr-ApQqgO4zdwIfHUPkUrZ1f6ciVV3IYoko>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Wed, 7 Aug 2024 02:56:54 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id deb84a5b (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Wed, 7 Aug 2024 06:56:50 +0000 (UTC)
Date: Wed, 7 Aug 2024 08:56:52 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Subject: [PATCH 02/20] path: expose `do_git_common_path()` as
 `strbuf_git_common_pathv()`
Message-ID: <e7a143c30dd95d8192eacc35c876e7926cb7c6a4.1723013714.git.ps@pks.im>
References: <cover.1723013714.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="0iqojMFE3ieV30eP"
Content-Disposition: inline
In-Reply-To: <cover.1723013714.git.ps@pks.im>


--0iqojMFE3ieV30eP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

With the same reasoning as the preceding commit, expose the function
`do_git_common_path()` as `strbuf_git_common_pathv()`.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 path.c | 22 +++++++++++-----------
 path.h |  5 ++++-
 2 files changed, 15 insertions(+), 12 deletions(-)

diff --git a/path.c b/path.c
index 71f1cb4dfb..bff98b255e 100644
--- a/path.c
+++ b/path.c
@@ -617,16 +617,16 @@ int strbuf_git_path_submodule(struct strbuf *buf, con=
st char *path,
 	return err;
 }
=20
-static void do_git_common_path(const struct repository *repo,
-			       struct strbuf *buf,
-			       const char *fmt,
-			       va_list args)
+void strbuf_git_common_pathv(struct strbuf *sb,
+			     const struct repository *repo,
+			     const char *fmt,
+			     va_list args)
 {
-	strbuf_addstr(buf, repo->commondir);
-	if (buf->len && !is_dir_sep(buf->buf[buf->len - 1]))
-		strbuf_addch(buf, '/');
-	strbuf_vaddf(buf, fmt, args);
-	strbuf_cleanup_path(buf);
+	strbuf_addstr(sb, repo->commondir);
+	if (sb->len && !is_dir_sep(sb->buf[sb->len - 1]))
+		strbuf_addch(sb, '/');
+	strbuf_vaddf(sb, fmt, args);
+	strbuf_cleanup_path(sb);
 }
=20
 const char *git_common_path(const char *fmt, ...)
@@ -634,7 +634,7 @@ const char *git_common_path(const char *fmt, ...)
 	struct strbuf *pathname =3D get_pathname();
 	va_list args;
 	va_start(args, fmt);
-	do_git_common_path(the_repository, pathname, fmt, args);
+	strbuf_git_common_pathv(pathname, the_repository, fmt, args);
 	va_end(args);
 	return pathname->buf;
 }
@@ -645,7 +645,7 @@ void strbuf_git_common_path(struct strbuf *sb,
 {
 	va_list args;
 	va_start(args, fmt);
-	do_git_common_path(repo, sb, fmt, args);
+	strbuf_git_common_pathv(sb, repo, fmt, args);
 	va_end(args);
 }
=20
diff --git a/path.h b/path.h
index 94e7030f0b..77eb0e6543 100644
--- a/path.h
+++ b/path.h
@@ -37,6 +37,10 @@ void strbuf_git_common_path(struct strbuf *sb,
 			    const struct repository *repo,
 			    const char *fmt, ...)
 	__attribute__((format (printf, 3, 4)));
+void strbuf_git_common_pathv(struct strbuf *sb,
+			     const struct repository *repo,
+			     const char *fmt,
+			     va_list args);
=20
 /*
  * Return a statically allocated path into the main repository's
@@ -45,7 +49,6 @@ void strbuf_git_common_path(struct strbuf *sb,
 const char *git_common_path(const char *fmt, ...)
 	__attribute__((format (printf, 1, 2)));
=20
-
 /*
  * The `git_path` family of functions will construct a path into a reposit=
ory's
  * git directory.
--=20
2.46.0.dirty


--0iqojMFE3ieV30eP
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmazGrMACgkQVbJhu7ck
PpQYpQ/+MIe8b5HbUv5e02rbc0nzMVuy4eJSco2fR/s54lkp4b2l3yg6q9pLrlhW
BPhkQdmm+J+4muZZi7ZOSoTWoEA8JeO0Ejlg31eMK+MxzYN5TEtWL8wj+fS8FJ3m
q+q8SL3YS61K0j23rjUd1vQO2QgopzS0Efi6z+6rJM+5r1kOSmj6MsUdPfdA878l
s9IT/4n6Jpumko2zzonv0vu7l8Gcjk/C++M37syre2BxtIil1y9NgeHwKD423203
0T9A1Ppfh69GvmNSlwu6AlQM3xVaNr8XaiX+F2IH3CeizJTejASgj+e1UDkn52+K
UH9zRI4KzfkrceyiSkI7RvgATqwUCwL2Ylbnn+26/buu5Tiu8gG599N9eXXI+152
ePuTD150L9b/lIKEjKS+fR9zLP9df19cDMy9wglFzqpuoZMvFMgP6Wq8zUSNzg4t
n9ze5uIijUDfpvKZIZ2Ga5reEPXd2PGq/6+RhtLfcnXoqA94yeWfEXxHfk5Hca+K
8s/ei3Q3Ug/oJEN7agIal7rZxl2BBFB/75fYtbrohHgTA+MMn4/AJsz6MsKxQ4Sf
uim1HqN3JPoj7sh6GxyTx7Gh7rrexf+U6SMeH9V86sdzdREayur65hkuMtzzWhmn
Uoc8MhjGHkxdsBctrX0PLJxfz0dAov5P7cLsPgnRSZm551oQB6Q=
=gRgy
-----END PGP SIGNATURE-----

--0iqojMFE3ieV30eP--
