Received: from fhigh1-smtp.messagingengine.com (fhigh1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54BB61B86DE
	for <git@vger.kernel.org>; Wed,  7 Aug 2024 06:58:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723013884; cv=none; b=IT3BZ4QPS2EQOKuI65lbgk2krDUYBU+rEnHVlTOHrJK4gChE/mHWD0UzaYP6qNklUcWbu2TOiZclIdjCtl0cw7DKFbbe8EDSGs+bA5m2+mKsQVgGz54eD6qiSBX3CQ7dBaL5F/TvyYBTSSmvncsVP17NskFKcppXhoy/iG1RA0E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723013884; c=relaxed/simple;
	bh=A4ySnJYc4Rm5cawAlpk1Zi3Zj0JoVuonAG45xR7KzN4=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QvWjlUU5j3foCJsOKLtmvNv8V4XZ+e8+cJZbxe7wg4l9tSFNPjv4shyGGQoTBi/IaXMx/k+IN/dGQGgxrsMZV7bozgLRzjzjai70X6KuQjQRvA6SycV2G554EYp/HF1GD26RZn/Yh+fK593CFNjDf0sgVS0APDJgkQKQN5d1DKY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=S5NNMrOy; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=XKuyAd6J; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="S5NNMrOy";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="XKuyAd6J"
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id AA7201151AEE
	for <git@vger.kernel.org>; Wed,  7 Aug 2024 02:57:59 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Wed, 07 Aug 2024 02:57:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1723013879; x=1723100279; bh=FO1xFe5RMI
	xTPmFaz2Fb9C25+1uqAnglfJIkWYKiPVQ=; b=S5NNMrOykVaccArdOjL9Cbhs20
	cNnDykna/EruzsQ52BhQ9MhlN4J/vJnFdjniRQ7iAli35e6xX7RhLDKU+2keATmH
	w57DOTQo4wTaa/etmKavpV9fIjp67fYtcguve6Ae1waVSMdElx2QhZPRkcJvv95O
	EhcHHnwDAucxcD2egPcrrUBzZmDVTl4EMFVWTl18WI0XMhWTxtGQOFL6XmnqBAK1
	0HXe+6xl7LONS838B8XLRtCGGpkYVuScaVQpZfpODMEHy5UnHK4SCUbp4rUsmyaZ
	mEXMgqCCBfn2che9G9NizZfYrYydJ7QBbEw6NCjkBucoTOhzIRXDwaTlkfOw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1723013879; x=1723100279; bh=FO1xFe5RMIxTPmFaz2Fb9C25+1uq
	AnglfJIkWYKiPVQ=; b=XKuyAd6JbOewn8Yo+kTYoPzFWuOykfDsdim/QpvqG9w0
	ytefSj9YZ4GisBpKRoUmPQnjUhsj+NMG00G9QUNEDmosbEc9rELmdp/mg+auK+D/
	7hepWxheidtStkFiHAQmAMNw+0pz53J1V2kM2qZghP5Gopm5bqbrJhpL2yfurDP5
	bIeTNvbRSVwu8nsONeguGfvlLK9vAGhDSgQMjT71Sto5JLJdLvC9LadTeVvTZXZK
	ig6Xj0Xg1p5Z+JUtreYq3v+ABP3Zxn6K818LWHsZi3FQ69Sx9KRhjWlGjl50p6KP
	m/sUUtT6Z4yc5ypXr80lfzJEun0xYDx4KMfOAnz0WA==
X-ME-Sender: <xms:9xqzZhlpe2UCcHjHcxKHuZeio4gavAXRGbvlZb5JTWX-s9CcUMAUIA>
    <xme:9xqzZs1R-u5vuMD4A5GJGS4rtvjImy52433ZBQ5YlscmovcsQKthGPgiAKBIUXdky
    5DMiiLlOzQVw9GSYA>
X-ME-Received: <xmr:9xqzZnpab8zIUL2ODedpLN6xl0xgGceFuq9p7_ao3BZ0lEsSeUw4BN7ljzA8yDQBoT_ILbDrCuOmsyL3_GgPxuWrI5av7InZvcY04lIQuQvMYlg2>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrkeelgdduudejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvuffkfhggtggujgesghdtre
    ertddtvdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehp
    khhsrdhimheqnecuggftrfgrthhtvghrnhepheeghfdtfeeuffehkefgffduleffjedthf
    dvjeektdfhhedvlefgtefgvdettdfhnecuvehluhhsthgvrhfuihiivgepgeenucfrrghr
    rghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtoheptd
X-ME-Proxy: <xmx:9xqzZhmODpDrnyEbSQEiKX_cz_18GnaIBeN2AJMypXje3jAMgjv5qw>
    <xmx:9xqzZv26LFMEPpycLzmFopGDdbQxLxkt-S0uIzCl4riy6Cd511opjQ>
    <xmx:9xqzZguILeLKlvNK60w-Su389D-_z0avrpb3KYcfUa9IAt6ZAnvacw>
    <xmx:9xqzZjVgXpycjSs0BW5dJ4ed2iaeXxcygbvw4-XSk5myjeXq7v7xaw>
    <xmx:9xqzZo_jFciwGT7uQ3bLzIob2s_zXBBPFvSXuTu5lSMzE9wNmR7EZKtX>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Wed, 7 Aug 2024 02:57:59 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 7ce80e96 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Wed, 7 Aug 2024 06:57:54 +0000 (UTC)
Date: Wed, 7 Aug 2024 08:57:56 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Subject: [PATCH 16/20] config: pass repo to functions that rename or copy
 sections
Message-ID: <980533972ce73c0d7a4450c2ebb514231c3ca649.1723013714.git.ps@pks.im>
References: <cover.1723013714.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="lx8w/JoJCyeB8lSg"
Content-Disposition: inline
In-Reply-To: <cover.1723013714.git.ps@pks.im>


--lx8w/JoJCyeB8lSg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Refactor functions that rename or copy config sections to accept a
`struct repository` such that we can get rid of the implicit dependency
on `the_repository`. Rename the functions accordingly.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/branch.c            |  7 ++++---
 builtin/config.c            | 16 ++++++++--------
 builtin/remote.c            |  4 ++--
 builtin/submodule--helper.c |  2 +-
 config.c                    | 30 ++++++++++++++++--------------
 config.h                    |  8 ++++----
 submodule.c                 |  2 +-
 7 files changed, 36 insertions(+), 33 deletions(-)

diff --git a/builtin/branch.c b/builtin/branch.c
index 48cac74f97..3f870741bf 100644
--- a/builtin/branch.c
+++ b/builtin/branch.c
@@ -210,7 +210,7 @@ static void delete_branch_config(const char *branchname)
 {
 	struct strbuf buf =3D STRBUF_INIT;
 	strbuf_addf(&buf, "branch.%s", branchname);
-	if (git_config_rename_section(buf.buf, NULL) < 0)
+	if (repo_config_rename_section(the_repository, buf.buf, NULL) < 0)
 		warning(_("update of config-file failed"));
 	strbuf_release(&buf);
 }
@@ -659,9 +659,10 @@ static void copy_or_rename_branch(const char *oldname,=
 const char *newname, int
=20
 	strbuf_addf(&oldsection, "branch.%s", interpreted_oldname);
 	strbuf_addf(&newsection, "branch.%s", interpreted_newname);
-	if (!copy && git_config_rename_section(oldsection.buf, newsection.buf) < =
0)
+	if (!copy && repo_config_rename_section(the_repository, oldsection.buf, n=
ewsection.buf) < 0)
 		die(_("branch is renamed, but update of config-file failed"));
-	if (copy && strcmp(interpreted_oldname, interpreted_newname) && git_confi=
g_copy_section(oldsection.buf, newsection.buf) < 0)
+	if (copy && strcmp(interpreted_oldname, interpreted_newname) &&
+	    repo_config_copy_section(the_repository, oldsection.buf, newsection.b=
uf) < 0)
 		die(_("branch is copied, but update of config-file failed"));
 	strbuf_release(&oldref);
 	strbuf_release(&newref);
diff --git a/builtin/config.c b/builtin/config.c
index 20a0b64090..e00d983596 100644
--- a/builtin/config.c
+++ b/builtin/config.c
@@ -1026,8 +1026,8 @@ static int cmd_config_rename_section(int argc, const =
char **argv, const char *pr
 	location_options_init(&location_opts, prefix);
 	check_write(&location_opts.source);
=20
-	ret =3D git_config_rename_section_in_file(location_opts.source.file,
-						argv[0], argv[1]);
+	ret =3D repo_config_rename_section_in_file(the_repository, location_opts.=
source.file,
+						 argv[0], argv[1]);
 	if (ret < 0)
 		goto out;
 	else if (!ret)
@@ -1055,8 +1055,8 @@ static int cmd_config_remove_section(int argc, const =
char **argv, const char *pr
 	location_options_init(&location_opts, prefix);
 	check_write(&location_opts.source);
=20
-	ret =3D git_config_rename_section_in_file(location_opts.source.file,
-						argv[0], NULL);
+	ret =3D repo_config_rename_section_in_file(the_repository, location_opts.=
source.file,
+						 argv[0], NULL);
 	if (ret < 0)
 		goto out;
 	else if (!ret)
@@ -1353,8 +1353,8 @@ static int cmd_config_actions(int argc, const char **=
argv, const char *prefix)
 	else if (actions =3D=3D ACTION_RENAME_SECTION) {
 		check_write(&location_opts.source);
 		check_argc(argc, 2, 2);
-		ret =3D git_config_rename_section_in_file(location_opts.source.file,
-							argv[0], argv[1]);
+		ret =3D repo_config_rename_section_in_file(the_repository, location_opts=
=2Esource.file,
+							 argv[0], argv[1]);
 		if (ret < 0)
 			goto out;
 		else if (!ret)
@@ -1365,8 +1365,8 @@ static int cmd_config_actions(int argc, const char **=
argv, const char *prefix)
 	else if (actions =3D=3D ACTION_REMOVE_SECTION) {
 		check_write(&location_opts.source);
 		check_argc(argc, 1, 1);
-		ret =3D git_config_rename_section_in_file(location_opts.source.file,
-							argv[0], NULL);
+		ret =3D repo_config_rename_section_in_file(the_repository, location_opts=
=2Esource.file,
+							 argv[0], NULL);
 		if (ret < 0)
 			goto out;
 		else if (!ret)
diff --git a/builtin/remote.c b/builtin/remote.c
index 08292498bd..fef3026ef4 100644
--- a/builtin/remote.c
+++ b/builtin/remote.c
@@ -736,7 +736,7 @@ static int mv(int argc, const char **argv, const char *=
prefix)
=20
 	strbuf_addf(&buf, "remote.%s", rename.old_name);
 	strbuf_addf(&buf2, "remote.%s", rename.new_name);
-	if (git_config_rename_section(buf.buf, buf2.buf) < 1)
+	if (repo_config_rename_section(the_repository, buf.buf, buf2.buf) < 1)
 		return error(_("Could not rename config section '%s' to '%s'"),
 				buf.buf, buf2.buf);
=20
@@ -944,7 +944,7 @@ static int rm(int argc, const char **argv, const char *=
prefix)
=20
 	if (!result) {
 		strbuf_addf(&buf, "remote.%s", remote->name);
-		if (git_config_rename_section(buf.buf, NULL) < 1)
+		if (repo_config_rename_section(the_repository, buf.buf, NULL) < 1)
 			return error(_("Could not remove config section '%s'"), buf.buf);
=20
 		handle_push_default(remote->name, NULL);
diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index f1218a1995..662c87c06c 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -1455,7 +1455,7 @@ static void deinit_submodule(const char *path, const =
char *prefix,
 		 * remove the whole section so we have a clean state when
 		 * the user later decides to init this submodule again
 		 */
-		git_config_rename_section_in_file(NULL, sub_key, NULL);
+		repo_config_rename_section_in_file(the_repository, NULL, sub_key, NULL);
 		if (!(flags & OPT_QUIET))
 			printf(_("Submodule '%s' (%s) unregistered for path '%s'\n"),
 				 sub->name, sub->url, displaypath);
diff --git a/config.c b/config.c
index e35fc90238..ed39922dbb 100644
--- a/config.c
+++ b/config.c
@@ -3697,9 +3697,11 @@ static int section_name_is_ok(const char *name)
 #define GIT_CONFIG_MAX_LINE_LEN (512 * 1024)
=20
 /* if new_name =3D=3D NULL, the section is removed instead */
-static int git_config_copy_or_rename_section_in_file(const char *config_fi=
lename,
-				      const char *old_name,
-				      const char *new_name, int copy)
+static int repo_config_copy_or_rename_section_in_file(
+	struct repository *r,
+	const char *config_filename,
+	const char *old_name,
+	const char *new_name, int copy)
 {
 	int ret =3D 0, remove =3D 0;
 	char *filename_buf =3D NULL;
@@ -3720,7 +3722,7 @@ static int git_config_copy_or_rename_section_in_file(=
const char *config_filename
 	}
=20
 	if (!config_filename)
-		config_filename =3D filename_buf =3D git_pathdup("config");
+		config_filename =3D filename_buf =3D repo_git_path(r, "config");
=20
 	out_fd =3D hold_lock_file_for_update(&lock, config_filename, 0);
 	if (out_fd < 0) {
@@ -3863,28 +3865,28 @@ static int git_config_copy_or_rename_section_in_fil=
e(const char *config_filename
 	return ret;
 }
=20
-int git_config_rename_section_in_file(const char *config_filename,
-				      const char *old_name, const char *new_name)
+int repo_config_rename_section_in_file(struct repository *r, const char *c=
onfig_filename,
+				       const char *old_name, const char *new_name)
 {
-	return git_config_copy_or_rename_section_in_file(config_filename,
+	return repo_config_copy_or_rename_section_in_file(r, config_filename,
 					 old_name, new_name, 0);
 }
=20
-int git_config_rename_section(const char *old_name, const char *new_name)
+int repo_config_rename_section(struct repository *r, const char *old_name,=
 const char *new_name)
 {
-	return git_config_rename_section_in_file(NULL, old_name, new_name);
+	return repo_config_rename_section_in_file(r, NULL, old_name, new_name);
 }
=20
-int git_config_copy_section_in_file(const char *config_filename,
-				      const char *old_name, const char *new_name)
+int repo_config_copy_section_in_file(struct repository *r, const char *con=
fig_filename,
+				     const char *old_name, const char *new_name)
 {
-	return git_config_copy_or_rename_section_in_file(config_filename,
+	return repo_config_copy_or_rename_section_in_file(r, config_filename,
 					 old_name, new_name, 1);
 }
=20
-int git_config_copy_section(const char *old_name, const char *new_name)
+int repo_config_copy_section(struct repository *r, const char *old_name, c=
onst char *new_name)
 {
-	return git_config_copy_section_in_file(NULL, old_name, new_name);
+	return repo_config_copy_section_in_file(r, NULL, old_name, new_name);
 }
=20
 /*
diff --git a/config.h b/config.h
index 947307c591..589d6dae26 100644
--- a/config.h
+++ b/config.h
@@ -392,11 +392,11 @@ void repo_config_set_multivar_in_file(struct reposito=
ry *r,
  * If NULL is passed through `new_name` parameter,
  * the section will be removed from the config file.
  */
-int git_config_rename_section(const char *, const char *);
+int repo_config_rename_section(struct repository *, const char *, const ch=
ar *);
=20
-int git_config_rename_section_in_file(const char *, const char *, const ch=
ar *);
-int git_config_copy_section(const char *, const char *);
-int git_config_copy_section_in_file(const char *, const char *, const char=
 *);
+int repo_config_rename_section_in_file(struct repository *, const char *, =
const char *, const char *);
+int repo_config_copy_section(struct repository *, const char *, const char=
 *);
+int repo_config_copy_section_in_file(struct repository *, const char *, co=
nst char *, const char *);
 int git_config_system(void);
 int config_error_nonbool(const char *);
 #if defined(__GNUC__)
diff --git a/submodule.c b/submodule.c
index ab99a30253..bc04fc8284 100644
--- a/submodule.c
+++ b/submodule.c
@@ -159,7 +159,7 @@ int remove_path_from_gitmodules(const char *path)
 	}
 	strbuf_addstr(&sect, "submodule.");
 	strbuf_addstr(&sect, submodule->name);
-	if (git_config_rename_section_in_file(GITMODULES_FILE, sect.buf, NULL) < =
0) {
+	if (repo_config_rename_section_in_file(the_repository, GITMODULES_FILE, s=
ect.buf, NULL) < 0) {
 		/* Maybe the user already did that, don't error out here */
 		warning(_("Could not remove .gitmodules entry for %s"), path);
 		strbuf_release(&sect);
--=20
2.46.0.dirty


--lx8w/JoJCyeB8lSg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmazGvMACgkQVbJhu7ck
PpS1Zw/+PVzzp7k+zfDjwCBCIQNN7pPTRx6p+isjde9yDCixrLFNk+aPqMf9vAZm
8KE9w3qrUmCZ3WIraQJPuvyiWxIa4DDgODDWFWxwzR64xKay0HN0iF+AGZyxj8c6
bbH+oxGpOPR4CoCUh6QGHOfyvxYNOcsxJ/5disOeGVtnXs+qHIo9IWBlGQ52+yp3
GftbSH0eBT28ASYDxr49fqdXvkxL6qpIwc50MygP9ALgmPQ/qpFqcxLDdIhuum+R
9qhI5uyXf9+lQw+q83HahTmBKpWNjfSznoeduHnMQmKDpQUVBEEnMhqj4GMbCdlQ
7F9qrP8Sxjs0GhfTAWhBG3Asljh9TwVQxIWxBgOcVEYjcefGcOGsVqjhVkX2mW8b
rOKREtKZ2QvtWIVrok3LFb18wu1SstqdpSXRsyTVk+Hb1ABwSvk9xAvwYH2DYbjK
yNY5j/SUauKV19GnCzEmC6pqr5y0cK37RTL7QFu0x0P/iNiuRr0XSK6HnNrUfIbB
HQnvuaEQS0sZ/IiJdYOKbNzPDRdxxbTSLB7VytTYWHlN6RDkdYINwWvHPar4XYW/
Pfwx1bNLG5EMIaDye5A3yQcvC5wnR+l4Vmje/DaAeImnsde6+w+ZikZ6/2w7uJHV
JEguk2FIYZhLl0aIrxsdE9EyQe8bLzmOneFPqz0bWj4TwjimXzw=
=yvCP
-----END PGP SIGNATURE-----

--lx8w/JoJCyeB8lSg--
