Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44A372E1F08
	for <git@vger.kernel.org>; Thu, 12 Feb 2026 10:09:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770890956; cv=none; b=conNzdQ1srOwx0yfXw/DSf4QFlW46LVAmQs+jax08TSN/3kRj4NeQTOzz9jVBU3efgnhtoSkDDTKQrx7GTBqnM/g6bfm0RUr0exa8V1x3MNiwLCawijZZNfUkfRI2osiuD14KhfYxbFNP3JcECyEXVzLdIk2OSo2C8QyLVhWR2U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770890956; c=relaxed/simple;
	bh=qFqpKeO2+qLBkIosaAH9LkDKt8jVvfFlIjTqEtJuVJM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Jr1PlTkviBNCOEN1oB96ibcU8+lnZZ+10IWk/D/16P0uvnkHxsdUECU0FiTqA4KOQr2X16+mkN7PSrdKeK3PM9+UL4OHY8JRMVnS5NJNCuF5lc29Vibbiz+ny1wK+XIL0g2NHduA74dBGdrF+yM+6sH8Ghyrx62Cicb00QadRDY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jhb7EwxD; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jhb7EwxD"
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-4376de3f128so2826109f8f.0
        for <git@vger.kernel.org>; Thu, 12 Feb 2026 02:09:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770890951; x=1771495751; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bGQf0noYuHFY8Mf5BP9UfshMi4b6OLnmrDiGUaDTnsM=;
        b=jhb7EwxDfR0TbAunASTr1pLSHaPJy0PPt61c3nrBGmxQmJaU8s/qyqhmXVpn0z7/Yk
         hW0dnbcgG23fAQqb0foJkEUFS6rmKUaBzVNEHqJCvcj9e1b34cElnVtoV/Cb/q76plDN
         3IcE6ZxE36Q06QdViwKVHPDNc78v5ygxNKf9uij6PRtzt+tHKsVJFE4MN1y1/KG8Vafk
         ftDcBWmwDN8HNn5IJUOUKuXeXxCsBYEHSu/TqLGxkw7dcXodPl334vwuNz66YHl3WHd7
         aPyXYgVXj08WkUqzJ3scfFY5o4QOxWwGjYxbSsMxGWf8sWySu/ayKbHC+T4rf/kb+Pyc
         /rfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770890951; x=1771495751;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=bGQf0noYuHFY8Mf5BP9UfshMi4b6OLnmrDiGUaDTnsM=;
        b=IQrdogUfqonnP6lTR6gsPyj19MqJnvCwTDid88dhLUEg5o/19crwagdwMU0pLCj4rY
         5DZ+Pnmt3uEwx3xfqqkpwIFkwWx4dN9vvoZJyBwQ6m1eYdLNFjr/rAFZ3aekwEnkk0K7
         JWKynNE+ZcYk7y+FgBE4QuQX/VzJ13IhI8F3+k8Lq44AeZKkQThBvyDHFoMs+u4pDPm1
         t6w0naQvO+coyErgkVgUGYRak/9AgIMPQ9IGP3rvWfW9wS0oOvTdr920KF9cibQruqH9
         qbDD2vmKUDtnhc27C/4+0ThHMYcjLhr0hq1EZG2XAMFTeywHd8LLQupgftO8LzZ4Tst8
         aaJQ==
X-Gm-Message-State: AOJu0Yw2hoPORba0nVUynCiNMNqpFJzxJYXpiYSH03giUo7WHoWdF3AT
	YF/+Ww6zgkcmAEbSDphUgyQLYno8Ed6ufs2SWwpYwrnusLw9FL7mGHvdtMzCJg==
X-Gm-Gg: AZuq6aINJIM5CYMwJlif33BgBGE1Ly03UPSA2ut7qC9Ger0osSVx/sVLLJuIJQ46jIR
	V+9rr88onIMMFiUfWsM1ItUV3AEkYqX/5eyapv1TlAfGORC0aO2mi4TP2KI8ogx4fO0N6xENL4V
	qCr7mNnuNKPviRaR8SLW/VXuCMdDUE1jPBWVpfbk6HbATEfVRNpFD4Iv7mVwnLVWkTa2uUePVdU
	AmLiugvKpPrJQpCbw4qVrKE7Q4W3ZrJ4zRToD8iZUQClcYwS9bTpRG9oXYLXzdRD6iqTv8dbwc/
	TBoUz9tWLskIUU+m32lPAOmScg4a02xFnIdINfAUxFPGntKqkMHNFYkN4r2u/rYqiT1uY/bRaHO
	tr5XzuYLHCbXw+0RK/hsNKGLeWedoCbSUvY9UyA71QVmucF0gHEvB3oIIJWKh3fVz7Fi2ZoSCI5
	5Vi/D6P4a/0TKKR1UNQLxsftbXzLbiXHKz8cIkPZScBRIgW1hjuSvVw74fG8JZSy5VFAnLR9KDd
	ZmZ855f8j1jfFVMLhfIca22mVKwGVXOmVyDk6a6TmcAmaBqOA==
X-Received: by 2002:a05:6000:2501:b0:437:6ec2:b11d with SMTP id ffacd0b85a97d-4378ad46ecbmr3863212f8f.38.1770890950848;
        Thu, 12 Feb 2026 02:09:10 -0800 (PST)
Received: from christian--20230123--2G7D3 ([62.35.114.108])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43783d3464csm12701151f8f.5.2026.02.12.02.09.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Feb 2026 02:09:10 -0800 (PST)
From: Christian Couder <christian.couder@gmail.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	Patrick Steinhardt <ps@pks.im>,
	Taylor Blau <me@ttaylorr.com>,
	Karthik Nayak <karthik.188@gmail.com>,
	Elijah Newren <newren@gmail.com>,
	=?UTF-8?q?Jean-No=C3=ABl=20Avila?= <avila.jn@gmail.com>,
	Christian Couder <christian.couder@gmail.com>,
	Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v3 6/9] list-objects-filter-options: support 'auto' mode for --filter
Date: Thu, 12 Feb 2026 11:08:37 +0100
Message-ID: <20260212100843.883623-7-christian.couder@gmail.com>
X-Mailer: git-send-email 2.53.0.70.g3d1fd9d397.dirty
In-Reply-To: <20260212100843.883623-1-christian.couder@gmail.com>
References: <20260204110818.2919273-1-christian.couder@gmail.com>
 <20260212100843.883623-1-christian.couder@gmail.com>
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
  accepted or not by the current command.
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

Also note that the new `allow_auto_filter` flag depends on the command,
not user choices, so it should be reset to the command default when
`struct list_objects_filter_options` instances are reset.

While at it, let's add a new "u-list-objects-filter-options.c" file for
`struct list_objects_filter_options` related unit tests. For now it
only tests gently_parse_list_objects_filter() though.

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 Makefile                                     |  1 +
 list-objects-filter-options.c                | 37 ++++++++++++--
 list-objects-filter-options.h                |  6 +++
 list-objects-filter.c                        |  8 +++
 t/meson.build                                |  1 +
 t/unit-tests/u-list-objects-filter-options.c | 53 ++++++++++++++++++++
 6 files changed, 103 insertions(+), 3 deletions(-)
 create mode 100644 t/unit-tests/u-list-objects-filter-options.c

diff --git a/Makefile b/Makefile
index 4ac44331ea..9e174dd06c 100644
--- a/Makefile
+++ b/Makefile
@@ -1518,6 +1518,7 @@ CLAR_TEST_SUITES += u-dir
 CLAR_TEST_SUITES += u-example-decorate
 CLAR_TEST_SUITES += u-hash
 CLAR_TEST_SUITES += u-hashmap
+CLAR_TEST_SUITES += u-list-objects-filter-options
 CLAR_TEST_SUITES += u-mem-pool
 CLAR_TEST_SUITES += u-oid-array
 CLAR_TEST_SUITES += u-oidmap
diff --git a/list-objects-filter-options.c b/list-objects-filter-options.c
index 7420bf81fe..ad92cbaa37 100644
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
@@ -52,7 +54,16 @@ int gently_parse_list_objects_filter(
 	if (filter_options->choice)
 		BUG("filter_options already populated");
 
-	if (!strcmp(arg, "blob:none")) {
+	if (!strcmp(arg, "auto")) {
+		if (!filter_options->allow_auto_filter) {
+			strbuf_addstr(errbuf,
+				      _("'auto' filter not supported by this command"));
+			return 1;
+		}
+		filter_options->choice = LOFC_AUTO;
+		return 0;
+
+	} else if (!strcmp(arg, "blob:none")) {
 		filter_options->choice = LOFC_BLOB_NONE;
 		return 0;
 
@@ -146,10 +157,22 @@ static int parse_combine_subfilter(
 
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
+	if (result) {
+		strbuf_addstr(errbuf, _("an 'auto' filter cannot be combined"));
+		goto cleanup;
+	}
 
+cleanup:
 	free(decoded);
 	return result;
 }
@@ -263,6 +286,9 @@ void parse_list_objects_filter(
 	} else {
 		struct list_objects_filter_options *sub;
 
+		if (filter_options->choice == LOFC_AUTO)
+			die(_("an 'auto' filter is incompatible with any other filter"));
+
 		/*
 		 * Make filter_options an LOFC_COMBINE spec so we can trivially
 		 * add subspecs to it.
@@ -277,6 +303,9 @@ void parse_list_objects_filter(
 		if (gently_parse_list_objects_filter(sub, arg, &errbuf))
 			die("%s", errbuf.buf);
 
+		if (sub->choice == LOFC_AUTO)
+			die(_("an 'auto' filter is incompatible with any other filter"));
+
 		strbuf_addch(&filter_options->filter_spec, '+');
 		filter_spec_append_urlencode(filter_options, arg);
 	}
@@ -317,6 +346,7 @@ void list_objects_filter_release(
 	struct list_objects_filter_options *filter_options)
 {
 	size_t sub;
+	unsigned int allow_auto_filter = filter_options->allow_auto_filter;
 
 	if (!filter_options)
 		return;
@@ -326,6 +356,7 @@ void list_objects_filter_release(
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
index a04a7a86cf..bec4c72327 100644
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
2.53.0.70.g3d1fd9d397.dirty

