Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B035BC43334
	for <git@archiver.kernel.org>; Thu, 30 Jun 2022 22:12:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229788AbiF3WMB (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 30 Jun 2022 18:12:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229645AbiF3WL7 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 30 Jun 2022 18:11:59 -0400
Received: from mail-pj1-x104a.google.com (mail-pj1-x104a.google.com [IPv6:2607:f8b0:4864:20::104a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0C6F5721C
        for <git@vger.kernel.org>; Thu, 30 Jun 2022 15:11:57 -0700 (PDT)
Received: by mail-pj1-x104a.google.com with SMTP id f8-20020a17090ac28800b001ed312c6fe1so348224pjt.8
        for <git@vger.kernel.org>; Thu, 30 Jun 2022 15:11:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc:content-transfer-encoding;
        bh=D1dP+t2VcUQTtDSb7flUy2K/7HnobV9zYRg2bhbxpZQ=;
        b=IYrMQsti8ee6PfNWNYyZ1gIwQpqTSoAPGH8SldbpsvyuXb3D793zZOOy1LxOfCvqKu
         9TbcrvyWBQBWifacW3cfwMvocuVw/KEI6F6pK5G6qkOtFeMZ9x3zfax99JisFaD/521k
         iBbiCpp0MD3SbN7o86Vv+vKq94arY9HNF0DxlGYWHpB1ex5ohkEqTn4TTsRRwvvEmHmg
         qb865qEAHs4Ath6kMTZdIzCneXbu1j0xy0rA4wqIdslLdoDyXzh9xOboLALj4I9SEsK1
         tkMQEJ6NwuxAkDFr/Re46veSexTYiP5RS+5eb9EGLLo3uRkR/eakepsIzSw+mPGHZccs
         sPVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc:content-transfer-encoding;
        bh=D1dP+t2VcUQTtDSb7flUy2K/7HnobV9zYRg2bhbxpZQ=;
        b=vcdrxLERJ9kY/k4ztca5ykwqzDAhpvLHcX8QmVkNJ9yHKllsZoXWdA5RhpoJ+WciTe
         1zgU2WsCEwmWzcwxVFAmYI7miaq6oxSZI3+/pSR6uK9Jzfame30GZbDbIkVaSkF6/1wM
         C3j+qnH3/rU0+5DxQWq5AISj8h96JejPuhtseAVO/2MNjiio4dhqfl19yHlJ4hKUtn9W
         GuGuh4FDUeNF3M8Os6tn+e1M2G5IkhQlSiE+Dl3PXtwU85AN+W62lZJEHvsHPQDSmkKt
         k87WB6H8jnOMoS3qTlRrWyzR5H6YHlH5RFiTIzh86PA3tC3XzeUQKjodHk4Gk3UcgsqH
         E9Lw==
X-Gm-Message-State: AJIora8RyJfPkuGQLZg5FyOu0ipz5Fn4hSN5E8rEJPQE0aUdaIJjuX5S
        H7K+8je/T5TZ8w2MiU3HBxU+jbk1h/1hMCpdp43uFSfRolESQ9aze1BTej5WbRBmzw1kEocqM0G
        m3oLJ3qK+4+Gr5FZIyuWfdbtzjCeKj+G12BwCZbQv9Q5h/uPC+B7K6twAVJxB7aU=
X-Google-Smtp-Source: AGRyM1uE88QGi+49VtJrUw8FRCwTAboqwMRamBxeAg7BeUGzUsobbIYfoFmrSFiBymgTfSZUDAs2YkBPHi+tvQ==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:26d9])
 (user=chooglen job=sendgmr) by 2002:a17:90a:249:b0:1e0:a8a3:3c6c with SMTP id
 t9-20020a17090a024900b001e0a8a33c6cmr321860pje.0.1656627115908; Thu, 30 Jun
 2022 15:11:55 -0700 (PDT)
Date:   Thu, 30 Jun 2022 15:11:41 -0700
In-Reply-To: <pull.1282.v2.git.git.1656623978.gitgitgadget@gmail.com>
Message-Id: <20220630221147.45689-1-chooglen@google.com>
Mime-Version: 1.0
References: <pull.1282.v2.git.git.1656623978.gitgitgadget@gmail.com>
X-Mailer: git-send-email 2.37.0.rc0.161.g10f37bed90-goog
Subject: [PATCH v3 0/6] submodule: remove "--recursive-prefix"
From:   Glen Choo <chooglen@google.com>
To:     git@vger.kernel.org
Cc:     Glen Choo <chooglen@google.com>,
        Atharva Raykar <raykar.ath@gmail.com>,
        "=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?=" 
        <avarab@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

(resending as v3 because I accidentally included ab/submodule-cleanup in
v2)

Thanks =C3=86var for the feedback! I've incorporated all of the suggestions=
,
except breaking up the tests in 1/6 into their own patch - I wasn't
convinced of the value of having prescriptive tests (with
test_expect_failure), and I found it difficult to discuss descriptive tests
(with test_expect_success) without also having the code in the same diff.
FWIW, this version (and the previous one) "git rebase -x 'make test'"
cleanly :)

Note for Junio: this version is based on ab/submodule-cleanup (and so will
future versions).

=3D Description

This series is a refactor of "git submodule--helper update" that replaces
"--recursive-prefix" with "--super-prefix" (see Background). This was
initially motivated by:

 * Junio's suggestion to simplify the code [1] (in response to a memory lea=
k
   found by Johannes Schindelin [2]).
 * A desire to use the module_list API + get_submodule_displaypath() outsid=
e
   of builtin/submodule--helper.c (I expect to use this to check out
   branches in each submodule).

But it also happens to remove some overly complicated/duplicated code that
was literally converted from shell :)

=3D Background

When recursing into nested submodules, Git commands keep track of the path
from the superproject to the submodule in order to print a "display path" t=
o
the user, e.g.

  Submodule path '../super/sub/nested-sub': checked out 'abcdef'

For historical reasons, "git submodule--helper update" uses
"--recursive-prefix" for this purpose, but it should use "--super-prefix"
instead because:

 * That's what every other command uses (not just submodule--helper
   subcommands).
 * Using the "--super-prefix" helper functions makes the "git
   submodule--helper update" code simpler

=3D Patch organization

 * Patch 1/6 makes sure that display paths are only computed using display
   path helper functions ([do_]get_submodule_displaypath()) and fixes some
   display paths that we never realized were broken.
 * Patches 2-3/6 simplify and deduplicate some display path computations.
 * Patch 4/6 (authored by =C3=86var) removes SUPPORT_SUPER_PREFIX where it'=
s not
   needed.
   * This doesn't affect correctness, but we want to do this eventually, so
     do it now to make 5/6 a bit cleaner.
 * Patch 5/6 replaces "--recursive-prefix" with "--super-prefix", making
   do_get_submodule_displaypath() obsolete.
   * GGG outputs an odd diff; I recommend viewing it with "--histogram"
 * Patch 6/6 removes do_get_submodule_displaypath().

=3D Series history

Changes in v3:
* None (resend of v2 because v2 accidentally included
  ab/submodule-cleanup)

Changes in v2:
 * Rebase onto ab/submodule-cleanup (previously master)
 * Cherry pick https://github.com/avar/git/commit/f445c57490d into 4/6
 * Style fixes in .c and tests

=3D Future work

At the end of this series, get_submodule_displaypath() can be moved to
submodule.h, which would make submodule.c:get_super_prefix_or_empty()
obsolete. I have a patch that demonstrates this (CI run: [4]), but I decide=
d
to keep this series more focused on "git submodule--helper update" so that
it's easier to review.

[1] https://lore.kernel.org/git/xmqq35g5xmmv.fsf@gitster.g
[2] https://lore.kernel.org/git/877a45867ae368bf9e053caedcb6cf421e02344d.16=
55336146.git.gitgitgadget@gmail.com
[3] https://lore.kernel.org/git/patch-v3-02.12-082e015781e-20220622T142012Z=
-avarab@gmail.com
[4] https://github.com/chooglen/git/actions/runs/2572557584

Glen Choo (5):
  submodule--helper update: use display path helper
  submodule--helper: don't recreate recursive prefix
  submodule--helper: use correct display path helper
  submodule--helper update: use --super-prefix
  submodule--helper: remove display path helper

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason (1):
  submodule--helper: remove unused SUPPORT_SUPER_PREFIX flags

 builtin/submodule--helper.c | 87 ++++++++++---------------------------
 t/t7406-submodule-update.sh | 56 ++++++++++++++++++++++++
 2 files changed, 79 insertions(+), 64 deletions(-)

Range-diff against v1:
1:  473548f2fa ! 1:  64c138df19 submodule--helper update: use display path =
helper
    @@ builtin/submodule--helper.c: static int prepare_to_clone_next_submod=
ule(const st
     -	struct strbuf displaypath_sb =3D STRBUF_INIT;
      	struct strbuf sb =3D STRBUF_INIT;
     -	const char *displaypath =3D NULL;
    -+	char *displaypath =3D NULL;
    ++	char *displaypath;
      	int needs_cloning =3D 0;
      	int need_free_url =3D 0;
     =20
    @@ builtin/submodule--helper.c: static int prepare_to_clone_next_submod=
ule(const st
     -		else
     -			strbuf_addstr(&sb, ce->name);
     -		strbuf_addf(out, _("Skipping unmerged submodule %s"), sb.buf);
    --		strbuf_addch(out, '\n');
    -+		strbuf_addf(out, _("Skipping unmerged submodule '%s'\n"), displaypa=
th);
    ++		strbuf_addf(out, _("Skipping unmerged submodule %s"), displaypath);
    + 		strbuf_addch(out, '\n');
      		goto cleanup;
      	}
     =20
    @@ t/t7406-submodule-update.sh: test_expect_success 'submodule update -=
-filter sets
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
     +test_expect_success 'submodule update --recursive skip submodules wit=
h strategy=3Dnone' '
    @@ t/t7406-submodule-update.sh: test_expect_success 'submodule update -=
-filter sets
     +	test_commit -C top-cloned/middle/bottom downstream_commit &&
     +	git -C top-cloned/middle config submodule.bottom.update none &&
     +	git -C top-cloned submodule update --recursive 2>actual.err &&
    -+	grep "Skipping submodule .middle/bottom." actual.err
    ++	grep -F "Skipping submodule ${SQ}middle/bottom${SQ}" actual.err
     +'
     +
      test_done
2:  618053730e ! 2:  d3e803a463 submodule--helper: don't recreate recursive=
 prefix
    @@ Commit message
    =20
      ## builtin/submodule--helper.c ##
     @@ builtin/submodule--helper.c: static void update_data_to_args(struct=
 update_data *update_data, struct strvec *
    - {
    +=20
      	strvec_pushl(args, "submodule--helper", "update", "--recursive", NUL=
L);
      	strvec_pushf(args, "--jobs=3D%d", update_data->max_jobs);
     -	if (update_data->recursive_prefix)
3:  7cd1c46f35 =3D 3:  1f7cf6ffaf submodule--helper: use correct display pa=
th helper
-:  ---------- > 4:  85e65f143b submodule--helper: remove unused SUPPORT_SU=
PER_PREFIX flags
4:  57988287fc ! 5:  1d8b6b244d submodule--helper update: use --super-prefi=
x
    @@ builtin/submodule--helper.c: struct submodule_update_clone {
      	const char *prefix;
     -	const char *recursive_prefix;
      	const char *displaypath;
    - 	const char *update_default;
    + 	enum submodule_update_type update_default;
      	struct object_id suboid;
     @@ builtin/submodule--helper.c: static int prepare_to_clone_next_submo=
dule(const struct cache_entry *ce,
     =20
    @@ builtin/submodule--helper.c: static int prepare_to_clone_next_submod=
ule(const st
     +						   get_super_prefix());
     =20
      	if (ce_stage(ce)) {
    - 		strbuf_addf(out, _("Skipping unmerged submodule '%s'\n"), displaypa=
th);
    -@@ builtin/submodule--helper.c: static void ensure_core_worktree(const=
 char *path)
    -=20
    - static void update_data_to_args(struct update_data *update_data, stru=
ct strvec *args)
    + 		strbuf_addf(out, _("Skipping unmerged submodule %s"), displaypath);
    +@@ builtin/submodule--helper.c: static void update_data_to_args(struct=
 update_data *update_data, struct strvec *
      {
    + 	enum submodule_update_type update_type =3D update_data->update_defau=
lt;
    +=20
     -	strvec_pushl(args, "submodule--helper", "update", "--recursive", NUL=
L);
     -	strvec_pushf(args, "--jobs=3D%d", update_data->max_jobs);
      	if (update_data->displaypath)
    @@ builtin/submodule--helper.c: static int module_update(int argc, cons=
t char **arg
     -			   N_("path"),
     -			   N_("path into the working tree, across nested "
     -			      "submodule boundaries")),
    - 		OPT_STRING(0, "update", &opt.update_default,
    - 			   N_("string"),
    - 			   N_("rebase, merge, checkout or none")),
    + 		OPT_SET_INT(0, "checkout", &opt.update_default,
    + 			N_("use the 'checkout' update strategy (default)"),
    + 			SM_UPDATE_CHECKOUT),
     @@ builtin/submodule--helper.c: static int module_update(int argc, con=
st char **argv, const char *prefix)
      			module_list_active(&list);
     =20
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
5:  9fa13380b0 ! 6:  a21e8cd174 submodule--helper: remove display path help=
er
    @@ builtin/submodule--helper.c: static int prepare_to_clone_next_submod=
ule(const st
     +		get_submodule_displaypath(ce->name, suc->update_data->prefix);
     =20
      	if (ce_stage(ce)) {
    - 		strbuf_addf(out, _("Skipping unmerged submodule '%s'\n"), displaypa=
th);
    + 		strbuf_addf(out, _("Skipping unmerged submodule %s"), displaypath);
     @@ builtin/submodule--helper.c: static int update_submodule(struct upd=
ate_data *update_data)
      {
      	ensure_core_worktree(update_data->sm_path);

base-commit: 5b893f7d81eb7feb43662ed8663e2af76a76b4c8
--=20
2.37.0.rc0.161.g10f37bed90-goog

