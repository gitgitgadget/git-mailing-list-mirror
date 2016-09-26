Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1817320986
	for <e@80x24.org>; Mon, 26 Sep 2016 22:43:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933250AbcIZWm6 (ORCPT <rfc822;e@80x24.org>);
        Mon, 26 Sep 2016 18:42:58 -0400
Received: from mail-qk0-f194.google.com ([209.85.220.194]:36235 "EHLO
        mail-qk0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753918AbcIZWmy (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Sep 2016 18:42:54 -0400
Received: by mail-qk0-f194.google.com with SMTP id m184so4646586qkb.3
        for <git@vger.kernel.org>; Mon, 26 Sep 2016 15:42:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nyu-edu.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=mFVTtELhGwHGtF7/BZmykLnSrXn+UjHBT4kctw7pKbU=;
        b=ey+edPRwn7rR0xepTgjji2KygYWHYgLKhKUdoqm5F9QMqgV5QvWYpUhxHVya54r2Yr
         8qpjo6yNg362OXYyNUSNYAX5t3CoHqnVDFzC7l6hxitDOYQuPHe8GJqkpbUp7iL0LAeh
         BNmuPv98tQvinYTYp8235ifNsVqf08NasYx+vk9STgYYkVyYE8gP73uaaSE2KdiPACv7
         ozR9/CWtSaGvDBG4D4TOqNrVTKBxtp2NeVAEvHiRCkMrzkrnNbRBnG8x0aEdeLpYZa/i
         vQ8TPCp5v/Y+X9H1vgw0GAWIL5+ZenHsp0sBO6/rllA9a4vjBvbX8AQg6j/uOVXBjSfD
         LPfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=mFVTtELhGwHGtF7/BZmykLnSrXn+UjHBT4kctw7pKbU=;
        b=NK77hwCIRui1cYRE27vCLomS3sZ4ZkgIVECqF/hTtc8JU6y1agmQE2iRMhcwF2gljl
         3xi4ozmlmAnAZ0+GbR5SwwWeD4uOL7FmlquRmj/nh3UVlC3VxZoDCupggPccZOhTbbtH
         UAyJ1vsBpWPPLVMFCQ6rwv7bOuPLPqJdAFaD7l/k7ZfiyoYPuG48VeHxfgUe6jKCOmH4
         YNXqvrPrbi6Gi9J00neUfw8LxQOsUkd8yrCKQvf+5vLAHb8tQTeT5KybHt5TDHv2KP3Q
         PQqmUKE8mAYY26rvSg8edW2iA3XLBC4qiUg2nMnu5GfWcOsFkEOnJUj6/VW/Nrg+9aiG
         0Kww==
X-Gm-Message-State: AA6/9RnIMyZUJLhYOAuAmGamdyp3Bm+ALKCzVkXP63m/Xl+IBZX+wyUHEAZHrWoZtjq/A1qr
X-Received: by 10.55.105.130 with SMTP id e124mr23749227qkc.183.1474929772836;
        Mon, 26 Sep 2016 15:42:52 -0700 (PDT)
Received: from LykOS.localdomain (cpe-74-65-203-27.nyc.res.rr.com. [74.65.203.27])
        by smtp.gmail.com with ESMTPSA id 62sm12840092qtg.14.2016.09.26.15.42.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 26 Sep 2016 15:42:52 -0700 (PDT)
From:   santiago@nyu.edu
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, peff@peff.net, sunshine@sunshineco.com,
        walters@verbum.org, Lukas P <luk.puehringer@gmail.com>
Subject: [PATCH v2 3/5] tag: add format specifier to gpg_verify_tag
Date:   Mon, 26 Sep 2016 18:42:31 -0400
Message-Id: <20160926224233.32702-4-santiago@nyu.edu>
X-Mailer: git-send-email 2.10.0
In-Reply-To: <20160926224233.32702-1-santiago@nyu.edu>
References: <20160926224233.32702-1-santiago@nyu.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Lukas P <luk.puehringer@gmail.com>

Calling functions for gpg_verify_tag() may desire to print relevant
information about the header for further verification. Add an optional
format argument to print any desired information after GPG verification.

Signed-off-by: Lukas P <luk.puehringer@gmail.com>
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
index 291073f..65e1a96 100644
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
+		format_ref(name, sha1, fmt_pretty, FILTER_REFS_TAGS);
+
 	return ret;
 }
 
diff --git a/tag.h b/tag.h
index a5721b6..0b6e458 100644
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

