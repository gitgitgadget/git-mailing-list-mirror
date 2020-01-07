Return-Path: <SRS0=IlH6=24=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62B65C33C99
	for <git@archiver.kernel.org>; Tue,  7 Jan 2020 04:53:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 37A812075A
	for <git@archiver.kernel.org>; Tue,  7 Jan 2020 04:53:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U72J9ANn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727629AbgAGExn (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 6 Jan 2020 23:53:43 -0500
Received: from mail-qv1-f49.google.com ([209.85.219.49]:36347 "EHLO
        mail-qv1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727617AbgAGExk (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 6 Jan 2020 23:53:40 -0500
Received: by mail-qv1-f49.google.com with SMTP id m14so4110660qvl.3
        for <git@vger.kernel.org>; Mon, 06 Jan 2020 20:53:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=jbA3LBz+SdJg67fYbKODcNtdYg8o9uAs+VSX7Ubldpg=;
        b=U72J9ANn17meyr2e/JvWJk7GYlgitKhCYJGwTdB4HKKSScTqkiOoNVbjPsTNPr4dfu
         Mbiw/uM6lJvjrkg5+vW4uHjD21pYOgs8S/mWIb+4gSUpJr6b77XWfuVuPuqgZaEuSDyZ
         We+yHxnxe4z7Lphyu/sXgEiK2v/AKaTA78n3k1YBc6xzOGfeop6WEmIhEhyb6avlc7Dg
         +5yPMd5NDLuO7h1wBroJpPDvN2yGwytPc4tb2vaQwE49clNKLSp0NIiaBEbNHtK/OFB8
         6AHtBaoQuWbiNDhupQJncS0mi4Jwc3svwk8NSTYwvtAcpXQ1vMdbCK1zkXO+1iqZEYJG
         SvNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=jbA3LBz+SdJg67fYbKODcNtdYg8o9uAs+VSX7Ubldpg=;
        b=cwLtftFGLAio8Kqhe2AtxgaWKON7MQrwcj155mp8c0gD0oAseV9FJGcyFhsyjJmYGC
         X/CNnkUKG1+eHI2SwtEIYxzAmTaspLkbUUFFCNoDqDuA0/ViX5JH/NsLDpUS+J2eSb0K
         YP7NsPQDg0ykK6ONwkMjRZTpbkbochOQRdwQToAxhxSTAsT2JlZ8w9KC6LkJIYSMKFvZ
         J1lcj2Y3MIIh6YCWKjoh1VMPyPIqc3CIrXwuWUDGJpXvDs104Ogai8MemdOp5dlyj+1o
         pEjSWtK+gZJKsexGw/bytnjK7MaI0Ara8A7LTX9HywtvGa1KMk9TTZsJU3T+KDq7Z2IK
         PS8A==
X-Gm-Message-State: APjAAAVF6KuIfzDQnsCq8fWwCshXQBAA6kmLfGR5MNV/Xh+e/vXfw3Mp
        ctvUHVhvSGZlXy8f9PK2vbgiMczZ
X-Google-Smtp-Source: APXvYqyzzQ0Q2QTHJDnr1Vh91L4w+NrQlgPkEi5pBYRJJOc+lY2E1N/VsKY66BwiK1waBunClG1ViA==
X-Received: by 2002:a05:6214:38c:: with SMTP id l12mr82518743qvy.224.1578372819698;
        Mon, 06 Jan 2020 20:53:39 -0800 (PST)
Received: from archbookpro.lan ([199.249.110.29])
        by smtp.gmail.com with ESMTPSA id t2sm21663893qkc.31.2020.01.06.20.53.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jan 2020 20:53:39 -0800 (PST)
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Jakub Narebski <jnareb@gmail.com>,
        Johannes Sixt <j6t@kdbg.org>,
        Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 14/16] t3507: fix indentation
Date:   Mon,  6 Jan 2020 23:53:11 -0500
Message-Id: <96310b7d289a912fa173dd15d55f3326005402cc.1578372682.git.liu.denton@gmail.com>
X-Mailer: git-send-email 2.25.0.rc1.180.g49a268d3eb
In-Reply-To: <cover.1578372682.git.liu.denton@gmail.com>
References: <cover.1577454401.git.liu.denton@gmail.com> <cover.1578372682.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

We have some test cases which are indented 7-spaces instead of a tab.
Reindent with a tab instead.

This patch should appear empty with `--ignore-all-space`.

Signed-off-by: Denton Liu <liu.denton@gmail.com>
---
 t/t3507-cherry-pick-conflict.sh | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/t/t3507-cherry-pick-conflict.sh b/t/t3507-cherry-pick-conflict.sh
index 9b9b4ca8d4..2a0d119c8a 100755
--- a/t/t3507-cherry-pick-conflict.sh
+++ b/t/t3507-cherry-pick-conflict.sh
@@ -381,23 +381,23 @@ test_expect_success 'failed commit does not clear REVERT_HEAD' '
 '
 
 test_expect_success 'successful final commit clears revert state' '
-       pristine_detach picked-signed &&
+	pristine_detach picked-signed &&
 
-       test_must_fail git revert picked-signed base &&
-       echo resolved >foo &&
-       test_path_is_file .git/sequencer/todo &&
-       git commit -a &&
-       test_must_fail test_path_exists .git/sequencer
+	test_must_fail git revert picked-signed base &&
+	echo resolved >foo &&
+	test_path_is_file .git/sequencer/todo &&
+	git commit -a &&
+	test_must_fail test_path_exists .git/sequencer
 '
 
 test_expect_success 'reset after final pick clears revert state' '
-       pristine_detach picked-signed &&
+	pristine_detach picked-signed &&
 
-       test_must_fail git revert picked-signed base &&
-       echo resolved >foo &&
-       test_path_is_file .git/sequencer/todo &&
-       git reset &&
-       test_must_fail test_path_exists .git/sequencer
+	test_must_fail git revert picked-signed base &&
+	echo resolved >foo &&
+	test_path_is_file .git/sequencer/todo &&
+	git reset &&
+	test_must_fail test_path_exists .git/sequencer
 '
 
 test_expect_success 'revert conflict, diff3 -m style' '
-- 
2.25.0.rc1.180.g49a268d3eb

