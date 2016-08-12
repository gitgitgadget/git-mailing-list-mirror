Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 898CF20193
	for <e@80x24.org>; Fri, 12 Aug 2016 00:29:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751257AbcHLA34 (ORCPT <rfc822;e@80x24.org>);
	Thu, 11 Aug 2016 20:29:56 -0400
Received: from mail-pf0-f176.google.com ([209.85.192.176]:33684 "EHLO
	mail-pf0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750998AbcHLA3z (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Aug 2016 20:29:55 -0400
Received: by mail-pf0-f176.google.com with SMTP id y134so3418305pfg.0
        for <git@vger.kernel.org>; Thu, 11 Aug 2016 17:29:55 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=M51aL9AcUHwLyAYSgEnEl2NBKCAHXtd1lqevahWRh8Y=;
        b=aoKc5yoHa+ItT4pe64G24bz4ZgSdk/k1sE3F1tyggJRCkc9oDkTtJk+/E8HhmjyD33
         aaGCt1PGYpk1ntgDZtPWeZF5w5GmIY2lYnjTFgtHp3I6pJqfQKcMsBXd4Aghy+tBoWDB
         dSPl74alUTg1uMX9zZPF3/l5Gz5aCTgN8pfRvHNSiagWqR70+TqZatGnRD1cjrFD21h2
         hmTruVGxt8gvjA9nyBqMOyqtNBePqIdRiat7J4d1xGATKVTlaz8mbthmUanmQuLoAlVN
         HWswYnFn5QXxH3XP0u7vO/kBkt2pQjZ23CxDPPgU8KNzldLl3sstBmWobK3mMknf4kxP
         tRJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=M51aL9AcUHwLyAYSgEnEl2NBKCAHXtd1lqevahWRh8Y=;
        b=dYmE46016wX88TtB4+ik6WOh4DCY3H+cuL+rrbg+wy1OpknSh4h4bKlbshns02e1pp
         JUGTIauqMpFNE+WTvVl4wIQ8QnpgcVur9AZ0UQRkDY7CsrqxNi2qKLHC53OOfxqJGPFT
         ds3nAOXNkj3l9qfylXGll9fOPydh8oKemPR86HKwnAi+lqWTtR2w7djTiwo3Q6K85jB2
         mowjSy0/dkrpdO4JcsbxBCm0x3ykWypZTF8pORcQDYgDrsEVCH479pmbH1lOjAi008Nd
         kvhHDXpeYckAgC3tzBAaqRxebzFqiLzrlSptjg3TwCk3IQir1gBOlb63t42C7bUuVsIy
         4X3Q==
X-Gm-Message-State: AEkoouu3lpxtxlKon+opUWS/Nz45i6SEHLdqaGigTUO+FEpGbPfLBYuBNvjgtAXUx6IpjQPv
X-Received: by 10.98.12.200 with SMTP id 69mr22096840pfm.15.1470961794744;
        Thu, 11 Aug 2016 17:29:54 -0700 (PDT)
Received: from localhost ([2620:0:1000:5b10:2879:1504:a6e4:e441])
        by smtp.gmail.com with ESMTPSA id 72sm7887814pfs.51.2016.08.11.17.29.53
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Thu, 11 Aug 2016 17:29:54 -0700 (PDT)
From:	Stefan Beller <sbeller@google.com>
To:	gitster@pobox.com, jrnieder@gmail.com
Cc:	git@vger.kernel.org, Stefan Beller <sbeller@google.com>
Subject: [PATCHv2] checkout: do not mention detach advice for explicit --detach option
Date:	Thu, 11 Aug 2016 17:29:47 -0700
Message-Id: <20160812002947.1582-1-sbeller@google.com>
X-Mailer: git-send-email 2.9.2.730.g46b112d
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

When a user asked for a detached HEAD specifically with `--detach`,
we do not need to give advice on what a detached HEAD state entails as
we can assume they know what they're getting into as they asked for it.

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 
 jrnieder wrote:
 > Examples?
 
 What do you mean by example?
  
 builtin/checkout.c         |  2 +-
 t/t2020-checkout-detach.sh | 13 +++++++++++++
 2 files changed, 14 insertions(+), 1 deletion(-)

diff --git a/builtin/checkout.c b/builtin/checkout.c
index 8d852d4..85408b1 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -658,7 +658,7 @@ static void update_refs_for_switch(const struct checkout_opts *opts,
 		update_ref(msg.buf, "HEAD", new->commit->object.oid.hash, NULL,
 			   REF_NODEREF, UPDATE_REFS_DIE_ON_ERR);
 		if (!opts->quiet) {
-			if (old->path && advice_detached_head)
+			if (old->path && advice_detached_head && !opts->force_detach)
 				detach_advice(new->name);
 			describe_detached_head(_("HEAD is now at"), new->commit);
 		}
diff --git a/t/t2020-checkout-detach.sh b/t/t2020-checkout-detach.sh
index 5d68729..941ea49 100755
--- a/t/t2020-checkout-detach.sh
+++ b/t/t2020-checkout-detach.sh
@@ -163,4 +163,17 @@ test_expect_success 'tracking count is accurate after orphan check' '
 	test_i18ncmp expect stdout
 '
 
+test_expect_success 'no advice given for explicit detached head state' '
+	git config advice.detachedHead false &&
+	git checkout child &&
+	git checkout --detach HEAD >expect &&
+	git config advice.detachedHead true &&
+	git checkout child &&
+	git checkout --detach HEAD >actual &&
+	test_cmp expect actual &&
+	git checkout child &&
+	git checkout HEAD >actual &&
+	! test_cmp expect actual
+'
+
 test_done
-- 
2.9.2.730.g46b112d

