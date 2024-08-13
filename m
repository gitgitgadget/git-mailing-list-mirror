Received: from fout2-smtp.messagingengine.com (fout2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64AF5187849
	for <git@vger.kernel.org>; Tue, 13 Aug 2024 09:14:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723540457; cv=none; b=guel7AISAD2DpLPYWMjlOYhQqgB5CQKPacxFj0cWr58fgb6if2SsusBE1W8YtjwqdxGyGffX7TF6xPApAp/ClGcvJFP1eVSzaVf9rUGqjMvverV68pGrMYvIEu3GHIM2iLo2YYy9x2PSe+7jUSHvNMMSZZVvrNuvtLqzwimSx8k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723540457; c=relaxed/simple;
	bh=TXEnzdD7jQszQmrzi8NZ0oImfpLCgBM57pZAakXd9Pc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DK6KsGiSwMlHdDDcdVPZ8KNc3o+/s9b0i0Hph84QsimKDcL1FfEf2KN7jAjpZxhBuEB6aBvuBocRIWMmBE10ScjfYB2CeIgBVzSvxXk/Ywbw145Tg1CYWfhFjp2oP0Rfxz5NBaizoDTH/JX5/PBBfXinWqS0g06LQY/Acl8sVvM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=Wwpsl+ae; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ptCvMoLQ; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Wwpsl+ae";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ptCvMoLQ"
Received: from phl-compute-01.internal (phl-compute-01.nyi.internal [10.202.2.41])
	by mailfout.nyi.internal (Postfix) with ESMTP id BBB42138FD0C;
	Tue, 13 Aug 2024 05:14:14 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Tue, 13 Aug 2024 05:14:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1723540454; x=1723626854; bh=ykKr/aebco
	7WycGOlGM/v04Ua29N7r0VChb7g6bKG7g=; b=Wwpsl+aeOnoeiDz35H3KgfA5iK
	I5mxS4xvLc12jKRJJlFUOJBzY/G7mKi8tOpNUN85tHn/yVg7Tg21H5c8RSEFtqE+
	cVfApiaE92KpR5x5hLNO2qD1NIqKt/QSBD69fD0Mc/b+7/Zd/Huam/68dhQwC4wZ
	LipKOr0xVgqZIobLkN4idqa+Uh2LelLtEqpIAJfOITTjolbGsa6IFNo26xUUJ/5j
	2oz4fzQjl/tEK0r9vUpTrSwtm/NIQjXKQerHts0rPtBF3aKlriG/25L7aRJ8soQD
	y1T0KISzZUL3aaplPLWMl7trhicOEMScrk2Ehu9+5HZ9HzHib7CvDcdEu8Fw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1723540454; x=1723626854; bh=ykKr/aebco7WycGOlGM/v04Ua29N
	7r0VChb7g6bKG7g=; b=ptCvMoLQU9u/WwqoKc8jg2v7o6rGu3joBpQ7bOxe8n2y
	UTkQRiA/j/EA2vmAzPC30GvQdn6YcY/qbvskfa/m63I0thby3FEBdeZpKjIACEST
	S19QrzktTXmmyEIemrDuIZOQNgkTQArPjbsNOwxQYUDt3tipjtPazRLlBhHJZffE
	ztVU7dFMOx/HndLKEMLyZBGEw8FPcGl2d9ulHCNnkppQq9B85BCiWLkzwrlZr2Dn
	CdLUUChjV9CuUMOnT0O6uNFA7h30pg2lFdeMyY/hWqibn+3MJOUu8od/zJ7+2FaS
	RtTdOjKAI3iXr6Qi0WYYfMUKLVGeYfiKvCXEAvDJzA==
X-ME-Sender: <xms:5iO7ZtiY5PI4dGAnlslrjAZzMFDKe5blqJpZOXiVxvZBxWKK2jOKzg>
    <xme:5iO7ZiBAvUtaS1U80IbiftI0dhYgfJheRVarfKyv-8UpUsrIyBGoqs_E7wVOO9AR4
    DN__qJYoeoNq0pmiQ>
X-ME-Received: <xmr:5iO7ZtFlERwgB0drZX29ihCFbcb7oWsjhsNpvxWXiKoWbYAS_qdmfNze9I7_yNglroKBkO5yCbLqsnCwMYjbZrPeZRs0oJkL6xL9vZi5wmVABg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddruddtvddguddvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefgueeg
    udfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgepvdenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepfedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomhdprhgtph
    htthhopehjlhhtohgslhgvrhesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehv
    ghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:5iO7ZiSMcfSjrdxptoSdtPvgZaYOx0VdUqVDc3MeZynetB_QDukJlA>
    <xmx:5iO7ZqzHtL2bw-7RZbPCWWhziVFy13PQROqgpPYoj9I_vN5LeMCfPQ>
    <xmx:5iO7Zo4o1OzWr_Xjt5EVQwKxbhcAfYKawl8aEPma-PbfEOZ4xkezZQ>
    <xmx:5iO7ZvxpSmyZd20xmoqxsC4CCBy-IcD_OMtZLAAEMOa6mU9hUvz0Lw>
    <xmx:5iO7Zu_Rt0Djb8oyRYbjel8dysfP0-1yOD8TKwhGbl4tIsrQnBDzzlyF>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 13 Aug 2024 05:14:13 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id a963195f (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 13 Aug 2024 09:13:57 +0000 (UTC)
Date: Tue, 13 Aug 2024 11:14:12 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Justin Tobler <jltobler@gmail.com>, Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 16/20] config: pass repo to functions that rename or copy
 sections
Message-ID: <b8c54b751c2b1af77b1fb6b324ca845ccdeeb669.1723540226.git.ps@pks.im>
References: <cover.1723013714.git.ps@pks.im>
 <cover.1723540226.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1723540226.git.ps@pks.im>

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
 	struct strbuf buf = STRBUF_INIT;
 	strbuf_addf(&buf, "branch.%s", branchname);
-	if (git_config_rename_section(buf.buf, NULL) < 0)
+	if (repo_config_rename_section(the_repository, buf.buf, NULL) < 0)
 		warning(_("update of config-file failed"));
 	strbuf_release(&buf);
 }
@@ -659,9 +659,10 @@ static void copy_or_rename_branch(const char *oldname, const char *newname, int
 
 	strbuf_addf(&oldsection, "branch.%s", interpreted_oldname);
 	strbuf_addf(&newsection, "branch.%s", interpreted_newname);
-	if (!copy && git_config_rename_section(oldsection.buf, newsection.buf) < 0)
+	if (!copy && repo_config_rename_section(the_repository, oldsection.buf, newsection.buf) < 0)
 		die(_("branch is renamed, but update of config-file failed"));
-	if (copy && strcmp(interpreted_oldname, interpreted_newname) && git_config_copy_section(oldsection.buf, newsection.buf) < 0)
+	if (copy && strcmp(interpreted_oldname, interpreted_newname) &&
+	    repo_config_copy_section(the_repository, oldsection.buf, newsection.buf) < 0)
 		die(_("branch is copied, but update of config-file failed"));
 	strbuf_release(&oldref);
 	strbuf_release(&newref);
diff --git a/builtin/config.c b/builtin/config.c
index 20a0b64090..e00d983596 100644
--- a/builtin/config.c
+++ b/builtin/config.c
@@ -1026,8 +1026,8 @@ static int cmd_config_rename_section(int argc, const char **argv, const char *pr
 	location_options_init(&location_opts, prefix);
 	check_write(&location_opts.source);
 
-	ret = git_config_rename_section_in_file(location_opts.source.file,
-						argv[0], argv[1]);
+	ret = repo_config_rename_section_in_file(the_repository, location_opts.source.file,
+						 argv[0], argv[1]);
 	if (ret < 0)
 		goto out;
 	else if (!ret)
@@ -1055,8 +1055,8 @@ static int cmd_config_remove_section(int argc, const char **argv, const char *pr
 	location_options_init(&location_opts, prefix);
 	check_write(&location_opts.source);
 
-	ret = git_config_rename_section_in_file(location_opts.source.file,
-						argv[0], NULL);
+	ret = repo_config_rename_section_in_file(the_repository, location_opts.source.file,
+						 argv[0], NULL);
 	if (ret < 0)
 		goto out;
 	else if (!ret)
@@ -1353,8 +1353,8 @@ static int cmd_config_actions(int argc, const char **argv, const char *prefix)
 	else if (actions == ACTION_RENAME_SECTION) {
 		check_write(&location_opts.source);
 		check_argc(argc, 2, 2);
-		ret = git_config_rename_section_in_file(location_opts.source.file,
-							argv[0], argv[1]);
+		ret = repo_config_rename_section_in_file(the_repository, location_opts.source.file,
+							 argv[0], argv[1]);
 		if (ret < 0)
 			goto out;
 		else if (!ret)
@@ -1365,8 +1365,8 @@ static int cmd_config_actions(int argc, const char **argv, const char *prefix)
 	else if (actions == ACTION_REMOVE_SECTION) {
 		check_write(&location_opts.source);
 		check_argc(argc, 1, 1);
-		ret = git_config_rename_section_in_file(location_opts.source.file,
-							argv[0], NULL);
+		ret = repo_config_rename_section_in_file(the_repository, location_opts.source.file,
+							 argv[0], NULL);
 		if (ret < 0)
 			goto out;
 		else if (!ret)
diff --git a/builtin/remote.c b/builtin/remote.c
index 08292498bd..fef3026ef4 100644
--- a/builtin/remote.c
+++ b/builtin/remote.c
@@ -736,7 +736,7 @@ static int mv(int argc, const char **argv, const char *prefix)
 
 	strbuf_addf(&buf, "remote.%s", rename.old_name);
 	strbuf_addf(&buf2, "remote.%s", rename.new_name);
-	if (git_config_rename_section(buf.buf, buf2.buf) < 1)
+	if (repo_config_rename_section(the_repository, buf.buf, buf2.buf) < 1)
 		return error(_("Could not rename config section '%s' to '%s'"),
 				buf.buf, buf2.buf);
 
@@ -944,7 +944,7 @@ static int rm(int argc, const char **argv, const char *prefix)
 
 	if (!result) {
 		strbuf_addf(&buf, "remote.%s", remote->name);
-		if (git_config_rename_section(buf.buf, NULL) < 1)
+		if (repo_config_rename_section(the_repository, buf.buf, NULL) < 1)
 			return error(_("Could not remove config section '%s'"), buf.buf);
 
 		handle_push_default(remote->name, NULL);
diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index f1218a1995..662c87c06c 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -1455,7 +1455,7 @@ static void deinit_submodule(const char *path, const char *prefix,
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
 
 /* if new_name == NULL, the section is removed instead */
-static int git_config_copy_or_rename_section_in_file(const char *config_filename,
-				      const char *old_name,
-				      const char *new_name, int copy)
+static int repo_config_copy_or_rename_section_in_file(
+	struct repository *r,
+	const char *config_filename,
+	const char *old_name,
+	const char *new_name, int copy)
 {
 	int ret = 0, remove = 0;
 	char *filename_buf = NULL;
@@ -3720,7 +3722,7 @@ static int git_config_copy_or_rename_section_in_file(const char *config_filename
 	}
 
 	if (!config_filename)
-		config_filename = filename_buf = git_pathdup("config");
+		config_filename = filename_buf = repo_git_path(r, "config");
 
 	out_fd = hold_lock_file_for_update(&lock, config_filename, 0);
 	if (out_fd < 0) {
@@ -3863,28 +3865,28 @@ static int git_config_copy_or_rename_section_in_file(const char *config_filename
 	return ret;
 }
 
-int git_config_rename_section_in_file(const char *config_filename,
-				      const char *old_name, const char *new_name)
+int repo_config_rename_section_in_file(struct repository *r, const char *config_filename,
+				       const char *old_name, const char *new_name)
 {
-	return git_config_copy_or_rename_section_in_file(config_filename,
+	return repo_config_copy_or_rename_section_in_file(r, config_filename,
 					 old_name, new_name, 0);
 }
 
-int git_config_rename_section(const char *old_name, const char *new_name)
+int repo_config_rename_section(struct repository *r, const char *old_name, const char *new_name)
 {
-	return git_config_rename_section_in_file(NULL, old_name, new_name);
+	return repo_config_rename_section_in_file(r, NULL, old_name, new_name);
 }
 
-int git_config_copy_section_in_file(const char *config_filename,
-				      const char *old_name, const char *new_name)
+int repo_config_copy_section_in_file(struct repository *r, const char *config_filename,
+				     const char *old_name, const char *new_name)
 {
-	return git_config_copy_or_rename_section_in_file(config_filename,
+	return repo_config_copy_or_rename_section_in_file(r, config_filename,
 					 old_name, new_name, 1);
 }
 
-int git_config_copy_section(const char *old_name, const char *new_name)
+int repo_config_copy_section(struct repository *r, const char *old_name, const char *new_name)
 {
-	return git_config_copy_section_in_file(NULL, old_name, new_name);
+	return repo_config_copy_section_in_file(r, NULL, old_name, new_name);
 }
 
 /*
diff --git a/config.h b/config.h
index 947307c591..589d6dae26 100644
--- a/config.h
+++ b/config.h
@@ -392,11 +392,11 @@ void repo_config_set_multivar_in_file(struct repository *r,
  * If NULL is passed through `new_name` parameter,
  * the section will be removed from the config file.
  */
-int git_config_rename_section(const char *, const char *);
+int repo_config_rename_section(struct repository *, const char *, const char *);
 
-int git_config_rename_section_in_file(const char *, const char *, const char *);
-int git_config_copy_section(const char *, const char *);
-int git_config_copy_section_in_file(const char *, const char *, const char *);
+int repo_config_rename_section_in_file(struct repository *, const char *, const char *, const char *);
+int repo_config_copy_section(struct repository *, const char *, const char *);
+int repo_config_copy_section_in_file(struct repository *, const char *, const char *, const char *);
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
-	if (git_config_rename_section_in_file(GITMODULES_FILE, sect.buf, NULL) < 0) {
+	if (repo_config_rename_section_in_file(the_repository, GITMODULES_FILE, sect.buf, NULL) < 0) {
 		/* Maybe the user already did that, don't error out here */
 		warning(_("Could not remove .gitmodules entry for %s"), path);
 		strbuf_release(&sect);
-- 
2.46.0.46.g406f326d27.dirty

