Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 627D11F516
	for <e@80x24.org>; Mon,  2 Jul 2018 00:25:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753014AbeGBAZ1 (ORCPT <rfc822;e@80x24.org>);
        Sun, 1 Jul 2018 20:25:27 -0400
Received: from mail-it0-f66.google.com ([209.85.214.66]:52637 "EHLO
        mail-it0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752844AbeGBAZO (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 1 Jul 2018 20:25:14 -0400
Received: by mail-it0-f66.google.com with SMTP id p4-v6so9879074itf.2
        for <git@vger.kernel.org>; Sun, 01 Jul 2018 17:25:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Q+TO868PCFQ+7SvfFCEUduNyB4PoG1kZh04mVqRA0XE=;
        b=QOSSamogg4MiXO06mqqKr67d5m25yGXddXqvrWX+6JnHEHcZDuV4vvl+ZQKLOYQJZd
         VApKUcA4lybUUPTjMWgMcx+MDd5zV5YHA9yqrJdgcBNJB+zMRTPSlKq5I+o2EsHrJiyA
         GXdVqEBZHnWKUyDDWEhimxMiF6YheMPSGXOrxPkTC3XfnrxU5bOoi89LuRaoZ3kafe8U
         WJphrTMvVvejZZXnYR/lhcSs9bqrOc0m/VC8m/ZF4sMyyXQgGCIdyx2GKewcqyu5A6+U
         iZdyE+Je7MuQBTS3rUMabvWqA9dA7vT9jWUPHcgdJEDn2t3nVUDVZHhAboqfZB7m1imY
         z4cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references;
        bh=Q+TO868PCFQ+7SvfFCEUduNyB4PoG1kZh04mVqRA0XE=;
        b=hxQuDCKsfZg1UfG7IUkyldEAEP8Gb57wm84LaAYrcPQJy668DAr6Jz3ZmHZugUbEBS
         5bSTJHHaMxFYibjHkJvrVVxnRXEYV2OzZ9n2nHJ+9qpZoY/MuoK1ooQmKZw65T5MvyVN
         R9e6cCQwdva+9ZAoAc2NBfNtCLx34LI7jMVnRXy4IHbnMpVKFc1UT82/Fy+lMewjhahl
         ONID14NgwtAPShHInGtz5bZFfJBDAubNHj5XZ3oEb2HZslGx2ptXdsCDAXL81ydQyzkL
         vTQkThQGkErVVJEUztPkqD327ead0K6ZB+jTSDtmvRG5eUS5hLCnzD3x1WlDTLIiYtoN
         7+Jg==
X-Gm-Message-State: APt69E3qkhoB2iQY6mrEwRJj/aUBbofsCdhelY7F9UXSxDA2h+X7naVd
        jy1xn0Btr12L/NJbVG+jlUaLtA==
X-Google-Smtp-Source: AAOMgpfospUO3yhPW1LEPw0boGmwKYogbuysKOpzqrJx/L517bpuwWVCMxWpS30kvALEwl6b2lIbZg==
X-Received: by 2002:a24:214d:: with SMTP id e74-v6mr4235972ita.91.1530491113738;
        Sun, 01 Jul 2018 17:25:13 -0700 (PDT)
Received: from localhost.localdomain (user-12l2cs3.cable.mindspring.com. [69.81.51.131])
        by smtp.gmail.com with ESMTPSA id o143-v6sm3302562itb.42.2018.07.01.17.25.12
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Sun, 01 Jul 2018 17:25:13 -0700 (PDT)
From:   Eric Sunshine <sunshine@sunshineco.com>
To:     git@vger.kernel.org
Cc:     Elijah Newren <newren@gmail.com>, Johannes Sixt <j6t@kdbg.org>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Stefan Beller <sbeller@google.com>,
        Junio C Hamano <gitster@pobox.com>,
        Luke Diamand <luke@diamand.org>, Jeff King <peff@peff.net>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH 25/25] t9119: fix broken &&-chains
Date:   Sun,  1 Jul 2018 20:24:05 -0400
Message-Id: <20180702002405.3042-26-sunshine@sunshineco.com>
X-Mailer: git-send-email 2.18.0.203.gfac676dfb9
In-Reply-To: <20180702002405.3042-1-sunshine@sunshineco.com>
References: <20180702002405.3042-1-sunshine@sunshineco.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Eric Sunshine <sunshine@sunshineco.com>
---
 t/t9119-git-svn-info.sh | 120 ++++++++++++++++++++--------------------
 1 file changed, 60 insertions(+), 60 deletions(-)

diff --git a/t/t9119-git-svn-info.sh b/t/t9119-git-svn-info.sh
index 88241baee3..8201c3e808 100755
--- a/t/t9119-git-svn-info.sh
+++ b/t/t9119-git-svn-info.sh
@@ -22,8 +22,8 @@ esac
 # same value as "svn info" (i.e. the commit timestamp that touched the
 # path most recently); do not expect that field to match.
 test_cmp_info () {
-	sed -e '/^Text Last Updated:/d' "$1" >tmp.expect
-	sed -e '/^Text Last Updated:/d' "$2" >tmp.actual
+	sed -e '/^Text Last Updated:/d' "$1" >tmp.expect &&
+	sed -e '/^Text Last Updated:/d' "$2" >tmp.actual &&
 	test_cmp tmp.expect tmp.actual &&
 	rm -f tmp.expect tmp.actual
 }
@@ -59,24 +59,24 @@ test_expect_success 'setup repository and import' '
 	'
 
 test_expect_success 'info' "
-	(cd svnwc; svn info) > expected.info &&
-	(cd gitwc; git svn info) > actual.info &&
+	(cd svnwc && svn info) > expected.info &&
+	(cd gitwc && git svn info) > actual.info &&
 	test_cmp_info expected.info actual.info
 	"
 
 test_expect_success 'info --url' '
-	test "$(cd gitwc; git svn info --url)" = "$quoted_svnrepo"
+	test "$(cd gitwc && git svn info --url)" = "$quoted_svnrepo"
 	'
 
 test_expect_success 'info .' "
-	(cd svnwc; svn info .) > expected.info-dot &&
-	(cd gitwc; git svn info .) > actual.info-dot &&
+	(cd svnwc && svn info .) > expected.info-dot &&
+	(cd gitwc && git svn info .) > actual.info-dot &&
 	test_cmp_info expected.info-dot actual.info-dot
 	"
 
 test_expect_success 'info $(pwd)' '
-	(cd svnwc; svn info "$(pwd)") >expected.info-pwd &&
-	(cd gitwc; git svn info "$(pwd)") >actual.info-pwd &&
+	(cd svnwc && svn info "$(pwd)") >expected.info-pwd &&
+	(cd gitwc && git svn info "$(pwd)") >actual.info-pwd &&
 	grep -v ^Path: <expected.info-pwd >expected.info-np &&
 	grep -v ^Path: <actual.info-pwd >actual.info-np &&
 	test_cmp_info expected.info-np actual.info-np &&
@@ -85,8 +85,8 @@ test_expect_success 'info $(pwd)' '
 	'
 
 test_expect_success 'info $(pwd)/../___wc' '
-	(cd svnwc; svn info "$(pwd)/../svnwc") >expected.info-pwd &&
-	(cd gitwc; git svn info "$(pwd)/../gitwc") >actual.info-pwd &&
+	(cd svnwc && svn info "$(pwd)/../svnwc") >expected.info-pwd &&
+	(cd gitwc && git svn info "$(pwd)/../gitwc") >actual.info-pwd &&
 	grep -v ^Path: <expected.info-pwd >expected.info-np &&
 	grep -v ^Path: <actual.info-pwd >actual.info-np &&
 	test_cmp_info expected.info-np actual.info-np &&
@@ -95,8 +95,8 @@ test_expect_success 'info $(pwd)/../___wc' '
 	'
 
 test_expect_success 'info $(pwd)/../___wc//file' '
-	(cd svnwc; svn info "$(pwd)/../svnwc//file") >expected.info-pwd &&
-	(cd gitwc; git svn info "$(pwd)/../gitwc//file") >actual.info-pwd &&
+	(cd svnwc && svn info "$(pwd)/../svnwc//file") >expected.info-pwd &&
+	(cd gitwc && git svn info "$(pwd)/../gitwc//file") >actual.info-pwd &&
 	grep -v ^Path: <expected.info-pwd >expected.info-np &&
 	grep -v ^Path: <actual.info-pwd >actual.info-np &&
 	test_cmp_info expected.info-np actual.info-np &&
@@ -105,56 +105,56 @@ test_expect_success 'info $(pwd)/../___wc//file' '
 	'
 
 test_expect_success 'info --url .' '
-	test "$(cd gitwc; git svn info --url .)" = "$quoted_svnrepo"
+	test "$(cd gitwc && git svn info --url .)" = "$quoted_svnrepo"
 	'
 
 test_expect_success 'info file' "
-	(cd svnwc; svn info file) > expected.info-file &&
-	(cd gitwc; git svn info file) > actual.info-file &&
+	(cd svnwc && svn info file) > expected.info-file &&
+	(cd gitwc && git svn info file) > actual.info-file &&
 	test_cmp_info expected.info-file actual.info-file
 	"
 
 test_expect_success 'info --url file' '
-	test "$(cd gitwc; git svn info --url file)" = "$quoted_svnrepo/file"
+	test "$(cd gitwc && git svn info --url file)" = "$quoted_svnrepo/file"
 	'
 
 test_expect_success 'info directory' "
-	(cd svnwc; svn info directory) > expected.info-directory &&
-	(cd gitwc; git svn info directory) > actual.info-directory &&
+	(cd svnwc && svn info directory) > expected.info-directory &&
+	(cd gitwc && git svn info directory) > actual.info-directory &&
 	test_cmp_info expected.info-directory actual.info-directory
 	"
 
 test_expect_success 'info inside directory' "
-	(cd svnwc/directory; svn info) > expected.info-inside-directory &&
-	(cd gitwc/directory; git svn info) > actual.info-inside-directory &&
+	(cd svnwc/directory && svn info) > expected.info-inside-directory &&
+	(cd gitwc/directory && git svn info) > actual.info-inside-directory &&
 	test_cmp_info expected.info-inside-directory actual.info-inside-directory
 	"
 
 test_expect_success 'info --url directory' '
-	test "$(cd gitwc; git svn info --url directory)" = "$quoted_svnrepo/directory"
+	test "$(cd gitwc && git svn info --url directory)" = "$quoted_svnrepo/directory"
 	'
 
 test_expect_success 'info symlink-file' "
-	(cd svnwc; svn info symlink-file) > expected.info-symlink-file &&
-	(cd gitwc; git svn info symlink-file) > actual.info-symlink-file &&
+	(cd svnwc && svn info symlink-file) > expected.info-symlink-file &&
+	(cd gitwc && git svn info symlink-file) > actual.info-symlink-file &&
 	test_cmp_info expected.info-symlink-file actual.info-symlink-file
 	"
 
 test_expect_success 'info --url symlink-file' '
-	test "$(cd gitwc; git svn info --url symlink-file)" \
+	test "$(cd gitwc && git svn info --url symlink-file)" \
 	     = "$quoted_svnrepo/symlink-file"
 	'
 
 test_expect_success 'info symlink-directory' "
-	(cd svnwc; svn info symlink-directory) \
+	(cd svnwc && svn info symlink-directory) \
 		> expected.info-symlink-directory &&
-	(cd gitwc; git svn info symlink-directory) \
+	(cd gitwc && git svn info symlink-directory) \
 		> actual.info-symlink-directory &&
 	test_cmp_info expected.info-symlink-directory actual.info-symlink-directory
 	"
 
 test_expect_success 'info --url symlink-directory' '
-	test "$(cd gitwc; git svn info --url symlink-directory)" \
+	test "$(cd gitwc && git svn info --url symlink-directory)" \
 	     = "$quoted_svnrepo/symlink-directory"
 	'
 
@@ -169,13 +169,13 @@ test_expect_success 'info added-file' "
 		cd svnwc &&
 		svn_cmd add added-file > /dev/null
 	) &&
-	(cd svnwc; svn info added-file) > expected.info-added-file &&
-	(cd gitwc; git svn info added-file) > actual.info-added-file &&
+	(cd svnwc && svn info added-file) > expected.info-added-file &&
+	(cd gitwc && git svn info added-file) > actual.info-added-file &&
 	test_cmp_info expected.info-added-file actual.info-added-file
 	"
 
 test_expect_success 'info --url added-file' '
-	test "$(cd gitwc; git svn info --url added-file)" \
+	test "$(cd gitwc && git svn info --url added-file)" \
 	     = "$quoted_svnrepo/added-file"
 	'
 
@@ -190,15 +190,15 @@ test_expect_success 'info added-directory' "
 		cd gitwc &&
 		git add added-directory
 	) &&
-	(cd svnwc; svn info added-directory) \
+	(cd svnwc && svn info added-directory) \
 		> expected.info-added-directory &&
-	(cd gitwc; git svn info added-directory) \
+	(cd gitwc && git svn info added-directory) \
 		> actual.info-added-directory &&
 	test_cmp_info expected.info-added-directory actual.info-added-directory
 	"
 
 test_expect_success 'info --url added-directory' '
-	test "$(cd gitwc; git svn info --url added-directory)" \
+	test "$(cd gitwc && git svn info --url added-directory)" \
 	     = "$quoted_svnrepo/added-directory"
 	'
 
@@ -213,16 +213,16 @@ test_expect_success 'info added-symlink-file' "
 		ln -s added-file added-symlink-file &&
 		svn_cmd add added-symlink-file > /dev/null
 	) &&
-	(cd svnwc; svn info added-symlink-file) \
+	(cd svnwc && svn info added-symlink-file) \
 		> expected.info-added-symlink-file &&
-	(cd gitwc; git svn info added-symlink-file) \
+	(cd gitwc && git svn info added-symlink-file) \
 		> actual.info-added-symlink-file &&
 	test_cmp_info expected.info-added-symlink-file \
 		actual.info-added-symlink-file
 	"
 
 test_expect_success 'info --url added-symlink-file' '
-	test "$(cd gitwc; git svn info --url added-symlink-file)" \
+	test "$(cd gitwc && git svn info --url added-symlink-file)" \
 	     = "$quoted_svnrepo/added-symlink-file"
 	'
 
@@ -237,16 +237,16 @@ test_expect_success 'info added-symlink-directory' "
 		ln -s added-directory added-symlink-directory &&
 		svn_cmd add added-symlink-directory > /dev/null
 	) &&
-	(cd svnwc; svn info added-symlink-directory) \
+	(cd svnwc && svn info added-symlink-directory) \
 		> expected.info-added-symlink-directory &&
-	(cd gitwc; git svn info added-symlink-directory) \
+	(cd gitwc && git svn info added-symlink-directory) \
 		> actual.info-added-symlink-directory &&
 	test_cmp_info expected.info-added-symlink-directory \
 		actual.info-added-symlink-directory
 	"
 
 test_expect_success 'info --url added-symlink-directory' '
-	test "$(cd gitwc; git svn info --url added-symlink-directory)" \
+	test "$(cd gitwc && git svn info --url added-symlink-directory)" \
 	     = "$quoted_svnrepo/added-symlink-directory"
 	'
 
@@ -259,13 +259,13 @@ test_expect_success 'info deleted-file' "
 		cd svnwc &&
 		svn_cmd rm --force file > /dev/null
 	) &&
-	(cd svnwc; svn info file) >expected.info-deleted-file &&
-	(cd gitwc; git svn info file) >actual.info-deleted-file &&
+	(cd svnwc && svn info file) >expected.info-deleted-file &&
+	(cd gitwc && git svn info file) >actual.info-deleted-file &&
 	test_cmp_info expected.info-deleted-file actual.info-deleted-file
 	"
 
 test_expect_success 'info --url file (deleted)' '
-	test "$(cd gitwc; git svn info --url file)" \
+	test "$(cd gitwc && git svn info --url file)" \
 	     = "$quoted_svnrepo/file"
 	'
 
@@ -278,13 +278,13 @@ test_expect_success 'info deleted-directory' "
 		cd svnwc &&
 		svn_cmd rm --force directory > /dev/null
 	) &&
-	(cd svnwc; svn info directory) >expected.info-deleted-directory &&
-	(cd gitwc; git svn info directory) >actual.info-deleted-directory &&
+	(cd svnwc && svn info directory) >expected.info-deleted-directory &&
+	(cd gitwc && git svn info directory) >actual.info-deleted-directory &&
 	test_cmp_info expected.info-deleted-directory actual.info-deleted-directory
 	"
 
 test_expect_success 'info --url directory (deleted)' '
-	test "$(cd gitwc; git svn info --url directory)" \
+	test "$(cd gitwc && git svn info --url directory)" \
 	     = "$quoted_svnrepo/directory"
 	'
 
@@ -297,13 +297,13 @@ test_expect_success 'info deleted-symlink-file' "
 		cd svnwc &&
 		svn_cmd rm --force symlink-file > /dev/null
 	) &&
-	(cd svnwc; svn info symlink-file) >expected.info-deleted-symlink-file &&
-	(cd gitwc; git svn info symlink-file) >actual.info-deleted-symlink-file &&
+	(cd svnwc && svn info symlink-file) >expected.info-deleted-symlink-file &&
+	(cd gitwc && git svn info symlink-file) >actual.info-deleted-symlink-file &&
 	test_cmp_info expected.info-deleted-symlink-file actual.info-deleted-symlink-file
 	"
 
 test_expect_success 'info --url symlink-file (deleted)' '
-	test "$(cd gitwc; git svn info --url symlink-file)" \
+	test "$(cd gitwc && git svn info --url symlink-file)" \
 	     = "$quoted_svnrepo/symlink-file"
 	'
 
@@ -316,13 +316,13 @@ test_expect_success 'info deleted-symlink-directory' "
 		cd svnwc &&
 		svn_cmd rm --force symlink-directory > /dev/null
 	) &&
-	(cd svnwc; svn info symlink-directory) >expected.info-deleted-symlink-directory &&
-	(cd gitwc; git svn info symlink-directory) >actual.info-deleted-symlink-directory &&
+	(cd svnwc && svn info symlink-directory) >expected.info-deleted-symlink-directory &&
+	(cd gitwc && git svn info symlink-directory) >actual.info-deleted-symlink-directory &&
 	test_cmp_info expected.info-deleted-symlink-directory actual.info-deleted-symlink-directory
 	"
 
 test_expect_success 'info --url symlink-directory (deleted)' '
-	test "$(cd gitwc; git svn info --url symlink-directory)" \
+	test "$(cd gitwc && git svn info --url symlink-directory)" \
 	     = "$quoted_svnrepo/symlink-directory"
 	'
 
@@ -331,27 +331,27 @@ test_expect_success 'info --url symlink-directory (deleted)' '
 
 test_expect_success 'info unknown-file' "
 	echo two > gitwc/unknown-file &&
-	(cd gitwc; test_must_fail git svn info unknown-file) \
+	(cd gitwc && test_must_fail git svn info unknown-file) \
 		 2> actual.info-unknown-file &&
 	grep unknown-file actual.info-unknown-file
 	"
 
 test_expect_success 'info --url unknown-file' '
 	echo two > gitwc/unknown-file &&
-	(cd gitwc; test_must_fail git svn info --url unknown-file) \
+	(cd gitwc && test_must_fail git svn info --url unknown-file) \
 		 2> actual.info-url-unknown-file &&
 	grep unknown-file actual.info-url-unknown-file
 	'
 
 test_expect_success 'info unknown-directory' "
 	mkdir gitwc/unknown-directory svnwc/unknown-directory &&
-	(cd gitwc; test_must_fail git svn info unknown-directory) \
+	(cd gitwc && test_must_fail git svn info unknown-directory) \
 		 2> actual.info-unknown-directory &&
 	grep unknown-directory actual.info-unknown-directory
 	"
 
 test_expect_success 'info --url unknown-directory' '
-	(cd gitwc; test_must_fail git svn info --url unknown-directory) \
+	(cd gitwc && test_must_fail git svn info --url unknown-directory) \
 		 2> actual.info-url-unknown-directory &&
 	grep unknown-directory actual.info-url-unknown-directory
 	'
@@ -361,13 +361,13 @@ test_expect_success 'info unknown-symlink-file' "
 		cd gitwc &&
 		ln -s unknown-file unknown-symlink-file
 	) &&
-	(cd gitwc; test_must_fail git svn info unknown-symlink-file) \
+	(cd gitwc && test_must_fail git svn info unknown-symlink-file) \
 		 2> actual.info-unknown-symlink-file &&
 	grep unknown-symlink-file actual.info-unknown-symlink-file
 	"
 
 test_expect_success 'info --url unknown-symlink-file' '
-	(cd gitwc; test_must_fail git svn info --url unknown-symlink-file) \
+	(cd gitwc && test_must_fail git svn info --url unknown-symlink-file) \
 		 2> actual.info-url-unknown-symlink-file &&
 	grep unknown-symlink-file actual.info-url-unknown-symlink-file
 	'
@@ -377,13 +377,13 @@ test_expect_success 'info unknown-symlink-directory' "
 		cd gitwc &&
 		ln -s unknown-directory unknown-symlink-directory
 	) &&
-	(cd gitwc; test_must_fail git svn info unknown-symlink-directory) \
+	(cd gitwc && test_must_fail git svn info unknown-symlink-directory) \
 		 2> actual.info-unknown-symlink-directory &&
 	grep unknown-symlink-directory actual.info-unknown-symlink-directory
 	"
 
 test_expect_success 'info --url unknown-symlink-directory' '
-	(cd gitwc; test_must_fail git svn info --url unknown-symlink-directory) \
+	(cd gitwc && test_must_fail git svn info --url unknown-symlink-directory) \
 		 2> actual.info-url-unknown-symlink-directory &&
 	grep unknown-symlink-directory actual.info-url-unknown-symlink-directory
 	'
-- 
2.18.0.203.gfac676dfb9

