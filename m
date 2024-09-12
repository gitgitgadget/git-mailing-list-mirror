Received: from fhigh6-smtp.messagingengine.com (fhigh6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2C151A0BCE
	for <git@vger.kernel.org>; Thu, 12 Sep 2024 11:29:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726140589; cv=none; b=hFQxoEyx9xkFRDIt3NvjuuaAFC5Df5/ailNJSgm56TTrQLpO+Rn2moZuxrpxHjAdxwzlc/4NtMgxfcoqXUAlPSiyri/XTG7qHYbith3/haWQuSaNmcYahv/2jnYb/4VeYRTwmnZKvMclsGzPC2XCph8OhQxvbAgwoqNkr4wvi50=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726140589; c=relaxed/simple;
	bh=bAJswoDzfxaX16rF+qk1R1DcHxDVE4DJyxZ62mhIj1I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gWEoos4NkPkHvkEhM0hLCx5ja8phfE6k1HTzFj2C2AwdU9hrvH3Z9WoRwtfMeAxTutI6HNUL0M+LnNAsJQY7K0/r4ibiW0n+Qcr3WgN9Fbudb0MwaNDY+3zordaZZQkppuI9JD3XS9SUurSQtSoghVFPj66bGEtyDG17RuulJB8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=MnNXkJr5; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=qkwWgqlO; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="MnNXkJr5";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="qkwWgqlO"
Received: from phl-compute-08.internal (phl-compute-08.phl.internal [10.202.2.48])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 3C81311405E3;
	Thu, 12 Sep 2024 07:29:47 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-08.internal (MEProxy); Thu, 12 Sep 2024 07:29:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1726140587; x=1726226987; bh=dHQOZZFI/M
	cq+23BlvBJVNXsJfpmkGp4NZk9M6rc/wE=; b=MnNXkJr5FwNg5gsnAHqjA6rdlq
	mc8kQPqu29YRyCFqmQQ5UXO6TYBe3BSyE6PrbVpUlzF9EUsDLGAXVfVtdwj3DwqI
	5LKnz3fLEGBNDq/zlnTKel1JvRcx++EUDANNLtzTBw03i6iISTkS9tHKvd5ptmzC
	iyWDwaHDg9ot8AVu7Y17YAAsiJ6ilKb2Da+gu6kP0E3Zv0is/cpZ9xte15z6+swv
	/imcB9j+aNav1fVhrxS+bftKNe7bGGITZZmV7Jpr2g3lqn6Qx/w1rX83KuXwEUiU
	QCeN5MQT0ptlnXoH6YrYZvCnubzC9KPW3G2vbsmZWyElC3vLYAoTQZiQz8Ow==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1726140587; x=1726226987; bh=dHQOZZFI/Mcq+23BlvBJVNXsJfpm
	kGp4NZk9M6rc/wE=; b=qkwWgqlOj8yzLhmqKRPp6uQM56DOAeIj8KyTDTFv3m0B
	hjfkSgCZR3x2ArhqKpKNoqJCH6lk8mucjVF3O8g+odBOWyNJctQzi+iRhdCMYF/w
	iYIdehhOfQRgCqY9RSkq+ZdWhdRhGC9YoxgKvB7h3pufJo1YGicRk5Fg3y3FaA0+
	hrCXJODgrGcKZWKDyIXJvB/luzP389cOxFFmXaUgnW/vpyNQSyc2K4xvgiqhM5lT
	3Vm1iUdFn1+9cUXPC6QUvbDB77ND71GKrRrHE7MomPqs2G3ZItRNT34a45dr0CR3
	7PSw0uLFVKrYrhGfjxJheCsP2ZoHCmnawek6sxa2sw==
X-ME-Sender: <xms:qtDiZgy9ptZgknczJDYHeyCKfMpoVjpcxL4xaK0cXkFgNmmgn94E4g>
    <xme:qtDiZkRi3SkscEXMOkVu5j9B0wTYoZimGDywawrsJ6Pb-8vgxLXDIVXDLDvXfhTmV
    HdjzGdh0FHExkKV9Q>
X-ME-Received: <xmr:qtDiZiVHnD89W-KK-Br-DYfbKavQs-jXfWPC2oda_9WNm2g2M9O-icDs4_M1JC9oRvpZ_iLZL7L71aa7ATAsbhV5yre1E7wj_d6bJiJ3YGfF>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrudejfedggeduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefgueeg
    udfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohephedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepkhgrrhhthhhikhdrudekkeesghhmrghilhdrtghomh
    dprhgtphhtthhopehjlhhtohgslhgvrhesghhmrghilhdrtghomhdprhgtphhtthhopegt
    rghlvhhinhifrghnsehgohhoghhlvgdrtghomhdprhgtphhtthhopehgihhtsehvghgvrh
    drkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtgho
    mh
X-ME-Proxy: <xmx:qtDiZuj0dG50Hi19upvmIk98dpk898GjxeThXVpPGNOceKS-aAXkAw>
    <xmx:qtDiZiB7-E1AGQyXSJAsxxPXxnoiwSDXCIHoYmRUrCjQGbZBaXo--Q>
    <xmx:qtDiZvLI0TNz5wltlNPwbx2--ZKl7wlZTWMy5MZntUdWEiym3vog6Q>
    <xmx:qtDiZpCMkRg_g3Rke8ubB2ukDa-BsyyZOoW0h83XNMt0fhXMEskvcw>
    <xmx:q9DiZp7RtnfSu7ZvEOzyrKpfD44td-AhKs3x3z_vuBK7elLKi_fVCqi6>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 12 Sep 2024 07:29:45 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 61a990fa (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 12 Sep 2024 11:29:37 +0000 (UTC)
Date: Thu, 12 Sep 2024 13:29:45 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Calvin Wan <calvinwan@google.com>, Justin Tobler <jltobler@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	karthik nayak <karthik.188@gmail.com>
Subject: [PATCH v3 08/21] config: make dependency on repo in
 `read_early_config()` explicit
Message-ID: <1ed3d3f1d7142129212750602585550c69aa599e.1726139990.git.ps@pks.im>
References: <cover.1724923648.git.ps@pks.im>
 <cover.1726139990.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1726139990.git.ps@pks.im>

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
2.46.0.551.gc5ee8f2d1c.dirty

