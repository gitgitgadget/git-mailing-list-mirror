Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FROM,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 74E741F405
	for <e@80x24.org>; Thu, 20 Dec 2018 19:44:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731601AbeLTToy (ORCPT <rfc822;e@80x24.org>);
        Thu, 20 Dec 2018 14:44:54 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:40313 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729246AbeLTTox (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 Dec 2018 14:44:53 -0500
Received: by mail-wm1-f66.google.com with SMTP id f188so3492537wmf.5
        for <git@vger.kernel.org>; Thu, 20 Dec 2018 11:44:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=VMuhPYf1g6Cle4TQSNd2MuM/4W+IRDNRjvR8fSkVbk0=;
        b=X+Tijb0zg0mctENAFJo6yJqrVOvz81ZyiReDQRX62mvhALLTJsefAK19AfTLcV98S4
         TQL4U4VSxYKDfE3eqS3iZgmwgVZRshdJzj+G6HtqsS9ASBSHUjPPenRaXQNgja88nuav
         b3egscCYrxLd6Ac5lZGvGswHWVZzjbvQe+faKT93Tgnt9URbjMEg6fJsRVPO+ILmp7K3
         quvIxpiK31JZASTc2hHIN1SQG6T6zcMevgFznfuBl0cOen2EUoFWMqxg+ctpdDtfxVfj
         4l0EkH8yVHej3FoB8geeqQO/9bCcxC4+yegc392DxGpfotC4ukXpYgxvuwJI8L9Fh/vu
         srOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=VMuhPYf1g6Cle4TQSNd2MuM/4W+IRDNRjvR8fSkVbk0=;
        b=YwEdSp1N9xSvqaZB3LW2CLaiwP/KsQ/KefFABQ4M6CR8zjbVbE5fYxkJgdRH7TE5b5
         kxG+1Q4xwL300kzNTrO0dtUsGA6nSQxXeby0Zmdn/EaJ2LmRghGuCEj7ZxstrFtF/Rn6
         ++JMeIrVXwq7d3WVizC9u9NYLAT0fJe7+LGrQNo5YO+aJ4itv4GR5Zx5hj8qnM4xEv5G
         OUlRLBePF+KinPZXRZsk3wS4E6SzFm0ng1cnEPbHZg2MROYfamiqy6dozv4W3v9OqPCG
         uGVkeYkxKDgbpmG2I9Zhk7uSYfGtFL/B4bJv4rnXnFSqb6S8z8SFhvseK+8tpejzXayH
         wvbA==
X-Gm-Message-State: AA+aEWYBOzTr9ULQWn07cRO+Xfnd6GTka6LO0wRbJnEwOFzXv3um+47G
        7h1QWRYUwC+egz91pmGEnLcjjPxG/Fw=
X-Google-Smtp-Source: AFSGD/Xag+7h1MJwI7UCeLmf1YdFbfBxraLfWMNtmVr0toTM+09IAZp0GnizpfHNZs0DzOOfBorbVw==
X-Received: by 2002:a1c:544f:: with SMTP id p15mr12672819wmi.37.1545335091303;
        Thu, 20 Dec 2018 11:44:51 -0800 (PST)
Received: from sebi-laptop.tendawifi.com ([188.24.227.76])
        by smtp.gmail.com with ESMTPSA id j129sm7587267wmb.39.2018.12.20.11.44.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 20 Dec 2018 11:44:50 -0800 (PST)
From:   Paul-Sebastian Ungureanu <ungureanupaulsebastian@gmail.com>
To:     git@vger.kernel.org
Cc:     t.gummerer@gmail.com, Johannes.Schindelin@gmx.de
Subject: [PATCH v12 03/26] strbuf.c: add `strbuf_insertf()` and `strbuf_vinsertf()`
Date:   Thu, 20 Dec 2018 21:44:19 +0200
Message-Id: <2260063a5c93f0cffe68e67f24d191a606ffaab4.1545331726.git.ungureanupaulsebastian@gmail.com>
X-Mailer: git-send-email 2.20.1.336.g43b67505b2.dirty
In-Reply-To: <cover.1545331726.git.ungureanupaulsebastian@gmail.com>
References: <cover.1545331726.git.ungureanupaulsebastian@gmail.com>
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
2.20.1.441.g764a526393

