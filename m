Received: from fhigh1-smtp.messagingengine.com (fhigh1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 885431B86DB
	for <git@vger.kernel.org>; Wed,  7 Aug 2024 06:57:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723013847; cv=none; b=o8PI9gJeg/HhlCt13CENUpWIOrM3ptnSmXusRfGWFTFfsDbt19ds+SsTRze8o0l3wT+rPQ86BiRvVLhswJocPiievl6E2JDVhE/saXvTIxJFch1os479hrLBq0NWIcHn9BA52P/4/vZm2tcNyHs1+QkJE587/nhyWZLYvUhsXQ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723013847; c=relaxed/simple;
	bh=aFTmtAmaV9RxMQ8fYN+JWzHj3BlvfMAK5oeHd4rcRXc=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iCyLGVf63ztve9w7sDU9PkbEAvvM9xvUDTtbqaH/jIxn+5ZxP0l1kIIqtYF0uBUXsXThui/zYwQ+BP+VGQ78Co5OgW/Ej/B4/KRDxko9TD07WrRq2Qtturestv2LO818B0m4VZdspJvZYykYCQBHeDxqw0zgqGezab+Ck8bNPtM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=lenwgWmP; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=fwo3pdPa; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="lenwgWmP";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="fwo3pdPa"
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id 249FB1151AB7
	for <git@vger.kernel.org>; Wed,  7 Aug 2024 02:57:23 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute1.internal (MEProxy); Wed, 07 Aug 2024 02:57:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1723013843; x=1723100243; bh=gxXjBtMFdd
	zdR2KAtdgq8TU828bIdP+wmR3xn8bfWDI=; b=lenwgWmPuVRkmQIhb8AwS79g6J
	ogMIfFGGq/ZBPl3JvBSbCWvQugw2vhMmyQ3wKqdj5CnZ4Cx7YcKVOjeS7E5ParpO
	mxiq4klj7qQsHpvARbdA1Y5/AUpCla6qDXo+mbP68LpxAg/iorJXbliOqbn/l474
	tpJznLpL6VurIhW4P8cFs32tY/4pdeU0jZKLFVbFF2V0GMY8iiLzf7JMk9HY2Kpo
	V7vxrHaqDUtQ4lPcmfw3RyHDdbE1c46S5eFEZ83AK25Cd8BEXx+HGQOFtW07Zka4
	kIvmD82mo3VfWgOw+RX21ijZUvX+tYqIqEBrnZmLlQgPbEgi77r8Es2DXU3g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1723013843; x=1723100243; bh=gxXjBtMFddzdR2KAtdgq8TU828bI
	dP+wmR3xn8bfWDI=; b=fwo3pdPaT0nJLYDD+eQ3mXjvadJNl0i/UyWx6VFIIj9L
	ZwHzIIqw0Dw2iYr3B5jC0mDP2PqIyrD1u5qLzjZt+P9KlTmFjTIzRDJ55GXx+mju
	g0lyosRJtgcRLUiK7k6l6iDT9USxBFNDATwkXsGpBrvMyAbxSA1ZqP7vj+R4mS68
	DpwdiGYVzau/FLmitwwawnhRsfxKdL6N1M4z1lEzEuYh2pwFOYUxeC6v5c9OA0+F
	R9OJk4b2eEBvBItcYoIZpPKFRxNFqDhadKYzxfbb9rjFSSVSNOhxS6YmLfrH86V9
	57BHfCU2Hxr1/TeVG09KeeOSAIduXtsDVaDxlzA8WQ==
X-ME-Sender: <xms:0xqzZr7ubsaE4KANxzbLQm3zDYbAqiMHcnrhzTvVJzlO_EHPLTZp8g>
    <xme:0xqzZg532Erqmyk6fEavti94adwPGaQdecVNw2YMJ7h8uGxGE4lfxIre3R_QEI4aL
    kn6eDKkI3jPDzS3uA>
X-ME-Received: <xmr:0xqzZiedaTV4UCLJ02xTdE4F4kDn8TVblGf0zSRC4ZWREMTKeINcvOP7XFIEEwB6mMD-NZwl5UOKWlOkfKMwBesvSshpQODvMIWkS1uvx0YjqqrQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrkeelgdduudejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvuffkfhggtggujgesghdtre
    ertddtvdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehp
    khhsrdhimheqnecuggftrfgrthhtvghrnhepheeghfdtfeeuffehkefgffduleffjedthf
    dvjeektdfhhedvlefgtefgvdettdfhnecuvehluhhsthgvrhfuihiivgeptdenucfrrghr
    rghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtoheptd
X-ME-Proxy: <xmx:0xqzZsJfAJgo2yIKpORdfN1SD757R_zH0cXcWABpmjox09JPYhJLew>
    <xmx:0xqzZvLVTM0FQA4iSL4IHKbyBAdcvAK06Xm1ee4tFzJRDKRDlizhSw>
    <xmx:0xqzZlwg7QliamgkBS-Sb2fYzUlekhET27dAFXPI1KB7sD7HsPJx5A>
    <xmx:0xqzZrIAd1QH9u9ydeRiV36owHvmncm-YbL31r_uZo82tHrTKsRdZA>
    <xmx:0xqzZljh5kNl8fst_C9joj6KQtG_wknuJS077c73jDxrKck-29goI8gP>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Wed, 7 Aug 2024 02:57:22 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id b728782e (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Wed, 7 Aug 2024 06:57:17 +0000 (UTC)
Date: Wed, 7 Aug 2024 08:57:19 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Subject: [PATCH 08/20] config: introduce missing setters that take repo as
 parameter
Message-ID: <feae2ad31ac91baae75c46c22c5c3ef3b58c1897.1723013714.git.ps@pks.im>
References: <cover.1723013714.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="9JYsEo9k/EX0vqkW"
Content-Disposition: inline
In-Reply-To: <cover.1723013714.git.ps@pks.im>


--9JYsEo9k/EX0vqkW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

While we already provide some of the config-setting interfaces with a
`struct repository` as parameter, others only have a variant that
implicitly depend on `the_repository`. Fill in those gaps such that we
can start to deprecate the repo-less variants.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 config.c | 93 ++++++++++++++++++++++++++++++++++++++++++++------------
 config.h | 15 ++++++++-
 2 files changed, 87 insertions(+), 21 deletions(-)

diff --git a/config.c b/config.c
index 6421894614..ac89b708e7 100644
--- a/config.c
+++ b/config.c
@@ -3178,21 +3178,39 @@ static void maybe_remove_section(struct config_stor=
e_data *store,
 		*end_offset =3D store->parsed[store->parsed_nr - 1].end;
 }
=20
+int repo_config_set_in_file_gently(struct repository *r, const char *confi=
g_filename,
+				   const char *key, const char *comment, const char *value)
+{
+	return repo_config_set_multivar_in_file_gently(r, config_filename, key, v=
alue, NULL, comment, 0);
+}
+
 int git_config_set_in_file_gently(const char *config_filename,
 				  const char *key, const char *comment, const char *value)
 {
-	return git_config_set_multivar_in_file_gently(config_filename, key, value=
, NULL, comment, 0);
+	return repo_config_set_in_file_gently(the_repository, config_filename,
+					      key, comment, value);
+}
+
+void repo_config_set_in_file(struct repository *r, const char *config_file=
name,
+			     const char *key, const char *value)
+{
+	repo_config_set_multivar_in_file(r, config_filename, key, value, NULL, 0);
 }
=20
 void git_config_set_in_file(const char *config_filename,
 			    const char *key, const char *value)
 {
-	git_config_set_multivar_in_file(config_filename, key, value, NULL, 0);
+	repo_config_set_in_file(the_repository, config_filename, key, value);
+}
+
+int repo_config_set_gently(struct repository *r, const char *key, const ch=
ar *value)
+{
+	return repo_config_set_multivar_gently(r, key, value, NULL, 0);
 }
=20
 int git_config_set_gently(const char *key, const char *value)
 {
-	return git_config_set_multivar_gently(key, value, NULL, 0);
+	return repo_config_set_gently(the_repository, key, value);
 }
=20
 int repo_config_set_worktree_gently(struct repository *r,
@@ -3209,13 +3227,18 @@ int repo_config_set_worktree_gently(struct reposito=
ry *r,
 	return repo_config_set_multivar_gently(r, key, value, NULL, 0);
 }
=20
-void git_config_set(const char *key, const char *value)
+void repo_config_set(struct repository *r, const char *key, const char *va=
lue)
 {
-	git_config_set_multivar(key, value, NULL, 0);
+	repo_config_set_multivar(r, key, value, NULL, 0);
=20
 	trace2_cmd_set_config(key, value);
 }
=20
+void git_config_set(const char *key, const char *value)
+{
+	repo_config_set(the_repository, key, value);
+}
+
 char *git_config_prepare_comment_string(const char *comment)
 {
 	size_t leading_blanks;
@@ -3293,11 +3316,12 @@ static void validate_comment_string(const char *com=
ment)
  * - the config file is removed and the lock file rename()d to it.
  *
  */
-int git_config_set_multivar_in_file_gently(const char *config_filename,
-					   const char *key, const char *value,
-					   const char *value_pattern,
-					   const char *comment,
-					   unsigned flags)
+int repo_config_set_multivar_in_file_gently(struct repository *r,
+					    const char *config_filename,
+					    const char *key, const char *value,
+					    const char *value_pattern,
+					    const char *comment,
+					    unsigned flags)
 {
 	int fd =3D -1, in_fd =3D -1;
 	int ret;
@@ -3317,7 +3341,7 @@ int git_config_set_multivar_in_file_gently(const char=
 *config_filename,
 	store.multi_replace =3D (flags & CONFIG_FLAGS_MULTI_REPLACE) !=3D 0;
=20
 	if (!config_filename)
-		config_filename =3D filename_buf =3D git_pathdup("config");
+		config_filename =3D filename_buf =3D repo_git_path(r, "config");
=20
 	/*
 	 * The lock serves a purpose in addition to locking: the new
@@ -3526,7 +3550,7 @@ int git_config_set_multivar_in_file_gently(const char=
 *config_filename,
 	ret =3D 0;
=20
 	/* Invalidate the config cache */
-	git_config_clear();
+	repo_config_clear(r);
=20
 out_free:
 	rollback_lock_file(&lock);
@@ -3543,12 +3567,24 @@ int git_config_set_multivar_in_file_gently(const ch=
ar *config_filename,
 	goto out_free;
 }
=20
-void git_config_set_multivar_in_file(const char *config_filename,
-				     const char *key, const char *value,
-				     const char *value_pattern, unsigned flags)
+int git_config_set_multivar_in_file_gently(const char *config_filename,
+					   const char *key, const char *value,
+					   const char *value_pattern,
+					   const char *comment,
+					   unsigned flags)
 {
-	if (!git_config_set_multivar_in_file_gently(config_filename, key, value,
-						    value_pattern, NULL, flags))
+	return repo_config_set_multivar_in_file_gently(the_repository, config_fil=
ename,
+						       key, value, value_pattern,
+						       comment, flags);
+}
+
+void repo_config_set_multivar_in_file(struct repository *r,
+				      const char *config_filename,
+				      const char *key, const char *value,
+				      const char *value_pattern, unsigned flags)
+{
+	if (!repo_config_set_multivar_in_file_gently(r, config_filename, key, val=
ue,
+						     value_pattern, NULL, flags))
 		return;
 	if (value)
 		die(_("could not set '%s' to '%s'"), key, value);
@@ -3556,6 +3592,14 @@ void git_config_set_multivar_in_file(const char *con=
fig_filename,
 		die(_("could not unset '%s'"), key);
 }
=20
+void git_config_set_multivar_in_file(const char *config_filename,
+				     const char *key, const char *value,
+				     const char *value_pattern, unsigned flags)
+{
+	repo_config_set_multivar_in_file(the_repository, config_filename,
+					 key, value, value_pattern, flags);
+}
+
 int git_config_set_multivar_gently(const char *key, const char *value,
 				   const char *value_pattern, unsigned flags)
 {
@@ -3576,12 +3620,21 @@ int repo_config_set_multivar_gently(struct reposito=
ry *r, const char *key,
 	return res;
 }
=20
+void repo_config_set_multivar(struct repository *r,
+			      const char *key, const char *value,
+			      const char *value_pattern, unsigned flags)
+{
+	char *file =3D repo_git_path(r, "config");
+	git_config_set_multivar_in_file(file, key, value,
+					value_pattern, flags);
+	free(file);
+}
+
 void git_config_set_multivar(const char *key, const char *value,
 			     const char *value_pattern, unsigned flags)
 {
-	git_config_set_multivar_in_file(git_path("config"),
-					key, value, value_pattern,
-					flags);
+	repo_config_set_multivar(the_repository, key, value,
+				 value_pattern, flags);
 }
=20
 static size_t section_name_match (const char *buf, const char *name)
diff --git a/config.h b/config.h
index 54b47dec9e..b13e1bfb8d 100644
--- a/config.h
+++ b/config.h
@@ -298,14 +298,18 @@ int git_config_pathname(char **, const char *, const =
char *);
 int git_config_expiry_date(timestamp_t *, const char *, const char *);
 int git_config_color(char *, const char *, const char *);
 int git_config_set_in_file_gently(const char *, const char *, const char *=
, const char *);
+int repo_config_set_in_file_gently(struct repository *r, const char *confi=
g_filename,
+				   const char *key, const char *comment, const char *value);
=20
 /**
  * write config values to a specific config file, takes a key/value pair as
  * parameter.
  */
 void git_config_set_in_file(const char *, const char *, const char *);
+void repo_config_set_in_file(struct repository *, const char *, const char=
 *, const char *);
=20
 int git_config_set_gently(const char *, const char *);
+int repo_config_set_gently(struct repository *r, const char *, const char =
*);
=20
 /**
  * Write a config value that should apply to the current worktree. If
@@ -318,6 +322,7 @@ int repo_config_set_worktree_gently(struct repository *=
, const char *, const cha
  * write config values to `.git/config`, takes a key/value pair as paramet=
er.
  */
 void git_config_set(const char *, const char *);
+void repo_config_set(struct repository *, const char *, const char *);
=20
 int git_config_parse_key(const char *, char **, size_t *);
=20
@@ -341,9 +346,11 @@ int git_config_parse_key(const char *, char **, size_t=
 *);
 #define CONFIG_FLAGS_FIXED_VALUE (1 << 1)
=20
 int git_config_set_multivar_gently(const char *, const char *, const char =
*, unsigned);
-void git_config_set_multivar(const char *, const char *, const char *, uns=
igned);
 int repo_config_set_multivar_gently(struct repository *, const char *, con=
st char *, const char *, unsigned);
+void git_config_set_multivar(const char *, const char *, const char *, uns=
igned);
+void repo_config_set_multivar(struct repository *r, const char *, const ch=
ar *, const char *, unsigned);
 int git_config_set_multivar_in_file_gently(const char *, const char *, con=
st char *, const char *, const char *, unsigned);
+int repo_config_set_multivar_in_file_gently(struct repository *, const cha=
r *, const char *, const char *, const char *, const char *, unsigned);
=20
 char *git_config_prepare_comment_string(const char *);
=20
@@ -372,6 +379,12 @@ void git_config_set_multivar_in_file(const char *confi=
g_filename,
 				     const char *value,
 				     const char *value_pattern,
 				     unsigned flags);
+void repo_config_set_multivar_in_file(struct repository *r,
+				      const char *config_filename,
+				      const char *key,
+				      const char *value,
+				      const char *value_pattern,
+				      unsigned flags);
=20
 /**
  * rename or remove sections in the config file
--=20
2.46.0.dirty


--9JYsEo9k/EX0vqkW
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmazGs8ACgkQVbJhu7ck
PpSyfQ/8DU9Y8TPvZAMIuXLPTIr/attr+gP4e5CE14K3tBmsWFs+PenGRNUU1lda
2qS35WnQolu4QCBupAIH1hQ/RZv6cxSFaV5UeknMzUchQ/qG7xHTyoiPiWHVE5z0
4iOUmvXB/YKaoAbGga/sK4vM0deJCM9w6AdwYhh8igK7qwcpsImSlSorDm6XAk5s
Ii+5ujemwoZcxwxqB961+VVcxrvgEk4qBhf6CZ/1cev8RXFkQY4Ug+7Zt2kQ014q
cpJJRHQTaQBST+9GSyWFSWoeOGms1TlOMDHB3s/wGyDXneioOuP8GkuSf5XuZMZF
Gchm7qI/edkZWBptjjTdNB9sNA9fTwt5uCIOdZTaptkfdp3vlb0ZvL1FmZONHPxr
KOCIUZGsBcH+fDMMhDqcAd6Q1Bh3aBRfWSSWQwJCkNlwK0pM5LL1k5cstr0Ha85+
wugsUDo6F9qtIjw3MboeKvzMieaJ3r6iMsxrCGBAEzbcV87y8tJQKtkWQDA8AxLv
VPtr1m4CTQ75uCWAnK3MvbdSI6KW6MzYMH99dYIwnY/G1Fr0xbf142NSc26v7ORj
unCNOM23tDNSIiS8kN845rnYH4W6H/Qu/PC/EuTdv0GHG/J9lMWrimRdIGn3xHpb
v1dIWCEIF8tXLL7maIw/EkHTpkewzgycpe5GJEI+bIttnQDfdPk=
=Uu+J
-----END PGP SIGNATURE-----

--9JYsEo9k/EX0vqkW--
