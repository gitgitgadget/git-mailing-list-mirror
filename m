Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A567614B08C
	for <git@vger.kernel.org>; Tue, 10 Sep 2024 02:29:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725935354; cv=none; b=o+Mpw4llwb1FepYJ6XZmwEeozwkB8aNc7G/aiQFua8vp3gMOUOmqpvRQJwoOnmWzDQSG5xR+kuTvGgL5NA9D16xVf11JTy0XjmHeCPRsnqTvNmTqC/sC5dkrUjVsyK65Cst/AIp4aZetpijOvS4lL0yycIeMbwTPMr8dMmGJAQE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725935354; c=relaxed/simple;
	bh=fpbnCbN3CgaANU2dyeExRT1HiGxuhgu2xpyYmuEnQCQ=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=XzZ5PmHznh1n9ehVfwbwp5cu9+abtgDnzI4tpQ4Byd1vnIk94owQI6eDYMsgl07L6QJr3fgZVk6P73vd+p9UmUDxiZ5OHC/kNUg1qHf/5ef3M5xmlFO1eRwrR2WW6lq/ssqUVr6z/0MdnjXziVYKoH903RXFdliTqtjOrhFVSbY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=k+aQoUfF; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k+aQoUfF"
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-5c3cdbe4728so4968889a12.2
        for <git@vger.kernel.org>; Mon, 09 Sep 2024 19:29:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725935350; x=1726540150; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OxibNVfaacDMWZrY5jLbaQv9IP94XIEeA7Z2qrkWvho=;
        b=k+aQoUfFTnA6m7le36QSBxrtFCiqbWIlqfNG3RHopUIOVy6ZiPzRE19VxFWPcgNLQs
         dny59LwBroX+i3DiWAhsIKZuFwJx8NB9Vqk/a06C6+vQ4RvgcSx16p49n2Z2aCJsZu6o
         Jhw9BQtKiVcvEKZUqh255aCO51upeKDH8huOMtjbygv9pJt2jPsHuqv2kNMoU3X1nnT0
         VSzq3v5eJl00D/u57yCSlGDn6sC4vPLSOvM4a52Okj8iSdUBm2tju+ORdmIdxhNg1wLX
         RJelPTrezk3Z02dhoYDtAw/2LbpaRhhGq18HJNiUaND2UKUFlsqac0PcO1b92ifVjBen
         g+Jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725935350; x=1726540150;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OxibNVfaacDMWZrY5jLbaQv9IP94XIEeA7Z2qrkWvho=;
        b=ouVqaI1+MQfUZSdGa7cJCkB1e9KDgzB2rd05qsa446/5PynioOuu6cPt28gD4Rl4HJ
         P3faN2RIzYUz6x0jB0OYF72tqs2AJf7HfveWkiCR23Oi6whzYdqMCSc627FNO0r97B0o
         8wPcHSLLC9JQp2/fMF9fXyPSwXMCm5UcxVhxw9fYB7MbnvHXrMgenYPupSd1NX5wQeiB
         sSMSU0Z1ydVK2hJJUhE93UCdujj35gHW+nnleqgnjH8YGrwqL6LF6PAswjA78J375wMJ
         SCSkurNftd0pgWB/zgXRXhW5CC8aRn2U0Xh7fkO9s70vrc1A2mYQ4eK+3dsSwx3VAOop
         1AxQ==
X-Gm-Message-State: AOJu0YwSEGbGAKuDKTbSBj32nINsQW3Rn9G7lOIWFz8iTaymtTpxaoKr
	UenF9VfRVSw011V4GYDIvp83eDp3uhI6IVoHpOIVLl/xAho8uuAeB/kMhw==
X-Google-Smtp-Source: AGHT+IFVqhdYyj6tvy6nj2948diZL52/d3rUtm0upCqb5q7j8HS3PQb9kVRF3wX3bQ4ZBGeKFKZDVw==
X-Received: by 2002:a17:907:d2c5:b0:a86:95ff:f3a0 with SMTP id a640c23a62f3a-a8d245139admr650988766b.3.1725935349616;
        Mon, 09 Sep 2024 19:29:09 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a8d25ced17asm420047966b.170.2024.09.09.19.29.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Sep 2024 19:29:09 -0700 (PDT)
Message-Id: <44417cceddcaeec9e90acd0b058edd8c80627479.1725935335.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1786.git.1725935335.gitgitgadget@gmail.com>
References: <pull.1786.git.1725935335.gitgitgadget@gmail.com>
From: "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 10 Sep 2024 02:28:37 +0000
Subject: [PATCH 12/30] survey: start pretty printing data in table form
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
Cc: gitster@pobox.com,
    johannes.schindelin@gmx.de,
    peff@peff.net,
    ps@pks.im,
    me@ttaylorr.com,
    johncai86@gmail.com,
    newren@gmail.com,
    Derrick Stolee <stolee@gmail.com>,
    Derrick Stolee <stolee@gmail.com>

From: Derrick Stolee <stolee@gmail.com>

When 'git survey' provides information to the user, this will be presented
in one of two formats: plaintext and JSON. The JSON implementation will be
delayed until the functionality is complete for the plaintext format.

The most important parts of the plaintext format are headers specifying the
different sections of the report and tables providing concreted data.

Create a custom table data structure that allows specifying a list of
strings for the row values. When printing the table, check each column for
the maximum width so we can create a table of the correct size from the
start.

The table structure is designed to be flexible to the different kinds of
output that will be implemented in future changes.

Signed-off-by: Derrick Stolee <stolee@gmail.com>
---
 builtin/survey.c      | 175 ++++++++++++++++++++++++++++++++++++++++++
 t/t8100-git-survey.sh |  17 +++-
 2 files changed, 191 insertions(+), 1 deletion(-)

diff --git a/builtin/survey.c b/builtin/survey.c
index 1b4fe591e59..b2104e84d61 100644
--- a/builtin/survey.c
+++ b/builtin/survey.c
@@ -5,6 +5,7 @@
 #include "parse-options.h"
 #include "progress.h"
 #include "ref-filter.h"
+#include "strbuf.h"
 #include "strvec.h"
 #include "trace2.h"
 
@@ -27,10 +28,16 @@ static struct survey_refs_wanted default_ref_options = {
 	.want_all_refs = 1,
 };
 
+enum survey_format {
+	SURVEY_PLAINTEXT = 0,
+	SURVEY_JSON = 1,
+};
+
 struct survey_opts {
 	int verbose;
 	int show_progress;
 	struct survey_refs_wanted refs;
+	enum survey_format format;
 };
 
 struct survey_report_ref_summary {
@@ -78,6 +85,161 @@ static void clear_survey_context(struct survey_context *ctx)
 	strvec_clear(&ctx->refs);
 }
 
+struct survey_table {
+	const char *table_name;
+	struct strvec header;
+	struct strvec *rows;
+	size_t rows_nr;
+	size_t rows_alloc;
+};
+
+#define SURVEY_TABLE_INIT {	\
+	.header = STRVEC_INIT,	\
+}
+
+static void clear_table(struct survey_table *table)
+{
+	strvec_clear(&table->header);
+	for (size_t i = 0; i < table->rows_nr; i++)
+		strvec_clear(&table->rows[i]);
+	free(table->rows);
+}
+
+static void insert_table_rowv(struct survey_table *table, ...)
+{
+	va_list ap;
+	char *arg;
+	ALLOC_GROW(table->rows, table->rows_nr + 1, table->rows_alloc);
+
+	memset(&table->rows[table->rows_nr], 0, sizeof(struct strvec));
+
+	va_start(ap, table);
+	while ((arg = va_arg(ap, char *)))
+		strvec_push(&table->rows[table->rows_nr], arg);
+	va_end(ap);
+
+	table->rows_nr++;
+}
+
+static void print_table_title(const char *name, size_t *widths, size_t nr)
+{
+	static struct strbuf lines = STRBUF_INIT;
+	size_t width = 0;
+	strbuf_setlen(&lines, 0);
+
+	strbuf_addch(&lines, ' ');
+	strbuf_addstr(&lines, name);
+	strbuf_addch(&lines, '\n');
+
+	for (size_t i = 0; i < nr; i++) {
+		if (i)
+			width += 3;
+		width += widths[i];
+	}
+	strbuf_addchars(&lines, '=', width);
+	printf("%s\n", lines.buf);
+}
+
+static void print_row_plaintext(struct strvec *row, size_t *widths)
+{
+	static struct strbuf line = STRBUF_INIT;
+	strbuf_setlen(&line, 0);
+
+	for (size_t i = 0; i < row->nr; i++) {
+		const char *str = row->v[i];
+		size_t len = strlen(str);
+		if (i)
+			strbuf_add(&line, " | ", 3);
+		strbuf_addchars(&line, ' ', widths[i] - len);
+		strbuf_add(&line, str, len);
+	}
+	printf("%s\n", line.buf);
+}
+
+static void print_divider_plaintext(size_t *widths, size_t nr)
+{
+	static struct strbuf line = STRBUF_INIT;
+	strbuf_setlen(&line, 0);
+
+	for (size_t i = 0; i < nr; i++) {
+		if (i)
+			strbuf_add(&line, "-+-", 3);
+		strbuf_addchars(&line, '-', widths[i]);
+	}
+	printf("%s\n", line.buf);
+}
+
+static void print_table_plaintext(struct survey_table *table)
+{
+	size_t *column_widths;
+	size_t columns_nr = table->header.nr;
+	CALLOC_ARRAY(column_widths, columns_nr);
+
+	for (size_t i = 0; i < columns_nr; i++) {
+		column_widths[i] = strlen(table->header.v[i]);
+
+		for (size_t j = 0; j < table->rows_nr; j++) {
+			size_t rowlen = strlen(table->rows[j].v[i]);
+			if (column_widths[i] < rowlen)
+				column_widths[i] = rowlen;
+		}
+	}
+
+	print_table_title(table->table_name, column_widths, columns_nr);
+	print_row_plaintext(&table->header, column_widths);
+	print_divider_plaintext(column_widths, columns_nr);
+
+	for (size_t j = 0; j < table->rows_nr; j++)
+		print_row_plaintext(&table->rows[j], column_widths);
+}
+
+static void survey_report_plaintext_refs(struct survey_context *ctx)
+{
+	struct survey_report_ref_summary *refs = &ctx->report.refs;
+	struct survey_table table = SURVEY_TABLE_INIT;
+
+	table.table_name = _("REFERENCES SUMMARY");
+
+	strvec_push(&table.header, _("Ref Type"));
+	strvec_push(&table.header, _("Count"));
+
+	if (ctx->opts.refs.want_all_refs || ctx->opts.refs.want_branches) {
+		char *fmt = xstrfmt("%"PRIuMAX"", refs->branches_nr);
+		insert_table_rowv(&table, _("Branches"), fmt, NULL);
+		free(fmt);
+	}
+
+	if (ctx->opts.refs.want_all_refs || ctx->opts.refs.want_remotes) {
+		char *fmt = xstrfmt("%"PRIuMAX"", refs->remote_refs_nr);
+		insert_table_rowv(&table, _("Remote refs"), fmt, NULL);
+		free(fmt);
+	}
+
+	if (ctx->opts.refs.want_all_refs || ctx->opts.refs.want_tags) {
+		char *fmt = xstrfmt("%"PRIuMAX"", refs->tags_nr);
+		insert_table_rowv(&table, _("Tags (all)"), fmt, NULL);
+		free(fmt);
+		fmt = xstrfmt("%"PRIuMAX"", refs->tags_annotated_nr);
+		insert_table_rowv(&table, _("Tags (annotated)"), fmt, NULL);
+		free(fmt);
+	}
+
+	print_table_plaintext(&table);
+	clear_table(&table);
+}
+
+static void survey_report_plaintext(struct survey_context *ctx)
+{
+	printf("GIT SURVEY for \"%s\"\n", ctx->repo->worktree);
+	printf("-----------------------------------------------------\n");
+	survey_report_plaintext_refs(ctx);
+}
+
+static void survey_report_json(struct survey_context *ctx)
+{
+	/* TODO. */
+}
+
 /*
  * After parsing the command line arguments, figure out which refs we
  * should scan.
@@ -312,6 +474,19 @@ int cmd_survey(int argc, const char **argv, const char *prefix)
 
 	survey_phase_refs(&ctx);
 
+	switch (ctx.opts.format) {
+	case SURVEY_PLAINTEXT:
+		survey_report_plaintext(&ctx);
+		break;
+
+	case SURVEY_JSON:
+		survey_report_json(&ctx);
+		break;
+
+	default:
+		BUG("Undefined format");
+	}
+
 	clear_survey_context(&ctx);
 	return 0;
 }
diff --git a/t/t8100-git-survey.sh b/t/t8100-git-survey.sh
index 5903c90cb57..a57f6ca7a59 100755
--- a/t/t8100-git-survey.sh
+++ b/t/t8100-git-survey.sh
@@ -21,7 +21,22 @@ test_expect_success 'creat a semi-interesting repo' '
 
 test_expect_success 'git survey (default)' '
 	git survey >out 2>err &&
-	test_line_count = 0 err
+	test_line_count = 0 err &&
+
+	cat >expect <<-EOF &&
+	GIT SURVEY for "$(pwd)"
+	-----------------------------------------------------
+	 REFERENCES SUMMARY
+	========================
+	        Ref Type | Count
+	-----------------+------
+	        Branches |     1
+	     Remote refs |     0
+	      Tags (all) |     0
+	Tags (annotated) |     0
+	EOF
+
+	test_cmp expect out
 '
 
 test_done
-- 
gitgitgadget

