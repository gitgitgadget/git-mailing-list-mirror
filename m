Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 083631F405
	for <e@80x24.org>; Wed,  8 Aug 2018 18:59:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730098AbeHHVUS (ORCPT <rfc822;e@80x24.org>);
        Wed, 8 Aug 2018 17:20:18 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:42583 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729679AbeHHVUR (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Aug 2018 17:20:17 -0400
Received: by mail-wr1-f65.google.com with SMTP id e7-v6so2909434wrs.9
        for <git@vger.kernel.org>; Wed, 08 Aug 2018 11:59:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=GgRi6l/oGc4yrRxR1lKuI1vooLsPJKGOfwkIDcmucKo=;
        b=MhOZ461s1bUZ0qUzoGz4o63jOuvV1uJJHAfe4e8k3+zhMpPYJ24/V0rwKwJQ+0c2N/
         d8QT7Ph2ttdhMr22wsSmQQrSW0UlnY9/oNIASnooP5FTwxE9GPQpvikTVmDYI833BPxk
         xVwPw4PtAECn0NkzN79E6kFmaOKzTz6mOtqzMb/o5ch/eNpJ2PxMkANrTZNKF9u+LtfN
         aM6sYj9lvtNZ0txeIQZb/NwMgilmSyo4WzEWNsLAMpe4vx9t+1n74VF4eMgjGNYNWgGx
         XezCyfIA0yEHRtJwa9GFRpNXRNT3ZE4DoZOdqiW6d1n7uygdQPh4cWUvhQ8H4TfA2/U+
         pSbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=GgRi6l/oGc4yrRxR1lKuI1vooLsPJKGOfwkIDcmucKo=;
        b=HshYlmaYvk+ngklp+Kt5kYZ3OgIldap7y/QMT1yqmG9pLxttwHe22nAgldMT2wB+p3
         v+yGGlU/o3oJe0bd0fp0QgQ4YXN4FmQCqPw7YKPN7yZcIpYYAv7ZMnKSfbSc8e0gjHtL
         0Ewx9A8aACanfbuc8vBMZ3JXSDSjpblMEgq8+2z0vrgMH/ZcgPYoBkht+6XaKajBwuNU
         pKroRB1vIwKnwc+N99bRn7s2N24q3G5yJVCRBvBNzkqyzZDkL7f0AGL18XTIqTZtjehM
         BiXszx9PPssmXnSj0AyD3xdNNYMdBQOOok92G3AXg0PJ/y0o/4vGw1fEdFL02kCqpCN9
         9Wow==
X-Gm-Message-State: AOUpUlEY1iyn1c2uDrUDaCt1VE0+tQqaW0NQ3e9Q2AeAO5gSEBjpu7ep
        xvGHGcxu9QRXcFZJmeChoAWAcxyJ
X-Google-Smtp-Source: AA+uWPylLU13H9NOlR7nAEA+VdX+iHJYwl2dik9KAfyaecrbjouJSJ5Kjs4DWyr3lkh+IJdPAauN3g==
X-Received: by 2002:adf:99ea:: with SMTP id y97-v6mr2626365wrb.215.1533754755858;
        Wed, 08 Aug 2018 11:59:15 -0700 (PDT)
Received: from sebi-laptop.tendawifi.com ([86.127.74.86])
        by smtp.gmail.com with ESMTPSA id p5-v6sm4238879wre.32.2018.08.08.11.59.14
        for <git@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 08 Aug 2018 11:59:15 -0700 (PDT)
From:   Paul-Sebastian Ungureanu <ungureanupaulsebastian@gmail.com>
To:     git@vger.kernel.org
Subject: [GSoC][PATCH v7 01/26] sha1-name.c: added 'get_oidf', which acts like 'get_oid'
Date:   Wed,  8 Aug 2018 21:58:40 +0300
Message-Id: <03006713a841adf68340f0dcf39ee17c99060eeb.1533753605.git.ungureanupaulsebastian@gmail.com>
X-Mailer: git-send-email 2.18.0.573.g56500d98f
In-Reply-To: <cover.1533753605.git.ungureanupaulsebastian@gmail.com>
References: <cover.1533753605.git.ungureanupaulsebastian@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Compared to 'get_oid', 'get_oidf' has as parameters a
printf format string and the additional arguments. This
will help simplify the code in subsequent commits.

Original-idea-by: Johannes Schindelin <johannes.schindelin@gmx.de>
Signed-off-by: Paul-Sebastian Ungureanu <ungureanupaulsebastian@gmail.com>
---
 cache.h     |  1 +
 sha1-name.c | 19 +++++++++++++++++++
 2 files changed, 20 insertions(+)

diff --git a/cache.h b/cache.h
index 8dc7134f0..4ec09b336 100644
--- a/cache.h
+++ b/cache.h
@@ -1321,6 +1321,7 @@ struct object_context {
 	GET_OID_BLOB)
 
 extern int get_oid(const char *str, struct object_id *oid);
+extern int get_oidf(struct object_id *oid, const char *fmt, ...);
 extern int get_oid_commit(const char *str, struct object_id *oid);
 extern int get_oid_committish(const char *str, struct object_id *oid);
 extern int get_oid_tree(const char *str, struct object_id *oid);
diff --git a/sha1-name.c b/sha1-name.c
index c9cc1318b..261b960bb 100644
--- a/sha1-name.c
+++ b/sha1-name.c
@@ -1471,6 +1471,25 @@ int get_oid(const char *name, struct object_id *oid)
 	return get_oid_with_context(name, 0, oid, &unused);
 }
 
+/*
+ * This returns a non-zero value if the string (built using printf
+ * format and the given arguments) is not a valid object.
+ */
+int get_oidf(struct object_id *oid, const char *fmt, ...)
+{
+	va_list ap;
+	int ret;
+	struct strbuf sb = STRBUF_INIT;
+
+	va_start(ap, fmt);
+	strbuf_vaddf(&sb, fmt, ap);
+	va_end(ap);
+
+	ret = get_oid(sb.buf, oid);
+	strbuf_release(&sb);
+
+	return ret;
+}
 
 /*
  * Many callers know that the user meant to name a commit-ish by
-- 
2.18.0.573.g56500d98f

