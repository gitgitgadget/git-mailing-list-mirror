Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3DB831F667
	for <e@80x24.org>; Thu, 17 Aug 2017 02:53:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751642AbdHQCxs (ORCPT <rfc822;e@80x24.org>);
        Wed, 16 Aug 2017 22:53:48 -0400
Received: from mail-pg0-f66.google.com ([74.125.83.66]:38721 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751621AbdHQCxq (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 Aug 2017 22:53:46 -0400
Received: by mail-pg0-f66.google.com with SMTP id 123so7434075pga.5
        for <git@vger.kernel.org>; Wed, 16 Aug 2017 19:53:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=cgZDV3BGULYdp4EKNR94QuBQYruScyDQoqNEEFcNAc4=;
        b=C6M6m6B3pY7FgrkK9675x5vMqYIuprqYsp9eRPPkDLiI86Kp0e6ofC3f9kCZJBCvgw
         fxq0FohXHPsSFBuUZ7eGFtfYX7Tk2vLBUrc81+r3iUROJFC/5izqxQO+hIBMyawaVmwT
         cteTWxX1W4F+p0WMaDkfxJwr9QLQ3PQxeADoBr0G/D2Hg4nmKomSn9pa1wYoEs7quPRb
         /zaoy7jC0tz/H5sBLggtLFLc0kzXlo3T26nQvPTl4Ca7OlmHar/i1RiBb80cL4dpkkkw
         FE5SyRXZNpXUcOlhX68nrQ39OYcxBQwY36fogihRdNh+Enf53Bu7aT0FPUeYS+D1bRJR
         ewrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=cgZDV3BGULYdp4EKNR94QuBQYruScyDQoqNEEFcNAc4=;
        b=EKr/aQ6aK1SURDOhCSTqwG+s/yRQtXagV7x17aXukK+hgfYm+w1cvzpsyhUXDXCdwt
         Fk/xYTy4t3h7frVd9NjO3WyuzTEHHILTF10122whLo1IxccXxN9yTFx9I8eqAbaFdXhs
         8sI0iQ1OV5W1/K420TI/k0wm6fJISovk5Df68mKKUfSK03FUGcnnVT3zaf5cf8dWTdis
         qkDuhzUIu1rhTAp4ime4WrQ9OlBryQbCRsjxHDeH9tlGcOD1adiLQu0S7hgzTZ2ljyHD
         RJj1dbLFiruzpwzrYMx7HKUbH74z8DiYH+hpwOw2wavil4Mn3c4UoJJ/OHxlhO6Ydilg
         ESAA==
X-Gm-Message-State: AHYfb5g3P+zHPhIBit7ynQG9UW1PMVJKhsmi5ck2X9kqgIzNNDe4jU//
        Ef3v/dU/x9niAk42IakS+Q==
X-Received: by 10.84.224.201 with SMTP id k9mr4170905pln.263.1502938425573;
        Wed, 16 Aug 2017 19:53:45 -0700 (PDT)
Received: from localhost.localdomain ([157.50.14.209])
        by smtp.gmail.com with ESMTPSA id 66sm4373696pfq.20.2017.08.16.19.53.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 16 Aug 2017 19:53:44 -0700 (PDT)
From:   Kaartic Sivaraam <kaarticsivaraam91196@gmail.com>
To:     gitster@pobox.com, martin.agren@gmail.com
Cc:     git@vger.kernel.org
Subject: [PATCH v4 2/3] builtin/branch: stop supporting the use of --set-upstream option
Date:   Thu, 17 Aug 2017 08:24:24 +0530
Message-Id: <20170817025425.6647-2-kaarticsivaraam91196@gmail.com>
X-Mailer: git-send-email 2.14.0.rc1.434.g6eded367a
In-Reply-To: <20170817025425.6647-1-kaarticsivaraam91196@gmail.com>
References: <xmqqy3qluck4.fsf@gitster.mtv.corp.google.com>
 <20170817025425.6647-1-kaarticsivaraam91196@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The '--set-upstream' option of branch was deprecated in,

    b347d06bf branch: deprecate --set-upstream and show help if we
    detect possible mistaken use (Thu, 30 Aug 2012 19:23:13 +0200)

In order to prevent "--set-upstream" on a command line from being taken as
an abbreviated form of "--set-upstream-to", explicitly catch "--set-upstream"
option and die, instead of just removing it from the list of options.

The option is planned to be removed after this change has been around for a few
years.

The before/after behaviour for a simple case follows,

    $ git remote
    origin

Before,

    $ git branch
    * master

    $ git branch --set-upstream origin/master
    The --set-upstream flag is deprecated and will be removed. Consider using --track or --set-upstream-to
    Branch origin/master set up to track local branch master.

    $ echo $?
    0

    $ git branch
    * master
      origin/master

After,

    $ git branch
    * master

    $ git branch --set-upstream origin/master
    fatal: the '--set-upstream' option is no longer supported. Please use '--track' or '--set-upstream-to' instead.

    $ echo $?
    128

    $ git branch
    * master

Helped-by: Martin Ågren <martin.agren@gmail.com>,  Junio C Hamano <gitster@pobox.com>
Signed-off-by: Kaartic Sivaraam <kaarticsivaraam91196@gmail.com>
---
 Changes in v4:

    - made a few changes suggested by Martin
    - hid the '--set-upstream' option from 'git branch -h' as suggested by Junio 
    - updated commit message as suggested by Junio
    - updated error message (this should have been in v3 but somehow got skipped)

 Note: I'm not using the word 'removed' in the error messages or in the documentation as
 I feel it counter-intuitive from the end user's perspective because 

    * 'git branch' still accepts the option in the command line

    *  The option has not yet been removed from the synopsis of the documentation and I think
       we can't remove it from the 'Synopsis' porion of the documentation as it doesn't make
       sense (at least to me) to give a description of an option not listed in the synopsis.
       Moreover, we have to state the reason for not supporting it in some place.

 I guess the phrase 'no longer supported' is equally communicative. Let me know if that was not
 a right decision.

 Documentation/git-branch.txt |  8 ++++----
 builtin/branch.c             | 25 +++--------------------
 t/t3200-branch.sh            | 47 ++------------------------------------------
 t/t6040-tracking-info.sh     | 20 +++++++------------
 4 files changed, 16 insertions(+), 84 deletions(-)

diff --git a/Documentation/git-branch.txt b/Documentation/git-branch.txt
index 81bd0a7b7..948d9c9ef 100644
--- a/Documentation/git-branch.txt
+++ b/Documentation/git-branch.txt
@@ -195,10 +195,10 @@ start-point is either a local or remote-tracking branch.
 	branch.autoSetupMerge configuration variable is true.
 
 --set-upstream::
-	If specified branch does not exist yet or if `--force` has been
-	given, acts exactly like `--track`. Otherwise sets up configuration
-	like `--track` would when creating the branch, except that where
-	branch points to is not changed.
+	As this option had confusing syntax it's no longer supported. Please use
+	--track or --set-upstream-to instead.
++
+Note: This could possibly become an alias of --set-upstream-to in the future.
 
 -u <upstream>::
 --set-upstream-to=<upstream>::
diff --git a/builtin/branch.c b/builtin/branch.c
index a3bd2262b..6e3ea5787 100644
--- a/builtin/branch.c
+++ b/builtin/branch.c
@@ -557,8 +557,8 @@ int cmd_branch(int argc, const char **argv, const char *prefix)
 		OPT__QUIET(&quiet, N_("suppress informational messages")),
 		OPT_SET_INT('t', "track",  &track, N_("set up tracking mode (see git-pull(1))"),
 			BRANCH_TRACK_EXPLICIT),
-		OPT_SET_INT( 0, "set-upstream",  &track, N_("change upstream info"),
-			BRANCH_TRACK_OVERRIDE),
+		{ OPTION_SET_INT, 0, "set-upstream", &track, NULL, N_("do not use"),
+			PARSE_OPT_NOARG | PARSE_OPT_HIDDEN, NULL, BRANCH_TRACK_OVERRIDE },
 		OPT_STRING('u', "set-upstream-to", &new_upstream, N_("upstream"), N_("change the upstream info")),
 		OPT_BOOL(0, "unset-upstream", &unset_upstream, N_("Unset the upstream info")),
 		OPT__COLOR(&branch_use_color, N_("use colored output")),
@@ -755,8 +755,6 @@ int cmd_branch(int argc, const char **argv, const char *prefix)
 		strbuf_release(&buf);
 	} else if (argc > 0 && argc <= 2) {
 		struct branch *branch = branch_get(argv[0]);
-		int branch_existed = 0, remote_tracking = 0;
-		struct strbuf buf = STRBUF_INIT;
 
 		if (!strcmp(argv[0], "HEAD"))
 			die(_("it does not make sense to create 'HEAD' manually"));
@@ -768,28 +766,11 @@ int cmd_branch(int argc, const char **argv, const char *prefix)
 			die(_("-a and -r options to 'git branch' do not make sense with a branch name"));
 
 		if (track == BRANCH_TRACK_OVERRIDE)
-			fprintf(stderr, _("The --set-upstream flag is deprecated and will be removed. Consider using --track or --set-upstream-to\n"));
+			die(_("the '--set-upstream' option is no longer supported. Please use '--track' or '--set-upstream-to' instead."));
 
-		strbuf_addf(&buf, "refs/remotes/%s", branch->name);
-		remote_tracking = ref_exists(buf.buf);
-		strbuf_release(&buf);
-
-		branch_existed = ref_exists(branch->refname);
 		create_branch(argv[0], (argc == 2) ? argv[1] : head,
 			      force, reflog, 0, quiet, track);
 
-		/*
-		 * We only show the instructions if the user gave us
-		 * one branch which doesn't exist locally, but is the
-		 * name of a remote-tracking branch.
-		 */
-		if (argc == 1 && track == BRANCH_TRACK_OVERRIDE &&
-		    !branch_existed && remote_tracking) {
-			fprintf(stderr, _("\nIf you wanted to make '%s' track '%s', do this:\n\n"), head, branch->name);
-			fprintf(stderr, "    git branch -d %s\n", branch->name);
-			fprintf(stderr, "    git branch --set-upstream-to %s\n", branch->name);
-		}
-
 	} else
 		usage_with_options(builtin_branch_usage, options);
 
diff --git a/t/t3200-branch.sh b/t/t3200-branch.sh
index b54b3ebf3..34f556998 100755
--- a/t/t3200-branch.sh
+++ b/t/t3200-branch.sh
@@ -606,38 +606,8 @@ test_expect_success 'test --unset-upstream on a particular branch' '
 	test_must_fail git config branch.my14.merge
 '
 
-test_expect_success '--set-upstream shows message when creating a new branch that exists as remote-tracking' '
-	git update-ref refs/remotes/origin/master HEAD &&
-	git branch --set-upstream origin/master 2>actual &&
-	test_when_finished git update-ref -d refs/remotes/origin/master &&
-	test_when_finished git branch -d origin/master &&
-	cat >expected <<EOF &&
-The --set-upstream flag is deprecated and will be removed. Consider using --track or --set-upstream-to
-
-If you wanted to make '"'master'"' track '"'origin/master'"', do this:
-
-    git branch -d origin/master
-    git branch --set-upstream-to origin/master
-EOF
-	test_i18ncmp expected actual
-'
-
-test_expect_success '--set-upstream with two args only shows the deprecation message' '
-	git branch --set-upstream master my13 2>actual &&
-	test_when_finished git branch --unset-upstream master &&
-	cat >expected <<EOF &&
-The --set-upstream flag is deprecated and will be removed. Consider using --track or --set-upstream-to
-EOF
-	test_i18ncmp expected actual
-'
-
-test_expect_success '--set-upstream with one arg only shows the deprecation message if the branch existed' '
-	git branch --set-upstream my13 2>actual &&
-	test_when_finished git branch --unset-upstream my13 &&
-	cat >expected <<EOF &&
-The --set-upstream flag is deprecated and will be removed. Consider using --track or --set-upstream-to
-EOF
-	test_i18ncmp expected actual
+test_expect_success '--set-upstream fails' '
+    test_must_fail git branch --set-upstream origin/master
 '
 
 test_expect_success '--set-upstream-to notices an error to set branch as own upstream' '
@@ -962,19 +932,6 @@ test_expect_success 'attempt to delete a branch merged to its base' '
 	test_must_fail git branch -d my10
 '
 
-test_expect_success 'use set-upstream on the current branch' '
-	git checkout master &&
-	git --bare init myupstream.git &&
-	git push myupstream.git master:refs/heads/frotz &&
-	git remote add origin myupstream.git &&
-	git fetch &&
-	git branch --set-upstream master origin/frotz &&
-
-	test "z$(git config branch.master.remote)" = "zorigin" &&
-	test "z$(git config branch.master.merge)" = "zrefs/heads/frotz"
-
-'
-
 test_expect_success 'use --edit-description' '
 	write_script editor <<-\EOF &&
 		echo "New contents" >"$1"
diff --git a/t/t6040-tracking-info.sh b/t/t6040-tracking-info.sh
index 97a07655a..be78cc4fa 100755
--- a/t/t6040-tracking-info.sh
+++ b/t/t6040-tracking-info.sh
@@ -188,35 +188,29 @@ test_expect_success 'fail to track annotated tags' '
 	test_must_fail git checkout heavytrack
 '
 
-test_expect_success 'setup tracking with branch --set-upstream on existing branch' '
+test_expect_success '--set-upstream-to does not change branch' '
 	git branch from-master master &&
-	test_must_fail git config branch.from-master.merge > actual &&
-	git branch --set-upstream from-master master &&
-	git config branch.from-master.merge > actual &&
-	grep -q "^refs/heads/master$" actual
-'
-
-test_expect_success '--set-upstream does not change branch' '
+	git branch --set-upstream-to master from-master &&
 	git branch from-master2 master &&
 	test_must_fail git config branch.from-master2.merge > actual &&
 	git rev-list from-master2 &&
 	git update-ref refs/heads/from-master2 from-master2^ &&
 	git rev-parse from-master2 >expect2 &&
-	git branch --set-upstream from-master2 master &&
+	git branch --set-upstream-to master from-master2 &&
 	git config branch.from-master.merge > actual &&
 	git rev-parse from-master2 >actual2 &&
 	grep -q "^refs/heads/master$" actual &&
 	cmp expect2 actual2
 '
 
-test_expect_success '--set-upstream @{-1}' '
-	git checkout from-master &&
+test_expect_success '--set-upstream-to @{-1}' '
+	git checkout follower &&
 	git checkout from-master2 &&
 	git config branch.from-master2.merge > expect2 &&
-	git branch --set-upstream @{-1} follower &&
+	git branch --set-upstream-to @{-1} from-master &&
 	git config branch.from-master.merge > actual &&
 	git config branch.from-master2.merge > actual2 &&
-	git branch --set-upstream from-master follower &&
+	git branch --set-upstream-to follower from-master &&
 	git config branch.from-master.merge > expect &&
 	test_cmp expect2 actual2 &&
 	test_cmp expect actual
-- 
2.14.0.rc1.434.g6eded367a

