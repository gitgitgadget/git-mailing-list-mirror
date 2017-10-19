Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 55157202DD
	for <e@80x24.org>; Thu, 19 Oct 2017 19:55:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752736AbdJSTzR (ORCPT <rfc822;e@80x24.org>);
        Thu, 19 Oct 2017 15:55:17 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:47770 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752349AbdJSTzQ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 19 Oct 2017 15:55:16 -0400
Received: by mail-wm0-f66.google.com with SMTP id t69so18115630wmt.2
        for <git@vger.kernel.org>; Thu, 19 Oct 2017 12:55:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=nT76p9wIPJk17Q8HQ52Xu0t1hbGZhuNyk+YlskXrbYo=;
        b=VWUi8meU3cXgW4y4/FzShScGAFL4TzT8zukG1bjkx9WWKtSsJwwyA2djM7NJ4SK9pD
         bX6nA7oJmXxIXAoAslYbGgcuZycNLq7dZBt5As/QqT5haqW56mZ6yujsONP8CxRt5/mz
         Bb7wrjxubtASPXFn6IDRoqd3uavwDZIgA4m3PPYkGmVOT9w+dNPsmFSd42cdyZFANOVR
         tOct8KLMTL7/3OptENtzBi4dCvbjcoM52JjuCmlu9TYzteUqDaj93KQMugLqjBNSHJ7z
         Vwd1O8Esq7eSAghOaz77OrCH1nmhHBISnTljEs3q4Xdr6s8zBxyo56elrLn7U5v/xKaK
         pOIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=nT76p9wIPJk17Q8HQ52Xu0t1hbGZhuNyk+YlskXrbYo=;
        b=lY8AK7pnljxBPWTGA40Id9HL3fRF1GgQbrTd89wLX7S1yD7ojsPix0/xBoHy6EmLz2
         5jZUkCQX1QBZa6VnqOjWjxWfbz1GaCwd0XFRlzEG+6eDDqKLj32HOm3DnkW53EQGb1NR
         Emr3cONVyFLRaTu27cbG9tY7yLnNLKmuhqzhOB37Rt0tDys5RNp2Xq+y4dkIysYy5lwM
         I8trMru9+Gm6jg+aTRyAdyLMHfKp5f7rwQ55zf0XUHNe+CoTmSIWmGX2Q+H7BWzVY7JF
         KpPnyz1xVLufJ6rCPBJokUK/CnOOAIiLloQ93B4e9vX1dQ5w4rcMETFcuYzGOPcx5tzC
         J51A==
X-Gm-Message-State: AMCzsaWin+oMePoHV547Cy42+h2TTY9PbJbPK6B6qmtOzRedC6qTG1jn
        Ny32EhSCzhbjryD7+tnG1vXaVg==
X-Google-Smtp-Source: ABhQp+Q0cq0MgLnDyHWrRHz4xlJjzBS+6cLEcqBdE5meKEpdE/jKxeSScGBvNbq8jy9G7tj2l9jIkg==
X-Received: by 10.28.135.209 with SMTP id j200mr2478258wmd.40.1508442915237;
        Thu, 19 Oct 2017 12:55:15 -0700 (PDT)
Received: from junior.corp.audiocodes.com ([164.138.116.202])
        by smtp.gmail.com with ESMTPSA id w126sm2405299wme.25.2017.10.19.12.55.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 19 Oct 2017 12:55:14 -0700 (PDT)
From:   orgads@gmail.com
To:     git@vger.kernel.org
Cc:     Orgad Shaneh <orgads@gmail.com>
Subject: [PATCH] add a test for "describe --contains" with mixed tags
Date:   Thu, 19 Oct 2017 22:55:01 +0300
Message-Id: <20171019195501.28622-1-orgads@gmail.com>
X-Mailer: git-send-email 2.15.0.rc1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Orgad Shaneh <orgads@gmail.com>

---
 t/t6120-describe.sh | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/t/t6120-describe.sh b/t/t6120-describe.sh
index 1c0e865..08427f4 100755
--- a/t/t6120-describe.sh
+++ b/t/t6120-describe.sh
@@ -340,4 +340,20 @@ test_expect_success ULIMIT_STACK_SIZE 'describe works in a deep repo' '
 	test_cmp expect actual
 '
 
+test_expect_success 'describe --contains for light before annotated' '
+	test_tick &&
+	git commit --allow-empty -m First &&
+	test_tick &&
+	git commit --allow-empty -m Second &&
+	test_tick &&
+	git commit --allow-empty -m Third &&
+	test_tick &&
+	git tag light-before-annotated HEAD^ &&
+	test_tick &&
+	git tag -a -m annotated annotated-after-light
+
+'
+
+check_describe light-before-annotated~1 --contains light-before-annotated~1
+
 test_done
-- 
1.9.1

