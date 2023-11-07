Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 814F153A4
	for <git@vger.kernel.org>; Tue,  7 Nov 2023 01:26:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M8oWtsFG"
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D222C11C
	for <git@vger.kernel.org>; Mon,  6 Nov 2023 17:26:12 -0800 (PST)
Received: by mail-lj1-x236.google.com with SMTP id 38308e7fff4ca-2c50ec238aeso71632421fa.0
        for <git@vger.kernel.org>; Mon, 06 Nov 2023 17:26:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699320371; x=1699925171; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=h/n0fV4/QwXGR/2rRR4UxwBDT3mdaepdE2cdNP7k0lc=;
        b=M8oWtsFGF4byPPh1XgN6nacMo1cwND2tSWqbI5vhmgUfZcK/7IY8DHd9a67kkNTe42
         7MEwN6famHy6S//kkO08xJ82CCp2tnwrKIY2ED2kzWTAC1wrLflBACTG4lvokQ7OjeRk
         /47GIj266vwQR/jf1k0Dv/eFhge+Yi5uEulofv/c+LaIy6RRLRIh6YVFkZ9M6Fst+F3Z
         fAq3VPx3MrnHOdB7t2DLgJp9Now6j8kO3SKipvNdp0E+f2CvHqJWgTQZUbJoLB9x5OjP
         LoQ/MH6WYq45Wg9v4DzXxnJn3whTr52ZAaSCej/CU2TvrI0+C3o/wfccKy5SI2iMmZjM
         4U1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699320371; x=1699925171;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=h/n0fV4/QwXGR/2rRR4UxwBDT3mdaepdE2cdNP7k0lc=;
        b=MDkixrkXx8Hvoy1aiTzzjym4I8luBtiQHOuQeVsaqxqcY6VWzDqkn+EvCpUP1TzQ43
         BfWYByEYbXPtzJ1Vtsm6cEByjcX1qsqGMNOpLh38IrvvAGw/sMn48o7/1Is4AmGZ6yWS
         UNfg2Jc78Q4+0s75gChgYQXHOI+l/cuOYa9u1ZKVO56Ez7+3rMfo8v0+qFe3Ow1wsfXx
         yiAqfdPqdTHwklhbftJulXGkPCT3HhsZZdnIl43jEgJ+oqzMcRC/yyGxhEjtQQogDhV0
         d9EnLtPvkQByMGIf94nTw+svsfyJkch5aIRsJWCrFCzU8LjVqrpsXTImTNMI7egqpRuR
         8phQ==
X-Gm-Message-State: AOJu0YyH5Zy56sOH9W8s3YmQrMcoS+gZXPfSWuzWGvi2YLELi4HDlQei
	zEc+GsfjGFYAXBUPEGLpA04J3JTnv4M=
X-Google-Smtp-Source: AGHT+IEWytIHQfCP7t79Cz3/huJfxBxkqozsCEBG6aYEJkeS7hBGUDK8qw7OXFt1uxuW/9mNQ12Hsw==
X-Received: by 2002:a2e:8017:0:b0:2c5:1900:47a4 with SMTP id j23-20020a2e8017000000b002c5190047a4mr24491020ljg.0.1699320370815;
        Mon, 06 Nov 2023 17:26:10 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id s7-20020a05600c45c700b003fc16ee2864sm13835146wmo.48.2023.11.06.17.26.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Nov 2023 17:26:09 -0800 (PST)
Message-ID: <84db440896c162bcbeeaaf00d528839056aefaa5.1699320362.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1609.git.1699320361.gitgitgadget@gmail.com>
References: <pull.1609.git.1699320361.gitgitgadget@gmail.com>
From: "Victoria Dye via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 07 Nov 2023 01:25:59 +0000
Subject: [PATCH 7/9] ref-filter.c: filter & format refs in the same callback
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

Update 'filter_and_format_refs()' to try to perform ref filtering &
formatting in a single ref iteration, without an intermediate 'struct
ref_array'. This can only be done if no operations need to be performed on a
pre-filtered array; specifically, if the refs are

- filtered on reachability,
- sorted, or
- formatted with ahead-behind information

they cannot be filtered & formatted in the same iteration. In that case,
fall back on the current filter-then-sort-then-format flow.

This optimization substantially improves memory usage due to no longer
storing a ref array in memory. In some cases, it also dramatically reduces
runtime (e.g. 'git for-each-ref --no-sort --count=1', which no longer loads
all refs into a 'struct ref_array' to printing only the first ref).

Signed-off-by: Victoria Dye <vdye@github.com>
---
 ref-filter.c | 80 ++++++++++++++++++++++++++++++++++++++++++++++++----
 1 file changed, 74 insertions(+), 6 deletions(-)

diff --git a/ref-filter.c b/ref-filter.c
index ff00ab4b8d8..384cf1595ff 100644
--- a/ref-filter.c
+++ b/ref-filter.c
@@ -2863,6 +2863,44 @@ static void free_array_item(struct ref_array_item *item)
 	free(item);
 }
 
+struct ref_filter_and_format_cbdata {
+	struct ref_filter *filter;
+	struct ref_format *format;
+
+	struct ref_filter_and_format_internal {
+		int count;
+	} internal;
+};
+
+static int filter_and_format_one(const char *refname, const struct object_id *oid, int flag, void *cb_data)
+{
+	struct ref_filter_and_format_cbdata *ref_cbdata = cb_data;
+	struct ref_array_item *ref;
+	struct strbuf output = STRBUF_INIT, err = STRBUF_INIT;
+
+	ref = apply_ref_filter(refname, oid, flag, ref_cbdata->filter);
+	if (!ref)
+		return 0;
+
+	if (format_ref_array_item(ref, ref_cbdata->format, &output, &err))
+		die("%s", err.buf);
+
+	if (output.len || !ref_cbdata->format->array_opts.omit_empty) {
+		fwrite(output.buf, 1, output.len, stdout);
+		putchar('\n');
+	}
+
+	strbuf_release(&output);
+	strbuf_release(&err);
+	free_array_item(ref);
+
+	if (ref_cbdata->format->array_opts.max_count &&
+	    ++ref_cbdata->internal.count >= ref_cbdata->format->array_opts.max_count)
+		return -1;
+
+	return 0;
+}
+
 /* Free all memory allocated for ref_array */
 void ref_array_clear(struct ref_array *array)
 {
@@ -3046,16 +3084,46 @@ int filter_refs(struct ref_array *array, struct ref_filter *filter, unsigned int
 	return ret;
 }
 
+static inline int can_do_iterative_format(struct ref_filter *filter,
+					  struct ref_sorting *sorting,
+					  struct ref_format *format)
+{
+	/*
+	 * Refs can be filtered and formatted in the same iteration as long
+	 * as we aren't filtering on reachability, sorting the results, or
+	 * including ahead-behind information in the formatted output.
+	 */
+	return !(filter->reachable_from ||
+		 filter->unreachable_from ||
+		 sorting ||
+		 format->bases.nr);
+}
+
 void filter_and_format_refs(struct ref_filter *filter, unsigned int type,
 			    struct ref_sorting *sorting,
 			    struct ref_format *format)
 {
-	struct ref_array array = { 0 };
-	filter_refs(&array, filter, type);
-	filter_ahead_behind(the_repository, format, &array);
-	ref_array_sort(sorting, &array);
-	print_formatted_ref_array(&array, format);
-	ref_array_clear(&array);
+	if (can_do_iterative_format(filter, sorting, format)) {
+		int save_commit_buffer_orig;
+		struct ref_filter_and_format_cbdata ref_cbdata = {
+			.filter = filter,
+			.format = format,
+		};
+
+		save_commit_buffer_orig = save_commit_buffer;
+		save_commit_buffer = 0;
+
+		do_filter_refs(filter, type, filter_and_format_one, &ref_cbdata);
+
+		save_commit_buffer = save_commit_buffer_orig;
+	} else {
+		struct ref_array array = { 0 };
+		filter_refs(&array, filter, type);
+		filter_ahead_behind(the_repository, format, &array);
+		ref_array_sort(sorting, &array);
+		print_formatted_ref_array(&array, format);
+		ref_array_clear(&array);
+	}
 }
 
 static int compare_detached_head(struct ref_array_item *a, struct ref_array_item *b)
-- 
gitgitgadget

