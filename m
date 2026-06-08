Received: from fhigh-b4-smtp.messagingengine.com (fhigh-b4-smtp.messagingengine.com [202.12.124.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1E60383326
	for <git@vger.kernel.org>; Mon,  8 Jun 2026 10:23:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780914219; cv=none; b=uXlZ8KNErOn0Bv9umff2a23YD8JZnzVXSUKe4RNm6msmEe61y0bfQdsEr2ivLH46vtdtgVz4MPtzW+UuBYF6dZhf+DKR74j7YM6EhGhTkbqi4WoLHrXvJopKvdYD87MJAgiFK9aGYadaVK93uvqlc2styEqsmnyIiq5POO33oW0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780914219; c=relaxed/simple;
	bh=9P0s8K9/Hmd73RbGJT41lEXabgHZBjbF5GB1otvvtAQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=noYoQLFye0UpyZpzaMiIM9E31ja0WrZU01EEJIF018gpbWQvQDVqGXP2X5M8VuiAyZGnsdEVwfUrN40uBm9BBoy0e1+dbtMTLcTOM/py/N4r4eynqxFqlkQlhMB79W1M6fmjIXagO8bVelI+rGsYZIGRzMcGuZEhG/TcDdlr6vw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=eTC07Yhm; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=LVKPCtgu; arc=none smtp.client-ip=202.12.124.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="eTC07Yhm";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="LVKPCtgu"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 3E42D7A011B;
	Mon,  8 Jun 2026 06:23:37 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-03.internal (MEProxy); Mon, 08 Jun 2026 06:23:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1780914217;
	 x=1781000617; bh=DrMCb3uPGPGsZN/8p4ddGkTA4RR04oGz9hhYKeWuW1k=; b=
	eTC07YhmL0rllLHS2tgLJ17at+246tdUL93E6qkihh3K9NosxjhzJhYcAtFDfOU4
	L30WqpaJC3RNhewLIZXCiFUzXags8GmcZo+TQ8XFK/bR1BAwu+z99SiQdQEKVCnU
	Sr1aYZ81rfs84vLNB9qKnq5phwU503oTEyfZlYG1Nn43Dzpjzi827RLCBGAeU2A2
	d1pknXia4cA8Mb38twe0qS61txiIl0wVghYTgK/4ANlgWgJKgyULAnf9kwK26ByL
	eEaKaaNdW9OUBy3TlydgoidU3+6OkRbYqDNE/S+9CeXB++jXyvtw1X/529iyXwk6
	WtBis9DIYd6GiAqjWMVpog==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1780914217; x=
	1781000617; bh=DrMCb3uPGPGsZN/8p4ddGkTA4RR04oGz9hhYKeWuW1k=; b=L
	VKPCtgubQc3ZsLxiXJzUPNKKels5dWBtHr1f6A6PRskVBhsWGN/AsITZWwbpZ4Kn
	5RJjezW4olcvn2fOWzmCC48v/6+4zQ7tO9YvWZwkAj4kAx2wik0/8e6Bp0A3UO2n
	2chyJhXS2AboDvkLF+GZnqQY3mXOWkKloK2JNf8IKF5NNoZgjWRipYtRz37jEyWB
	blCNQKO5h2WqVZPeeFhU/DTp4t0veHbIm8mTsf9xw5v5GjWwnySEf2b/CQ4cmmcV
	4LCmLheCK33JE3vDzMwEtncA+gxAw29JeK40vdtxcOv4Wco7h4H/0ZwGdbggiYIt
	Ja6oR9bFJKn1sLbrmHvFg==
X-ME-Sender: <xms:KZgmandECvixb5uabdTa9MlEyewIyM1aSULgWotGMtM4Wm_qc1aAYg>
    <xme:KZgmaus6N6sW2724LCc7vqArrdZVAizFpgAMB5JiBG3OX5zBY1XR_WrAetI3KNcyl
    yRQrq7JCJBXkhxpy2-rT3C8P0iXCSK_hW3EIRjO4lcVjCdfVQQ>
X-ME-Received: <xmr:KZgmagn1LNULd-9GW9DCC2JJbvDQgUVSe4r8oyumC0YwwZCXgaC5gAR3M6OsOA0RRkXvrt3r1PnQWNSSq3uzs91SD_zoWJVVqHFKW9MbuQ>
X-ME-Proxy-Cause: dmFkZTEU6CGo3vgRKOUy0NKAJj0qncnb+S3chfDNaeW9f7h5ictXCkTMmbzsA1bg+OqO5t
    VoN4gZ8DE2bMSNg0gKHlrcoGOrBSILyou8tacVmnF15zr8wO47F34BCKbOUToGnhrJDCke
    BuycNX2jBRY83y6KuU872VYl4KFCFPuj4/RU5I0flJJm7GMsjxxfUH7pW5x8WevI6FajEy
    HqZr4ietzymr2hvqu2TTKDUNt+8cx4slMtibdFncynERefQ9+isUR9VbS9B73SaPMRa3pu
    z4dSFOzBZjFAGJnsuuWgnRAVgiZUR1gYZTCdZoQ3btYVnBCPL1PuUzpm1MvOIGiJMY3uH7
    /asVHbv1THKc8yo1NZPLNwksUqiskkqCE9Ue2hIcy2myQm3Wcq+gSN0UsI6p8g9Af9IkYH
    nBjx5BJp7AZ5rTzcrKvNpZ81DC9namXydM3iwY7Nb4JDCwu+in3uTz98GGTzjMBXyvftuH
    aC72hStebnALDO8hDyi7/wam/LbJ3T/UUuY+EZhntNK4eXzFMdLD6LhJMO4ZxnFzC0m/+q
    3zfbUci4rza79wsfIFg/YAnSspyIPUZVm/bGbDwkqcjLv4c0LFh45t5INiZQPCt8uBx43D
    HWoc9I5+mc6YoodhlGTuP4MlLYU9D7c3HpWmwCoIquFS1qpOGifbhjemdI5w
X-ME-Proxy: <xmx:KZgmaozEkt5eTY3FknkNs4hmtgg3L87DzZR13Htet1vWCByRfxeAcw>
    <xmx:KZgmaqO_XJCU5veON1DaKkjCiHh5Kez4jSgLRqeA-PEqMesVN0fYBw>
    <xmx:KZgmaspLX8cBIV3-ff9U87cw3dTw04b75hpPDJ84FVRzXXwMZLU4PA>
    <xmx:KZgmarEbptQo3uD7ROJ6iyB33Hy-pKbwb271SL2n067eGJKoh_jCjw>
    <xmx:KZgmanBeoI2ZM0aJWfKJoUOLWUct6NG3t7rgzBIOfp8LVg8gsPL8spsu>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 8 Jun 2026 06:23:35 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 8a8228e4 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 8 Jun 2026 10:23:35 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Mon, 08 Jun 2026 12:23:26 +0200
Subject: [PATCH v3 2/9] reset: drop `USE_THE_REPOSITORY_VARIABLE`
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260608-b4-pks-history-drop-v3-2-84ca8e43e937@pks.im>
References: <20260608-b4-pks-history-drop-v3-0-84ca8e43e937@pks.im>
In-Reply-To: <20260608-b4-pks-history-drop-v3-0-84ca8e43e937@pks.im>
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
2.54.0.1136.gdb2ca164c4.dirty

