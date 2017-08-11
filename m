Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D048B20899
	for <e@80x24.org>; Fri, 11 Aug 2017 20:36:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753739AbdHKUgZ (ORCPT <rfc822;e@80x24.org>);
        Fri, 11 Aug 2017 16:36:25 -0400
Received: from mail-pf0-f174.google.com ([209.85.192.174]:33339 "EHLO
        mail-pf0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753660AbdHKUgV (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 11 Aug 2017 16:36:21 -0400
Received: by mail-pf0-f174.google.com with SMTP id h68so20013235pfk.0
        for <git@vger.kernel.org>; Fri, 11 Aug 2017 13:36:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=tyhSSKgzZ4wrpcngkngp3Pi0gbi0Sp5uzScWa9cXiX8=;
        b=j8r3BopY3IEnawrS/DlAj5OD2KK0zuSHgZjayOV03fFcjIHvO+ukFiP37i2VJhLkvi
         rjV+NpN9d+OVflQ4TUqITcMukB+LPBtO/RV1k9Ogh/gJTdSbhHa49Lg4gILWOtjvIU4M
         Y4BOjF3PsUsxB1ayhMxO8wznulmK+N46M5KP7ji8RCHKkvuhxLVkT+bc+HA/Z8QDvrBe
         onEQSvH+OHwis2CNTMA94DZl4O3+NJ3sXolO9pUpJpQZOOPZoi2OoobnaOs92W5B0i21
         oG1DszMYhjbig6LOxwqfpTVZf8f+KSBRd4etmU2sjaubkk6NnpC0FJhcl6c8iLY7qo/I
         iQ+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=tyhSSKgzZ4wrpcngkngp3Pi0gbi0Sp5uzScWa9cXiX8=;
        b=Q4LEU2u+XGbUORRKFI5KaX777SoyyWp2egQTQU1MuKCh/9O27Re2xysS1ZO/mvaPng
         S/lxHOPwUwkoVRPDiMN9/EfakhmlywrcX85U6X2YYnxDjYyf6VvcfWN9JIhRt5KzSg7+
         m0cwuJEioQI6T6k80MU9yabE0BtuJW34GQRiak621v4OOuX/fv6Ul/uedm+Nt5jXjtiu
         wnSSYVJwppKdlmvwnpjMxl0OJgZXuAKVTaUJSKurZfIdX15zTCcNJHNCFbHNCxGHggBB
         1QsytcRz8+3U3XDuvt4hbSmaG+ZNl9s/6pG32mg4GMJBjIPuDsWWRWXDY8AzocWdpNbw
         lcdQ==
X-Gm-Message-State: AHYfb5izpWrdR9sg/4t9LH8MtfgNeiITmZ3w5+rbEr23u++JpUXIui+E
        IsVll0wduippeEAspT5FOw==
X-Received: by 10.84.196.129 with SMTP id l1mr18864981pld.337.1502483780728;
        Fri, 11 Aug 2017 13:36:20 -0700 (PDT)
Received: from twelve2.svl.corp.google.com ([100.96.218.24])
        by smtp.gmail.com with ESMTPSA id z189sm2712139pgb.12.2017.08.11.13.36.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 11 Aug 2017 13:36:19 -0700 (PDT)
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>, gitster@pobox.com
Subject: [PATCH 2/2] sha1_file: remove read_packed_sha1()
Date:   Fri, 11 Aug 2017 13:36:15 -0700
Message-Id: <557fbeeac6a0f65d48ba0902f20c0650e75ae332.1502483486.git.jonathantanmy@google.com>
X-Mailer: git-send-email 2.14.0.434.g98096fd7a8-goog
In-Reply-To: <cover.1502483486.git.jonathantanmy@google.com>
References: <cover.1502483486.git.jonathantanmy@google.com>
In-Reply-To: <cover.1502483486.git.jonathantanmy@google.com>
References: <xmqqfucz11yb.fsf@gitster.mtv.corp.google.com> <cover.1502483486.git.jonathantanmy@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Use read_object() in its place instead. This avoids duplication of code.

This makes force_object_loose() slightly slower (because of a redundant
check of loose object storage), but only in the error case.

Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
---
 sha1_file.c | 26 +-------------------------
 1 file changed, 1 insertion(+), 25 deletions(-)

diff --git a/sha1_file.c b/sha1_file.c
index 910109fd9..0f758eabf 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -3062,30 +3062,6 @@ int sha1_object_info(const unsigned char *sha1, unsigned long *sizep)
 	return type;
 }
 
-static void *read_packed_sha1(const unsigned char *sha1,
-			      enum object_type *type, unsigned long *size)
-{
-	struct pack_entry e;
-	void *data;
-
-	if (!find_pack_entry(sha1, &e))
-		return NULL;
-	data = cache_or_unpack_entry(e.p, e.offset, size, type);
-	if (!data) {
-		/*
-		 * We're probably in deep shit, but let's try to fetch
-		 * the required object anyway from another pack or loose.
-		 * This should happen only in the presence of a corrupted
-		 * pack, and is better than failing outright.
-		 */
-		error("failed to read object %s at offset %"PRIuMAX" from %s",
-		      sha1_to_hex(sha1), (uintmax_t)e.offset, e.p->pack_name);
-		mark_bad_packed_object(e.p, sha1);
-		data = read_object(sha1, type, size);
-	}
-	return data;
-}
-
 int pretend_sha1_file(void *buf, unsigned long len, enum object_type type,
 		      unsigned char *sha1)
 {
@@ -3468,7 +3444,7 @@ int force_object_loose(const unsigned char *sha1, time_t mtime)
 
 	if (has_loose_object(sha1))
 		return 0;
-	buf = read_packed_sha1(sha1, &type, &len);
+	buf = read_object(sha1, &type, &len);
 	if (!buf)
 		return error("cannot read sha1_file for %s", sha1_to_hex(sha1));
 	hdrlen = xsnprintf(hdr, sizeof(hdr), "%s %lu", typename(type), len) + 1;
-- 
2.14.0.434.g98096fd7a8-goog

