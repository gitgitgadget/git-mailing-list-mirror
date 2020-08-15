Return-Path: <SRS0=NddV=BZ=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BFBDC433E1
	for <git@archiver.kernel.org>; Sat, 15 Aug 2020 21:57:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F17BA206B6
	for <git@archiver.kernel.org>; Sat, 15 Aug 2020 21:57:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="vIrFmQlz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729469AbgHOV5J (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 15 Aug 2020 17:57:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726458AbgHOVwJ (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 15 Aug 2020 17:52:09 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 696B9C0068BC
        for <git@vger.kernel.org>; Sat, 15 Aug 2020 10:17:55 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id c10so6560406pjn.1
        for <git@vger.kernel.org>; Sat, 15 Aug 2020 10:17:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=pHIUHMq1L/XNr2cbF7yh0h0ZcpFhFcWLb8XNh8pk5Go=;
        b=vIrFmQlz8fMeOe4oDrF6s3XP9ijAhqxAh/5e9/rw0DiRt+fm4PTJ7qGlDiGTr1tRGt
         hVUJeOCSsehSmZ2E80P/liLHGBSHSpCLpZOeSybDbbFuxu0yWtz/fmh2ZFTteBnmaNqo
         +QVPFhQG8gsiz679ssYPw1GF8PywKXV1dNOOa2WJdrWvlvk/HcQxIkme6TumoPO/7ESB
         312lP/aFWuzHHj04hgVI5N/g0yQ26IsbHWpZfP8ADZbSuSXZyhs6tF463RedIlfNFQKQ
         y61Yw0ZQD6+jQJNhtmXOsu/4yjRsqCYM0SdicCSLaM6a0XAW+p93rPX+Lx7VrBmg4J1R
         ynnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=pHIUHMq1L/XNr2cbF7yh0h0ZcpFhFcWLb8XNh8pk5Go=;
        b=dlp0f1yTK2G9fM2MoU/N78nqsZ1gsS/CJkpGYe8uiDzBEP7gwzL0LvkiS7m1tsUs0E
         1KAQH/k5mIBSh2omVyELfL1CiwmRUyyaJ++0h4yW8sdb2F/wtI6YyId5JH2WGFjpACbO
         82VblSv1v0QTsA7T9f16QQVRMEP4Q62NwQwioVQrU7IxrDBM3wSICWoTxKhGeld+tcFE
         WaH3CztMzIcZe2g7k4yWXkY66aPniX9rLF91v4Z1E2oh/K4cPTh2DFpGLS5i1P7iPPZK
         6TwzmpAyPO8qX3qE5+JvWeFn7fdiD6S5orWYqjxhPc3AkbYR+WUGQYcW4OPasSKVIuGZ
         7Txw==
X-Gm-Message-State: AOAM5335LJaNeFp1G9Y2uo8BRj1zVLgbKxyS9H5bPxAJo0jooWqCFrgm
        oeLlcAaOo1/2BrKW12h+ogU=
X-Google-Smtp-Source: ABdhPJyk/eHAh3RF4Vzdj3cP9NKRPDC7uy8/BKW4m5qKS99wynHlC0XTW+/V0Qn1vnSM/Y4+Z+swkA==
X-Received: by 2002:a17:902:76c5:: with SMTP id j5mr5898134plt.87.1597511874368;
        Sat, 15 Aug 2020 10:17:54 -0700 (PDT)
Received: from tigtog.localdomain.localdomain ([144.34.163.219])
        by smtp.gmail.com with ESMTPSA id x13sm11040596pga.30.2020.08.15.10.17.53
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 15 Aug 2020 10:17:53 -0700 (PDT)
From:   Jiang Xin <worldhello.net@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>
Cc:     Jiang Xin <zhiyou.jx@alibaba-inc.com>
Subject: [PATCH v17 06/10] receive-pack: feed report options to post-receive
Date:   Sat, 15 Aug 2020 13:17:36 -0400
Message-Id: <20200815171740.6257-7-worldhello.net@gmail.com>
X-Mailer: git-send-email 2.26.0.rc0
In-Reply-To: <20200518094039.757-1-worldhello.net@gmail.com>
References: <20200518094039.757-1-worldhello.net@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jiang Xin <zhiyou.jx@alibaba-inc.com>

When commands are fed to the "post-receive" hook, report options will
be parsed and the real old-oid, new-oid, reference name will feed to
the "post-receive" hook.

Signed-off-by: Jiang Xin <zhiyou.jx@alibaba-inc.com>
---
 builtin/receive-pack.c                        | 29 ++++++++++++++++---
 t/t5411/once-0010-report-status-v1.sh         |  3 +-
 t/t5411/test-0032-report-with-options.sh      | 14 ++++-----
 ...est-0033-report-with-options--porcelain.sh | 14 ++++-----
 ...t-0036-report-multi-rewrite-for-one-ref.sh | 11 +++++--
 ...rt-multi-rewrite-for-one-ref--porcelain.sh | 11 +++++--
 t/t5411/test-0038-report-mixed-refs.sh        |  2 +-
 .../test-0039-report-mixed-refs--porcelain.sh |  2 +-
 8 files changed, 59 insertions(+), 27 deletions(-)

diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
index 58972aa7cf..a687218167 100644
--- a/builtin/receive-pack.c
+++ b/builtin/receive-pack.c
@@ -777,17 +777,38 @@ static int feed_receive_hook(void *state_, const char **bufp, size_t *sizep)
 {
 	struct receive_hook_feed_state *state = state_;
 	struct command *cmd = state->cmd;
+	static struct ref_push_report_options *options = NULL;
 
 	while (cmd &&
 	       state->skip_broken && (cmd->report.error_message || cmd->did_not_exist))
 		cmd = cmd->next;
 	if (!cmd)
 		return -1; /* EOF */
+	if (!bufp)
+		return 0; /* OK, can feed something. */
 	strbuf_reset(&state->buf);
-	strbuf_addf(&state->buf, "%s %s %s\n",
-		    oid_to_hex(&cmd->old_oid), oid_to_hex(&cmd->new_oid),
-		    cmd->ref_name);
-	state->cmd = cmd->next;
+	if (!options)
+		options = cmd->report.options;
+	if (options) {
+		struct object_id *old_oid;
+		struct object_id *new_oid;
+		const char *ref_name;
+
+		old_oid = options->old_oid ? options->old_oid : &cmd->old_oid;
+		new_oid = options->new_oid ? options->new_oid : &cmd->new_oid;
+		ref_name = options->ref_name ? options->ref_name : cmd->ref_name;
+		strbuf_addf(&state->buf, "%s %s %s\n",
+			    oid_to_hex(old_oid), oid_to_hex(new_oid),
+			    ref_name);
+		options = options->next;
+		if (!options)
+			state->cmd = cmd->next;
+	} else {
+		strbuf_addf(&state->buf, "%s %s %s\n",
+			    oid_to_hex(&cmd->old_oid), oid_to_hex(&cmd->new_oid),
+			    cmd->ref_name);
+		state->cmd = cmd->next;
+	}
 	if (bufp) {
 		*bufp = state->buf.buf;
 		*sizep = state->buf.len;
diff --git a/t/t5411/once-0010-report-status-v1.sh b/t/t5411/once-0010-report-status-v1.sh
index 56a86d8ed4..bf410dc418 100644
--- a/t/t5411/once-0010-report-status-v1.sh
+++ b/t/t5411/once-0010-report-status-v1.sh
@@ -74,7 +74,8 @@ test_expect_success "proc-receive: report status v1" '
 	post-receive< <COMMIT-A> <COMMIT-B> refs/heads/master
 	post-receive< <ZERO-OID> <COMMIT-A> refs/for/master/topic1
 	post-receive< <ZERO-OID> <COMMIT-A> refs/heads/foo
-	post-receive< <ZERO-OID> <COMMIT-A> refs/for/master/topic2
+	post-receive< <ZERO-OID> <COMMIT-A> refs/for/changes/23/123/1
+	post-receive< <COMMIT-B> <COMMIT-A> refs/for/changes/24/124/2
 	EOF
 	test_cmp expect actual &&
 
diff --git a/t/t5411/test-0032-report-with-options.sh b/t/t5411/test-0032-report-with-options.sh
index 3742ed3c3d..b77b78c49f 100644
--- a/t/t5411/test-0032-report-with-options.sh
+++ b/t/t5411/test-0032-report-with-options.sh
@@ -54,7 +54,7 @@ test_expect_success "proc-receive: report option refname ($PROTOCOL)" '
 	remote: proc-receive> ok refs/for/master/topic
 	remote: proc-receive> option refname refs/pull/123/head
 	remote: # post-receive hook
-	remote: post-receive< <ZERO-OID> <COMMIT-A> refs/for/master/topic
+	remote: post-receive< <ZERO-OID> <COMMIT-A> refs/pull/123/head
 	To <URL/of/upstream.git>
 	 * [new reference] HEAD -> refs/pull/123/head
 	EOF
@@ -87,7 +87,7 @@ test_expect_success "proc-receive: report option refname and forced-update ($PRO
 	remote: proc-receive> option refname refs/pull/123/head
 	remote: proc-receive> option forced-update
 	remote: # post-receive hook
-	remote: post-receive< <ZERO-OID> <COMMIT-A> refs/for/master/topic
+	remote: post-receive< <ZERO-OID> <COMMIT-A> refs/pull/123/head
 	To <URL/of/upstream.git>
 	 * [new reference] HEAD -> refs/pull/123/head
 	EOF
@@ -121,7 +121,7 @@ test_expect_success "proc-receive: report option refname and old-oid ($PROTOCOL)
 	remote: proc-receive> option refname refs/pull/123/head
 	remote: proc-receive> option old-oid <COMMIT-B>
 	remote: # post-receive hook
-	remote: post-receive< <ZERO-OID> <COMMIT-A> refs/for/master/topic
+	remote: post-receive< <COMMIT-B> <COMMIT-A> refs/pull/123/head
 	To <URL/of/upstream.git>
 	 <OID-B>..<OID-A> HEAD -> refs/pull/123/head
 	EOF
@@ -153,7 +153,7 @@ test_expect_success "proc-receive: report option old-oid ($PROTOCOL)" '
 	remote: proc-receive> ok refs/for/master/topic
 	remote: proc-receive> option old-oid <COMMIT-B>
 	remote: # post-receive hook
-	remote: post-receive< <ZERO-OID> <COMMIT-A> refs/for/master/topic
+	remote: post-receive< <COMMIT-B> <COMMIT-A> refs/for/master/topic
 	To <URL/of/upstream.git>
 	 <OID-B>..<OID-A> HEAD -> refs/for/master/topic
 	EOF
@@ -187,7 +187,7 @@ test_expect_success "proc-receive: report option old-oid and new-oid ($PROTOCOL)
 	remote: proc-receive> option old-oid <COMMIT-A>
 	remote: proc-receive> option new-oid <COMMIT-B>
 	remote: # post-receive hook
-	remote: post-receive< <ZERO-OID> <COMMIT-A> refs/for/master/topic
+	remote: post-receive< <COMMIT-A> <COMMIT-B> refs/for/master/topic
 	To <URL/of/upstream.git>
 	 <OID-A>..<OID-B> HEAD -> refs/for/master/topic
 	EOF
@@ -237,9 +237,9 @@ test_expect_success "proc-receive: report with multiple rewrites ($PROTOCOL)" '
 	remote: proc-receive> option forced-update
 	remote: proc-receive> option new-oid <COMMIT-A>
 	remote: # post-receive hook
-	remote: post-receive< <ZERO-OID> <COMMIT-A> refs/for/next/topic
+	remote: post-receive< <ZERO-OID> <COMMIT-A> refs/pull/123/head
 	remote: post-receive< <ZERO-OID> <COMMIT-A> refs/for/a/b/c/topic
-	remote: post-receive< <ZERO-OID> <COMMIT-A> refs/for/master/topic
+	remote: post-receive< <COMMIT-B> <COMMIT-A> refs/pull/124/head
 	To <URL/of/upstream.git>
 	 * [new reference] HEAD -> refs/pull/123/head
 	 * [new reference] HEAD -> refs/for/a/b/c/topic
diff --git a/t/t5411/test-0033-report-with-options--porcelain.sh b/t/t5411/test-0033-report-with-options--porcelain.sh
index f18ba9f06f..1fe352b686 100644
--- a/t/t5411/test-0033-report-with-options--porcelain.sh
+++ b/t/t5411/test-0033-report-with-options--porcelain.sh
@@ -55,7 +55,7 @@ test_expect_success "proc-receive: report option refname ($PROTOCOL/porcelain)"
 	remote: proc-receive> ok refs/for/master/topic
 	remote: proc-receive> option refname refs/pull/123/head
 	remote: # post-receive hook
-	remote: post-receive< <ZERO-OID> <COMMIT-A> refs/for/master/topic
+	remote: post-receive< <ZERO-OID> <COMMIT-A> refs/pull/123/head
 	To <URL/of/upstream.git>
 	*    HEAD:refs/pull/123/head    [new reference]
 	Done
@@ -90,7 +90,7 @@ test_expect_success "proc-receive: report option refname and forced-update ($PRO
 	remote: proc-receive> option refname refs/pull/123/head
 	remote: proc-receive> option forced-update
 	remote: # post-receive hook
-	remote: post-receive< <ZERO-OID> <COMMIT-A> refs/for/master/topic
+	remote: post-receive< <ZERO-OID> <COMMIT-A> refs/pull/123/head
 	To <URL/of/upstream.git>
 	*    HEAD:refs/pull/123/head    [new reference]
 	Done
@@ -125,7 +125,7 @@ test_expect_success "proc-receive: report option refname and old-oid ($PROTOCOL/
 	remote: proc-receive> option refname refs/pull/123/head
 	remote: proc-receive> option old-oid <COMMIT-B>
 	remote: # post-receive hook
-	remote: post-receive< <ZERO-OID> <COMMIT-A> refs/for/master/topic
+	remote: post-receive< <COMMIT-B> <COMMIT-A> refs/pull/123/head
 	To <URL/of/upstream.git>
 	     HEAD:refs/pull/123/head    <OID-B>..<OID-A>
 	Done
@@ -158,7 +158,7 @@ test_expect_success "proc-receive: report option old-oid ($PROTOCOL/porcelain)"
 	remote: proc-receive> ok refs/for/master/topic
 	remote: proc-receive> option old-oid <COMMIT-B>
 	remote: # post-receive hook
-	remote: post-receive< <ZERO-OID> <COMMIT-A> refs/for/master/topic
+	remote: post-receive< <COMMIT-B> <COMMIT-A> refs/for/master/topic
 	To <URL/of/upstream.git>
 	     HEAD:refs/for/master/topic    <OID-B>..<OID-A>
 	Done
@@ -193,7 +193,7 @@ test_expect_success "proc-receive: report option old-oid and new-oid ($PROTOCOL/
 	remote: proc-receive> option old-oid <COMMIT-A>
 	remote: proc-receive> option new-oid <COMMIT-B>
 	remote: # post-receive hook
-	remote: post-receive< <ZERO-OID> <COMMIT-A> refs/for/master/topic
+	remote: post-receive< <COMMIT-A> <COMMIT-B> refs/for/master/topic
 	To <URL/of/upstream.git>
 	     HEAD:refs/for/master/topic    <OID-A>..<OID-B>
 	Done
@@ -245,9 +245,9 @@ test_expect_success "proc-receive: report with multiple rewrites ($PROTOCOL/porc
 	remote: proc-receive> option forced-update
 	remote: proc-receive> option new-oid <COMMIT-A>
 	remote: # post-receive hook
-	remote: post-receive< <ZERO-OID> <COMMIT-A> refs/for/next/topic
+	remote: post-receive< <ZERO-OID> <COMMIT-A> refs/pull/123/head
 	remote: post-receive< <ZERO-OID> <COMMIT-A> refs/for/a/b/c/topic
-	remote: post-receive< <ZERO-OID> <COMMIT-A> refs/for/master/topic
+	remote: post-receive< <COMMIT-B> <COMMIT-A> refs/pull/124/head
 	To <URL/of/upstream.git>
 	*    HEAD:refs/pull/123/head    [new reference]
 	*    HEAD:refs/for/a/b/c/topic    [new reference]
diff --git a/t/t5411/test-0036-report-multi-rewrite-for-one-ref.sh b/t/t5411/test-0036-report-multi-rewrite-for-one-ref.sh
index 64662afdc6..27d58edd14 100644
--- a/t/t5411/test-0036-report-multi-rewrite-for-one-ref.sh
+++ b/t/t5411/test-0036-report-multi-rewrite-for-one-ref.sh
@@ -41,7 +41,9 @@ test_expect_success "proc-receive: multiple rewrite for one ref, no refname for
 	remote: proc-receive> option old-oid <COMMIT-A>
 	remote: proc-receive> option new-oid <COMMIT-B>
 	remote: # post-receive hook
-	remote: post-receive< <ZERO-OID> <COMMIT-A> refs/for/master/topic
+	remote: post-receive< <COMMIT-A> <COMMIT-B> refs/for/master/topic
+	remote: post-receive< <ZERO-OID> <COMMIT-A> refs/changes/24/124/1
+	remote: post-receive< <COMMIT-A> <COMMIT-B> refs/changes/25/125/1
 	To <URL/of/upstream.git>
 	 <OID-A>..<OID-B> HEAD -> refs/for/master/topic
 	 * [new reference] HEAD -> refs/changes/24/124/1
@@ -101,7 +103,9 @@ test_expect_success "proc-receive: multiple rewrites for one ref, no refname for
 	remote: proc-receive> option new-oid <COMMIT-A>
 	remote: proc-receive> option forced-update
 	remote: # post-receive hook
-	remote: post-receive< <ZERO-OID> <COMMIT-A> refs/for/master/topic
+	remote: post-receive< <ZERO-OID> <COMMIT-A> refs/changes/24/124/1
+	remote: post-receive< <COMMIT-A> <COMMIT-B> refs/for/master/topic
+	remote: post-receive< <COMMIT-B> <COMMIT-A> refs/changes/25/125/1
 	To <URL/of/upstream.git>
 	 * [new reference] HEAD -> refs/changes/24/124/1
 	 <OID-A>..<OID-B> HEAD -> refs/for/master/topic
@@ -149,7 +153,8 @@ test_expect_success "proc-receive: multiple rewrites for one ref ($PROTOCOL)" '
 	remote: proc-receive> option old-oid <COMMIT-A>
 	remote: proc-receive> option new-oid <COMMIT-B>
 	remote: # post-receive hook
-	remote: post-receive< <ZERO-OID> <COMMIT-A> refs/for/master/topic
+	remote: post-receive< <ZERO-OID> <COMMIT-A> refs/changes/23/123/1
+	remote: post-receive< <COMMIT-A> <COMMIT-B> refs/changes/24/124/2
 	To <URL/of/upstream.git>
 	 * [new reference] HEAD -> refs/changes/23/123/1
 	 <OID-A>..<OID-B> HEAD -> refs/changes/24/124/2
diff --git a/t/t5411/test-0037-report-multi-rewrite-for-one-ref--porcelain.sh b/t/t5411/test-0037-report-multi-rewrite-for-one-ref--porcelain.sh
index a7e29af0c2..77b5b22ed4 100644
--- a/t/t5411/test-0037-report-multi-rewrite-for-one-ref--porcelain.sh
+++ b/t/t5411/test-0037-report-multi-rewrite-for-one-ref--porcelain.sh
@@ -41,7 +41,9 @@ test_expect_success "proc-receive: multiple rewrite for one ref, no refname for
 	remote: proc-receive> option old-oid <COMMIT-A>
 	remote: proc-receive> option new-oid <COMMIT-B>
 	remote: # post-receive hook
-	remote: post-receive< <ZERO-OID> <COMMIT-A> refs/for/master/topic
+	remote: post-receive< <COMMIT-A> <COMMIT-B> refs/for/master/topic
+	remote: post-receive< <ZERO-OID> <COMMIT-A> refs/changes/24/124/1
+	remote: post-receive< <COMMIT-A> <COMMIT-B> refs/changes/25/125/1
 	To <URL/of/upstream.git>
 	     HEAD:refs/for/master/topic    <OID-A>..<OID-B>
 	*    HEAD:refs/changes/24/124/1    [new reference]
@@ -102,7 +104,9 @@ test_expect_success "proc-receive: multiple rewrites for one ref, no refname for
 	remote: proc-receive> option new-oid <COMMIT-A>
 	remote: proc-receive> option forced-update
 	remote: # post-receive hook
-	remote: post-receive< <ZERO-OID> <COMMIT-A> refs/for/master/topic
+	remote: post-receive< <ZERO-OID> <COMMIT-A> refs/changes/24/124/1
+	remote: post-receive< <COMMIT-A> <COMMIT-B> refs/for/master/topic
+	remote: post-receive< <COMMIT-B> <COMMIT-A> refs/changes/25/125/1
 	To <URL/of/upstream.git>
 	*    HEAD:refs/changes/24/124/1    [new reference]
 	     HEAD:refs/for/master/topic    <OID-A>..<OID-B>
@@ -151,7 +155,8 @@ test_expect_success "proc-receive: multiple rewrites for one ref ($PROTOCOL/porc
 	remote: proc-receive> option old-oid <COMMIT-A>
 	remote: proc-receive> option new-oid <COMMIT-B>
 	remote: # post-receive hook
-	remote: post-receive< <ZERO-OID> <COMMIT-A> refs/for/master/topic
+	remote: post-receive< <ZERO-OID> <COMMIT-A> refs/changes/23/123/1
+	remote: post-receive< <COMMIT-A> <COMMIT-B> refs/changes/24/124/2
 	To <URL/of/upstream.git>
 	*    HEAD:refs/changes/23/123/1    [new reference]
 	     HEAD:refs/changes/24/124/2    <OID-A>..<OID-B>
diff --git a/t/t5411/test-0038-report-mixed-refs.sh b/t/t5411/test-0038-report-mixed-refs.sh
index 54bec4c026..a74a2cb449 100644
--- a/t/t5411/test-0038-report-mixed-refs.sh
+++ b/t/t5411/test-0038-report-mixed-refs.sh
@@ -53,7 +53,7 @@ test_expect_success "proc-receive: report update of mixed refs ($PROTOCOL)" '
 	remote: post-receive< <ZERO-OID> <COMMIT-A> refs/heads/baz
 	remote: post-receive< <ZERO-OID> <COMMIT-A> refs/for/next/topic2
 	remote: post-receive< <ZERO-OID> <COMMIT-A> refs/heads/foo
-	remote: post-receive< <ZERO-OID> <COMMIT-A> refs/for/master/topic
+	remote: post-receive< <COMMIT-A> <COMMIT-B> refs/for/master/topic
 	To <URL/of/upstream.git>
 	 <OID-A>..<OID-B> <COMMIT-B> -> master
 	 * [new branch] HEAD -> bar
diff --git a/t/t5411/test-0039-report-mixed-refs--porcelain.sh b/t/t5411/test-0039-report-mixed-refs--porcelain.sh
index 605b3cb5c9..e4baa13ea3 100644
--- a/t/t5411/test-0039-report-mixed-refs--porcelain.sh
+++ b/t/t5411/test-0039-report-mixed-refs--porcelain.sh
@@ -53,7 +53,7 @@ test_expect_success "proc-receive: report update of mixed refs ($PROTOCOL/porcel
 	remote: post-receive< <ZERO-OID> <COMMIT-A> refs/heads/baz
 	remote: post-receive< <ZERO-OID> <COMMIT-A> refs/for/next/topic2
 	remote: post-receive< <ZERO-OID> <COMMIT-A> refs/heads/foo
-	remote: post-receive< <ZERO-OID> <COMMIT-A> refs/for/master/topic
+	remote: post-receive< <COMMIT-A> <COMMIT-B> refs/for/master/topic
 	To <URL/of/upstream.git>
 	     <COMMIT-B>:refs/heads/master    <OID-A>..<OID-B>
 	*    HEAD:refs/heads/bar    [new branch]
-- 
2.28.0

