Received: from fout-a2-smtp.messagingengine.com (fout-a2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1008415B56E
	for <git@vger.kernel.org>; Tue, 24 Sep 2024 10:05:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727172349; cv=none; b=EJjus9yAF6MHVclg98nEg57nXve2MC1+xSwcA2PRMIN37APxkE1gsUAHkpPkxuNbmGrANwKcHGJDco7QN5TbklQVvJiolTcLubyekRjtR5PKYhITxBXrqwE3Db9bTHaDL3cXqNmDECE7ZXOQPJckP83ptswm375fqOvLC7mQg58=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727172349; c=relaxed/simple;
	bh=797gHGmJ5D7n1W33zUC5Xg+NuyHpNu/v00qRQjIYjG8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=U4oLZj1n5Az4tdTA9crjbeGVNWmdX6Hd+C++Ru8FRrsNd73e0AV6FgdlYwQAE75WHNKXXGf0EkV94JdN1tIUvJLYaebaFxd/rgerLNnIoAGxfrIw0lGy5KxyBiXxv6MATcQkFvJc5jSgBfB0Ry+BP4/C86TEpOCfquWfPOw3NQs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=Ua8c3/jd; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=cRxRvfDr; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Ua8c3/jd";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="cRxRvfDr"
Received: from phl-compute-02.internal (phl-compute-02.phl.internal [10.202.2.42])
	by mailfout.phl.internal (Postfix) with ESMTP id 0A1D11380438;
	Tue, 24 Sep 2024 06:05:47 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Tue, 24 Sep 2024 06:05:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1727172347; x=1727258747; bh=ZoPttUzQAV
	SkcPR1Azu4S5LymvkpVTe4/zFvY0s4wIU=; b=Ua8c3/jdCS1XkvAxf2Z6yqXXk0
	yG9Hwr9KWMup4FIsTcBeSUhZFMuAfBwfbXiDrfxDcPLOzQXNiP4rGL5FrJ6F1Z4q
	R+hEEwa0awbWTAyVcf4xvuWShh8QjJ/SyptwD2Tz8ez0PMYQQHJXI1/nwu50QBlu
	At08uGfegqRuNp7ba4vuAl7VAU0n11MZ1Pb4ebogFUzX3dnKmMZZ66bReZrcTRpJ
	3SdDWsVu5woF601aYGiXUUffCg8JznPtT2dlGhHARlgs1uLFcFK5jt4NM/NelGsD
	BpCL1vGw/7HGqiY7dOmim0OKND2IJZfFx9M6Vny9Nv7u8GOcoVLiss1lYu1g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1727172347; x=1727258747; bh=ZoPttUzQAVSkcPR1Azu4S5Lymvkp
	VTe4/zFvY0s4wIU=; b=cRxRvfDrcMAQgMfl5MOGktxPC449Dwfr2dlE1UbOUvLl
	LBPWzn8w3hzP3/pZzwzSJ+7GVc/Gdua1XNNXe2vivFqzB8Jm/KVcMdXtNKRltIPl
	K9aHTzTEspdYygmbwbulmRmmMYER5hcxBFZnaSi6Yv9q+rbYSPVwNGKXdlIYCHQ/
	zIHjKCV5KNddUyoMEaKD8OwzKwO+ReGttQEPCC3HY5Y6NfNfFoOL68UZ7SAxA3MR
	GdcJ0wZWRcK+duvpoaqXwG1qvqmTxobAS0S5MtkClY6W1Hrv++rB21Yj6WWdaRwP
	UBGKIe/UIz4ls9XPgEPd+WXMuPM5dbGzQYVvCfjUfg==
X-ME-Sender: <xms:-o7yZovwqdOq6IrxSsp_HVGjzcvH9m6-iqA9OWVbq5iyRs2UZsSvhA>
    <xme:-o7yZldpkl8eyS6Lc6EfNAE1mkicIpo8I-7S0ObJFNgAiA8YJlQeF9llFGZ5CC6Ze
    Ibwt4VwY0q0rhWWdA>
X-ME-Received: <xmr:-o7yZjxcj8EXlEq8vk6kYBIrn9uScidCGYZvxodSY7Esqig5yl9nJKqqYWbbTXFaMtdIyidOuzsaUc1j2fBKmmKPs4lMAcv2siRurn3VyBvyqw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvddtvddgvdefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefgueeg
    udfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgepudenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepgedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtoheprhhonhgrnhesrhhjphdrihgvpdhrtghpthhtohepsh
    hhvghjihgrlhhuohesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdr
    khgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhdrshdrrhesfigvsgdruggv
X-ME-Proxy: <xmx:-o7yZrOZG4uoQzGg_g-FUI5hx5cy8FXCOS9eiIHuEQtnBdgPv4HY0g>
    <xmx:-o7yZo8HHy4A3CVQEXxMrWNsmHigX67R5_Jr9vwTd_j4o805bYk-7g>
    <xmx:-o7yZjVOu_4n4EB7ijb9yCfMJ1Oe1jjjr3qEsbrVQhXBlkPBgvK4Xw>
    <xmx:-o7yZhd8fT9-5HNMjrvFCg8b9ScP1KAPY6K7N0NoLDfVHaj4bxqLwQ>
    <xmx:-47yZsbWg6w6WWN4dR8wp0MPI3Ux7az-UEzCcKUaHkiy9IjPWUEE-KMw>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 24 Sep 2024 06:05:45 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 6636831a (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 24 Sep 2024 10:05:12 +0000 (UTC)
Date: Tue, 24 Sep 2024 12:05:42 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Ronan Pigott <ronan@rjp.ie>, shejialuo <shejialuo@gmail.com>,
	=?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
Subject: [PATCH 1/2] t1305: exercise edge cases of "onbranch" includes
Message-ID: <615df98339e9451bc237decea087716ca15d157d.1727171197.git.ps@pks.im>
References: <1b9fb3f3fde62594b9ac999ffb69e6c4fb9f6fd6@rjp.ie>
 <cover.1727171197.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1727171197.git.ps@pks.im>

Add a couple more tests for "onbranch" includes for several edge cases.
All tests except for the last one pass, so for the most part this change
really only aims to nail down behaviour of include conditionals further.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 t/t1305-config-include.sh | 40 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 40 insertions(+)

diff --git a/t/t1305-config-include.sh b/t/t1305-config-include.sh
index 5cde79ef8c4..ad08db72308 100755
--- a/t/t1305-config-include.sh
+++ b/t/t1305-config-include.sh
@@ -357,4 +357,44 @@ test_expect_success 'include cycles are detected' '
 	grep "exceeded maximum include depth" stderr
 '
 
+test_expect_success 'onbranch with unborn branch' '
+	test_when_finished "rm -rf repo" &&
+	git init repo &&
+	(
+		cd repo &&
+		git config set includeIf.onbranch:"*".path config.inc &&
+		git config set -f .git/config.inc foo.bar baz &&
+		git config get foo.bar
+	)
+'
+
+test_expect_success 'onbranch with detached HEAD' '
+	test_when_finished "rm -rf repo" &&
+	git init repo &&
+	(
+		cd repo &&
+		git config set "includeIf.onbranch:*.path" config.inc &&
+		git config set -f .git/config.inc foo.bar baz &&
+		test_commit initial &&
+		git switch --detach HEAD &&
+		test_must_fail git config get foo.bar
+	)
+'
+
+test_expect_success 'onbranch without repository' '
+	test_when_finished "rm -f .gitconfig config.inc" &&
+	git config set -f .gitconfig "includeIf.onbranch:**.path" config.inc &&
+	git config set -f config.inc foo.bar baz &&
+	git config get foo.bar &&
+	test_must_fail nongit git config get foo.bar
+'
+
+test_expect_failure 'onbranch without repository but explicit nonexistent Git directory' '
+	test_when_finished "rm -f .gitconfig config.inc" &&
+	git config set -f .gitconfig "includeIf.onbranch:**.path" config.inc &&
+	git config set -f config.inc foo.bar baz &&
+	git config get foo.bar &&
+	test_must_fail nongit git --git-dir=nonexistent config get foo.bar
+'
+
 test_done
-- 
2.46.0.551.gc5ee8f2d1c.dirty

