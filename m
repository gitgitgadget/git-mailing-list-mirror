Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4BECA1F404
	for <e@80x24.org>; Tue,  6 Feb 2018 00:19:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752220AbeBFAT3 (ORCPT <rfc822;e@80x24.org>);
        Mon, 5 Feb 2018 19:19:29 -0500
Received: from mail-pg0-f66.google.com ([74.125.83.66]:34077 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752199AbeBFAT1 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Feb 2018 19:19:27 -0500
Received: by mail-pg0-f66.google.com with SMTP id s73so173863pgc.1
        for <git@vger.kernel.org>; Mon, 05 Feb 2018 16:19:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=s4RDyz4qj4NesiAIRUU55ruG7JN4xaTQTwUlOzplyd4=;
        b=Yfetd6/suIdmNzeIO4qK0P+D1S18JTjw63b2DvMU8Yu5DIybDzJoQ1QrQddEmIAjPF
         hi2lpGxCq5veY0vA4umGTbLAEXIn/3Rtt3rCvRY9EtIKag9FwzU9jW1By1HM9+/Qk3+9
         IlxVgtfJesBwRAAIGWJ7iBSq3C+gLUoPawocUY3RV8WYt6eJvaHH8sqce3OR72bF1Tj0
         kurmzP+5GRFQlzFneCb1pNJbyxshYkA5a9Pm3nJIfEifnF3S1yNecqL23ONjomSZan9f
         j6QcAmmNIUXb5qMU6Wpb4m3FwzhAPz8KK8RcYbr5xw48WHEUY9N2hDxTYsSXgGjjwMEo
         BaVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=s4RDyz4qj4NesiAIRUU55ruG7JN4xaTQTwUlOzplyd4=;
        b=m6B2CtIOQFXJnVeAm3d+Rz/jOtseY7OpnC7Iu8Byp5GPCRseu88WPcHftQw2YNq11O
         NhNYYTMnJNxA0fPPm2aL35RBgyhmHYFvmR/PYyeh40sY/IuPRlE7A3RPKRmNE2rMlDQJ
         iepr3IgbLg7JefBrpQR7+MBhfVm821tI9UNEWZ7bVIv5SOKq0gilfen3jjympwlOPUf9
         6c2z1FEy9fI3VG7wdxfxA5X3ovMWsEUbWLAOuYf5dMqGEoa0iyLITYggfCP502CYU5Zb
         0AWTwqZhsB2pxvV81txUjHZ5RqbIbmPUiRitJVJF0ZjP4vrjSzgf3rlFY/LSbWpRM6ov
         75mA==
X-Gm-Message-State: APf1xPAGqJJ0X74GS4YGGa/wOrAaBxOGy0hHazPTWNdEvUH/pkcbkN2D
        WZG01cGsDdKjdelktAp0S8xt5MI1dk4=
X-Google-Smtp-Source: AH8x226r+fCcjMMpgMgRzk7dXlirei+qxUQM3czfknvMMo5Bog2KKVjDUTakold2QuRDQTsUAHEoBA==
X-Received: by 10.98.147.85 with SMTP id b82mr522736pfe.203.1517876365869;
        Mon, 05 Feb 2018 16:19:25 -0800 (PST)
Received: from localhost ([2620:0:100e:422:2d12:5719:3437:fdb7])
        by smtp.gmail.com with ESMTPSA id a87sm18916338pfj.13.2018.02.05.16.19.25
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 05 Feb 2018 16:19:25 -0800 (PST)
From:   Stefan Beller <sbeller@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Nieder <jrnieder@gmail.com>,
        Stefan Beller <sbeller@google.com>
Subject: [PATCH 109/194] object-store: move check_sha1_signature to object-store.h
Date:   Mon,  5 Feb 2018 16:16:24 -0800
Message-Id: <20180206001749.218943-11-sbeller@google.com>
X-Mailer: git-send-email 2.15.1.433.g936d1b9894.dirty
In-Reply-To: <20180206001749.218943-1-sbeller@google.com>
References: <20180205235508.216277-1-sbeller@google.com>
 <20180206001749.218943-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jonathan Nieder <jrnieder@gmail.com>

When map == NULL, check_sha1_signature reads the object from the
object store to hash it.  Move the declaration of this function to
object-store.h to make it easier to find.

While at it, clarify the comment describing its API.

Signed-off-by: Stefan Beller <sbeller@google.com>
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 cache.h        | 2 --
 object-store.h | 9 +++++++++
 sha1_file.c    | 6 ------
 3 files changed, 9 insertions(+), 8 deletions(-)

diff --git a/cache.h b/cache.h
index 634172cec4..15ba480ac3 100644
--- a/cache.h
+++ b/cache.h
@@ -1195,8 +1195,6 @@ extern int git_open_cloexec(const char *name, int flags);
 extern int unpack_sha1_header(git_zstream *stream, unsigned char *map, unsigned long mapsize, void *buffer, unsigned long bufsiz);
 extern int parse_sha1_header(const char *hdr, unsigned long *sizep);
 
-extern int check_sha1_signature(const unsigned char *sha1, void *buf, unsigned long size, const char *type);
-
 extern int finalize_object_file(const char *tmpfile, const char *filename);
 
 /* Helper to check and "touch" a file */
diff --git a/object-store.h b/object-store.h
index d009f952f8..a0e9824406 100644
--- a/object-store.h
+++ b/object-store.h
@@ -99,6 +99,15 @@ extern int pretend_sha1_file(void *, unsigned long, enum object_type, unsigned c
 extern int force_object_loose(const unsigned char *sha1, time_t mtime);
 extern void *map_sha1_file(struct repository *r, const unsigned char *sha1, unsigned long *size);
 
+/*
+ * Rehash an object's data to make sure the object name actually matches
+ * "sha1" to detect object corruption.
+ *
+ * The in-core object data should be in "map". If "map" == NULL, reads the
+ * named object using the streaming interface and rehashes it on the fly.
+ */
+extern int check_sha1_signature(const unsigned char *sha1, void *buf, unsigned long size, const char *type);
+
 /*
  * Convenience for sha1_object_info_extended() with a NULL struct
  * object_info. OBJECT_INFO_SKIP_CACHED is automatically set; pass
diff --git a/sha1_file.c b/sha1_file.c
index aa564e3ad4..3262075497 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -802,12 +802,6 @@ void *xmmap(void *start, size_t length,
 	return ret;
 }
 
-/*
- * With an in-core object data in "map", rehash it to make sure the
- * object name actually matches "sha1" to detect object corruption.
- * With "map" == NULL, try reading the object named with "sha1" using
- * the streaming interface and rehash it to do the same.
- */
 int check_sha1_signature(const unsigned char *sha1, void *map,
 			 unsigned long size, const char *type)
 {
-- 
2.15.1.433.g936d1b9894.dirty

