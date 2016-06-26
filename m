Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-9.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BB6FB20179
	for <e@80x24.org>; Sun, 26 Jun 2016 12:09:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752149AbcFZMJl (ORCPT <rfc822;e@80x24.org>);
	Sun, 26 Jun 2016 08:09:41 -0400
Received: from mail-lf0-f65.google.com ([209.85.215.65]:33249 "EHLO
	mail-lf0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752069AbcFZMJk (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 26 Jun 2016 08:09:40 -0400
Received: by mail-lf0-f65.google.com with SMTP id l188so26167699lfe.0
        for <git@vger.kernel.org>; Sun, 26 Jun 2016 05:09:39 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=4oGrcClwsRNo/a6FmMuQ0xXxAisgbV2U2fWL/yDxgAU=;
        b=SEezIUWNGsoV7Ksyrt/p2qEPUH98/gFu9tbYj5nWBd9WiwG5wsKUDwg1SjbDL2BVC4
         otyPzvIGeVdiB82chNKvEsqhCbbKchP9YyYau64O53sqvndVqjSQdfjVB2sznvI05kBa
         iVIfAQq9rcQDkZlmhKOYE9/VYmP8giM9uhcf6V9pBKjsD83N5PQ6ZsYq9UlFU6a5AtJq
         wUqLtvbMm4aMKC4+D4X8FHPD3NuaBIBjYj3FN5ICLiIM9vOSZwLJXEh+ODbfs7XKYshT
         kYPV3tyIku5cFWsBWhRbeJnzKgZZJMQp0ToHS24Zqus5HcLSNofJ6DoWcRJ3xLmnQ5xP
         WKUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=4oGrcClwsRNo/a6FmMuQ0xXxAisgbV2U2fWL/yDxgAU=;
        b=jADN16dosVx8Yj/kkrHPQ/RCFL4CoLIlfYs2w5URYN7kCAEk4XNefyQHYoRDGgwd1C
         IPsGtrSTVNaR2DDXKYfdm28N4ExjGyoLZ72Q4IVbJrweKh6WCW8Ps2sUOGt69bpKu1fp
         tQKKZLsqVN8gb4IYKJqJ1hm8awdvI1lMrGa62pHCmT8MA+iEMNsZyLvLBp1qF/bJn9IZ
         +kHZ9mYOE8QwKLF74xJL8LyEL5TZSzme0CapJ2SkmizcE5Xaz9+BCvzd47pgyi4OiwKH
         xIigS/I0Qs2pxOMxPfFBdfto6R3lnWSonCDaGYShNG36u1kICEAlXpLDXuXsSSMmoC9H
         7psQ==
X-Gm-Message-State: ALyK8tLAF2P8a+zp+xuYFNnZFZckAyaIxinLzUScRj7i32wTevXsxkpuah9RD0UgCKrcNA==
X-Received: by 10.46.32.223 with SMTP id g92mr3699193lji.32.1466942978182;
        Sun, 26 Jun 2016 05:09:38 -0700 (PDT)
Received: from duynguyen.does.not.exist (10.219.241.83.in-addr.dgcsystems.net. [83.241.219.10])
        by smtp.gmail.com with ESMTPSA id 80sm2338889lfv.20.2016.06.26.05.09.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 26 Jun 2016 05:09:37 -0700 (PDT)
From:	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To:	git@vger.kernel.org, novalis@novalis.org
Cc:	Junio C Hamano <gitster@pobox.com>, kamggg@gmail.com,
	dturner@twopensource.com,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v13 21/20] unix-socket.c: add stub implementation when unix sockets are not supported
Date:	Sun, 26 Jun 2016 14:09:28 +0200
Message-Id: <20160626120928.14950-1-pclouds@gmail.com>
X-Mailer: git-send-email 2.8.2.531.gd073806
In-Reply-To: <1466914464-10358-19-git-send-email-novalis@novalis.org>
References: <1466914464-10358-19-git-send-email-novalis@novalis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

This keeps #ifdef at the callee instead of caller, it's less messier.

The caller in question is in read-cache.c which, unlike other
unix-socket callers so far, is always built regardless of unix socket
support. No extra handling (for ENOSYS) is needed because in this
build, index-helper does not exist, $GIT_DIR/index-helper.sock does
not exist, so no unix socket call is made by read-cache.c in the first
place.

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 BTW 20/20 didn't seem to make it to the list (or my mailbox). And you
 probably want to update .mailmap with @novalis.org as main address
 too.

 Makefile      |  2 ++
 unix-socket.h | 18 ++++++++++++++++++
 2 files changed, 20 insertions(+)

diff --git a/Makefile b/Makefile
index d1309b8..d8cfc51 100644
--- a/Makefile
+++ b/Makefile
@@ -1337,6 +1337,8 @@ ifndef NO_UNIX_SOCKETS
 	LIB_OBJS += unix-socket.o
 	PROGRAM_OBJS += credential-cache.o
 	PROGRAM_OBJS += credential-cache--daemon.o
+else
+	BASIC_CFLAGS += -DNO_UNIX_SOCKETS
 endif
 
 ifdef NO_ICONV
diff --git a/unix-socket.h b/unix-socket.h
index e271aee..f1cba70 100644
--- a/unix-socket.h
+++ b/unix-socket.h
@@ -1,7 +1,25 @@
 #ifndef UNIX_SOCKET_H
 #define UNIX_SOCKET_H
 
+#ifndef NO_UNIX_SOCKETS
+
 int unix_stream_connect(const char *path);
 int unix_stream_listen(const char *path);
 
+#else
+
+static inline int unix_stream_connect(const char *path)
+{
+	errno = ENOSYS;
+	return -1;
+}
+
+static inline int unix_stream_listen(const char *path)
+{
+	errno = ENOSYS;
+	return -1;
+}
+
+#endif
+
 #endif /* UNIX_SOCKET_H */
-- 
2.8.2.531.gd073806

