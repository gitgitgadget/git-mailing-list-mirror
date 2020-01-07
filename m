Return-Path: <SRS0=IlH6=24=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F7CBC33C9E
	for <git@archiver.kernel.org>; Tue,  7 Jan 2020 04:10:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3296720715
	for <git@archiver.kernel.org>; Tue,  7 Jan 2020 04:10:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c1pipOcG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727539AbgAGEKa (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 6 Jan 2020 23:10:30 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:42000 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727493AbgAGEKa (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 6 Jan 2020 23:10:30 -0500
Received: by mail-wr1-f65.google.com with SMTP id q6so52263824wro.9
        for <git@vger.kernel.org>; Mon, 06 Jan 2020 20:10:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=4J5F4ChafWahIMjwCbjtD6fB6IPRxUSmsLTuT/xvC9U=;
        b=c1pipOcGWhrmeh9473iXxumS1nSullbU0duQ2t57zRk5qtIVUfmotz2HGUOOh4liA4
         n7vY1Dib29fCyPYp4R12L7ACyiXkKgCgTifOZQ8GReNi6Ima6Bo53fi3YIEVwPkzCBbZ
         YLsUgcDvFVurUcY5N90Tq1olChDDzF/U6uzvMY5qNNQ2vOEiIrqVDpbeXz1uyC/0rdod
         LhPgQ5YOoypci+NIj/9mKwwNr7kjU8cz/tHFHuxXRq5L17VAsj6j3o+AgOiDwzT9Ut9O
         glg1iSMyibJhUPR8mher0x7X6XzE+a5X6KRsaRsc5TiBa8W1dP+s67zt8+bXTeVL56rb
         mDkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=4J5F4ChafWahIMjwCbjtD6fB6IPRxUSmsLTuT/xvC9U=;
        b=sMmsANdEZqfcKn2qXlMfm79Yf2tIFxFBZx/946cfUsyJSU41M5q1NAqFjGPpCSV7D3
         lvdqN59GCiyVxbiKFgnfdod0e5uKZP0VclH2qjxub0KYTsB7I0AxvtnxuTA3IYGVacUW
         YijtanLkXnnbjRvMtOfBwDBLtbLg0m2Ays4uc41Yon2htJWfFv1xeJ2G5kX2GSXrcAoX
         ozRjyiQMvgrQvdnaRycbXsyRMKCZvqGU68ZiJU/R/wfDJOmcfysDX2XRi+2xvFjhunxC
         IGjDyka4c+M2frFBBQvpZEwjVyJOirF1Yn9HPPuKLOYRFCGDRYHn1y1kwClGBY1jjF9D
         GS6A==
X-Gm-Message-State: APjAAAVHA7XEOvpie+9EjgHwoapTSau74VLDDya1G95/GBeDnxQZ0AGv
        /8OXwOhpGYvk+3VRl79xmZQGXGNv
X-Google-Smtp-Source: APXvYqzxtOW8aSMoZNa7glUIfbgoUCddeEZrArfZkc/9KSCD44GkDdhTKZrZXXK8XOjG+UNehZPovA==
X-Received: by 2002:adf:82e7:: with SMTP id 94mr107528431wrc.60.1578370228054;
        Mon, 06 Jan 2020 20:10:28 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id c195sm26692470wmd.45.2020.01.06.20.10.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jan 2020 20:10:27 -0800 (PST)
Message-Id: <19a7cc1889d6094e4f8a94c19c43ad554662e8d8.1578370226.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.507.v2.git.1578370226.gitgitgadget@gmail.com>
References: <pull.507.git.1577933387.gitgitgadget@gmail.com>
        <pull.507.v2.git.1578370226.gitgitgadget@gmail.com>
From:   "Heba Waly via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 07 Jan 2020 04:10:26 +0000
Subject: [PATCH v2 1/1] branch: advise the user to checkout a different branch
 before deleting
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Heba Waly <heba.waly@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Heba Waly <heba.waly@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Heba Waly <heba.waly@gmail.com>

Display a hint to the user when attempting to delete a checked out
branch.

Currently the user gets an error message saying: "error: Cannot delete
branch <branch> checked out at <path>". The hint will be displayed
after the error message.

Signed-off-by: Heba Waly <heba.waly@gmail.com>
---
 advice.c          |  4 +++-
 advice.h          |  1 +
 builtin/branch.c  | 14 ++++++++++++++
 t/t3200-branch.sh |  6 ++++--
 4 files changed, 22 insertions(+), 3 deletions(-)

diff --git a/advice.c b/advice.c
index 249c60dcf3..0a8fd2f68e 100644
--- a/advice.c
+++ b/advice.c
@@ -31,6 +31,7 @@ int advice_graft_file_deprecated = 1;
 int advice_checkout_ambiguous_remote_branch_name = 1;
 int advice_nested_tag = 1;
 int advice_submodule_alternate_error_strategy_die = 1;
+int advice_delete_checkedout_branch = 1;
 
 static int advice_use_color = -1;
 static char advice_colors[][COLOR_MAXLEN] = {
@@ -91,7 +92,8 @@ static struct {
 	{ "checkoutAmbiguousRemoteBranchName", &advice_checkout_ambiguous_remote_branch_name },
 	{ "nestedTag", &advice_nested_tag },
 	{ "submoduleAlternateErrorStrategyDie", &advice_submodule_alternate_error_strategy_die },
-
+	{ "deleteCheckedoutBranch", &advice_delete_checkedout_branch },
+	
 	/* make this an alias for backward compatibility */
 	{ "pushNonFastForward", &advice_push_update_rejected }
 };
diff --git a/advice.h b/advice.h
index b706780614..e75c5ee33c 100644
--- a/advice.h
+++ b/advice.h
@@ -31,6 +31,7 @@ extern int advice_graft_file_deprecated;
 extern int advice_checkout_ambiguous_remote_branch_name;
 extern int advice_nested_tag;
 extern int advice_submodule_alternate_error_strategy_die;
+extern int advice_delete_checkedout_branch;
 
 int git_default_advice_config(const char *var, const char *value);
 __attribute__((format (printf, 1, 2)))
diff --git a/builtin/branch.c b/builtin/branch.c
index d8297f80ff..d1a9443e36 100644
--- a/builtin/branch.c
+++ b/builtin/branch.c
@@ -240,6 +240,20 @@ static int delete_branches(int argc, const char **argv, int force, int kinds,
 				error(_("Cannot delete branch '%s' "
 					"checked out at '%s'"),
 				      bname.buf, wt->path);
+				if (advice_delete_checkedout_branch) {
+					if (wt->is_current) {
+						advise(_("The branch you are trying to delete is already "
+							"checked out, run the following command to "
+							"checkout a different branch then try again:\n"
+							"git switch <branch>"));
+					}
+					else {
+						advise(_("The branch you are trying to delete is checked "
+							"out on another worktree, run the following command "
+							"to checkout a different branch then try again:\n"
+							"git -C %s switch <branch>"), wt->path);
+					}
+				}
 				ret = 1;
 				continue;
 			}
diff --git a/t/t3200-branch.sh b/t/t3200-branch.sh
index 411a70b0ce..edb01bee45 100755
--- a/t/t3200-branch.sh
+++ b/t/t3200-branch.sh
@@ -807,8 +807,10 @@ test_expect_success 'test deleting branch without config' '
 
 test_expect_success 'deleting currently checked out branch fails' '
 	git worktree add -b my7 my7 &&
-	test_must_fail git -C my7 branch -d my7 &&
-	test_must_fail git branch -d my7 &&
+	test_must_fail git -C my7 branch -d my7 2>output1.err &&
+	test_must_fail git branch -d my7 2>output2.err &&
+	test_i18ngrep "hint: The branch you are trying to delete is already checked out" output1.err &&
+	test_i18ngrep "hint: The branch you are trying to delete is checked out on another worktree" output2.err &&
 	rm -r my7 &&
 	git worktree prune
 '
-- 
gitgitgadget
