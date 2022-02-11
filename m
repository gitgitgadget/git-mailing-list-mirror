Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39FECC433EF
	for <git@archiver.kernel.org>; Fri, 11 Feb 2022 20:01:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353064AbiBKUBc (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 11 Feb 2022 15:01:32 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:44220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235284AbiBKUBa (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 11 Feb 2022 15:01:30 -0500
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35C73C4F
        for <git@vger.kernel.org>; Fri, 11 Feb 2022 12:01:29 -0800 (PST)
Received: by mail-wm1-x334.google.com with SMTP id c192so6105964wma.4
        for <git@vger.kernel.org>; Fri, 11 Feb 2022 12:01:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=SNpIy/07GQZSBrZ5H2sk7/nd388dliKlQOi7EWsbFEw=;
        b=H95+eNAxlLIJV5v1oUy3bntL1ZkKQz0w+d1fDDMcqCZW1yqtVYP7GgVMU7ALWCSM5x
         eJQbalB4xBf40UaJY6URHbxA2SSruEsG6ez6jvHG6kBuP3FH7EV9mY6LKMOHO68RuU/i
         V7IEkNUg8mP9borBm76Hu+/qTj9PluIDKSasQyUFnW+Iq8M/6hQebxCV32Imzeu/yJKb
         7iQdfKo3Ffi3/s4gCUK0MVkWEbySAvX3hUsBd9rgU8J7zSgGVsvbUHv8yszCW4/JanZe
         ydfWsT4a974a40QrYasgffFnUBMLqf3wAeGfqiniaawgMcSZdwQfllNBsFvH3IaThVHg
         WCRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=SNpIy/07GQZSBrZ5H2sk7/nd388dliKlQOi7EWsbFEw=;
        b=pkXJxnseed1Rqy0fRvGoDg4uNrYVLQ16yvYaD07AZVOL+5BaWdu5kKEe3AL+tYCnOa
         c1RniMWkMnXGhiTDD/ZpOeXRwO9cK88HDhlCd9L20VcGFmz/EMsb13dWBFiV0bCWoA8C
         ouOMsf3NCJuXHG+T8INOKAtaGtzYik5IcTyy1zakIeZKxF8+yiIKmdOjQX8yONzg4oBS
         XP33O6RewViyQfUByuwTJqbBZb6matQh7NrPU0wAUJZed5MXLVAShUl5Dc5zU1uumpIJ
         PG9KdY9O7xsudIw5BYcSGj8L/vOiWExjdSsvzs2Vw8Ndn6mgx41+lxKWSzVxKNx/EG6d
         UoCQ==
X-Gm-Message-State: AOAM5321Wg/x7O4ANNRbi/P+JpbZMhog0LhItOwHFjjCWCQR42oVKBBB
        JM36YDLAHcJpgvby7ww4CBINnEp6LPc=
X-Google-Smtp-Source: ABdhPJzgdfhCokKf0iTdS5UgJ9Nj3rmaYyLwlZHWryTdgPupJFkY0YK7+l+MOI+n6+t18PNOIz2GlQ==
X-Received: by 2002:a7b:c093:: with SMTP id r19mr1586105wmh.181.1644609687579;
        Fri, 11 Feb 2022 12:01:27 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id o20sm3462516wmq.21.2022.02.11.12.01.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Feb 2022 12:01:26 -0800 (PST)
Message-Id: <fa6294387ab223d56e6ab66448f1ebe1ec370cd7.1644609683.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1212.v5.git.git.1644609683.gitgitgadget@gmail.com>
References: <pull.1212.v4.git.git.1644465706.gitgitgadget@gmail.com>
        <pull.1212.v5.git.git.1644609683.gitgitgadget@gmail.com>
From:   "John Cai via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 11 Feb 2022 20:01:21 +0000
Subject: [PATCH v5 1/3] cat-file: rename cmdmode to transform_mode
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

