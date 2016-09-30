Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 60CBF20986
	for <e@80x24.org>; Fri, 30 Sep 2016 22:18:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933599AbcI3WS0 (ORCPT <rfc822;e@80x24.org>);
        Fri, 30 Sep 2016 18:18:26 -0400
Received: from mail-qk0-f195.google.com ([209.85.220.195]:34327 "EHLO
        mail-qk0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932883AbcI3WSR (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 30 Sep 2016 18:18:17 -0400
Received: by mail-qk0-f195.google.com with SMTP id n189so4796878qke.1
        for <git@vger.kernel.org>; Fri, 30 Sep 2016 15:18:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nyu-edu.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=UvgxaKSazf0BMEZVzdUlL/iDEBPqfjfbfmeC2wSA8zo=;
        b=1ETg9puEnx4kF083TWPGGvzM+paPzSNTpzgoWipy2TxQ6UkMbg6ULbewz7rlp/36Wk
         ZmJ4ebAAwb7c7Gqf7lF0Z0IMTBnCf/72opFSxLoHs3vhbminovcnMTlbILBURh37NA9g
         o1YLw+nBwvBzel4/dEjISGKqFjGwkTOf9jX/Rqv8zlwZ+WUjLsgGmdjibPzNLvcalWh8
         VLtDSq30xg8td40QtvS2LevfTKG+bmCtfwK0AVUd1WxYpBVUkz3CGZLfhKze1R5//2HV
         ldhWGL+3U2nDyD2n2B3e+Ny98ZdxJVuCULucvH9gs1LzwHQyh+bhaFcI/6QqxyJlD1Ec
         5Drw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=UvgxaKSazf0BMEZVzdUlL/iDEBPqfjfbfmeC2wSA8zo=;
        b=L5JAlkGKQBynqYp2uQfnbcmc4oPLGbDFkD+8nyevoRIy8JWbiKxbgdelR1IJsZCHDL
         FUU5d2wfC6c2hqvuHW2w4hohqM9WNrVg53SFSnBhyquT6TVriB0hBsxpCq0JM4rrGNIT
         Lw0xCuUXLz0lryz/KqdJUMp5yXRokp6oYbqSs7ywtzi+65OqBGRJHeZOdambL2Ha3ph+
         ApTJXFfxG8eGZue3W4I12uxkqTNdvKvj6Nyu81uQ6IWnTCFtxGZSnY0zZnN7IReaCdAp
         wiwvgDddOT2Z2esgB254RtqmjbtCBXASdYjyYw7uSYdvrv9j4VFXgwPra1aQVMet4vBZ
         x61w==
X-Gm-Message-State: AA6/9RndZMtNq3wh3LVoTT2Sn/rUFsGMGrN6VT8jYEuXMjSA2/LUOiXBaEhSa7vcBbyhOhNP
X-Received: by 10.55.65.70 with SMTP id o67mr9279833qka.305.1475273896158;
        Fri, 30 Sep 2016 15:18:16 -0700 (PDT)
Received: from LykOS.localdomain (cpe-74-65-203-27.nyc.res.rr.com. [74.65.203.27])
        by smtp.gmail.com with ESMTPSA id x21sm11347615qkb.19.2016.09.30.15.18.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 30 Sep 2016 15:18:15 -0700 (PDT)
From:   santiago@nyu.edu
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, peff@peff.net, sunshine@sunshineco.com,
        walters@verbum.org, Lukas Puehringer <luk.puehringer@gmail.com>
Subject: [PATCH v3 5/5] builtin/tag: add --format argument for tag -v
Date:   Fri, 30 Sep 2016 18:18:06 -0400
Message-Id: <20160930221806.3398-6-santiago@nyu.edu>
X-Mailer: git-send-email 2.10.0
In-Reply-To: <20160930221806.3398-1-santiago@nyu.edu>
References: <20160930221806.3398-1-santiago@nyu.edu>
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
 builtin/tag.c             | 34 +++++++++++++++++++++++-----------
 2 files changed, 24 insertions(+), 12 deletions(-)

diff --git a/Documentation/git-tag.txt b/Documentation/git-tag.txt
index 7ecca8e..3bb5e3c 100644
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
index 14f3b48..7730fd0 100644
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
@@ -103,9 +105,16 @@ static int delete_tag(const char *name, const char *ref,
 }
 
 static int verify_tag(const char *name, const char *ref,
-				const unsigned char *sha1)
+				const unsigned char *sha1, void *cb_data)
 {
-	return verify_and_format_tag(sha1, name, NULL, GPG_VERIFY_VERBOSE);
+	int flags;
+    char *fmt_pretty = cb_data;
+	flags = GPG_VERIFY_VERBOSE;
+
+	if (fmt_pretty)
+		flags = GPG_VERIFY_QUIET;
+
+	return verify_and_format_tag(sha1, name, fmt_pretty, flags);
 }
 
 static int do_sign(struct strbuf *buffer)
@@ -334,7 +343,7 @@ int cmd_tag(int argc, const char **argv, const char *prefix)
 	struct strbuf err = STRBUF_INIT;
 	struct ref_filter filter;
 	static struct ref_sorting *sorting = NULL, **sorting_tail = &sorting;
-	const char *format = NULL;
+	char *format = NULL;
 	struct option options[] = {
 		OPT_CMDMODE('l', "list", &cmdmode, N_("list tag names"), 'l'),
 		{ OPTION_INTEGER, 'n', NULL, &filter.lines, N_("n"),
@@ -424,9 +433,12 @@ int cmd_tag(int argc, const char **argv, const char *prefix)
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
2.10.0

