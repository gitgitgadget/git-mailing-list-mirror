Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDE293E9586
	for <git@vger.kernel.org>; Wed,  4 Feb 2026 11:08:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770203325; cv=none; b=Q5gauW6rUA0GiVVzkK5UDIrR4Cy3Kr8TsgaTjnvVGRhxWLhUvzbepUtVkAV4w4tO+6Ouw99ZYVU2EQFiIDyI2RS5oILV3A34016quzuy42ySWqM1eBwvCD2cJvX2d1CAWafAJ8BRgoDlHrPjvdGr9bGEaxUVoo6VRONFQ9GCqqk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770203325; c=relaxed/simple;
	bh=KJIA3U1ZplYz2e5ZnCRLag7FZZUm3xd3+LKFbgf+AOM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=b/VCUHCZwRAfUeot8klVxU2+wGaVH4FmRamin1VPE2pGRO9MCD2ID6KwyLwT3YQ4SCASggdpl0YYEM/Sgo+TtM2fDSuCQLHzQDW+g9sXy+eTww5QUcN+NbtU/v78AuGk6ul8HQWqcPjFRJgc2zJd9GhhRlqNpnHi2CeGF5Ye8dQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Jo+28cVF; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Jo+28cVF"
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-43246af170aso550473f8f.0
        for <git@vger.kernel.org>; Wed, 04 Feb 2026 03:08:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770203323; x=1770808123; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ufJC2BE5UbbuDz2J1ep4/Gn1U2pR7gumRfudMZa+UdU=;
        b=Jo+28cVFCd6Z0Pph3NHCD9+/P7Ok81XRQ5OfZLzjAmlCW35w65PpS//kDkfwbSJnX1
         lDeRC0IQ0XMRKpNP6xX60QK+PyGUCmzWeKtwVRuYlsPg/vJXPrU6/2ggDu020jT1BHuj
         pcwvUdCLzFb8QrB+NkiWILG/qiiD/wbGRxFTNxClG3BNJYLbcbrD7pAnnh8iHw1squ5d
         znsYiBHmEtftYea4j4VDP6MesRisCkCjgKUOOeCKSagWOjc9McGjyUprFM4h2QCCtnSV
         ufLLtbkVus4RTiZRct2yzf4P/E/9cHGKciNQfPpO6L52NKnFFiPeJzYHAh/3mfcJylgR
         LwjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770203323; x=1770808123;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ufJC2BE5UbbuDz2J1ep4/Gn1U2pR7gumRfudMZa+UdU=;
        b=IoN42D/b6u5n8K0D4fr/vI2VUKmYrr0uzsla5B6gWapWYYfidQu1B+3JRlOFD3W8DI
         SPOysnVBviATAPSAZojtfGedZgaZ1LbXq/lJCcTJw/In9SX4125oB3xXLM4gy35bGQNb
         uM4wR9VkSZrKt3wcO3eZrfdo8JISCnTIMq25L+XJEm8wjUsgQiNl3pL/lKcgPRel9V7S
         ClM4P3+h4O8VQa89Zu1uzwaPRSpjP6aXYafIflIoQZOfMwKKN3uAhHw3iWVu6L4dKWio
         L+b+046mR8O+r35u/5AFbclRZPrcEBx5S18Q628koLTwvJJBaCEJMiuoZEwtEHa9eZuG
         e9/Q==
X-Gm-Message-State: AOJu0YyT0MjzgBnB+WCARNkwcUWM0Q6dQ3YOabdwoO0noumIhAyqLvxs
	q4P8b0g83G62RyPfp+MfPARjfLdVIXZhSxdb4XTkSSAxb8mBpxo+RFuq0XqE1Q==
X-Gm-Gg: AZuq6aL4CqWQabXQ1wHARhuqMecymFDaLLJ1N2XV0mxTLPOCfcRhHa84g6DhQWFs0nz
	cHZZoi/prTNF7iNWQcg4fDwsVqRJKNmaAsZb8lni8zSAnKcuLRfhPsb5VFRE1CTmGNxxR92qiTH
	Rjk9UenGLjuRe4y9jPubQ2pI80sa8dkUbgdpb14UgFdiMhM9I6CygEWuw0oC37BWxLBmLkSvv0M
	SDT8zwUY6Bn1yEHk87v58J+7AOvr7Uw7ty654j7ov4KssLY8N8NcGpUPtYvRJOT4LPgfq44BArx
	bWcwrzqlsUM3FmY56H4pzMdLJyiZA6UwhD7MwufUxxNb/mAsuokyQfPkQIgA3LtOdpsHY1c0nht
	m2gCTNiHZV38rn+B7bXyTg4RUrzocFVfCYU7u8nuuzlpL3tKV91/xECBrZnzQklIJGcaew/O718
	qFOHLX8+LjtMzz+OdtxRXemoS0tWJLl6oPnl5sSjYmpHr0bVKPYrcXvEagSqjNgLlRxdIaOwBIZ
	3DVdFqyuhC+ZGxo7ahkRS2ervsVAU2GbyXwaw==
X-Received: by 2002:a05:6000:26ce:b0:435:b674:c9b1 with SMTP id ffacd0b85a97d-43617c37cacmr3821931f8f.11.1770203322266;
        Wed, 04 Feb 2026 03:08:42 -0800 (PST)
Received: from christian--20230123--2G7D3 ([62.35.114.108])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-436180640f2sm5340096f8f.39.2026.02.04.03.08.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Feb 2026 03:08:41 -0800 (PST)
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
Subject: [PATCH v2 6/8] list-objects-filter-options: support 'auto' mode for --filter
Date: Wed,  4 Feb 2026 12:08:11 +0100
Message-ID: <20260204110818.2919273-7-christian.couder@gmail.com>
X-Mailer: git-send-email 2.53.0.rc2.10.g12663a1c75.dirty
In-Reply-To: <20260204110818.2919273-1-christian.couder@gmail.com>
References: <20251223111113.47473-1-christian.couder@gmail.com>
 <20260204110818.2919273-1-christian.couder@gmail.com>
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
index 8aa489f3b6..04256f747c 100644
--- a/Makefile
+++ b/Makefile
@@ -1516,6 +1516,7 @@ CLAR_TEST_SUITES += u-dir
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
2.53.0.rc2.10.g12663a1c75.dirty

