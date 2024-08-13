Received: from fout2-smtp.messagingengine.com (fout2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B8F118B486
	for <git@vger.kernel.org>; Tue, 13 Aug 2024 09:13:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723540429; cv=none; b=rmrowz6R795E2HKmj0Ak4d72pLXaXIY/Bs9O4l6y2wxsx5y6fp3ZS3hGLY+56oqurHqvwNyvPyGZGSnxfPAjtlfsqwFmzUDySeV8K3Er4V9cgK8QYwNkbr8oL+jZoft9iunZN6++yO/CrJLHBcJs02jMZmfnH6V5kGWVAjWNzXA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723540429; c=relaxed/simple;
	bh=I15fssooDh6Pchtrdh3RHaJgk4wfx2/5caKMLFe4pTE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=k00VwL/KeWdQTD9+4QHjzVu2p4kn4+3SY+K1TdhNEiSjlfOK9j/0y6FXNXMwIxVBayrEIJcM3U66dsWLhQg9UWjkeQ/wZX3WHGZN1mOrDC9BiPJP4clfY96f+8oGK7tIxC/ZEwgdrEz2RIopyw0lD20jmdSAmu/bTiR8OWOkGOQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=ZhJWobHg; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=H9Rdaax8; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="ZhJWobHg";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="H9Rdaax8"
Received: from phl-compute-08.internal (phl-compute-08.nyi.internal [10.202.2.48])
	by mailfout.nyi.internal (Postfix) with ESMTP id 6465E138FD24;
	Tue, 13 Aug 2024 05:13:46 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-08.internal (MEProxy); Tue, 13 Aug 2024 05:13:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1723540426; x=1723626826; bh=PAck6YOPSS
	wo1ZSboxF1439Nd2EubxenVhoKYPXd4WE=; b=ZhJWobHg4Ga6OoP1Mb4TC1UXmr
	8AlW5AvNRD66OphGmdk4eiLDoWT8Gb+7e2htkrv1v+8zkGuGS/UJCfkQ5lYJFv29
	rVIyuJ5nWWus/Q9tEQEytCP1974wn4b1T2g0/VAQnEelxgnF+8aD46LcALVnLV+y
	mW+siH4480X8BlIb68Cv3H1uOpyrg5K1olJ8paGOQXbJmlze+C46GJ91ju/jK1RS
	wRkO+KtQUWwJuPnCNYRBCkXXcBeyua2yWh5YCigp0MDwk28PNeX8B6WhsOdrJ0G9
	n4nfZULtvigNgAN1iQ9BKBVS5p8LIiGRMIi919U0BH4/rvKqumhfm/5xJGig==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1723540426; x=1723626826; bh=PAck6YOPSSwo1ZSboxF1439Nd2Eu
	bxenVhoKYPXd4WE=; b=H9Rdaax8S+z5ivjui4OiBYr4tCIurdu+zcaZTPc3eRqM
	utJgWVLnSoVWv/bZRYSItqtdlHzwbido6DNUvhiU4oLIEes/jmV/qKxytZJv0kXp
	5pKvJoPZB0avZhfITDNEcxehxhvI3XReqjE8JFxk4cwPw+AJM1ZzUROLDCfpE9pT
	2eaUKNisvjw+r3MqMAbll3zJ4HneSxKcLmvW4cJeOpJCTW5FSv936pfDZc65k7ZZ
	DqBLsxhAnEL6MuXt1+qBQsS1tBKTLiMiyPKG+xJ6bxwkL8EDiv+g25ij5DQFhvbj
	5TM8Q6vfa75oDz6YZh8ElU/XyxyDYWMbvAEJF5niiQ==
X-ME-Sender: <xms:yiO7Zo1YX6MBBDE052GT45uUya69CNtXRCxKzfw0_BU8HQVthAsQrQ>
    <xme:yiO7ZjF-GWmAIurq4D6Cg4_Ai1kLlGUiADqt_VpBmsJjcCeG3tzqy7oCJMdzzYZ_0
    _FoeknKCH-39at4hA>
X-ME-Received: <xmr:yiO7Zg4Zx3EkSRXhEKQ3MY5KEscKZZmiGQRaysrQh22HAZVyUYHMSEu4WBGvz4YyrGHRN2TZDEKTmMUXeK6V9JjeOXc9hbN_Sac2DhbzLRKi3g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddruddtvddguddvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefgueeg
    udfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepfedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprh
    gtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhmpdhrtghpthhtohepjhhlthho
    sghlvghrsehgmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:yiO7Zh2rE9SbktNN1MJFX5YjDBrNZ2gB7CiP_bSk9ORTxFZ4ooS5kQ>
    <xmx:yiO7ZrGtGxlv8Nhtz8i2UbUnWiyBCYQBOBHLjyZho63sBYKjlwvXwA>
    <xmx:yiO7Zq-W6Kxrts7Lj3Hrzb73AQz1-Wy2Uy-Hbr9jbS-UnsWjQfPOWw>
    <xmx:yiO7Zgn0WrQLu9dxgmGRCbKD4fdskPeRaaS96dVKGTSWCfmcsHXlTw>
    <xmx:yiO7ZjCDhR1yG6skeBy5KXUGceEGdoCcaGFkE_O094zj6mCa8bwk2pm3>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 13 Aug 2024 05:13:45 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 654aad23 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 13 Aug 2024 09:13:28 +0000 (UTC)
Date: Tue, 13 Aug 2024 11:13:43 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Justin Tobler <jltobler@gmail.com>, Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 08/20] config: introduce missing setters that take repo as
 parameter
Message-ID: <e316491e56a5a53a0fe9bacc0f67eabe5c3ca18b.1723540226.git.ps@pks.im>
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

While we already provide some of the config-setting interfaces with a
`struct repository` as parameter, others only have a variant that
implicitly depends on `the_repository`. Fill in those gaps such that we
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
@@ -3178,21 +3178,39 @@ static void maybe_remove_section(struct config_store_data *store,
 		*end_offset = store->parsed[store->parsed_nr - 1].end;
 }
 
+int repo_config_set_in_file_gently(struct repository *r, const char *config_filename,
+				   const char *key, const char *comment, const char *value)
+{
+	return repo_config_set_multivar_in_file_gently(r, config_filename, key, value, NULL, comment, 0);
+}
+
 int git_config_set_in_file_gently(const char *config_filename,
 				  const char *key, const char *comment, const char *value)
 {
-	return git_config_set_multivar_in_file_gently(config_filename, key, value, NULL, comment, 0);
+	return repo_config_set_in_file_gently(the_repository, config_filename,
+					      key, comment, value);
+}
+
+void repo_config_set_in_file(struct repository *r, const char *config_filename,
+			     const char *key, const char *value)
+{
+	repo_config_set_multivar_in_file(r, config_filename, key, value, NULL, 0);
 }
 
 void git_config_set_in_file(const char *config_filename,
 			    const char *key, const char *value)
 {
-	git_config_set_multivar_in_file(config_filename, key, value, NULL, 0);
+	repo_config_set_in_file(the_repository, config_filename, key, value);
+}
+
+int repo_config_set_gently(struct repository *r, const char *key, const char *value)
+{
+	return repo_config_set_multivar_gently(r, key, value, NULL, 0);
 }
 
 int git_config_set_gently(const char *key, const char *value)
 {
-	return git_config_set_multivar_gently(key, value, NULL, 0);
+	return repo_config_set_gently(the_repository, key, value);
 }
 
 int repo_config_set_worktree_gently(struct repository *r,
@@ -3209,13 +3227,18 @@ int repo_config_set_worktree_gently(struct repository *r,
 	return repo_config_set_multivar_gently(r, key, value, NULL, 0);
 }
 
-void git_config_set(const char *key, const char *value)
+void repo_config_set(struct repository *r, const char *key, const char *value)
 {
-	git_config_set_multivar(key, value, NULL, 0);
+	repo_config_set_multivar(r, key, value, NULL, 0);
 
 	trace2_cmd_set_config(key, value);
 }
 
+void git_config_set(const char *key, const char *value)
+{
+	repo_config_set(the_repository, key, value);
+}
+
 char *git_config_prepare_comment_string(const char *comment)
 {
 	size_t leading_blanks;
@@ -3293,11 +3316,12 @@ static void validate_comment_string(const char *comment)
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
 	int fd = -1, in_fd = -1;
 	int ret;
@@ -3317,7 +3341,7 @@ int git_config_set_multivar_in_file_gently(const char *config_filename,
 	store.multi_replace = (flags & CONFIG_FLAGS_MULTI_REPLACE) != 0;
 
 	if (!config_filename)
-		config_filename = filename_buf = git_pathdup("config");
+		config_filename = filename_buf = repo_git_path(r, "config");
 
 	/*
 	 * The lock serves a purpose in addition to locking: the new
@@ -3526,7 +3550,7 @@ int git_config_set_multivar_in_file_gently(const char *config_filename,
 	ret = 0;
 
 	/* Invalidate the config cache */
-	git_config_clear();
+	repo_config_clear(r);
 
 out_free:
 	rollback_lock_file(&lock);
@@ -3543,12 +3567,24 @@ int git_config_set_multivar_in_file_gently(const char *config_filename,
 	goto out_free;
 }
 
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
+	return repo_config_set_multivar_in_file_gently(the_repository, config_filename,
+						       key, value, value_pattern,
+						       comment, flags);
+}
+
+void repo_config_set_multivar_in_file(struct repository *r,
+				      const char *config_filename,
+				      const char *key, const char *value,
+				      const char *value_pattern, unsigned flags)
+{
+	if (!repo_config_set_multivar_in_file_gently(r, config_filename, key, value,
+						     value_pattern, NULL, flags))
 		return;
 	if (value)
 		die(_("could not set '%s' to '%s'"), key, value);
@@ -3556,6 +3592,14 @@ void git_config_set_multivar_in_file(const char *config_filename,
 		die(_("could not unset '%s'"), key);
 }
 
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
@@ -3576,12 +3620,21 @@ int repo_config_set_multivar_gently(struct repository *r, const char *key,
 	return res;
 }
 
+void repo_config_set_multivar(struct repository *r,
+			      const char *key, const char *value,
+			      const char *value_pattern, unsigned flags)
+{
+	char *file = repo_git_path(r, "config");
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
 
 static size_t section_name_match (const char *buf, const char *name)
diff --git a/config.h b/config.h
index 54b47dec9e..b13e1bfb8d 100644
--- a/config.h
+++ b/config.h
@@ -298,14 +298,18 @@ int git_config_pathname(char **, const char *, const char *);
 int git_config_expiry_date(timestamp_t *, const char *, const char *);
 int git_config_color(char *, const char *, const char *);
 int git_config_set_in_file_gently(const char *, const char *, const char *, const char *);
+int repo_config_set_in_file_gently(struct repository *r, const char *config_filename,
+				   const char *key, const char *comment, const char *value);
 
 /**
  * write config values to a specific config file, takes a key/value pair as
  * parameter.
  */
 void git_config_set_in_file(const char *, const char *, const char *);
+void repo_config_set_in_file(struct repository *, const char *, const char *, const char *);
 
 int git_config_set_gently(const char *, const char *);
+int repo_config_set_gently(struct repository *r, const char *, const char *);
 
 /**
  * Write a config value that should apply to the current worktree. If
@@ -318,6 +322,7 @@ int repo_config_set_worktree_gently(struct repository *, const char *, const cha
  * write config values to `.git/config`, takes a key/value pair as parameter.
  */
 void git_config_set(const char *, const char *);
+void repo_config_set(struct repository *, const char *, const char *);
 
 int git_config_parse_key(const char *, char **, size_t *);
 
@@ -341,9 +346,11 @@ int git_config_parse_key(const char *, char **, size_t *);
 #define CONFIG_FLAGS_FIXED_VALUE (1 << 1)
 
 int git_config_set_multivar_gently(const char *, const char *, const char *, unsigned);
-void git_config_set_multivar(const char *, const char *, const char *, unsigned);
 int repo_config_set_multivar_gently(struct repository *, const char *, const char *, const char *, unsigned);
+void git_config_set_multivar(const char *, const char *, const char *, unsigned);
+void repo_config_set_multivar(struct repository *r, const char *, const char *, const char *, unsigned);
 int git_config_set_multivar_in_file_gently(const char *, const char *, const char *, const char *, const char *, unsigned);
+int repo_config_set_multivar_in_file_gently(struct repository *, const char *, const char *, const char *, const char *, const char *, unsigned);
 
 char *git_config_prepare_comment_string(const char *);
 
@@ -372,6 +379,12 @@ void git_config_set_multivar_in_file(const char *config_filename,
 				     const char *value,
 				     const char *value_pattern,
 				     unsigned flags);
+void repo_config_set_multivar_in_file(struct repository *r,
+				      const char *config_filename,
+				      const char *key,
+				      const char *value,
+				      const char *value_pattern,
+				      unsigned flags);
 
 /**
  * rename or remove sections in the config file
-- 
2.46.0.46.g406f326d27.dirty

