Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6891420248
	for <e@80x24.org>; Sat, 23 Mar 2019 04:17:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725909AbfCWENo (ORCPT <rfc822;e@80x24.org>);
        Sat, 23 Mar 2019 00:13:44 -0400
Received: from mail-it1-f196.google.com ([209.85.166.196]:51913 "EHLO
        mail-it1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725818AbfCWENo (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 23 Mar 2019 00:13:44 -0400
Received: by mail-it1-f196.google.com with SMTP id e24so6614468itl.1
        for <git@vger.kernel.org>; Fri, 22 Mar 2019 21:13:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=SRQOQus+v+6Sk8xDJfcBrwbrie14p1jIbY3x0wD/uSc=;
        b=OGyRBE6D1/hv78SFSF5fxcywGXTRArKENm+9roiwEL7gCzNIg41WUgooYlP0g6RnfL
         vy5otreoJZYpQ1kMvR1MeblADKsUidzpiABGLp/ssdsmcFj/fbLPBPg/Sac4jj1xyPkw
         CSm/KEz7N3j1OeZhcZunb/3/S5o2DRdpLeEP7enfWT0TT/MlxMVHvDWfRhp4RJT/iv3v
         hKUPnFmarerfKmvpyrRvVKg7HVoPvlEpLt0s6aJXgve/S7uM53VHG/HXOA69byl7GzhD
         hpa4cmayX8+2OC14lCdxYG197Sadveql2ZuPueaVluOrd9/lgxURC46M3QoFVCwGRGvy
         JPCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=SRQOQus+v+6Sk8xDJfcBrwbrie14p1jIbY3x0wD/uSc=;
        b=eU5bjgSVyzq+puLqRfY6AJuXo3b8hgGL9an4CkPDv+cr6UeQ+qEj6oA9dXbmLh4NeR
         I/c9Igu1OhI/RN52GYIwXfXHXPSlcnj7wNmlPsqpScROlgKp3RuOjCXY5z8JfmQSuhp7
         Z+TlGor420RkBsXPyOJ5JPPJcY7kJKQ3FNlzAzW2zvw2Hl8OcQOuDtWfc+BtWkZxw1K1
         hF+CvSMq22dO0DmPq/Xzuktcf8AduZsuTeHZoXptGDB+mwzYkRiVptV/BAx1IBCQwZPL
         JIaVs5xFWRUpz8dygTK7NeCLKGZ2dsa5KJWWdpawHeyUhfb5gJWk3H2irAhoaw+R2jwm
         RSTg==
X-Gm-Message-State: APjAAAVMppLB1R2Zbk94QSj+9CbA51aMO4GDawHlumcQeEN74b/lLFRI
        t5VPhLZlGeAoYDfwOcW3JoDnoTcE
X-Google-Smtp-Source: APXvYqymTReZpISE8/uFFw+th92KGcbwcX22jqK28rFviMUcuJySaxihn713oftJ4DRoOfJeEyj/hQ==
X-Received: by 2002:a24:1f44:: with SMTP id d65mr838402itd.65.1553314422804;
        Fri, 22 Mar 2019 21:13:42 -0700 (PDT)
Received: from xavier.hsd1.ut.comcast.net ([2601:681:4100:375e:f2d5:bfff:fecd:8741])
        by smtp.gmail.com with ESMTPSA id r74sm175301ita.7.2019.03.22.21.13.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 22 Mar 2019 21:13:41 -0700 (PDT)
From:   Alex Henrie <alexhenrie24@gmail.com>
To:     git@vger.kernel.org, gitster@pobox.com
Cc:     Alex Henrie <alexhenrie24@gmail.com>
Subject: [PATCH] In `git log --graph`, default to --pretty=oneline --abbrev-commit
Date:   Fri, 22 Mar 2019 22:13:32 -0600
Message-Id: <20190323041332.9743-1-alexhenrie24@gmail.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Having --pretty=medium as the default almost always makes the graph too
difficult to follow.

Signed-off-by: Alex Henrie <alexhenrie24@gmail.com>
---
 builtin/log.c          |  5 +++++
 t/t4052-stat-output.sh | 14 +++++++-------
 t/t4202-log.sh         | 14 ++++++++++++++
 3 files changed, 26 insertions(+), 7 deletions(-)

diff --git a/builtin/log.c b/builtin/log.c
index ab859f5904..4fca910fee 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -199,6 +199,11 @@ static void cmd_log_init_finish(int argc, const char **argv, const char *prefix,
 	memset(&w, 0, sizeof(w));
 	userformat_find_requirements(NULL, &w);
 
+	if (rev->graph && !fmt_pretty && !rev->pretty_given && !rev->show_signature) {
+		rev->abbrev_commit = 1;
+		rev->commit_format = CMIT_FMT_ONELINE;
+	}
+
 	if (!rev->show_notes_given && (!rev->pretty_given || w.notes))
 		rev->show_notes = 1;
 	if (rev->show_notes)
diff --git a/t/t4052-stat-output.sh b/t/t4052-stat-output.sh
index 28c053849a..b44776efe3 100755
--- a/t/t4052-stat-output.sh
+++ b/t/t4052-stat-output.sh
@@ -144,7 +144,7 @@ done <<\EOF
 ignores expect72 format-patch -1 --stdout
 respects expect200 diff HEAD^ HEAD --stat
 respects expect200 show --stat
-respects expect200 log -1 --stat
+respects expect200 log -1 --pretty=medium --stat
 EOF
 
 cat >expect40 <<'EOF'
@@ -172,7 +172,7 @@ done <<\EOF
 ignores expect72 format-patch -1 --stdout
 respects expect40 diff HEAD^ HEAD --stat
 respects expect40 show --stat
-respects expect40 log -1 --stat
+respects expect40 log -1 --pretty=medium --stat
 EOF
 
 cat >expect40 <<'EOF'
@@ -200,7 +200,7 @@ done <<\EOF
 ignores expect72 format-patch -1 --stdout
 respects expect40 diff HEAD^ HEAD --stat
 respects expect40 show --stat
-respects expect40 log -1 --stat
+respects expect40 log -1 --pretty=medium --stat
 EOF
 
 
@@ -247,7 +247,7 @@ done <<\EOF
 format-patch -1 --stdout
 diff HEAD^ HEAD --stat
 show --stat
-log -1 --stat
+log -1 --pretty=medium --stat
 EOF
 
 test_expect_success 'preparation for long filename tests' '
@@ -281,7 +281,7 @@ done <<\EOF
 format-patch -1 --stdout
 diff HEAD^ HEAD --stat
 show --stat
-log -1 --stat
+log -1 --pretty=medium --stat
 EOF
 
 cat >expect72 <<'EOF'
@@ -315,7 +315,7 @@ done <<\EOF
 ignores expect72 format-patch -1 --stdout
 respects expect200 diff HEAD^ HEAD --stat
 respects expect200 show --stat
-respects expect200 log -1 --stat
+respects expect200 log -1 --pretty=medium --stat
 EOF
 
 cat >expect1 <<'EOF'
@@ -345,7 +345,7 @@ done <<\EOF
 ignores expect72 format-patch -1 --stdout
 respects expect1 diff HEAD^ HEAD --stat
 respects expect1 show --stat
-respects expect1 log -1 --stat
+respects expect1 log -1 --pretty=medium --stat
 EOF
 
 cat >expect <<'EOF'
diff --git a/t/t4202-log.sh b/t/t4202-log.sh
index 819c24d10e..7cf9f15cec 100755
--- a/t/t4202-log.sh
+++ b/t/t4202-log.sh
@@ -39,6 +39,20 @@ test_expect_success setup '
 
 '
 
+test_expect_success 'default log format' '
+
+	git log --pretty=medium > expect &&
+	git log > actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'default log --graph format' '
+
+	git log --graph --pretty=oneline --abbrev-commit > expect &&
+	git log --graph > actual &&
+	test_cmp expect actual
+'
+
 printf "sixth\nfifth\nfourth\nthird\nsecond\ninitial" > expect
 test_expect_success 'pretty' '
 
-- 
2.21.0

