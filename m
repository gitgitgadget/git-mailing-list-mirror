Return-Path: <SRS0=nPiP=6T=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CBEAC47259
	for <git@archiver.kernel.org>; Tue,  5 May 2020 14:41:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0C25A206A5
	for <git@archiver.kernel.org>; Tue,  5 May 2020 14:41:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PW1JvnPl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729517AbgEEOlt (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 5 May 2020 10:41:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729454AbgEEOlp (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 5 May 2020 10:41:45 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35FCEC061A41
        for <git@vger.kernel.org>; Tue,  5 May 2020 07:41:45 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id r14so984951pfg.2
        for <git@vger.kernel.org>; Tue, 05 May 2020 07:41:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=TnO7VesALpp/v47P4tBBqR6D2JpGRr1nhMGDI6gF6PU=;
        b=PW1JvnPlw2h/jb3G0D/Uu7bZdyZbK3VvGucZ3ROxPx4klU5cqKjmHgx4k1ryy+csvA
         dh6ODIXhroahrLiPJoS/bUKFuYd3VZVzOLXMvEwp5F62sqTSBNBVufVEY+GZNv6g5/c5
         9dU7IQG4EbH6gYVwEF5AmUDDwBO89GrzhwGUAHi1Y6Ky6gbGs2eUaZzxBOUeWuco/L70
         rOeeBPhzgLk1FAxZjziYljeUsn3dkwE9HEDZk0mUiESpBB34QE3MkpbjHYPZIWONymiq
         hF0HQ6lgRbAdq9gApZXNt8QX8XRY6uIKx2K7d0aqITh+4VV+gWuqnMqZfjMuGneOkBCB
         XzZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=TnO7VesALpp/v47P4tBBqR6D2JpGRr1nhMGDI6gF6PU=;
        b=QauI3uzky/j/kjolpayKAXcav3wDIF6FWgDhKUTp2cjCA0iJa1Sw9Z2VxeRGUYK4/S
         EMuNy+OML45WSpWQWMSnsaDmt4RJqI7umpLY0gEn4EeGr2qcFTMtcS9vZCpicDF8cWN/
         RuZsKNwEpne2aBFC4vUf3UMbiN+Ft/nLnwpoowdGXwh9AHHJsJ5AP+A05vZDeREBTmX7
         rWPQcPsoPO3Z8lQhX6q+QNFWCAzuVRnq7MjKhG41PXJXO4Yr+UYaHrOqc2QAws8+2kPD
         vKnm9nPMqIIprSvvicSzilNB/w/fk4zvanzEaUi5gJMcv8uP6rIxYDAMoCE4j+OeO9tS
         wqZw==
X-Gm-Message-State: AGi0PuavaKA8kKu6roAEkdKyB6++Ave31FKQDTq5SA7SjBhQiFZMv3Pj
        upGmU/3ne5B3xvgdUSzTl9U=
X-Google-Smtp-Source: APiQypKckNX/rThjjifLrZoyDyOJ34wJDzVBachNO0pEcZP5tSoo7vfvYOp+jIRgjo8QU9EtnqMafw==
X-Received: by 2002:a63:68c3:: with SMTP id d186mr3164380pgc.269.1588689704411;
        Tue, 05 May 2020 07:41:44 -0700 (PDT)
Received: from tigtog.localdomain.localdomain ([144.34.163.219])
        by smtp.gmail.com with ESMTPSA id f99sm2431012pjg.22.2020.05.05.07.41.43
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 05 May 2020 07:41:43 -0700 (PDT)
From:   Jiang Xin <worldhello.net@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Git List <git@vger.kernel.org>
Cc:     Jiang Xin <zhiyou.jx@alibaba-inc.com>
Subject: [PATCH v14 4/7] receive-pack: feed report options to post-receive
Date:   Tue,  5 May 2020 10:41:28 -0400
Message-Id: <20200505144131.30048-5-worldhello.net@gmail.com>
X-Mailer: git-send-email 2.26.0.rc0
In-Reply-To: <CANYiYbFCG1_hdy1kA06wjrvGSQ2=y-hJX3Rsh-rn=X9tcqv1VQ@mail.gmail.com>
References: <CANYiYbFCG1_hdy1kA06wjrvGSQ2=y-hJX3Rsh-rn=X9tcqv1VQ@mail.gmail.com>
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
 t/t5411/test-0032-report-with-options.sh      | 14 ++++-----
 ...est-0033-report-with-options--porcelain.sh | 14 ++++-----
 ...t-0036-report-multi-rewrite-for-one-ref.sh | 11 +++++--
 ...rt-multi-rewrite-for-one-ref--porcelain.sh | 11 +++++--
 t/t5411/test-0038-report-mixed-refs.sh        |  2 +-
 .../test-0039-report-mixed-refs--porcelain.sh |  2 +-
 7 files changed, 57 insertions(+), 26 deletions(-)

diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
index 8b96a995b8..f57d997121 100644
--- a/builtin/receive-pack.c
+++ b/builtin/receive-pack.c
@@ -775,17 +775,38 @@ static int feed_receive_hook(void *state_, const char **bufp, size_t *sizep)
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
+		char *ref_name;
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
index 929c46ccd8..b817d645f1 100644
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
index a371c8d610..2519c1acd8 100644
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
index 9b060b2f84..b3fcd2283e 100644
--- a/t/t5411/test-0038-report-mixed-refs.sh
+++ b/t/t5411/test-0038-report-mixed-refs.sh
@@ -45,7 +45,7 @@ test_expect_success "proc-receive: report update of mixed refs ($PROTOCOL)" '
 	remote: post-receive< <ZERO-OID> <COMMIT-A> refs/heads/baz
 	remote: post-receive< <ZERO-OID> <COMMIT-A> refs/for/next/topic
 	remote: post-receive< <ZERO-OID> <COMMIT-A> refs/heads/foo
-	remote: post-receive< <ZERO-OID> <COMMIT-A> refs/for/master/topic
+	remote: post-receive< <COMMIT-A> <COMMIT-B> refs/for/master/topic
 	To <URL/of/upstream.git>
 	 <OID-A>..<OID-B> <COMMIT-B> -> master
 	 * [new branch] HEAD -> bar
diff --git a/t/t5411/test-0039-report-mixed-refs--porcelain.sh b/t/t5411/test-0039-report-mixed-refs--porcelain.sh
index 537d4046b9..693b55549f 100644
--- a/t/t5411/test-0039-report-mixed-refs--porcelain.sh
+++ b/t/t5411/test-0039-report-mixed-refs--porcelain.sh
@@ -45,7 +45,7 @@ test_expect_success "proc-receive: report update of mixed refs ($PROTOCOL/porcel
 	remote: post-receive< <ZERO-OID> <COMMIT-A> refs/heads/baz
 	remote: post-receive< <ZERO-OID> <COMMIT-A> refs/for/next/topic
 	remote: post-receive< <ZERO-OID> <COMMIT-A> refs/heads/foo
-	remote: post-receive< <ZERO-OID> <COMMIT-A> refs/for/master/topic
+	remote: post-receive< <COMMIT-A> <COMMIT-B> refs/for/master/topic
 	To <URL/of/upstream.git>
 	     <COMMIT-B>:refs/heads/master    <OID-A>..<OID-B>
 	*    HEAD:refs/heads/bar    [new branch]
-- 
2.26.1.120.g98702cf3e9

