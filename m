Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.4 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1C6CB208C4
	for <e@80x24.org>; Tue, 15 Aug 2017 11:49:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751529AbdHOLte (ORCPT <rfc822;e@80x24.org>);
        Tue, 15 Aug 2017 07:49:34 -0400
Received: from mail-lf0-f68.google.com ([209.85.215.68]:36257 "EHLO
        mail-lf0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751500AbdHOLtd (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 Aug 2017 07:49:33 -0400
Received: by mail-lf0-f68.google.com with SMTP id t128so462176lff.3
        for <git@vger.kernel.org>; Tue, 15 Aug 2017 04:49:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=s94XtxIqoT0FaVgISdKU+LyfOR4TBzEOZ4cYCZp0PwQ=;
        b=UE6k3LiDAZwYT7IcV6M01D/sWBEfKDDk91LZo2P7pevbPy3/w1vUfjPMyWbarNb4lI
         xcof3RPDm/zZOemYiKHQMezNwPLcA3NVIrMxUri/x0eeY611PT9RjFt7hBNTloOctSlb
         DxKDbpYh3EtO6mTImeQNy/HpCOKGqD1TEaUK41qS4dOb+x0QjQ8VoHWx63j04+I7lEm1
         /ntLhq4aukMHaJqJD5ZEgsfu5ZRUD+t8t82B7N3EeVSIWLZJNot1WVM7V4+7DSR5XDLp
         k6OBd7miAHQ6ZQgoOUZh6wEo5BD0Nr2a87YC5nrYQOr1v0Fc6JQw9bQwtQYWAM+jCZQn
         OBDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:in-reply-to:references;
        bh=s94XtxIqoT0FaVgISdKU+LyfOR4TBzEOZ4cYCZp0PwQ=;
        b=S+vLuQmFFBkbKYIu3C/D3wlDnjhEdHk2WJHeYPNjXZ1bCZ8ap4zWJp1DFPcsdim1HZ
         h7omtDIz+shfCz+0q+wrOEH/RlCAIOSCim2Num4z317cx/+SHMNUBfKQskpEHduY7QB6
         S96Iy3icvI8sxkiUPL6C1s42fJQWr4uyswT2KirqiPVb4FYJnQu/SRODzITNYvq3wsHq
         squES3r11bxbhN6Ee3mO6LDYsBvfOJMP1E6ejfci0P/K7DyNuMB/AuWOUF76HwWxilZv
         75e9EStX7X0O/SQWc7Bs8ei12XdzZ36tFScvBv/Iezvixd9iNfeNIBzqDg52lygwvuy0
         Bnog==
X-Gm-Message-State: AHYfb5goJVwoX5u57i0MHO/AalKSlevemkit9KrGlI1nGJlSgiD9aS+O
        2p7Q5ep5gctTPnAuY3Q=
X-Received: by 10.46.69.87 with SMTP id s84mr10253354lja.129.1502797771948;
        Tue, 15 Aug 2017 04:49:31 -0700 (PDT)
Received: from localhost.localdomain (user-94-254-225-26.play-internet.pl. [94.254.225.26])
        by smtp.gmail.com with ESMTPSA id z25sm1575317lja.1.2017.08.15.04.49.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 15 Aug 2017 04:49:31 -0700 (PDT)
From:   Patryk Obara <patryk.obara@gmail.com>
To:     git@vger.kernel.org,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        Junio C Hamano <gitster@pobox.com>
Cc:     Patryk Obara <patryk.obara@gmail.com>
Subject: [PATCH 1/5] cache: extend object_id size to sha3-256
Date:   Tue, 15 Aug 2017 13:49:02 +0200
Message-Id: <c6d4d0a52c5d33a2c6e3e8249fcf5696f06e3e0c.1502796628.git.patryk.obara@gmail.com>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <cover.1502796628.git.patryk.obara@gmail.com>
References: <cover.1502796628.git.patryk.obara@gmail.com>
In-Reply-To: <cover.1502796628.git.patryk.obara@gmail.com>
References: <cover.1502796628.git.patryk.obara@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This commit is not intended to be merged - it serves only as context for
next patches in this thread.

Signed-off-by: Patryk Obara <patryk.obara@gmail.com>
---
 cache.h | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/cache.h b/cache.h
index 1c69d2a..ad8a57c 100644
--- a/cache.h
+++ b/cache.h
@@ -68,9 +68,13 @@ unsigned long git_deflate_bound(git_zstream *, unsigned long);
 #define GIT_SHA1_RAWSZ 20
 #define GIT_SHA1_HEXSZ (2 * GIT_SHA1_RAWSZ)
 
+/* The length in bytes and in hex digits of an object name (SHA3-256 value). */
+#define GIT_SHA3_256_RAWSZ 32
+#define GIT_SHA3_256_HEXSZ (2 * GIT_SHA3_256_RAWSZ)
+
 /* The length in byte and in hex digits of the largest possible hash value. */
-#define GIT_MAX_RAWSZ GIT_SHA1_RAWSZ
-#define GIT_MAX_HEXSZ GIT_SHA1_HEXSZ
+#define GIT_MAX_RAWSZ GIT_SHA3_256_RAWSZ
+#define GIT_MAX_HEXSZ GIT_SHA3_256_HEXSZ
 
 struct object_id {
 	unsigned char hash[GIT_MAX_RAWSZ];
-- 
2.9.5

