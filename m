Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1123D1F87F
	for <e@80x24.org>; Thu, 22 Nov 2018 23:06:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407864AbeKWJrx (ORCPT <rfc822;e@80x24.org>);
        Fri, 23 Nov 2018 04:47:53 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:34187 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2392559AbeKWJrx (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 23 Nov 2018 04:47:53 -0500
Received: by mail-wm1-f68.google.com with SMTP id y185so6435064wmd.1
        for <git@vger.kernel.org>; Thu, 22 Nov 2018 15:06:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=gRXteZlaGNdhQmvKsvHbHO5vnsnp6IMoXuH2OBuyVZI=;
        b=ELaTew56zXhjQOayT55q0kVop7K5FzMgCOxynAm8D/CEeA1pig9QQ55K7YvzrCGpXl
         EHS6b4TYWgxsnA+miQyYrqAxDVA6uDpYmrXULrfU10FA1bczCOZziggUlUdRHN9Ehlbw
         OEf823fPq9bQUH+lGyyH1kYwatMmcN8YMdG7GKsiYT7OiY0YARBy1l6W8yRyqwixHyUT
         sS5mrJY/6gDj5BHhBYpLn9eCAkY8qB+SQAy99nuEtnU9wUzhO+1JTj4v1FfOydBwSwnO
         6jZlK82c+V+KsxCJEJ7Yj9kIObp2aHcPRzhsZo4wxX31yv2qqAOH/jCPhbbtHJ7UCYRd
         jFDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=gRXteZlaGNdhQmvKsvHbHO5vnsnp6IMoXuH2OBuyVZI=;
        b=n0EKM/mwJgOM+siEie8FHR9y9vl71r1mC+lL2QgjsXHu4QdsHch18dYcG+1w7EZ1qt
         lVaVrF0tcSZqP0us+xQk4SNMKD1YsjcwcPMTyFDdbytTPPIkJ8TSVcu//rp1xf4DqquP
         iRXF7kYmlaNQDs30QU2jnoH8//TPgobPiR/bIKqVU5XvwcgRUJjGvcarN1ZE6bgcVlHe
         8Zl+3yQfP3T3mMy12Za962p2oj/OzCaN+A2QXgsGwNJpaKYRHJydGajSxnkmf2s6ynr2
         4TEg3Uv0DUpuAlohLDAfDHJB8xI7xpsz3qnhiMfVFA8XfcHRrbxgOChvqlQ60vayg1CR
         yM7g==
X-Gm-Message-State: AA+aEWYPl49vYfuJsHfAAfRBjNlSmd2FR4uKf9y6EvAIjgBsPZeo4eKs
        9nK/0KAAL+faublU5NNhSeIFb1lq
X-Google-Smtp-Source: AFSGD/V3jn99h9JU0ao9IDoGrbKqw/LOEM5DMGv0fvf3bWO4TzEgXdBBGH2iCevN9jFnYFCoc+MtSA==
X-Received: by 2002:a1c:85d2:: with SMTP id h201mr10732290wmd.151.1542927972132;
        Thu, 22 Nov 2018 15:06:12 -0800 (PST)
Received: from localhost.localdomain ([91.250.255.197])
        by smtp.gmail.com with ESMTPSA id v5sm11099670wrr.11.2018.11.22.15.06.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 22 Nov 2018 15:06:11 -0800 (PST)
From:   Paul-Sebastian Ungureanu <ungureanupaulsebastian@gmail.com>
To:     git@vger.kernel.org
Cc:     t.gummerer@gmail.com
Subject: [PATCH v11 01/22] sha1-name.c: add `get_oidf()` which acts like `get_oid()`
Date:   Fri, 23 Nov 2018 01:05:21 +0200
Message-Id: <bbd55849d41892a15021eb2fcfb2ea55efeecd95.1542925164.git.ungureanupaulsebastian@gmail.com>
X-Mailer: git-send-email 2.19.1.878.g0482332a22
In-Reply-To: <cover.1542925164.git.ungureanupaulsebastian@gmail.com>
References: <cover.1542925164.git.ungureanupaulsebastian@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Compared to `get_oid()`, `get_oidf()` has as parameters
a pointer to `object_id`, a printf format string and
additional arguments. This will help simplify the code
in subsequent commits.

Original-idea-by: Johannes Schindelin <johannes.schindelin@gmx.de>
Signed-off-by: Paul-Sebastian Ungureanu <ungureanupaulsebastian@gmail.com>
---
 cache.h     |  1 +
 sha1-name.c | 19 +++++++++++++++++++
 2 files changed, 20 insertions(+)

diff --git a/cache.h b/cache.h
index 8b1ee42ae9..6f1a549489 100644
--- a/cache.h
+++ b/cache.h
@@ -1334,6 +1334,7 @@ struct object_context {
 	GET_OID_BLOB)
 
 extern int get_oid(const char *str, struct object_id *oid);
+extern int get_oidf(struct object_id *oid, const char *fmt, ...);
 extern int get_oid_commit(const char *str, struct object_id *oid);
 extern int get_oid_committish(const char *str, struct object_id *oid);
 extern int get_oid_tree(const char *str, struct object_id *oid);
diff --git a/sha1-name.c b/sha1-name.c
index faa60f69e3..cf0e8a3f85 100644
--- a/sha1-name.c
+++ b/sha1-name.c
@@ -1542,6 +1542,25 @@ int get_oid(const char *name, struct object_id *oid)
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
2.19.1.878.g0482332a22

