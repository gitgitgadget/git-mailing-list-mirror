Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A82AD20248
	for <e@80x24.org>; Sun,  7 Apr 2019 18:48:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726479AbfDGSsA (ORCPT <rfc822;e@80x24.org>);
        Sun, 7 Apr 2019 14:48:00 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:35856 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726335AbfDGSsA (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 7 Apr 2019 14:48:00 -0400
Received: by mail-wm1-f65.google.com with SMTP id h18so12297738wml.1
        for <git@vger.kernel.org>; Sun, 07 Apr 2019 11:47:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=bIIuqL+uejRpEhajtI8oZ0dIRPp40KH7zgBdrEW8xGw=;
        b=ugMrM4Fms3y2Ij1aWa9r2Hb+arRmaqgm06NbWBdxcfA2dZ1VfBGM9aburRjWYess/o
         QstawN/uDzgLHXwoGuFIAq2APRpTkrI3+02K4qlOxcLq/pG/rEzaSDLOZ6N1GWtmVbzR
         oQmD5O7f5t7Tx2gFgxNI/Pi2tAkpM2/PexDaR6weFjUFPlQyICyK9Powa2qQy4cAqDJP
         G6y3jzFpMAng7ZXYLL6Zi3qobXISQ9vuDFdZbTJ1uKmlcom5rNR6eCn4UDwc8IJxspIB
         bJKm7r8x1Qd2R9s0qzQqdoThCFxk7KtHyNr+qwSqFRFuvXLwXIzh0cHFycKzXYVSCt95
         KmmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=bIIuqL+uejRpEhajtI8oZ0dIRPp40KH7zgBdrEW8xGw=;
        b=sMDArBnw2jRbPeNRpbvQVmiewf/AeoHn1Bt6ebXnH6xkmc2DTR/0HeIQ66hazba/E+
         Ek2GcaAVkgL9uw3hIA2r4EQr3FvgQiiOpptVvpqJuPbpoXQitk200sruGTBHXMMQVg1t
         eFxLRFdKZYhZ/8M46G9yzkqmz+KafZplpt11yQyNzSBoit/j0RuQyPgQAqxECcISIrFg
         sWPi4WL5C5btPpUSF+Aey1b7wzXFXLRNQ0nn3nZyJnzneAp0/OYRxBPKSs1itnxiq5z7
         o2Oete++p43xTlQF9fyOJoWgou/NH0b4usehNAmTVwM3F4CQ3IyJjlRxgQ2D5i1u2SeW
         SPwQ==
X-Gm-Message-State: APjAAAUcLDmA43NaUN3G/mhp5WJZTBolLwD46T9Wg5dSMsdX3vYigsOj
        ORanANJg5MtewKTSdbniFZDTChEj
X-Google-Smtp-Source: APXvYqwoSQipB2Rc7lsw2sL3hac/bo6JgTJAXZRe0y2ryUbBg7CAOHOJTJ6kg8ex6j+CoT9GhZc8Vw==
X-Received: by 2002:a1c:c181:: with SMTP id r123mr7431361wmf.13.1554662878247;
        Sun, 07 Apr 2019 11:47:58 -0700 (PDT)
Received: from localhost ([31.127.45.89])
        by smtp.gmail.com with ESMTPSA id x18sm10418977wmi.6.2019.04.07.11.47.56
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 07 Apr 2019 11:47:56 -0700 (PDT)
From:   Thomas Gummerer <t.gummerer@gmail.com>
To:     git@vger.kernel.org
Cc:     Thomas Gummerer <t.gummerer@gmail.com>
Subject: [PATCH] ls-files: use correct format string
Date:   Sun,  7 Apr 2019 19:47:51 +0100
Message-Id: <20190407184751.28027-1-t.gummerer@gmail.com>
X-Mailer: git-send-email 2.21.0.392.gf8f6787159
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

struct stat_data and struct cache_time both use unsigned ints for all
their members.  However the format string for 'git ls-files --debug'
currently uses %d for formatting these numbers.  This means that we
potentially print these values incorrectly if they are greater than
INT_MAX.

This has been the case since the --debug option was introduced in 'git
ls-files' in 8497421715 ("ls-files: learn a debugging dump format",
2010-07-31).

Signed-off-by: Thomas Gummerer <t.gummerer@gmail.com>
---

I noticed this running 'git ls-files --debug' the other day.
Presumably there's not too many users of 'git ls-files', and even
fewer will see values that trigger this behaviour.  

 builtin/ls-files.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/builtin/ls-files.c b/builtin/ls-files.c
index 29a8762d46..463105ccb5 100644
--- a/builtin/ls-files.c
+++ b/builtin/ls-files.c
@@ -112,11 +112,11 @@ static void print_debug(const struct cache_entry *ce)
 	if (debug_mode) {
 		const struct stat_data *sd = &ce->ce_stat_data;
 
-		printf("  ctime: %d:%d\n", sd->sd_ctime.sec, sd->sd_ctime.nsec);
-		printf("  mtime: %d:%d\n", sd->sd_mtime.sec, sd->sd_mtime.nsec);
-		printf("  dev: %d\tino: %d\n", sd->sd_dev, sd->sd_ino);
-		printf("  uid: %d\tgid: %d\n", sd->sd_uid, sd->sd_gid);
-		printf("  size: %d\tflags: %x\n", sd->sd_size, ce->ce_flags);
+		printf("  ctime: %u:%u\n", sd->sd_ctime.sec, sd->sd_ctime.nsec);
+		printf("  mtime: %u:%u\n", sd->sd_mtime.sec, sd->sd_mtime.nsec);
+		printf("  dev: %u\tino: %u\n", sd->sd_dev, sd->sd_ino);
+		printf("  uid: %u\tgid: %u\n", sd->sd_uid, sd->sd_gid);
+		printf("  size: %u\tflags: %x\n", sd->sd_size, ce->ce_flags);
 	}
 }
 
-- 
2.21.0.392.gf8f6787159

