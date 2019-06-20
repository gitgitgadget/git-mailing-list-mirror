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
	by dcvr.yhbt.net (Postfix) with ESMTP id 9798A1F461
	for <e@80x24.org>; Thu, 20 Jun 2019 16:38:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732078AbfFTQid (ORCPT <rfc822;e@80x24.org>);
        Thu, 20 Jun 2019 12:38:33 -0400
Received: from mail-pf1-f202.google.com ([209.85.210.202]:56319 "EHLO
        mail-pf1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732055AbfFTQib (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 Jun 2019 12:38:31 -0400
Received: by mail-pf1-f202.google.com with SMTP id i26so2334638pfo.22
        for <git@vger.kernel.org>; Thu, 20 Jun 2019 09:38:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=T6e6gPqlkRPSRXWcnblPBQNF/TMjH+mE+j/ew3Vnn80=;
        b=KEb7RC8KrthU5a2fhwfrMa6ADS+BUWmcuIbAvBNxAg9qJCpyM7SoB2Nn6KAtoIM0B1
         PcR0Aq6zC25e45+F+dkTp0S3WRCsAt/ul6RceDfpjvcdA4y7GBaVgaiQDXbCyZr2196W
         QALp/UaHBqzS5rLiZQfSW3yNCN6f8X4kBFJ6z+lRfLQtPFmI/wHEFTezaG9/mQHFlz2r
         Aml+BYUdScInROwElgX5gEn87lLIka11/HbE/hBToNn24ZlJkhszGbiwaa3OBMHQrEvU
         DJlfz7NLwSoGHXM6UT0dv+N0wXralOX09k46JDDS6V1XlPosqRLq+MdeCvhGvSS4wQx/
         64VA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=T6e6gPqlkRPSRXWcnblPBQNF/TMjH+mE+j/ew3Vnn80=;
        b=CmRmh8xoXMHQvaTqFUcjRpEORfvecKtOQ3858uqfpG9+8ZI4EOidchzUIClP1rDCuY
         YpDz2iHM17LenEeEPL+YQ9HdR61+d+z0AHgzeWsxgIfIYbUaO/nUdYSorjSLyI/qayVI
         JgWfjVEsY1tjb3GdmPmDvroBUYiGDcW0weGsqJEt/R4pUmB4kHWj4sTonsPynWWnlD6M
         UE/2akFa+A1s7+zCqZboLx972+9u7uHD+fBf6pltEDm/3K3NVkbTgikDxncoGIRJRfzl
         WKf9gFQUyBbE1UERWmbn90kI+apz2NQVNS2bLhin7/8tLC2LfPYnFiYrdo/aDULp9Apf
         fg4Q==
X-Gm-Message-State: APjAAAXXR1xz7xVjlKJcHb8bjqVvaSZyxInjWm3COZJHmMhNif+wyIk2
        zY35Bciq/UezrMAMJOfa7LwzU76TumlYMw2uJfsB+uUyx+ZWK48qx9E8UWIQQtku06M8H+Qd3xN
        CdQJu25IS/YEDdce5/D9qRqozDSCjwvaLPJRYfs5LAYOjSODR3yJv
X-Google-Smtp-Source: APXvYqzaKhDCOaB7RxpS8Qvsp4zYBRPW4oQlivHt3XiOJRfaS0aYs1t0Fea4/ibGtmsdDcsWdi+r661+
X-Received: by 2002:a63:63c1:: with SMTP id x184mr7365421pgb.213.1561048710927;
 Thu, 20 Jun 2019 09:38:30 -0700 (PDT)
Date:   Thu, 20 Jun 2019 12:38:12 -0400
In-Reply-To: <20190620163820.231316-1-brho@google.com>
Message-Id: <20190620163820.231316-2-brho@google.com>
Mime-Version: 1.0
References: <20190620163820.231316-1-brho@google.com>
X-Mailer: git-send-email 2.22.0.410.gd8fdbe21b5-goog
Subject: [PATCH v9 1/9] fsck: rename and touch up init_skiplist()
From:   Barret Rhoden <brho@google.com>
To:     git@vger.kernel.org
Cc:     "=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?=" 
        <avarab@gmail.com>, David Kastrup <dak@gnu.org>,
        Jeff King <peff@peff.net>, Jeff Smith <whydoubt@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>,
        "=?UTF-8?q?Ren=C3=A9=20Scharfe?=" <l.s.r@web.de>,
        Stefan Beller <stefanbeller@gmail.com>,
        Michael Platings <michael@platin.gs>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

init_skiplist() took a file consisting of SHA-1s and comments and added
the objects to an oidset.  This functionality is useful for other
commands and will be moved to oidset.c in a future commit.

In preparation for that move, this commit renames it to
oidset_parse_file() to reflect its more generic usage and cleans up a
few of the names.

Signed-off-by: Barret Rhoden <brho@google.com>
---
 fsck.c                          | 18 +++++++++---------
 t/t5504-fetch-receive-strict.sh | 14 +++++++-------
 2 files changed, 16 insertions(+), 16 deletions(-)

diff --git a/fsck.c b/fsck.c
index 4703f5556145..a28cba6b05dd 100644
--- a/fsck.c
+++ b/fsck.c
@@ -181,7 +181,7 @@ static int fsck_msg_type(enum fsck_msg_id msg_id,
 	return msg_type;
 }
 
-static void init_skiplist(struct fsck_options *options, const char *path)
+void oidset_parse_file(struct oidset *set, const char *path)
 {
 	FILE *fp;
 	struct strbuf sb = STRBUF_INIT;
@@ -189,26 +189,26 @@ static void init_skiplist(struct fsck_options *options, const char *path)
 
 	fp = fopen(path, "r");
 	if (!fp)
-		die("Could not open skip list: %s", path);
+		die("could not open object name list: %s", path);
 	while (!strbuf_getline(&sb, fp)) {
 		const char *p;
-		const char *hash;
+		const char *name;
 
 		/*
 		 * Allow trailing comments, leading whitespace
 		 * (including before commits), and empty or whitespace
 		 * only lines.
 		 */
-		hash = strchr(sb.buf, '#');
-		if (hash)
-			strbuf_setlen(&sb, hash - sb.buf);
+		name = strchr(sb.buf, '#');
+		if (name)
+			strbuf_setlen(&sb, name - sb.buf);
 		strbuf_trim(&sb);
 		if (!sb.len)
 			continue;
 
 		if (parse_oid_hex(sb.buf, &oid, &p) || *p != '\0')
-			die("Invalid SHA-1: %s", sb.buf);
-		oidset_insert(&options->skiplist, &oid);
+			die("invalid object name: %s", sb.buf);
+		oidset_insert(set, &oid);
 	}
 	if (ferror(fp))
 		die_errno("Could not read '%s'", path);
@@ -284,7 +284,7 @@ void fsck_set_msg_types(struct fsck_options *options, const char *values)
 		if (!strcmp(buf, "skiplist")) {
 			if (equal == len)
 				die("skiplist requires a path");
-			init_skiplist(options, buf + equal + 1);
+			oidset_parse_file(&options->skiplist, buf + equal + 1);
 			buf += len + 1;
 			continue;
 		}
diff --git a/t/t5504-fetch-receive-strict.sh b/t/t5504-fetch-receive-strict.sh
index 7bc706873c5b..fdfe179b1188 100755
--- a/t/t5504-fetch-receive-strict.sh
+++ b/t/t5504-fetch-receive-strict.sh
@@ -164,9 +164,9 @@ test_expect_success 'fsck with unsorted skipList' '
 test_expect_success 'fsck with invalid or bogus skipList input' '
 	git -c fsck.skipList=/dev/null -c fsck.missingEmail=ignore fsck &&
 	test_must_fail git -c fsck.skipList=does-not-exist -c fsck.missingEmail=ignore fsck 2>err &&
-	test_i18ngrep "Could not open skip list: does-not-exist" err &&
+	test_i18ngrep "could not open.*: does-not-exist" err &&
 	test_must_fail git -c fsck.skipList=.git/config -c fsck.missingEmail=ignore fsck 2>err &&
-	test_i18ngrep "Invalid SHA-1: \[core\]" err
+	test_i18ngrep "invalid object name: \[core\]" err
 '
 
 test_expect_success 'fsck with other accepted skipList input (comments & empty lines)' '
@@ -193,7 +193,7 @@ test_expect_success 'fsck no garbage output from comments & empty lines errors'
 test_expect_success 'fsck with invalid abbreviated skipList input' '
 	echo $commit | test_copy_bytes 20 >SKIP.abbreviated &&
 	test_must_fail git -c fsck.skipList=SKIP.abbreviated fsck 2>err-abbreviated &&
-	test_i18ngrep "^fatal: Invalid SHA-1: " err-abbreviated
+	test_i18ngrep "^fatal: invalid object name: " err-abbreviated
 '
 
 test_expect_success 'fsck with exhaustive accepted skipList input (various types of comments etc.)' '
@@ -226,10 +226,10 @@ test_expect_success 'push with receive.fsck.skipList' '
 	test_must_fail git push --porcelain dst bogus &&
 	git --git-dir=dst/.git config receive.fsck.skipList does-not-exist &&
 	test_must_fail git push --porcelain dst bogus 2>err &&
-	test_i18ngrep "Could not open skip list: does-not-exist" err &&
+	test_i18ngrep "could not open.*: does-not-exist" err &&
 	git --git-dir=dst/.git config receive.fsck.skipList config &&
 	test_must_fail git push --porcelain dst bogus 2>err &&
-	test_i18ngrep "Invalid SHA-1: \[core\]" err &&
+	test_i18ngrep "invalid object name: \[core\]" err &&
 
 	git --git-dir=dst/.git config receive.fsck.skipList SKIP &&
 	git push --porcelain dst bogus
@@ -255,10 +255,10 @@ test_expect_success 'fetch with fetch.fsck.skipList' '
 	test_must_fail git --git-dir=dst/.git fetch "file://$(pwd)" $refspec &&
 	git --git-dir=dst/.git config fetch.fsck.skipList does-not-exist &&
 	test_must_fail git --git-dir=dst/.git fetch "file://$(pwd)" $refspec 2>err &&
-	test_i18ngrep "Could not open skip list: does-not-exist" err &&
+	test_i18ngrep "could not open.*: does-not-exist" err &&
 	git --git-dir=dst/.git config fetch.fsck.skipList dst/.git/config &&
 	test_must_fail git --git-dir=dst/.git fetch "file://$(pwd)" $refspec 2>err &&
-	test_i18ngrep "Invalid SHA-1: \[core\]" err &&
+	test_i18ngrep "invalid object name: \[core\]" err &&
 
 	git --git-dir=dst/.git config fetch.fsck.skipList dst/.git/SKIP &&
 	git --git-dir=dst/.git fetch "file://$(pwd)" $refspec
-- 
2.22.0.410.gd8fdbe21b5-goog

