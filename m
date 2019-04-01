Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3194C202BB
	for <e@80x24.org>; Mon,  1 Apr 2019 20:52:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727447AbfDAUwI (ORCPT <rfc822;e@80x24.org>);
        Mon, 1 Apr 2019 16:52:08 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:42094 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726968AbfDAUwG (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 1 Apr 2019 16:52:06 -0400
Received: by mail-pl1-f195.google.com with SMTP id cv12so5068952plb.9
        for <git@vger.kernel.org>; Mon, 01 Apr 2019 13:52:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=06zGSIOvlTEKmIrN9ecJxVTIlas5rzEUjQW+KHAXsnw=;
        b=VGL6B0sxaejRnBgyylXo+pyXcYuUDWTEFNVUCGkBpMjZ3zfUtN2sa00eEB/eqJfED8
         bL03oX9PQtFBzNIspMXIS+YXGMgCv9nvecG7S2m4K2UrYY6mlPVvWcCmN3BlKb37OZYb
         q3USK4Xu3n7sp4b/DB9wlU83pyB3kMgYmEp216f79XbI0lpIk7WOzpw9z+4UR99yetcx
         TzV1p4zuXJ59begmbfWCllhwqMVmAUhA78qlbEMbbjOe3c/3GAto5939JSrxf94aq/zZ
         Ek/amBk4P0vzjUZlFR3WZUqCnqsWcKRXZiRyvzZaZr7FsNmkDGpUHRtZXUjSWIcbO8eE
         Qf9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=06zGSIOvlTEKmIrN9ecJxVTIlas5rzEUjQW+KHAXsnw=;
        b=cw02ps+1t+r1w+GjL2OQGaz2Ql3jA4BQpxDCHASU+gX4Mk5UM7WGoESjYZmE819gzp
         d3DoaqFqk8rFig3lLsmwc/L5E9tio7nHhfJ+wRbmNrHjYzLE1BYwB9toGJuwFnjfl7fI
         IMOgqAkzBRiy0gl5huGDepWzGktaeUcWAD65Dr6/6ZffpjnOVz7sFoXK2hgJLAKBIY35
         g5XBK3OVdEU1WXhMF5UUhpiO7OApX7veQZeFJBXcEEVs9jSA+yUWvFpZ69TJvMhIdmWp
         ut7w8NjSYxX6+BvYG0TK9+0hRgNVjMw2V9wk32KIi7maCxDi6akWO/RoHoaTrAld2Pm3
         IC3w==
X-Gm-Message-State: APjAAAVr+oiAN/8dgcItkpDnBt2/Fs4L8diDEYx+ScKKuGmFoWA1vCCT
        CCHj4/NQ3n8XRhjKnwYE7PnDOK71
X-Google-Smtp-Source: APXvYqyXfGaiYESPKVLVMNnfor+8MBDvgL90FwrF4Q8HC3cwI6wAp2PmjeURNS1yTjPiOJinXKg9Mg==
X-Received: by 2002:a17:902:2b8b:: with SMTP id l11mr67955033plb.18.1554151925236;
        Mon, 01 Apr 2019 13:52:05 -0700 (PDT)
Received: from dev-l ([149.28.200.39])
        by smtp.gmail.com with ESMTPSA id p3sm20249704pfn.167.2019.04.01.13.52.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 01 Apr 2019 13:52:04 -0700 (PDT)
Date:   Mon, 1 Apr 2019 13:52:02 -0700
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Junio C Hamano <gitster@pobox.com>,
        =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH v3 4/4] rebase: teach rebase --keep-base
Message-ID: <d0cde21c3049c76bf8f6057d6f92796479bedcff.1554151449.git.liu.denton@gmail.com>
References: <20190328221745.GA3941@dev-l>
 <cover.1554151449.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover.1554151449.git.liu.denton@gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

A common scenario is if a user is working on a topic branch and they
wish to make some changes to intermediate commits or autosquash, they
would run something such as

	git rebase -i --onto master... master

in order to preserve the merge base. This is useful when contributing a
patch series to the Git mailing list, one often starts on top of the
current 'master'. However, while developing the patches, 'master' is
also developed further and it is sometimes not the bst idea to keep
rebasing on top of 'master', but to keep the base commit as-is.

Alternatively, a user wishing to test individual commits in a topic
branch without changing anything may run

	git rebase -x ./test.sh master... master

Since rebasing onto the merge base of the branch and the upstream is
such a common case, introduce the --keep-base option as a shortcut.

This allows us to rewrite the above as

	git rebase -i --keep-base master

and

	git rebase -x ./test.sh --keep-base master

respectively.

Add tests to ensure --keep-base works correctly in the normal case and
fails when there are multiple merge bases, both in regular and
interactive mode. Also, test to make sure conflicting options cause
rebase to fail. While we're adding test cases, add a missing
set_fake_editor call to 'rebase -i --onto master...side'.

While we're documenting the --keep-base option, change an instance of
"merge-base" to "merge base", which is the consistent spelling.

Helped-by: Eric Sunshine <sunshine@sunshineco.com>
Helped-by: Junio C Hamano <gitster@pobox.com>
Helped-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
Helped-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Signed-off-by: Denton Liu <liu.denton@gmail.com>
---
 Documentation/git-rebase.txt     | 30 +++++++++++++++--
 builtin/rebase.c                 | 32 ++++++++++++++----
 t/t3416-rebase-onto-threedots.sh | 57 ++++++++++++++++++++++++++++++++
 t/t3431-rebase-fork-point.sh     |  4 +++
 t/t3432-rebase-fast-forward.sh   |  3 ++
 5 files changed, 117 insertions(+), 9 deletions(-)

diff --git a/Documentation/git-rebase.txt b/Documentation/git-rebase.txt
index 6363d674b7..569ab708d4 100644
--- a/Documentation/git-rebase.txt
+++ b/Documentation/git-rebase.txt
@@ -8,8 +8,8 @@ git-rebase - Reapply commits on top of another base tip
 SYNOPSIS
 --------
 [verse]
-'git rebase' [-i | --interactive] [<options>] [--exec <cmd>] [--onto <newbase>]
-	[<upstream> [<branch>]]
+'git rebase' [-i | --interactive] [<options>] [--exec <cmd>]
+	[--onto <newbase> | --keep-base] [<upstream> [<branch>]]
 'git rebase' [-i | --interactive] [<options>] [--exec <cmd>] [--onto <newbase>]
 	--root [<branch>]
 'git rebase' --continue | --skip | --abort | --quit | --edit-todo | --show-current-patch
@@ -217,6 +217,24 @@ As a special case, you may use "A\...B" as a shortcut for the
 merge base of A and B if there is exactly one merge base. You can
 leave out at most one of A and B, in which case it defaults to HEAD.
 
+--keep-base::
+	Set the starting point at which to create the new commits to the
+	merge base of <upstream> <branch>. Running
+	'git rebase --keep-base <upstream> <branch>' is equivalent to
+	running 'git rebase --onto <upstream>... <upstream>'.
++
+This option is useful in the case where one is developing a feature on
+top of an upstream branch. While the feature is being worked on, the
+upstream branch may advance and it may not be the best idea to keep
+rebasing on top of the upstream but to keep the base commit as-is.
++
+Although both this option and --fork-point find the merge base between
+<upstream> and <branch>, this option uses the merge base as the _starting
+point_ on which new commits will be created, whereas --fork-point uses
+the merge base to determine the _set of commits_ which will be rebased.
++
+See also INCOMPATIBLE OPTIONS below.
+
 <upstream>::
 	Upstream branch to compare against.  May be any valid commit,
 	not just an existing branch name. Defaults to the configured
@@ -364,6 +382,10 @@ ends up being empty, the <upstream> will be used as a fallback.
 +
 If either <upstream> or --root is given on the command line, then the
 default is `--no-fork-point`, otherwise the default is `--fork-point`.
++
+If your branch was based on <upstream> but <upstream> was rewound and
+your branch contains commits which were dropped, this option can be used
+with `--keep-base` in order to drop those commits from your branch.
 
 --ignore-whitespace::
 --whitespace=<option>::
@@ -539,6 +561,8 @@ In addition, the following pairs of options are incompatible:
  * --preserve-merges and --rebase-merges
  * --rebase-merges and --strategy
  * --rebase-merges and --strategy-option
+ * --keep-base and --onto
+ * --keep-base and --root
 
 BEHAVIORAL DIFFERENCES
 -----------------------
@@ -863,7 +887,7 @@ NOTE: While an "easy case recovery" sometimes appears to be successful
       --interactive` will be **resurrected**!
 
 The idea is to manually tell 'git rebase' "where the old 'subsystem'
-ended and your 'topic' began", that is, what the old merge-base
+ended and your 'topic' began", that is, what the old merge base
 between them was.  You will have to find a way to name the last commit
 of the old 'subsystem', for example:
 
diff --git a/builtin/rebase.c b/builtin/rebase.c
index 7aa6a090d4..caec1b56e8 100644
--- a/builtin/rebase.c
+++ b/builtin/rebase.c
@@ -27,8 +27,8 @@
 #include "branch.h"
 
 static char const * const builtin_rebase_usage[] = {
-	N_("git rebase [-i] [options] [--exec <cmd>] [--onto <newbase>] "
-		"[<upstream>] [<branch>]"),
+	N_("git rebase [-i] [options] [--exec <cmd>] "
+		"[--onto <newbase> | --keep-base] [<upstream> [<branch>]]"),
 	N_("git rebase [-i] [options] [--exec <cmd>] [--onto <newbase>] "
 		"--root [<branch>]"),
 	N_("git rebase --continue | --abort | --skip | --edit-todo"),
@@ -1035,6 +1035,7 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
 	};
 	const char *branch_name;
 	int ret, flags, total_argc, in_progress = 0;
+	int keep_base = 0;
 	int ok_to_skip_pre_rebase = 0;
 	struct strbuf msg = STRBUF_INIT;
 	struct strbuf revisions = STRBUF_INIT;
@@ -1068,6 +1069,8 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
 		OPT_STRING(0, "onto", &options.onto_name,
 			   N_("revision"),
 			   N_("rebase onto given branch instead of upstream")),
+		OPT_BOOL(0, "keep-base", &keep_base,
+			 N_("use the merge-base of upstream and branch as the current base")),
 		OPT_BOOL(0, "no-verify", &ok_to_skip_pre_rebase,
 			 N_("allow pre-rebase hook to run")),
 		OPT_NEGBIT('q', "quiet", &options.flags,
@@ -1234,6 +1237,13 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
 		usage_with_options(builtin_rebase_usage,
 				   builtin_rebase_options);
 
+	if (keep_base) {
+		if (options.onto_name)
+			die(_("cannot combine '--keep-base' with '--onto'"));
+		if (options.root)
+			die(_("cannot combine '--keep-base' with '--root'"));
+	}
+
 	if (action != NO_ACTION && !in_progress)
 		die(_("No rebase in progress?"));
 	setenv(GIT_REFLOG_ACTION_ENVIRONMENT, "rebase", 0);
@@ -1558,12 +1568,22 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
 	}
 
 	/* Make sure the branch to rebase onto is valid. */
-	if (!options.onto_name)
+	if (keep_base) {
+		strbuf_reset(&buf);
+		strbuf_addstr(&buf, options.upstream_name);
+		strbuf_addstr(&buf, "...");
+		options.onto_name = xstrdup(buf.buf);
+	} else if (!options.onto_name)
 		options.onto_name = options.upstream_name;
 	if (strstr(options.onto_name, "...")) {
-		if (get_oid_mb(options.onto_name, &merge_base) < 0)
-			die(_("'%s': need exactly one merge base"),
-			    options.onto_name);
+		if (get_oid_mb(options.onto_name, &merge_base) < 0) {
+			if (keep_base)
+				die(_("'%s': need exactly one merge base with branch"),
+				    options.upstream_name);
+			else
+				die(_("'%s': need exactly one merge base"),
+				    options.onto_name);
+		}
 		options.onto = lookup_commit_or_die(&merge_base,
 						    options.onto_name);
 	} else {
diff --git a/t/t3416-rebase-onto-threedots.sh b/t/t3416-rebase-onto-threedots.sh
index ddf2f64853..9c2548423b 100755
--- a/t/t3416-rebase-onto-threedots.sh
+++ b/t/t3416-rebase-onto-threedots.sh
@@ -99,7 +99,64 @@ test_expect_success 'rebase -i --onto master...side' '
 	git checkout side &&
 	git reset --hard K &&
 
+	set_fake_editor &&
 	test_must_fail git rebase -i --onto master...side J
 '
 
+test_expect_success 'rebase --keep-base --onto incompatible' '
+	test_must_fail git rebase --keep-base --onto master...
+'
+
+test_expect_success 'rebase --keep-base --root incompatible' '
+	test_must_fail git rebase --keep-base --root
+'
+
+test_expect_success 'rebase --keep-base master from topic' '
+	git reset --hard &&
+	git checkout topic &&
+	git reset --hard G &&
+
+	git rebase --keep-base master &&
+	git rev-parse C >base.expect &&
+	git merge-base master HEAD >base.actual &&
+	test_cmp base.expect base.actual &&
+
+	git rev-parse HEAD~2 >actual &&
+	git rev-parse C^0 >expect &&
+	test_cmp expect actual
+'
+
+test_expect_success 'rebase --keep-base master from side' '
+	git reset --hard &&
+	git checkout side &&
+	git reset --hard K &&
+
+	test_must_fail git rebase --keep-base master
+'
+
+test_expect_success 'rebase -i --keep-base master from topic' '
+	git reset --hard &&
+	git checkout topic &&
+	git reset --hard G &&
+
+	set_fake_editor &&
+	EXPECT_COUNT=2 git rebase -i --keep-base master &&
+	git rev-parse C >base.expect &&
+	git merge-base master HEAD >base.actual &&
+	test_cmp base.expect base.actual &&
+
+	git rev-parse HEAD~2 >actual &&
+	git rev-parse C^0 >expect &&
+	test_cmp expect actual
+'
+
+test_expect_success 'rebase -i --keep-base master from side' '
+	git reset --hard &&
+	git checkout side &&
+	git reset --hard K &&
+
+	set_fake_editor &&
+	test_must_fail git rebase -i --keep-base master
+'
+
 test_done
diff --git a/t/t3431-rebase-fork-point.sh b/t/t3431-rebase-fork-point.sh
index 8e2483b73e..0311bcbc68 100755
--- a/t/t3431-rebase-fork-point.sh
+++ b/t/t3431-rebase-fork-point.sh
@@ -43,11 +43,15 @@ test_rebase() {
 
 test_rebase 'G F E D B A' ''
 test_rebase 'G F D B A' '--onto D'
+test_rebase 'G F B A' '--keep-base'
 test_rebase 'G F C E D B A' '--no-fork-point'
 test_rebase 'G F C D B A' '--no-fork-point --onto D'
+test_rebase 'G F C B A' '--no-fork-point --keep-base'
 test_rebase 'G F E D B A' '--fork-point refs/heads/master'
 test_rebase 'G F D B A' '--fork-point --onto D refs/heads/master'
+test_rebase 'G F B A' '--fork-point --keep-base refs/heads/master'
 test_rebase 'G F C E D B A' 'refs/heads/master'
 test_rebase 'G F C D B A' '--onto D refs/heads/master'
+test_rebase 'G F C B A' '--keep-base refs/heads/master'
 
 test_done
diff --git a/t/t3432-rebase-fast-forward.sh b/t/t3432-rebase-fast-forward.sh
index 414b4216d6..8585c21c5c 100755
--- a/t/t3432-rebase-fast-forward.sh
+++ b/t/t3432-rebase-fast-forward.sh
@@ -33,6 +33,7 @@ test_rebase_same_head success 'master'
 test_rebase_same_head success '--onto B B'
 test_rebase_same_head success '--onto B... B'
 test_rebase_same_head success '--onto master... master'
+test_rebase_same_head success '--keep-base master'
 
 test_expect_success 'add work to side' '
 	test_commit E
@@ -44,6 +45,7 @@ test_rebase_same_head success 'master'
 test_rebase_same_head success '--onto B B'
 test_rebase_same_head success '--onto B... B'
 test_rebase_same_head success '--onto master... master'
+test_rebase_same_head success '--keep-base master'
 
 test_expect_success 'add work to upstream' '
 	git checkout master &&
@@ -55,5 +57,6 @@ changes='our and their changes'
 test_rebase_same_head success '--onto B B'
 test_rebase_same_head success '--onto B... B'
 test_rebase_same_head success '--onto master... master'
+test_rebase_same_head success '--keep-base master'
 
 test_done
-- 
2.21.0.695.gaf8658f249

