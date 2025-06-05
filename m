Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 713061C861D
	for <git@vger.kernel.org>; Thu,  5 Jun 2025 14:07:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749132440; cv=none; b=PyR7pa8FM/Q65SsuUXiqnNBuRedfjWJGn3zOGXZehztddWgjXdIW6OYnzU2JeMUe9z+QpdTRYX4IHjFdFed43bjgP5fnP4Cp1fn5Ma3IJzt3SF40GOX+TWnvCqi8hBlJWFe4RIZvzXXfwbPNvjcF9zhIeeT04N0Ohd6ooNozwNk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749132440; c=relaxed/simple;
	bh=G10Ha55n6toOCPZf7gnjAPt94XLv5QRJu443r9G5QW4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=K6K9RjzgPrZl06Fk1ySOBKaGRcvYIHSgBmh3lLjRww/CcEH0ovL/8WMnr2vR5DZo9D3zF6m5fT8MdbAbaRA7hxGRLiYuDzTJXyYBVSvkGMSIjgnCoROHGjXeQyikkfKcuwPji7KDaA1DMCHYIX3C0WztJqO3L352/QFPV83q7O4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GuCdSiMu; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GuCdSiMu"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-450ce3a2dd5so9042775e9.3
        for <git@vger.kernel.org>; Thu, 05 Jun 2025 07:07:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749132436; x=1749737236; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bBPY3uR+bO4v+Ow+fYUjExt4Hfd6bBkgHhHjvxvMr5U=;
        b=GuCdSiMuex9WsIorKvrrxecudrAownQCmMA9xKr0pmlAiwaDGm2yEiy+uO2xAKfkBd
         HV8e+2W86y2IF5AcjUK6/3KFdlBUPuhAInsAyb5eBxhM5pmsIFg+1l0JJ91apGYR9YqM
         Q5s7UMZCYKLKSUAHxpRz0oejXWdvYsXHZooFeIDCMKkUegk7HhcN1MuBDSbOZSxI3yoO
         I30mU0aw3EdFibjgJk5Ilu1dXpqBwje4t9bP1MrmTKcz84s/XD1V7zucG1nUSTTzG3Z/
         Z25jr7c8IORGJnc7DWRa8ctEL5/5uI81fFN1slRAMPFGvX3XXOQynr7AutBOnypYHHGM
         Abkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749132436; x=1749737236;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bBPY3uR+bO4v+Ow+fYUjExt4Hfd6bBkgHhHjvxvMr5U=;
        b=UnSgiJb3VUc04NvMpVX70l7O/21/E2F508TXGGbBVrcCgctVvbVXEWbvjzbg6TUfl8
         8NAwmnhBe3CMwdcxLIG03u2yk0ZgVKpBBSuPJwuMCPphom47ckvIpHpMRMV7KfDUEiKq
         LiebgLV0Pj1Xtqv3tUanxLI3rEU9zgu0I1ittHPPu+k0J62ipzK++EXBLFgLbK9vZ+p3
         zRtZ8QqJtVPJk4WUcROOXIxsBwWy1SYmFTEN9ci6+RnK8Jlri4IeNKHC7eAu7I7WXjEl
         x6z1+W+zOoUu/nfQ4rnM/2zQiyKymzePxNQFpkTw5hMRXqeSfe4WMqhIPS7zXzA47BsU
         Kvtg==
X-Gm-Message-State: AOJu0YwKV1amJqmFIGpqItKxwCz1vqboiarT+rAJa7DNa2pCdMKgqbs+
	efeNylyHIeX2ZcNslZGTWLof7WCZDTIvXkXBdJONgHV+bmPr3B8qbOpohoVNMWMVcUY=
X-Gm-Gg: ASbGncsOqAAK3fSfMKPAhpOBGlx2Zfv5F9vQ9wNoM6XLlz995zR0Dx4Gai3IwCMqJU5
	05EqouJBDtaaaltlQ6KZZa1vycxyrdFx0WzhCXt+/Or2VG56NXPJKjYy7VTko6t2aLT66CKvynn
	L7kveyQxcB+49Z+Ja5IWh8maz2ze5grM6FMFP8xMvXVRn6gFyTyqVW7VWDEOzyK9F7nPzBmW6Md
	Jww3zAe3CUlWIlhHxW33s9ejP5L0hrPdkiuq6FTpg4uQSoQEqGp5jGGpw1GngJ7PtUt8ojTR1TY
	DwWMkmQ7BLUjSlGZe9ISbeA38R74O19iYWcKhWiwz3L2Qw==
X-Google-Smtp-Source: AGHT+IEpGNl3AOrH7bpMjH9LvNKcpVb9swPiQIVeQ2Eah89eTkX84jf4LBdNCcDWZTxSxe41d7iuxw==
X-Received: by 2002:a05:600c:3e1a:b0:43c:fbbf:7bf1 with SMTP id 5b1f17b1804b1-451f0b54654mr77227285e9.30.1749132435986;
        Thu, 05 Jun 2025 07:07:15 -0700 (PDT)
Received: from localhost.localdomain ([105.113.85.244])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-451fe39fc52sm8827305e9.27.2025.06.05.07.07.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Jun 2025 07:07:15 -0700 (PDT)
From: Seyi Kuforiji <kuforiji98@gmail.com>
To: git@vger.kernel.org
Cc: ps@pks.im,
	phillip.wood@dunelm.org.uk,
	Seyi Kuforiji <kuforiji98@gmail.com>
Subject: [PATCH v4 01/10] t/unit-tests: implement clar specific reftable test helper functions
Date: Thu,  5 Jun 2025 15:06:35 +0100
Message-ID: <20250605140644.239199-2-kuforiji98@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250605140644.239199-1-kuforiji98@gmail.com>
References: <20250605140644.239199-1-kuforiji98@gmail.com>
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

