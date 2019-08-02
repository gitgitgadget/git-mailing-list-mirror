Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3073C1F731
	for <e@80x24.org>; Fri,  2 Aug 2019 09:57:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406955AbfHBJ5o (ORCPT <rfc822;e@80x24.org>);
        Fri, 2 Aug 2019 05:57:44 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:42901 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2406642AbfHBJ5o (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 2 Aug 2019 05:57:44 -0400
Received: by mail-lj1-f196.google.com with SMTP id t28so72260153lje.9
        for <git@vger.kernel.org>; Fri, 02 Aug 2019 02:57:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+Wvp/mL8/suDq6gcHIqOxEFgwK3hpx7xnZIAAB/rPm8=;
        b=AjT40ThegrXWUOKCQwKTyF6c9nsQwWe/ehECguaJbmhE64BG7Sa1mw8L2Uy7EgA1AQ
         KonhN45rXY1gLkjLMnMwxmr6zT55O+uj17QYfQDvU1QsqxzMITZu103gHQklc0al8Z1n
         iemWxiMvbKW75bqcjApgDCLGYF17LC76VIw/f2ABx/IgTgr8wzSdjae0EbY4xRjMEc8y
         0kt0apxwvLagv5oGgjKYdFzHdZRxrDXXZFmpxirzVRv6cN56TougXZOQ/22zlpsAIIXd
         4VPhVwRGGHLPvOg7xXCPg8nwnpUfZqXDibW1IM0vXKZ8cM0KLIbqI/M1BUkWV9ntE3Bw
         Rhng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+Wvp/mL8/suDq6gcHIqOxEFgwK3hpx7xnZIAAB/rPm8=;
        b=Qf6SVkGFskCZQesEEDJ81fwG6IiUdGlgUP/Z9Jvt/aizv+j4oO1I9eHzgTJIzZGFyN
         xoCBgYxhJxhOFTkowQ9RRXLtEknd4l/SNppb2oxRRPx58iXt6GgoLwGH9zWA6pgMlXDJ
         3VMrHOdfb/vD5iignrwluQsgWOI745u1eIlt1HFVPeO2yLLTGk3jgO12PlyQkYmXl8Gk
         L0BkYHndietkPHOqofyQxzLcm9E94AhC0YaTCHn2Nyn9aYGACFAd2Oocg6IDBrs3crGk
         cZfdPmmp4HZd/XBv4VChmeOLNsIy5A6eOsjRyjlYCLWV0sqUi20ZNKbFVG6vrq9Vyj/p
         cCYQ==
X-Gm-Message-State: APjAAAU2mocFYGYuk5WGOkIxWir1wBNKKamXDFP6IIsTcJkKsIWfviXK
        SjsaZ7+w7GCy5+9Qpi/KtZI=
X-Google-Smtp-Source: APXvYqwLv4E8VkH+zsh6fUTGXfbqtDGkkWY8meMwstT31j0H6u0hfgvTjBkkHNX1kH1ZUyQuttEQ2w==
X-Received: by 2002:a2e:8802:: with SMTP id x2mr50354879ljh.200.1564739862175;
        Fri, 02 Aug 2019 02:57:42 -0700 (PDT)
Received: from localhost.localdomain (31-211-229-121.customers.ownit.se. [31.211.229.121])
        by smtp.gmail.com with ESMTPSA id y12sm14237344lfy.36.2019.08.02.02.57.41
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 02 Aug 2019 02:57:41 -0700 (PDT)
From:   =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>
To:     Josh Steadmon <steadmon@google.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Michael J Gruber <git@grubix.eu>
Subject: [PATCH 5/5] t7503: test failing merge with both hooks available
Date:   Fri,  2 Aug 2019 11:56:39 +0200
Message-Id: <1a65bc5519e59934bf665175b4377c5d6427b77a.1564737003.git.martin.agren@gmail.com>
X-Mailer: git-send-email 2.23.0.rc0.30.g51cf315870
In-Reply-To: <cover.1564737003.git.martin.agren@gmail.com>
References: <cover.1564695892.git.steadmon@google.com> <cover.1564737003.git.martin.agren@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

With a failing automatic merge, we want to make sure that we *don't*
call the pre-merge-commit hook and that we (eventually) *do* call the
pre-commit hook.

Signed-off-by: Martin Ågren <martin.agren@gmail.com>
---
 ...3-pre-commit-and-pre-merge-commit-hooks.sh | 30 +++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/t/t7503-pre-commit-and-pre-merge-commit-hooks.sh b/t/t7503-pre-commit-and-pre-merge-commit-hooks.sh
index f0c73fd58d..4bf359c097 100755
--- a/t/t7503-pre-commit-and-pre-merge-commit-hooks.sh
+++ b/t/t7503-pre-commit-and-pre-merge-commit-hooks.sh
@@ -41,6 +41,18 @@ test_expect_success 'root commit' '
 	git checkout master
 '
 
+test_expect_success 'setup conflicting branches' '
+	test_when_finished "git checkout master" &&
+	git checkout -b conflicting-a master &&
+	echo a >conflicting &&
+	git add conflicting &&
+	git commit -m conflicting-a &&
+	git checkout -b conflicting-b master &&
+	echo b >conflicting &&
+	git add conflicting &&
+	git commit -m conflicting-b
+'
+
 test_expect_success 'with no hook' '
 	test_when_finished "rm -f actual_hooks" &&
 	echo "foo" >file &&
@@ -93,6 +105,24 @@ test_expect_success 'with succeeding hook (merge)' '
 	test_cmp expected_hooks actual_hooks
 '
 
+test_expect_success 'automatic merge fails; both hooks are available' '
+	test_when_finished "rm -f \"$PREMERGE\" \"$PRECOMMIT\"" &&
+	test_when_finished "rm -f expected_hooks actual_hooks" &&
+	test_when_finished "git checkout master" &&
+	ln -s "success.sample" "$PREMERGE" &&
+	ln -s "success.sample" "$PRECOMMIT" &&
+
+	git checkout conflicting-a &&
+	test_must_fail git merge -m "merge conflicting-b" conflicting-b &&
+	test_path_is_missing actual_hooks &&
+
+	echo "$PRECOMMIT" >expected_hooks &&
+	echo a+b >conflicting &&
+	git add conflicting &&
+	git commit -m "resolve conflict" &&
+	test_cmp expected_hooks actual_hooks
+'
+
 test_expect_success '--no-verify with succeeding hook' '
 	test_when_finished "rm -f \"$PRECOMMIT\" actual_hooks" &&
 	ln -s "success.sample" "$PRECOMMIT" &&
-- 
2.23.0.rc0.30.g51cf315870

