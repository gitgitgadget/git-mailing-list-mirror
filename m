Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AEFEC433EF
	for <git@archiver.kernel.org>; Sat, 18 Jun 2022 00:21:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1383730AbiFRAVf (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 17 Jun 2022 20:21:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1383690AbiFRAVS (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 17 Jun 2022 20:21:18 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0418759B9E
        for <git@vger.kernel.org>; Fri, 17 Jun 2022 17:21:13 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id m125-20020a1ca383000000b0039c63fe5f64so3082305wme.0
        for <git@vger.kernel.org>; Fri, 17 Jun 2022 17:21:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=0nohZfrU3waxiggkleheiPc9iFJgwC2t5qYWboTFqks=;
        b=a5qfH1vc6N/eLc2sopo3TMQJ5uQUa4NwIDKXJQuu/7ZTDvH+VVJSehfTjXm+EQuKwD
         e/sJrPVYGIGeR3WXnBZUn5mkX3JMgrRs0YjePJy0RgLd9XQuUIYzEltYVk/d4NeGa0cZ
         n6udQFn1sxdwgrIJ/Ja6szt0f3zcaBj2L5yzx8cNYWKieLLiEZmmPnxX3jLkiJJx9Kam
         ZMZPheEfXgQQx6TSFlj+dsZCGk5Ndt6XVfulwg5P2HopJv/3v/VkHjpD5vvNnxzbIt4x
         gWhBwscNODUZzxq8WleuCawQf+vawkMZNZzUb0pUmF5J8RTlX/8S0N4YorpEjQ6RjhEQ
         o2vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=0nohZfrU3waxiggkleheiPc9iFJgwC2t5qYWboTFqks=;
        b=wFPcGwhMMI7cZX4uTt8POPkB432f6sogfYpMofDBpdu+F9wbAHsnumkwcme+ZZldlL
         hz/Kn7QbwA1WnJhRqKd5eF725PKIIxSRbt7u1SuPDYJfCnrEQG0fA+ppHTTKal5EveDu
         aqgOCsCUC/w8xes4udOwbq2Ld1/EWZqLuRBuKwhDJ4Cox0pL7MIGnP+t80/ZuxbsrQh7
         9GZPgiAjittMVkv2YNGHa2NfZM1uVfdFm7ENrd892755l93ff50F/27IKxhf7k7zsfsC
         YjTbuqf5UWK+oQx3HkettMpeKEt/6Fb9dsUM8Yutz+bET19NgHKK0Je3HvN3CHtpBnWQ
         D8EA==
X-Gm-Message-State: AOAM530qReEIhO2iH+iGMyFwQi9YYLsvQLGbb0uIhGy1UdJqcyTxPBZr
        JiT/nTAhxmtqO1MKz8h/74s1dlTcmhUBwQ==
X-Google-Smtp-Source: ABdhPJxiFyT6Oxr5nOHjMkny3qIJPLYtoT+bvRHlXrdR4HaJTTsf+VBut+rM4q8vt7AIoDWUC0xkSw==
X-Received: by 2002:a05:600c:8a4:b0:39c:54fd:acbb with SMTP id l36-20020a05600c08a400b0039c54fdacbbmr23599381wmp.92.1655511671067;
        Fri, 17 Jun 2022 17:21:11 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id z6-20020a7bc7c6000000b0039c63f4bce0sm10318327wmk.12.2022.06.17.17.21.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jun 2022 17:21:10 -0700 (PDT)
Message-Id: <67a728d35f0e3a3dde63d7fc8116ed20cad44141.1655511660.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1122.v7.git.1655511660.gitgitgadget@gmail.com>
References: <pull.1122.v6.git.1645602413.gitgitgadget@gmail.com>
        <pull.1122.v7.git.1655511660.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sat, 18 Jun 2022 00:20:50 +0000
Subject: [PATCH v7 07/17] merge-ort: provide a merge_get_conflicted_files()
 helper function
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Christian Couder <chriscool@tuxfamily.org>,
        Taylor Blau <me@ttaylorr.com>,
        Johannes Altmanninger <aclopte@gmail.com>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Christian Couder <christian.couder@gmail.com>,
        =?UTF-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Elijah Newren <newren@gmail.com>,
        Johannes Sixt <j6t@kdbg.org>,
        Josh Steadmon <steadmon@google.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

After a merge, this function allows the user to extract the same
information that would be printed by `ls-files -u`, which means
files with their mode, oid, and stage.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 merge-ort.c | 31 +++++++++++++++++++++++++++++++
 merge-ort.h | 21 +++++++++++++++++++++
 2 files changed, 52 insertions(+)

diff --git a/merge-ort.c b/merge-ort.c
index b9c9e906e94..1635d215c0b 100644
--- a/merge-ort.c
+++ b/merge-ort.c
@@ -4295,6 +4295,37 @@ void merge_display_update_messages(struct merge_options *opt,
 	trace2_region_leave("merge", "display messages", opt->repo);
 }
 
+void merge_get_conflicted_files(struct merge_result *result,
+				struct string_list *conflicted_files)
+{
+	struct hashmap_iter iter;
+	struct strmap_entry *e;
+	struct merge_options_internal *opti = result->priv;
+
+	strmap_for_each_entry(&opti->conflicted, &iter, e) {
+		const char *path = e->key;
+		struct conflict_info *ci = e->value;
+		int i;
+
+		VERIFY_CI(ci);
+
+		for (i = MERGE_BASE; i <= MERGE_SIDE2; i++) {
+			struct stage_info *si;
+
+			if (!(ci->filemask & (1ul << i)))
+				continue;
+
+			si = xmalloc(sizeof(*si));
+			si->stage = i+1;
+			si->mode = ci->stages[i].mode;
+			oidcpy(&si->oid, &ci->stages[i].oid);
+			string_list_append(conflicted_files, path)->util = si;
+		}
+	}
+	/* string_list_sort() uses a stable sort, so we're good */
+	string_list_sort(conflicted_files);
+}
+
 void merge_switch_to_result(struct merge_options *opt,
 			    struct tree *head,
 			    struct merge_result *result,
diff --git a/merge-ort.h b/merge-ort.h
index e5aec45b18f..ddcc39d7270 100644
--- a/merge-ort.h
+++ b/merge-ort.h
@@ -2,6 +2,7 @@
 #define MERGE_ORT_H
 
 #include "merge-recursive.h"
+#include "hash.h"
 
 struct commit;
 struct tree;
@@ -88,6 +89,26 @@ void merge_switch_to_result(struct merge_options *opt,
 void merge_display_update_messages(struct merge_options *opt,
 				   struct merge_result *result);
 
+struct stage_info {
+	struct object_id oid;
+	int mode;
+	int stage;
+};
+
+/*
+ * Provide a list of path -> {struct stage_info*} mappings for
+ * all conflicted files.  Note that each path could appear up to three
+ * times in the list, corresponding to 3 different stage entries.  In short,
+ * this basically provides the info that would be printed by `ls-files -u`.
+ *
+ * result should have been populated by a call to
+ * one of the merge_incore_[non]recursive() functions.
+ *
+ * conflicted_files should be empty before calling this function.
+ */
+void merge_get_conflicted_files(struct merge_result *result,
+				struct string_list *conflicted_files);
+
 /* Do needed cleanup when not calling merge_switch_to_result() */
 void merge_finalize(struct merge_options *opt,
 		    struct merge_result *result);
-- 
gitgitgadget

