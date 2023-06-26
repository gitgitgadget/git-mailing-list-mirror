Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E49EEB64D7
	for <git@archiver.kernel.org>; Mon, 26 Jun 2023 15:11:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230454AbjFZPLH (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 26 Jun 2023 11:11:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230394AbjFZPKs (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Jun 2023 11:10:48 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 991DD273C
        for <git@vger.kernel.org>; Mon, 26 Jun 2023 08:10:12 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id ffacd0b85a97d-313f04ff978so1156894f8f.3
        for <git@vger.kernel.org>; Mon, 26 Jun 2023 08:10:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687792199; x=1690384199;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/v/Py1vjg1fSBoRLWZ19vEqryIbPJF03YOpHR6Rg+Qs=;
        b=p7h4/kVE3dHAT16TVWzA8cvcdtJa4gzUthk7SxOUdwlJ96DRhkSqoX/JXNHdKLZjJJ
         jpTxG2hpQmkkmiQO96JS0majK5BP71KVJzHPnoy509KVXOjWjm7OKAyxOR5h3O27fCd0
         Y53+7+xpZtyr25ENA25EeruJTuQnZrhgXWxAA7UqSHThAVnn0DQFYwGkgeEskh26hrxL
         3phECDU2iloaEduNZgc7qBcJNOWUHkZALaU0OtzJkAPpAGdqTbZ4xL+HxTLifwyvivtG
         b7X0OGk2AgIvbwRe7fOQnkBM3Qjk6hdlC/Uqq4laU7XtT5AQ4kpuiNKvjppeYeP1BGHc
         mcwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687792199; x=1690384199;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/v/Py1vjg1fSBoRLWZ19vEqryIbPJF03YOpHR6Rg+Qs=;
        b=GYYa0hoPt+jvm5Dwehuh2oPN1Mo88Wp2dZasqrucdWW+iFQ2/0MDglVQOjO+CsQ2br
         8D3JTCWGYktx5k5nTJ61Iz019jmqecAd7LGZ9mdtN1Zr5unXy266IRAMjZr3n3AEJKvE
         TvtwONOi/P6Fpv9smywkgioNL3zdsjNLuqEJFE+1ZYdpKSxVlYKxuFNVy/HoILIeMYNE
         mfZ0kXISbd3xok5khTOF2YY7asOtT4ai5xYB+ZMQZ3DQ6EusOJ1w6JZNZ/hxImCvb8jX
         /WLlSIPU8/PIJDRBi14h7sf8dBbl1AO9hMM7oa0l15r6GYw6ph4hy76j4yMPzhl5OSaW
         S+KA==
X-Gm-Message-State: AC+VfDwHrQ8bYaQMVydaiQopOypB3bJcZ8CDRL5Vfvsb0HtKj5WuE4Tc
        pjtTjqZtJyPFOBadNskbYsx0QT0rk5o=
X-Google-Smtp-Source: ACHHUZ40cH2IyCiqNeJCOkk7eao32W8YBclOg0GSVhaKWK2MC42fZjB6Zkt70yQmCv+Ucgr3AAMcdA==
X-Received: by 2002:a05:6000:184:b0:309:1532:8287 with SMTP id p4-20020a056000018400b0030915328287mr8412216wrx.19.1687792198960;
        Mon, 26 Jun 2023 08:09:58 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id cs7-20020a056000088700b0030ada01ca78sm7690002wrb.10.2023.06.26.08.09.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Jun 2023 08:09:58 -0700 (PDT)
Message-Id: <4aa261d9de1ec054f9e1cdecf700b29b57cedf56.1687792197.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1548.git.1687792197.gitgitgadget@gmail.com>
References: <pull.1548.git.1687792197.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 26 Jun 2023 15:09:56 +0000
Subject: [PATCH 1/2] for-each-ref: extract ref output loop
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     vdye@github.com, gitster@pobox.com, me@ttaylorr.com,
        mjcheetham@outlook.com, Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <derrickstolee@github.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <derrickstolee@github.com>

In preparation for a new output mode of 'git for-each-ref', extract the
loop that outputs references into a static method. No functional change
here.

Signed-off-by: Derrick Stolee <derrickstolee@github.com>
---
 builtin/for-each-ref.c | 58 ++++++++++++++++++++++++++----------------
 1 file changed, 36 insertions(+), 22 deletions(-)

diff --git a/builtin/for-each-ref.c b/builtin/for-each-ref.c
index 695fc8f4a5e..ce34940e3e6 100644
--- a/builtin/for-each-ref.c
+++ b/builtin/for-each-ref.c
@@ -17,17 +17,47 @@ static char const * const for_each_ref_usage[] = {
 	NULL
 };
 
-int cmd_for_each_ref(int argc, const char **argv, const char *prefix)
+static void filter_and_output_refs(struct repository *r,
+				   struct ref_array *array,
+				   struct ref_filter *filter,
+				   struct ref_format *format,
+				   struct ref_sorting *sorting,
+				   int maxcount,
+				   int omit_empty)
 {
 	int i;
+	struct strbuf err = STRBUF_INIT;
+	struct strbuf output = STRBUF_INIT;
+
+	filter_refs(array, filter, FILTER_REFS_ALL);
+	filter_ahead_behind(r, format, array);
+
+	ref_array_sort(sorting, array);
+
+	if (!maxcount || array->nr < maxcount)
+		maxcount = array->nr;
+	for (i = 0; i < maxcount; i++) {
+		strbuf_reset(&err);
+		strbuf_reset(&output);
+		if (format_ref_array_item(array->items[i], format, &output, &err))
+			die("%s", err.buf);
+		fwrite(output.buf, 1, output.len, stdout);
+		if (output.len || !omit_empty)
+			putchar('\n');
+	}
+
+	strbuf_release(&err);
+	strbuf_release(&output);
+}
+
+int cmd_for_each_ref(int argc, const char **argv, const char *prefix)
+{
 	struct ref_sorting *sorting;
 	struct string_list sorting_options = STRING_LIST_INIT_DUP;
-	int maxcount = 0, icase = 0, omit_empty = 0;
+	int maxcount = 0, icase = 0, omit_empty = 0, count_matches = 0;
 	struct ref_array array;
 	struct ref_filter filter;
 	struct ref_format format = REF_FORMAT_INIT;
-	struct strbuf output = STRBUF_INIT;
-	struct strbuf err = STRBUF_INIT;
 	int from_stdin = 0;
 	struct strvec vec = STRVEC_INIT;
 
@@ -101,25 +131,9 @@ int cmd_for_each_ref(int argc, const char **argv, const char *prefix)
 	}
 
 	filter.match_as_path = 1;
-	filter_refs(&array, &filter, FILTER_REFS_ALL);
-	filter_ahead_behind(the_repository, &format, &array);
+	filter_and_output_refs(the_repository, &array, &filter, &format,
+			       sorting, maxcount, omit_empty);
 
-	ref_array_sort(sorting, &array);
-
-	if (!maxcount || array.nr < maxcount)
-		maxcount = array.nr;
-	for (i = 0; i < maxcount; i++) {
-		strbuf_reset(&err);
-		strbuf_reset(&output);
-		if (format_ref_array_item(array.items[i], &format, &output, &err))
-			die("%s", err.buf);
-		fwrite(output.buf, 1, output.len, stdout);
-		if (output.len || !omit_empty)
-			putchar('\n');
-	}
-
-	strbuf_release(&err);
-	strbuf_release(&output);
 	ref_array_clear(&array);
 	free_commit_list(filter.with_commit);
 	free_commit_list(filter.no_commit);
-- 
gitgitgadget

