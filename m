Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B47D2882A1
	for <git@vger.kernel.org>; Fri, 26 Sep 2025 07:26:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758871563; cv=none; b=bAE9wkzA2EvyTtIkDTfsMXJBZHyvK8nnMUVL67IHvbDOi4miJ5YKKaPjJsJR5RQpEG/vEDDXpgfE4jOhqDrcN3x8Yiu7YM097BPD1fzeWVX1sZaRyAiIyoGFDoSRD1DR6PlQJ3O4m9di+xufFgikMgO+O7QbGWuNdmOZWdc0JXk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758871563; c=relaxed/simple;
	bh=SOrVFR/i+LcNfGKOPb2LImIUukjLiMfxrysbYO9PRBo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=AsMoqu2cmCrxACyP7wN5D3/0c4kzCcpjfNDlWrutyEGIGquLzcXom8kuz+NHEc7RViDIoq+ehEdt2GoL8xd8MrxW5EqZLAQcENfr+M4WXHlLB9RPQOFn92ajWjZ6/ZiE1IQcNDcfOjgRN20VgdzkVQ6OUUm0l0Ab2CrHiGd7tNw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fP1HMNsJ; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fP1HMNsJ"
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-61feb87fe26so2494848a12.1
        for <git@vger.kernel.org>; Fri, 26 Sep 2025 00:26:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758871560; x=1759476360; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dCM3lPPIgcnor7XGOXKw0QxQegyDi6R6fH9F+G4IR3M=;
        b=fP1HMNsJm7/wDvHPrO0liQVJ/jTaQhJIy/qYIICNnwRgUlo0NZerXvVRs58w2nMi1r
         K4V6Egynih6bGk5CEaNkErBFSMxS62DQOeltFZTv+LjzWlcqBKD50LH/nF0osIrjqal/
         9o8biPpnyKYqsAflJ92KiEkGklUFmo6SGEhxD90YQRflJNyoasHHwMXkz64hNarF9QPd
         lyTJER8+iwkLxlaTQRSiHeUABgr6Z6poz/XvMBey3drFvK73WVwf/YxCBbudGFgtiNCH
         YYTfJ0Yy3pLRh3tciLaUOFaq8DSsyHO+Weam7e+R90/38Ph8BG2ph1rLcRWW6Jf9gow+
         plEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758871560; x=1759476360;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dCM3lPPIgcnor7XGOXKw0QxQegyDi6R6fH9F+G4IR3M=;
        b=aw3fFTa5W9x+idK9UVEcWQHEfRkPEnEuHA2lY8RI4oHuj+TwmiyzOBqfcKt3OyWAxz
         5+EtQR/UhNMaZ+kD8oX51ScMfsAmNwqLR/S0tfI246jHLuhA8PKAZK6E4ZZay43bDZrU
         eihTFJHsZscWYfdDZxqCnfeZy29uUt46OwJ7a5iHBbIjfxgtvyVou4Ik+rrSkGnNo3Jn
         hLmHzVRuJK+rhWi6ONUkDJyFmeOPHqBAXD7QGYmFAtdEMCu04fh7gpDSLIUvL7eyPMAa
         PbfuHlEs3aeOopNYy00XctJFNMpFdHWZQl6jUATB4a+EIQ152UsYFV8Gj8V16AVlwsy5
         9mvQ==
X-Gm-Message-State: AOJu0YwTjqICl22edTB4WE6lnvFlZFHwv40C0o156uJKLoivowGFyzfA
	l2ZpKMwqCFQRfpftydLQgT+nFOkSVYzEkiIH94agIbmXvMAiTxZzD3o2
X-Gm-Gg: ASbGncuCagauiExn5haezOWLPmae+Y3gHDHdeDVdelB3FxzO0DM+u/WDu3pQgjhQerm
	U7sSTAXMtml9au9aT13EiaQUth6yrxnFCiGJ0K8kSkXdsIN6JsH4386+/z4gRM3ykcIN16hnirE
	VEVLUWRkvUYZ2WMgrS9smrdDhW6yKpnYVl5Z3Jy0DRlt1sjxMiWgecWBmdpNLAjDxVxfR8EqCfM
	X4JswNPeUsFEbnbNcjHrNXNipFIio0Ditn+Xhwhz+bdmrw13QuBx7NDYpIyvKf88ybLqt/Cbvzv
	PK5VSmPvKtnyhJiKh2CqStL5DWfDhNitx7DGK+kbSFY68dOCrlcmHHl3IEcu+bvbpUljC17NXG0
	B7ztgPBv8ksEa2h4lCccdCWfrDac29ZnTCN4hiOA=
X-Google-Smtp-Source: AGHT+IGhxFaDUeXo5iW/ilNwJl1hTloNMtQDMjSym1YNRLYi4Hx4b1UHcVBMbBVOn9chzm9LP+h2ZQ==
X-Received: by 2002:a05:6402:7d5:b0:61c:7090:c7de with SMTP id 4fb4d7f45d1cf-6349fa1c6a2mr3930575a12.13.1758871559477;
        Fri, 26 Sep 2025 00:25:59 -0700 (PDT)
Received: from [127.0.0.2] ([2a02:2455:8268:bc00:2fd5:3bfb:87f3:d768])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-634a3af54desm2368795a12.40.2025.09.26.00.25.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Sep 2025 00:25:58 -0700 (PDT)
From: Karthik Nayak <karthik.188@gmail.com>
Date: Fri, 26 Sep 2025 09:25:49 +0200
Subject: [PATCH v4 6/7] reftable: add code to facilitate consistency checks
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250926-228-reftable-introduce-consistency-checks-v4-6-c96fd8551c0d@gmail.com>
References: <20250926-228-reftable-introduce-consistency-checks-v4-0-c96fd8551c0d@gmail.com>
In-Reply-To: <20250926-228-reftable-introduce-consistency-checks-v4-0-c96fd8551c0d@gmail.com>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>, ps@pks.im, gitster@pobox.com, 
 shejialuo@gmail.com
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=6090; i=karthik.188@gmail.com;
 h=from:subject:message-id; bh=SOrVFR/i+LcNfGKOPb2LImIUukjLiMfxrysbYO9PRBo=;
 b=owJ4nAHtARL+kA0DAAoBPtWfJI5GjH8ByyZiAGjWQAAup8ZhNl52cPDOpsSDwXdukYiW76rop
 JdrifZzD906NokBswQAAQoAHRYhBFfOTH9jdXEPy2XGBj7VnySORox/BQJo1kAAAAoJED7VnySO
 Rox/tugL/iLdytMBiAJR9kHeY8tQeOKjC+5AzjHtsDWVC0WcT5xW4ll76Qm+6+pAJr2BswReBLW
 B3KTRATUrYW7dUwjeKbJhmsOJ9J3cJwSmIMy1EM2ohFoTOdNtMVTgTZgRX/XjGB2ShZGnG54d2O
 sctmWpUYtjMbWf0lLVHq55RQhPup/ZdT6VxgP8DXOUI2mviSLL3eyAySiUF4inDDOOP2rrcN1HD
 ivtmVG/YpELjQjWYHEX/KASvjle+zuRusZzh8LQosk/0uyd7MVCqZhgci040e9d4LZ0pc3Gzk2W
 zlC8QvJ1YKu3Hokij1br8mOq9zQX7IYvhVXs50V5Hn1oR5vEzDAX1MmMSvRE6edaDiMrscsw2qy
 umESluJp1NnJP2062NUYZLWugJCEobkpMCdggaWtZxNhHTu58sihLe/vxFujlEfiBkCsmyjteoi
 P6GsLhG2cSbas1H3l+Uq0jTmtnOgHphlJBV1ZuYXuP9Rx/vTHqxvJL3szeeFDub3CDiBY6Ux8p6
 f8=
X-Developer-Key: i=karthik.188@gmail.com; a=openpgp;
 fpr=57CE4C7F6375710FCB65C6063ED59F248E468C7F

The `git refs verify` command is used to run consistency checks on the
reference backends. This command is also invoked when users run 'git
fsck'. While the files-backend has some fsck checks added, the reftable
backend lacks such checks. Let's add the required infrastructure and a
check to test for the files present in the reftable directory.

Since the reftable library is treated as an independent library we
should ensure that the library code works independently without
knowledge about Git's internals. To do this, add both 'reftable/fsck.c'
and 'reftable/reftable-fsck.h'. Which provide an entry point
'reftable_fsck_check' for running fsck checks over a provided reftable
stack. The callee provides the function with callbacks to handle issue
and information reporting.

The added check, goes over all tables in the reftable stack validates
that they have a valid name. It not, it raises an error.

While here, move 'reftable/error.o' in the Makefile to retain
lexicographic ordering.

Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
---
 Makefile                 |   3 +-
 meson.build              |   1 +
 reftable/fsck.c          | 100 +++++++++++++++++++++++++++++++++++++++++++++++
 reftable/reftable-fsck.h |  40 +++++++++++++++++++
 4 files changed, 143 insertions(+), 1 deletion(-)

diff --git a/Makefile b/Makefile
index 4c95affadb..03fbaf2b21 100644
--- a/Makefile
+++ b/Makefile
@@ -2732,9 +2732,10 @@ XDIFF_OBJS += xdiff/xutils.o
 xdiff-objs: $(XDIFF_OBJS)
 
 REFTABLE_OBJS += reftable/basics.o
-REFTABLE_OBJS += reftable/error.o
 REFTABLE_OBJS += reftable/block.o
 REFTABLE_OBJS += reftable/blocksource.o
+REFTABLE_OBJS += reftable/error.o
+REFTABLE_OBJS += reftable/fsck.o
 REFTABLE_OBJS += reftable/iter.o
 REFTABLE_OBJS += reftable/merged.o
 REFTABLE_OBJS += reftable/pq.o
diff --git a/meson.build b/meson.build
index b3dfcc0497..8914252910 100644
--- a/meson.build
+++ b/meson.build
@@ -452,6 +452,7 @@ libgit_sources = [
   'reftable/error.c',
   'reftable/block.c',
   'reftable/blocksource.c',
+  'reftable/fsck.c',
   'reftable/iter.c',
   'reftable/merged.c',
   'reftable/pq.c',
diff --git a/reftable/fsck.c b/reftable/fsck.c
new file mode 100644
index 0000000000..26b9115b14
--- /dev/null
+++ b/reftable/fsck.c
@@ -0,0 +1,100 @@
+#include "basics.h"
+#include "reftable-fsck.h"
+#include "reftable-table.h"
+#include "stack.h"
+
+static bool table_has_valid_name(const char *name)
+{
+	const char *ptr = name;
+	char *endptr;
+
+	/* strtoull doesn't set errno on success */
+	errno = 0;
+
+	strtoull(ptr, &endptr, 16);
+	if (errno)
+		return false;
+	ptr = endptr;
+
+	if (*ptr != '-')
+		return false;
+	ptr++;
+
+	strtoull(ptr, &endptr, 16);
+	if (errno)
+		return false;
+	ptr = endptr;
+
+	if (*ptr != '-')
+		return false;
+	ptr++;
+
+	strtoul(ptr, &endptr, 16);
+	if (errno)
+		return false;
+	ptr = endptr;
+
+	if (strcmp(ptr, ".ref") && strcmp(ptr, ".log"))
+		return false;
+
+	return true;
+}
+
+typedef int (*table_check_fn)(struct reftable_table *table,
+			      reftable_fsck_report_fn report_fn,
+			      void *cb_data);
+
+static int table_check_name(struct reftable_table *table,
+			    reftable_fsck_report_fn report_fn,
+			    void *cb_data)
+{
+	if (!table_has_valid_name(table->name)) {
+		struct reftable_fsck_info info;
+
+		info.error = REFTABLE_FSCK_ERROR_TABLE_NAME;
+		info.msg = "invalid reftable table name";
+		info.path = table->name;
+
+		return report_fn(&info, cb_data);
+	}
+
+	return 0;
+}
+
+static int table_checks(struct reftable_table *table,
+			reftable_fsck_report_fn report_fn,
+			reftable_fsck_verbose_fn verbose_fn UNUSED,
+			void *cb_data)
+{
+	table_check_fn table_check_fns[] = {
+		table_check_name,
+		NULL,
+	};
+	int err = 0;
+
+	for (size_t i = 0; table_check_fns[i]; i++)
+		err |= table_check_fns[i](table, report_fn, cb_data);
+
+	return err;
+}
+
+int reftable_fsck_check(struct reftable_stack *stack,
+			reftable_fsck_report_fn report_fn,
+			reftable_fsck_verbose_fn verbose_fn,
+			void *cb_data)
+{
+	struct reftable_buf msg = REFTABLE_BUF_INIT;
+	int err = 0;
+
+	for (size_t i = 0; i < stack->tables_len; i++) {
+		reftable_buf_reset(&msg);
+		reftable_buf_addstr(&msg, "Checking table: ");
+		reftable_buf_addstr(&msg, stack->tables[i]->name);
+		verbose_fn(msg.buf, cb_data);
+
+		err |= table_checks(stack->tables[i], report_fn, verbose_fn, cb_data);
+	}
+
+	reftable_buf_release(&msg);
+	return err;
+}
diff --git a/reftable/reftable-fsck.h b/reftable/reftable-fsck.h
new file mode 100644
index 0000000000..007a392cf9
--- /dev/null
+++ b/reftable/reftable-fsck.h
@@ -0,0 +1,40 @@
+#ifndef REFTABLE_FSCK_H
+#define REFTABLE_FSCK_H
+
+#include "reftable-stack.h"
+
+enum reftable_fsck_error {
+	/* Invalid table name */
+	REFTABLE_FSCK_ERROR_TABLE_NAME = 0,
+	/* Used for bounds checking, must be last */
+	REFTABLE_FSCK_MAX_VALUE,
+};
+
+/* Represents an individual error encountered during the FSCK checks. */
+struct reftable_fsck_info {
+	enum reftable_fsck_error error;
+	const char *msg;
+	const char *path;
+};
+
+typedef int reftable_fsck_report_fn(struct reftable_fsck_info *info,
+				    void *cb_data);
+typedef void reftable_fsck_verbose_fn(const char *msg, void *cb_data);
+
+/*
+ * Given a reftable stack, perform consistency checks on the stack.
+ *
+ * If an issue is encountered, the issue is reported to the callee via the
+ * provided 'report_fn'. If the issue is non-recoverable the flow will not
+ * continue. If it is recoverable, the flow will continue and further issues
+ * will be reported as identified.
+ *
+ * The 'verbose_fn' will be invoked to provide verbose information about
+ * the progress and state of the consistency checks.
+ */
+int reftable_fsck_check(struct reftable_stack *stack,
+			reftable_fsck_report_fn report_fn,
+			reftable_fsck_verbose_fn verbose_fn,
+			void *cb_data);
+
+#endif /* REFTABLE_FSCK_H */

-- 
2.51.0

