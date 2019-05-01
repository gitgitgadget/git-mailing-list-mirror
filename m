Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0D4451F453
	for <e@80x24.org>; Wed,  1 May 2019 13:12:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726503AbfEANML (ORCPT <rfc822;e@80x24.org>);
        Wed, 1 May 2019 09:12:11 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:46845 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726101AbfEANMK (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 1 May 2019 09:12:10 -0400
Received: by mail-pg1-f195.google.com with SMTP id n2so8274242pgg.13
        for <git@vger.kernel.org>; Wed, 01 May 2019 06:12:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=vFUAs9R6kymwh6c7YYA95uXPj/YqVJUesYT+t6+6Xt8=;
        b=HY4Ibn+h+vbqKZfulPoG4cJyKBTTixX5Lcmt57ozC/Ct/lYP1ruN2KRkM6f7dTaeCD
         Fwt8eA3gntn2oXdUO5udEWSYj3hJ01VvQnWEYA+LWBfACLI4LREa48mLLL7rwLgHvl5U
         vCmQDnugcki8h4V6qvznPLYPmndiW/2zeHcly3jQnkVybMsPwSJ9gqsU6bE1SoA8HP39
         y+H8U9HM+Fb1v4nQzaH8vzcrfWvrKBbw2YFTK6e3G3619epr+iRjZBIDvHxZagxCnr+f
         a4HYEGQTHrdvjHHZE76QhMuZzdvSQHIZ9PWBOTAhw0xl1SGIogENsZou8FlCDF6eQ0HB
         zjVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=vFUAs9R6kymwh6c7YYA95uXPj/YqVJUesYT+t6+6Xt8=;
        b=JOEIH2ysuPZrul6xK59eBlQe16KZprVgnuDXpHapi34IGKay83qEDOnQJymYeoisWP
         pwiMYrvQhuSqPkSZSWF9vSjbG1LRF9Bjt3SmNh67tt7hV68beKYKFA3W4fGHHDV7vF9v
         QgwS7MJ/TlOKC2mtMPqz62RIMvEPtWM8T2ShQFIgBub/wKh4fkFGjaRXYwJN6GhUGB4F
         /QqM/WAA7fdAnA8d1e5xTFVGFrN+faHMaeX/+3Z4w4ZQqAeiyqENIyAl4ULo/BnB+JEs
         msuxdUQoz0WMi0EZHUkD1ydXyJhIb03w//R6jMtnLc7b1SJcfapV6Sk+hjjX7IY7fsyT
         bYrA==
X-Gm-Message-State: APjAAAV5tY33PB481d0TKewArQhaZ3tdHiZPjiICvYXaEze+U9R6xP02
        Dva44RFC3wNDorZwflXyQIjuI/f1
X-Google-Smtp-Source: APXvYqzrmuLxzSb8Y0aVREjzRmloJnM3qN7Tf0c+yS8JCd6yZ2w6BoKokz9zvtXd245x9Em6rLqIyw==
X-Received: by 2002:a65:5bc3:: with SMTP id o3mr3920604pgr.40.1556716329956;
        Wed, 01 May 2019 06:12:09 -0700 (PDT)
Received: from ash ([171.226.41.84])
        by smtp.gmail.com with ESMTPSA id l10sm90666701pfc.46.2019.05.01.06.12.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 01 May 2019 06:12:09 -0700 (PDT)
Received: by ash (sSMTP sendmail emulation); Wed, 01 May 2019 20:12:05 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Phillip Wood <phillip.wood123@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 2/2] merge: add --quit
Date:   Wed,  1 May 2019 20:11:52 +0700
Message-Id: <20190501131152.314-3-pclouds@gmail.com>
X-Mailer: git-send-email 2.21.0.1110.g9614c01b33
In-Reply-To: <20190501131152.314-1-pclouds@gmail.com>
References: <20190501131152.314-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This allows to cancel the current merge without reseting worktree/index,
which is what --abort is for. Like other --quit(s), this is often used
when you forgot that you're in the middle of a merge and already
switched away, doing different things. By the time you're realize, you
can't even continue the merge anymore.

This also makes all in-progress commands, am, merge, rebase, revert and
cherry-pick, take all three --abort, --continue and --quit (bisect has a
different UI).

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 Documentation/git-merge.txt |  4 ++++
 builtin/merge.c             | 13 +++++++++++++
 t/t7600-merge.sh            | 14 ++++++++++++++
 3 files changed, 31 insertions(+)

diff --git a/Documentation/git-merge.txt b/Documentation/git-merge.txt
index 6294dbc09d..c01cfa6595 100644
--- a/Documentation/git-merge.txt
+++ b/Documentation/git-merge.txt
@@ -100,6 +100,10 @@ commit or stash your changes before running 'git merge'.
 'git merge --abort' is equivalent to 'git reset --merge' when
 `MERGE_HEAD` is present.
 
+--quit::
+	Forget about the current merge in progress. Leave the index
+	and the working tree as-is.
+
 --continue::
 	After a 'git merge' stops due to conflicts you can conclude the
 	merge by running 'git merge --continue' (see "HOW TO RESOLVE
diff --git a/builtin/merge.c b/builtin/merge.c
index 0fd448b403..13392ba1cf 100644
--- a/builtin/merge.c
+++ b/builtin/merge.c
@@ -73,6 +73,7 @@ static int option_renormalize;
 static int verbosity;
 static int allow_rerere_auto;
 static int abort_current_merge;
+static int quit_current_merge;
 static int continue_current_merge;
 static int allow_unrelated_histories;
 static int show_progress = -1;
@@ -270,6 +271,8 @@ static struct option builtin_merge_options[] = {
 	OPT__VERBOSITY(&verbosity),
 	OPT_BOOL(0, "abort", &abort_current_merge,
 		N_("abort the current in-progress merge")),
+	OPT_BOOL(0, "quit", &quit_current_merge,
+		N_("--abort but leave index and working tree alone")),
 	OPT_BOOL(0, "continue", &continue_current_merge,
 		N_("continue the current in-progress merge")),
 	OPT_BOOL(0, "allow-unrelated-histories", &allow_unrelated_histories,
@@ -1255,6 +1258,16 @@ int cmd_merge(int argc, const char **argv, const char *prefix)
 		goto done;
 	}
 
+	if (quit_current_merge) {
+		if (orig_argc != 2)
+			usage_msg_opt(_("--quit expects no arguments"),
+				      builtin_merge_usage,
+				      builtin_merge_options);
+
+		remove_merge_branch_state(the_repository);
+		goto done;
+	}
+
 	if (continue_current_merge) {
 		int nargc = 1;
 		const char *nargv[] = {"commit", NULL};
diff --git a/t/t7600-merge.sh b/t/t7600-merge.sh
index 106148254d..ea82cb744b 100755
--- a/t/t7600-merge.sh
+++ b/t/t7600-merge.sh
@@ -822,4 +822,18 @@ test_expect_success EXECKEEPSPID 'killed merge can be completed with --continue'
 	verify_parents $c0 $c1
 '
 
+test_expect_success 'merge --quit' '
+	git reset --hard side &&
+	test_must_fail git -c rerere.enabled=true merge master &&
+	test_path_is_file .git/MERGE_HEAD &&
+	test_path_is_file .git/MERGE_MODE &&
+	test_path_is_file .git/MERGE_MSG &&
+	test_path_is_file .git/MERGE_RR &&
+	git merge --quit &&
+	test_path_is_missing .git/MERGE_HEAD &&
+	test_path_is_missing .git/MERGE_MODE &&
+	test_path_is_missing .git/MERGE_MSG &&
+	test_path_is_missing .git/MERGE_RR
+'
+
 test_done
-- 
2.21.0.1110.g9614c01b33

