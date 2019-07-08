Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 86B8C1F4B6
	for <e@80x24.org>; Mon,  8 Jul 2019 16:38:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387848AbfGHQiP (ORCPT <rfc822;e@80x24.org>);
        Mon, 8 Jul 2019 12:38:15 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:51763 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732947AbfGHQiO (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 8 Jul 2019 12:38:14 -0400
Received: by mail-wm1-f68.google.com with SMTP id 207so181557wma.1
        for <git@vger.kernel.org>; Mon, 08 Jul 2019 09:38:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=zoIqHKw3zDEACzwLd448WaYWaae1CraA0g3v4j0IPiY=;
        b=J2p3w0s5uhIwdaFzpgrXOGsspovA7iIJ/xuqUlmoouCF5q/bcQfCRG67tWt+3vBgUU
         CYRFA1XFt89shCFf44BQxcpu/XqKTHBEive1ymoNjVfxcYxp9tMuBKPLuUq1HmxQE7i3
         ZsoXh+tkR371CkpzVm1dS0CvyUlg1c2qqn8RMzd9rGne7OrZcLbhnjTmszBsGShWl8Qr
         q3dL/i3O1Qrm9tIwKEFcZp8lhuywY/p4AWP6i06CX/sCMJTbBB4X2Qw3taKti2rc/Y7J
         +b3zkWiyyf8cb/apOTxXo86oandbeq6Tkg09RR1454v0JG9BKwJplQ1eoBzVl3VTEI88
         ug3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=zoIqHKw3zDEACzwLd448WaYWaae1CraA0g3v4j0IPiY=;
        b=esl5BwxTiSw57PNNHnrk1WjklzNB2oaEUHxfKiA/r7XVgVN7wS8oI6swUGAMFQxkgC
         /b1gKiGcv+YdEyoQsOBBcOyJ0d0K6evyzkuh581Wac9JCjFnNk9lUFH7GdzICFsSkF3u
         XFyrr8j1OUIbCi+l8rMqa8txrGpDJpA18IwNt8N9RlpyXILxdMijanDG1hFx26lrcWeE
         87orLuHawk6DF38sGG/Qd2OLm5QQ4hqiQP8qyVaeu1WiwPK+7kenqzUwocM65Vmnl4e5
         m+Ox8zYTb1zNSpb0X6qIgPx4Tl4rtmWEeRyvt3pJN8mwe429krB9ru4b32wsPn108pSB
         huww==
X-Gm-Message-State: APjAAAXKLKB8RuGncVc+SJ4aFvxmD2/Z1XXoH9QMCOSM7LXr/W5HVUF8
        431CJDVMFX9jZwZcCGC73ls0XLOq
X-Google-Smtp-Source: APXvYqxL2/xxLuwf8a+yW/b0Drw4R0lW3SpMgWP5MfKkRyT/nSGkW6cecDlo58JFBfdR9hPRLBHkCQ==
X-Received: by 2002:a1c:7ec7:: with SMTP id z190mr17135306wmc.17.1562603891156;
        Mon, 08 Jul 2019 09:38:11 -0700 (PDT)
Received: from localhost ([95.148.214.18])
        by smtp.gmail.com with ESMTPSA id g11sm14442963wru.24.2019.07.08.09.38.09
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 08 Jul 2019 09:38:10 -0700 (PDT)
From:   Thomas Gummerer <t.gummerer@gmail.com>
To:     git@vger.kernel.org
Cc:     Duy Nguyen <pclouds@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Johannes Sixt <j6t@kdbg.org>,
        Thomas Gummerer <t.gummerer@gmail.com>
Subject: [PATCH v3 14/14] range-diff: add headers to the outer hunk header
Date:   Mon,  8 Jul 2019 17:33:15 +0100
Message-Id: <20190708163315.29912-15-t.gummerer@gmail.com>
X-Mailer: git-send-email 2.22.0.510.g264f2c817a
In-Reply-To: <20190708163315.29912-1-t.gummerer@gmail.com>
References: <20190705170630.27500-1-t.gummerer@gmail.com>
 <20190708163315.29912-1-t.gummerer@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add the section headers/hunk headers we introduced in the previous
commits to the outer diff's hunk headers.  This makes it easier to
understand which change we are actually looking at.  For example an
outer hunk header might now look like:

    @@  Documentation/config/interactive.txt

while previously it would have only been

    @@

which doesn't give a lot of context for the change that follows.

For completeness also add section headers for the commit metadata and
the commit message, although they are arguably less important.

Signed-off-by: Thomas Gummerer <t.gummerer@gmail.com>
---
 range-diff.c          |  9 ++++++---
 t/t3206-range-diff.sh | 41 ++++++++++++++++++++++-------------------
 2 files changed, 28 insertions(+), 22 deletions(-)

diff --git a/range-diff.c b/range-diff.c
index 7a96a587f1..ba1e9a4265 100644
--- a/range-diff.c
+++ b/range-diff.c
@@ -139,8 +139,10 @@ static int read_patches(const char *range, struct string_list *list)
 			strbuf_addstr(&buf, " ##");
 		} else if (in_header) {
 			if (starts_with(line, "Author: ")) {
+				strbuf_addstr(&buf, " ## Metadata ##\n");
 				strbuf_addstr(&buf, line);
 				strbuf_addstr(&buf, "\n\n");
+				strbuf_addstr(&buf, " ## Commit message ##\n");
 			} else if (starts_with(line, "    ")) {
 				p = line + len - 2;
 				while (isspace(*p) && p >= line)
@@ -402,8 +404,9 @@ static void output_pair_header(struct diff_options *diffopt,
 	fwrite(buf->buf, buf->len, 1, diffopt->file);
 }
 
-static struct userdiff_driver no_func_name = {
-	.funcname = { "$^", 0 }
+static struct userdiff_driver section_headers = {
+	.funcname = { "^ ## (.*) ##$\n"
+		      "^.?@@ (.*)$", REG_EXTENDED }
 };
 
 static struct diff_filespec *get_filespec(const char *name, const char *p)
@@ -415,7 +418,7 @@ static struct diff_filespec *get_filespec(const char *name, const char *p)
 	spec->size = strlen(p);
 	spec->should_munmap = 0;
 	spec->is_stdin = 1;
-	spec->driver = &no_func_name;
+	spec->driver = &section_headers;
 
 	return spec;
 }
diff --git a/t/t3206-range-diff.sh b/t/t3206-range-diff.sh
index d4de270979..ec548654ce 100755
--- a/t/t3206-range-diff.sh
+++ b/t/t3206-range-diff.sh
@@ -99,7 +99,7 @@ test_expect_success 'changed commit' '
 	1:  4de457d = 1:  a4b3333 s/5/A/
 	2:  fccce22 = 2:  f51d370 s/4/A/
 	3:  147e64e ! 3:  0559556 s/11/B/
-	    @@
+	    @@ file: A
 	      9
 	      10
 	     -11
@@ -109,7 +109,7 @@ test_expect_success 'changed commit' '
 	      13
 	      14
 	4:  a63e992 ! 4:  d966c5c s/12/B/
-	    @@
+	    @@ file
 	     @@ file: A
 	      9
 	      10
@@ -158,7 +158,7 @@ test_expect_success 'changed commit with sm config' '
 	1:  4de457d = 1:  a4b3333 s/5/A/
 	2:  fccce22 = 2:  f51d370 s/4/A/
 	3:  147e64e ! 3:  0559556 s/11/B/
-	    @@
+	    @@ file: A
 	      9
 	      10
 	     -11
@@ -168,7 +168,7 @@ test_expect_success 'changed commit with sm config' '
 	      13
 	      14
 	4:  a63e992 ! 4:  d966c5c s/12/B/
-	    @@
+	    @@ file
 	     @@ file: A
 	      9
 	      10
@@ -186,9 +186,10 @@ test_expect_success 'renamed file' '
 	sed s/Z/\ /g >expected <<-EOF &&
 	1:  4de457d = 1:  f258d75 s/5/A/
 	2:  fccce22 ! 2:  017b62d s/4/A/
-	    @@
+	    @@ Metadata
 	    ZAuthor: Thomas Rast <trast@inf.ethz.ch>
 	    Z
+	    Z ## Commit message ##
 	    -    s/4/A/
 	    +    s/4/A/ + rename file
 	    Z
@@ -198,8 +199,8 @@ test_expect_success 'renamed file' '
 	    Z 1
 	    Z 2
 	3:  147e64e ! 3:  3ce7af6 s/11/B/
-	    @@
-	    Z
+	    @@ Metadata
+	    Z ## Commit message ##
 	    Z    s/11/B/
 	    Z
 	    - ## file ##
@@ -210,8 +211,8 @@ test_expect_success 'renamed file' '
 	    Z 9
 	    Z 10
 	4:  a63e992 ! 4:  1e6226b s/12/B/
-	    @@
-	    Z
+	    @@ Metadata
+	    Z ## Commit message ##
 	    Z    s/12/B/
 	    Z
 	    - ## file ##
@@ -230,30 +231,32 @@ test_expect_success 'file added and later removed' '
 	sed s/Z/\ /g >expected <<-EOF &&
 	1:  4de457d = 1:  096b1ba s/5/A/
 	2:  fccce22 ! 2:  d92e698 s/4/A/
-	    @@
+	    @@ Metadata
 	    ZAuthor: Thomas Rast <trast@inf.ethz.ch>
 	    Z
+	    Z ## Commit message ##
 	    -    s/4/A/
 	    +    s/4/A/ + new-file
 	    Z
 	    Z ## file ##
 	    Z@@
-	    @@
+	    @@ file
 	    Z A
 	    Z 6
 	    Z 7
 	    +
 	    + ## new-file (new) ##
 	3:  147e64e ! 3:  9a1db4d s/11/B/
-	    @@
+	    @@ Metadata
 	    ZAuthor: Thomas Rast <trast@inf.ethz.ch>
 	    Z
+	    Z ## Commit message ##
 	    -    s/11/B/
 	    +    s/11/B/ + remove file
 	    Z
 	    Z ## file ##
 	    Z@@ file: A
-	    @@
+	    @@ file: A
 	    Z 12
 	    Z 13
 	    Z 14
@@ -274,8 +277,8 @@ test_expect_success 'changed message' '
 	sed s/Z/\ /g >expected <<-EOF &&
 	1:  4de457d = 1:  f686024 s/5/A/
 	2:  fccce22 ! 2:  4ab067d s/4/A/
-	    @@
-	    Z
+	    @@ Metadata
+	    Z ## Commit message ##
 	    Z    s/4/A/
 	    Z
 	    +    Also a silly comment here!
@@ -293,8 +296,8 @@ test_expect_success 'dual-coloring' '
 	sed -e "s|^:||" >expect <<-\EOF &&
 	:<YELLOW>1:  a4b3333 = 1:  f686024 s/5/A/<RESET>
 	:<RED>2:  f51d370 <RESET><YELLOW>!<RESET><GREEN> 2:  4ab067d<RESET><YELLOW> s/4/A/<RESET>
-	:    <REVERSE><CYAN>@@<RESET>
-	:     <RESET>
+	:    <REVERSE><CYAN>@@<RESET> <RESET>Metadata<RESET>
+	:      ## Commit message ##<RESET>
 	:         s/4/A/<RESET>
 	:     <RESET>
 	:    <REVERSE><GREEN>+<RESET><BOLD>    Also a silly comment here!<RESET>
@@ -303,7 +306,7 @@ test_expect_success 'dual-coloring' '
 	:    <CYAN> @@<RESET>
 	:      1<RESET>
 	:<RED>3:  0559556 <RESET><YELLOW>!<RESET><GREEN> 3:  b9cb956<RESET><YELLOW> s/11/B/<RESET>
-	:    <REVERSE><CYAN>@@<RESET>
+	:    <REVERSE><CYAN>@@<RESET> <RESET>file: A<RESET>
 	:      9<RESET>
 	:      10<RESET>
 	:    <RED> -11<RESET>
@@ -313,7 +316,7 @@ test_expect_success 'dual-coloring' '
 	:      13<RESET>
 	:      14<RESET>
 	:<RED>4:  d966c5c <RESET><YELLOW>!<RESET><GREEN> 4:  8add5f1<RESET><YELLOW> s/12/B/<RESET>
-	:    <REVERSE><CYAN>@@<RESET>
+	:    <REVERSE><CYAN>@@<RESET> <RESET>file<RESET>
 	:    <CYAN> @@ file: A<RESET>
 	:      9<RESET>
 	:      10<RESET>
-- 
2.22.0.510.g264f2c817a

