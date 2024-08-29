Received: from fhigh5-smtp.messagingengine.com (fhigh5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E9B118E046
	for <git@vger.kernel.org>; Thu, 29 Aug 2024 09:38:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724924323; cv=none; b=rDPxVbIzKK1ZagpCaFtPxbKHwniqQnrwNXcvxS6G7sqGsofSSqyBtkD5OzQN8plJOCtJ8AmYHbQGB6Qw6xgGHGiaSjQ6lWP9aAa6n9cAd5hdBgN+Tc2qnS5omHXBfkycYQr47GkWNhCoTM7vQyvJ9rhXwtBP5qAFjsGCjJwLoRA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724924323; c=relaxed/simple;
	bh=pyrxoOuTkUVhijtviBmzXXvxJfPTjTG1NwYCoXtpwzs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ki2o6w/RIB+Ge6LKUdjw8sNVtAdxo90fPXWXR0gGworovPkSJv+BuFO6n39GVM8XOPFdgcyRvif+0lehdW2OnK4/Fla+Tqkbhcv9duEOX8PUVKA9dJUMBcgziNWOUCKxbJeVSBp13oWjL+RMqcQ+JnNu7AM8wDYXbzOQC6iAjF8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=fhys5DzE; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=PMrJM0pE; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="fhys5DzE";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="PMrJM0pE"
Received: from phl-compute-04.internal (phl-compute-04.nyi.internal [10.202.2.44])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id 133181151C1D;
	Thu, 29 Aug 2024 05:38:41 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Thu, 29 Aug 2024 05:38:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1724924321; x=1725010721; bh=0KD1oH/pqh
	uqlkPaBbdj4g0ez0kH3Ebj+TAcCiojBJI=; b=fhys5DzE/JlOXH23L1oJHAG+x+
	+OLVKhnnChHoH6/dTS5aEwGCEaxmW96cMdRmBgHp28ExQEGKypeZrwY8BOLyA3KK
	nTU2Ul/36ouF+8pVkj/RzTzAT3BKwbOP8YfJwosbq3esbCJbjUXDB8ZDVe52GPpg
	PnkT3XMkk6/9aTikxkrbJY3uDC3QSd00ddvzndIUiu+Bht9CEuEnILiQCUVqgfE3
	F0EtjsrW/zxfcncLEO2HNcFSfQEhDaESKZk+vV8hFcQLUHneJ2UfkdQk9MCLPgYq
	SL+UdDu4GbNzKiQyQJAjC6Y92E4HrBrlfytF+ftCNdQKa3rAIsdn68vIqgWA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1724924321; x=1725010721; bh=0KD1oH/pqhuqlkPaBbdj4g0ez0kH
	3Ebj+TAcCiojBJI=; b=PMrJM0pEagg3MUpXCtErHIwm8nmX7HSkTsg1d/uFWshM
	HIy3SFvDyFpGvxmmeei+uj2rwyLMRiYs5nwu1nDPsG9trMoFvrxSrmA3Z/fCcYCU
	QEOOWSzmpQuaTP6UnFHxOmsCaymWxEWyozM4JUv12fNQ0qT3lHbvUOUCMsHDolHi
	CmKGpJBG1GDMJ+PbVITWC9MmSjNyXN/OAJ/uOXFrz0CPJl3PWOn8Nug81PDV4gwt
	Bj7UA/f41D9EGNQ7a54MiR3KiqXRZIdknGgt7E4QwKDm9srOVkx7J3YW2fijGV3w
	ENkK2SQiwq3wdu7G81a9srJdbBijAbMHT38rT5KcDg==
X-ME-Sender: <xms:oEHQZmsDj3pxNJg-Qb2NAizIUK2s9KqOg46GZHiajbOLo0WyU8fZ-g>
    <xme:oEHQZreykOQ81Tu4unsBSEdi5mNgIaMTF9xcV60Hxl0F5IdMIjC6b1hnWSWoGRNzg
    JUw6bUh6wPK-6TXAg>
X-ME-Received: <xmr:oEHQZhzaQLzKtofqtkkjovwZDLWbvAwEtE-i9YlZMtS2Brc3saMN5BEd7uID8R9-jn4iFMgfq3nhHkw_UBV3cUZnXrI9lPZYUKoE5F3vM6pi3LA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrudefgedgudekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefgueeg
    udfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepvddpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprh
    gtphhtthhopegtrghlvhhinhifrghnsehgohhoghhlvgdrtghomh
X-ME-Proxy: <xmx:oEHQZhNyRQraGiLJAbrR3ZODd2MwbQ4fR2D4Pg0UGtv64mFuCMh-aw>
    <xmx:oUHQZm9o1qNbXGfHMlKJDswvTT8LYA_p-ObtKHeIB5EL4E4RLSfPAw>
    <xmx:oUHQZpXNWG2JlD8xxpsg-xdcpPKOV--XFIiReDiFjiImdqZok4XgNA>
    <xmx:oUHQZvf3fIXPIBoUy8EOseQNRyaW2Jk9sU6SZvOzzIWBDNzPFDhb6g>
    <xmx:oUHQZoJ0Vg8U1RzQYaHXwNPDrmekbOm57x5CnWuw3MbCgdi_do5ZNWe7>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 29 Aug 2024 05:38:40 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 00784d8b (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 29 Aug 2024 09:38:31 +0000 (UTC)
Date: Thu, 29 Aug 2024 11:38:38 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Calvin Wan <calvinwan@google.com>
Subject: [PATCH 05/21] environment: make `get_graft_file()` accept a
 repository
Message-ID: <ac27d7128a41e4693a19afe0b1931d0c1db75d09.1724923648.git.ps@pks.im>
References: <cover.1724923648.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1724923648.git.ps@pks.im>

The `get_graft_file()` function retrieves the path to the graft file of
`the_repository`. Make it accept a `struct repository` such that it can
work on arbitrary repositories and make it part of the repository
subsystem. This reduces our reliance on `the_repository` and clarifies
scope.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/replace.c | 2 +-
 commit.c          | 4 ++--
 environment.c     | 7 -------
 environment.h     | 2 --
 repository.c      | 7 +++++++
 repository.h      | 1 +
 6 files changed, 11 insertions(+), 12 deletions(-)

diff --git a/builtin/replace.c b/builtin/replace.c
index 34cc4672bc1..04fbe580895 100644
--- a/builtin/replace.c
+++ b/builtin/replace.c
@@ -514,7 +514,7 @@ static int create_graft(int argc, const char **argv, int force, int gentle)
 
 static int convert_graft_file(int force)
 {
-	const char *graft_file = get_graft_file(the_repository);
+	const char *graft_file = repo_get_graft_file(the_repository);
 	FILE *fp = fopen_or_warn(graft_file, "r");
 	struct strbuf buf = STRBUF_INIT, err = STRBUF_INIT;
 	struct strvec args = STRVEC_INIT;
diff --git a/commit.c b/commit.c
index 3238772f521..1f710a92a17 100644
--- a/commit.c
+++ b/commit.c
@@ -292,14 +292,14 @@ static int read_graft_file(struct repository *r, const char *graft_file)
 
 void prepare_commit_graft(struct repository *r)
 {
-	char *graft_file;
+	const char *graft_file;
 
 	if (r->parsed_objects->commit_graft_prepared)
 		return;
 	if (!startup_info->have_repository)
 		return;
 
-	graft_file = get_graft_file(r);
+	graft_file = repo_get_graft_file(r);
 	read_graft_file(r, graft_file);
 	/* make sure shallows are read */
 	is_repository_shallow(r);
diff --git a/environment.c b/environment.c
index 10ef77576c3..371f01a705d 100644
--- a/environment.c
+++ b/environment.c
@@ -306,13 +306,6 @@ int odb_pack_keep(const char *name)
 	return open(name, O_RDWR|O_CREAT|O_EXCL, 0600);
 }
 
-char *get_graft_file(struct repository *r)
-{
-	if (!r->graft_file)
-		BUG("git environment hasn't been setup");
-	return r->graft_file;
-}
-
 static void set_git_dir_1(const char *path)
 {
 	xsetenv(GIT_DIR_ENVIRONMENT, path, 1);
diff --git a/environment.h b/environment.h
index ff590cfff73..d12c48481b6 100644
--- a/environment.h
+++ b/environment.h
@@ -1,7 +1,6 @@
 #ifndef ENVIRONMENT_H
 #define ENVIRONMENT_H
 
-struct repository;
 struct strvec;
 
 /*
@@ -106,7 +105,6 @@ int have_git_dir(void);
 extern int is_bare_repository_cfg;
 int is_bare_repository(void);
 extern char *git_work_tree_cfg;
-char *get_graft_file(struct repository *r);
 void set_git_dir(const char *path, int make_realpath);
 const char *get_git_namespace(void);
 const char *strip_namespace(const char *namespaced_ref);
diff --git a/repository.c b/repository.c
index a9bbde80b5d..cdefcb4002d 100644
--- a/repository.c
+++ b/repository.c
@@ -119,6 +119,13 @@ const char *repo_get_index_file(struct repository *repo)
 	return repo->index_file;
 }
 
+const char *repo_get_graft_file(struct repository *repo)
+{
+	if (!repo->graft_file)
+		BUG("git environment hasn't been setup");
+	return repo->graft_file;
+}
+
 static void repo_set_commondir(struct repository *repo,
 			       const char *commondir)
 {
diff --git a/repository.h b/repository.h
index 15660ac2f19..ad0f984b444 100644
--- a/repository.h
+++ b/repository.h
@@ -210,6 +210,7 @@ const char *repo_get_git_dir(struct repository *repo);
 const char *repo_get_common_dir(struct repository *repo);
 const char *repo_get_object_directory(struct repository *repo);
 const char *repo_get_index_file(struct repository *repo);
+const char *repo_get_graft_file(struct repository *repo);
 
 /*
  * Define a custom repository layout. Any field can be NULL, which
-- 
2.46.0.421.g159f2d50e7.dirty

