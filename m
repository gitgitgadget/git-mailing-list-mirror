Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3F48520248
	for <e@80x24.org>; Thu, 11 Apr 2019 13:14:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726757AbfDKNOH (ORCPT <rfc822;e@80x24.org>);
        Thu, 11 Apr 2019 09:14:07 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:46272 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726121AbfDKNOG (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 11 Apr 2019 09:14:06 -0400
Received: by mail-pf1-f196.google.com with SMTP id 9so3426347pfj.13
        for <git@vger.kernel.org>; Thu, 11 Apr 2019 06:14:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=8+lJjPwOlliknR63oegYLjJO8QVGZ/Ih1G5DU3HzxBM=;
        b=IdZNPFDSLD3OMI/zB+ug9MVED9diQO6/VQp7ncq8VpV1HNqZsP0f/1Q05JyX/JZ2KO
         DrFA3M6tqqkaAA/ubQap5+ce9XSDKBrTXD2NE8IPJdrFVBdIo2xcpyTaQdnDZfiRGzsN
         oysSEsafMRqClGHrew/5Lk5APGy5uOAVDNneFRbJm8D9zeRwhglSothk6Ettd/LSF6dK
         +6eHV7EZn7GmvuCclZNqpz4UwL98Z45lbHQ63nEMWJCK+hQ1iJiPbPRX8/VpjN5ktpEM
         DPKLbHA5sc81H01Gukr/xmSIv9Q5442ecMD9QU20JXeoor/W3+gzl8Pv69rLHcqH2ybl
         zPIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=8+lJjPwOlliknR63oegYLjJO8QVGZ/Ih1G5DU3HzxBM=;
        b=lvoioN/U3yzV0MKjcq8rYrnBdm9+1K+Z8CPgzyPs8s7fxyviwaa01mk5qeHAzslURU
         ILclYxcCT22qKeaUJJnX+GjnEePgTe5xQGR9LAUrbvQ9KvtsZdaQk5KDGFjpmHvz/a3c
         6BHc8+HnVjc4O/DBxbtWTeLQDCoKh+lGAyqQOHzl93sz6djUxp/Ac/vmmmZ1ws2cnI/D
         t7Bdr18ZOXkUQhRqPzSV1vZxx0AotJmjIwIMnuJ7dNyi9+jckMiXwkkZZ/26euwtJunG
         u49Z6yye4HG3W6OFbp9ZQyldcU3fKbUqTKL8KxjQLrs3Zh78Rt/63HRIl+WN5gvJqIqZ
         ycrw==
X-Gm-Message-State: APjAAAUTDDz3yQSFhF7NxfcFrLYYR2NqhJDJsQI7HNk021DwmuVCdH1j
        ivkVLPxXGRbAOPuVg8WufZYZUvTG
X-Google-Smtp-Source: APXvYqyn85LEIHjgstHN2DV5jDsKKpa3nEYi/1pzjYHWrCIZAc+aHcwLN3z5gTGIKAUOij5KReJiUA==
X-Received: by 2002:a65:6212:: with SMTP id d18mr44309215pgv.162.1554988446016;
        Thu, 11 Apr 2019 06:14:06 -0700 (PDT)
Received: from ash ([116.102.217.71])
        by smtp.gmail.com with ESMTPSA id e193sm10029411pgc.53.2019.04.11.06.14.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 11 Apr 2019 06:14:05 -0700 (PDT)
Received: by ash (sSMTP sendmail emulation); Thu, 11 Apr 2019 20:14:00 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     pclouds@gmail.com
Cc:     git@vger.kernel.org, gitster@pobox.com, newren@gmail.com,
        Eric Sunshine <sunshine@sunshineco.com>, rybak.a.v@gmail.com,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        jacob.keller@gmail.com
Subject: [PATCH v2 15/16] rm: add --staged as alias for --cached
Date:   Thu, 11 Apr 2019 20:12:17 +0700
Message-Id: <20190411131218.19195-16-pclouds@gmail.com>
X-Mailer: git-send-email 2.21.0.682.g30d2204636
In-Reply-To: <20190411131218.19195-1-pclouds@gmail.com>
References: <20190308101655.9767-1-pclouds@gmail.com>
 <20190411131218.19195-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

After the last patch, "git status" now suggests

- add                  to stage some changes
- restore [--worktree] to undo worktree changes
- restore --staged     to undo index changes
- rm --cached          to remove files from the index

This change is to make the suggestions for more consistent by using
--staged across all suggested commands instead of the
still-a-bit-hard-to-understand --cached.

PS. Should we suggest "git stage" instead of "git add"? Maybe that's
going too far?

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 Documentation/git-rm.txt | 7 ++++---
 builtin/rm.c             | 7 ++++---
 t/t3600-rm.sh            | 6 +++---
 t/t7508-status.sh        | 2 +-
 wt-status.c              | 4 ++--
 5 files changed, 14 insertions(+), 12 deletions(-)

diff --git a/Documentation/git-rm.txt b/Documentation/git-rm.txt
index b5c46223c4..4271fc5eaa 100644
--- a/Documentation/git-rm.txt
+++ b/Documentation/git-rm.txt
@@ -8,7 +8,7 @@ git-rm - Remove files from the working tree and from the index
 SYNOPSIS
 --------
 [verse]
-'git rm' [-f | --force] [-n] [-r] [--cached] [--ignore-unmatch] [--quiet] [--] <file>...
+'git rm' [-f | --force] [-n] [-r] [--staged] [--ignore-unmatch] [--quiet] [--] <file>...
 
 DESCRIPTION
 -----------
@@ -55,10 +55,11 @@ OPTIONS
 	the list of files, (useful when filenames might be mistaken
 	for command-line options).
 
+--staged::
 --cached::
 	Use this option to unstage and remove paths only from the index.
-	Working tree files, whether modified or not, will be
-	left alone.
+	Working tree files, whether modified or not, will be left
+	alone. `--cached` is synonym for `--staged`.
 
 --ignore-unmatch::
 	Exit with a zero status even if no files matched.
diff --git a/builtin/rm.c b/builtin/rm.c
index db85b33982..47c8eb100b 100644
--- a/builtin/rm.c
+++ b/builtin/rm.c
@@ -217,7 +217,7 @@ static int check_local_mod(struct object_id *head, int index_only)
 			     "staged in the index:",
 			     "the following files have changes "
 			     "staged in the index:", files_cached.nr),
-			  _("\n(use --cached to keep the file,"
+			  _("\n(use --staged to keep the file,"
 			    " or -f to force removal)"),
 			  &errs);
 	string_list_clear(&files_cached, 0);
@@ -226,7 +226,7 @@ static int check_local_mod(struct object_id *head, int index_only)
 			  Q_("the following file has local modifications:",
 			     "the following files have local modifications:",
 			     files_local.nr),
-			  _("\n(use --cached to keep the file,"
+			  _("\n(use --staged to keep the file,"
 			    " or -f to force removal)"),
 			  &errs);
 	string_list_clear(&files_local, 0);
@@ -240,7 +240,8 @@ static int ignore_unmatch = 0;
 static struct option builtin_rm_options[] = {
 	OPT__DRY_RUN(&show_only, N_("dry run")),
 	OPT__QUIET(&quiet, N_("do not list removed files")),
-	OPT_BOOL( 0 , "cached",         &index_only, N_("only remove from the index")),
+	OPT_BOOL( 0 , "staged",         &index_only, N_("only remove from the index")),
+	OPT_BOOL( 0 , "cached",         &index_only, N_("synonym for --staged")),
 	OPT__FORCE(&force, N_("override the up-to-date check"), PARSE_OPT_NOCOMPLETE),
 	OPT_BOOL('r', NULL,             &recursive,  N_("allow recursive removal")),
 	OPT_BOOL( 0 , "ignore-unmatch", &ignore_unmatch,
diff --git a/t/t3600-rm.sh b/t/t3600-rm.sh
index 04e5d42bd3..5686032b8c 100755
--- a/t/t3600-rm.sh
+++ b/t/t3600-rm.sh
@@ -797,7 +797,7 @@ test_expect_success 'rm file with local modification' '
 	cat >expect <<-\EOF &&
 	error: the following file has local modifications:
 	    foo.txt
-	(use --cached to keep the file, or -f to force removal)
+	(use --staged to keep the file, or -f to force removal)
 	EOF
 	git commit -m "testing rm 3" &&
 	echo content3 >foo.txt &&
@@ -819,7 +819,7 @@ test_expect_success 'rm file with changes in the index' '
 	cat >expect <<-\EOF &&
 	error: the following file has changes staged in the index:
 	    foo.txt
-	(use --cached to keep the file, or -f to force removal)
+	(use --staged to keep the file, or -f to force removal)
 	EOF
 	git reset --hard &&
 	echo content5 >foo.txt &&
@@ -845,7 +845,7 @@ test_expect_success 'rm files with two different errors' '
 	(use -f to force removal)
 	error: the following file has changes staged in the index:
 	    bar1.txt
-	(use --cached to keep the file, or -f to force removal)
+	(use --staged to keep the file, or -f to force removal)
 	EOF
 	echo content >foo1.txt &&
 	git add foo1.txt &&
diff --git a/t/t7508-status.sh b/t/t7508-status.sh
index 681bc314b4..738f3df2f9 100755
--- a/t/t7508-status.sh
+++ b/t/t7508-status.sh
@@ -71,7 +71,7 @@ test_expect_success 'setup' '
 '
 
 test_expect_success 'status (1)' '
-	test_i18ngrep "use \"git rm --cached <file>\.\.\.\" to unstage" output
+	test_i18ngrep "use \"git rm --staged <file>\.\.\.\" to unstage" output
 '
 
 strip_comments () {
diff --git a/wt-status.c b/wt-status.c
index 19fd1add75..4d065ce89e 100644
--- a/wt-status.c
+++ b/wt-status.c
@@ -187,7 +187,7 @@ static void wt_longstatus_print_unmerged_header(struct wt_status *s)
 					 _("  (use \"git restore --source=%s --staged <file>...\" to unstage)"),
 					 s->reference);
 	} else
-		status_printf_ln(s, c, _("  (use \"git rm --cached <file>...\" to unstage)"));
+		status_printf_ln(s, c, _("  (use \"git rm --staged <file>...\" to unstage)"));
 
 	if (!both_deleted) {
 		if (!del_mod_conflict)
@@ -220,7 +220,7 @@ static void wt_longstatus_print_cached_header(struct wt_status *s)
 					 _("  (use \"git restore --source=%s --staged <file>...\" to unstage)"),
 					 s->reference);
 	} else
-		status_printf_ln(s, c, _("  (use \"git rm --cached <file>...\" to unstage)"));
+		status_printf_ln(s, c, _("  (use \"git rm --staged <file>...\" to unstage)"));
 	status_printf_ln(s, c, "%s", "");
 }
 
-- 
2.21.0.682.g30d2204636

