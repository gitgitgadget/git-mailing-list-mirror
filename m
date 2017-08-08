Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6718E20899
	for <e@80x24.org>; Tue,  8 Aug 2017 19:32:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752253AbdHHTcx (ORCPT <rfc822;e@80x24.org>);
        Tue, 8 Aug 2017 15:32:53 -0400
Received: from mail-pg0-f43.google.com ([74.125.83.43]:37988 "EHLO
        mail-pg0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752149AbdHHTcv (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Aug 2017 15:32:51 -0400
Received: by mail-pg0-f43.google.com with SMTP id l64so18549287pge.5
        for <git@vger.kernel.org>; Tue, 08 Aug 2017 12:32:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=Y5Ee5IvCOP24ZSkcCM+TB893wxkweXsQMXPK6ZR222c=;
        b=uI+PBX4vf6yzLIiHB/2GvGQbE0BsVUVnxhvIhuLuqkayhgI0BEFWShdyL56z/M2uxW
         ZeVbgJK0UIRujDLEssMmITBiQ9mMd6Boy4zpDny14UYbmPpDakbCmdf82uhohPhJen03
         M/6gEEyTHowb9nasAf3D8FYA84Z4eG0IvMvNY52AMDCAG3Z1JNDsx2i9kUuttAHJE+7M
         3gVrZ46PmmfqDNYBXak+B4Z8zOyq24uVHHuN0u9F3cj1LaLO0M7zhmJx0Emnjg1zeyRX
         uMyI8/z7l55EIv8Mb8LRf5f9SylA+r2/8lr5bIZpjgy2w7phjmTJ7gzPaW8BXrStHL0P
         Yr/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=Y5Ee5IvCOP24ZSkcCM+TB893wxkweXsQMXPK6ZR222c=;
        b=o84r1a/ZSxtmWBQDSkD5Ab7cb+Mwo4L5lhKx3vTmXc0v9rE6hsV2fQxE3tkyaz0KM1
         udccESXtU6qI/rSbw/85OdE/YfmcpdeBKFCVvVbRwulfxk21Di10E4ijXVnIPsJ3fJBf
         nTJk8kuH+MmhNioTyHZd7i2AAiIfZdPv9+isIkF1NshCOU53/x0kG+jtZKE1chKXU9Xn
         EbGR3bdzTxdsiaEj5ySoCPZq0ViA3E5o3JDfYiJfKTFt/fWUuDWyQsbP0Kl23juvjrtp
         1aqKNMh2v05Sja79wfMKaRdBk7xXFEz0B34bt5b+sRY23Creo/UsKdIyHTxVJ1Jz85/x
         +Tvw==
X-Gm-Message-State: AHYfb5ixpnprYH1DNLayqYWL5KOwO2dsS0FBVLc6YBcCkMzZN3K1YCj3
        iJFXVoALnN6yTuie4NxOuA==
X-Received: by 10.84.151.3 with SMTP id i3mr5921431pli.377.1502220769429;
        Tue, 08 Aug 2017 12:32:49 -0700 (PDT)
Received: from twelve2.svl.corp.google.com ([100.96.218.24])
        by smtp.gmail.com with ESMTPSA id k186sm4332547pfc.173.2017.08.08.12.32.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 08 Aug 2017 12:32:47 -0700 (PDT)
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>
Subject: [RFC PATCH 02/10] pack: move static state variables
Date:   Tue,  8 Aug 2017 12:32:32 -0700
Message-Id: <20a79889f8993d8e532f06ab18d298d40550081d.1502220307.git.jonathantanmy@google.com>
X-Mailer: git-send-email 2.14.0.434.g98096fd7a8-goog
In-Reply-To: <cover.1502220307.git.jonathantanmy@google.com>
References: <cover.1502220307.git.jonathantanmy@google.com>
In-Reply-To: <cover.1502220307.git.jonathantanmy@google.com>
References: <cover.1502220307.git.jonathantanmy@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

sha1_file.c declares some static variables that store packfile-related
state. Move them to pack.c.

They are temporarily made global, but subsequent commits will restore
their scope back to static.

Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
---
 pack.c      | 14 ++++++++++++++
 pack.h      |  9 +++++++++
 sha1_file.c | 13 -------------
 3 files changed, 23 insertions(+), 13 deletions(-)

diff --git a/pack.c b/pack.c
index 0d191dfd6..0f46e0617 100644
--- a/pack.c
+++ b/pack.c
@@ -1,4 +1,5 @@
 #include "cache.h"
+#include "mru.h"
 
 char *odb_pack_name(struct strbuf *buf,
 		    const unsigned char *sha1,
@@ -21,3 +22,16 @@ char *sha1_pack_index_name(const unsigned char *sha1)
 	static struct strbuf buf = STRBUF_INIT;
 	return odb_pack_name(&buf, sha1, "idx");
 }
+
+unsigned int pack_used_ctr;
+unsigned int pack_mmap_calls;
+unsigned int peak_pack_open_windows;
+unsigned int pack_open_windows;
+unsigned int pack_open_fds;
+unsigned int pack_max_fds;
+size_t peak_pack_mapped;
+size_t pack_mapped;
+struct packed_git *packed_git;
+
+static struct mru packed_git_mru_storage;
+struct mru *packed_git_mru = &packed_git_mru_storage;
diff --git a/pack.h b/pack.h
index 63bfde00c..7fcd45f7b 100644
--- a/pack.h
+++ b/pack.h
@@ -124,4 +124,13 @@ extern char *sha1_pack_name(const unsigned char *sha1);
  */
 extern char *sha1_pack_index_name(const unsigned char *sha1);
 
+extern unsigned int pack_used_ctr;
+extern unsigned int pack_mmap_calls;
+extern unsigned int peak_pack_open_windows;
+extern unsigned int pack_open_windows;
+extern unsigned int pack_open_fds;
+extern unsigned int pack_max_fds;
+extern size_t peak_pack_mapped;
+extern size_t pack_mapped;
+
 #endif
diff --git a/sha1_file.c b/sha1_file.c
index 7e511ce9e..4d95e21eb 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -682,19 +682,6 @@ static int has_loose_object(const unsigned char *sha1)
 	return check_and_freshen(sha1, 0);
 }
 
-static unsigned int pack_used_ctr;
-static unsigned int pack_mmap_calls;
-static unsigned int peak_pack_open_windows;
-static unsigned int pack_open_windows;
-static unsigned int pack_open_fds;
-static unsigned int pack_max_fds;
-static size_t peak_pack_mapped;
-static size_t pack_mapped;
-struct packed_git *packed_git;
-
-static struct mru packed_git_mru_storage;
-struct mru *packed_git_mru = &packed_git_mru_storage;
-
 void pack_report(void)
 {
 	fprintf(stderr,
-- 
2.14.0.434.g98096fd7a8-goog

