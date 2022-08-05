Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41D45C00140
	for <git@archiver.kernel.org>; Fri,  5 Aug 2022 17:59:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241437AbiHER7A (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 5 Aug 2022 13:59:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241341AbiHER6w (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 5 Aug 2022 13:58:52 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E31D711A28
        for <git@vger.kernel.org>; Fri,  5 Aug 2022 10:58:49 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id n185so1735863wmn.4
        for <git@vger.kernel.org>; Fri, 05 Aug 2022 10:58:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc;
        bh=zUCoW/2G7JPtFU9l828Xnvy3ZpPXTdWEfUHvdp91luU=;
        b=U72H3PMwXiL2W1C+DTkUByBjPidnWglXq276omPsLyz3btSmrPOSNRhZkUsLo5pkqs
         EDwMgYohowiTaktVsD4thbXjOTDCnAkUtR11eqWdlY18sQFeIjzVgl1/IvcnK26/Qhwz
         ha3oCNfUm7BY7gEJUOb1y1Vjy8Ac3qfqeYko+rLGQvUX5BQgSIgEs+QddOR+54cwh2ZA
         SMleI78CZBslPcBdVmbuOFN+txYMk/rqxzvuKPQFdF2v79NkioIcHJ6hVv9WfQZeU6QR
         +Hq6cExK/oXBTWLLOOwIUUVa0NcmL9zJowE4WqEzmcsAY9euU2nPruS1AmCsP8w/iwyY
         AQOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc;
        bh=zUCoW/2G7JPtFU9l828Xnvy3ZpPXTdWEfUHvdp91luU=;
        b=OwMEmX8DLAGQ5ufubGDy5DAhkPYgmSoxdEZRSj8Q/wmXElYaTecdP9F2FmD7jFuYtf
         mw2rRgax3/cDwAKROxQ6SYogH9nXPoEqfnKdlt55sWvyLnhqny76oCoL92WjSpU8Sqvk
         GRV34q83Rxa14ph5WSCBDZZQpAhEZuGeBrK1gp3TgGnacvLfsNO1zddvmx1OtJjWLKTc
         PCEHGJq1d7C0lgQQcClmGO6BWoF13uiGeYWsZeC4gY4IjPKqPCd8P4MQcdbhvAm6TWxr
         BvqOYUNwn7OY0RmiLR1J6z/lm9OMyzEjT6nZ3g/o5s+xO1+fZ0J7yDo9RuWmUMsgxfrH
         LpSA==
X-Gm-Message-State: ACgBeo0Z3mQQlj9sBcSVuJI//TULdFAEcIJRs0Iywu/oyJYneB3iIx2V
        SoVLUecFo0qXs1Nt+TxE8STiimqAXgU=
X-Google-Smtp-Source: AA6agR7q2RwK39fXV7SAsS3Q/FkEF7wAr403Fa2B79aRBVAE550gV1IJh9aup7JfoYvDBibMXQv7VA==
X-Received: by 2002:a05:600c:2b88:b0:3a4:f6ff:994 with SMTP id j8-20020a05600c2b8800b003a4f6ff0994mr9788705wmc.32.1659722327680;
        Fri, 05 Aug 2022 10:58:47 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id u11-20020adfeb4b000000b0021f15514e7fsm5299161wrn.0.2022.08.05.10.58.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Aug 2022 10:58:46 -0700 (PDT)
Message-Id: <pull.1301.v3.git.1659722323.gitgitgadget@gmail.com>
In-Reply-To: <pull.1301.v2.git.1659122979.gitgitgadget@gmail.com>
References: <pull.1301.v2.git.1659122979.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 05 Aug 2022 17:58:32 +0000
Subject: [PATCH v3 00/11] log: create tighter default decoration filter
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, me@ttaylorr.com, vdye@github.com,
        steadmon@google.com,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Jeff King <peff@peff.net>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Derrick Stolee <derrickstolee@github.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When running 'git log', the default is to report any refs within refs/* as
decorations. This series reduces the default set to be more specific to a
set of known-useful namespaces.

This was previously reduced by adding the log.excludeDecoration config
option and modifying that config in git maintenance's prefetch task (to hide
refs/prefetch/*). I then followed that pattern again for the bundle URI
feature [1], but this caught some reviewers by surprise as an unfortunate
side-effect. This series is a way to roll back the previous decision to use
log.excludeDecoration and instead use tighter filters by default.

[1]
https://lore.kernel.org/git/a217e9a0640b45d21ef971d6e91cee3f1993f383.1656535245.git.gitgitgadget@gmail.com/

The current design ignores the new filters if there are any
previously-specified filters. This includes the
log.excludeDecorations=refs/prefetch/ set by the git maintenance command.
This means that users who ran that command in their repo will not get the
benefits of the more strict filters. While we stop writing
log.excludeDecorations, we don't remove existing instances of it. This
should be fine at least for the refs/bundles/ namespace in the future, since
those refs will typically be created for new clones that have not yet had
the log.excludeDecoration setting.

To make it easy for users to opt-in to the previous behavior, add a new git
log --decorate-all option and log.decorateFilter=all config option.


Updates in v3
=============

 * Fixed braces in if/else-if in patch 1. Also added a NEEDSWORK comment.
 * Added a patch that modernizes t4207 and converts some logic to a helper.
 * Updated the new tests in t4207 to use the new helper.
 * Used singular ref_namespace instead of ref_namespaces.
 * Update definition of refs_namespace to have fixed size so we can use
   ARRAY_SIZE() in a loop.
 * Renamed the CLI option to --clear-decorations and the config option to
   log.initialDecorationSet.
 * Several recommended style updates and typo fixes.


Updates in v2
=============

 * As discussed in the previous version, there are a lot of places that care
   about different subsets of the special ref namespaces. This version
   creates a new ref_namespaces array that centralizes and describes how
   these known ref namespaces interact with other Git features.

 * Some patches are added to help centralize previously-unrelated features
   onto the ref_namespaces array.

 * One thing that I noticed while doing this work was that notes come from a
   commit history that is pointed by a single ref, not multiple refs in a
   namespace. Also, that ref can change based on config and environment
   variables. This version updates that knowledge to allow our
   ref_namespaces[NAMESPACE_NOTES] value change with these settings. Since
   there is only one ref, I also chose to remove it from the default
   decorations. As Junio mentioned, this should not make any difference
   since a user won't see it unless they purposefully start git log from the
   notes ref.

 * Despite feedback to the opposite, I maintain my opinion that this default
   filter should be a small list of known-useful namespaces. For expert
   users who use other namespaces, I added patches that make it easier to
   show custom namespaces (specifically --decorate-all and
   log.decorateFilter=all). The logic for creating the default filter now
   uses the ref_namespaces array in such a way that it would be simple to
   reverse this decision, and I include that alternate implementation in a
   commit message.

 * This version includes several code and test style improvements.

 * The final patch demonstrates how we can remove some duplicate string
   literals for these namespaces. It is focused on the prefetch namespace
   (and an adjacent use of the tags namespace) because of how this series
   changes our handling of that namespace in particular. This makes it
   easier for a future change to modify the namespace via config or
   environment variables. There are opportunities to do this kind of update
   more widely, but I don't want to set that as a critical refactor to do
   right now.

Thanks, -Stolee

Derrick Stolee (11):
  refs: allow "HEAD" as decoration filter
  t4207: modernize test
  t4207: test coloring of grafted decorations
  refs: add array of ref namespaces
  refs: use ref_namespaces for replace refs base
  log-tree: use ref_namespaces instead of if/else-if
  log: add default decoration filter
  log: add --clear-decorations option
  log: create log.initialDecorationSet=all
  maintenance: stop writing log.excludeDecoration
  fetch: use ref_namespaces during prefetch

 Documentation/config/log.txt                  |   5 +
 Documentation/git-log.txt                     |  14 +-
 builtin/fetch.c                               |   6 +-
 builtin/gc.c                                  |   6 -
 builtin/log.c                                 |  84 ++++++++---
 builtin/replace.c                             |   3 +
 cache.h                                       |   1 -
 environment.c                                 |   5 +-
 log-tree.c                                    |  27 ++--
 notes.c                                       |   1 +
 refs.c                                        |  95 ++++++++++++-
 refs.h                                        |  46 ++++++
 t/t4013-diff-various.sh                       |   2 +
 t/t4013/diff.log_--decorate=full_--all        |   2 +-
 ..._--decorate=full_--clear-decorations_--all |  61 ++++++++
 ...f.log_--decorate=full_--decorate-all_--all |  61 ++++++++
 t/t4013/diff.log_--decorate_--all             |   2 +-
 ...f.log_--decorate_--clear-decorations_--all |  61 ++++++++
 .../diff.log_--decorate_--decorate-all_--all  |  61 ++++++++
 t/t4202-log.sh                                | 132 +++++++++++++++++-
 t/t4207-log-decoration-colors.sh              |  90 +++++++++---
 t/t7900-maintenance.sh                        |  21 ---
 22 files changed, 701 insertions(+), 85 deletions(-)
 create mode 100644 t/t4013/diff.log_--decorate=full_--clear-decorations_--all
 create mode 100644 t/t4013/diff.log_--decorate=full_--decorate-all_--all
 create mode 100644 t/t4013/diff.log_--decorate_--clear-decorations_--all
 create mode 100644 t/t4013/diff.log_--decorate_--decorate-all_--all


base-commit: 6a475b71f8c4ce708d69fdc9317aefbde3769e25
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1301%2Fderrickstolee%2Fdecorations-v3
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1301/derrickstolee/decorations-v3
Pull-Request: https://github.com/gitgitgadget/git/pull/1301

Range-diff vs v2:

  1:  c2e5a0b3a50 !  1:  1522889352f refs: allow "HEAD" as decoration filter
     @@ Commit message
      
          It is sufficient to only cover "HEAD" here and not include other special
          refs like REBASE_HEAD. This is because HEAD is the only ref outside of
     -    refs/* that is added to the list of decorations.
     +    refs/* that is added to the list of decorations. However, we may want to
     +    special-case these other refs in normalize_glob_ref() in the future.
     +    Leave a NEEDSWORK comment for now.
      
          Signed-off-by: Derrick Stolee <derrickstolee@github.com>
      
       ## refs.c ##
      @@ refs.c: void normalize_glob_ref(struct string_list_item *item, const char *prefix,
     + 	if (*pattern == '/')
     + 		BUG("pattern must not start with '/'");
       
     - 	if (prefix) {
     +-	if (prefix) {
     ++	if (prefix)
       		strbuf_addstr(&normalized_pattern, prefix);
      -	}
      -	else if (!starts_with(pattern, "refs/"))
     -+	} else if (!starts_with(pattern, "refs/") &&
     ++	else if (!starts_with(pattern, "refs/") &&
      +		   strcmp(pattern, "HEAD"))
       		strbuf_addstr(&normalized_pattern, "refs/");
     ++	/*
     ++	 * NEEDSWORK: Special case other symrefs such as REBASE_HEAD,
     ++	 * MERGE_HEAD, etc.
     ++	 */
     ++
       	strbuf_addstr(&normalized_pattern, pattern);
       	strbuf_strip_suffix(&normalized_pattern, "/");
     + 
      
       ## t/t4202-log.sh ##
      @@ t/t4202-log.sh: test_expect_success 'decorate-refs and simplify-by-decoration without output' '
  -:  ----------- >  2:  0633f8403db t4207: modernize test
  2:  b5eb110958b !  3:  fafe20c1e82 t4207: test coloring of grafted decorations
     @@ Commit message
      
       ## t/t4207-log-decoration-colors.sh ##
      @@ t/t4207-log-decoration-colors.sh: test_expect_success setup '
     + 	git config color.decorate.remoteBranch red &&
       	git config color.decorate.tag "reverse bold yellow" &&
       	git config color.decorate.stash magenta &&
     - 	git config color.decorate.HEAD cyan &&
      +	git config color.decorate.grafted black &&
     + 	git config color.decorate.HEAD cyan &&
       
       	c_reset="<RESET>" &&
     - 
      @@ t/t4207-log-decoration-colors.sh: test_expect_success setup '
       	c_tag="<BOLD;REVERSE;YELLOW>" &&
       	c_stash="<MAGENTA>" &&
     @@ t/t4207-log-decoration-colors.sh: test_expect_success setup '
       
       	test_commit A &&
       	git clone . other &&
     -@@ t/t4207-log-decoration-colors.sh: test_expect_success 'Commit Decorations Colored Correctly' '
     - 	test_cmp expected out
     +@@ t/t4207-log-decoration-colors.sh: On main: Changes to A.t
     + 	cmp_filtered_decorations
       '
       
     -+cat >expected <<EOF
     -+${c_commit}COMMIT_ID${c_reset}${c_commit} (${c_reset}${c_HEAD}HEAD ->\
     -+ ${c_reset}${c_branch}main${c_reset}${c_commit},\
     -+ ${c_reset}${c_tag}tag: D${c_reset}${c_commit})${c_reset} D
     -+${c_commit}COMMIT_ID${c_reset}${c_commit} (${c_reset}${c_tag}tag: C${c_reset}${c_commit},\
     -+ ${c_reset}${c_grafted}replaced${c_reset}${c_commit})${c_reset} B
     -+${c_commit}COMMIT_ID${c_reset}${c_commit} (${c_reset}${c_tag}tag: A${c_reset}${c_commit})${c_reset} A
     -+EOF
     -+
      +test_expect_success 'test coloring with replace-objects' '
      +	test_when_finished rm -rf .git/refs/replace* &&
      +	test_commit C &&
      +	test_commit D &&
      +
      +	git replace HEAD~1 HEAD~2 &&
     -+	git log --first-parent --abbrev=10 --decorate --oneline --color=always HEAD |
     -+	sed "s/[0-9a-f]\{10,10\}/COMMIT_ID/" |
     -+	test_decode_color >out &&
     -+	test_cmp expected out &&
     ++
     ++	cat >expect <<-EOF &&
     ++	${c_commit}COMMIT_ID${c_reset}${c_commit} (${c_reset}${c_HEAD}HEAD -> \
     ++${c_reset}${c_branch}main${c_reset}${c_commit}, \
     ++${c_reset}${c_tag}tag: D${c_reset}${c_commit})${c_reset} D
     ++	${c_commit}COMMIT_ID${c_reset}${c_commit} (${c_reset}${c_tag}tag: C${c_reset}${c_commit}, \
     ++${c_reset}${c_grafted}replaced${c_reset}${c_commit})${c_reset} B
     ++	${c_commit}COMMIT_ID${c_reset}${c_commit} (${c_reset}${c_tag}tag: A${c_reset}${c_commit})${c_reset} A
     ++EOF
     ++
     ++	git log --first-parent --no-abbrev --decorate --oneline --color=always HEAD >actual &&
     ++	cmp_filtered_decorations &&
      +	git replace -d HEAD~1 &&
      +
      +	GIT_REPLACE_REF_BASE=refs/replace2/ git replace HEAD~1 HEAD~2 &&
     -+	GIT_REPLACE_REF_BASE=refs/replace2/ git log --first-parent --abbrev=10 \
     -+		--decorate --oneline --color=always HEAD |
     -+	sed "s/[0-9a-f]\{10,10\}/COMMIT_ID/" |
     -+	test_decode_color >out &&
     -+	test_cmp expected out
     ++	GIT_REPLACE_REF_BASE=refs/replace2/ git log --first-parent \
     ++		--no-abbrev --decorate --oneline --color=always HEAD >actual &&
     ++	cmp_filtered_decorations
      +'
      +
     -+cat >expected <<EOF
     -+${c_commit}COMMIT_ID${c_reset}${c_commit} (${c_reset}${c_HEAD}HEAD ->\
     -+ ${c_reset}${c_branch}main${c_reset}${c_commit},\
     -+ ${c_reset}${c_tag}tag: D${c_reset}${c_commit},\
     -+ ${c_reset}${c_grafted}replaced${c_reset}${c_commit})${c_reset} D
     -+${c_commit}COMMIT_ID${c_reset}${c_commit} (${c_reset}${c_tag}tag: v1.0${c_reset}${c_commit},\
     -+ ${c_reset}${c_tag}tag: B${c_reset}${c_commit})${c_reset} B
     -+${c_commit}COMMIT_ID${c_reset}${c_commit} (${c_reset}${c_tag}tag: A${c_reset}${c_commit})${c_reset} A
     -+EOF
     -+
      +test_expect_success 'test coloring with grafted commit' '
      +	test_when_finished rm -rf .git/refs/replace* &&
      +
      +	git replace --graft HEAD HEAD~2 &&
     -+	git log --first-parent --abbrev=10 --decorate --oneline --color=always HEAD |
     -+	sed "s/[0-9a-f]\{10,10\}/COMMIT_ID/" |
     -+	test_decode_color >out &&
     -+	test_cmp expected out &&
     ++
     ++	cat >expect <<-EOF &&
     ++	${c_commit}COMMIT_ID${c_reset}${c_commit} (${c_reset}${c_HEAD}HEAD -> \
     ++${c_reset}${c_branch}main${c_reset}${c_commit}, \
     ++${c_reset}${c_tag}tag: D${c_reset}${c_commit}, \
     ++${c_reset}${c_grafted}replaced${c_reset}${c_commit})${c_reset} D
     ++	${c_commit}COMMIT_ID${c_reset}${c_commit} (${c_reset}${c_tag}tag: v1.0${c_reset}${c_commit}, \
     ++${c_reset}${c_tag}tag: B${c_reset}${c_commit})${c_reset} B
     ++	${c_commit}COMMIT_ID${c_reset}${c_commit} (${c_reset}${c_tag}tag: A${c_reset}${c_commit})${c_reset} A
     ++	EOF
     ++
     ++	git log --first-parent --no-abbrev --decorate --oneline --color=always HEAD >actual &&
     ++	cmp_filtered_decorations &&
      +	git replace -d HEAD &&
      +
      +	GIT_REPLACE_REF_BASE=refs/replace2/ git replace --graft HEAD HEAD~2 &&
     -+	GIT_REPLACE_REF_BASE=refs/replace2/ git log --first-parent --abbrev=10 \
     -+		--decorate --oneline --color=always HEAD |
     -+	sed "s/[0-9a-f]\{10,10\}/COMMIT_ID/" |
     -+	test_decode_color >out &&
     -+	test_cmp expected out
     ++	GIT_REPLACE_REF_BASE=refs/replace2/ git log --first-parent \
     ++		--no-abbrev --decorate --oneline --color=always HEAD >actual &&
     ++	cmp_filtered_decorations
      +'
      +
       test_done
  3:  d7486390d57 !  4:  475ebca6310 refs: add array of ref namespaces
     @@ refs.c: static unsigned char refname_disposition[256] = {
       	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 3, 0, 0, 4, 4
       };
       
     -+struct ref_namespace_info ref_namespaces[] = {
     ++struct ref_namespace_info ref_namespace[] = {
      +	[NAMESPACE_HEAD] = {
      +		.ref = "HEAD",
      +		.decoration = DECORATION_REF_HEAD,
     @@ refs.c: static unsigned char refname_disposition[256] = {
      +		/*
      +		 * The refs/notes/commit ref points to the tip of a
      +		 * parallel commit history that adds metadata to commits
     -+		 * in the normal history. This branch can be overwritten
     ++		 * in the normal history. This ref can be overwritten
      +		 * by the core.notesRef config variable or the
      +		 * GIT_NOTES_REFS environment variable.
      +		 */
     @@ refs.c: static unsigned char refname_disposition[256] = {
      +
      +void update_ref_namespace(enum ref_namespace namespace, char *ref)
      +{
     -+	struct ref_namespace_info *info = &ref_namespaces[namespace];
     ++	struct ref_namespace_info *info = &ref_namespace[namespace];
      +	if (info->ref_updated)
      +		free(info->ref);
      +	info->ref = ref;
     @@ refs.h: struct ref_store *get_main_ref_store(struct repository *r);
       
      +/*
      + * Some of the names specified by refs have special meaning to Git.
     -+ * Organize these namespaces in a comon 'ref_namespaces' array for
     ++ * Organize these namespaces in a comon 'ref_namespace' array for
      + * reference from multiple places in the codebase.
      + */
      +
     @@ refs.h: struct ref_store *get_main_ref_store(struct repository *r);
      +	 * If 'exact' is true, then we must match the 'ref' exactly.
      +	 * Otherwise, use a prefix match.
      +	 *
     -+	 * 'orig_ref' is for internal use. It represents whether the
     ++	 * 'ref_updated' is for internal use. It represents whether the
      +	 * 'ref' value was replaced from its original literal version.
      +	 */
      +	unsigned exact:1,
     @@ refs.h: struct ref_store *get_main_ref_store(struct repository *r);
      +};
      +
      +/* See refs.c for the contents of this array. */
     -+extern struct ref_namespace_info ref_namespaces[];
     ++extern struct ref_namespace_info ref_namespace[NAMESPACE__COUNT];
      +
      +/*
      + * Some ref namespaces can be modified by config values or environment
  4:  8da0b0a3181 !  5:  45e3ce94d0d refs: use ref_namespaces for replace refs base
     @@ builtin/replace.c: static int for_each_replace_name(const char **argv, each_repl
       	size_t base_len;
       	int had_error = 0;
       	struct object_id oid;
     -+	const char *git_replace_ref_base = ref_namespaces[NAMESPACE_REPLACE].ref;
     ++	const char *git_replace_ref_base = ref_namespace[NAMESPACE_REPLACE].ref;
       
       	strbuf_addstr(&ref, git_replace_ref_base);
       	base_len = ref.len;
     @@ builtin/replace.c: static int check_ref_valid(struct object_id *object,
       			    struct strbuf *ref,
       			    int force)
       {
     -+	const char *git_replace_ref_base = ref_namespaces[NAMESPACE_REPLACE].ref;
     ++	const char *git_replace_ref_base = ref_namespace[NAMESPACE_REPLACE].ref;
      +
       	strbuf_reset(ref);
       	strbuf_addf(ref, "%s%s", git_replace_ref_base, oid_to_hex(object));
     @@ log-tree.c: static int add_ref_decoration(const char *refname, const struct obje
       	enum object_type objtype;
       	enum decoration_type deco_type = DECORATION_NONE;
       	struct decoration_filter *filter = (struct decoration_filter *)cb_data;
     -+	const char *git_replace_ref_base;
     ++	const char *git_replace_ref_base = ref_namespace[NAMESPACE_REPLACE].ref;
       
       	if (filter && !ref_filter_match(refname, filter))
       		return 0;
     - 
     -+	git_replace_ref_base = ref_namespaces[NAMESPACE_REPLACE].ref;
     - 	if (starts_with(refname, git_replace_ref_base)) {
     - 		struct object_id original_oid;
     - 		if (!read_replace_refs)
      
       ## refs.c ##
      @@ refs.c: int refs_for_each_fullref_in(struct ref_store *refs, const char *prefix,
       
       int for_each_replace_ref(struct repository *r, each_repo_ref_fn fn, void *cb_data)
       {
     -+	const char *git_replace_ref_base = ref_namespaces[NAMESPACE_REPLACE].ref;
     ++	const char *git_replace_ref_base = ref_namespace[NAMESPACE_REPLACE].ref;
       	return do_for_each_repo_ref(r, git_replace_ref_base, fn,
       				    strlen(git_replace_ref_base),
       				    DO_FOR_EACH_INCLUDE_BROKEN, cb_data);
  5:  53b15a0b793 !  6:  063e5bac2ce log-tree: use ref_namespaces instead of if/else-if
     @@ log-tree.c: static int add_ref_decoration(const char *refname, const struct obje
      -		deco_type = DECORATION_REF_STASH;
      -	else if (!strcmp(refname, "HEAD"))
      -		deco_type = DECORATION_REF_HEAD;
     -+	for (i = 0; i < NAMESPACE__COUNT; i++) {
     -+		struct ref_namespace_info *info = &ref_namespaces[i];
     ++	for (i = 0; i < ARRAY_SIZE(ref_namespace); i++) {
     ++		struct ref_namespace_info *info = &ref_namespace[i];
      +
      +		if (!info->decoration)
      +			continue;
  6:  bec532fb8c6 !  7:  c249bface2a log: add default decoration filter
     @@ builtin/log.c: static void cmd_log_init_defaults(struct rev_info *rev)
      +	 * No command-line or config options were given, so
      +	 * populate with sensible defaults.
      +	 */
     -+	for (i = 0; i < NAMESPACE__COUNT; i++) {
     -+		if (!ref_namespaces[i].decoration)
     ++	for (i = 0; i < ARRAY_SIZE(ref_namespace); i++) {
     ++		if (!ref_namespace[i].decoration)
      +			continue;
      +
     -+		string_list_append(include, ref_namespaces[i].ref);
     ++		string_list_append(include, ref_namespace[i].ref);
      +	}
      +}
      +
     @@ t/t4202-log.sh: test_expect_success 'log --decorate includes all levels of tag a
      +
      +	git log --decorate=full --oneline >actual &&
      +
     -+	for ref in $reflist
     -+	do
     -+		! grep $ref/fake actual || return 1
     -+	done
     ++	# None of the refs are visible:
     ++	! grep /fake actual
      +'
      +
       test_expect_success 'log --end-of-options' '
  7:  64ee889369d !  8:  1b12374ff1b log: add --decorate-all option
     @@ Metadata
      Author: Derrick Stolee <derrickstolee@github.com>
      
       ## Commit message ##
     -    log: add --decorate-all option
     +    log: add --clear-decorations option
     +
     +    The previous changes introduced a new default ref filter for decorations
     +    in the 'git log' command. This can be overridden using
     +    --decorate-refs=HEAD and --decorate-refs=refs/, but that is cumbersome
     +    for users.
     +
     +    Instead, add a --clear-decorations option that resets all previous
     +    filters to a blank filter that accepts all refs.
      
          Signed-off-by: Derrick Stolee <derrickstolee@github.com>
      
     @@ Documentation/git-log.txt: If none of these options or config settings are given
       used as decoration if they match `HEAD`, `refs/heads/`, `refs/remotes/`,
       `refs/stash/`, or `refs/tags/`.
       
     -+--decorate-all::
     ++--clear-decorations::
      +	When specified, this option clears all previous `--decorate-refs`
      +	or `--decorate-refs-exclude` options and relaxes the default
     -+	decoration filter to include all possible decoration refs.
     ++	decoration filter to include all references.
      +
       --source::
       	Print out the ref name given on the command line by which each
     @@ builtin/log.c: static int parse_decoration_style(const char *value)
       	return -1;
       }
       
     -+static int decorate_all;
     ++static int use_default_decoration_filter = 1;
      +static struct string_list decorate_refs_exclude = STRING_LIST_INIT_NODUP;
      +static struct string_list decorate_refs_exclude_config = STRING_LIST_INIT_NODUP;
      +static struct string_list decorate_refs_include = STRING_LIST_INIT_NODUP;
      +
     -+static int decorate_all_callback(const struct option *opt,
     -+				 const char *arg, int unset)
     ++static int clear_decorations_callback(const struct option *opt,
     ++					    const char *arg, int unset)
      +{
     -+	if (unset) {
     -+		decorate_all = 0;
     -+		return 0;
     -+	}
     -+
      +	string_list_clear(&decorate_refs_include, 0);
      +	string_list_clear(&decorate_refs_exclude, 0);
     -+	decorate_all = 1;
     ++	use_default_decoration_filter = 0;
      +	return 0;
      +}
      +
     @@ builtin/log.c: static void set_default_decoration_filter(struct decoration_filte
       	}
       
      -	if (decoration_filter->exclude_ref_pattern->nr ||
     -+	if (decorate_all ||
     ++	if (!use_default_decoration_filter ||
      +	    decoration_filter->exclude_ref_pattern->nr ||
       	    decoration_filter->include_ref_pattern->nr ||
       	    decoration_filter->exclude_ref_config_pattern->nr)
     @@ builtin/log.c: static void cmd_log_init_finish(int argc, const char **argv, cons
       		OPT_BOOL(0, "source", &source, N_("show source")),
       		OPT_BOOL(0, "use-mailmap", &mailmap, N_("use mail map file")),
       		OPT_ALIAS(0, "mailmap", "use-mailmap"),
     -+		OPT_CALLBACK_F(0, "decorate-all", NULL, NULL, N_("how all ref decorations"),
     -+			       PARSE_OPT_NOARG, decorate_all_callback),
     ++		OPT_CALLBACK_F(0, "clear-decorations", NULL, NULL,
     ++			       N_("clear all previously-defined decoration filters"),
     ++			       PARSE_OPT_NOARG | PARSE_OPT_NONEG,
     ++			       clear_decorations_callback),
       		OPT_STRING_LIST(0, "decorate-refs", &decorate_refs_include,
       				N_("pattern"), N_("only decorate refs that match <pattern>")),
       		OPT_STRING_LIST(0, "decorate-refs-exclude", &decorate_refs_exclude,
     @@ t/t4013-diff-various.sh: log -GF -p --pickaxe-all master
       log -IA -IB -I1 -I2 -p master
       log --decorate --all
       log --decorate=full --all
     -+log --decorate --decorate-all --all
     -+log --decorate=full --decorate-all --all
     ++log --decorate --clear-decorations --all
     ++log --decorate=full --clear-decorations --all
       
       rev-list --parents HEAD
       rev-list --children HEAD
      
     + ## t/t4013/diff.log_--decorate=full_--clear-decorations_--all (new) ##
     +@@
     ++$ git log --decorate=full --clear-decorations --all
     ++commit b7e0bc69303b488b47deca799a7d723971dfa6cd (refs/heads/mode)
     ++Author: A U Thor <author@example.com>
     ++Date:   Mon Jun 26 00:06:00 2006 +0000
     ++
     ++    update mode
     ++
     ++commit a6f364368ca320bc5a92e18912e16fa6b3dff598 (refs/heads/note)
     ++Author: A U Thor <author@example.com>
     ++Date:   Mon Jun 26 00:06:00 2006 +0000
     ++
     ++    update mode (file2)
     ++
     ++Notes:
     ++    note
     ++
     ++commit cd4e72fd96faed3f0ba949dc42967430374e2290 (refs/heads/rearrange)
     ++Author: A U Thor <author@example.com>
     ++Date:   Mon Jun 26 00:06:00 2006 +0000
     ++
     ++    Rearranged lines in dir/sub
     ++
     ++commit cbacedd14cb8b89255a2c02b59e77a2e9a8021a0 (refs/notes/commits)
     ++Author: A U Thor <author@example.com>
     ++Date:   Mon Jun 26 00:06:00 2006 +0000
     ++
     ++    Notes added by 'git notes add'
     ++
     ++commit 59d314ad6f356dd08601a4cd5e530381da3e3c64 (HEAD -> refs/heads/master)
     ++Merge: 9a6d494 c7a2ab9
     ++Author: A U Thor <author@example.com>
     ++Date:   Mon Jun 26 00:04:00 2006 +0000
     ++
     ++    Merge branch 'side'
     ++
     ++commit c7a2ab9e8eac7b117442a607d5a9b3950ae34d5a (refs/heads/side)
     ++Author: A U Thor <author@example.com>
     ++Date:   Mon Jun 26 00:03:00 2006 +0000
     ++
     ++    Side
     ++
     ++commit 9a6d4949b6b76956d9d5e26f2791ec2ceff5fdc0
     ++Author: A U Thor <author@example.com>
     ++Date:   Mon Jun 26 00:02:00 2006 +0000
     ++
     ++    Third
     ++
     ++commit 1bde4ae5f36c8d9abe3a0fce0c6aab3c4a12fe44
     ++Author: A U Thor <author@example.com>
     ++Date:   Mon Jun 26 00:01:00 2006 +0000
     ++
     ++    Second
     ++    
     ++    This is the second commit.
     ++
     ++commit 444ac553ac7612cc88969031b02b3767fb8a353a (refs/heads/initial)
     ++Author: A U Thor <author@example.com>
     ++Date:   Mon Jun 26 00:00:00 2006 +0000
     ++
     ++    Initial
     ++$
     +
       ## t/t4013/diff.log_--decorate=full_--decorate-all_--all (new) ##
      @@
      +$ git log --decorate=full --decorate-all --all
     @@ t/t4013/diff.log_--decorate=full_--decorate-all_--all (new)
      +Date:   Mon Jun 26 00:00:00 2006 +0000
      +
      +    Initial
     ++$
     +
     + ## t/t4013/diff.log_--decorate_--clear-decorations_--all (new) ##
     +@@
     ++$ git log --decorate --clear-decorations --all
     ++commit b7e0bc69303b488b47deca799a7d723971dfa6cd (mode)
     ++Author: A U Thor <author@example.com>
     ++Date:   Mon Jun 26 00:06:00 2006 +0000
     ++
     ++    update mode
     ++
     ++commit a6f364368ca320bc5a92e18912e16fa6b3dff598 (note)
     ++Author: A U Thor <author@example.com>
     ++Date:   Mon Jun 26 00:06:00 2006 +0000
     ++
     ++    update mode (file2)
     ++
     ++Notes:
     ++    note
     ++
     ++commit cd4e72fd96faed3f0ba949dc42967430374e2290 (rearrange)
     ++Author: A U Thor <author@example.com>
     ++Date:   Mon Jun 26 00:06:00 2006 +0000
     ++
     ++    Rearranged lines in dir/sub
     ++
     ++commit cbacedd14cb8b89255a2c02b59e77a2e9a8021a0 (refs/notes/commits)
     ++Author: A U Thor <author@example.com>
     ++Date:   Mon Jun 26 00:06:00 2006 +0000
     ++
     ++    Notes added by 'git notes add'
     ++
     ++commit 59d314ad6f356dd08601a4cd5e530381da3e3c64 (HEAD -> master)
     ++Merge: 9a6d494 c7a2ab9
     ++Author: A U Thor <author@example.com>
     ++Date:   Mon Jun 26 00:04:00 2006 +0000
     ++
     ++    Merge branch 'side'
     ++
     ++commit c7a2ab9e8eac7b117442a607d5a9b3950ae34d5a (side)
     ++Author: A U Thor <author@example.com>
     ++Date:   Mon Jun 26 00:03:00 2006 +0000
     ++
     ++    Side
     ++
     ++commit 9a6d4949b6b76956d9d5e26f2791ec2ceff5fdc0
     ++Author: A U Thor <author@example.com>
     ++Date:   Mon Jun 26 00:02:00 2006 +0000
     ++
     ++    Third
     ++
     ++commit 1bde4ae5f36c8d9abe3a0fce0c6aab3c4a12fe44
     ++Author: A U Thor <author@example.com>
     ++Date:   Mon Jun 26 00:01:00 2006 +0000
     ++
     ++    Second
     ++    
     ++    This is the second commit.
     ++
     ++commit 444ac553ac7612cc88969031b02b3767fb8a353a (initial)
     ++Author: A U Thor <author@example.com>
     ++Date:   Mon Jun 26 00:00:00 2006 +0000
     ++
     ++    Initial
      +$
      
       ## t/t4013/diff.log_--decorate_--decorate-all_--all (new) ##
     @@ t/t4202-log.sh: test_expect_success 'decorate-refs focus from default' '
       	! grep HEAD actual
       '
       
     -+test_expect_success '--decorate-all overrides defaults' '
     ++test_expect_success '--clear-decorations overrides defaults' '
      +	cat >expect.default <<-\EOF &&
      +	Merge-tag-reach (HEAD -> refs/heads/main)
      +	Merge-tags-octopus-a-and-octopus-b
     @@ t/t4202-log.sh: test_expect_success 'decorate-refs focus from default' '
      +	initial
      +	EOF
      +	git log --decorate=full --pretty="tformat:%f%d" \
     -+		--decorate-all >actual &&
     ++		--clear-decorations >actual &&
      +	test_cmp expect.all actual
      +'
      +
     -+test_expect_success '--decorate-all clears previous exclusions' '
     ++test_expect_success '--clear-decorations clears previous exclusions' '
      +	cat >expect.all <<-\EOF &&
      +	Merge-tag-reach (HEAD -> refs/heads/main)
      +	reach (tag: refs/tags/reach, refs/heads/reach)
     @@ t/t4202-log.sh: test_expect_success 'decorate-refs focus from default' '
      +		--simplify-by-decoration \
      +		--decorate-refs-exclude="heads/octopus*" \
      +		--decorate-refs="heads" \
     -+		--decorate-all >actual &&
     ++		--clear-decorations >actual &&
      +	test_cmp expect.all actual &&
      +
      +	cat >expect.filtered <<-\EOF &&
     @@ t/t4202-log.sh: test_expect_success 'decorate-refs focus from default' '
      +		--simplify-by-decoration \
      +		--decorate-refs-exclude="heads/octopus" \
      +		--decorate-refs="heads" \
     -+		--decorate-all \
     ++		--clear-decorations \
      +		--decorate-refs-exclude="tags/" \
      +		--decorate-refs="heads/octopus*" >actual &&
      +	test_cmp expect.filtered actual
  8:  8142b32f023 !  9:  7ec2578b90a log: create log.decorateFilter=all
     @@ Metadata
      Author: Derrick Stolee <derrickstolee@github.com>
      
       ## Commit message ##
     -    log: create log.decorateFilter=all
     +    log: create log.initialDecorationSet=all
      
     -    The previous change introduced the --decorate-all option for users who
     -    do not want their decorations limited to a narrow set of ref namespaces.
     +    The previous change introduced the --clear-decorations option for users
     +    who do not want their decorations limited to a narrow set of ref
     +    namespaces.
      
     -    Add a config option that is equivalent to specifying --decorate-all by
     -    default.
     +    Add a config option that is equivalent to specifying --clear-decorations
     +    by default.
      
          Signed-off-by: Derrick Stolee <derrickstolee@github.com>
      
     @@ Documentation/config/log.txt: log.decorate::
       	names are shown. This is the same as the `--decorate` option
       	of the `git log`.
       
     -+log.decorateFilter::
     ++log.initialDecorationSet::
      +	By default, `git log` only shows decorations for certain known ref
     -+	namespaces. If 'all' is specified, then show all possible ref
     -+	decorations. Default value is 'default'.
     ++	namespaces. If 'all' is specified, then show all refs as
     ++	decorations.
      +
       log.excludeDecoration::
       	Exclude the specified patterns from the log decorations. This is
     @@ Documentation/config/log.txt: log.decorate::
      
       ## Documentation/git-log.txt ##
      @@ Documentation/git-log.txt: used as decoration if they match `HEAD`, `refs/heads/`, `refs/remotes/`,
     - --decorate-all::
     + --clear-decorations::
       	When specified, this option clears all previous `--decorate-refs`
       	or `--decorate-refs-exclude` options and relaxes the default
     --	decoration filter to include all possible decoration refs.
     -+	decoration filter to include all possible decoration refs. This
     -+	option is assumed if the config value `log.decorateFilter` is set
     -+	to `all`.
     +-	decoration filter to include all references.
     ++	decoration filter to include all references. This option is
     ++	assumed if the config value `log.initialDecorationSet` is set to
     ++	`all`.
       
       --source::
       	Print out the ref name given on the command line by which each
     @@ builtin/log.c: static void set_default_decoration_filter(struct decoration_filte
       
      +	/*
      +	 * By default, decorate_all is disabled. Enable it if
     -+	 * log.decorateMode=all. Don't ever disable it by config, since
     -+	 * the command-line takes precedent.
     ++	 * log.initialDecorationSet=all. Don't ever disable it by config,
     ++	 * since the command-line takes precedent.
      +	 */
     -+	if (!decorate_all &&
     -+	    !git_config_get_string("log.decoratefilter", &value) &&
     ++	if (use_default_decoration_filter &&
     ++	    !git_config_get_string("log.initialdecorationset", &value) &&
      +	    !strcmp("all", value))
     -+		decorate_all = 1;
     ++		use_default_decoration_filter = 0;
      +	free(value);
      +
     - 	if (decorate_all ||
     + 	if (!use_default_decoration_filter ||
       	    decoration_filter->exclude_ref_pattern->nr ||
       	    decoration_filter->include_ref_pattern->nr ||
      
       ## t/t4202-log.sh ##
     -@@ t/t4202-log.sh: test_expect_success '--decorate-all overrides defaults' '
     +@@ t/t4202-log.sh: test_expect_success '--clear-decorations overrides defaults' '
       	EOF
       	git log --decorate=full --pretty="tformat:%f%d" \
     - 		--decorate-all >actual &&
     + 		--clear-decorations >actual &&
      +	test_cmp expect.all actual &&
     -+	git -c log.decorateFilter=all log \
     ++	git -c log.initialDecorationSet=all log \
      +		--decorate=full --pretty="tformat:%f%d" >actual &&
       	test_cmp expect.all actual
       '
       
     -
     - ## t/t9902-completion.sh ##
     -@@ t/t9902-completion.sh: test_expect_success 'git config - variable name' '
     - 	test_completion "git config log.d" <<-\EOF
     - 	log.date Z
     - 	log.decorate Z
     -+	log.decorateFilter Z
     - 	log.diffMerges Z
     - 	EOF
     - '
     -@@ t/t9902-completion.sh: test_expect_success 'git -c - variable name' '
     - 	test_completion "git -c log.d" <<-\EOF
     - 	log.date=Z
     - 	log.decorate=Z
     -+	log.decorateFilter=Z
     - 	log.diffMerges=Z
     - 	EOF
     - '
     -@@ t/t9902-completion.sh: test_expect_success 'git clone --config= - variable name' '
     - 	test_completion "git clone --config=log.d" <<-\EOF
     - 	log.date=Z
     - 	log.decorate=Z
     -+	log.decorateFilter=Z
     - 	log.diffMerges=Z
     - 	EOF
     - '
  9:  318269dfe27 = 10:  1f4d9bc4b3f maintenance: stop writing log.excludeDecoration
 10:  8599bb55045 ! 11:  bd2ffac88ac fetch: use ref_namespaces during prefetch
     @@ builtin/fetch.c: static void filter_prefetch_refspec(struct refspec *rs)
       		    (rs->items[i].src &&
      -		     !strncmp(rs->items[i].src, "refs/tags/", 10))) {
      +		     !strncmp(rs->items[i].src,
     -+			      ref_namespaces[NAMESPACE_TAGS].ref,
     -+			      strlen(ref_namespaces[NAMESPACE_TAGS].ref)))) {
     ++			      ref_namespace[NAMESPACE_TAGS].ref,
     ++			      strlen(ref_namespace[NAMESPACE_TAGS].ref)))) {
       			int j;
       
       			free(rs->items[i].src);
     @@ builtin/fetch.c: static void filter_prefetch_refspec(struct refspec *rs)
       
       		old_dst = rs->items[i].dst;
      -		strbuf_addstr(&new_dst, "refs/prefetch/");
     -+		strbuf_addstr(&new_dst, ref_namespaces[NAMESPACE_PREFETCH].ref);
     ++		strbuf_addstr(&new_dst, ref_namespace[NAMESPACE_PREFETCH].ref);
       
       		/*
       		 * If old_dst starts with "refs/", then place

-- 
gitgitgadget
