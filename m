Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DD7C2E1EFD
	for <git@vger.kernel.org>; Tue,  2 Sep 2025 07:05:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756796741; cv=none; b=C8GZhxdPnSPUe4dxjZjeL3abs9CI+ZufzjwbDSu9xtuPU7FDzIPGbTkwrsH7yUvPpae+IqXv6HDBgKwUj2AOGUM9Asz6eeGK4ihlQXdj05Kpyb9v4wK+/YnPHgxzq91lZQ+OSibKcing2HxtdqWFEQH6NLc3M5LtCftAVmGYAJE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756796741; c=relaxed/simple;
	bh=D8mZZYo46ys5GPCstoZTtonVcmmzs170LsYeDyQoMQI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=uRYBLqjeHYXxnFgxOD6oOI7Gr6DpVJE10khqF6UvRUUmZSFiA0uwRu7MhRLQFR5IJYYfsyqI0nr5GmB5PjrUozCGdiTSUoi0kZdvMD6VhFzt/Nd4jY2Yp3Ag4jLVm21FdG40UCF2umiBOZq4CMpUez0RUIcsKuUH278by5Vcd7w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EAvpaZEw; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EAvpaZEw"
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-b043da5a55fso175417666b.0
        for <git@vger.kernel.org>; Tue, 02 Sep 2025 00:05:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756796737; x=1757401537; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7dCbGL/LtF8K+zGs6PbzDgg4Iaksbdk6gaCuLlDdRJM=;
        b=EAvpaZEwRTOmTOww4S6vZS2uV0itopMs2Z1tnWfkPNCIIp1Ho9WDXfnBU9qs+EuzK3
         jiIGfH2yXTRkT603FFzigTB+Y06s8vNceEvLUNzT0uJMIBHl5Gbfl5/GMYvrJkuYeMir
         s2zlbrYMzs5kk+Mq+NIcqGHQB1niyknVEa3K10RiyjHhUPu1nRLEDMXykUynvK7ayUPr
         UyzjBTNACFIE0SqKD/+reHtEc9SGhpVmPvYXmVlJeGVURR/3H7Wqdt3Iux102gJ+GhPB
         8x/7JA0Aw0eYRKeSOFnOZwA8zWlV8QYk85NkY+DIJeGcO4Qvxv1P+Re18Hdotsb9hQ4h
         zOcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756796737; x=1757401537;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7dCbGL/LtF8K+zGs6PbzDgg4Iaksbdk6gaCuLlDdRJM=;
        b=n3o8bG/yp4fCF8mc51KIhsE+R109yC5uhkkQ2CHBjkMh4blS48TiQFt/rr9u3T5CB+
         Nd7gnQx2nzUKO3iIp3eLM94agtFaC3tiSUDj2d7+d59METj/7ltEQO6oV093bqY/TuBp
         0Rk4I55FpjhgH3F+aXEVL2Za5QJFk3hv7j8TNm77pZsFfm2WhMIc9LX74qrUAruu/nBq
         q86TS2T/BCwKIpDck+Wl9jtRvC2XV0SB4uZgJcuyxpTeMKhRAQiI99xD3B3+5Dsh0BkV
         RnKDV4q9vQVIwvRdMIKdM8NweynaSt14j4DOgn9WkOdEalKKzbfmE1cXZlcwLh444VjD
         ZkCQ==
X-Gm-Message-State: AOJu0YwOFcRXDkN/BgnOtLgiTcVbbUs8946TsCh5X1mhvAWvhb5sc7zk
	tWGRB8YPnPkouXuxRzY95cCklqfwuqM+J4btYhzj0E27xP3mpAXA1cvFZOCR3w==
X-Gm-Gg: ASbGncv3mTaiEUZRCxKSVM3YSMpYFKcszhAgW7G5HbWes7VsgrSVRb79cZVlGVmdqHd
	aGF4Gi1zCF1gauSlKsh3u4xNP2HOpKBWxNxQq85tBYaHlT/r7vx4+u2dwdxpNOH1i6J0Pv05AMy
	IAoQ0k0fWaqhFFHni8zeBMdkZPOXjCvmVh+rlutrHDBn+RIamCu4QYNLdZIoTKVKrXiSAQhZlRN
	AZ6PzWfQw3xvvIPWJ1lM9vzK2Kw/RkG6xDbWZ3cNycxhVI9R49auypYJnxS/X1NXQbczYg/TfzR
	J+hRr4RMhh61H3RAweDqoLkWQgqMDkAzPrNufIbvhqNgCCldfLBvoRd+iVya0ni95b2uHbfa9Zq
	pMe3u8AVcc+LkneRRFDPMysb5UzneJnCvuVo+7sM=
X-Google-Smtp-Source: AGHT+IFs2Bzo3yGMFpo7cUx7T7V9r62Ctdr0+Nczmr5mzgYLjkYwTFGnFzIStgBZTnH790qeKxNxKg==
X-Received: by 2002:a17:906:694a:b0:b04:25ae:6c76 with SMTP id a640c23a62f3a-b0425ae7255mr481024566b.47.1756796737172;
        Tue, 02 Sep 2025 00:05:37 -0700 (PDT)
Received: from [127.0.0.2] ([2a02:2455:8268:bc00:39c9:1f0d:23f0:502f])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aff9918dbd2sm821575866b.103.2025.09.02.00.05.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Sep 2025 00:05:36 -0700 (PDT)
From: Karthik Nayak <karthik.188@gmail.com>
Date: Tue, 02 Sep 2025 09:05:22 +0200
Subject: [PATCH v2 2/5] refs/reftable: add fsck check for checking the
 table name
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250902-228-reftable-introduce-consistency-checks-v2-2-4f96b3834779@gmail.com>
References: <20250902-228-reftable-introduce-consistency-checks-v2-0-4f96b3834779@gmail.com>
In-Reply-To: <20250902-228-reftable-introduce-consistency-checks-v2-0-4f96b3834779@gmail.com>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>, jltobler@gmail.com, 
 shejialuo@gmail.com
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=11644;
 i=karthik.188@gmail.com; h=from:subject:message-id;
 bh=D8mZZYo46ys5GPCstoZTtonVcmmzs170LsYeDyQoMQI=;
 b=owJ4nAHtARL+kA0DAAoBPtWfJI5GjH8ByyZiAGi2lz1PjRDDog9kGsslxCWrTSBT95ec03wJC
 ykJA7eMJYkbAokBswQAAQoAHRYhBFfOTH9jdXEPy2XGBj7VnySORox/BQJotpc9AAoJED7VnySO
 Rox/zEsL/R1taoOraX7n/f2TGddAd0SyIJsbX0clxu2Eqwqyze7jG+Dt2U29Tpy6ZfJs7D0rlim
 10kbT0Bcmi90mD8PNFimetPvFT4GcK5xhSxpGJRpjFGvkZzkjov518/rSITW2Mc4CzaI7Nz09so
 28BAZoE3eWWS6c46hYANaLvfnmRNKiQD/nAeYD86SE2I+VrokMA44uBba+CcXIrQx0fgR9hc5qO
 Rb4QG8Bg0G1/LtWGUABF4sM0Ui/viWupnLKjkSCl9Hgny+SetFD/Jb28mAWAJTBQAufjXhRRI6n
 5n8MIkJM8dhow+CpK0iVp0//srEe0fzFjgrB1ntVPG0PH0x5jnGMS/s/FBp5ctG1xLvQMsg7o/D
 ddfPY6R6f/2YxtztuzNq+z4pPEENQdbQmC6mOIeeHpN8hTgeKx87M01Y6po7dfKjFzDWurkpVi0
 FmI9il3cnVrHiGYs29GDN2HRao37emgbP+TnAqhNoI9j5SEZCTS21apoT/PAHLa/1hlDyaNk/55
 0Y=
X-Developer-Key: i=karthik.188@gmail.com; a=openpgp;
 fpr=57CE4C7F6375710FCB65C6063ED59F248E468C7F

The `git refs verify` command is used to run fsck checks on the
reference backends. This command is also invoked when users run 'git
fsck'. While the files-backend has some fsck checks added, the reftable
backend lacks such checks. Let's add the required infrastructure and a
check to test for the table names in the 'tables.list' of reftables.

For the infrastructure, since the reftable library is treated as an
independent library we should ensure that the library code works
independently without knowledge about Git's internals. To do this,
add both 'reftable/fsck.c' and 'reftable/reftable-fsck.h'. Which
provide an entry point 'reftable_fsck_check' for running fsck checks
over a provided reftable stack. The callee provides the function with
callbacks to handle issue and information reporting.

Add glue code in 'refs/reftable-backend.c' which calls the reftable
library to perform the fsck checks. Here we also map the reftable errors
to Git' fsck errors.

Introduce a check to validate table names for a given reftable stack.
Also add 'badReftableTableName' as a corresponding error within Git. Add
a test to check for this behavior.

While here, remove a unused header `#include "../lockfile.h"` from
'refs/reftable-backend.c'.

Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
---
 Documentation/fsck-msgids.adoc |  3 +++
 Makefile                       |  1 +
 fsck.h                         |  1 +
 meson.build                    |  1 +
 refs/reftable-backend.c        | 57 ++++++++++++++++++++++++++++++++++++-----
 reftable/fsck.c                | 53 ++++++++++++++++++++++++++++++++++++++
 reftable/reftable-fsck.h       | 38 +++++++++++++++++++++++++++
 t/meson.build                  |  3 ++-
 t/t0614-reftable-fsck.sh       | 58 ++++++++++++++++++++++++++++++++++++++++++
 9 files changed, 208 insertions(+), 7 deletions(-)

diff --git a/Documentation/fsck-msgids.adoc b/Documentation/fsck-msgids.adoc
index 1c912615f9..784ddc0df5 100644
--- a/Documentation/fsck-msgids.adoc
+++ b/Documentation/fsck-msgids.adoc
@@ -38,6 +38,9 @@
 `badReferentName`::
 	(ERROR) The referent name of a symref is invalid.
 
+`badReftableTableName`::
+	(ERROR) A reftable table has an invalid name.
+
 `badTagName`::
 	(INFO) A tag has an invalid format.
 
diff --git a/Makefile b/Makefile
index e11340c1ae..f2ddcc8d7c 100644
--- a/Makefile
+++ b/Makefile
@@ -2733,6 +2733,7 @@ REFTABLE_OBJS += reftable/error.o
 REFTABLE_OBJS += reftable/block.o
 REFTABLE_OBJS += reftable/blocksource.o
 REFTABLE_OBJS += reftable/iter.o
+REFTABLE_OBJS += reftable/fsck.o
 REFTABLE_OBJS += reftable/merged.o
 REFTABLE_OBJS += reftable/pq.o
 REFTABLE_OBJS += reftable/record.o
diff --git a/fsck.h b/fsck.h
index 559ad57807..5901f944a1 100644
--- a/fsck.h
+++ b/fsck.h
@@ -34,6 +34,7 @@ enum fsck_msg_type {
 	FUNC(BAD_PACKED_REF_HEADER, ERROR)                         \
 	FUNC(BAD_PARENT_SHA1, ERROR)                               \
 	FUNC(BAD_REFERENT_NAME, ERROR)                             \
+	FUNC(BAD_REFTABLE_TABLE_NAME, ERROR)                       \
 	FUNC(BAD_REF_CONTENT, ERROR)                               \
 	FUNC(BAD_REF_FILETYPE, ERROR)                              \
 	FUNC(BAD_REF_NAME, ERROR)                                  \
diff --git a/meson.build b/meson.build
index 5dd299b496..82879fbfaa 100644
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
diff --git a/refs/reftable-backend.c b/refs/reftable-backend.c
index 8dae1e1112..c38c6422f8 100644
--- a/refs/reftable-backend.c
+++ b/refs/reftable-backend.c
@@ -6,20 +6,21 @@
 #include "../config.h"
 #include "../dir.h"
 #include "../environment.h"
+#include "../fsck.h"
 #include "../gettext.h"
 #include "../hash.h"
 #include "../hex.h"
 #include "../iterator.h"
 #include "../ident.h"
-#include "../lockfile.h"
 #include "../object.h"
 #include "../path.h"
 #include "../refs.h"
 #include "../reftable/reftable-basics.h"
-#include "../reftable/reftable-stack.h"
-#include "../reftable/reftable-record.h"
 #include "../reftable/reftable-error.h"
+#include "../reftable/reftable-fsck.h"
 #include "../reftable/reftable-iterator.h"
+#include "../reftable/reftable-record.h"
+#include "../reftable/reftable-stack.h"
 #include "../repo-settings.h"
 #include "../setup.h"
 #include "../strmap.h"
@@ -2675,11 +2676,55 @@ static int reftable_be_reflog_expire(struct ref_store *ref_store,
 	return ret;
 }
 
-static int reftable_be_fsck(struct ref_store *ref_store UNUSED,
-			    struct fsck_options *o UNUSED,
+static void reftable_fsck_verbose_handler(const char *msg, void *cb_data)
+{
+	struct fsck_options *o = cb_data;
+
+	if (o->verbose)
+		fprintf_ln(stderr, "%s", _(msg));
+}
+
+static int reftable_fsck_error_handler(struct reftable_fsck_info *info,
+				       void *cb_data)
+{
+	struct fsck_ref_report report = { .path = info->path };
+	struct fsck_options *o = cb_data;
+	enum fsck_msg_id msg_id;
+
+	switch (info->error) {
+	case REFTABLE_FSCK_ERROR_TABLE_NAME:
+		msg_id = FSCK_MSG_BAD_REFTABLE_TABLE_NAME;
+		break;
+	default:
+		BUG("unknown fsck error: %d", info->error);
+	}
+
+	return fsck_report_ref(o, &report, msg_id, "%s", info->msg);
+}
+
+static int reftable_be_fsck(struct ref_store *ref_store, struct fsck_options *o,
 			    struct worktree *wt UNUSED)
 {
-	return 0;
+	struct reftable_ref_store *refs;
+	struct strmap_entry *entry;
+	struct hashmap_iter iter;
+	int ret = 0;
+
+	refs = reftable_be_downcast(ref_store, REF_STORE_READ, "fsck");
+
+	if (o->verbose)
+		fprintf_ln(stderr, _("Checking references consistency"));
+
+	ret |= reftable_fsck_check(refs->main_backend.stack, reftable_fsck_error_handler,
+				  reftable_fsck_verbose_handler, o);
+
+	strmap_for_each_entry(&refs->worktree_backends, &iter, entry) {
+		struct reftable_backend *b = (struct reftable_backend *)entry->value;
+		ret |= reftable_fsck_check(b->stack, reftable_fsck_error_handler,
+					  reftable_fsck_verbose_handler, o);
+	}
+
+	return ret;
 }
 
 struct ref_storage_be refs_be_reftable = {
diff --git a/reftable/fsck.c b/reftable/fsck.c
new file mode 100644
index 0000000000..4282b1413e
--- /dev/null
+++ b/reftable/fsck.c
@@ -0,0 +1,53 @@
+#include "basics.h"
+#include "reftable-fsck.h"
+#include "stack.h"
+
+int reftable_fsck_check(struct reftable_stack *stack,
+			reftable_fsck_report_fn report_fn,
+			reftable_fsck_verbose_fn verbose_fn,
+			void *cb_data)
+{
+
+	char **names = NULL;
+	uint64_t min, max;
+	int err = 0;
+
+	if (stack == NULL)
+		goto out;
+
+	err = read_lines(stack->list_file, &names);
+	if (err < 0)
+		goto out;
+
+	verbose_fn("Checking reftable table names", cb_data);
+
+	for (size_t i = 0; names[i]; i++) {
+		struct reftable_fsck_info info = {
+			.error = REFTABLE_FSCK_ERROR_TABLE_NAME,
+			.path = names[i],
+		};
+		uint32_t rnd;
+		/*
+		 * We want to match the tail '.ref'. One extra byte to ensure
+		 * that there is no unexpected extra character and one byte for
+		 * the null terminator added by sscanf.
+		 */
+		char tail[6];
+
+		if (sscanf(names[i], "0x%012" PRIx64 "-0x%012" PRIx64 "-%08x%5s",
+			   &min, &max, &rnd, tail) != 4) {
+			info.msg = "invalid reftable table name";
+			err = report_fn(&info, cb_data);
+			continue;
+		}
+
+		if (strcmp(tail, ".ref")) {
+			info.msg = "invalid reftable table extension";
+			err = report_fn(&info, cb_data);
+		}
+	}
+
+out:
+	free_names(names);
+	return err;
+}
diff --git a/reftable/reftable-fsck.h b/reftable/reftable-fsck.h
new file mode 100644
index 0000000000..4cf0053234
--- /dev/null
+++ b/reftable/reftable-fsck.h
@@ -0,0 +1,38 @@
+#ifndef REFTABLE_FSCK_H
+#define REFTABLE_FSCK_H
+
+#include "reftable-stack.h"
+
+enum reftable_fsck_error {
+	/* Invalid table name */
+	REFTABLE_FSCK_ERROR_TABLE_NAME = -1,
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
+ * Given a reftable stack, perform FSCK check on the stack.
+ *
+ * If an issue is encountered, the issue is reported to the callee via the
+ * provided 'report_fn'. If the issue is non-recoverable the flow will not
+ * continue. If it is recoverable, the flow will continue and further issues
+ * will be reported as identified.
+ *
+ * The 'verbose_fn' will be invoked to provide verbose information about
+ * the progress and state of the FSCK checks.
+ */
+int reftable_fsck_check(struct reftable_stack *stack,
+			reftable_fsck_report_fn report_fn,
+			reftable_fsck_verbose_fn verbose_fn,
+			void *cb_data);
+
+#endif /* REFTABLE_FSCK_H */
diff --git a/t/meson.build b/t/meson.build
index bbeba1a8d5..a8eb44eb30 100644
--- a/t/meson.build
+++ b/t/meson.build
@@ -145,6 +145,7 @@ integration_tests = [
   't0611-reftable-httpd.sh',
   't0612-reftable-jgit-compatibility.sh',
   't0613-reftable-write-options.sh',
+  't0614-reftable-fsck.sh',
   't1000-read-tree-m-3way.sh',
   't1001-read-tree-m-2way.sh',
   't1002-read-tree-m-u-2way.sh',
@@ -1214,4 +1215,4 @@ if perl.found() and time.found()
       timeout: 0,
     )
   endforeach
-endif
\ No newline at end of file
+endif
diff --git a/t/t0614-reftable-fsck.sh b/t/t0614-reftable-fsck.sh
new file mode 100755
index 0000000000..81d30df2d7
--- /dev/null
+++ b/t/t0614-reftable-fsck.sh
@@ -0,0 +1,58 @@
+#!/bin/sh
+
+test_description='Test reftable backend consistency check'
+
+GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
+export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
+GIT_TEST_DEFAULT_REF_FORMAT=reftable
+export GIT_TEST_DEFAULT_REF_FORMAT
+
+. ./test-lib.sh
+
+test_expect_success 'table name should be checked' '
+	test_when_finished "rm -rf repo" &&
+	git init repo &&
+	(
+		cd repo &&
+		git commit --allow-empty -m initial &&
+
+		git refs verify 2>err &&
+		test_must_be_empty err &&
+
+		TABLE_NAME=$(cat .git/reftable/tables.list | head -n1) &&
+		sed "1s/^/extra/" .git/reftable/tables.list >.git/reftable/tables.list.tmp &&
+		mv .git/reftable/tables.list.tmp .git/reftable/tables.list &&
+		mv .git/reftable/${TABLE_NAME} .git/reftable/extra${TABLE_NAME} &&
+
+		test_must_fail git refs verify 2>err &&
+		cat >expect <<-EOF &&
+		error: extra${TABLE_NAME}: badReftableTableName: invalid reftable table name
+		EOF
+		test_cmp expect err
+	)
+'
+
+test_expect_success 'table name should be checked' '
+	test_when_finished "rm -rf repo" &&
+	git init repo &&
+	(
+		cd repo &&
+		git commit --allow-empty -m initial &&
+
+		git refs verify 2>err &&
+		test_must_be_empty err &&
+
+		TABLE_NAME=$(cat .git/reftable/tables.list | head -n1) &&
+		sed "1s/$/extra/" .git/reftable/tables.list >.git/reftable/tables.list.tmp &&
+		mv .git/reftable/tables.list.tmp .git/reftable/tables.list &&
+		mv .git/reftable/${TABLE_NAME} .git/reftable/${TABLE_NAME}extra &&
+
+		test_must_fail git refs verify 2>err &&
+		cat >expect <<-EOF &&
+		error: ${TABLE_NAME}extra: badReftableTableName: invalid reftable table extension
+		EOF
+		test_cmp expect err
+	)
+'
+
+test_done

-- 
2.50.1

