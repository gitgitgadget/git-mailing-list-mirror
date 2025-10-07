Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 480A42DE6F7
	for <git@vger.kernel.org>; Tue,  7 Oct 2025 12:11:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759839104; cv=none; b=ipTGjVXZYxWv8S3dbTpZevRbmY0SJHyhtx1O27GUAlAHLZif9SdL6ZXVvIbmzjH2kzevsM/V3txljiHHq7//eWXkzi1iiucJhGP6EapL1hS45lxHNvedcYM3RPmV6L8gbECWjPvfvGwfOrgsFNUsYtkZX78JrUwpAc/88e/Jcoc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759839104; c=relaxed/simple;
	bh=vSqHbopCE57sjNHVS9oNw22/X3C3wUUKxtLi18VBvvM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=mPKVglahZBSFWKo3d56m3RA2lxgLfAoGSKwCJI4xNQOBPY86qiJbvmPy9cdD/0N6dmexgLElUX1cT9QryPnk2y5/GYaXFHRy60QK3CkkYWof+BCHLFu9WLUMelS+dmtTT1kfDnMFmiYQt1VZIzV5WEHj7s1Ex0TLZZTbQJF3et4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PKv2ilIx; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PKv2ilIx"
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-637e2b86240so10571471a12.0
        for <git@vger.kernel.org>; Tue, 07 Oct 2025 05:11:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759839100; x=1760443900; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uYablZc1SswTWJs1vF7bmoS4Ustw3aGbWrW16TvPEXA=;
        b=PKv2ilIxsCtcUmNJA0QIcZRlI6fD4Dku8WBWa58qX4htgXKLigM53kUj1yumJA0FDF
         w7R0Q0q9SWdbcPFQ3lijiwMlsXZqgyhkIqvlyR4+OJEGwzxWYTGTq/aD0UOxRfKRUkZ4
         NrLWWj48t0HtxD6ebTo6cVUbCMOLN1PIS2UiIYOxrYyHwsykxOKtukDvnWRM2gt/wRbv
         M8+OfWV3BgIg6WLxJFFqgZ5insL7cX1wypYfG3WUh0i/eI57KuRWyNyaFMaKXfcXSUkO
         x0aB2oSlUZxvy2vV/RTfWJ7G9B8QchfGVoegFAoL+H0VrHX2OK+6qoXuTf12MRCLdhBM
         k5iQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759839100; x=1760443900;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uYablZc1SswTWJs1vF7bmoS4Ustw3aGbWrW16TvPEXA=;
        b=ESxsE1MxF4TlsVPEzHwlPDZ0Eb5Teh/eSkjpuDwa0Lt8lyIXKa7ZD5AwZ5Y7RIwPeR
         9akj4Zv8qJhCHHfuPcXrQdcbNALurCI1Wbb5t/O1NFa0lM018t6gDjKEfvup36OCUy0C
         2PJzC7bqB7I2ls+iKZD4+MtDfniGL7LtVbf/3ZWGvMjLdJb2n2FXCKQbq3Wx1YD0BRQ4
         XUgMsy3DYmu39gvko5mFTxCaHx9Q2Qtn122Zt7PVb7+vdrW5j4m9KtcsMmsW8hM9KTwM
         f8buWXhzZosUz36AM38KcDSgrW7QC+UyAeDrnuBuTD1F3wq4Gki4gEi5vOJUxCKcj7Hs
         RSwg==
X-Gm-Message-State: AOJu0Yzv2AxLrn2KB5zTBO+UGVQ221M27IBXUSu32A+rvucQQAGWqsdr
	11QLbTX0poLqPmabWyY2tM/3a2TCe9wC3PQRy7hzONmHLJWErAYg92Xx
X-Gm-Gg: ASbGnctSI+v+A9QgFV7zPpoAyY0+y11ni6JekwGUXd5v9ipA1RT35aIJ4OE99mSFOVZ
	eoniJjwzFcPqL3IgObKxQeLxs23+CZFQFCI5y8xNlzK663S4Jp89d/rGpSVkdmfeJt3QoYYIjWk
	4HduNj8yms2R6daJC1QI9/OVXV/4Aiv1QwurDXtX5mCeKY+Zj/aqXT93qXfSHeLpNKiRdtwLp42
	O8A/VNwoQdci8JmClgblEoEuMgErPF0vJD/Z256EnBXNut8Y4NGGOWkYGzr6rg7927LVZJ3oOoA
	Y71Te7dgfYcZjmd2vtx5QHHSNWyVlqgux1QmIDiX10XqGVCOYO+0JBGf6qgnxyUHOFs7aSo8oKh
	ucDDkQu/5PYyKdudreZRL7FBkYNq76ZlQR5KKHQrb2dxEOGA/
X-Google-Smtp-Source: AGHT+IHQGVVToppQ2BkyOM4m9qA1bxyW2YvomIbCeViMgQw28Fp5tacPPCtQ7seqNVwHgs1CyYQVlg==
X-Received: by 2002:a17:907:720b:b0:b3f:d9e9:bac7 with SMTP id a640c23a62f3a-b49c3f77be1mr1790367066b.53.1759839100355;
        Tue, 07 Oct 2025 05:11:40 -0700 (PDT)
Received: from [127.0.0.2] ([2a02:2455:8268:bc00:406:6e87:ed:4c93])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b486970b36fsm1367386866b.62.2025.10.07.05.11.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Oct 2025 05:11:40 -0700 (PDT)
From: Karthik Nayak <karthik.188@gmail.com>
Date: Tue, 07 Oct 2025 14:11:31 +0200
Subject: [PATCH v6 7/7] refs/reftable: add fsck check for checking the
 table name
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251007-228-reftable-introduce-consistency-checks-v6-7-638cff42f0b0@gmail.com>
References: <20251007-228-reftable-introduce-consistency-checks-v6-0-638cff42f0b0@gmail.com>
In-Reply-To: <20251007-228-reftable-introduce-consistency-checks-v6-0-638cff42f0b0@gmail.com>
To: git@vger.kernel.org
Cc: ps@pks.im, gitster@pobox.com, peff@peff.net, 
 Karthik Nayak <karthik.188@gmail.com>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=6737; i=karthik.188@gmail.com;
 h=from:subject:message-id; bh=vSqHbopCE57sjNHVS9oNw22/X3C3wUUKxtLi18VBvvM=;
 b=owJ4nAHtARL+kA0DAAoBPtWfJI5GjH8ByyZiAGjlA3V3y9SJIR4Khy/6Z9aUCVrTCFANK+PlZ
 fhAk/yRl6rBE4kBswQAAQoAHRYhBFfOTH9jdXEPy2XGBj7VnySORox/BQJo5QN1AAoJED7VnySO
 Rox/v0YL/3Bw/3RtXtalJMIo3KKf8lR0rRLeAjYWq7RT+JzDe1j/+nuY+VuAs/BhrcoyJcB2aI6
 x3QsqQt86Ub5vkenOQCQg5ZjbzldsA3no8yYhDE8QMtPkS4PF1eCm9grfE15YS430YT7HnklfL+
 uoMXaRfN++0hAbwaK9gXA+oubmaBrstcC99Ox9hG4gfz1fWl9V0WpE8kOC536m6uZomKB31xLW8
 lw+sLDg22iRS7EUOXsF2vls7/3E86FsRiHTlvBat+QDQ9/C+f7M0wQZAYrxDpt0ajTxzo9SxXPZ
 PlhuBw+xGBHXrPlU++fddAMslOl1M3KP6J8+bsoGj+0S9WH39Nvwi74P+CyG6F2dY3a+G1nu4Q5
 SxJ0QfLL3ntXeeQ65oB2O2DpOA+vDas4C7625A4a3Ry2/P/z4onWNSx0/adGH7TurIshXczuesC
 nu4+X0IOAoa4LKXEwz6TTXPNnv8EyJnXhmUWQw5dm+7l/Tm6DXWQnG9iNqflilVmAyhZx5VCb7+
 LE=
X-Developer-Key: i=karthik.188@gmail.com; a=openpgp;
 fpr=57CE4C7F6375710FCB65C6063ED59F248E468C7F

Add glue code in 'refs/reftable-backend.c' which calls the reftable
library to perform the fsck checks. Here we also map the reftable errors
to Git' fsck errors.

Introduce a check to validate table names for a given reftable stack.
Also add 'badReftableTableName' as a corresponding error within Git. The
reftable specification mentions:

  It suggested to use
  ${min_update_index}-${max_update_index}-${random}.ref as a naming
  convention.

So treat non-conformant file names as warnings.

While adding the fsck header to 'refs/reftable-backend.c', modify the
list to maintain lexicographical ordering.

Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
---
 Documentation/fsck-msgids.adoc |  3 +++
 fsck.h                         |  1 +
 refs/reftable-backend.c        | 57 +++++++++++++++++++++++++++++++++++++----
 t/meson.build                  |  1 +
 t/t0614-reftable-fsck.sh       | 58 ++++++++++++++++++++++++++++++++++++++++++
 5 files changed, 115 insertions(+), 5 deletions(-)

diff --git a/Documentation/fsck-msgids.adoc b/Documentation/fsck-msgids.adoc
index 1c912615f9..81f11ba125 100644
--- a/Documentation/fsck-msgids.adoc
+++ b/Documentation/fsck-msgids.adoc
@@ -38,6 +38,9 @@
 `badReferentName`::
 	(ERROR) The referent name of a symref is invalid.
 
+`badReftableTableName`::
+	(WARN) A reftable table has an invalid name.
+
 `badTagName`::
 	(INFO) A tag has an invalid format.
 
diff --git a/fsck.h b/fsck.h
index 6b0db235e0..759df97655 100644
--- a/fsck.h
+++ b/fsck.h
@@ -73,6 +73,7 @@ enum fsck_msg_type {
 	FUNC(UNKNOWN_TYPE, ERROR) \
 	FUNC(ZERO_PADDED_DATE, ERROR) \
 	/* warnings */ \
+	FUNC(BAD_REFTABLE_TABLE_NAME, WARN) \
 	FUNC(EMPTY_NAME, WARN) \
 	FUNC(FULL_PATHNAME, WARN) \
 	FUNC(HAS_DOT, WARN) \
diff --git a/refs/reftable-backend.c b/refs/reftable-backend.c
index 2152349cb9..b106fd8b53 100644
--- a/refs/reftable-backend.c
+++ b/refs/reftable-backend.c
@@ -6,6 +6,7 @@
 #include "../config.h"
 #include "../dir.h"
 #include "../environment.h"
+#include "../fsck.h"
 #include "../gettext.h"
 #include "../hash.h"
 #include "../hex.h"
@@ -15,10 +16,11 @@
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
@@ -2707,11 +2709,56 @@ static int reftable_be_reflog_expire(struct ref_store *ref_store,
 	return ret;
 }
 
-static int reftable_be_fsck(struct ref_store *ref_store UNUSED,
-			    struct fsck_options *o UNUSED,
+static void reftable_fsck_verbose_handler(const char *msg, void *cb_data)
+{
+	struct fsck_options *o = cb_data;
+
+	if (o->verbose)
+		fprintf_ln(stderr, "%s", msg);
+}
+
+static const enum fsck_msg_id fsck_msg_id_map[] = {
+	[REFTABLE_FSCK_ERROR_TABLE_NAME] = FSCK_MSG_BAD_REFTABLE_TABLE_NAME,
+};
+
+static int reftable_fsck_error_handler(struct reftable_fsck_info *info,
+				       void *cb_data)
+{
+	struct fsck_ref_report report = { .path = info->path };
+	struct fsck_options *o = cb_data;
+	enum fsck_msg_id msg_id;
+
+	if (info->error < 0 || info->error >= REFTABLE_FSCK_MAX_VALUE)
+		BUG("unknown fsck error: %d", (int)info->error);
+
+	msg_id = fsck_msg_id_map[info->error];
+
+	if (!msg_id)
+		BUG("fsck_msg_id value missing for reftable error: %d", (int)info->error);
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
+	ret |= reftable_fsck_check(refs->main_backend.stack, reftable_fsck_error_handler,
+				   reftable_fsck_verbose_handler, o);
+
+	strmap_for_each_entry(&refs->worktree_backends, &iter, entry) {
+		struct reftable_backend *b = (struct reftable_backend *)entry->value;
+		ret |= reftable_fsck_check(b->stack, reftable_fsck_error_handler,
+					   reftable_fsck_verbose_handler, o);
+	}
+
+	return ret;
 }
 
 struct ref_storage_be refs_be_reftable = {
diff --git a/t/meson.build b/t/meson.build
index 7974795fe4..ec1fc0b2a1 100644
--- a/t/meson.build
+++ b/t/meson.build
@@ -146,6 +146,7 @@ integration_tests = [
   't0611-reftable-httpd.sh',
   't0612-reftable-jgit-compatibility.sh',
   't0613-reftable-write-options.sh',
+  't0614-reftable-fsck.sh',
   't1000-read-tree-m-3way.sh',
   't1001-read-tree-m-2way.sh',
   't1002-read-tree-m-u-2way.sh',
diff --git a/t/t0614-reftable-fsck.sh b/t/t0614-reftable-fsck.sh
new file mode 100755
index 0000000000..85cc47d67e
--- /dev/null
+++ b/t/t0614-reftable-fsck.sh
@@ -0,0 +1,58 @@
+#!/bin/sh
+
+test_description='Test reftable backend consistency check'
+
+GIT_TEST_DEFAULT_REF_FORMAT=reftable
+export GIT_TEST_DEFAULT_REF_FORMAT
+
+. ./test-lib.sh
+
+test_expect_success "no errors reported on a well formed repository" '
+	test_when_finished "rm -rf repo" &&
+	git init repo &&
+	(
+		cd repo &&
+		git commit --allow-empty -m initial &&
+
+		for i in $(test_seq 20)
+		do
+			git update-ref refs/heads/branch-$i HEAD || return 1
+		done &&
+
+		# The repository should end up with multiple tables.
+		test_line_count ">" 1 .git/reftable/tables.list &&
+
+		git refs verify 2>err &&
+		test_must_be_empty err
+	)
+'
+
+for TABLE_NAME in "foo-bar-e4d12d59.ref" \
+	"0x00000000zzzz-0x00000000zzzz-e4d12d59.ref" \
+	"0x000000000001-0x000000000002-e4d12d59.abc" \
+	"0x000000000001-0x000000000002-e4d12d59.refabc"; do
+	test_expect_success "table name $TABLE_NAME should be checked" '
+		test_when_finished "rm -rf repo" &&
+		git init repo &&
+		(
+			cd repo &&
+			git commit --allow-empty -m initial &&
+
+			git refs verify 2>err &&
+			test_must_be_empty err &&
+
+			EXISTING_TABLE=$(head -n1 .git/reftable/tables.list) &&
+			mv ".git/reftable/$EXISTING_TABLE" ".git/reftable/$TABLE_NAME" &&
+			sed "s/${EXISTING_TABLE}/${TABLE_NAME}/g" .git/reftable/tables.list > tables.list &&
+			mv tables.list .git/reftable/tables.list &&
+
+			git refs verify 2>err &&
+			cat >expect <<-EOF &&
+			warning: ${TABLE_NAME}: badReftableTableName: invalid reftable table name
+			EOF
+			test_cmp expect err
+		)
+	'
+done
+
+test_done

-- 
2.51.0

