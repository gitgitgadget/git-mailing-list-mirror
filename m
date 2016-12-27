Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C9A25200E0
	for <e@80x24.org>; Tue, 27 Dec 2016 16:23:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755422AbcL0QX2 (ORCPT <rfc822;e@80x24.org>);
        Tue, 27 Dec 2016 11:23:28 -0500
Received: from mail-pg0-f66.google.com ([74.125.83.66]:36082 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755384AbcL0QXY (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Dec 2016 11:23:24 -0500
Received: by mail-pg0-f66.google.com with SMTP id n5so12847011pgh.3
        for <git@vger.kernel.org>; Tue, 27 Dec 2016 08:23:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=aZ8bYc4J7zUE7p9adql6GAYHnvkxvf/yEFnw4zDOrHQ=;
        b=qE/axBxav4hu8CfWP2NDW/ldessPrMc+qSbLdAxLpZo2E4XpMc8cRhk8jbqzpgLVBA
         Z4LDbNdu5VA3wSA0h+qzzjMws8VVRn3YmQZzlQz5CUhYCrq1dW9eu2dnILhiMw5Z4cxr
         icrphh2LFg3HoGpF3tz7/tEEx39wMHISRu2zFikQjgccZ717n8tmlCbE1zv0TnGV1QX2
         2teaOp7zEWMWG6Tzj7801ZpoApPj81GXIabm3lNY0tnUKX/l7TEW0xXtmnnqc+lWt3V1
         VSrhIOgjnyAPggOQWBqUJm2Wze/CLzsS6Y24XQMRwcwh1/5JirBKxfYHBIPDqplSE9xL
         RTuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=aZ8bYc4J7zUE7p9adql6GAYHnvkxvf/yEFnw4zDOrHQ=;
        b=q0iCxLDJnIgOZDCCBzxdA2ncQGImio/rARTzS336GRetHLAb0nqm/srZyrWF67AL9/
         MoYbl7mtrAv+MlTCeLDmjNjYsX208DCVTfcYYcXc8e77+wH2k4e7zj3tCeMu2vTCZjfk
         6yqkegqCaEwAaYbFLttZWigaTrJk6iQ4o9BtQYLMWmZtQsydGYpbLPo4KFLraxHNgFO4
         SnTvysWXaQmDR4TIzmRuBUQ745Id0tQiOlQGSqZdsgypA1Agsfia/fkCHiLmeYWx8S1r
         HMRiS/kgfuq7LwoGSWw3wI1k0NNlf91eX4CpDzd4BnjxS70ek9vvJDUUZ7UXdm1lPDGM
         qT3w==
X-Gm-Message-State: AIkVDXLjvSpQLgFhfYJzXQJdGnpTtSL5G5UhAWOrR4rt9oVEZa+gELp7IlC0t5UVlIQQCg==
X-Received: by 10.84.215.194 with SMTP id g2mr68713169plj.16.1482855803970;
        Tue, 27 Dec 2016 08:23:23 -0800 (PST)
Received: from AamlaJuice.corp.endurance.com ([115.110.127.198])
        by smtp.gmail.com with ESMTPSA id c64sm46517096pfa.91.2016.12.27.08.23.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 27 Dec 2016 08:23:23 -0800 (PST)
From:   Karthik Nayak <karthik.188@gmail.com>
X-Google-Original-From: Karthik Nayak <Karthik.188@gmail.com>
To:     git@vger.kernel.org
Cc:     jacob.keller@gmail.com, gitster@pobox.com,
        ramsay@ramsayjones.plus.com, Karthik Nayak <karthik.188@gmail.com>
Subject: [PATCH v9 05/20] ref-filter: move get_head_description() from branch.c
Date:   Tue, 27 Dec 2016 21:53:42 +0530
Message-Id: <20161227162357.28212-6-Karthik.188@gmail.com>
X-Mailer: git-send-email 2.10.2
In-Reply-To: <20161227162357.28212-1-Karthik.188@gmail.com>
References: <20161227162357.28212-1-Karthik.188@gmail.com>
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
index 9d30f55..6423ebc 100644
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
index 385fc04..5511a20 100644
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
index fc55fa3..f78323d 100644
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
2.10.2

