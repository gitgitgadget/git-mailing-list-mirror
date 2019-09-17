Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 44E641F463
	for <e@80x24.org>; Tue, 17 Sep 2019 16:35:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730432AbfIQQfN (ORCPT <rfc822;e@80x24.org>);
        Tue, 17 Sep 2019 12:35:13 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:39537 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728841AbfIQQfN (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 17 Sep 2019 12:35:13 -0400
Received: by mail-pl1-f196.google.com with SMTP id x6so275175plv.6
        for <git@vger.kernel.org>; Tue, 17 Sep 2019 09:35:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=SCZ3PSZYYyA65ldei1eY7ScBVSEwKNnN5LtAJ4Vwb0E=;
        b=kWvHx38q4uGm7vXgVOqjh+h6XhLKtYmJJ7FUS0s6jvMDpY0Ou1rIaVMMFFyvjVE1lm
         vcoBRcE1E6SSoRCLYAVRSB32mKxv9h7N8+q82Bhl6bCSGH+llzIYDPH+nCltt2PG4FUn
         AiI5r+9nZF1z86y02Yef1JsZmUh8uK5NiHpoDCPowxuQukTT1uuExf+/2z/ZON/o+02p
         JkngteGbYbD2hnAbewqC41PwnqoKlByGKh4lW0aQsBFPoXa1axE2VBLJuHUJ+3pumMTf
         4P8mO83BC0N188lHIQOebvNy1ilLgglwyKlg9FbuMYwXZQRdHcXxguBa6RWonVnBPgtS
         JS9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=SCZ3PSZYYyA65ldei1eY7ScBVSEwKNnN5LtAJ4Vwb0E=;
        b=L1BAmQB7hoWeu9+LJLeqDTrbR/B3MTEbE6Pzc80TgN9Ggv4yDX+Sr3fI1c6ZtzFQOR
         UUxZrDbOaGL3jerZgRBBXF/SXhuUah49nN42acRQwR0sy5UJ/Y29qN0tmJ1WAy8UxAkU
         97zqqZ/eXdevDtDT9hrMSnDF9N++SuiIDikVyJKfC1AXTkdC4i19MErRsLVb+byC8Clf
         /2f5F4M3d4PJfL9mq8RUBdrriTah1gelZQf12+CXfZsraHf71bk6QpTXHqMX+8Tp2F7D
         zWZC4LybLy7R5NcIYE7YM7AgnUlJgn9dNAh/WTCwmPaqrHb2a2HreUbQlltVlz9wPQNa
         SQvA==
X-Gm-Message-State: APjAAAVBFM2V+vodIIIfVKMcmbditDkXta4qquRWvqZ6nlopNT6X22Bq
        KZHUEJMylps3gBrsMIx5Gad76opb+KE=
X-Google-Smtp-Source: APXvYqzNj62nEaidrO9/AQK0/YbOtQdvLAu70w6FOIq7Eknsjfz9M6hkrAPDIxMXgZKwPgx74sAReA==
X-Received: by 2002:a17:902:bb92:: with SMTP id m18mr4568067pls.153.1568738112262;
        Tue, 17 Sep 2019 09:35:12 -0700 (PDT)
Received: from newren2-linux.yojoe.local ([8.4.231.67])
        by smtp.gmail.com with ESMTPSA id s5sm3202452pfe.52.2019.09.17.09.35.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 17 Sep 2019 09:35:11 -0700 (PDT)
From:   Elijah Newren <newren@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        =?UTF-8?q?Rafael=20Ascens=C3=A3o?= <rafa.almas@gmail.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        Samuel Lijin <sxlijin@gmail.com>,
        Elijah Newren <newren@gmail.com>
Subject: [PATCH v4 01/12] t7300: add testcases showing failure to clean specified pathspecs
Date:   Tue, 17 Sep 2019 09:34:53 -0700
Message-Id: <20190917163504.14566-2-newren@gmail.com>
X-Mailer: git-send-email 2.22.1.17.g6e632477f7
In-Reply-To: <20190917163504.14566-1-newren@gmail.com>
References: <20190912221240.18057-1-newren@gmail.com>
 <20190917163504.14566-1-newren@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Someone brought me a testcase where multiple git-clean invocations were
required to clean out unwanted files:
  mkdir d{1,2}
  touch d{1,2}/ut
  touch d1/t && git add d1/t
With this setup, the user would need to run
  git clean -ffd */ut
twice to delete both ut files.

A little testing showed some interesting variants:
  * If only one of those two ut files existed (either one), then only one
    clean command would be necessary.
  * If both directories had tracked files, then only one git clean would
    be necessary to clean both files.
  * If both directories had no tracked files then the clean command above
    would never clean either of the untracked files despite the pathspec
    explicitly calling both of them out.

A bisect showed that the failure to clean out the files started with
commit cf424f5fd89b ("clean: respect pathspecs with "-d", 2014-03-10).
However, that pointed to a separate issue: while the "-d" flag was used
by the original user who showed me this problem, that flag should have
been irrelevant to this problem.  Testing again without the "-d" flag
showed that the same buggy behavior exists without using that flag, and
has in fact existed since before cf424f5fd89b.

Although these problems at first are perceived to be different (e.g.
never clearing out the requested files vs. taking multiple invocations
to get everything cleared out), they are actually just different
manifestations of the same problem.  The case with multiple directories
that have no tracked files is the more general case; solving it will
solve all the others.  So, I concentrate on it.  Add testcases showing
that multiple untracked files within entirely untracked directories
cannot be cleaned when specifying these files to git clean via
pathspecs.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 t/t7300-clean.sh | 32 ++++++++++++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/t/t7300-clean.sh b/t/t7300-clean.sh
index d01fd120ab..2c254c773c 100755
--- a/t/t7300-clean.sh
+++ b/t/t7300-clean.sh
@@ -691,6 +691,38 @@ test_expect_failure 'git clean -d skips nested repo containing ignored files' '
 	test_path_is_file nested-repo-with-ignored-file/file
 '
 
+test_expect_failure 'git clean handles being told what to clean' '
+	mkdir -p d1 d2 &&
+	touch d1/ut d2/ut &&
+	git clean -f */ut &&
+	test_path_is_missing d1/ut &&
+	test_path_is_missing d2/ut
+'
+
+test_expect_failure 'git clean handles being told what to clean, with -d' '
+	mkdir -p d1 d2 &&
+	touch d1/ut d2/ut &&
+	git clean -ffd */ut &&
+	test_path_is_missing d1/ut &&
+	test_path_is_missing d2/ut
+'
+
+test_expect_failure 'git clean works if a glob is passed without -d' '
+	mkdir -p d1 d2 &&
+	touch d1/ut d2/ut &&
+	git clean -f "*ut" &&
+	test_path_is_missing d1/ut &&
+	test_path_is_missing d2/ut
+'
+
+test_expect_failure 'git clean works if a glob is passed with -d' '
+	mkdir -p d1 d2 &&
+	touch d1/ut d2/ut &&
+	git clean -ffd "*ut" &&
+	test_path_is_missing d1/ut &&
+	test_path_is_missing d2/ut
+'
+
 test_expect_success MINGW 'handle clean & core.longpaths = false nicely' '
 	test_config core.longpaths false &&
 	a50=aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa &&
-- 
2.22.1.17.g6e632477f7.dirty

