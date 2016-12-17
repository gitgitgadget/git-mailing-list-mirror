Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4C8341FF76
	for <e@80x24.org>; Sat, 17 Dec 2016 14:56:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1758391AbcLQO4m (ORCPT <rfc822;e@80x24.org>);
        Sat, 17 Dec 2016 09:56:42 -0500
Received: from mail-wm0-f65.google.com ([74.125.82.65]:36554 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1757632AbcLQO4T (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 17 Dec 2016 09:56:19 -0500
Received: by mail-wm0-f65.google.com with SMTP id m203so10562278wma.3
        for <git@vger.kernel.org>; Sat, 17 Dec 2016 06:56:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=lAfA73rfUE4wOhLkzG7IIJgnx2XbpCbWmvjk10+TNM0=;
        b=XCrHTk6D86UStjHd5kYH0DbuLJB6MR8fnVcux+p9L8OyMweh5VkfpI6vEeysQIwUoj
         ST8qH2UXR0wBfsz3xOubS813ZNC2hVSu1rc2qXkSCq0dnoiGKncISFfXxHzNJZBu1ztz
         gS3Hb3SmUpNeF1Qi69VHwnIiIRAdGNFLsNlMUe6BG5aO+ZEE7gu6yvUatSX7wJ3R4xDK
         2eh0TLSbADRdDh/ht0oPZBSL/Rt1n0is4vwivPxfeHVHE4E0XIGiGlYnNz1gu88QVskR
         F5hJ4V/n56k7I5sj9vhy0xO1IsKGXDzkWdicHYTQX4+/wjy/qxqAW+tqhDgX7+64DD6p
         LNlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=lAfA73rfUE4wOhLkzG7IIJgnx2XbpCbWmvjk10+TNM0=;
        b=K7fYDDK4e1Gq/gD08vHLpN0lODwN4VaXRLI3/vVCQYOD+RmqZk9h/OKt9evtA9zgXC
         mSBpZkKOX5i9qz5pR5g01i8HYfbTOSqGXn19ewbjwJiNajVh/wWDKDeBVKB4hCANa2q7
         8BdjHZLwsHXQdvJZ7pkmjyEhvLSA0dISbYzQID8N+zWmqBENvpTFbz4kVjWSwSOE0+gl
         WaI7sLXqLSPf68SpO38kUuz2aHUgMea62UKPgAmOK1MPmEAXxVphmX84pSWiz+3d3Lk9
         +j39KDCcF3HEZzFhzEhR81hla/RqUQ3U7LhHIDnNY8TTC9757ECU2QnEX0XXeQ7AIpuu
         7BYw==
X-Gm-Message-State: AIkVDXLt0G7Fs4dkvQMbF3ya3aXvsUyZs3+YbDK1px96hm+AQPSxmN9tQfHdczvyTZ46tA==
X-Received: by 10.28.0.13 with SMTP id 13mr7286954wma.126.1481986577879;
        Sat, 17 Dec 2016 06:56:17 -0800 (PST)
Received: from localhost.localdomain (85.198.126.78.rev.sfr.net. [78.126.198.85])
        by smtp.gmail.com with ESMTPSA id y4sm11823449wjp.0.2016.12.17.06.56.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 17 Dec 2016 06:56:17 -0800 (PST)
From:   Christian Couder <christian.couder@gmail.com>
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v2 13/21] sha1_file: make check_and_freshen_file() non static
Date:   Sat, 17 Dec 2016 15:55:39 +0100
Message-Id: <20161217145547.11748-14-chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.11.0.49.g2414764.dirty
In-Reply-To: <20161217145547.11748-1-chriscool@tuxfamily.org>
References: <20161217145547.11748-1-chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This function will be used in a commit soon, so let's make
it available globally.

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 cache.h     | 3 +++
 sha1_file.c | 2 +-
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/cache.h b/cache.h
index e15b421b6f..f442f28189 100644
--- a/cache.h
+++ b/cache.h
@@ -1170,6 +1170,9 @@ extern int has_pack_index(const unsigned char *sha1);
 
 extern void assert_sha1_type(const unsigned char *sha1, enum object_type expect);
 
+/* Helper to check and "touch" a file */
+extern int check_and_freshen_file(const char *fn, int freshen);
+
 extern const signed char hexval_table[256];
 static inline unsigned int hexval(unsigned char c)
 {
diff --git a/sha1_file.c b/sha1_file.c
index 9c86d1924a..7e5846d4f9 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -576,7 +576,7 @@ static int freshen_file(const char *fn)
  * either does not exist on disk, or has a stale mtime and may be subject to
  * pruning).
  */
-static int check_and_freshen_file(const char *fn, int freshen)
+int check_and_freshen_file(const char *fn, int freshen)
 {
 	if (access(fn, F_OK))
 		return 0;
-- 
2.11.0.49.g2414764.dirty

