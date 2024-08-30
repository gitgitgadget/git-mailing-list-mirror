Received: from fout7-smtp.messagingengine.com (fout7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A48D716FF2A
	for <git@vger.kernel.org>; Fri, 30 Aug 2024 09:09:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725008979; cv=none; b=eomUVEaQeXQGadgiQyCME8wei/jP51eFFOD1GltabnC3E0RQ1wcRZvllYFdbt4KpPxxoSEihXuJJg5N3rIon+JjRkb5LcDdNh583YbTmMCqiLIR/bn1MAqmHBS4oLqFwWV6VGPfDkprnSvk4K5vDOYn3DORBQhl0xPN+jZHLPvk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725008979; c=relaxed/simple;
	bh=Tfm41KthbPJIKekzItTrXa7/jlVh+RROJe9u7kv783E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PyTWduwBuo+x3z4q++V2eqj7TJFFAaTM3n5244ocGK5+IS2ZATk0XXYAOdsKEzU6Yd/+kw5iWoLIj2/9S76/yYMpd30Eqn+YwneW0SUdPDrtWoMdNqh8N/5VI5lyeuAx2c3eSX8Af4HxRxhCni0gwiDwDcHt9bL/vtAIyqVkxdo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=rFMGuWJy; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=C1AX6nB+; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="rFMGuWJy";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="C1AX6nB+"
Received: from phl-compute-03.internal (phl-compute-03.nyi.internal [10.202.2.43])
	by mailfout.nyi.internal (Postfix) with ESMTP id C5E151380277;
	Fri, 30 Aug 2024 05:09:36 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-03.internal (MEProxy); Fri, 30 Aug 2024 05:09:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1725008976; x=1725095376; bh=dot8BMVqQL
	Iv8o7x1bB64VwtSyFPLviYpW9L8yovN6M=; b=rFMGuWJyp1sq7ZX8qgoanGg1QG
	EbzGAGA9AjPCQup/HCzOTOV88I0OwRGVympU7Zja9+XXLqUJUB9v62UPZ7fo7DAa
	ZtzFO3xa7vHbgV1qO6jZiqiIGxxQAi8ByBHul7lkQvH3YtFIPzj0jao1qzWFZW+W
	vMtxP13d9l5Owe8wN5mtXVGFPZMsqaiiNOeQyRXcEi9lKKaHG2uWnyKs6mR9h1vT
	+kXRyFoVNBKj94I5EBAFwf08ncGARjv0WcBA64uWhU8yfOpfLUPRY0RZEUsBbUgd
	mJqg/E6ZCQmF2xhEumKdnn+0VVNjM1wAaS8gOtK1xe6ovmC+Yba1WBdt8N+A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1725008976; x=1725095376; bh=dot8BMVqQLIv8o7x1bB64VwtSyFP
	LviYpW9L8yovN6M=; b=C1AX6nB+Fzwg4b61xeWRIC4RnlIORQbZYay2qqJwNn68
	f8RSHB15wIS/K+vODUt6nn8BO71iAZsu2OsgTXlOTfLUDHSRX4FxHZEImjU1OfzC
	xR45Itg95FWmfieddyhaXxxcIWiWlCalKuBs3Cbgb6h1QilCfnYIpOMo3ziQ27g7
	qUBvCXEXcvOhBxc5wKmda+Z9x0hTGMESus5cjVK2Q8yrnjSD9FjNn48tmkPjSsfd
	nJVe0v9iilU6h5jpW5J86ieGjC47iVmm+m8AXJz/Pp/ls1WNmYTKQtQlJfFdxVmd
	ZFfgU2jlHlbM/VhvdgHhlgFdSaHIz7GM0cw9fhoX1Q==
X-ME-Sender: <xms:UIzRZt3Yty4pZsud78iTXoMKgt5kKJSuGmY_N07LLsEXCsZQ6TiV9g>
    <xme:UIzRZkEA0OrBHHIhJ5yRPz_lwvzbCPmYDBCGaq9XhMdUpJXZrU4r2KM_Tpl9Wywar
    WKIcB6KaX_T2qDznA>
X-ME-Received: <xmr:UIzRZt7ZFmzY4tiXWNO3HMzJmKROsuWbujkTjsfE03Mvj6hB_r15ShX2EszXX7sCtSzcRCZm3AMYml2z-WaYnRd_TUZ_NpsL4HtSl1zr_MKilEgdFw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrudefiedguddvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefgueeg
    udfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgepudenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepgedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomhdprhgtph
    htthhopegtrghlvhhinhifrghnsehgohhoghhlvgdrtghomhdprhgtphhtthhopehjlhht
    ohgslhgvrhesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrh
    hnvghlrdhorhhg
X-ME-Proxy: <xmx:UIzRZq2jAy_b9u7Mz3LPtVVpiG93jRjbhwBmf7mkA5y6FRhGHbpSvg>
    <xmx:UIzRZgHjWW-nepCeajlRW77osPENOhJ3TeScqPu873gB7cxGlp7azw>
    <xmx:UIzRZr8pC88Z-bXyJM1Tvt8NCfnXCa5cuFszSYyQmXUxkVbYtHR70g>
    <xmx:UIzRZtnx8799zB_yBJ3Qw7r5wSw3Yl4DWD7n-WXTQERFNUmpo1IeWw>
    <xmx:UIzRZsiC9lGrSizKxL4u6YLpd30QpwESEpbtEc1m5lbQ3t72bJc2r7lU>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 30 Aug 2024 05:09:35 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id fb251241 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 30 Aug 2024 09:09:24 +0000 (UTC)
Date: Fri, 30 Aug 2024 11:09:32 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Calvin Wan <calvinwan@google.com>, Justin Tobler <jltobler@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 13/21] environment: guard state depending on a repository
Message-ID: <9a3f466b53040d693ed9b2c2390d391a5420aad1.1725008898.git.ps@pks.im>
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

In "environment.h" we have quite a lot of functions and variables that
either explicitly or implicitly depend on `the_repository`.

The implicit set of stateful declarations includes for example variables
which get populated when parsing a repository's Git configuration. This
set of variables is broken by design, as their state often depends on
the last repository config that has been parsed. So they may or may not
represent the state of `the_repository`.

Fixing that is quite a big undertaking, and later patches in this series
will demonstrate a solution for a first small set of those variables. So
for now, let's guard these with `USE_THE_REPOSITORY_VARIABLE` so that
callers are aware of the implicit dependency.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 compat/mingw.c             |  2 ++
 compat/win32/path-utils.c  |  2 ++
 config.c                   |  2 ++
 environment.h              | 25 ++++++++++++++++++++++++-
 name-hash.c                |  3 +++
 path.c                     |  2 ++
 preload-index.c            |  3 +++
 prompt.c                   |  2 ++
 refs/files-backend.c       |  2 ++
 sparse-index.c             |  2 ++
 statinfo.c                 |  2 ++
 t/helper/test-path-utils.c |  2 ++
 tree-diff.c                |  3 +++
 userdiff.c                 |  2 ++
 14 files changed, 53 insertions(+), 1 deletion(-)

diff --git a/compat/mingw.c b/compat/mingw.c
index 29d3f09768c..5c2080c04c1 100644
--- a/compat/mingw.c
+++ b/compat/mingw.c
@@ -1,3 +1,5 @@
+#define USE_THE_REPOSITORY_VARIABLE
+
 #include "../git-compat-util.h"
 #include "win32.h"
 #include <aclapi.h>
diff --git a/compat/win32/path-utils.c b/compat/win32/path-utils.c
index b658ca3f811..966ef779b9c 100644
--- a/compat/win32/path-utils.c
+++ b/compat/win32/path-utils.c
@@ -1,3 +1,5 @@
+#define USE_THE_REPOSITORY_VARIABLE
+
 #include "../../git-compat-util.h"
 #include "../../environment.h"
 
diff --git a/config.c b/config.c
index 043e1c8a078..f3066c37477 100644
--- a/config.c
+++ b/config.c
@@ -6,6 +6,8 @@
  *
  */
 
+#define USE_THE_REPOSITORY_VARIABLE
+
 #include "git-compat-util.h"
 #include "abspath.h"
 #include "advice.h"
diff --git a/environment.h b/environment.h
index f1a7c645db5..934859e1c59 100644
--- a/environment.h
+++ b/environment.h
@@ -102,6 +102,28 @@ int use_optional_locks(void);
 const char *get_git_namespace(void);
 const char *strip_namespace(const char *namespaced_ref);
 
+/*
+ * TODO: All the below state either explicitly or implicitly relies on
+ * `the_repository`. We should eventually get rid of these and make the
+ * dependency on a repository explicit:
+ *
+ *   - `setup_git_env()` ideally shouldn't exist as it modifies global state,
+ *     namely the environment. The current process shouldn't ever access that
+ *     state via envvars though, but should instead consult a `struct
+ *     repository`. When spawning new processes, we would ideally also pass a
+ *     `struct repository` and then set up the environment variables for the
+ *     child process, only.
+ *
+ *   - `have_git_dir()` should not have to exist at all. Instead, we should
+ *     decide on whether or not we have a `struct repository`.
+ *
+ *   - All the global config variables should become tied to a repository. Like
+ *     this, we'd correctly honor repository-local configuration and be able to
+ *     distinguish configuration values from different repositories.
+ *
+ * Please do not add new global config variables here.
+ */
+# ifdef USE_THE_REPOSITORY_VARIABLE
 void setup_git_env(const char *git_dir);
 
 /*
@@ -213,4 +235,5 @@ extern const char *comment_line_str;
 extern char *comment_line_str_to_free;
 extern int auto_comment_line_char;
 
-#endif
+# endif /* USE_THE_REPOSITORY_VARIABLE */
+#endif /* ENVIRONMENT_H */
diff --git a/name-hash.c b/name-hash.c
index 3a58ce03d9c..95528e3bcd2 100644
--- a/name-hash.c
+++ b/name-hash.c
@@ -5,6 +5,9 @@
  *
  * Copyright (C) 2008 Linus Torvalds
  */
+
+#define USE_THE_REPOSITORY_VARIABLE
+
 #include "git-compat-util.h"
 #include "environment.h"
 #include "gettext.h"
diff --git a/path.c b/path.c
index a3bf25b7def..93491bab141 100644
--- a/path.c
+++ b/path.c
@@ -2,6 +2,8 @@
  * Utilities for paths and pathnames
  */
 
+#define USE_THE_REPOSITORY_VARIABLE
+
 #include "git-compat-util.h"
 #include "abspath.h"
 #include "environment.h"
diff --git a/preload-index.c b/preload-index.c
index 63fd35d64b1..7926eb09a69 100644
--- a/preload-index.c
+++ b/preload-index.c
@@ -1,6 +1,9 @@
 /*
  * Copyright (C) 2008 Linus Torvalds
  */
+
+#define USE_THE_REPOSITORY_VARIABLE
+
 #include "git-compat-util.h"
 #include "pathspec.h"
 #include "dir.h"
diff --git a/prompt.c b/prompt.c
index 8935fe4dfb9..f21c5bf1c7e 100644
--- a/prompt.c
+++ b/prompt.c
@@ -1,3 +1,5 @@
+#define USE_THE_REPOSITORY_VARIABLE
+
 #include "git-compat-util.h"
 #include "parse.h"
 #include "environment.h"
diff --git a/refs/files-backend.c b/refs/files-backend.c
index 1cff65f6ae5..1bbb550f3af 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -1,3 +1,5 @@
+#define USE_THE_REPOSITORY_VARIABLE
+
 #include "../git-compat-util.h"
 #include "../copy.h"
 #include "../environment.h"
diff --git a/sparse-index.c b/sparse-index.c
index 9958656ded1..542ca5f411c 100644
--- a/sparse-index.c
+++ b/sparse-index.c
@@ -1,3 +1,5 @@
+#define USE_THE_REPOSITORY_VARIABLE
+
 #include "git-compat-util.h"
 #include "environment.h"
 #include "gettext.h"
diff --git a/statinfo.c b/statinfo.c
index 3c6bc049c15..30a164b0e68 100644
--- a/statinfo.c
+++ b/statinfo.c
@@ -1,3 +1,5 @@
+#define USE_THE_REPOSITORY_VARIABLE
+
 #include "git-compat-util.h"
 #include "environment.h"
 #include "statinfo.h"
diff --git a/t/helper/test-path-utils.c b/t/helper/test-path-utils.c
index bf0e23ed505..f57c8d706aa 100644
--- a/t/helper/test-path-utils.c
+++ b/t/helper/test-path-utils.c
@@ -1,3 +1,5 @@
+#define USE_THE_REPOSITORY_VARIABLE
+
 #include "test-tool.h"
 #include "abspath.h"
 #include "environment.h"
diff --git a/tree-diff.c b/tree-diff.c
index 9252481df36..5eab8af631b 100644
--- a/tree-diff.c
+++ b/tree-diff.c
@@ -1,6 +1,9 @@
 /*
  * Helper functions for tree diff generation
  */
+
+#define USE_THE_REPOSITORY_VARIABLE
+
 #include "git-compat-util.h"
 #include "diff.h"
 #include "diffcore.h"
diff --git a/userdiff.c b/userdiff.c
index 989629149f6..d43d8360d17 100644
--- a/userdiff.c
+++ b/userdiff.c
@@ -1,3 +1,5 @@
+#define USE_THE_REPOSITORY_VARIABLE
+
 #include "git-compat-util.h"
 #include "config.h"
 #include "userdiff.h"
-- 
2.46.0.421.g159f2d50e7.dirty

