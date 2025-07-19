Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F9B82110
	for <git@vger.kernel.org>; Sat, 19 Jul 2025 00:11:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752883916; cv=none; b=lRqoljfBiKEc/SC/wj1leJArHCXkw4X3X+0kRXRniZvV6Kabtha4mNx3w99bSYaAsdL3NeJaFyMsMnuQhUw+DqzUNSO2YGm9ytYXt8WB4EOM1XHW88qfSVg2Dcbt7TWjvs0zkfH83U99AFDuUCzI3nUpruGI7zfwNlxCaLZxKnM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752883916; c=relaxed/simple;
	bh=nzTQtXrHuHoAAmg54IlsxGZDsnoj3MTuKUCNk26tMq8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Jz+AIBh+SE76GjoFjXWdqWzhrdrjGOj7uPAYAqqIgxxrA58ogl+6gr38bKtkf5fFWy68go74aTh5N6zbaPp0DATGaCPrVwz/70hJG6bpimuQGxV3Kzvw+GRMLo2JBocufMXP7rQRnb5shOdfRS/SpC4E3fbG/X79ASVUvOskKXk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bogBJ00a; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bogBJ00a"
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-311c95ddfb5so1962912a91.2
        for <git@vger.kernel.org>; Fri, 18 Jul 2025 17:11:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752883912; x=1753488712; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=561I4PwtBrUZVNckr/MZj/CT5Yf2PCfC6oN8tPgYh44=;
        b=bogBJ00aXGThwFE/lF7uSREKO6Z6d0WpO9b5EvDHBBWHy5cq2dUKGBYMGuyTeZDhBv
         h/XzyJ3pJ04E9fEeH/KN4uEfebrOQnB4t46Li6jrwKWoOw0pxuQa9OlKcR3Fcwb0ROo/
         OeEoYcLFUkHrF/2EbDD6GXEsv2Olg7pXMc3Zgor+7GpGXccA5lggA9dAXpQSULPW8p1L
         OYLnKQ7E+izk4lAd5iEm7ccJoOAFTVqHgOP3bHsYgRWMGOgnxArBV355hjeVELs64yJd
         tljtkfFaSBfcuFXltDa32TSE9qu82faJwE2vWcKs/WinZcw66b2TRpbsb2oUj/FOthkg
         tiOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752883912; x=1753488712;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=561I4PwtBrUZVNckr/MZj/CT5Yf2PCfC6oN8tPgYh44=;
        b=RFZ+J+Ztun5yFvyUs2jWqscNvKSiqNqyQ0KHgkNf/tHGuPKjjfSDs5OjgwRFcUJVJG
         d1irk8Y7kSH6yVpNYUkg28Z4yK3aRTvEXfCi9FtfbRT32v/DZQviqHVACsEor8vFflhV
         wg6X8/ZarhWBrWnz2B6NJFWpvwZ9noMiT+EhBUj7wZuV25Lz3OPgQktZ9i5xnXbeucDB
         ZipEpGjsIFLHfCkZ8oP8k6TJN//I3Q1aQfyr7rMVeDea7fe8argB1honQSRvXCpjiygB
         0a6urntyI9srx9X4FeJcWagJlo+8RyC9oOF2/RqugWsmKv1EPFPtEiCTr3KRJQS2rvNM
         A3MQ==
X-Forwarded-Encrypted: i=1; AJvYcCVqJjnO8MnjAgZRsGy84ORqzToysuvU3B4legO9aMEQqB0fv8sSc4TigpfiXjsLA4n6+2k=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxp1N4jlUV0iMerXnkbCyHV9OfmelefzWM/mEaEGxQwbaE1oEUB
	VoLxirOBPYPlR61UgKvHiLNDfOU7hhM1PwZZpMv00WxG0DnxRgMN1wRw
X-Gm-Gg: ASbGncuz4Pc+hSG+SpC2xX9uLMYEi516A+xO2/tMJwgwSuddZE7V4/kMejRwYkXOVbj
	tLkkmm2zKobMoE7R2JcGCGY71zXiusaNIks3ruWs1OXpZNrqGTkkUqP7q66pTDTFaafx/omhxls
	m5PMhDssY9PAfYkh4h1YTEMOPJVs1rkasD92q0Ig9LeJdcVHSB/zYeEabt2DflSUir0Js8PibuK
	ef+NOaNAHMEYfsVnwM1g6tyyIL7VIHJsFUnMEuzst06sSlF3MphkmzowgrBGDLbTkwIlEnfwZym
	pqnEPYZUy9oY1+pbLwW82nqb+rB68KFqg4GNdotxSoa7m3onOSS0LTUXBpQZ7Oqu5vfIFqCPk69
	W77R+Sg7ISyKZiYdWI/RtJTWU3LNNmVNjo/M=
X-Google-Smtp-Source: AGHT+IH/5Z59rZzbs/4SMYsi3FHWU+w0x5AXyq5yE8FYW1BP3ApgwF08NP/tIFzB0tUVF3uF+JhWwA==
X-Received: by 2002:a17:90b:1c02:b0:312:e8ed:758 with SMTP id 98e67ed59e1d1-31cc25404b9mr6230411a91.13.1752883912341;
        Fri, 18 Jul 2025 17:11:52 -0700 (PDT)
Received: from thinku.iitr.ac.in ([103.37.201.222])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-31cc3d5e765sm1964268a91.0.2025.07.18.17.11.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Jul 2025 17:11:51 -0700 (PDT)
From: Ayush Chandekar <ayu.chandekar@gmail.com>
To: ayu.chandekar@gmail.com
Cc: christian.couder@gmail.com,
	git@vger.kernel.org,
	shyamthakkar001@gmail.com,
	phillip.wood123@gmail.com,
	ps@pks.im,
	gitster@pobox.com,
	ben.knoble@gmail.com
Subject: [GSOC PATCH v6 0/3] environment: remove sparse-checkout related global variables
Date: Sat, 19 Jul 2025 05:41:25 +0530
Message-ID: <cover.1752882401.git.ayu.chandekar@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250603131806.14915-1-ayu.chandekar@gmail.com>
References: <20250603131806.14915-1-ayu.chandekar@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch series aims to remove global variables related to sparse-checkout from the global scope and to remove the definition '#define USE_THE_REPOSITORY_VARIABLE' from a few files.

It contains three patches:

1 - Remove the global variable 'core_apply_sparse_checkout' and move its setting to the 'struct repo_settings'. Also remove the definition '#define USE_THE_REPOSITORY_VARIABLE' from "builtin/backfill.c". 

2 - Remove the global variable 'core_sparse_checkout_cone' and move its setting to the 'struct repo_settings'.

3 - Remove the global variable 'sparse_expect_files_outside_of_patterns` and move its setting to 'struct repo_settings'. Also remove the definition '#define USE_THE_REPOSITORY_VARIABLE' from "sparse-index.c"

Thanks a lot to Christian for mentoring, and to Junio, Patrick, Phillip and Ben for reviewing

Ayush Chandekar (3):
  environment: move access to "core.sparsecheckout" into repo_settings
  environment: move access to "core.sparsecheckoutcone" into
    repo_settings
  environment: remove the global variable
    'sparse_expect_files_outside_of_patterns'

 builtin/backfill.c        |  7 ++----
 builtin/clone.c           |  3 ++-
 builtin/grep.c            |  4 ++--
 builtin/mv.c              |  6 ++---
 builtin/sparse-checkout.c | 49 +++++++++++++++++++--------------------
 builtin/worktree.c        |  2 +-
 config.c                  | 24 -------------------
 dir.c                     |  5 ++--
 environment.c             |  3 ---
 environment.h             |  4 ----
 repo-settings.c           |  3 +++
 repo-settings.h           |  4 ++++
 sparse-index.c            |  9 ++++---
 unpack-trees.c            |  2 +-
 wt-status.c               |  3 ++-
 15 files changed, 51 insertions(+), 77 deletions(-)

-- 

Discussions since v5:
* For 1/3 and 2/3, Junio told me that it was concerning to put so many calls to `prepare_repo_settings()` so I tried to minimize the calls and made sure that there's no useless calling.
* For 3/3, Phillip told me that it broke user-facing as it will be parsed quite late in the callchain and might throw an error mid operation which we do not want.

Main problem I was dealing with was `prepare_repo_settings()`. I think we can try to get useless calls to `prepare_repo_settings()`. Other than that, I agree with the approach that came up in the discussion here:
https://lore.kernel.org/git/32fceddc-c867-4a47-bde8-c873279edbc1@gmail.com/
which was adding a call to `prepare_repo_settings()` in `repo_config()`.

Summary of range-diff:
* Changed some calls to `prepare_repo_settings()` to make sure that it is added in code paths only where it has no been called before. 
  Also changed a mistake in commit message: s/sparse-checkout.c/sparse-index.c  and have explained it more.
* Shifted the global variable to `struct repo_settings`(the previous version just localized it leading to user experience issues) and changed the commit message

Range-diff with v5:
1:  54ea376768 ! 1:  d0e2042b30 environment: move access to "core.sparsecheckout" into repo_settings
    @@ Commit message
         - In "dir.c", the function using 'settings.sparse_checkout' is invoked
           in multiple files that do not call `prepare_repo_settings()`, hence
           add a call directly to that function.
    -    - In "sparse-checkout.c", add a call to `prepare_repo_settings()` inside
    -      `is_sparse_index_allowed()`, as it is used widely and relies on the
    -      setting.
    +    - In "sparse-index.c", remove a call to `prepare_repo_settings()`
    +      from the function `is_sparse_index_allowed()` as it is called
    +      everytime before the function is called, and add a call to
    +      `prepare_repo_settings()` inside `convert_to_sparse()`, as it is
    +      used widely without having a call to `prepare_repo_settings()`
    +      before and relies on the setting.
         - In "wt-status.c", call `prepare_repo_settings()` before accessing
           the setting because the function using it is commonly used.
     
    @@ dir.c: enum pattern_match_result path_matches_pattern_list(
      int init_sparse_checkout_patterns(struct index_state *istate)
      {
     -	if (!core_apply_sparse_checkout)
    -+	prepare_repo_settings(istate->repo);
     +	if (!istate->repo->settings.sparse_checkout)
      		return 1;
      	if (istate->sparse_checkout_patterns)
      		return 0;
    +@@ dir.c: static int path_in_sparse_checkout_1(const char *path,
    + 	enum pattern_match_result match = UNDECIDED;
    + 	const char *end, *slash;
    + 
    ++	prepare_repo_settings(istate->repo);
    + 	/*
    + 	 * We default to accepting a path if the path is empty, there are no
    + 	 * patterns, or the patterns are of the wrong type.
     
      ## environment.c ##
     @@ environment.c: enum push_default_type push_default = PUSH_DEFAULT_UNSPECIFIED;
    @@ sparse-index.c: static int index_has_unmerged_entries(struct index_state *istate
      int is_sparse_index_allowed(struct index_state *istate, int flags)
      {
     -	if (!core_apply_sparse_checkout || !core_sparse_checkout_cone)
    -+	prepare_repo_settings(istate->repo);
     +	if (!istate->repo->settings.sparse_checkout || !core_sparse_checkout_cone)
      		return 0;
      
    @@ sparse-index.c: int is_sparse_index_allowed(struct index_state *istate, int flag
      		if (!istate->repo->settings.sparse_index)
      			return 0;
      	}
    +@@ sparse-index.c: int is_sparse_index_allowed(struct index_state *istate, int flags)
    + 
    + int convert_to_sparse(struct index_state *istate, int flags)
    + {
    ++	prepare_repo_settings(istate->repo);
    + 	/*
    + 	 * If the index is already sparse, empty, or otherwise
    + 	 * cannot be converted to sparse, do not convert.
     @@ sparse-index.c: static void clear_skip_worktree_from_present_files_full(struct index_state *ista
      
      void clear_skip_worktree_from_present_files(struct index_state *istate)
2:  c4d37dc7c5 ! 2:  d799faca3f environment: move access to "core.sparsecheckoutcone" into repo_settings
    @@ Commit message
         code to store it in the variable `sparse_checkout_cone` in the struct
         `repo_settings`.
     
    -    Call `prepare_repo_settings()` where necessary to ensure the `struct
    -    repo_settings` is initialized before use:
    -    - In "dir.c", the function accessing the setting is usually called after
    -      `prepare_repo_settings()`, except for one code path in
    -      "unpack-trees.c", so add a call there.
    -
         Avoid redundant calls to `prepare_repo_settings()` where it is already
         present:
         - In "builtin/mv.c" and "builtin/sparse-checkout.c", it is already
           invoked in their respective `cmd_*()` functions.
    -    - In "sparse-index.c", `prepare_repo_settings` is already called before
    -      the setting is accessed.
    +    - In "sparse-index.c", `prepare_repo_settings()` is already called
    +      before the setting is accessed.
    +    - In "dir.c", `prepare_repo_settings()` is already called in all code
    +      paths before the setting is accessed.
     
         This change is part of an ongoing effort to eliminate global variables,
         improve modularity and help libify the codebase.
    @@ repo-settings.h: struct repo_settings {
     
      ## sparse-index.c ##
     @@ sparse-index.c: static int index_has_unmerged_entries(struct index_state *istate)
    + 
      int is_sparse_index_allowed(struct index_state *istate, int flags)
      {
    - 	prepare_repo_settings(istate->repo);
     -	if (!istate->repo->settings.sparse_checkout || !core_sparse_checkout_cone)
     +	if (!istate->repo->settings.sparse_checkout || !istate->repo->settings.sparse_checkout_cone)
      		return 0;
      
      	if (!(flags & SPARSE_INDEX_MEMORY_ONLY)) {
    -
    - ## unpack-trees.c ##
    -@@ unpack-trees.c: enum update_sparsity_result update_sparsity(struct unpack_trees_options *o,
    - 		BUG("update_sparsity() called wrong");
    - 
    - 	trace_performance_enter();
    -+	prepare_repo_settings(the_repository);
    - 
    - 	/* If we weren't given patterns, use the recorded ones */
    - 	if (!pl) {
3:  84cb67469e ! 3:  35137b6814 environment: remove the global variable 'sparse_expect_files_outside_of_patterns'
    @@ Metadata
      ## Commit message ##
         environment: remove the global variable 'sparse_expect_files_outside_of_patterns'
     
    -    The global variable 'sparse_expect_files_outside_of_patterns' is used in
    -    a single function named 'clear_skip_worktree_from_present_files()' in
    -    sparse-index.c. Move its declaration inside that function, removing
    -    unnecessary global state.
    +    The setting "sparse.expectFilesOutsideOfPatterns" is stored in the
    +    global variable 'sparse_expect_files_outside_of_patterns' and allows
    +    files marked with the `SKIP_WORKTREE` bit to be present in the worktree.
    +
    +    As this setting is closely related to repository, remove the global
    +    variable and store the setting in the `struct repo_settings` along
    +    with other sparse checkout related settings.
     
         This also allows us to remove the definition '#define
         USE_THE_REPOSITORY_VARIABLE' from the file 'sparse-index.c'.
    @@ environment.h: extern int precomposed_unicode;
      	AUTOREBASE_NEVER = 0,
      	AUTOREBASE_LOCAL,
     
    + ## repo-settings.c ##
    +@@ repo-settings.c: void prepare_repo_settings(struct repository *r)
    + 	repo_cfg_bool(r, "core.usereplacerefs", &r->settings.read_replace_refs, 1);
    + 	repo_cfg_bool(r, "core.sparsecheckout", &r->settings.sparse_checkout, 0);
    + 	repo_cfg_bool(r, "core.sparsecheckoutcone", &r->settings.sparse_checkout_cone, 0);
    ++	repo_cfg_bool(r, "sparse.expectfilesoutsideofpatterns", &r->settings.sparse_expect_files_outside_of_patterns, 0);
    + 
    + 	/*
    + 	 * The GIT_TEST_MULTI_PACK_INDEX variable is special in that
    +
    + ## repo-settings.h ##
    +@@ repo-settings.h: struct repo_settings {
    + 
    + 	int sparse_checkout;
    + 	int sparse_checkout_cone;
    ++	int sparse_expect_files_outside_of_patterns;
    + };
    + #define REPO_SETTINGS_INIT { \
    + 	.shared_repository = -1, \
    +
      ## sparse-index.c ##
     @@
     -#define USE_THE_REPOSITORY_VARIABLE
    @@ sparse-index.c
      
      #include "git-compat-util.h"
     @@ sparse-index.c: static void clear_skip_worktree_from_present_files_full(struct index_state *ista
    - 
      void clear_skip_worktree_from_present_files(struct index_state *istate)
      {
    -+	int sparse_expect_files_outside_of_patterns = 0;
    -+	repo_config_get_bool(istate->repo, "sparse.expectfilesoutsideofpatterns",
    -+		&sparse_expect_files_outside_of_patterns);
      	if (!istate->repo->settings.sparse_checkout ||
    - 	    sparse_expect_files_outside_of_patterns)
    +-	    sparse_expect_files_outside_of_patterns)
    ++	    istate->repo->settings.sparse_expect_files_outside_of_patterns)
      		return;
    + 
    + 	if (clear_skip_worktree_from_present_files_sparse(istate)) {

2.49.0

