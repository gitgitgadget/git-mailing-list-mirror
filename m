Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19F6BC433FE
	for <git@archiver.kernel.org>; Sun, 20 Feb 2022 06:55:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237214AbiBTGz1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 20 Feb 2022 01:55:27 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:46786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234462AbiBTGzQ (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 20 Feb 2022 01:55:16 -0500
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE99B35DC8
        for <git@vger.kernel.org>; Sat, 19 Feb 2022 22:54:50 -0800 (PST)
Received: by mail-wr1-x42c.google.com with SMTP id f3so21392047wrh.7
        for <git@vger.kernel.org>; Sat, 19 Feb 2022 22:54:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=Ap4ZqYlnkgb+ZsEVT3Um4/EicxMnYbd2hGinYTe7EAw=;
        b=a0pdsI7ZYbQWX9VugWGY/1rxq6/i6qqPy/iTgt4js6zupbZ5+yJmORuoc1S/3AkESg
         GUKR+cOq9H7lMZzrHKQvlfmcQy1l1L/V2peZoZXQC9kqNbqQO0vUjbOs2m6PvW4U0UGI
         Im5qt3VtvErpy4bb+xh41epcM8qgdPXegxO/GyPdtNlkAyM+6ZfP8QcT/EV8ZxNKzfhY
         3DbWJbTTtwyWuYLqnkO03a7vP45XR1IM6uBNrqtBVAtA8+YLGRcIz/sDs4CGxtB6nOoa
         q2+AjTLeFXz+g9ATCSKlFr7ywonBTvjN5qut1LTIDltQPdjCkaRmvikV7EKnlMDs/qN3
         QzBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=Ap4ZqYlnkgb+ZsEVT3Um4/EicxMnYbd2hGinYTe7EAw=;
        b=duG27B6A6w7MAz/Rg/rQC2WsL28SuFcoty8HQ58a+PczP0B2pVBTkgIu3YkQnjJ9Wd
         f5PuGmwH2NsX61lnJdlv+1D3tiptAfqYhP7NXCzpkNWTsyjXfPHIxutyCdbl5QhvbYGQ
         LHdbCt2c8410rw475x37hTb6z49YjRyRRTuatpqp2jRIJgr5HdbTPFU9+ASlCy4m4mJS
         DxrOCF6k64yrKq9Y5dyx/2fqvDyk3Pwvy1vPiHuc1hIkFOk/23P1K1Nk/10UUB6Jt28Q
         V+sqXxdbmF++nLEmt+4KlCbfQPGlWfso1GbM4z2+4OHSNKBjCDMLVWDaqMysky6xS6sV
         lRsw==
X-Gm-Message-State: AOAM530ModvLZAexS1jV29D/HBRJexMvWjxhfr8TJSN9IaOI8pQJMAo/
        LYLprIEeerAPUkOojJYp6rw3s+coTpg=
X-Google-Smtp-Source: ABdhPJy9Fb9LcA1BWaUWBaZLPkSdFPMpWC6Uv7EaavsqknuMvtjpsNEoYwLyRKmsZQlsjlGusD++Og==
X-Received: by 2002:a5d:5708:0:b0:1e4:aea5:a57c with SMTP id a8-20020a5d5708000000b001e4aea5a57cmr10781911wrv.709.1645340089343;
        Sat, 19 Feb 2022 22:54:49 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id z24-20020a1c4c18000000b0037bd7f40771sm3939649wmf.30.2022.02.19.22.54.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Feb 2022 22:54:48 -0800 (PST)
Message-Id: <12e2351092a00d2b5efaa3773771b200c6d52600.1645340082.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1122.v5.git.1645340082.gitgitgadget@gmail.com>
References: <pull.1122.v4.git.1644698093.gitgitgadget@gmail.com>
        <pull.1122.v5.git.1645340082.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sun, 20 Feb 2022 06:54:37 +0000
Subject: [PATCH v5 07/12] merge-ort: provide a merge_get_conflicted_files()
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
index ebaed98d53a..e1b647b0a40 100644
--- a/merge-ort.c
+++ b/merge-ort.c
@@ -4274,6 +4274,37 @@ void merge_display_update_messages(struct merge_options *opt,
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

