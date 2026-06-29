Received: from fhigh-b8-smtp.messagingengine.com (fhigh-b8-smtp.messagingengine.com [202.12.124.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBA4734752A
	for <git@vger.kernel.org>; Mon, 29 Jun 2026 07:34:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782718488; cv=none; b=rwURo6w8WvOlhvvOj6Bk/a297wJRomPJ4YdS4DSFrXeg8SE2GKAdeaBspafMfSCS8v4711TveaYdNLmTGuS1cGZFoEN/tR+kH9ItdufaI3lr0hpecjMmJoumtdd7Yq0FkvCS0woMlfCJXCtcrLDLQBqBV3si7R1/+ii5igKXw04=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782718488; c=relaxed/simple;
	bh=eone9JQbD/RenE8ofAlflhQ1v9gRZerbwW0X/j2Hon8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=VlVh8u9K2/IZ9e9d0pO8EjWgIzCGmzVOQ6Rbo40HOoFAyDCve3pIgCD8AAJ6QRZ+Zcg/7o7UTS2Tw+YloxPRrAXkshtR1ADkcwHJeycrI5ntqu8mOV2CvSmbfX9u6lWbKOopjz1lAjgAfJ/jzYUM7qTRZFg9K3SCyTuAlDEkVgc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=JI5CPgZB; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=FEBClKAT; arc=none smtp.client-ip=202.12.124.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="JI5CPgZB";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="FEBClKAT"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 292907A0095;
	Mon, 29 Jun 2026 03:34:38 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Mon, 29 Jun 2026 03:34:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1782718478;
	 x=1782804878; bh=Z8Lj08WPi/fIS3PpBdxdCjztxya6GOJcShzQRHqkGFc=; b=
	JI5CPgZBci8eDS5TQnQmee0F7Y3zcxrmuF1H/crTdT1xM9M+tDA/8nBOMtm8Js78
	QkamAZDGssIvKjjGLPybPEEs1xzHDOT8hk7X+hdOy4hZ5oqzH9X8Ap6MhvisRx7g
	VJiwM6HFn4VexjsQUF2ARjGW6QK3zQWdviyh+ptgXw4G1P/6HJ3kscbMYUqiW8wW
	Ays9hVKglSZIajsiEDIvXbmf0Y+5Uvt3Fs+RNkRiBVMrz57fVRek4qlJTy0gqDCE
	/RuiM/EsM1YS9y108DsqtH2+wq5/qEjRzhB66aWpNpJSim3Xu5bKcdeioTdwkKdx
	BtnrquZ6kLziMMPTFqvM9w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1782718478; x=
	1782804878; bh=Z8Lj08WPi/fIS3PpBdxdCjztxya6GOJcShzQRHqkGFc=; b=F
	EBClKATTCSzQxs8ByIP/qDOaWzRkZxeM1n4ub1aCV/G9CpSysm7PzKUyrD3FmmNw
	BetD2JMicFqlyQaI2QIUU8EClgnvXa74ROWgoqyuwCQ9r/XZs+3cJPp2HZE5iF8p
	GXvNfVniZ6ZwJqhlbeF1QBwAdlcuYz57DR8D7HNLRh+YjfqchtArXAaK8KESjQIy
	kNB4QM0doN+bUw3m50n4GYtXnOtrDTgRnMJ/IMjRuBrqn0kiBMWd2rcwLhU96IiC
	tni76BopyJyD47pWx91+4uMaAmPHdqGu3bRk77C7lGpOpjTSCeWLoR/ps5IyG8rj
	yiDEgKMZWu4u6NB4kdbNA==
X-ME-Sender: <xms:DSBCauyI5l-3Qv8Mp0erg1UpY2Sw0VaLJMSY6hFVZmaHp55kttJccA>
    <xme:DSBCajnEqbmRIMhLvvqbMrLw_ljWEujhcpjnJnN0tIjKT6MYkFa5V38E7YYpqJkly
    Iu5xJZSbwculbDdxnunbpG0zAr63WYrKU2uDIyAiws91DWQachvtw>
X-ME-Received: <xmr:DSBCanmRlUwgTuFncELgtczwrPcUz141KvxgHt4f0Ce03LtZ0rQe036jUZGC_rqegxbjJ3-BMdvAMoQKJSYQoYV5kUNVB7R-rqj5hdU4wMLm>
X-ME-Proxy-Cause: dmFkZTFc4uQ6Qti1Zi9h94m4od3eMpCQCnDSYXEx7QOqzgywygLB3u2mJuU4WGTziEY0sP
    vssB/gclRg1ee6qJz/HkTNvVUAGJRzObGlYhlIWy2H0VizAeVI4Xeth5sjhla/To+149l/
    DnpD73+tyoScl3p4zN9NQkkGKn6ia0XiF6ce1fQg3g/N5exLIvyhMvPBClJO8fJfSQamiA
    fdVPH07ySGubvtRJl5FYb7NHirzBLueiOcGXimA9yqyRycKngriJVEG34RByO5A/F6lB6i
    kYa8uD5/S+7zMXFZ52b65RCnTypiqCWEjwut/seJuRz24f133R4jeJf+/yzbcKsEf0+ed4
    QekoVXv6Uur0c14eMq3dYCNqkk2c/a3NO1dMYULct3JphiINzqjj5woBm+9Ci6UcrS0nlJ
    FIAoN6t5nW45lRGWkLAa8wldOIxMR97IjB2Fuz7axTR4gwpQNUOz7cnbkagzclT3lMsqpq
    4sUesfPyJwOMW2y/a5jp7yfLS0jtt4FQzsx5mdwvolzjNXX9k581CVsn4i32AbloGCoP7G
    g+/QeROP5/X/ovd38X+EkZLQN0SjCHoTepcD3EWCF4SD5Z/Li9etFv0T+SQhG+7aHL4ViB
    7Qao2UOMfJG9SNHx9r2nOY6XU7kLSFqZa3XtKPaugHtZqsYkUjDPSeNEamGg
X-ME-Proxy: <xmx:DSBCalzFHZVFpPitPpu-uWDx2kkFHGfFYLlvwnGZIXgYn1mQyFD13w>
    <xmx:DSBCasom1gOXOM8qEL8kt5OXEr9Yp5Jk66Mtq0Z39S_F8dVXM-p4ng>
    <xmx:DSBCak4EDvbvm5OVYkTFisnjgATkcfqvhZWkr49aCyEEY1sfHw8KFw>
    <xmx:DSBCajfFAeNTBMWpWT3gKFggpFlW4GeD7nh9LCIHfMwwnQUWYbLEIg>
    <xmx:DiBCalNy3WmLWNup0QqtdcaomYKxe0JtO6HO4bOH0Dp2xS3B-gdyXp74>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 29 Jun 2026 03:34:36 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 39382f1f (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 29 Jun 2026 07:34:36 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Mon, 29 Jun 2026 09:34:28 +0200
Subject: [PATCH v7 02/11] reset: drop `USE_THE_REPOSITORY_VARIABLE`
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260629-b4-pks-history-drop-v7-2-6e9392a957d8@pks.im>
References: <20260629-b4-pks-history-drop-v7-0-6e9392a957d8@pks.im>
In-Reply-To: <20260629-b4-pks-history-drop-v7-0-6e9392a957d8@pks.im>
To: git@vger.kernel.org
Cc: Pablo Sabater <pabloosabaterr@gmail.com>, 
 Junio C Hamano <gitster@pobox.com>, 
 Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>, 
 Phillip Wood <phillip.wood@dunelm.org.uk>, 
 Christian Couder <chriscool@tuxfamily.org>
X-Mailer: b4 0.15.2

In "reset.c" we still have references to `the_repository`, even though
the only entry point into the file already receives a repository as
parameter.

Update all uses of `the_repository` to instead use the passed-in repo
and drop `USE_THE_REPOSITORY_VARIABLE`.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 reset.c | 27 +++++++++++++--------------
 1 file changed, 13 insertions(+), 14 deletions(-)

diff --git a/reset.c b/reset.c
index 46e30e6394..3b3cb74dab 100644
--- a/reset.c
+++ b/reset.c
@@ -1,5 +1,3 @@
-#define USE_THE_REPOSITORY_VARIABLE
-
 #include "git-compat-util.h"
 #include "cache-tree.h"
 #include "gettext.h"
@@ -13,7 +11,8 @@
 #include "unpack-trees.h"
 #include "hook.h"
 
-static int update_refs(const struct reset_head_opts *opts,
+static int update_refs(struct repository *repo,
+		       const struct reset_head_opts *opts,
 		       const struct object_id *oid,
 		       const struct object_id *head)
 {
@@ -42,19 +41,19 @@ static int update_refs(const struct reset_head_opts *opts,
 	prefix_len = msg.len;
 
 	if (update_orig_head) {
-		if (!repo_get_oid(the_repository, "ORIG_HEAD", &oid_old_orig))
+		if (!repo_get_oid(repo, "ORIG_HEAD", &oid_old_orig))
 			old_orig = &oid_old_orig;
 		if (head) {
 			if (!reflog_orig_head) {
 				strbuf_addstr(&msg, "updating ORIG_HEAD");
 				reflog_orig_head = msg.buf;
 			}
-			refs_update_ref(get_main_ref_store(the_repository),
+			refs_update_ref(get_main_ref_store(repo),
 					reflog_orig_head, "ORIG_HEAD",
 					orig_head ? orig_head : head,
 					old_orig, 0, UPDATE_REFS_MSG_ON_ERR);
 		} else if (old_orig)
-			refs_delete_ref(get_main_ref_store(the_repository),
+			refs_delete_ref(get_main_ref_store(repo),
 					NULL, "ORIG_HEAD", old_orig, 0);
 	}
 
@@ -64,23 +63,23 @@ static int update_refs(const struct reset_head_opts *opts,
 		reflog_head = msg.buf;
 	}
 	if (!switch_to_branch)
-		ret = refs_update_ref(get_main_ref_store(the_repository),
+		ret = refs_update_ref(get_main_ref_store(repo),
 				      reflog_head, "HEAD", oid, head,
 				      detach_head ? REF_NO_DEREF : 0,
 				      UPDATE_REFS_MSG_ON_ERR);
 	else {
-		ret = refs_update_ref(get_main_ref_store(the_repository),
+		ret = refs_update_ref(get_main_ref_store(repo),
 				      reflog_branch ? reflog_branch : reflog_head,
 				      switch_to_branch, oid, NULL, 0,
 				      UPDATE_REFS_MSG_ON_ERR);
 		if (!ret)
-			ret = refs_update_symref(get_main_ref_store(the_repository),
+			ret = refs_update_symref(get_main_ref_store(repo),
 						 "HEAD", switch_to_branch,
 						 reflog_head);
 	}
 	if (!ret && run_hook)
-		run_hooks_l(the_repository, "post-checkout",
-			    oid_to_hex(head ? head : null_oid(the_hash_algo)),
+		run_hooks_l(repo, "post-checkout",
+			    oid_to_hex(head ? head : null_oid(repo->hash_algo)),
 			    oid_to_hex(oid), "1", NULL);
 	strbuf_release(&msg);
 	return ret;
@@ -126,7 +125,7 @@ int reset_head(struct repository *r, const struct reset_head_opts *opts)
 		oid = &head_oid;
 
 	if (refs_only)
-		return update_refs(opts, oid, head);
+		return update_refs(r, opts, oid, head);
 
 	action = reset_hard ? "reset" : "checkout";
 	setup_unpack_trees_porcelain(&unpack_tree_opts, action);
@@ -163,7 +162,7 @@ int reset_head(struct repository *r, const struct reset_head_opts *opts)
 		goto leave_reset_head;
 	}
 
-	tree = repo_parse_tree_indirect(the_repository, oid);
+	tree = repo_parse_tree_indirect(r, oid);
 	if (!tree) {
 		ret = error(_("unable to read tree (%s)"), oid_to_hex(oid));
 		goto leave_reset_head;
@@ -177,7 +176,7 @@ int reset_head(struct repository *r, const struct reset_head_opts *opts)
 	}
 
 	if (oid != &head_oid || update_orig_head || switch_to_branch)
-		ret = update_refs(opts, oid, head);
+		ret = update_refs(r, opts, oid, head);
 
 leave_reset_head:
 	rollback_lock_file(&lock);

-- 
2.55.0.rc2.803.g1fd1e6609c.dirty

