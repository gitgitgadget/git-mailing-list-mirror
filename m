Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 716124688
	for <git@vger.kernel.org>; Tue,  7 Nov 2023 01:26:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Uv8bkQfU"
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A14F103
	for <git@vger.kernel.org>; Mon,  6 Nov 2023 17:26:11 -0800 (PST)
Received: by mail-lj1-x235.google.com with SMTP id 38308e7fff4ca-2c501bd6ff1so72531801fa.3
        for <git@vger.kernel.org>; Mon, 06 Nov 2023 17:26:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699320369; x=1699925169; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=y09QspDXVPmlBRm1qFdY7UtSS881c75ebgMZNDaEc1c=;
        b=Uv8bkQfUW5tB6eRyLyb5PMLg2lYqKzMpGOija5KmzWo8kft2DfqlXHTrQahWI1mRsq
         9nFrG5RMox7rUG8gqWCRb7e13tGZAZdEozaygpO1qQSM7L6WxNdUpLis39MvQZUfNSX0
         gEprmLXm41FMx4gkaUZmSQxZbc+KWW/5L5EQgGi+rte5Trk0QhBz4aBlmrFiDKmvmSNd
         878YZ2CsUWBmbaetxbNtlE04VNZ+THwoHK4BmWSpghJi+beDywjx4fTXxerKpHpU+6fw
         KuLdIDekOx9Y0c7uqjjnaQvA0Ex8wPgWty7yuyxazskG2WMfXqF/C2s2IuGv0bCBaaN4
         Xhvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699320369; x=1699925169;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=y09QspDXVPmlBRm1qFdY7UtSS881c75ebgMZNDaEc1c=;
        b=Z2Ddk+0YuBUe6DXRfVh/qP5eLz/rF3qcwqjieSSeDeqkNWjQz7iUfXxO3jToxQbdw8
         eV1zhGwRVc5jkojqolt7Gir07q1hLGGODEYC5gx3Y6h/uZtJEUdkMVlzzWo8PmvQslXw
         BiR36ow4SIAyKGqHFe9b8LTfv0WjYK0JBYZ0DircCjQ3nCtCXN8WYCWcPjtwKmOVTVko
         6qpR6W4YjZAJeRm70+lCHJWlERS2Ohxb7lGPWIZ0H5BNFs50fPlnfEg+sK1JB8A2xcbZ
         nnF8L8C7CaIU96CJo+HxFwY0irYla7suc8p7G7jZsJNdwIIDLs2AghPTJRN9bv8e865I
         3DNg==
X-Gm-Message-State: AOJu0Yz+SmkDDBkoQ3a8XU7i7BSBVVzVsmTYHhXrQcTtEzg4HmqGT4F9
	HGolq0Hb3Guqi+8H78a95ld4zqitYl0=
X-Google-Smtp-Source: AGHT+IF403mRmP3ig1WljJtJpr+UFNGa5sP0mTmFbugB1Ay++xBw1khKNKjV5QJFDmsVuIyPOdbUQQ==
X-Received: by 2002:a2e:b042:0:b0:2bc:bf29:18d3 with SMTP id d2-20020a2eb042000000b002bcbf2918d3mr24216318ljl.31.1699320368848;
        Mon, 06 Nov 2023 17:26:08 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id c17-20020a056000105100b0032d829e10c0sm929530wrx.28.2023.11.06.17.26.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Nov 2023 17:26:07 -0800 (PST)
Message-ID: <f5be57eea7d5b73d4614d2e1816f5cc5b1118a13.1699320362.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1609.git.1699320361.gitgitgadget@gmail.com>
References: <pull.1609.git.1699320361.gitgitgadget@gmail.com>
From: "Victoria Dye via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 07 Nov 2023 01:25:57 +0000
Subject: [PATCH 5/9] ref-filter.h: add functions for filter/format &
 format-only
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
Cc: Victoria Dye <vdye@github.com>,
    Victoria Dye <vdye@github.com>

From: Victoria Dye <vdye@github.com>

Add two new public methods to 'ref-filter.h':

* 'print_formatted_ref_array()' which, given a format specification & array
  of ref items, formats and prints the items to stdout.
* 'filter_and_format_refs()' which combines 'filter_refs()',
  'ref_array_sort()', and 'print_formatted_ref_array()' into a single
  function.

This consolidates much of the code used to filter and format refs in
'builtin/for-each-ref.c', 'builtin/tag.c', and 'builtin/branch.c', reducing
duplication and simplifying the future changes needed to optimize the filter
& format process.

Signed-off-by: Victoria Dye <vdye@github.com>
---
 builtin/branch.c       | 33 +++++++++++++++++----------------
 builtin/for-each-ref.c | 27 +--------------------------
 builtin/tag.c          | 23 +----------------------
 ref-filter.c           | 35 +++++++++++++++++++++++++++++++++++
 ref-filter.h           | 14 ++++++++++++++
 5 files changed, 68 insertions(+), 64 deletions(-)

diff --git a/builtin/branch.c b/builtin/branch.c
index 5a1ec1cd04f..2ed59f16f1c 100644
--- a/builtin/branch.c
+++ b/builtin/branch.c
@@ -437,8 +437,6 @@ static void print_ref_list(struct ref_filter *filter, struct ref_sorting *sortin
 {
 	int i;
 	struct ref_array array;
-	struct strbuf out = STRBUF_INIT;
-	struct strbuf err = STRBUF_INIT;
 	int maxwidth = 0;
 	const char *remote_prefix = "";
 	char *to_free = NULL;
@@ -468,24 +466,27 @@ static void print_ref_list(struct ref_filter *filter, struct ref_sorting *sortin
 	filter_ahead_behind(the_repository, format, &array);
 	ref_array_sort(sorting, &array);
 
-	for (i = 0; i < array.nr; i++) {
-		strbuf_reset(&err);
-		strbuf_reset(&out);
-		if (format_ref_array_item(array.items[i], format, &out, &err))
-			die("%s", err.buf);
-		if (column_active(colopts)) {
-			assert(!filter->verbose && "--column and --verbose are incompatible");
-			 /* format to a string_list to let print_columns() do its job */
+	if (column_active(colopts)) {
+		struct strbuf out = STRBUF_INIT, err = STRBUF_INIT;
+
+		assert(!filter->verbose && "--column and --verbose are incompatible");
+
+		for (i = 0; i < array.nr; i++) {
+			strbuf_reset(&err);
+			strbuf_reset(&out);
+			if (format_ref_array_item(array.items[i], format, &out, &err))
+				die("%s", err.buf);
+
+			/* format to a string_list to let print_columns() do its job */
 			string_list_append(output, out.buf);
-		} else {
-			fwrite(out.buf, 1, out.len, stdout);
-			if (out.len || !format->array_opts.omit_empty)
-				putchar('\n');
 		}
+
+		strbuf_release(&err);
+		strbuf_release(&out);
+	} else {
+		print_formatted_ref_array(&array, format);
 	}
 
-	strbuf_release(&err);
-	strbuf_release(&out);
 	ref_array_clear(&array);
 	free(to_free);
 }
diff --git a/builtin/for-each-ref.c b/builtin/for-each-ref.c
index 881c3ee055f..1c19cd5bd34 100644
--- a/builtin/for-each-ref.c
+++ b/builtin/for-each-ref.c
@@ -19,15 +19,11 @@ static char const * const for_each_ref_usage[] = {
 
 int cmd_for_each_ref(int argc, const char **argv, const char *prefix)
 {
-	int i, total;
 	struct ref_sorting *sorting;
 	struct string_list sorting_options = STRING_LIST_INIT_DUP;
 	int icase = 0;
-	struct ref_array array;
 	struct ref_filter filter = REF_FILTER_INIT;
 	struct ref_format format = REF_FORMAT_INIT;
-	struct strbuf output = STRBUF_INIT;
-	struct strbuf err = STRBUF_INIT;
 	int from_stdin = 0;
 	struct strvec vec = STRVEC_INIT;
 
@@ -61,8 +57,6 @@ int cmd_for_each_ref(int argc, const char **argv, const char *prefix)
 		OPT_END(),
 	};
 
-	memset(&array, 0, sizeof(array));
-
 	format.format = "%(objectname) %(objecttype)\t%(refname)";
 
 	git_config(git_default_config, NULL);
@@ -104,27 +98,8 @@ int cmd_for_each_ref(int argc, const char **argv, const char *prefix)
 	}
 
 	filter.match_as_path = 1;
-	filter_refs(&array, &filter, FILTER_REFS_ALL);
-	filter_ahead_behind(the_repository, &format, &array);
-
-	ref_array_sort(sorting, &array);
-
-	total = format.array_opts.max_count;
-	if (!total || array.nr < total)
-		total = array.nr;
-	for (i = 0; i < total; i++) {
-		strbuf_reset(&err);
-		strbuf_reset(&output);
-		if (format_ref_array_item(array.items[i], &format, &output, &err))
-			die("%s", err.buf);
-		fwrite(output.buf, 1, output.len, stdout);
-		if (output.len || !format.array_opts.omit_empty)
-			putchar('\n');
-	}
+	filter_and_format_refs(&filter, FILTER_REFS_ALL, sorting, &format);
 
-	strbuf_release(&err);
-	strbuf_release(&output);
-	ref_array_clear(&array);
 	ref_filter_clear(&filter);
 	ref_sorting_release(sorting);
 	strvec_clear(&vec);
diff --git a/builtin/tag.c b/builtin/tag.c
index 2d599245d48..2528d499dd8 100644
--- a/builtin/tag.c
+++ b/builtin/tag.c
@@ -48,13 +48,7 @@ static int config_sign_tag = -1; /* unspecified */
 static int list_tags(struct ref_filter *filter, struct ref_sorting *sorting,
 		     struct ref_format *format)
 {
-	struct ref_array array;
-	struct strbuf output = STRBUF_INIT;
-	struct strbuf err = STRBUF_INIT;
 	char *to_free = NULL;
-	int i;
-
-	memset(&array, 0, sizeof(array));
 
 	if (filter->lines == -1)
 		filter->lines = 0;
@@ -72,23 +66,8 @@ static int list_tags(struct ref_filter *filter, struct ref_sorting *sorting,
 	if (verify_ref_format(format))
 		die(_("unable to parse format string"));
 	filter->with_commit_tag_algo = 1;
-	filter_refs(&array, filter, FILTER_REFS_TAGS);
-	filter_ahead_behind(the_repository, format, &array);
-	ref_array_sort(sorting, &array);
-
-	for (i = 0; i < array.nr; i++) {
-		strbuf_reset(&output);
-		strbuf_reset(&err);
-		if (format_ref_array_item(array.items[i], format, &output, &err))
-			die("%s", err.buf);
-		fwrite(output.buf, 1, output.len, stdout);
-		if (output.len || !format->array_opts.omit_empty)
-			putchar('\n');
-	}
+	filter_and_format_refs(filter, FILTER_REFS_TAGS, sorting, format);
 
-	strbuf_release(&err);
-	strbuf_release(&output);
-	ref_array_clear(&array);
 	free(to_free);
 
 	return 0;
diff --git a/ref-filter.c b/ref-filter.c
index 5129b6986c9..8992fbf45b1 100644
--- a/ref-filter.c
+++ b/ref-filter.c
@@ -3023,6 +3023,18 @@ int filter_refs(struct ref_array *array, struct ref_filter *filter, unsigned int
 	return ret;
 }
 
+void filter_and_format_refs(struct ref_filter *filter, unsigned int type,
+			    struct ref_sorting *sorting,
+			    struct ref_format *format)
+{
+	struct ref_array array = { 0 };
+	filter_refs(&array, filter, type);
+	filter_ahead_behind(the_repository, format, &array);
+	ref_array_sort(sorting, &array);
+	print_formatted_ref_array(&array, format);
+	ref_array_clear(&array);
+}
+
 static int compare_detached_head(struct ref_array_item *a, struct ref_array_item *b)
 {
 	if (!(a->kind ^ b->kind))
@@ -3212,6 +3224,29 @@ int format_ref_array_item(struct ref_array_item *info,
 	return 0;
 }
 
+void print_formatted_ref_array(struct ref_array *array, struct ref_format *format)
+{
+	int total;
+	struct strbuf output = STRBUF_INIT, err = STRBUF_INIT;
+
+	total = format->array_opts.max_count;
+	if (!total || array->nr < total)
+		total = array->nr;
+	for (int i = 0; i < total; i++) {
+		strbuf_reset(&err);
+		strbuf_reset(&output);
+		if (format_ref_array_item(array->items[i], format, &output, &err))
+			die("%s", err.buf);
+		if (output.len || !format->array_opts.omit_empty) {
+			fwrite(output.buf, 1, output.len, stdout);
+			putchar('\n');
+		}
+	}
+
+	strbuf_release(&err);
+	strbuf_release(&output);
+}
+
 void pretty_print_ref(const char *name, const struct object_id *oid,
 		      struct ref_format *format)
 {
diff --git a/ref-filter.h b/ref-filter.h
index 0db3ff52889..0ce5af58ab3 100644
--- a/ref-filter.h
+++ b/ref-filter.h
@@ -137,6 +137,14 @@ struct ref_format {
  * filtered refs in the ref_array structure.
  */
 int filter_refs(struct ref_array *array, struct ref_filter *filter, unsigned int type);
+/*
+ * Filter refs using the given ref_filter and type, sort the contents
+ * according to the given ref_sorting, format the filtered refs with the
+ * given ref_format, and print them to stdout.
+ */
+void filter_and_format_refs(struct ref_filter *filter, unsigned int type,
+			    struct ref_sorting *sorting,
+			    struct ref_format *format);
 /*  Clear all memory allocated to ref_array */
 void ref_array_clear(struct ref_array *array);
 /*  Used to verify if the given format is correct and to parse out the used atoms */
@@ -161,6 +169,12 @@ char *get_head_description(void);
 /*  Set up translated strings in the output. */
 void setup_ref_filter_porcelain_msg(void);
 
+/*
+ * Print up to maxcount ref_array elements to stdout using the given
+ * ref_format.
+ */
+void print_formatted_ref_array(struct ref_array *array, struct ref_format *format);
+
 /*
  * Print a single ref, outside of any ref-filter. Note that the
  * name must be a fully qualified refname.
-- 
gitgitgadget

