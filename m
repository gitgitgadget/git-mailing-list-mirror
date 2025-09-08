Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3912302148
	for <git@vger.kernel.org>; Mon,  8 Sep 2025 12:37:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757335065; cv=none; b=p6zjCrGq34KRtzJtSrJLQBJWK4asxRlg+w98MHn2IFVGMW6uzwO+1val59fkbB8TQlvzi8m1hmS4L9f+4op1JZTkcmjVf8FA7xMuaupfiZYPc894aI7ZzyFIXK8sxeP0/VIENN5DqXpdvc40THvNVvWFQm/NnOoAvXBxL7jMKE0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757335065; c=relaxed/simple;
	bh=oqfQyPdrsdB5P+uUfkVlFsr++s8sUEKZX4INdpsFbzI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=OWAN5bNUVxACIaKWIrJuITwfKWuYd0fbkGczlRiqar6u+n9qJIsZkkzJFEdFw0T8oAIvtSayil64Za+of52N7Md63ZnVl/+SlpEjMznZ+YVWSE/Wej7meqh/HmAuLNxXZ3ZUMQCo3Ei3HRVPD7I6g3f5GTgCDYT3pxXbo7n11xU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IUb5gFKa; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IUb5gFKa"
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-62598fcf41aso2615019a12.3
        for <git@vger.kernel.org>; Mon, 08 Sep 2025 05:37:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757335062; x=1757939862; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xXrLMSbGUEfIBLoOIcxuiSdHRQP56cTiZH1+n+8AIlg=;
        b=IUb5gFKaHLcgLkkkFISygMnrjpCFWXYI3f0NpLelxuXHZRtLtlUgELuWhvW9VmXVqI
         ESHIUbDMMiIn9NV9PQAGyuGwa2EP8N0xHT9OZMzIpf+pleIzpcjWCBhJBbbg4K26IWu8
         VfigdcJ5ScBrP1P7Bwh4cBw9eXtzAqagduiAFEV0jdAO6KtT9gaaQwX0Kqn7cPE0kzl+
         k6RrlMNPjWMNXDW7R2yGREDRcm0sAJE3JxrewO/1hMefKxqhMaHYGd+ffcBnnuJHqtuj
         1JVDdgXo74/BM/g1le4ctyL4v1hZlxuGecdc+iTd1nMZ5cmLdrAV/MsOCGCJDiW4txcT
         NrtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757335062; x=1757939862;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xXrLMSbGUEfIBLoOIcxuiSdHRQP56cTiZH1+n+8AIlg=;
        b=gvSf2EgKnOJbmW7xfZiEaN268Z531kNa3VCuzDmex9V/t3x5t/XwaVTwWIziFsXtXO
         dIm9rai+8Qn0V7KIXXQ8UgcO0m4lggfVOFLgwgC50rkU5YlXqm6ejSeYQI657u2WUhh2
         rFDRxeTUFHKr6pLER2Y8brfoKYw9mnwGnKOhZUehXBLYm6/dWz5j0LXGgq33qmEjOlim
         +yC607GvHwpgcvzIkAQYV3I6eMkjucjWaDJmU9zri34tKhamY1eMvMO2Yt06E5RA6qCW
         swzP4y3O7UfVy7H8rToO/wq9q+bngunWYWnzBlHNaFCiiFuK669sUr2wrThsvEyGSKmB
         iJww==
X-Gm-Message-State: AOJu0YydflQ/zMLZZkDCIdYQYf/9DDHHPhcR/phW3UAFRuW5gkel0NGw
	EAKUACK2cy3GrOYSMYOo9xnXORZKgByDn+FBkQUW7RNnSXAtR9AM3N2T
X-Gm-Gg: ASbGncvU0Ro23qlVVb60ArPAq41t8TmkfWsZjXzSlzB5jimULGAlsTsSbZHZX2V+mtC
	fhZrtXKYxDnATPLq+O4nrbedHjt/ldSnRGQtok3ZFdbnDscTt/61OadUGr++OhG+QFHjctCWw4u
	7b7q3ZaYKb066poNxaoBg+RpQKt0HtBNoLMlEOjKlJjQD2cabREsGZxfV3b6lUQJEzv4X/lx6ZL
	g3dmwpHszsQzpMEMODKTTOkx4cLV2EnLJ55EESeXWAtbSqUB4dzilsiuwRztevxhyTC+6m4Cb6+
	sjEc4ZoNIWvb8CQwfxFK+k3XQPNm8wNttmRJPJR6dZlFfOgHaDJJP6FgMGW+MF6K8mWvqN9UWDR
	wJl2ihxPYBr0HUg/xrxKRaE8020cW/J7DnEWGn3cdOi2O7H6sOA==
X-Google-Smtp-Source: AGHT+IFOi1V4qQB3GFXPlZhE4PE8f+c2Jelz84dvgr9dSmSayQQMxhIdjhRK+4Gazuy3rkLvALxbsQ==
X-Received: by 2002:a05:6402:5c9:b0:61c:deac:4693 with SMTP id 4fb4d7f45d1cf-6237336bf54mr6713486a12.12.1757335062124;
        Mon, 08 Sep 2025 05:37:42 -0700 (PDT)
Received: from [127.0.0.2] ([2a02:2455:8268:bc00:c9f4:d82a:f11d:d7f9])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-61cfc1c7848sm23257445a12.2.2025.09.08.05.37.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Sep 2025 05:37:41 -0700 (PDT)
From: Karthik Nayak <karthik.188@gmail.com>
Date: Mon, 08 Sep 2025 14:37:38 +0200
Subject: [PATCH v2 4/4] refs/files: handle D/F conflicts during locking
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250908-587-git-fetch-1-fails-fetches-on-case-insensitive-repositories-v2-4-b2eb2459befb@gmail.com>
References: <20250908-587-git-fetch-1-fails-fetches-on-case-insensitive-repositories-v2-0-b2eb2459befb@gmail.com>
In-Reply-To: <20250908-587-git-fetch-1-fails-fetches-on-case-insensitive-repositories-v2-0-b2eb2459befb@gmail.com>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>, 
 Joe Drew <joe.drew@indexexchange.com>, peff@peff.net, ps@pks.im, 
 gitster@pobox.com
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=4528; i=karthik.188@gmail.com;
 h=from:subject:message-id; bh=oqfQyPdrsdB5P+uUfkVlFsr++s8sUEKZX4INdpsFbzI=;
 b=owJ4nAHtARL+kA0DAAoBPtWfJI5GjH8ByyZiAGi+zhH8ceQJDLKmkeosf4Y2saV0pyrBxOglX
 lC3cvx1B9LNW4kBswQAAQoAHRYhBFfOTH9jdXEPy2XGBj7VnySORox/BQJovs4RAAoJED7VnySO
 Rox/7eAL/R12QvTyWAntKs3BhRn5Rsg7MkU7ARV/0jr/1QHe2ncvdPY1jT8XO+xjfCFXEqdYktx
 JeJnuCH/q+V5UTWZfqgzC3PMSKLXxCPT8xvlzU16uISMHOwYa7+Y//3FtxX0lba8k01fRqvgBWw
 nSjeZ+t2gzqYaD7N4gBgFGRj9nqmeD6NKydq580ZyBFnumM7IQp3Eg4j2OEZkLRDn1KubZOMCTi
 5/WcbpGwrEcwbSXH0ARsiEDAC/DbTHNAu+0zsGYCdluLSttw55tp6qdeLX5ENt5wryaSvasYUGD
 MLsdCilRkp76FIJNTISq5minOk6+GIkaAqooglslBpF3xEtxom5sKeArK8tgwK+5f0rohs5mWfA
 GluKly8vHDARg0uv+7jYYHKZx4+4l70Y8I3GgZYkZMq4UgSTGn3Q6rG6gfjFo4zkbnEeC8Lt3As
 ot5dl7f4Qx/9FdpaTS7FfiurU2bGUPRm+5r5bza82ZkNM0jhCDAb8rKKSIYjuJAMw3+EW4z+Yh6
 E4=
X-Developer-Key: i=karthik.188@gmail.com; a=openpgp;
 fpr=57CE4C7F6375710FCB65C6063ED59F248E468C7F

The previous commit, added the necessary validation and checks for F/D
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
conflicts. To fix this, simply categorize the error as a name conflict.
Also remove this reference from the list of valid refnames for
availability checks.

By categorizing the error and removing it from the list of valid
references, batched updates now knows to reject such reference updates
and apply the other reference updates.

Fix a small typo in `ref_transaction_maybe_set_rejected()` while here.

Helped-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
---
 refs.c               |  8 +++++++-
 refs/files-backend.c |  2 +-
 t/t5510-fetch.sh     | 20 ++++++++++++++++++++
 3 files changed, 28 insertions(+), 2 deletions(-)

diff --git a/refs.c b/refs.c
index 4c1c339ed9..ec4f0e9502 100644
--- a/refs.c
+++ b/refs.c
@@ -1223,7 +1223,7 @@ int ref_transaction_maybe_set_rejected(struct ref_transaction *transaction,
 		return 0;
 
 	if (!transaction->rejections)
-		BUG("transaction not inititalized with failure support");
+		BUG("transaction not initialized with failure support");
 
 	/*
 	 * Don't accept generic errors, since these errors are not user
@@ -1232,6 +1232,12 @@ int ref_transaction_maybe_set_rejected(struct ref_transaction *transaction,
 	if (err == REF_TRANSACTION_ERROR_GENERIC)
 		return 0;
 
+	/*
+	 * Remove this refname from the list of refnames used for validation
+	 */
+	string_list_remove(&transaction->refnames,
+			   transaction->updates[update_idx]->refname, 0);
+
 	transaction->updates[update_idx]->rejection_err = err;
 	ALLOC_GROW(transaction->rejections->update_indices,
 		   transaction->rejections->nr + 1,
diff --git a/refs/files-backend.c b/refs/files-backend.c
index 85f2e14e93..ceeec272ff 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -852,6 +852,7 @@ static enum ref_transaction_error lock_raw_ref(struct files_ref_store *refs,
 				goto error_return;
 			} else if (remove_dir_recursively(&ref_file,
 							  REMOVE_DIR_EMPTY_ONLY)) {
+				ret = REF_TRANSACTION_ERROR_NAME_CONFLICT;
 				if (refs_verify_refname_available(
 						    &refs->base, refname,
 						    extras, NULL, 0, err)) {
@@ -859,7 +860,6 @@ static enum ref_transaction_error lock_raw_ref(struct files_ref_store *refs,
 					 * The error message set by
 					 * verify_refname_available() is OK.
 					 */
-					ret = REF_TRANSACTION_ERROR_NAME_CONFLICT;
 					goto error_return;
 				} else {
 					/*
diff --git a/t/t5510-fetch.sh b/t/t5510-fetch.sh
index 08dbea6503..ffaa956cde 100755
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
 
@@ -1592,6 +1598,20 @@ test_expect_success CASE_INSENSITIVE_FS,REFFILES 'F/D conflict on case insensiti
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
 . "$TEST_DIRECTORY"/lib-httpd.sh
 start_httpd
 

-- 
2.50.1

