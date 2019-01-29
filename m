Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 477101F453
	for <e@80x24.org>; Tue, 29 Jan 2019 05:22:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725805AbfA2FWE (ORCPT <rfc822;e@80x24.org>);
        Tue, 29 Jan 2019 00:22:04 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:41622 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725267AbfA2FWE (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 29 Jan 2019 00:22:04 -0500
Received: by mail-wr1-f65.google.com with SMTP id x10so20517377wrs.8
        for <git@vger.kernel.org>; Mon, 28 Jan 2019 21:22:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Syb0g5Lw1wR8A9Zh7rPfDLLl27vZcJo3is+7MIteKd4=;
        b=ZSAaNcy0oQoI9g7Iuds8/AXTgkSis1s6KJn5B2X5LN/QPjI01bOjV7Iu3VAeYe/Pbd
         iUcCTr8W4xETOSPNfSudt+BY0AI8pIQ8RGZV9BTuElqo8l1A/rmgjkdIHN55XvIayd4c
         AX2iRaqYZN0pB0tyK4CR12+F/bPWBi5jPqckvVdc2R6tRES3i+UJGDRO0w4Qw+ZyHbBI
         +kPPhFrPnhxtNHIwDISY1DnECOdPP3J6EoliE0Y/dnttxOjH/hKmx2z029i6Db5td6y2
         UWJFqSqvU3LgL1cibG6ycGra6/sBsEr4GrCEvzh7GxhAaDh047w1YEEi1K2bRSHjLDdw
         Pwcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Syb0g5Lw1wR8A9Zh7rPfDLLl27vZcJo3is+7MIteKd4=;
        b=fxK3iDwzuNaICVy1a8dyCNllpVIQp/Oml0dIqTWLF9dADj8pLVH6ZRFJuLrqnjFYav
         anne2avNjDDucf9tQ+iu+qwyckFXacHDyDIuQLjJp6UrxKsNkBmY+F7U8LXeaFB7IqA7
         k2WGZyv1n1JhrbDgmGzGo8hsuczCzjzA4uuP3q1+8gWGpXeh61iOLRKJZKLOtCTuiSFN
         o0g2vj7AVL/QcjcJuB27cFA7bvi3x8MccIcciyIbUPth0ZTbs4rg35aNcvYzOWEf9QRi
         PWH9+BOXtjKJw4uiw4LqceD8KvUX6U1oHVDnNgebyv/aoo3NPiIADLePYfwbZcmn6fXZ
         9JLg==
X-Gm-Message-State: AJcUukeY0zEIHUO+eqQPfUJwOdZcOSF80C2dbWGINPeWukUWkJhB7RFH
        rxji7/ZJbcwlGGYCsgQfzgITaqfnObA=
X-Google-Smtp-Source: ALg8bN7tDxaLhK7PuW2jFr7cndA9hupKuVpgFHT3iPyjHm4RnsbGkQ/Fwvtg4nBlMQ7KP5M463fYGg==
X-Received: by 2002:a5d:480d:: with SMTP id l13mr25836873wrq.175.1548739322159;
        Mon, 28 Jan 2019 21:22:02 -0800 (PST)
Received: from localhost.localdomain (ip5b43d796.dynamic.kabel-deutschland.de. [91.67.215.150])
        by smtp.gmail.com with ESMTPSA id g67sm2906294wmd.38.2019.01.28.21.21.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 28 Jan 2019 21:22:00 -0800 (PST)
From:   Sebastian Staudt <koraktor@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Duy Nguyen <pclouds@gmail.com>,
        Sebastian Staudt <koraktor@gmail.com>
Subject: [PATCH v3 1/3] Add tests for describe with --work-tree
Date:   Tue, 29 Jan 2019 06:18:57 +0100
Message-Id: <20190129051859.12830-1-koraktor@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The dirty ones are already passing, but just because describe is comparing
with the wrong working tree.

Signed-off-by: Sebastian Staudt <koraktor@gmail.com>
---
 t/t6120-describe.sh | 33 +++++++++++++++++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/t/t6120-describe.sh b/t/t6120-describe.sh
index d639d94696..c863c4f600 100755
--- a/t/t6120-describe.sh
+++ b/t/t6120-describe.sh
@@ -145,14 +145,38 @@ check_describe A-* HEAD
 
 check_describe "A-*[0-9a-f]" --dirty
 
+test_expect_success 'describe --dirty with --work-tree' "
+	(
+		cd '$TEST_DIRECTORY' &&
+		git --git-dir '$TRASH_DIRECTORY/.git' --work-tree '$TRASH_DIRECTORY' describe --dirty >'$TRASH_DIRECTORY/out'
+	) &&
+	grep 'A-\d\+-g[0-9a-f]\+' '$TRASH_DIRECTORY/out'
+"
+
 test_expect_success 'set-up dirty work tree' '
 	echo >>file
 '
 
 check_describe "A-*[0-9a-f]-dirty" --dirty
 
+test_expect_success 'describe --dirty with --work-tree' "
+	(
+		cd '$TEST_DIRECTORY' &&
+		git --git-dir '$TRASH_DIRECTORY/.git' --work-tree '$TRASH_DIRECTORY' describe --dirty >'$TRASH_DIRECTORY/out'
+	) &&
+	grep 'A-\d\+-g[0-9a-f]\+-dirty' '$TRASH_DIRECTORY/out'
+"
+
 check_describe "A-*[0-9a-f].mod" --dirty=.mod
 
+test_expect_success 'describe --dirty=.mod with --work-tree' "
+	(
+		cd '$TEST_DIRECTORY' &&
+		git --git-dir '$TRASH_DIRECTORY/.git' --work-tree '$TRASH_DIRECTORY' describe --dirty=.mod >'$TRASH_DIRECTORY/out'
+	) &&
+	grep 'A-\d\+-g[0-9a-f]\+.mod' '$TRASH_DIRECTORY/out'
+"
+
 test_expect_success 'describe --dirty HEAD' '
 	test_must_fail git describe --dirty HEAD
 '
@@ -303,12 +327,21 @@ test_expect_success 'describe chokes on severely broken submodules' '
 	mv .git/modules/sub1/ .git/modules/sub_moved &&
 	test_must_fail git describe --dirty
 '
+
 test_expect_success 'describe ignoring a broken submodule' '
 	git describe --broken >out &&
 	test_when_finished "mv .git/modules/sub_moved .git/modules/sub1" &&
 	grep broken out
 '
 
+test_expect_success 'describe with --work-tree ignoring a broken submodule' "
+	(
+		cd '$TEST_DIRECTORY' &&
+		git --git-dir '$TRASH_DIRECTORY/.git' --work-tree '$TRASH_DIRECTORY' describe --broken >'$TRASH_DIRECTORY/out'
+	) &&
+	grep broken '$TRASH_DIRECTORY/out'
+"
+
 test_expect_success 'describe a blob at a directly tagged commit' '
 	echo "make it a unique blob" >file &&
 	git add file && git commit -m "content in file" &&
-- 
2.20.1

