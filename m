Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 86E0B20401
	for <e@80x24.org>; Mon, 12 Jun 2017 22:14:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752647AbdFLWOV (ORCPT <rfc822;e@80x24.org>);
        Mon, 12 Jun 2017 18:14:21 -0400
Received: from mail-pf0-f177.google.com ([209.85.192.177]:35945 "EHLO
        mail-pf0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752371AbdFLWOU (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Jun 2017 18:14:20 -0400
Received: by mail-pf0-f177.google.com with SMTP id x63so57242287pff.3
        for <git@vger.kernel.org>; Mon, 12 Jun 2017 15:14:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=SCofYlE1Z5JusC5eOXA7a74rbu1Mx3o/4axlEUl+YNo=;
        b=FYbuYd7P2fdTHnLvFPr5u+tfx5Ml+A1YJDUAtSiTNWQ55qu5g3ZE/8kxubgdhatDSu
         ruJHINauS5fkkCjkL6xkmSZ48YBSMNCBOzYmdc0KBUwUrqZSjws0pYQ81QhEwplO3Y3e
         YFtZmUIUEZHIbA+N0yBbxMXtAMvAfExUZ8UAO+ZyuT1QIjHExFrNjxOiKaPXLun5hjpk
         2dIcaPO7VFl/pkhzhxm8uWBlrHyQ3pNlIhe08P1cdhg9RYH3UG9cwATG79k8Y8l1q1x/
         9TAp9djPWsvbcothkT1b5g5sxLuVn8ZEGinpaUN0qiR5k7CMnNu2KpyccFYxSR1AJk52
         pydw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=SCofYlE1Z5JusC5eOXA7a74rbu1Mx3o/4axlEUl+YNo=;
        b=QqDwK/Kvx34MkUkWgW6WrBH3BRl//j2lRlN5lB+8lzPwgGa/t2Cgcv1BqtrCRmgjRN
         jqD364PpodTHqkUxndFeGWXpUwMOqx5C8bOyIdAy9Gbv6K6CR71aDmLMVPuN4/zSzkQo
         TT6AdktDVWH9ttGL378xcCG10oxaGvpt3A3Y1Hqkt5harfHanmV4NuSabE1PMhkJCJkq
         kxVSHUvdGXG8kNKeupxOZWFGYLH8ip8INrSlm1UnfTniWmae+7iO+0n6r29ucpKb+3XR
         Z3A1jiVOVRQX95CcUC94fW5erxUKSJJUDkA5ZggWhBXFUzVMVGKi99/NzZtWlyLl3jFA
         CIOw==
X-Gm-Message-State: AODbwcB7r77SuZ6prnGIsdbqzFt0Cq9AdWO6Y3wBGb3chswmildUmmer
        zztkmq7ZNZFioY3yGa402g==
X-Received: by 10.99.16.65 with SMTP id 1mr59134222pgq.60.1497305659257;
        Mon, 12 Jun 2017 15:14:19 -0700 (PDT)
Received: from roshar.svl.corp.google.com ([100.96.218.30])
        by smtp.gmail.com with ESMTPSA id i68sm22403884pfi.72.2017.06.12.15.14.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 12 Jun 2017 15:14:18 -0700 (PDT)
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, Brandon Williams <bmwill@google.com>
Subject: [PATCH 01/17] convert: convert get_cached_convert_stats_ascii to take an index
Date:   Mon, 12 Jun 2017 15:13:52 -0700
Message-Id: <20170612221408.173876-2-bmwill@google.com>
X-Mailer: git-send-email 2.13.1.518.g3df882009-goog
In-Reply-To: <20170612221408.173876-1-bmwill@google.com>
References: <20170612221408.173876-1-bmwill@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Brandon Williams <bmwill@google.com>
---
 builtin/ls-files.c | 3 ++-
 convert.c          | 5 +++--
 convert.h          | 5 ++++-
 3 files changed, 9 insertions(+), 4 deletions(-)

diff --git a/builtin/ls-files.c b/builtin/ls-files.c
index b376afc31..0044abf66 100644
--- a/builtin/ls-files.c
+++ b/builtin/ls-files.c
@@ -63,7 +63,8 @@ static void write_eolinfo(const struct cache_entry *ce, const char *path)
 		const char *w_txt = "";
 		const char *a_txt = get_convert_attr_ascii(path);
 		if (ce && S_ISREG(ce->ce_mode))
-			i_txt = get_cached_convert_stats_ascii(ce->name);
+			i_txt = get_cached_convert_stats_ascii(&the_index,
+							       ce->name);
 		if (!lstat(path, &st) && S_ISREG(st.st_mode))
 			w_txt = get_wt_convert_stats_ascii(path);
 		printf("i/%-5s w/%-5s attr/%-17s\t", i_txt, w_txt, a_txt);
diff --git a/convert.c b/convert.c
index f1e168bc3..03160b376 100644
--- a/convert.c
+++ b/convert.c
@@ -134,11 +134,12 @@ static const char *gather_convert_stats_ascii(const char *data, unsigned long si
 	}
 }
 
-const char *get_cached_convert_stats_ascii(const char *path)
+const char *get_cached_convert_stats_ascii(const struct index_state *istate,
+					   const char *path)
 {
 	const char *ret;
 	unsigned long sz;
-	void *data = read_blob_data_from_cache(path, &sz);
+	void *data = read_blob_data_from_index(istate, path, &sz);
 	ret = gather_convert_stats_ascii(data, sz);
 	free(data);
 	return ret;
diff --git a/convert.h b/convert.h
index 82871a11d..667b7dfe0 100644
--- a/convert.h
+++ b/convert.h
@@ -4,6 +4,8 @@
 #ifndef CONVERT_H
 #define CONVERT_H
 
+struct index_state;
+
 enum safe_crlf {
 	SAFE_CRLF_FALSE = 0,
 	SAFE_CRLF_FAIL = 1,
@@ -33,7 +35,8 @@ enum eol {
 };
 
 extern enum eol core_eol;
-extern const char *get_cached_convert_stats_ascii(const char *path);
+extern const char *get_cached_convert_stats_ascii(const struct index_state *istate,
+						  const char *path);
 extern const char *get_wt_convert_stats_ascii(const char *path);
 extern const char *get_convert_attr_ascii(const char *path);
 
-- 
2.13.1.518.g3df882009-goog

