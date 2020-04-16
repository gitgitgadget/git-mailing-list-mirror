Return-Path: <SRS0=FNL0=6A=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54251C3815B
	for <git@archiver.kernel.org>; Thu, 16 Apr 2020 16:24:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2DA3120857
	for <git@archiver.kernel.org>; Thu, 16 Apr 2020 16:24:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AojR9Tyv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2410785AbgDPQYb (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 16 Apr 2020 12:24:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726307AbgDPQY0 (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 16 Apr 2020 12:24:26 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C7ACC061A10
        for <git@vger.kernel.org>; Thu, 16 Apr 2020 09:24:26 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id ms17so571980pjb.0
        for <git@vger.kernel.org>; Thu, 16 Apr 2020 09:24:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=jsVCleHySyaVFPGUoZmhJMYlz0VCNulpT+sG/NRCynA=;
        b=AojR9TyvfBl1RfW/6q5RoJfISIkIQc3mfZofACCRS1pLAT/wloV3Vw2gk7aCS5nQ5W
         IxrYB+3QUhFgXizRd/A3Qh+Xyu4as4dqJRB8a4XP/KRDfqxmBqQWjCDuRRU57aQbQWfY
         LoWueZ8PgjTltSsOLKOz1UW602T9C6v4QcH2C2y/MQKzDygmJJ0E9iG4uztCdIPr3Wm8
         CXt2Gw5RUviZ6Eth8+RaN8hqgIgdP0NqMWGY4bF6yhB3jfrrHXwWQ6bm2VIUre+YH0qu
         ANxMNrSKVqUzpjvwp1KaseDGalfnKopp9eg3dOQeLx6EvGQp4dltCieJ5yx6TKJIHXsg
         yoKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=jsVCleHySyaVFPGUoZmhJMYlz0VCNulpT+sG/NRCynA=;
        b=bIitrcVL/6bIis2tC0fkH/I/+F5/V7pYn5QaPchPZ+Tq3IFAWV7o5KbHgMdxCH6r8q
         bxnJ2vJ8yRJuMsPB/PkxOjGAFlE6eNiYXssA/5eVOd+Kf86o3reDGktOp4IrhmC3eAXj
         ADdG/lB1z4Uv/8WJqyh1a6vfboV6IaATHeWAgb1GyrWDmDOaNUBq3EQSn/tq1Ftik88Q
         nq+pvgPLO5KvVpO/g6K4fNWKlVK3Ap7L8hVr0QZLmMM2cQ3dOHjF5cteCwqMAcNN2/vD
         OixmHnN0eKJY0fXCe2z0p0PFMXDgfH1TIgCd/j4REVql0dpVwqX7dWcwfz9nVgIRMxX+
         af9Q==
X-Gm-Message-State: AGi0PuZutpLxjrhkG02PztyXF93YvqAXhrxQZKUdNShX9px7cbx0jiSs
        UAPtr+PuKpPHX3aZaDlc9wU=
X-Google-Smtp-Source: APiQypLEVBT5MxTpKYqERlcNTvcmpVz4y22KxkRNj7qwi6XzrBhyFjHQYA68bjBSkz6FL0MxO5EGMQ==
X-Received: by 2002:a17:902:b681:: with SMTP id c1mr9703641pls.143.1587054265811;
        Thu, 16 Apr 2020 09:24:25 -0700 (PDT)
Received: from tigtog.localdomain.localdomain ([144.34.163.219])
        by smtp.gmail.com with ESMTPSA id c125sm17007933pfa.142.2020.04.16.09.24.24
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 16 Apr 2020 09:24:25 -0700 (PDT)
From:   Jiang Xin <worldhello.net@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>
Cc:     Jiang Xin <zhiyou.jx@alibaba-inc.com>
Subject: [PATCH v3 4/5] transport-helper: mark failure for atomic push
Date:   Thu, 16 Apr 2020 12:24:14 -0400
Message-Id: <20200416162415.5751-5-worldhello.net@gmail.com>
X-Mailer: git-send-email 2.26.0.rc0
In-Reply-To: <20200329143329.13846-1-worldhello.net@gmail.com>
References: <20200329143329.13846-1-worldhello.net@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jiang Xin <zhiyou.jx@alibaba-inc.com>

Commit v2.22.0-1-g3bca1e7f9f (transport-helper: enforce atomic in
push_refs_with_push, 2019-07-11) noticed the incomplete report of
failure of an atomic push for HTTP protocol.  But the implementation
has a flaw that mark all remote references as failure.

Only mark necessary references as failure in `push_refs_with_push()` of
transport-helper.

Signed-off-by: Jiang Xin <zhiyou.jx@alibaba-inc.com>
---
 t/t5541-http-push-smart.sh | 14 +++++++++++---
 t/t5548-push-porcelain.sh  |  5 ++---
 transport-helper.c         | 15 +++++++++++++++
 3 files changed, 28 insertions(+), 6 deletions(-)

diff --git a/t/t5541-http-push-smart.sh b/t/t5541-http-push-smart.sh
index 2c2c3fb0f5..afc680d5e3 100755
--- a/t/t5541-http-push-smart.sh
+++ b/t/t5541-http-push-smart.sh
@@ -177,7 +177,10 @@ test_expect_success 'push (chunked)' '
 	 test $HEAD = $(git rev-parse --verify HEAD))
 '
 
-test_expect_failure 'push --atomic also prevents branch creation, reports collateral' '
+## References of remote: atomic1(1)            master(2) collateral(2) other(2)
+## References of local :            atomic2(2) master(1) collateral(3) other(2) collateral1(3) atomic(1)
+## Atomic push         :                       master(1) collateral(3)                         atomic(1)
+test_expect_success 'push --atomic also prevents branch creation, reports collateral' '
 	# Setup upstream repo - empty for now
 	d=$HTTPD_DOCUMENT_ROOT_PATH/atomic-branches.git &&
 	git init --bare "$d" &&
@@ -189,7 +192,8 @@ test_expect_failure 'push --atomic also prevents branch creation, reports collat
 	test_commit atomic2 &&
 	git branch collateral &&
 	git branch other &&
-	git push "$up" master collateral other &&
+	git push "$up" atomic1 master collateral other &&
+	git tag -d atomic1 &&
 
 	# collateral is a valid push, but should be failed by atomic push
 	git checkout collateral &&
@@ -224,7 +228,11 @@ test_expect_failure 'push --atomic also prevents branch creation, reports collat
 
 	# the collateral failure refs should be indicated to the user
 	grep "^ ! .*rejected.* atomic -> atomic .*atomic push failed" output &&
-	grep "^ ! .*rejected.* collateral -> collateral .*atomic push failed" output
+	grep "^ ! .*rejected.* collateral -> collateral .*atomic push failed" output &&
+
+	# never report what we do not push
+	! grep "^ ! .*rejected.* atomic1 " output &&
+	! grep "^ ! .*rejected.* other " output
 '
 
 test_expect_success 'push --atomic fails on server-side errors' '
diff --git a/t/t5548-push-porcelain.sh b/t/t5548-push-porcelain.sh
index e7d9e06dac..898099aede 100755
--- a/t/t5548-push-porcelain.sh
+++ b/t/t5548-push-porcelain.sh
@@ -110,7 +110,7 @@ run_git_push_porcelain_output_test() {
 	# Refs of upstream : master(A)  bar(B)  baz(A)  next(A)
 	# Refs of workbench: master(B)  bar(A)  baz(A)  next(A)
 	# git-push         : master(B)  bar(A)  NULL    next(A)
-	test_expect_failure "atomic push failed ($PROTOCOL)" '
+	test_expect_success "atomic push failed ($PROTOCOL)" '
 		(
 			cd workbench &&
 			git update-ref refs/heads/master $B &&
@@ -124,10 +124,10 @@ run_git_push_porcelain_output_test() {
 		make_user_friendly_and_stable_output <out >actual &&
 		cat >expect <<-EOF &&
 		To <URL/of/upstream.git>
+		=    refs/heads/next:refs/heads/next    [up to date]
 		!    refs/heads/bar:refs/heads/bar    [rejected] (non-fast-forward)
 		!    (delete):refs/heads/baz    [rejected] (atomic push failed)
 		!    refs/heads/master:refs/heads/master    [rejected] (atomic push failed)
-		!    refs/heads/next:refs/heads/next    [rejected] (atomic push failed)
 		Done
 		EOF
 		test_cmp expect actual &&
@@ -142,7 +142,6 @@ run_git_push_porcelain_output_test() {
 		EOF
 		test_cmp expect actual
 	'
-
 	test_expect_success "prepare pre-receive hook ($PROTOCOL)" '
 		write_script "$upstream/hooks/pre-receive" <<-EOF
 		exit 1
diff --git a/transport-helper.c b/transport-helper.c
index 20a7185ec4..ab3b52eb14 100644
--- a/transport-helper.c
+++ b/transport-helper.c
@@ -894,6 +894,21 @@ static int push_refs_with_push(struct transport *transport,
 		case REF_STATUS_REJECT_STALE:
 		case REF_STATUS_REJECT_ALREADY_EXISTS:
 			if (atomic) {
+				/* Mark other refs as failed */
+				for (ref = remote_refs; ref; ref = ref->next) {
+					if (!ref->peer_ref && !mirror)
+						continue;
+
+					switch (ref->status) {
+					case REF_STATUS_NONE:
+					case REF_STATUS_OK:
+					case REF_STATUS_EXPECTING_REPORT:
+						ref->status = REF_STATUS_ATOMIC_PUSH_FAILED;
+						continue;
+					default:
+						break; /* do nothing */
+					}
+				}
 				string_list_clear(&cas_options, 0);
 				return 0;
 			} else
-- 
2.24.1.15.g448c31058d.agit.4.5

