Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.5 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 211F51F453
	for <e@80x24.org>; Tue, 25 Sep 2018 19:48:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728077AbeIZB5V (ORCPT <rfc822;e@80x24.org>);
        Tue, 25 Sep 2018 21:57:21 -0400
Received: from mail-qt1-f201.google.com ([209.85.160.201]:50770 "EHLO
        mail-qt1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726878AbeIZB5V (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 25 Sep 2018 21:57:21 -0400
Received: by mail-qt1-f201.google.com with SMTP id e14-v6so9442390qtp.17
        for <git@vger.kernel.org>; Tue, 25 Sep 2018 12:48:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=stcmNKivRrqfXeP6KQWIfEL9itU1hFxTUcZ7vo1OUjQ=;
        b=Qnfo/yBQp83b8zZavrCjxAhMFGOtQD6sYjRLBUEzEnGEtkF8QWv310U6vkCReIlvwr
         3hPVvd/rCrVafD7me/5WIO5PeBAHLGfLH/gbstp6rH0WJZdaA7bw20GsffqRZYO5pAs/
         E2t9Hdcf/B/AtGsotmUf63F7jZUg/cmq6A0VYBvA2SzgHIjpjABdDNHwQmQY7VTyxEQE
         gUFcyJbtDBJAuYfvFzQOoG5lraNw5JBAvaDPhl9nPUj2eMgAhptoWN7R7L78/qqx74Om
         R2he4KFvSaQBzNhN4hdiOVrKhjau6ftZKKZsTtRLJ7w0qH2cUGCxgjRU1LphGgPurh6F
         7pcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=stcmNKivRrqfXeP6KQWIfEL9itU1hFxTUcZ7vo1OUjQ=;
        b=AIeDfXR4q6w4+gLZ8QFD/1V8nMGgiT+77++XXytMXbSE9XE5Qx0KyvB6knNKnDQWFi
         hSjCeUCanG83Ex+XDoNm0AbmDDeUq3IJ/ujxwvzfyP6SrTQx3sRveYY/pDV/NfTZLdQc
         GUKQbJP57gEpyEbc2hAf64XRZ0EZpZdJvZI3BspgJBTeXrbIiImtglZZ/2GjFyBg3bS4
         Rg8z0x3q6ZpOnaHGGpCFnGc8S514S6s53gZdZESDTgPUlEuOC8MbHJZrYcZtGvuXlbO4
         cTNVKYxuzx6j07VvOp0SsPmSMOsbFfC4zeOEHUeKIqwxUq9BBrIxai51ez9ZrSe0MLWP
         NNWg==
X-Gm-Message-State: ABuFfojfqGUkxXWeu+y+8F3ByPfexI3P+ulQpeCByyI+lZIHteD7d9g7
        ISk5RHQXF5fu/T+y+r7+rOa+jBhm5yhpwY6psznf4IQ0sPGTawBtBai+f2Xh0lhj6j0xjC7qR6I
        yboWDE8Ra8QlTPSENfRPGXq7Y44Y+IzMNDKeSchJtD1nnwbBHUjjo+bPztS5+
X-Google-Smtp-Source: ACcGV63vU2AnUGDJmKDBS/WHLT51RSA0S+MQ81CiDo/v3IPUk59R3u/HG8qtHvwHZUV9I4Nm2MMx51hOch6Z
X-Received: by 2002:ad4:4152:: with SMTP id z18-v6mr848765qvp.40.1537904892377;
 Tue, 25 Sep 2018 12:48:12 -0700 (PDT)
Date:   Tue, 25 Sep 2018 12:47:50 -0700
In-Reply-To: <20180925194755.105578-1-sbeller@google.com>
Message-Id: <20180925194755.105578-5-sbeller@google.com>
Mime-Version: 1.0
References: <20180925194755.105578-1-sbeller@google.com>
X-Mailer: git-send-email 2.19.0.605.g01d371f741-goog
Subject: [PATCH v4 4/9] submodule: move global changed_submodule_names into
 fetch submodule struct
From:   Stefan Beller <sbeller@google.com>
To:     git@vger.kernel.org
Cc:     Stefan Beller <sbeller@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The `changed_submodule_names` are only used for fetching, so let's make it
part of the struct that is passed around for fetching submodules.

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 submodule.c | 42 +++++++++++++++++++++++-------------------
 1 file changed, 23 insertions(+), 19 deletions(-)

diff --git a/submodule.c b/submodule.c
index 22c64bd8559..17103379ba4 100644
--- a/submodule.c
+++ b/submodule.c
@@ -25,7 +25,7 @@
 #include "commit-reach.h"
 
 static int config_update_recurse_submodules = RECURSE_SUBMODULES_OFF;
-static struct string_list changed_submodule_names = STRING_LIST_INIT_DUP;
+
 static int initialized_fetch_ref_tips;
 static struct oid_array ref_tips_before_fetch;
 static struct oid_array ref_tips_after_fetch;
@@ -1110,7 +1110,22 @@ void check_for_new_submodule_commits(struct object_id *oid)
 	oid_array_append(&ref_tips_after_fetch, oid);
 }
 
-static void calculate_changed_submodule_paths(void)
+struct submodule_parallel_fetch {
+	int count;
+	struct argv_array args;
+	struct repository *r;
+	const char *prefix;
+	int command_line_option;
+	int default_option;
+	int quiet;
+	int result;
+
+	struct string_list changed_submodule_names;
+};
+#define SPF_INIT {0, ARGV_ARRAY_INIT, NULL, NULL, 0, 0, 0, 0, STRING_LIST_INIT_DUP }
+
+static void calculate_changed_submodule_paths(
+	struct submodule_parallel_fetch *spf)
 {
 	struct argv_array argv = ARGV_ARRAY_INIT;
 	struct string_list changed_submodules = STRING_LIST_INIT_DUP;
@@ -1148,7 +1163,8 @@ static void calculate_changed_submodule_paths(void)
 			continue;
 
 		if (!submodule_has_commits(path, commits))
-			string_list_append(&changed_submodule_names, name->string);
+			string_list_append(&spf->changed_submodule_names,
+					   name->string);
 	}
 
 	free_submodules_oids(&changed_submodules);
@@ -1185,18 +1201,6 @@ int submodule_touches_in_range(struct object_id *excl_oid,
 	return ret;
 }
 
-struct submodule_parallel_fetch {
-	int count;
-	struct argv_array args;
-	struct repository *r;
-	const char *prefix;
-	int command_line_option;
-	int default_option;
-	int quiet;
-	int result;
-};
-#define SPF_INIT {0, ARGV_ARRAY_INIT, NULL, NULL, 0, 0, 0, 0}
-
 static int get_fetch_recurse_config(const struct submodule *submodule,
 				    struct submodule_parallel_fetch *spf)
 {
@@ -1257,7 +1261,7 @@ static int get_next_submodule(struct child_process *cp,
 		case RECURSE_SUBMODULES_ON_DEMAND:
 			if (!submodule ||
 			    !string_list_lookup(
-					&changed_submodule_names,
+					&spf->changed_submodule_names,
 					submodule->name))
 				continue;
 			default_argv = "on-demand";
@@ -1349,8 +1353,8 @@ int fetch_populated_submodules(struct repository *r,
 	argv_array_push(&spf.args, "--recurse-submodules-default");
 	/* default value, "--submodule-prefix" and its value are added later */
 
-	calculate_changed_submodule_paths();
-	string_list_sort(&changed_submodule_names);
+	calculate_changed_submodule_paths(&spf);
+	string_list_sort(&spf.changed_submodule_names);
 	run_processes_parallel(max_parallel_jobs,
 			       get_next_submodule,
 			       fetch_start_failure,
@@ -1359,7 +1363,7 @@ int fetch_populated_submodules(struct repository *r,
 
 	argv_array_clear(&spf.args);
 out:
-	string_list_clear(&changed_submodule_names, 1);
+	string_list_clear(&spf.changed_submodule_names, 1);
 	return spf.result;
 }
 
-- 
2.19.0.605.g01d371f741-goog

