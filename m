Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 19C0B1F404
	for <e@80x24.org>; Tue,  6 Feb 2018 00:20:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752172AbeBFAUZ (ORCPT <rfc822;e@80x24.org>);
        Mon, 5 Feb 2018 19:20:25 -0500
Received: from mail-pg0-f67.google.com ([74.125.83.67]:42326 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752037AbeBFAUX (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Feb 2018 19:20:23 -0500
Received: by mail-pg0-f67.google.com with SMTP id m28so156209pgc.9
        for <git@vger.kernel.org>; Mon, 05 Feb 2018 16:20:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=DJZw8NfogAgEkEWtohWMNCIpcoOxFynVPoa5H8++hUU=;
        b=da40sgcZcbkVeav5I96r5cVmNDx4yKD8KxMQokb9v11DKxHweg/E8riU5fGYWoHETO
         pBfTabqtlTikc0cRUuR6BW7MLbXLFDP37x1gQgloyNPpC86csaLBnPuaFFBMfeYKkrOA
         20FTdOvJBpnpgQf3RgLpEI0Y8Aew7UCewSlHGKLf3sjKITP/1NKvM2J4kU+4YsMYQIIx
         +xZLgWZPrKg0xQcZgXCmdG9/zholha9NQ6E6cREZtLrxZC9psqPYzvCkzd540o3yNkM2
         Fev6p8+iw/Erd8pV43k8zWQ7eIebVRlnsOQPb9Muo6dwZ9F9OpqFU9k8RseHHAi+4v42
         TSeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=DJZw8NfogAgEkEWtohWMNCIpcoOxFynVPoa5H8++hUU=;
        b=mPeNj3zETPCZs+00jFmjrIrJ7iyEjIJttP3S3JLcstQY/olRgxd8RC32IV/yygvMLm
         mVwf6hdAiYAvwlYCvqBQJm/bQGb38lJtk+WTb32vwqlQV9wOFwm0Y/PxfMmcF8GW/se5
         kgpUnp7yKMvtuFfHHVNv5USjbzUzoLDBNLzprZ7mfKj59lIDN9nE4SpZ4bN3PY4fD9O3
         Y/deyD/20o6KMPLqKCc8/cOvPHxCii89FUMEnSFbbo7au/HH0EWdngVJdsbblIJnJvSr
         lTosP00V+A8HbdzBuDNce+7Gx0eWmGDLVLUD8Nlpv0uDXLpv2rqVAmuV9C/R2/X2rv+h
         2tCg==
X-Gm-Message-State: APf1xPD6QDhwz77RPHAgGizb91EDnKIqTshTwl1HJY4pvKyxHGIV7VKc
        v6oviq5X9c+VOWvUJXaPaybggWVcXSg=
X-Google-Smtp-Source: AH8x225Tr5LcLTY7VM+U5Ua5cTXhn2BjYzAqP3QP8j9Pu9Xatxn7+/do04ZmZmH3aa6ktU0FDSSJww==
X-Received: by 10.99.111.71 with SMTP id k68mr428975pgc.360.1517876422185;
        Mon, 05 Feb 2018 16:20:22 -0800 (PST)
Received: from localhost ([2620:0:100e:422:2d12:5719:3437:fdb7])
        by smtp.gmail.com with ESMTPSA id l64sm20587705pfg.62.2018.02.05.16.20.21
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 05 Feb 2018 16:20:21 -0800 (PST)
From:   Stefan Beller <sbeller@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Nieder <jrnieder@gmail.com>,
        Stefan Beller <sbeller@google.com>
Subject: [PATCH 114/194] object: move read_object_with_reference to object.h
Date:   Mon,  5 Feb 2018 16:16:29 -0800
Message-Id: <20180206001749.218943-16-sbeller@google.com>
X-Mailer: git-send-email 2.15.1.433.g936d1b9894.dirty
In-Reply-To: <20180206001749.218943-1-sbeller@google.com>
References: <20180205235508.216277-1-sbeller@google.com>
 <20180206001749.218943-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jonathan Nieder <jrnieder@gmail.com>

This should make the function easier to find, alongside other
functions that parse and act on the content of objects.

While at it, add a comment describing the function's API.

Signed-off-by: Stefan Beller <sbeller@google.com>
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 cache.h  |  5 -----
 object.h | 16 ++++++++++++++++
 2 files changed, 16 insertions(+), 5 deletions(-)

diff --git a/cache.h b/cache.h
index 15ba480ac3..89422e7976 100644
--- a/cache.h
+++ b/cache.h
@@ -1351,11 +1351,6 @@ extern int df_name_compare(const char *name1, int len1, int mode1, const char *n
 extern int name_compare(const char *name1, size_t len1, const char *name2, size_t len2);
 extern int cache_name_stage_compare(const char *name1, int len1, int stage1, const char *name2, int len2, int stage2);
 
-extern void *read_object_with_reference(const unsigned char *sha1,
-					const char *required_type,
-					unsigned long *size,
-					unsigned char *sha1_ret);
-
 extern struct object *peel_to_type(const char *name, int namelen,
 				   struct object *o, enum object_type);
 
diff --git a/object.h b/object.h
index c9ea2285e8..d676404f00 100644
--- a/object.h
+++ b/object.h
@@ -108,6 +108,22 @@ extern void *create_object(struct repository *r, const unsigned char *sha1, void
 
 void *object_as_type(struct object *obj, enum object_type type, int quiet);
 
+/*
+ * Resolves 'sha1' to an object of the specified type and returns the
+ * raw content of the resulting object.
+ *
+ * For example, with required_type == OBJ_TREE, this can be passed a
+ * tree, commit, or tag object id to get the raw tree object pointed
+ * to by the named object.
+ *
+ * Returns NULL if 'sha1' can not be peeled to an object of the
+ * specified type.
+ */
+extern void *read_object_with_reference(const unsigned char *sha1,
+					const char *required_type,
+					unsigned long *size,
+					unsigned char *sha1_ret);
+
 /*
  * Returns the object, having parsed it to find out what it is.
  *
-- 
2.15.1.433.g936d1b9894.dirty

