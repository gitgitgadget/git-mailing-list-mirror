Received: from fout-a3-smtp.messagingengine.com (fout-a3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7626A1C07F4
	for <git@vger.kernel.org>; Mon,  4 Nov 2024 15:11:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730733118; cv=none; b=Ihjk3yqpmTUoZxhCmJAehZosDdhJXtaSi7YJVEFX+jUypjkHolnYjDroHBzYM9CFwKUZDTx70bItjUr9SbC5e03wAmWQfAOwIFWcQXWSMbU4KlFkfcKpbGLsJWLqpqy0EpN+hUmHy0bSzpGL9Yur66E1D17iiaFoATqJnK756D8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730733118; c=relaxed/simple;
	bh=dlR951rvvPjSk+5J/6dtwQaBfpdzcSZ2Dg+CkBqh8rM=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iXhwHRXgHZMfS0VpMeCuBNc+cDdDrvc292KfesSmApDT+BmZ4X3fJh8cG0EWyXPv2kJTZbhwJHNc9UainR/936mXVlPG6rVe3V5+/ehxFxk/zvnmb46aZZxVQ+BFoJeEcS2+bR1cok7vJa1UQHiHyFSOLJE/JuRAWrGDkwZY52o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=x09nPgP/; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=DMJPn1XY; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="x09nPgP/";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="DMJPn1XY"
Received: from phl-compute-08.internal (phl-compute-08.phl.internal [10.202.2.48])
	by mailfout.phl.internal (Postfix) with ESMTP id 734611380434
	for <git@vger.kernel.org>; Mon,  4 Nov 2024 10:11:55 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-08.internal (MEProxy); Mon, 04 Nov 2024 10:11:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1730733115; x=1730819515; bh=DHCvi5ozWs
	v9o6MJ3QHXrv95wog6M28Um10SBMf7Aow=; b=x09nPgP/ub9DBomXQAa+J1XSdY
	oQgz6ia6XeuJCKaBvZ3hYPUw4jNThI7FA+JLL+K3HcpUboYXZCY4vThefhBIU/sz
	nOOti4HMXBfvqbGiCpWPNTFZgCwg27Jte5ZHYuHsaOpf/nZZV0uL2jSUZgVKeT/1
	uS9YRqORcKae7B2WtDjh2Ykj2M2h8YR08urJEwUSN1SUD/7BathRbAWGIy4w15uL
	iBzvfgnZlieea/pZ0yyTskdEshhqdlxntazbdd0dKVe0iAaH0+VA73TXxlCcqOfL
	FCW4vpaSp8HGAPTjla3QKxAVCLo9nLZxNMnB1wiXynA3opOB+DyU0WglUx0g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1730733115; x=1730819515; bh=DHCvi5ozWsv9o6MJ3QHXrv95wog6M28Um10
	SBMf7Aow=; b=DMJPn1XYXTZoVrdOOdi1fuGS2R6bm0LXFmACggGBJTNwqn/q34u
	2eBdgtK0dLTPO+Q3dCbzI5uRTXxp2nJ2Rz4EHUGojfMjYuTycR0O9ykHe1iQvOMN
	NUne2LDT9ZZ6sHLkxxrczMnNSITTri4rOzMBVEBOGpx+/+MItOsyJWJhvAezhzun
	xkXVNYGY7jK0Lo1zQgiXD3QajXWTPW1/hdiTcdrHl+MWz04btsAjELsLHOOByrly
	hXVSn7u4iP9d1B3MR7hikDsW2La2ZHIoX9o4o0CktBuE7kxi1JYxYMgMDas3oZma
	TqRVlhdusz8QBtebk3T7vpCTtUphlvefZ0Q==
X-ME-Sender: <xms:O-QoZ5366lKfpTW0L-SORQS293OY4GeKL0H4R_NQrD0J-7KBJjw0yA>
    <xme:O-QoZwHf5-Hvv2twV6CSHoFmfHIP9pL43DaMCVRJCYEhY8YmOLTzA7gQr4CX8VYj3
    tOJ59n6Rqmk4SGUZg>
X-ME-Received: <xmr:O-QoZ54xYeyWygf1-pKO7kEozEYCvyS7UxDbwb5R4FPNxVU3NesDDwDezyqdg5ZEpubuf4t5kKJiYtmaVuQqZU2gjiMl3XuJLYtodxKS4rJoX1HEag>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdeliedgjedvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvuf
    fkfhggtggujgesthdtredttddtvdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhh
    rghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnhepheekfeefgeegvd
    egvdeffeehtedttdffjeeuffelgffgheefleffleejvdefheeinecuvehluhhsthgvrhfu
    ihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspg
    hrtghpthhtohepuddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithesvhhg
    vghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:O-QoZ22Agf5h07uRD8uEG3yRHOGWbuzCFuQvjap_3QuGhVhHndm2bQ>
    <xmx:O-QoZ8FgRd1wXB-k3HD7RKDpMS1PwsyCBqCY1jynXC1ZRy3CWZdACA>
    <xmx:O-QoZ380Spx2GNgEfNS3vUY0jU_VarrGhtn9goSlZr__NdNkYT_twQ>
    <xmx:O-QoZ5kFdDCtwQKpHpWrzSwxvB6lFYpyU_b2o5cjRTn8GElii1vXjw>
    <xmx:O-QoZ2NMjZudURBTLOgF1iy6xv9vDzl4h-9lFEwC1-FrjrBtH0hr2gmw>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Mon, 4 Nov 2024 10:11:54 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id c8d8e1bb (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Mon, 4 Nov 2024 15:11:34 +0000 (UTC)
Date: Mon, 4 Nov 2024 16:11:48 +0100
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Subject: [PATCH 5/8] refs/reftable: refactor reflog expiry to use reftable
 backend
Message-ID: <44f4adce9adb1ef16017da6631f9b957929cf842.1730732881.git.ps@pks.im>
References: <cover.1730732881.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1730732881.git.ps@pks.im>

Refactor the callback function that expires reflog entries in the
reftable backend to use `reftable_backend_read_ref()` instead of
accessing the reftable stack directly. This ensures that the function
will benefit from the new caching layer that we're about to introduce.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 refs/reftable-backend.c | 13 +++++--------
 1 file changed, 5 insertions(+), 8 deletions(-)

diff --git a/refs/reftable-backend.c b/refs/reftable-backend.c
index 3912431111..98a070f5a7 100644
--- a/refs/reftable-backend.c
+++ b/refs/reftable-backend.c
@@ -2382,14 +2382,15 @@ static int reftable_be_reflog_expire(struct ref_store *ref_store,
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
@@ -2411,12 +2412,9 @@ static int reftable_be_reflog_expire(struct ref_store *ref_store,
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
@@ -2483,8 +2481,7 @@ static int reftable_be_reflog_expire(struct ref_store *ref_store,
 		}
 	}
 
-	if (flags & EXPIRE_REFLOGS_UPDATE_REF && last_hash &&
-	    reftable_ref_record_val1(&ref_record))
+	if (flags & EXPIRE_REFLOGS_UPDATE_REF && last_hash && !is_null_oid(&oid))
 		oidread(&arg.update_oid, last_hash, ref_store->repo->hash_algo);
 
 	arg.refs = refs;
@@ -2509,11 +2506,11 @@ static int reftable_be_reflog_expire(struct ref_store *ref_store,
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

