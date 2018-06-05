Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 282B51F403
	for <e@80x24.org>; Tue,  5 Jun 2018 09:14:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751884AbeFEJOD (ORCPT <rfc822;e@80x24.org>);
        Tue, 5 Jun 2018 05:14:03 -0400
Received: from mail-wr0-f194.google.com ([209.85.128.194]:33243 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751824AbeFEJOA (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 5 Jun 2018 05:14:00 -0400
Received: by mail-wr0-f194.google.com with SMTP id k16-v6so1567985wro.0
        for <git@vger.kernel.org>; Tue, 05 Jun 2018 02:14:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=diamand.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=uydV5jcAsrq1wO0j4RcEsCfvARXpHLi1y+BlqACLBGU=;
        b=O1gUXP9JZxSTUJ0w9nWxgwox0YqS8syeyEd+FYaXGX1GqGHTro8Maw8ykBeDSBKNXF
         cOoWdyQPcMLhO5CF924UAP6pgduikhPvS1GrZcAfRjc/8B3QwM/PvftOCOPiEJ8vHdg7
         SGiLt2ulF8LLw3ve3QLzp93hCteh7wdncCAWc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=uydV5jcAsrq1wO0j4RcEsCfvARXpHLi1y+BlqACLBGU=;
        b=tiKpKz9AFf1b40aUOkaKh7uD5dQxws/epcxB4hrLVPy6luEuOjC4BPtX4iYZyTXSTQ
         n5FuCyTa4OqK/hPit5nnvKZvbvIJzVi8w/sOHD0nRswc/EF1o4T0ETOiUI68RlEb87oz
         WNHpXeDnkWZk+583qZc32HPWG+wzSKYqNmbvgMzEPj4kc7pbuqZs2kXGHzReK/qKwYTU
         hWhasjIrkjYhYpvsi4JmXfiq/yL9mp6o03IPjsLf8KvHgt4urGGg/D82fm3k1afzusl+
         sNqv8EbWc7iQ5Z7ux3WxFGT2ldQDoVPBAbdiGJTmEJU01Z9WDd8lruwyfOT5lAJD+Esr
         ZFBQ==
X-Gm-Message-State: ALKqPwcFKTB+0YG1gqWr5kCTqcFQ69AAnehHASee6gm9jmlrg4vdTvVW
        o1D2bdpt6LAsNNikHjw1lAA2xIuqwYg=
X-Google-Smtp-Source: ADUXVKKqe1d3mJH4FkLubYdFwQ/x9RjM4Dx+82WpVPVtDf4I9vF3usCEKU43b6K5/3dvLYTEIvV/Xg==
X-Received: by 2002:adf:ac37:: with SMTP id v52-v6mr19169978wrc.56.1528190039184;
        Tue, 05 Jun 2018 02:13:59 -0700 (PDT)
Received: from ethel.corp.roku (cpc92728-cmbg20-2-0-cust351.5-4.cable.virginm.net. [82.29.15.96])
        by smtp.gmail.com with ESMTPSA id i46-v6sm42018545wra.36.2018.06.05.02.13.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 05 Jun 2018 02:13:58 -0700 (PDT)
From:   Luke Diamand <luke@diamand.org>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        Romain Merland <merlorom@yahoo.fr>,
        Miguel Torroja <miguel.torroja@gmail.com>,
        viniciusalexandre@gmail.com,
        Lars Schneider <larsxschneider@gmail.com>,
        Lex Spoon <lex@lexspoon.org>, Luke Diamand <luke@diamand.org>
Subject: [PATCHv1 2/3] git-p4: narrow the scope of exceptions caught when parsing an int
Date:   Tue,  5 Jun 2018 10:13:49 +0100
Message-Id: <20180605091350.14476-3-luke@diamand.org>
X-Mailer: git-send-email 2.17.0.392.gdeb1a6e9b7
In-Reply-To: <20180605091350.14476-1-luke@diamand.org>
References: <20180605091350.14476-1-luke@diamand.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The current code traps all exceptions around some code which parses an
integer, and then talks to Perforce.

That can result in errors from Perforce being ignored. Change the code
to only catch the integer conversion exceptions.

Signed-off-by: Luke Diamand <luke@diamand.org>
---
 git-p4.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/git-p4.py b/git-p4.py
index d856078ec8..b337562b39 100755
--- a/git-p4.py
+++ b/git-p4.py
@@ -959,7 +959,7 @@ def p4ChangesForPaths(depotPaths, changeRange, requestedBlockSize):
         try:
             (changeStart, changeEnd) = p4ParseNumericChangeRange(parts)
             block_size = chooseBlockSize(requestedBlockSize)
-        except:
+        except ValueError:
             changeStart = parts[0][1:]
             changeEnd = parts[1]
             if requestedBlockSize:
-- 
2.17.0.392.gdeb1a6e9b7

