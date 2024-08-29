Received: from fhigh5-smtp.messagingengine.com (fhigh5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEAFC18CC19
	for <git@vger.kernel.org>; Thu, 29 Aug 2024 09:39:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724924352; cv=none; b=s45pvuCA/AviRt8X4uUSDpaFzJGldRIEV4R2VNleo5FZ0XF84Vt7+v2D8bPPBvpNwRBEX2QdqHDxKSKdfY31fcbHAyBCH/R9Lewnxv+sspYf591MgWqo3FIHzjOeiHq6Euf6CAcy19JQhyVLGXBTQmyonOAxiVyybm7HzNPwJxI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724924352; c=relaxed/simple;
	bh=6Dm+WJpSQI+ZLufDPxqKaqDXzxZn7sY61bKrIOJsX/U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JD6LF7cz9ovzuQV+//4yIl4mcOM70HeYF4a2G5gyjlAWzTuVVEl3IGHSMKd3cgpSqgg0si4YK5AilCB2k0SN24ELJ52Iy8onzOcd0jktYybPg1zJLNprTE/fHsV7+/+Qc7hWt1HZ6dg3lzWvBrXo74pYzO+9dYKrJipv4E3U5n8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=pchx7Dqa; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=iCr1MLr5; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="pchx7Dqa";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="iCr1MLr5"
Received: from phl-compute-02.internal (phl-compute-02.nyi.internal [10.202.2.42])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id 103461151CC3;
	Thu, 29 Aug 2024 05:39:10 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Thu, 29 Aug 2024 05:39:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1724924350; x=1725010750; bh=Kgn3SDPe2m
	QhJN5yMyTMiPRu4A5V5kHIQ+PHXE8QtFQ=; b=pchx7DqaCK1uq0xN+n650nr4c+
	7t/H+xoglvMazpS4o34bztLZM6NAVRPQhY0qCr/LBo2PHqKCjyKrYU6an0cCB7d7
	8KNYhrgsRZj0LVrzAuw+0jP8VkGh4sC7iVc2k/nZcdE8L2wIxD3sK+CA2wO8A+Nu
	Um0mEm0I1wWNMVaodSyUhow54eXd+X5E2xNo/3mAb1SoKVD4uGEFaNs1lnCAIl6e
	PylnRzEK0hLj8zVKQeocth0wAAyP/O7AThN0ZNPjy96Lo1x852QOo/DsdKliKoj3
	EZe/gohDckVSuulkAUkRbhdDMEYbECFGCniwvmYRp0i3YlRcAFidjNBkDrhQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1724924350; x=1725010750; bh=Kgn3SDPe2mQhJN5yMyTMiPRu4A5V
	5kHIQ+PHXE8QtFQ=; b=iCr1MLr5UHmW6VxWYKaGCm2N04ACRnorkzb5W4lilIZS
	fPJ1OKJFFz3F+mWZAp03qZMzofqpLXfkr1qL6rE/PjrrSXe+qZb1lMX3hhw6nA+r
	6Ltk4xoisVPqeNY6VBtJ0P4ZFPZ/woBCb08db3X3FZbM97N8bubre/LnAezbP+vQ
	eBhVH10cx3Iq8Oq2bKR2QqYaE6IZs6l7yUCNF26bdenN9AL1hFBZNaxR4Y0eVbZ6
	eXNMMPFdlWf1eObhsquD6m7Npb1g/GfvhF2Lfp4PpS528H7M5Mg+pSsU0KHIytZt
	1xzzYcaELWBqTpTJpvAsKi9+eh1A4HUiE4bHKY78BA==
X-ME-Sender: <xms:vUHQZnKmMuqRv3Er1fUZwFFeRGXXvmZvanNzY--qtGqjeTMdOqEQMA>
    <xme:vUHQZrJmKc6FnmpYIMdXmxFp8mPphcm7taik0BIW3mJ1uLwVSh4pw5UOoIC3js0Bw
    tOUosx-nBrn6bt-bg>
X-ME-Received: <xmr:vUHQZvv9XPktsWfzs1m8BYnjb8gtNcFDJimJbHHiDcRBE_zvzz_E2Eah6-28lnGw7nKogvtYad9Dswnv1SvMPKNg-Y7XYcQvdzG7_zDePhbCQPw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrudefgedgudekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefgueeg
    udfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgepudenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepvddpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprh
    gtphhtthhopegtrghlvhhinhifrghnsehgohhoghhlvgdrtghomh
X-ME-Proxy: <xmx:vUHQZgYSD8sIR3raDOFCpXpIr_I4DcZpBzY0hID8LUEXcosZViNeeg>
    <xmx:vUHQZubUZw3ZHwDfIPdN4H7w1lkH2xGuHXV9cncdJVRk0dhTJL7hNQ>
    <xmx:vUHQZkDmajc4tEyu67qhevR-ECgBvDB2sXMArzioDdat7v0pPDYeqw>
    <xmx:vUHQZsYa_9gWq9wBMt22VSbTrIhAscSkWP9gui9k7mHeHYRQQRtDfg>
    <xmx:vkHQZtlYppNhcR-8GDBHNHduUD-C2qvHT1e4psZ_EqM51Nw8Ki4_t4ux>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 29 Aug 2024 05:39:09 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id d14ef3c2 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 29 Aug 2024 09:39:00 +0000 (UTC)
Date: Thu, 29 Aug 2024 11:39:07 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Calvin Wan <calvinwan@google.com>
Subject: [PATCH 13/21] environment: guard state depending on a repository
Message-ID: <27a7d00de78098a84ac3ff31aee075a5944821dc.1724923648.git.ps@pks.im>
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
 12 files changed, 49 insertions(+), 1 deletion(-)

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

