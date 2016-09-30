Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2946920986
	for <e@80x24.org>; Fri, 30 Sep 2016 22:18:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752059AbcI3WSV (ORCPT <rfc822;e@80x24.org>);
        Fri, 30 Sep 2016 18:18:21 -0400
Received: from mail-qk0-f193.google.com ([209.85.220.193]:35268 "EHLO
        mail-qk0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750832AbcI3WSP (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 30 Sep 2016 18:18:15 -0400
Received: by mail-qk0-f193.google.com with SMTP id j129so6751860qkd.2
        for <git@vger.kernel.org>; Fri, 30 Sep 2016 15:18:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nyu-edu.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=C6/sOySnP2pp2ULMV/QuRU+VRFBNAe3Q6Xqbc+XfoT4=;
        b=pAWmuxf+ebYzxFq2PjY6GEWJGtGz55TBQ1kRx48o0B1JFbl77g4QxfPe3uemldNNa5
         5CGTDK+tpMlzPMJt8IEKqHEWRJ6a0SM+zq0vvcWKnWGaTY2lkHkHKONvA7AKl0Fv9iUU
         c64Ee/6w0ktSNcNDGRPvWR4UgdPc7yg3hfFsAU4pNzkypBWQ7DoFC7COE0c4U22EUkvs
         sBe4dVnkBRrs2WV3Tt9UAPaFrHZvWqoVR1zqk6R88yTuqAhHn8PCnPdvXlQCw3X7Xy1X
         6K9/GnuiSRCRlYZPyaGRKEq4rKmDEndG3zIepdZkRwwdDrJpAyYUDSagLnGTPxRRuxAQ
         x+qA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=C6/sOySnP2pp2ULMV/QuRU+VRFBNAe3Q6Xqbc+XfoT4=;
        b=UjpWr7oUTnQ5F1YT2wc2RZhSo5ZkXZa978W2//xMwnfoJdtdW1yMH+pCxfUAltwszK
         nD6pvW1yc7H/l4P0GMg1QCUQTgcJFgBbjp8zk4HznR6kZ0Jwc6AtYP2Dy1B/b8hMY3eB
         de1MLdd1RQsSCE+iPKgGIJloF0x65ph43n6H3cM+NbfK6/a6SEPW/OLEKw40H05fLHZx
         ye/FfzFI5OJhz9nQhyHmr9uKy2vaAhCBJkzFUl/C3BDF/Km695zqaBrWcUePUwDeCTff
         BnOE3wvEdgoIVljpQkQLU/BrLAVK+1J3kqJAA2o9m+JNyZutixrQoKDM2sxrMhcYHSo0
         VaWg==
X-Gm-Message-State: AA6/9RlrjnCQobzuwVFprx/RxNrnsV0ASKurSzwTxR0jMilshq7pCchyhcVZLJ0ZCVDx2SkG
X-Received: by 10.55.21.164 with SMTP id 36mr9812209qkv.215.1475273894018;
        Fri, 30 Sep 2016 15:18:14 -0700 (PDT)
Received: from LykOS.localdomain (cpe-74-65-203-27.nyc.res.rr.com. [74.65.203.27])
        by smtp.gmail.com with ESMTPSA id x21sm11347615qkb.19.2016.09.30.15.18.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 30 Sep 2016 15:18:13 -0700 (PDT)
From:   santiago@nyu.edu
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, peff@peff.net, sunshine@sunshineco.com,
        walters@verbum.org, Lukas P <luk.puehringer@gmail.com>
Subject: [PATCH v3 3/5] tag: add format specifier to gpg_verify_tag
Date:   Fri, 30 Sep 2016 18:18:04 -0400
Message-Id: <20160930221806.3398-4-santiago@nyu.edu>
X-Mailer: git-send-email 2.10.0
In-Reply-To: <20160930221806.3398-1-santiago@nyu.edu>
References: <20160930221806.3398-1-santiago@nyu.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Lukas P <luk.puehringer@gmail.com>

Calling functions for gpg_verify_tag() may desire to print relevant
information about the header for further verification. Add an optional
format argument to print any desired information after GPG verification.

Signed-off-by: Lukas Puehringer <luk.puehringer@gmail.com>
---
 builtin/tag.c        |  2 +-
 builtin/verify-tag.c |  2 +-
 tag.c                | 17 +++++++++++------
 tag.h                |  4 ++--
 4 files changed, 15 insertions(+), 10 deletions(-)

diff --git a/builtin/tag.c b/builtin/tag.c
index 50e4ae5..14f3b48 100644
--- a/builtin/tag.c
+++ b/builtin/tag.c
@@ -105,7 +105,7 @@ static int delete_tag(const char *name, const char *ref,
 static int verify_tag(const char *name, const char *ref,
 				const unsigned char *sha1)
 {
-	return gpg_verify_tag(sha1, name, GPG_VERIFY_VERBOSE);
+	return verify_and_format_tag(sha1, name, NULL, GPG_VERIFY_VERBOSE);
 }
 
 static int do_sign(struct strbuf *buffer)
diff --git a/builtin/verify-tag.c b/builtin/verify-tag.c
index 99f8148..de10198 100644
--- a/builtin/verify-tag.c
+++ b/builtin/verify-tag.c
@@ -51,7 +51,7 @@ int cmd_verify_tag(int argc, const char **argv, const char *prefix)
 		const char *name = argv[i++];
 		if (get_sha1(name, sha1))
 			had_error = !!error("tag '%s' not found.", name);
-		else if (gpg_verify_tag(sha1, name, flags))
+		else if (verify_and_format_tag(sha1, name, NULL, flags))
 			had_error = 1;
 	}
 	return had_error;
diff --git a/tag.c b/tag.c
index 291073f..d3512c0 100644
--- a/tag.c
+++ b/tag.c
@@ -4,6 +4,7 @@
 #include "tree.h"
 #include "blob.h"
 #include "gpg-interface.h"
+#include "ref-filter.h"
 
 const char *tag_type = "tag";
 
@@ -33,8 +34,8 @@ static int run_gpg_verify(const char *buf, unsigned long size, unsigned flags)
 	return ret;
 }
 
-int gpg_verify_tag(const unsigned char *sha1, const char *name_to_report,
-		unsigned flags)
+int verify_and_format_tag(const unsigned char *sha1, const char *name,
+		const char *fmt_pretty, unsigned flags)
 {
 	enum object_type type;
 	char *buf;
@@ -44,21 +45,25 @@ int gpg_verify_tag(const unsigned char *sha1, const char *name_to_report,
 	type = sha1_object_info(sha1, NULL);
 	if (type != OBJ_TAG)
 		return error("%s: cannot verify a non-tag object of type %s.",
-				name_to_report ?
-				name_to_report :
+				name ?
+				name :
 				find_unique_abbrev(sha1, DEFAULT_ABBREV),
 				typename(type));
 
 	buf = read_sha1_file(sha1, &type, &size);
 	if (!buf)
 		return error("%s: unable to read file.",
-				name_to_report ?
-				name_to_report :
+				name ?
+				name :
 				find_unique_abbrev(sha1, DEFAULT_ABBREV));
 
 	ret = run_gpg_verify(buf, size, flags);
 
 	free(buf);
+
+	if (fmt_pretty)
+		pretty_print_ref(name, sha1, fmt_pretty, FILTER_REFS_TAGS);
+
 	return ret;
 }
 
diff --git a/tag.h b/tag.h
index a5721b6..896b9c2 100644
--- a/tag.h
+++ b/tag.h
@@ -17,7 +17,7 @@ extern int parse_tag_buffer(struct tag *item, const void *data, unsigned long si
 extern int parse_tag(struct tag *item);
 extern struct object *deref_tag(struct object *, const char *, int);
 extern struct object *deref_tag_noverify(struct object *);
-extern int gpg_verify_tag(const unsigned char *sha1,
-		const char *name_to_report, unsigned flags);
+extern int verify_and_format_tag(const unsigned char *sha1, const char *name,
+		const char *fmt_pretty, unsigned flags);
 
 #endif /* TAG_H */
-- 
2.10.0

