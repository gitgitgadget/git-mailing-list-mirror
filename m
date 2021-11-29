Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BCC4C433EF
	for <git@archiver.kernel.org>; Mon, 29 Nov 2021 21:52:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232484AbhK2Vz4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 29 Nov 2021 16:55:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232692AbhK2Vxy (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 29 Nov 2021 16:53:54 -0500
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46DCFC043CE3
        for <git@vger.kernel.org>; Mon, 29 Nov 2021 10:49:51 -0800 (PST)
Received: by mail-wr1-x432.google.com with SMTP id d24so39030036wra.0
        for <git@vger.kernel.org>; Mon, 29 Nov 2021 10:49:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=441hnFEP0pDsGPACxyWqkbI6C0pj/gDFlnUBJ2HsBAM=;
        b=jWOhMXDggGIIHWVwiNv3+GcvEpZC6QlaiSPSPIlaeW6lTDuHMEfjKqbIRKhegUGx9w
         cc3EY1fxhZgsjqhlazXF6mz1q3hoLLMvykSvxLMI2LTYqG+TM/aVmZSHImt/O/NX7tXq
         R4Fo/Rp/GhiCvc6zmxJ5Nrt1emZOAG4WqCPix3RLTAS6+CPLF0k+QEIdYJBxrOY87B5j
         IWxiJL0cGavjDUEqQXslxnT1iITZObYe6iY1LWbSUWf54sGNIbNXaYEZeCjYXy5l3/Wf
         aEPYS8h7yX1McyCuNzuSs8FW1QpGbu+XQ1fMw4VZfUh7SCWOWU6uwmEuInsMatrgRRLX
         fy3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=441hnFEP0pDsGPACxyWqkbI6C0pj/gDFlnUBJ2HsBAM=;
        b=IwYoQPuletCqLKHu/1nRgRi32vbZgKCZ8Qa0jchszyd/V2qaxNkC1eW8ppl+Pn8hr0
         rEIC3ZIawXhJSVCuS0w8kc7+inko3za/DYQxGTcwM6+oWSlkBCXEYpaqhL79Z3SENxGK
         UGyw7Dx9+wUARaz2VduwnzZvm5z/j0l8Oc8x28RQPeUljhOkmvb2Ie2lZPQFKR10tknF
         tPaxZcFik8J8p9XG0K/65dTHX8w4BBx69nOsPzt1GeCsRGCw6RD1gBRWPZTiRtNe7aEC
         d4SdAv7KWrvSDpd9iyCadzfkNnRs1I/p0IS178lHS3kV7qV6Y7LraELseKoiNKZugdVl
         Tycw==
X-Gm-Message-State: AOAM532VVejTXfqoEJo9UibeojyHO9tAUcF83rauq7sJcR7TRJFLlwe3
        WWC1i7EzrUzFhCL+fC6yeYmqWWDqGMc=
X-Google-Smtp-Source: ABdhPJyZIl2S1YG1z0EuiSmT9HIM9A5FD6okl+4SZEApjM/lT4BvicgpuDAK4l3Y5VhSEeIcSd8AjA==
X-Received: by 2002:a5d:69c5:: with SMTP id s5mr35844211wrw.283.1638211789599;
        Mon, 29 Nov 2021 10:49:49 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id w2sm13957139wrn.67.2021.11.29.10.49.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Nov 2021 10:49:49 -0800 (PST)
Message-Id: <0a297f0c3e884c2d4cfb24a6d3b9f1973fc83125.1638211786.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1147.v2.git.git.1638211786.gitgitgadget@gmail.com>
References: <pull.1147.git.git.1637855761.gitgitgadget@gmail.com>
        <pull.1147.v2.git.git.1638211786.gitgitgadget@gmail.com>
From:   "Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 29 Nov 2021 18:49:44 +0000
Subject: [PATCH v2 4/6] refs: add REF_SKIP_REFNAME_VERIFICATION flag
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Han-Wen Nienhuys <hanwenn@gmail.com>,
        Han-Wen Nienhuys <hanwen@google.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Han-Wen Nienhuys <hanwen@google.com>

Use this flag with the test-helper in t1430, to avoid direct writes to the ref
database.

Signed-off-by: Han-Wen Nienhuys <hanwen@google.com>
---
 refs.c                  |  7 ++---
 refs.h                  | 10 +++++--
 t/t1430-bad-ref-name.sh | 59 ++++++++++++++++++++++-------------------
 3 files changed, 44 insertions(+), 32 deletions(-)

diff --git a/refs.c b/refs.c
index d7cc0a23a3b..086b1341d2a 100644
--- a/refs.c
+++ b/refs.c
@@ -1078,9 +1078,10 @@ int ref_transaction_update(struct ref_transaction *transaction,
 {
 	assert(err);
 
-	if ((new_oid && !is_null_oid(new_oid)) ?
-	    check_refname_format(refname, REFNAME_ALLOW_ONELEVEL) :
-	    !refname_is_safe(refname)) {
+	if (!(flags & REF_SKIP_REFNAME_VERIFICATION) &&
+	    ((new_oid && !is_null_oid(new_oid)) ?
+		     check_refname_format(refname, REFNAME_ALLOW_ONELEVEL) :
+			   !refname_is_safe(refname))) {
 		strbuf_addf(err, _("refusing to update ref with bad name '%s'"),
 			    refname);
 		return -1;
diff --git a/refs.h b/refs.h
index 46e68fd4c2a..684f8b33d17 100644
--- a/refs.h
+++ b/refs.h
@@ -617,12 +617,18 @@ struct ref_transaction *ref_transaction_begin(struct strbuf *err);
  */
 #define REF_SKIP_OID_VERIFICATION (1 << 10)
 
+/*
+ * Skip verifying refname. This is useful for testing data corruption scenarios.
+ */
+#define REF_SKIP_REFNAME_VERIFICATION (1 << 11)
+
 /*
  * Bitmask of all of the flags that are allowed to be passed in to
  * ref_transaction_update() and friends:
  */
-#define REF_TRANSACTION_UPDATE_ALLOWED_FLAGS \
-	(REF_NO_DEREF | REF_FORCE_CREATE_REFLOG | REF_SKIP_OID_VERIFICATION)
+#define REF_TRANSACTION_UPDATE_ALLOWED_FLAGS                                  \
+	(REF_NO_DEREF | REF_FORCE_CREATE_REFLOG | REF_SKIP_OID_VERIFICATION | \
+	 REF_SKIP_REFNAME_VERIFICATION)
 
 /*
  * Add a reference update to transaction. `new_oid` is the value that
diff --git a/t/t1430-bad-ref-name.sh b/t/t1430-bad-ref-name.sh
index 4c77cf89a6c..56d0726944e 100755
--- a/t/t1430-bad-ref-name.sh
+++ b/t/t1430-bad-ref-name.sh
@@ -9,7 +9,8 @@ TEST_PASSES_SANITIZE_LEAK=true
 
 test_expect_success setup '
 	test_commit one &&
-	test_commit two
+	test_commit two &&
+	main_sha1=$(git rev-parse refs/heads/main)
 '
 
 test_expect_success 'fast-import: fail on invalid branch name ".badbranchname"' '
@@ -43,16 +44,16 @@ test_expect_success 'fast-import: fail on invalid branch name "bad[branch]name"'
 '
 
 test_expect_success 'git branch shows badly named ref as warning' '
-	cp .git/refs/heads/main .git/refs/heads/broken...ref &&
-	test_when_finished "rm -f .git/refs/heads/broken...ref" &&
+	test-tool ref-store main update-ref msg "refs/heads/broken...ref" $main_sha1 $ZERO_OID 2048 &&
+	test_when_finished "test-tool ref-store main delete-refs 1 msg refs/heads/broken...ref" &&
 	git branch >output 2>error &&
 	test_i18ngrep -e "ignoring ref with broken name refs/heads/broken\.\.\.ref" error &&
 	! grep -e "broken\.\.\.ref" output
 '
 
 test_expect_success 'branch -d can delete badly named ref' '
-	cp .git/refs/heads/main .git/refs/heads/broken...ref &&
-	test_when_finished "rm -f .git/refs/heads/broken...ref" &&
+	test-tool ref-store main update-ref msg "refs/heads/broken...ref" $main_sha1 $ZERO_OID 2048 &&
+	test_when_finished "test-tool ref-store main delete-refs 1 msg refs/heads/broken...ref" &&
 	git branch -d broken...ref &&
 	git branch >output 2>error &&
 	! grep -e "broken\.\.\.ref" error &&
@@ -60,8 +61,8 @@ test_expect_success 'branch -d can delete badly named ref' '
 '
 
 test_expect_success 'branch -D can delete badly named ref' '
-	cp .git/refs/heads/main .git/refs/heads/broken...ref &&
-	test_when_finished "rm -f .git/refs/heads/broken...ref" &&
+	test-tool ref-store main update-ref msg "refs/heads/broken...ref" $main_sha1 $ZERO_OID 2048 &&
+	test_when_finished "test-tool ref-store main delete-refs 1 msg refs/heads/broken...ref" &&
 	git branch -D broken...ref &&
 	git branch >output 2>error &&
 	! grep -e "broken\.\.\.ref" error &&
@@ -90,7 +91,7 @@ test_expect_success 'branch -D cannot delete absolute path' '
 '
 
 test_expect_success 'git branch cannot create a badly named ref' '
-	test_when_finished "rm -f .git/refs/heads/broken...ref" &&
+	test_when_finished "test-tool ref-store main delete-refs 1 msg refs/heads/broken...ref" &&
 	test_must_fail git branch broken...ref &&
 	git branch >output 2>error &&
 	! grep -e "broken\.\.\.ref" error &&
@@ -98,7 +99,7 @@ test_expect_success 'git branch cannot create a badly named ref' '
 '
 
 test_expect_success 'branch -m cannot rename to a bad ref name' '
-	test_when_finished "rm -f .git/refs/heads/broken...ref" &&
+	test_when_finished "test-tool ref-store main delete-refs 1 msg refs/heads/broken...ref" &&
 	test_might_fail git branch -D goodref &&
 	git branch goodref &&
 	test_must_fail git branch -m goodref broken...ref &&
@@ -109,8 +110,9 @@ test_expect_success 'branch -m cannot rename to a bad ref name' '
 '
 
 test_expect_failure 'branch -m can rename from a bad ref name' '
-	cp .git/refs/heads/main .git/refs/heads/broken...ref &&
-	test_when_finished "rm -f .git/refs/heads/broken...ref" &&
+	test-tool ref-store main update-ref msg "refs/heads/broken...ref" $main_sha1 $ZERO_OID 2048 &&
+
+	test_when_finished "test-tool ref-store main delete-refs 1 msg refs/heads/broken...ref" &&
 	git branch -m broken...ref renamed &&
 	test_cmp_rev main renamed &&
 	git branch >output 2>error &&
@@ -119,7 +121,7 @@ test_expect_failure 'branch -m can rename from a bad ref name' '
 '
 
 test_expect_success 'push cannot create a badly named ref' '
-	test_when_finished "rm -f .git/refs/heads/broken...ref" &&
+	test_when_finished "test-tool ref-store main delete-refs 1 msg refs/heads/broken...ref" &&
 	test_must_fail git push "file://$(pwd)" HEAD:refs/heads/broken...ref &&
 	git branch >output 2>error &&
 	! grep -e "broken\.\.\.ref" error &&
@@ -139,7 +141,7 @@ test_expect_failure 'push --mirror can delete badly named ref' '
 		cd dest &&
 		test_commit two &&
 		git checkout --detach &&
-		cp .git/refs/heads/main .git/refs/heads/broken...ref
+		test-tool ref-store main update-ref msg "refs/heads/broken...ref" $main_sha1 $ZERO_OID 2048
 	) &&
 	git -C src push --mirror "file://$top/dest" &&
 	git -C dest branch >output 2>error &&
@@ -148,9 +150,9 @@ test_expect_failure 'push --mirror can delete badly named ref' '
 '
 
 test_expect_success 'rev-parse skips symref pointing to broken name' '
-	test_when_finished "rm -f .git/refs/heads/broken...ref" &&
+	test_when_finished "test-tool ref-store main delete-refs 1 msg refs/heads/broken...ref" &&
 	git branch shadow one &&
-	cp .git/refs/heads/main .git/refs/heads/broken...ref &&
+	test-tool ref-store main update-ref msg "refs/heads/broken...ref" $main_sha1 $ZERO_OID 2048 &&
 	printf "ref: refs/heads/broken...ref\n" >.git/refs/tags/shadow &&
 	test_when_finished "rm -f .git/refs/tags/shadow" &&
 	git rev-parse --verify one >expect &&
@@ -160,8 +162,8 @@ test_expect_success 'rev-parse skips symref pointing to broken name' '
 '
 
 test_expect_success 'for-each-ref emits warnings for broken names' '
-	cp .git/refs/heads/main .git/refs/heads/broken...ref &&
-	test_when_finished "rm -f .git/refs/heads/broken...ref" &&
+	test-tool ref-store main update-ref msg "refs/heads/broken...ref" $main_sha1 $ZERO_OID 2048 &&
+	test_when_finished "test-tool ref-store main delete-refs 1 msg refs/heads/broken...ref" &&
 	printf "ref: refs/heads/broken...ref\n" >.git/refs/heads/badname &&
 	test_when_finished "rm -f .git/refs/heads/badname" &&
 	printf "ref: refs/heads/main\n" >.git/refs/heads/broken...symref &&
@@ -176,8 +178,8 @@ test_expect_success 'for-each-ref emits warnings for broken names' '
 '
 
 test_expect_success 'update-ref -d can delete broken name' '
-	cp .git/refs/heads/main .git/refs/heads/broken...ref &&
-	test_when_finished "rm -f .git/refs/heads/broken...ref" &&
+	test-tool ref-store main update-ref msg "refs/heads/broken...ref" $main_sha1 $ZERO_OID 2048 &&
+	test_when_finished "test-tool ref-store main delete-refs 1 msg refs/heads/broken...ref" &&
 	git update-ref -d refs/heads/broken...ref >output 2>error &&
 	test_must_be_empty output &&
 	test_must_be_empty error &&
@@ -187,8 +189,8 @@ test_expect_success 'update-ref -d can delete broken name' '
 '
 
 test_expect_success 'branch -d can delete broken name' '
-	cp .git/refs/heads/main .git/refs/heads/broken...ref &&
-	test_when_finished "rm -f .git/refs/heads/broken...ref" &&
+	test-tool ref-store main update-ref msg "refs/heads/broken...ref" $main_sha1 $ZERO_OID 2048 &&
+	test_when_finished "test-tool ref-store main delete-refs 1 msg refs/heads/broken...ref" &&
 	git branch -d broken...ref >output 2>error &&
 	test_i18ngrep "Deleted branch broken...ref (was broken)" output &&
 	test_must_be_empty error &&
@@ -198,8 +200,9 @@ test_expect_success 'branch -d can delete broken name' '
 '
 
 test_expect_success 'update-ref --no-deref -d can delete symref to broken name' '
-	cp .git/refs/heads/main .git/refs/heads/broken...ref &&
-	test_when_finished "rm -f .git/refs/heads/broken...ref" &&
+	test-tool ref-store main update-ref msg "refs/heads/broken...ref" $main_sha1 $ZERO_OID 2048 &&
+
+	test_when_finished "test-tool ref-store main delete-refs 1 msg refs/heads/broken...ref" &&
 	printf "ref: refs/heads/broken...ref\n" >.git/refs/heads/badname &&
 	test_when_finished "rm -f .git/refs/heads/badname" &&
 	git update-ref --no-deref -d refs/heads/badname >output 2>error &&
@@ -209,8 +212,9 @@ test_expect_success 'update-ref --no-deref -d can delete symref to broken name'
 '
 
 test_expect_success 'branch -d can delete symref to broken name' '
-	cp .git/refs/heads/main .git/refs/heads/broken...ref &&
-	test_when_finished "rm -f .git/refs/heads/broken...ref" &&
+	test-tool ref-store main update-ref msg "refs/heads/broken...ref" $main_sha1 $ZERO_OID 2048 &&
+
+	test_when_finished "test-tool ref-store main delete-refs 1 msg refs/heads/broken...ref" &&
 	printf "ref: refs/heads/broken...ref\n" >.git/refs/heads/badname &&
 	test_when_finished "rm -f .git/refs/heads/badname" &&
 	git branch -d badname >output 2>error &&
@@ -238,8 +242,9 @@ test_expect_success 'branch -d can delete dangling symref to broken name' '
 '
 
 test_expect_success 'update-ref -d can delete broken name through symref' '
-	cp .git/refs/heads/main .git/refs/heads/broken...ref &&
-	test_when_finished "rm -f .git/refs/heads/broken...ref" &&
+	test-tool ref-store main update-ref msg "refs/heads/broken...ref" $main_sha1 $ZERO_OID 2048 &&
+
+	test_when_finished "test-tool ref-store main delete-refs 1 msg refs/heads/broken...ref" &&
 	printf "ref: refs/heads/broken...ref\n" >.git/refs/heads/badname &&
 	test_when_finished "rm -f .git/refs/heads/badname" &&
 	git update-ref -d refs/heads/badname >output 2>error &&
-- 
gitgitgadget

