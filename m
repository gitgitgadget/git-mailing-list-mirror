Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AFBB14265
	for <git@vger.kernel.org>; Sun, 17 Mar 2024 08:27:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710664078; cv=none; b=N6caHmwHr8V0ZV3FbXb3eUjcbAoSQrE6JWFA740IFxQuqW71y59vNNup2uwH1E4VqcA/I7hCwHToQMu0MXK0U8VZQvzuoKV5+q0cA5H6dGbsGpywVBf5vWYVIkNjThsH0BBHTgLHzK9PsxCv4jXO7K8vHKhVh/PpInZGaOHek1Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710664078; c=relaxed/simple;
	bh=Ya/ReF7ckz2qzXNhSlILNPntbmzO9d68JsIgHyo2+2I=;
	h=Message-ID:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=d5k+3VOLsRYL3LpsY1u/gLAJTzA5DkH0uEtVeywcso8V4xOsWo8g/TqRZCWXwH1F8VaeNGfQQKwxnUh6RpBTV+5Jlt9uAiiSTqnbom7TWqI0j60v6pEVjTFE6qdUPCMVHpCHZz366SbugJQDOXhPdacawrtlS8meDJcpgsQ4e+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LW2yWsA1; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LW2yWsA1"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-41405d77c7bso10085065e9.3
        for <git@vger.kernel.org>; Sun, 17 Mar 2024 01:27:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710664074; x=1711268874; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=L/45s98ra90Kcihpig7wT4SqNE9dOw3dMoiUyev6PNQ=;
        b=LW2yWsA1CkqVoUySQ8/wcCd0fTHCHT6QeG2Kt/UQjp8NCWlxLsoGH37B/qUcX6BiD1
         1WJ8IOVUucPGD2E5jOXY9P+vrE9yYOmQcm3U1XwsUEaTWFsMI3bqavRNTf1Gn1uv+vZO
         DnO5hPVK1fJbfRX6Oqje2pYa4ZA8t8GjPX7UckTwODvlHRAQGHTERItBiJCzx4UkqdWh
         d+9sub8YSmOIc8ny1gjVOe6k6QbqFUHfapNCMwt642QHgaq4ouRdzr3w9W8MgsdMIoh8
         PKcE9kGV0kHT2KiI1wqT8bz5SNcl8PfEDGHdzF/19DQquz1xAaoYhAKYL6iqVA4VCTP0
         oLNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710664074; x=1711268874;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=L/45s98ra90Kcihpig7wT4SqNE9dOw3dMoiUyev6PNQ=;
        b=IdYIfdzu7+A96VSi2Ao+/jgDzuVkSP8ia4bGv1SnTwtTUVgqecSAqR+VPpiAXpbLtC
         Ng2JXB4GnmO0nDNlS45rEQ++NdQrYaf6qIcmdmiyFZvzWjJ4vlJE4fiRi88ynYlpGVFW
         Cq5iq9quJkC0e1yhqvK5ib7MJlvO2A48kYPqsneDaXxJiHgBhkbWDikiw3HJ3awB2scH
         t9wF6RF1INvy5T4XgFPpE9Nnqt6PohocL7IaRx97F+GQ1jBrE45jo+UUyuRLiRwQbYuo
         uhIgC56wogTJoVxRaPoumhdPjckQhqKtCXfwZw+dO8dnh2OdundGJNSXbgwLSfHLSztG
         AvCA==
X-Gm-Message-State: AOJu0Yx3JwuevTYhFy4DfsPObH5i4vHcgO9bciw67QNOL1XpTmev9ab5
	L31tm7XqR3mlA44e4WnOsI8Prw9pdQnj/Jw08WoexctmcJhRFmEhgNvWetE3
X-Google-Smtp-Source: AGHT+IEQ0ZpME4DyTZ+/bWz/PStp3i8VlVpqeIfR3SgbF1v2MIGhS61GDhbihO51bqAfiQtm/n/Y7w==
X-Received: by 2002:a05:600c:54d1:b0:414:a9e:bedc with SMTP id iw17-20020a05600c54d100b004140a9ebedcmr1458829wmb.15.1710664073589;
        Sun, 17 Mar 2024 01:27:53 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id m9-20020a05600c3b0900b00413ebaf0055sm11087166wms.7.2024.03.17.01.27.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 Mar 2024 01:27:52 -0700 (PDT)
Message-ID: <2e89da2e72b460228b3f77b1a5168f0a1fe0adcf.1710664071.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1690.git.1710664071.gitgitgadget@gmail.com>
References: <pull.1690.git.1710664071.gitgitgadget@gmail.com>
From: "Mohit Marathe via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sun, 17 Mar 2024 08:27:50 +0000
Subject: [PATCH 1/2] utf8: change type from int to size_t
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
Cc: Mohit Marathe <mohitmarathe@proton.me>,
    Mohit Marathe <mohitmarathe@proton.me>

From: Mohit Marathe <mohitmarathe@proton.me>

This update modifies the variable types that are used in calls to the
`utf8_strnwidth` and `utf8_strwidth` functions. This modification is
a proactive measure in anticipation of an upcoming interface change
to these functions in the subsequent patch.

Signed-off-by: Mohit Marathe <mohitmarathe@proton.me>
---
 builtin/blame.c    | 6 +++---
 builtin/branch.c   | 2 +-
 builtin/fetch.c    | 2 +-
 builtin/worktree.c | 4 ++--
 column.c           | 2 +-
 diff.c             | 8 +++++---
 gettext.c          | 2 +-
 gettext.h          | 2 +-
 pretty.c           | 4 ++--
 utf8.c             | 4 ++--
 wt-status.c        | 4 ++--
 11 files changed, 21 insertions(+), 19 deletions(-)

diff --git a/builtin/blame.c b/builtin/blame.c
index db1f56de61a..a72e2552305 100644
--- a/builtin/blame.c
+++ b/builtin/blame.c
@@ -53,7 +53,7 @@ static const char *annotate_opt_usage[] = {
 };
 
 static int longest_file;
-static int longest_author;
+static size_t longest_author;
 static int max_orig_digits;
 static int max_digits;
 static int max_score_digits;
@@ -529,7 +529,7 @@ static void emit_other(struct blame_scoreboard *sb, struct blame_entry *ent, int
 					name = ci.author_mail.buf;
 				else
 					name = ci.author.buf;
-				pad = longest_author - utf8_strwidth(name);
+				pad = cast_size_t_to_int(longest_author - utf8_strwidth(name));
 				printf(" (%s%*s %10s",
 				       name, pad, "",
 				       format_time(ci.author_time,
@@ -631,7 +631,7 @@ static void find_alignment(struct blame_scoreboard *sb, int *option)
 
 	for (e = sb->ent; e; e = e->next) {
 		struct blame_origin *suspect = e->suspect;
-		int num;
+		size_t num;
 
 		if (compute_auto_abbrev)
 			auto_abbrev = update_auto_abbrev(auto_abbrev, suspect);
diff --git a/builtin/branch.c b/builtin/branch.c
index 8c2305ad2c8..321c3558f2d 100644
--- a/builtin/branch.c
+++ b/builtin/branch.c
@@ -349,7 +349,7 @@ static int calc_maxwidth(struct ref_array *refs, int remote_bonus)
 	for (i = 0; i < refs->nr; i++) {
 		struct ref_array_item *it = refs->items[i];
 		const char *desc = it->refname;
-		int w;
+		size_t w;
 
 		skip_prefix(it->refname, "refs/heads/", &desc);
 		skip_prefix(it->refname, "refs/remotes/", &desc);
diff --git a/builtin/fetch.c b/builtin/fetch.c
index 46a793411a4..fee992c3c14 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -705,7 +705,7 @@ static int refcol_width(const struct ref *ref_map, int compact_format)
 		max = max * 2 / 3;
 
 	for (ref = ref_map; ref; ref = ref->next) {
-		int rlen, llen = 0, len;
+		size_t rlen, llen = 0, len;
 
 		if (ref->status == REF_STATUS_REJECT_SHALLOW ||
 		    !ref->peer_ref ||
diff --git a/builtin/worktree.c b/builtin/worktree.c
index 9c76b62b02d..bdbf46fb658 100644
--- a/builtin/worktree.c
+++ b/builtin/worktree.c
@@ -961,8 +961,8 @@ static void show_worktree_porcelain(struct worktree *wt, int line_terminator)
 static void show_worktree(struct worktree *wt, int path_maxlen, int abbrev_len)
 {
 	struct strbuf sb = STRBUF_INIT;
-	int cur_path_len = strlen(wt->path);
-	int path_adj = cur_path_len - utf8_strwidth(wt->path);
+	size_t cur_path_len = strlen(wt->path);
+	int path_adj = cast_size_t_to_int(cur_path_len - utf8_strwidth(wt->path));
 	const char *reason;
 
 	strbuf_addf(&sb, "%-*s ", 1 + path_maxlen + path_adj, wt->path);
diff --git a/column.c b/column.c
index 50bbccc92ee..ec874036de6 100644
--- a/column.c
+++ b/column.c
@@ -22,7 +22,7 @@ struct column_data {
 };
 
 /* return length of 's' in letters, ANSI escapes stripped */
-static int item_length(const char *s)
+static size_t item_length(const char *s)
 {
 	return utf8_strnwidth(s, strlen(s), 1);
 }
diff --git a/diff.c b/diff.c
index e50def45383..4faf151345a 100644
--- a/diff.c
+++ b/diff.c
@@ -2629,7 +2629,8 @@ void print_stat_summary(FILE *fp, int files,
 
 static void show_stats(struct diffstat_t *data, struct diff_options *options)
 {
-	int i, len, add, del, adds = 0, dels = 0;
+	int i, add, del, adds = 0, dels = 0;
+	size_t len = 0;
 	uintmax_t max_change = 0, max_len = 0;
 	int total_files = data->nr, count;
 	int width, name_width, graph_width, number_width = 0, bin_width = 0;
@@ -2780,7 +2781,8 @@ static void show_stats(struct diffstat_t *data, struct diff_options *options)
 		char *name = file->print_name;
 		uintmax_t added = file->added;
 		uintmax_t deleted = file->deleted;
-		int name_len, padding;
+		size_t name_len;
+		int padding;
 
 		if (!file->is_interesting && (added + deleted == 0))
 			continue;
@@ -2809,7 +2811,7 @@ static void show_stats(struct diffstat_t *data, struct diff_options *options)
 			if (slash)
 				name = slash;
 		}
-		padding = len - utf8_strwidth(name);
+		padding = cast_size_t_to_int(len - utf8_strwidth(name));
 		if (padding < 0)
 			padding = 0;
 
diff --git a/gettext.c b/gettext.c
index 57facbc21ec..5a77b4f7202 100644
--- a/gettext.c
+++ b/gettext.c
@@ -127,7 +127,7 @@ void git_setup_gettext(void)
 }
 
 /* return the number of columns of string 's' in current locale */
-int gettext_width(const char *s)
+size_t gettext_width(const char *s)
 {
 	static int is_utf8 = -1;
 	if (is_utf8 == -1)
diff --git a/gettext.h b/gettext.h
index 484cafa5628..f161a21b45c 100644
--- a/gettext.h
+++ b/gettext.h
@@ -31,7 +31,7 @@
 #ifndef NO_GETTEXT
 extern int git_gettext_enabled;
 void git_setup_gettext(void);
-int gettext_width(const char *s);
+size_t gettext_width(const char *s);
 #else
 #define git_gettext_enabled (0)
 static inline void git_setup_gettext(void)
diff --git a/pretty.c b/pretty.c
index bdbed4295aa..f03493c74b1 100644
--- a/pretty.c
+++ b/pretty.c
@@ -1781,7 +1781,7 @@ static size_t format_and_pad_commit(struct strbuf *sb, /* in UTF-8 */
 
 	if (padding < 0) {
 		const char *start = strrchr(sb->buf, '\n');
-		int occupied;
+		size_t occupied;
 		if (!start)
 			start = sb->buf;
 		occupied = utf8_strnwidth(start, strlen(start), 1);
@@ -1802,7 +1802,7 @@ static size_t format_and_pad_commit(struct strbuf *sb, /* in UTF-8 */
 		placeholder++;
 		total_consumed++;
 	}
-	len = utf8_strnwidth(local_sb.buf, local_sb.len, 1);
+	len = cast_size_t_to_int(utf8_strnwidth(local_sb.buf, local_sb.len, 1));
 
 	if (c->flush_type == flush_left_and_steal) {
 		const char *ch = sb->buf + sb->len - 1;
diff --git a/utf8.c b/utf8.c
index 6bfaefa28eb..8ccdf684e07 100644
--- a/utf8.c
+++ b/utf8.c
@@ -466,7 +466,7 @@ int utf8_fprintf(FILE *stream, const char *format, ...)
 
 	columns = fputs(buf.buf, stream);
 	if (0 <= columns) /* keep the error from the I/O */
-		columns = utf8_strwidth(buf.buf);
+		columns = cast_size_t_to_int(utf8_strwidth(buf.buf));
 	strbuf_release(&buf);
 	return columns;
 }
@@ -806,7 +806,7 @@ void strbuf_utf8_align(struct strbuf *buf, align_type position, unsigned int wid
 		       const char *s)
 {
 	size_t slen = strlen(s);
-	int display_len = utf8_strnwidth(s, slen, 0);
+	size_t display_len = utf8_strnwidth(s, slen, 0);
 	int utf8_compensation = slen - display_len;
 
 	if (display_len >= width) {
diff --git a/wt-status.c b/wt-status.c
index 7108a92b52c..c847b4bb5ed 100644
--- a/wt-status.c
+++ b/wt-status.c
@@ -325,7 +325,7 @@ static int maxwidth(const char *(*label)(int), int minval, int maxval)
 
 	for (i = minval; i <= maxval; i++) {
 		const char *s = label(i);
-		int len = s ? utf8_strwidth(s) : 0;
+		size_t len = s ? utf8_strwidth(s) : 0;
 		if (len > result)
 			result = len;
 	}
@@ -341,7 +341,7 @@ static void wt_longstatus_print_unmerged_data(struct wt_status *s,
 	static char *padding;
 	static int label_width;
 	const char *one, *how;
-	int len;
+	size_t len;
 
 	if (!padding) {
 		label_width = maxwidth(wt_status_unmerged_status_string, 1, 7);
-- 
gitgitgadget

