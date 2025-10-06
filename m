Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1073B2D63FF
	for <git@vger.kernel.org>; Mon,  6 Oct 2025 14:23:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759760594; cv=none; b=Ql0fvDr1tfhzksE5fufCtTl7q5G675/L2O+q3D5AEVIidvx1BQHZcdNIq1O2v3PZrCIQJmZ4X/F/styTQSDlJ8iYb8v4KFTp6WffnOCd12UtuM0RkP2BqdEfcf6TC0meps1q1Y4PPEQGPkNIo4wwQA9Gvn3DFA1cH/jVUWb9v5k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759760594; c=relaxed/simple;
	bh=JxnDDcb2Wno8TzizsxTtRdbzlz0tC4g1+xYYPjCM68k=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=U7nNXYHi7bQm0HvFQx94mzDcQ3m3Hu0jSjTJluatszHOgRe4d8RmmK1yB1IhLodtkVrUXQK27JphUCxrIF54bAi82d1NkdJoJ3yChK09umc4T2/uWSqpn1+40EE/0YLeZrS5TdpV0cqI2gZoiewU1EZIOwAXpK2TV7dj8cd4I3Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bDA9dxSN; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bDA9dxSN"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-46e33b260b9so48604685e9.2
        for <git@vger.kernel.org>; Mon, 06 Oct 2025 07:23:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759760590; x=1760365390; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=grk0++9sVmx+MhvarhXpKR4HB8c9qw4j/iIH3dyyO8Y=;
        b=bDA9dxSNaGu4/7lr7CxQoI+i0NpcPv6s3MyuDrUh3ZAFm3kROi4g/71cc7eVbbAkhC
         vcYVnnVaGCet0CO/uCwBFpfVjvEceo8P7Vdz9efMxTWbZLy+c3NqOh6GUUDqqq1amuI4
         bFLKM/qsbNcNg5NkSkcxiB7cM+ZhPE/imHuDQSKykLpp27C/NR4TGOlIwn4cGCal1Ejv
         e4NMgFoBg/2erDal5NM9E/bIVYY46jr4mRxgEQTEA7d81W8ui/DQN06g4FIeOuAw03fS
         WmceyJBz64PyV2FV5rHFTgTktfaDpJUnxeIsH151zwuLxuhgmWSUzYT5CfncYsIIO5SX
         GsyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759760590; x=1760365390;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=grk0++9sVmx+MhvarhXpKR4HB8c9qw4j/iIH3dyyO8Y=;
        b=l2Q2Xz42pYSiC+JZ0rgG/n72p7zytX3hsrKZrfsQQl7NTDfxbzFZtyi3XMqQcwfCqj
         wOuJajHfWE21VZzSDk2oWMjRM9QyHBbYxWjF0I72ANOLsxvnhoF7J9kmo9TmRasa55zz
         tSIMA7+H5Zb87ZgixOUng2Oz6HhYMCZ3dkdrzsF+ravFwWRLQWOTHEB8UWyRMfKNYByC
         VcGUWDDB+olwo/8oNUFyfM8QEZyemSatRhyATDevMfCCXY/G72nEAFGNS1oqY3eiEAbT
         VCzX13+ptV780pgAz/9aWm8+37NXudA5L/GFkep1JR0NvhINuDmELdScWCF18qyYA/eq
         q9iA==
X-Gm-Message-State: AOJu0YyLs8Q5Nl66ErxNQIx2Z6voCsGu0+H8971sKjehJ8WVLho7uRaU
	vVjkqr/ibV5oCQwV9aqIbAL3yhj0kdERu6Oyk5WM2l/HiyG8+rwJupdUI4hNcvYu
X-Gm-Gg: ASbGncuAWbGSiTNr2l8uiOavgn0KmJwwh0+6jNFGZ/82IfMBbziRnYYknubGtbGdjqJ
	7vcm7eXJpGAZR3MvJkYWrLGrhiHtwPLHEJxP/m7PURha0ej+1KjtL32E5xwB1uE0+Qy6JMUgymV
	l4RpHHzqk062Ayns49WLzIjt+OVu6JXZ/jTujKnS3wB8JVtDX6OLgBXrPCC31fC9LQLvcHbqxpz
	/3rkE/ceU279cTAOuzQAyEaZZgcyya+UnNAVbz6dFNa/EkA/C5QUGhW1vzwVI1qiu3z+xVNuM4X
	FKJHr8Hsfe7XGt1/ty3hzZcgGdeDxlAwg5vfHeKuizPDd7NCYnBdCj4ayhOURks2NustUiRXxKe
	lig9RfH/aTN3DqAvNPNQgS4pKB2G7BJnMQJQ45ghqQXa6RQ==
X-Google-Smtp-Source: AGHT+IH7Y0brIbtpe5Cu/UTEFHbUpiYNY9Zys/khqy9iUcM6HYxzgSTsPgJ/CWx4E/S3d6AFqcBSfQ==
X-Received: by 2002:a05:600c:8b64:b0:46e:652e:168f with SMTP id 5b1f17b1804b1-46e710fe30fmr97458675e9.6.1759760589855;
        Mon, 06 Oct 2025 07:23:09 -0700 (PDT)
Received: from [127.0.0.2] ([82.163.201.2])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-46e7234f547sm171237555e9.9.2025.10.06.07.23.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Oct 2025 07:23:09 -0700 (PDT)
From: Karthik Nayak <karthik.188@gmail.com>
Date: Mon, 06 Oct 2025 16:23:05 +0200
Subject: [PATCH v5 7/7] refs/reftable: add fsck check for checking the
 table name
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251006-228-reftable-introduce-consistency-checks-v5-7-f196d386214f@gmail.com>
References: <20251006-228-reftable-introduce-consistency-checks-v5-0-f196d386214f@gmail.com>
In-Reply-To: <20251006-228-reftable-introduce-consistency-checks-v5-0-f196d386214f@gmail.com>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>, ps@pks.im, gitster@pobox.com
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=6726; i=karthik.188@gmail.com;
 h=from:subject:message-id; bh=JxnDDcb2Wno8TzizsxTtRdbzlz0tC4g1+xYYPjCM68k=;
 b=owJ4nAHtARL+kA0DAAoBPtWfJI5GjH8ByyZiAGjj0MbYQIPx7dgqqfwXiw/Gv7dCzxHBWA68o
 oCSEP38i/l36IkBswQAAQoAHRYhBFfOTH9jdXEPy2XGBj7VnySORox/BQJo49DGAAoJED7VnySO
 Rox/6UQL/A9/1+FfbRLGIz7smWXUIKuFxwKymC2lQGVyg76tU/Xy/lRSI5ZjVNeusykQJoI+G+Z
 luNiRa/48GBAmUloeBjvsHaAA5EbcW0RyZ5Oa+PTuhn4GLDDda5+THUgf5TnTRbyymnCIHKYykm
 /Hr1UGnOvUTrjc4ga+6BsoxWJNwYWX1mryj+DOuTcHS+CEfdaYcx7tDM6V7FSW4SPI4BALqrMAx
 zRsp7s48T34woQpsfIssmOWMXI6L8bbEei9IenUgZ1XKJuyBnk48w0/29X4DMXKN2iOSIU7PyO+
 uDHK7qz54hHCTHTZxAwgs/V6H87WfpMRp9zsZEdNUMeh+3l7sEH9YeucPw6+KHqeAKJ+4SM5Q+0
 S2dzJzjV0CFfTPVX4LhRqcLjtAfRAOCtzSSrG5tyslfVHxq5dV+P5ytRs/Q9mKlkfeQ+Gt1qgXP
 SNfsUQd0tLpd9/8epD3kPav7QolDkEyq82a3GJqL7aHZkift9KT4TdjZfaFzcS+cxP1VGDfQ758
 vI=
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
index 0000000000..a5be279ab3
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
+			git update-ref branch-$i HEAD || return 1
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

