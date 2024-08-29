Received: from fout1-smtp.messagingengine.com (fout1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4C8018E37D
	for <git@vger.kernel.org>; Thu, 29 Aug 2024 09:38:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724924335; cv=none; b=d9uuh12nxNR71X1rnBesSTvV32HDWWagQgFqHu9YL2W8vmFvl5d56MYJaivYLqyc4wxxrH0APXCkMZRv5PussrvN3XLbhv2cJ0N39Q0uUHsHBUkOn7vBIb4rHxqNk5NCLJzLNeQfE3zmg04Ndb0t30EYvh49LJ7hHmjZalqiVdM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724924335; c=relaxed/simple;
	bh=Mq0U0WwJtn1EmExkLW4YOYN8JRX2YfmxhsusaMrwobo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=X3FMRyLiaDnje/INR6jq910RRaz8jmQ6erF9bO5WoGOaRJWeFQ3BgpI6C+nkng27E4FUVAsyxskDxA2Z1PQ50t6MYo4cAwN+7WzCGbc/pRzs/0yjLqyeAr/ES1fFMJgrM9zUjSxtnbi/4oP6uCwVHfINdxJmMy83ERrIMQyUX1g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=Z/6EFTua; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=bIoagbc5; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Z/6EFTua";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="bIoagbc5"
Received: from phl-compute-07.internal (phl-compute-07.nyi.internal [10.202.2.47])
	by mailfout.nyi.internal (Postfix) with ESMTP id 054A5138FC3A;
	Thu, 29 Aug 2024 05:38:53 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-07.internal (MEProxy); Thu, 29 Aug 2024 05:38:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1724924333; x=1725010733; bh=2G8FfczyXk
	58W8Hdv/10UbX4Cpv4Vof3RnqLz6X/e/0=; b=Z/6EFTua89gTfJecIM2/Kyp8dv
	ItovRsC7+Y6VUB3i+5wjUj3UvmRRVXsifhWjWpA5QzTrlFms5WQZAtl2UwWxRGyk
	JQF0Qn7xdxR6El6rp4xXeRG6qakcu9s0e8XQ1tram7Zfr2KWu5X/kb+naL4zQntr
	cvpqLgofhwg6wFP+vj67TBRDHUfTKHEYT/W9PNL3Tc/zJWlsu4m/1ICA7+DLa6HI
	dh2DaiVx5ibYNpMPcrcof3o5bIGXIHxLtcrCZFd+F2Pxs+44Hv7Bm4cQIBLX9AQA
	j5fftCiEUA9uPjorzOHdU0SMi+2dWItq/RB8dgRpc+9HDHewfp1gi0a9LGGA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1724924333; x=1725010733; bh=2G8FfczyXk58W8Hdv/10UbX4Cpv4
	Vof3RnqLz6X/e/0=; b=bIoagbc5YjYdK24/YXjWGQLTKGVVFAyE7dSUZkNOIBXj
	DsKaJwH3VXa0tSmfgDBLZ7MRNqECvfTK3mMwianL2Y1ZYXPTesyQD8JzzMNKvwih
	zvhhQvJ97IVwF10x8u5fYzIiYr1reuS3B2rLXhKcIpuipG2D37G9UxRrLBIyDji6
	st1tPAvr95T80aRhDjCpWxGIUNWwWIINQwI1Ch6jQbDXf0cWgiirhgiYuOmFGE3t
	l3w8rF8vvk9wvPyb3qu2Me22W3jUaiD682OiIJAyW8WclbZN9VTxMDAYbhqyHrvV
	mfSDJofWaImrj3RKmfAkZr/tcAE74hsa9KV38klLEg==
X-ME-Sender: <xms:rEHQZg3YuRRkAHtm0ZkWTJcY3u4yqZyEQNH86ROOXJQtxTB74Ce78Q>
    <xme:rEHQZrHHLoUsJNaCRymjajx22_Hu5kjrRWYZNy_FT8_WUlO3dzZ7Jadz_yRQj4kTf
    PFfP_-3iJpg2gx6pw>
X-ME-Received: <xmr:rEHQZo5k4EgMWum1Tt8svc9og1lp74iAKN9ItMnz51goZfLT_g_h7OqxAfdi4L64RDYEOw2ZwxSJlwf7bYXonLD-tRnaXrHEVhi8LCj1oTN5nZU>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrudefgedgudekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefgueeg
    udfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgepudenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepvddpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtoheptggrlhhvihhnfigrnhesghhoohhglhgvrdgtohhmpd
    hrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:rEHQZp3Qrb1VmMvYpzDBHgNwGpQP0r8dc5gRXXUzDtOTFeGcdkeRYw>
    <xmx:rEHQZjGlbp8VrmbyUDqzBs4z-Jux-fIY-MmrdsQeMUa_hdcXJx0gFQ>
    <xmx:rEHQZi_4mJJko1KB-aXbgRoQi0jdIBOP5CZokculP-8m6dDtBT_x-w>
    <xmx:rEHQZol3DdpJnYMdKOzxpk3BMVZPCksR4Em_ySKEkZyMsDaZ45N6-w>
    <xmx:rEHQZoTHvFGGnIv_TNhn_Fs9rhXr35uYq7ajKmRdNwtSHdpHa3XhTff->
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 29 Aug 2024 05:38:52 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 526ae21f (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 29 Aug 2024 09:38:43 +0000 (UTC)
Date: Thu, 29 Aug 2024 11:38:50 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Calvin Wan <calvinwan@google.com>
Subject: [PATCH 08/21] config: make dependency on repo in
 `read_early_config()` explicit
Message-ID: <85e40696cc96c0956de4c9221e7ae49b1789163b.1724923648.git.ps@pks.im>
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

The `read_early_config()` function can be used to read configuration
where a repository has not yet been set up. As such, it is optional
whether or not `the_repository` has already been initialized. If it was
initialized we use its commondir and gitdir. If not, the function will
try to detect the Git directories by itself and, if found, also parse
their config files.

This means that we implicitly rely on `the_repository`. Make this
dependency explicit by passing a `struct repository`. This allows us to
again drop the `USE_THE_REPOSITORY_VARIABLE` define in "config.c".

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 alias.c                |  6 ++++--
 config.c               | 10 ++++------
 config.h               |  2 +-
 help.c                 |  2 +-
 pager.c                |  7 +++++--
 t/helper/test-config.c |  3 ++-
 trace2/tr2_cfg.c       |  4 +++-
 7 files changed, 20 insertions(+), 14 deletions(-)

diff --git a/alias.c b/alias.c
index 4daafd9bdae..1a1a141a0ae 100644
--- a/alias.c
+++ b/alias.c
@@ -1,3 +1,5 @@
+#define USE_THE_REPOSITORY_VARIABLE
+
 #include "git-compat-util.h"
 #include "alias.h"
 #include "config.h"
@@ -37,7 +39,7 @@ char *alias_lookup(const char *alias)
 {
 	struct config_alias_data data = { alias, NULL };
 
-	read_early_config(config_alias_cb, &data);
+	read_early_config(the_repository, config_alias_cb, &data);
 
 	return data.v;
 }
@@ -46,7 +48,7 @@ void list_aliases(struct string_list *list)
 {
 	struct config_alias_data data = { NULL, NULL, list };
 
-	read_early_config(config_alias_cb, &data);
+	read_early_config(the_repository, config_alias_cb, &data);
 }
 
 void quote_cmdline(struct strbuf *buf, const char **argv)
diff --git a/config.c b/config.c
index a8357ea9544..043e1c8a078 100644
--- a/config.c
+++ b/config.c
@@ -6,8 +6,6 @@
  *
  */
 
-#define USE_THE_REPOSITORY_VARIABLE
-
 #include "git-compat-util.h"
 #include "abspath.h"
 #include "advice.h"
@@ -2204,7 +2202,7 @@ static void configset_iter(struct config_set *set, config_fn_t fn, void *data)
 	}
 }
 
-void read_early_config(config_fn_t cb, void *data)
+void read_early_config(struct repository *repo, config_fn_t cb, void *data)
 {
 	struct config_options opts = {0};
 	struct strbuf commondir = STRBUF_INIT;
@@ -2212,9 +2210,9 @@ void read_early_config(config_fn_t cb, void *data)
 
 	opts.respect_includes = 1;
 
-	if (have_git_dir()) {
-		opts.commondir = repo_get_common_dir(the_repository);
-		opts.git_dir = repo_get_git_dir(the_repository);
+	if (repo && repo->gitdir) {
+		opts.commondir = repo_get_common_dir(repo);
+		opts.git_dir = repo_get_git_dir(repo);
 	/*
 	 * When setup_git_directory() was not yet asked to discover the
 	 * GIT_DIR, we ask discover_git_directory() to figure out whether there
diff --git a/config.h b/config.h
index f5fa833cb98..5c730c4f899 100644
--- a/config.h
+++ b/config.h
@@ -198,7 +198,7 @@ int git_config_from_parameters(config_fn_t fn, void *data);
  * `the_repository` has not yet been set up, try to discover the Git
  * directory to read the configuration from.
  */
-void read_early_config(config_fn_t cb, void *data);
+void read_early_config(struct repository *repo, config_fn_t cb, void *data);
 
 /*
  * Read config but only enumerate system and global settings.
diff --git a/help.c b/help.c
index c03863f2265..413c93edaea 100644
--- a/help.c
+++ b/help.c
@@ -618,7 +618,7 @@ const char *help_unknown_cmd(const char *cmd)
 	memset(&other_cmds, 0, sizeof(other_cmds));
 	memset(&aliases, 0, sizeof(aliases));
 
-	read_early_config(git_unknown_cmd_config, NULL);
+	read_early_config(the_repository, git_unknown_cmd_config, NULL);
 
 	/*
 	 * Disable autocorrection prompt in a non-interactive session
diff --git a/pager.c b/pager.c
index 9c24ce62633..40b664f893c 100644
--- a/pager.c
+++ b/pager.c
@@ -1,3 +1,5 @@
+#define USE_THE_REPOSITORY_VARIABLE
+
 #include "git-compat-util.h"
 #include "config.h"
 #include "editor.h"
@@ -92,7 +94,8 @@ const char *git_pager(int stdout_is_tty)
 	pager = getenv("GIT_PAGER");
 	if (!pager) {
 		if (!pager_program)
-			read_early_config(core_pager_config, NULL);
+			read_early_config(the_repository,
+					  core_pager_config, NULL);
 		pager = pager_program;
 	}
 	if (!pager)
@@ -298,7 +301,7 @@ int check_pager_config(const char *cmd)
 	data.want = -1;
 	data.value = NULL;
 
-	read_early_config(pager_command_config, &data);
+	read_early_config(the_repository, pager_command_config, &data);
 
 	if (data.value)
 		pager_program = data.value;
diff --git a/t/helper/test-config.c b/t/helper/test-config.c
index e193079ed54..33247f0e92e 100644
--- a/t/helper/test-config.c
+++ b/t/helper/test-config.c
@@ -96,7 +96,8 @@ int cmd__config(int argc, const char **argv)
 	struct config_set cs;
 
 	if (argc == 3 && !strcmp(argv[1], "read_early_config")) {
-		read_early_config(early_config_cb, (void *)argv[2]);
+		read_early_config(the_repository, early_config_cb,
+				  (void *)argv[2]);
 		return 0;
 	}
 
diff --git a/trace2/tr2_cfg.c b/trace2/tr2_cfg.c
index d96d908bb9d..22a99a0682a 100644
--- a/trace2/tr2_cfg.c
+++ b/trace2/tr2_cfg.c
@@ -1,3 +1,5 @@
+#define USE_THE_REPOSITORY_VARIABLE
+
 #include "git-compat-util.h"
 #include "config.h"
 #include "strbuf.h"
@@ -124,7 +126,7 @@ void tr2_cfg_list_config_fl(const char *file, int line)
 	struct tr2_cfg_data data = { file, line };
 
 	if (tr2_cfg_load_patterns() > 0)
-		read_early_config(tr2_cfg_cb, &data);
+		read_early_config(the_repository, tr2_cfg_cb, &data);
 }
 
 void tr2_list_env_vars_fl(const char *file, int line)
-- 
2.46.0.421.g159f2d50e7.dirty

