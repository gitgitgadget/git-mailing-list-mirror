Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A60B21F453
	for <e@80x24.org>; Thu,  7 Feb 2019 06:40:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726651AbfBGGkK (ORCPT <rfc822;e@80x24.org>);
        Thu, 7 Feb 2019 01:40:10 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:38600 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725912AbfBGGkK (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 Feb 2019 01:40:10 -0500
Received: by mail-lj1-f196.google.com with SMTP id c19-v6so8312212lja.5
        for <git@vger.kernel.org>; Wed, 06 Feb 2019 22:40:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=UdS7xBaH/EMue5fg6T4ODpJq+yuehihn05FBXBRXH+Q=;
        b=plRqBsghYt2jCtcQ6dhrSACUbb6gxUww0LUlCTKyPEzyibp+yu1ioQhS+dRZdiYbHP
         shpBYGu9dSSag3I6Eq5yvQjNVzet859CZYJChotHTrjccboBLfkskcyd0Bqc1YvdMkYE
         oAshhVDK0gZLw13bEbdexGZGERE58jRPjP5aMQG8edKnAMR9AkS7OP4WY7te+/KxGuOC
         oN8HI/QWoQf1lnHWll1j41GAgagTL7KHojvx2HMh8uvNxgZ4xEsDSo6ToIyN0nGztBPB
         VUMbuc6er9UYX0PgoxkYPgWFl+phbzqguaI1UKmR0FjrmuPR2WiqkkmclKOzbiO5cHYc
         jw/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=UdS7xBaH/EMue5fg6T4ODpJq+yuehihn05FBXBRXH+Q=;
        b=kVpk+Lg2fI6Jw/w2hPKbaDn6Rrfx+E6bVYmDkIkGlBR6lXgLqjUngd1u91QO7Jbp5y
         u6/75nKrrnp5+zHxyDImYukUTOeELyWQN+KJsYjoelcqZl+Cs+b8NeDeUQBSJLW7w8oc
         R/hiTzD9IBE2vH1IGHIrd2C3MVIUvLAF/Jhw5I/Evmx4YDnfQQS7P7vcUvLufF3eAsCh
         izejolRF4ttpWfLuSyJhegLzTm7Ji6khyqUaBSOtUhc939QgNC7FWC7g7kiKoI1qNlbE
         NRYKaUB5shPvuL1w1h2LAcVgNP10Xl+9wD5+Auz6bufhhrnUKkwKnYAJTG2557nSa9fg
         3rUQ==
X-Gm-Message-State: AHQUAuaL82KA/qlziwwNimRbB0JHo1AZcj5ORv8+iphGoE9878ViJZ4W
        sKhMKJWa4R2kzwfr+y+k+K3k6hdD
X-Google-Smtp-Source: AHgI3IaV62kuYbumJpj91MB0o3tqTb9KpJEMQbSEdeep78I8LYgYaG5iHuZMNrDcnQsvCJx6FNPX/Q==
X-Received: by 2002:a2e:7615:: with SMTP id r21-v6mr4738493ljc.131.1549521607816;
        Wed, 06 Feb 2019 22:40:07 -0800 (PST)
Received: from localhost.localdomain (h-70-143.A163.priv.bahnhof.se. [79.136.70.143])
        by smtp.gmail.com with ESMTPSA id a18-v6sm4046470ljk.86.2019.02.06.22.40.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 06 Feb 2019 22:40:07 -0800 (PST)
From:   matni403@gmail.com
To:     gitster@pobox.com
Cc:     git@vger.kernel.org, Mats Nilsson <matni403@gmail.com>
Subject: [PATCH] Pretty-format: Ability to add newline after non-empty string
Date:   Thu,  7 Feb 2019 07:39:57 +0100
Message-Id: <20190207063957.11052-1-matni403@gmail.com>
X-Mailer: git-send-email 2.14.1.windows.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Mats Nilsson <matni403@gmail.com>

This allows for expansion of %*x to %x followed by a LF if
and only if %x is non-empty.

Signed-off-by: Mats Nilsson <matni403@gmail.com>
---
 Documentation/pretty-formats.txt |  4 ++++
 pretty.c                         | 11 +++++++++--
 t/t6006-rev-list-format.sh       |  5 +++++
 3 files changed, 18 insertions(+), 2 deletions(-)

diff --git a/Documentation/pretty-formats.txt b/Documentation/pretty-formats.txt
index de6953108c..cddd21e27e 100644
--- a/Documentation/pretty-formats.txt
+++ b/Documentation/pretty-formats.txt
@@ -236,6 +236,10 @@ If you add a ` ` (space) after '%' of a placeholder, a space
 is inserted immediately before the expansion if and only if the
 placeholder expands to a non-empty string.
 
+If you add a '*' (star) after '%' of a placeholder, a line-feed
+is added immediately after the expansion if and only if the
+placeholder expands to a non-empty string.
+
 * 'tformat:'
 +
 The 'tformat:' format works exactly like 'format:', except that it
diff --git a/pretty.c b/pretty.c
index 0ab45d10d7..fedea05acc 100644
--- a/pretty.c
+++ b/pretty.c
@@ -1457,7 +1457,8 @@ static size_t format_commit_item(struct strbuf *sb, /* in UTF-8 */
 		NO_MAGIC,
 		ADD_LF_BEFORE_NON_EMPTY,
 		DEL_LF_BEFORE_EMPTY,
-		ADD_SP_BEFORE_NON_EMPTY
+		ADD_SP_BEFORE_NON_EMPTY,
+		ADD_LF_AFTER_NON_EMPTY
 	} magic = NO_MAGIC;
 
 	switch (placeholder[0]) {
@@ -1470,6 +1471,9 @@ static size_t format_commit_item(struct strbuf *sb, /* in UTF-8 */
 	case ' ':
 		magic = ADD_SP_BEFORE_NON_EMPTY;
 		break;
+	case '*':
+		magic = ADD_LF_AFTER_NON_EMPTY;
+		break;
 	default:
 		break;
 	}
@@ -1492,6 +1496,8 @@ static size_t format_commit_item(struct strbuf *sb, /* in UTF-8 */
 			strbuf_insert(sb, orig_len, "\n", 1);
 		else if (magic == ADD_SP_BEFORE_NON_EMPTY)
 			strbuf_insert(sb, orig_len, " ", 1);
+		else if (magic == ADD_LF_AFTER_NON_EMPTY)
+			strbuf_addstr(sb, "\n");
 	}
 	return consumed + 1;
 }
@@ -1501,7 +1507,8 @@ static size_t userformat_want_item(struct strbuf *sb, const char *placeholder,
 {
 	struct userformat_want *w = context;
 
-	if (*placeholder == '+' || *placeholder == '-' || *placeholder == ' ')
+	if (*placeholder == '+' || *placeholder == '-' ||
+		*placeholder == ' ' || *placeholder == '*')
 		placeholder++;
 
 	switch (*placeholder) {
diff --git a/t/t6006-rev-list-format.sh b/t/t6006-rev-list-format.sh
index da113d975b..e333ed91d3 100755
--- a/t/t6006-rev-list-format.sh
+++ b/t/t6006-rev-list-format.sh
@@ -445,6 +445,11 @@ test_expect_success 'add SP before non-empty (2)' '
 	test $(wc -w <actual) = 6
 '
 
+test_expect_success 'add LF after non-empty' '
+	git show -s --pretty=format:"%s%*sThanks" HEAD^^ >actual &&
+	test_line_count = 2 actual
+'
+
 test_expect_success '--abbrev' '
 	echo SHORT SHORT SHORT >expect2 &&
 	echo LONG LONG LONG >expect3 &&
-- 
2.14.1.windows.1

