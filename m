Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A9AB2882D7
	for <git@vger.kernel.org>; Fri, 26 Sep 2025 07:26:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758871564; cv=none; b=EjDICS+20erChxhIOekAfWJVh6imQ/whVCGz/aQ2qZrcXW/Jhg5rPATYlSur8aOBq33/Cz7xTvJgu1Puhu3yeS/pi60Py2eObAsdaEJYFiABImvi6GggxrktPSMqoVumjgsjiLjpKsOmyRuzp06/sS1lDKX/QV0Qi3vOgY+WER4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758871564; c=relaxed/simple;
	bh=38yAAkuSat5Dht2DhvVipTQTRJ6LIo7uQ11n8lqtRQs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=HQI05BVkj/nDlZvQirJWmUxIkESd/Oqwgi37uSnTx1PuH0wd/VaP2rlrKNZMtWDqHmbBU7aGRUQLiaV5AV725+cxX3rsl5dhJrc6bmZf7WZsL/c7cttpxCQ0AZjKVd20aJ7sOFVTXR+Io4Qhm4PTnmvyHqiNJk5V+tT7RsezKm4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=N0wO/FuT; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N0wO/FuT"
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-b2d92b52149so359166366b.1
        for <git@vger.kernel.org>; Fri, 26 Sep 2025 00:26:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758871560; x=1759476360; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gwPDOt/gIXILUEff5UNxx15eIBCF/pxGAxE01qDEIiE=;
        b=N0wO/FuTQ1FQWJImh6kqPAeXWgId2hY6I+Z2DfyPxeG7HnC1M37X3y0LXlCZ+NPbF2
         wKtLxRyN0LpaX7p20KRBcwNbpftm3tg1wBys1N0dIA7T0F2i5srcivPejWXtyRcxOKvL
         8LCAap8gik3GBSnsGLpqHUoaeIsRlzsLaAAb9Daq8ZM+DTECokyurBA7OQhBRgPNKH7U
         FlS8+cUUCz3SQXYV9xWWMHS6gaEKC2iUr2f1Div7tJM455pEvWebQ5LBINjg4IWiKEsz
         gurFiLbLs/ALP5wd6KhwtV/w/ajuYII4CWZAqVmUj4QBKXglInJX6gxO0QkIapOdGN74
         avnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758871560; x=1759476360;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gwPDOt/gIXILUEff5UNxx15eIBCF/pxGAxE01qDEIiE=;
        b=nEPxbmd8D77BNAK3KTMNwUaXVfAYvKIgOHIXT6B8eFhq0Ox31asXrM5R5VgtAL6C82
         vooJPbU7JArUtZ3janyLy3aQXNKIM2GhkznRqsNkbJ6qk1PwU+2RSoZWQyW7JG2kLvD7
         Vxn+6dpTf7sRpFzJYzjSyGYldkjJqWwE3b6izySCz2B8W222/UZDDH5Ed6JnQ0aomuob
         cRul34Hr4Bu3EEZimN6cJ/bd1KR+dfQZVlSuCdB4AmT9clYHLJqwkBUBarhWPXWdl3Y0
         JZH02p7dXQXfnWJhqP+4+XzuhZRTszshNTbvRWIYv9/dpjHj8Lr2AHsR1GhnDlCScIzB
         a1mw==
X-Gm-Message-State: AOJu0YwI0oRFZb99W8uTP39p32sXdDF5nQjRQXpp9OxnVZJ7r1eHxlA6
	RHbuhN6RCHnrnJOXbmTGOvaTxu8oAvkquoivbav/xqHZ+dfoVDX3AJ2Z
X-Gm-Gg: ASbGncv2coUozi5jcu5G5jkIfeLv/LSkABZcUoyYF1gbYVIVexy+x7tz9IBg5fc9YPE
	F02XIsM1hWfF7IXrN3+7wOYqZ9sL2qxOJ8CR8FH1G0VJ/aPv0ahmN/mHSn68BlC9qE3bLrbuHeQ
	/uJVfB2BCdSAWe8TxDoNXFZiwYIAgHd4OWlI3QN2vH1ZyRudiV7vgibYrwS+dMa1vppZwGCOyog
	L1DuoiTM6ytbnHRGOxXJFRVeHk3V+fa0tSBWjpM2KO/APXZxJitD1lBq6dUZsjx16PPlMEvaF/r
	jTr/7aLhrr4oNXsSsscXVq7nY81GoXji2yTVpalxPS2CqcTgVld/8mJvxWfYUz2Y2mvGvtRhlMI
	5W2w6fc0FfHN6O1ege8ySHMfC++Jj8o2ekTQcpG2IyY7Ksy4AjQ==
X-Google-Smtp-Source: AGHT+IHyEGMfj9GeK3oEwOQYi6S50zEdD6K4t7pbu5MXPFlvs7bYqvPLZ7DODXi0vSuV+6BtCYsM4A==
X-Received: by 2002:a17:907:3f20:b0:b04:5a04:c721 with SMTP id a640c23a62f3a-b34b80b0fe1mr702431666b.20.1758871560188;
        Fri, 26 Sep 2025 00:26:00 -0700 (PDT)
Received: from [127.0.0.2] ([2a02:2455:8268:bc00:2fd5:3bfb:87f3:d768])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-634a3af54desm2368795a12.40.2025.09.26.00.25.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Sep 2025 00:25:59 -0700 (PDT)
From: Karthik Nayak <karthik.188@gmail.com>
Date: Fri, 26 Sep 2025 09:25:50 +0200
Subject: [PATCH v4 7/7] refs/reftable: add fsck check for checking the
 table name
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250926-228-reftable-introduce-consistency-checks-v4-7-c96fd8551c0d@gmail.com>
References: <20250926-228-reftable-introduce-consistency-checks-v4-0-c96fd8551c0d@gmail.com>
In-Reply-To: <20250926-228-reftable-introduce-consistency-checks-v4-0-c96fd8551c0d@gmail.com>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>, ps@pks.im, gitster@pobox.com, 
 shejialuo@gmail.com
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=6234; i=karthik.188@gmail.com;
 h=from:subject:message-id; bh=38yAAkuSat5Dht2DhvVipTQTRJ6LIo7uQ11n8lqtRQs=;
 b=owJ4nAHtARL+kA0DAAoBPtWfJI5GjH8ByyZiAGjWQAGvY6oMnAECQ7OP9FAnZ5P8L3fMOmUEA
 FDnU4QqP6QAf4kBswQAAQoAHRYhBFfOTH9jdXEPy2XGBj7VnySORox/BQJo1kABAAoJED7VnySO
 Rox/VxsL/i72oYjmOLUr0qiC62YR5N0sUdFKFJ7x1dT7Hao+zRgn9yHH3En5Q6MXrnTmIKKOw4r
 UNQHDP6XEXw1QTbvjD7xYtciHMjuDJucqKEwStN7awExMS5AuHmuMbNXm3H6oVf3/FbSeXzRqhh
 YKi3v/cXgvr/tMXkKGIcv9SRQfMgmwcgGKlnHZTHqqkUg2sWXWLLSfITCO/joEroBcbDYqJt4IJ
 E3ftFB6stgy4WlG+1tHYT0dK9zYOztJiYX6sF/jnrcmttbtGfGk9VyL5ecZtNkqbg2AIzObHTqF
 zDFXnSh4Ix7wS9Lu8ENKts/LibjBreAwfwoLDHi1upLAulsJrr6v2g4rFLYeiQP+IRYfgenW65T
 kjGrbjIDMV2zrhBYMZzI202Q+5MD2bKApFXByhrUleYKB2x+D1EaPfqQPq8FaX51i35AH27MUme
 vItdhbUlmbpLFgK8VW4ODK72iU2R+0Y2yWPBJPXTWOjSSVqvK4BISCrErwk0eFtUxP+jL2LDLg5
 Uw=
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
 refs/reftable-backend.c        | 57 ++++++++++++++++++++++++++++++++++++++----
 t/meson.build                  |  1 +
 t/t0614-reftable-fsck.sh       | 38 ++++++++++++++++++++++++++++
 5 files changed, 95 insertions(+), 5 deletions(-)

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
index 0000000000..250d244e66
--- /dev/null
+++ b/t/t0614-reftable-fsck.sh
@@ -0,0 +1,38 @@
+#!/bin/sh
+
+test_description='Test reftable backend consistency check'
+
+GIT_TEST_DEFAULT_REF_FORMAT=reftable
+export GIT_TEST_DEFAULT_REF_FORMAT
+
+. ./test-lib.sh
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

