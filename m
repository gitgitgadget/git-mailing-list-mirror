Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32EBCC77B7A
	for <git@archiver.kernel.org>; Tue,  6 Jun 2023 13:24:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237243AbjFFNYo (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 6 Jun 2023 09:24:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233703AbjFFNYn (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 6 Jun 2023 09:24:43 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D71B990
        for <git@vger.kernel.org>; Tue,  6 Jun 2023 06:24:40 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id ffacd0b85a97d-30ae901a9ffso5535478f8f.2
        for <git@vger.kernel.org>; Tue, 06 Jun 2023 06:24:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686057879; x=1688649879;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qs68gLT6cwN29sd77wmIzSm0veJcbnLLeaekD2aZZTQ=;
        b=FPUU5EzG091KV7Y+m8O3+G6FDWygdCO9OC+O7Z56uGUfXfT8dJCzWrFYaEiDhBGcVt
         MGamTmPNIqYYXhaFr3UHQ2x0eWaGjeRwwuWPWt73UQnxaMBafG+fk67utKlLaI9ypawV
         M2x1L89sQs/tP7OjrZV0W67dndFGGPF4qZ1F9nI1pE6AaTmy2VgV32qkhBjRPP6H/d5H
         g06a+5HcnlECG3VwnXixmyIM+ZPlyR1fmy8I6GEkZ391pIxiZbLq5aJIKciI1C1pLLvU
         wrGhj7fWOmf4lzYEaR79Ldj5Liy7eUZBXzZMxWpMDz2Jjk4Z02io50l8fnobieJF3+W4
         /dLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686057879; x=1688649879;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qs68gLT6cwN29sd77wmIzSm0veJcbnLLeaekD2aZZTQ=;
        b=ULPat+BuwfaumIc2T8gcqt8WrO7cisUDwhhGxaYP+e4hflzpv7dLX98X2b8/Ruz/b2
         6ajGvHE8LJPhBUkDrQgJiObHeeevB4ScaNxw0HsiV3hyDt5jY/q0l0ytfupNyXWDCuc2
         JVSY56yapoqZgzwWzKe/pLxAW2Qnl1TxkDM2bLp0Oe2Pz7vlXL7YEhm70Jve1O71gPQM
         AP3paTZo211AlA32pgeSrcsuXWTopwdw955Ay11YwX0dHLxxe5SRZavsyndicHTJ4ij9
         EQ186o9TVvYZpwmH95/GPYAAYBLfvSsQXHBachnmeutY4I2rNNHz0U+NMDS5dU5aKBrE
         D8HQ==
X-Gm-Message-State: AC+VfDwnEciKUeK8lNq9Pcie1MkGGkS1lz5LpbRQYz0/XBWvDhE09EVn
        Gz6O6I79ZlteeHDyTeTR/je0TtR4jT4=
X-Google-Smtp-Source: ACHHUZ4X7UJvVCDN8aY5RoLnKb0E+kCk8PPTuJiM9dGOw7igjMwtdDdeZLYGdSjkad3gJDv1WN3Z9g==
X-Received: by 2002:a5d:498f:0:b0:307:cb94:85de with SMTP id r15-20020a5d498f000000b00307cb9485demr2341188wrq.11.1686057878767;
        Tue, 06 Jun 2023 06:24:38 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id t3-20020adfe103000000b0030ae6432504sm12607379wrz.38.2023.06.06.06.24.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Jun 2023 06:24:38 -0700 (PDT)
Message-Id: <pull.1537.v3.git.1686057877.gitgitgadget@gmail.com>
In-Reply-To: <pull.1537.v2.git.1685716157.gitgitgadget@gmail.com>
References: <pull.1537.v2.git.1685716157.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 06 Jun 2023 13:24:34 +0000
Subject: [PATCH v3 0/3] Create stronger guard rails on replace refs
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     vdye@github.com, me@ttaylorr.com, newren@gmail.com,
        gitster@pobox.com, Jeff King <peff@peff.net>,
        =?UTF-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
        Derrick Stolee <derrickstolee@github.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

(This series is based on tb/pack-bitmap-traversal-with-boundary due to
wanting to modify prepare_repo_settings() in a similar way.)

The replace-refs can be ignored via the core.useReplaceRefs=false config
setting. This setting is possible to miss in some Git commands if they do
not load default config at the appropriate time. See [1] for a recent
example of this.

[1]
https://lore.kernel.org/git/pull.1530.git.1683745654800.gitgitgadget@gmail.com/

This series aims to avoid this kind of error from happening in the future.
The idea is to encapsulate the setting in such a way that we can guarantee
that config has been checked before using the in-memory value.

Further, we must be careful that some Git commands want to disable replace
refs unconditionally, as if GIT_NO_REPLACE_REFS was enabled in the
environment.

The approach taken here is to split the global into two different sources.
First, read_replace_refs is kept (but moved to replace-objects.c scope) and
reflects whether or not the feature is permitted by the environment and the
current command. Second, a new value is added to repo-settings and this is
checked after using prepare_repo_settings() to guarantee the config has been
read.

This presents a potential behavior change, in that now core.useReplaceRefs
is specific to each in-memory repository instead of applying the
superproject value to all submodules. I could not find a Git command that
has multiple in-memory repositories and follows OIDs to object contents, so
I'm not sure how to demonstrate it in a test.

Here is the breakdown of the series:

 * Patch 1 creates disable_replace_refs() to encapsulate the global
   disabling of the feature.
 * Patch 2 creates replace_refs_enabled() to check if the feature is enabled
   (with respect to a given repository).
 * Patch 3 creates the value in repo-settings as well as ensures that the
   repo settings have been prepared before accessing the value within
   replace_refs_enabled(). A test is added to demonstrate how the config
   value is now scoped on a per-repository basis.


Updates in v3
=============

Thanks for the review on v2!

 * The removal of the global from environment.c is delayed to patch 3
   because config.c still assigns the value in patch 2.
 * The comment for the member in the repo_settings struct is modified for
   better grammar.


Updates in v2
=============

Thanks for the careful review on v1!

 * disable_replace_refs() now replaces "read_replace_refs = 0" in the exact
   same line to avoid possible behavior change.
 * Stale comments, include headers, and commit messages are updated to
   include the latest status.
 * Patch 3 contains a test of the repo-scoped value using 'git grep'.

Thanks, -Stolee

Derrick Stolee (3):
  repository: create disable_replace_refs()
  replace-objects: create wrapper around setting
  repository: create read_replace_refs setting

 builtin/cat-file.c                 |  2 +-
 builtin/commit-graph.c             |  2 +-
 builtin/fsck.c                     |  2 +-
 builtin/index-pack.c               |  2 +-
 builtin/pack-objects.c             |  2 +-
 builtin/prune.c                    |  2 +-
 builtin/replace.c                  |  2 +-
 builtin/unpack-objects.c           |  2 +-
 builtin/upload-pack.c              |  2 +-
 commit-graph.c                     |  4 +--
 config.c                           |  5 ----
 environment.c                      |  3 +--
 git.c                              |  2 +-
 log-tree.c                         |  2 +-
 replace-object.c                   | 28 ++++++++++++++++++++-
 replace-object.h                   | 30 +++++++++++++++-------
 repo-settings.c                    |  1 +
 repository.h                       |  9 +++++++
 t/t7814-grep-recurse-submodules.sh | 40 ++++++++++++++++++++++++++++++
 19 files changed, 111 insertions(+), 31 deletions(-)


base-commit: b0afdce5dab61f224fd66c13768facc36a7f8705
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1537%2Fderrickstolee%2Freplace-refs-safety-v3
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1537/derrickstolee/replace-refs-safety-v3
Pull-Request: https://github.com/gitgitgadget/git/pull/1537

Range-diff vs v2:

 1:  0616fdbf303 = 1:  0616fdbf303 repository: create disable_replace_refs()
 2:  0831e7f8b5e ! 2:  4e75a76f5dd replace-objects: create wrapper around setting
     @@ Commit message
          set accidentally in other places, wrap it in a replace_refs_enabled()
          method.
      
     -    This allows us to remove the global from being recognized outside of
     -    replace-objects.c.
     +    Since we still assign this global in config.c, we are not able to remove
     +    the global scope of this variable and make it a static within
     +    replace-object.c. This will happen in a later change which will also
     +    prevent the variable from being read before it is initialized.
      
     -    Further, a future change will help prevent the variable from being read
     -    before it is initialized. Centralizing its access is an important first
     -    step.
     +    Centralizing read access to the variable is an important first step.
      
          Signed-off-by: Derrick Stolee <derrickstolee@github.com>
      
     @@ commit-graph.c: static struct commit_graph *alloc_commit_graph(void)
       		if (hashmap_get_size(&r->objects->replace_map->map))
       			return 0;
      
     - ## environment.c ##
     -@@ environment.c: const char *editor_program;
     - const char *askpass_program;
     - const char *excludes_file;
     - enum auto_crlf auto_crlf = AUTO_CRLF_FALSE;
     --int read_replace_refs = 1;
     - enum eol core_eol = EOL_UNSET;
     - int global_conv_flags_eol = CONV_EOL_RNDTRP_WARN;
     - char *check_roundtrip_encoding = "SHIFT-JIS";
     -
       ## log-tree.c ##
      @@ log-tree.c: static int add_ref_decoration(const char *refname, const struct object_id *oid,
       
     @@ log-tree.c: static int add_ref_decoration(const char *refname, const struct obje
       				&original_oid)) {
      
       ## replace-object.c ##
     -@@ replace-object.c: const struct object_id *do_lookup_replace_object(struct repository *r,
     - 	die(_("replace depth too high for object %s"), oid_to_hex(oid));
     - }
     - 
     -+static int read_replace_refs = 1;
     -+
     - void disable_replace_refs(void)
     +@@ replace-object.c: void disable_replace_refs(void)
       {
       	read_replace_refs = 0;
       }
     @@ replace-object.h: void prepare_replace_object(struct repository *r);
       const struct object_id *do_lookup_replace_object(struct repository *r,
       						 const struct object_id *oid);
       
     -+
      +/*
      + * Some commands disable replace-refs unconditionally, and otherwise each
      + * repository could alter the core.useReplaceRefs config value.
 3:  4c7dbeb8c6d ! 3:  8b7c7714c8c repository: create read_replace_refs setting
     @@ Commit message
          method, if necessary. This solves the problem of forgetting to check the
          config, as we will check it before returning this value.
      
     +    Due to this encapsulation, the global can move to be static within
     +    replace-object.c.
     +
          There is an interesting behavior change possible here: we now have a
          repository-scoped understanding of this config value. Thus, if there was
          a command that recurses into submodules and might follow replace refs,
     @@ config.c: static int git_default_core_config(const char *var, const char *value,
       	return platform_core_config(var, value, cb);
       }
      
     + ## environment.c ##
     +@@ environment.c: const char *editor_program;
     + const char *askpass_program;
     + const char *excludes_file;
     + enum auto_crlf auto_crlf = AUTO_CRLF_FALSE;
     +-int read_replace_refs = 1;
     + enum eol core_eol = EOL_UNSET;
     + int global_conv_flags_eol = CONV_EOL_RNDTRP_WARN;
     + char *check_roundtrip_encoding = "SHIFT-JIS";
     +
       ## replace-object.c ##
      @@ replace-object.c: void prepare_replace_object(struct repository *r)
        * replacement object's name (replaced recursively, if necessary).
     @@ replace-object.c: void prepare_replace_object(struct repository *r)
        */
       const struct object_id *do_lookup_replace_object(struct repository *r,
       						 const struct object_id *oid)
     +@@ replace-object.c: const struct object_id *do_lookup_replace_object(struct repository *r,
     + 	die(_("replace depth too high for object %s"), oid_to_hex(oid));
     + }
     + 
     ++/*
     ++ * This indicator determines whether replace references should be
     ++ * respected process-wide, regardless of which repository is being
     ++ * using at the time.
     ++ */
     ++static int read_replace_refs = 1;
     ++
     + void disable_replace_refs(void)
     + {
     + 	read_replace_refs = 0;
      @@ replace-object.c: void disable_replace_refs(void)
       
       int replace_refs_enabled(struct repository *r)
     @@ repository.h: struct repo_settings {
       	int pack_use_bitmap_boundary_traversal;
       
      +	/*
     -+	 * Has this repository have core.useReplaceRefs=true (on by
     ++	 * Does this repository have core.useReplaceRefs=true (on by
      +	 * default)? This provides a repository-scoped version of this
      +	 * config, though it could be disabled process-wide via some Git
      +	 * builtins or the --no-replace-objects option. See

-- 
gitgitgadget
