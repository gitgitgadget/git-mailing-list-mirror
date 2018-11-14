Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0DDD31F87F
	for <e@80x24.org>; Wed, 14 Nov 2018 22:28:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729127AbeKOIdi (ORCPT <rfc822;e@80x24.org>);
        Thu, 15 Nov 2018 03:33:38 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:51149 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728609AbeKOIdi (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Nov 2018 03:33:38 -0500
Received: by mail-wm1-f65.google.com with SMTP id 124-v6so17075878wmw.0
        for <git@vger.kernel.org>; Wed, 14 Nov 2018 14:28:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=R7O9/RWL9EZ8yyq1N+k4dQoxU8DwClHo+tqRSisLEjs=;
        b=eXNLp6YA7CIaqQ6qPqztX7lkRxPMV0ZN4K8IJD/9W2l1+ASnbjOFtyw23sMMyxSo7K
         xYuguCEoHVxU5yA/V3cVoxXy6eNp1znB+4A9/xbXftxoEmiPr8cPvJVYy0q4I4JE3P03
         eypHZsMP2/p5+tLdd8gWEcHWPS5/8xCzctU9TXwFeOHYxmmsmQjDEQCmYndAlSdT1c6w
         vABU9nq0V5BJsooWBNYth+2x2OiEkOCCqHl3nKxlk8J+4HndsrmrhfJwu+jgh2Hz0NCF
         VNuMVvwDzePiQPyBsY1QirHbRBsEvEXLcQyQQCGUU4A7+W7juZn1Z4VoGnnwQQJPLOQL
         xtTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=R7O9/RWL9EZ8yyq1N+k4dQoxU8DwClHo+tqRSisLEjs=;
        b=PrT0TMXWg5Su0W/2R9M2s6qUhytk1X6QIipnzhoMHPMC4u8CHoaKAB7+YXtM6p4sgW
         p6j5sotfvJ1V5fIqPfe/5w/KroEtzb9WCRFhcuEKhT8WRQKb02RvD3y3m+bjLbCAZ5EY
         PIpfXJnPQ5ZDdoQUFCICsd8yB8fwjwc9yhm9pPZbGO17GABp+eEamu2L6n6rI+5v24Au
         ZauWotETf2gDFmWytYM4UU9wbscGqlfiSFLuUXt1cee4MH9iy7MkPQjPnP891FL/ZK6a
         IOWnwfBlpEI3SwgM78TNj3CSVdBgTNEP5KQJimGnakEvTdRS9owgjwsBXi+059r6IP4Y
         ISdA==
X-Gm-Message-State: AGRZ1gKpJZcb2hig4OnFoRPlnrytssMMOUeS34zWJhaK+eL8QMTBFiz9
        DMmimiLMweGZfI4K+Xf7A2k=
X-Google-Smtp-Source: AJdET5fDGCX7yNsc7ck7d0vexDq9Zu6bwZK6OiBuowHp3YIMMdiPIpgZDXjN8SGA3xjF2mMTDD4plg==
X-Received: by 2002:a7b:c191:: with SMTP id y17mr3411205wmi.10.1542234511308;
        Wed, 14 Nov 2018 14:28:31 -0800 (PST)
Received: from localhost.localdomain ([31.223.156.217])
        by smtp.gmail.com with ESMTPSA id b66-v6sm13978871wmb.21.2018.11.14.14.28.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 14 Nov 2018 14:28:30 -0800 (PST)
From:   Slavica Djukic <slavicadj.ip2018@gmail.com>
X-Google-Original-From: Slavica Djukic <slawica92@hotmail.com>
To:     slavicadj.ip2018@gmail.com
Cc:     Johannes.Schindelin@gmx.de, git@vger.kernel.org,
        slawica92@hotmail.com, Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 2/2] [Outreachy] stash: tolerate missing user identity
Date:   Wed, 14 Nov 2018 23:28:02 +0100
Message-Id: <20181114222802.10928-1-slawica92@hotmail.com>
X-Mailer: git-send-email 2.19.1.1052.gd166e6afe
In-Reply-To: <20181114221218.3112-1-slawica92@hotmail.com>
References: <20181114221218.3112-1-slawica92@hotmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The "git stash" command insists on having a usable user identity to
the same degree as the "git commit-tree" and "git commit" commands
do, because it uses the same codepath that creates commit objects
as these commands.

It is not strictly necesary to do so.  Check if we will barf before
creating commit objects and then supply fake identity to please the
machinery that creates commits.

This is not that much of usability improvement, as the users who run
"git stash" would eventually want to record their changes that are
temporarily stored in the stashes in a more permanent history by
committing, and they must do "git config user.{name,email}" at that
point anyway, so arguably this change is only delaying a step that
is necessary to work in the repository.

Helped-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Slavica Djukic <slawica92@hotmail.com>
---
 git-stash.sh     | 17 +++++++++++++++++
 t/t3903-stash.sh |  2 +-
 2 files changed, 18 insertions(+), 1 deletion(-)

diff --git a/git-stash.sh b/git-stash.sh
index 94793c1a9..789ce2f41 100755
--- a/git-stash.sh
+++ b/git-stash.sh
@@ -55,6 +55,20 @@ untracked_files () {
 	git ls-files -o $z $excl_opt -- "$@"
 }
 
+prepare_fallback_ident () {
+	if ! git -c user.useconfigonly=yes var GIT_COMMITTER_IDENT >/dev/null 2>&1
+	then
+		GIT_AUTHOR_NAME="git stash"
+		GIT_AUTHOR_EMAIL=git@stash
+		GIT_COMMITTER_NAME="git stash"
+		GIT_COMMITTER_EMAIL=git@stash
+		export GIT_AUTHOR_NAME
+		export GIT_AUTHOR_EMAIL
+		export GIT_COMMITTER_NAME
+		export GIT_COMMITTER_EMAIL
+	fi
+}
+
 clear_stash () {
 	if test $# != 0
 	then
@@ -67,6 +81,9 @@ clear_stash () {
 }
 
 create_stash () {
+
+	prepare_fallback_ident
+
 	stash_msg=
 	untracked=
 	while test $# != 0
diff --git a/t/t3903-stash.sh b/t/t3903-stash.sh
index bab8bec67..0b0814421 100755
--- a/t/t3903-stash.sh
+++ b/t/t3903-stash.sh
@@ -1096,7 +1096,7 @@ test_expect_success 'stash -- <subdir> works with binary files' '
 	test_path_is_file subdir/untracked
 '
 
-test_expect_failure 'stash works when user.name and user.email are not set' '
+test_expect_success 'stash works when user.name and user.email are not set' '
 	git reset &&
 	git var GIT_COMMITTER_IDENT >expected &&
 	>1 &&
-- 
2.19.1.1052.gd166e6afe

