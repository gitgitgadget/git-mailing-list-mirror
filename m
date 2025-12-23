Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E41433030D
	for <git@vger.kernel.org>; Tue, 23 Dec 2025 11:11:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766488307; cv=none; b=My+999MMgD1n1DQ+Nwi64U9MXi7pCh6MAMD9WRGLhDBZCvpGqiuUTxuWLWpEyVG71+DarVy9jRu3AaP5dPZuHav/8aie+KL6r3CLSXnAK12VTSfGyPKA5qlvXt9WvbVlU3UjCxoP5IB4ki5EYL0fc5K+OhiDdZKv6UmFK4QVg4A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766488307; c=relaxed/simple;
	bh=cTXW5mwPWGPMam4NaANIMzTxZ8urWDXdhH09MqT3MkM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YxKhpVBhefqclBBnQ3Y46hg8ueNT8QJdQIFaaso5zTjwPQ9D4D+Gcy6DsmsyIuyhdgLt7tRdcmgv8vbjefDmmzQhsKORnAxK/GOWGZGKLGnk3DGx8VrsvsZBve8fT+Ds1n7DvgnR3o76+GwSRPDpX74fq+ysFFB9Q/arurOI6dM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=grWI2VOr; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="grWI2VOr"
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-42fbad1fa90so4101354f8f.0
        for <git@vger.kernel.org>; Tue, 23 Dec 2025 03:11:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766488301; x=1767093101; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sd0yAOmKNOEKfXoTzVD1cQmHY1UuOXlmPNu9K2y20Eg=;
        b=grWI2VOrWWTRJnMBivq4ZiA03hjKK4re4Dhvcv8E7zsdrq6naB9EXMt6Sg+e9QJmxz
         Vryqa8FZE7fZ41PVMjNEF5qmtFhfVh0aVRyrencm8axJLCXcNjFwGFA5xgbhGr7t0YnV
         zwylvcK+oW4wMohruwRTCFQw+uA1mcHYSf6u/T2dk2/SEvFelh4ZuqWjwdC4aQokTyKJ
         RmshOCYoKis+E88trg0sKujmTA6ZbJSVrfJZh+S/VHnEM1fsjjR8EdqyqyuhxiWrhz9G
         L8jS7YWsK5XgNEEGLJw7+hsHcv1bIeF31BzcmZDN1q5sPnOPSAW70+G/df2WFQCgdbt5
         pVMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766488301; x=1767093101;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=sd0yAOmKNOEKfXoTzVD1cQmHY1UuOXlmPNu9K2y20Eg=;
        b=qbaAUkihVOvsobRnC1KL+kkoIw7NbAyYdIz5JzbkBl1TQun78yG+q0KtCA3PZHcSrF
         S2b6ijYPR6qFgMT2U5ShS1zYihhX9XGvGj5QW5zROjj2DMfR1YG4hW3Cslfm8Ho3erbk
         FU6Djqor8LHOsA05IdI4u96WzsmWopwmuW7MGGfLTF7cdHHW35AyHh+aygP4dUhbmi+3
         6PwzIJp18i6l6JCQFrjeXV6+smRxZcQE6Vj7w5F2r8sY+xaPYmgkKd/AH2/UnUknXdW5
         pX3ZDIVnsEwCIM/wniyydkc/Zy+BfD+DIbyPieMX7WdMU+F4Pn6gA8V9MjDo7zU5k2qS
         d+/Q==
X-Gm-Message-State: AOJu0YyoGnPc7zw7eeYT6kXpnxISGz16TPoyphikjUAhdiGKXlWhtxzG
	yBX4qAld4q0tHoiBPIJJ/m5cro7+0KXRzBqS+I5Nlr9lAnTxfulezbjwzf3yLQ==
X-Gm-Gg: AY/fxX4w9+pyQXBic8T7+CVIb8Z4P7sHFCECTeQpiDuhj52Plf5cKxMrQpTSeuvDjh+
	JjdmoHgTsxL3VOIPPjgIZLp9o+lu790ug/l7O55GzAMhRw9HPpDzs4oSDuE8E77eDGm+UUiacC9
	hJGKFmGVu5Z0kN0HKfGOe489FyzuKaXymTOnmBcbu45c4HjI9+HGzi53BYZLL8MhrUtbUPBA7q+
	Q9fkJqTJRly9D7Hsa3vRcsotatZfO5y2Sw0f6LkbqrOvRElkfAP8ROa0VC1ClKlMF/9whdvarXb
	fDf6pv9bIxIsRCvvfNVdP0evtFWiMhm1m8yCWs4MOF5DGt+9NkAFTYWbvQBQUUKsKDfuJjrfJXe
	n96dell7bqZnb74XODcnwBI/bkX0wMU6Cxgczq+Uj/2s1wlr7x2PEoWUn0YMd4eUTuQM82aVFPL
	QebzuH7gH0fXTRXLx2n5tVHq/Oox1kBl6qKlvoSSLnlcYdQWCU1kSyRJtlY96utli/9qN2R2TIN
	felOOr1mIbxBmfhcO2PlG6AT+U=
X-Google-Smtp-Source: AGHT+IHSkiCKGUfcMYiZygJLpb33HsUy5XZtXQ7qb7leK9q6qteWVd1rMYYA1Qps2E1LlOc4wgXagw==
X-Received: by 2002:a05:6000:178c:b0:431:918:501d with SMTP id ffacd0b85a97d-4324e702853mr16557892f8f.60.1766488301036;
        Tue, 23 Dec 2025 03:11:41 -0800 (PST)
Received: from christian--20230123--2G7D3 ([62.35.114.108])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4324ea227e0sm27932795f8f.17.2025.12.23.03.11.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Dec 2025 03:11:40 -0800 (PST)
From: Christian Couder <christian.couder@gmail.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	Patrick Steinhardt <ps@pks.im>,
	Taylor Blau <me@ttaylorr.com>,
	Karthik Nayak <karthik.188@gmail.com>,
	Elijah Newren <newren@gmail.com>,
	Christian Couder <christian.couder@gmail.com>,
	Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH 6/9] list-objects-filter-options: support 'auto' mode for --filter
Date: Tue, 23 Dec 2025 12:11:10 +0100
Message-ID: <20251223111113.47473-7-christian.couder@gmail.com>
X-Mailer: git-send-email 2.52.0.319.gfcaffa7898
In-Reply-To: <20251223111113.47473-1-christian.couder@gmail.com>
References: <20251223111113.47473-1-christian.couder@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In a following commit, we are going to allow passing "auto" as a
<filterspec> to the `--filter=<filterspec>` option, but only for some
commands. Other commands that support the `--filter=<filterspec>`
option should still die() when 'auto' is passed.

Let's set up the "list-objects-filter-options.{c,h}" infrastructure to
support that:

- Add a new `unsigned int allow_auto_filter : 1;` flag to
  `struct list_objects_filter_options` which specifies if "auto" is
  accepted or not.
- Change gently_parse_list_objects_filter() to parse "auto" if it's
  accepted.
- Make sure we die() if "auto" is combined with another filter.
- Update list_objects_filter_release() to preserve the
  allow_auto_filter flag, as this function is often called (via
  opt_parse_list_objects_filter) to reset the struct before parsing a
  new value.

Let's also update `list-objects-filter.c` to recognize the new
`LOFC_AUTO` choice. Since "auto" must be resolved to a concrete filter
before filtering actually begins, initializing a filter with
`LOFC_AUTO` is invalid and will trigger a BUG().

Note that ideally combining "auto" with "auto" could be allowed, but in
practice, it's probably not worth the added code complexity. And if we
really want it, nothing prevents us to allow it in future work.

If we ever want to give a meaning to combining "auto" with a different
filter too, nothing prevents us to do that in future work either.

While at it, let's add a new "u-list-objects-filter-options.c" file for
`struct list_objects_filter_options` related unit tests. For now it
only tests gently_parse_list_objects_filter() though.

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 Makefile                                     |  1 +
 list-objects-filter-options.c                | 36 +++++++++++--
 list-objects-filter-options.h                |  6 +++
 list-objects-filter.c                        |  8 +++
 t/meson.build                                |  1 +
 t/unit-tests/u-list-objects-filter-options.c | 53 ++++++++++++++++++++
 6 files changed, 102 insertions(+), 3 deletions(-)
 create mode 100644 t/unit-tests/u-list-objects-filter-options.c

diff --git a/Makefile b/Makefile
index 89d8d73ec0..85b2ff09f4 100644
--- a/Makefile
+++ b/Makefile
@@ -1507,6 +1507,7 @@ CLAR_TEST_SUITES += u-dir
 CLAR_TEST_SUITES += u-example-decorate
 CLAR_TEST_SUITES += u-hash
 CLAR_TEST_SUITES += u-hashmap
+CLAR_TEST_SUITES += u-list-objects-filter-options
 CLAR_TEST_SUITES += u-mem-pool
 CLAR_TEST_SUITES += u-oid-array
 CLAR_TEST_SUITES += u-oidmap
diff --git a/list-objects-filter-options.c b/list-objects-filter-options.c
index 7420bf81fe..f13ae5caeb 100644
--- a/list-objects-filter-options.c
+++ b/list-objects-filter-options.c
@@ -20,6 +20,8 @@ const char *list_object_filter_config_name(enum list_objects_filter_choice c)
 	case LOFC_DISABLED:
 		/* we have no name for "no filter at all" */
 		break;
+	case LOFC_AUTO:
+		return "auto";
 	case LOFC_BLOB_NONE:
 		return "blob:none";
 	case LOFC_BLOB_LIMIT:
@@ -52,7 +54,17 @@ int gently_parse_list_objects_filter(
 	if (filter_options->choice)
 		BUG("filter_options already populated");
 
-	if (!strcmp(arg, "blob:none")) {
+	if (!strcmp(arg, "auto")) {
+		if (!filter_options->allow_auto_filter) {
+			strbuf_addstr(
+				errbuf,
+				_("'auto' filter not supported by this command"));
+			return 1;
+		}
+		filter_options->choice = LOFC_AUTO;
+		return 0;
+
+	} else if (!strcmp(arg, "blob:none")) {
 		filter_options->choice = LOFC_BLOB_NONE;
 		return 0;
 
@@ -146,10 +158,20 @@ static int parse_combine_subfilter(
 
 	decoded = url_percent_decode(subspec->buf);
 
-	result = has_reserved_character(subspec, errbuf) ||
-		gently_parse_list_objects_filter(
+	result = has_reserved_character(subspec, errbuf);
+	if (result)
+		goto cleanup;
+
+	result = gently_parse_list_objects_filter(
 			&filter_options->sub[new_index], decoded, errbuf);
+	if (result)
+		goto cleanup;
+
+	result = (filter_options->sub[new_index].choice == LOFC_AUTO);
+	if (result)
+		strbuf_addstr(errbuf, _("an 'auto' filter cannot be combined"));
 
+cleanup:
 	free(decoded);
 	return result;
 }
@@ -263,6 +285,9 @@ void parse_list_objects_filter(
 	} else {
 		struct list_objects_filter_options *sub;
 
+		if (filter_options->choice == LOFC_AUTO)
+			die(_("an 'auto' filter is incompatible with any other filter"));
+
 		/*
 		 * Make filter_options an LOFC_COMBINE spec so we can trivially
 		 * add subspecs to it.
@@ -277,6 +302,9 @@ void parse_list_objects_filter(
 		if (gently_parse_list_objects_filter(sub, arg, &errbuf))
 			die("%s", errbuf.buf);
 
+		if (sub->choice == LOFC_AUTO)
+			die(_("an 'auto' filter is incompatible with any other filter"));
+
 		strbuf_addch(&filter_options->filter_spec, '+');
 		filter_spec_append_urlencode(filter_options, arg);
 	}
@@ -317,6 +345,7 @@ void list_objects_filter_release(
 	struct list_objects_filter_options *filter_options)
 {
 	size_t sub;
+	unsigned int allow_auto_filter = filter_options->allow_auto_filter;
 
 	if (!filter_options)
 		return;
@@ -326,6 +355,7 @@ void list_objects_filter_release(
 		list_objects_filter_release(&filter_options->sub[sub]);
 	free(filter_options->sub);
 	list_objects_filter_init(filter_options);
+	filter_options->allow_auto_filter = allow_auto_filter;
 }
 
 void partial_clone_register(
diff --git a/list-objects-filter-options.h b/list-objects-filter-options.h
index 7b2108b986..77d7bbc846 100644
--- a/list-objects-filter-options.h
+++ b/list-objects-filter-options.h
@@ -18,6 +18,7 @@ enum list_objects_filter_choice {
 	LOFC_SPARSE_OID,
 	LOFC_OBJECT_TYPE,
 	LOFC_COMBINE,
+	LOFC_AUTO,
 	LOFC__COUNT /* must be last */
 };
 
@@ -50,6 +51,11 @@ struct list_objects_filter_options {
 	 */
 	unsigned int no_filter : 1;
 
+	/*
+	 * Is LOFC_AUTO a valid option?
+	 */
+	unsigned int allow_auto_filter : 1;
+
 	/*
 	 * BEGIN choice-specific parsed values from within the filter-spec. Only
 	 * some values will be defined for any given choice.
diff --git a/list-objects-filter.c b/list-objects-filter.c
index acd65ebb73..78316e7f90 100644
--- a/list-objects-filter.c
+++ b/list-objects-filter.c
@@ -745,6 +745,13 @@ static void filter_combine__init(
 	filter->finalize_omits_fn = filter_combine__finalize_omits;
 }
 
+static void filter_auto__init(
+	struct list_objects_filter_options *filter_options UNUSED,
+	struct filter *filter UNUSED)
+{
+	BUG("LOFC_AUTO should have been resolved before initializing the filter");
+}
+
 typedef void (*filter_init_fn)(
 	struct list_objects_filter_options *filter_options,
 	struct filter *filter);
@@ -760,6 +767,7 @@ static filter_init_fn s_filters[] = {
 	filter_sparse_oid__init,
 	filter_object_type__init,
 	filter_combine__init,
+	filter_auto__init,
 };
 
 struct filter *list_objects_filter__init(
diff --git a/t/meson.build b/t/meson.build
index 459c52a489..0bd66cc6ce 100644
--- a/t/meson.build
+++ b/t/meson.build
@@ -4,6 +4,7 @@ clar_test_suites = [
   'unit-tests/u-example-decorate.c',
   'unit-tests/u-hash.c',
   'unit-tests/u-hashmap.c',
+  'unit-tests/u-list-objects-filter-options.c',
   'unit-tests/u-mem-pool.c',
   'unit-tests/u-oid-array.c',
   'unit-tests/u-oidmap.c',
diff --git a/t/unit-tests/u-list-objects-filter-options.c b/t/unit-tests/u-list-objects-filter-options.c
new file mode 100644
index 0000000000..f7d73701b5
--- /dev/null
+++ b/t/unit-tests/u-list-objects-filter-options.c
@@ -0,0 +1,53 @@
+#include "unit-test.h"
+#include "list-objects-filter-options.h"
+#include "strbuf.h"
+
+/* Helper to test gently_parse_list_objects_filter() */
+static void check_gentle_parse(const char *filter_spec,
+			       int expect_success,
+			       int allow_auto,
+			       enum list_objects_filter_choice expected_choice)
+{
+	struct list_objects_filter_options filter_options = LIST_OBJECTS_FILTER_INIT;
+	struct strbuf errbuf = STRBUF_INIT;
+	int ret;
+
+	filter_options.allow_auto_filter = allow_auto;
+
+	ret = gently_parse_list_objects_filter(&filter_options, filter_spec, &errbuf);
+
+	if (expect_success) {
+		cl_assert_equal_i(ret, 0);
+		cl_assert_equal_i(expected_choice, filter_options.choice);
+		cl_assert_equal_i(errbuf.len, 0);
+	} else {
+		cl_assert(ret != 0);
+		cl_assert(errbuf.len > 0);
+	}
+
+	strbuf_release(&errbuf);
+	list_objects_filter_release(&filter_options);
+}
+
+void test_list_objects_filter_options__regular_filters(void)
+{
+	check_gentle_parse("blob:none", 1, 0, LOFC_BLOB_NONE);
+	check_gentle_parse("blob:none", 1, 1, LOFC_BLOB_NONE);
+	check_gentle_parse("blob:limit=5k", 1, 0, LOFC_BLOB_LIMIT);
+	check_gentle_parse("blob:limit=5k", 1, 1, LOFC_BLOB_LIMIT);
+	check_gentle_parse("combine:blob:none+tree:0", 1, 0, LOFC_COMBINE);
+	check_gentle_parse("combine:blob:none+tree:0", 1, 1, LOFC_COMBINE);
+}
+
+void test_list_objects_filter_options__auto_allowed(void)
+{
+	check_gentle_parse("auto", 1, 1, LOFC_AUTO);
+	check_gentle_parse("auto", 0, 0, 0);
+}
+
+void test_list_objects_filter_options__combine_auto_fails(void)
+{
+	check_gentle_parse("combine:auto+blob:none", 0, 1, 0);
+	check_gentle_parse("combine:blob:none+auto", 0, 1, 0);
+	check_gentle_parse("combine:auto+auto", 0, 1, 0);
+}
-- 
2.52.0.319.gfcaffa7898

