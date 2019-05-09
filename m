Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8CEB51F45F
	for <e@80x24.org>; Thu,  9 May 2019 10:10:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726406AbfEIKK4 (ORCPT <rfc822;e@80x24.org>);
        Thu, 9 May 2019 06:10:56 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:45209 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725847AbfEIKK4 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 May 2019 06:10:56 -0400
Received: by mail-pg1-f196.google.com with SMTP id i21so954623pgi.12
        for <git@vger.kernel.org>; Thu, 09 May 2019 03:10:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=9NpdX/cj2EMNcXjXiyMhTDfB0uHfpWtkQgY09RzRmf0=;
        b=HI0KfNDhvtHJVJ8bM/HufrMgADrTbClFcLII0bkrSU0W/C7WuBbEh49tFcTKkBqOwI
         rSLPoUAofZ32NP3ol8C2chU2sLjhRlMcLqzocGR6aHe0qrjUx3FmOcC4NgRPbbylRmUT
         m8e6jbJ9jSVgpV7QH8jLAty2L9sip8tUjBE5v1vNhxxetnfa2WzBprpg9ilsHfz2KgRN
         M46okEvnJ02t7sCLDm0E5JXjPTuTzn52dFNcmXqdAnyj6TiJhe4IF29VObjqbBWYUkon
         dnxvYsT3Hp8x8+L4+ZT2dltKMwZZdrwiNu3DvJfyyjCKjWE5IlkxwVl62JDq0eZdy1hk
         YDUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9NpdX/cj2EMNcXjXiyMhTDfB0uHfpWtkQgY09RzRmf0=;
        b=IGL13jQki99R4Yw42RAXInewbFrIwbl6r1vcEF2InOWtW0yt0t2LpO7O3D0LltxmMW
         iB3SW+cEX+guh/E/ADqoITVm0xDmbYRBRuIAQkqNPWCOzZESDN70tZM3pUIZ6pM0qnys
         zYjCiXfaqdGf7OUUovAK39bz2Ku3KMyifHKSaDUJUqPrdj78ogxEXJHxXes3GzfpHnqe
         Z2qnpBsT4LJnFVBQRPDOYJymvxCz53SCfXee7gdf3miGlgrj44L3dZ7Zq+H4PMLpG5DF
         WARm+UHrLOvJWoKtlOTzOP/QB9Ezib6t0+NUh/O8O02757/kN2+SHDkAbsc6YUkY1N0i
         2kWQ==
X-Gm-Message-State: APjAAAWjRKOpmMbA6vx7P9KkpRCmgmIrklGr7zLvSlHoghVteF4MB3Yr
        fv5Tw0S1rZDC8FI4NZgyiQM=
X-Google-Smtp-Source: APXvYqy2EFezzGAQIKLRg23S7KdXsAv8FNVPoW9rZg6TN0it70Ng3cVvhG2x3GP6dGglKfXYlJ7YRg==
X-Received: by 2002:a63:fb45:: with SMTP id w5mr4195857pgj.397.1557396655701;
        Thu, 09 May 2019 03:10:55 -0700 (PDT)
Received: from ash ([115.72.28.243])
        by smtp.gmail.com with ESMTPSA id d66sm124440pfg.183.2019.05.09.03.10.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 09 May 2019 03:10:55 -0700 (PDT)
Received: by ash (sSMTP sendmail emulation); Thu, 09 May 2019 17:10:51 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     pclouds@gmail.com
Cc:     git@vger.kernel.org, gitster@pobox.com, emilyshaffer@google.com
Subject: [PATCH v2 2/2] merge: add --quit
Date:   Thu,  9 May 2019 17:10:28 +0700
Message-Id: <20190509101028.24656-3-pclouds@gmail.com>
X-Mailer: git-send-email 2.21.0.1141.gd54ac2cb17
In-Reply-To: <20190509101028.24656-1-pclouds@gmail.com>
References: <20190501131152.314-1-pclouds@gmail.com>
 <20190509101028.24656-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This allows to cancel the current merge without resetting worktree/index,
which is what --abort is for. Like other --quit(s), this is often used
when you forgot that you're in the middle of a merge and already
switched away, doing different things. By the time you've realized, you
can't even continue the merge anymore.

This also makes all in-progress commands, am, merge, rebase, revert and
cherry-pick, take all three --abort, --continue and --quit (bisect has a
different UI).

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 Documentation/git-merge.txt |  4 ++++
 builtin/merge.c             | 13 +++++++++++++
 t/t7600-merge.sh            | 14 ++++++++++++++
 3 files changed, 31 insertions(+)

diff --git a/Documentation/git-merge.txt b/Documentation/git-merge.txt
index 4cc86469f3..b7d581fc76 100644
--- a/Documentation/git-merge.txt
+++ b/Documentation/git-merge.txt
@@ -99,6 +99,10 @@ commit or stash your changes before running 'git merge'.
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
index e9663f027a..598d56edfe 100644
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
@@ -267,6 +268,8 @@ static struct option builtin_merge_options[] = {
 	OPT__VERBOSITY(&verbosity),
 	OPT_BOOL(0, "abort", &abort_current_merge,
 		N_("abort the current in-progress merge")),
+	OPT_BOOL(0, "quit", &quit_current_merge,
+		N_("--abort but leave index and working tree alone")),
 	OPT_BOOL(0, "continue", &continue_current_merge,
 		N_("continue the current in-progress merge")),
 	OPT_BOOL(0, "allow-unrelated-histories", &allow_unrelated_histories,
@@ -1252,6 +1255,16 @@ int cmd_merge(int argc, const char **argv, const char *prefix)
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
2.21.0.1141.gd54ac2cb17

