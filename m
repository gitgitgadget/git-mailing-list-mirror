Received: from fhigh-b8-smtp.messagingengine.com (fhigh-b8-smtp.messagingengine.com [202.12.124.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DE5B3BF66C
	for <git@vger.kernel.org>; Wed, 10 Jun 2026 08:52:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781081561; cv=none; b=TNXQBqww0BpHO8ETgLAYATRGYQf/G1vgKjxvNWRI8LoGcEPHhNO2xel9esy7AM2UdpYwltr2CLKLdopbZ130CzIVZXJool5YtgoarmjeNM8asVEUoiBrjtib6ImCdK8hZ43k7n+Y5ewrvxZCpfPZRw+M0Aam6TWhrL7JB48uU98=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781081561; c=relaxed/simple;
	bh=aCKx8RAdUBN0jhn+KdWUiigGFQKs3Qj1qM7JT4xlbH0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=KVqv567/1GFddoly9pbNiZ/eKuAN5OSGsLklS8xJ7+PGC4ATqgaYI3XSbJWe+bQsrQ/0hy1TZ0FNGua+f6JMMoVYXyhona8p/9gTvF6jPARVjvi20CpSkUNe4LgLEtO4pIvdl/H/kX7F2WvkZQ7J3HVX5CyxUp11njTPvYq5nkU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=XIruLHGO; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=VKehFhqd; arc=none smtp.client-ip=202.12.124.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="XIruLHGO";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="VKehFhqd"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 2EEC47A0067;
	Wed, 10 Jun 2026 04:52:39 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Wed, 10 Jun 2026 04:52:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1781081559;
	 x=1781167959; bh=ZExGmDHv+LmWh0NHGhqyng7Igrt6hKsKZGrKTOMA1DY=; b=
	XIruLHGOVvWVRg3qnP1Cg0VmdWwEhHATCWoDshIWlD4EUzhlfdlgmVeFIHoryFN7
	M7e/YiraUWmHWexW+3+Aj/8eusUuuH8QsNu0Ubkm/6NV/ylisO61GFm7QXqNZOg8
	21BgVCXoxyt3nflcPLytTIo76/XpyDYkOOBGXlH9GrQiwtQeaGkDOk2IDHkDapYs
	NeiWkeeoMwTGHtTyXm/20UA3/UDbOsm1EGxFrHvUe8bzihP77Qzcc+LXV1bij5YB
	5IWt/oF7dntZyaFm1CL75Xkqp9/1XqD/lVvSRW55KBvftOkeWKQCF2ZroR1Gnv35
	fRDF+Xcwxz4aB7ZDihpJiw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1781081559; x=
	1781167959; bh=ZExGmDHv+LmWh0NHGhqyng7Igrt6hKsKZGrKTOMA1DY=; b=V
	KehFhqdwJ1TT2GadSKetxStMnvI4PSMnagw5ZPfpAQZ/Nct+bsUt20yaPnJ/2FKm
	KiI2P2ds066TjPF+YZyR3rQLmE4E4Mj4r3ezGb+NTuGRBYQ9UF3TJKMJ5HmrS9yu
	0vmKE/knCkx0JyER0rclVu8zQeVk1Izz7fAIy2OxKGR3WQZyLyVc+sU7nEDMSdvN
	Tv8ZtEyknJ0svXBRsC3sNtkqowXZ14VsT4p18GdbwzAmKsKSMsHpv5bRmNhGlxYx
	XB6XRr6iBXccQefPG4WqlF4do++aE8Jrxpqf2TrQQrBjoOcKPCvUNiBDVg7hkZIe
	Pv+6Fa7gd/mX/W9drnqpQ==
X-ME-Sender: <xms:1iUpaibLn2PLr7aq9-wFxupXwJ8Obl6qNnbVHX08aUxYX_Y5IzoSCw>
    <xme:1iUpam7NNrwcvy3ccl9p41dCN_LoMmqPXYRsMTVv3-if8PvePiRf2nFBRLvLhVQf6
    pNeh_b_mYMMl0qljNO0itXjCT0hwg2BJvzQODpr9Se_aMk6V2I_MQ>
X-ME-Received: <xmr:1iUpatAIZFplVlXd0kW-Db06Obp6TMYR7_xmhZqPLcM6eXUdL8JF1ZX8359CcwIbhvWnH40rVUHvKso0crAQMh23W8UOs41EtRrBtJNlWg>
X-ME-Proxy-Cause: dmFkZTF+2VdknJdj8ZOu+QNsFFL2Cp4b8MqxYtg2L4k2lvcdsh9YrzSboE6bPt4KoDjGwC
    6qElUpuMdHcBesalKO5yqWKug91R08Ywpa4ms3332VV8ZUZovufNOt6cKxX+PDS4N5TOlh
    UkArHXbI5L+hKOXl+CtfdlZZjrWx66Fz//JhA/5xtF3/vAXeWCf3FpCs+sPLHHPIfvphj3
    vnmi+RddKNPLB2ik3E4aLRriPZHJaWRwXmwXbswq7zGuiiduIG4/L0Ut90WbLe4URCzcUF
    VVeXIIybjrzhYBZ2WLlFI1H1Mz/pN6DdD+zzryFnw/IR2vHeFP0fSf5P1EeJPM80Et84eb
    kZg1YeF77dBd3oMs+MHzRS5ve1CL5628W1PWUuO37C8ZAwjoWXHecfQEXZA1Lc7iIOxLti
    d+pJkhC0AE+nk3v6KiPJERTZ/N694a1ZzlaHmNqB/YCSh2QwhKH2d9ghAD95Rltqff0VrM
    y0TI+UEWfBRgThIjy6mlrlLAGY/ndJRE+jjeuI7bhUeBFXvTSWxoRrG/3T13CxhvrBju1N
    EZAqE39kAgW4LM3uWFPES82bh2u+/eX5NTo3qhr5v3tHC9R06ZQEhnTbcM70hN4aqvWL3N
    BDcAtk8nugT4S+X0DVHwAbAOf8CrrCwkvT62RuzaiIBkHLcq3QMvK342qPzA
X-ME-Proxy: <xmx:1iUpakf6PuBIdxldgX152vjOZejvqBIvPyEgj0ySo1QsWwtlmH5JNA>
    <xmx:1iUpakKiWbG3smiJ-zR5sLQgSQsOdiNSbQm5VWAJEQ-gL30szyqtLg>
    <xmx:1iUpan2jOtMuluayLGVQdKLDDNNguY0pCWycuJGZjGEYaVs02AbOlA>
    <xmx:1iUpauhE2QR1YSO6Q2u9mzo8fsDzoCsISDU_BUCt9nC82fnhg7lpAA>
    <xmx:1yUpaltJ2Hpv3DTxAsb2AG9gdh2ykLtIQeBsB0nYURWmmJauZUoVoFNO>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 10 Jun 2026 04:52:37 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 3bc48129 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 10 Jun 2026 08:52:36 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Wed, 10 Jun 2026 10:52:22 +0200
Subject: [PATCH v4 02/10] reset: drop `USE_THE_REPOSITORY_VARIABLE`
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260610-b4-pks-history-drop-v4-2-70d5f0ae8c25@pks.im>
References: <20260610-b4-pks-history-drop-v4-0-70d5f0ae8c25@pks.im>
In-Reply-To: <20260610-b4-pks-history-drop-v4-0-70d5f0ae8c25@pks.im>
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

