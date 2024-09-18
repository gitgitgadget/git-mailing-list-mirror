Received: from fout6-smtp.messagingengine.com (fout6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0C6814EC5E
	for <git@vger.kernel.org>; Wed, 18 Sep 2024 04:32:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726633954; cv=none; b=XQYRSgtfcnSolODL4pw4fsehgev3aYsHvEOFpxNEQFAxiCAoMAJia2tWVg+KHv+NczO05A03e+OmveYTdpOGsf1KIzjwyyvDcpjHMWGZ780N6LNNilHf6oLf8CjiwKVnw7krmAn7uvjBz1QgnRaffPspmQRnC0Lf6sPuCK6Y6SU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726633954; c=relaxed/simple;
	bh=RHitIEb/5n75CChFBXAqCBWPZV24bdF03RupSs+mmsI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sVDSVQe8BGixtCCzasF/mD7YKou1/xzG7MfbW3kGkvMmiY9sf537Wz3p4M4JP3z/BMfUbXpNptOr/cnqgiZqJs1sz76yGGuYrAihOl0utXcOJ4/0Bj+dKupJ9EvcNgLr3G+njzP6LD9AoXOfNTl5A3bxDEejTuF4wX8n6zrKBUY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=BRjClIZU; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=oESOeKBl; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="BRjClIZU";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="oESOeKBl"
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfout.phl.internal (Postfix) with ESMTP id 0A0391380237;
	Wed, 18 Sep 2024 00:32:32 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Wed, 18 Sep 2024 00:32:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1726633952; x=1726720352; bh=zOCNGARfiC
	rCzliOjcu2ZOL8/DoZFs+d0RdtY6maxf8=; b=BRjClIZUU/FNmfTuq3vu4tCVIp
	AEwV5nE/a1p9qyrNqsoELxDMPZIr3U0CIsEg+8ObpGgqAJnnbmmZgtq/E+WutBho
	EoY/BUAz9PIoQ93ryKmksX60BDNYA26LGicMCh8QM5FhjRaCoBxkuDOlZhuc3pOi
	xorkPeiYb86KMUDGDYoP1ShEmwIw7x1CAUeKp5BO5w3WyqEZkoZioo6JvviPrNEh
	NY1bR19Ab2gJMa3XkNPda/zRf5pi5XUOusxFxL5d9eTiMsOCgTl58RD5ZF7G3wpJ
	m4WT8p2LDAzw2lAmjwzWFb68w09iwYITv6Aj4oYP7HBpRel5KPAA0PhoVhNg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1726633952; x=1726720352; bh=zOCNGARfiCrCzliOjcu2ZOL8/DoZ
	Fs+d0RdtY6maxf8=; b=oESOeKBlLh/3gfSML039CK7kU2taNeE/c0VwTPutgEp9
	iibBvEs7igyFBrYWwIsVuWHuYLybrhG/7ua5/pVwYl2WIbZEyjN4d9W854ZOOuVu
	iDGoG/xyJDdW6yDmde8jaSGtsfgPB2cyDKfRdhqG5UgagcfBHPYwA7oybCLFysx6
	YBlL9RRXCmUIIEiI8OgJ8XMC5mSDHVOk7ZQUalmMz8+900FGzMFz9arI0Cngtc7U
	nVO/WtwMxkIvO13BxspYjPjXCZUxBaQAqbwWCgXRPd1abN9T8SChGl7lmNOtLF/G
	my8O3F9i2+Ym7SSExpQdd9+qV0aIi3svpIKO+dOIJQ==
X-ME-Sender: <xms:31fqZqlcloBjU36d6pRkphOkLX6x6wgefn2XBgGu-2A1vBPddeICtA>
    <xme:31fqZh1mBxlaR00uroSBWNOhTMMQyTh9hXz-bi-b0eNAfKX7ErTdxqifHMr6coB-u
    2p61ShGp8E1iFha7w>
X-ME-Received: <xmr:31fqZorgAI6eSdxTsBe9ERzSjKHjysDQJ9uMVNdjiDAU68og-kIZT31_8JJhIACe10dmJPt-mXNWjFkHyt6D71OL3iRostBOXLTh3_gH7OG02Z6p>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrudekkedgkeehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefgueeg
    udfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgepudenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepfedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprh
    gtphhtthhopehkrghrthhhihhkrddukeeksehgmhgrihhlrdgtohhmpdhrtghpthhtohep
    shhunhhshhhinhgvsehsuhhnshhhihhnvggtohdrtghomh
X-ME-Proxy: <xmx:31fqZukCNzDRu4ripJhjJjLwU4q7NBKSyYmUriaebeX5eNfphVRTUw>
    <xmx:31fqZo1XGe1NDhGoUiU-Afa5iTH96osmsdBL0zGz3v7QJAyAfXfZlw>
    <xmx:31fqZluRVTXELNpXoTAPz-OPdoTtuZxcYBcD2SaASQg5DXZPmqhGjw>
    <xmx:31fqZkU3iPKRw8235ZNQDhklSjt0vqwXs4KjFYoxeon0hqW241sBXQ>
    <xmx:4FfqZlynHnLWlooXMK8_LfinmkycYNOMWZaLP6W2ilIEuqvzdATcgrWe>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 18 Sep 2024 00:32:31 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id bf579514 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 18 Sep 2024 04:32:10 +0000 (UTC)
Date: Wed, 18 Sep 2024 06:32:30 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: karthik nayak <karthik.188@gmail.com>,
	Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v2 3/3] refs/reftable: reload locked stack when preparing
 transaction
Message-ID: <111b497ef17340c71f6c009a6c4228f45c5f1322.1726633812.git.ps@pks.im>
References: <cover.1726578382.git.ps@pks.im>
 <cover.1726633812.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1726633812.git.ps@pks.im>

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

