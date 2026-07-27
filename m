Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED28C3BF682
	for <git@vger.kernel.org>; Mon, 27 Jul 2026 06:59:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785135566; cv=none; b=M1JtQUsq+ZUfJWdnw2LW/+NwBNCYDNL4EwYFI9iZtyzshDAVai28LcMaHXIu3jJpBtxONx9BE5WmFvHyAodOhHzcvnAclRfyvEt9XOu9yJoMbP0zgHM3k6pturUIn0xmEjvaEpB72aArjn30aRQjhJ/6ic7hmHaLt9lbeRGRVl4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785135566; c=relaxed/simple;
	bh=bHrbA0JElKExzHxGDIbzzyl0WS1lpz+d+4EzTAtyPjQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XCY8UVZSFTgUGe+lPNgP2/H3IWHdRSMOF7ZDjsGqScgCQr1xc/CCRMguNrjbCPAX5qbZml3dkGrcbeK0h6Xvu2C77Np531xd2wQEeiUn2WgH9gW79UBoEwfBistB+xICdZc01Af8QWA5+a0OffiCaJ7wLLpjGzqJ6l0eX1XG4nE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=N4uR1Vq0; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N4uR1Vq0"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2cace91f112so24814215ad.0
        for <git@vger.kernel.org>; Sun, 26 Jul 2026 23:59:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785135564; x=1785740364; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=3uLXbCAShwK5+n+PlwTosxRNkqlAFFHRazcP5L5mSUE=;
        b=N4uR1Vq0QQKUzcK3setNJD6fffXT3j+M1gu/UtLP2Ig5UW2fI6ePwdElEjr5397Mrb
         YCUIJPFOOimj4AfcMeN7BeGXvWD5jiXVkJTxxLnFZHfIPzDbPhTgWbL2EXeEdiAUxSvD
         wUNGXWRAi+VueVyZ9++bL/FZMoGGsI1g+SDjI9weE4zleL9RdESJ1Fl84LlEZOxSjjlV
         pYWW6EVRUrtGkDLC/s1DZGIyhhKojfGwEPpFv+idxLuwUTdteglr2Rl2XGstrrWQCFDn
         2jTjCKgXKPHjWf9oeOz3vitngACPY3LqX4i/nadlEmulZKolzPSe4pVk8edZy4/PF50N
         eVvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785135564; x=1785740364;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=3uLXbCAShwK5+n+PlwTosxRNkqlAFFHRazcP5L5mSUE=;
        b=mPeM1tmeh7rrSpicvVItEXkuVzI0HykezJUmHHffKVe0ZaZ5STYg5mMAP5201L0zZl
         J8jC8z8ThWfDTlX5Ffq029/Rm7nq5a4lU2zk/3gHY1wRh0Qc0vZBKwEU6tteZHQr7zsG
         G5Me5FyB8KNvIagOOIM9y5QVcrnH26PtngA9NJ8irR9XRPh1I43wrSWowSRn6hzcslIo
         IEvNk7QidDA684q0QEbl4JDw3D1e3i2CHgbG1zr4yRKciMn/zzEGwRASDYeeDoD+iXg0
         GIvf/L8jC4iP2SW2qK8cuTttNTL0F2nkbdG9Z71xAKP0bPHjiNm1rnEU6A+Dn6r2nMc5
         2Y8Q==
X-Gm-Message-State: AOJu0YwmkkAqXnyzqEzJNA+4m8DuG3RSx797FLi4N3o5cO+awIwMQOu1
	FyXURDv7IWq0bnYUnManIgnM3aN3XikgGpBYKy2t9eOuDpG9obcuWBykaq+aypPn
X-Gm-Gg: AR+sD11YIBTleWxHRryrs9su7KeTkoyiOx6hPf1hArpegNGJLyUs3qImcCYCkUo1bwi
	0CVAIyXOu3uizGF3UV/Z0hPTV0lZmGKDjhP+sk/oIiExpd8TVeJ14LiGhaYZIlz5i2W9OO2IWAc
	g7JJbVFYvpbQmXuQ7yUJGSQmZxQm01bSNw+bjlWGvwcPm0S0CsiwT7j41siTaa7PcKU+2tSdF89
	ham+bJBwKLiVCahaxh9xfwetir3Cv+PWyLJQkCZYRnD42WlMjiZ5sIravoqWW9BohffwEZDVhsu
	BlO8Jra1IMN0qy15isEtjfP98ROZvAOmp+kdzwmt+K6I2Uc3jol5cCtDO+ljE4Fuy5V0gtzobT0
	FcgOzhg2LjuoU78qD6EkWU6kkXS2dPRiDvuipkRmOoow9ZVY81F5a1bCLPZghcKukDvBuyb1nzL
	VsMb7sDWLtTM0XYVXHOU0=
X-Received: by 2002:a05:6a20:7486:b0:3bf:b68f:4685 with SMTP id adf61e73a8af0-3c67d9d5751mr7344666637.23.1785135563921;
        Sun, 26 Jul 2026 23:59:23 -0700 (PDT)
Received: from fedora.tail0f6912.ts.net ([112.133.220.140])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-314bc447f6bsm32122656eec.12.2026.07.26.23.59.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Jul 2026 23:59:23 -0700 (PDT)
From: Hardik Kumar <hardikxk@gmail.com>
To: git@vger.kernel.org
Cc: Hardik Kumar <hardikxk@gmail.com>
Subject: [PATCH v3] utf8: make utf8_strwidth() and utf8_strnwidth() return size_t
Date: Mon, 27 Jul 2026 12:29:17 +0530
Message-ID: <20260727065917.469738-1-hardikxk@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260726123427.173877-1-hardikxk@gmail.com>
References: <20260726123427.173877-1-hardikxk@gmail.com>
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
  returns its size_t len parameter.
- utf8_strwidth() just forwards its result.

Change their signatures to return size_t instead.

Update the types of the variables where these method is used to avoid
implicit conversion from size_t to int.

The return values from `utf8_strwidth()` are cast to int where
negative values are expected or depend on other int variables.

Signed-off-by: Hardik Kumar <hardikxk@gmail.com>
---
 builtin/blame.c |  6 +++---
 builtin/fetch.c |  2 +-
 builtin/repo.c  | 10 +++++-----
 column.c        |  2 +-
 diff.c          |  8 ++++----
 gettext.c       |  2 +-
 gettext.h       |  2 +-
 pretty.c        |  4 ++--
 utf8.c          | 13 ++++---------
 utf8.h          |  4 ++--
 wt-status.c     | 10 +++++-----
 11 files changed, 29 insertions(+), 34 deletions(-)

diff --git a/builtin/blame.c b/builtin/blame.c
index 48d5251..83e4dd6 100644
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
@@ -685,9 +685,9 @@ static void find_alignment(struct blame_scoreboard *sb, int *option)
 			suspect->commit->object.flags |= METAINFO_SHOWN;
 			get_commit_info(suspect->commit, &ci);
 			if (*option & OUTPUT_SHOW_EMAIL)
-				num = utf8_strwidth(ci.author_mail.buf);
+				num = cast_size_t_to_int(utf8_strwidth(ci.author_mail.buf));
 			else
-				num = utf8_strwidth(ci.author.buf);
+				num = cast_size_t_to_int(utf8_strwidth(ci.author.buf));
 			if (longest_author < num)
 				longest_author = num;
 			commit_info_destroy(&ci);
diff --git a/builtin/fetch.c b/builtin/fetch.c
index 775a797..c4ae95f 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -850,7 +850,7 @@ static void display_ref_update(struct display_state *display_state, char code,
 			display_state->shown_url = 1;
 		}
 
-		width = (summary_width + strlen(summary) - gettext_width(summary));
+		width = (summary_width + strlen(summary) - cast_size_t_to_int(gettext_width(summary)));
 		remote = prettify_refname(remote);
 		local = prettify_refname(local);
 
diff --git a/builtin/repo.c b/builtin/repo.c
index 84e012f..9c7ad8c 100644
--- a/builtin/repo.c
+++ b/builtin/repo.c
@@ -371,7 +371,7 @@ static void stats_table_vaddf(struct stats_table *table,
 
 	strbuf_vaddf(&buf, format, ap);
 	formatted_name = strbuf_detach(&buf, NULL);
-	name_width = utf8_strwidth(formatted_name);
+	name_width = cast_size_t_to_int(utf8_strwidth(formatted_name));
 
 	item = string_list_append_nodup(&table->rows, formatted_name);
 	item->util = entry;
@@ -387,12 +387,12 @@ static void stats_table_vaddf(struct stats_table *table,
 		string_list_append_nodup(&table->annotations, strbuf_detach(&buf, NULL));
 	}
 	if (entry->value) {
-		int value_width = utf8_strwidth(entry->value);
+		int value_width = cast_size_t_to_int(utf8_strwidth(entry->value));
 		if (value_width > table->value_col_width)
 			table->value_col_width = value_width;
 	}
 	if (entry->unit) {
-		int unit_width = utf8_strwidth(entry->unit);
+		int unit_width = cast_size_t_to_int(utf8_strwidth(entry->unit));
 		if (unit_width > table->unit_col_width)
 			table->unit_col_width = unit_width;
 	}
@@ -582,8 +582,8 @@ static void stats_table_print_structure(const struct stats_table *table)
 {
 	const char *name_col_title = _("Repository structure");
 	const char *value_col_title = _("Value");
-	int title_name_width = utf8_strwidth(name_col_title);
-	int title_value_width = utf8_strwidth(value_col_title);
+	int title_name_width = cast_size_t_to_int(utf8_strwidth(name_col_title));
+	int title_value_width = cast_size_t_to_int(utf8_strwidth(value_col_title));
 	int name_col_width = table->name_col_width;
 	int value_col_width = table->value_col_width;
 	int unit_col_width = table->unit_col_width;
diff --git a/column.c b/column.c
index 93fae31..a63d040 100644
--- a/column.c
+++ b/column.c
@@ -26,7 +26,7 @@ struct column_data {
 /* return length of 's' in letters, ANSI escapes stripped */
 static int item_length(const char *s)
 {
-	return utf8_strnwidth(s, strlen(s), 1);
+	return cast_size_t_to_int(utf8_strnwidth(s, strlen(s), 1));
 }
 
 /*
diff --git a/diff.c b/diff.c
index 589c196..205fedf 100644
--- a/diff.c
+++ b/diff.c
@@ -2982,7 +2982,7 @@ static void show_stats(struct diffstat_t *data, struct diff_options *options)
 			continue;
 		}
 		fill_print_name(file);
-		len = utf8_strwidth(file->print_name);
+		len = cast_size_t_to_int(utf8_strwidth(file->print_name));
 		if (max_len < len)
 			max_len = len;
 
@@ -3037,7 +3037,7 @@ static void show_stats(struct diffstat_t *data, struct diff_options *options)
 	 * making the line longer than the maximum width.
 	 */
 	if (options->stat_width == -1)
-		width = term_columns() - utf8_strnwidth(line_prefix, strlen(line_prefix), 1);
+		width = term_columns() - cast_size_t_to_int(utf8_strnwidth(line_prefix, strlen(line_prefix), 1));
 	else
 		width = options->stat_width ? options->stat_width : 80;
 	number_width = decimal_width(max_change) > number_width ?
@@ -3108,7 +3108,7 @@ static void show_stats(struct diffstat_t *data, struct diff_options *options)
 		 * "scale" the filename
 		 */
 		len = name_width;
-		name_len = utf8_strwidth(name);
+		name_len = cast_size_t_to_int(utf8_strwidth(name));
 		if (name_width < name_len) {
 			char *slash;
 			prefix = "...";
@@ -3123,7 +3123,7 @@ static void show_stats(struct diffstat_t *data, struct diff_options *options)
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
index d8a9f37..83d4e86 100644
--- a/pretty.c
+++ b/pretty.c
@@ -1809,7 +1809,7 @@ static size_t format_and_pad_commit(struct strbuf *sb, /* in UTF-8 */
 
 	if (padding < 0) {
 		const char *start = strrchr(sb->buf, '\n');
-		int occupied;
+		size_t occupied;
 		if (!start)
 			start = sb->buf;
 		occupied = utf8_strnwidth(start, strlen(start), 1);
@@ -1830,7 +1830,7 @@ static size_t format_and_pad_commit(struct strbuf *sb, /* in UTF-8 */
 		placeholder++;
 		total_consumed++;
 	}
-	len = utf8_strnwidth(local_sb.buf, local_sb.len, 1);
+	len = cast_size_t_to_int(utf8_strnwidth(local_sb.buf, local_sb.len, 1));
 
 	if (c->flush_type == flush_left_and_steal) {
 		const char *ch = sb->buf + sb->len - 1;
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
index 58461e0..672f83b 100644
--- a/wt-status.c
+++ b/wt-status.c
@@ -325,13 +325,13 @@ static const char *wt_status_diff_status_string(int status)
 	}
 }
 
-static int maxwidth(const char *(*label)(int), int minval, int maxval)
+static size_t maxwidth(const char *(*label)(int), int minval, int maxval)
 {
 	int result = 0, i;
 
 	for (i = minval; i <= maxval; i++) {
 		const char *s = label(i);
-		int len = s ? utf8_strwidth(s) : 0;
+		size_t len = s ? utf8_strwidth(s) : 0;
 		if (len > result)
 			result = len;
 	}
@@ -345,7 +345,7 @@ static void wt_longstatus_print_unmerged_data(struct wt_status *s,
 	struct wt_status_change_data *d = it->util;
 	struct strbuf onebuf = STRBUF_INIT;
 	static char *padding;
-	static int label_width;
+	static size_t label_width;
 	const char *one, *how;
 	int len;
 
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

base-commit: 9a0c4701dcd5725c4184599322b52933ff5005ca
-- 
2.55.0

