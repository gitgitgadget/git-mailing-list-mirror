Return-Path: <SRS0=d/2q=6J=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96A34C55185
	for <git@archiver.kernel.org>; Sat, 25 Apr 2020 09:15:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6E0212071C
	for <git@archiver.kernel.org>; Sat, 25 Apr 2020 09:15:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b6qWE6Oz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726062AbgDYJPw (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 25 Apr 2020 05:15:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725837AbgDYJPw (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 25 Apr 2020 05:15:52 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03793C09B04A
        for <git@vger.kernel.org>; Sat, 25 Apr 2020 02:15:51 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id hi11so4925049pjb.3
        for <git@vger.kernel.org>; Sat, 25 Apr 2020 02:15:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+eHTaUunDYV7wS2xexMTrS8IY5PNMAnB1yUATnPRJHQ=;
        b=b6qWE6Ozo1NsoYnF7khUNe2ziWJF7ovHWu5Fukt5Y3PXbQeTKIjTmKIsT3YBDaDz+V
         s5IQbj7jFZsN9D7iV+R0cs1kk4lj8raIaJeOZjOLz5UX8APXZ7C4A4OUqgBhNEyAqvTc
         DRb/bolhsgfln3IrF37rK33rCrTbIp4ybhZhJp/ZSrmQnI0nSovRRtKkxF+s8GN0pwdo
         7i6AT6HOzt7c9qc/MRRYGc8iPCN7KPXDF7sOGPD1aSL/7x2yz8aPqS3ci2hvsT69EWfq
         tLKUfl0BX57BN7aekq7HAj/Ckw0g4kLA6JUgLBV9kGsTTQUWdAGFfexNYhCILA2UWRj6
         84VA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+eHTaUunDYV7wS2xexMTrS8IY5PNMAnB1yUATnPRJHQ=;
        b=VkXAGrVJZkNG/ljPXtVAlHfjXwk3yU5pzymXQffTjt+09kElWTzHrWT5n2Vo2DFxTv
         QdmxA3dmcPQ1Dcp500Z1THLXPTKIqfObXF4ePxTkYhRDCovU92/R3BB/cD78uGp6Z/dJ
         7cGYbZl9zHuCZUoobuT9KDOvMymnHpLxw8LdIHqh0zxMjrsBv6f99VknyugQc2KHO6+Y
         ptq1GeVPU5ZNXZ/NYKo+DujIZK5s3bUpiKusWc7k7U0DA4jy2WoPL3oo0B34A/OUZi13
         dQWz3TFUoKBOaeFw6IofKvEc7rsseJjLQnQoWnNSKeNqTnm4OTfSbs2rsF1iyuFtyVgw
         V39Q==
X-Gm-Message-State: AGi0PuY/DGNfzJO+I+qbM5KtkLKAKXm0yCqgvNhomn2eWu/dhf3sfskF
        twHoxkpNgg4k6tnVebVqkgxt6l/a
X-Google-Smtp-Source: APiQypJgqyvnorWfJvf7WJIMMv9bIAM59Fgps37QjsGaBXcejbQ84tFeSFDXO+ypzy7KhK9r+3sqJA==
X-Received: by 2002:a17:90a:f313:: with SMTP id ca19mr11299328pjb.7.1587806151070;
        Sat, 25 Apr 2020 02:15:51 -0700 (PDT)
Received: from localhost.localdomain (c-67-188-192-166.hsd1.ca.comcast.net. [67.188.192.166])
        by smtp.gmail.com with ESMTPSA id k10sm7763454pfa.163.2020.04.25.02.15.50
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 25 Apr 2020 02:15:50 -0700 (PDT)
From:   =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= 
        <carenas@gmail.com>
To:     git@vger.kernel.org
Cc:     davvid@gmail.com,
        =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= 
        <carenas@gmail.com>
Subject: [PATCH] macos: move NO_REGEX in macOS to config.mak.uname
Date:   Sat, 25 Apr 2020 02:15:49 -0700
Message-Id: <20200425091549.42293-1-carenas@gmail.com>
X-Mailer: git-send-email 2.26.2.569.g1d74ac4d14
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

29de20504e (Makefile: fix default regex settings on Darwin, 2013-05-11)
added this flag to the Makefile since Mac OS X 10.8 at the time didn't
have a working REG_EXTENDED|REG_NEWLINE

move it to config.mak.uname where all the other system specific settings
are kept since e1b6dbb554 (Makefile: hoist uname autodetection to
config.mak.uname, 2013-01-03) and update the rule so it only applies to
those known broken versions as the problem was most likely fixed in the
next version when Apple imported TRE on their libc.

Signed-off-by: Carlo Marcelo Arenas Belón <carenas@gmail.com>
---
 Makefile         | 1 -
 config.mak.uname | 3 +++
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/Makefile b/Makefile
index dc356ce4dd..7e3fc7ca79 100644
--- a/Makefile
+++ b/Makefile
@@ -1308,7 +1308,6 @@ ifeq ($(uname_S),Darwin)
 		APPLE_COMMON_CRYPTO = YesPlease
 		COMPAT_CFLAGS += -DAPPLE_COMMON_CRYPTO
 	endif
-	NO_REGEX = YesPlease
 	PTHREAD_LIBS =
 endif
 
diff --git a/config.mak.uname b/config.mak.uname
index 0ab8e00938..f89acdd15f 100644
--- a/config.mak.uname
+++ b/config.mak.uname
@@ -125,6 +125,9 @@ ifeq ($(uname_S),Darwin)
 		HAVE_GETDELIM = YesPlease
 	endif
 	NO_MEMMEM = YesPlease
+	ifeq ($(shell test `expr "$(uname_R)" : '\([0-9]*\)\.'` -le 12 && echo 1),1)
+		NO_REGEX = YesPlease
+	endif
 	USE_ST_TIMESPEC = YesPlease
 	HAVE_DEV_TTY = YesPlease
 	COMPAT_OBJS += compat/precompose_utf8.o
-- 
2.26.2.569.g1d74ac4d14

