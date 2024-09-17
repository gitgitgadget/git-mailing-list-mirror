Received: from fout5-smtp.messagingengine.com (fout5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8295717107F
	for <git@vger.kernel.org>; Tue, 17 Sep 2024 13:43:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726580614; cv=none; b=s8/1iuzU7mKfO4nwgTHCzOQlhLB754VCer4DZhFVrBnFxStgRd7GtW7lpT90M7hN+za8cPUpgUk493T2EsWxwvXHVr7ZiKTiSrnXfTCelNoAQbFZ20phGDV4ubFP8zZecU6PTX1e8vG3qzMCoRVn2lo/LT2bOjlqSUMFR1MKxhM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726580614; c=relaxed/simple;
	bh=RHitIEb/5n75CChFBXAqCBWPZV24bdF03RupSs+mmsI=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KaG+4nKDM8eFY7KffIIxsA6w4Sa/BrUAoo4vd8yBN9eU2oMzv/p3V/bDKeK5cp7nXn3sECaVlrmmF0j2PkOtWgZk3Fpo2oJMxLg6pwMgHF/Lw6HduU9J+8GaRXWamDWjutYcs903LJJ0RhHq8YVFmPcRh1hDDZDLsOwtPW5TA64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=Rq/3QMvq; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Wm108hdd; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Rq/3QMvq";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Wm108hdd"
Received: from phl-compute-11.internal (phl-compute-11.phl.internal [10.202.2.51])
	by mailfout.phl.internal (Postfix) with ESMTP id BB3111380073
	for <git@vger.kernel.org>; Tue, 17 Sep 2024 09:43:31 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-11.internal (MEProxy); Tue, 17 Sep 2024 09:43:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1726580611; x=1726667011; bh=zOCNGARfiC
	rCzliOjcu2ZOL8/DoZFs+d0RdtY6maxf8=; b=Rq/3QMvqGZwUkcTlZsFISpfUCJ
	i/4Q3/kL3E+k6NjXRKN4PbKI9TLtCgNjtxw2cuqLoB69SFtIEpii1rq+uyPTFbnt
	khuxRXpokTeJqg2y42sWOAbrEtSsRGU2AZkfkGyPBBXq5SRI6kdB+J62Wz2XKpA9
	xHLvJNSl82Hg4wv/v9NYJvNz9APvSg7tR2wg9AQAYwyCJVQuACDBkHSrsnQUoLvW
	8+ouXuTRDK2MLomZQASf7MpofgB4xR31WFeMNpcFQeyGu+aj5OkHZjlpkA6FKwM4
	sU+tFq7XChpr+WD0gI+T8GxQh5kxvFFAPvB9vwCf9FCnMmQ/RzMvezBB+HQw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1726580611; x=1726667011; bh=zOCNGARfiCrCzliOjcu2ZOL8/DoZ
	Fs+d0RdtY6maxf8=; b=Wm108hddkQPiVSC2/p40uwj1QuxwUF9lZ9JAL28UtU8q
	GUzsXNLH0rrdAY5nhlFeh/+8Tl36fS8JEsmVlHQf3hLkjy6oB5jq++1jUkBgC00U
	65jAhvM4ToVGi+ZEMkHqyKXK31tjBJdeV0V2xjkOzE2UMe/sgQ3IgUqoJSZ3bcGa
	+542q4ZNwElxDhy4gfpBV3BDGUSTC6z5NNOA5B6xGQA2SyWI7AMcCJSBeblGitgT
	4JYqeum1HFbvBcarPky7FAjQFL3JM0xsyDA9ioOqup+hNtSuiWqv30P+TdftkCwT
	7XudXjtwcYEVi8uylABOCph+gtT86vJroyrAIjfwpA==
X-ME-Sender: <xms:g4fpZsJlzAPSCRnOt8PDdkmamXUwSfysAGXO_lxn_7-RYwjX9SZ8Ug>
    <xme:g4fpZsK7QZSEdNiCOmFNL4g1ve44TSpdNLlpzuU6GAgGWuupEx11d-7HFWf5cYc-W
    NdGqRsTjhJ96ZJsWQ>
X-ME-Received: <xmr:g4fpZsuV5XgbHYCUfpJLZ9UnbNl3wXpSFZHknLKopJUl30smdhGClr3q_bPypIDMOJKWWGenVYbw4NP7ukVWnuetUGo8WWRp0lc9iPitG4cM>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrudekjedgieelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvuf
    fkfhggtggujgesthdtredttddtvdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhh
    rghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnhepheekfeefgeegvd
    egvdeffeehtedttdffjeeuffelgffgheefleffleejvdefheeinecuvehluhhsthgvrhfu
    ihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspg
    hrtghpthhtohepuddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithesvhhg
    vghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:g4fpZpaVXCRmRqVu_Cwm6Ws016LoDAxDy1ALYC9PFeqptJYDoZ9RkA>
    <xmx:g4fpZjY5XOBqm07Rj_RihR8i4ZEtHloO0OSj_7MJTutc7Zwt0lWQsg>
    <xmx:g4fpZlB8WXW9I4aDVTiFABhvnylZsdKYp0mIbSc6H20NL52J1UY-jA>
    <xmx:g4fpZpZfJ8kH4Jr9R9srD3RfnpQUtp-xRu8hyzg80ejI7EGO5cuEOw>
    <xmx:g4fpZqx93BSd12EodHTMXSaxmRBt9uD25iafs5lYPD4do9DDKukcO7f->
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Tue, 17 Sep 2024 09:43:30 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 697a0d86 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Tue, 17 Sep 2024 13:43:06 +0000 (UTC)
Date: Tue, 17 Sep 2024 15:43:25 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Subject: [PATCH 3/3] refs/reftable: reload locked stack when preparing
 transaction
Message-ID: <37ec3acbff00564ecf3b63d1635aad5da0c54b19.1726578382.git.ps@pks.im>
References: <cover.1726578382.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1726578382.git.ps@pks.im>

When starting a reftable transaction we lock all stacks we are about to
modify. While it may happen that the stack is out-of-date at this point
in time we don't really care: transactional updates encode the expected
state of a certain reference, so all that we really want to verify is
that the _current_ value matches that expected state.

Pass `REFTABLE_STACK_NEW_ADDITION_RELOAD` when locking the stack such
that an out-of-date stack will be reloaded after having been locked.
This change is safe because all verifications of the expected state
happen after this step anyway.

Add a testcase that verifies that many writers are now able to write to
the stack concurrently without failures and with a deterministic end
result.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 refs/reftable-backend.c    |  3 ++-
 t/t0610-reftable-basics.sh | 31 +++++++++++++++++++++++++++++++
 2 files changed, 33 insertions(+), 1 deletion(-)

diff --git a/refs/reftable-backend.c b/refs/reftable-backend.c
index c500fb820a7..d4b383ca179 100644
--- a/refs/reftable-backend.c
+++ b/refs/reftable-backend.c
@@ -766,7 +766,8 @@ static int prepare_transaction_update(struct write_transaction_table_arg **out,
 		if (ret)
 			return ret;
 
-		ret = reftable_stack_new_addition(&addition, stack, 0);
+		ret = reftable_stack_new_addition(&addition, stack,
+						  REFTABLE_STACK_NEW_ADDITION_RELOAD);
 		if (ret) {
 			if (ret == REFTABLE_LOCK_ERROR)
 				strbuf_addstr(err, "cannot lock references");
diff --git a/t/t0610-reftable-basics.sh b/t/t0610-reftable-basics.sh
index 62da3e37823..2d951c8ceb6 100755
--- a/t/t0610-reftable-basics.sh
+++ b/t/t0610-reftable-basics.sh
@@ -450,6 +450,37 @@ test_expect_success 'ref transaction: retry acquiring tables.list lock' '
 	)
 '
 
+test_expect_success 'ref transaction: many concurrent writers' '
+	test_when_finished "rm -rf repo" &&
+	git init repo &&
+	(
+		cd repo &&
+		# Set a high timeout such that a busy CI machine will not abort
+		# early. 10 seconds should hopefully be ample of time to make
+		# this non-flaky.
+		git config set reftable.lockTimeout 10000 &&
+		test_commit --no-tag initial &&
+
+		head=$(git rev-parse HEAD) &&
+		for i in $(test_seq 100)
+		do
+			printf "%s commit\trefs/heads/branch-%s\n" "$head" "$i" ||
+			return 1
+		done >expect &&
+		printf "%s commit\trefs/heads/main\n" "$head" >>expect &&
+
+		for i in $(test_seq 100)
+		do
+			{ git update-ref refs/heads/branch-$i HEAD& } ||
+			return 1
+		done &&
+
+		wait &&
+		git for-each-ref --sort=v:refname >actual &&
+		test_cmp expect actual
+	)
+'
+
 test_expect_success 'pack-refs: compacts tables' '
 	test_when_finished "rm -rf repo" &&
 	git init repo &&
-- 
2.46.0.551.gc5ee8f2d1c.dirty

