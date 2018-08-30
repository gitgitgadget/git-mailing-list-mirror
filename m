Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B35871F404
	for <e@80x24.org>; Thu, 30 Aug 2018 21:41:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727292AbeHaBpx (ORCPT <rfc822;e@80x24.org>);
        Thu, 30 Aug 2018 21:45:53 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:52162 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727067AbeHaBpw (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 30 Aug 2018 21:45:52 -0400
Received: by mail-wm0-f66.google.com with SMTP id y2-v6so3342524wma.1
        for <git@vger.kernel.org>; Thu, 30 Aug 2018 14:41:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=lj6ZeJFCKpMz6bq2/hl7y0bt2MakdMy1e5Pg26NUdhY=;
        b=t4+ZICfDAswwVtPxz+8i3aoU6fXRmriA06InF8sZhJYcSv938TlflxDV50ZaYprdXB
         YUuvOO9rdgnm7Dl9mebpg1j5GF0vkT2dnAnW6R08cBX1RgKjjBX29G+VIWeVRnfqkU4s
         mNAOO10HCW2Is0PeXXDlU4GWS4ZmWgD1valXBLJ0umg+U6tE0yLWpda+2iWzvYNKhnkh
         acAV3h/niPGQdlhulGBX6PW/9qeORGltYDzZEo85CYLE08H26TmR9KDXgu0US2kvEw9A
         0T+8J1JpMpqglIbQz6KIhFEk6gKUB69amM7lxgxpjwY/SL3mwYmoJ+KkUPxwqRtznsQQ
         LDMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=lj6ZeJFCKpMz6bq2/hl7y0bt2MakdMy1e5Pg26NUdhY=;
        b=DSuic9pgb6qfRAAfCzT7xfvz0binmqn/7TBtuaCfrdGH8gcTPkbqRNAZTUqu4UtMQR
         2GUoLcdOgAV8//P6tLAquo2dbA6sR4jpfKv0Fjyukrc1AIh78YjLngxJkyGS0+3Ci2CZ
         Bc5u0Wf3rtCmwewhJN2vzfqOj9kr6rFeYluLZKTYJzKdq0lyNgnnAKoIx6xdlHkVOUvB
         nvkz/D3EY9o4ZxciZq6YRdm7jxjIJtaO6XTW26YsH7ve3ZxJRjayRo3g+sDoOR+BFae+
         pbANaRDMawPC/Vz+Q58V4YqSyez7T8OdKVAkv96d1Y5D9a/4lOxi+4X/tO3l8PUp8T2M
         90/g==
X-Gm-Message-State: APzg51B0XPd/79fe4fOu13av/JXrnSg3efldubEYhBju1wd/i7fTem7K
        zXAtF/ptQjdItmentkqRTvQPPPhk
X-Google-Smtp-Source: ANB0VdZOc+miflolZ01lH6lDfZtssMqOr9u8k0yoSDek4bhCaofZMLXylBg/h5GFfUYfKX5TStOm8A==
X-Received: by 2002:a1c:c7c3:: with SMTP id x186-v6mr2946074wmf.109.1535665299007;
        Thu, 30 Aug 2018 14:41:39 -0700 (PDT)
Received: from sebi-laptop.tendawifi.com ([188.24.241.57])
        by smtp.gmail.com with ESMTPSA id x24-v6sm14445951wrd.13.2018.08.30.14.41.38
        for <git@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 30 Aug 2018 14:41:38 -0700 (PDT)
From:   Paul-Sebastian Ungureanu <ungureanupaulsebastian@gmail.com>
To:     git@vger.kernel.org
Subject: [GSoC][PATCH v8 01/20] sha1-name.c: add `get_oidf()` which acts like `get_oid()`
Date:   Fri, 31 Aug 2018 00:40:31 +0300
Message-Id: <b21cdeb1636b679d80ff554c48bc76516aed2cf6.1535665109.git.ungureanupaulsebastian@gmail.com>
X-Mailer: git-send-email 2.19.0.rc0.22.gc26283d74e
In-Reply-To: <cover.1535665109.git.ungureanupaulsebastian@gmail.com>
References: <cover.1535665109.git.ungureanupaulsebastian@gmail.com>
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
index b1fd3d58ab..d93b2e25a5 100644
--- a/cache.h
+++ b/cache.h
@@ -1309,6 +1309,7 @@ struct object_context {
 	GET_OID_BLOB)
 
 extern int get_oid(const char *str, struct object_id *oid);
+extern int get_oidf(struct object_id *oid, const char *fmt, ...);
 extern int get_oid_commit(const char *str, struct object_id *oid);
 extern int get_oid_committish(const char *str, struct object_id *oid);
 extern int get_oid_tree(const char *str, struct object_id *oid);
diff --git a/sha1-name.c b/sha1-name.c
index c9cc1318b7..261b960bbd 100644
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
2.19.0.rc0.22.gc26283d74e

