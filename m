Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22318C433EF
	for <git@archiver.kernel.org>; Wed, 16 Feb 2022 20:59:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233398AbiBPU7m (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 16 Feb 2022 15:59:42 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:38508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233293AbiBPU7f (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 Feb 2022 15:59:35 -0500
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E15EF20204A
        for <git@vger.kernel.org>; Wed, 16 Feb 2022 12:59:22 -0800 (PST)
Received: by mail-wr1-x430.google.com with SMTP id f3so5290451wrh.7
        for <git@vger.kernel.org>; Wed, 16 Feb 2022 12:59:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=ielkz8QHotBtE/FrvWE7acgciQk61gjydC4noInf6m0=;
        b=bpFbVoIHVtL88xRlO6Tecc5iut2YKz8UC9vrNe1EGhFG/m1hMezcYkpR0cWmjjvBgR
         oBQq80jN+csI4JtVdR1S22rADdSwmYmab+yOtz0Letdo+ty0gd/FvAYT84lcOzL2Nrad
         gUynm30VthhYbMiDgwb98GejImYk+jWJkK0hgjDWkh6WEbhpjQPLFUekHLDDzMUbXzDX
         fe4hPqhse5vOF2dW5cHOsImuh3WMqygjWUqUSY7wEXWvDPYzTP/+ulSfYcFo2rIdHaVO
         ggo4bK0paqQHqQJMyyEh+liMtNxI6oqTb2vaBVznvlZbw9l+SkS/LgSRTdvX194P2f5B
         xrqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=ielkz8QHotBtE/FrvWE7acgciQk61gjydC4noInf6m0=;
        b=15IB2pheUlodjToCI+H285Pjdfhiwne2GmeW1R+SS0AtlPrdAuM56CpY0+UgmH65Tr
         r3hOYVMBJY/hoIr/IBRSONvhIPNbvWNmwrJwTih0IdmjNAcMW87k1Z7aW/ZyxIx1T92a
         YAyp57Cmnv7v9JV2FGBGkzW/oqObQgnMV9bTi8IQEeBK/jbbdJDJBqArNz3A7eVV9kq3
         t+Y1qThFtZwyplk8TqvC7buCObY+mIpOXxuUuEhwbGLwOcs9ITkrvIEWFhHIGJbSK5ss
         G0X6UjGSPVMH1DsqLrPuVYmN2vCejxFV+nK5ehMlU8cyQzbrfTBiuG79EzdvJAyH1F3+
         RJfw==
X-Gm-Message-State: AOAM533xBKHkq/LT2GUFaZeuAkYOHfk9fYBeAK//TKzAflSGANeX5DHi
        8wgzfXDRplbXAfvDj5BFNp06bhcGm/k=
X-Google-Smtp-Source: ABdhPJw1T3WWbe2EJlpX2uwi3D4WtuM7L0ddwJnHbJb4emrn4jCNrCAu4V5tFXlLi1FCJZ5S5llDTQ==
X-Received: by 2002:a05:6000:108b:b0:1e3:222a:25dd with SMTP id y11-20020a056000108b00b001e3222a25ddmr3743105wrw.481.1645045161370;
        Wed, 16 Feb 2022 12:59:21 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id x10sm18569606wmj.17.2022.02.16.12.59.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Feb 2022 12:59:20 -0800 (PST)
Message-Id: <12084a335cb9128db5d122dea9f74edc86b64595.1645045157.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1212.v9.git.git.1645045157.gitgitgadget@gmail.com>
References: <pull.1212.v8.git.git.1645023740.gitgitgadget@gmail.com>
        <pull.1212.v9.git.git.1645045157.gitgitgadget@gmail.com>
From:   "John Cai via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 16 Feb 2022 20:59:15 +0000
Subject: [PATCH v9 2/4] cat-file: introduce batch_mode enum to replace
 print_contents
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

A future patch introduces a new --batch-command flag. Including --batch
and --batch-check, we will have a total of three batch modes. print_contents
is the only boolean on the batch_options sturct used to distinguish
between the different modes. This makes the code harder to read.

To reduce potential confusion, replace print_contents with an enum to
help readability and clarity.

Helped-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: John Cai <johncai86@gmail.com>
---
 builtin/cat-file.c | 20 ++++++++++++++++----
 1 file changed, 16 insertions(+), 4 deletions(-)

diff --git a/builtin/cat-file.c b/builtin/cat-file.c
index 5f015e71096..5e38af82af1 100644
--- a/builtin/cat-file.c
+++ b/builtin/cat-file.c
@@ -17,10 +17,15 @@
 #include "object-store.h"
 #include "promisor-remote.h"
 
+enum batch_mode {
+	BATCH_MODE_CONTENTS,
+	BATCH_MODE_INFO,
+};
+
 struct batch_options {
 	int enabled;
 	int follow_symlinks;
-	int print_contents;
+	enum batch_mode batch_mode;
 	int buffer_output;
 	int all_objects;
 	int unordered;
@@ -386,7 +391,7 @@ static void batch_object_write(const char *obj_name,
 	strbuf_addch(scratch, '\n');
 	batch_write(opt, scratch->buf, scratch->len);
 
-	if (opt->print_contents) {
+	if (opt->batch_mode == BATCH_MODE_CONTENTS) {
 		print_object_or_die(opt, data);
 		batch_write(opt, "\n", 1);
 	}
@@ -536,7 +541,7 @@ static int batch_objects(struct batch_options *opt)
 	 * If we are printing out the object, then always fill in the type,
 	 * since we will want to decide whether or not to stream.
 	 */
-	if (opt->print_contents)
+	if (opt->batch_mode == BATCH_MODE_CONTENTS)
 		data.info.typep = &data.type;
 
 	if (opt->all_objects) {
@@ -635,7 +640,14 @@ static int batch_option_callback(const struct option *opt,
 	}
 
 	bo->enabled = 1;
-	bo->print_contents = !strcmp(opt->long_name, "batch");
+
+	if (!strcmp(opt->long_name, "batch"))
+		bo->batch_mode = BATCH_MODE_CONTENTS;
+	else if (!strcmp(opt->long_name, "batch-check"))
+		bo->batch_mode = BATCH_MODE_INFO;
+	else
+		BUG("%s given to batch-option-callback", opt->long_name);
+
 	bo->format = arg;
 
 	return 0;
-- 
gitgitgadget

