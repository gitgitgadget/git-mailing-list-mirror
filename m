Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 821D9C433EF
	for <git@archiver.kernel.org>; Tue,  8 Feb 2022 22:24:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1387538AbiBHWYm (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 8 Feb 2022 17:24:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1386596AbiBHU6I (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Feb 2022 15:58:08 -0500
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40716C0612B8
        for <git@vger.kernel.org>; Tue,  8 Feb 2022 12:58:08 -0800 (PST)
Received: by mail-wr1-x42e.google.com with SMTP id m14so481371wrg.12
        for <git@vger.kernel.org>; Tue, 08 Feb 2022 12:58:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=SNpIy/07GQZSBrZ5H2sk7/nd388dliKlQOi7EWsbFEw=;
        b=aAo2Pab2NZNBLqNB+rZlAIPQGIhhVpinFVJBgGfYk1D9AB3HNzBqlMjFzZrwM5jAZG
         OvFkBDb8QbYryVMHnbHXP1UPC1VV9AxZQEgl7flNacr6HKdeuL1BbeAeRWvz7NE7dBbK
         ldjhliMkAUgpSHWeJw4zsjKakJKqqgha92+qvFzU13UMj9XaHR48DdI2QYAu1TmUdN9i
         UUGme24HoTmzxsI2hP64eoHIaez4upzhXFf0VJdpfh1aGI9sPbQ1Af73loOuEQle9gPz
         YM/JdSvZaQ5svHfIZxGcQ5wx3OlOVfCN1YShp+qe6wXunS7LLCqagglyU7Y57/WDOcJ+
         fVrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=SNpIy/07GQZSBrZ5H2sk7/nd388dliKlQOi7EWsbFEw=;
        b=IbyZyZh7tz5AKp/6qTCvtNjzDAcCzgpcWdaDozbK/yr12OSiYo9gz/Tq5U49lKtnSB
         69f0jKKFqGb5A09if3USDBynSg5KvIPVx+KlcIUSNgEQ81W1YGAq+KhUw2i57WJ1adlO
         ghgI/35BOLE5FXvhKHsWs4oFzcBtN55KbEgSEVVasgoBrA5PfamQ6663s/bDaWAY8mCe
         yeFRUmB+uNYc5eZM1QJIfqN+MCYC/7Vc1j2Fp+2y6DVPG0Vv2bj++HBOJiQiXr2Q3W9+
         KFagOIOh3Ov0amfGAW+kRGYkjkOu4oCIyMPbB1I7oB7vc7/YPN40wg0yAL4XvcXtseyU
         Zzhw==
X-Gm-Message-State: AOAM533Z+nhU6fycAOqeM8xWioAYxfj8ty/IAQRKABQIvVNOrZRvaox9
        KlekwdlKLJSXUsG/WoI583WVibAzgp8=
X-Google-Smtp-Source: ABdhPJysCFSfcTC12WxFs/mb1blsnOuq55tj4sGAumNYHp2VFGQVFYONnmUsXGe5NAhjfjwdotAmgw==
X-Received: by 2002:a05:6000:150:: with SMTP id r16mr4927978wrx.59.1644353886709;
        Tue, 08 Feb 2022 12:58:06 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id y8sm15628298wrd.32.2022.02.08.12.58.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Feb 2022 12:58:06 -0800 (PST)
Message-Id: <fa6294387ab223d56e6ab66448f1ebe1ec370cd7.1644353884.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1212.v3.git.git.1644353884.gitgitgadget@gmail.com>
References: <pull.1212.v2.git.git.1644251611.gitgitgadget@gmail.com>
        <pull.1212.v3.git.git.1644353884.gitgitgadget@gmail.com>
From:   "John Cai via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 08 Feb 2022 20:58:02 +0000
Subject: [PATCH v3 1/3] cat-file: rename cmdmode to transform_mode
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     me@ttaylorr.com, phillip.wood123@gmail.com, avarab@gmail.com,
        e@80x24.org, bagasdotme@gmail.com, gitster@pobox.com,
        Eric Sunshine <sunshine@sunshineco.com>,
        Jonathan Tan <jonathantanmy@google.com>,
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

