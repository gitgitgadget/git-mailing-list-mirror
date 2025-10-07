Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6901E2DC78C
	for <git@vger.kernel.org>; Tue,  7 Oct 2025 12:11:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759839103; cv=none; b=rZBncO8oCSQmITgg1iT7POkoIEzKWv2VUOYllNhQpEhkrtBaco38XuTX+o1VLp1Q1uTr6giB4dAfyD8/rYKRYMwjSKzMAOnE+TI+cWgEzjiBm9xX/F+r7QMwu9MtecuiZ/QEA4ss/UMPlAQ4YhuMclxwBYe/8a/wjkH+59G84M8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759839103; c=relaxed/simple;
	bh=SOrVFR/i+LcNfGKOPb2LImIUukjLiMfxrysbYO9PRBo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=KIfYmfnG+vsw8B0wV/+p7uz+S1fLHYQKicl6o4sAX2IRs9FfzDECCVsLmvGxnjmE1UOjxS6ij2RHRMRdN5r/NzKrSB5xZ5CPfGDhgql69Om1xgKhIVy8Od6PaH033serg+0gfIezpXT+MXboWZzDNqtRp5E3Duvh7lSqi5Zrz9s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fyNH9TJc; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fyNH9TJc"
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-b457d93c155so1081422566b.1
        for <git@vger.kernel.org>; Tue, 07 Oct 2025 05:11:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759839100; x=1760443900; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dCM3lPPIgcnor7XGOXKw0QxQegyDi6R6fH9F+G4IR3M=;
        b=fyNH9TJcnK+NuhUhh67ZEz7EhjUPqkxo4XBwr87loq+NEAg8jafKfUlgEmuabSHCfM
         T6oUVfeE6KxBfdf1SoYITp10/+J0TqWGXzOJWRocKkb/Y9LYcGJsyIkibJiRptUo3P/D
         ABRsKL4ARXgmblhbKHkPd8pl849ue5ePbob43jUNXrsRr55UoTrcKoSJg3lsOqIccGeO
         umE8WbF3yr9AJd0F06pZGH1MvfZ5ovcY6VDU4VMgPCAoVrKllOpg53Qp9RXdWWC180v+
         ozrOWdzDd89nRYmNOCn2VlIaxjw0KeDyPn1TV+4EbFpc7hszNZnoGmIe7q9tNywiYwE8
         1Giw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759839100; x=1760443900;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dCM3lPPIgcnor7XGOXKw0QxQegyDi6R6fH9F+G4IR3M=;
        b=Y5vQR1pT2vDh9BJbCnNxM7UqC0RRg1ZJ3UC5i9Sw7jQPTNCoV0xrtccc1Y2GLjj4+k
         O3vP7jBenbj3x8BlZY7GOc3oFvUTLRJ1OYzUiSXd5GUHcsb2lNsbvOYYxZr/02pq4m+3
         jocpk6J9tqb+Ym/EOAfQL/oJfJzdSDQ7+07k2bHavL9h3FB35n5pFwglFWkWjg5ZTwhW
         17yl3RkaHOq/GBX60yCBCH+fyt6bmoe2fB1mlqS3uT23L4n7D+4X/NhFqd3MyGLvDwfP
         V6Iq9yca1B34Ze12TAlH1NMNH4NVNuUuc55NhLwbGpdVu0Uaqh72v0yFiGG8oMIt3XCy
         KySw==
X-Gm-Message-State: AOJu0YyjvVTA7KJX59zFVJcTkNhMbOTBpOi2jdr/q0PkvL80PYwtuYu0
	ZyuQHkGz4eMK3IDvDhRkst3DjFqJWM4uTodSxmGs7/fNNYWVf3Ct+3uA
X-Gm-Gg: ASbGnctxYGAAPu0qanbNQa2lARw+NSmAhq9bZhOegP2bHHousUVeG/qINgg+oMhb2Pi
	uSmOQXd/SfMtpQJDnPrOR6lbAC6U64dEItopDGJtk0ud4quUhNMohp7oYT8m5RtP49FoyUJPK3/
	LzR6U2crdHAkgT0G0y4JiWmFtdOr6x1Nqbcm41OYy6o5zfPPVEA6NC5TaqDxON8XrrjygW77/fg
	vl0t6NlS0TFPlUysk87hvigDyRi/r3Jev3rW0FEZ8iUvCqWK0ZDUHMgVxl22SBSAU1zawp1HT/n
	raLZIcGYvQKp5m5rQ5iNbGHKBtSzJrYozvMwdYQc4+NynXxKzStcZ7b4V+y+4w01INpE2nt/MTj
	wCl2EXYH1ipJAbqgCp03dWwobWeFSCWORax+19cfPpHRjL6ED
X-Google-Smtp-Source: AGHT+IFAsCiBaGLQYCWypLtcwVlegzAQ0rluSyHQ1xtc8gu96iK8+PV1xR/bnzHue0a/O+RoRVE8Bg==
X-Received: by 2002:a17:907:2d8c:b0:b45:44f4:30e1 with SMTP id a640c23a62f3a-b49c3445c6fmr1935684066b.34.1759839099528;
        Tue, 07 Oct 2025 05:11:39 -0700 (PDT)
Received: from [127.0.0.2] ([2a02:2455:8268:bc00:406:6e87:ed:4c93])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b486970b36fsm1367386866b.62.2025.10.07.05.11.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Oct 2025 05:11:38 -0700 (PDT)
From: Karthik Nayak <karthik.188@gmail.com>
Date: Tue, 07 Oct 2025 14:11:30 +0200
Subject: [PATCH v6 6/7] reftable: add code to facilitate consistency checks
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251007-228-reftable-introduce-consistency-checks-v6-6-638cff42f0b0@gmail.com>
References: <20251007-228-reftable-introduce-consistency-checks-v6-0-638cff42f0b0@gmail.com>
In-Reply-To: <20251007-228-reftable-introduce-consistency-checks-v6-0-638cff42f0b0@gmail.com>
To: git@vger.kernel.org
Cc: ps@pks.im, gitster@pobox.com, peff@peff.net, 
 Karthik Nayak <karthik.188@gmail.com>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=6090; i=karthik.188@gmail.com;
 h=from:subject:message-id; bh=SOrVFR/i+LcNfGKOPb2LImIUukjLiMfxrysbYO9PRBo=;
 b=owJ4nAHtARL+kA0DAAoBPtWfJI5GjH8ByyZiAGjlA3U8CZyCeg6g9cWXyPq3KU9QonMgSSHt9
 QWu2//NUPhuYIkBswQAAQoAHRYhBFfOTH9jdXEPy2XGBj7VnySORox/BQJo5QN1AAoJED7VnySO
 Rox/G8gMAKO2p+ocEMismcgdEtRwNISdzh9n6K8LEikp89pNKDLRTBBjD2l4TpsH9ZVLTBz+JaR
 2Xv4rsSU/ypIOXuqMtFA6JV+UHzu0WeoqBadtkjYqlgcFAzpaYFAEp2ZAaO8IywQTu6RccJHbzX
 wz4tnSdXsFIrqnSOYpX2Egli5RLArHWj3SpJpr6ZLxLxA0JTRpLhoKUh1eO4KYBn5VRT09NO6L2
 XoRBtJpD79/77xeMfEz2nSICjpk82pGgaIdeW0yc/af3qhdrADBgGYy9TNSwLdUimciEGaLNcYi
 sIpcOreBTrzDu+uiOx/hhvizup7BTmydqPbJBUt1R8XG/Sq7AfrvuLT1VF3xA7dJENl0m1O2mgm
 ceSGN8FuF4f+FEvruVRARpJ8usJK8nrBYx+oAGEJVLGvRBW0Mo8aIP6hpnJM7q0LKRpCQqyHUD9
 YAE9dU81+UDxLKXbQ+5X84nX4Re7wef4SumnFfGcf1Dvvn2spDAtxcB6qjgY1A4sQtAdwabOcP3
 KE=
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

