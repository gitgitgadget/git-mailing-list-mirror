Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FROM,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EE98D1F405
	for <e@80x24.org>; Thu, 20 Dec 2018 19:44:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731447AbeLTTox (ORCPT <rfc822;e@80x24.org>);
        Thu, 20 Dec 2018 14:44:53 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:45027 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728588AbeLTTow (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 Dec 2018 14:44:52 -0500
Received: by mail-wr1-f68.google.com with SMTP id z5so2964577wrt.11
        for <git@vger.kernel.org>; Thu, 20 Dec 2018 11:44:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=rJOEHrCAzdc21FbUEM3Mgh2sdULnOBQfB42x8DaPRsc=;
        b=rHn92dl4VJpxsvuotqEL+trda97wyw0rmef/xjgXdkUQGgyiUfNKR7SrCfxNf7z1GN
         mRdP0kbto3HZPMNRQpKMMg5HAExEgY16RVFM9Gqa48F6PtYUQgCAEKjvJZmClcmfdJoD
         6qHMlszvKV5bSwdBbgmsbdPBOSQ/PiDmjKYvT4RCgvpPzT4EmkQh0NKpsekme2KmE1/C
         BwT8Ys9HYA0qS09xo+J7AdoYqru2a3t8xiMkDz9HEKPEwTP0IVx0k9ZOEzHi9eIIdXEP
         Q5D/eEEHlKgMOaxJ2cCGVIULwXIaZo5wgdsdiOv9pXbRiAxRyqNFNyo2wsrcfvq2+Bo1
         /xeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=rJOEHrCAzdc21FbUEM3Mgh2sdULnOBQfB42x8DaPRsc=;
        b=V+Z6pbz1PuqStYUe6UbOe1leVYyjgkY1NqVFH0PupIQDecmPNvqSmaUrX/A+VollNe
         bOfTI4yWJHvz8JwqmHUxjnBGVwfLLv9lmNK6V8cFL4jLAMGwe8gmgg2iwlrnFEjNW1VQ
         G1ryem42Osopt1Hs+6ioZfIt3FubRvavVONoWJaU6LkNgIt8OZQzgEtMOl3hFTH9irfQ
         iKhUFSCSn+ke+sj8Zh5tfwfCQEMAy0UdMDe4wkkPE+FLfxcex8o9r24LInUjZFMdOZNn
         FGD6kljQu+LofCa9ywiyx+T44If6Rj+7S+Ae0V8oCvsqxnBtJD+fK7svl/+B3krSYOnt
         5W8g==
X-Gm-Message-State: AA+aEWZk2LcSpHgrf3Xq3UmkJlTl+wZLoqTaBhFth2FDym17HOD/cLLo
        fuMqdqZO2I0GATq0MebjE2aWfEuxaSI=
X-Google-Smtp-Source: AFSGD/UV8HGlVHG2DQIwLZa3BrV+zsVRt9Sx8EIlhewLM+iH+pY17k4IHtLuJ+SjiLKk7XU7Qi6dmQ==
X-Received: by 2002:a5d:40c1:: with SMTP id b1mr25204091wrq.133.1545335090360;
        Thu, 20 Dec 2018 11:44:50 -0800 (PST)
Received: from sebi-laptop.tendawifi.com ([188.24.227.76])
        by smtp.gmail.com with ESMTPSA id j129sm7587267wmb.39.2018.12.20.11.44.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 20 Dec 2018 11:44:49 -0800 (PST)
From:   Paul-Sebastian Ungureanu <ungureanupaulsebastian@gmail.com>
To:     git@vger.kernel.org
Cc:     t.gummerer@gmail.com, Johannes.Schindelin@gmx.de
Subject: [PATCH v12 02/26] strbuf.c: add `strbuf_join_argv()`
Date:   Thu, 20 Dec 2018 21:44:18 +0200
Message-Id: <554f15de006f6015390a8e1c6098c8bf2d06c849.1545331726.git.ungureanupaulsebastian@gmail.com>
X-Mailer: git-send-email 2.20.1.336.g43b67505b2.dirty
In-Reply-To: <cover.1545331726.git.ungureanupaulsebastian@gmail.com>
References: <cover.1545331726.git.ungureanupaulsebastian@gmail.com>
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
2.20.1.441.g764a526393

