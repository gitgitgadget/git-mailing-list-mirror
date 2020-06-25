Return-Path: <SRS0=4a08=AG=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9639AC433DF
	for <git@archiver.kernel.org>; Thu, 25 Jun 2020 20:33:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6EBAA20791
	for <git@archiver.kernel.org>; Thu, 25 Jun 2020 20:33:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=usp-br.20150623.gappssmtp.com header.i=@usp-br.20150623.gappssmtp.com header.b="yr2T8q7k"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407146AbgFYUdP (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 25 Jun 2020 16:33:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2407140AbgFYUdO (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 25 Jun 2020 16:33:14 -0400
Received: from mail-qk1-x741.google.com (mail-qk1-x741.google.com [IPv6:2607:f8b0:4864:20::741])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCE10C08C5C1
        for <git@vger.kernel.org>; Thu, 25 Jun 2020 13:33:14 -0700 (PDT)
Received: by mail-qk1-x741.google.com with SMTP id 145so4245565qke.9
        for <git@vger.kernel.org>; Thu, 25 Jun 2020 13:33:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp-br.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=6p4gqrkOITNw6tnB9xnpq/Qeo91MuyX0Kj2dGHJu5Xg=;
        b=yr2T8q7kaWnW8E0iEssJWwHi3emsl4rg3LRu+xqb7N2uoXkxml5VehymecEzaXkm10
         Yypi+vX9Ifw8Cs+zjIWS5AlvJNiJCWB+8XdDwX7I2iCO/QlOp8oVsgc82E8y/4Qa9klL
         h8YSzFSfLqvaMgEFoOTcB2KXKHdems1Oz4QjRRe4PiOi9Sc+AJWs3aEaeB8NRCpe/kP1
         /hzOU+N029IWT/Ax51JAVJrzqkzUIZfEfwcq7Y7UWbl/HgF1mvbsrZKQL5+M6J7jGO7r
         GDTs5a8whHyAPKA92KmPWVhY0i1iAMb2/znhvlFVmb31m2XeQUs8fjArecV75AI9BN4w
         jlsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6p4gqrkOITNw6tnB9xnpq/Qeo91MuyX0Kj2dGHJu5Xg=;
        b=kIIhnuVQPd7+HqWL3cTtxMq3CcADVcQ+N5Y0T9EQ1Ov0MI5pwFy/tJVXmhC77FMZ9M
         +KzgVlGp+II9AB36u1tVT6FmYywz5aToCXqvSqi+sj5lLdPGx7kNRzbLw5HXOzj23iAY
         0kWI5hoj465WwiR+EHvDO8uXoxm7NERhpiMJq1Pxp6u372qpzwJ5nT9/975Axat2eYxl
         2uYDUELxpii0/i7OiS/B479UsZMk8V/wuyjU0hSv07iAmzVl+3KhZOZZbstaIBGShTiU
         YJGou62qWB1RRC9nLObI00MzBN5BZu1U0mm8u5u9Q8cTaI1X/vFwCtKHPB/3dcYJZ/Q5
         zd4w==
X-Gm-Message-State: AOAM531/CmzYWp0GcGsBJMUqz7u/lBmTgvdSGUWxBztoyNDFkIG4AiO6
        CUHQmZ+P9i61IVwgbaw9YKLIwcALUxg=
X-Google-Smtp-Source: ABdhPJzGbTAOgOqxDTzvyYCAz+EsB0uxSwyEzy8Hh1eNbTKJ5e/F9awKVy+cACEz1/eLZ3d8BzUNJg==
X-Received: by 2002:a37:474d:: with SMTP id u74mr15573056qka.195.1593117193478;
        Thu, 25 Jun 2020 13:33:13 -0700 (PDT)
Received: from mango.spo.virtua.com.br ([2804:14c:81:9a16::4])
        by smtp.gmail.com with ESMTPSA id n63sm6745118qkn.104.2020.06.25.13.33.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jun 2020 13:33:12 -0700 (PDT)
From:   Matheus Tavares <matheus.bernardino@usp.br>
To:     git@vger.kernel.org
Cc:     sandals@crustytoothpaste.net, j6t@kdbg.org,
        jonathantanmy@google.com, peff@peff.net,
        Johannes.Schindelin@gmx.de, Fredrik Kuivinen <frekui@gmail.com>
Subject: [PATCH 2/2] hex: make hash_to_hex_algop() and friends thread-safe
Date:   Thu, 25 Jun 2020 17:32:57 -0300
Message-Id: <0104cd9c763aee220a2df357834c79b10695ee35.1593115455.git.matheus.bernardino@usp.br>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1593115455.git.matheus.bernardino@usp.br>
References: <cover.1593115455.git.matheus.bernardino@usp.br>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

hash_to_hex_algop() returns a static buffer, relieving callers from the
responsibility of freeing memory after use. But the current
implementation uses the same static data for all threads and, thus, is
not thread-safe. We could avoid using this function and its wrappers
in threaded code, but they are sometimes too deep in the call stack to
be noticed or even avoided.

For example, we can take a look at the number of oid_to_hex() calls,
which calls hash_to_hex_algop():

$ git grep 'oid_to_hex(' | wc -l
818

Although these functions don't seem to be causing problems out there for
now (at least not reported), making them thread-safe makes the codebase
more robust against race conditions. We can easily do that replicating
the static buffer in each thread's local storage.

Original-patch-by: Fredrik Kuivinen <frekui@gmail.com>
Signed-off-by: Matheus Tavares <matheus.bernardino@usp.br>
---
 hex.c | 45 +++++++++++++++++++++++++++++++++++++++++----
 1 file changed, 41 insertions(+), 4 deletions(-)

diff --git a/hex.c b/hex.c
index da51e64929..1094ed25bd 100644
--- a/hex.c
+++ b/hex.c
@@ -136,12 +136,49 @@ char *oid_to_hex_r(char *buffer, const struct object_id *oid)
 	return hash_to_hex_algop_r(buffer, oid->hash, the_hash_algo);
 }
 
+struct hexbuf_array {
+	int idx;
+	char bufs[4][GIT_MAX_HEXSZ + 1];
+};
+
+#ifdef HAVE_THREADS
+static pthread_key_t hexbuf_array_key;
+static pthread_once_t hexbuf_array_once = PTHREAD_ONCE_INIT;
+
+void init_hexbuf_array_key(void)
+{
+	if (pthread_key_create(&hexbuf_array_key, free))
+		die(_("failed to initialize threads' key for hash to hex conversion"));
+}
+
+#else
+static struct hexbuf_array default_hexbuf_array;
+#endif
+
 char *hash_to_hex_algop(const unsigned char *hash, const struct git_hash_algo *algop)
 {
-	static int bufno;
-	static char hexbuffer[4][GIT_MAX_HEXSZ + 1];
-	bufno = (bufno + 1) % ARRAY_SIZE(hexbuffer);
-	return hash_to_hex_algop_r(hexbuffer[bufno], hash, algop);
+	struct hexbuf_array *ha;
+
+#ifdef HAVE_THREADS
+	void *value;
+
+	if (pthread_once(&hexbuf_array_once, init_hexbuf_array_key))
+		die(_("failed to initialize threads' key for hash to hex conversion"));
+
+	value = pthread_key_getspecific(&hexbuf_array_key);
+	if (value) {
+		ha = (struct hexbuf_array *) value;
+	} else {
+		ha = xmalloc(sizeof(*ha));
+		if (pthread_key_setspecific(&hexbuf_array_key, (void *)ha))
+			die(_("failed to set thread buffer for hash to hex conversion"));
+	}
+#else
+	ha = &default_hexbuf_array;
+#endif
+
+	ha->idx = (ha->idx + 1) % ARRAY_SIZE(ha->bufs);
+	return hash_to_hex_algop_r(ha->bufs[ha->idx], hash, algop);
 }
 
 char *hash_to_hex(const unsigned char *hash)
-- 
2.26.2

