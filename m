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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92D54C55186
	for <git@archiver.kernel.org>; Sat, 25 Apr 2020 10:26:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6F2EE20704
	for <git@archiver.kernel.org>; Sat, 25 Apr 2020 10:26:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HYyRTEKy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726113AbgDYK0y (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 25 Apr 2020 06:26:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726059AbgDYK0y (ORCPT
        <rfc822;git@vger.kernel.org>); Sat, 25 Apr 2020 06:26:54 -0400
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A71DC09B04A
        for <git@vger.kernel.org>; Sat, 25 Apr 2020 03:26:54 -0700 (PDT)
Received: by mail-pl1-x644.google.com with SMTP id n24so4724507plp.13
        for <git@vger.kernel.org>; Sat, 25 Apr 2020 03:26:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Yuo+dF8OfND+I+yY3OujxWRbcc9RkwxOrATqr7I2Vmw=;
        b=HYyRTEKy/5UaVW5hMgwj1cxOjK9vIVFi1CTSxyvKiNCM5nx/F10qVGMAsCYP88O0xX
         +xnyXGZOquhFS0Q7AJmfU503J/rIKn33RdFNALFaotrE6/WYemL4klSE9KrLHqYkjhDU
         5KG6QlHuJD5G7Wbvp9cilcRG7AC7n8QRT/qocAQgmRJVlEcboiWO8+Ng8m8/W+Qp5Wfl
         3cY44/Cv/4vT7Tr5LzgrDB6KbzfD1b2EzJkeYROVyPFleKw52XJq6ESzVy0qJevyrF5s
         wdcfoqkI4dmrRGSfc1pKzFPQUW3r3p/r4Ow5RYMqyaSx7fkmcBUjn4oJNjkAe14jLM8M
         Jxlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Yuo+dF8OfND+I+yY3OujxWRbcc9RkwxOrATqr7I2Vmw=;
        b=B9rXKjxFcDKXGlzOGm7dftwyEmvaJ7Xz5Jm0FtCpWzz7OhuxzDP1bjNzmyyYegcS2h
         OIWZz84sdvI1s4e6Wi0BtsqUa8hdipUX/xTEGw6rNJxj0w79WOF3fu1yozGoYGQQKXF2
         rSCDQvpvdFZmB8XnmcNOgEHQcCOexwSm4TF/xDaLqSqrhJs3309oxN0W+2SJwpc6soWA
         XwXz7MKxGRs5tPBfFe4pCQrQK0Pz0YOn9EzKeYlL6AmD8LpAVkCzm1xtvKAOmnZQE32f
         NWDZnudKLvZed6yhdxpSNj2s5NWG2+0r90XIky5fOkLwb+IAQ9AlZcNQFDZKkOT74lbF
         B7EA==
X-Gm-Message-State: AGi0PubIPOEypiUutaBn3qqOhecMr6NQ0KHlfn5qPfoHWfMpUF7k1v0I
        kgUq15I+cSC3cRclK1JnEmoIU+hZ
X-Google-Smtp-Source: APiQypLUtbRRvHroIFvi5psC1Hy0F8JMLdM05/47oEYRyrRd86Z1TUFvfK/fSrrcRW+osjM7d8Dx9Q==
X-Received: by 2002:a17:90a:a0c:: with SMTP id o12mr12064088pjo.29.1587810413297;
        Sat, 25 Apr 2020 03:26:53 -0700 (PDT)
Received: from localhost.localdomain (c-67-188-192-166.hsd1.ca.comcast.net. [67.188.192.166])
        by smtp.gmail.com with ESMTPSA id z7sm7711188pff.47.2020.04.25.03.26.52
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 25 Apr 2020 03:26:52 -0700 (PDT)
From:   =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= 
        <carenas@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= 
        <carenas@gmail.com>
Subject: [PATCH] macos: move PTHREAD_LIBS out of Makefile
Date:   Sat, 25 Apr 2020 03:26:51 -0700
Message-Id: <20200425102651.51961-1-carenas@gmail.com>
X-Mailer: git-send-email 2.26.2.569.g1d74ac4d14
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

starting with f7d9d04e3b (make: Remove -pthread on Darwin (it is included
by cstdlib)., 2009-01-26) building in macOS had made sure not to add any
additional libraries for thread support.

the setting was missed when moving the rest of the system specific settings
to config.uname.mak with e1b6dbb554 (Makefile: hoist uname autodetection to
config.mak.uname, 2013-01-03), so do it now.

Signed-off-by: Carlo Marcelo Arenas Belón <carenas@gmail.com>
---
 Makefile         | 4 +++-
 config.mak.uname | 1 +
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/Makefile b/Makefile
index 7e3fc7ca79..4a6739386a 100644
--- a/Makefile
+++ b/Makefile
@@ -1290,6 +1290,9 @@ ifeq (no,$(USE_PARENS_AROUND_GETTEXT_N))
 endif
 endif
 
+# Platform specific configuration should go instead
+# in config.uname.mak, this is just a last pass to
+# make sure package managers are supported
 ifeq ($(uname_S),Darwin)
 	ifndef NO_FINK
 		ifeq ($(shell test -d /sw/lib && echo y),y)
@@ -1308,7 +1311,6 @@ ifeq ($(uname_S),Darwin)
 		APPLE_COMMON_CRYPTO = YesPlease
 		COMPAT_CFLAGS += -DAPPLE_COMMON_CRYPTO
 	endif
-	PTHREAD_LIBS =
 endif
 
 ifdef NO_LIBGEN_H
diff --git a/config.mak.uname b/config.mak.uname
index f89acdd15f..1f911a88e3 100644
--- a/config.mak.uname
+++ b/config.mak.uname
@@ -134,6 +134,7 @@ ifeq ($(uname_S),Darwin)
 	BASIC_CFLAGS += -DPRECOMPOSE_UNICODE
 	BASIC_CFLAGS += -DPROTECT_HFS_DEFAULT=1
 	HAVE_BSD_SYSCTL = YesPlease
+	PTHREAD_LIBS =
 	FREAD_READS_DIRECTORIES = UnfortunatelyYes
 	HAVE_NS_GET_EXECUTABLE_PATH = YesPlease
 	BASIC_CFLAGS += -I/usr/local/include
-- 
2.26.2.569.g1d74ac4d14

