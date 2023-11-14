Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92F732FC47
	for <git@vger.kernel.org>; Tue, 14 Nov 2023 19:54:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="By19hHLM"
Received: from mail-qt1-x82e.google.com (mail-qt1-x82e.google.com [IPv6:2607:f8b0:4864:20::82e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3BD2102
	for <git@vger.kernel.org>; Tue, 14 Nov 2023 11:54:15 -0800 (PST)
Received: by mail-qt1-x82e.google.com with SMTP id d75a77b69052e-41cd6e1d4fbso35150351cf.1
        for <git@vger.kernel.org>; Tue, 14 Nov 2023 11:54:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699991654; x=1700596454; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5XWd6sHPmyhluF5tAor/FSeqnyNOadFnP2v9XS/SCks=;
        b=By19hHLMlbwX0Vnxx9FSPDxfDyWOpaMTvvEuF5XIoUV2XJZ2F+GDYLp9H6XrZhmIFY
         8EKNEEeWh8awYZcefHtxAXtMmX6JBV+0q4OSR7xskfaMocpXjWHaofT2EWiBUvbboNv/
         2p+vTvO4sPfCHw0K6kdhxK6z69nPXm99G1oNnW3TYz9T2y7SvpzzsoE90GbapDFxqQy6
         lfz7of39VeQIuBrxChOLb4PoPtl+fRcOJHvWAkb0dB4+r7C6Y/KPnWQ2iUa3IA275/yo
         DeGK3adEZyPc5Rpr23rP92V8H2cTcYb2Me8n6PdXTG+qy9MKRIB8h6L9FyQzjkATKQMe
         pTwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699991654; x=1700596454;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5XWd6sHPmyhluF5tAor/FSeqnyNOadFnP2v9XS/SCks=;
        b=Jdxi9prbnZOK2amWIHP+j6KdGueDBuxnZvsVMaG4Ff/JLCCSjPcmy/+BrS4TPkggzL
         6LpQvhmaIMDe43VyA/EDJL9ST5Z1hY1fRkzz8IXA5EsWYgmEP8AYxK7k6MTI4GXG/boA
         eNJITo8pFndys8P3z12RHAy0UV0NJjfqJLLONf+aa+sahfgEerBFWa/AXraVkJ9THsCT
         13nmp/nGgx/p7p2M+2ABYN+uLSqucw5SwtTOPeiCqYp5kPC5lIwKXTIREujrmlBXbMjQ
         2nJBfqsdWVVKZmfuyitbsfHUmwYS9ftCbUQiMTYpXZ8VJCxQWO9+t/dszs9x41zunB6t
         rEjQ==
X-Gm-Message-State: AOJu0YwHz1GN7rcMN4ty/TF1isdlPFMwUohXiAxe9Q12EQAh2w+orWyI
	tv/3vf/GSdfuuwwikE7NDUQ4JT5u1I8=
X-Google-Smtp-Source: AGHT+IHjvOaheHBmUTTdvmxARmEq5gZH+dDOaHFNwLGbyPTZQeB51Py+Jf51albUTwADckpAwkawAQ==
X-Received: by 2002:a05:622a:1d6:b0:419:5b97:2fbb with SMTP id t22-20020a05622a01d600b004195b972fbbmr3398829qtw.34.1699991654380;
        Tue, 14 Nov 2023 11:54:14 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id t19-20020ac865d3000000b0041ce9ebaad2sm2981304qto.43.2023.11.14.11.54.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Nov 2023 11:54:14 -0800 (PST)
Message-ID: <91a77c1a834cfc2fbe0676222135c2beb6ed3e01.1699991638.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1609.v2.git.1699991638.gitgitgadget@gmail.com>
References: <pull.1609.git.1699320361.gitgitgadget@gmail.com>
	<pull.1609.v2.git.1699991638.gitgitgadget@gmail.com>
From: "Victoria Dye via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 14 Nov 2023 19:53:55 +0000
Subject: [PATCH v2 07/10] ref-filter.c: filter & format refs in the same
 callback
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
Cc: Patrick Steinhardt <ps@pks.im>,
    =?UTF-8?Q?=C3=98ystein?= Walle <oystwa@gmail.com>,
    Kristoffer Haugsbakk <code@khaugsbakk.name>,
    Victoria Dye <vdye@github.com>,
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
 ref-filter.c | 88 ++++++++++++++++++++++++++++++++++++++++++++++++----
 1 file changed, 82 insertions(+), 6 deletions(-)

diff --git a/ref-filter.c b/ref-filter.c
index ff00ab4b8d8..48453db24f7 100644
--- a/ref-filter.c
+++ b/ref-filter.c
@@ -2863,6 +2863,49 @@ static void free_array_item(struct ref_array_item *item)
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
+	/*
+	 * Increment the running count of refs that match the filter. If
+	 * max_count is set and we've reached the max, stop the ref
+	 * iteration by returning a nonzero value.
+	 */
+	if (ref_cbdata->format->array_opts.max_count &&
+	    ++ref_cbdata->internal.count >= ref_cbdata->format->array_opts.max_count)
+		return 1;
+
+	return 0;
+}
+
 /* Free all memory allocated for ref_array */
 void ref_array_clear(struct ref_array *array)
 {
@@ -3046,16 +3089,49 @@ int filter_refs(struct ref_array *array, struct ref_filter *filter, unsigned int
 	return ret;
 }
 
+static inline int can_do_iterative_format(struct ref_filter *filter,
+					  struct ref_sorting *sorting,
+					  struct ref_format *format)
+{
+	/*
+	 * Filtering & formatting results within a single ref iteration
+	 * callback is not compatible with options that require
+	 * post-processing a filtered ref_array. These include:
+	 * - filtering on reachability
+	 * - sorting the filtered results
+	 * - including ahead-behind information in the formatted output
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

