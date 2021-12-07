Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5572FC433FE
	for <git@archiver.kernel.org>; Tue,  7 Dec 2021 13:38:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237243AbhLGNmC (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 7 Dec 2021 08:42:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237218AbhLGNl6 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Dec 2021 08:41:58 -0500
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D5A6C061574
        for <git@vger.kernel.org>; Tue,  7 Dec 2021 05:38:28 -0800 (PST)
Received: by mail-wr1-x435.google.com with SMTP id j3so29610369wrp.1
        for <git@vger.kernel.org>; Tue, 07 Dec 2021 05:38:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=sFhcJPD/UXyuC6RDfKOl0yb3a7+qO5odJVmbBbbbDBA=;
        b=ZOzqS/cjfx+LrClWVei8meSWshrst5hXrBs5SMH0FxYcVzOQ2i8lS5R17IdVHrVYhl
         6sz/uPYiZ6swiWGfhx7u1PvcS9B5fg1Q0KT/+jWoq1EuR8+CZ+5XcQMUvGv8nquvEKIu
         lAp9JipGCiscYNYIlyx4hS+AO6CrzafPOlAxO6/+SwkGeFRo++9WUtH3VxL93Wn8/uct
         SZpzl2XPitfCwamiz2WCb6PNXGMtn4ODcqwU2OzCIOVjlpHylmd6FtwAqCk4Dto6ehI0
         6FE7U9SzZf3MQYtBAEzcc71ywIHw1tbn8imCT6hJD9skGfALTu4foJZ/+YqgxjWt1F7f
         19PA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=sFhcJPD/UXyuC6RDfKOl0yb3a7+qO5odJVmbBbbbDBA=;
        b=y+1fshhe1DEZ/Wz3++tf9Zt75ckBYf3G9XHTBErfFPxQzJSTmJdAzLGAfNj1zrnmxY
         ENHYCw3WEu+BSzAQuwolZKpBflYqEMZOKMaxai84KyvCARgm7TyRD9uF98v4JleCyp6A
         tRx7xD9Ua18eWKwQGal4dcsglMlrQ5gWoaf2E1BHhU/yJyRzP3mnkRIY3HmVFCWURoht
         pdAeFlx2UBT0ey+q3kBsCv8GluTPMCW7YhJHSixkSpQcfnXY0CLBRgFDmD9yvSPPpX3G
         0QF10JOtUcdCRLSsFwOuvIicn7ziqPxmXj6lSqygW4EYF/HbSJM/1N+pl+L7qp4Vp48g
         OUxw==
X-Gm-Message-State: AOAM533jDgPYIQdH32WTHtqgHCyCT/Zl8GtbU5F1bC7QuifTYtg+kY2J
        w7c9QXVnh1N1pEoVjsZyVgXSa9V0InU=
X-Google-Smtp-Source: ABdhPJzVWl9Ic+4voO6VCaMg7VV9Ok5ZU5xGqv81/t7+e+0/3pGtUmRboPFAlnnZlqtQUeDywIFqEg==
X-Received: by 2002:adf:d1cb:: with SMTP id b11mr51242857wrd.33.1638884306288;
        Tue, 07 Dec 2021 05:38:26 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id k27sm2882602wms.41.2021.12.07.05.38.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Dec 2021 05:38:25 -0800 (PST)
Message-Id: <577726dc9dffb14558cfe5d3183c6b96c149b3fb.1638884300.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1147.v4.git.git.1638884300.gitgitgadget@gmail.com>
References: <pull.1147.v3.git.git.1638470403.gitgitgadget@gmail.com>
        <pull.1147.v4.git.git.1638884300.gitgitgadget@gmail.com>
From:   "Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 07 Dec 2021 13:38:18 +0000
Subject: [PATCH v4 6/8] refs: introduce REF_SKIP_REFNAME_VERIFICATION flag
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Han-Wen Nienhuys <hanwen@google.com>, Jeff King <peff@peff.net>,
        Han-Wen Nienhuys <hanwenn@gmail.com>,
        Han-Wen Nienhuys <hanwen@google.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Han-Wen Nienhuys <hanwen@google.com>

Use this flag with the test-helper in t1430, to avoid direct writes to the ref
database.

Signed-off-by: Han-Wen Nienhuys <hanwen@google.com>
---
 refs.c                    |  7 +++--
 refs.h                    | 10 +++++--
 t/helper/test-ref-store.c |  1 +
 t/t1430-bad-ref-name.sh   | 59 +++++++++++++++++++++------------------
 4 files changed, 45 insertions(+), 32 deletions(-)

diff --git a/refs.c b/refs.c
index 996ac271641..93bfe5b30cf 100644
--- a/refs.c
+++ b/refs.c
@@ -1083,9 +1083,10 @@ int ref_transaction_update(struct ref_transaction *transaction,
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
index 76efc589cca..65017ceaefc 100644
--- a/refs.h
+++ b/refs.h
@@ -621,12 +621,18 @@ struct ref_transaction *ref_transaction_begin(struct strbuf *err);
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
diff --git a/t/helper/test-ref-store.c b/t/helper/test-ref-store.c
index 0f3aa84c9f0..8bca4f2af1b 100644
--- a/t/helper/test-ref-store.c
+++ b/t/helper/test-ref-store.c
@@ -131,6 +131,7 @@ static struct flag_definition transaction_flags[] = {
 	FLAG_DEF(REF_NO_DEREF),
 	FLAG_DEF(REF_FORCE_CREATE_REFLOG),
 	FLAG_DEF(REF_SKIP_OID_VERIFICATION),
+	FLAG_DEF(REF_SKIP_REFNAME_VERIFICATION),
 	{ NULL, 0 }
 };
 
diff --git a/t/t1430-bad-ref-name.sh b/t/t1430-bad-ref-name.sh
index 4c77cf89a6c..326e5bd5e80 100755
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
+	test-tool ref-store main update-ref msg "refs/heads/broken...ref" $main_sha1 $ZERO_OID REF_SKIP_REFNAME_VERIFICATION &&
+	test_when_finished "test-tool ref-store main delete-refs REF_NO_DEREF msg refs/heads/broken...ref" &&
 	git branch >output 2>error &&
 	test_i18ngrep -e "ignoring ref with broken name refs/heads/broken\.\.\.ref" error &&
 	! grep -e "broken\.\.\.ref" output
 '
 
 test_expect_success 'branch -d can delete badly named ref' '
-	cp .git/refs/heads/main .git/refs/heads/broken...ref &&
-	test_when_finished "rm -f .git/refs/heads/broken...ref" &&
+	test-tool ref-store main update-ref msg "refs/heads/broken...ref" $main_sha1 $ZERO_OID REF_SKIP_REFNAME_VERIFICATION &&
+	test_when_finished "test-tool ref-store main delete-refs REF_NO_DEREF msg refs/heads/broken...ref" &&
 	git branch -d broken...ref &&
 	git branch >output 2>error &&
 	! grep -e "broken\.\.\.ref" error &&
@@ -60,8 +61,8 @@ test_expect_success 'branch -d can delete badly named ref' '
 '
 
 test_expect_success 'branch -D can delete badly named ref' '
-	cp .git/refs/heads/main .git/refs/heads/broken...ref &&
-	test_when_finished "rm -f .git/refs/heads/broken...ref" &&
+	test-tool ref-store main update-ref msg "refs/heads/broken...ref" $main_sha1 $ZERO_OID REF_SKIP_REFNAME_VERIFICATION &&
+	test_when_finished "test-tool ref-store main delete-refs REF_NO_DEREF msg refs/heads/broken...ref" &&
 	git branch -D broken...ref &&
 	git branch >output 2>error &&
 	! grep -e "broken\.\.\.ref" error &&
@@ -90,7 +91,7 @@ test_expect_success 'branch -D cannot delete absolute path' '
 '
 
 test_expect_success 'git branch cannot create a badly named ref' '
-	test_when_finished "rm -f .git/refs/heads/broken...ref" &&
+	test_when_finished "test-tool ref-store main delete-refs REF_NO_DEREF msg refs/heads/broken...ref" &&
 	test_must_fail git branch broken...ref &&
 	git branch >output 2>error &&
 	! grep -e "broken\.\.\.ref" error &&
@@ -98,7 +99,7 @@ test_expect_success 'git branch cannot create a badly named ref' '
 '
 
 test_expect_success 'branch -m cannot rename to a bad ref name' '
-	test_when_finished "rm -f .git/refs/heads/broken...ref" &&
+	test_when_finished "test-tool ref-store main delete-refs REF_NO_DEREF msg refs/heads/broken...ref" &&
 	test_might_fail git branch -D goodref &&
 	git branch goodref &&
 	test_must_fail git branch -m goodref broken...ref &&
@@ -109,8 +110,9 @@ test_expect_success 'branch -m cannot rename to a bad ref name' '
 '
 
 test_expect_failure 'branch -m can rename from a bad ref name' '
-	cp .git/refs/heads/main .git/refs/heads/broken...ref &&
-	test_when_finished "rm -f .git/refs/heads/broken...ref" &&
+	test-tool ref-store main update-ref msg "refs/heads/broken...ref" $main_sha1 $ZERO_OID REF_SKIP_REFNAME_VERIFICATION &&
+
+	test_when_finished "test-tool ref-store main delete-refs REF_NO_DEREF msg refs/heads/broken...ref" &&
 	git branch -m broken...ref renamed &&
 	test_cmp_rev main renamed &&
 	git branch >output 2>error &&
@@ -119,7 +121,7 @@ test_expect_failure 'branch -m can rename from a bad ref name' '
 '
 
 test_expect_success 'push cannot create a badly named ref' '
-	test_when_finished "rm -f .git/refs/heads/broken...ref" &&
+	test_when_finished "test-tool ref-store main delete-refs REF_NO_DEREF msg refs/heads/broken...ref" &&
 	test_must_fail git push "file://$(pwd)" HEAD:refs/heads/broken...ref &&
 	git branch >output 2>error &&
 	! grep -e "broken\.\.\.ref" error &&
@@ -139,7 +141,7 @@ test_expect_failure 'push --mirror can delete badly named ref' '
 		cd dest &&
 		test_commit two &&
 		git checkout --detach &&
-		cp .git/refs/heads/main .git/refs/heads/broken...ref
+		test-tool ref-store main update-ref msg "refs/heads/broken...ref" $main_sha1 $ZERO_OID REF_SKIP_REFNAME_VERIFICATION
 	) &&
 	git -C src push --mirror "file://$top/dest" &&
 	git -C dest branch >output 2>error &&
@@ -148,9 +150,9 @@ test_expect_failure 'push --mirror can delete badly named ref' '
 '
 
 test_expect_success 'rev-parse skips symref pointing to broken name' '
-	test_when_finished "rm -f .git/refs/heads/broken...ref" &&
+	test_when_finished "test-tool ref-store main delete-refs REF_NO_DEREF msg refs/heads/broken...ref" &&
 	git branch shadow one &&
-	cp .git/refs/heads/main .git/refs/heads/broken...ref &&
+	test-tool ref-store main update-ref msg "refs/heads/broken...ref" $main_sha1 $ZERO_OID REF_SKIP_REFNAME_VERIFICATION &&
 	printf "ref: refs/heads/broken...ref\n" >.git/refs/tags/shadow &&
 	test_when_finished "rm -f .git/refs/tags/shadow" &&
 	git rev-parse --verify one >expect &&
@@ -160,8 +162,8 @@ test_expect_success 'rev-parse skips symref pointing to broken name' '
 '
 
 test_expect_success 'for-each-ref emits warnings for broken names' '
-	cp .git/refs/heads/main .git/refs/heads/broken...ref &&
-	test_when_finished "rm -f .git/refs/heads/broken...ref" &&
+	test-tool ref-store main update-ref msg "refs/heads/broken...ref" $main_sha1 $ZERO_OID REF_SKIP_REFNAME_VERIFICATION &&
+	test_when_finished "test-tool ref-store main delete-refs REF_NO_DEREF msg refs/heads/broken...ref" &&
 	printf "ref: refs/heads/broken...ref\n" >.git/refs/heads/badname &&
 	test_when_finished "rm -f .git/refs/heads/badname" &&
 	printf "ref: refs/heads/main\n" >.git/refs/heads/broken...symref &&
@@ -176,8 +178,8 @@ test_expect_success 'for-each-ref emits warnings for broken names' '
 '
 
 test_expect_success 'update-ref -d can delete broken name' '
-	cp .git/refs/heads/main .git/refs/heads/broken...ref &&
-	test_when_finished "rm -f .git/refs/heads/broken...ref" &&
+	test-tool ref-store main update-ref msg "refs/heads/broken...ref" $main_sha1 $ZERO_OID REF_SKIP_REFNAME_VERIFICATION &&
+	test_when_finished "test-tool ref-store main delete-refs REF_NO_DEREF msg refs/heads/broken...ref" &&
 	git update-ref -d refs/heads/broken...ref >output 2>error &&
 	test_must_be_empty output &&
 	test_must_be_empty error &&
@@ -187,8 +189,8 @@ test_expect_success 'update-ref -d can delete broken name' '
 '
 
 test_expect_success 'branch -d can delete broken name' '
-	cp .git/refs/heads/main .git/refs/heads/broken...ref &&
-	test_when_finished "rm -f .git/refs/heads/broken...ref" &&
+	test-tool ref-store main update-ref msg "refs/heads/broken...ref" $main_sha1 $ZERO_OID REF_SKIP_REFNAME_VERIFICATION &&
+	test_when_finished "test-tool ref-store main delete-refs REF_NO_DEREF msg refs/heads/broken...ref" &&
 	git branch -d broken...ref >output 2>error &&
 	test_i18ngrep "Deleted branch broken...ref (was broken)" output &&
 	test_must_be_empty error &&
@@ -198,8 +200,9 @@ test_expect_success 'branch -d can delete broken name' '
 '
 
 test_expect_success 'update-ref --no-deref -d can delete symref to broken name' '
-	cp .git/refs/heads/main .git/refs/heads/broken...ref &&
-	test_when_finished "rm -f .git/refs/heads/broken...ref" &&
+	test-tool ref-store main update-ref msg "refs/heads/broken...ref" $main_sha1 $ZERO_OID REF_SKIP_REFNAME_VERIFICATION &&
+
+	test_when_finished "test-tool ref-store main delete-refs REF_NO_DEREF msg refs/heads/broken...ref" &&
 	printf "ref: refs/heads/broken...ref\n" >.git/refs/heads/badname &&
 	test_when_finished "rm -f .git/refs/heads/badname" &&
 	git update-ref --no-deref -d refs/heads/badname >output 2>error &&
@@ -209,8 +212,9 @@ test_expect_success 'update-ref --no-deref -d can delete symref to broken name'
 '
 
 test_expect_success 'branch -d can delete symref to broken name' '
-	cp .git/refs/heads/main .git/refs/heads/broken...ref &&
-	test_when_finished "rm -f .git/refs/heads/broken...ref" &&
+	test-tool ref-store main update-ref msg "refs/heads/broken...ref" $main_sha1 $ZERO_OID REF_SKIP_REFNAME_VERIFICATION &&
+
+	test_when_finished "test-tool ref-store main delete-refs REF_NO_DEREF msg refs/heads/broken...ref" &&
 	printf "ref: refs/heads/broken...ref\n" >.git/refs/heads/badname &&
 	test_when_finished "rm -f .git/refs/heads/badname" &&
 	git branch -d badname >output 2>error &&
@@ -238,8 +242,9 @@ test_expect_success 'branch -d can delete dangling symref to broken name' '
 '
 
 test_expect_success 'update-ref -d can delete broken name through symref' '
-	cp .git/refs/heads/main .git/refs/heads/broken...ref &&
-	test_when_finished "rm -f .git/refs/heads/broken...ref" &&
+	test-tool ref-store main update-ref msg "refs/heads/broken...ref" $main_sha1 $ZERO_OID REF_SKIP_REFNAME_VERIFICATION &&
+
+	test_when_finished "test-tool ref-store main delete-refs REF_NO_DEREF msg refs/heads/broken...ref" &&
 	printf "ref: refs/heads/broken...ref\n" >.git/refs/heads/badname &&
 	test_when_finished "rm -f .git/refs/heads/badname" &&
 	git update-ref -d refs/heads/badname >output 2>error &&
-- 
gitgitgadget

