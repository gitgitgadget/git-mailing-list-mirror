Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BA19220756
	for <e@80x24.org>; Tue, 17 Jan 2017 23:39:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751598AbdAQXjB (ORCPT <rfc822;e@80x24.org>);
        Tue, 17 Jan 2017 18:39:01 -0500
Received: from mail-qk0-f195.google.com ([209.85.220.195]:36745 "EHLO
        mail-qk0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751493AbdAQXhd (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 17 Jan 2017 18:37:33 -0500
Received: by mail-qk0-f195.google.com with SMTP id a20so17393690qkc.3
        for <git@vger.kernel.org>; Tue, 17 Jan 2017 15:37:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nyu-edu.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=wID4o5kEetVUweBaiPzQTG0MqZNv7qaAk4r1XlHpfWg=;
        b=BDdTspCDL8NYK7tZdETBb8+qP/U1x5cF6e7XA9qVl/6olhhhhgXWPQQxdvQh/DFwzk
         LadN86j8op0FBh8+Mc5hZevbdWSgNaL81dIzAVDHPSwZz082DwjnKKlAk5Dxx/IOfjO6
         IOCQHVVRyHFjvseLf5PXh8ccdYivAy0QqECHZQZwa4L4lNRKc8j70h4kAHlhrmUVisB3
         mdbJsjXOHtgbYNI3+kcuJbKsA2Y/hpO4623SfkatLLQi9Q8c8we6XFIGUzFlaKWfGr9h
         tYMs79uKA7/RE1+M79bsb9O8zNHSb0R9zmaYYDloSeuwJaaqg+0sJKZcyeWcpYC0l1WP
         hNVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=wID4o5kEetVUweBaiPzQTG0MqZNv7qaAk4r1XlHpfWg=;
        b=bk9toVc2QHtGSLvH8OUGr8f38I29aI0CyLLZNZ3/z1RDwgLmVTPPdEbQlNbzBy4H/6
         r0v2FOzJD4WJbVJMgmIY2zpmbt7NieQlkV7oxqVtYWYDdkyDYQKKdLqGmVYjFQzmAikm
         PDR6YCp9qtGgtoqtUBxWIMFUPM9aR30U4d6crH35RiqldcXf5E+D3YHXQwHb6td0OkcV
         ggqc70eTZMjTYSudYZqBBuGIbt06vgcjUGlfFLdVhOiCVTgImXIl3zbP5tyCmxnOcdhn
         FbAhGDE2dDfeHYP5vHiYXO9hwueWp4PoZICSQJw8vMZYH9vJz+53aY5fsazCRFha/ija
         DsuQ==
X-Gm-Message-State: AIkVDXJJklxCGFmA4PQuLtYsZzsOSVD/6qOD5/Q0B3+ET5bRMoaDZG2TqeSpCd5UO+SK6YQL
X-Received: by 10.55.215.129 with SMTP id t1mr217393qkt.274.1484696252707;
        Tue, 17 Jan 2017 15:37:32 -0800 (PST)
Received: from localhost.localdomain (NYUFWA-WLESSAUTHCLIENTS-17.NATPOOL.NYU.EDU. [216.165.95.6])
        by smtp.gmail.com with ESMTPSA id c1sm3405814qke.36.2017.01.17.15.37.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 17 Jan 2017 15:37:32 -0800 (PST)
From:   santiago@nyu.edu
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, peff@peff.net, sunshine@sunshineco.com,
        walters@verbum.org, Lukas Puehringer <luk.puehringer@gmail.com>
Subject: [PATCH v6 4/6] builtin/tag: add --format argument for tag -v
Date:   Tue, 17 Jan 2017 18:37:21 -0500
Message-Id: <20170117233723.23897-5-santiago@nyu.edu>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20170117233723.23897-1-santiago@nyu.edu>
References: <20170117233723.23897-1-santiago@nyu.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Lukas Puehringer <luk.puehringer@gmail.com>

Adding --format to git tag -v mutes the default output of the GPG
verification and instead prints the formatted tag object.
This allows callers to cross-check the tagname from refs/tags with
the tagname from the tag object header upon GPG verification.

The callback function for for_each_tag_name() didn't allow callers to
pass custom data to their callback functions. Add a new opaque pointer
to each_tag_name_fn's parameter to allow this.

Signed-off-by: Lukas Puehringer <luk.puehringer@gmail.com>
---
 Documentation/git-tag.txt |  2 +-
 builtin/tag.c             | 38 ++++++++++++++++++++++++++++----------
 2 files changed, 29 insertions(+), 11 deletions(-)

diff --git a/Documentation/git-tag.txt b/Documentation/git-tag.txt
index 76cfe40d9..586aaa315 100644
--- a/Documentation/git-tag.txt
+++ b/Documentation/git-tag.txt
@@ -15,7 +15,7 @@ SYNOPSIS
 'git tag' [-n[<num>]] -l [--contains <commit>] [--points-at <object>]
 	[--column[=<options>] | --no-column] [--create-reflog] [--sort=<key>]
 	[--format=<format>] [--[no-]merged [<commit>]] [<pattern>...]
-'git tag' -v <tagname>...
+'git tag' -v [--format=<format>] <tagname>...
 
 DESCRIPTION
 -----------
diff --git a/builtin/tag.c b/builtin/tag.c
index 73df72811..b9da72761 100644
--- a/builtin/tag.c
+++ b/builtin/tag.c
@@ -24,7 +24,7 @@ static const char * const git_tag_usage[] = {
 	N_("git tag -d <tagname>..."),
 	N_("git tag -l [-n[<num>]] [--contains <commit>] [--points-at <object>]"
 		"\n\t\t[--format=<format>] [--[no-]merged [<commit>]] [<pattern>...]"),
-	N_("git tag -v <tagname>..."),
+	N_("git tag -v [--format=<format>] <tagname>..."),
 	NULL
 };
 
@@ -66,15 +66,17 @@ static int list_tags(struct ref_filter *filter, struct ref_sorting *sorting, con
 }
 
 typedef int (*each_tag_name_fn)(const char *name, const char *ref,
-				const unsigned char *sha1);
+				const unsigned char *sha1, void *cb_data);
 
-static int for_each_tag_name(const char **argv, each_tag_name_fn fn)
+static int for_each_tag_name(const char **argv, each_tag_name_fn fn,
+		void *cb_data)
 {
 	const char **p;
 	char ref[PATH_MAX];
 	int had_error = 0;
 	unsigned char sha1[20];
 
+
 	for (p = argv; *p; p++) {
 		if (snprintf(ref, sizeof(ref), "refs/tags/%s", *p)
 					>= sizeof(ref)) {
@@ -87,14 +89,14 @@ static int for_each_tag_name(const char **argv, each_tag_name_fn fn)
 			had_error = 1;
 			continue;
 		}
-		if (fn(*p, ref, sha1))
+		if (fn(*p, ref, sha1, cb_data))
 			had_error = 1;
 	}
 	return had_error;
 }
 
 static int delete_tag(const char *name, const char *ref,
-				const unsigned char *sha1)
+				const unsigned char *sha1, void *cb_data)
 {
 	if (delete_ref(ref, sha1, 0))
 		return 1;
@@ -103,9 +105,22 @@ static int delete_tag(const char *name, const char *ref,
 }
 
 static int verify_tag(const char *name, const char *ref,
-				const unsigned char *sha1)
+				const unsigned char *sha1, void *cb_data)
 {
-	return gpg_verify_tag(sha1, name, GPG_VERIFY_VERBOSE);
+	int flags;
+	char *fmt_pretty = cb_data;
+	flags = GPG_VERIFY_VERBOSE;
+
+	if (fmt_pretty)
+		flags = GPG_VERIFY_OMIT_STATUS;
+
+	if (gpg_verify_tag(sha1, name, flags))
+		return -1;
+
+    if (fmt_pretty)
+		pretty_print_ref(name, sha1, fmt_pretty);
+
+	return 0;
 }
 
 static int do_sign(struct strbuf *buffer)
@@ -428,9 +443,12 @@ int cmd_tag(int argc, const char **argv, const char *prefix)
 	if (filter.merge_commit)
 		die(_("--merged and --no-merged option are only allowed with -l"));
 	if (cmdmode == 'd')
-		return for_each_tag_name(argv, delete_tag);
-	if (cmdmode == 'v')
-		return for_each_tag_name(argv, verify_tag);
+		return for_each_tag_name(argv, delete_tag, NULL);
+	if (cmdmode == 'v') {
+		if (format)
+			verify_ref_format(format);
+		return for_each_tag_name(argv, verify_tag, format);
+	}
 
 	if (msg.given || msgfile) {
 		if (msg.given && msgfile)
-- 
2.11.0

