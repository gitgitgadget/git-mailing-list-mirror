Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 188011F87F
	for <e@80x24.org>; Thu, 22 Nov 2018 23:06:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2439012AbeKWJrz (ORCPT <rfc822;e@80x24.org>);
        Fri, 23 Nov 2018 04:47:55 -0500
Received: from mail-wm1-f41.google.com ([209.85.128.41]:33529 "EHLO
        mail-wm1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2407865AbeKWJrz (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 23 Nov 2018 04:47:55 -0500
Received: by mail-wm1-f41.google.com with SMTP id 79so10466135wmo.0
        for <git@vger.kernel.org>; Thu, 22 Nov 2018 15:06:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Lp+nls5cK1oTcQpKaKojqHRpT4EgXFuw040N/kyzjtQ=;
        b=lvyNAjbsSkSMy4vl0a22A7lHh1Nxg/diTG2gWAL0OqQFqKJqOJ1IWL8VRkw+56iJWN
         W+hPUoNQUbbhYkQB2cl1Dny5XCweKH6M9+f0jsTOGfkDoNclu4nftBNBWhH9qnamnIJg
         L5E62YJfilgXnO5uHFXpGPsJPMRXY2q2Ic9aWI4B5FOfW9t93R2fh3FQ6XyjCQjOROup
         sWAOLmCn+slIUepd3zq8yAKjLtqYXoJRP/MEXPjMhWNGprGcURjUJOAjpdO6uCZGXJhG
         wNUa40Lfx015niYK1YFsbKchP5dJBzpKX+JtIIDiqOP21Z6NnAJoWpvM1zBO/S9gfAz3
         9UMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Lp+nls5cK1oTcQpKaKojqHRpT4EgXFuw040N/kyzjtQ=;
        b=f2ryQi1wMbn7goOLgSZ6gr6lt8Rm3jsaf+yx5I3WYyA1oNm3TP6iHIuWQbh4syhfnQ
         9y/M80kfTs9PrmnmXZnrKWWa3/g25fj6WcS0taMJYKwUZgoKZGFjky05sSoghyu99T7E
         md/l/6yVgqSMlmUvRYYycEJur8VGzW0jndl2MoTGEnC3CWjvlor8Uv8t31aGhjhKzafk
         y5veyFv8SOvPq1TnTt89lfhcKOdqyh4Uw7LPmSsE6nx/N2+cRGpWO4gJTRTfyTSQoN8r
         v84vwtBDPsH4SRa4YbzgixKCfp3WD1sI0cDAm22B6NbqoQQJwXlSErgjBbwSUUebVmDt
         C96g==
X-Gm-Message-State: AGRZ1gLESblAL4bDAD10DS2uChZjwqkZRxKgOQLZmMTittQfjJQmMpVL
        aofiSgcFKsYEIZ+wG+TiG10uo03x
X-Google-Smtp-Source: AJdET5ejfk42WJkK4VW9bS1njcKMDv1VEFQH+3WS4/WYLwl6ADWV2qmtQv77UgX8fmsAwsvPlJhybw==
X-Received: by 2002:a1c:87cc:: with SMTP id j195mr11224761wmd.2.1542927974436;
        Thu, 22 Nov 2018 15:06:14 -0800 (PST)
Received: from localhost.localdomain ([91.250.255.197])
        by smtp.gmail.com with ESMTPSA id v5sm11099670wrr.11.2018.11.22.15.06.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 22 Nov 2018 15:06:13 -0800 (PST)
From:   Paul-Sebastian Ungureanu <ungureanupaulsebastian@gmail.com>
To:     git@vger.kernel.org
Cc:     t.gummerer@gmail.com
Subject: [PATCH v11 03/22] strbuf.c: add `strbuf_insertf()` and `strbuf_vinsertf()`
Date:   Fri, 23 Nov 2018 01:05:23 +0200
Message-Id: <e8d86fae660a79eabcf4764dfa9986282c097242.1542925164.git.ungureanupaulsebastian@gmail.com>
X-Mailer: git-send-email 2.19.1.878.g0482332a22
In-Reply-To: <cover.1542925164.git.ungureanupaulsebastian@gmail.com>
References: <cover.1542925164.git.ungureanupaulsebastian@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Implement `strbuf_insertf()` and `strbuf_vinsertf()` to
insert data using a printf format string.

Original-idea-by: Johannes Schindelin <johannes.schindelin@gmx.de>
Signed-off-by: Paul-Sebastian Ungureanu <ungureanupaulsebastian@gmail.com>
---
 strbuf.c | 36 ++++++++++++++++++++++++++++++++++++
 strbuf.h |  9 +++++++++
 2 files changed, 45 insertions(+)

diff --git a/strbuf.c b/strbuf.c
index 82e90f1dfe..bfbbdadbf3 100644
--- a/strbuf.c
+++ b/strbuf.c
@@ -249,6 +249,42 @@ void strbuf_insert(struct strbuf *sb, size_t pos, const void *data, size_t len)
 	strbuf_splice(sb, pos, 0, data, len);
 }
 
+void strbuf_vinsertf(struct strbuf *sb, size_t pos, const char *fmt, va_list ap)
+{
+	int len, len2;
+	char save;
+	va_list cp;
+
+	if (pos > sb->len)
+		die("`pos' is too far after the end of the buffer");
+	va_copy(cp, ap);
+	len = vsnprintf(sb->buf + sb->len, 0, fmt, cp);
+	va_end(cp);
+	if (len < 0)
+		BUG("your vsnprintf is broken (returned %d)", len);
+	if (!len)
+		return; /* nothing to do */
+	if (unsigned_add_overflows(sb->len, len))
+		die("you want to use way too much memory");
+	strbuf_grow(sb, len);
+	memmove(sb->buf + pos + len, sb->buf + pos, sb->len - pos);
+	/* vsnprintf() will append a NUL, overwriting one of our characters */
+	save = sb->buf[pos + len];
+	len2 = vsnprintf(sb->buf + pos, sb->alloc - sb->len, fmt, ap);
+	sb->buf[pos + len] = save;
+	if (len2 != len)
+		BUG("your vsnprintf is broken (returns inconsistent lengths)");
+	strbuf_setlen(sb, sb->len + len);
+}
+
+void strbuf_insertf(struct strbuf *sb, size_t pos, const char *fmt, ...)
+{
+	va_list ap;
+	va_start(ap, fmt);
+	strbuf_vinsertf(sb, pos, fmt, ap);
+	va_end(ap);
+}
+
 void strbuf_remove(struct strbuf *sb, size_t pos, size_t len)
 {
 	strbuf_splice(sb, pos, len, "", 0);
diff --git a/strbuf.h b/strbuf.h
index be02150df3..8f8fe01e68 100644
--- a/strbuf.h
+++ b/strbuf.h
@@ -244,6 +244,15 @@ void strbuf_addchars(struct strbuf *sb, int c, size_t n);
  */
 void strbuf_insert(struct strbuf *sb, size_t pos, const void *, size_t);
 
+/**
+ * Insert data to the given position of the buffer giving a printf format
+ * string. The contents will be shifted, not overwritten.
+ */
+void strbuf_vinsertf(struct strbuf *sb, size_t pos, const char *fmt,
+		     va_list ap);
+
+void strbuf_insertf(struct strbuf *sb, size_t pos, const char *fmt, ...);
+
 /**
  * Remove given amount of data from a given position of the buffer.
  */
-- 
2.19.1.878.g0482332a22

