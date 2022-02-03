Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87FDFC433EF
	for <git@archiver.kernel.org>; Thu,  3 Feb 2022 19:08:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353694AbiBCTIO (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 3 Feb 2022 14:08:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353685AbiBCTIK (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 3 Feb 2022 14:08:10 -0500
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB4F0C061714
        for <git@vger.kernel.org>; Thu,  3 Feb 2022 11:08:09 -0800 (PST)
Received: by mail-wr1-x42b.google.com with SMTP id f17so6945453wrx.1
        for <git@vger.kernel.org>; Thu, 03 Feb 2022 11:08:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=0mShErQGd36+q/uNszciRr6X3mra+MArMa6Lk++g4Dc=;
        b=hfsRUtMLHQ5cz6f6a1lbwRsuXSerpCf3yB1kFoF1H+KXGUSxHY299HkTApGGwK6Gu3
         xLSTI2LHqbKznHvSakRpS1+2a2lGCsuiy+/MT/ICtD6ae3UinWMFl9Fex1jpa3nf1nOk
         x7YeWe9uylj5w/h3utT2Rm5WsorXIkQc8VnfXqyA+8mYb2tpxfMZ5MFcnBOJcLfng+Xg
         +GnuIOZX8uQQjcscRgJ/H4TwBzn2323bSMxoW/44fhS53fypwrPGgDk3nFGzI8kbtvmx
         yEtc2VA7pJIsvjXVD3IldjFCUDCciqTDvXHF+hgn2T/hzzAs9+ybKurlxOg+F/NA1l92
         bEtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=0mShErQGd36+q/uNszciRr6X3mra+MArMa6Lk++g4Dc=;
        b=IHoHxFhJYVIA394DdLHnuev9cUEBecXhjPpXkt0B+q4wkWD/yhqPKs/nzi6DLIiN0U
         ZgSPokuD3xtqmmFD8q5OFGD1BY76WXIpN555CvsPfrqFYlTRHbwCWjrRj8TBxCq7AJnK
         Z2sdeMCJcGA1tQ3hOVKC8yRijctxYoti7LR+cM/MbK6sYuH49EF6A7J+taT6ikVTLy1K
         7g/mJUOsroui/Z/l298S2xLksGVxWaZmCF4Z8jhZqzECgMB4vfwEJiYjjb+lVhZyEfXR
         VI49gJrVZjsVc9L+3YbPuTkYi/PvqsjEnPEHVw5XUZPzohX1KfDQHf85+fqtgNMvrUbv
         rxLQ==
X-Gm-Message-State: AOAM533vOXrRIBlFJimHalZbRSdXrgMBhymivQVynC2P7T9Z9f33zIzQ
        nqzbeD+m6AIsJQtJEA8QS1GgnnWxKDE=
X-Google-Smtp-Source: ABdhPJzHOlqmPlZsP0H2I/8NHL8JZ/XHHtFiJBjSeCfENk0vrLLdb8K9wuWygywuzhGQbk2W08r/ZA==
X-Received: by 2002:a5d:59a3:: with SMTP id p3mr31406844wrr.378.1643915288306;
        Thu, 03 Feb 2022 11:08:08 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id v8sm7490881wmd.44.2022.02.03.11.08.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Feb 2022 11:08:07 -0800 (PST)
Message-Id: <86df0c9e4df34566c10870e06865af536504a6af.1643915286.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1212.git.git.1643915286.gitgitgadget@gmail.com>
References: <pull.1212.git.git.1643915286.gitgitgadget@gmail.com>
From:   "John Cai via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 03 Feb 2022 19:08:05 +0000
Subject: [PATCH 1/2] cat-file.c: rename cmdmode to mode
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     me@ttaylorr.com, phillip.wood123@gmail.com, avarab@gmail.com,
        e@80x24.org, bagasdotme@gmail.com, gitster@pobox.com,
        John Cai <johncai86@gmail.com>, John Cai <johncai86@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: John Cai <johncai86@gmail.com>

To prepare for a new flag --batch-command, we will add a flag that
indicates whether or not an interactive command mode will be used
that reads commands and arguments off of stdin.

An intuitive name for this flag would be "command", which can get
confusing with the already existing cmdmode.

Rename cmdmode->mode to prepare for this change.

Signed-off-by: John Cai <johncai86@gmail.com>
---
 builtin/cat-file.c | 19 +++++++++----------
 1 file changed, 9 insertions(+), 10 deletions(-)

diff --git a/builtin/cat-file.c b/builtin/cat-file.c
index d94050e6c18..858bca208ff 100644
--- a/builtin/cat-file.c
+++ b/builtin/cat-file.c
@@ -24,7 +24,7 @@ struct batch_options {
 	int buffer_output;
 	int all_objects;
 	int unordered;
-	int cmdmode; /* may be 'w' or 'c' for --filters or --textconv */
+	int mode; /* may be 'w' or 'c' for --filters or --textconv */
 	const char *format;
 };
 
@@ -306,19 +306,19 @@ static void print_object_or_die(struct batch_options *opt, struct expand_data *d
 	if (data->type == OBJ_BLOB) {
 		if (opt->buffer_output)
 			fflush(stdout);
-		if (opt->cmdmode) {
+		if (opt->mode) {
 			char *contents;
 			unsigned long size;
 
 			if (!data->rest)
 				die("missing path for '%s'", oid_to_hex(oid));
 
-			if (opt->cmdmode == 'w') {
+			if (opt->mode == 'w') {
 				if (filter_object(data->rest, 0100644, oid,
 						  &contents, &size))
 					die("could not convert '%s' %s",
 					    oid_to_hex(oid), data->rest);
-			} else if (opt->cmdmode == 'c') {
+			} else if (opt->mode == 'c') {
 				enum object_type type;
 				if (!textconv_object(the_repository,
 						     data->rest, 0100644, oid,
@@ -330,7 +330,7 @@ static void print_object_or_die(struct batch_options *opt, struct expand_data *d
 					die("could not convert '%s' %s",
 					    oid_to_hex(oid), data->rest);
 			} else
-				BUG("invalid cmdmode: %c", opt->cmdmode);
+				BUG("invalid mode: %c", opt->mode);
 			batch_write(opt, contents, size);
 			free(contents);
 		} else {
@@ -533,7 +533,7 @@ static int batch_objects(struct batch_options *opt)
 	strbuf_expand(&output, opt->format, expand_format, &data);
 	data.mark_query = 0;
 	strbuf_release(&output);
-	if (opt->cmdmode)
+	if (opt->mode)
 		data.split_on_whitespace = 1;
 
 	/*
@@ -695,10 +695,9 @@ int cmd_cat_file(int argc, const char **argv, const char *prefix)
 
 	batch.buffer_output = -1;
 	argc = parse_options(argc, argv, prefix, options, cat_file_usage, 0);
-
 	if (opt) {
 		if (batch.enabled && (opt == 'c' || opt == 'w'))
-			batch.cmdmode = opt;
+			batch.mode = opt;
 		else if (argc == 1)
 			obj_name = argv[0];
 		else
@@ -712,9 +711,9 @@ int cmd_cat_file(int argc, const char **argv, const char *prefix)
 			usage_with_options(cat_file_usage, options);
 	}
 	if (batch.enabled) {
-		if (batch.cmdmode != opt || argc)
+		if (batch.mode != opt || argc)
 			usage_with_options(cat_file_usage, options);
-		if (batch.cmdmode && batch.all_objects)
+		if (batch.mode && batch.all_objects)
 			die("--batch-all-objects cannot be combined with "
 			    "--textconv nor with --filters");
 	}
-- 
gitgitgadget

