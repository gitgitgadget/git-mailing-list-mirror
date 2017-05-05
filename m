Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8B4B5207B3
	for <e@80x24.org>; Fri,  5 May 2017 18:19:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752286AbdEESTw (ORCPT <rfc822;e@80x24.org>);
        Fri, 5 May 2017 14:19:52 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:32971 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751544AbdEESTu (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 5 May 2017 14:19:50 -0400
Received: by mail-wm0-f66.google.com with SMTP id y10so2902453wmh.0
        for <git@vger.kernel.org>; Fri, 05 May 2017 11:19:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=zlH2H+I/ens1sOO1b1Whoe6ezFaVI1UplZUxGD2WlpM=;
        b=BpfcGVdW5sJTDvDYxm0t3nN9+6nyzTef1nohyxi8jTVa639zp83ItqIyGuzSQf0NEZ
         mprsT3GXk0i3iG0ETMrWpPxPSNluBv8AjZJsHkiEYcuCUe//Xn2dbYsdpHBwwwIUUJpF
         8E9I/OATex61ur3GxeoC4mNQ+3P0aj5Fmg69KPURuk63usuWU4vjazQRh1x+NW4U0fzs
         fBKiQwl5f33FEa/o9mshhig+EEtXKfmcHm6Sr/M1+G9hN/VE0Ly6r8mERUXM5sYlk7Em
         aiYg13g2dsHPQStvxqZemuza2dRDTasvXGWy++p083ThVPFHMHvFABDMu85JAlsagaQE
         1HgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=zlH2H+I/ens1sOO1b1Whoe6ezFaVI1UplZUxGD2WlpM=;
        b=Tt+CZ7ZfNtSZoxmt/7C59GGU1RqIIDh4sLRYoNJJh+ncVTpLelNVhyX9tjrh/bugHI
         R7f7096+xxkHcQdCixfLtgigaijrOOu6M83VuP2rhD65Kv1smx61oAhjkVlAiJiNVMAu
         uoVza1BS2QGWHkPWoxiDK4GYSgZLRGdHhMkDYnbKipPQXXZTEYksVpCEKYOIL66daqtl
         9vALKr26IlBR2AZP0IUBmHxD/3oAZNwEXcxneqUK63Gc5hDaGEeKL66BBbxuVwhXpEMa
         4bO3FsT/NRhyRmohB9e78IuIpoVvuIiQBjbaD1Joj3SOsiF1NoxjIfgDMjEa1jOdvrsZ
         A5yA==
X-Gm-Message-State: AN3rC/5raJBMPPUAUmxmtpIHS0ujqn/jCXap38hkkieB7nzMnKxGgPdB
        kua8u8qFo20Reg==
X-Received: by 10.28.66.157 with SMTP id k29mr6672554wmi.84.1494008384055;
        Fri, 05 May 2017 11:19:44 -0700 (PDT)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id z90sm8858304wrc.36.2017.05.05.11.19.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 05 May 2017 11:19:42 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Michael J Gruber <git@grubix.eu>,
        Lars Schneider <larsxschneider@gmail.com>,
        Jiang Xin <worldhello.net@gmail.com>,
        Stefan Beller <sbeller@google.com>, Jeff King <peff@peff.net>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2] tests: fix tests broken under GETTEXT_POISON=YesPlease
Date:   Fri,  5 May 2017 18:19:32 +0000
Message-Id: <20170505181932.14317-1-avarab@gmail.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20170505154053.58128-1-larsxschneider@gmail.com>
References: <20170505154053.58128-1-larsxschneider@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The GETTEXT_POISON=YesPlease compile-time testing option added in my
bb946bba76 ("i18n: add GETTEXT_POISON to simulate unfriendly
translator", 2011-02-22) has been slowly bitrotting as strings have
been marked for translation, and new tests have been added without
running it.

I brought this up on the list ("[BUG] test suite broken with
GETTEXT_POISON=YesPlease", [1]) asking whether this mode was useful at
all anymore. At least one person occasionally uses it, and Lars
Schneider offered to change one of the the Travis builds to run in
this mode, so fix up the failing ones.

My test setup runs most of the tests, with the notable exception of
skipping all the p4 tests, so it's possible that there's still some
lurking regressions I haven't fixed.

1. <CACBZZX62+acvi1dpkknadTL827mtCm_QesGSZ=6+UnyeMpg8+Q@mail.gmail.com>

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---

On Fri, May 5, 2017 at 5:40 PM, Lars Schneider <larsxschneider@gmail.com> wrote:
> Hi,
>
> this adds GETTEXT_POISON tests to TravisCI. Patch 1/2 is preparation
> and 2/2 adds the build job.
>
> You can see a test run here:
> https://travis-ci.org/larsxschneider/git/jobs/229120495
>
> On "next" this generates a bunch of failures (see below).
>
> @Ævar: Are your GETTEXT_POISON fixes in already or are these failures expected?

My v1 in <20170421185757.28978-1-avarab@gmail.com> didn't get picked
up, so these are all known failures.

In addition the t7508-status.sh test was broken on pu. I've just based
this version of the patch on pu, it's identical on master except for
the addition of the t7508-status.sh fix, meaning if this lands on pu
GETTEXT_POISON runs will be clean.

Junio: I think between Travis now testing for this & the scary i18n
reflog regression (not that poison caught that, but that was lack of
testing, poisoining catches that class of issue) it makes sense to
discard my patch for removing GETTEXT_POISON & queue this up instead.

 t/t1309-early-config.sh          |  2 +-
 t/t1430-bad-ref-name.sh          |  2 +-
 t/t3203-branch-output.sh         |  2 +-
 t/t3404-rebase-interactive.sh    | 14 +++++++-------
 t/t3415-rebase-autosquash.sh     | 10 +++++-----
 t/t3903-stash.sh                 |  4 ++--
 t/t4205-log-pretty-formats.sh    |  4 ++--
 t/t5316-pack-delta-depth.sh      |  8 ++++++--
 t/t6134-pathspec-in-submodule.sh |  4 ++--
 t/t7004-tag.sh                   |  4 ++--
 t/t7406-submodule-update.sh      |  2 +-
 t/t7508-status.sh                |  6 +++---
 t/t7509-commit.sh                |  4 ++--
 t/t7800-difftool.sh              |  4 ++--
 14 files changed, 37 insertions(+), 33 deletions(-)

diff --git a/t/t1309-early-config.sh b/t/t1309-early-config.sh
index 1af8c454cf..3dda215e8e 100755
--- a/t/t1309-early-config.sh
+++ b/t/t1309-early-config.sh
@@ -77,7 +77,7 @@ test_with_config () {
 
 test_expect_success 'ignore .git/ with incompatible repository version' '
 	test_with_config "[core]repositoryformatversion = 999999" 2>err &&
-	grep "warning:.* Expected git repo version <= [1-9]" err
+	test_i18ngrep "warning:.* Expected git repo version <= [1-9]" err
 '
 
 test_expect_failure 'ignore .git/ with invalid repository version' '
diff --git a/t/t1430-bad-ref-name.sh b/t/t1430-bad-ref-name.sh
index 8937e25e49..e88349c8a0 100755
--- a/t/t1430-bad-ref-name.sh
+++ b/t/t1430-bad-ref-name.sh
@@ -122,7 +122,7 @@ test_expect_success 'push cannot create a badly named ref' '
 	! grep -e "broken\.\.\.ref" output
 '
 
-test_expect_failure 'push --mirror can delete badly named ref' '
+test_expect_failure C_LOCALE_OUTPUT 'push --mirror can delete badly named ref' '
 	top=$(pwd) &&
 	git init src &&
 	git init dest &&
diff --git a/t/t3203-branch-output.sh b/t/t3203-branch-output.sh
index 5778c0afe1..a428ae6703 100755
--- a/t/t3203-branch-output.sh
+++ b/t/t3203-branch-output.sh
@@ -236,7 +236,7 @@ test_expect_success 'git branch --format option' '
 	Refname is refs/heads/ref-to-remote
 	EOF
 	git branch --format="Refname is %(refname)" >actual &&
-	test_cmp expect actual
+	test_i18ncmp expect actual
 '
 
 test_done
diff --git a/t/t3404-rebase-interactive.sh b/t/t3404-rebase-interactive.sh
index 61113be08a..3b411ea8f1 100755
--- a/t/t3404-rebase-interactive.sh
+++ b/t/t3404-rebase-interactive.sh
@@ -366,7 +366,7 @@ test_expect_success 'verbose flag is heeded, even after --continue' '
 	grep "^ file1 | 2 +-$" output
 '
 
-test_expect_success 'multi-squash only fires up editor once' '
+test_expect_success C_LOCALE_OUTPUT 'multi-squash only fires up editor once' '
 	base=$(git rev-parse HEAD~4) &&
 	set_fake_editor &&
 	FAKE_COMMIT_AMEND="ONCE" FAKE_LINES="1 squash 2 squash 3 squash 4" \
@@ -376,7 +376,7 @@ test_expect_success 'multi-squash only fires up editor once' '
 	test 1 = $(git show | grep ONCE | wc -l)
 '
 
-test_expect_success 'multi-fixup does not fire up editor' '
+test_expect_success C_LOCALE_OUTPUT 'multi-fixup does not fire up editor' '
 	git checkout -b multi-fixup E &&
 	base=$(git rev-parse HEAD~4) &&
 	set_fake_editor &&
@@ -426,7 +426,7 @@ D
 ONCE
 EOF
 
-test_expect_success 'squash and fixup generate correct log messages' '
+test_expect_success C_LOCALE_OUTPUT 'squash and fixup generate correct log messages' '
 	git checkout -b squash-fixup E &&
 	base=$(git rev-parse HEAD~4) &&
 	set_fake_editor &&
@@ -439,7 +439,7 @@ test_expect_success 'squash and fixup generate correct log messages' '
 	git branch -D squash-fixup
 '
 
-test_expect_success 'squash ignores comments' '
+test_expect_success C_LOCALE_OUTPUT 'squash ignores comments' '
 	git checkout -b skip-comments E &&
 	base=$(git rev-parse HEAD~4) &&
 	set_fake_editor &&
@@ -452,7 +452,7 @@ test_expect_success 'squash ignores comments' '
 	git branch -D skip-comments
 '
 
-test_expect_success 'squash ignores blank lines' '
+test_expect_success C_LOCALE_OUTPUT 'squash ignores blank lines' '
 	git checkout -b skip-blank-lines E &&
 	base=$(git rev-parse HEAD~4) &&
 	set_fake_editor &&
@@ -860,7 +860,7 @@ test_expect_success 'rebase -ix with several instances of --exec' '
 	test_cmp expected actual
 '
 
-test_expect_success 'rebase -ix with --autosquash' '
+test_expect_success C_LOCALE_OUTPUT 'rebase -ix with --autosquash' '
 	git reset --hard execute &&
 	git checkout -b autosquash &&
 	echo second >second.txt &&
@@ -943,7 +943,7 @@ test_expect_success 'rebase -i --root fixup root commit' '
 	test 0 = $(git cat-file commit HEAD | grep -c ^parent\ )
 '
 
-test_expect_success 'rebase --edit-todo does not works on non-interactive rebase' '
+test_expect_success C_LOCALE_OUTPUT 'rebase --edit-todo does not work on non-interactive rebase' '
 	git reset --hard &&
 	git checkout conflict-branch &&
 	set_fake_editor &&
diff --git a/t/t3415-rebase-autosquash.sh b/t/t3415-rebase-autosquash.sh
index 2f88f50c05..e364c12622 100755
--- a/t/t3415-rebase-autosquash.sh
+++ b/t/t3415-rebase-autosquash.sh
@@ -234,23 +234,23 @@ test_auto_fixup_fixup () {
 	fi
 }
 
-test_expect_success 'fixup! fixup!' '
+test_expect_success C_LOCALE_OUTPUT 'fixup! fixup!' '
 	test_auto_fixup_fixup fixup fixup
 '
 
-test_expect_success 'fixup! squash!' '
+test_expect_success C_LOCALE_OUTPUT 'fixup! squash!' '
 	test_auto_fixup_fixup fixup squash
 '
 
-test_expect_success 'squash! squash!' '
+test_expect_success C_LOCALE_OUTPUT 'squash! squash!' '
 	test_auto_fixup_fixup squash squash
 '
 
-test_expect_success 'squash! fixup!' '
+test_expect_success C_LOCALE_OUTPUT 'squash! fixup!' '
 	test_auto_fixup_fixup squash fixup
 '
 
-test_expect_success 'autosquash with custom inst format' '
+test_expect_success C_LOCALE_OUTPUT 'autosquash with custom inst format' '
 	git reset --hard base &&
 	git config --add rebase.instructionFormat "[%an @ %ar] %s"  &&
 	echo 2 >file1 &&
diff --git a/t/t3903-stash.sh b/t/t3903-stash.sh
index b71d1e659e..3b4bed5c9a 100755
--- a/t/t3903-stash.sh
+++ b/t/t3903-stash.sh
@@ -865,7 +865,7 @@ test_expect_success 'stash push -p with pathspec shows no changes only once' '
 	git stash push -p foo >actual &&
 	echo "No local changes to save" >expect &&
 	git reset --hard HEAD~ &&
-	test_cmp expect actual
+	test_i18ncmp expect actual
 '
 
 test_expect_success 'stash push with pathspec shows no changes when there are none' '
@@ -875,7 +875,7 @@ test_expect_success 'stash push with pathspec shows no changes when there are no
 	git stash push foo >actual &&
 	echo "No local changes to save" >expect &&
 	git reset --hard HEAD~ &&
-	test_cmp expect actual
+	test_i18ncmp expect actual
 '
 
 test_expect_success 'stash push with pathspec not in the repository errors out' '
diff --git a/t/t4205-log-pretty-formats.sh b/t/t4205-log-pretty-formats.sh
index 21eb8c8587..18aa1b5889 100755
--- a/t/t4205-log-pretty-formats.sh
+++ b/t/t4205-log-pretty-formats.sh
@@ -126,12 +126,12 @@ test_expect_success 'NUL separation with --stat' '
 	test_i18ncmp expected actual
 '
 
-test_expect_failure 'NUL termination with --stat' '
+test_expect_failure C_LOCALE_OUTPUT 'NUL termination with --stat' '
 	stat0_part=$(git diff --stat HEAD^ HEAD) &&
 	stat1_part=$(git diff-tree --no-commit-id --stat --root HEAD^) &&
 	printf "add bar\n$stat0_part\n\0$(commit_msg)\n$stat1_part\n0" >expected &&
 	git log -z --stat --pretty="tformat:%s" >actual &&
-	test_i18ncmp expected actual
+	test_cmp expected actual
 '
 
 test_expect_success 'setup more commits' '
diff --git a/t/t5316-pack-delta-depth.sh b/t/t5316-pack-delta-depth.sh
index 37143ea0ac..2ed479b712 100755
--- a/t/t5316-pack-delta-depth.sh
+++ b/t/t5316-pack-delta-depth.sh
@@ -82,12 +82,16 @@ test_expect_success 'packing produces a long delta' '
 	# Use --window=0 to make sure we are seeing reused deltas,
 	# not computing a new long chain.
 	pack=$(git pack-objects --all --window=0 </dev/null pack) &&
-	test 9 = "$(max_chain pack-$pack.pack)"
+	echo 9 >expect &&
+	max_chain pack-$pack.pack >actual &&
+	test_i18ncmp expect actual
 '
 
 test_expect_success '--depth limits depth' '
 	pack=$(git pack-objects --all --depth=5 </dev/null pack) &&
-	test 5 = "$(max_chain pack-$pack.pack)"
+	echo 5 >expect &&
+	max_chain pack-$pack.pack >actual &&
+	test_i18ncmp expect actual
 '
 
 test_done
diff --git a/t/t6134-pathspec-in-submodule.sh b/t/t6134-pathspec-in-submodule.sh
index fd401ca605..99a8982ab1 100755
--- a/t/t6134-pathspec-in-submodule.sh
+++ b/t/t6134-pathspec-in-submodule.sh
@@ -21,7 +21,7 @@ EOF
 test_expect_success 'error message for path inside submodule' '
 	echo a >sub/a &&
 	test_must_fail git add sub/a 2>actual &&
-	test_cmp expect actual
+	test_i18ncmp expect actual
 '
 
 cat <<EOF >expect
@@ -30,7 +30,7 @@ EOF
 
 test_expect_success 'error message for path inside submodule from within submodule' '
 	test_must_fail git -C sub add . 2>actual &&
-	test_cmp expect actual
+	test_i18ncmp expect actual
 '
 
 test_done
diff --git a/t/t7004-tag.sh b/t/t7004-tag.sh
index bb2e4d704d..0ef7b94394 100755
--- a/t/t7004-tag.sh
+++ b/t/t7004-tag.sh
@@ -87,7 +87,7 @@ test_expect_success 'creating a tag with --create-reflog should create reflog' '
 	git tag --create-reflog tag_with_reflog &&
 	git reflog exists refs/tags/tag_with_reflog &&
 	sed -e "s/^.*	//" .git/logs/refs/tags/tag_with_reflog >actual &&
-	test_cmp expected actual
+	test_i18ncmp expected actual
 '
 
 test_expect_success 'annotated tag with --create-reflog has correct message' '
@@ -98,7 +98,7 @@ test_expect_success 'annotated tag with --create-reflog has correct message' '
 	git tag -m "annotated tag" --create-reflog tag_with_reflog &&
 	git reflog exists refs/tags/tag_with_reflog &&
 	sed -e "s/^.*	//" .git/logs/refs/tags/tag_with_reflog >actual &&
-	test_cmp expected actual
+	test_i18ncmp expected actual
 '
 
 test_expect_success '--create-reflog does not create reflog on failure' '
diff --git a/t/t7406-submodule-update.sh b/t/t7406-submodule-update.sh
index 4ac386d98b..034914a14f 100755
--- a/t/t7406-submodule-update.sh
+++ b/t/t7406-submodule-update.sh
@@ -447,7 +447,7 @@ test_expect_success 'submodule update - command run for initial population of su
 	EOF
 	rm -rf super/submodule &&
 	test_must_fail git -C super submodule update 2>actual &&
-	test_cmp expect actual &&
+	test_i18ncmp expect actual &&
 	git -C super submodule update --checkout
 '
 
diff --git a/t/t7508-status.sh b/t/t7508-status.sh
index 567c4d4bab..79427840a4 100755
--- a/t/t7508-status.sh
+++ b/t/t7508-status.sh
@@ -392,7 +392,7 @@ EOF
 test_expect_success 'status -s -b' '
 
 	git status -s -b >output &&
-	test_cmp expect output
+	test_i18ncmp expect output
 
 '
 
@@ -402,7 +402,7 @@ test_expect_success 'status -s -z -b' '
 	git status -s -z -b >output &&
 	nul_to_q <output >output.q &&
 	mv output.q output &&
-	test_cmp expect output
+	test_i18ncmp expect output
 '
 
 test_expect_success 'setup dir3' '
@@ -744,7 +744,7 @@ EOF
 test_expect_success 'status -s -b with color.status' '
 
 	git status -s -b | test_decode_color >output &&
-	test_cmp expect output
+	test_i18ncmp expect output
 
 '
 
diff --git a/t/t7509-commit.sh b/t/t7509-commit.sh
index db9774e345..ddef7ea6b0 100755
--- a/t/t7509-commit.sh
+++ b/t/t7509-commit.sh
@@ -101,7 +101,7 @@ test_expect_success '--amend option with empty author' '
 	echo "Empty author test" >>foo &&
 	test_tick &&
 	test_must_fail git commit -a -m "empty author" --amend 2>err &&
-	grep "empty ident" err
+	test_i18ngrep "empty ident" err
 '
 
 test_expect_success '--amend option with missing author' '
@@ -114,7 +114,7 @@ test_expect_success '--amend option with missing author' '
 	echo "Missing author test" >>foo &&
 	test_tick &&
 	test_must_fail git commit -a -m "malformed author" --amend 2>err &&
-	grep "empty ident" err
+	test_i18ngrep "empty ident" err
 '
 
 test_expect_success '--reset-author makes the commit ours even with --amend option' '
diff --git a/t/t7800-difftool.sh b/t/t7800-difftool.sh
index 7f09867478..668bbee73c 100755
--- a/t/t7800-difftool.sh
+++ b/t/t7800-difftool.sh
@@ -25,14 +25,14 @@ prompt_given ()
 
 test_expect_success 'basic usage requires no repo' '
 	test_expect_code 129 git difftool -h >output &&
-	grep ^usage: output &&
+	test_i18ngrep ^usage: output &&
 	# create a ceiling directory to prevent Git from finding a repo
 	mkdir -p not/repo &&
 	test_when_finished rm -r not &&
 	test_expect_code 129 \
 	env GIT_CEILING_DIRECTORIES="$(pwd)/not" \
 	git -C not/repo difftool -h >output &&
-	grep ^usage: output
+	test_i18ngrep ^usage: output
 '
 
 # Create a file on master and change it on branch
-- 
2.11.0

