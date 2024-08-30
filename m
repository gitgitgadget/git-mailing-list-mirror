Received: from fout7-smtp.messagingengine.com (fout7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F2BB178378
	for <git@vger.kernel.org>; Fri, 30 Aug 2024 09:09:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725008974; cv=none; b=ZDjkFumPFvTlhk/DPMGNU+Flw6amcUy2rFNkpL0QcQu3+WRVK+5wjqK20nnNIQwus8El0FjOZLgozW9oZEPTiDbkhGQTy/4dTLNPwJHyIh78/bKjhWxNC1xoLnJlMjir6nqvZv98uzQaUwgwmbQBn9k/JGtnBCheWlF7nAxuYfk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725008974; c=relaxed/simple;
	bh=kMLGyR3Ewku+g8hr/XLCrAJLPqp78OdCj8FLv2ERCIo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Xj2RutPQDSe3dQdztfEu5adLbXuGeO6G29jXgf52gVYkE3iyeZdh8rSO2uConS4XLpd0xZDAhdtvkvzjwvxdIrqqyPaxyFeg8We4WpCsKg7r6AICzbw0fobagem8XI0Mr5XnrMfurmyxAIRfOKOoueqYvKbgYIet6xgNgjI/xlo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=XeyClqVt; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=CSo/JUo3; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="XeyClqVt";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="CSo/JUo3"
Received: from phl-compute-05.internal (phl-compute-05.nyi.internal [10.202.2.45])
	by mailfout.nyi.internal (Postfix) with ESMTP id 7C274138027C;
	Fri, 30 Aug 2024 05:09:31 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Fri, 30 Aug 2024 05:09:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1725008971; x=1725095371; bh=8OKSJA681b
	OeIyiFhXuEg76THmOc6VJPtf2c4TusuuM=; b=XeyClqVttKnIQXHudzH0S77ijj
	bAgOAxGC+lN83LcCv2i4dvQIHsJOAwhf2kPI/8b/LOij3BhagyipjwgH0Eqxy5qY
	k7lSUZWA+2lu9l64egp8pPBMUnYkrSZGRYdA7tBWKwgARHsydNPaDzVj5f7TE3xB
	kl8blqyz4No0SNIXkS4feR95LODHyiZimqhJgvxWiMDt7/n3IXkjBo/UdycxJWJy
	BMs06H+gqmflshYbEGYk0Q3sdZQVERMZthwwDmN3VSZgfsPZO7oA/c47rLKFhBI/
	U3Pad5ZztamF/QQhSUwmwE8Jyw5RGULKTYScBlBEEqzd74HQnsUMdpBuECpw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1725008971; x=1725095371; bh=8OKSJA681bOeIyiFhXuEg76THmOc
	6VJPtf2c4TusuuM=; b=CSo/JUo3HbsYiGrypqqyTIAlCXUfL2eYks/Qm8zU0zz7
	KcVX7Dwgsrt+UkrZRvqtPMoHu0wrZPS5eKfcix0y+EI0/DDQwJbRnQoXvGJdSYgk
	qZWpHNVI63GFFWVJqVArdhg8KJcZGuDvT3FcRzNkX4AlDXqt0Ci/Wqo8IOV47WVX
	VCOQIgRV6hVI8DoxF6icAkUMJSZ9YzIA9UsAB2nrhlUAVbP0jSHCETXJNN2qU7aK
	OleKTqGJIMT0LsPb4HSIKgAfmVT081IJCFMRL8jVhiHyWkYnSCDACZnAtTwiSH9L
	sYmccE/ymFGoo3Gz6V/oR/jiNsZ2qJuv/T89q97Tkg==
X-ME-Sender: <xms:S4zRZmmXrbp5gpj0i_PJui0B0qOV0R1_E1yTVHZEi9fpnhUoYM2yMQ>
    <xme:S4zRZt3ps1yIZDNlCTquuQVhU6ec8C3S-5nLXjf_a_-q0RQwCfT_CwL3iUbhri0Q2
    Vem_w7cNh379IsdtA>
X-ME-Received: <xmr:S4zRZkp501Gm7XCkRydvWyKHMRY6T765gVqdVL5l7xSZFJM38hVrniRvBwNP3DYdOm55-4lRyNw9PTjg1sz0-5ZXHUQskJ1C7QWsiElGqR1_f6O9cQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrudefiedguddvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefgueeg
    udfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgepvdenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepgedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepjhhlthhosghlvghrsehgmhgrihhlrdgtohhmpdhrtg
    hpthhtohepghhithhsthgvrhesphhosghogidrtghomhdprhgtphhtthhopegtrghlvhhi
    nhifrghnsehgohhoghhlvgdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrh
    hnvghlrdhorhhg
X-ME-Proxy: <xmx:S4zRZqmMHhdUR_EcmJltIua4w3ziTRzGKV6HLLSox_i8Q0n9xT8GTw>
    <xmx:S4zRZk1-ccCSvRkibneTBwJoXYsGlpH1Ebj4DfU1tPT34bDCOSDSaQ>
    <xmx:S4zRZhuRrp29YoIFnQKQdJhtFikBGmSK6RmSyLsSw3VdlH_P0bbabw>
    <xmx:S4zRZgWcM5vK06YCTU9xxgroICJYC0pMpGWwztI61LPhIdk9J9ESxw>
    <xmx:S4zRZnTGOAw0mWxQt9ek6WRuUeIX3xh6m0iBpqSOkX3SS32hYMxxh7CC>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 30 Aug 2024 05:09:30 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 5b6c8182 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 30 Aug 2024 09:09:20 +0000 (UTC)
Date: Fri, 30 Aug 2024 11:09:29 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Calvin Wan <calvinwan@google.com>, Justin Tobler <jltobler@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 12/21] environment: reorder header to split out
 `the_repository`-free section
Message-ID: <78f77a006a0d577ffce5d5488042d8db113b37b2.1725008898.git.ps@pks.im>
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
2.46.0.421.g159f2d50e7.dirty

