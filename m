Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9CC0C1F404
	for <e@80x24.org>; Tue,  6 Feb 2018 00:10:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752155AbeBFAKr (ORCPT <rfc822;e@80x24.org>);
        Mon, 5 Feb 2018 19:10:47 -0500
Received: from mail-pg0-f68.google.com ([74.125.83.68]:39773 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752132AbeBFAKq (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Feb 2018 19:10:46 -0500
Received: by mail-pg0-f68.google.com with SMTP id w17so141974pgv.6
        for <git@vger.kernel.org>; Mon, 05 Feb 2018 16:10:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=MHlgaxluT7pqj6Y3u8y7C/L6IEDeHIaaUaylhUz5xck=;
        b=TLYMNwVROiJs/FpYY3pCcbUWed3ydkN3wlXbdtwhHovxK2wqhrxyXTzAhVeqAfiWbD
         3EwZ+rF8oKJbV0nBaastaLcDoYJ+MVbieyndrojHDyrtVIH/NkxBOfi3zHETL0Zf5WFE
         c/IcntJwy8nGtrDRqtJ86fS5YO/5juPhivy01i4j8sDFe2rYvMdv2HfgbKvjf4oHmNcs
         JXIaope/UOAa4MoIHW9SrPbpY9QXmC0Wz41tY6YQi+z1vKMW1L1zapoFwY8pxMde+Tr+
         1mhBaBTM+tbRim74rbvYWcXsbDWhGUrkEJX7Es7hbK8AZqSYJA1DKruTQLD06FC2NbKV
         yS9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=MHlgaxluT7pqj6Y3u8y7C/L6IEDeHIaaUaylhUz5xck=;
        b=Fowx92UV2a5w1u/4u747TxfyiIKeH6NkE+xx397X6STmlmP2tWPgnMpvv0nreD2JNw
         8vh3qJADflUJmzQxaAmrw+vew8si56qyLCCOa0H4WEuGd/OxJAd2WrtQdTzIJLAZ8fHC
         cqYo4Cu+DFn/nDUFT4W/KqiTvKwyyyiQBSS38ptFpQmo/8JGaPWuebgFXZHJiCEVYXVP
         1/3XfIji1gYLxCgNDMU0+kSYlDo1sBDoUFsO6jFFNxAEq1M/4m7PD/WDZ0WMMvz0ugJW
         F/TVog7/UAY6hjvxf7gyZSf++WZKO1zmVPLoSnfGnobcAp9dVk7G580zxWYHO+l5qbO0
         kXAA==
X-Gm-Message-State: APf1xPDhYwef6tt4ssKmzXN5lQbuv8hRVQgjPDr5+YmhMtb1zPop13if
        MfvnA6SjJoBoWOrIgWTGA6hu4VlMVNo=
X-Google-Smtp-Source: AH8x225ORINaOWzQe6nhK1krDe7BAJdmRjwVB0Cb74wCs9M4d10XkmpdcTvwvK8ieRcXG/TbJKmM+A==
X-Received: by 10.101.68.202 with SMTP id g10mr434422pgs.210.1517875844791;
        Mon, 05 Feb 2018 16:10:44 -0800 (PST)
Received: from localhost ([2620:0:100e:422:2d12:5719:3437:fdb7])
        by smtp.gmail.com with ESMTPSA id z128sm20476874pfb.36.2018.02.05.16.10.44
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 05 Feb 2018 16:10:44 -0800 (PST)
From:   Stefan Beller <sbeller@google.com>
To:     git@vger.kernel.org
Cc:     Stefan Beller <sbeller@google.com>
Subject: [PATCH 078/194] cache.h: migrate the definition of object_id to object.h
Date:   Mon,  5 Feb 2018 15:55:39 -0800
Message-Id: <20180205235735.216710-58-sbeller@google.com>
X-Mailer: git-send-email 2.15.1.433.g936d1b9894.dirty
In-Reply-To: <20180205235735.216710-1-sbeller@google.com>
References: <20180205235508.216277-1-sbeller@google.com>
 <20180205235735.216710-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In the following patch we'll need the struct object completely accessible
in object.h, which includes an object_id. Move the definition of the
object_id there, to enable this.

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 cache.h  | 13 +------------
 object.h | 12 ++++++++++++
 2 files changed, 13 insertions(+), 12 deletions(-)

diff --git a/cache.h b/cache.h
index 22404de92b..634172cec4 100644
--- a/cache.h
+++ b/cache.h
@@ -15,6 +15,7 @@
 #include "path.h"
 #include "sha1-array.h"
 #include "repository.h"
+#include "object.h"
 
 #ifndef platform_SHA_CTX
 /*
@@ -66,18 +67,6 @@ int git_deflate_end_gently(git_zstream *);
 int git_deflate(git_zstream *, int flush);
 unsigned long git_deflate_bound(git_zstream *, unsigned long);
 
-/* The length in bytes and in hex digits of an object name (SHA-1 value). */
-#define GIT_SHA1_RAWSZ 20
-#define GIT_SHA1_HEXSZ (2 * GIT_SHA1_RAWSZ)
-
-/* The length in byte and in hex digits of the largest possible hash value. */
-#define GIT_MAX_RAWSZ GIT_SHA1_RAWSZ
-#define GIT_MAX_HEXSZ GIT_SHA1_HEXSZ
-
-struct object_id {
-	unsigned char hash[GIT_MAX_RAWSZ];
-};
-
 #define the_hash_algo the_repository->hash_algo
 
 #if defined(DT_UNKNOWN) && !defined(NO_D_TYPE_IN_DIRENT)
diff --git a/object.h b/object.h
index f34461d4af..fbccb09257 100644
--- a/object.h
+++ b/object.h
@@ -43,6 +43,18 @@ struct object_array {
  */
 #define FLAG_BITS  27
 
+/* The length in bytes and in hex digits of an object name (SHA-1 value). */
+#define GIT_SHA1_RAWSZ 20
+#define GIT_SHA1_HEXSZ (2 * GIT_SHA1_RAWSZ)
+
+/* The length in byte and in hex digits of the largest possible hash value. */
+#define GIT_MAX_RAWSZ GIT_SHA1_RAWSZ
+#define GIT_MAX_HEXSZ GIT_SHA1_HEXSZ
+
+struct object_id {
+	unsigned char hash[GIT_MAX_RAWSZ];
+};
+
 /*
  * The object type is stored in 3 bits.
  */
-- 
2.15.1.433.g936d1b9894.dirty

