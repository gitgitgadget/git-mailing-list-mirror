Return-Path: <SRS0=m/qT=4Z=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6ACCC10F27
	for <git@archiver.kernel.org>; Sun,  8 Mar 2020 18:29:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7D07E206D7
	for <git@archiver.kernel.org>; Sun,  8 Mar 2020 18:29:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SyZOU5u+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726368AbgCHS3u (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 8 Mar 2020 14:29:50 -0400
Received: from mail-ed1-f45.google.com ([209.85.208.45]:39230 "EHLO
        mail-ed1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726279AbgCHS3u (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 8 Mar 2020 14:29:50 -0400
Received: by mail-ed1-f45.google.com with SMTP id m13so9311929edb.6
        for <git@vger.kernel.org>; Sun, 08 Mar 2020 11:29:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=V9X8YkwHYzBVUHpxH8mIsbywL7koUIJXVt5dKJwvDWw=;
        b=SyZOU5u+IKjRtoOCZPshXUyoFaUaGWTM365TGmeLmY2x/nzrcOMLDkA3J5RPj2ze9S
         kD2XbhIN+DIm2J/CjViFY18ZAREYvvwrCjK+uRdl7RXFeKc238oD1ReIdbu2P/32bLVK
         GmEHYeqtQVrvf8yeQ8XHZxgv8lOaX/cKxYBoKdC9okwq8OdIVZaoTSBdnvnk4ijJBvuv
         nnz/un2cW/2chXr7/L337iZL9KHkqWO4/MAyLRnkN83LGJZQsgL3n3zHAh2yhQwEDlqt
         lk8IOJY2g54r+cypzJ71yd8LygtevuwhE/9m6VJ2HpYrNKk9bYuTuTl7Z+1TKRxKXgpm
         L6ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=V9X8YkwHYzBVUHpxH8mIsbywL7koUIJXVt5dKJwvDWw=;
        b=AtKtxqxBhurysWSl9nC/qk3fUv0d9YP5GVrXvsamlGACQTjLNaDtgauqNUyerNpmwC
         oDsNiypHXtGTCNgCujqHXApc/q0ZYyR3aTGWR02fFmxjSlxOv4P7EwI0xVQD6RRWOlII
         omIhviqkDeQm2m02IrqqWCpiz7t5h6qSBW90XJ/VL7AEGwbMAnVNE3B/DWOBbfAFE0yl
         9vPWCZ0Z6WsL/AMe0brNocN9DGbSDmZFfZ7IqzmsJBhyph39PvzVez8OSCLggr8xsqHt
         nshZ2BJUpAEsUoZFuIiPMkBunH9R+Ym74UWJFPRl3X3MeKZSJnCnt/mEF2/TIbiCYwG7
         4Wxg==
X-Gm-Message-State: ANhLgQ3jNGF4Ey9VpzFjWd/pfOrvoA+ILp5bNam1oYe2vtp4O/bXLNAO
        x9+zbkLRwR85qxe4RJ9GACYBxbHK
X-Google-Smtp-Source: ADFU+vsjBCEVOCAX7gfaekDgz7esawo+uJhQMmDNEcfwtUgcyEVzkaHSwW3NvXlWX+B9Bgs2DEmnUg==
X-Received: by 2002:aa7:dccd:: with SMTP id w13mr9673706edu.201.1583692187957;
        Sun, 08 Mar 2020 11:29:47 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id a7sm1478728ejs.33.2020.03.08.11.29.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Mar 2020 11:29:47 -0700 (PDT)
Message-Id: <c68bc2b37889bb2394dfd618cd3f03c1a7d85280.1583692184.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.576.git.1583692184.gitgitgadget@gmail.com>
References: <pull.576.git.1583692184.gitgitgadget@gmail.com>
From:   "Philippe Blain via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sun, 08 Mar 2020 18:29:43 +0000
Subject: [PATCH 2/3] ref-filter: teach the API to correctly handle CRLF
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Michael J Gruber <git@grubix.eu>,
        Matthieu Moy <git@matthieu-moy.fr>,
        John Keeping <john@keeping.me.uk>,
        Karthik Nayak <karthik.188@gmail.com>,
        Jeff King <peff@peff.net>,
        Alex Henrie <alexhenrie24@gmail.com>,
        Philippe Blain <levraiphilippeblain@gmail.com>,
        Philippe Blain <levraiphilippeblain@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Philippe Blain <levraiphilippeblain@gmail.com>

The ref-filter API does not correctly handle commit or tag messages that
use CRLF as the line terminator. Such messages can be created with the
`--verbatim` option of `git commit` and `git tag`, or by using `git
commit-tree` directly.

This impacts the output of `git branch -v`, and `git branch`, `git
tag` and `git for-each-ref` when used with a `--format` argument
containing the atoms `%(contents:subject)` or `%(contents:body)`.

Fix this bug in ref-filter by improving the logic in `copy_subject` and
`find_subpos`.

Add tests for `branch`, `tag` and `for-each-ref` using
lib-crlf-messages.sh. The 'make commits' test at the beginning of
t3203-branch-output.sh needs to be modified since it did not use
`test_tick` and thus the commit hashes were not reproducible. For
simplicity, use `test_commit` as the content and name of the files
created in this setup test are irrelevant to the rest of the test
script.

Signed-off-by: Philippe Blain <levraiphilippeblain@gmail.com>
---
 ref-filter.c             | 19 +++++++++++++++++--
 t/t3203-branch-output.sh | 26 +++++++++++++++++++++-----
 t/t6300-for-each-ref.sh  |  5 +++++
 t/t7004-tag.sh           |  7 +++++++
 4 files changed, 50 insertions(+), 7 deletions(-)

diff --git a/ref-filter.c b/ref-filter.c
index 79bb5206783..537cc4de42c 100644
--- a/ref-filter.c
+++ b/ref-filter.c
@@ -1050,10 +1050,18 @@ static char *copy_subject(const char *buf, unsigned long len)
 {
 	char *r = xmemdupz(buf, len);
 	int i;
+	struct strbuf sb = STRBUF_INIT;
 
-	for (i = 0; i < len; i++)
+	strbuf_attach(&sb, r, len, len + 1);
+	for (i = 0; i < sb.len; i++) {
 		if (r[i] == '\n')
 			r[i] = ' ';
+		if (r[i] == '\r') {
+			strbuf_remove(&sb, i, 1);
+			i -= 1;
+		}
+	}
+	strbuf_detach(&sb, NULL);
 
 	return r;
 }
@@ -1184,15 +1192,22 @@ static void find_subpos(const char *buf,
 		eol = strchrnul(buf, '\n');
 		if (*eol)
 			eol++;
+		/*  protect against messages that might contain \r\n */
+		if (*eol == '\r')
+			eol++;
 		buf = eol;
 	}
 	*sublen = buf - *sub;
 	/* drop trailing newline, if present */
 	if (*sublen && (*sub)[*sublen - 1] == '\n')
 		*sublen -= 1;
+	/*  protect against commit messages that might contain \r\n */
+	else if (*sublen && (*sub)[*sublen - 1] == '\r')
+		*sublen -= 3; /* drop '\r\n\r' */
 
 	/* skip any empty lines */
-	while (*buf == '\n')
+	/* and protect against commit messages that might contain \r\n */
+	while (*buf == '\n' || *buf == '\r')
 		buf++;
 	*body = buf;
 	*bodylen = strlen(buf);
diff --git a/t/t3203-branch-output.sh b/t/t3203-branch-output.sh
index 71818b90f00..1235089619c 100755
--- a/t/t3203-branch-output.sh
+++ b/t/t3203-branch-output.sh
@@ -3,13 +3,11 @@
 test_description='git branch display tests'
 . ./test-lib.sh
 . "$TEST_DIRECTORY"/lib-terminal.sh
+. "$TEST_DIRECTORY"/lib-crlf-messages.sh
 
 test_expect_success 'make commits' '
-	echo content >file &&
-	git add file &&
-	git commit -m one &&
-	echo content >>file &&
-	git commit -a -m two
+	test_commit one &&
+	test_commit two
 '
 
 test_expect_success 'make branches' '
@@ -95,6 +93,24 @@ test_expect_success 'git branch --ignore-case --list -v pattern shows branch sum
 	awk "{print \$NF}" <tmp >actual &&
 	test_cmp expect actual
 '
+test_create_crlf_refs
+
+test_expect_success 'git branch -v works with CRLF input' '
+	cat >expect <<-EOF &&
+	  branch-one                     139b20d two
+	  branch-two                     d79ce16 one
+	  crlf                           2113b0e Subject first line
+	  crlf-empty-lines-after-subject 0a9530d Subject first line
+	  crlf-two-line-subject          f9ded1f Subject first line Subject second line
+	* master                         139b20d two
+	EOF
+	git branch -v >actual &&
+	test_cmp expect actual
+'
+
+test_crlf_subject_body_and_contents branch --list crlf*
+
+test_cleanup_crlf_refs
 
 test_expect_success 'git branch -v pattern does not show branch summaries' '
 	test_must_fail git branch -v branch*
diff --git a/t/t6300-for-each-ref.sh b/t/t6300-for-each-ref.sh
index 9c910ce7467..467924de3df 100755
--- a/t/t6300-for-each-ref.sh
+++ b/t/t6300-for-each-ref.sh
@@ -8,6 +8,7 @@ test_description='for-each-ref test'
 . ./test-lib.sh
 . "$TEST_DIRECTORY"/lib-gpg.sh
 . "$TEST_DIRECTORY"/lib-terminal.sh
+. "$TEST_DIRECTORY"/lib-crlf-messages.sh
 
 # Mon Jul 3 23:18:43 2006 +0000
 datestamp=1151968723
@@ -888,4 +889,8 @@ test_expect_success 'for-each-ref --ignore-case ignores case' '
 	test_cmp expect actual
 '
 
+test_create_crlf_refs
+
+test_crlf_subject_body_and_contents for-each-ref refs/heads/crlf*
+
 test_done
diff --git a/t/t7004-tag.sh b/t/t7004-tag.sh
index 6db92bd3ba6..25f465f34ea 100755
--- a/t/t7004-tag.sh
+++ b/t/t7004-tag.sh
@@ -10,6 +10,7 @@ Tests for operations with tags.'
 . ./test-lib.sh
 . "$TEST_DIRECTORY"/lib-gpg.sh
 . "$TEST_DIRECTORY"/lib-terminal.sh
+. "$TEST_DIRECTORY"/lib-crlf-messages.sh
 
 # creating and listing lightweight tags:
 
@@ -1969,6 +1970,12 @@ test_expect_success '--format should list tags as per format given' '
 	test_cmp expect actual
 '
 
+test_create_crlf_refs
+
+test_crlf_subject_body_and_contents tag --list tag-crlf*
+
+test_cleanup_crlf_refs
+
 test_expect_success "set up color tests" '
 	echo "<RED>v1.0<RESET>" >expect.color &&
 	echo "v1.0" >expect.bare &&
-- 
gitgitgadget

