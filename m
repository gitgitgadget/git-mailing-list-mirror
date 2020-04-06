Return-Path: <SRS0=cWmm=5W=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7387EC2BA1B
	for <git@archiver.kernel.org>; Mon,  6 Apr 2020 17:00:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 48E4B21841
	for <git@archiver.kernel.org>; Mon,  6 Apr 2020 17:00:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CrcxUuwY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729761AbgDFRAL (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 6 Apr 2020 13:00:11 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:38532 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729534AbgDFRAI (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 6 Apr 2020 13:00:08 -0400
Received: by mail-ed1-f68.google.com with SMTP id e5so379343edq.5
        for <git@vger.kernel.org>; Mon, 06 Apr 2020 10:00:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:mime-version
         :content-transfer-encoding:fcc:to:cc;
        bh=l2hH/TavINoYF3ZV0UYu/koCVh28c/8hMEtEzNLktok=;
        b=CrcxUuwY3cf+hU4l98DuBjnAi5gp1SrSjez/p93iyFnQAQeQENmWl+tc8PPHrjFq9/
         8OWKpRs1sCXVqiRbgXF33xy9I6oiShweFeikwhGZ32XkdOHUMM+JU84w8e7EGjVj9pnD
         W2OvyK/uVrpxZnNWhw9nLckvYC5uz25o7qKRROk9drlYMhMXBfkBxnPdM/Ge36zpH718
         jUV7Jb4HBRDbgXdvzFcMBX2T9E4hllub/EYUs8CfqdK68hv9j8timjC2OsiNDxpiZiqk
         THHlGffWQhE4EjoZ13XiJ/BsX5W7WzO/IwU1JFNzP3qyl/r7CPGPHveSwVCIHB8JNo3D
         CfZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:mime-version:content-transfer-encoding:fcc:to:cc;
        bh=l2hH/TavINoYF3ZV0UYu/koCVh28c/8hMEtEzNLktok=;
        b=rCXmNgGJBXdDkaLJygxLdqOdftHTF/AtrUDGk33giC/pbz1bjECxI0L2pY2CDkNHYl
         I51/s876+FFhgSLkpnkWihsCxhEaYfu1DnMFI0bohDFjUA71RUzXN2+XVqZFlqsqrq+L
         ue00NwfqJ6xmf3S8SnzAroLErTKKD8MPlZgYb8KAVb3IF6aAMPo2sLLMm19gBKn/bcK6
         roqtlPzsUnl8R6JG7IxDJNwlPX3/cu5Zh1DczgLHCuZmcxaMA/GFbi0wkbaUyO579VhP
         QGq+/7XyhbwBe/4Iyur+KMOsuuFnhiYp/Dxh1fhwN7tFRWq+IlN0bCmN5a77hGNa6o10
         BP8w==
X-Gm-Message-State: AGi0PubWyT5WKHk2Sh/WQZIRLjMcD++8kCMO/VwTKxbMikreGK7uplSZ
        8PurTPLT1jsJZZtWSHx1MIxOtae8
X-Google-Smtp-Source: APiQypJk+7aazjvYp5C0ToWMQTHS0n5rFKg/Ap78Bl/W381ZLoadFSJJtPtnKpnHsp2rz2cVDqvTQQ==
X-Received: by 2002:a50:eb08:: with SMTP id y8mr19198984edp.49.1586192406730;
        Mon, 06 Apr 2020 10:00:06 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id d13sm1935869ejt.74.2020.04.06.10.00.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Apr 2020 10:00:06 -0700 (PDT)
Message-Id: <6beaede715972d7726dda8a58bbd4b920813e194.1586192395.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.497.v4.git.1586192395.gitgitgadget@gmail.com>
References: <pull.497.v3.git.1585528298.gitgitgadget@gmail.com>
        <pull.497.v4.git.1586192395.gitgitgadget@gmail.com>
From:   "Garima Singh via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 06 Apr 2020 16:59:53 +0000
Subject: [PATCH v4 13/15] revision.c: add trace2 stats around Bloom filter
 usage
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Fcc:    Sent
To:     git@vger.kernel.org
Cc:     stolee@gmail.com, szeder.dev@gmail.com, jonathantanmy@google.com,
        Garima Singh <garima.singh@microsoft.com>,
        Garima Singh <garima.singh@microsoft.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Garima Singh <garima.singh@microsoft.com>

Add trace2 statistics around Bloom filter usage and behavior
for 'git log -- path' commands that are hoping to benefit from
the presence of computed changed paths Bloom filters.

These statistics are great for performance analysis work and
for formal testing, which we will see in the commit following
this one.

Helped-by: Derrick Stolee <dstolee@microsoft.com
Helped-by: SZEDER Gábor <szeder.dev@gmail.com>
Helped-by: Jonathan Tan <jonathantanmy@google.com>
Signed-off-by: Garima Singh <garima.singh@microsoft.com>
---
 revision.c | 41 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 41 insertions(+)

diff --git a/revision.c b/revision.c
index d3fcb7c6ff6..2b06ee739c8 100644
--- a/revision.c
+++ b/revision.c
@@ -30,6 +30,7 @@
 #include "hashmap.h"
 #include "utf8.h"
 #include "bloom.h"
+#include "json-writer.h"
 
 volatile show_early_output_fn_t show_early_output;
 
@@ -625,6 +626,30 @@ static void file_change(struct diff_options *options,
 	options->flags.has_changes = 1;
 }
 
+static int bloom_filter_atexit_registered;
+static unsigned int count_bloom_filter_maybe;
+static unsigned int count_bloom_filter_definitely_not;
+static unsigned int count_bloom_filter_false_positive;
+static unsigned int count_bloom_filter_not_present;
+static unsigned int count_bloom_filter_length_zero;
+
+static void trace2_bloom_filter_statistics_atexit(void)
+{
+	struct json_writer jw = JSON_WRITER_INIT;
+
+	jw_object_begin(&jw, 0);
+	jw_object_intmax(&jw, "filter_not_present", count_bloom_filter_not_present);
+	jw_object_intmax(&jw, "zero_length_filter", count_bloom_filter_length_zero);
+	jw_object_intmax(&jw, "maybe", count_bloom_filter_maybe);
+	jw_object_intmax(&jw, "definitely_not", count_bloom_filter_definitely_not);
+	jw_object_intmax(&jw, "false_positive", count_bloom_filter_false_positive);
+	jw_end(&jw);
+
+	trace2_data_json("bloom", the_repository, "statistics", &jw);
+
+	jw_release(&jw);
+}
+
 static void prepare_to_use_bloom_filter(struct rev_info *revs)
 {
 	struct pathspec_item *pi;
@@ -661,6 +686,11 @@ static void prepare_to_use_bloom_filter(struct rev_info *revs)
 	revs->bloom_key = xmalloc(sizeof(struct bloom_key));
 	fill_bloom_key(path, len, revs->bloom_key, revs->bloom_filter_settings);
 
+	if (trace2_is_enabled() && !bloom_filter_atexit_registered) {
+		atexit(trace2_bloom_filter_statistics_atexit);
+		bloom_filter_atexit_registered = 1;
+	}
+
 	free(path_alloc);
 }
 
@@ -679,10 +709,12 @@ static int check_maybe_different_in_bloom_filter(struct rev_info *revs,
 	filter = get_bloom_filter(revs->repo, commit, 0);
 
 	if (!filter) {
+		count_bloom_filter_not_present++;
 		return -1;
 	}
 
 	if (!filter->len) {
+		count_bloom_filter_length_zero++;
 		return -1;
 	}
 
@@ -690,6 +722,11 @@ static int check_maybe_different_in_bloom_filter(struct rev_info *revs,
 				       revs->bloom_key,
 				       revs->bloom_filter_settings);
 
+	if (result)
+		count_bloom_filter_maybe++;
+	else
+		count_bloom_filter_definitely_not++;
+
 	return result;
 }
 
@@ -736,6 +773,10 @@ static int rev_compare_tree(struct rev_info *revs,
 			   &revs->pruning) < 0)
 		return REV_TREE_DIFFERENT;
 
+	if (!nth_parent)
+		if (bloom_ret == 1 && tree_difference == REV_TREE_SAME)
+			count_bloom_filter_false_positive++;
+
 	return tree_difference;
 }
 
-- 
gitgitgadget

