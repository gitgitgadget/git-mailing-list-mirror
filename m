Received: from fhigh-a4-smtp.messagingengine.com (fhigh-a4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3979D40960A
	for <git@vger.kernel.org>; Wed,  1 Jul 2026 11:35:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782905746; cv=none; b=L5F/2w9B4FKNsKwa0wMwqUH9OmoKI5W3ypdEKof1hMl/S6+M+TRHGQZIKotY0Gxy+gCoFna05bajHwyfWx01q+yaszqmHdsuf+U/hvPYzFQoBhHeZ0nHNUPEXJrQznAzrg4KPJjuUlen/1RYxJFBBH5LWnuzT47Mq+qOhUEwMbs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782905746; c=relaxed/simple;
	bh=eObS3YdcH6+RSw/iQ+uQA8tzeFrFml0tS1bsxkMFemw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=IPCHjVaDZkNf5wZIZj3Aj6aookHF84GF5+XWMiRke8JGBMZ6ll7SYthCvdRAvgt4fyioQe+X3ghlmbxJAug3EY9DRxW/PWJ/vR2TSEeuHmoLlwMADK5gUArDyWN7wJJf2sofXLXznbK+SVT+iTsr7LaUVyvS0Ta52Ef+FlZAFak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=J1tVo74T; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=JeQ6j74E; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="J1tVo74T";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="JeQ6j74E"
Received: from phl-compute-12.internal (phl-compute-12.internal [10.202.2.52])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 83BEF14000ED;
	Wed,  1 Jul 2026 07:35:44 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-12.internal (MEProxy); Wed, 01 Jul 2026 07:35:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1782905744;
	 x=1782992144; bh=6FIlESXa2sGE+U7VRFUzqi6x0W+1l1Sx1Ayz59OIEDs=; b=
	J1tVo74TYUq6N4qrzfynHMhO/k6kgUzlD+h3PiBtOGYX5R3wspkh6XUb5A9C3Ed9
	kYKtn1J3qdLzHOqNvpwI7bukQYz8gRscKUu9oOElFc6sAqn1H3OjAm8+CKYpcmJz
	RxWSo5//MWd+hkgizc1poQegyCXzA78ILZ3cgWjUFx2A9SdsOW5HalRs/wvr28Qx
	QJ9jV07nGBAsfUZFjr5uhxXVqVvygtn3NbyWQ0FuWMDyXXTPGcQ/KZ2tjfQnKJ/5
	6QUrn9Cv2G3puB9g4XbKVKUzfTWCKLs+qRcGlhUe4MWDe2LD73Wlf+1B667VNACD
	0IgcZ3Lceq+d6+KWwxzrkg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1782905744; x=
	1782992144; bh=6FIlESXa2sGE+U7VRFUzqi6x0W+1l1Sx1Ayz59OIEDs=; b=J
	eQ6j74EmJ0B8moOwZ7hrloKur2Xf0LywKqNKoOPudyBHSqFwhxGUm9IAKpCPaZil
	Fnaym1XJPG/UYt/eVaGw2rItAHqkFSd2wHeQaSAUn0vgzn5IsTGeHOsMaB80ec3f
	J/OU0pI15KdEO2OJkAG3N9cVT0BobigyiqbxPMuze34ZjClUW61dG/W7o3fisuUi
	gLFWMC5uo4OqCcoyt74YDwJZZH7a0aPYprE1HZQUTw1qW6osleACR+CcbvNbGJ0Q
	L3vGQyVixdCyCIXtAS22TEWnXjWDBSZMwG0TDmcBLFiclRRO6i8H+xVOGkjCb32/
	s2eo7fEhdTM+V5A6wc/0g==
X-ME-Sender: <xms:kPtEahmTIB11MKgT7ASFPW_V29vuDLxYVrnwpBKY2MwWctgGHHXfdg>
    <xme:kPtEamKHANgA4h_nxQDwYSxWtdxsL1GWmxrQjhbxULdehXsLvsHfeCBMH3-rC-ZUr
    Gunds1fJgepSlZhgzhNuCIYyexrnsO_w-L-sCUCofZ8cr499ehu>
X-ME-Received: <xmr:kPtEau5_qaKV3n39HqjUCHcU-27fEqsu9LZ8kX56jTQNb4CIk-SgxCmiQkj2vGZBnJ1Z8tnkrKD9lPhwW6jCXod1ZCgJp_MhEGyiAq47BUQ>
X-ME-Proxy-Cause: dmFkZTEZoO6HolNFiuzhqEVK1EXq4BbCn1tdQX7LTJIMJcT/+latCDErJzD4+CwgisT7ri
    qxkn+QB2VfpeBpgOV5q2sBGT63aEOuYhfWwjT+wgnaZ2qGTsJfaJHBVk347IlsaCNTe39N
    jrZm/FsYSWHGfvBlbmbsEFy/XtzODL8fdqiFNJeGFn2lrHVPGPL/Yr6cOMglYCr7uBXs7r
    aXJwkPam35tJtUVY8r7/VZg2IyQl/w9r8/QisqR4rjlYUkyluAeVVxaLcVOMBGocW1MGez
    Nwenq9cyAhPKHT6bW4GOhAoe1hp9EC68DfdP8WD4TQ3JQn6e5yBMnRKyOIrDWHKuIfRTTd
    ZooM/kLKPn1tpw+KBa9JNpmAjLgH6UuYt1Gdr2Ih8Tk4bCrCD0TpKJQdrYVL8Nq0Kslvkd
    x/JY+Ba4PGJ96LfVrEB/qKlAs1wYfPf6dJvazl2fwfc+CwMqecOrIElovtoncX0rAqav9+
    9TMdKenelh4S6vEMPwAT4KxEqjpyoERV4QZAaCRAlNZqT4w+9+vInvffVjJQBmh+DjUiN9
    ntsoo1m7Zf8/AjUAgnJApXwd6gq1Rshtk4nOS0eOYp6d+ZUKeaoE+zOYEacE2nFueVdy/G
    n1aNDpaDn0EquNLTtzTq55JQi8lscFtYMP0r0cQw4N2afRZWVAxtc+DL9UwQ
X-ME-Proxy: <xmx:kPtEai1rs23Tv5qcRB1YtmB2g8ob2k472jq67awjbORUnbXSq89tcQ>
    <xmx:kPtEaseGM8koVN9OzPBAcf97uf0Omwpi_EVhCAdDQRoZnuiJQNRlyA>
    <xmx:kPtEagcxScYu4JLIYQpJYHI-0z2zarVNnJNI2L0rOdqb6VXp1eU7Fw>
    <xmx:kPtEavwF7l7AS82pa6LvU2_inEsZ3y6A98_-C2r_buI0CXh4X98yxA>
    <xmx:kPtEahCzGwaO8Bj1QfgU37AVCdL1keydk_mVdYkZQHPULuBBjsOQ7CGk>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 1 Jul 2026 07:35:43 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id b541a4e0 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 1 Jul 2026 11:35:42 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Wed, 01 Jul 2026 13:35:29 +0200
Subject: [PATCH v8 02/11] reset: drop `USE_THE_REPOSITORY_VARIABLE`
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260701-b4-pks-history-drop-v8-2-19b5cdf1facd@pks.im>
References: <20260701-b4-pks-history-drop-v8-0-19b5cdf1facd@pks.im>
In-Reply-To: <20260701-b4-pks-history-drop-v8-0-19b5cdf1facd@pks.im>
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
2.55.0.795.g602f6c329a.dirty

