Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A471C433F5
	for <git@archiver.kernel.org>; Mon,  7 Feb 2022 16:48:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344875AbiBGQqe (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 7 Feb 2022 11:46:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1390298AbiBGQdg (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Feb 2022 11:33:36 -0500
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65E66C0401DA
        for <git@vger.kernel.org>; Mon,  7 Feb 2022 08:33:35 -0800 (PST)
Received: by mail-wm1-x335.google.com with SMTP id l12-20020a7bc34c000000b003467c58cbdfso14731329wmj.2
        for <git@vger.kernel.org>; Mon, 07 Feb 2022 08:33:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=NfSFRnfelmqSoSSWLiP3zkKP4bAFL60Y8wDqM2g7opg=;
        b=CP9k72NglvSh+YTrIZEHnjjHizICWs0cALJanOvCtf2rL3VVJiBDUXy+0Ye7mIsZAy
         hIrrftcmHUNu0gh4lcxy85LWPpXEPiOVMPz5BIHSb8tAJ7mxKxaE9M3Ua6eXz0erH0Ve
         Pcc9FPWjx5uaWV+nM0DM5A0K0qc1oGY2D+Z99T3vMsN7rKQGqCHS9o3ZWPAn3IIuP9o+
         gD2ivH58k6RoA9EdYe8F7MiUb2RoZlMXfdKWNWFT7UDSWc5324MoEFjFLdeTCljNHSAM
         d0VruGasDZ0WHZ7sBZaQWsuvdIJF+o1wNyZcVAr0KNbhTXJ50DzwKAO+P3WnhVmqwWYw
         9uHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=NfSFRnfelmqSoSSWLiP3zkKP4bAFL60Y8wDqM2g7opg=;
        b=Gg9q+71RxY906gXsn73L9FggqWBhfZsfn/3jwaGNa9PsxmSOrvnLUaTCPsjGP/V7el
         PskeH5DOXcou/z4Z75j8YwsM31HZHzT3pLAlJF7HWbAYsMKRmTfmY6XHcFNMQXXxGnUa
         AtnZVsEmLyxWXKJBePacQ3CCwAMgpOIpUQVaOAduuzAvw4qJe14/uql2TMTGxt9cx12e
         Q62fg6aEfNOj/35Ki2e1249hB6wMXJJxB8FedlA6jBfkv1bT0yHESpnfLSbU/DocgEuM
         hRPv8X15KENu6aGj62mozyQ3lHGy7pdVgFDTRs/WQN6yPF0tjT3Bnil5Bk5tJvn8Dail
         i0rQ==
X-Gm-Message-State: AOAM530h0wO5h8DvLjsltdL5t7CKEco5Kkl73QllIgMfzLYLoRShStmA
        UHhauxWuwiI8nTW8ugqeyq6vxPYUKms=
X-Google-Smtp-Source: ABdhPJz0WyYgoS1HQQKE7f4Hrz+zGfKllZwNbX9j4gqJ607t3XPNpCV1J68MXuk8azdEJ6VqEmTkFQ==
X-Received: by 2002:a7b:cf05:: with SMTP id l5mr208345wmg.37.1644251613842;
        Mon, 07 Feb 2022 08:33:33 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id t18sm10808618wri.34.2022.02.07.08.33.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Feb 2022 08:33:33 -0800 (PST)
Message-Id: <2d9a0b06ce5ab62095ae9a91d8d56441e9bb8c54.1644251611.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1212.v2.git.git.1644251611.gitgitgadget@gmail.com>
References: <pull.1212.git.git.1643915286.gitgitgadget@gmail.com>
        <pull.1212.v2.git.git.1644251611.gitgitgadget@gmail.com>
From:   "John Cai via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 07 Feb 2022 16:33:30 +0000
Subject: [PATCH v2 1/2] cat-file: rename cmdmode to transform_mode
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     me@ttaylorr.com, phillip.wood123@gmail.com, avarab@gmail.com,
        e@80x24.org, bagasdotme@gmail.com, gitster@pobox.com,
        Eric Sunshine <sunshine@sunshineco.com>,
        John Cai <johncai86@gmail.com>, John Cai <johncai86@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: John Cai <johncai86@gmail.com>

When introducing a new flag --batch-command, we will add a flag on the
batch_options struct that indicates whether or not an interactive
command mode will be used that reads commands and arguments off of
stdin.

An intuitive name for this flag would be "command", which can get
confusing with the already existing cmdmode.

cmdmode refers to how the result output of the blob will be transformed,
either according to --filter or --textconv. So transform_mode is a more
descriptive name for the flag, and will not get confused with the new
command flag to be added in the next commit.

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

