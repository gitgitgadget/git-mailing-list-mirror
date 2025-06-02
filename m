Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F6C97485
	for <git@vger.kernel.org>; Mon,  2 Jun 2025 12:26:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748867206; cv=none; b=du1FopQJZkDBdKuFRKBGe2XxHXbXFWQtgD+vqH/7m6b6+LHKrFGif/xyVbKZOpqDGsmjNi8gCbVDypLsFqg8YwEZs2p6x6gtJqLGB+EillmFh+UjoE+aze3UcHh5mhfDy4HWNf91YetqObzTCV+QV69ACFidn2n3lw4QODXUmn0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748867206; c=relaxed/simple;
	bh=G10Ha55n6toOCPZf7gnjAPt94XLv5QRJu443r9G5QW4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=V5hhByXRQBK38M2eWKcdSPgWX0VQHENQD9hildrUHlLSZFGe9+JSdwrEm/VRQmUFI60mfYddcT4NQ3ayi00rFCiR8jcwuJ32pKqxAu1H2Ez+FI0zGf9ndwuUZNRXRlfzdgMTtBNOWLNzDoQNdhQrN3Htl7egnmF5sMLFAPJTSRA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XGaWX5Xs; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XGaWX5Xs"
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-450d668c2a1so20049895e9.0
        for <git@vger.kernel.org>; Mon, 02 Jun 2025 05:26:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748867202; x=1749472002; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bBPY3uR+bO4v+Ow+fYUjExt4Hfd6bBkgHhHjvxvMr5U=;
        b=XGaWX5XsSvHTxz7n8JQ1D2WVPTm9+2soHp1m1k3BFE8NXraI0J3Yre/yMS0AXVQvrE
         O9nyH7mWZyhfWFDvHiMHIJSqu2G2fZqUmwapRYCU+QUYAMfmFniVD7nsgwXaKRgUI6gB
         AUgJlWA7SLW4xeWbIdT79N2gd1eLRP3Q9ZSPay9UnBifV/tv9UeqtN44B/cKbPvqlAsN
         KezZeTLk+jwKZCPACs7SZcR2/waubVJC6TVHWVu7GMDRvH7qPDz0zqc9cDSbCyl3ORcS
         vACr7b8EA0nT/OUUpw/2+6VAZVAQg33X2Ougu+6LdIc5D+GbeSO5QUPoPMemPbUcmQDS
         xydg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748867202; x=1749472002;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bBPY3uR+bO4v+Ow+fYUjExt4Hfd6bBkgHhHjvxvMr5U=;
        b=tY8/Ihiw2Qw62cPhPihg+3PweqUYiJtCZOUWh1gXNj1PgNkLsiBtMjzZsLwAm2Ol+t
         T3LfMmpAiVoo9UEb/sq4CkcOYd14ZqXjZykLXHT8E+4FmaKGPDLKvpBSgPWxzm9rV1L/
         q2/ubbZjSJ299LKlqy8e2Muoka6QNrGXcp4MHKdqTszN2UNDeXnDaZSqd1UlgyvfkG5k
         s9fIap8NYTGJ7eRtwcfqGZSenuvkweuHYVkTQhMLwDxhVwKikCVv8NIWIL6Yqvv86uxr
         WD0Xjy1VMs6f8TVshUActG+9sEq7nEU+/46MxZMJNqW2ou7Px3L08P9vPvA5ZbXmH1kO
         GGng==
X-Gm-Message-State: AOJu0YyHQseT+CP81X2D+HzE5B8xqRMoXDtgCFZ2PQ5QKnTItJRDrkGF
	EoPXkni2kDy3loCDzwqmoZAQqbvpGAZB96IfoWN7Gfyd4n3GjAQpZflMcw9+6EDcNLo=
X-Gm-Gg: ASbGncv1zC8uLbR6WMC2i4J5D7PDiQGSbw4uYNVVAHv/SbifIOBDPEZZuUE2GH/okLT
	JZeFBIwPsAQnlG9DVlzbco1VKRPPvnttQM4ApaRVpwixMc/WqiykfiE3pBPBjdxD8TTbm9o/g8H
	di94OYU+Urik4Y1uwxxxSQ+SRlCPs7JjbKlmaSO72ic4/7SyBQVni1lwLO+3ZfW17gA0QgKaK6t
	JjFHIQyKi1pC4fAisfh+8Dgh49B2nVWiFpGSNSXvIQ4+E+LT2tgBSWaiIIk6i8XOpY7T5Se/60y
	9Zh+qVTWGKCdzVaKMD7mdM/I8Hys1bK0EsGzRva0djO9dPHMDBWHUxz88hEGqq2Sfafcz8Bwntl
	r
X-Google-Smtp-Source: AGHT+IGV49t5wxLO3jN+0PLdHC6eVwS4DKD/mRNjIdLM1VCikOKLwIZE+EIK53/oEs3cOjglZdiIEA==
X-Received: by 2002:a05:600c:6009:b0:440:69f5:f179 with SMTP id 5b1f17b1804b1-450ce837614mr114193475e9.7.1748867202263;
        Mon, 02 Jun 2025 05:26:42 -0700 (PDT)
Received: from localhost.localdomain ([105.113.90.168])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-451d30a227csm51034145e9.0.2025.06.02.05.26.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Jun 2025 05:26:41 -0700 (PDT)
From: Seyi Kuforiji <kuforiji98@gmail.com>
To: git@vger.kernel.org
Cc: ps@pks.im,
	phillip.wood@dunelm.org.uk,
	Seyi Kuforiji <kuforiji98@gmail.com>
Subject: [PATCH v3 01/10] t/unit-tests: implement clar specific reftable test helper functions
Date: Mon,  2 Jun 2025 13:25:49 +0100
Message-ID: <20250602122559.208780-2-kuforiji98@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250602122559.208780-1-kuforiji98@gmail.com>
References: <20250602122559.208780-1-kuforiji98@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Helper functions defined in `t/unit-tests/lib-reftable.{c,h}` are
required for the reftable-related test files to run. In the current
implementation these functions are designed to conform with our
homegrown unit-testing structure. So in other to convert the reftable
test files, there is need for a clar specific implementation of these
helper functions.

Implement equivalent helper functions in `lib-reftable-clar.{c,h}` to
use clar. These functions conform with the clar testing framework and
become available for all reftable-related test files implemented using
the clar testing framework, which requires them. This will be used by
subsequent commits.

Signed-off-by: Seyi Kuforiji <kuforiji98@gmail.com>
---
 Makefile                         |   1 +
 t/meson.build                    |   3 +-
 t/unit-tests/lib-reftable-clar.c | 101 +++++++++++++++++++++++++++++++
 t/unit-tests/lib-reftable-clar.h |  20 ++++++
 4 files changed, 124 insertions(+), 1 deletion(-)
 create mode 100644 t/unit-tests/lib-reftable-clar.c
 create mode 100644 t/unit-tests/lib-reftable-clar.h

diff --git a/Makefile b/Makefile
index 70d1543b6b..e4fa038508 100644
--- a/Makefile
+++ b/Makefile
@@ -1375,6 +1375,7 @@ CLAR_TEST_OBJS = $(patsubst %,$(UNIT_TEST_DIR)/%.o,$(CLAR_TEST_SUITES))
 CLAR_TEST_OBJS += $(UNIT_TEST_DIR)/clar/clar.o
 CLAR_TEST_OBJS += $(UNIT_TEST_DIR)/unit-test.o
 CLAR_TEST_OBJS += $(UNIT_TEST_DIR)/lib-oid.o
+CLAR_TEST_OBJS += $(UNIT_TEST_DIR)/lib-reftable-clar.o
 
 UNIT_TEST_PROGRAMS += t-reftable-basics
 UNIT_TEST_PROGRAMS += t-reftable-block
diff --git a/t/meson.build b/t/meson.build
index d052fc3e23..f77f21536e 100644
--- a/t/meson.build
+++ b/t/meson.build
@@ -19,7 +19,8 @@ clar_test_suites = [
 clar_sources = [
   'unit-tests/clar/clar.c',
   'unit-tests/unit-test.c',
-  'unit-tests/lib-oid.c'
+  'unit-tests/lib-oid.c',
+  'unit-tests/lib-reftable-clar.c'
 ]
 
 clar_decls_h = custom_target(
diff --git a/t/unit-tests/lib-reftable-clar.c b/t/unit-tests/lib-reftable-clar.c
new file mode 100644
index 0000000000..64e40a106e
--- /dev/null
+++ b/t/unit-tests/lib-reftable-clar.c
@@ -0,0 +1,101 @@
+#include "unit-test.h"
+#include "lib-reftable-clar.h"
+#include "hex.h"
+#include "parse-options.h"
+#include "reftable/constants.h"
+#include "reftable/writer.h"
+#include "strbuf.h"
+#include "string-list.h"
+#include "strvec.h"
+
+void cl_reftable_set_hash(uint8_t *p, int i, enum reftable_hash id)
+{
+	memset(p, (uint8_t)i, hash_size(id));
+}
+
+static ssize_t strbuf_writer_write(void *b, const void *data, size_t sz)
+{
+	strbuf_add(b, data, sz);
+	return sz;
+}
+
+static int strbuf_writer_flush(void *arg UNUSED)
+{
+	return 0;
+}
+
+struct reftable_writer *cl_reftable_strbuf_writer(struct reftable_buf *buf,
+						 struct reftable_write_options *opts)
+{
+	struct reftable_writer *writer;
+	int ret = reftable_writer_new(&writer, &strbuf_writer_write, &strbuf_writer_flush,
+				      buf, opts);
+	cl_assert(!ret);
+	return writer;
+}
+
+void cl_reftable_write_to_buf(struct reftable_buf *buf,
+			     struct reftable_ref_record *refs,
+			     size_t nrefs,
+			     struct reftable_log_record *logs,
+			     size_t nlogs,
+			     struct reftable_write_options *_opts)
+{
+	struct reftable_write_options opts = { 0 };
+	const struct reftable_stats *stats;
+	struct reftable_writer *writer;
+	uint64_t min = 0xffffffff;
+	uint64_t max = 0;
+	int ret;
+
+	if (_opts)
+		opts = *_opts;
+
+	for (size_t i = 0; i < nrefs; i++) {
+		uint64_t ui = refs[i].update_index;
+		if (ui > max)
+			max = ui;
+		if (ui < min)
+			min = ui;
+	}
+	for (size_t i = 0; i < nlogs; i++) {
+		uint64_t ui = logs[i].update_index;
+		if (ui > max)
+			max = ui;
+		if (ui < min)
+			min = ui;
+	}
+
+	writer = cl_reftable_strbuf_writer(buf, &opts);
+	ret = reftable_writer_set_limits(writer, min, max);
+	cl_assert_equal_i(ret, 0);
+
+	if (nrefs) {
+		ret = reftable_writer_add_refs(writer, refs, nrefs);
+		cl_assert_equal_i(ret, 0);
+	}
+
+	if (nlogs) {
+		ret = reftable_writer_add_logs(writer, logs, nlogs);
+		cl_assert_equal_i(ret, 0);
+	}
+
+	ret = reftable_writer_close(writer);
+	cl_assert_equal_i(ret, 0);
+
+	stats = reftable_writer_stats(writer);
+	for (size_t i = 0; i < (size_t)stats->ref_stats.blocks; i++) {
+		size_t off = i * (opts.block_size ? opts.block_size
+						  : DEFAULT_BLOCK_SIZE);
+		if (!off)
+			off = header_size(opts.hash_id == REFTABLE_HASH_SHA256 ? 2 : 1);
+		cl_assert(buf->buf[off] == 'r');
+	}
+
+	if (nrefs)
+		cl_assert(stats->ref_stats.blocks > 0);
+	if (nlogs)
+		cl_assert(stats->log_stats.blocks > 0);
+
+	reftable_writer_free(writer);
+}
diff --git a/t/unit-tests/lib-reftable-clar.h b/t/unit-tests/lib-reftable-clar.h
new file mode 100644
index 0000000000..b562648973
--- /dev/null
+++ b/t/unit-tests/lib-reftable-clar.h
@@ -0,0 +1,20 @@
+#include "git-compat-util.h"
+#include "clar/clar.h"
+#include "clar-decls.h"
+#include "git-compat-util.h"
+#include "reftable/reftable-writer.h"
+#include "strbuf.h"
+
+struct reftable_buf;
+
+void cl_reftable_set_hash(uint8_t *p, int i, enum reftable_hash id);
+
+struct reftable_writer *cl_reftable_strbuf_writer(struct reftable_buf *buf,
+						  struct reftable_write_options *opts);
+
+void cl_reftable_write_to_buf(struct reftable_buf *buf,
+			     struct reftable_ref_record *refs,
+			     size_t nrecords,
+			     struct reftable_log_record *logs,
+			     size_t nlogs,
+			     struct reftable_write_options *opts);
-- 
2.43.0

