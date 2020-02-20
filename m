Return-Path: <SRS0=QcP8=4I=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6978CC11D04
	for <git@archiver.kernel.org>; Thu, 20 Feb 2020 09:16:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 36A6124654
	for <git@archiver.kernel.org>; Thu, 20 Feb 2020 09:16:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E3MjzOtd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726826AbgBTJQd (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 20 Feb 2020 04:16:33 -0500
Received: from mail-pl1-f170.google.com ([209.85.214.170]:43429 "EHLO
        mail-pl1-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726803AbgBTJQc (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 Feb 2020 04:16:32 -0500
Received: by mail-pl1-f170.google.com with SMTP id p11so1305580plq.10
        for <git@vger.kernel.org>; Thu, 20 Feb 2020 01:16:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=PEEWhMKbRDfRfR36Nif/rqyTWsPVwW1YtvSko0jKUJ0=;
        b=E3MjzOtd4TqwhB2xVhTqP9uctsYhOBamSDhj2y9CKSCy6jNqythEhd4IPRen6mbnsQ
         8bxtHQpaeH1nM3SO0zT31KE4Gq4aa9pZsRN9mcf7kMAgmhXzRyRqjaTgabz89NJKIaqd
         WjmWXo4Ip7eZQkP7En+KATIzjaUju8BjpcgrrZvJwySZwpjH2XLgm3axdKChxt7E1rNr
         ni4XEvDdHoqsv4fkOjmjMZUn5YgS4rXR4Rixbl74QEy2bVCIf/FzglU8OrTTBWOCxgwq
         +dc22YtfvhQPVbQVFvh2anBve7Q116+SRsc5Fg5quob7cAayOTY1I12XD54DcUjUo23J
         bdRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=PEEWhMKbRDfRfR36Nif/rqyTWsPVwW1YtvSko0jKUJ0=;
        b=YVY6E+5TQNDbzVjDOkkuusY7N0tweu6FTQveuzPCtbvn6n49nh/owI5h+rQxMEYqAo
         itn7r6PEBrMf6CZrpvONnTsGnD/9M5XMPgEnLWkwWN0hV2wdvYfgsL2XH8eDzW8TeF6y
         XQe64fj2jmhL5rIdUEkUXdrcAduCcmIOQHXblyaZTKeHbtfZMkb5x3XrK/Ir271XTaDL
         U6pZDW4nSlnOA3gPkD2QCYgOxjBc6bXwCYGu+FXOEkihUZU/kZhnl7qLXh/ycVpaMndc
         J5ukovFbadg/DXzzW4BsYnnghsJ9ii714dpiB4Vx7dZPdgLiS1O1D0jeUF3ohAbM9Ed1
         VKbA==
X-Gm-Message-State: APjAAAW1SWOiaTKtgFdF3mtijIQtBF+C2EFJeEuU7iZjnJivEshdO9aI
        IHrng5K/yWPLPWclV8pJ8SwGf18uMJk=
X-Google-Smtp-Source: APXvYqz/2NYRRkuOjLBNffrgCX4ayGBbOf8a98JgV2DCQQlyVCsBEYTUBBfqak++GMxYql+BkcUGAw==
X-Received: by 2002:a17:902:ab8f:: with SMTP id f15mr30203809plr.280.1582190191556;
        Thu, 20 Feb 2020 01:16:31 -0800 (PST)
Received: from Abhishek-Arch.nitk.ac.in ([218.248.46.107])
        by smtp.gmail.com with ESMTPSA id c8sm2745381pgq.30.2020.02.20.01.16.30
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Feb 2020 01:16:31 -0800 (PST)
From:   Abhishek Kumar <abhishekkumar8222@gmail.com>
To:     git@vger.kernel.org
Subject: [PATCH v2 2/2] lib-log-graph: consolidate colored graph cmp logic
Date:   Thu, 20 Feb 2020 14:45:28 +0530
Message-Id: <20200220091528.28472-3-abhishekkumar8222@gmail.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200220091528.28472-1-abhishekkumar8222@gmail.com>
References: <20200216134750.18947-1-abhishekkumar8222@gmail.com>
 <20200220091528.28472-1-abhishekkumar8222@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Abhishek Kumar <abhishekkumar8222@gmail.com>
---
 t/lib-log-graph.sh           |  6 ++++++
 t/t4202-log.sh               |  4 +---
 t/t4214-log-graph-octopus.sh | 36 ++++++++++++------------------------
 t/t4215-log-skewed-merges.sh |  4 +---
 4 files changed, 20 insertions(+), 30 deletions(-)

diff --git a/t/lib-log-graph.sh b/t/lib-log-graph.sh
index 97cde44dc7..6185a648ed 100755
--- a/t/lib-log-graph.sh
+++ b/t/lib-log-graph.sh
@@ -20,3 +20,9 @@ lib_test_cmp_short_graph () {
 	sanitize_log_output >output.sanitized < output &&
 	test_i18ncmp expect output.sanitized
 }
+
+lib_test_cmp_colored_graph () {
+	git log --graph --color=always "$@" >output.colors.raw &&
+	test_decode_color <output.colors.raw | sed "s/ *\$//" >output.colors &&
+	test_cmp expect.colors output.colors
+}
diff --git a/t/t4202-log.sh b/t/t4202-log.sh
index e025a9cfc2..4694b6d0ce 100755
--- a/t/t4202-log.sh
+++ b/t/t4202-log.sh
@@ -537,9 +537,7 @@ EOF
 
 test_expect_success 'log --graph with merge with log.graphColors' '
 	test_config log.graphColors " blue,invalid-color, cyan, red  , " &&
-	git log --color=always --graph --date-order --pretty=tformat:%s |
-		test_decode_color | sed "s/ *\$//" >actual &&
-	test_cmp expect.colors actual
+	lib_test_cmp_colored_graph --date-order --format=%s
 '
 
 test_expect_success 'log --raw --graph -m with merge' '
diff --git a/t/t4214-log-graph-octopus.sh b/t/t4214-log-graph-octopus.sh
index dedb72ace6..a080325098 100755
--- a/t/t4214-log-graph-octopus.sh
+++ b/t/t4214-log-graph-octopus.sh
@@ -10,6 +10,10 @@ test_cmp_graph () {
 	lib_test_cmp_graph --color=never --date-order --format=%s "$@"
 }
 
+test_cmp_colored_graph () {
+	lib_test_cmp_colored_graph --date-order --format=%s "$@"
+}
+
 test_expect_success 'set up merge history' '
 	test_commit initial &&
 	for i in 1 2 3 4 ; do
@@ -60,9 +64,7 @@ test_expect_success 'log --graph with tricky octopus merge with colors' '
 	<MAGENTA>|<RESET><MAGENTA>/<RESET>
 	* initial
 	EOF
-	git log --color=always --graph --date-order --pretty=tformat:%s left octopus-merge >actual.colors.raw &&
-	test_decode_color <actual.colors.raw | sed "s/ *\$//" >actual.colors &&
-	test_cmp expect.colors actual.colors
+	test_cmp_colored_graph left octopus-merge
 '
 
 # Repeat the previous two tests with "normal" octopus merge (i.e.,
@@ -97,9 +99,7 @@ test_expect_success 'log --graph with normal octopus merge with colors' '
 	* initial
 	EOF
 	test_config log.graphColors red,green,yellow,blue,magenta,cyan &&
-	git log --color=always --graph --date-order --pretty=tformat:%s octopus-merge >actual.colors.raw &&
-	test_decode_color <actual.colors.raw | sed "s/ *\$//" >actual.colors &&
-	test_cmp expect.colors actual.colors
+	test_cmp_colored_graph octopus-merge
 '
 
 test_expect_success 'log --graph with normal octopus merge and child, no color' '
@@ -133,9 +133,7 @@ test_expect_success 'log --graph with normal octopus and child merge with colors
 	* initial
 	EOF
 	test_config log.graphColors red,green,yellow,blue,magenta,cyan &&
-	git log --color=always --graph --date-order --pretty=tformat:%s after-merge >actual.colors.raw &&
-	test_decode_color <actual.colors.raw | sed "s/ *\$//" >actual.colors &&
-	test_cmp expect.colors actual.colors
+	test_cmp_colored_graph after-merge
 '
 
 test_expect_success 'log --graph with tricky octopus merge and its child, no color' '
@@ -171,9 +169,7 @@ test_expect_success 'log --graph with tricky octopus merge and its child with co
 	<CYAN>|<RESET><CYAN>/<RESET>
 	* initial
 	EOF
-	git log --color=always --graph --date-order --pretty=tformat:%s left after-merge >actual.colors.raw &&
-	test_decode_color <actual.colors.raw | sed "s/ *\$//" >actual.colors &&
-	test_cmp expect.colors actual.colors
+	test_cmp_colored_graph left after-merge
 '
 
 test_expect_success 'log --graph with crossover in octopus merge, no color' '
@@ -215,9 +211,7 @@ test_expect_success 'log --graph with crossover in octopus merge with colors' '
 	<MAGENTA>|<RESET><MAGENTA>/<RESET>
 	* initial
 	EOF
-	git log --color=always --graph --date-order --pretty=tformat:%s after-4 octopus-merge >actual.colors.raw &&
-	test_decode_color <actual.colors.raw | sed "s/ *\$//" >actual.colors &&
-	test_cmp expect.colors actual.colors
+	test_cmp_colored_graph after-4 octopus-merge
 '
 
 test_expect_success 'log --graph with crossover in octopus merge and its child, no color' '
@@ -261,9 +255,7 @@ test_expect_success 'log --graph with crossover in octopus merge and its child w
 	<CYAN>|<RESET><CYAN>/<RESET>
 	* initial
 	EOF
-	git log --color=always --graph --date-order --pretty=tformat:%s after-4 after-merge >actual.colors.raw &&
-	test_decode_color <actual.colors.raw | sed "s/ *\$//" >actual.colors &&
-	test_cmp expect.colors actual.colors
+	test_cmp_colored_graph after-4 after-merge
 '
 
 test_expect_success 'log --graph with unrelated commit and octopus tip, no color' '
@@ -305,9 +297,7 @@ test_expect_success 'log --graph with unrelated commit and octopus tip with colo
 	<RED>|<RESET><RED>/<RESET>
 	* initial
 	EOF
-	git log --color=always --graph --date-order --pretty=tformat:%s after-initial octopus-merge >actual.colors.raw &&
-	test_decode_color <actual.colors.raw | sed "s/ *\$//" >actual.colors &&
-	test_cmp expect.colors actual.colors
+	test_cmp_colored_graph after-initial octopus-merge
 '
 
 test_expect_success 'log --graph with unrelated commit and octopus child, no color' '
@@ -351,9 +341,7 @@ test_expect_success 'log --graph with unrelated commit and octopus child with co
 	<RED>|<RESET><RED>/<RESET>
 	* initial
 	EOF
-	git log --color=always --graph --date-order --pretty=tformat:%s after-initial after-merge >actual.colors.raw &&
-	test_decode_color <actual.colors.raw | sed "s/ *\$//" >actual.colors &&
-	test_cmp expect.colors actual.colors
+	test_cmp_colored_graph after-initial after-merge
 '
 
 test_done
diff --git a/t/t4215-log-skewed-merges.sh b/t/t4215-log-skewed-merges.sh
index e1e94176da..28d0779a8c 100755
--- a/t/t4215-log-skewed-merges.sh
+++ b/t/t4215-log-skewed-merges.sh
@@ -305,9 +305,7 @@ test_expect_success 'log --graph with multiple tips and colors' '
 	<BLUE>|<RESET><BLUE>/<RESET>
 	* 6_A
 	EOF
-	git log --color=always --graph --date-order --pretty=tformat:%s 6_1 6_3 6_5 >actual.colors.raw &&
-	test_decode_color <actual.colors.raw | sed "s/ *\$//" >actual.colors &&
-	test_cmp expect.colors actual.colors
+	lib_test_cmp_colored_graph --date-order --pretty=tformat:%s 6_1 6_3 6_5
 '
 
 test_expect_success 'log --graph with multiple tips' '
-- 
2.25.0

