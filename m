Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9D43B1F404
	for <e@80x24.org>; Mon,  1 Jan 2018 22:55:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752321AbeAAWzB (ORCPT <rfc822;e@80x24.org>);
        Mon, 1 Jan 2018 17:55:01 -0500
Received: from mail-wm0-f66.google.com ([74.125.82.66]:41313 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752314AbeAAWy4 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 1 Jan 2018 17:54:56 -0500
Received: by mail-wm0-f66.google.com with SMTP id g75so58990142wme.0
        for <git@vger.kernel.org>; Mon, 01 Jan 2018 14:54:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=BFbeYpfw+iy6t5VtAp5rZGCSUkFOHWUdNpP1zrEGJU0=;
        b=Kp4dDP+bPThSrdnq01aa1PXRijyl+yxulMgvm4bzHckLwOT8f2bpMyoHq3UnCb1ld1
         v0COR/nPthFsfmOkM9+VFuOOct+mOU0lhgc3Ts+1ehn88OitMahC54AV5iVlaUxtxCpu
         prcRsT+lKFKUCMD+oMAKS55o/K7dgc7JLQEWDRu/w7uZluOQxWJADEPB4FhJcJ3RKAQr
         4fGkQ+mNYwPMTKg080DdtThAjrPw/Ur4OXfk1BXPXv7RoOGCtI2+HT0R7r7ci9mZOIEy
         ZXkC3y/HaIex5h5Ppij+3neMClQLEk/UR8I75YXqnQ4tyUsOePyae3HW9nbOjZRaUVGw
         CLbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=BFbeYpfw+iy6t5VtAp5rZGCSUkFOHWUdNpP1zrEGJU0=;
        b=DpF6oM18RzijbgTwah0tuyjSXvdfOVn36j6YvzYEPaby3pKF33af/8hGTPpuapP8SR
         lBiooBSpxfsJeVuMHlLHV41OCggZctZNpBM0JD9X7EAV0jvpdm6ZPZkhDXBNYAVXVTHO
         v/6xsi1AMOjIhvWe0R/pRIlUvPkyer5DZaV1nmAp3CoHzo0mB2O7XiJeyBsG5uIbyGQL
         Ytz+ICrtg3MKQPUmaB8kYpAeKBZ7jtkhq29rn2T4Lre8UitS3Odz+g2zQZm1p+NfYAT0
         fUewzoie3jBKWqJ/w2KAiXQcsI5mQfKIzLshxWGVrBTY1JpHPPuBRLMfHhftAY9yVcQq
         YZIw==
X-Gm-Message-State: AKGB3mLU8038DHPt7sFJdDaFq9uuja5mPv5xD6lZGxmN2idfDo6mDDuW
        AqZhQFBSLjii/ji/BZvzuhiAag==
X-Google-Smtp-Source: ACJfBouoqB3jHpaIHydAei/twfbYX2RsRCg+6U/RsTrH0t8kGgmO7XQRapMyES4DiNXKpNcKFcYTKA==
X-Received: by 10.28.190.12 with SMTP id o12mr28623320wmf.148.1514847295138;
        Mon, 01 Jan 2018 14:54:55 -0800 (PST)
Received: from localhost.localdomain (94-21-23-100.pool.digikabel.hu. [94.21.23.100])
        by smtp.gmail.com with ESMTPSA id d7sm54186061wrd.54.2018.01.01.14.54.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 01 Jan 2018 14:54:54 -0800 (PST)
From:   =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [PATCH 4/4] branch: add '--show-description' option
Date:   Mon,  1 Jan 2018 23:54:48 +0100
Message-Id: <20180101225448.2561-5-szeder.dev@gmail.com>
X-Mailer: git-send-email 2.16.0.rc0.67.g3a46dbca7
In-Reply-To: <20180101225448.2561-1-szeder.dev@gmail.com>
References: <20180101225448.2561-1-szeder.dev@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

'git branch' has an option to edit a branch's description, but lacks
the option to show that description.

Therefore, add a new '--show-description' option to do just that, as a
more user-friendly alternative to 'git config --get
branch.$branchname.description':

  - it's shorter to type (both in the number of characters and the
    number of TABs if using completion),
  - works on the current branch without explicitly naming it,
  - hides the implementation detail that branch descriptions are
    stored in the config file, and
  - errors out with a proper error message when the given branch
    doesn't exist (but exits quietly with an error code when the
    branch does exit but has no description, just like the 'git config'
    query does).

Signed-off-by: SZEDER Gábor <szeder.dev@gmail.com>
---
 Documentation/git-branch.txt           |  6 +++++-
 builtin/branch.c                       | 39 +++++++++++++++++++++++++++++++---
 contrib/completion/git-completion.bash |  4 ++--
 t/t3200-branch.sh                      | 23 ++++++++++++++++++++
 4 files changed, 66 insertions(+), 6 deletions(-)

diff --git a/Documentation/git-branch.txt b/Documentation/git-branch.txt
index b3084c99c..e05c9e193 100644
--- a/Documentation/git-branch.txt
+++ b/Documentation/git-branch.txt
@@ -20,7 +20,7 @@ SYNOPSIS
 'git branch' (-m | -M) [<oldbranch>] <newbranch>
 'git branch' (-c | -C) [<oldbranch>] <newbranch>
 'git branch' (-d | -D) [-r] <branchname>...
-'git branch' --edit-description [<branchname>]
+'git branch' (--edit-description | --show-description) [<branchname>]
 
 DESCRIPTION
 -----------
@@ -226,6 +226,10 @@ start-point is either a local or remote-tracking branch.
 	`request-pull`, and `merge` (if enabled)). Multi-line explanations
 	may be used.
 
+--show-description::
+	Show the description of the branch previously set using
+	`--edit-description`.
+
 --contains [<commit>]::
 	Only list branches which contain the specified commit (HEAD
 	if not specified). Implies `--list`.
diff --git a/builtin/branch.c b/builtin/branch.c
index 32531aa44..f2f6614e2 100644
--- a/builtin/branch.c
+++ b/builtin/branch.c
@@ -573,7 +573,7 @@ static int edit_branch_description(const char *branch_name)
 int cmd_branch(int argc, const char **argv, const char *prefix)
 {
 	int delete = 0, rename = 0, copy = 0, force = 0, list = 0;
-	int reflog = 0, edit_description = 0;
+	int reflog = 0, edit_description = 0, show_description = 0;
 	int quiet = 0, unset_upstream = 0;
 	const char *new_upstream = NULL;
 	enum branch_track track;
@@ -615,6 +615,8 @@ int cmd_branch(int argc, const char **argv, const char *prefix)
 		OPT_BOOL('l', "create-reflog", &reflog, N_("create the branch's reflog")),
 		OPT_BOOL(0, "edit-description", &edit_description,
 			 N_("edit the description for the branch")),
+		OPT_BOOL(0, "show-description", &show_description,
+			 N_("show the description for the branch")),
 		OPT__FORCE(&force, N_("force creation, move/rename, deletion")),
 		OPT_MERGED(&filter, N_("print only branches that are merged")),
 		OPT_NO_MERGED(&filter, N_("print only branches that are not merged")),
@@ -654,7 +656,9 @@ int cmd_branch(int argc, const char **argv, const char *prefix)
 	argc = parse_options(argc, argv, prefix, options, builtin_branch_usage,
 			     0);
 
-	if (!delete && !rename && !copy && !edit_description && !new_upstream && !unset_upstream && argc == 0)
+	if (!delete && !rename && !copy &&
+	    !edit_description && !show_description &&
+	    !new_upstream && !unset_upstream && argc == 0)
 		list = 1;
 
 	if (filter.with_commit || filter.merge != REF_FILTER_MERGED_NONE || filter.points_at.nr ||
@@ -662,7 +666,7 @@ int cmd_branch(int argc, const char **argv, const char *prefix)
 		list = 1;
 
 	if (!!delete + !!rename + !!copy + !!new_upstream +
-	    list + unset_upstream + edit_description > 1)
+	    list + unset_upstream + edit_description + show_description > 1)
 		usage_with_options(builtin_branch_usage, options);
 
 	if (filter.abbrev == -1)
@@ -737,6 +741,35 @@ int cmd_branch(int argc, const char **argv, const char *prefix)
 
 		if (edit_branch_description(branch_name))
 			return 1;
+	} else if (show_description) {
+		const char *branch_name;
+		struct strbuf buf = STRBUF_INIT;
+		char *description = NULL;
+
+		if (!argc) {
+			if (filter.detached)
+				die(_("cannot show description on detached HEAD"));
+			branch_name = head;
+		} else if (argc == 1)
+			branch_name = argv[0];
+		else
+			die(_("cannot show description of more than one branch"));
+
+		strbuf_addf(&buf, "refs/heads/%s", branch_name);
+		if (!ref_exists(buf.buf)) {
+			strbuf_release(&buf);
+			return error(_("no branch named '%s'"), branch_name);
+		}
+		strbuf_reset(&buf);
+
+		strbuf_addf(&buf, "branch.%s.description", branch_name);
+		if (git_config_get_string(buf.buf, &description)) {
+			strbuf_release(&buf);
+			return 1;
+		}
+		printf("%s", description);
+		strbuf_release(&buf);
+		free(description);
 	} else if (copy) {
 		if (!argc)
 			die(_("branch name required"));
diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 3683c772c..0fcc13ea0 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -1203,8 +1203,8 @@ _git_branch ()
 		__gitcomp "
 			--color --no-color --verbose --abbrev= --no-abbrev
 			--track --no-track --contains --no-contains --merged --no-merged
-			--set-upstream-to= --edit-description --list
-			--unset-upstream --delete --move --copy --remotes
+			--set-upstream-to= --edit-description --show-description
+			--list --unset-upstream --delete --move --copy --remotes
 			--column --no-column --sort= --points-at
 			"
 		;;
diff --git a/t/t3200-branch.sh b/t/t3200-branch.sh
index 427ad490d..53adccc5e 100755
--- a/t/t3200-branch.sh
+++ b/t/t3200-branch.sh
@@ -1239,6 +1239,29 @@ test_expect_success 'refuse --edit-description on unborn branch for now' '
 	test_must_fail env EDITOR=./editor git branch --edit-description
 '
 
+test_expect_success '--show-description' '
+	echo "New contents" >expect &&
+	git branch --show-description >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success '--show-description on detached HEAD' '
+	git checkout --detach &&
+	test_when_finished git checkout master &&
+	test_must_fail git branch --show-description
+'
+
+test_expect_success '--show-description with no description errors quietly' '
+	git config --unset branch.master.description &&
+	test_must_fail git branch --show-description >actual 2>actual.err &&
+	test_must_be_empty actual &&
+	test_must_be_empty actual.err
+'
+
+test_expect_success '--show-description on non-existing branch' '
+	test_must_fail git branch --show-description no-such-branch
+'
+
 test_expect_success '--merged catches invalid object names' '
 	test_must_fail git branch --merged 0000000000000000000000000000000000000000
 '
-- 
2.16.0.rc0.67.g3a46dbca7

