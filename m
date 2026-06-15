Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04C833F787F
	for <git@vger.kernel.org>; Mon, 15 Jun 2026 13:55:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781531705; cv=none; b=IeASpywW5Mp0WOzZd4DGbr5jpgH+ZvZP/Kc7FmmXIvhJL61x8DmoUlqcmKmA2sJlseReeoifg9rYGOQLZV/2LiTy4BHTkdzfVHIsCzl3Musyu5Dv42fZ6h/UQhexPopfGK5kRcvJcOBqJ0WBgb1dHtfSj5afg9mw2ngjoF2xZqo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781531705; c=relaxed/simple;
	bh=tUQ/wgCJFD/7gm7jTGImWWFCE2jjI8LDWQEtAdwMQqI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=rxooU6sZSAA9mN6foS+FWjd4N08wri9qaVb73UTMUJ7cvpQfa8xLNWevmfacRHsbiVKIKsWhXO4PTbI3uxyUvu6rEgeOcuB0hc4AJ3Lhcig3JGaprnaRyk7Ltj3sVFUcH+9OG1H4124rNdstVRUXotl15ArcPJSV1NkB1kKH7fI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=qe5r5tfo; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=DtF3Xg30; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="qe5r5tfo";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="DtF3Xg30"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.phl.internal (Postfix) with ESMTP id 3A9FBEC026A;
	Mon, 15 Jun 2026 09:55:03 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Mon, 15 Jun 2026 09:55:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1781531703;
	 x=1781618103; bh=S1doBTSk/Mmex4i6DWIDGLtV6Kth5LPWPVvVl3wp8jA=; b=
	qe5r5tfom4f3NL4ILofX4b5SZ6kkr2Lfw3TdJtP8rKHf1RW5DsM5HnyEKnLf39r8
	Wp78rZkpewJGZ60kDuB7r+eYgB3iYbznJFDSifPN15r2+CWj8kSq0FL7+b8BG6sZ
	p4vK57tsmfQQzpjV295xC+mfib9gmI/euOTMnE2dmM2ir9awYCoV5hBjReDl9Vp/
	ZC9AOvwqSIuR+MEqtFDblmxpmy/ccI8aXHkmb5QtlezPzVuOdobeC2YCqUNOLaiR
	lPezC5Jxxb2pEZ4zA7rMwlAoC7KmbnaR8KUsZWAbCtR4NVQ01FPNluhungNH36hM
	dMHIa/y77pd3sX6d8CzDhw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1781531703; x=
	1781618103; bh=S1doBTSk/Mmex4i6DWIDGLtV6Kth5LPWPVvVl3wp8jA=; b=D
	tF3Xg30dTqLcgo9ZOGo4iak/h/PPFR8st4Tl7yPeazwAa3Wp/BaOzBISvlC1JV88
	XXtxSme+vJFw611CByuiTopyelUFPWA6nNzl8W3ZM4FPp9FCCGwv5XUcCTN+lphD
	ssnqLGy80BhbF1Swkmy6lPOtbbKx5arDFHJWQup94CwS5oHwq4xbysKrIF5j+ut7
	bs6PxDaIcstjYgwz0Pv7Emq0LLr7TuV7UcTtRi1gv/ioh/VL3nkcEQBglHhMMz99
	AQ6Mub0Otpa9E3/fL8Abvq4h1BJEUQ32SVIS9dP5QrSmNsCBtoeMCH1oinT0S4tX
	jUhT2At+1xxinajR52yMw==
X-ME-Sender: <xms:NwQwaqflQuffKGn94vo43UhvIPo39FIveXnkevXyyQuDFjG10_eQnQ>
    <xme:NwQwalv8ZJ8652Kyf3MpcsI4vHtyL5P8vFLjMHrvoTGnAHG5TRuJ4WQId6dLbvhFZ
    C37hRzLEAf1LEcwi_Yyx5pJ4YqnJhvbdIfQI16L9q3kD33Nwi3DVA>
X-ME-Received: <xmr:NwQwarnxslsfiQHgG0BfL_s1tVYE9UB06WDdiU649M-5a6yot9AbKnnTRRWzTt7mBOnkOgvP2j6GVDVUbL9UFwgQ6K7B5GWK0H5nz8r9Uw>
X-ME-Proxy-Cause: dmFkZTEMPeD8zBW3DHtQEP5i93Acch+5rP0QNkH1cG/JXuA6+oEvHbtVmbD6clvJelgRZE
    1vBDsT7A7uQV6Gdj9OkjlqBCAnA412wemQtKwuPA/hvgcOh8CyRfV2AhtwfLNHTKQlwHQv
    oxhlnwtt/nGkegyVzC975GVhHt4uS6iBR/u/zU4/qV1aRi9gpkRnRhEG7H0vxr+9yXdWRU
    A8v/TL7rSWppNOMIvDS55f2AGwsqLpr5AvNVKzOZx9y2Ss5T1e/j4FoCcOGPCslmG/qDWP
    4JG1/aHeUY9Coy2vDLc1RvUk2C6XO8Fs5cA6VTVPI0cv+rNzSdKho8Uu7UNXJYJWmKwPMd
    Bsb2SOJBFs1XzrM3u13j2s59r+ZHXeoEOOm66bP/crHiuOUpVHsb76Jo+oV5XzDZNnNJ79
    ztxfvLV5WAR8Zgu5RTcQ96uIC47Y4sHJ5KI7OVKTV07VNlXIArN7J6pLvPqvgG/NFb6LBm
    9Sr4tihgdUo3m2Uk4XDxGiJwPFVEdSlYJ5XEFKOVGF50Yv6+8BD+ce2BgPhPBMYMJuF0lI
    YcuVTehnBj5yNSxBTDQbomH/SsrVCZnFOLKmWp0EFFTIf7mG8LmB1hPQFHjgPONB7B+QKX
    SqKDT3N/AVQ+Z3/qOXklKVxnx/NTOz4GDE7mqDp6ONZC4OdZdyKL6HtRDmiw
X-ME-Proxy: <xmx:NwQwanx75RhlYZ4BAeW-mqZ_7zSot0HyJZ32a3qJHGWbKor0olWQNA>
    <xmx:NwQwatNDMHuKv7E3RZCYJejg35yWZVR8wkkZ1AoEsgwCoLLU5c8T4w>
    <xmx:NwQwajq0cUh4_pchVto-6pIO-WIpSULG2CXXGppoFPEsUM6iNK8EqQ>
    <xmx:NwQwamEzkbq9BfUNs95UQ5jyYzmRvQ61xseS7Yw4YEeMv6oNGAmRNw>
    <xmx:NwQwamC8-ocbDZHFIVkVCuHEDkXFoirwITOT0LelQwVB8tB_hg2deaJF>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 15 Jun 2026 09:55:00 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 672ba48c (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 15 Jun 2026 13:55:00 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Mon, 15 Jun 2026 15:54:52 +0200
Subject: [PATCH v6 02/10] reset: drop `USE_THE_REPOSITORY_VARIABLE`
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260615-b4-pks-history-drop-v6-2-2e329e536d78@pks.im>
References: <20260615-b4-pks-history-drop-v6-0-2e329e536d78@pks.im>
In-Reply-To: <20260615-b4-pks-history-drop-v6-0-2e329e536d78@pks.im>
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
2.55.0.rc0.738.g0c8ab3ebcc.dirty

