Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B2451F03DE
	for <git@vger.kernel.org>; Sun, 26 Jul 2026 19:57:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785095854; cv=none; b=CU2Of43vIiUPF/e0pGETU4tYJmxxHc4RYfrFHKzrylwUJpes6uOHTD4H6lwpmP8cWmLvGs45MA0XrL14Tt890ovKZCEt7oHDszB54991sQQvtScSNDWpvSjUxmyPCHL8eii9YBCYnv7L6CSxazExyBYa0EoguH0MdSgVe3qySQk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785095854; c=relaxed/simple;
	bh=nNKvhEBTENGrcWy8hX0lk5lU/yx8fnkgiJ2CwUsZRus=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gp4n2fnIRCA0PJaldAgBR37GIi5bMwyGP4U7rcCYxjARBDozTLYFMu1BzyPuytbgPkwpXqYh4o/+6SRxNHxl9gQekPtaeWhL3L0ZdT+Ail5A7La3Od1UqgcbyxIW+bg60K8zkk8g+tw7A0WcoflL8klfvmmKUpU7jZ+jHdLfJGk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eVlYhQF6; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eVlYhQF6"
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-c9b373d5af0so1474415a12.2
        for <git@vger.kernel.org>; Sun, 26 Jul 2026 12:57:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785095852; x=1785700652; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=gTsklbUC0EVoqPA+bs3wFDPeDKGLz11BxEGbL/Jd6L4=;
        b=eVlYhQF6DEkZKlAqjmxtsZLiecxo08kemqgTgCugBLP3HEZEBZIt8UvEJDPB0n0bpO
         95kd0uEAmgMjWAZWHgPZbruk+kczEkWLSCVxwIsyaBLZ51mMmbZKWNHDecFZyK60B1bm
         EjWHNL9nYJsqOsX3upNacUn/t9/fVR+z4hW2/T1xWvdf/hxD5immmsT4AiQ23/jeS2CU
         8YSj0bBGGUpdjf5n/ncHtjgt2U1sc1hr0WBnCb7nKs6PA0Tqnp0KhQ6KNNIMT6UVTBYK
         RRuXMU6Xi0DF+X3D+KQATnTP062L6adhxpOsdrssaf0Datwd9fkfav9op7ERARu+oxc0
         N1rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785095852; x=1785700652;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=gTsklbUC0EVoqPA+bs3wFDPeDKGLz11BxEGbL/Jd6L4=;
        b=ewGmk15FqQ5rn6i5Jn+OYHEsFGkfMw3ABofuy9DwDbQcCa8zTdX4aNRVunzB5DftS9
         AuAut+Sy6eBlNTTYyi+xrkNiH45Ws3d308EcnbU7SJyM1j7gsTxCA/fZb7sYrmv0h+/x
         /iz1Z/71YOEaPBwxa6+OvF1rekWRG6ycErNDeb9TlDlcR3RIZnRCVmZClkAdv6SOtmHa
         ZBfHkvHGiHYYI0EsfagK5G5XTJDpJqKsTTdH8HRnRqMiiLF2HvnUC5o0z18JFG18S9DK
         eHBbZLLGI1qDqangJAO2C5PtwXAFbN9f2kwfsxdT8q3yFe3swbO3FBInd+yZV0T9SXB7
         CcCA==
X-Gm-Message-State: AOJu0YzaKTFzRhu1iIEq4d6iKZ6G/AnV+DPblZLe+/2Ek6AHHMeZmqHn
	UjqABsmneyau/YLsL4PRXekN0umJPsSIItP7+38vk2Jwpk0pcw2l5GkgsXciKgsV
X-Gm-Gg: AR+sD12cL0GPzYXlkggdBiHgeaCClZ2eO8MB06QfI72eKm+FbhOU8rfmilpwSQW5K4o
	PZZeZC786e2G+r9oMKHmHlYS5mQyjTXSB3Oi6CFYdp5g9pByf7dk5EKqZ/rPvVqd3UHbI0De1eD
	+dQFTdg/6+/MXN1ewLqkeJvqu9QsfN3L6l/D/Z9XpSBWtJV97HzBur84AHh8nTs4OHJlUj1o0Q5
	vjc2xDFq77ihaik73Y7CYElDJAPirrWjpRch6ouCfUL2tOm7LY19UuFv+TfZTfs7YgnQ5hoajA3
	emlAE4kNp8+Xf/ZGgAKIlPEUIDSH87kQVtAMWXZJ2Noyqdgz8BSiA9RRCxYR2WY4niLOUEM67wk
	wJI3UTFPfxyhD0oHaOzp0csQWNirtzwVuO4/bhVAr8Ks6AYqI5Hjo7+YllsBZnZI8gG7dZAVlY9
	Fw6OeuGp9beD8iKCu8
X-Received: by 2002:a05:6a21:6005:b0:3c0:9c19:65c0 with SMTP id adf61e73a8af0-3c67e05d5fdmr5626037637.72.1785095851710;
        Sun, 26 Jul 2026 12:57:31 -0700 (PDT)
Received: from fedora.tail0f6912.ts.net ([117.213.200.4])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-13d130f42bbsm52391516c88.14.2026.07.26.12.57.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Jul 2026 12:57:31 -0700 (PDT)
From: Hardik Kumar <hardikxk@gmail.com>
To: git@vger.kernel.org
Cc: l.s.r@web.de,
	pabloosabaterr@gmail.com,
	Hardik Kumar <hardikxk@gmail.com>
Subject: [PATCH v2] utf8: use size_t for string width methods and callee sites.
Date: Mon, 27 Jul 2026 01:27:18 +0530
Message-ID: <20260726195718.1914131-1-hardikxk@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <DK8L6JM14UNS.16B15DIOFW1K5@gmail.com>
References: <DK8L6JM14UNS.16B15DIOFW1K5@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

utf8_strwidth() and utf8_strnwidth() return int, even though the
return value is always non-negative:

- utf8_strnwidth() accumulates the width into a size_t and otherwise
  returns its size_t len parameter,
- utf8_strwidth() just forwards its result.

Change their signatures to return size_t instead.

Update the types of the variables the said method is used to avoid
potential UB caused by implicit conversion from size_t to int.

The returned values from `utf8_strwidth()` are casted to int at places
where it was falling tests or required other changes.

Signed-off-by: Hardik Kumar <hardikxk@gmail.com>
---
Changes in v2:
- reworked types for utf8_strwidth and its sites of usage.
- removed redundant parens around `string`.
- updated commit message for better explaining the patch.

 builtin/blame.c  |  4 ++--
 builtin/branch.c |  2 +-
 builtin/repo.c   | 10 +++++-----
 column.c         |  2 +-
 diff.c           |  7 ++++---
 gettext.c        |  2 +-
 gettext.h        |  2 +-
 pretty.c         |  5 +++--
 utf8.c           | 13 ++++---------
 utf8.h           |  4 ++--
 wt-status.c      |  8 ++++----
 11 files changed, 28 insertions(+), 31 deletions(-)

diff --git a/builtin/blame.c b/builtin/blame.c
index 48d5251..2d24b63 100644
--- a/builtin/blame.c
+++ b/builtin/blame.c
@@ -564,7 +564,7 @@ static void emit_other(struct blame_scoreboard *sb, struct blame_entry *ent,
 					name = ci.author_mail.buf;
 				else
 					name = ci.author.buf;
-				pad = longest_author - utf8_strwidth(name);
+				pad = longest_author - cast_size_t_to_int(utf8_strwidth(name));
 				printf(" (%s%*s %10s",
 				       name, pad, "",
 				       format_time(ci.author_time,
@@ -668,7 +668,7 @@ static void find_alignment(struct blame_scoreboard *sb, int *option)
 
 	for (e = sb->ent; e; e = e->next) {
 		struct blame_origin *suspect = e->suspect;
-		int num;
+		size_t num;
 		size_t marks_count = count_marks(e, *option);
 
 		if (max_marks_count < marks_count)
diff --git a/builtin/branch.c b/builtin/branch.c
index dede60d..514ba64 100644
--- a/builtin/branch.c
+++ b/builtin/branch.c
@@ -354,7 +354,7 @@ static int calc_maxwidth(struct ref_array *refs, int remote_bonus)
 	for (i = 0; i < refs->nr; i++) {
 		struct ref_array_item *it = refs->items[i];
 		const char *desc = it->refname;
-		int w;
+		size_t w;
 
 		skip_prefix(it->refname, "refs/heads/", &desc);
 		skip_prefix(it->refname, "refs/remotes/", &desc);
diff --git a/builtin/repo.c b/builtin/repo.c
index 84e012f..47b9191 100644
--- a/builtin/repo.c
+++ b/builtin/repo.c
@@ -367,7 +367,7 @@ static void stats_table_vaddf(struct stats_table *table,
 	struct strbuf buf = STRBUF_INIT;
 	struct string_list_item *item;
 	char *formatted_name;
-	int name_width;
+	size_t name_width;
 
 	strbuf_vaddf(&buf, format, ap);
 	formatted_name = strbuf_detach(&buf, NULL);
@@ -387,12 +387,12 @@ static void stats_table_vaddf(struct stats_table *table,
 		string_list_append_nodup(&table->annotations, strbuf_detach(&buf, NULL));
 	}
 	if (entry->value) {
-		int value_width = utf8_strwidth(entry->value);
+		size_t value_width = utf8_strwidth(entry->value);
 		if (value_width > table->value_col_width)
 			table->value_col_width = value_width;
 	}
 	if (entry->unit) {
-		int unit_width = utf8_strwidth(entry->unit);
+		size_t unit_width = utf8_strwidth(entry->unit);
 		if (unit_width > table->unit_col_width)
 			table->unit_col_width = unit_width;
 	}
@@ -582,8 +582,8 @@ static void stats_table_print_structure(const struct stats_table *table)
 {
 	const char *name_col_title = _("Repository structure");
 	const char *value_col_title = _("Value");
-	int title_name_width = utf8_strwidth(name_col_title);
-	int title_value_width = utf8_strwidth(value_col_title);
+	size_t title_name_width = utf8_strwidth(name_col_title);
+	size_t title_value_width = utf8_strwidth(value_col_title);
 	int name_col_width = table->name_col_width;
 	int value_col_width = table->value_col_width;
 	int unit_col_width = table->unit_col_width;
diff --git a/column.c b/column.c
index 93fae31..6b7f921 100644
--- a/column.c
+++ b/column.c
@@ -24,7 +24,7 @@ struct column_data {
 };
 
 /* return length of 's' in letters, ANSI escapes stripped */
-static int item_length(const char *s)
+static size_t item_length(const char *s)
 {
 	return utf8_strnwidth(s, strlen(s), 1);
 }
diff --git a/diff.c b/diff.c
index 589c196..4887958 100644
--- a/diff.c
+++ b/diff.c
@@ -2952,7 +2952,8 @@ static int utf8_ish_width(const char **start)
 
 static void show_stats(struct diffstat_t *data, struct diff_options *options)
 {
-	int i, len, add, del, adds = 0, dels = 0;
+	int i, add, del, adds = 0, dels = 0;
+	size_t len;
 	uintmax_t max_change = 0, max_len = 0;
 	int total_files = data->nr, count;
 	int width, name_width, graph_width, number_width = 0, bin_width = 0;
@@ -3037,7 +3038,7 @@ static void show_stats(struct diffstat_t *data, struct diff_options *options)
 	 * making the line longer than the maximum width.
 	 */
 	if (options->stat_width == -1)
-		width = term_columns() - utf8_strnwidth(line_prefix, strlen(line_prefix), 1);
+		width = term_columns() - cast_size_t_to_int(utf8_strnwidth(line_prefix, strlen(line_prefix), 1));
 	else
 		width = options->stat_width ? options->stat_width : 80;
 	number_width = decimal_width(max_change) > number_width ?
@@ -3123,7 +3124,7 @@ static void show_stats(struct diffstat_t *data, struct diff_options *options)
 			if (slash)
 				name = slash;
 		}
-		padding = len - utf8_strwidth(name);
+		padding = len - cast_size_t_to_int(utf8_strwidth(name));
 		if (padding < 0)
 			padding = 0;
 
diff --git a/gettext.c b/gettext.c
index 8d08a61..4d5d05e 100644
--- a/gettext.c
+++ b/gettext.c
@@ -129,7 +129,7 @@ void git_setup_gettext(void)
 }
 
 /* return the number of columns of string 's' in current locale */
-int gettext_width(const char *s)
+size_t gettext_width(const char *s)
 {
 	static int is_utf8 = -1;
 	if (is_utf8 == -1)
diff --git a/gettext.h b/gettext.h
index 484cafa..f161a21 100644
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
index d8a9f37..f7d392d 100644
--- a/pretty.c
+++ b/pretty.c
@@ -1805,11 +1805,12 @@ static size_t format_and_pad_commit(struct strbuf *sb, /* in UTF-8 */
 {
 	struct strbuf local_sb = STRBUF_INIT;
 	size_t total_consumed = 0;
-	int len, padding = c->padding;
+	int padding = c->padding;
+	size_t len;
 
 	if (padding < 0) {
 		const char *start = strrchr(sb->buf, '\n');
-		int occupied;
+		size_t occupied;
 		if (!start)
 			start = sb->buf;
 		occupied = utf8_strnwidth(start, strlen(start), 1);
diff --git a/utf8.c b/utf8.c
index 96460cc..cefaefe 100644
--- a/utf8.c
+++ b/utf8.c
@@ -208,7 +208,7 @@ int utf8_width(const char **start, size_t *remainder_p)
  * string, assuming that the string is utf8.  Returns strlen() instead
  * if the string does not look like a valid utf8 string.
  */
-int utf8_strnwidth(const char *string, size_t len, int skip_ansi)
+size_t utf8_strnwidth(const char *string, size_t len, int skip_ansi)
 {
 	const char *orig = string;
 	size_t width = 0;
@@ -225,15 +225,10 @@ int utf8_strnwidth(const char *string, size_t len, int skip_ansi)
 		if (glyph_width > 0)
 			width += glyph_width;
 	}
-
-	/*
-	 * TODO: fix the interface of this function and `utf8_strwidth()` to
-	 * return `size_t` instead of `int`.
-	 */
-	return cast_size_t_to_int(string ? width : len);
+	return string ? width : len;
 }
 
-int utf8_strwidth(const char *string)
+size_t utf8_strwidth(const char *string)
 {
 	return utf8_strnwidth(string, strlen(string), 0);
 }
@@ -821,7 +816,7 @@ void strbuf_utf8_align(struct strbuf *buf, align_type position, unsigned int wid
 		       const char *s)
 {
 	size_t slen = strlen(s);
-	int display_len = utf8_strnwidth(s, slen, 0);
+	size_t display_len = utf8_strnwidth(s, slen, 0);
 	int utf8_compensation = slen - display_len;
 
 	if (display_len >= width) {
diff --git a/utf8.h b/utf8.h
index cf8ecb0..531e968 100644
--- a/utf8.h
+++ b/utf8.h
@@ -7,8 +7,8 @@ typedef unsigned int ucs_char_t;  /* assuming 32bit int */
 
 size_t display_mode_esc_sequence_len(const char *s);
 int utf8_width(const char **start, size_t *remainder_p);
-int utf8_strnwidth(const char *string, size_t len, int skip_ansi);
-int utf8_strwidth(const char *string);
+size_t utf8_strnwidth(const char *string, size_t len, int skip_ansi);
+size_t utf8_strwidth(const char *string);
 int is_utf8(const char *text);
 int is_encoding_utf8(const char *name);
 int same_encoding(const char *, const char *);
diff --git a/wt-status.c b/wt-status.c
index 58461e0..0e1e32d 100644
--- a/wt-status.c
+++ b/wt-status.c
@@ -331,9 +331,9 @@ static int maxwidth(const char *(*label)(int), int minval, int maxval)
 
 	for (i = minval; i <= maxval; i++) {
 		const char *s = label(i);
-		int len = s ? utf8_strwidth(s) : 0;
+		size_t len = s ? utf8_strwidth(s) : 0;
 		if (len > result)
-			result = len;
+			result = cast_size_t_to_int(len);
 	}
 	return result;
 }
@@ -360,7 +360,7 @@ static void wt_longstatus_print_unmerged_data(struct wt_status *s,
 	status_printf(s, color(WT_STATUS_HEADER, s), "\t");
 
 	how = wt_status_unmerged_status_string(d->stagemask);
-	len = label_width - utf8_strwidth(how);
+	len = label_width - cast_size_t_to_int(utf8_strwidth(how));
 	status_printf_more(s, c, "%s%.*s%s\n", how, len, padding, one);
 	strbuf_release(&onebuf);
 }
@@ -429,7 +429,7 @@ static void wt_longstatus_print_change_data(struct wt_status *s,
 	what = wt_status_diff_status_string(status);
 	if (!what)
 		BUG("unhandled diff status %c", status);
-	len = label_width - utf8_strwidth(what);
+	len = label_width - cast_size_t_to_int(utf8_strwidth(what));
 	assert(len >= 0);
 	if (one_name != two_name)
 		status_printf_more(s, c, "%s%.*s%s -> %s",
-- 
2.55.0

