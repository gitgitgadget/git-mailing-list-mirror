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
	by dcvr.yhbt.net (Postfix) with ESMTP id 9BD351F731
	for <e@80x24.org>; Fri,  2 Aug 2019 09:58:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406607AbfHBJ6q (ORCPT <rfc822;e@80x24.org>);
        Fri, 2 Aug 2019 05:58:46 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:44524 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2406906AbfHBJ5c (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 2 Aug 2019 05:57:32 -0400
Received: by mail-lf1-f65.google.com with SMTP id r15so35517189lfm.11
        for <git@vger.kernel.org>; Fri, 02 Aug 2019 02:57:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=KYw7b3C7A2T1RxNYvfesLCz7CAX7DrwKH/9YTZcpHWs=;
        b=uSFSFdmKAT8w3eAcKBJRYxb/dW9ga99iN0pZtQ3//tE/Fy03dzo07AyYUeTrhNxo1h
         MzMFa1cGtLFbUQMXzK1L2GC+jU8g+LCXwizq9VECKzJm17dLC3nXo9trG62uQJqiXyYt
         cf2VPDE2F6XbvRWfTJA6/SwI1UR5APvdY+ge93AXmM+XCO5C5dY2jvVEPafNMPod6PEh
         KkO3GwUy6TnLjTnpkRaFbNppBcKmK3IXFIIL1xPgtJGH8nZcEgvlWTvSnBzxZHpd4DVy
         UmAqzne7yfKgiBv2xR1GyDIgif6STn9t15k5G3oNGthfmGOZX22k2E48HsuagPoXbD07
         vrKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=KYw7b3C7A2T1RxNYvfesLCz7CAX7DrwKH/9YTZcpHWs=;
        b=lN+zQRK7XTr1ihMC6DQlxgZUunToAOih2j6jhMPfsuC5/MRML3g9uatW5l24QbSjl6
         RnkB5FgrxJStRD3Fvtbg/xu/bck1mGmf1fPoSzqm+q9QBnwaRw+Z0VbIwZIsRUiUFeDc
         8fzFFW7y+DaRr+JprvAimOlQ/KaILsCZclP8c4Uztgx7MfWE7DEjjD39hVQbC12lGEJD
         aRcSa1MQ1Tnepe/3O27ix0UaDTlgVojSl7UYiRpV/qMaMCUbHnNGUqza9wak3mLwh4Wz
         0xyUQifU/CT7J4V8CvtEbcRPH5bK8RN3MHkJpXB250QpsoYsFpvOVRGDldU9uszisCRd
         LaxA==
X-Gm-Message-State: APjAAAXX8TSf7vAJuUgMtjALYUxdTrT75Yj1oNdK4NN+Qpe2uJ4qBfg/
        NYaIe6gKzcv1hAMpiUcqzSu/3Jnz
X-Google-Smtp-Source: APXvYqwpg3pFqV3mDlbHbH+wjqRAeedWOYRqCzvbqI1ar3bpoKX0BYShJjMax0YAT3P2M6mrsZe5Nw==
X-Received: by 2002:ac2:4201:: with SMTP id y1mr1750045lfh.127.1564739850936;
        Fri, 02 Aug 2019 02:57:30 -0700 (PDT)
Received: from localhost.localdomain (31-211-229-121.customers.ownit.se. [31.211.229.121])
        by smtp.gmail.com with ESMTPSA id y12sm14237344lfy.36.2019.08.02.02.57.29
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 02 Aug 2019 02:57:30 -0700 (PDT)
From:   =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>
To:     Josh Steadmon <steadmon@google.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Michael J Gruber <git@grubix.eu>
Subject: [PATCH 3/5] t7503: simplify file-juggling
Date:   Fri,  2 Aug 2019 11:56:37 +0200
Message-Id: <12cae1e82eceb0586bbc132bf8f883bb862189d7.1564737003.git.martin.agren@gmail.com>
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

Rather than creating an empty "expected_hooks" file and another empty
file "actual_hooks" (which we want to not be appended to), just verify
that "actual_hooks" isn't created. Do still clean up the "actual_hooks"
file, so that a failing test won't start affecting later tests too.

Signed-off-by: Martin Ågren <martin.agren@gmail.com>
---
 ...3-pre-commit-and-pre-merge-commit-hooks.sh | 60 +++++++------------
 1 file changed, 20 insertions(+), 40 deletions(-)

diff --git a/t/t7503-pre-commit-and-pre-merge-commit-hooks.sh b/t/t7503-pre-commit-and-pre-merge-commit-hooks.sh
index a6f1240aa2..477207cb5c 100755
--- a/t/t7503-pre-commit-and-pre-merge-commit-hooks.sh
+++ b/t/t7503-pre-commit-and-pre-merge-commit-hooks.sh
@@ -42,43 +42,35 @@ test_expect_success 'root commit' '
 '
 
 test_expect_success 'with no hook' '
-	test_when_finished "rm -f expected_hooks actual_hooks" &&
-	>expected_hooks &&
-	>actual_hooks &&
+	test_when_finished "rm -f actual_hooks" &&
 	echo "foo" >file &&
 	git add file &&
 	git commit -m "first" &&
-	test_cmp expected_hooks actual_hooks
+	test_path_is_missing actual_hooks
 '
 
 test_expect_success 'with no hook (merge)' '
-	test_when_finished "rm -f expected_hooks actual_hooks" &&
-	>expected_hooks &&
-	>actual_hooks &&
+	test_when_finished "rm -f actual_hooks" &&
 	git checkout side &&
 	git merge -m "merge master" master &&
 	git checkout master &&
-	test_cmp expected_hooks actual_hooks
+	test_path_is_missing actual_hooks
 '
 
 test_expect_success '--no-verify with no hook' '
-	test_when_finished "rm -f expected_hooks actual_hooks" &&
-	>expected_hooks &&
-	>actual_hooks &&
+	test_when_finished "rm -f actual_hooks" &&
 	echo "bar" >file &&
 	git add file &&
 	git commit --no-verify -m "bar" &&
-	test_cmp expected_hooks actual_hooks
+	test_path_is_missing actual_hooks
 '
 
 test_expect_success '--no-verify with no hook (merge)' '
-	test_when_finished "rm -f expected_hooks actual_hooks" &&
-	>expected_hooks &&
-	>actual_hooks &&
+	test_when_finished "rm -f actual_hooks" &&
 	git checkout side &&
 	git merge --no-verify -m "merge master" master &&
 	git checkout master &&
-	test_cmp expected_hooks actual_hooks
+	test_path_is_missing actual_hooks
 '
 
 test_expect_success 'with succeeding hook' '
@@ -104,25 +96,21 @@ test_expect_success 'with succeeding hook (merge)' '
 '
 
 test_expect_success '--no-verify with succeeding hook' '
-	test_when_finished "rm -f \"$PRECOMMIT\" expected_hooks actual_hooks" &&
+	test_when_finished "rm -f \"$PRECOMMIT\" actual_hooks" &&
 	ln -s "success.sample" "$PRECOMMIT" &&
-	>expected_hooks &&
-	>actual_hooks &&
 	echo "even more" >>file &&
 	git add file &&
 	git commit --no-verify -m "even more" &&
-	test_cmp expected_hooks actual_hooks
+	test_path_is_missing actual_hooks
 '
 
 test_expect_success '--no-verify with succeeding hook (merge)' '
-	test_when_finished "rm -f \"$PREMERGE\" expected_hooks actual_hooks" &&
+	test_when_finished "rm -f \"$PREMERGE\" actual_hooks" &&
 	ln -s "success.sample" "$PREMERGE" &&
-	>expected_hooks &&
-	>actual_hooks &&
 	git checkout side &&
 	git merge --no-verify -m "merge master" master &&
 	git checkout master &&
-	test_cmp expected_hooks actual_hooks
+	test_path_is_missing actual_hooks
 '
 
 test_expect_success 'with failing hook' '
@@ -137,14 +125,12 @@ test_expect_success 'with failing hook' '
 '
 
 test_expect_success '--no-verify with failing hook' '
-	test_when_finished "rm -f \"$PRECOMMIT\" expected_hooks actual_hooks" &&
+	test_when_finished "rm -f \"$PRECOMMIT\" actual_hooks" &&
 	ln -s "fail.sample" "$PRECOMMIT" &&
-	>expected_hooks &&
-	>actual_hooks &&
 	echo "stuff" >>file &&
 	git add file &&
 	git commit --no-verify -m "stuff" &&
-	test_cmp expected_hooks actual_hooks
+	test_path_is_missing actual_hooks
 '
 
 test_expect_success 'with failing hook (merge)' '
@@ -159,38 +145,32 @@ test_expect_success 'with failing hook (merge)' '
 '
 
 test_expect_success '--no-verify with failing hook (merge)' '
-	test_when_finished "rm -f \"$PREMERGE\" expected_hooks actual_hooks" &&
+	test_when_finished "rm -f \"$PREMERGE\" actual_hooks" &&
 	ln -s "fail.sample" "$PREMERGE" &&
-	>expected_hooks &&
-	>actual_hooks &&
 	git checkout side &&
 	git merge --no-verify -m "merge master" master &&
 	git checkout master &&
-	test_cmp expected_hooks actual_hooks
+	test_path_is_missing actual_hooks
 '
 
 test_expect_success POSIXPERM 'with non-executable hook' '
-	test_when_finished "rm -f \"$PRECOMMIT\" expected_hooks actual_hooks && chmod +x \"$HOOKDIR/fail.sample\"" &&
+	test_when_finished "rm -f \"$PRECOMMIT\" actual_hooks && chmod +x \"$HOOKDIR/fail.sample\"" &&
 	ln -s "fail.sample" "$PRECOMMIT" &&
 	chmod -x "$HOOKDIR/fail.sample" &&
-	>expected_hooks &&
-	>actual_hooks &&
 	echo "content" >>file &&
 	git add file &&
 	git commit -m "content" &&
-	test_cmp expected_hooks actual_hooks
+	test_path_is_missing actual_hooks
 '
 
 test_expect_success POSIXPERM '--no-verify with non-executable hook' '
-	test_when_finished "rm -f \"$PRECOMMIT\" expected_hooks actual_hooks && chmod +x \"$HOOKDIR/fail.sample\"" &&
+	test_when_finished "rm -f \"$PRECOMMIT\" actual_hooks && chmod +x \"$HOOKDIR/fail.sample\"" &&
 	ln -s "fail.sample" "$PRECOMMIT" &&
 	chmod -x "$HOOKDIR/fail.sample" &&
-	>expected_hooks &&
-	>actual_hooks &&
 	echo "more content" >>file &&
 	git add file &&
 	git commit --no-verify -m "more content" &&
-	test_cmp expected_hooks actual_hooks
+	test_path_is_missing actual_hooks
 '
 
 test_expect_success 'with hook requiring GIT_PREFIX' '
-- 
2.23.0.rc0.30.g51cf315870

