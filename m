Received: from fhigh-b6-smtp.messagingengine.com (fhigh-b6-smtp.messagingengine.com [202.12.124.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2CDE1D14E3
	for <git@vger.kernel.org>; Tue,  5 Nov 2024 09:12:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730797943; cv=none; b=ND90DzsMITmUaeivrGV+T3zIQ4Oq/Fr0qt+Mk07LHpcjDkrS/EXDNvM/gmqrDOr0IZXDmLOEUTnL6UmFyZbWtx2gAwE8MZ6OwrNgsSvSJoZgLkRljzxrdlffzb6uhsrV/aWvrv/67ndXJpSdFBC7GEE9sTajMcdEPNfQvX7meUw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730797943; c=relaxed/simple;
	bh=OuzipJSYzBDeK/uEFyiYB8IV5RZH8NQnfdRifYDFKrI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ifRO9EMyNW0n3lbRnwJYnv5TkzRT5hFLiHB+JadDPCrVVq+P5Wpnt9hpPwNTxnl6YNgFyGHnXjkWOw1B8D/Wt6u0e//O4ZWTpXZM1NRbcdntLyfibzBPapvCjK0cBOvJ4qMeJIPctvJqj5+EJGSSh5Z2WudGBXkGUfR4OECyYEs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=Z1dcPyT5; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=m1ryVq+q; arc=none smtp.client-ip=202.12.124.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Z1dcPyT5";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="m1ryVq+q"
Received: from phl-compute-10.internal (phl-compute-10.phl.internal [10.202.2.50])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 0762D2540126;
	Tue,  5 Nov 2024 04:12:21 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-10.internal (MEProxy); Tue, 05 Nov 2024 04:12:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1730797940; x=1730884340; bh=vNzVlfVWW+
	xICVC8kdsWLYsgyi3pcmHdpM96mbKAv1E=; b=Z1dcPyT58RNJHZrWGRnJSsbrhp
	qP4PC3QUN+5sBDew7Oy0mpPXkHq5umlBHPpJgxvMj9/sl5Wv6QPunBuGK6iswXet
	hrp2mKrBRCzJ5cjuo/8lAxG6yFUIbzODvpAAg7G5BZBJzkfmJdmgCAQrZBc6NBBN
	wgor+9ylUlmBzPur8cwk4+Xgb9WBDtg1O1uyRHFr1/2FRBVtDQU2iA10TVsZQ6Rl
	h8D93Hohfj0l5+hoQ2MT2hqYs7A8ld/0h7FbqIGDua6YgvxPphRtXhObIno09mAj
	UOEqfrtGbiKCN714/9MJq2DYzIX4ayp4xwbthCaRHP2jNIHPzlWZb+34qQLw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1730797940; x=1730884340; bh=vNzVlfVWW+xICVC8kdsWLYsgyi3pcmHdpM9
	6mbKAv1E=; b=m1ryVq+qspWFIO9ONN2BK8ATCqek7lCydw5rBhPdycEjtejbqFA
	x5poDl1hSCPLsKU5xT2dVGn+u7WMv7bkn88tL3WQRlEp4WQhq+LctjB/tDRGWi82
	d+v3oeNAd9LnAALCaPXNO7QxGUjfQBK+P+1q7e10zwwGRoOPLTrchFjTzvJzElsy
	kqUwrzw1icE4SaH3mat0eqhxU/gUl8AW5+xGha960ADxv6dNyRWZkhKRNJL8rTP/
	Iu94Mj7BYv41V7s1TTat1WdKQZT687UpCSf1irm46Y4dzMvUUbe9Qy/Bpza+dTwj
	VYK6Hmk0NiUzAIDyd1t8gcUXZ0xIqIyXEfw==
X-ME-Sender: <xms:dOEpZ8NPYeFj1OPM4342vNl8unYoqZI0rvawn2yfBZ5y_HEYmxNkcw>
    <xme:dOEpZy9E0k3bzCbQhWF7gQ3mTrWOJ6PgajqztdQkg_r-2hnLIDEthmr1nEZv48qID
    YJkld2hVyD2lwj5gw>
X-ME-Received: <xmr:dOEpZzSafaB2Y4rk_SpxXVoHV7k85udXK6wpWdL2c2ySNu9X23mjl1uI-Gys34I3RaxBzTp3cNA01yvfnAAo_wEUKAfhA3vzfiPl5Cwd8poHPQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdelkedgtdduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvve
    fukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhn
    hhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpeevkeekfffhie
    dtleduiefgjedttedvledvudehgfeugedugffhueekhfejvdektdenucevlhhushhtvghr
    ufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsg
    gprhgtphhtthhopedvpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehgihhtshht
    vghrsehpohgsohigrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlh
    drohhrgh
X-ME-Proxy: <xmx:dOEpZ0vM2LI-jSxRU_jJpwCzLeoS0jsbFLIB4cZUtyFtA_0tAJYBAQ>
    <xmx:dOEpZ0ciQom08Vv76xKLhohYdrdku8GNNewHQAuY9E76IAFCE3CqWg>
    <xmx:dOEpZ43-TogZ-0x52xJXsZcmfQVjkl7rAaoDuRjtpz_a6AjfmmEnvg>
    <xmx:dOEpZ4-h7mSXAi0nIPadYwMxZp0EQ_44ThNkfP7cMAJ7Ez8hVHsyvA>
    <xmx:dOEpZ1qR3o5PvrHYgAW9ijVGILnv4NjW9CVvKgiZ7d3QLwNwbWadTDLh>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 5 Nov 2024 04:12:20 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 6ef1a316 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 5 Nov 2024 09:11:58 +0000 (UTC)
Date: Tue, 5 Nov 2024 10:12:13 +0100
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 5/8] refs/reftable: refactor reflog expiry to use reftable
 backend
Message-ID: <355557ec951372a16b70558706981867a5206c87.1730792627.git.ps@pks.im>
References: <cover.1730732881.git.ps@pks.im>
 <cover.1730792627.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1730792627.git.ps@pks.im>

Refactor the callback function that expires reflog entries in the
reftable backend to use `reftable_backend_read_ref()` instead of
accessing the reftable stack directly. This ensures that the function
will benefit from the new caching layer that we're about to introduce.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 refs/reftable-backend.c | 13 +++++--------
 1 file changed, 5 insertions(+), 8 deletions(-)

diff --git a/refs/reftable-backend.c b/refs/reftable-backend.c
index dfe94ff969..9c6e9c8374 100644
--- a/refs/reftable-backend.c
+++ b/refs/reftable-backend.c
@@ -2412,14 +2412,15 @@ static int reftable_be_reflog_expire(struct ref_store *ref_store,
 		reftable_be_downcast(ref_store, REF_STORE_WRITE, "reflog_expire");
 	struct reftable_log_record *logs = NULL;
 	struct reftable_log_record *rewritten = NULL;
-	struct reftable_ref_record ref_record = {0};
 	struct reftable_iterator it = {0};
 	struct reftable_addition *add = NULL;
 	struct reflog_expiry_arg arg = {0};
 	struct reftable_backend *be;
 	struct object_id oid = {0};
+	struct strbuf referent = STRBUF_INIT;
 	uint8_t *last_hash = NULL;
 	size_t logs_nr = 0, logs_alloc = 0, i;
+	unsigned int type = 0;
 	int ret;
 
 	if (refs->err < 0)
@@ -2441,12 +2442,9 @@ static int reftable_be_reflog_expire(struct ref_store *ref_store,
 	if (ret < 0)
 		goto done;
 
-	ret = reftable_stack_read_ref(be->stack, refname, &ref_record);
+	ret = reftable_backend_read_ref(be, refname, &oid, &referent, &type);
 	if (ret < 0)
 		goto done;
-	if (reftable_ref_record_val1(&ref_record))
-		oidread(&oid, reftable_ref_record_val1(&ref_record),
-			ref_store->repo->hash_algo);
 	prepare_fn(refname, &oid, policy_cb_data);
 
 	while (1) {
@@ -2513,8 +2511,7 @@ static int reftable_be_reflog_expire(struct ref_store *ref_store,
 		}
 	}
 
-	if (flags & EXPIRE_REFLOGS_UPDATE_REF && last_hash &&
-	    reftable_ref_record_val1(&ref_record))
+	if (flags & EXPIRE_REFLOGS_UPDATE_REF && last_hash && !is_null_oid(&oid))
 		oidread(&arg.update_oid, last_hash, ref_store->repo->hash_algo);
 
 	arg.refs = refs;
@@ -2539,11 +2536,11 @@ static int reftable_be_reflog_expire(struct ref_store *ref_store,
 		cleanup_fn(policy_cb_data);
 	assert(ret != REFTABLE_API_ERROR);
 
-	reftable_ref_record_release(&ref_record);
 	reftable_iterator_destroy(&it);
 	reftable_addition_destroy(add);
 	for (i = 0; i < logs_nr; i++)
 		reftable_log_record_release(&logs[i]);
+	strbuf_release(&referent);
 	free(logs);
 	free(rewritten);
 	return ret;
-- 
2.47.0.229.g8f8d6eee53.dirty

