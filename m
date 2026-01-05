Received: from fhigh-b8-smtp.messagingengine.com (fhigh-b8-smtp.messagingengine.com [202.12.124.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8A2E29D29C
	for <git@vger.kernel.org>; Mon,  5 Jan 2026 19:55:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767642940; cv=none; b=IF6E2K5jVymSyKYeCufSIzB6G0ci0AT7RVLmsImi1L5anbJFZLsEaz6Z0jPDZAgeVtRY7r531CKxcuio8FnT7UZpQpYPgzZIeiYtOhShlWeKTqx1DL8MHr7m2K8AV1ApJOC0cgcy7F5w6sMMXZFuAcX/1333knJVkoDe4hiiuWE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767642940; c=relaxed/simple;
	bh=WTAnjXYO5eJucrXcXMS5MfSjkQRr7i0ac/msAcnSNgs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mMNAhtdN19fgnHkcKQ2Y3UQDNxBh8a35zB6WQynQxOrsgMHOrYh4WwpUSmLDDxxy02pzxFuQ67VGeBStJ1Kp5MlUD45uiQ8mZmldjc4rqSz5FP5EbtOtvRrPnhpadORSojDrcRuwl1L0RxaBSKUdjF2tXjPL7ncAlCqtPbT+dUQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=CNoIO7fB; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=XUa5qv6e; arc=none smtp.client-ip=202.12.124.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="CNoIO7fB";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="XUa5qv6e"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 0AE2C7A0092;
	Mon,  5 Jan 2026 14:55:38 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Mon, 05 Jan 2026 14:55:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1767642937;
	 x=1767729337; bh=/kc01SxU4r6zIVnhs1KAh4jIQ+r98gpJxuGd1L/sVHI=; b=
	CNoIO7fBrpwAcNR2xAPDU2PXzaf0PUYlt/URK7BETxoIvgsbXcUIEBjqzV/E188z
	2yegewVGoBJuqvUSArS6A/XMHFM1PqISTvlZo767SjS3YHDUYPFPL7m8KTAT5vFH
	Hfew2tKxdXf25JltLmmCkztZ63TTY2Y/yYH1eBGre480wZvrOFPxasydUn6J/Yv+
	RiQu23laJes7WZlNOYQ/4YmRL7WqJRIBStgeRcWsgAyRJ1AFqRr/8wypQuVJSbP+
	lJDRxLTGaHLK1hNY9rvwWr1Dqw7LoXUK3SJv3M6dUmUNsz86O8rWdnOXJVSC+vDG
	ecJQ7qbxBQHElesfXqKgmg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1767642937; x=
	1767729337; bh=/kc01SxU4r6zIVnhs1KAh4jIQ+r98gpJxuGd1L/sVHI=; b=X
	Ua5qv6ee2ubYpDPIDh6XOrmZiJTFYRiZ+/SMYf7txTB7lI8OggNyPtr6wTs2nZuF
	phlr2boelcA7vtvw9n+zZcqXfM80/LT9RIPp/WBouE1OZ3agjP4lIr5CmsxxxnlL
	tLgHzLQ1GhSIqEDxPabBoJ0SPE50LXkV8K48/Qx//Zps3zQNMRzKnej3QooFcoaO
	L3L6vl8v2gb+8M+92tuDsF1f/ETku6JVkq6XrnwcqT/oPCJsOZDXzMjYbINDOTQY
	DMI8KB29jV/CkPf0BE5hEim2dSm/6SOZsY2iudiF5HsHmj2MtQ+jTqeXKFT8PTIO
	DHqdmrDgzBzuSqblK/rXg==
X-ME-Sender: <xms:ORdcaeEMpa2AXtmGNjlkpr1lKcKb2byLsjQZwzUpr4dsU7pbsgUZ-_Q>
    <xme:ORdcaYoRMhqECvrfvsKjETUuchZfqAA6khE_EeHxsxWwX2mWZ2ymSYQoF9AFezPBL
    GbVB8Nn6jv6xkhsplcQlH5rDrcliZOzOwNgKovse3gtlbxzCktMyQ>
X-ME-Received: <xmr:ORdcafZCwWB1J8GY_8vHzPeRCg5LJ4Bmabkq0nkPcSuMscYmrHk57Cr86ERtgzhsoJC7FnvmluJ0IDeaKb4ftrduGfnu0ybl4TU04M-pFGzNLP4CFREEyXrOwQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdelkedvtdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenfghrlh
    cuvffnffculdefhedmnecujfgurhephffvvefufffkofgjfhggtgfgsehtkeertdertdej
    necuhfhrohhmpehkrhhishhtohhffhgvrhhhrghughhssggrkhhksehfrghsthhmrghilh
    drtghomhenucggtffrrghtthgvrhhnpefhgfeglefhjeekgfetleetjefhteeiheegfedt
    udduffegjefhkeetudeggffhkeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpehkrhhishhtohhffhgvrhhhrghughhssggrkhhksehfrghsthhm
    rghilhdrtghomhdpnhgspghrtghpthhtohepiedpmhhouggvpehsmhhtphhouhhtpdhrtg
    hpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopegtohgu
    vgeskhhhrghughhssggrkhhkrdhnrghmvgdprhgtphhtthhopegthhhrihhsthhirghnrd
    gtohhuuggvrhesghhmrghilhdrtghomhdprhgtphhtthhopehnvgifrhgvnhesghhmrghi
    lhdrtghomhdprhgtphhtthhopehsihguughhrghrthhhrghsthhhrghnrgefudesghhmrg
    hilhdrtghomhdprhgtphhtthhopehphhhilhhlihhprdifohhougesughunhgvlhhmrdho
    rhhgrdhukh
X-ME-Proxy: <xmx:ORdcaZWlanIi5NIr78YanMWkr-e8IbV62lSDJFjwhdxXfbpFbo2j9g>
    <xmx:ORdcaQ_VkHFvtY9qskUaiXXwSsIIo5P5Uws9mfPgJZM6ffz5Xke54Q>
    <xmx:ORdcaa81uORD6Dx9j2hc_O3JxHTTwoLFVipxzWyNSjue-ENAwg_PMQ>
    <xmx:ORdcaYTxQQ05EHoVj_o2uvtjtpRg5I5hVYmYmhza8xqSTw55kdVVhg>
    <xmx:ORdcabML5fFTfC-9ASLvd2gIbVArxe6FrI7vj4UJkGa4MJPqN-IOwifc>
Feedback-ID: i8b11424c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 5 Jan 2026 14:55:36 -0500 (EST)
From: kristofferhaugsbakk@fastmail.com
To: git@vger.kernel.org
Cc: Kristoffer Haugsbakk <code@khaugsbakk.name>,
	christian.couder@gmail.com,
	newren@gmail.com,
	Siddharth Asthana <siddharthasthana31@gmail.com>,
	Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: [PATCH v3 6/6] t3650: add more regression tests for failure conditions
Date: Mon,  5 Jan 2026 20:53:22 +0100
Message-ID: <V3_replay_regression_tests.1aa@msgid.xyz>
X-Mailer: git-send-email 2.52.0.383.gb1c58d6b301
In-Reply-To: <V3_CV_replay_die_descr.1a4@msgid.xyz>
References: <V2_CV_replay_die_descr.17b@msgid.xyz> <V3_CV_replay_die_descr.1a4@msgid.xyz>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Kristoffer Haugsbakk <code@khaugsbakk.name>

There isn’t much test coverage for basic failure conditions. Let’s add
a few more since these are simple to write and remove if they become
obsolete.

Helped-by: Phillip Wood <phillip.wood@dunelm.org.uk>
Signed-off-by: Kristoffer Haugsbakk <code@khaugsbakk.name>
---

Notes (series):
    v2:
    
    Improve test `option --onto or --advance is mandatory`. Phillip pointed out
    that using a pipe loses the return value. Instead let’s test the whole
    output by just appending `git replay -h` to `expect`.
    
    Also “normalize” to just using echo/printf for the `expect` since these are
    just oneliner errors.
    
    Also add two more tests (at the end).

 t/t3650-replay-basics.sh | 40 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 40 insertions(+)

diff --git a/t/t3650-replay-basics.sh b/t/t3650-replay-basics.sh
index d4399aa1662..d10c01506f1 100755
--- a/t/t3650-replay-basics.sh
+++ b/t/t3650-replay-basics.sh
@@ -41,10 +41,17 @@ test_expect_success 'setup' '
 
 	git switch main &&
 	test_commit L &&
 	test_commit M &&
 
+	git switch --detach topic4 &&
+	test_commit N &&
+	test_commit O &&
+	git switch -c topic-with-merge topic4 &&
+	test_merge P O --no-ff &&
+	git switch main &&
+
 	git switch -c conflict B &&
 	test_commit C.conflict C.t conflict
 '
 
 test_expect_success 'setup bare' '
@@ -63,10 +70,43 @@ test_expect_success '--onto with invalid commit-ish' '
 	printf "a valid commit-ish for --onto\n" >>expect &&
 	test_must_fail git replay --onto=refs/not-valid topic1..topic2 2>actual &&
 	test_cmp expect actual
 '
 
+test_expect_success 'option --onto or --advance is mandatory' '
+	echo "error: option --onto or --advance is mandatory" >expect &&
+	test_might_fail git replay -h >>expect &&
+	test_must_fail git replay topic1..topic2 2>actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'no base or negative ref gives no-replaying down to root error' '
+	echo "fatal: replaying down from root commit is not supported yet!" >expect &&
+	test_must_fail git replay --onto=topic1 topic2 2>actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'options --advance and --contained cannot be used together' '
+	printf "fatal: options ${SQ}--advance${SQ} " >expect &&
+	printf "and ${SQ}--contained${SQ} cannot be used together\n" >>expect &&
+	test_must_fail git replay --advance=main --contained \
+		topic1..topic2 2>actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'cannot advance target ... ordering would be ill-defined' '
+	echo "fatal: cannot advance target with multiple sources because ordering would be ill-defined" >expect &&
+	test_must_fail git replay --advance=main main topic1 topic2 2>actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'replaying merge commits is not supported yet' '
+	echo "fatal: replaying merge commits is not supported yet!" >expect &&
+	test_must_fail git replay --advance=main main..topic-with-merge 2>actual &&
+	test_cmp expect actual
+'
+
 test_expect_success 'using replay to rebase two branches, one on top of other' '
 	git replay --onto main topic1..topic2 >result &&
 
 	test_line_count = 1 result &&
 
-- 
2.52.0.383.gb1c58d6b301

