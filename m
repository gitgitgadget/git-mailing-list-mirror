Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B73F21F453
	for <e@80x24.org>; Tue, 25 Sep 2018 22:34:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726266AbeIZEoJ (ORCPT <rfc822;e@80x24.org>);
        Wed, 26 Sep 2018 00:44:09 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:45153 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725762AbeIZEoI (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 Sep 2018 00:44:08 -0400
Received: by mail-ed1-f65.google.com with SMTP id j2-v6so160917edp.12
        for <git@vger.kernel.org>; Tue, 25 Sep 2018 15:34:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=uLQiZHCmALo3yxhQ90Kb4US9A941DQEPQOUxZzMTeX0=;
        b=btp1xyN/YzwWMqopvCqImTdw9Aqc2rg7TYgagbwIIG0Av/igESyp4oZj+T1HL1e5IY
         CA2/KGfxxjPjLnbeuoBAmk+6umifoaUkEdbTmdnl3N3NJUeH3fpwi1QECtwfXOuGHUCG
         bFOBzYmHJgiftvHPtDbE0lvYAjp8d9GG+KGC7fQDmqwCo1j5W3JLu+SnVochT5nSXIJR
         IOok7Xzx++UMyzGvwikmFPCSrCJofZNAHOI9f/4yLffAL8uvNMmcj4w1dv35jCjBNS1V
         to2yOHrt5aEUTrFFzhn2jpJk2HNutRPopCjkuaSwGuH2WPGX1u/1n8wHAsjvK7uMjIHh
         DleQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=uLQiZHCmALo3yxhQ90Kb4US9A941DQEPQOUxZzMTeX0=;
        b=X0dSUQgo+v6b2ASOxHGSj5XkyJjeHNL3FYWw8hbuw6XkML2h2+8HCwc/XM+2ZDgGHu
         Oq/k7ZcSVtMVEtxWoVeUOC60V49ETFsL9nvaflFqtFGV1HBlU0Jqw7Tz3N0JsLTfq+4J
         qxuaFx4kEoMgqc8OOZBvwaewTXUIundbFj/ovtC00itVzD30gso51WqoPvhqBrhz9Vcf
         PoN0OMGKLcohhcIKrQG6pjReVBm6mSyD9owD4vhutA5VvMek72S9DPVPYkdCRy/l9LHH
         esckc+Vzpu3GxTP1mvF01Q+61Yh9oUTx08rydvoSJXxmlBtGWSrkogRbU3UiVuA1kJXf
         MsVw==
X-Gm-Message-State: ABuFfoi+/DdyefcwPdXx/OD5p0Mq4yXb2QvhxHE2NHt01jc5nEc/jPjY
        Fj0dftnCzHUZSFImlb+6vIZqM6Vh
X-Google-Smtp-Source: ACcGV62vXIN6+P40AUjL43j4jh3zqGlQItbzI3OJKBfoRUBZRC36GY7SzHTKAnUyzwmsJSujBt1G5A==
X-Received: by 2002:aa7:c549:: with SMTP id s9-v6mr4759565edr.73.1537914861605;
        Tue, 25 Sep 2018 15:34:21 -0700 (PDT)
Received: from localhost.localdomain ([92.55.154.13])
        by smtp.gmail.com with ESMTPSA id o37-v6sm33553edo.71.2018.09.25.15.34.20
        for <git@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 25 Sep 2018 15:34:20 -0700 (PDT)
From:   Paul-Sebastian Ungureanu <ungureanupaulsebastian@gmail.com>
To:     git@vger.kernel.org
Subject: [PATCH v9 02/21] strbuf.c: add `strbuf_join_argv()`
Date:   Wed, 26 Sep 2018 01:33:14 +0300
Message-Id: <1fb6d7a72c067fb594b04944dea4a5d223229d69.1537913094.git.ungureanupaulsebastian@gmail.com>
X-Mailer: git-send-email 2.19.0.rc0.23.g1fb9f40d88.dirty
In-Reply-To: <cover.1537913094.git.ungureanupaulsebastian@gmail.com>
References: <cover.1537913094.git.ungureanupaulsebastian@gmail.com>
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
index 64041c3c24..3eb431b2b0 100644
--- a/strbuf.c
+++ b/strbuf.c
@@ -259,6 +259,21 @@ void strbuf_addbuf(struct strbuf *sb, const struct strbuf *sb2)
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
index 60a35aef16..7ed859bb8a 100644
--- a/strbuf.h
+++ b/strbuf.h
@@ -284,6 +284,13 @@ static inline void strbuf_addstr(struct strbuf *sb, const char *s)
  */
 extern void strbuf_addbuf(struct strbuf *sb, const struct strbuf *sb2);
 
+
+/**
+ *
+ */
+extern const char *strbuf_join_argv(struct strbuf *buf, int argc,
+				    const char **argv, char delim);
+
 /**
  * This function can be used to expand a format string containing
  * placeholders. To that end, it parses the string and calls the specified
-- 
2.19.0.rc0.23.g1fb9f40d88

