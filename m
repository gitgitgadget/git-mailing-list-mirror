Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3F2301F4F8
	for <e@80x24.org>; Thu, 22 Sep 2016 18:54:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S941111AbcIVSyA (ORCPT <rfc822;e@80x24.org>);
        Thu, 22 Sep 2016 14:54:00 -0400
Received: from mail-qk0-f196.google.com ([209.85.220.196]:35596 "EHLO
        mail-qk0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S940996AbcIVSx1 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 22 Sep 2016 14:53:27 -0400
Received: by mail-qk0-f196.google.com with SMTP id n185so1736789qke.2
        for <git@vger.kernel.org>; Thu, 22 Sep 2016 11:53:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nyu-edu.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=qmaK0J9I2Dqe4y3JBem4eztmXH7xBaODF3bBLgrFpAQ=;
        b=KR8S1q4sbZ8NuclDKTSRD0SImAoWZaU+psjrWw8Wf9RdiWdMj+SVDAuNwB4sIfFcMf
         kbPyuNiAnmSelCAfsEJjYWKgI6wpv8n4pnDGuGBMD7YGcS/Iq/pqfIadxxfoa1pOsT89
         NtKgQazl1ZV7xFpf+LY6CxL9j8HQ+tGJD7crqb+D8uNP276do8/w+EIQ3GUYEZxS8G5P
         ABZxTsQLZ0e0OS2qFULvJdvU7EhZb/kUIaC3yWFHTWyewGLh87Ziz3Y93l9YpQSHvK09
         fka8pUoDlFLsA+i9Beg8fWeg0wKn+NEvPXaYdiEA485QF+O/Zeha63EWd/HUDZYYS3Dq
         3nwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=qmaK0J9I2Dqe4y3JBem4eztmXH7xBaODF3bBLgrFpAQ=;
        b=XgmWujBH0dAM53H4I3wx0AGCbcBWAwOR/NPzRI8JvECKXjNh6Emx5/NP71SoCxD/Ya
         /TiBZplpOMeo0dl6LJ+mWdT/01p4Pzriojj8l9mlPTJqvSb8bcuRq1i2iQL3oTTMOonq
         EjSV74IxiK5U820Z71Xjoh5PYA5Rm4jPWSpYLFgDrHS/OxnyrwXn81ymeL/1hWkG+aRG
         h/opEHXzQ+nQcYjIzHn/MS1SugnD+uS72RLVmwBE1NB9tLw2H3uGk/Dfv5iUviCIwKGo
         z9pKm95q8M5VkwJz0hDvczklbfBmdUtDR5883rk3ix1PYROej5FzL+7B1qjpxrWfYvg6
         4WSw==
X-Gm-Message-State: AA6/9Rk2/U7+5EOeXg75E35ohCf/evEhwQv35YVkmrhgCvsDhMLMZ1fM/8O9dl1rWEPHnFI3
X-Received: by 10.55.176.199 with SMTP id z190mr3854129qke.139.1474570405919;
        Thu, 22 Sep 2016 11:53:25 -0700 (PDT)
Received: from LykOS.nyu.edu (NYUFWA-WLESSAUTHCLIENTS-19.NATPOOL.NYU.EDU. [216.165.95.8])
        by smtp.gmail.com with ESMTPSA id m87sm1675117qkl.21.2016.09.22.11.53.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 22 Sep 2016 11:53:25 -0700 (PDT)
From:   santiago@nyu.edu
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, peff@peff.net, sunshine@sunshineco.com,
        walters@verbum.org, Lukas P <luk.puehringer@gmail.com>,
        Lukas Puehringer <lukas.puehringer@nyu.edu>
Subject: [PATCH 4/6] tag: add format specifier to gpg_verify_tag
Date:   Thu, 22 Sep 2016 14:53:15 -0400
Message-Id: <20160922185317.349-5-santiago@nyu.edu>
X-Mailer: git-send-email 2.10.0
In-Reply-To: <20160922185317.349-1-santiago@nyu.edu>
References: <20160922185317.349-1-santiago@nyu.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Lukas P <luk.puehringer@gmail.com>

Calling functions for gpg_verify_tag() may desire to print relevant
information about the header for further verification. Add an optional
format argument to print any desired information after GPG verification.

Signed-off-by: Lukas Puehringer <lukas.puehringer@nyu.edu>
---
 builtin/tag.c        |  2 +-
 builtin/verify-tag.c |  6 ++++--
 tag.c                | 14 ++++++++++++--
 tag.h                |  4 ++--
 4 files changed, 19 insertions(+), 7 deletions(-)

diff --git a/builtin/tag.c b/builtin/tag.c
index dbf271f..94ed8a2 100644
--- a/builtin/tag.c
+++ b/builtin/tag.c
@@ -106,7 +106,7 @@ static int delete_tag(const char *name, const char *ref,
 static int verify_tag(const char *name, const char *ref,
 				const unsigned char *sha1)
 {
-	return gpg_verify_tag(sha1, name, GPG_VERIFY_VERBOSE);
+	return verify_and_format_tag(sha1, name, NULL, GPG_VERIFY_VERBOSE);
 }
 
 static int do_sign(struct strbuf *buffer)
diff --git a/builtin/verify-tag.c b/builtin/verify-tag.c
index 99f8148..7a1121b 100644
--- a/builtin/verify-tag.c
+++ b/builtin/verify-tag.c
@@ -51,8 +51,10 @@ int cmd_verify_tag(int argc, const char **argv, const char *prefix)
 		const char *name = argv[i++];
 		if (get_sha1(name, sha1))
 			had_error = !!error("tag '%s' not found.", name);
-		else if (gpg_verify_tag(sha1, name, flags))
-			had_error = 1;
+		else {
+			if (verify_and_format_tag(sha1, name, NULL, flags))
+				had_error = 1;
+		}
 	}
 	return had_error;
 }
diff --git a/tag.c b/tag.c
index d1dcd18..e08da51 100644
--- a/tag.c
+++ b/tag.c
@@ -3,6 +3,7 @@
 #include "commit.h"
 #include "tree.h"
 #include "blob.h"
+#include "ref-filter.h"
 
 const char *tag_type = "tag";
 
@@ -30,8 +31,8 @@ static int run_gpg_verify(const char *buf, unsigned long size, unsigned flags)
 	return ret;
 }
 
-int gpg_verify_tag(const unsigned char *sha1, const char *name_to_report,
-		unsigned flags)
+int verify_and_format_tag(const unsigned char *sha1, const char *name_to_report,
+		const char *fmt_pretty, unsigned flags)
 {
 	enum object_type type;
 	char *buf;
@@ -56,6 +57,15 @@ int gpg_verify_tag(const unsigned char *sha1, const char *name_to_report,
 	ret = run_gpg_verify(buf, size, flags);
 
 	free(buf);
+
+	if (fmt_pretty) {
+		struct ref_array_item *ref_item;
+		ref_item = new_ref_item(name_to_report, sha1, 0);
+		ref_item->kind = FILTER_REFS_TAGS;
+		show_ref_item(ref_item, fmt_pretty, 0);
+		free_ref_item(ref_item);
+	}
+
 	return ret;
 }
 
diff --git a/tag.h b/tag.h
index a5721b6..460b6f9 100644
--- a/tag.h
+++ b/tag.h
@@ -17,7 +17,7 @@ extern int parse_tag_buffer(struct tag *item, const void *data, unsigned long si
 extern int parse_tag(struct tag *item);
 extern struct object *deref_tag(struct object *, const char *, int);
 extern struct object *deref_tag_noverify(struct object *);
-extern int gpg_verify_tag(const unsigned char *sha1,
-		const char *name_to_report, unsigned flags);
+extern int verify_and_format_tag(const unsigned char *sha1,
+		const char *name_to_report, const char *fmt_pretty, unsigned flags);
 
 #endif /* TAG_H */
-- 
2.10.0

