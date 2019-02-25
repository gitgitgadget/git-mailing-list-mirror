Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2939020248
	for <e@80x24.org>; Mon, 25 Feb 2019 23:16:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728949AbfBYXQx (ORCPT <rfc822;e@80x24.org>);
        Mon, 25 Feb 2019 18:16:53 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:38217 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728848AbfBYXQw (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 25 Feb 2019 18:16:52 -0500
Received: by mail-wm1-f67.google.com with SMTP id v26so561093wmh.3
        for <git@vger.kernel.org>; Mon, 25 Feb 2019 15:16:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=64Q/C+UvG7aY2L+o9q2/pGVmjnoxjBNn2y9cffInBG8=;
        b=fnDm9Ez5eekdPm3y1mgodmA0ZAcZT5vbVIWz/xE8Pp3RhouzdAoVADjSKn4DQ4mTbC
         MrPfjVmf8V0Ud3KqnBB6l6vBYA84Ij8HoTJVengAfXsoSb6C73/RiunAdJBAma9ERU+F
         +iayMIxrLQsNV0VD3yatwrJWo+fFugdNRpumh7BH6nXRnbIJUPpTcmqma6KxpouWfEms
         350Z9x/lxt+njEMVdcVvQQ5YhuP/jqXUp/xgPNX1WhsnyCdD60968xAiPBLt1MjvUVYo
         rqWo9PKXTlfoMmxfSuS4wDhVaEZsdKxWnr/CUZpufU2BkhaQ10+A7MXLcRFuekNARra+
         Q7hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=64Q/C+UvG7aY2L+o9q2/pGVmjnoxjBNn2y9cffInBG8=;
        b=laUj/6w8ZskkHn3qgjyNVSWPpHnO4fFcoGDi+MI2IkJK38Iq5p8iD7N0a6oOWFq7rq
         wOBvxuRXmyuaDZsLMU9mYDECny8xoMy4chbKPMyMLa3zRGbFLN3fgSRLdlMwF35VRLgk
         cR1Dxebi0GUdRww4RqrlfRTGILfIXLSnpFTKUTlyjqY0hlvo1ijoGRynpxs04JNEF1gx
         5QMpi0h3ZZqnbjlSckak4neRmAkleZDlPiklDP849JEd4x1EJUgQQOfY03i18oIPhOL5
         cnuePpvbG+kLpVZqATvqYtSWz1uw33MKrXRqq3Py55emZx2uuoVt/YzgaUQkjfxjhZoM
         MiGg==
X-Gm-Message-State: AHQUAua4+IWRcf1Tasv5weyv8RyKDxRpWd1zVIUSS6898lb6b3JozEnQ
        FpLWNHgsj4a+ftln86S/TYCj+WdQ
X-Google-Smtp-Source: AHgI3IbY160Q9iozvwJe47/8DZD/MGEkGoII8I4LHGUbAOqiR3d5NH2i7Bv3ft6+WlPgO0Ffg4o1Lg==
X-Received: by 2002:a7b:c84b:: with SMTP id c11mr653079wml.108.1551136610362;
        Mon, 25 Feb 2019 15:16:50 -0800 (PST)
Received: from localhost ([95.149.189.205])
        by smtp.gmail.com with ESMTPSA id b197sm21347990wmd.23.2019.02.25.15.16.48
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 25 Feb 2019 15:16:49 -0800 (PST)
From:   Thomas Gummerer <t.gummerer@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Paul-Sebastian Ungureanu <ungureanupaulsebastian@gmail.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Johannes Sixt <j6t@kdbg.org>,
        Thomas Gummerer <t.gummerer@gmail.com>
Subject: [PATCH v13 03/27] strbuf.c: add `strbuf_insertf()` and `strbuf_vinsertf()`
Date:   Mon, 25 Feb 2019 23:16:07 +0000
Message-Id: <20190225231631.30507-4-t.gummerer@gmail.com>
X-Mailer: git-send-email 2.21.0.rc2.291.g17236886c5
In-Reply-To: <20190225231631.30507-1-t.gummerer@gmail.com>
References: <nycvar.QRO.7.76.6.1902191127420.41@tvgsbejvaqbjf.bet>
 <20190225231631.30507-1-t.gummerer@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Paul-Sebastian Ungureanu <ungureanupaulsebastian@gmail.com>

Implement `strbuf_insertf()` and `strbuf_vinsertf()` to
insert data using a printf format string.

Original-idea-by: Johannes Schindelin <johannes.schindelin@gmx.de>
Signed-off-by: Paul-Sebastian Ungureanu <ungureanupaulsebastian@gmail.com>
Helped-by: Johannes Sixt <j6t@kdbg.org>
Signed-off-by: Thomas Gummerer <t.gummerer@gmail.com>
---
 strbuf.c | 36 ++++++++++++++++++++++++++++++++++++
 strbuf.h |  9 +++++++++
 2 files changed, 45 insertions(+)

diff --git a/strbuf.c b/strbuf.c
index 82e90f1dfe..87ecf7f975 100644
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
+	len2 = vsnprintf(sb->buf + pos, len + 1, fmt, ap);
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
2.21.0.rc2.291.g17236886c5

