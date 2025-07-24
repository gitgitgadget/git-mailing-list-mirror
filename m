Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5145328C85A
	for <git@vger.kernel.org>; Thu, 24 Jul 2025 14:29:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753367396; cv=none; b=jZ80WH6nnVJ5GXLiZ1u7eFMtT7DmNMFhHbQuLbYdMrPVIp9gCl2FOHEvQMLn8Cj+J5mB+xXNSWl3huiulq0WG4N5F9sEraQFKPyezXWwyfEKDGP6mv1ctpSSjHPdcrLO/e1YZHiTMf87GQhX7kT65ov/qhiIzPxBtB2QYwUZwWk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753367396; c=relaxed/simple;
	bh=G0ECwQFo1XKHehDZc9VuGjj3KG6/bkctiLT9vAHRRxg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rhSIKCDAWR0rlStWXTUEd8WlNxaFEX6aYLD7QrHRLZt2C9n8Ilu2xQXMeXNMPuarYSNLoHct4Vc9g4zjNpOQwwdiM3Eb51Yg6TmDPxOJanb81T5+afFvyCr+E8xF4/HmQ0+nlbt+wXOFMKx9oZHQUrpnjWOWUOZCJQgCG2D4ZFs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YgqmhquJ; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YgqmhquJ"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4560d176f97so12043135e9.0
        for <git@vger.kernel.org>; Thu, 24 Jul 2025 07:29:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753367392; x=1753972192; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pWc1zUaE+dYqpjZnko7Dhf+x3w7aEPi2Qv487Y3nOEI=;
        b=YgqmhquJFxrE9NVwtOvFsm7WXtjoSgimKMi8ZpaTnzmEEG7h2LOUlQUYGdqmktzxXx
         AXC17nyT2fllIDqVW4kC0/311Beoy+vDKrlqQ3sWNAr8vo6NLCe+IghNt62ppPC0gajA
         tJGNULs0aKyqg21wAXW5bTUcamguKJtigWuIWSSYHl9Hi0bKhTXvBm/APEAI5d9igKQf
         XlSb0Y0Rkk00KWuRC4dZNvmej7fFzHiH18zZ+9WeC5xaaafsFCJnJ7NnQhr3jTpvPXCl
         TWTtuic9wWXpLcu1DLsptYkwlKPDOE2W0y/nA2mSTLNdO5Sl6XecKapfP0PgVjmdHAls
         rC3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753367392; x=1753972192;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pWc1zUaE+dYqpjZnko7Dhf+x3w7aEPi2Qv487Y3nOEI=;
        b=oq9xk1dh7WaygTKkFazF2B6oIlCkQQWCxghEP8eetIKv9UHpB2yV2KzG00JdpN6FVf
         W+FNQ6Cn8pLvOAfrdafeOZ/7qnuakRfxW6wnlEbIRn7b5hMhgFgJEbAeGoYICBH82IzS
         xUMZ05YqyLuwug6JqDcRhOorbxdjLoihNSMCHNuKEsuG3mhp2vhTz9lCBeMb4n7bK9jo
         XBtscgt/xM6hvOAMbZ715Ukx7MBtroxb0uyDgC5w/sSlqMzFnHNLQsS3vjL3A74Fwe6g
         VkJpc/pSZdp9+wIRsZQYW6gA0fDP5sHX9o8pL+V4fveEXXSmyQjeUcsuWhSga5IWw1Yz
         JmBA==
X-Gm-Message-State: AOJu0YzJ1EVQRx8jxvMoSOeWOSdx/xS25cTK7cF0DUB6TYXAnxt5GfRu
	+TLf9NyUKSpc5bdPmAqfin3k1dC4PmQdZPvX7LdeLD5Kj/DI5A8Q/JICfA7v6MoD/S9IGYxk
X-Gm-Gg: ASbGnctfSJHSv+XPmFV3+6IhrMS8tINyaG9mYjAzNtz14h/KYzwrM/msY1Dy90uR3h5
	Zuu5rX0EMDQmTzXOEMMhBXDS9xV34xqtpq33jcQ5I57lnsDb/M5BAAhktRgDspmyJQp5CWRaE0E
	6BIETNKq5Gemo5Tt2QkAzU2g0lsGfef6OhVh89zN6nZ+AIs0VmaoI11zq6cRTEj01VmIkAlosVm
	2LMgm+1+vPTICZpKCNB3L5sN+PsVSAJVhXxP1fA79sIQAKeaoRQKGYZUMyE8KJSuRZvWfSdWg7c
	pXmdUhhHlPVq7jfD4SwSMgjsIU/0bnsmAmjAanb0Us4A681TxfL6slSHqgHeggl/+v0kQxnsUh+
	0ZaLYqZedEtFg72C+
X-Google-Smtp-Source: AGHT+IFvvoArCvBEC0FwUp/fA69Dkw8cimr0Q+0t3g5nrfzQk4inAeakEYqIUAXLfIXLERtM83UTTA==
X-Received: by 2002:a05:600c:4e4a:b0:456:28d4:ef1 with SMTP id 5b1f17b1804b1-45868d49628mr63834735e9.29.1753367392187;
        Thu, 24 Jul 2025 07:29:52 -0700 (PDT)
Received: from localhost.localdomain ([105.113.77.100])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4586ec63d29sm22792135e9.1.2025.07.24.07.29.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Jul 2025 07:29:51 -0700 (PDT)
From: Seyi Kufoiji <kuforiji98@gmail.com>
To: git@vger.kernel.org
Cc: ps@pks.im,
	phillip.wood@dunelm.org.uk,
	Seyi Kuforiji <kuforiji98@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v5 01/10] t/unit-tests: implement clar specific reftable test helper functions
Date: Thu, 24 Jul 2025 15:28:28 +0100
Message-ID: <20250724142837.67149-2-kuforiji98@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250724142837.67149-1-kuforiji98@gmail.com>
References: <20250605140644.239199-1-kuforiji98@gmail.com>
 <20250724142837.67149-1-kuforiji98@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Seyi Kuforiji <kuforiji98@gmail.com>

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
Signed-off-by: Junio C Hamano <gitster@pobox.com>
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

