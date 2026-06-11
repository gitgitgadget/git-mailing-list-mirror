Received: from fout-a4-smtp.messagingengine.com (fout-a4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00ECC40E8D4
	for <git@vger.kernel.org>; Thu, 11 Jun 2026 13:27:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781184441; cv=none; b=FO1gdb/WdzKLK1/lD7rj9Oxe2BUKLBRfG78DXCsLPApDXUCrrNGodHBwqH1sz0b59DDu00VliE5+v3PdeDYoxYFYKUwsia6a1cbe7wRievLzPoFw3LGdCAUaK2FwAJzvqcofAnMWs+VwuFXaUyQN6YAp0S5GNn1L3tvdepuXTHs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781184441; c=relaxed/simple;
	bh=aCKx8RAdUBN0jhn+KdWUiigGFQKs3Qj1qM7JT4xlbH0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=rimyGisqDQkh28xJujVB15Qj99zYGfs2hOZAv1o4gtYjrrYv4h26L/jnUN5u1wcsBeugWvm+UoWiwHc2P7HptRfWZLfPWdzR1QCCcDNLezRAkx8jdTfdte1kZPY4DjHUebXC/s6C4aNQkaf6aWxj286m2X1Yj/v7qMAIXr7QsGY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=bn09XeCn; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=CGB1Wabf; arc=none smtp.client-ip=103.168.172.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="bn09XeCn";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="CGB1Wabf"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.phl.internal (Postfix) with ESMTP id 31A54EC0171;
	Thu, 11 Jun 2026 09:27:19 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Thu, 11 Jun 2026 09:27:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1781184439;
	 x=1781270839; bh=ZExGmDHv+LmWh0NHGhqyng7Igrt6hKsKZGrKTOMA1DY=; b=
	bn09XeCnKhYyzipE8qqk/DwVk/7jj7Mb2GCu/etpuSKQl6qhL0YYGIs7INwEX+Z/
	wuCYG9804WVLcjuTOod0ze3O4DQa/JImRqL8L8rjzC+dV+lx7MnGowBS0BfPP0RX
	x4pgPYOyc5sSp1gvUOu0svrcAltwke7JKicfENOdl1Im78xKC3jbV2/JtXNlRl47
	8SXZUq8B+A0WuqqA6eKFVe6VdB3smkjk+OitiU5OVRpoOA9qRb0LVXldHXVft0B8
	zTo7NLxLqq7Lklz+cCLXRLRG0fTNftsO9xilIN1Bm2ooykSyhayp3o+4vwgPYvhQ
	b63abkqIUUZ/orZMqpUjuA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1781184439; x=
	1781270839; bh=ZExGmDHv+LmWh0NHGhqyng7Igrt6hKsKZGrKTOMA1DY=; b=C
	GB1WabfU/687eSPArgIkDr1uw5sJRvkaG+4KY1lF1cXkkOGmT9dsMjisn43/mvxg
	zM+CyQFovRHXgtzvN1BKuQoP1WauaSMxW8POB3HV4ZhO6i2vkwp0nb8loK1vySGW
	yDIMSN5mVZ7YVAEV0geJSrKcCSybnTL5HtY5CzEC/3vdMlusf1fg2hykU8MJH6aJ
	/iFBio0XhUTZyS+I9jGE1FhoyZ3VqERkDjzpBLNRE1xqRo3W6o56qZ8zh9ovXZFC
	mF6Gu5w5OrLpafY4k4I8Ixr7iA7q/VFa4cVw9u4gnagvEzuYUqOaMTLZmcThSv3k
	xtBcJmvx7PuRQTT9EqrKg==
X-ME-Sender: <xms:t7cqagUDBV4MvSKHqsoA6usEMG-9Cv8Nfi5LQtitDlARdpzztWsAHg>
    <xme:t7cqamHxFS1CixyLQOJFqCW2JrUo6tMmY9hx5E_kDzY3gcYieXQAspEwI-13DO3VU
    Cjf0H3cN0vZo6KGAM-86q3c77YyuEzigYjeAmSRtPh65JWsz1Xl>
X-ME-Received: <xmr:t7cqakeptsFwp4RQy5Ubr52t4yAEo8Syg96WgbN8I5DgrkjouwWBZz3i1_D-kpokM_SeaYK-WgAR5SiKkpnq6V76quUNzcOrzzZbz9TAIXja>
X-ME-Proxy-Cause: dmFkZTE7MVGK4Ba+oYOC1nLoG7cbGVUzVu+Iucq2ujoLCcLVcHoPfJ3B2E58mZFloJJEWg
    7AGsW2I/4BjpnRlKmxKo0wt5YOdMuUxOsLMTkjZem8VQiAtVIsicVRgUAWRkbQi87i2Jw+
    DfFPXaGDI6pvc1qclb1US1dvL3b36kPqfQhl6/bp455aJE9vNT0S8JoEdfBhTTrfsv+ZJZ
    KGGdcWggPNgCbSUbX0ddUs3WBfsfTprEsRyVVOLqKAiyj4l5//RbQBoUNUkrXiNsB/13q1
    rlMGTissinGZJwG7DXheIFo7J/pXapx80MYmHAwM6GeItP8Mn0+4S30TiL/EPpBsgU1nTS
    rKGgJJTr+dbgNooAb3tiaysY0lrkr9dXScwWuedNuSjuXWtUSj1DL8eNnrnJcnHd5j/mOZ
    vwcQ2/HbI3STsG/kpEqq1qps3KH5mqvZ7kVP8uXf3d0SDlxgadta38SWfFRSbgQ0yCLstu
    iDAZepdn5ZsRuwdN9FXMMAoMFvpBAK36pK8B90wtUYh9LsroCSWMoNGp+4XlNymjZJR4Oa
    9mwVMd/W+1JPbKWiNfV9xrYHCsTlt+1tmcwkCGAr8bvhin/1oHdFj73iEmWCoc8XczYRoU
    y8AuMK15sK+BL7ulPwQYvgwq6LjzBC43Qj4QIhzaiUiLJrBBH/+tkk08vI6A
X-ME-Proxy: <xmx:t7cqavI2TDq08o6DGluAJEk98xzWu5JWKrlvdnJP6Ydv3p7A83E94g>
    <xmx:t7cqahEZIiWA05PGc2rfWDaCoy76i-z10zOyYWIzhvN4ALyzf2PAxw>
    <xmx:t7cqaqAzJ0MUWFme0ZOKs0zp2lO3vKJIKZj9dL08uZoJWvVMvdmujg>
    <xmx:t7cqas8VVnBRTjqMWZHLjjskOYTDPyr8gdFXxMxfmzmV24lavsi4Bw>
    <xmx:t7cqajbixRgie8KXt2RFhk3ZmUxv-1ZgZCPfkET10viSi9jV0y7GJpDk>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 11 Jun 2026 09:27:18 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id d03d5e7b (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 11 Jun 2026 13:27:17 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Thu, 11 Jun 2026 15:27:05 +0200
Subject: [PATCH v5 02/10] reset: drop `USE_THE_REPOSITORY_VARIABLE`
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260611-b4-pks-history-drop-v5-2-34d35725559c@pks.im>
References: <20260611-b4-pks-history-drop-v5-0-34d35725559c@pks.im>
In-Reply-To: <20260611-b4-pks-history-drop-v5-0-34d35725559c@pks.im>
To: git@vger.kernel.org
Cc: Pablo Sabater <pabloosabaterr@gmail.com>, 
 Junio C Hamano <gitster@pobox.com>, 
 Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>, 
 Phillip Wood <phillip.wood@dunelm.org.uk>
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
2.54.0.1189.g8c84645362.dirty

