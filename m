Received: from fout2-smtp.messagingengine.com (fout2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A8E71A262F
	for <git@vger.kernel.org>; Thu, 12 Sep 2024 11:30:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726140606; cv=none; b=jvNbxDP2I3P/69GvsX8ahS3grFV5PZnaVMCkWInoWtXv5lyst9g9E3feXvHUUcPm1BiEhH8tRC8pV29mdQ7K1040q9rdk4lxEIbPRYSZr774IAtD8WcRXK+uLR9VflJ4JYMl+3GkcwNP3lbJQB/ob89NhJzq157feUkATvzRot8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726140606; c=relaxed/simple;
	bh=GDaMR5cTuNaIXY/n5x6zZmE9MBi/Q7lElB8OrliGKtw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Mn2y9aBVTZS2xSccUj90Y8+9y33cz1tYodXxanJO1copw+tvZJD5qyhokaFZZ8tOEq27LojAgCcOO7XKWasLDonZD8JrIKAqDrCsAprnvCmeGZZexULPI3PD/TcrqOn1q2VSU221MCf0fYxYRdZktMgNTrnw7XgMm3Vv8YAq1L0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=Ihq4Jwjd; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=k7Tg3bVW; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Ihq4Jwjd";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="k7Tg3bVW"
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfout.phl.internal (Postfix) with ESMTP id 92410138064B;
	Thu, 12 Sep 2024 07:30:03 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Thu, 12 Sep 2024 07:30:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1726140603; x=1726227003; bh=Ky79fJEFQL
	90ugsU8+ZrXxI9Vec86hL6EpLNzds3rTM=; b=Ihq4JwjdyTJLWGQbzKgGjzDAJ6
	PTUqIeMLpUG6fDrgI9+7xtBNpRi1tDO5fS9FypTpf91FsZY98cx53PtclwYCgm41
	3zQl5Ydvo5Cy14aeIlYHJqOyXu8W6H7K1NKQ0s7HnNa3HotE09Dxqzu/gpsDRSCu
	CRJu6hPTzq8mvN298BB8OVqAC92DxDPFBWzcNHjR39QDHU+cCRAcoGAf2gEpXzGq
	M+8iH/9Ik8ItGTso36JLUIr2Kg6CX79MtpkIk/gi6RMOUJm6KXf5I+Ik2LJbCTim
	xJUcO0sa9o0PTni/hAPzT2oi39FEDwz6wmTXSZqZ+RpOzcnvIYG2xgy6mUDA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1726140603; x=1726227003; bh=Ky79fJEFQL90ugsU8+ZrXxI9Vec8
	6hL6EpLNzds3rTM=; b=k7Tg3bVWv+N27s0ktV9pGF9JkdlvrKh5Z61AbMtI+5Dz
	ZoALmLyXjJXjZSx/YjWwizO4YxV68iKbaW+H1rS9gOZ5Q8tZAVVyszMmIZLw+RFM
	vsMBsONQuBg8OaMb+sr/dH6yz0LpjHIxRyOswXW1oBrEWKvmz4fvZPWduOmmh3lf
	PyoveR0xlEm5v/QD+KZPQgmUgmImktQ6IjYt88G4GCRfRdpT0MT0BA6cmXFRxfFA
	vrYOQ37629d4uu+6aoPk7kovDYZfrMeTrYg52Lp1iuWjzKut4+4xsQ1NVABzy6Hz
	18DA0MWORNTLsp6fXsQuFb8V1uWEuFdRQhYEgw2eEA==
X-ME-Sender: <xms:u9DiZhNgXkl11yBmxc21Czq_3biVInmP4CE-g-jAEb2ymjr9X85giQ>
    <xme:u9DiZj8W-lqrrxUJnAdPQJIJlj6YkvL0Rx9c9tZo1Hkg4PH4wS2y91Z-yAWWBNtCY
    0X02y-au6mj_U1SHw>
X-ME-Received: <xmr:u9DiZgRr7IdexH_RjnbZ3PoBFtQzMZZlBpxWNSkfm9-5PO5zeCPsIoPPahRBAOrPmKOWRPVearjUew3BFRNIGsPq_Nagp-1L0YNrSnnCms3k>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrudejfedggedvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefgueeg
    udfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgepudenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohephedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepkhgrrhhthhhikhdrudekkeesghhmrghilhdrtghomh
    dprhgtphhtthhopehjlhhtohgslhgvrhesghhmrghilhdrtghomhdprhgtphhtthhopehg
    ihhtshhtvghrsehpohgsohigrdgtohhmpdhrtghpthhtoheptggrlhhvihhnfigrnhesgh
    hoohhglhgvrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhr
    gh
X-ME-Proxy: <xmx:u9DiZtuUYqzbgyw9OzYPmcIfIbbIq4LD48qiVJq8a0LogVrgacbJGg>
    <xmx:u9DiZpfn3VdBKPC0yc4ujlGVur7tpHckodcU6LKYJDkxbI1Sm1FlUw>
    <xmx:u9DiZp3hp7kuq3sQpB6i6Cxzr_SqD-ShhR7n2FMe4f58EQ2vvTP28A>
    <xmx:u9DiZl-vh3bjpwzEHbW7K6uSXeIW5f3veLdviVYDm_EJjp5gjuqPsA>
    <xmx:u9DiZiHfT4kWg3buxGQkiZwOSGDnGKEIcEBJbvnCCWGcKCitK__dLLU2>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 12 Sep 2024 07:30:02 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id d66ce3e3 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 12 Sep 2024 11:29:53 +0000 (UTC)
Date: Thu, 12 Sep 2024 13:30:01 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Calvin Wan <calvinwan@google.com>, Justin Tobler <jltobler@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	karthik nayak <karthik.188@gmail.com>
Subject: [PATCH v3 13/21] environment: guard state depending on a repository
Message-ID: <417cca950bff25c5947663532d5ed468079e6c72.1726139990.git.ps@pks.im>
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
2.46.0.551.gc5ee8f2d1c.dirty

