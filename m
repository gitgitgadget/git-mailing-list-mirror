Return-Path: <SRS0=DNVg=EI=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14D4DC388F9
	for <git@archiver.kernel.org>; Mon,  2 Nov 2020 20:46:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A2F75206E5
	for <git@archiver.kernel.org>; Mon,  2 Nov 2020 20:46:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dXl6UQtl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727308AbgKBUoe (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 2 Nov 2020 15:44:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726711AbgKBUnw (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 2 Nov 2020 15:43:52 -0500
Received: from mail-ot1-x341.google.com (mail-ot1-x341.google.com [IPv6:2607:f8b0:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11F63C0617A6
        for <git@vger.kernel.org>; Mon,  2 Nov 2020 12:43:52 -0800 (PST)
Received: by mail-ot1-x341.google.com with SMTP id h62so13889113oth.9
        for <git@vger.kernel.org>; Mon, 02 Nov 2020 12:43:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=iDmmdb1yMbAVf8rdFEjA/Su1MuMpaeeULyOhTaFe/Yc=;
        b=dXl6UQtlQ2sDQyri5OFPjbt6NhtlmuyK3t4lNbh2C+nV20ApevilPETWQo7qddU2E+
         vFZtGnKdNDt3+bBflnO85CULK9v5aSZeeAciq3jLF+VL5toY3txZ6Z5xTXi1wtosFP4N
         zozfLVrSB7hnD3txzYZKlEGQt6h75Lt7wJaCk1Z4QlKgoRYXH39wufw6Ov+oSjJCaEzx
         ZiwtlBcoy8MmnLvjnIRx3eycqhp00XROvX0DZRKcck21y6TMQ2f+10WYBngIQoemOfE0
         l6xSMvnEodwk+CXGAz+otFGfR2NBEG9ombvzia9dsBAqC2lYjE4R3K3BgPpYu9+lc44i
         Auvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=iDmmdb1yMbAVf8rdFEjA/Su1MuMpaeeULyOhTaFe/Yc=;
        b=Qm5bcVy5AF64/PhjPsy1Q4c60Tpb/kwouOsgXVML1FMVCzFZEnpg7oxf+tAEKBDG+U
         B107rxeOTkM75OjaaCe38ICVPpLxQKxczpyKWiUbATPRQZxYJXLS8yFqZxvZl6Wsm8xW
         MWjno+ddQ/+rLL2qie5CJSYYysYJJ5qhB4x2e+8ce2KjtLxgzHCYocoJGL7KV/gbou34
         iq0EwPjPDK89TyJFugz2VWlkJTRlqD/bopIEVQxLh4YJjwSgxQsQbf3SGU/nUK7V19pt
         FkS8utSIlXT1+llCIkQJE4zvIEnOkgcrYQFmmN2la9vUoEBlGdl0eVK/CtVWBGQNFASP
         BjLw==
X-Gm-Message-State: AOAM530MCy3maKWGWfj3P3xLZDJMB31OJ/4H5x+zz1jumSBmqQzuVDki
        9CkR5gu8nEs3kK6xiOoCB+kEyPXxMwF64A==
X-Google-Smtp-Source: ABdhPJzBSC6xzlyv+QVRiquoyCuk8CNc3Xk5DWqRgYe4HCMO80+gxcKAeiuFOMRo8HN2J+tEruf85A==
X-Received: by 2002:a05:6830:2143:: with SMTP id r3mr4388680otd.189.1604349830746;
        Mon, 02 Nov 2020 12:43:50 -0800 (PST)
Received: from tiger.attlocal.net ([2602:30a:2c28:20f0:7c1a:85e3:2ea9:5d7e])
        by smtp.gmail.com with ESMTPSA id t27sm3848512otc.14.2020.11.02.12.43.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2020 12:43:50 -0800 (PST)
From:   Elijah Newren <newren@gmail.com>
To:     git@vger.kernel.org
Cc:     Elijah Newren <newren@gmail.com>
Subject: [PATCH v2 01/20] merge-ort: setup basic internal data structures
Date:   Mon,  2 Nov 2020 12:43:25 -0800
Message-Id: <20201102204344.342633-2-newren@gmail.com>
X-Mailer: git-send-email 2.29.0.471.ga4f56089c0
In-Reply-To: <20201102204344.342633-1-newren@gmail.com>
References: <20201102204344.342633-1-newren@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Set up some basic internal data structures.  The only carry-over from
merge-recursive.c is call_depth, though needed_rename_limit will be
added later.

The central piece of data will definitely be the strmap "paths", which
will map every relevant pathname under consideration to either a
merged_info or a conflict_info.  ("unmerged" is a strmap that is a
subset of "paths".)

merged_info contains all relevant information for a non-conflicted
entry.  conflict_info contains a merged_info, plus any additional
information about a conflict such as the higher orders stages involved
and the names of the paths those came from (handy once renames get
involved).  If an entry remains conflicted, the merged_info portion of a
conflict_info will later be filled with whatever version of the file
should be placed in the working directory (e.g. an as-merged-as-possible
variation that contains conflict markers).

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 merge-ort.c | 40 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 40 insertions(+)

diff --git a/merge-ort.c b/merge-ort.c
index b487901d3e..9d5ea0930d 100644
--- a/merge-ort.c
+++ b/merge-ort.c
@@ -17,6 +17,46 @@
 #include "cache.h"
 #include "merge-ort.h"
 
+#include "strmap.h"
+
+struct merge_options_internal {
+	struct strmap paths;    /* maps path -> (merged|conflict)_info */
+	struct strmap unmerged; /* maps path -> conflict_info */
+	const char *current_dir_name;
+	int call_depth;
+};
+
+struct version_info {
+	struct object_id oid;
+	unsigned short mode;
+};
+
+struct merged_info {
+	struct version_info result;
+	unsigned is_null:1;
+	unsigned clean:1;
+	size_t basename_offset;
+	 /*
+	  * Containing directory name.  Note that we assume directory_name is
+	  * constructed such that
+	  *    strcmp(dir1_name, dir2_name) == 0 iff dir1_name == dir2_name,
+	  * i.e. string equality is equivalent to pointer equality.  For this
+	  * to hold, we have to be careful setting directory_name.
+	  */
+	const char *directory_name;
+};
+
+struct conflict_info {
+	struct merged_info merged;
+	struct version_info stages[3];
+	const char *pathnames[3];
+	unsigned df_conflict:1;
+	unsigned path_conflict:1;
+	unsigned filemask:3;
+	unsigned dirmask:3;
+	unsigned match_mask:3;
+};
+
 void merge_switch_to_result(struct merge_options *opt,
 			    struct tree *head,
 			    struct merge_result *result,
-- 
2.29.0.471.ga4f56089c0

