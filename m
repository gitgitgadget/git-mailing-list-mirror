Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9BB001F97E
	for <e@80x24.org>; Sun, 14 Oct 2018 22:13:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726357AbeJOFzh (ORCPT <rfc822;e@80x24.org>);
        Mon, 15 Oct 2018 01:55:37 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:39306 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726262AbeJOFzh (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 15 Oct 2018 01:55:37 -0400
Received: by mail-ed1-f67.google.com with SMTP id d15-v6so16067963edq.6
        for <git@vger.kernel.org>; Sun, 14 Oct 2018 15:13:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Iav6BNdhEZHbLcvnqxSZavTocD7Zs/dD093lPCE26Mw=;
        b=u2Y0K7XixhjnWszqmhmXjmCBiRXiN1yvWhH6N06ccmIAgu5XsMkQygu57kq4Ozolie
         +dlfrLdpLnT+gVujV2yYT3QhR0u9G3FzxOYmgtoZbtAGGocuK37l/AYRNjvjZ6jkdBCp
         Hurmc2AnHOTRQjEAn53tji+6MYsMgzYJ9gpEuqUb7BNTSJyex+47AA504SVeEBRB14pO
         5fJZcHz1HLag+XL/Vur9Apx/nIBbwI/rqq79ys/gMfdRG/TXaIgRE9+h0L1+Dte88Dex
         3VfEYRYRwT+KB9FsfdWBGNhIIDKMUY0YRd8hziBxFYL+unSo0gn4OHr0Xj04HArHgoWz
         DFTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Iav6BNdhEZHbLcvnqxSZavTocD7Zs/dD093lPCE26Mw=;
        b=Ve/7lkl8ey0Tj9kCunKtpIjhAGLFjkPYH98ZE220kLgZbyVuYoOPowWFvmrrygWDmR
         Gzg5yPsaXuJWStPtV51ZTjGQf8s3IfHNQjxIbkiDJTGYA/MsH8/lvRhTA0pyiPyQ89Ug
         wZyfnLLFahSo/qXWHgJpQDxB5A6uPleF5LF8ny6Lg0tbsS+TpD4CBQLFFmnmgtg7xw17
         /7zXr9s1NfcsxBE7/v2vJg5i6Yp1nsKKr79ng4QenZQlf4th3oXBXobAzqxEg7S3HhW5
         J0aefhhV2miGMnkr6FpaH2M8jfTUc5KKL/AZWgx9Lykm/TdU8uUTPQLlmHxlGfAcfY17
         ZBMA==
X-Gm-Message-State: ABuFfogyu12tfNDUw8ZJnMwCmglv0/HnvBe2WekpsAB+wRnPJA6lUYEz
        8WijwiID1aAXlhmd7zXCyujXhkEl
X-Google-Smtp-Source: ACcGV61gBAXpK6y9ZXnAJf1y88IdJHGZEYbgvcWH7f80e2rAcN8UxadOBNVlXYUCsV+nqQg5Rb5l8w==
X-Received: by 2002:a50:9247:: with SMTP id j7-v6mr21390000eda.124.1539555190312;
        Sun, 14 Oct 2018 15:13:10 -0700 (PDT)
Received: from localhost.localdomain ([91.250.255.197])
        by smtp.gmail.com with ESMTPSA id p23-v6sm1829273ejj.16.2018.10.14.15.13.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 14 Oct 2018 15:13:09 -0700 (PDT)
From:   Paul-Sebastian Ungureanu <ungureanupaulsebastian@gmail.com>
To:     git@vger.kernel.org
Cc:     t.gummerer@gmail.com
Subject: [PATCH v10 01/21] sha1-name.c: add `get_oidf()` which acts like `get_oid()`
Date:   Mon, 15 Oct 2018 01:11:07 +0300
Message-Id: <b21cdeb1636b679d80ff554c48bc76516aed2cf6.1539553398.git.ungureanupaulsebastian@gmail.com>
X-Mailer: git-send-email 2.19.0.rc0.23.g10a62394e7
In-Reply-To: <cover.1539553398.git.ungureanupaulsebastian@gmail.com>
References: <cover.1539553398.git.ungureanupaulsebastian@gmail.com>
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
2.19.0.rc0.23.g10a62394e7

