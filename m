Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 004C41F404
	for <e@80x24.org>; Thu,  4 Jan 2018 22:52:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753649AbeADWww (ORCPT <rfc822;e@80x24.org>);
        Thu, 4 Jan 2018 17:52:52 -0500
Received: from mail-pf0-f194.google.com ([209.85.192.194]:37843 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753307AbeADWwv (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 4 Jan 2018 17:52:51 -0500
Received: by mail-pf0-f194.google.com with SMTP id n6so1402428pfa.4
        for <git@vger.kernel.org>; Thu, 04 Jan 2018 14:52:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=hdGd25/plcuDkUogaDTcPCTgasZVxR3+Ztqr2kKKwsQ=;
        b=gpYPLk0LFcVSXTDmDVQ4Jr1qGdzpTg+taMyNjMLvjp0n8tw1g8FXXLWaV6quW1yIuK
         rNbaqUIuGcn2YS89BvLONg8VfIxi9ZXDBSR8DuWtNO0dOieWRKK/7uodsFA8++/RDeX+
         j8/se1ENZYcYJpBLmSm01qCnTcbpn1/4zCt0444x8j7Hq16/C1aCMnoLcLIh+Cgmdkxo
         y1Vq96CN6UjnIiohK4vJNqQn5iepSQOWC0c645ciWhzMKtWbmVtKehL0RO9e7ZGqx6Nk
         PiibnVR+eKrIb21jx9dztf4mgV+MOLa73VOTVfAvOykg2nezGlgcWwKYt30APz5T+5uS
         9GVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=hdGd25/plcuDkUogaDTcPCTgasZVxR3+Ztqr2kKKwsQ=;
        b=nnPy6AgogUMXESTg/4oKe0ExgEhnsNXMNgS3m51jTJQm4isgJBpYaEbg7b5lVsRyL6
         WG+0kzpktoA6DBnd12dLvxITT+N2iJy5p6chTH/SB6lwnTjeAHbZNej2YrA8Ld79s1ya
         QE6jlfPWPmTMIHQ8afPJpTqJ1HGzGRlN+zPRwaXgj/XJYCklmsjDG0QJQutZdxfHO3JW
         e8cKzCFaXE9oxVRPbH+tnbHS/s0eYz1zT7Wz+03j4KFb8b7L6jm29NGLCi/tFe+YIfJN
         RVZ3J4FKotO0Cr5I2kD8Yvj8AvmrGniaA3PUtm3gtetWO5AF2fSkaZCQ41Th9ah03eHm
         klpg==
X-Gm-Message-State: AKGB3mLtnOxwy5auo+VwQp6Bd5DEIp0Rveadoyggo4owH7gR4/CJvUXv
        gLIVaDTw3TCdOiBpBRVnkrsqIA==
X-Google-Smtp-Source: ACJfBotbKN2+ODa/5VQWDTRtYFE/+o2KCxovIdw2IYXSd8AtrUwunlRyg8O/Gy3NwKZ+kzHi5b93HQ==
X-Received: by 10.101.99.144 with SMTP id h16mr881274pgv.101.1515106370350;
        Thu, 04 Jan 2018 14:52:50 -0800 (PST)
Received: from localhost ([2620:0:100e:422:2d12:5719:3437:fdb7])
        by smtp.gmail.com with ESMTPSA id t84sm9970316pfe.160.2018.01.04.14.52.49
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 04 Jan 2018 14:52:49 -0800 (PST)
From:   Stefan Beller <sbeller@google.com>
To:     sbeller@google.com
Cc:     git@vger.kernel.org, gitster@pobox.com, jacob.keller@gmail.com
Subject: [PATCHv2 1/6] diff.h: Make pickaxe_opts an unsigned bit field
Date:   Thu,  4 Jan 2018 14:50:39 -0800
Message-Id: <20180104225044.191220-2-sbeller@google.com>
X-Mailer: git-send-email 2.16.0.rc0.223.g4a4ac83678-goog
In-Reply-To: <20180104225044.191220-1-sbeller@google.com>
References: <20180103004624.222528-1-sbeller@google.com>
 <20180104225044.191220-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This variable is used as a bit field[1], and as we are about to add more
fields, indicate its usage as a bit field by making it unsigned.

[1] containing the bits

    #define DIFF_PICKAXE_ALL	1
    #define DIFF_PICKAXE_REGEX	2
    #define DIFF_PICKAXE_KIND_S	4
    #define DIFF_PICKAXE_KIND_G	8

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 diff.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/diff.h b/diff.h
index 0fb18dd735..ea310f76fd 100644
--- a/diff.h
+++ b/diff.h
@@ -146,7 +146,7 @@ struct diff_options {
 	int skip_stat_unmatch;
 	int line_termination;
 	int output_format;
-	int pickaxe_opts;
+	unsigned pickaxe_opts;
 	int rename_score;
 	int rename_limit;
 	int needed_rename_limit;
-- 
2.16.0.rc0.223.g4a4ac83678-goog

