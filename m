Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6DB5020401
	for <e@80x24.org>; Sun, 18 Jun 2017 21:16:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752757AbdFRVQf (ORCPT <rfc822;e@80x24.org>);
        Sun, 18 Jun 2017 17:16:35 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:33089 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752569AbdFRVQe (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 18 Jun 2017 17:16:34 -0400
Received: by mail-wm0-f65.google.com with SMTP id f90so13766406wmh.0
        for <git@vger.kernel.org>; Sun, 18 Jun 2017 14:16:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Ozx9TCq64kOO6YFIN5NR/OH4dl/mN6pasKOps4NCLXc=;
        b=eYCPeyowJvAYyZ5FziivWKXgqzKHp8GTaboMb7CMYo667udcN2I4iADr1TczvTuwuZ
         Ast3Aa2j4iXbDKuQ70IkLuigzi/jP5wNe8HoGmnjsb+WF22MMa7J/J+0LfGNgf7uzjKr
         fCQauA5S2fw99P7EZMiQ4RiTdFYteiplNYV5pFnlGC6RUs9HRTvbwPtLlF9y4fGiFZNl
         FmHQamh8E7Qz2bEQfJrSHYsCMf/wuuGNl/Q8pY1ZR1FtrD8D2VUEbGtqkYsTzfIi4G4A
         pj6gWemvlb2gwwepYte3ISrEXwg5aT4v6+UD2PTTVD2l2B7fiWgCTRGdMd1IS+LZkpHK
         yXUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Ozx9TCq64kOO6YFIN5NR/OH4dl/mN6pasKOps4NCLXc=;
        b=R49T29965TZeLvENMrstMijRL/CsUYX3xBwLHPEivOOStAFDZ8h6LleJDeHd2TzJ97
         M3MuKaxoho7sIQ95xudBzmRKECAt344M/AB7hvA+p1MU9IT53ADR7rBx9M6aRyfW2819
         CqbrLiud/fKOqpfEynEnd+dIxSGELJu9QhFVIwS9tkXps3YJf6+by9ipFrckH6m+OwCa
         2Mb4r5jMycCHLs30ahMhfCJ6J7bEjWnXNIeo504+f6OpATk4nedyCFIMdKSINevwbr4i
         n8DOkA6RCDNBkCt1jdcKjXQ2fA33P9VuNHZyYTKTuuvVt9LVFcTov7DmLLc8UUHNu/qh
         Tzug==
X-Gm-Message-State: AKS2vOxG4+a7BNciAxsG4QZd9WaWm0RvVjEbcmQ+h4tmBUI1l6FYLX0P
        saQTGLhfDJc1LAKB
X-Received: by 10.80.169.193 with SMTP id n59mr14500943edc.181.1497820592992;
        Sun, 18 Jun 2017 14:16:32 -0700 (PDT)
Received: from localhost.localdomain (ip-213-127-51-182.ip.prioritytelecom.net. [213.127.51.182])
        by smtp.gmail.com with ESMTPSA id r28sm4818744edd.33.2017.06.18.14.16.31
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Sun, 18 Jun 2017 14:16:32 -0700 (PDT)
From:   Sahil Dua <sahildua2305@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Junio C Hamano <gitster@pobox.com>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>
Subject: [PATCH v2 1/3] config: create a function to format section headers
Date:   Sun, 18 Jun 2017 23:16:31 +0200
Message-Id: <1497820591-93434-1-git-send-email-sahildua2305@gmail.com>
X-Mailer: git-send-email 2.7.4 (Apple Git-66)
In-Reply-To: <0102015ca23f0488-7423db93-b65f-4214-8221-af6a1bb4c2e5-000000@eu-west-1.amazonses.com>
References: <0102015ca23f0488-7423db93-b65f-4214-8221-af6a1bb4c2e5-000000@eu-west-1.amazonses.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Factor out the logic which creates section headers in the config file,
e.g. the 'branch.foo' key will be turned into '[branch "foo"]'.

This introduces no function changes, but is needed for a later change
which adds support for copying branch sections in the config file.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
Signed-off-by: Ramsay Jones <ramsay@ramsayjones.plus.com>
Signed-off-by: Sahil Dua <sahildua2305@gmail.com>
---
 config.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/config.c b/config.c
index 34a139c..32fd3c8 100644
--- a/config.c
+++ b/config.c
@@ -2169,10 +2169,10 @@ static int write_error(const char *filename)
 	return 4;
 }
 
-static int store_write_section(int fd, const char *key)
+static struct strbuf store_create_section(const char *key)
 {
 	const char *dot;
-	int i, success;
+	int i;
 	struct strbuf sb = STRBUF_INIT;
 
 	dot = memchr(key, '.', store.baselen);
@@ -2188,6 +2188,15 @@ static int store_write_section(int fd, const char *key)
 		strbuf_addf(&sb, "[%.*s]\n", store.baselen, key);
 	}
 
+	return sb;
+}
+
+static int store_write_section(int fd, const char *key)
+{
+	int success;
+
+	struct strbuf sb = store_create_section(key);
+
 	success = write_in_full(fd, sb.buf, sb.len) == sb.len;
 	strbuf_release(&sb);
 
-- 
2.7.4 (Apple Git-66)

