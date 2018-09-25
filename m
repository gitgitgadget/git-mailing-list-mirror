Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4DA411F453
	for <e@80x24.org>; Tue, 25 Sep 2018 22:34:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726440AbeIZEoQ (ORCPT <rfc822;e@80x24.org>);
        Wed, 26 Sep 2018 00:44:16 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:41979 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726250AbeIZEoQ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 Sep 2018 00:44:16 -0400
Received: by mail-ed1-f65.google.com with SMTP id f38-v6so178039edd.8
        for <git@vger.kernel.org>; Tue, 25 Sep 2018 15:34:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=JwEH2C02i3PPlGKhEZvbB75R1KTyaYpHx0A5sLUJvgg=;
        b=tD+L2QEomZEQXRSz2JhN9m/3g541qfBhdaPDDGhZhrHXwv6hryzEgAaCvJa2mOdDSQ
         pUDYPEG3Smqm/py9UfuwlvaOHE3+2YBveoZpMJKVEl+BTHDxUSe/FrvQ1nzXCwmNCe6/
         CI3CN5h1bq3m2h+cfDtPzMv1ruikn+5zPH5U9pKx30ZW/sfMYxFUe40/6Z1DUw9KPqS5
         XNipTRHZQy0urT9vTZG3BitZS7Ewgq4jUEaqVfbdsZ0ftrL9meCu1rBYYWWejUE9Js/5
         G665ooNIz2VkAsJT33TMwz5cmRtsUKFojyEdUUxf0lgrXslPNz4mfV5O+pQc5skLMdxt
         Igtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=JwEH2C02i3PPlGKhEZvbB75R1KTyaYpHx0A5sLUJvgg=;
        b=JdLLByc7wFQsYlMRVMH6EdJX+Uh25ih1AKAOKWzampTPVgs2VTpANNUIkzQHtn4nni
         2TCj1TIRDSWWYuwRcweCf1rRBbVqTNXXADIQT/ZYNKWtoaPvlxve51a5Zo8u/QaUWrA9
         lB1aVfGxXwzP13VGynU55pnbO6V/J3vH6Jd5Zu9H2Sp61lqm/0aaLYTD+DRZw4EEOcQ/
         olUu4BdSgVUdC44A6vH75gJToZJOGLoNfLp/QjulkYOCzQkSWWsHtYn8054kTxE6BaES
         q5N88Ji9wzokeXL7gq7vRJ3ykVXIGi6T97lC33wfH1am2bIZSuWgi77dK6T15xZKBxpT
         IodQ==
X-Gm-Message-State: ABuFfoguwkQg8VyMLv24EjpehoXO1fZZOZusVkYQs8MSNOzw6f7rbjVB
        8vEvBbk/99yCLwyPTDVIqawYzlUm
X-Google-Smtp-Source: ACcGV62qBL0u9l0jx4hmNu/1ifdr333bRtd5idrkqxhWb9UH80ELmLjzWzouwTuiyqGP5to03Ys3Gg==
X-Received: by 2002:a50:c345:: with SMTP id q5-v6mr1054697edb.130.1537914869575;
        Tue, 25 Sep 2018 15:34:29 -0700 (PDT)
Received: from localhost.localdomain ([92.55.154.13])
        by smtp.gmail.com with ESMTPSA id o37-v6sm33553edo.71.2018.09.25.15.34.28
        for <git@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 25 Sep 2018 15:34:28 -0700 (PDT)
From:   Paul-Sebastian Ungureanu <ungureanupaulsebastian@gmail.com>
To:     git@vger.kernel.org
Subject: [GSoC][PATCH v9 06/21] strbuf.c: add `strbuf_join_argv()`
Date:   Wed, 26 Sep 2018 01:33:22 +0300
Message-Id: <ab5bb135401ed4aff45ec95cbcda79c12961a84a.1537911869.git.ungureanupaulsebastian@gmail.com>
X-Mailer: git-send-email 2.19.0.rc0.23.g1fb9f40d88.dirty
In-Reply-To: <cover.1537911869.git.ungureanupaulsebastian@gmail.com>
References: <cover.1537911869.git.ungureanupaulsebastian@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Implement `strbuf_join_argv()` to join arguments.

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
2.19.0.rc0.23.g1c0a08a5d3

