Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A7C43209B3
	for <e@80x24.org>; Sat, 10 Dec 2016 02:14:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752528AbcLJCO2 (ORCPT <rfc822;e@80x24.org>);
        Fri, 9 Dec 2016 21:14:28 -0500
Received: from mail-pg0-f50.google.com ([74.125.83.50]:34760 "EHLO
        mail-pg0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752380AbcLJCO1 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 9 Dec 2016 21:14:27 -0500
Received: by mail-pg0-f50.google.com with SMTP id x23so13676518pgx.1
        for <git@vger.kernel.org>; Fri, 09 Dec 2016 18:14:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=i/iOHTNq9IhZ+l4fcMx3xSKFryB7fDnxO43RfzUcThY=;
        b=ajaAIfaHbZy4xfULKyJWmrxz4nvRIyAc1uPXlLroxPTItVSgcuGCOipYuyKQMGYYhD
         nkoawIkkQiZf7uZotunfqoPMaTKdZdqlrMqMUMaaTPAY80VHYhnxCC1prcLjOXw5LMPs
         koHGW2lu5chH1xTqcJlgDH0zJJcJAkWz+jL1/CoJ9DOUC+MRRxOxGTB3cxbl1Hi13VHz
         tJ7UlP/CZdyJPRPC34nkpQwwKCiHRNPhphABqhsdXnIn5GUoe6rmW2j6csbhZMWFsLFY
         OQsEX3neu5qkUYDpGVKl1Z+rhriywKa7b22ujneKXQxGdmFuUTq+XTkH9tMjv5poRZE2
         zqJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=i/iOHTNq9IhZ+l4fcMx3xSKFryB7fDnxO43RfzUcThY=;
        b=VeFFbqvRsEDFf0nBppdeUhq0ip2U6ucT5VkrHioRAAX1bEDL/AtWcM06R4E5iJJB8u
         8GMHSf0WIjiLRU1nfTaLQCPpodsAXCHc3Pb4aLfJbX2IdERG/YRe1EFZ9MvN07NlbQrA
         L4P8ajd0enr58AtGyNPsB1j7Y8izB5FraFl2VLhXh2rcrRpqR/rXbJNsy+SdbUqRZG0F
         0gz3eu3XqgYutwodFvPpd/t3ppjJrXFLkk/97OLaPYeFDaKaWoZ15IatyvuZmoAmEvip
         nsAiwoRqSddCzLLdqJLOe1I1JlPkpN656El3E5aX9ZWQBOT93WZML9/2PuOjtZvD8X5W
         CbhA==
X-Gm-Message-State: AKaTC02qWuzks3o27iwKB4va4ZXQ4nUWRMJurc/pBu0X1HgF8KEh48u4ph5jZ/Ep4kQLRg==
X-Received: by 10.84.133.129 with SMTP id f1mr160646280plf.64.1481336066946;
        Fri, 09 Dec 2016 18:14:26 -0800 (PST)
Received: from raptor.fas.fa.disney.com ([198.187.190.1])
        by smtp.gmail.com with ESMTPSA id 129sm60570611pgj.26.2016.12.09.18.14.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 09 Dec 2016 18:14:25 -0800 (PST)
From:   David Aguilar <davvid@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git ML <git@vger.kernel.org>
Subject: [PATCH] mergetools: fix xxdiff hotkeys
Date:   Fri,  9 Dec 2016 18:14:21 -0800
Message-Id: <20161210021421.22955-1-davvid@gmail.com>
X-Mailer: git-send-email 2.11.0.rc3.8.gaca8798.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

xxdiff was using a mix of "Ctrl-<key>" and "Ctrl+<key>" hotkeys.
The dashed "-" form is not accepted by newer xxdiff versions.
Use the plus "+" form only.

Signed-off-by: David Aguilar <davvid@gmail.com>
---
This patch is based on top of da/mergetool-diff-order

 mergetools/xxdiff | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/mergetools/xxdiff b/mergetools/xxdiff
index e284811ff2..ce5b8e9f29 100644
--- a/mergetools/xxdiff
+++ b/mergetools/xxdiff
@@ -1,7 +1,7 @@
 diff_cmd () {
 	"$merge_tool_path" \
 		-R 'Accel.Search: "Ctrl+F"' \
-		-R 'Accel.SearchForward: "Ctrl-G"' \
+		-R 'Accel.SearchForward: "Ctrl+G"' \
 		"$LOCAL" "$REMOTE"
 }
 
@@ -9,15 +9,15 @@ merge_cmd () {
 	if $base_present
 	then
 		"$merge_tool_path" -X --show-merged-pane \
-			-R 'Accel.SaveAsMerged: "Ctrl-S"' \
+			-R 'Accel.SaveAsMerged: "Ctrl+S"' \
 			-R 'Accel.Search: "Ctrl+F"' \
-			-R 'Accel.SearchForward: "Ctrl-G"' \
+			-R 'Accel.SearchForward: "Ctrl+G"' \
 			--merged-file "$MERGED" "$LOCAL" "$BASE" "$REMOTE"
 	else
 		"$merge_tool_path" -X $extra \
-			-R 'Accel.SaveAsMerged: "Ctrl-S"' \
+			-R 'Accel.SaveAsMerged: "Ctrl+S"' \
 			-R 'Accel.Search: "Ctrl+F"' \
-			-R 'Accel.SearchForward: "Ctrl-G"' \
+			-R 'Accel.SearchForward: "Ctrl+G"' \
 			--merged-file "$MERGED" "$LOCAL" "$REMOTE"
 	fi
 }
-- 
2.11.0.rc3.8.gaca8798.dirty

