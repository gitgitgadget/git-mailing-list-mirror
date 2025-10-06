Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6618F2D5C83
	for <git@vger.kernel.org>; Mon,  6 Oct 2025 14:23:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759760593; cv=none; b=hF5snGbPz8Ibe6YLbylxy23n8LUgSzrRWoCmUdWRVTOJh1SuW1xZskmSMGkHjAl4a/0Aq0GEH4J28Bv3fuLXDu0U/NRfY9WwzO8j5w61B+l3c09Ei6uRsgZwX9JE7BVIsn9OugKXPC5ZBwpLOwDVM+Oo22zL+8WLxcZCUJo7Vz8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759760593; c=relaxed/simple;
	bh=SOrVFR/i+LcNfGKOPb2LImIUukjLiMfxrysbYO9PRBo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=OXJzOXa8zPjgZ3qsSckKXKLbXCnnrMNhgCKQHaMXprv9PKSKGKdO+Y2dNYJ/NxFb93/TxGvwrfgKxb7Q7Rewuarty/3KmfhDbwQbJMy0HADGGfVQisy1K8JCESQtS1ZH0Nosk7GV32c4wn5SSI392/3v1mom43C/HIBM0l/sd/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AA1mIQdr; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AA1mIQdr"
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-3ece0e4c5faso3697057f8f.1
        for <git@vger.kernel.org>; Mon, 06 Oct 2025 07:23:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759760589; x=1760365389; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dCM3lPPIgcnor7XGOXKw0QxQegyDi6R6fH9F+G4IR3M=;
        b=AA1mIQdrCTQ8K756TOpOKsm+5foLOEpJSPNxIAZHgkAON6YRmNCcFXZEoo9juuorFK
         ksTUIYSDxMZ3wXlrQQGttHxkOgeV4jUoEsTzi35FeAtdwohKGlCssvrmrQtsETUzYF3O
         UKOxKe7xi6BNpTCB8xeZiJ4umYT+2orn6PAvQcsCaxKvtn+Py+v5+pF/9eJ8f1sryrN3
         /xnEsm31jOQBR/cPPzV9bqe31cHQ9Qde6qfPi2s5ILQtDrNJrUnjYusmr6UTWHtCoPoK
         c1qu3Y4MHpRVfZhSyM14D4Y7f9byYrfP9fl+gkYtASYHXNToFD1D9K6563Yr+TeveTcg
         iPGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759760589; x=1760365389;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dCM3lPPIgcnor7XGOXKw0QxQegyDi6R6fH9F+G4IR3M=;
        b=QQEoFrwKY325u/Ly9FvZl/ih4VeaVtDavQOpTi7gTbxCSCFxFIMaYeT/lbt/CzJHLT
         N/7OC4jACR5bKzz12d+T8P+c6nqIk8tBjuRbaWPnI23Ydl2HyU5zSn4EMXVtC0SAg+3C
         Lbe19210N+NtlIkhWoeSwfCbojs9r3gJNNp5SZLSMeKLJSmED+l7l9JgUXWgXVM1jB3z
         jpC3Jk9clUxfzFVEot7F945pRY/pYbgJv2InXXj7pofS6AEAWgm+VpAtCn84mEQFo/Y1
         2KNqBzRYZbr4SRdg7GsqXIF952sowtJ/4TyAcmC8rpFxQA6igyahraEmJdREvEUNOtb+
         8hgA==
X-Gm-Message-State: AOJu0Ywg2ogv7czwtgDxF4vBxGPjBnTnUYSBU3WWWRgMPjSzb/zMT1bx
	PPNZ4noBMZJ9jvqnVBcAoUHrXJMAjOpfcYkfAAQwYaBFJH+Yzv640+Pi8d+gjVlo
X-Gm-Gg: ASbGncvhAuVHRb1tNTW0POb9eql0dqHeEJOoAFx9ZmIAZ8m1X2X2nijRuli1ExenwgK
	pmjVXyepdG68orLv+gZM0YawRi5CUWshPROEbyU+i7wNYgCkB/+7Qbcmr4fZMIWFbE/dkpnbt1K
	PNK9j6jpgAOcYAzrXXdJCCBTaPlmkmOdKD225ozFXxvclmG9y8aXzZUYfJ/CfLiuDWhZa8mi0vj
	wVQC5jNjpLJgon6Dn0LMMvtLDKXn54lHDP7hDB/J4kjWmCNrV1/6H3ONHEziXwg19u8r6NLcmAU
	k7SFKxsCU3dUuCd0Hierxn9TE9/lofqEIPMzN+ftEbanT0jvRqsgz2FTIR+MUn9OtKWJYt0C3/O
	9b75bNf1OvcnkzQrTXsYcb2OxHbT9VPaTm+XxfKEJGLUnP5tss5iNihw5rgQLr9Rh9/o=
X-Google-Smtp-Source: AGHT+IHpsKAnKfXz/xPhFbG3yiH8IBqGUFBc6G+f3TjpHUqASeM3OApTxNBpYDieslDf7KjvjVe1hQ==
X-Received: by 2002:a05:6000:43c6:10b0:415:7c56:30d9 with SMTP id ffacd0b85a97d-4256714d65dmr7124525f8f.23.1759760589065;
        Mon, 06 Oct 2025 07:23:09 -0700 (PDT)
Received: from [127.0.0.2] ([82.163.201.2])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-46e7234f547sm171237555e9.9.2025.10.06.07.23.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Oct 2025 07:23:08 -0700 (PDT)
From: Karthik Nayak <karthik.188@gmail.com>
Date: Mon, 06 Oct 2025 16:23:04 +0200
Subject: [PATCH v5 6/7] reftable: add code to facilitate consistency checks
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251006-228-reftable-introduce-consistency-checks-v5-6-f196d386214f@gmail.com>
References: <20251006-228-reftable-introduce-consistency-checks-v5-0-f196d386214f@gmail.com>
In-Reply-To: <20251006-228-reftable-introduce-consistency-checks-v5-0-f196d386214f@gmail.com>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>, ps@pks.im, gitster@pobox.com
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=6090; i=karthik.188@gmail.com;
 h=from:subject:message-id; bh=SOrVFR/i+LcNfGKOPb2LImIUukjLiMfxrysbYO9PRBo=;
 b=owJ4nAHtARL+kA0DAAoBPtWfJI5GjH8ByyZiAGjj0MbQqqDqqDvsnSoOEQxfmq5y7pX+p2LQk
 0k79KvFsk/wuIkBswQAAQoAHRYhBFfOTH9jdXEPy2XGBj7VnySORox/BQJo49DGAAoJED7VnySO
 Rox/AgUMAJs1wDoFwgfxGf1RvaijBY1aYU5RxVTOG5jix1SLYCaTmguDl+rewlwCgtzBK/JpyjJ
 SamUtquQacf8SQgLc6S1q8R2K7qvaqRjoKOEwm5JchXADNETCKXi9YKFmtDqukoRCu7eDcRd9Vr
 2KJs19U98od8iLxXgnc4p7y07sQtQXRa+q4vPz8+y4wta7S4f86Hq5Uhn1Quo+o0Lt8yeD2YSGI
 tRWUOcFhaqZ+zr3wyPPRZh+jO9dYCOOBzYlJYcIsYeJgFkcRELUk3Gp6AlafWQMraUSFPCHKVu7
 DYjrgEq0XzShKDCFieQJ+7caSzleYSJ3fBVtsvR2TALFt5jesKxphI7W5vtQeEkvv/P4+WGvIHb
 d9lbUNVAZF4Z9VrT/BT9pixKeY4w/tZUD8cBDmtmw8ZIxvqD0H2pm2uMyMnjY/zUUYEEIF1dnuG
 KdazJYX9I0uPDJh14ibuchndGSUxRaB8BNX0x/aLuQsz3ko3rreOgnvPPPhuXwNkQSPujCuDrf7
 pk=
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

