Received: from fout-a8-smtp.messagingengine.com (fout-a8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7E022E859
	for <git@vger.kernel.org>; Tue, 24 Sep 2024 05:33:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727155995; cv=none; b=DDA7pus70t4H1yudf4m0useu9QpyjFnF/fJ1tQDYErIfXWlW6+UaNiRMPvAHYj7VJ0rZTh3jcEcRJS+6OKbaXji6vnZ68kNOSqRzYTyu6ZMg9uV1E7+73mWbgUWQBdZfh4OYqQYZj5WniztqUoLabaok0qRe5GCcwd6nKQwZkD4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727155995; c=relaxed/simple;
	bh=rX69GNu/VuXRnl2fD04QhRWxMnOE/m98dmtZ8/6xaxU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=c9Ph0UwKLdUsjjkpKTsnK90RXa/1fvH0E1JRIT/uWnPVBrSHm1elF0y4kpJ2aj2SDp8h5d+juSew/TsJONFSrVxv9PeAV39Zl37yyjGw3EbtaE+g6u5zKDNOUo0YkPzPINDpwpRqMcJ5S0F468uCKPDjv4rbqhAET3avnlUpxws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=mA8C7AQc; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ebtaf1r+; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="mA8C7AQc";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ebtaf1r+"
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfout.phl.internal (Postfix) with ESMTP id 025E213802E6;
	Tue, 24 Sep 2024 01:33:13 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Tue, 24 Sep 2024 01:33:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1727155992; x=1727242392; bh=Inh0ixxUlX
	AJDUcsFWk1eb51WK+4Yjh7AnLuc0SH6dw=; b=mA8C7AQcAyUXhg4bBzsfdI5DKo
	nhW1Nl399Rzjk7EvTKdobUqkM1mz6JHYyL9nXkf2zebUUeBF0RpMAGetilaUgb/U
	waPUL9K8w5BXVAxAJYYBNGrrAUytIOCTNx+AqQ3JDunSbfRo/8BR3GspbRB5+HMu
	S0Vp5oLEfDfXzVTBPIzGLS1C7ZWauQP2Gi3z+5a+auXl/ceFSrUh8sT2+mpxdYov
	TabkcJo/eY6zgQh+vLrdfQnfXElVAdNkiiOmnUiomJg337x/iK4trX5Van9NaLZY
	3ynoY70jH5QQL0cQ5Om/zXajdC1OFa37heFRpnTy2JeUISkOEs4D3YYVy1hQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1727155992; x=1727242392; bh=Inh0ixxUlXAJDUcsFWk1eb51WK+4
	Yjh7AnLuc0SH6dw=; b=ebtaf1r+wCQMmtcJlveTLNDmrDODDfsPelx6+ULUJf0k
	RM7zQ2vZDWZQkNWCzt91EgzjNKtbKyO7l/PNdSGn3VShDes5LO09N00N2S7sVcKO
	xE1R6XS+SfeUa5bgL6H6k1FC5wZFBWHPDQGKb0mDZDx9sfz0TPuToftK9gfgn/wj
	OJFCffTPscW1E4D3j46ZoAe9rh4SZsRocA+ZpHrDfDba+Ykm8/3dTeDOGi3wa8rB
	gU2fraX1coguSx4VHomcImGuvHi5YrkzNMmW7FogCfPWs0jTHGzz7RJ46+75zUJP
	QWcunvNNep0BMyo5e0BAyR7yljuG+ZhPCMt2yKs8CQ==
X-ME-Sender: <xms:GE_yZstXuHLZChLDZdPrbHF1p7T1HD4oAC-yGm07wwF_kr6cQnsfXw>
    <xme:GE_yZpffd7gZzsT-qrLnV9H4yU0SJqkBpqI2fFUqUEENg81UyqmXj4Tbw5Y7-F7_P
    kvKry1YBq9ZLMB-zA>
X-ME-Received: <xmr:GE_yZnw1gEZPMEFX9lReDG55BfWOOaeH9UjC3jCMuj8L6FUU0MsWnwWgihjekNfQbYn1Dz3WZ75ZyTAnvozPEfnQSvyjmAkoY6PBqgCFp8F2rA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvddtuddgieehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefgueeg
    udfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgepudenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohephedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomhdprhgtph
    htthhopehsuhhnshhhihhnvgesshhunhhshhhinhgvtghordgtohhmpdhrtghpthhtohep
    ghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehjrghmvghssehjrg
    hmvghslhhiuhdrihhopdhrtghpthhtohepkhgrrhhthhhikhdrudekkeesghhmrghilhdr
    tghomh
X-ME-Proxy: <xmx:GE_yZvOZ108Fif_L_9_KZJZ8ueUKKiaTGga506GkToN_H4UlkNlPTw>
    <xmx:GE_yZs-iZJXY4AX6_NwgXm4W1dT5Lb9qG4-J2NCglH_QNy9w04fKvg>
    <xmx:GE_yZnXo2R-lrB-_OL4FCWiZkQyUDibwGPLiUbMmAFmpEMo-9VtjyQ>
    <xmx:GE_yZlepGovEp4oflR9k6jrY-Ntarxy3jdmzuEW-eaVgtrdoZBlbcg>
    <xmx:GE_yZrlYGURtgbM3c6i8lJXH51gxYB8NXXbLP4nFkN402h3-dFYpXXPj>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 24 Sep 2024 01:33:11 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 4c150322 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 24 Sep 2024 05:32:38 +0000 (UTC)
Date: Tue, 24 Sep 2024 07:33:08 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: karthik nayak <karthik.188@gmail.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	James Liu <james@jamesliu.io>, Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v4 3/3] refs/reftable: reload locked stack when preparing
 transaction
Message-ID: <9ce2d18dff2a655365b609dd86ea484a489c717a.1727155858.git.ps@pks.im>
References: <cover.1726578382.git.ps@pks.im>
 <cover.1727155858.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1727155858.git.ps@pks.im>

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

