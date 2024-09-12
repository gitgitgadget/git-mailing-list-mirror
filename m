Received: from fout2-smtp.messagingengine.com (fout2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A5491A2567
	for <git@vger.kernel.org>; Thu, 12 Sep 2024 11:30:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726140603; cv=none; b=JNa5Id3/bDvb9u76YC6D/+k8gpWjm1LOjb5qcsceU1R4lW3JK3QXDiUStfhmClX24wt4u9pEJFRqzEFvTpUREX0FfZGsZdalWbXZ1kzi67Q2gKGZmItQHtotuu4QktHoXZ/k14TEQD512pb2pvuZgADYgkCIagiKgUH1oqvguJU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726140603; c=relaxed/simple;
	bh=x0gHHgsySr3jILwR3M6yuzvr1Gqle8iVBTnrbOETR2g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QzzbyWCr5yQEg2XHR7q78o05KYChZ1tw2ptXqce+t/nfB+DskXBQonWdFgRTaVo1w7/xkqW9oVm9TPaDT6cArhfFtTv2Ymx2PT9O3j+kjADb3i02/UvaRRPMu1lYOfdQG5/9IgsxYJ5+r66Ujn5p8DckaIC8BTTwtXQOfODTkdU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=R07+ed1s; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=p/ShZvrh; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="R07+ed1s";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="p/ShZvrh"
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfout.phl.internal (Postfix) with ESMTP id D7492138061F;
	Thu, 12 Sep 2024 07:30:00 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Thu, 12 Sep 2024 07:30:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1726140600; x=1726227000; bh=nulMwl1dF7
	OpHLp3ERJdcKDaMzu4b1PhPa0JGt7XDvY=; b=R07+ed1sUMGVeg7rdi58bw1T9n
	DbM/uieZR6xKWTEm4oCpS4hDFyi31LLsckHJhM17PzwEzrGgVvVh/OKNWRSI6sNe
	11FMYNK6xgH/iTDlhViOacVMv/1AmA3/ikUbvHHrAuNwda9DQ2G+p+DsZ/PKMMW4
	o5EKuLPPeXLKMpt9sLUdufkmGsWm83zEu4lPsbAkEByoHnjYXU5kRbWfIxhtRxGG
	unrbzc4BRHQysPx1xJASJh/CsfP9pdSzaSI0HaUvrTUlerB1hqXBXt74zcl+UyGS
	8T07jRu0fuDeFJzLQh1YtO5jGTR5YPTkFabSk5DIr+cDb6/BQ897cR/pktMg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1726140600; x=1726227000; bh=nulMwl1dF7OpHLp3ERJdcKDaMzu4
	b1PhPa0JGt7XDvY=; b=p/ShZvrh19Da6U2MtGVHCSwjglk3E06AEwp/XRYpaKtj
	aaujHvqC7stYlRk+LLu+RYeznTvDhXTNjNsFjNbY1cSXwf7l1z6RJ8aiZevJNV/s
	DJbVBqDgoxc4qRPILidakI+V3ZUQQPyfX/F5CdO+DDnsSDjRhsQ2/sBs3TWBXpXY
	O+ItS4kk9O/zudBrKTwQdRtjeXqqZPxC9IINEItp5SDJtT3Dhf4GTJu1Xh6pkZSU
	Zfo5hO9nSC6lniHOGUQtFraRk0bOA4MNS9gpE+Hcr6VQy/D4crcZTaKGx18ygM84
	jw59hzhonpzZk658q28gtSxbRx1C19nzQYNIVCsXIg==
X-ME-Sender: <xms:uNDiZrL8uO-8FKG1fcwz0Pk5ymsGMeVeP4aDM6xMPXU46HlYhEsJjw>
    <xme:uNDiZvKf2dylvwDlunDS1pzq7fK-2R-KamxfRRmIj1dkO506I8LO7ihYgu4ykDVYh
    Uno2Z_AVrpvfIt3hw>
X-ME-Received: <xmr:uNDiZjve1NS1VEmNGBT6Hs7TYlP_jSyT-Zu2W7HDP6iUdoXGzdELh7priYqap05sVuwznR5IyJ9jxBqEi65dhR6ZYA8aEzbUO4kIQS3dBI4D>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrudejfedggeduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefgueeg
    udfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgepvdenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohephedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomhdprhgtph
    htthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepjhhlthho
    sghlvghrsehgmhgrihhlrdgtohhmpdhrtghpthhtoheptggrlhhvihhnfigrnhesghhooh
    hglhgvrdgtohhmpdhrtghpthhtohepkhgrrhhthhhikhdrudekkeesghhmrghilhdrtgho
    mh
X-ME-Proxy: <xmx:uNDiZkYNkytKVmFOrSrn1FCBjSE73e4eAf1SmBSQbFSx7WXH0Yb60A>
    <xmx:uNDiZiZPVdg1F7BuhbHMDKA1Uw8qImfSZgmlqt1NzkAJUoyIKp8NfA>
    <xmx:uNDiZoBzXS2-IXa6HYGZyKmUD6_f4jEbmXCVPr_VkAsw_Y-j8mzm3w>
    <xmx:uNDiZga_LDNaqEva6ubzZPWF0Frag9QDiaoCkgfr8HO_JYcfy-MHXQ>
    <xmx:uNDiZpzb1QJE9igfVgRB256EGiuJecH5daDWtGpFh311FiWa1wbjE46j>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 12 Sep 2024 07:29:59 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 7398c30f (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 12 Sep 2024 11:29:50 +0000 (UTC)
Date: Thu, 12 Sep 2024 13:29:59 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Calvin Wan <calvinwan@google.com>, Justin Tobler <jltobler@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	karthik nayak <karthik.188@gmail.com>
Subject: [PATCH v3 12/21] environment: reorder header to split out
 `the_repository`-free section
Message-ID: <8de5b246dadd7de97ffebb22f6f018aeb7a74917.1726139990.git.ps@pks.im>
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

Reorder the "environment.h" header such that declarations which are free
from `the_repository` come before those which aren't. The new structure
is now:

    - Defines for environment variable names.

    - Things which do not rely on a repository.

    - Things which do, including those that implicitly rely on a parsed
      repository. This includes for example variables which get
      populated when reading repository config.

This will allow us to guard the last category of declarations with
`USE_THE_REPOSITORY_VARIABLE`.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 environment.h | 81 +++++++++++++++++++++++++--------------------------
 1 file changed, 40 insertions(+), 41 deletions(-)

diff --git a/environment.h b/environment.h
index b8460396790..f1a7c645db5 100644
--- a/environment.h
+++ b/environment.h
@@ -1,22 +1,6 @@
 #ifndef ENVIRONMENT_H
 #define ENVIRONMENT_H
 
-struct strvec;
-
-/*
- * The character that begins a commented line in user-editable file
- * that is subject to stripspace.
- */
-extern const char *comment_line_str;
-extern char *comment_line_str_to_free;
-extern int auto_comment_line_char;
-
-/*
- * Wrapper of getenv() that returns a strdup value. This value is kept
- * in argv to be freed later.
- */
-const char *getenv_safe(struct strvec *argv, const char *name);
-
 /* Double-check local_repo_env below if you add to this list. */
 #define GIT_DIR_ENVIRONMENT "GIT_DIR"
 #define GIT_COMMON_DIR_ENVIRONMENT "GIT_COMMON_DIR"
@@ -86,6 +70,8 @@ const char *getenv_safe(struct strvec *argv, const char *name);
  */
 #define GIT_IMPLICIT_WORK_TREE_ENVIRONMENT "GIT_IMPLICIT_WORK_TREE"
 
+#define ALTERNATE_DB_ENVIRONMENT "GIT_ALTERNATE_OBJECT_DIRECTORIES"
+
 /*
  * Repository-local GIT_* environment variables; these will be cleared
  * when git spawns a sub-process that runs inside another repository.
@@ -94,6 +80,28 @@ const char *getenv_safe(struct strvec *argv, const char *name);
  */
 extern const char * const local_repo_env[];
 
+struct strvec;
+
+/*
+ * Wrapper of getenv() that returns a strdup value. This value is kept
+ * in argv to be freed later.
+ */
+const char *getenv_safe(struct strvec *argv, const char *name);
+
+/*
+ * Should we print an ellipsis after an abbreviated SHA-1 value
+ * when doing diff-raw output or indicating a detached HEAD?
+ */
+int print_sha1_ellipsis(void);
+
+/*
+ * Returns the boolean value of $GIT_OPTIONAL_LOCKS (or the default value).
+ */
+int use_optional_locks(void);
+
+const char *get_git_namespace(void);
+const char *strip_namespace(const char *namespaced_ref);
+
 void setup_git_env(const char *git_dir);
 
 /*
@@ -102,13 +110,19 @@ void setup_git_env(const char *git_dir);
  */
 int have_git_dir(void);
 
+/*
+ * Accessors for the core.sharedrepository config which lazy-load the value
+ * from the config (if not already set). The "reset" function can be
+ * used to unset "set" or cached value, meaning that the value will be loaded
+ * fresh from the config file on the next call to get_shared_repository().
+ */
+void set_shared_repository(int value);
+int get_shared_repository(void);
+void reset_shared_repository(void);
+
 extern int is_bare_repository_cfg;
 int is_bare_repository(void);
 extern char *git_work_tree_cfg;
-const char *get_git_namespace(void);
-const char *strip_namespace(const char *namespaced_ref);
-
-#define ALTERNATE_DB_ENVIRONMENT "GIT_ALTERNATE_OBJECT_DIRECTORIES"
 
 /* Environment bits from configuration mechanism */
 extern int trust_executable_bit;
@@ -134,16 +148,6 @@ extern unsigned long big_file_threshold;
 extern unsigned long pack_size_limit_cfg;
 extern int max_allowed_tree_depth;
 
-/*
- * Accessors for the core.sharedrepository config which lazy-load the value
- * from the config (if not already set). The "reset" function can be
- * used to unset "set" or cached value, meaning that the value will be loaded
- * fresh from the config file on the next call to get_shared_repository().
- */
-void set_shared_repository(int value);
-int get_shared_repository(void);
-void reset_shared_repository(void);
-
 extern int core_preload_index;
 extern int precomposed_unicode;
 extern int protect_hfs;
@@ -153,11 +157,6 @@ extern int core_apply_sparse_checkout;
 extern int core_sparse_checkout_cone;
 extern int sparse_expect_files_outside_of_patterns;
 
-/*
- * Returns the boolean value of $GIT_OPTIONAL_LOCKS (or the default value).
- */
-int use_optional_locks(void);
-
 enum log_refs_config {
 	LOG_REFS_UNSET = -1,
 	LOG_REFS_NONE = 0,
@@ -172,6 +171,7 @@ enum rebase_setup_type {
 	AUTOREBASE_REMOTE,
 	AUTOREBASE_ALWAYS
 };
+extern enum rebase_setup_type autorebase;
 
 enum push_default_type {
 	PUSH_DEFAULT_NOTHING = 0,
@@ -181,15 +181,12 @@ enum push_default_type {
 	PUSH_DEFAULT_CURRENT,
 	PUSH_DEFAULT_UNSPECIFIED
 };
-
-extern enum rebase_setup_type autorebase;
 extern enum push_default_type push_default;
 
 enum object_creation_mode {
 	OBJECT_CREATION_USES_HARDLINKS = 0,
 	OBJECT_CREATION_USES_RENAMES = 1
 };
-
 extern enum object_creation_mode object_creation_mode;
 
 extern char *notes_ref_name;
@@ -209,9 +206,11 @@ extern char *askpass_program;
 extern char *excludes_file;
 
 /*
- * Should we print an ellipsis after an abbreviated SHA-1 value
- * when doing diff-raw output or indicating a detached HEAD?
+ * The character that begins a commented line in user-editable file
+ * that is subject to stripspace.
  */
-int print_sha1_ellipsis(void);
+extern const char *comment_line_str;
+extern char *comment_line_str_to_free;
+extern int auto_comment_line_char;
 
 #endif
-- 
2.46.0.551.gc5ee8f2d1c.dirty

