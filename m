Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 413F0C43334
	for <git@archiver.kernel.org>; Thu, 30 Jun 2022 21:19:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237354AbiF3VTo (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 30 Jun 2022 17:19:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233505AbiF3VTo (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 30 Jun 2022 17:19:44 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CDE845784
        for <git@vger.kernel.org>; Thu, 30 Jun 2022 14:19:42 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id c130-20020a1c3588000000b0039c6fd897b4so2497601wma.4
        for <git@vger.kernel.org>; Thu, 30 Jun 2022 14:19:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:mime-version
         :content-transfer-encoding:fcc:to:cc;
        bh=GGUb0ltnai3Eqiyc2h6ZMz4PTJXH/M4Kj4j0PdgrvMc=;
        b=RCVJYrpK7uhfj9CQ+1vdiqs1QXXsOt2FPjVwTtlKkhbVny3d0jliiQoVoNWr6e+Ld8
         2a8VHN88r4Em6DrPJ+z+gtGNWNYKh1tz3fVFHsBoSeEKu03yt5jc9aTCn1FOenZc17oS
         Gcb60pyt+P/9RdpHYTJaNnrpeqeU3ufLc+MlbDDrX0vHVUEzPpKe1pfRh+welRccx8pO
         ABk2ylraT40eUibBQOXYVBDVbQcLieYYtNq/gXvqjI7N9rr1eq2DEXJ7QkU9qwmROGhs
         8zr3HY02HvRsdzAPNF1j518StGitP4PseBq/2PCaUkGMCYcon4arJpniJG9ShltACxFT
         gsZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:mime-version:content-transfer-encoding:fcc:to:cc;
        bh=GGUb0ltnai3Eqiyc2h6ZMz4PTJXH/M4Kj4j0PdgrvMc=;
        b=Lv4Ps936JUFHeKax9EQdKFeJ86xPQ8YzCknZA/P9F0mzVCF1LYDloarALQft7mxHmo
         NkrBNekbLbtwsO61z0+wpyjk5Mmnj7+8lVo8nMosZbdL7B8xf3QLb+G6S3YApWVnNymx
         j6D5Y53VpcnEyvVVSevw4uEbT1fxLM3emR4rgBe23wUHASvvF89Tr2kvSBF+1j3CLapZ
         bS8niZzzQjtKhUTFPX3NADxV7rv2zR9nDATW5Lwjp5+Ns/auDeWXsQXQAJDfLSfIkpk2
         B21Sy0GL5fLIrMm0dMuaDswJfTX9AXxWh2Wb6n9TSkkW27LVP70RQGXsFMhOyId0BSRf
         CWaw==
X-Gm-Message-State: AJIora+ru5D9TrvsqoA9xm7U/ALdCQGPyI+U7HIJdz2l2RCI7327BaYK
        KLRC+mBX6LADeZ6zVkTzSNaNWsQFiP4=
X-Google-Smtp-Source: AGRyM1uFXRGFBKsYDwg1bE1EVOKg1pTMYTTaaDMgbkjoe6hU7EDG74EycQnJCgLJSl2ObCVukaJ7ww==
X-Received: by 2002:a05:600c:3ac3:b0:3a0:45b6:7efb with SMTP id d3-20020a05600c3ac300b003a045b67efbmr13997570wms.183.1656623980492;
        Thu, 30 Jun 2022 14:19:40 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id u23-20020a7bcb17000000b0039aef592ca0sm7598935wmj.35.2022.06.30.14.19.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jun 2022 14:19:39 -0700 (PDT)
Message-Id: <pull.1282.v2.git.git.1656623978.gitgitgadget@gmail.com>
In-Reply-To: <pull.1282.git.git.1656372017.gitgitgadget@gmail.com>
References: <pull.1282.git.git.1656372017.gitgitgadget@gmail.com>
From:   "Glen Choo via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 30 Jun 2022 21:19:20 +0000
Subject: [PATCH v2 00/18] submodule: remove "--recursive-prefix"
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Fcc:    Sent
To:     git@vger.kernel.org
Cc:     Atharva Raykar <raykar.ath@gmail.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Glen Choo <chooglen@google.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thanks Ævar for the feedback! I've incorporated all of the suggestions,
except breaking up the tests in 1/6 into their own patch - I wasn't
convinced of the value of having prescriptive tests (with
test_expect_failure), and I found it difficult to discuss descriptive tests
(with test_expect_success) without also having the code in the same diff.
FWIW, this version (and the previous one) "git rebase -x 'make test'"
cleanly :)

Note for Junio: this version is based on ab/submodule-cleanup (and so will
future versions).

= Description

This series is a refactor of "git submodule--helper update" that replaces
"--recursive-prefix" with "--super-prefix" (see Background). This was
initially motivated by:

 * Junio's suggestion to simplify the code [1] (in response to a memory leak
   found by Johannes Schindelin [2]).
 * A desire to use the module_list API + get_submodule_displaypath() outside
   of builtin/submodule--helper.c (I expect to use this to check out
   branches in each submodule).

But it also happens to remove some overly complicated/duplicated code that
was literally converted from shell :)

= Background

When recursing into nested submodules, Git commands keep track of the path
from the superproject to the submodule in order to print a "display path" to
the user, e.g.

Submodule path '../super/sub/nested-sub': checked out 'abcdef'

For historical reasons, "git submodule--helper update" uses
"--recursive-prefix" for this purpose, but it should use "--super-prefix"
instead because:

 * That's what every other command uses (not just submodule--helper
   subcommands).
 * Using the "--super-prefix" helper functions makes the "git
   submodule--helper update" code simpler

= Patch organization

 * Patch 1/6 makes sure that display paths are only computed using display
   path helper functions ([do_]get_submodule_displaypath()) and fixes some
   display paths that we never realized were broken.
 * Patches 2-3/6 simplify and deduplicate some display path computations.
 * Patch 4/6 (authored by Ævar) removes SUPPORT_SUPER_PREFIX where it's not
   needed.
   * This doesn't affect correctness, but we want to do this eventually, so
     do it now to make 5/6 a bit cleaner.
 * Patch 5/6 replaces "--recursive-prefix" with "--super-prefix", making
   do_get_submodule_displaypath() obsolete.
   * GGG outputs an odd diff; I recommend viewing it with "--histogram"
 * Patch 6/6 removes do_get_submodule_displaypath().

= Series history

Changes in v2:

 * Rebase onto ab/submodule-cleanup (previously master)
 * Cherry pick https://github.com/avar/git/commit/f445c57490d into 4/6
 * Style fixes in .c and tests

= Future work

At the end of this series, get_submodule_displaypath() can be moved to
submodule.h, which would make submodule.c:get_super_prefix_or_empty()
obsolete. I have a patch that demonstrates this (CI run: [4]), but I decided
to keep this series more focused on "git submodule--helper update" so that
it's easier to review.

[1] https://lore.kernel.org/git/xmqq35g5xmmv.fsf@gitster.g [2]
https://lore.kernel.org/git/877a45867ae368bf9e053caedcb6cf421e02344d.1655336146.git.gitgitgadget@gmail.com
[3]
https://lore.kernel.org/git/patch-v3-02.12-082e015781e-20220622T142012Z-avarab@gmail.com
[4] https://github.com/chooglen/git/actions/runs/2572557584

Glen Choo (6):
  submodule--helper: eliminate internal "--update" option
  submodule--helper update: use display path helper
  submodule--helper: don't recreate recursive prefix
  submodule--helper: use correct display path helper
  submodule--helper update: use --super-prefix
  submodule--helper: remove display path helper

Ævar Arnfjörð Bjarmason (12):
  git-submodule.sh: remove unused sanitize_submodule_env()
  git-submodule.sh: remove unused $prefix variable
  git-submodule.sh: make the "$cached" variable a boolean
  git-submodule.sh: remove unused top-level "--branch" argument
  submodule--helper: have --require-init imply --init
  submodule update: remove "-v" option
  submodule--helper: rename "absorb-git-dirs" to "absorbgitdirs"
  submodule--helper: report "submodule" as our name in some "-h" output
  submodule--helper: understand --checkout, --merge and --rebase
    synonyms
  git-submodule.sh: use "$quiet", not "$GIT_QUIET"
  git-sh-setup.sh: remove "say" function, change last users
  submodule--helper: remove unused SUPPORT_SUPER_PREFIX flags

 builtin/submodule--helper.c    | 161 +++++++++++++++------------------
 contrib/subtree/git-subtree.sh |  15 ++-
 git-instaweb.sh                |   2 +-
 git-sh-setup.sh                |  16 ----
 git-submodule.sh               |  88 +++++++-----------
 submodule.c                    |   2 +-
 t/t7406-submodule-update.sh    |  58 +++++++++++-
 7 files changed, 175 insertions(+), 167 deletions(-)


base-commit: 8168d5e9c23ed44ae3d604f392320d66556453c9
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1282%2Fchooglen%2Fsubmodule%2Fremove-recursive-prefix-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1282/chooglen/submodule/remove-recursive-prefix-v2
Pull-Request: https://github.com/git/git/pull/1282

Range-diff vs v1:

  -:  ----------- >  1:  85775255f18 git-submodule.sh: remove unused sanitize_submodule_env()
  -:  ----------- >  2:  960fad98e8a git-submodule.sh: remove unused $prefix variable
  -:  ----------- >  3:  757d0927976 git-submodule.sh: make the "$cached" variable a boolean
  -:  ----------- >  4:  da3aae9e847 git-submodule.sh: remove unused top-level "--branch" argument
  -:  ----------- >  5:  d9c7f69aaa6 submodule--helper: have --require-init imply --init
  -:  ----------- >  6:  0d68ee723e5 submodule update: remove "-v" option
  -:  ----------- >  7:  6e556c412e9 submodule--helper: rename "absorb-git-dirs" to "absorbgitdirs"
  -:  ----------- >  8:  36d45163b6d submodule--helper: report "submodule" as our name in some "-h" output
  -:  ----------- >  9:  8f12108c295 submodule--helper: understand --checkout, --merge and --rebase synonyms
  -:  ----------- > 10:  b788fc671bf submodule--helper: eliminate internal "--update" option
  -:  ----------- > 11:  2eec4637397 git-submodule.sh: use "$quiet", not "$GIT_QUIET"
  -:  ----------- > 12:  5b893f7d81e git-sh-setup.sh: remove "say" function, change last users
  1:  473548f2fa4 ! 13:  64c138df196 submodule--helper update: use display path helper
     @@ builtin/submodule--helper.c: static int prepare_to_clone_next_submodule(const st
      -	struct strbuf displaypath_sb = STRBUF_INIT;
       	struct strbuf sb = STRBUF_INIT;
      -	const char *displaypath = NULL;
     -+	char *displaypath = NULL;
     ++	char *displaypath;
       	int needs_cloning = 0;
       	int need_free_url = 0;
       
     @@ builtin/submodule--helper.c: static int prepare_to_clone_next_submodule(const st
      -		else
      -			strbuf_addstr(&sb, ce->name);
      -		strbuf_addf(out, _("Skipping unmerged submodule %s"), sb.buf);
     --		strbuf_addch(out, '\n');
     -+		strbuf_addf(out, _("Skipping unmerged submodule '%s'\n"), displaypath);
     ++		strbuf_addf(out, _("Skipping unmerged submodule %s"), displaypath);
     + 		strbuf_addch(out, '\n');
       		goto cleanup;
       	}
       
     @@ t/t7406-submodule-update.sh: test_expect_success 'submodule update --filter sets
      +	test_when_finished "rm -fr top-cloned" &&
      +	cp -r top-clean top-cloned &&
      +
     -+	# Create an upstream commit in each repo
     ++	# Create an upstream commit in each repo, starting with bottom
      +	test_commit -C bottom upstream_commit &&
     -+	(cd middle &&
     -+	 git -C bottom fetch &&
     -+	 git -C bottom checkout -f FETCH_HEAD &&
     -+	 git add bottom &&
     -+	 git commit -m "upstream_commit"
     -+	) &&
     -+	(cd top &&
     -+	 git -C middle fetch &&
     -+	 git -C middle checkout -f FETCH_HEAD &&
     -+	 git add middle &&
     -+	 git commit -m "upstream_commit"
     -+	) &&
     ++	# Create middle commit
     ++	git -C middle/bottom fetch &&
     ++	git -C middle/bottom checkout -f FETCH_HEAD &&
     ++	git -C middle add bottom &&
     ++	git -C middle commit -m "upstream_commit" &&
     ++	# Create top commit
     ++	git -C top/middle fetch &&
     ++	git -C top/middle checkout -f FETCH_HEAD &&
     ++	git -C top add middle &&
     ++	git -C top commit -m "upstream_commit" &&
      +
      +	# Create a downstream conflict
     -+	(cd top-cloned/middle &&
     -+	 test_commit -C bottom downstream_commit &&
     -+	 git add bottom &&
     -+	 git commit -m "downstream_commit" &&
     -+	 git fetch --recurse-submodules origin &&
     -+	 test_must_fail git merge origin/main
     -+	) &&
     ++	test_commit -C top-cloned/middle/bottom downstream_commit &&
     ++	git -C top-cloned/middle add bottom &&
     ++	git -C top-cloned/middle commit -m "downstream_commit" &&
     ++	git -C top-cloned/middle fetch --recurse-submodules origin &&
     ++	test_must_fail git -C top-cloned/middle merge origin/main &&
     ++
      +	# Make the update of "middle" a no-op, otherwise we error out
      +	# because of its unmerged state
      +	test_config -C top-cloned submodule.middle.update !true &&
      +	git -C top-cloned submodule update --recursive 2>actual.err &&
     -+	grep "Skipping unmerged submodule .middle/bottom." actual.err
     ++	grep -F "Skipping unmerged submodule middle/bottom" actual.err
      +'
      +
      +test_expect_success 'submodule update --recursive skip submodules with strategy=none' '
     @@ t/t7406-submodule-update.sh: test_expect_success 'submodule update --filter sets
      +	test_commit -C top-cloned/middle/bottom downstream_commit &&
      +	git -C top-cloned/middle config submodule.bottom.update none &&
      +	git -C top-cloned submodule update --recursive 2>actual.err &&
     -+	grep "Skipping submodule .middle/bottom." actual.err
     ++	grep -F "Skipping submodule ${SQ}middle/bottom${SQ}" actual.err
      +'
      +
       test_done
  2:  618053730e1 ! 14:  d3e803a4630 submodule--helper: don't recreate recursive prefix
     @@ Commit message
      
       ## builtin/submodule--helper.c ##
      @@ builtin/submodule--helper.c: static void update_data_to_args(struct update_data *update_data, struct strvec *
     - {
     + 
       	strvec_pushl(args, "submodule--helper", "update", "--recursive", NULL);
       	strvec_pushf(args, "--jobs=%d", update_data->max_jobs);
      -	if (update_data->recursive_prefix)
  3:  7cd1c46f350 = 15:  1f7cf6ffaf1 submodule--helper: use correct display path helper
  -:  ----------- > 16:  85e65f143b6 submodule--helper: remove unused SUPPORT_SUPER_PREFIX flags
  4:  57988287fc0 ! 17:  1d8b6b244dc submodule--helper update: use --super-prefix
     @@ builtin/submodule--helper.c: struct submodule_update_clone {
       	const char *prefix;
      -	const char *recursive_prefix;
       	const char *displaypath;
     - 	const char *update_default;
     + 	enum submodule_update_type update_default;
       	struct object_id suboid;
      @@ builtin/submodule--helper.c: static int prepare_to_clone_next_submodule(const struct cache_entry *ce,
       
     @@ builtin/submodule--helper.c: static int prepare_to_clone_next_submodule(const st
      +						   get_super_prefix());
       
       	if (ce_stage(ce)) {
     - 		strbuf_addf(out, _("Skipping unmerged submodule '%s'\n"), displaypath);
     -@@ builtin/submodule--helper.c: static void ensure_core_worktree(const char *path)
     - 
     - static void update_data_to_args(struct update_data *update_data, struct strvec *args)
     + 		strbuf_addf(out, _("Skipping unmerged submodule %s"), displaypath);
     +@@ builtin/submodule--helper.c: static void update_data_to_args(struct update_data *update_data, struct strvec *
       {
     + 	enum submodule_update_type update_type = update_data->update_default;
     + 
      -	strvec_pushl(args, "submodule--helper", "update", "--recursive", NULL);
      -	strvec_pushf(args, "--jobs=%d", update_data->max_jobs);
       	if (update_data->displaypath)
     @@ builtin/submodule--helper.c: static int module_update(int argc, const char **arg
      -			   N_("path"),
      -			   N_("path into the working tree, across nested "
      -			      "submodule boundaries")),
     - 		OPT_STRING(0, "update", &opt.update_default,
     - 			   N_("string"),
     - 			   N_("rebase, merge, checkout or none")),
     + 		OPT_SET_INT(0, "checkout", &opt.update_default,
     + 			N_("use the 'checkout' update strategy (default)"),
     + 			SM_UPDATE_CHECKOUT),
      @@ builtin/submodule--helper.c: static int module_update(int argc, const char **argv, const char *prefix)
       			module_list_active(&list);
       
     @@ builtin/submodule--helper.c: struct cmd_struct {
       	{"name", module_name, 0},
      -	{"clone", module_clone, 0},
      +	{"clone", module_clone, SUPPORT_SUPER_PREFIX},
     - 	{"add", module_add, SUPPORT_SUPER_PREFIX},
     + 	{"add", module_add, 0},
      -	{"update", module_update, 0},
      +	{"update", module_update, SUPPORT_SUPER_PREFIX},
       	{"resolve-relative-url-test", resolve_relative_url_test, 0},
       	{"foreach", module_foreach, SUPPORT_SUPER_PREFIX},
     - 	{"init", module_init, SUPPORT_SUPER_PREFIX},
     + 	{"init", module_init, 0},
  5:  9fa13380b02 ! 18:  a21e8cd174d submodule--helper: remove display path helper
     @@ builtin/submodule--helper.c: static int prepare_to_clone_next_submodule(const st
      +		get_submodule_displaypath(ce->name, suc->update_data->prefix);
       
       	if (ce_stage(ce)) {
     - 		strbuf_addf(out, _("Skipping unmerged submodule '%s'\n"), displaypath);
     + 		strbuf_addf(out, _("Skipping unmerged submodule %s"), displaypath);
      @@ builtin/submodule--helper.c: static int update_submodule(struct update_data *update_data)
       {
       	ensure_core_worktree(update_data->sm_path);

-- 
gitgitgadget
