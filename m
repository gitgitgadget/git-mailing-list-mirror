Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D099E1F404
	for <e@80x24.org>; Mon,  3 Sep 2018 18:10:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728212AbeICWb4 (ORCPT <rfc822;e@80x24.org>);
        Mon, 3 Sep 2018 18:31:56 -0400
Received: from mail-lf1-f41.google.com ([209.85.167.41]:43649 "EHLO
        mail-lf1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727493AbeICWbz (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 3 Sep 2018 18:31:55 -0400
Received: by mail-lf1-f41.google.com with SMTP id h64-v6so1012640lfi.10
        for <git@vger.kernel.org>; Mon, 03 Sep 2018 11:10:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=TZos09seLerEkDcAipA2xI788Qg1S7bLBhtsEHrbgFA=;
        b=MwaOvaJ+6PkNmCb632t+qOBCZQnnA3k98xs6nClFeJUVt5hBaSrKRNZ1o7AHPIcD+0
         CvmJ2tenWRABkek+NK4xOPN1mdYBVO5CojepWhP9vMLeZf+Vncx4cyDvx3kVw7UcltVA
         Hzn6ON5/63gvPSWx71t7SHIDS/Z/zS0yGRzj+j+DvrXXNffBNTwftkvFMss0pl/Wd3KQ
         CvPMC54/9A+wGh8IvWJOaQE4tvqesGLeVOXBuhJVgAB6qlQ9Z+wIxImclndmR/B1H+iC
         /u19KM7dnSYgnn15iHIHwZdqZg17qWP493+dp1XBX7TLhmLVX2DCQDT+8i/znnR3My60
         kU5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=TZos09seLerEkDcAipA2xI788Qg1S7bLBhtsEHrbgFA=;
        b=N5ELpvEBY5G0sfh2M53g+lZZ5WfTYYc8lFrvrLmRb+Q0waSLalry2lYwXUOol/T8LI
         q5F5z0FJON3lbD2lWJ1Aw37sH4xNDL9zC98HgeT2InGAU9HXi3ljw+jeHrERTSVgw93d
         rFf+NrlNCbFuBveKCTx/496zGu68hxmmxtWQfHVDZ/k9x65IPwN1u+GDzyDywvJupbNk
         TpZV37KeE/2Z0bmWlcIeIXCO6qlkyg+5TxIgZIKmd3cHwFTiKKC7Wi1/GMqty3s0iCDX
         KIDSuSDqawBu0Vf022FAodcExI5dVCu29ixAtYtlFqH7Kc7PnPDvxzzT5E57H9pFdZBT
         gxLw==
X-Gm-Message-State: APzg51C0hT9qFkfyOTaJfdI2+Bh0eyHna1TEvcmt8/QwBUffjjKVJOik
        sIdNqYXgqQoKXA4DfCWkxbQ=
X-Google-Smtp-Source: ANB0VdbJtBQHm9I5vb6fzIUCCuVvJxT7JyLTrytD+GceHV4fO7mscjBv5s1q4J/zLObkKQ2mCNZx+g==
X-Received: by 2002:a19:d808:: with SMTP id p8-v6mr12366842lfg.105.1535998233405;
        Mon, 03 Sep 2018 11:10:33 -0700 (PDT)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id x20-v6sm3706062lfi.8.2018.09.03.11.10.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 03 Sep 2018 11:10:32 -0700 (PDT)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     pclouds@gmail.com
Cc:     git@vger.kernel.org, Stefan Beller <sbeller@google.com>
Subject: [PATCH v2 19/24] submodule.c: remove implicit dependency on the_index
Date:   Mon,  3 Sep 2018 20:09:27 +0200
Message-Id: <20180903180932.32260-20-pclouds@gmail.com>
X-Mailer: git-send-email 2.19.0.rc0.337.ge906d732e7
In-Reply-To: <20180903180932.32260-1-pclouds@gmail.com>
References: <20180826100314.5137-1-pclouds@gmail.com>
 <20180903180932.32260-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 builtin/pull.c |  2 +-
 submodule.c    | 28 +++++++++++++++++-----------
 submodule.h    |  9 ++++++---
 transport.c    |  9 ++++++---
 4 files changed, 30 insertions(+), 18 deletions(-)

diff --git a/builtin/pull.c b/builtin/pull.c
index 33b7100837..9c455984d1 100644
--- a/builtin/pull.c
+++ b/builtin/pull.c
@@ -944,7 +944,7 @@ int cmd_pull(int argc, const char **argv, const char *prefix)
 		int ret = 0;
 		if ((recurse_submodules == RECURSE_SUBMODULES_ON ||
 		     recurse_submodules == RECURSE_SUBMODULES_ON_DEMAND) &&
-		    submodule_touches_in_range(&rebase_fork_point, &curr_head))
+		    submodule_touches_in_range(&the_index, &rebase_fork_point, &curr_head))
 			die(_("cannot rebase with locally recorded submodule modifications"));
 		if (!autostash) {
 			struct commit_list *list = NULL;
diff --git a/submodule.c b/submodule.c
index 50cbf5f13e..c0c1224760 100644
--- a/submodule.c
+++ b/submodule.c
@@ -766,7 +766,8 @@ static void collect_changed_submodules_cb(struct diff_queue_struct *q,
  * have a corresponding 'struct oid_array' (in the 'util' field) which lists
  * what the submodule pointers were updated to during the change.
  */
-static void collect_changed_submodules(struct string_list *changed,
+static void collect_changed_submodules(struct index_state *istate,
+				       struct string_list *changed,
 				       struct argv_array *argv)
 {
 	struct rev_info rev;
@@ -930,8 +931,10 @@ static int submodule_needs_pushing(const char *path, struct oid_array *commits)
 	return 0;
 }
 
-int find_unpushed_submodules(struct oid_array *commits,
-		const char *remotes_name, struct string_list *needs_pushing)
+int find_unpushed_submodules(struct index_state *istate,
+			     struct oid_array *commits,
+			     const char *remotes_name,
+			     struct string_list *needs_pushing)
 {
 	struct string_list submodules = STRING_LIST_INIT_DUP;
 	struct string_list_item *name;
@@ -943,7 +946,7 @@ int find_unpushed_submodules(struct oid_array *commits,
 	argv_array_push(&argv, "--not");
 	argv_array_pushf(&argv, "--remotes=%s", remotes_name);
 
-	collect_changed_submodules(&submodules, &argv);
+	collect_changed_submodules(istate, &submodules, &argv);
 
 	for_each_string_list_item(name, &submodules) {
 		struct oid_array *commits = name->util;
@@ -1044,7 +1047,8 @@ static void submodule_push_check(const char *path, const char *head,
 		die("process for submodule '%s' failed", path);
 }
 
-int push_unpushed_submodules(struct oid_array *commits,
+int push_unpushed_submodules(struct index_state *istate,
+			     struct oid_array *commits,
 			     const struct remote *remote,
 			     const struct refspec *rs,
 			     const struct string_list *push_options,
@@ -1053,7 +1057,8 @@ int push_unpushed_submodules(struct oid_array *commits,
 	int i, ret = 1;
 	struct string_list needs_pushing = STRING_LIST_INIT_DUP;
 
-	if (!find_unpushed_submodules(commits, remote->name, &needs_pushing))
+	if (!find_unpushed_submodules(istate, commits,
+				      remote->name, &needs_pushing))
 		return 1;
 
 	/*
@@ -1110,7 +1115,7 @@ void check_for_new_submodule_commits(struct object_id *oid)
 	oid_array_append(&ref_tips_after_fetch, oid);
 }
 
-static void calculate_changed_submodule_paths(void)
+static void calculate_changed_submodule_paths(struct index_state *istate)
 {
 	struct argv_array argv = ARGV_ARRAY_INIT;
 	struct string_list changed_submodules = STRING_LIST_INIT_DUP;
@@ -1131,7 +1136,7 @@ static void calculate_changed_submodule_paths(void)
 	 * Collect all submodules (whether checked out or not) for which new
 	 * commits have been recorded upstream in "changed_submodule_names".
 	 */
-	collect_changed_submodules(&changed_submodules, &argv);
+	collect_changed_submodules(istate, &changed_submodules, &argv);
 
 	for_each_string_list_item(name, &changed_submodules) {
 		struct oid_array *commits = name->util;
@@ -1158,7 +1163,8 @@ static void calculate_changed_submodule_paths(void)
 	initialized_fetch_ref_tips = 0;
 }
 
-int submodule_touches_in_range(struct object_id *excl_oid,
+int submodule_touches_in_range(struct index_state *istate,
+			       struct object_id *excl_oid,
 			       struct object_id *incl_oid)
 {
 	struct string_list subs = STRING_LIST_INIT_DUP;
@@ -1176,7 +1182,7 @@ int submodule_touches_in_range(struct object_id *excl_oid,
 		argv_array_push(&args, oid_to_hex(excl_oid));
 	}
 
-	collect_changed_submodules(&subs, &args);
+	collect_changed_submodules(istate, &subs, &args);
 	ret = subs.nr;
 
 	argv_array_clear(&args);
@@ -1346,7 +1352,7 @@ int fetch_populated_submodules(struct repository *r,
 	argv_array_push(&spf.args, "--recurse-submodules-default");
 	/* default value, "--submodule-prefix" and its value are added later */
 
-	calculate_changed_submodule_paths();
+	calculate_changed_submodule_paths(r->index);
 	run_processes_parallel(max_parallel_jobs,
 			       get_next_submodule,
 			       fetch_start_failure,
diff --git a/submodule.h b/submodule.h
index 7d476cefa7..600d41d765 100644
--- a/submodule.h
+++ b/submodule.h
@@ -102,13 +102,16 @@ int add_submodule_odb(const char *path);
  * Checks if there are submodule changes in a..b. If a is the null OID,
  * checks b and all its ancestors instead.
  */
-int submodule_touches_in_range(struct object_id *a,
+int submodule_touches_in_range(struct index_state *istate,
+			       struct object_id *a,
 			       struct object_id *b);
-int find_unpushed_submodules(struct oid_array *commits,
+int find_unpushed_submodules(struct index_state *istate,
+			     struct oid_array *commits,
 			     const char *remotes_name,
 			     struct string_list *needs_pushing);
 struct refspec;
-int push_unpushed_submodules(struct oid_array *commits,
+int push_unpushed_submodules(struct index_state *istate,
+			     struct oid_array *commits,
 			     const struct remote *remote,
 			     const struct refspec *rs,
 			     const struct string_list *push_options,
diff --git a/transport.c b/transport.c
index 06ffea2774..cb40a23d45 100644
--- a/transport.c
+++ b/transport.c
@@ -1139,7 +1139,8 @@ int transport_push(struct transport *transport,
 					oid_array_append(&commits,
 							  &ref->new_oid);
 
-			if (!push_unpushed_submodules(&commits,
+			if (!push_unpushed_submodules(&the_index,
+						      &commits,
 						      transport->remote,
 						      rs,
 						      transport->push_options,
@@ -1163,8 +1164,10 @@ int transport_push(struct transport *transport,
 					oid_array_append(&commits,
 							  &ref->new_oid);
 
-			if (find_unpushed_submodules(&commits, transport->remote->name,
-						&needs_pushing)) {
+			if (find_unpushed_submodules(&the_index,
+						     &commits,
+						     transport->remote->name,
+						     &needs_pushing)) {
 				oid_array_clear(&commits);
 				die_with_unpushed_submodules(&needs_pushing);
 			}
-- 
2.19.0.rc0.337.ge906d732e7

