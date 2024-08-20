Received: from fhigh8-smtp.messagingengine.com (fhigh8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02F24191F93
	for <git@vger.kernel.org>; Tue, 20 Aug 2024 14:06:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724162762; cv=none; b=L7IFLw2bruv1N8FUOMGyJB2+YDgAVoFhiHfngSkDmkB4M+m0hLd+tXBtLHfsfnpXy96LgcOFx7YNgCxrYe2UnQL+PxThMSTaYS/A/NzwYb0JokVfdFytM18CtmxdxF9eIYtawTlNWePCq/bxBL+p1QYr9sceHJD6YP2FGpLbWRA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724162762; c=relaxed/simple;
	bh=QLPG/ImQs2pcRSbXlKo57qxLPs1KHvNODyorTa4JRDI=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WhfrFD1anJPrZeSyUDyUZ1s3rlC3ckFi7VOBHzuWsbZno3wVqIFAuSPpq6Z5+V4o2h/bsESwmSUr1PD+tClA9udrvuZcHn6n6q+Mo8kaSYXW+1abEJyGpAbK1T3cbcMHBRHBkrVyd2L8/N4JVOucTg/v/bFA19nmGoC500ya2rU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=ZuxuswhE; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Ovbl+AVN; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="ZuxuswhE";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Ovbl+AVN"
Received: from phl-compute-03.internal (phl-compute-03.nyi.internal [10.202.2.43])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id D48051151A9E
	for <git@vger.kernel.org>; Tue, 20 Aug 2024 10:05:59 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Tue, 20 Aug 2024 10:05:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1724162759; x=1724249159; bh=LmZRIKtX9a
	uGvNsTj8OGDyx1pMfRoPXBFiMIdsEFrXY=; b=ZuxuswhEDHKrXANTKcJ7IHUYsi
	65CJAc1Oe8KZ/FH6RCkbOU2u0VSpaAq52v/JyzETJfy/USEsmSHILh4B91/uHjB1
	jHGwCEBKDX2ORvsQHJxIiP29Fl+niaWeLP0dtaSEhmjILvLiGEQJ5vo0yFPYfoKg
	qqktJEGujFGBO0mcgBpWrfBLEkCpuWISWfjwPX2R4rK78QVha9qRevKIqsn90oqP
	iBvuzvBURWIKG2YZqZqsAs0L8oQbwjAOnJxHJVc0U2tVbgt88oN+SLQ7fCbSU4sU
	CMgdr2VTkxx7YK2AvnEBf4aiKQKq9Y5gtHEIMyLiZYoXaqVibXK3femsuDLA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1724162759; x=1724249159; bh=LmZRIKtX9auGvNsTj8OGDyx1pMfR
	oPXBFiMIdsEFrXY=; b=Ovbl+AVNTr6iAA+yl41cKDS4QOJDbiTDjS9IjA02KBw0
	i6tGndnFKUvc7QAd/H+WXXfUeRwJyhVv012GvqEiZBZzqR+jrhX9RskYYeFdXWlb
	AIni5I8MiyRQtW6Y2zHKxMlKg3zn7+iUgrYgrnK5ktAXH3CksV3sd5g7VbZGn09n
	brMbw3vd0CBJPTBoBxLf6j3VuZ4BC41HVh7n6kbQXM7D/c6OPMahu1u80d7FjmM8
	zAkG08C2GnNRcnLl4WQ3aKu4sWvVrA9ShnJHePgloN1vKMubmv0GqyK55+SCdzee
	y9g2xwuxS9M3KjfNWcUys8vKr4LvjOZHp3TW6vqMRw==
X-ME-Sender: <xms:x6LEZgqFialymQKbtXUjFWAPbIhZBwIDc5KOrh4jbAvUZaFOuMBwbA>
    <xme:x6LEZmq9QlbTsSppQX1bd6oe3i5RGux3uHVppUjk1nIGv_YVl0bDk40-hpPynUxkb
    W-oJAiw4FqRwN2HLw>
X-ME-Received: <xmr:x6LEZlM6sDF89m5hHvDdPKB4ZDiSy9MbLLB1ZBxxq7QFiErz2MVvhhNwBpkW1OCpMMXKOwbtJjCNcTLOvSdyv5G-hH47stmEWczn3rLBSB9_GwkyhA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrudduiedgjedtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvuf
    fkfhggtggujgesthdtredttddtvdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhh
    rghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnhepheekfeefgeegvd
    egvdeffeehtedttdffjeeuffelgffgheefleffleejvdefheeinecuvehluhhsthgvrhfu
    ihiivgepvdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspg
    hrtghpthhtohepuddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithesvhhg
    vghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:x6LEZn7T1n8wg-rkBP7Apqfwex5bymhI0GgUHjJj5JEYsiMHvGqKPA>
    <xmx:x6LEZv4E5-jlfkTPMJGithF7vT-Hlk8RHP0uImgf0eh5nHk0I2Kbew>
    <xmx:x6LEZnjw5xe-t444P1HW3a9byHAFgqOn_sqBiPdQ-158YnmMc1tgEA>
    <xmx:x6LEZp7ECsFpRxQWDFxOOLQ1o7OioC2RNb6Y42tCDBbp8ZU9rbWRFw>
    <xmx:x6LEZpSQmdba_Ntdagn1SrDUwF031BS4v2rBrId4OynPh7JbJ541lOC3>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Tue, 20 Aug 2024 10:05:59 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id a2108e09 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Tue, 20 Aug 2024 14:05:27 +0000 (UTC)
Date: Tue, 20 Aug 2024 16:05:54 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Subject: [PATCH 18/20] builtin/fetch: fix leaking transaction with `--atomic`
Message-ID: <9ede792550e0b289d931c7f0fcf467873f09c5a5.1724159575.git.ps@pks.im>
References: <cover.1724159575.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1724159575.git.ps@pks.im>

With the `--atomic` flag, we use a single ref transaction to commit all
ref updates in git-fetch(1). The lifetime of transactions is somewhat
weird: while `ref_transaction_abort()` will free the transaction, a call
to `ref_transaction_commit()` won't. We thus have to manually free the
transaction in the successful case.

Adapt the code to free the transaction in the exit path to plug the
resulting memory leak. As `ref_transaction_abort()` already freed the
transaction for us, we have to unset the transaction when we hit that
code path to not cause a double free.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/fetch.c         | 8 ++++----
 t/t5574-fetch-output.sh | 1 +
 2 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/builtin/fetch.c b/builtin/fetch.c
index c297569a473..0264483c0e5 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -1731,11 +1731,8 @@ static int do_fetch(struct transport *transport,
 			goto cleanup;
 
 		retcode = ref_transaction_commit(transaction, &err);
-		if (retcode) {
-			ref_transaction_free(transaction);
-			transaction = NULL;
+		if (retcode)
 			goto cleanup;
-		}
 	}
 
 	commit_fetch_head(&fetch_head);
@@ -1803,8 +1800,11 @@ static int do_fetch(struct transport *transport,
 		if (transaction && ref_transaction_abort(transaction, &err) &&
 		    err.len)
 			error("%s", err.buf);
+		transaction = NULL;
 	}
 
+	if (transaction)
+		ref_transaction_free(transaction);
 	display_state_release(&display_state);
 	close_fetch_head(&fetch_head);
 	strbuf_release(&err);
diff --git a/t/t5574-fetch-output.sh b/t/t5574-fetch-output.sh
index 5883839a04e..f7707326ea1 100755
--- a/t/t5574-fetch-output.sh
+++ b/t/t5574-fetch-output.sh
@@ -5,6 +5,7 @@ test_description='git fetch output format'
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success 'fetch with invalid output format configuration' '
-- 
2.46.0.164.g477ce5ccd6.dirty

