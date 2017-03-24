Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C780B1FC19
	for <e@80x24.org>; Fri, 24 Mar 2017 18:41:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935929AbdCXSlZ (ORCPT <rfc822;e@80x24.org>);
        Fri, 24 Mar 2017 14:41:25 -0400
Received: from mail-wr0-f194.google.com ([209.85.128.194]:33918 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935077AbdCXSlT (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 Mar 2017 14:41:19 -0400
Received: by mail-wr0-f194.google.com with SMTP id y90so1649494wrb.1
        for <git@vger.kernel.org>; Fri, 24 Mar 2017 11:41:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=rTySXPoAE4JFQqMnzfgOwSDn1jLpZf405cxkoeJliKc=;
        b=etNlu/hGL9iUDVwLp00V5F7w+8UX/A3Ptzy8Igm/FW+eEbEVJJGDmAJEX3xSja1Pg5
         op6FVDZygG//mrFNbnoooVPUtLTwW1dq76iowM4bS/ZK7CjQyR4ZSm5I7f24ualfCv/G
         b8qs13lpyW1bfkCOSprzdZ0ez6gqmhPGcb2DrBVdi6Xhv/MjM8LgXUIh1mCiebbMJamX
         FJG2jBYD2W409OqkaDRJ+IRn8jDEgTLhM4uV34zgnYZNDIYRCj6OVN5qLF2c27x+BHzG
         JiBRlZGvMYuE2Qwm5tIQ9T1I+OMxVMdFDpl6utGK1OQnQkotUkqkOHQ4xvW9O4INctrS
         cJdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=rTySXPoAE4JFQqMnzfgOwSDn1jLpZf405cxkoeJliKc=;
        b=ufzr9kkc1QFoz/IV7vmzqJUcWdLdEasG26oLBAfjdGlYDdr5yOMyh/zdTq6pWkP53d
         F6eMjHmD2yKq/LNL1fRStlAVZC/sshcC1kuzbgnmQ9u3nAJbhVejQW3lNK8nD7Po6ZDj
         BcSGhU32c4kkdciyZWIG+vWy7F5SikSrFicKFK02I4uD4wxlqxrkk7TQskbHoab2whLf
         X4WImtX20DpA2dLbu0kl6Hixue6UOQ336eUGmaAYdPO1LZdQ3JKNcVPweweJJLnZ2Ksy
         tiq9DdtxE/SdHo96sWhhF0YzTrPqS2CmIsDBjCALQTpdhLMXU/VzhuOLZ4PmoIx+s52f
         pMFA==
X-Gm-Message-State: AFeK/H0BoO5eq4A72oY4cxFwXBP4f7X0UIgRA+6B0zvoac0MwEuAIeOFC7z3kEDbDArJuw==
X-Received: by 10.223.134.229 with SMTP id 34mr9044025wry.104.1490380877321;
        Fri, 24 Mar 2017 11:41:17 -0700 (PDT)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id j77sm3440560wmj.3.2017.03.24.11.41.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 24 Mar 2017 11:41:16 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Lars Hjemli <hjemli@gmail.com>,
        Jeff King <peff@peff.net>,
        Christian Couder <christian.couder@gmail.com>,
        Carlos Rica <jasampler@gmail.com>,
        Samuel Tardieu <sam@rfc1149.net>,
        Tom Grennan <tmgrennan@gmail.com>,
        Karthik Nayak <karthik.188@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v4 02/16] tag doc: split up the --[no-]merged documentation
Date:   Fri, 24 Mar 2017 18:40:45 +0000
Message-Id: <20170324184059.5374-3-avarab@gmail.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20170324184059.5374-1-avarab@gmail.com>
References: <20170324184059.5374-1-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Split up the --[no-]merged documentation into documentation that
documents each option independently. This is in line with how "branch"
and "for-each-ref" are documented, and makes subsequent changes to
discuss the limits & caveats of each option easier to read.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 Documentation/git-tag.txt | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/Documentation/git-tag.txt b/Documentation/git-tag.txt
index 33f18ea5fb..68b0ab2410 100644
--- a/Documentation/git-tag.txt
+++ b/Documentation/git-tag.txt
@@ -124,10 +124,13 @@ This option is only applicable when listing tags without annotation lines.
 	Only list tags which contain the specified commit (HEAD if not
 	specified).
 
---[no-]merged [<commit>]::
-	Only list tags whose tips are reachable, or not reachable
-	if `--no-merged` is used, from the specified commit (`HEAD`
-	if not specified).
+--merged [<commit>]::
+	Only list tags whose tips are reachable from the specified commit
+	(`HEAD` if not specified).
+
+--no-merged [<commit>]::
+	Only list tags whose tips are not reachable from the specified
+	commit (`HEAD` if not specified).
 
 --points-at <object>::
 	Only list tags of the given object.
-- 
2.11.0

