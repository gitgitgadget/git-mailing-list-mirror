Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 03B091F87F
	for <e@80x24.org>; Thu, 22 Nov 2018 23:06:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2438942AbeKWJry (ORCPT <rfc822;e@80x24.org>);
        Fri, 23 Nov 2018 04:47:54 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:38424 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2392523AbeKWJry (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 23 Nov 2018 04:47:54 -0500
Received: by mail-wr1-f65.google.com with SMTP id v13so7167726wrw.5
        for <git@vger.kernel.org>; Thu, 22 Nov 2018 15:06:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Rjnnj9TRwqeyN5UUhaUTnY9uBMV8NNt3+VQkPm2ty4w=;
        b=czxhzeZhJZWkk/kbMzKFkueZ+hL13UuJ2m4Y0Ew0I2J/QzCVeUsm/8ijrPO1Z8JdnT
         ixC9aZoOWp1uF4OCnwcpWvI4+KBqllWSCK060BKHLvvZKihcw2wBNhn3TGQg1MZXx+u1
         H77037zpjXotcf8iXGmf+XTKyS2tSv4GP6JmvHtLlXUc5s1zVCmRUkSFkDPRD+eZpF4L
         8mlLdFOV4dvFGMDUkXPt09f2Sz5b56E/SsFDyqO0AhCgmpMlXnp220lFIHAXtFy188pr
         DhxprI8WSMwJdqRRitaw1gz7g+LOAVeSKVGRujbdydQ3Do4Qb9c5+oTswjZQda5Ka0KN
         5dpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Rjnnj9TRwqeyN5UUhaUTnY9uBMV8NNt3+VQkPm2ty4w=;
        b=ubn4Bl51fk7I+tA/cjYX80cygx5nMhiMMLd4LYi26wQaLZY3ftVPVE7CJeKtdpZEaV
         i1OEN827UWTAIBjNtdnOMN79HCFY98y1Rjwk8clsMqHYwPZ87BU/MgFBznLCcFwEhwM7
         YR9Ai3tXj7506XJBaOA2H1dQlru8WjLjxLh3MLaAIIungidRNgfJNqA4PatNAN4fRmzH
         rZqcDhplqA56PgWhH8NgTvMdN5rbASFUq1Iex2a4qsSTWYFAOuNGhD4cJv8LyvxzMURg
         98mqUn9mD/TqFOrXz2TDz4Oud7LbLF4O/hR+5CldgJim433f/UPQBGC3EIuA7TiFSjwM
         xcrg==
X-Gm-Message-State: AA+aEWb8C+OdDG/hqpmGUHnHkDR8oueYMwD878CUJXpwcfBmLNzyDYI5
        XRHgHf4jCOHxomy1MRR4IIZMNbC2
X-Google-Smtp-Source: AFSGD/X3TKSAgHAe24LIPLsGOlr4iX9IyYcaFhKR2V4HbwymzI9R1NyecBLikKRhCbPWXoxAsNksgA==
X-Received: by 2002:adf:ef0d:: with SMTP id e13mr11331541wro.29.1542927973371;
        Thu, 22 Nov 2018 15:06:13 -0800 (PST)
Received: from localhost.localdomain ([91.250.255.197])
        by smtp.gmail.com with ESMTPSA id v5sm11099670wrr.11.2018.11.22.15.06.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 22 Nov 2018 15:06:12 -0800 (PST)
From:   Paul-Sebastian Ungureanu <ungureanupaulsebastian@gmail.com>
To:     git@vger.kernel.org
Cc:     t.gummerer@gmail.com
Subject: [PATCH v11 02/22] strbuf.c: add `strbuf_join_argv()`
Date:   Fri, 23 Nov 2018 01:05:22 +0200
Message-Id: <af23e1efdababcd981f814f20a1b44048509cd23.1542925164.git.ungureanupaulsebastian@gmail.com>
X-Mailer: git-send-email 2.19.1.878.g0482332a22
In-Reply-To: <cover.1542925164.git.ungureanupaulsebastian@gmail.com>
References: <cover.1542925164.git.ungureanupaulsebastian@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Implement `strbuf_join_argv()` to join arguments
into a strbuf.

Signed-off-by: Paul-Sebastian Ungureanu <ungureanupaulsebastian@gmail.com>
---
 strbuf.c | 15 +++++++++++++++
 strbuf.h |  7 +++++++
 2 files changed, 22 insertions(+)

diff --git a/strbuf.c b/strbuf.c
index f6a6cf78b9..82e90f1dfe 100644
--- a/strbuf.c
+++ b/strbuf.c
@@ -268,6 +268,21 @@ void strbuf_addbuf(struct strbuf *sb, const struct strbuf *sb2)
 	strbuf_setlen(sb, sb->len + sb2->len);
 }
 
+const char *strbuf_join_argv(struct strbuf *buf,
+			     int argc, const char **argv, char delim)
+{
+	if (!argc)
+		return buf->buf;
+
+	strbuf_addstr(buf, *argv);
+	while (--argc) {
+		strbuf_addch(buf, delim);
+		strbuf_addstr(buf, *(++argv));
+	}
+
+	return buf->buf;
+}
+
 void strbuf_addchars(struct strbuf *sb, int c, size_t n)
 {
 	strbuf_grow(sb, n);
diff --git a/strbuf.h b/strbuf.h
index fc40873b65..be02150df3 100644
--- a/strbuf.h
+++ b/strbuf.h
@@ -288,6 +288,13 @@ static inline void strbuf_addstr(struct strbuf *sb, const char *s)
  */
 void strbuf_addbuf(struct strbuf *sb, const struct strbuf *sb2);
 
+/**
+ * Join the arguments into a buffer. `delim` is put between every
+ * two arguments.
+ */
+const char *strbuf_join_argv(struct strbuf *buf, int argc,
+			     const char **argv, char delim);
+
 /**
  * This function can be used to expand a format string containing
  * placeholders. To that end, it parses the string and calls the specified
-- 
2.19.1.878.g0482332a22

