Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0ED22E8DFE
	for <git@vger.kernel.org>; Mon,  8 Sep 2025 12:37:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757335064; cv=none; b=LULS/2cuoqJAfuXHynNvnzqhYxYJr9OgDJYW0KswQUkx82dQZreFY2sXNEZ1P1BRnD/BZe+gfbgkxd15+CbaCqhnWEDmDHeXK/FyqebRp72na2O9qjG8Vs8apYMEfsFmcJHY3g3LiHCUNU8GHa/LVbNZK7NFgMdwPI43Or/x/Ck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757335064; c=relaxed/simple;
	bh=ODYjr9+JNuBE3yDCFjPk6YWcvjI+AsimfN8IDnTKlIQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=KzmM2XZg3WpLGlRH/HFsTFPgr9QiFrkQs7ucIgyoONguakh8rLuH483MFPa/Qfp81/7x5+0IKGqzg7wMzdxqvUXjnnbCx2zQhfUgaiqRJhg2VTP3C6oExNhRbGys+EF/zl9LgKuL32KIZjb06zJB2t735b3gzYU6C8HApfjvg8s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Dpwasw2z; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Dpwasw2z"
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-627b85e4c0fso1807078a12.1
        for <git@vger.kernel.org>; Mon, 08 Sep 2025 05:37:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757335060; x=1757939860; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LBnOZnaiFIV6keoQ2runmyqdDR1vUxOJZ7BY74NjufA=;
        b=Dpwasw2zFL8JM5557tdlPl9vMCV5zBs4U5F/lhBJKMh2koP7xrDxl1HnFoWFfl49Nv
         YT8q30RrT6E6JG/TFabKVfuhyKmCcFDWlDp0KZAllhq2joKGhjpfJuuIB8axXNesb8gG
         WjU3YjJYtLNnzZ9pVGH2Q+NBzsLSyYBaHoizpe14dCqmDi74hsNKjTX52aBl4Xx4ry95
         jhD6lEOG4vfjQxGcV1I1yUVP5Gp/yC9Cip6044SIrZu6tBV9cjlazc+U3W4qW7i16mHA
         8B/ttqX38/zzPqnEGRFA5j5pcwahczdmeC2QpoIhpUnZq+Yb2dv5dGji45Gt5fHPvP6l
         p7/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757335060; x=1757939860;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LBnOZnaiFIV6keoQ2runmyqdDR1vUxOJZ7BY74NjufA=;
        b=HOHx/T/DsNcoSAnDvqIKeFd9/ycPPhGNWBo+Vvbr/atMX48JXmEKAGmTtJ6/6ZQgbf
         pGMSNDKWB4gDJ9TbEm/scSZZR602fj0sX/c31LEbT4eaKQb3jIHWQSOyFHHTFuAzYlq+
         T3rWUZMpsdBy1PJtN4AOuRz/YNaUgrOW3ScpoNKRyiXwbfxVQjQjN/S/BqElhSbphl/L
         4FxrFLFx6vVr/Sy/aPErXhaJv+aluJj3zXECsF2qfGiD9RV7xu8xINI+HqOz5foe4o3o
         5Mn6sbZ6QLow7pncsikyyyz7Kin0ZD/PGaiPKMic4HKWCQ27u4bY0PV38X01BHfHQ7g3
         h6cA==
X-Gm-Message-State: AOJu0YxBkE2o+6zg89B2eSZfOuc/o7mctkO54BEmci7C8WeBELcZVZyf
	rS3IsmuqAIst6vXQ5vaszaCZXEB8/3t+zLRU7UxgkrWY494pMhtqdITN
X-Gm-Gg: ASbGnctzrLrgzn33SgUsHTKNWuSKTD9k9CwXh31f7zGea63bwb/sG+VNARgJY2NEEi4
	d6eAYE1aDITKOtgPWS9UhYH2rTow1pnAixtqHbN398lBxSY6kMcm0QMOIyOy7rbPg456XqyCKFu
	bLSK14i5fssNrrityr0maS7KdCtF8imwZzHTFbRgBJvDm52nFlCwIGkjSyBJE+MVjqobmReyYF+
	VojlWZU+WijpsDwlpZi0MksOM05yBKfqe96U8p6bZ1XuGHjEtmtjEZJDjhuQes/NSyCbZbB2C4x
	NofqT+PbQ1DIpKCxgffkmOHkAsDvZ7fQkkf5T1FLv8hWxQZG9wSrADP2+4HxXoIPvXO1Og9N1EM
	82faqFluiCd7mY4UT7iNoLr1HU7VU
X-Google-Smtp-Source: AGHT+IHdKbaHr3fuddf3lfibzKbk7Tq8bU3KLUpXqVeGtsBcL5CfvCwg6OLe45I8rAYvx3lXCOYKUA==
X-Received: by 2002:a50:9ea5:0:b0:61c:c9f0:643b with SMTP id 4fb4d7f45d1cf-620f08bd9b6mr8782483a12.0.1757335059744;
        Mon, 08 Sep 2025 05:37:39 -0700 (PDT)
Received: from [127.0.0.2] ([2a02:2455:8268:bc00:c9f4:d82a:f11d:d7f9])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-61cfc1c7848sm23257445a12.2.2025.09.08.05.37.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Sep 2025 05:37:39 -0700 (PDT)
From: Karthik Nayak <karthik.188@gmail.com>
Date: Mon, 08 Sep 2025 14:37:35 +0200
Subject: [PATCH v2 1/4] refs/files: catch conflicts on case-insensitive
 file-systems
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250908-587-git-fetch-1-fails-fetches-on-case-insensitive-repositories-v2-1-b2eb2459befb@gmail.com>
References: <20250908-587-git-fetch-1-fails-fetches-on-case-insensitive-repositories-v2-0-b2eb2459befb@gmail.com>
In-Reply-To: <20250908-587-git-fetch-1-fails-fetches-on-case-insensitive-repositories-v2-0-b2eb2459befb@gmail.com>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>, 
 Joe Drew <joe.drew@indexexchange.com>, peff@peff.net, ps@pks.im, 
 gitster@pobox.com
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=12442;
 i=karthik.188@gmail.com; h=from:subject:message-id;
 bh=ODYjr9+JNuBE3yDCFjPk6YWcvjI+AsimfN8IDnTKlIQ=;
 b=kA0DAAoBPtWfJI5GjH8ByyZiAGi+zhGh+ugTG2Pmd90qxq447+efKB5C70y1ZDp6xUzbCQNko
 IkBswQAAQoAHRYhBFfOTH9jdXEPy2XGBj7VnySORox/BQJovs4RAAoJED7VnySORox/e2oL/iNr
 7cjuPxMESCGOMgw9GPcQGHpaVOj1YozT906RcFCib23sE++i0lDjrp7VnD179rDOqI5UblZJF+G
 Z2BsynkZImSeg19f1LryFQ+obbmIpPOQJl9PNk3XQBY4V8d9pjDJ08lCgV+CFZQPqAOmTlmdhp0
 xjgSnNUI67V/zhCxspMpdxi5VWlTrks+C9AFY/SGqUJMiLX7tTgHt7f0sR0EoFSNCCUKiodYV9O
 NW2norS6G5zouP8QmPNrb+lWXBEeXirtTdWkVkE/ru0NjpgZqsY4p+f+jmDLr3ghel6/XQjng3/
 0/GBC56bdxpxUqqkXSdOgvQeHZmTzLB6X1eohAsqkyr3uRewK6yOa8JJvK1sptzKQc0Y6fL0j7D
 ypKZB8BNGb4Hx2Bb84vdg7Xs50IiSMTXwlVwU0xP4EqgW2FdIFJtxoXCVP7eqhssoreRbdBkohh
 sbX49JiZkyFFN0D//30b6850hRrVRV7E67ry6hJ9JLhqTo722H2T+nu1F5Iw==
X-Developer-Key: i=karthik.188@gmail.com; a=openpgp;
 fpr=57CE4C7F6375710FCB65C6063ED59F248E468C7F

During the 'prepare' phase of reference transaction in the files
backend, we create the lock files for references to be created. When
using batched updates on case-insensitive filesystems, the entire
batched updates would be aborted if there are conflicting names such as:

  refs/heads/Foo
  refs/heads/foo

This affects all commands which were migrated to use batched updates in
Git 2.51, including 'git-fetch(1)' and 'git-receive-pack(1)'. Before
that, reference updates would be applied serially with one transaction
used per update. When users fetched multiple references on
case-insensitive systems, subsequent references would simply overwrite
any earlier references. So when fetching:

  refs/heads/foo: 5f34ec0bfeac225b1c854340257a65b106f70ea6
  refs/heads/Foo: ec3053b0977e83d9b67fc32c4527a117953994f3
  refs/heads/sample: 2eefd1150e06d8fca1ddfa684dec016f36bf4e56

The user would simply end up with:

  refs/heads/foo: ec3053b0977e83d9b67fc32c4527a117953994f3
  refs/heads/sample: 2eefd1150e06d8fca1ddfa684dec016f36bf4e56

This is buggy behavior since the user is never informed about the
overrides performed and missing references. Nevertheless, the user is
left with a working repository with a subset of the references. Since
Git 2.51, in such situations fetches would simply fail without updating
any references. Which is also buggy behavior and worse off since the
user is left without any references.

The error is triggered in `lock_raw_ref()` where the files backend
attempts to create a lock file. When a lock file already exists the
function returns a 'REF_TRANSACTION_ERROR_GENERIC'. When this happens,
the entire batched updates, not individual operation, is aborted as if
it were in a transaction.

Change this to return 'REF_TRANSACTION_ERROR_CASE_CONFLICT' instead to
aid the batched update mechanism to simply reject such errors. The
change only affects batched updates since batched updates will reject
individual updates with non-generic errors. So specifically this would
only affect:

    1. git fetch
    2. git receive-pack
    3. git update-ref --batch-updates

This bubbles the error type up to `files_transaction_prepare()` which
tries to lock each reference update. So if the locking fails, we check
if the rejection type can be ignored, which is done by calling
`ref_transaction_maybe_set_rejected()`.

As the error type is now 'REF_TRANSACTION_ERROR_CASE_CONFLICT',
the specific reference update would simply be rejected, while other
updates in the transaction would continue to be applied. This allows
partial application of references in case-insensitive filesystems when
fetching colliding references.

While the earlier implementation allowed the last reference to be
applied overriding the initial references, this change would allow the
first reference to be applied while rejecting consequent collisions.
This should be an okay compromise since with the files backend, there is
no scenario possible where we would retain all colliding references.

Let's also be more pro-active and notify users on case-insensitive
filesystems about such problems by providing a brief about the issue
while also recommending using the reftable backend, which doesn't have
the same issue.

Reported-by: Joe Drew <joe.drew@indexexchange.com>
Helped-by: Patrick Steinhardt <ps@pks.im>
Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
---
 builtin/fetch.c       | 21 +++++++++++++++++---
 refs.c                |  2 ++
 refs.h                |  2 ++
 refs/files-backend.c  | 26 ++++++++++++++++++++-----
 t/t1400-update-ref.sh | 53 +++++++++++++++++++++++++++++++++++++++++++++++++++
 t/t5510-fetch.sh      | 22 ++++++++++++++++++++-
 6 files changed, 117 insertions(+), 9 deletions(-)

diff --git a/builtin/fetch.c b/builtin/fetch.c
index 24645c4653..c7ff3480fb 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -1643,7 +1643,8 @@ static int set_head(const struct ref *remote_refs, struct remote *remote)
 
 struct ref_rejection_data {
 	int *retcode;
-	int conflict_msg_shown;
+	bool conflict_msg_shown;
+	bool case_sensitive_msg_shown;
 	const char *remote_name;
 };
 
@@ -1657,11 +1658,25 @@ static void ref_transaction_rejection_handler(const char *refname,
 {
 	struct ref_rejection_data *data = cb_data;
 
-	if (err == REF_TRANSACTION_ERROR_NAME_CONFLICT && !data->conflict_msg_shown) {
+	if (err == REF_TRANSACTION_ERROR_CASE_CONFLICT && ignore_case &&
+	    !data->case_sensitive_msg_shown) {
+		error(_("You're on a case-insensitive filesystem, and the remote you are\n"
+			"trying to fetch from has references that only differ in casing. It\n"
+			"is impossible to store such references with the 'files' backend. You\n"
+			"can either accept this as-is, in which case you won't be able to\n"
+			"store all remote references on disk. Or you can alternatively\n"
+			"migrate your repository to use the 'reftable' backend with the\n"
+			"following command:\n\n    git refs migrate --ref-format=reftable\n\n"
+			"Please keep in mind that not all implementations of Git support this\n"
+			"new format yet. So if you use tools other than Git to access this\n"
+			"repository it may not be an option to migrate to reftables.\n"));
+		data->case_sensitive_msg_shown = true;
+	} else if (err == REF_TRANSACTION_ERROR_NAME_CONFLICT &&
+		   !data->conflict_msg_shown) {
 		error(_("some local refs could not be updated; try running\n"
 			" 'git remote prune %s' to remove any old, conflicting "
 			"branches"), data->remote_name);
-		data->conflict_msg_shown = 1;
+		data->conflict_msg_shown = true;
 	} else {
 		const char *reason = ref_transaction_error_msg(err);
 
diff --git a/refs.c b/refs.c
index bfdbe718b7..4c1c339ed9 100644
--- a/refs.c
+++ b/refs.c
@@ -3321,6 +3321,8 @@ const char *ref_transaction_error_msg(enum ref_transaction_error err)
 		return "invalid new value provided";
 	case REF_TRANSACTION_ERROR_EXPECTED_SYMREF:
 		return "expected symref but found regular ref";
+	case REF_TRANSACTION_ERROR_CASE_CONFLICT:
+		return "reference conflict due to case-insensitive filesystem";
 	default:
 		return "unknown failure";
 	}
diff --git a/refs.h b/refs.h
index eedbb599c5..41915086b3 100644
--- a/refs.h
+++ b/refs.h
@@ -31,6 +31,8 @@ enum ref_transaction_error {
 	REF_TRANSACTION_ERROR_INVALID_NEW_VALUE = -6,
 	/* Expected ref to be symref, but is a regular ref */
 	REF_TRANSACTION_ERROR_EXPECTED_SYMREF = -7,
+	/* Cannot create ref due to case-insensitive filesystem */
+	REF_TRANSACTION_ERROR_CASE_CONFLICT = -8,
 };
 
 /*
diff --git a/refs/files-backend.c b/refs/files-backend.c
index 088b52c740..58005d2732 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -647,6 +647,19 @@ static void unlock_ref(struct ref_lock *lock)
 	}
 }
 
+static bool duplicate_reference_case_cmp(struct ref_transaction *transaction,
+					 struct ref_update *update)
+{
+	for (size_t i = 0; i < transaction->nr; i++) {
+		if (transaction->updates[i] == update)
+			break;
+
+		if (!strcasecmp(transaction->updates[i]->refname, update->refname))
+			return true;
+	}
+	return false;
+}
+
 /*
  * Lock refname, without following symrefs, and set *lock_p to point
  * at a newly-allocated lock object. Fill in lock->old_oid, referent,
@@ -677,16 +690,17 @@ static void unlock_ref(struct ref_lock *lock)
  * - Generate informative error messages in the case of failure
  */
 static enum ref_transaction_error lock_raw_ref(struct files_ref_store *refs,
-					       struct ref_update *update,
+					       struct ref_transaction *transaction,
 					       size_t update_idx,
 					       int mustexist,
 					       struct string_list *refnames_to_check,
-					       const struct string_list *extras,
 					       struct ref_lock **lock_p,
 					       struct strbuf *referent,
 					       struct strbuf *err)
 {
 	enum ref_transaction_error ret = REF_TRANSACTION_ERROR_GENERIC;
+	struct ref_update *update = transaction->updates[update_idx];
+	const struct string_list *extras = &transaction->refnames;
 	const char *refname = update->refname;
 	unsigned int *type = &update->type;
 	struct ref_lock *lock;
@@ -776,6 +790,9 @@ static enum ref_transaction_error lock_raw_ref(struct files_ref_store *refs,
 			goto retry;
 		} else {
 			unable_to_lock_message(ref_file.buf, myerr, err);
+			if (myerr == EEXIST && ignore_case &&
+			    duplicate_reference_case_cmp(transaction, update))
+				ret = REF_TRANSACTION_ERROR_CASE_CONFLICT;
 			goto error_return;
 		}
 	}
@@ -2583,9 +2600,8 @@ static enum ref_transaction_error lock_ref_for_update(struct files_ref_store *re
 	if (lock) {
 		lock->count++;
 	} else {
-		ret = lock_raw_ref(refs, update, update_idx, mustexist,
-				   refnames_to_check, &transaction->refnames,
-				   &lock, &referent, err);
+		ret = lock_raw_ref(refs, transaction, update_idx, mustexist,
+				   refnames_to_check, &lock, &referent, err);
 		if (ret) {
 			char *reason;
 
diff --git a/t/t1400-update-ref.sh b/t/t1400-update-ref.sh
index 96648a6e5d..08d5df2af7 100755
--- a/t/t1400-update-ref.sh
+++ b/t/t1400-update-ref.sh
@@ -2294,6 +2294,59 @@ do
 		)
 	'
 
+	test_expect_success CASE_INSENSITIVE_FS,REFFILES "stdin $type batch-updates existing reference" '
+		git init repo &&
+		test_when_finished "rm -fr repo" &&
+		(
+			cd repo &&
+			test_commit one &&
+			old_head=$(git rev-parse HEAD) &&
+			test_commit two &&
+			head=$(git rev-parse HEAD) &&
+
+			{
+				format_command $type "create refs/heads/foo" "$head" &&
+				format_command $type "create refs/heads/ref" "$old_head" &&
+				format_command $type "create refs/heads/Foo" "$old_head"
+			} >stdin &&
+			git update-ref $type --stdin --batch-updates <stdin >stdout &&
+
+			echo $head >expect &&
+			git rev-parse refs/heads/foo >actual &&
+			echo $old_head >expect &&
+			git rev-parse refs/heads/ref >actual &&
+			test_cmp expect actual &&
+			test_grep -q "reference conflict due to case-insensitive filesystem" stdout
+		)
+	'
+
+	test_expect_success CASE_INSENSITIVE_FS "stdin $type batch-updates existing reference" '
+		git init --ref-format=reftable repo &&
+		test_when_finished "rm -fr repo" &&
+		(
+			cd repo &&
+			test_commit one &&
+			old_head=$(git rev-parse HEAD) &&
+			test_commit two &&
+			head=$(git rev-parse HEAD) &&
+
+			{
+				format_command $type "create refs/heads/foo" "$head" &&
+				format_command $type "create refs/heads/ref" "$old_head" &&
+				format_command $type "create refs/heads/Foo" "$old_head"
+			} >stdin &&
+			git update-ref $type --stdin --batch-updates <stdin >stdout &&
+
+			echo $head >expect &&
+			git rev-parse refs/heads/foo >actual &&
+			echo $old_head >expect &&
+			git rev-parse refs/heads/ref >actual &&
+			test_cmp expect actual &&
+			git rev-parse refs/heads/Foo >actual &&
+			test_cmp expect actual
+		)
+	'
+
 	test_expect_success "stdin $type batch-updates delete incorrect symbolic ref" '
 		git init repo &&
 		test_when_finished "rm -fr repo" &&
diff --git a/t/t5510-fetch.sh b/t/t5510-fetch.sh
index ebc696546b..57f60da81b 100755
--- a/t/t5510-fetch.sh
+++ b/t/t5510-fetch.sh
@@ -47,7 +47,13 @@ test_expect_success "clone and setup child repos" '
 		git config set branch.main.merge refs/heads/one
 	) &&
 	git clone . bundle &&
-	git clone . seven
+	git clone . seven &&
+	git clone --ref-format=reftable . case_sensitive &&
+	(
+		cd case_sensitive &&
+		git branch branch1 &&
+		git branch bRanch1
+	)
 '
 
 test_expect_success "fetch test" '
@@ -1526,6 +1532,20 @@ test_expect_success SYMLINKS 'clone does not get confused by a D/F conflict' '
 	test_path_is_missing whoops
 '
 
+test_expect_success CASE_INSENSITIVE_FS,REFFILES 'existing references in a case insensitive filesystem' '
+	test_when_finished rm -rf case_insensitive &&
+	(
+		git init --bare case_insensitive &&
+		cd case_insensitive &&
+		git remote add origin -- ../case_sensitive &&
+		test_must_fail git fetch -f origin "refs/heads/*:refs/heads/*" 2>err &&
+		test_grep "You${SQ}re on a case-insensitive filesystem" err &&
+		git rev-parse refs/heads/main >expect &&
+		git rev-parse refs/heads/branch1 >actual &&
+		test_cmp expect actual
+	)
+'
+
 . "$TEST_DIRECTORY"/lib-httpd.sh
 start_httpd
 

-- 
2.50.1

