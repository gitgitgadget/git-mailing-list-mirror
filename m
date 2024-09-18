Received: from fhigh6-smtp.messagingengine.com (fhigh6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDF3017AE0C
	for <git@vger.kernel.org>; Wed, 18 Sep 2024 09:59:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726653580; cv=none; b=nf90eScW71V3T9YFwUDLIZn+scrvENGaQvH6EwBTnhslVJsKv8TV+Lz99BFWCzrzAglCvB4XsQh3QXs9C735v54JGQH6Og58v9MoRUfnTGaGSsRgIY9sYlecQhld5or87J7f/ClnUalGgOU8CN5Eu0OFmce18VYgRG39e4gl8aI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726653580; c=relaxed/simple;
	bh=rX69GNu/VuXRnl2fD04QhRWxMnOE/m98dmtZ8/6xaxU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UGZNKEn8el04vMlHTElNzPPUvhzVnmmFdhNXGdsMt+sKa1XMglkJrE9xt1lXoqGwSX3BP+gBxVkg4uDtS3LPBj8lsLSwvAUuUlRD7Lo+GHwn0zzUG7fgSfB0VEsGx1IBD1kNtqzL6v5VFg8KZjn7MGgsjotWHVJWmE/+MskxDgM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=tTsrXZAB; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=AIuA8Dpe; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="tTsrXZAB";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="AIuA8Dpe"
Received: from phl-compute-11.internal (phl-compute-11.phl.internal [10.202.2.51])
	by mailfhigh.phl.internal (Postfix) with ESMTP id E97491140105;
	Wed, 18 Sep 2024 05:59:37 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-11.internal (MEProxy); Wed, 18 Sep 2024 05:59:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1726653577; x=1726739977; bh=Inh0ixxUlX
	AJDUcsFWk1eb51WK+4Yjh7AnLuc0SH6dw=; b=tTsrXZAB2HW/fZY2gYAKnrcj8i
	cmFbY+YtIE557aKnj/6XoGPE4mJ7uwsRhT2tHI4vvHxtavneBrt+ouoynTxbA74D
	9OOQKZgcdai+s2/rV2J55nzBOzNFuHSYbQ52u+M1gtkUF2E39opWD5EZAd38jeP3
	dJyeJ6mD5csnOzf7GZgK2/cQ8fgOiOfHtNNddzSQon+mJoTEGh/Q7igFUNXzTGYn
	oC+JjJDKC2Mm0+lJLaDeTDwEls3tmvE7eo17CO11K+yxPzPZDf6C+1krIT7RGpLx
	ej7MBSlCsc1d1hnGPZxNOGL6cHgyDP2molKbVfVCoP8szkjIDujsTiP1qurg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1726653577; x=1726739977; bh=Inh0ixxUlXAJDUcsFWk1eb51WK+4
	Yjh7AnLuc0SH6dw=; b=AIuA8DpeU/3KLUv/gyn/5LKbwnpHwaOnanS51Ct5NU3e
	OoB61pvvNROqnihBQpHOW8t5Mxf3UJhovvjMZK+DeyAUyDerjFlHpZYEUdzoYnBM
	BiRBLQowcZ42EFzF7tMbeS9ijOs0GLHXb2AvvBrYCuytGEhadPfNPSTmqz1EX+uq
	5KHsOc62x7ZTsBQrfjCO43zDkG7Y8qFvRYi6y+E9VMgga9wNwcaXo5xnzCW3c/at
	9Qd1r3v5ZWruBIC4xGzxmj8PhKC/ENQv/O8I/TXNURmRuqvMPjby06riXKw7kYgS
	0g2IIoWj5IhHUV1X8sECyd8XaYdTW1SPFaT7HDpsGA==
X-ME-Sender: <xms:iaTqZouf3gVCxSg-DfCXDmnL3kYEpaKGWPjP6c8Ujgnj2Nmn8_uMCg>
    <xme:iaTqZlfsOmnXlYYGE_pYHNz2AnKok34I-TnruTNMaN-hK6GzLJefqAl0PsYM5mQiO
    h4Kxb8yeeE1PqHN0A>
X-ME-Received: <xmr:iaTqZjwjAQgQbG_pCGn7aSYuOhy2s0iYHzwLqYhjWGMETMUgKzDYZe9okzqlgT3n5DvjNVeKKoWibnmvIxVn3cR9cdrjBWyMKbCauHtRZMUrfMCd>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrudekledgvdduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefgueeg
    udfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepgedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepjhgrmhgvshesjhgrmhgvshhlihhurdhiohdprhgtph
    htthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepkhgrrhht
    hhhikhdrudekkeesghhmrghilhdrtghomhdprhgtphhtthhopehsuhhnshhhihhnvgessh
    hunhhshhhinhgvtghordgtohhm
X-ME-Proxy: <xmx:iaTqZrNUVzbxJjc1VpwvMMHgcZ_KhVUNeIES_rv0RCLxvLcTex74bA>
    <xmx:iaTqZo-mjySMt-HeVdlHvfSYGati8VqlYvoPcW7dVfS3nN-2IR1h2A>
    <xmx:iaTqZjUBia-GG8x0-GwhFsIHnN4Em7aoaHZNT3rgXr1GhtFmArrqrA>
    <xmx:iaTqZhez5FkAg_ufoKKH8p9hipzNnLMVRYRtEOz25mqsyFINWWJHBg>
    <xmx:iaTqZsbt-iFSYsarFToLMzg8-63dCiEpp5mB4wvlj9wAnOb6eA6haaIC>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 18 Sep 2024 05:59:36 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 979992aa (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 18 Sep 2024 09:59:15 +0000 (UTC)
Date: Wed, 18 Sep 2024 11:59:35 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: karthik nayak <karthik.188@gmail.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	James Liu <james@jamesliu.io>
Subject: [PATCH v3 3/3] refs/reftable: reload locked stack when preparing
 transaction
Message-ID: <25d4e513a368a0787b6f78466f85a3155ca3a740.1726653185.git.ps@pks.im>
References: <cover.1726578382.git.ps@pks.im>
 <cover.1726653185.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1726653185.git.ps@pks.im>

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
index 6ca00627dd7..efe2b0258ca 100644
--- a/refs/reftable-backend.c
+++ b/refs/reftable-backend.c
@@ -770,7 +770,8 @@ static int prepare_transaction_update(struct write_transaction_table_arg **out,
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

