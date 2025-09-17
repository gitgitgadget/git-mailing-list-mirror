Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51FD136CE0E
	for <git@vger.kernel.org>; Wed, 17 Sep 2025 15:25:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758122732; cv=none; b=H8BnxzRpmCZWKcvPgaP23L8aILLPzyOqRPPkya8mRJpGWUAHHMeANx+MWE4Y95hES3gHA4RoFSEWFhWDtU74VSohOFEUPEuEpugyPN7BxgaOSd86DUv9O/dA83X5fyJRwXfG2DIWypYyVI6Kw2e1bRcMylHrP/9ofleRrhuawus=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758122732; c=relaxed/simple;
	bh=/w5fXjyUq3FA/cvU5EfDzR0kRo9IwE5KPlahO3RDNMU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ZqVRNjvv2pM8A0H/fsT4oxBM00NWYF9J395Ua9S9lPICHt/sFsdL+WyPVJ/2Wq57lhXF06oF6aNBRZRvZO1HYKNN/mLGMRkpvfgyk79+kfnCeh6FfKMGzBoI0u0Kki5LtV7fFn5kPlDSq2RBh1xBOP80BFBfZ2wYlWE4FMsZrBc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CgL+TJQK; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CgL+TJQK"
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-62f0bf564e4so6339790a12.3
        for <git@vger.kernel.org>; Wed, 17 Sep 2025 08:25:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758122727; x=1758727527; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=USw2o+rrmnJ2RwxRJQyF/7W5JM5lpCPkTwa2yc0tKCY=;
        b=CgL+TJQKe8npmQuGQBNAYCyuaAJfZMiXhK+6D6f0sPmhpSUGj+C4HFS8b9iBAz692w
         3NgvmS0Ugm3GpZxip25ESBYyJz2oREPdnRaNZuG+JBc9PbPkIr3n1M+clmVrIORT9/4a
         4w1Ld6iZBxzGU3H0iHcSz6x6dO3eO0fIBrT9MQK8MxEeKLUMBWtOxxyHx00mDCjPBgpq
         7PkhvLKycraGM6Zx/JPqR+ObubXGKn0/wrqc3I4SrS4snmViinUHC25P+WQ3M0oK792H
         ee+v88R/6wnpOec9LpwhxXfC0fd9pun2IoSEWJEDN31MSJgNK5lFDgwepLjjLMnypndQ
         QFLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758122727; x=1758727527;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=USw2o+rrmnJ2RwxRJQyF/7W5JM5lpCPkTwa2yc0tKCY=;
        b=iK3GIEevom8A9hdzMnpDwk9uexT6qTq3f6mQuB34NMh595dxtp9vLXWwBNG87jRKoc
         GvJBv1p5kbdNAeQgx5+w435kggKX8dOvmgpSGI5DnllV265VlrVSjfvups3UeBXYBBpI
         KGBYOctPV6li0v8LZVVizifLbLfeIpja1a48VrYeKkL4AvmU3vfok+UIQLKhM0hGF5nC
         3EvxHMexKur9CPzma2JJ/x9sSe5VSh4iXyKJnku6aEWrHndLmcDStCP60oy9zy9HBX/c
         3ku5969Hr5smWySu40mTid0CRLnsIcZCLIkmBxbTwxkC7t2u4jlB5U3MC1sYOurT5RZr
         XusA==
X-Gm-Message-State: AOJu0YxraM5j54clQNfS4vlYkMN40iWCprAKI6WywD2IkssKnvuwQBZ1
	npER6sO2aVubDtfXMYF4n2Ij5Qrt7jX9a5FzD1waqTlZ92PPbh9e2mXi
X-Gm-Gg: ASbGncv/YVbdCKRK86562OXNORIwRrIjmuZ14gP8dEVUKvI1JJUMVbpJ47NHaZQOWxl
	DK+CJ1zwrogcmuSNMnc1PFQPJWpv9nr+1AKmbEX86bwTYYnUxcm4PvDPlPoJnN7wtmDY0vSdPKl
	s7b9ooNbTUWIrW5N56L8bhJY8n/LSlTEwuozvApzlQL/KZWJA/QrAr6Y6BT1M4I/GonyE4dn51B
	YglrNQr+lHky1AP5RQincA6gijuqZQ22iKZAPj9Jp+o3WS+9dfk0+948Ds8iANkipzh/+gKs3Ei
	L/fjxB/asH0gJALOi1wGlTKJqreGTzan19m8JvEB93zqWJSyU92m2RhzMDfqIPJlU7h8Allz27I
	lbw6lQSdAtmvLcy4m4/uythZUVx4r
X-Google-Smtp-Source: AGHT+IGmWoxT7WU2HSuw4nGOlGlD6b0V6K1VWmbjPnvaL1fq3h6sehnhJ1wplczRQr4OMdwOVJCJWQ==
X-Received: by 2002:a17:907:3c8a:b0:b04:25ae:6c76 with SMTP id a640c23a62f3a-b1bc1afd149mr284625566b.47.1758122727326;
        Wed, 17 Sep 2025 08:25:27 -0700 (PDT)
Received: from [127.0.0.2] ([2a02:2455:8268:bc00:bc15:cb75:326d:fed1])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b07b32f21a2sm1410380566b.83.2025.09.17.08.25.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Sep 2025 08:25:26 -0700 (PDT)
From: Karthik Nayak <karthik.188@gmail.com>
Date: Wed, 17 Sep 2025 17:25:14 +0200
Subject: [PATCH v4 4/4] refs/files: handle D/F conflicts during locking
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250917-587-git-fetch-1-fails-fetches-on-case-insensitive-repositories-v4-4-da3c74a08ed0@gmail.com>
References: <20250917-587-git-fetch-1-fails-fetches-on-case-insensitive-repositories-v4-0-da3c74a08ed0@gmail.com>
In-Reply-To: <20250917-587-git-fetch-1-fails-fetches-on-case-insensitive-repositories-v4-0-da3c74a08ed0@gmail.com>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>, joe.drew@indexexchange.com, 
 peff@peff.net, ps@pks.im, gitster@pobox.com, toon@iotcl.com, 
 jltobler@gmail.com
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=6338; i=karthik.188@gmail.com;
 h=from:subject:message-id; bh=/w5fXjyUq3FA/cvU5EfDzR0kRo9IwE5KPlahO3RDNMU=;
 b=owJ4nAHtARL+kA0DAAoBPtWfJI5GjH8ByyZiAGjK0uCdTuip5Ig7Ggm5dJi4OfM/IVBnSnXnU
 169kNs93upgm4kBswQAAQoAHRYhBFfOTH9jdXEPy2XGBj7VnySORox/BQJoytLgAAoJED7VnySO
 Rox/ifkL+wX30gRZlVKKMQ77XnbTjPE5N84fINxbh7H6ufNQBoyHW0c5e6DUdekCEgoNq8PPMSk
 xPKx5DrjkbIbEn4X7uG+TKN2Z3gcfBiqRWZAWdTexWJjzhc3BPOCQdYtLlMQyFq0EROkHjJbjHx
 a+lkTyfvv+Ls8XcKrlIYnlxvzy52gr3tEBnckyp1D7EhgqRTSA5ZMRiyl6+92B6CT/XXWvAjEI3
 O3JFIN5F9gTx2c/AzcAgCMLt6SC56YJk8G6aFDgcsUDmn00Qmo6mZyj2riOiqC7zndvrwT2e7q+
 C3LP1BNkqcRVkrOtSQmMsbGdX7YbsuTzTImEi/Ky5L5szdyCoTxp3FUpfyoIyCq7ofCt7pbCMib
 5hdK8eVTPJ+kjvKCbVCFH3qabOE94hO9BkswYCIiU3mt3WNvkvbD07kdCAcNQdn7oe38w+P5bk6
 pL5Wr5bgHC5wYXK6H+a0zgMiLOFu+QAhVM3Ah3dfPxMGfxLANkanfZRm9Wl9qVT6kILQ2XbbiL7
 tw=
X-Developer-Key: i=karthik.188@gmail.com; a=openpgp;
 fpr=57CE4C7F6375710FCB65C6063ED59F248E468C7F

The previous commit added the necessary validation and checks for F/D
conflicts in the files backend when working on case insensitive systems.

There is still a possibility for D/F conflicts. This is a different from
the F/D since for F/D conflicts, there would not be a conflict during
the lock creation phase:

    refs/heads/foo.lock
    refs/heads/foo/bar.lock

However there would be a conflict when the locks are committed, since we
cannot have 'refs/heads/foo/bar' and 'refs/heads/foo'. These kinds of
conflicts are checked and resolved in
`refs_verify_refnames_available()`, so the previous commit ensured that
for case-insensitive filesystems, we would lowercase the inputs to that
function.

For D/F conflicts, there is a conflict during the lock creation phase
itself:

    refs/heads/foo/bar.lock
    refs/heads/foo.lock

As in `lock_raw_ref()` after creating the lock, we also check for D/F
conflicts. This can occur in case-insensitive filesystems when trying to
fetch case-conflicted references like:

    refs/heads/Foo/new
    refs/heads/foo

D/F conflicts can also occur in case-sensitive filesystems, when the
repository already contains a directory with a lock file
'refs/heads/foo/bar.lock' and trying to fetch 'refs/heads/foo'. This
doesn't concern directories containing garbage files as those are
handled on a higher level.

To fix this, simply categorize the error as a name conflict. Also remove
this reference from the list of valid refnames for availability checks.
By categorizing the error and removing it from the list of valid
references, batched updates now knows to reject such reference updates
and apply the other reference updates.

Fix a small typo in `ref_transaction_maybe_set_rejected()` while here.

Helped-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
---
 refs.c               |  9 ++++++++-
 refs/files-backend.c | 11 ++++++-----
 t/t5510-fetch.sh     | 46 ++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 60 insertions(+), 6 deletions(-)

diff --git a/refs.c b/refs.c
index 4c1c339ed9..e7109ea5fe 100644
--- a/refs.c
+++ b/refs.c
@@ -1223,7 +1223,7 @@ int ref_transaction_maybe_set_rejected(struct ref_transaction *transaction,
 		return 0;
 
 	if (!transaction->rejections)
-		BUG("transaction not inititalized with failure support");
+		BUG("transaction not initialized with failure support");
 
 	/*
 	 * Don't accept generic errors, since these errors are not user
@@ -1232,6 +1232,13 @@ int ref_transaction_maybe_set_rejected(struct ref_transaction *transaction,
 	if (err == REF_TRANSACTION_ERROR_GENERIC)
 		return 0;
 
+	/*
+	 * Rejected refnames shouldn't be considered in the availability
+	 * checks, so remove them from the list.
+	 */
+	string_list_remove(&transaction->refnames,
+			   transaction->updates[update_idx]->refname, 0);
+
 	transaction->updates[update_idx]->rejection_err = err;
 	ALLOC_GROW(transaction->rejections->update_indices,
 		   transaction->rejections->nr + 1,
diff --git a/refs/files-backend.c b/refs/files-backend.c
index bfdf85121a..4a0343d827 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -870,6 +870,7 @@ static enum ref_transaction_error lock_raw_ref(struct files_ref_store *refs,
 				goto error_return;
 			} else if (remove_dir_recursively(&ref_file,
 							  REMOVE_DIR_EMPTY_ONLY)) {
+				ret = REF_TRANSACTION_ERROR_NAME_CONFLICT;
 				if (refs_verify_refname_available(
 						    &refs->base, refname,
 						    extras, NULL, 0, err)) {
@@ -877,14 +878,14 @@ static enum ref_transaction_error lock_raw_ref(struct files_ref_store *refs,
 					 * The error message set by
 					 * verify_refname_available() is OK.
 					 */
-					ret = REF_TRANSACTION_ERROR_NAME_CONFLICT;
 					goto error_return;
 				} else {
 					/*
-					 * We can't delete the directory,
-					 * but we also don't know of any
-					 * references that it should
-					 * contain.
+					 * Directory conflicts can occur if there
+					 * is an existing lock file in the directory
+					 * or if the filesystem is case-insensitive
+					 * and the directory contains a valid reference
+					 * but conflicts with the update.
 					 */
 					strbuf_addf(err, "there is a non-empty directory '%s' "
 						    "blocking reference '%s'",
diff --git a/t/t5510-fetch.sh b/t/t5510-fetch.sh
index 08dbea6503..6b2739db26 100755
--- a/t/t5510-fetch.sh
+++ b/t/t5510-fetch.sh
@@ -59,6 +59,12 @@ test_expect_success "clone and setup child repos" '
 		cd case_sensitive_fd &&
 		git branch foo/bar &&
 		git branch Foo
+	) &&
+	git clone --ref-format=reftable . case_sensitive_df &&
+	(
+		cd case_sensitive_df &&
+		git branch Foo/bar &&
+		git branch foo
 	)
 '
 
@@ -1592,6 +1598,46 @@ test_expect_success CASE_INSENSITIVE_FS,REFFILES 'F/D conflict on case insensiti
 	)
 '
 
+test_expect_success CASE_INSENSITIVE_FS,REFFILES 'D/F conflict on case insensitive filesystem' '
+	test_when_finished rm -rf case_insensitive &&
+	(
+		git init --bare case_insensitive &&
+		cd case_insensitive &&
+		git remote add origin -- ../case_sensitive_df &&
+		test_must_fail git fetch -f origin "refs/heads/*:refs/heads/*" 2>err &&
+		test_grep "failed: refname conflict" err &&
+		git rev-parse refs/heads/main >expect &&
+		git rev-parse refs/heads/Foo/bar >actual &&
+		test_cmp expect actual
+	)
+'
+
+test_expect_success REFFILES 'D/F conflict on case sensitive filesystem with lock' '
+	(
+		git init --ref-format=reftable base &&
+		cd base &&
+		echo >file update &&
+		git add . &&
+		git commit -m "updated" &&
+		git branch -M main &&
+
+		git update-ref refs/heads/foo @ &&
+		git update-ref refs/heads/branch @ &&
+		cd .. &&
+
+		git init --ref-format=files --bare repo &&
+		cd repo &&
+		git remote add origin ../base &&
+		mkdir refs/heads/foo &&
+		touch refs/heads/foo/random.lock &&
+		test_must_fail git fetch origin "refs/heads/*:refs/heads/*" 2>err &&
+		test_grep "some local refs could not be updated; try running" err &&
+		git rev-parse refs/heads/main >expect &&
+		git rev-parse refs/heads/branch >actual &&
+		test_cmp expect actual
+	)
+'
+
 . "$TEST_DIRECTORY"/lib-httpd.sh
 start_httpd
 

-- 
2.51.0

