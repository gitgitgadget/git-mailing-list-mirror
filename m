Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 598E7C47082
	for <git@archiver.kernel.org>; Thu,  3 Jun 2021 16:30:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 43E02613EE
	for <git@archiver.kernel.org>; Thu,  3 Jun 2021 16:30:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229849AbhFCQcO (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 3 Jun 2021 12:32:14 -0400
Received: from mail-wr1-f47.google.com ([209.85.221.47]:35773 "EHLO
        mail-wr1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229812AbhFCQcO (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 3 Jun 2021 12:32:14 -0400
Received: by mail-wr1-f47.google.com with SMTP id m18so6500252wrv.2
        for <git@vger.kernel.org>; Thu, 03 Jun 2021 09:30:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=FMMdxFRSf7IEW3ujRPzploCAh2dgrAQJ+GOrzRMU1EM=;
        b=lYtO7b5vLC0HUxlNfF+zexcZ8d4ykPXUuuofKE6nbML4NMJQ3dAQHx8pXsRx2HQc8O
         Yubng46AHVWy5VNv0213Te3K/UhvBv2EBCJztOO18ZvrgMwGyBv4rWLYf1laDPPwbopk
         ZmYn7npkHhW0LBqrNs5YhxU2uc3vY8yigeHe9F0NezToHiEmPnitM3NeVCop0v6qLZM4
         p5GA4UhOQGT6q4cmQmKk8VRg4YneyjaFsHKccdF56wZ6Cw97lTJt0GLQ7qQcFqLLOMVw
         CKUFbIB92dGBPr1dSF3UdAdlzNld6d/2IpSXlFHsw/pa/ks02/CQQS0WliTe1UtfrScZ
         OJ9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=FMMdxFRSf7IEW3ujRPzploCAh2dgrAQJ+GOrzRMU1EM=;
        b=slt06aaa9LKieSyr6J5v+JpIelqdzioqnjn3eVhTepG+d+vlxNKJIXBwfrsyHmA4XQ
         zMFfwErWWf6rVS20qUe7tt94FnIOne8I7pn/zt8kzn8ecZe6JlUEeO1il5ZutrId/5xR
         vAmw0LkK2H8s5jUHGV+2bnOxUMBm70MEDN3YdSQZbjQIEhx/41IjWChZDKsMFokHKf4A
         0R70veWCwF2D75YkBpO/XhJ/Lc2XhDOck4dS+sW9sBhmCGiFBF7G9RADDBkKI3P6oxy0
         wJLTJJKUZgQrP0smmY2ACiOJaE8gxjt8iBemAd8cFsm8M8SwP+gm73o2MqvrSHW6NpRN
         TKMw==
X-Gm-Message-State: AOAM533mgmiTmPNhGEgrYyvhIdyKUeJhQKztWOYCTFZwfyWd5mpSzL33
        ZCoYFz9j1stgpcEuS85mStvyx3j1mHY=
X-Google-Smtp-Source: ABdhPJylSj4JPebFP2J3zReijQAeRKqCqssIbnaWS7mZ85ahsY6xraS29sH3joHiIIkrO0l952fBwg==
X-Received: by 2002:a5d:4b05:: with SMTP id v5mr797856wrq.330.1622737768692;
        Thu, 03 Jun 2021 09:29:28 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id u16sm4310661wru.56.2021.06.03.09.29.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Jun 2021 09:29:28 -0700 (PDT)
Message-Id: <4af3b958dd056e2162fdc5d7f6600bcedde210b8.1622737766.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.967.v2.git.1622737766.gitgitgadget@gmail.com>
References: <pull.967.git.1622558157.gitgitgadget@gmail.com>
        <pull.967.v2.git.1622737766.gitgitgadget@gmail.com>
From:   "ZheNing Hu via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 03 Jun 2021 16:29:25 +0000
Subject: [PATCH v2 1/2] [GSOC] cat-file: handle trivial --batch format with
 --batch-all-objects
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Christian Couder <christian.couder@gmail.com>,
        Hariom Verma <hariom18599@gmail.com>,
        Jeff King <peff@peff.net>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        ZheNing Hu <adlternative@gmail.com>,
        ZheNing Hu <adlternative@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: ZheNing Hu <adlternative@gmail.com>

The --batch code to print an object assumes we found out the type of
the object from calling oid_object_info_extended(). This is true for
the default format, but even in a custom format, we manually modify
the object_info struct to ask for the type.

This assumption was broken by 845de33a5b (cat-file: avoid noop calls
to sha1_object_info_extended, 2016-05-18). That commit skips the call
to oid_object_info_extended() entirely when --batch-all-objects is in
use, and the custom format does not include any placeholders that
require calling it.

Or when the custom format only include placeholders like %(objectname) or
%(rest), oid_object_info_extended() will not get the type of the object.

This results in an error when we try to confirm that the type didn't
change:

$ git cat-file --batch=batman --batch-all-objects
batman
fatal: object 000023961a0c02d6e21dc51ea3484ff71abf1c74 changed type!?

and also has other subtle effects (e.g., we'd fail to stream a blob,
since we don't realize it's a blob in the first place).

We can fix this by flipping the order of the setup. The check for "do
we need to get the object info" must come _after_ we've decided
whether we need to look up the type.

Helped-by: Jeff King <peff@peff.net>
Signed-off-by: ZheNing Hu <adlternative@gmail.com>
---
 builtin/cat-file.c  | 13 +++++++------
 t/t1006-cat-file.sh | 22 ++++++++++++++++++++++
 2 files changed, 29 insertions(+), 6 deletions(-)

diff --git a/builtin/cat-file.c b/builtin/cat-file.c
index 5ebf13359e83..02461bb5ea6f 100644
--- a/builtin/cat-file.c
+++ b/builtin/cat-file.c
@@ -512,12 +512,6 @@ static int batch_objects(struct batch_options *opt)
 	if (opt->cmdmode)
 		data.split_on_whitespace = 1;
 
-	if (opt->all_objects) {
-		struct object_info empty = OBJECT_INFO_INIT;
-		if (!memcmp(&data.info, &empty, sizeof(empty)))
-			data.skip_object_info = 1;
-	}
-
 	/*
 	 * If we are printing out the object, then always fill in the type,
 	 * since we will want to decide whether or not to stream.
@@ -525,6 +519,13 @@ static int batch_objects(struct batch_options *opt)
 	if (opt->print_contents)
 		data.info.typep = &data.type;
 
+	if (opt->all_objects) {
+		struct object_info empty = OBJECT_INFO_INIT;
+
+		if (!memcmp(&data.info, &empty, sizeof(empty)))
+			data.skip_object_info = 1;
+	}
+
 	if (opt->all_objects) {
 		struct object_cb_data cb;
 
diff --git a/t/t1006-cat-file.sh b/t/t1006-cat-file.sh
index 5d2dc99b74ad..18b3779ccb60 100755
--- a/t/t1006-cat-file.sh
+++ b/t/t1006-cat-file.sh
@@ -586,4 +586,26 @@ test_expect_success 'cat-file --unordered works' '
 	test_cmp expect actual
 '
 
+test_expect_success 'set up object list for --batch-all-objects tests' '
+	git -C all-two cat-file --batch-all-objects --batch-check="%(objectname)" >objects
+'
+
+test_expect_success 'cat-file --batch="%(objectname)" with --batch-all-objects will work' '
+	git -C all-two cat-file --batch="%(objectname)" <objects >expect &&
+	git -C all-two cat-file --batch-all-objects --batch="%(objectname)" >actual &&
+	cmp expect actual
+'
+
+test_expect_success 'cat-file --batch="%(rest)" with --batch-all-objects will work' '
+	git -C all-two cat-file --batch="%(rest)" <objects >expect &&
+	git -C all-two cat-file --batch-all-objects --batch="%(rest)" >actual &&
+	cmp expect actual
+'
+
+test_expect_success 'cat-file --batch="batman" with --batch-all-objects will work' '
+	git -C all-two cat-file --batch="batman" <objects >expect &&
+	git -C all-two cat-file --batch-all-objects --batch="batman" >actual &&
+	cmp expect actual
+'
+
 test_done
-- 
gitgitgadget

