Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5ADB51F87F
	for <e@80x24.org>; Sun, 11 Nov 2018 09:53:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727493AbeKKTlF (ORCPT <rfc822;e@80x24.org>);
        Sun, 11 Nov 2018 14:41:05 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:42302 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727448AbeKKTlF (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 11 Nov 2018 14:41:05 -0500
Received: by mail-lj1-f193.google.com with SMTP id f3-v6so5059824ljk.9
        for <git@vger.kernel.org>; Sun, 11 Nov 2018 01:52:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=2NLroxYtFz/Q+/dyGYrd4J55EzRUFRKuLfRxXwY8gmw=;
        b=EcDYQp+sVY2CoXFd2QHcHLZIqRLeDgXijpxCVW2ra7/i/2N9MMAqoupi8XuPl3lYL3
         2ofvZiDiTeFm63oomIeBzgfeVrqDQnjEpeT+T5IpKpcfvxgIoCMrWeymo1eR84TYuYTm
         9NL7YWGPNUjBhScXCWxVZXs3eZZHgmYw8YiuqGMkGfEt9whfOEGPxGEeIhCkpyx/HPun
         UlICbwc61TyN4m50w5miX10rDUwJRuoDeQ1eoJpAW9yyDQ9XyBIogOj3X546MopU0f8y
         ulaNl4YPIeWXlYizibjk87v/j29mTHq1pe4jaDQe2mXbrWCPqFLdLFY3o0As4yN+Ewg8
         Kecw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=2NLroxYtFz/Q+/dyGYrd4J55EzRUFRKuLfRxXwY8gmw=;
        b=difnIVq7Z51Z5ds1XqXBL+uEsMxJie7qZay6MOlnjiQp54CpwRq1kj80YREQGa6l2l
         2pKcmSSbw/qfL9jgopw1bxo01/66eljE1ZA2cihpeXq3AzXPIU3mkdNx+e9V0BziMEAW
         HKJWk3uxURx2tVdtzyyqvwI+3c4MubE5QRJYh8ZKmplRkErCOD/tiUlNmtt9VBPlMd0C
         ORkm4j0SUbLurg1PC/61kC7N1fMPZgwvkcYbFYCvtd4aemA/0WucEltgV8Y1E/+J6xEh
         Tlr0Liha17w4F2SoyFcTqvUrS5mkyEVeBLv0oAWJ17Znrgga882QiLaJ/4PnT/zzb6XA
         3//A==
X-Gm-Message-State: AGRZ1gJzj6wVdh/pUsGqe++e2vzc+kQbLMNLB9eO0C2Ld/V2YuxAK7Dn
        iBOAQWZFHI4VTnEquvRf1qOwFknU
X-Google-Smtp-Source: AJdET5egMmNdTURouHFb1n16xvWdWL++tvUcVKO7SjM5cx9eE2x3Qp3GutHQrTAG6+YjbkjjtgoV1Q==
X-Received: by 2002:a2e:9cd2:: with SMTP id g18-v6mr10249296ljj.161.1541929976833;
        Sun, 11 Nov 2018 01:52:56 -0800 (PST)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id r69sm2584495lfi.15.2018.11.11.01.52.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 11 Nov 2018 01:52:55 -0800 (PST)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [RFC PATCH] Introduce "precious" file concept
Date:   Sun, 11 Nov 2018 10:52:54 +0100
Message-Id: <20181111095254.30473-1-pclouds@gmail.com>
X-Mailer: git-send-email 2.19.1.1235.ga92291acdb
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Since this topic has come up twice recently, I revisited this
"precious" thingy that I started four years ago and tried to see if I
could finally finish it. There are a couple things to be sorted out...

A new attribute "precious" is added to indicate that certain files
have valuable content and should not be easily discarded even if they
are ignored or untracked (*).

So far there are two parts of Git that are made aware of precious
files: "git clean" will leave precious files alone and unpack-trees.c
(i.e. merges and branch switches) will not overwrite
ignored-but-precious files.

Is there any other parts of Git that should be made aware of this
"precious" attribute?

Also while "precious" is a fun name, but it does not sound serious.
Any suggestions? Perhaps "valuable"?

Very lightly tested. The patch is more to have something to discuss
than is bug free and ready to use.

(*) Note that tracked files could be marked "precious" in the future
    too although the exact semantics is not very clear since tracked
    files are by default precious.

    But something like "index log" could use this to record all
    changes to precious files instead of just "git add -p" changes,
    for example. So these files are in a sense more precious than
    other tracked files.

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 Documentation/git-clean.txt     |  3 ++-
 Documentation/gitattributes.txt | 13 +++++++++++++
 attr.c                          |  9 +++++++++
 attr.h                          |  2 ++
 builtin/clean.c                 | 19 ++++++++++++++++---
 unpack-trees.c                  |  3 ++-
 6 files changed, 44 insertions(+), 5 deletions(-)

diff --git a/Documentation/git-clean.txt b/Documentation/git-clean.txt
index 03056dad0d..a9beadfb12 100644
--- a/Documentation/git-clean.txt
+++ b/Documentation/git-clean.txt
@@ -21,7 +21,8 @@ option is specified, ignored files are also removed. This can, for
 example, be useful to remove all build products.
 
 If any optional `<path>...` arguments are given, only those paths
-are affected.
+are affected. Ignored or untracked files with `precious` attributes
+are not removed.
 
 OPTIONS
 -------
diff --git a/Documentation/gitattributes.txt b/Documentation/gitattributes.txt
index b8392fc330..c722479bdc 100644
--- a/Documentation/gitattributes.txt
+++ b/Documentation/gitattributes.txt
@@ -1188,6 +1188,19 @@ If this attribute is not set or has an invalid value, the value of the
 (See linkgit:git-config[1]).
 
 
+Precious files
+~~~~~~~~~~~~~~~~~~~~~~~~
+
+`precious`
+^^^^^^^^^^
+
+This attribute is set on files to indicate that their content is
+valuable. Many commands will behave slightly different on precious
+files. linkgit:git-clean[1] will leave precious files alone. Merging
+and branch switching will not silently overwrite ignored files that
+are marked "precious".
+
+
 USING MACRO ATTRIBUTES
 ----------------------
 
diff --git a/attr.c b/attr.c
index 60d284796d..d06ca0ae4b 100644
--- a/attr.c
+++ b/attr.c
@@ -1186,3 +1186,12 @@ void attr_start(void)
 	pthread_mutex_init(&check_vector.mutex, NULL);
 #endif
 }
+
+int is_precious_file(struct index_state *istate, const char *path)
+{
+	static struct attr_check *check;
+	if (!check)
+		check = attr_check_initl("precious", NULL);
+	git_check_attr(istate, path, check);
+	return check && ATTR_TRUE(check->items[0].value);
+}
diff --git a/attr.h b/attr.h
index b0378bfe5f..b9a9751a66 100644
--- a/attr.h
+++ b/attr.h
@@ -82,4 +82,6 @@ void git_attr_set_direction(enum git_attr_direction new_direction);
 
 void attr_start(void);
 
+int is_precious_file(struct index_state *istate, const char *path);
+
 #endif /* ATTR_H */
diff --git a/builtin/clean.c b/builtin/clean.c
index 8d9a7dc206..9e554448a6 100644
--- a/builtin/clean.c
+++ b/builtin/clean.c
@@ -17,6 +17,7 @@
 #include "color.h"
 #include "pathspec.h"
 #include "help.h"
+#include "attr.h"
 
 static int force = -1; /* unset */
 static int interactive;
@@ -30,6 +31,8 @@ static const char *const builtin_clean_usage[] = {
 
 static const char *msg_remove = N_("Removing %s\n");
 static const char *msg_would_remove = N_("Would remove %s\n");
+static const char *msg_skip_precious = N_("Skipping precious file %s\n");
+static const char *msg_would_skip_precious = N_("Would skip precious file %s\n");
 static const char *msg_skip_git_dir = N_("Skipping repository %s\n");
 static const char *msg_would_skip_git_dir = N_("Would skip repository %s\n");
 static const char *msg_warn_remove_failed = N_("failed to remove %s");
@@ -152,6 +155,7 @@ static int remove_dirs(struct strbuf *path, const char *prefix, int force_flag,
 	struct dirent *e;
 	int res = 0, ret = 0, gone = 1, original_len = path->len, len;
 	struct string_list dels = STRING_LIST_INIT_DUP;
+	const char *rel_path;
 
 	*dir_gone = 1;
 
@@ -191,9 +195,15 @@ static int remove_dirs(struct strbuf *path, const char *prefix, int force_flag,
 
 		strbuf_setlen(path, len);
 		strbuf_addstr(path, e->d_name);
-		if (lstat(path->buf, &st))
+		if (lstat(path->buf, &st)) {
 			; /* fall thru */
-		else if (S_ISDIR(st.st_mode)) {
+		} else if ((!prefix || skip_prefix(path->buf, prefix, &rel_path)) &&
+			   is_precious_file(&the_index, rel_path)) {
+			quote_path_relative(path->buf, prefix, &quoted);
+			printf(dry_run ? _(msg_would_skip_precious) : _(msg_skip_precious), quoted.buf);
+			*dir_gone = 0;
+			continue;
+		} else if (S_ISDIR(st.st_mode)) {
 			if (remove_dirs(path, prefix, force_flag, dry_run, quiet, &gone))
 				ret = 1;
 			if (gone) {
@@ -1017,7 +1027,10 @@ int cmd_clean(int argc, const char **argv, const char *prefix)
 		if (lstat(abs_path.buf, &st))
 			continue;
 
-		if (S_ISDIR(st.st_mode)) {
+		if (is_precious_file(&the_index, item->string)) {
+			qname = quote_path_relative(item->string, NULL, &buf);
+			printf(dry_run ? _(msg_would_skip_precious) : _(msg_skip_precious), qname);
+		} else if (S_ISDIR(st.st_mode)) {
 			if (remove_dirs(&abs_path, prefix, rm_flags, dry_run, quiet, &gone))
 				errors++;
 			if (gone && !quiet) {
diff --git a/unpack-trees.c b/unpack-trees.c
index 7570df481b..d49fe0f77e 100644
--- a/unpack-trees.c
+++ b/unpack-trees.c
@@ -1895,7 +1895,8 @@ static int check_ok_to_remove(const char *name, int len, int dtype,
 		return 0;
 
 	if (o->dir &&
-	    is_excluded(o->dir, o->src_index, name, &dtype))
+	    is_excluded(o->dir, o->src_index, name, &dtype) &&
+	    !is_precious_file(o->src_index, name))
 		/*
 		 * ce->name is explicitly excluded, so it is Ok to
 		 * overwrite it.
-- 
2.19.1.1235.ga92291acdb

