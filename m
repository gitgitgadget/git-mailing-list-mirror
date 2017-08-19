Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5955F1F667
	for <e@80x24.org>; Sat, 19 Aug 2017 20:13:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751822AbdHSUNp (ORCPT <rfc822;e@80x24.org>);
        Sat, 19 Aug 2017 16:13:45 -0400
Received: from mail-pf0-f196.google.com ([209.85.192.196]:33751 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751533AbdHSUNm (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 19 Aug 2017 16:13:42 -0400
Received: by mail-pf0-f196.google.com with SMTP id z3so1446583pfk.0
        for <git@vger.kernel.org>; Sat, 19 Aug 2017 13:13:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=teichroeb-net.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=vR3ceyQ9cBCsRo2QKJSUY7+WGrQjp/YN8SywvMtfdzM=;
        b=mOEo+hN8ufa1Mex/qgdb0fch75UEGFRhcrnOfyaDOwpiQi9C8iArfYykuRDPGH1d93
         sQHhvls+36QYSGhYIxYFdfCDc2qvq1ecMjfyqJCcf8ZLTRlyc7KUG4uwOA0vRxXXGLHL
         eom/cHCZFANuy5TJp8HXGrC+3IwZoI+aeymUifrG/otz4qNPB6YNGmVjp9ymMw06R12I
         1QEaaOJiyUXCAzCrHt/Xwz4s+od8jaXjPMp/IXTEK4jKVJprHpBALSHzUgChM/UZbWqc
         y9ENKOob35ee/zsg4zx+LyLTZbjM058fekl69x7vDwAC+rtE74hdfkcQhgYoJE8yQi0B
         /9DQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=vR3ceyQ9cBCsRo2QKJSUY7+WGrQjp/YN8SywvMtfdzM=;
        b=cPvuNx1CUnzvR4jz3mxef4RRURkvQ+9JAwscZhSIVyi1jCZOLm+GhP/w7n1tkP1Jt5
         JULIedjOK2IYMGoCLP2z5vh349C7YfvPd3ypmczlQ29/oibIpIpJp/aA7CLzSgxsLdz7
         Gcw3hGoEuull5ETFSIKKN05QtMo8QORaxUdPkaxB6b6Oqw3vTuICErR70A2sqC4BLBte
         hOIu//iaBE+SA2np+E3jqDrcs9gNu/PT89WQQBAbWas6fqeVmDlnaP6SpivVoQi6JxQk
         IMpDyYq2F0kzXS/nOF2Z+kknlWIP/jBY6Gwiv9jB0bsZhv6rRKXx3eSZbSyKu1OQaCo5
         QudA==
X-Gm-Message-State: AHYfb5hmspoUXNpxz/TB6+QIvcucdgD73oDZ+NEjAX3zVJTZFikuH9KZ
        pSMg3gMJG2NnxIjwYng=
X-Received: by 10.84.136.36 with SMTP id 33mr14485123plk.123.1503173621935;
        Sat, 19 Aug 2017 13:13:41 -0700 (PDT)
Received: from localhost.localdomain (S01066c3b6b1953d0.vc.shawcable.net. [24.80.205.243])
        by smtp.gmail.com with ESMTPSA id l15sm14172681pgs.58.2017.08.19.13.13.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 19 Aug 2017 13:13:41 -0700 (PDT)
From:   Joel Teichroeb <joel@teichroeb.net>
To:     git@vger.kernel.org
Cc:     Joel Teichroeb <joel@teichroeb.net>
Subject: [PATCH 3/3] stash: add test for stashing in a detached state
Date:   Sat, 19 Aug 2017 13:13:26 -0700
Message-Id: <20170819201326.6872-3-joel@teichroeb.net>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <20170819201326.6872-1-joel@teichroeb.net>
References: <20170819201326.6872-1-joel@teichroeb.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

All that we are really testing here is that the message is
correct when we are not on any branch. All other functionality is
already tested elsewhere.

Signed-off-by: Joel Teichroeb <joel@teichroeb.net>
---
 t/t3903-stash.sh | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/t/t3903-stash.sh b/t/t3903-stash.sh
index 887010c497..3b1ac1971a 100755
--- a/t/t3903-stash.sh
+++ b/t/t3903-stash.sh
@@ -822,6 +822,18 @@ test_expect_success 'create with multiple arguments for the message' '
 	test_cmp expect actual
 '
 
+test_expect_success 'create in a detached state' '
+	test_when_finished "git checkout master" &&
+	git checkout HEAD~1 &&
+	>foo &&
+	git add foo &&
+	STASH_ID=$(git stash create) &&
+	HEAD_ID=$(git rev-parse --short HEAD) &&
+	echo "WIP on (no branch): ${HEAD_ID} initial" >expect &&
+	git show --pretty=%s -s ${STASH_ID} >actual &&
+	test_cmp expect actual
+'
+
 test_expect_success 'stash -- <pathspec> stashes and restores the file' '
 	>foo &&
 	>bar &&
-- 
2.14.1

