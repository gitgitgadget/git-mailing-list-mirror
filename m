Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24956C433EF
	for <git@archiver.kernel.org>; Mon, 14 Feb 2022 18:23:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357432AbiBNSXX (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 14 Feb 2022 13:23:23 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:35456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245427AbiBNSXV (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 14 Feb 2022 13:23:21 -0500
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4AFBBCAB
        for <git@vger.kernel.org>; Mon, 14 Feb 2022 10:23:12 -0800 (PST)
Received: by mail-wm1-x32e.google.com with SMTP id o34so6346338wms.1
        for <git@vger.kernel.org>; Mon, 14 Feb 2022 10:23:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=SNpIy/07GQZSBrZ5H2sk7/nd388dliKlQOi7EWsbFEw=;
        b=j7xt+G1mwZ91sUzpN+TF9AxmDLGhymHb3wzVd2xS9B4EjxcG6iN8EBnOEKIEVESvaQ
         DrSbczZtTxRoCiV6kJZGbieg17/ShuA6s9C0GwBMR6GypDOaiaizW4Y1rYLcLlxMlEMa
         aMC2qU4xAl5PUhGvONZKIbqql1iLCZHaOntplVyoYCNYNNnHTCvwFWaEbTAE3vQnkb1h
         /0ISYD3FAnqcKzfogdg6+h55dP0b2EJJ8bNsGX27OraNzUWKxgRCyx8XFsDj8SufNyEG
         n2ZZW9b5BKcQDHTTtY9C8jSdTEFYXKvx0dCXBw8WYmDM2zXPFs7286yEhWwyU/vHpDvO
         DQNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=SNpIy/07GQZSBrZ5H2sk7/nd388dliKlQOi7EWsbFEw=;
        b=W9PilnvwULI2Hcylqxz8rsRYqtOcfU+NJPUaYlGDAiqD9g72adsrqOG08zdHdsxV4A
         paHQ77EOBRoKo4h/+yjO411e/+iwYxzPb0czcnGibHbPnzNy97dX8LtJw+m0dMIhBxNf
         AuNeTSqZdt5IRYfAxj6Gpw88bK8xkBjGVm82uSvaN+GhQ1ar9tBA6cqZiTLIqh0i1OcR
         IUipgi5hGYM4oHP4p4cQUWYcNcCK9weVYaPcBauC4+j02AdfEWIsAORdIuut42FsAh5R
         k1+Gn+Wuki4iHYsoKYRdVBSLtyVO99lk+leIBLs7g68rOCoebRCXIeW2KOEeavSQ/212
         1NjQ==
X-Gm-Message-State: AOAM531jtxfCQYzvnZNE3ZohHR4RJP5LA+d/d8K7InD425NoJ10U6OE9
        4BFuZhFpdRVA3EATjzXrXmHEDcajSiU=
X-Google-Smtp-Source: ABdhPJw0Y21Qe2js0wF6GKtHSe/JmX8XMK+DAj0pNcARdJOKUbhO2yU5I++t6Q11H8imidsueWYNFw==
X-Received: by 2002:a7b:cbd4:: with SMTP id n20mr22647wmi.33.1644862990986;
        Mon, 14 Feb 2022 10:23:10 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id n7sm12569731wmd.30.2022.02.14.10.23.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Feb 2022 10:23:10 -0800 (PST)
Message-Id: <fa6294387ab223d56e6ab66448f1ebe1ec370cd7.1644862988.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1212.v6.git.git.1644862988.gitgitgadget@gmail.com>
References: <pull.1212.v5.git.git.1644609683.gitgitgadget@gmail.com>
        <pull.1212.v6.git.git.1644862988.gitgitgadget@gmail.com>
From:   "John Cai via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 14 Feb 2022 18:23:05 +0000
Subject: [PATCH v6 1/4] cat-file: rename cmdmode to transform_mode
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     me@ttaylorr.com, phillip.wood123@gmail.com, avarab@gmail.com,
        e@80x24.org, bagasdotme@gmail.com, gitster@pobox.com,
        Eric Sunshine <sunshine@sunshineco.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Christian Couder <christian.couder@gmail.com>,
        John Cai <johncai86@gmail.com>, John Cai <johncai86@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: John Cai <johncai86@gmail.com>

In the next patch, we will add an enum on the batch_options struct that
indicates which type of batch operation will be used: --batch,
--batch-check and the soon to be  --batch-command that will read
commands from stdin. --batch-command mode might get confused with
the cmdmode flag.

There is value in renaming cmdmode in any case. cmdmode refers to how
the result output of the blob will be transformed, either according to
--filter or --textconv. So transform_mode is a more descriptive name
for the flag.

Rename cmdmode to transform_mode in cat-file.c

Signed-off-by: John Cai <johncai86@gmail.com>
---
 builtin/cat-file.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/builtin/cat-file.c b/builtin/cat-file.c
index 7b3f42950ec..5f015e71096 100644
--- a/builtin/cat-file.c
+++ b/builtin/cat-file.c
@@ -24,7 +24,7 @@ struct batch_options {
 	int buffer_output;
 	int all_objects;
 	int unordered;
-	int cmdmode; /* may be 'w' or 'c' for --filters or --textconv */
+	int transform_mode; /* may be 'w' or 'c' for --filters or --textconv */
 	const char *format;
 };
 
@@ -302,19 +302,19 @@ static void print_object_or_die(struct batch_options *opt, struct expand_data *d
 	if (data->type == OBJ_BLOB) {
 		if (opt->buffer_output)
 			fflush(stdout);
-		if (opt->cmdmode) {
+		if (opt->transform_mode) {
 			char *contents;
 			unsigned long size;
 
 			if (!data->rest)
 				die("missing path for '%s'", oid_to_hex(oid));
 
-			if (opt->cmdmode == 'w') {
+			if (opt->transform_mode == 'w') {
 				if (filter_object(data->rest, 0100644, oid,
 						  &contents, &size))
 					die("could not convert '%s' %s",
 					    oid_to_hex(oid), data->rest);
-			} else if (opt->cmdmode == 'c') {
+			} else if (opt->transform_mode == 'c') {
 				enum object_type type;
 				if (!textconv_object(the_repository,
 						     data->rest, 0100644, oid,
@@ -326,7 +326,7 @@ static void print_object_or_die(struct batch_options *opt, struct expand_data *d
 					die("could not convert '%s' %s",
 					    oid_to_hex(oid), data->rest);
 			} else
-				BUG("invalid cmdmode: %c", opt->cmdmode);
+				BUG("invalid transform_mode: %c", opt->transform_mode);
 			batch_write(opt, contents, size);
 			free(contents);
 		} else {
@@ -529,7 +529,7 @@ static int batch_objects(struct batch_options *opt)
 	strbuf_expand(&output, opt->format, expand_format, &data);
 	data.mark_query = 0;
 	strbuf_release(&output);
-	if (opt->cmdmode)
+	if (opt->transform_mode)
 		data.split_on_whitespace = 1;
 
 	/*
@@ -742,7 +742,7 @@ int cmd_cat_file(int argc, const char **argv, const char *prefix)
 	/* Return early if we're in batch mode? */
 	if (batch.enabled) {
 		if (opt_cw)
-			batch.cmdmode = opt;
+			batch.transform_mode = opt;
 		else if (opt && opt != 'b')
 			usage_msg_optf(_("'-%c' is incompatible with batch mode"),
 				       usage, options, opt);
-- 
gitgitgadget

