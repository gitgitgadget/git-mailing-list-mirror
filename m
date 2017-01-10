Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3789E205C9
	for <e@80x24.org>; Tue, 10 Jan 2017 08:49:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754889AbdAJItF (ORCPT <rfc822;e@80x24.org>);
        Tue, 10 Jan 2017 03:49:05 -0500
Received: from mail-pf0-f193.google.com ([209.85.192.193]:34115 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1760309AbdAJItB (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 10 Jan 2017 03:49:01 -0500
Received: by mail-pf0-f193.google.com with SMTP id y143so6871204pfb.1
        for <git@vger.kernel.org>; Tue, 10 Jan 2017 00:49:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=uXAlm9WFs7L/ZGQ5S3ZfuUHiJAr8Dr0u5QKcFc70a+o=;
        b=qWlRF0c1KM1IxDkweExgPmTckLcuf816fq6gYuXnzia1QQfPDlq0Spy7rN9UctX678
         N6Vx8zMAcJBgHxeCkvxPg/jNzn0iXtpYV8xPgNYJzfq7OCE+wgiHc49j+3Q7ZFzPSkGg
         O2iF30t5QTgg/9jdkZ9dg5AbeBBxCV1x5JUanFwX0m4GaPpfu/YxB6I8ApSD7q7VFs2j
         WNfMP7UNCuUo+jsUC2DMapNqYxOhH8xRXHIc+Z/ev6qM99tYNhIzDwMM2kc9kcCP97cz
         va4vokYzG4QlCwTtq2cyyBN5vWM/SfIrszc0Tz4hZLNGtpiAoR7PU5GDxiQmeXv1Yeu6
         9OPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=uXAlm9WFs7L/ZGQ5S3ZfuUHiJAr8Dr0u5QKcFc70a+o=;
        b=jIKQRO/m7+JKAGf70PuuCd/ZqX8oPRzwifPyCRoIUOqJc0N78ghIGxj2rOCX8C8f72
         pWIfCI3/k0yH6UuAPUublc1mOQAFSWebrzMLboohf7UwYUT3yUQjKhCS+K9dqMKVCvLt
         u98Yrr2Hh7CdCBqdJCMUFt1O8/rea88wdE9EgUEPOGYe4kvp9GMcqJOWz+pPQVxlNV5+
         MGaNAKpF0AUrtlrfN1iv0+99WOMqOa51CJqTQo9vWW+YxRRFck3JiRZrcWiElwvwMU/n
         doeb+wkKs38QlfYZ2g6RGGT9KKZVYNnuu0B8B62qZ1CiwamRHGv+mqyK3ZQg2NDQq6ub
         xSdg==
X-Gm-Message-State: AIkVDXJNQTCvXh4uTd5fA2Biu1kpojfsIugXZkYH3CjXVi2ceEG95Rvgz2oU3bU1lNRHQA==
X-Received: by 10.84.169.169 with SMTP id h38mr3344541plb.48.1484038140864;
        Tue, 10 Jan 2017 00:49:00 -0800 (PST)
Received: from AamlaJuice.corp.endurance.com ([115.110.127.198])
        by smtp.gmail.com with ESMTPSA id m12sm3411983pfg.92.2017.01.10.00.48.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 10 Jan 2017 00:49:00 -0800 (PST)
From:   Karthik Nayak <karthik.188@gmail.com>
X-Google-Original-From: Karthik Nayak <Karthik.188@gmail.com>
To:     git@vger.kernel.org
Cc:     jacob.keller@gmail.com, gitster@pobox.com,
        Karthik Nayak <karthik.188@gmail.com>
Subject: [PATCH v10 05/20] ref-filter: move get_head_description() from branch.c
Date:   Tue, 10 Jan 2017 14:19:38 +0530
Message-Id: <20170110084953.15890-6-Karthik.188@gmail.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20170110084953.15890-1-Karthik.188@gmail.com>
References: <20170110084953.15890-1-Karthik.188@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Karthik Nayak <karthik.188@gmail.com>

Move the implementation of get_head_description() from branch.c to
ref-filter.  This gives a description of the HEAD ref if called. This
is used as the refname for the HEAD ref whenever the
FILTER_REFS_DETACHED_HEAD option is used. Make it public because we
need it to calculate the length of the HEAD refs description in
branch.c:calc_maxwidth() when we port branch.c to use ref-filter
APIs.

Mentored-by: Christian Couder <christian.couder@gmail.com>
Mentored-by: Matthieu Moy <matthieu.moy@grenoble-inp.fr>
Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
---
 builtin/branch.c | 33 ---------------------------------
 ref-filter.c     | 38 ++++++++++++++++++++++++++++++++++++--
 ref-filter.h     |  2 ++
 3 files changed, 38 insertions(+), 35 deletions(-)

diff --git a/builtin/branch.c b/builtin/branch.c
index 9d30f55b0..6423ebce5 100644
--- a/builtin/branch.c
+++ b/builtin/branch.c
@@ -364,39 +364,6 @@ static void add_verbose_info(struct strbuf *out, struct ref_array_item *item,
 	strbuf_release(&subject);
 }
 
-static char *get_head_description(void)
-{
-	struct strbuf desc = STRBUF_INIT;
-	struct wt_status_state state;
-	memset(&state, 0, sizeof(state));
-	wt_status_get_state(&state, 1);
-	if (state.rebase_in_progress ||
-	    state.rebase_interactive_in_progress)
-		strbuf_addf(&desc, _("(no branch, rebasing %s)"),
-			    state.branch);
-	else if (state.bisect_in_progress)
-		strbuf_addf(&desc, _("(no branch, bisect started on %s)"),
-			    state.branch);
-	else if (state.detached_from) {
-		if (state.detached_at)
-			/* TRANSLATORS: make sure this matches
-			   "HEAD detached at " in wt-status.c */
-			strbuf_addf(&desc, _("(HEAD detached at %s)"),
-				state.detached_from);
-		else
-			/* TRANSLATORS: make sure this matches
-			   "HEAD detached from " in wt-status.c */
-			strbuf_addf(&desc, _("(HEAD detached from %s)"),
-				state.detached_from);
-	}
-	else
-		strbuf_addstr(&desc, _("(no branch)"));
-	free(state.branch);
-	free(state.onto);
-	free(state.detached_from);
-	return strbuf_detach(&desc, NULL);
-}
-
 static void format_and_print_ref_item(struct ref_array_item *item, int maxwidth,
 				      struct ref_filter *filter, const char *remote_prefix)
 {
diff --git a/ref-filter.c b/ref-filter.c
index 385fc04d0..5511a200c 100644
--- a/ref-filter.c
+++ b/ref-filter.c
@@ -14,6 +14,7 @@
 #include "git-compat-util.h"
 #include "version.h"
 #include "trailer.h"
+#include "wt-status.h"
 
 typedef enum { FIELD_STR, FIELD_ULONG, FIELD_TIME } cmp_type;
 typedef enum { COMPARE_EQUAL, COMPARE_UNEQUAL, COMPARE_NONE } cmp_status;
@@ -1101,6 +1102,37 @@ static void fill_remote_ref_details(struct used_atom *atom, const char *refname,
 		*s = refname;
 }
 
+char *get_head_description(void)
+{
+	struct strbuf desc = STRBUF_INIT;
+	struct wt_status_state state;
+	memset(&state, 0, sizeof(state));
+	wt_status_get_state(&state, 1);
+	if (state.rebase_in_progress ||
+	    state.rebase_interactive_in_progress)
+		strbuf_addf(&desc, _("(no branch, rebasing %s)"),
+			    state.branch);
+	else if (state.bisect_in_progress)
+		strbuf_addf(&desc, _("(no branch, bisect started on %s)"),
+			    state.branch);
+	else if (state.detached_from) {
+		/* TRANSLATORS: make sure these match _("HEAD detached at ")
+		   and _("HEAD detached from ") in wt-status.c */
+		if (state.detached_at)
+			strbuf_addf(&desc, _("(HEAD detached at %s)"),
+				state.detached_from);
+		else
+			strbuf_addf(&desc, _("(HEAD detached from %s)"),
+				state.detached_from);
+	}
+	else
+		strbuf_addstr(&desc, _("(no branch)"));
+	free(state.branch);
+	free(state.onto);
+	free(state.detached_from);
+	return strbuf_detach(&desc, NULL);
+}
+
 /*
  * Parse the object referred by ref, and grab needed value.
  */
@@ -1140,9 +1172,11 @@ static void populate_value(struct ref_array_item *ref)
 			name++;
 		}
 
-		if (starts_with(name, "refname"))
+		if (starts_with(name, "refname")) {
 			refname = ref->refname;
-		else if (starts_with(name, "symref"))
+			if (ref->kind & FILTER_REFS_DETACHED_HEAD)
+				refname = get_head_description();
+		} else if (starts_with(name, "symref"))
 			refname = ref->symref ? ref->symref : "";
 		else if (starts_with(name, "upstream")) {
 			const char *branch_name;
diff --git a/ref-filter.h b/ref-filter.h
index fc55fa357..f78323de0 100644
--- a/ref-filter.h
+++ b/ref-filter.h
@@ -108,5 +108,7 @@ int parse_opt_ref_sorting(const struct option *opt, const char *arg, int unset);
 struct ref_sorting *ref_default_sorting(void);
 /*  Function to parse --merged and --no-merged options */
 int parse_opt_merge_filter(const struct option *opt, const char *arg, int unset);
+/*  Get the current HEAD's description */
+char *get_head_description(void);
 
 #endif /*  REF_FILTER_H  */
-- 
2.11.0

