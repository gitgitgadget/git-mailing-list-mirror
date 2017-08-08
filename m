Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 329FE20899
	for <e@80x24.org>; Tue,  8 Aug 2017 17:11:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752150AbdHHRLZ (ORCPT <rfc822;e@80x24.org>);
        Tue, 8 Aug 2017 13:11:25 -0400
Received: from mail-pg0-f68.google.com ([74.125.83.68]:33885 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752059AbdHHRLY (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Aug 2017 13:11:24 -0400
Received: by mail-pg0-f68.google.com with SMTP id y192so3572287pgd.1
        for <git@vger.kernel.org>; Tue, 08 Aug 2017 10:11:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references;
        bh=XIlUULFYLnJ30gNVoI0qIJFaYDWGv2Fyc3TSQ55yqF4=;
        b=TudDshTylbYrBSqGPIOxNtJbhoAxtxDQQ5YZxri4QqpqOVyqeoHErqLmbZB6mKNGYa
         KwWZQAPNoQu9WlpOAFW8RvkLRkzWgn4r0jx7i8OZDutPBeKD0bJuaumh6dzm5sZ3Qaox
         V6wpJTsQEgvcsUHxRZgRPTsKgFnZbsZN4qdztHDibVMhqykhBcTnVjxdXjn4F3/+fwcC
         EN2cI2vfqK7KuR0yOLvfzdCvAGMtaqp8FsMwWKxFd2g965xN0rIgXzOJbRjT6eW2eT9D
         lQkW/+FxiTaoS8JFDbn9cwiFscDVHo7AH/wTqmzOXY5eTOAc6QTS+9ntf1H6ue6nDJo+
         RMdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references;
        bh=XIlUULFYLnJ30gNVoI0qIJFaYDWGv2Fyc3TSQ55yqF4=;
        b=dN87x3AlIvPHqCzCw720AvR6PQ+o4kW6dBzEFn4w5DTnarlutgFs/2BRAWhQdNRkeb
         xUU7A4R8Wwy3FaOZ60qsQ93jx7pjxkd2A4DOt8Bs2anrpwxFo8o1DOMhxftBKGN4FBES
         UNAFrvWqCQaOfDMU6uSI2gzIHPkpiYu+zkCCFA352dRYgOz/Z23i+IJ/ayowrqrG75s1
         33MC9yxGlnTscR7SUvqH+TtGy1atbqf4MewugBnS2LLEi1EuKRF1VCO0dGb7COdG0saB
         RD7fz8z3VcAYiY5Md1BTIEq242rYvez8gYhLiWk5QErcbSYD9lEtHcoF3hTeRoTKrmzg
         QPBg==
X-Gm-Message-State: AHYfb5hlVa++QXFvAPGjzeHgeuhOFtrCzVrE4SqHVcfQVGJEROEv+DdG
        qUQIBDoHG0A7kCDCpqE=
X-Received: by 10.98.212.92 with SMTP id u28mr5128009pfl.316.1502212283706;
        Tue, 08 Aug 2017 10:11:23 -0700 (PDT)
Received: from localhost.localdomain ([117.249.214.142])
        by smtp.gmail.com with ESMTPSA id n184sm2417976pga.89.2017.08.08.10.11.20
        for <git@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 08 Aug 2017 10:11:23 -0700 (PDT)
From:   Kaartic Sivaraam <kaarticsivaraam91196@gmail.com>
To:     git@vger.kernel.org
Subject: [PATCH v2 1/2 / RFC] builtin/branch: stop supporting the use of --set-upstream option
Date:   Tue,  8 Aug 2017 22:41:35 +0530
Message-Id: <20170808171136.31168-1-kaarticsivaraam91196@gmail.com>
X-Mailer: git-send-email 2.14.0.rc1.434.g6eded367a
In-Reply-To: <xmqq60dzp00l.fsf@gitster.mtv.corp.google.com>
References: <xmqq60dzp00l.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The '--set-upstream' option of branch was deprecated in,

    b347d06bf branch: deprecate --set-upstream and show help if we
    detect possible mistaken use (Thu, 30 Aug 2012 19:23:13 +0200)

It was deprecated for the reasons specified in the commit message of
the referenced commit.

Refactor 'branch' so that it dies with an appropraite error message
when the '--set-upstream' is used.

Note that there's a reason behind "dying with an error message" instead of
"not accepting the '--set-upstream'". ;git branch' would still *accept*
'--set-upstream' even after it's removal as a consequence of "unique
prefix can be abbrievated in option names" AND '--set-upstream' is a unique
prefix of '--set-upstream-to' when '--set-upstream' has been removed. In
order to smooth the transition for users due to the "prefix issue" it was
decided to make branch die when seeing the '--set-upstream' flag for a few
years and let the users know that it would be removed some time in the future.

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
    fatal: the '--set-upstream' flag is no longer supported and will be removed. Consider using '--track' or '--set-upstream-to'

    $ echo $?
    128

    $ git branch
    * master

Signed-off-by: Kaartic Sivaraam <kaarticsivaraam91196@gmail.com>
---
 Changes in v2:

 The previous patch removed the concerned option while the current patch
 makes 'git branch' die on seeing the option.

 The possibility of '--set-upstream' becoming an alias of  '--set-upstream-to'
 was documented.

 Documentation/git-branch.txt |  8 +++----
 builtin/branch.c             | 21 +------------------
 t/t3200-branch.sh            | 50 ++++----------------------------------------
 t/t6040-tracking-info.sh     | 16 +++++++-------
 4 files changed, 17 insertions(+), 78 deletions(-)

diff --git a/Documentation/git-branch.txt b/Documentation/git-branch.txt
index 81bd0a7b7..372107e0c 100644
--- a/Documentation/git-branch.txt
+++ b/Documentation/git-branch.txt
@@ -195,10 +195,10 @@ start-point is either a local or remote-tracking branch.
 	branch.autoSetupMerge configuration variable is true.
 
 --set-upstream::
-	If specified branch does not exist yet or if `--force` has been
-	given, acts exactly like `--track`. Otherwise sets up configuration
-	like `--track` would when creating the branch, except that where
-	branch points to is not changed.
+	This option is no longer supported and will be removed in the future.
+	Consider using --track or --set-upstream-to instead.
++
+Note: This could possibly become an alias of --set-upstream-to in the future.
 
 -u <upstream>::
 --set-upstream-to=<upstream>::
diff --git a/builtin/branch.c b/builtin/branch.c
index a3bd2262b..2fcb6f7e5 100644
--- a/builtin/branch.c
+++ b/builtin/branch.c
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
+			die(_("the '--set-upstream' flag is no longer supported and will be removed. Consider using '--track' or '--set-upstream-to'"));
 
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
index dd37ac47c..249be4b1a 100755
--- a/t/t3200-branch.sh
+++ b/t/t3200-branch.sh
@@ -561,7 +561,8 @@ test_expect_success 'use --set-upstream-to modify a particular branch' '
 	git branch my13 &&
 	git branch --set-upstream-to master my13 &&
 	test "$(git config branch.my13.remote)" = "." &&
-	test "$(git config branch.my13.merge)" = "refs/heads/master"
+	test "$(git config branch.my13.merge)" = "refs/heads/master" &&
+	git branch --unset-upstream my13
 '
 
 test_expect_success '--unset-upstream should fail if given a non-existent branch' '
@@ -605,38 +606,8 @@ test_expect_success 'test --unset-upstream on a particular branch' '
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
@@ -961,19 +932,6 @@ test_expect_success 'attempt to delete a branch merged to its base' '
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
index 97a07655a..4b522f456 100755
--- a/t/t6040-tracking-info.sh
+++ b/t/t6040-tracking-info.sh
@@ -188,35 +188,35 @@ test_expect_success 'fail to track annotated tags' '
 	test_must_fail git checkout heavytrack
 '
 
-test_expect_success 'setup tracking with branch --set-upstream on existing branch' '
+test_expect_success 'setup tracking with branch --set-upstream-to on existing branch' '
 	git branch from-master master &&
 	test_must_fail git config branch.from-master.merge > actual &&
-	git branch --set-upstream from-master master &&
+	git branch --set-upstream-to master from-master &&
 	git config branch.from-master.merge > actual &&
 	grep -q "^refs/heads/master$" actual
 '
 
-test_expect_success '--set-upstream does not change branch' '
+test_expect_success '--set-upstream-to does not change branch' '
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

