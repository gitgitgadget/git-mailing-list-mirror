Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.7 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE,
	USER_IN_DEF_DKIM_WL shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2FF441F731
	for <e@80x24.org>; Thu,  1 Aug 2019 22:21:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389442AbfHAWVB (ORCPT <rfc822;e@80x24.org>);
        Thu, 1 Aug 2019 18:21:01 -0400
Received: from mail-pg1-f201.google.com ([209.85.215.201]:34162 "EHLO
        mail-pg1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728326AbfHAWVB (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Aug 2019 18:21:01 -0400
Received: by mail-pg1-f201.google.com with SMTP id x19so46079301pgx.1
        for <git@vger.kernel.org>; Thu, 01 Aug 2019 15:21:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=x9lWRsKnrkZqQug0KWm6apMHUJA7iiieKmve2fqIzc8=;
        b=h37MskhJAQpBRUrBAjR6oQuYzxVrDp4y24Dqr9zmho2Sa+bJyX2kVY1ryPozXYvEjw
         OeMiSgAOg751GkbtfOXn18plOKz3h74TazNhqXROcSuvVDtgyNh8MjIzQpdGNEVWqsII
         sLDyrRS7uHhmqU2BwqqKoGnvxxhD/Kv+ALjGJNBmkcwRop0BpJd68rWBoUwlDaP3RcM3
         vgNygYfscMdj2HjrM4vKo0+wUkofELAMkY93MxrsDL6p7zlG997iHitBlbqjzzO2I4p0
         cGuhM6CxbcRNjRiRB3PE+jO7rF763Fy4vyPvBc6D1VA70b4v9ji9Cx5lr2cwqNhx2OJ4
         WkPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=x9lWRsKnrkZqQug0KWm6apMHUJA7iiieKmve2fqIzc8=;
        b=s9n6sTBNiIXIcN5ruVgS10p2FvZNHZ3wXwYYbUF5XThoum9zsGrLpTC3Mptkj09R6g
         sEeGx+W7ONDM8r/NOgrKLi4ZatNeDSXFrLBvwEyDRHs0L6Q7x4t87K3SgwU7hUiXNIoD
         +csw868tDERmhTJ42NolzIIh3Gv2ReQTZZ7vGdYqICnW42uSWEc1Nr9QApAeEm8XWJYD
         Gsz8b/p5Xsec4PfJdzncaARLeUNmesDAsDHm12pXK6m5PBYow7vnEBnYBZLJyMVO/cWx
         MA8PPax2lCp+sIiQCcAzcgrVDUh4A4/BuGWYcrHvNsCrrurd+mQfqdxWcFxCLViMOV5Q
         VPgw==
X-Gm-Message-State: APjAAAVlo2QRmWmRB1xxKurm0brNa9vzy7//y3vDKea3WI/54KzJatsZ
        RgPb3gQ6ha4epCiBqXqM9sgdm+etjMEo1bM/0YIOyCiL2hdiFdLen6mviR99iwhher//6vEn4+f
        752L+htzkhtup/U87Tyzz1+7ffsrSKQIp7JcLY4AjhnkTmJaVx4kB2+zqI8kZcaw=
X-Google-Smtp-Source: APXvYqw0fMouZ4MkBuQj2WSAFShozCrMM8M52m2RsRzKtXA8WZshD9gBPxjZRLQvjFri2+p6S9+PuV9+fR3COw==
X-Received: by 2002:a63:9e43:: with SMTP id r3mr97435461pgo.148.1564698059441;
 Thu, 01 Aug 2019 15:20:59 -0700 (PDT)
Date:   Thu,  1 Aug 2019 15:20:46 -0700
In-Reply-To: <cover.1564695892.git.steadmon@google.com>
Message-Id: <45828c56fcd672193096ad767eab24730a0e47ec.1564695893.git.steadmon@google.com>
Mime-Version: 1.0
References: <cover.1563490164.git.steadmon@google.com> <cover.1564695892.git.steadmon@google.com>
X-Mailer: git-send-email 2.22.0.770.g0f2c4a37fd-goog
Subject: [PATCH v3 4/4] merge: --no-verify to bypass pre-merge-commit hook
From:   Josh Steadmon <steadmon@google.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, git@grubix.eu, martin.agren@gmail.com
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Analogous to commit, introduce a '--no-verify' option which bypasses the
pre-merge-commit hook. The shorthand '-n' is taken by '--no-stat'
already.

[js: * reworded commit message to reflect current state of --no-stat flag
       and new hook name
     * fixed flag documentation to reflect new hook name
     * cleaned up trailing whitespace
     * squashed test changes from the original series' patch 4/4
     * modified tests to follow pattern from this series' patch 1/4
]

Signed-off-by: Michael J Gruber <git@grubix.eu>
Signed-off-by: Josh Steadmon <steadmon@google.com>
---
 Documentation/githooks.txt                    |  2 +-
 builtin/merge.c                               |  4 +--
 ...3-pre-commit-and-pre-merge-commit-hooks.sh | 29 +++++++++++++++++++
 3 files changed, 32 insertions(+), 3 deletions(-)

diff --git a/Documentation/githooks.txt b/Documentation/githooks.txt
index 7c4c994858..a934553509 100644
--- a/Documentation/githooks.txt
+++ b/Documentation/githooks.txt
@@ -108,7 +108,7 @@ pre-merge-commit
 
 This hook is invoked by 'git merge' when doing an automatic merge
 commit; it is equivalent to 'pre-commit' for a non-automatic commit
-for a merge.
+for a merge, and can be bypassed with the `--no-verify` option.
 
 prepare-commit-msg
 ~~~~~~~~~~~~~~~~~~
diff --git a/builtin/merge.c b/builtin/merge.c
index bf0ae68c40..c9746e37b8 100644
--- a/builtin/merge.c
+++ b/builtin/merge.c
@@ -287,7 +287,7 @@ static struct option builtin_merge_options[] = {
 	  N_("GPG sign commit"), PARSE_OPT_OPTARG, NULL, (intptr_t) "" },
 	OPT_BOOL(0, "overwrite-ignore", &overwrite_ignore, N_("update ignored files (default)")),
 	OPT_BOOL(0, "signoff", &signoff, N_("add Signed-off-by:")),
-	OPT_BOOL(0, "no-verify", &no_verify, N_("bypass commit-msg hook")),
+	OPT_BOOL(0, "no-verify", &no_verify, N_("bypass pre-merge-commit and commit-msg hooks")),
 	OPT_END()
 };
 
@@ -818,7 +818,7 @@ static void prepare_to_commit(struct commit_list *remoteheads)
 	struct strbuf msg = STRBUF_INIT;
 	const char *index_file = get_index_file();
 
-	if (run_commit_hook(0 < option_edit, index_file, "pre-merge-commit", NULL))
+	if (!no_verify && run_commit_hook(0 < option_edit, index_file, "pre-merge-commit", NULL))
 		abort_commit(remoteheads, NULL);
 	/*
 	 * Re-read the index as pre-merge-commit hook could have updated it,
diff --git a/t/t7503-pre-commit-and-pre-merge-commit-hooks.sh b/t/t7503-pre-commit-and-pre-merge-commit-hooks.sh
index 040dfa0175..86a375ab3e 100755
--- a/t/t7503-pre-commit-and-pre-merge-commit-hooks.sh
+++ b/t/t7503-pre-commit-and-pre-merge-commit-hooks.sh
@@ -68,6 +68,15 @@ test_expect_success '--no-verify with no hook' '
 	test_cmp expected_hooks actual_hooks
 '
 
+test_expect_success '--no-verify with no hook (merge)' '
+	test_when_finished "rm -f expected_hooks actual_hooks" &&
+	touch expected_hooks actual_hooks &&
+	git checkout side &&
+	git merge --no-verify -m "merge master" master &&
+	git checkout master &&
+	test_cmp expected_hooks actual_hooks
+'
+
 test_expect_success 'with succeeding hook' '
 	test_when_finished "rm -f \"$PRECOMMIT\" expected_hooks actual_hooks" &&
 	ln -s "success.sample" "$PRECOMMIT" &&
@@ -100,6 +109,16 @@ test_expect_success '--no-verify with succeeding hook' '
 	test_cmp expected_hooks actual_hooks
 '
 
+test_expect_success '--no-verify with succeeding hook (merge)' '
+	test_when_finished "rm -f \"$PREMERGE\" expected_hooks actual_hooks" &&
+	ln -s "success.sample" "$PREMERGE" &&
+	touch expected_hooks actual_hooks &&
+	git checkout side &&
+	git merge --no-verify -m "merge master" master &&
+	git checkout master &&
+	test_cmp expected_hooks actual_hooks
+'
+
 test_expect_success 'with failing hook' '
 	test_when_finished "rm -f \"$PRECOMMIT\" expected_hooks actual_hooks" &&
 	ln -s "fail.sample" "$PRECOMMIT" &&
@@ -132,6 +151,16 @@ test_expect_success 'with failing hook (merge)' '
 	test_cmp expected_hooks actual_hooks
 '
 
+test_expect_success '--no-verify with failing hook (merge)' '
+	test_when_finished "rm -f \"$PREMERGE\" expected_hooks actual_hooks" &&
+	ln -s "fail.sample" "$PREMERGE" &&
+	touch expected_hooks actual_hooks &&
+	git checkout side &&
+	git merge --no-verify -m "merge master" master &&
+	git checkout master &&
+	test_cmp expected_hooks actual_hooks
+'
+
 test_expect_success POSIXPERM 'with non-executable hook' '
 	test_when_finished "rm -f \"$PRECOMMIT\" expected_hooks actual_hooks; chmod +x \"$HOOKDIR/fail.sample\"" &&
 	ln -s "fail.sample" "$PRECOMMIT" &&
-- 
2.22.0.770.g0f2c4a37fd-goog

