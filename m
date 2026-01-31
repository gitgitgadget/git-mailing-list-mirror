Received: from mail-pj1-f68.google.com (mail-pj1-f68.google.com [209.85.216.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC5D02DCF46
	for <git@vger.kernel.org>; Sat, 31 Jan 2026 19:01:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769886102; cv=none; b=UUNIMOoqbhtblS6kk+7DjZuslN4MSN2LRRqJo/gNJkKGevaYOShOpxmTbs7T/29KOH01iUFOZ1vFSMkoEOslwYnwFJBlA1heAkvNjsuO+kNTOMvBkmkhfgqLPGQMJIT9YQ6ftfCxM/fA/jcexnBKM2fhLLvMC62qMvI1hgokJ+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769886102; c=relaxed/simple;
	bh=AgW8uC2Byyxzz/h/h1TyCVZW2jxVRbfzMlHLG5uqC0c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ONf00m4BK89O1883iO3lTuBl2iK8FZNho3uK6pHMAAoUzw05kYmC0xiW0lUxmou0Zqo4sXVMU7su31JHdfjGA6KwTxa65T2pYcuHR4d8/zSFn+1ZLBO7C6aoO4NPSTYyO9Dm6aouDMYkCKEp84qKK6Tzb0RecwARw3QYi/G6API=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ItLuqfN/; arc=none smtp.client-ip=209.85.216.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ItLuqfN/"
Received: by mail-pj1-f68.google.com with SMTP id 98e67ed59e1d1-350fe1f8ea3so1472008a91.2
        for <git@vger.kernel.org>; Sat, 31 Jan 2026 11:01:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769886100; x=1770490900; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ni80rKjhZsb6vW5cpIgOxpcUuyybAZaMhsiGOJynX2E=;
        b=ItLuqfN/f7ngrNvn78j1P40RVUmq1YKs48W5YIIctLUDdsaL4yFxCUC/c9wBfOwcc4
         8OTYK5m5rXMCxW/WJA2nOerpSG5OAi/6ao3VdX2QcY3KCkKb2CHV+AUYylassf94tfBD
         Ig0Mn5Xn8qtQgBri4Hur2aOqh7TV0S3KaIdyiU5ixvMp400nVJomgSTg0YfBg6ViqQu9
         FQThoWEoSHchxucrVydnQ6fTT1Q81sNDSJE1JXCSE8jeNbj9K7fJuDc4tT7e+7Ubx/Uo
         X37PBTvF3rI6kY6dvfMMMl+eRF6q9pOC52z9GuKm+rqlYpeqtKxHk4QoE1VaI88FJ5xZ
         w8DA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769886100; x=1770490900;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ni80rKjhZsb6vW5cpIgOxpcUuyybAZaMhsiGOJynX2E=;
        b=s7wrg+2wfs3oKidJm1fhkWzD0VjVR6ghgcx1GHRRH5jlCj8Y7ucmO2DZE99l71T79r
         ssc6aTGJGc/7u6uTvWlFSn48htjtbcxG+dlb2ELVI+1Rx9CpK3tFqmmOaqW/AlYPTyvD
         loW5MnKGBHZxC+lQZQtlmWx5r2x5uYUVzawbVF7LZ6HYO5nd2j0c7aFY1C7VhJ/MG7RX
         2p2Y+cUCGJrT2wT4jlJ7CNh5usNy1GatL/VyH6rk6L2WreZfSjHs5lPRjIk4O3ZgPvtc
         4rTbDEUQVSlFBoDIMM1u3BHI/pxs4fCjdF3fa6y7XFgvELC4sKza4I9i9aYkhbIk6Tm3
         7qxg==
X-Gm-Message-State: AOJu0YwpuzmtMjIEq38UctDRPR4yiovRRzEaxz/+0UDUUhK6f93RftVk
	vxWbsWMwUKI1KfW4qUX/hS21hpOFCqowELMLSYi6R/Hj6RIZmsH1VJDAd0VyYJei
X-Gm-Gg: AZuq6aLcfJFs9aztslOhRUcH08LWar+RaXO888MQFHf98mqgSotp4aW6i1OXI8510Tu
	dY6xLNdhR1uwoCsmsGBuy2QjVPA80plxGjom5XM+igKSGQgkSdDWn4PQIzUmapNLC0z0LIRp5Lz
	ig2Vn8s2HV21kjOWGv3DtDz9e0+87eJ6q8l8xTVV8sq0N1O6zQD0NBP3Gq9pukfqk+RgyVwK7HI
	py/EsIQVozPFoacet+EGdjmjIoBbLz0LacxhjB1X66J3o7/sBTsY4WebkZiRtE3daLbDRuO3EL4
	0BxZz5ikK/SUWirDun7KlQC5WthmYvN+eHnqQn+wj1PNPS7LZeeBHW9t6stwssQOGc6qg6Y7Kh2
	GBgkgxEBB9leMfO6ZyhxHfaNiqmoYKhPI3ct25aH6Y80/KCIOncRaUZXhO6ObmLU4B5tYglsg42
	8LQiUzdltwoMgpQLn95uw0gnrhtnX5PWbKHSJWs60IC0CH
X-Received: by 2002:a17:90b:3a84:b0:34c:a29d:992a with SMTP id 98e67ed59e1d1-3543b41d025mr6382016a91.34.1769886099896;
        Sat, 31 Jan 2026 11:01:39 -0800 (PST)
Received: from Shreyansh-PC.domain.name ([2401:4900:1cd6:312c:c36:249a:cab4:59a4])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3540f2cb419sm11151747a91.1.2026.01.31.11.01.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 31 Jan 2026 11:01:39 -0800 (PST)
From: Shreyansh Paliwal <shreyanshpaliwalcmsmn@gmail.com>
To: git@vger.kernel.org
Cc: gitster@pobox.com,
	Shreyansh Paliwal <shreyanshpaliwalcmsmn@gmail.com>
Subject: [PATCH 2/3] wt-status: pass struct repository and wt_status through function parameters
Date: Sun,  1 Feb 2026 00:27:38 +0530
Message-ID: <20260131190106.389289-3-shreyanshpaliwalcmsmn@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260131190106.389289-1-shreyanshpaliwalcmsmn@gmail.com>
References: <20260131190106.389289-1-shreyanshpaliwalcmsmn@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Some functions in wt-status.c relied on the_repository because no
repository instance was available in their local scope.

Update these functions to accept struct repository or struct
wt_status as parameters, and adjust callers accordingly.

Replace remaining uses of the_repository in these functions with the
passed-in repository instance.

This completely removes the use of the_repository global variable
in wt-status.c.

Signed-off-by: Shreyansh Paliwal <shreyanshpaliwalcmsmn@gmail.com>
---
 wt-status.c | 32 ++++++++++++++++----------------
 1 file changed, 16 insertions(+), 16 deletions(-)

diff --git a/wt-status.c b/wt-status.c
index 9f4d8fda7f..eb1a3a254b 100644
--- a/wt-status.c
+++ b/wt-status.c
@@ -984,17 +984,17 @@ static int stash_count_refs(const char *refname UNUSED,
 	return 0;
 }
 
-static int count_stash_entries(void)
+static int count_stash_entries(struct repository *r)
 {
 	int n = 0;
-	refs_for_each_reflog_ent(get_main_ref_store(the_repository),
+	refs_for_each_reflog_ent(get_main_ref_store(r),
 				 "refs/stash", stash_count_refs, &n);
 	return n;
 }
 
 static void wt_longstatus_print_stash_summary(struct wt_status *s)
 {
-	int stash_count = count_stash_entries();
+	int stash_count = count_stash_entries(s->repo);
 
 	if (stash_count > 0)
 		status_printf_ln(s, GIT_COLOR_NORMAL,
@@ -1287,10 +1287,10 @@ static void show_am_in_progress(struct wt_status *s,
 	wt_longstatus_print_trailer(s);
 }
 
-static char *read_line_from_git_path(const char *filename)
+static char *read_line_from_git_path(struct repository *r, const char *filename)
 {
 	struct strbuf buf = STRBUF_INIT;
-	FILE *fp = fopen_or_warn(repo_git_path_append(the_repository, &buf,
+	FILE *fp = fopen_or_warn(repo_git_path_append(r, &buf,
 						      "%s", filename), "r");
 
 	if (!fp) {
@@ -1325,8 +1325,8 @@ static int split_commit_in_progress(struct wt_status *s)
 	if (head_flags & REF_ISSYMREF || orig_head_flags & REF_ISSYMREF)
 		return 0;
 
-	rebase_amend = read_line_from_git_path("rebase-merge/amend");
-	rebase_orig_head = read_line_from_git_path("rebase-merge/orig-head");
+	rebase_amend = read_line_from_git_path(s->repo, "rebase-merge/amend");
+	rebase_orig_head = read_line_from_git_path(s->repo, "rebase-merge/orig-head");
 
 	if (!rebase_amend || !rebase_orig_head)
 		; /* fall through, no split in progress */
@@ -1350,7 +1350,7 @@ static int split_commit_in_progress(struct wt_status *s)
  * The function assumes that the line does not contain useless spaces
  * before or after the command.
  */
-static void abbrev_oid_in_line(struct strbuf *line)
+static void abbrev_oid_in_line(struct repository *r, struct strbuf *line)
 {
 	struct string_list split = STRING_LIST_INIT_DUP;
 	struct object_id oid;
@@ -1362,7 +1362,7 @@ static void abbrev_oid_in_line(struct strbuf *line)
 		return;
 
 	if ((2 <= string_list_split(&split, line->buf, " ", 2)) &&
-	    !repo_get_oid(the_repository, split.items[1].string, &oid)) {
+	    !repo_get_oid(r, split.items[1].string, &oid)) {
 		strbuf_reset(line);
 		strbuf_addf(line, "%s ", split.items[0].string);
 		strbuf_add_unique_abbrev(line, &oid, DEFAULT_ABBREV);
@@ -1372,10 +1372,10 @@ static void abbrev_oid_in_line(struct strbuf *line)
 	string_list_clear(&split, 0);
 }
 
-static int read_rebase_todolist(const char *fname, struct string_list *lines)
+static int read_rebase_todolist(struct repository *r, const char *fname, struct string_list *lines)
 {
 	struct strbuf buf = STRBUF_INIT;
-	FILE *f = fopen(repo_git_path_append(the_repository, &buf, "%s", fname), "r");
+	FILE *f = fopen(repo_git_path_append(r, &buf, "%s", fname), "r");
 	int ret;
 
 	if (!f) {
@@ -1384,7 +1384,7 @@ static int read_rebase_todolist(const char *fname, struct string_list *lines)
 			goto out;
 		}
 		die_errno("Could not open file %s for reading",
-			  repo_git_path_replace(the_repository, &buf, "%s", fname));
+			  repo_git_path_replace(r, &buf, "%s", fname));
 	}
 	while (!strbuf_getline_lf(&buf, f)) {
 		if (starts_with(buf.buf, comment_line_str))
@@ -1392,7 +1392,7 @@ static int read_rebase_todolist(const char *fname, struct string_list *lines)
 		strbuf_trim(&buf);
 		if (!buf.len)
 			continue;
-		abbrev_oid_in_line(&buf);
+		abbrev_oid_in_line(r, &buf);
 		string_list_append(lines, buf.buf);
 	}
 	fclose(f);
@@ -1413,8 +1413,8 @@ static void show_rebase_information(struct wt_status *s,
 		struct string_list have_done = STRING_LIST_INIT_DUP;
 		struct string_list yet_to_do = STRING_LIST_INIT_DUP;
 
-		read_rebase_todolist("rebase-merge/done", &have_done);
-		if (read_rebase_todolist("rebase-merge/git-rebase-todo",
+		read_rebase_todolist(s->repo, "rebase-merge/done", &have_done);
+		if (read_rebase_todolist(s->repo, "rebase-merge/git-rebase-todo",
 					 &yet_to_do))
 			status_printf_ln(s, color,
 				_("git-rebase-todo is missing."));
@@ -2259,7 +2259,7 @@ static void wt_porcelain_v2_print_tracking(struct wt_status *s)
  */
 static void wt_porcelain_v2_print_stash(struct wt_status *s)
 {
-	int stash_count = count_stash_entries();
+	int stash_count = count_stash_entries(s->repo);
 	char eol = s->null_termination ? '\0' : '\n';
 
 	if (stash_count > 0)
-- 
2.52.0

