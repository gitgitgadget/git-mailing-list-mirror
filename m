Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1250356766
	for <git@vger.kernel.org>; Wed, 19 Jun 2024 03:00:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718766032; cv=none; b=X+lkNJJLWKeALT7D3uZEB5xjGvc65nBidOlkT/GjMjCyJSJDrMLlN11K577dv75cAfJtODpGqx0MUksYr9jxH4taynLlBS58pfQkcEuoGZlnxArre6PmUe41sHvEsnaDRO88x9tQR3KJmXKSZd8s35ZixhRNGFGGJW26Yo6bMjw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718766032; c=relaxed/simple;
	bh=g/s4pDKau4zJ3xPBXI+BdJob4svDmH9t1cmpJjEMLX0=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=iM/ah8ID4QKhFcRApwFNhRrURla2xEPSNHytd+vGPa9bLdd5d/I82hhyRNXbyTUJMKdBscMIGyDGkRLZrX4oj5RxyCaJgDVKieF43EcKrtq1YS5r5k2oxyHYTi5B27dfRukiUqOTAm3b07peNw4CppgLkkC/WIVtCiVGnqKpKr8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PvMLNOTR; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PvMLNOTR"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4217990f8baso55093415e9.2
        for <git@vger.kernel.org>; Tue, 18 Jun 2024 20:00:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718766029; x=1719370829; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gCcoEWlJCrgh53o0wPpgv1dTJAB9+0KhbA69cFsF4GY=;
        b=PvMLNOTRfwOi+YwBEKDm85XON0UsJwGjBhIxby3PpcNIukmsUaaqPzoDp0/0xhKOn5
         gNCtoF8IjagwcPX9lfvdVsW1aj4t4bb8ydnRHQVLSc3AqOw5CoWEuFynnTVIL6eGULhO
         XJidS3big0OWwWLNC3iClUyVoRR8XsqH4+YWbw7tk9g6Y64aOh7F0cmbfHfbsSY7BRQE
         3yklb4CbrUNJ3hmkeViAjh+ajeLREi0t6B/Biu+apIHnSgPkQd7oV72sfBEnLv0mlec+
         +oB4u9grzPu1ZPmtXQ5ZrblekEneS42YZ7wRbUPqueTgKYYWd3eblcPO5F4UAi/ZUez9
         MwxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718766029; x=1719370829;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gCcoEWlJCrgh53o0wPpgv1dTJAB9+0KhbA69cFsF4GY=;
        b=FZjo0tQW4cJwD9fHpqgVnyzxVFRrpSOnBzoE9CNe8H9p28rB0nMnsqMsp9BVccdxDk
         rz/bKW5I9SKLgofvv1S5QuVxJRpst5qELAP5l5fj0rYIElST2IN31SywhYNRVwY129l5
         KaxyqcMMdnHkDHrttQfejQVMzRzsbz7pWOdUN3JGK3Ls/9Bk5OxPjIhTsRHkQpF/+Yxr
         YKfTBETHE7BktiiQ7SnIiOoI4JKTtPo4TDKc8gKqDgrFkjzrkKI5b3bWvbwiNLbpwvpw
         zJ+TJrL+/wAuZnGd5hvHNShSC0P5pYZqbdtcsFQgE26P2M+xA4FZkHP7q2mrq2jjRrx/
         nZPA==
X-Gm-Message-State: AOJu0YwVkkg5zVgPmr2VA4wFTLNXoZuM+v5cMl8yjTOO0WEBxpLglWFr
	0B4+6hYMApNX+IJ49kj4nsCkahYVnX9jD4o8wKpA2Bwthxss9I7stIEFLQ==
X-Google-Smtp-Source: AGHT+IEKU6tAfF8RCkijMOpiFIBT7XMzOMEpTLZwWaSqtQTli1QvkW9fg+nrW82IgNfVGbn1VJt1BQ==
X-Received: by 2002:a5d:53cd:0:b0:362:5b83:51dd with SMTP id ffacd0b85a97d-363192cdeb4mr979554f8f.49.1718766029205;
        Tue, 18 Jun 2024 20:00:29 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4247101aac6sm28683705e9.0.2024.06.18.20.00.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Jun 2024 20:00:28 -0700 (PDT)
Message-Id: <6756956d0c7e3672a1a3b362b31b9d7e29bc5b9f.1718766019.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1748.v2.git.1718766019.gitgitgadget@gmail.com>
References: <pull.1748.git.1718310307.gitgitgadget@gmail.com>
	<pull.1748.v2.git.1718766019.gitgitgadget@gmail.com>
From: "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 19 Jun 2024 03:00:18 +0000
Subject: [PATCH v2 6/7] merge-ort: upon merge abort, only show messages
 causing the abort
Fcc: Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
To: git@vger.kernel.org
Cc: Taylor Blau <me@ttaylorr.com>,
    Eric Sunshine <sunshine@sunshineco.com>,
    Elijah Newren <newren@gmail.com>,
    Elijah Newren <newren@gmail.com>

From: Elijah Newren <newren@gmail.com>

When something goes wrong enough that we need to abort early and not
even attempt merging the remaining files, it probably does not make
sense to report conflicts messages for the subset of files we processed
before hitting the fatal error.  Instead, only show the messages
associated with paths where we hit the fatal error.  Also, print these
messages to stderr rather than stdout.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 merge-ort.c | 78 ++++++++++++++++++++++++++++++++++++-----------------
 1 file changed, 53 insertions(+), 25 deletions(-)

diff --git a/merge-ort.c b/merge-ort.c
index d0b13463283..b337e4d74ef 100644
--- a/merge-ort.c
+++ b/merge-ort.c
@@ -543,10 +543,24 @@ enum conflict_and_info_types {
 	CONFLICT_SUBMODULE_HISTORY_NOT_AVAILABLE,
 	CONFLICT_SUBMODULE_MAY_HAVE_REWINDS,
 	CONFLICT_SUBMODULE_NULL_MERGE_BASE,
-	CONFLICT_SUBMODULE_CORRUPT,
+
+	/* INSERT NEW ENTRIES HERE */
+
+	/*
+	 * Keep this entry after all regular conflict and info types; only
+	 * errors (failures causing immediate abort of the merge) should
+	 * come after this.
+	 */
+	NB_REGULAR_CONFLICT_TYPES,
+
+	/*
+	 * Something is seriously wrong; cannot even perform merge;
+	 * Keep this group _last_ other than NB_TOTAL_TYPES
+	 */
+	ERROR_SUBMODULE_CORRUPT,
 
 	/* Keep this entry _last_ in the list */
-	NB_CONFLICT_TYPES,
+	NB_TOTAL_TYPES,
 };
 
 /*
@@ -597,8 +611,10 @@ static const char *type_short_descriptions[] = {
 		"CONFLICT (submodule may have rewinds)",
 	[CONFLICT_SUBMODULE_NULL_MERGE_BASE] =
 		"CONFLICT (submodule lacks merge base)",
-	[CONFLICT_SUBMODULE_CORRUPT] =
-		"CONFLICT (submodule corrupt)"
+
+	/* Something is seriously wrong; cannot even perform merge */
+	[ERROR_SUBMODULE_CORRUPT] =
+		"ERROR (submodule corrupt)",
 };
 
 struct logical_conflict_info {
@@ -762,7 +778,8 @@ static void path_msg(struct merge_options *opt,
 
 	/* Sanity checks */
 	assert(omittable_hint ==
-	       !starts_with(type_short_descriptions[type], "CONFLICT") ||
+	       (!starts_with(type_short_descriptions[type], "CONFLICT") &&
+		!starts_with(type_short_descriptions[type], "ERROR")) ||
 	       type == CONFLICT_DIR_RENAME_SUGGESTED);
 	if (opt->record_conflict_msgs_as_headers && omittable_hint)
 		return; /* Do not record mere hints in headers */
@@ -1817,9 +1834,9 @@ static int merge_submodule(struct merge_options *opt,
 	/* check whether both changes are forward */
 	ret2 = repo_in_merge_bases(&subrepo, commit_o, commit_a);
 	if (ret2 < 0) {
-		path_msg(opt, CONFLICT_SUBMODULE_CORRUPT, 0,
+		path_msg(opt, ERROR_SUBMODULE_CORRUPT, 0,
 			 path, NULL, NULL, NULL,
-			 _("Failed to merge submodule %s "
+			 _("error: failed to merge submodule %s "
 			   "(repository corrupt)"),
 			 path);
 		ret = -1;
@@ -1828,9 +1845,9 @@ static int merge_submodule(struct merge_options *opt,
 	if (ret2 > 0)
 		ret2 = repo_in_merge_bases(&subrepo, commit_o, commit_b);
 	if (ret2 < 0) {
-		path_msg(opt, CONFLICT_SUBMODULE_CORRUPT, 0,
+		path_msg(opt, ERROR_SUBMODULE_CORRUPT, 0,
 			 path, NULL, NULL, NULL,
-			 _("Failed to merge submodule %s "
+			 _("error: failed to merge submodule %s "
 			   "(repository corrupt)"),
 			 path);
 		ret = -1;
@@ -1848,9 +1865,9 @@ static int merge_submodule(struct merge_options *opt,
 	/* Case #1: a is contained in b or vice versa */
 	ret2 = repo_in_merge_bases(&subrepo, commit_a, commit_b);
 	if (ret2 < 0) {
-		path_msg(opt, CONFLICT_SUBMODULE_CORRUPT, 0,
+		path_msg(opt, ERROR_SUBMODULE_CORRUPT, 0,
 			 path, NULL, NULL, NULL,
-			 _("Failed to merge submodule %s "
+			 _("error: failed to merge submodule %s "
 			   "(repository corrupt)"),
 			 path);
 		ret = -1;
@@ -1867,9 +1884,9 @@ static int merge_submodule(struct merge_options *opt,
 	}
 	ret2 = repo_in_merge_bases(&subrepo, commit_b, commit_a);
 	if (ret2 < 0) {
-		path_msg(opt, CONFLICT_SUBMODULE_CORRUPT, 0,
+		path_msg(opt, ERROR_SUBMODULE_CORRUPT, 0,
 			 path, NULL, NULL, NULL,
-			 _("Failed to merge submodule %s "
+			 _("error: failed to merge submodule %s "
 			   "(repository corrupt)"),
 			 path);
 		ret = -1;
@@ -1901,9 +1918,9 @@ static int merge_submodule(struct merge_options *opt,
 					 &merges);
 	switch (parent_count) {
 	case -1:
-		path_msg(opt, CONFLICT_SUBMODULE_CORRUPT, 0,
+		path_msg(opt, ERROR_SUBMODULE_CORRUPT, 0,
 			 path, NULL, NULL, NULL,
-			 _("Failed to merge submodule %s "
+			 _("error: failed to merge submodule %s "
 			   "(repository corrupt)"),
 			 path);
 		ret = -1;
@@ -4646,6 +4663,7 @@ void merge_display_update_messages(struct merge_options *opt,
 	struct hashmap_iter iter;
 	struct strmap_entry *e;
 	struct string_list olist = STRING_LIST_INIT_NODUP;
+	FILE *o = stdout;
 
 	if (opt->record_conflict_msgs_as_headers)
 		BUG("Either display conflict messages or record them as headers, not both");
@@ -4662,6 +4680,10 @@ void merge_display_update_messages(struct merge_options *opt,
 	}
 	string_list_sort(&olist);
 
+	/* Print to stderr if we hit errors rather than just conflicts */
+	if (result->clean < 0)
+		o = stderr;
+
 	/* Iterate over the items, printing them */
 	for (int path_nr = 0; path_nr < olist.nr; ++path_nr) {
 		struct string_list *conflicts = olist.items[path_nr].util;
@@ -4669,25 +4691,31 @@ void merge_display_update_messages(struct merge_options *opt,
 			struct logical_conflict_info *info =
 				conflicts->items[i].util;
 
+			/* On failure, ignore regular conflict types */
+			if (result->clean < 0 &&
+			    info->type < NB_REGULAR_CONFLICT_TYPES)
+				continue;
+
 			if (detailed) {
-				printf("%lu", (unsigned long)info->paths.nr);
-				putchar('\0');
+				fprintf(o, "%lu", (unsigned long)info->paths.nr);
+				fputc('\0', o);
 				for (int n = 0; n < info->paths.nr; n++) {
-					fputs(info->paths.v[n], stdout);
-					putchar('\0');
+					fputs(info->paths.v[n], o);
+					fputc('\0', o);
 				}
-				fputs(type_short_descriptions[info->type],
-				      stdout);
-				putchar('\0');
+				fputs(type_short_descriptions[info->type], o);
+				fputc('\0', o);
 			}
-			puts(conflicts->items[i].string);
+			fputs(conflicts->items[i].string, o);
+			fputc('\n', o);
 			if (detailed)
-				putchar('\0');
+				fputc('\0', o);
 		}
 	}
 	string_list_clear(&olist, 0);
 
-	print_submodule_conflict_suggestion(&opti->conflicted_submodules);
+	if (result->clean >= 0)
+		print_submodule_conflict_suggestion(&opti->conflicted_submodules);
 
 	/* Also include needed rename limit adjustment now */
 	diff_warn_rename_limit("merge.renamelimit",
-- 
gitgitgadget

