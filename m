Received: from fout7-smtp.messagingengine.com (fout7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17FB4171658
	for <git@vger.kernel.org>; Fri, 30 Aug 2024 09:09:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725008963; cv=none; b=hw1ERl9zL6Q+hqvjHz2ua83INlgLS9B1N+LRB1oqIDVaB001Tti56dxfdFFGhH4A6WXlHfnzWcZsb30/5xdr9Mm718fMVGXZmpTRGxgd3z9uaH/6jf+ED7jpUMPocz5+pr3vw8b9affzmv6DMMzkiVxBVeXJYrXNC6e5BOQISAA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725008963; c=relaxed/simple;
	bh=Mq0U0WwJtn1EmExkLW4YOYN8JRX2YfmxhsusaMrwobo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WDePL99aoHoz9yYcphiW7RccrVjd6QbMyJymkYe5cL0jKJqUr4Oc2EagJ9ZYBwk/vc0etw963PIKaRg2ceHMje+QD1RxHtzppeizqqjc3Jv4swvhTNtO3JGowXn2Wl+fkLEAEq2QpwnX/vhCUtNqqS2uuL28Cc94OxrWrTdBZWM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=pOiNqv8E; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=gVEdpXCa; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="pOiNqv8E";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="gVEdpXCa"
Received: from phl-compute-07.internal (phl-compute-07.nyi.internal [10.202.2.47])
	by mailfout.nyi.internal (Postfix) with ESMTP id 6BC601380272;
	Fri, 30 Aug 2024 05:09:21 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-07.internal (MEProxy); Fri, 30 Aug 2024 05:09:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1725008961; x=1725095361; bh=2G8FfczyXk
	58W8Hdv/10UbX4Cpv4Vof3RnqLz6X/e/0=; b=pOiNqv8EpIGCebNufLLWPjLRJX
	62LfQgARGjzVmdk4yPZz9ZakAPK8u3pWWIdnqcekjYbsecV6553gAuqM883yQ3oQ
	fjiqmlaWC+HPYinJrLXwif1V64cwBLeC7sCrcb3DPFXaYVDZ9vmR9NGlaOtr+iF4
	BhJQ9e/FUacaHU1U4AiMedIgvMp1b2S4HGUzsHu9Xb1dTvWkKkCbk2LsW6djfozF
	uNDVJSPRh6nBzP80FSy9QWgT29o71JBYyAJJIWFQKoODHh1i4T3m7x8gb8G4aGUc
	loCbkvOf4XKk/M5RpguwFBc3ybA0DPF3yJrkzIi89Na4pOPIedQLWnBW08sw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1725008961; x=1725095361; bh=2G8FfczyXk58W8Hdv/10UbX4Cpv4
	Vof3RnqLz6X/e/0=; b=gVEdpXCaWbsKsF3sxvj56T/1uGqmUweFtQ5EEwY1Xdvm
	O/9jd+V8ascHoUkqwdhuI2s73SDi+NfJIF5/JQaFvHn7h/gntPUoaEnWqqvbEBmw
	Ap2jf7RxPmQfvx/MEIryh4hA2vAF+g1KAY1b8FoEO9OZLuXal63LqO0qQvJaDzyQ
	QEJlvokFtWHUvd7noEoBV9dICpz+mwDw5XMz3f/2vu3arLffQJaQUVf82sPvgxsw
	NJrqjcxRbCjHqkMKA0mk8+iItJS+jPkWfbe52tQdAnXTaAj/g9TUnwO/q0/A4reJ
	N8daQkciW7fdV+T70wyYRy6b4VtMMnXkD0v4n8qwjA==
X-ME-Sender: <xms:QYzRZmDjFT-1jVswrNGLXt-ucphnYnjsDkrvLrPZGHIzev-NNgTIsA>
    <xme:QYzRZggsEKuvJGNZAMTf8A2Y3KCXNrodwBQlC2dtBTmUu2OmNq_qw5DjXLm65N8A0
    KGrWBWwx4UZcOlSRA>
X-ME-Received: <xmr:QYzRZplHMtxjrHSwR0IrwFawoKviG04rnb3jfJtd5bfmUF9sKLUNTJWuypmE2J5Gi-Kty88XyzJloJk8PlGTbltZl_J8jGqp85nkag2bk7pIgHynyA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrudefiedguddvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefgueeg
    udfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepgedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtoheptggrlhhvihhnfigrnhesghhoohhglhgvrdgtohhmpd
    hrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehj
    lhhtohgslhgvrhesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtshhtvghrsehpoh
    gsohigrdgtohhm
X-ME-Proxy: <xmx:QYzRZkxeq-GU6_bcncpyXXxW5FLcEQ1soyfN82nNKAS7KehtrfmnZA>
    <xmx:QYzRZrQyAx9aEYpjE9T81570nNJtj8oOEsOvWAeU9KdBUqC7MUdEJg>
    <xmx:QYzRZvbqwGqmtxNAW7QiCStqoqXcMsQ32rzZ0ES4csBryy1gSoyTsA>
    <xmx:QYzRZkSgoiigh61tUBqInyzRjXZb1rhrCxykfQxCBFCEISXKhvryVg>
    <xmx:QYzRZpNzRvmAIkb9L9hC_t_OS5FLPADBQyDKiCaqdM2L_vvO2c5UWT2t>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 30 Aug 2024 05:09:20 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id c2064d1c (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 30 Aug 2024 09:09:09 +0000 (UTC)
Date: Fri, 30 Aug 2024 11:09:18 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Calvin Wan <calvinwan@google.com>, Justin Tobler <jltobler@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 08/21] config: make dependency on repo in
 `read_early_config()` explicit
Message-ID: <b8aa5dcc0b67e3957dc65f38b7dc02a97cc096a7.1725008898.git.ps@pks.im>
References: <cover.1724923648.git.ps@pks.im>
 <cover.1725008897.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1725008897.git.ps@pks.im>

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

