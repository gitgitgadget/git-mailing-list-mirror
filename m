Received: from fout-b4-smtp.messagingengine.com (fout-b4-smtp.messagingengine.com [202.12.124.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A965B26ED3A
	for <git@vger.kernel.org>; Tue, 30 Dec 2025 15:04:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767107073; cv=none; b=MBL4ARluHErz317JaKNOXwW2PziZbDMZiBYVF0Ac9cPFbhkBrQA2h2D7E3AladxocZlpgkWTa5YfZ7GK7K7pcrlH78dgd5iW6R7nxU+uX99QsHCpIf74QC90jlars4ESmmmm7aCYd1jBbG1lNymRDGs0gUibS52EqxsNz3f9cPg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767107073; c=relaxed/simple;
	bh=rHk+bhmGCg+0/64NvsEa7EfZhL4PeQgvTA5HraZm0Rc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dAVIqMcYZCwHdlO84t6JzIY8XMk+CNC+G8UepkaQOdkupBfsmrmRz5FURoIK3R4RsYrmem1Ce8Y679YP6krhFXUHfriem7mhSzn7ldjs8FoSQRV7V0kC5K1Kj4KtfvYzi54lXllgrRThH1IWDNpxI5XiWzu8YA4j7nrvQca7GSs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=LBkPH541; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=eTRfYEiL; arc=none smtp.client-ip=202.12.124.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="LBkPH541";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="eTRfYEiL"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.stl.internal (Postfix) with ESMTP id B79511D00067;
	Tue, 30 Dec 2025 10:04:20 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Tue, 30 Dec 2025 10:04:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1767107060;
	 x=1767193460; bh=mj9/P2it8jLU3YLHyhk920Rd8npHFBCwxD/7gsD0v8A=; b=
	LBkPH541O97vMjUGcnkylLEhls5JoPMpATIJJc4ZrgcSc5LKvgEWl/vPQss3cTWE
	W3g/UOeFCifUrX3Nk5JEQEuPREbDj6RK3zgwOp5l7WQAVgMhR51S68kEG4qE4tal
	pe6+tFdBZV8Ovi4Yf2f7t+kfB/5IPIHaCUAq/IOJzTNllDgIhtxRxd5mqdaFddE6
	UpyMse9xs6JM+Ov/B2NzPpD59IY/rBplRVoYg7YZxRH7EQF3pEikTG+QzeNUm6JC
	hCfYRK96jnoHHUKEW5XWt0EyR94VUIKVVgupo/mhPX54W07OzNXcGtfJRvFyXzhB
	LUZ6ZIRBBisV9U3u8GlraQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1767107060; x=
	1767193460; bh=mj9/P2it8jLU3YLHyhk920Rd8npHFBCwxD/7gsD0v8A=; b=e
	TRfYEiLTSmtmLdEzqmgqtycy7lgFHX+vcHD0VlfiPSPLQAcJKGT6Kh29w/WGur3V
	bpn3m3tWzv5uz1AFy78/PuQGdy/Uap8I5VMykTwRxCvFAAhwV25/yyavItk8kjBK
	KrwNxbwyyPzAfVMdiOcSU1lrQks6BsHFeQ0goMnHFGCYaCgm1NHQxfzuurkosG78
	oWkEqDlckh9nd/yjzLlmkGDdZlTn5Exd+Z5sgM7dSBPvFDFif6eqv3rExn+IEu1M
	x9Ou7RHdRriP0dRqxWz/AspDDBpMifEZzyoYDbfG6LDxh9lHCrEXkEe124wrdXaZ
	BSKBYuQgsS8NUL7y+z1kQ==
X-ME-Sender: <xms:9OlTaSTX_nPfDsG6soAUolbT0GZmd0QKbxwkMBKm2dB8-PAwX5cdj7w>
    <xme:9OlTaRFi6ckd6uBqySK_pKuqp1ifo1VZJFVeY1VIHg0vnmRcWiWij4GEmS-bFoHLz
    mFWnBj_zWC_yqrY76ud3Sooj2LM2uKX9eIqHWXUtJoktXhYRN79LA>
X-ME-Received: <xmr:9OlTaXHWmzJJ22JAAb5YsloNdxYQLoLfYAYqshy234ohEUqRZqeYVYPzQDEnychR_jUMB_lmm8TQqNDMEf1B-1s-xEKqjQ4Eekr4rjBEXPjvyGhQmCUCbz4>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdektdeffecutefuodetggdotefrod
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
X-ME-Proxy: <xmx:9OlTafTyX8wGB7cLFjDfhkYGQraCdPfzYHEuQ7bJmEnREcGn-aTe1A>
    <xmx:9OlTaYIgGth9tOpEXkrQoriuwL9QkdnCqWZzEWD4S7zzf3OP5ksmew>
    <xmx:9OlTaaan-i6YlEhcEqT2tXgsWBUGPjZZerRGN6cunRIlLsMo9ay6vA>
    <xmx:9OlTaa9hpJ8yaHepaGsFNhy_TF_Jyy-ixVuQEVH2yac839TvIcUp_g>
    <xmx:9OlTadaji0B9xoAJHAt9-5KO0_Wjnt8qjf4DhFufwyVUsoefJ5apKXg->
Feedback-ID: i8b11424c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 30 Dec 2025 10:04:19 -0500 (EST)
From: kristofferhaugsbakk@fastmail.com
To: git@vger.kernel.org
Cc: Kristoffer Haugsbakk <code@khaugsbakk.name>,
	christian.couder@gmail.com,
	newren@gmail.com,
	Siddharth Asthana <siddharthasthana31@gmail.com>,
	Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: [PATCH v2 5/5] t3650: add more regression tests for failure conditions
Date: Tue, 30 Dec 2025 16:01:51 +0100
Message-ID: <V2_replay_regression_tests.180@msgid.xyz>
X-Mailer: git-send-email 2.52.0.10.g08704017180
In-Reply-To: <V2_CV_replay_die_descr.17b@msgid.xyz>
References: <CV_replay_die_descr.13f@msgid.xyz> <V2_CV_replay_die_descr.17b@msgid.xyz>
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
index d4399aa1662..c0c59ae6938 100755
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
+	echo "fatal: replaying down to root commit is not supported yet!" >expect &&
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
2.52.0.10.g08704017180

