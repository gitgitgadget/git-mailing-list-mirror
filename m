Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EC234203E2
	for <e@80x24.org>; Fri, 22 Jul 2016 20:28:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752162AbcGVU2b (ORCPT <rfc822;e@80x24.org>);
	Fri, 22 Jul 2016 16:28:31 -0400
Received: from mail-pf0-f176.google.com ([209.85.192.176]:33763 "EHLO
	mail-pf0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750989AbcGVU2a (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Jul 2016 16:28:30 -0400
Received: by mail-pf0-f176.google.com with SMTP id y134so44464753pfg.0
        for <git@vger.kernel.org>; Fri, 22 Jul 2016 13:28:29 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=QbBV1BVJbvM+mZt8ljAZnKMzgDGSv6UaN71UC1TadW8=;
        b=IC22S/uDvmUKGNasS7AZgVR/nHVHwO9i8q7CwaZcxBBW9366hGvBrAdaJ0HJpmvok/
         H6KpHfRmpjbqs0DEtjba1mhs5tbMhnEai0UW9pSLCXLoB24YPfflXEu6LtAnQfULqKvf
         a0iIRMVxndqoFy0i83TaDqzAyxp5NAhcAipvIn2N+Q7bUnk9eHmCbzkSROLrvPFwOwbI
         fBFZsXU+ucspH23EO2/kzld9HY0c9x5etrt42ToiAytQhCaB7Rhbh1la2OC/pp5vGsJQ
         MKCgfcxDKLMJtsPdQ4aep7DKY9EIsg0bkK1pc8jvrIYPgfTobfQlwZUZrw32/q+4po5Y
         iEMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=QbBV1BVJbvM+mZt8ljAZnKMzgDGSv6UaN71UC1TadW8=;
        b=R3bxd6cIQw/NFxycxlc3S6+VQ8mci3Fz3qe3h4ghD+9BPmsQMlumXNT+rsSAiFqbnC
         9HdMquM7jsewykjuDNY5NRJJeNNnDoduYl2T1lDL9pXRuR+FQA/Sw0ItPEi2Otp33Sma
         +dhrWK1oUO3Emiix1cDwUI4wIY1z8PS+NSJFQiHsy9ejwkP/c+bxhCewnBPlLI91eA4E
         CleaKC8KNUBj7BrzZxdwrbnmoAbrLVlIFvP6B1bhDpQXiqGpvZESHdHPyXiTX/Ebw2cs
         jHNDPB9nF/UyYrYN6zdzrbqKuOrOacrpob4atwbkDw1OcxagGs6wGWsH/AhbyCKpV0rg
         OU4Q==
X-Gm-Message-State: AEkoouuBqJKMX+rGCbuhE/Rv+TcBx6hMm77MsRkgdEDQasf3f3R3t360bon/wvoR+ajxqBPG
X-Received: by 10.98.84.65 with SMTP id i62mr9492327pfb.72.1469219309276;
        Fri, 22 Jul 2016 13:28:29 -0700 (PDT)
Received: from localhost ([2620:0:1000:5b10:1da9:5530:1617:876e])
        by smtp.gmail.com with ESMTPSA id q4sm21989899pfb.18.2016.07.22.13.28.28
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Fri, 22 Jul 2016 13:28:28 -0700 (PDT)
From:	Stefan Beller <sbeller@google.com>
To:	gitster@pobox.com
Cc:	git@vger.kernel.org, Stefan Beller <sbeller@google.com>
Subject: [PATCH] Documentation: pack-protocol correct NAK response
Date:	Fri, 22 Jul 2016 13:28:20 -0700
Message-Id: <20160722202820.18688-1-sbeller@google.com>
X-Mailer: git-send-email 2.9.2.370.g4a59376.dirty
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

In the transport protocol we use NAK to signal the non existence of a
common base, so fix the documentation. This helps readers of the document,
as they don't have to wonder about the difference between NAK and NACK.
As NACK is used in git archive and upload-archive, this is easy to get
wrong.

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 Documentation/technical/pack-protocol.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/technical/pack-protocol.txt b/Documentation/technical/pack-protocol.txt
index 8b36343..d40ab65 100644
--- a/Documentation/technical/pack-protocol.txt
+++ b/Documentation/technical/pack-protocol.txt
@@ -307,7 +307,7 @@ In multi_ack mode:
     ready to make a packfile, it will blindly ACK all 'have' obj-ids
     back to the client.
 
-  * the server will then send a 'NACK' and then wait for another response
+  * the server will then send a 'NAK' and then wait for another response
     from the client - either a 'done' or another list of 'have' lines.
 
 In multi_ack_detailed mode:
-- 
2.9.2.370.g4a59376.dirty

