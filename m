Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21CE22F4A0A
	for <git@vger.kernel.org>; Thu, 18 Sep 2025 08:11:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758183119; cv=none; b=BTYZwDlZGjX8sPOQFdmCodDZXHfUldT/VdJf1rApP5v0kT+3fkOfbsGlZL9pYiau+PuQvCFcp3Gm9LObRFTWnI2cDrxUs3ZLuTBtCYpFTb7eyPBydO3XK2BYDyeTMVBpWe8mp53hJibdGyaEnRmeO/xiZmve7/CLCPjy05wRbOo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758183119; c=relaxed/simple;
	bh=zc11WZ1OBHhMSWEqqvwRhQyIYkwLIRmqv7O2VNblQnA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=T017ln//uEfWbKgQnxOD41Pyimu833zk8An9gsPPzXMD9rttTOsRC9DOOID12/YtQV83u2U35D1La/YuLkW4UJW7NV3hs5n69DCWO9YyLBo0RR4vXInZcBCbmSJtGxvSBDqfBDQ1r63DkxufV/ARGKqgbeLWaFqT5gqh84zMSfc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Fndkv7bX; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Fndkv7bX"
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-afcb7a16441so101447766b.2
        for <git@vger.kernel.org>; Thu, 18 Sep 2025 01:11:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758183115; x=1758787915; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=K+/zeYTGa4ORxJb9AmgjqqckF6KEtYr6u1eSdvnnRUk=;
        b=Fndkv7bXD6uLrwXP/CWah5NQHMBDxVby7+sRvOLAAptIujpP7WlhmLz4Z2/Gp/SFL7
         i6nnZjpb2HcH9IEYZ8DW+sQwZ0OZvN3fEkKlXlPnj6wwoT35KgxzrR7assvosLeVPRM7
         ZUPsErQ8PhdAA6pZki6H/XL/lFLipDY2PxBf35OTd7/NsY1KAooGyg8Rg/L8qY2HemLc
         jCErXRZ9BvfLzxovShzrrR1kGvzngsNbaizfaurur+V3K5XKcVP7U8BtvNDWIPGLxBJ5
         BbzajX5Q2DQ63jc78LNoSTEJRWOkBnOehbUthVoJN0KU0/918xc7Lv9ZqDfResvw2qO+
         Raqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758183115; x=1758787915;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=K+/zeYTGa4ORxJb9AmgjqqckF6KEtYr6u1eSdvnnRUk=;
        b=nEFSy1me1vVd7/J5HsAp+hYI0kN6m9HiQslUhkX4y1tcrdS6sppVxmXPf6Fbz5Pe20
         bsa1PTIZ6450stepdkF0EtcON4eY2ITAeh3nng3qLeBDoF8FUrhJ6KtxvZT0C8nEAxee
         n32BsiWA/1+49g2264ALh25QihpICOL9uAXUDsfwmf1Ywt6WlzifAiRdX1/JQMroA/55
         NVU7KMYXAb9YY9dd/JJ1QQ94JrT8ZrdWUTqehAWFieMxG+UgpSSVhnUEnDjgf4H8MVrG
         J6q/HPeuzWFb3+iwWgTPyVcAtVOulDPWKTi4SgGkmdvOAPXwI9yD3WqG4JTK1eACwzrq
         vf0A==
X-Gm-Message-State: AOJu0YxB4PxuJV1EJihUE88g7OFLf+GKeZDO8qNhbQ2oqSMf1HnRZ4dX
	3818fCYyE6BiXZU66/vY/g5vdK7kzMQ5Q2n0m6SfQqL7YGNa0D5DBtVnAyOsgXL9
X-Gm-Gg: ASbGncttGFCiabFAZllmWPNdd7Jtqv0/umhs/eYhkMveDQ7vx1RyreKXxmpqYS1N493
	G2IKFSfsTN7YqHuxrBUi6s7KihBZIiLAS1bFh43Jtjp4/10WAL72r0LYzb6zZyz2BqEPIaD43F3
	ek72ws4mJIo/kVKSmEYs0cafBfqJmrc9fDtwmDlBWevr75Xx9Fs1RnO+PM2ngEqImo9G+egjwDg
	5gkD05DcpvVu6JKvRYRsBb7pwSxet4kLUbZYotgyEhQKRCU7TV7NEvD/27srZnJdPadv7hB1nMf
	mTpcznLgPF8kqgXWI+JXqe1tcG+ydCp49BU5+7GugnzShF90sWYdboXJNQO5rRWqXF1bsOn/DoJ
	GoM0LsJghXco4Ru8Cid9U591dnC96E338VB6mIVevXsBdfvw=
X-Google-Smtp-Source: AGHT+IF7A1EK7H6HsWX5Jni/JSVbhfLIrHZknFunOF7F+mlFXPcV90/BMVVSLsDg5WV7ciiFiOhxSA==
X-Received: by 2002:a17:907:1c29:b0:b07:c905:21c with SMTP id a640c23a62f3a-b1bbd685be4mr596072666b.48.1758183115187;
        Thu, 18 Sep 2025 01:11:55 -0700 (PDT)
Received: from [127.0.0.2] ([2a02:2455:8268:bc00:2802:b9c0:7d04:71e9])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b1fd2ce20f4sm139986566b.111.2025.09.18.01.11.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Sep 2025 01:11:54 -0700 (PDT)
From: Karthik Nayak <karthik.188@gmail.com>
Date: Thu, 18 Sep 2025 10:11:49 +0200
Subject: [PATCH v3 8/8] refs/reftable: add fsck check for checking the
 table name
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250918-228-reftable-introduce-consistency-checks-v3-8-271af03eb34d@gmail.com>
References: <20250918-228-reftable-introduce-consistency-checks-v3-0-271af03eb34d@gmail.com>
In-Reply-To: <20250918-228-reftable-introduce-consistency-checks-v3-0-271af03eb34d@gmail.com>
To: git@vger.kernel.org
Cc: ps@pks.im, gitster@pobox.com, shejialuo@gmail.com, 
 Karthik Nayak <karthik.188@gmail.com>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=6914; i=karthik.188@gmail.com;
 h=from:subject:message-id; bh=zc11WZ1OBHhMSWEqqvwRhQyIYkwLIRmqv7O2VNblQnA=;
 b=owJ4nAHtARL+kA0DAAoBPtWfJI5GjH8ByyZiAGjLvsO3WFpKk7u3bLi99zMjjxCP8V5Cv9acu
 tjm6qLwC99ZTIkBswQAAQoAHRYhBFfOTH9jdXEPy2XGBj7VnySORox/BQJoy77DAAoJED7VnySO
 Rox/L9cMAJJLsU7V7PN89ZX0nDF1jFYOCP5oYfMqOxrfsH0Q4gRBMdNA3l6h+BnF38ujbGMFyDj
 1oKSl12t4XfnOZ2uV6MYPpp3o6w5fC4bB+MEaDJQGjGv4AhZPsvDKfTpoJs246C1JVkoOR8lz93
 NLUMK8nWzaJG/99kluIqF2PQTWHRc39ox41zEY7GWSIWlsljH1EoDrh9B0Q9X8fOjRxN5qGWft8
 rcmGq/G/S43bBGhpW9Gym8Ffbkg7nC7jmfnmDcYk2ZYXpyawigtYU5hQ3YRbaM80eVkHWdmf8GC
 7C8IKHSXQ6gwIsFeSv8roVME0ILVvpHwgtgOn7oZhe3rvJ9zKe3B8QRLtdOgWhaROudwPmMZEfX
 DoIOFaWEKc0lRrEyPwZFcvaQehub20oqvXcO0vAZNf5DBSA6yxCmpgpQmZXjrSNmzTEL8wakTsk
 Nz8s4APXwpA8LllcYDYf5l/hmqtLxt12Tsb8ys5LoQfIGiAB0CeaGKrNx4u27sjfu7C+RemPMt8
 dI=
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

So treat non-conformant file names as warnings. Introduce another check
to check for file types, non-expected filetypes will be treated as
errors.

Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
---
 Documentation/fsck-msgids.adoc |  6 +++++
 fsck.h                         |  2 ++
 refs/reftable-backend.c        | 58 ++++++++++++++++++++++++++++++++++++++----
 t/meson.build                  |  1 +
 t/t0614-reftable-fsck.sh       | 55 +++++++++++++++++++++++++++++++++++++++
 5 files changed, 117 insertions(+), 5 deletions(-)

diff --git a/Documentation/fsck-msgids.adoc b/Documentation/fsck-msgids.adoc
index 1c912615f9..d10fe9bb35 100644
--- a/Documentation/fsck-msgids.adoc
+++ b/Documentation/fsck-msgids.adoc
@@ -38,6 +38,12 @@
 `badReferentName`::
 	(ERROR) The referent name of a symref is invalid.
 
+`badReftableFiletype`::
+	(ERROR) File with unexpected type in reftable directory.
+
+`badReftableTableName`::
+	(WARN) A reftable table has an invalid name.
+
 `badTagName`::
 	(INFO) A tag has an invalid format.
 
diff --git a/fsck.h b/fsck.h
index 6b0db235e0..c857fcdd7c 100644
--- a/fsck.h
+++ b/fsck.h
@@ -34,6 +34,7 @@ enum fsck_msg_type {
 	FUNC(BAD_PACKED_REF_HEADER, ERROR) \
 	FUNC(BAD_PARENT_SHA1, ERROR) \
 	FUNC(BAD_REFERENT_NAME, ERROR) \
+	FUNC(BAD_REFTABLE_FILETYPE, ERROR) \
 	FUNC(BAD_REF_CONTENT, ERROR) \
 	FUNC(BAD_REF_FILETYPE, ERROR) \
 	FUNC(BAD_REF_NAME, ERROR) \
@@ -73,6 +74,7 @@ enum fsck_msg_type {
 	FUNC(UNKNOWN_TYPE, ERROR) \
 	FUNC(ZERO_PADDED_DATE, ERROR) \
 	/* warnings */ \
+	FUNC(BAD_REFTABLE_TABLE_NAME, WARN) \
 	FUNC(EMPTY_NAME, WARN) \
 	FUNC(FULL_PATHNAME, WARN) \
 	FUNC(HAS_DOT, WARN) \
diff --git a/refs/reftable-backend.c b/refs/reftable-backend.c
index 2152349cb9..1a18f4bf92 100644
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
@@ -2707,11 +2709,57 @@ static int reftable_be_reflog_expire(struct ref_store *ref_store,
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
+	[REFTABLE_FSCK_ERROR_INVALID_FILE_TYPE] = FSCK_MSG_BAD_REFTABLE_FILETYPE,
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
+		BUG("unknown fsck error: %d", info->error);
+
+	msg_id = fsck_msg_id_map[info->error];
+
+	if (!msg_id)
+		BUG("fsck_msg_id value missing for reftable error: %d", info->error);
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
index 0000000000..d4e6765b6b
--- /dev/null
+++ b/t/t0614-reftable-fsck.sh
@@ -0,0 +1,55 @@
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
+			touch ".git/reftable/$TABLE_NAME" &&
+
+			git refs verify 2>err &&
+			cat >expect <<-EOF &&
+			warning: ${TABLE_NAME}: badReftableTableName: file with invalid table name
+			EOF
+			test_cmp expect err
+		)
+	'
+done
+
+test_expect_success "invalid file type should be checked" '
+	test_when_finished "rm -rf repo" &&
+	git init repo &&
+	(
+		cd repo &&
+		git commit --allow-empty -m initial &&
+
+		git refs verify 2>err &&
+		test_must_be_empty err &&
+
+		mkdir ".git/reftable/foo" &&
+
+		test_must_fail git refs verify 2>err &&
+		cat >expect <<-EOF &&
+		error: foo: badReftableFiletype: file with unexpected type
+		EOF
+		test_cmp expect err
+	)
+'
+
+test_done

-- 
2.51.0

