Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E0FCC1F461
	for <e@80x24.org>; Tue, 14 May 2019 09:13:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726342AbfENJNp (ORCPT <rfc822;e@80x24.org>);
        Tue, 14 May 2019 05:13:45 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:46303 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725916AbfENJNp (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 May 2019 05:13:45 -0400
Received: by mail-pf1-f194.google.com with SMTP id y11so8780787pfm.13
        for <git@vger.kernel.org>; Tue, 14 May 2019 02:13:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=XCIWdJ6SsVAizM/TaHLgiPpIdsWd2y2kO+5HHQzh/E8=;
        b=VZyntAXF47icuCf+3WNy/oy1jpMH6pPQSPJEx0bw7ahUXJjCFZClG42iGd2Q6QGn6E
         c/Q3OPK7EHX1hZTOyz3W3PZM04yBBAmnTmIE/RalAlpHnNGimtUWAbBmmqtu2oolpSy3
         xhBNKgFVBwXKS4FMrq7gHJwd5yR1NVTr2X6zL+qtHnrjdI6M5i/x7yx6VjJqjXT30EOZ
         wCtwezj9Zl9lvR/nkm3Rb+CdIVxJ9zraL0eM+x+/OuZxg483rGIiya/ccStmVjC8o7Y0
         KfFLndwj3qVA9W4kT3a/nZp9g2Ibdl8T5KwuexOCfyGfQJPWrb60pweE9faYTl+1Y7bB
         MiEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=XCIWdJ6SsVAizM/TaHLgiPpIdsWd2y2kO+5HHQzh/E8=;
        b=D+g8F6PZ6VLwGHMwlDpDE8eoSjIUqlOJohPg+N9Uk5PIvMQ8F8OBzoXIyoCYEJ3MQ0
         sv7ovsAJsKygT60/1LcmdWHdJTZ7nXWdalQzdVdOpAYeCVp4go/8Lc2liEBCagMJ0L27
         mEFJFUzFL7D2yBPDqNJLnxNPW1AnTB6d7gPFyF5KWfjUbN4/5u3haziY/P8+cQdHSCnv
         NQFL0bQAuAwYQjmANSCCHuOi8Asu+TEXOInrFrObABofPiyoJkKbgFIkONAiLTIEOGZe
         ZIeZhERRDInYykN3YwT93onOaGY31O0nWMRiRVsHiPXpuY28i7Swk+iwy7wF9SuzW4Gm
         axsQ==
X-Gm-Message-State: APjAAAWatbfYudBCeIBszfae6yz4iQUze3pKKxOnCFsWK3YXAGF85kma
        BzURrOppnzhJuAnMH/Gr13aOb7Ol
X-Google-Smtp-Source: APXvYqz3tA+4L16bzqVDE7hzvM4hNt4MuOmD4Q91glYVceEKoTs73/Vaaj8bGn8KgN5CrduP9PQG7Q==
X-Received: by 2002:a63:2d6:: with SMTP id 205mr36715444pgc.114.1557825225047;
        Tue, 14 May 2019 02:13:45 -0700 (PDT)
Received: from ash ([115.72.28.243])
        by smtp.gmail.com with ESMTPSA id i12sm18295013pgb.61.2019.05.14.02.13.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 14 May 2019 02:13:44 -0700 (PDT)
Received: by ash (sSMTP sendmail emulation); Tue, 14 May 2019 16:13:40 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     pclouds@gmail.com
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH v3 2/2] merge: add --quit
Date:   Tue, 14 May 2019 16:13:22 +0700
Message-Id: <20190514091322.12427-3-pclouds@gmail.com>
X-Mailer: git-send-email 2.21.0.1141.gd54ac2cb17
In-Reply-To: <20190514091322.12427-1-pclouds@gmail.com>
References: <20190509101028.24656-1-pclouds@gmail.com>
 <20190514091322.12427-1-pclouds@gmail.com>
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
index 106148254d..d453710ef6 100755
--- a/t/t7600-merge.sh
+++ b/t/t7600-merge.sh
@@ -822,4 +822,18 @@ test_expect_success EXECKEEPSPID 'killed merge can be completed with --continue'
 	verify_parents $c0 $c1
 '
 
+test_expect_success 'merge --quit' '
+	git reset --hard c2 &&
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

