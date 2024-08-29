Received: from fout1-smtp.messagingengine.com (fout1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E608918F2D1
	for <git@vger.kernel.org>; Thu, 29 Aug 2024 09:39:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724924348; cv=none; b=lETsPq/USFx2g6CXlFN9EIVCmqeynIA6r659M4wv6ayTv3tHkxjldGUrUsh0k1xMTlUjrs5dKu+JwZ7q7jMQA+hv7d4P4TWC5IPgo/z3BzmlKCgabGn/f/jwOn+V1DfJrLGs8RlnRYTPfhLpN67ceJhy2m4C3c/tSLCf7jkt7y8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724924348; c=relaxed/simple;
	bh=kMLGyR3Ewku+g8hr/XLCrAJLPqp78OdCj8FLv2ERCIo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RSmjg3LqBoKyV7Z2Ot7Kaa0EH5ibFM2nwBGU6d1c9pH7cmAp/Ig1UKuggceYoYdLoYOT0vYck8cPtISOQ5V0l9TbUURvIW6+75+6WT/eZfv2vLY36tepkl/RFOdomREW2kQHFyUIPciFdysLILtqwXh5FYYuQ7AcU+Ugc0Cx3Wc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=f4Mh4r44; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=LIEvRHbJ; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="f4Mh4r44";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="LIEvRHbJ"
Received: from phl-compute-07.internal (phl-compute-07.nyi.internal [10.202.2.47])
	by mailfout.nyi.internal (Postfix) with ESMTP id 12A43138FC3A;
	Thu, 29 Aug 2024 05:39:06 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-07.internal (MEProxy); Thu, 29 Aug 2024 05:39:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1724924346; x=1725010746; bh=8OKSJA681b
	OeIyiFhXuEg76THmOc6VJPtf2c4TusuuM=; b=f4Mh4r44h2HfHWBPLSrlrI4C9/
	V/c2EkM1dsqaU8fKRhkAT6f/w7V9Gi6wzzX/ln430KGWqv9LFzKWPJjL9XC+ThSw
	eG1Xfz2VrptD7N9jbcmb548ylvhNMjU7Zcl0qJN27B6Vu6gwkrN3qdc+S7i70nfj
	Qw5wc4Ai3KdDSFoh8clCOHL6TNgel9qioZ/q/lUyWbSW2GDr0rpGIj2i0hb7P6z3
	Wjy24hIqSjzt/ZWK3LgAECQ3oQV2RYpl30cjiecugopwZC73yRPeKGtCvAr0p9Sq
	g7PbEat2BoatbhlEHwt6DOQovzrvXHNecWZynqFb3mT18mTHIuF0hlr3igEA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1724924346; x=1725010746; bh=8OKSJA681bOeIyiFhXuEg76THmOc
	6VJPtf2c4TusuuM=; b=LIEvRHbJJt51AW9v3wCY+4w1b+BiwFKuTqBRvsbDzygY
	XmsjuRTjTKwIPGEIpeKsdnnpEV2XwxB5b/RnQ3QefBibichON1DS+ddeJCdIAqDr
	fwhaSa3hH+GGMzDsGM5i+z6z3f/HCDgN3qi3TGWButIj8dnFihRpGAJ5WKMuDspn
	WRy2kAY/5xGovPzjqyN5ykxvb9YQtPFkGe1YQ7a1hK+ZnfjnDzJ7dLywyubSZg0o
	Q9Cc/eIVNr/Lv3UX2MjWcs2853iLEKQ7Et2k4XVBrKjZRfmECz6F7zA8PHBeiT0v
	GzuOAKn0dqrr9HihOdPvu4KvgKlnMJgA7qLLzRAqPA==
X-ME-Sender: <xms:uUHQZr2Wa194R6jbvFLbM9DgNyrFl3oNH8IfikBwRyQmkbquQjtMtw>
    <xme:uUHQZqEYb27tnnG_iTW_9zwmXNm_VqDVNeG2fCYGKin4g56Gnyem73fhmJLRMOk9M
    kgKOdO4hn-zO5oyCQ>
X-ME-Received: <xmr:uUHQZr56Oh9s2zY4LxjrrJYallE96aP0AXb-ErrHHXUCFedYnSsC8hpGeLmBy2Zn1kxirOEhjP8P4YEq6f6KYFvAoc4_u0Du0Ku7W0wSTFnY8uc>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrudefgedgudekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefgueeg
    udfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgepvdenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepvddpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtoheptggrlhhvihhnfigrnhesghhoohhglhgvrdgtohhmpd
    hrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:uUHQZg1jOAaDfoNPnW_khX7JZU6sEyW9iG0jSQDXX_ENfuMyN3KjfA>
    <xmx:uUHQZuGePyEAgGJprIrNsDOM9MeNxSgRz63nlKwI_kcuufHaiIOtCQ>
    <xmx:uUHQZh9oJ2drkE7ZBFKpPLs8vGeRwsArCyOwdlCDX8mJO4eGuVl_eQ>
    <xmx:uUHQZrnAhKTSRtdTLYC7W5d62mH5yjFNoG358PlYbFJdJFkk4UQNoQ>
    <xmx:ukHQZjRHMT9i_YhPADX5nVNryjX-VK-qW1rGlE76qqqCOq8NoE8uiW0J>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 29 Aug 2024 05:39:05 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id c0f3bb72 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 29 Aug 2024 09:38:57 +0000 (UTC)
Date: Thu, 29 Aug 2024 11:39:02 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Calvin Wan <calvinwan@google.com>
Subject: [PATCH 12/21] environment: reorder header to split out
 `the_repository`-free section
Message-ID: <a5a78db1697b96189db71be44973dfbef517a22f.1724923648.git.ps@pks.im>
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

