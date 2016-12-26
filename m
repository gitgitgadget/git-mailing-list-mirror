Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EFAA1200E0
	for <e@80x24.org>; Mon, 26 Dec 2016 10:23:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932258AbcLZKXV (ORCPT <rfc822;e@80x24.org>);
        Mon, 26 Dec 2016 05:23:21 -0500
Received: from mail-wm0-f67.google.com ([74.125.82.67]:35871 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752083AbcLZKWt (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Dec 2016 05:22:49 -0500
Received: by mail-wm0-f67.google.com with SMTP id m203so52438226wma.3
        for <git@vger.kernel.org>; Mon, 26 Dec 2016 02:22:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=X1unFpxDVHfjfskUSgJ/lulVCQkQPK8xCIFBu/y6zUk=;
        b=qUgVwcykuaw2pKUTnmKUNeRLqkEv9Ip7cOx4ZC0cgAJtU/NovW5CjuyTJIXGu6OUiS
         /4pi7gAc+h9g7FoUHa2i5w/GdLLJr9h1Qu5qAVptikz7TzBUYvEAeRQImt2LPGXkKU+w
         d5mEZz/s16USujLfC6cwZv4e65i8TNVvz9OtLmpVHPA10R6Mafro3Obxq9oeFYQZEziK
         ys5M9rYwnrtMre2up2eY9HGQ4+8WiSZpa+QU9slcfqU+EvrPyXiCXSENPXvW37puqmCB
         HpznM0LNDGcJ2wJuugQwPhUsZ9KqvDZwi+2dM4QPCldb14VNVqoOq6rkXZbHiKI2h+Ii
         WUrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=X1unFpxDVHfjfskUSgJ/lulVCQkQPK8xCIFBu/y6zUk=;
        b=RlNwR63UZoFDzqrwfoukbyrxvlD1D4Y3Tq3w2fySZfr4XTQv4nkB0agp60wl96Zvl7
         ModhIMqMi5xlAexvANp57AKYd84OtBceDsDjSADImieIeGadiaCJP/nfSrjgEhxhWx43
         ng1hD2qhoErqApQ2lFeUAKUmq9BcsQzWekcYgQbfuLoXqct/+A9AuUo1L6XYy8se1Ieh
         9ISt4dIZONpSSlDDtl76rzhHVy7XmEad5rEg+++8jPvvqVHWb8RqteYbFbzAx0VBpThV
         OQdiD1JUKPEz28uJYJb995inVtqfmL0KVjtrlb4Tfd8LQ7TJYXHbx/AwNfO+nc4p/fiX
         aZxg==
X-Gm-Message-State: AIkVDXL3A+qGOfykXm28ikDT7vewYWLlzmA5C6Yv9Z0lGLMpLqDtWgNMrXItWxfr+BPvJA==
X-Received: by 10.28.175.204 with SMTP id y195mr24227530wme.106.1482747768299;
        Mon, 26 Dec 2016 02:22:48 -0800 (PST)
Received: from localhost.localdomain (cha92-h01-128-78-31-246.dsl.sta.abo.bbox.fr. [128.78.31.246])
        by smtp.gmail.com with ESMTPSA id kp5sm54259010wjb.8.2016.12.26.02.22.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 26 Dec 2016 02:22:47 -0800 (PST)
From:   Christian Couder <christian.couder@gmail.com>
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v3 13/21] sha1_file: make check_and_freshen_file() non static
Date:   Mon, 26 Dec 2016 11:22:14 +0100
Message-Id: <20161226102222.17150-14-chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.11.0.209.gda91e66374.dirty
In-Reply-To: <20161226102222.17150-1-chriscool@tuxfamily.org>
References: <20161226102222.17150-1-chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This function will be used in a commit soon, so let's make
it available globally.

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 cache.h     | 3 +++
 sha1_file.c | 2 +-
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/cache.h b/cache.h
index e15b421b6f..f442f28189 100644
--- a/cache.h
+++ b/cache.h
@@ -1170,6 +1170,9 @@ extern int has_pack_index(const unsigned char *sha1);
 
 extern void assert_sha1_type(const unsigned char *sha1, enum object_type expect);
 
+/* Helper to check and "touch" a file */
+extern int check_and_freshen_file(const char *fn, int freshen);
+
 extern const signed char hexval_table[256];
 static inline unsigned int hexval(unsigned char c)
 {
diff --git a/sha1_file.c b/sha1_file.c
index 1173071859..f5303d955a 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -601,7 +601,7 @@ static int freshen_file(const char *fn)
  * either does not exist on disk, or has a stale mtime and may be subject to
  * pruning).
  */
-static int check_and_freshen_file(const char *fn, int freshen)
+int check_and_freshen_file(const char *fn, int freshen)
 {
 	if (access(fn, F_OK))
 		return 0;
-- 
2.11.0.209.gda91e66374.dirty

