Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EB7D9207D6
	for <e@80x24.org>; Fri,  5 May 2017 05:28:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753341AbdEEF1k (ORCPT <rfc822;e@80x24.org>);
        Fri, 5 May 2017 01:27:40 -0400
Received: from mail-io0-f195.google.com ([209.85.223.195]:35778 "EHLO
        mail-io0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751561AbdEEF1h (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 5 May 2017 01:27:37 -0400
Received: by mail-io0-f195.google.com with SMTP id v34so8561996iov.2
        for <git@vger.kernel.org>; Thu, 04 May 2017 22:27:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=udec71M+Toe479rvO8VrwYv4KpxbfpaKZIDdEuywzQQ=;
        b=FZhw6U2KpVn0f/S3lcNAnd0LadpKfMEiZMv85ix2L+LnjCTWp1aHuN+uclvOSewZT9
         MDmjgRLdExFOZGDSxeDHk05Xbhpj7ABQOUztAqaZoknHNY1llb+pMSZWB76KcV7Ga8sV
         m6TXKajtTGXwY2LaYYWY1cww8luHfCublVD58blu4HTIAZiN+01fz73I603sfhutLKvF
         lTTbGtfEcXTbYg+xPfVttLhx9kDBV0d0ucrZhWbxiHoBBUmVgxHSLwNE/HA0kUzHx1qS
         6niF3K4/92PEA56ALEIySDhJgi0fpZWtpwpwuEeHV/wK4FQKQo7/h+OWH0k7tFlIcaAz
         f8xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=udec71M+Toe479rvO8VrwYv4KpxbfpaKZIDdEuywzQQ=;
        b=T5WdU2tH1MhBKJLERR/eCYdRfzZ5306ZdbHjulDe+ODJitPVX4HHpZSr3o/v4wJg0B
         qAaVc7O0r39t8BfFJZKC1yC9yn3TfEjdIxsZsmbUoj4Lxaw1zZjvSGDIeHa1KRQOQRvs
         WujS7CJcUYdkKrZ1QuBcSxRfy4ysPKZCX78uB2la26+82FLsi1V7JfJKTxr5R6ZGzb3P
         fLOw0/wgglnce0OlP474KEM9cTzHByGOjjmWSJtVcYqURvV71PHkgL9yuckhGHq3T6Ot
         kt8qmQCpkUgWIBZbSf91/oysqkK2mIgH7n3KyddchSFgH5M9bUgUjqO1e5KIuD7chlQr
         gEEA==
X-Gm-Message-State: AN3rC/68JnRmqPwnzMUMerGyYPS1Nc1yOoEgN8lNrQ/B5ztbuoJODRtu
        MmDffCnU5gSBtw==
X-Received: by 10.157.49.89 with SMTP id v25mr8811013otd.45.1493962056284;
        Thu, 04 May 2017 22:27:36 -0700 (PDT)
Received: from whydoubt.T-mobile.com (ip68-12-240-88.ok.ok.cox.net. [68.12.240.88])
        by smtp.gmail.com with ESMTPSA id 2sm2179586ota.46.2017.05.04.22.27.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 04 May 2017 22:27:35 -0700 (PDT)
From:   Jeff Smith <whydoubt@gmail.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, peff@peff.net, Jeff Smith <whydoubt@gmail.com>
Subject: [RFC PATCH 02/10] Move textconv_object to be with other textconv methods
Date:   Fri,  5 May 2017 00:27:21 -0500
Message-Id: <20170505052729.7576-3-whydoubt@gmail.com>
X-Mailer: git-send-email 2.9.3
In-Reply-To: <20170505052729.7576-1-whydoubt@gmail.com>
References: <20170505052729.7576-1-whydoubt@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Jeff Smith <whydoubt@gmail.com>
---
 builtin.h          |  2 --
 builtin/blame.c    | 28 ----------------------------
 builtin/cat-file.c |  1 +
 diff.c             | 23 +++++++++++++++++++++++
 diff.h             |  7 +++++++
 5 files changed, 31 insertions(+), 30 deletions(-)

diff --git a/builtin.h b/builtin.h
index 9e4a898..498ac80 100644
--- a/builtin.h
+++ b/builtin.h
@@ -25,8 +25,6 @@ struct fmt_merge_msg_opts {
 extern int fmt_merge_msg(struct strbuf *in, struct strbuf *out,
 			 struct fmt_merge_msg_opts *);
 
-extern int textconv_object(const char *path, unsigned mode, const struct object_id *oid, int oid_valid, char **buf, unsigned long *buf_size);
-
 extern int is_builtin(const char *s);
 
 extern int cmd_add(int argc, const char **argv, const char *prefix);
diff --git a/builtin/blame.c b/builtin/blame.c
index 42c56eb..c419981 100644
--- a/builtin/blame.c
+++ b/builtin/blame.c
@@ -147,34 +147,6 @@ static int diff_hunks(mmfile_t *file_a, mmfile_t *file_b,
 }
 
 /*
- * Prepare diff_filespec and convert it using diff textconv API
- * if the textconv driver exists.
- * Return 1 if the conversion succeeds, 0 otherwise.
- */
-int textconv_object(const char *path,
-		    unsigned mode,
-		    const struct object_id *oid,
-		    int oid_valid,
-		    char **buf,
-		    unsigned long *buf_size)
-{
-	struct diff_filespec *df;
-	struct userdiff_driver *textconv;
-
-	df = alloc_filespec(path);
-	fill_filespec(df, oid->hash, oid_valid, mode);
-	textconv = get_textconv(df);
-	if (!textconv) {
-		free_filespec(df);
-		return 0;
-	}
-
-	*buf_size = fill_textconv(textconv, df, buf);
-	free_filespec(df);
-	return 1;
-}
-
-/*
  * Given an origin, prepare mmfile_t structure to be used by the
  * diff machinery
  */
diff --git a/builtin/cat-file.c b/builtin/cat-file.c
index 1890d7a..79a2c82 100644
--- a/builtin/cat-file.c
+++ b/builtin/cat-file.c
@@ -5,6 +5,7 @@
  */
 #include "cache.h"
 #include "builtin.h"
+#include "diff.h"
 #include "parse-options.h"
 #include "userdiff.h"
 #include "streaming.h"
diff --git a/diff.c b/diff.c
index 11eef1c..a62e989 100644
--- a/diff.c
+++ b/diff.c
@@ -5270,6 +5270,29 @@ size_t fill_textconv(struct userdiff_driver *driver,
 	return size;
 }
 
+int textconv_object(const char *path,
+		    unsigned mode,
+		    const struct object_id *oid,
+		    int oid_valid,
+		    char **buf,
+		    unsigned long *buf_size)
+{
+	struct diff_filespec *df;
+	struct userdiff_driver *textconv;
+
+	df = alloc_filespec(path);
+	fill_filespec(df, oid->hash, oid_valid, mode);
+	textconv = get_textconv(df);
+	if (!textconv) {
+		free_filespec(df);
+		return 0;
+	}
+
+	*buf_size = fill_textconv(textconv, df, buf);
+	free_filespec(df);
+	return 1;
+}
+
 void setup_diff_pager(struct diff_options *opt)
 {
 	/*
diff --git a/diff.h b/diff.h
index 5be1ee7..52ebd54 100644
--- a/diff.h
+++ b/diff.h
@@ -385,6 +385,13 @@ extern size_t fill_textconv(struct userdiff_driver *driver,
  */
 extern struct userdiff_driver *get_textconv(struct diff_filespec *one);
 
+/*
+ * Prepare diff_filespec and convert it using diff textconv API
+ * if the textconv driver exists.
+ * Return 1 if the conversion succeeds, 0 otherwise.
+ */
+extern int textconv_object(const char *path, unsigned mode, const struct object_id *oid, int oid_valid, char **buf, unsigned long *buf_size);
+
 extern int parse_rename_score(const char **cp_p);
 
 extern long parse_algorithm_value(const char *value);
-- 
2.9.3

