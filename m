Received: from fhigh-a6-smtp.messagingengine.com (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59D7C41361B
	for <git@vger.kernel.org>; Thu, 11 Jun 2026 13:27:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781184456; cv=none; b=ODsVqexneHBeIDUx36CJ/aO1NKJ/uI4lOE7O+Wth88yMtjn9Xiy5x1kM8FHujpbHYzHeNAgQEa3ILTHxzlrX/2pAswIwXtBFWTtG1Rk3gUxxD0WYixpd+TR27uSOVGXQxIO1jIJm6hXvYm4Ag/gfUYuTDXTCB9K15yIYArvLx3g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781184456; c=relaxed/simple;
	bh=hGzQpoYI6vSzvHr7cXoEPALfHZrG2YQ0IBpBB3tccEI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=IuIBR92Zn3q/hs9jbcH+1qBoVbWP4eWub6VegwL6TmwOqyifSizdnuRlgnRQOqnkxa6VzabVJUu97G3BSoo/yHqd0a+ZuWTSBnSbDC9sgDd2d1hz8KHK6AAwqBtn4aP38jPOMWi43272XLe+FsZKaQnwhEpTj2xOBXli80yBu/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=MkmRv9Bi; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Q1ZAjCWj; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="MkmRv9Bi";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Q1ZAjCWj"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.phl.internal (Postfix) with ESMTP id A987114000F8;
	Thu, 11 Jun 2026 09:27:34 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Thu, 11 Jun 2026 09:27:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1781184454;
	 x=1781270854; bh=4Lf/eXFsyc82vMTmu6NWYQUgf6vC/Rb7D49g6tTJXfo=; b=
	MkmRv9Binx3A77CwsjxPcF2PA4tdmQvHPZtVeAWzO9bGCEcXGnbC6m1Kii+RX/DN
	iwSuBCHIxNocqZSGzdCSB7apNE1YgM+MPIXyUztVyQXkOSlPI86sM6LVT44n91ea
	LcNAhL55ocTduRKvUcj4fkj0WIKB4bGwamKW7wfVL3RbMid2jHfWDqCYQ0bPPhoe
	6aog4lzGzjbGbzCCcA7/9+uVi/TgiZpak/RQD5TCWjgUXiEcgpMNZjCfrcVB1zVt
	9PAEDkuuJibkMMShUKHHqk85NuL4gDFN7+0CRbitndopBLBRPmsSUBCkh1MuJP2y
	dGmoid0a7PaffJeg++J6DA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1781184454; x=
	1781270854; bh=4Lf/eXFsyc82vMTmu6NWYQUgf6vC/Rb7D49g6tTJXfo=; b=Q
	1ZAjCWjthGMGL2/z2oGa1G7p6fQbVNpuAdzR4sqMoFinkYUDUJ9EgDVvVBRKZCjq
	bFM30tt6s+XThrQ6+3Fd0598GVmCn3uhNEp9+5nPwP22nhLkx+A7uWZuOJDw3a7q
	t0SPp7u0b3SjTZ6WEo8CWfC9i0Hf3TI4K0VsssqX+8RWth/yXpDgu234M0lYWiVa
	PYUz7QC7QCEXI2/fJqGSbnnMYo6GSnMQGSCvRl7q4N88Lqhgr9ortw9UDv2cgCbi
	CvB4vGND56E8YB71b9FTFq2pgo2nFXy+I1fTfJj/bfNYcWV46WJwV69LkIjp2x5v
	H0avSp14pRH4RTmU0mIJQ==
X-ME-Sender: <xms:xrcqahrZ7hvwY3Q4u97u5DDgFxf342OlShoFAdQOxlsvMw1tm9xUIQ>
    <xme:xrcqalL2WLFhXbjI2Km5fWJozpP4X46mquLsmjAwb8JrIpkIhmnv85IpCfz02LRk9
    MpyTSPIV0KtS2tWAv_eXjas7L2jUdFbNHQhIX12yyKK_PAvPcEa_kM>
X-ME-Received: <xmr:xrcqauRJ3NTVRzsg-z0PBWT3Vih38lBWeCG0YtwJYf6_BcdjfSwX8E1SGNtYJ5HNsl4XaInNdrWwgOKgTBCU6Vsgl0Xy24mP-zNFgGb0slsF>
X-ME-Proxy-Cause: dmFkZTGwvRir9c3jOJCfaO/fcQZVMOvwNAvS1QZKH5gRSNLEUXkTOOKA8JJZVtzjW2Du2Z
    N9g4eX/U0NY1IRiNE8hYBqy9/FzVX9SlooG7PrF15U6jO32N6ofuJ79gtfeIU73w/rXX4k
    WMV9sxmRZ4MR3e+NnhIRFaemFiS7/Tru2qJ36Y6weCRhaSxrSfPmOybkHoO8a7jWozpd5/
    afCV8WniK9wyefTXN6rgCLyMeplM8dDrV2LJGRYqxlcDzr2/4dUd00EtnLkXL9eJxJhkvy
    BHrL+cHqauXqZKokOz+gymX3a8pP2GCE5rBgE00hhzZu7HWdqbNcum5jhi51UFUNUR+mF4
    RiAQY/oanFXGAIOabV9LJuGkzIbZ8UnnlqXGZrUjXoTghE8HqGZBT2C8K2AWpbz4s75ACJ
    H1hGCSYfRB5AIKIKQH/OfACBYGkXHdcDPDi46iVt/EVYTMGJk18ZGQP0GJinADZQDKXV7B
    jOmtLz3QA1kqD68+AJ39MbVOMX6XWBeS68rwyHBajL/nIneJMyxi+MzEuMShhDGr7QCtqp
    UMic5qxSVRfwPpI8/Zm47aD1TkGD9AEeibpHS+EmFTw90Kdxqb0jZX17QFiBNHvNYzhKgw
    Ap8AqQsTGNODl4EoryCB1/kNqJBaI8W9pMI2+lwAh81xOaJ1faSGpYQK+Rdg
X-ME-Proxy: <xmx:xrcqasunWmbkq6ZtdXF0G5pinRCpD341Chl-mNJ-Gec0Y41xnNIT_A>
    <xmx:xrcqanYbtxbyK3HYMqORKcLtSnMzo72OWUbYAlNogF_i_UHSAf_9lA>
    <xmx:xrcqaqH228rGDPeDfjo-fzWV2zw39mpya-NuZdk-o6ajbMGzjvyNQA>
    <xmx:xrcqajwDbEKsDpNGDpz8Zh9QGUvlWk-sHkEJVt4LibbhfR1Tcp1oBg>
    <xmx:xrcqah9hzm5dzZxOCqbZRW18nNZKVb4rvQznLKXnmwr2lnLsJ1kTAFes>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 11 Jun 2026 09:27:33 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id fcd7b831 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 11 Jun 2026 13:27:32 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Thu, 11 Jun 2026 15:27:11 +0200
Subject: [PATCH v5 08/10] reset: stop assuming that the caller passes in a
 clean index
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260611-b4-pks-history-drop-v5-8-34d35725559c@pks.im>
References: <20260611-b4-pks-history-drop-v5-0-34d35725559c@pks.im>
In-Reply-To: <20260611-b4-pks-history-drop-v5-0-34d35725559c@pks.im>
To: git@vger.kernel.org
Cc: Pablo Sabater <pabloosabaterr@gmail.com>, 
 Junio C Hamano <gitster@pobox.com>, 
 Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>, 
 Phillip Wood <phillip.wood@dunelm.org.uk>
X-Mailer: b4 0.15.2

In 652bd0211d (rebase: use 'skip_cache_tree_update' option, 2022-11-10),
we updated `reset_working_tree()` to stop updating the index tree cache.
This was done as a performance optimization: the function is only called
by "sequencer.c" and "rebase.c", both of which assume a clean index
before they perform their operation, so we know that the end result will
be a clean index, too. Consequently, we can skip recomputing the cache
as we can instead use `prime_cache_tree()` directly.

In a subsequent commit we're about to add a new caller though where the
assumption doesn't hold anymore: the index may be dirty before calling
`reset_working_tree()`, and consequently we cannot prime the cache with
a given tree anymore as the index and tree will mismatch.

Adapt the logic so that we only skip the cache tree update in case we're
doing a hard reset. While we could introduce logic that only skips the
update in case the incoming index was dirty already, that doesn't really
feel worth it: after all, the mentioned commit says itself that the
performance improvement was negligible anyway.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 reset.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/reset.c b/reset.c
index 955ea4ed5a..5a9ed807d7 100644
--- a/reset.c
+++ b/reset.c
@@ -167,10 +167,11 @@ int reset_working_tree(struct repository *r,
 	unpack_tree_opts.dry_run = dry_run;
 	unpack_tree_opts.merge = 1;
 	unpack_tree_opts.preserve_ignored = 0; /* FIXME: !overwrite_ignore */
-	unpack_tree_opts.skip_cache_tree_update = 1;
 	init_checkout_metadata(&unpack_tree_opts.meta, switch_to_branch, oid, NULL);
-	if (reset_hard)
+	if (reset_hard) {
+		unpack_tree_opts.skip_cache_tree_update = 1;
 		unpack_tree_opts.reset = UNPACK_RESET_PROTECT_UNTRACKED;
+	}
 
 	if (!reset_hard && !fill_tree_descriptor(r, &desc[nr++], &head_oid)) {
 		ret = error(_("failed to find tree of %s"),
@@ -197,7 +198,8 @@ int reset_working_tree(struct repository *r,
 		goto leave_reset_head;
 	}
 
-	prime_cache_tree(r, r->index, tree);
+	if (reset_hard)
+		prime_cache_tree(r, r->index, tree);
 
 	if (write_locked_index(r->index, &lock, COMMIT_LOCK) < 0) {
 		ret = error(_("could not write index"));

-- 
2.54.0.1189.g8c84645362.dirty

