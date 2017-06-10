Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FROM,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8F7861FAEB
	for <e@80x24.org>; Sat, 10 Jun 2017 11:41:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752011AbdFJLlP (ORCPT <rfc822;e@80x24.org>);
        Sat, 10 Jun 2017 07:41:15 -0400
Received: from mail-wr0-f194.google.com ([209.85.128.194]:33199 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751955AbdFJLlO (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 10 Jun 2017 07:41:14 -0400
Received: by mail-wr0-f194.google.com with SMTP id v104so11863473wrb.0
        for <git@vger.kernel.org>; Sat, 10 Jun 2017 04:41:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=8QqxmQzZFG8smcJn3ZlqheEx/Hx5LPkKVzXkcZPQzEU=;
        b=XTrgsQHSMjf0H1dFmF5yC/uJElo42bGG0lnUU5F6fxsaYh6Z+p1W/S9HTiSk8Ccwq5
         YZgS63VLY+P3O3DKnfMSfMPUWl7nLQRiMjbOCwmebr9l8vbeiCUq+0zKKjXmYFS0I2KQ
         C7fcFTlRgrQfZCka4IkPncugBBxLpyEA0FtTROya4+wyiUWQDxPmKjTbzXZo1jpWwnYZ
         dE5i5DdvN8ZtjuKvfdZNzqlfJaTjo9Qf/NDXmYYm2KMCazVUdKU2JgE1fTjUAqtqqcjO
         pgpmS/XTBC+Hz/EltY6BLhrJRrL0TNggBYV1/Q9t9E7Dz3lUPC4/GSns85nZM0hbcRHP
         KUfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=8QqxmQzZFG8smcJn3ZlqheEx/Hx5LPkKVzXkcZPQzEU=;
        b=H/vgXA2Szoc9DzjsckhFvqchiuw1ZfIE3E54f2weK+sZw9J1ejAZof7ItGZIeQEEe7
         dlEnF/tMcDBEluNS3dpeTVOYyfPjckj5mli3wnTglI5j7hliUnT2+F8c8F541QChBPrN
         mgEBy3zrZvQnAL2poygk/2+fH/6igxD918JtyaJ2zxEJL2cYCG4P/wKD4LC2Ca24V1i9
         FStl/4F/XGZViI+5x0lM0otjV4/rLftSBUf54mhmDsFzKcKTBuW8Q8OWLQRdIbG0KkYk
         f7yVIX0M1T//GztJVuoPA8DubSDGWRKu3U7Ee9I7ZvEzaSMix4tZ4nUPWmFGgNJ24hKs
         uC1A==
X-Gm-Message-State: AKS2vOx+f6MZN4PgFUWpAKxITAplQuLRCv4h6SvLcyNfMXjP90TdFkfv
        07QjcFm3Ia7MEQ==
X-Received: by 10.28.138.16 with SMTP id m16mr2417719wmd.99.1497094872983;
        Sat, 10 Jun 2017 04:41:12 -0700 (PDT)
Received: from localhost.localdomain (x4db24cad.dyn.telefonica.de. [77.178.76.173])
        by smtp.gmail.com with ESMTPSA id f75sm2757287wmi.14.2017.06.10.04.41.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 10 Jun 2017 04:41:12 -0700 (PDT)
From:   =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
To:     Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [PATCHv2.1] revision.h: turn rev_info.early_output back into an unsigned int
Date:   Sat, 10 Jun 2017 13:41:01 +0200
Message-Id: <20170610114101.21026-1-szeder.dev@gmail.com>
X-Mailer: git-send-email 2.13.0.420.g54001f015
In-Reply-To: <20170610064102.w4kp6omxdznfe7fa@sigill.intra.peff.net>
References: <20170610064102.w4kp6omxdznfe7fa@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

rev_info.early_output started out as an unsigned int in cdcefbc97 (Add
"--early-output" log flag for interactive GUI use, 2007-11-03), but
later it was turned into a single bit in a bit field in cc243c3ce
(show: --ignore-missing, 2011-05-18) without explanation, though the
code using it still expects it to be a regular integer type and uses
it as a counter.  Consequently, any even number given via
'--early-output=<N>', or indeed a plain '--early-output' defaulting to
100 effectively disabled the feature.

Turn rev_info.early_output back into its origin unsigned int data
type, making '--early-output' work again.

Signed-off-by: SZEDER Gábor <szeder.dev@gmail.com>
---

> But the "users still expect" bit was a bit subtle to me, as I thought
> you meant users of Git. But you mean that the feature itself is not a
> boolean, but rather an integer count of how much early output to show.

Yeah, I wrote "callsites" first, but then realized it's not a
function...

Here is the same patch with an updated commit message now saying "code
using it" and "used as a counter" to make it clearer.  It also
mentions that an argumentless '--early-output' turns off the feature,
too.

I won't resend the rest of the series.

 revision.h | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/revision.h b/revision.h
index a91dd3d5d..f96e7f7f4 100644
--- a/revision.h
+++ b/revision.h
@@ -74,8 +74,9 @@ struct rev_info {
 	/* topo-sort */
 	enum rev_sort_order sort_order;
 
-	unsigned int	early_output:1,
-			ignore_missing:1,
+	unsigned int early_output;
+
+	unsigned int	ignore_missing:1,
 			ignore_missing_links:1;
 
 	/* Traversal flags */
-- 
2.13.0.420.g54001f015

