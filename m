Received: from fout7-smtp.messagingengine.com (fout7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B740D7581B
	for <git@vger.kernel.org>; Fri, 16 Aug 2024 09:06:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723799175; cv=none; b=Hz8PJRZM11LFaMm0ME+i5PcYhcz2RxiEeLU2d64DdMpByBS2Z5wz1Ki5JK7qvyWypw0DVht2Tw+BJTHknKqZHW4mStCTd8FWCpv28DqBwHH0Yjvq5y9XlEF7R1fWkAac/T4ZcMbB6xvf2TpPOD1w0cQPhs7RZurUyC4GpmltNIA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723799175; c=relaxed/simple;
	bh=iwvBxeyOchcJfVlelwb+BzBURrC9sMspLnBIDaxUUf4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JJhM99V8iETjlOhXQ+GlHmZjbvXr/9qEwqyh/peiPJtgZaaSurnZS7/GLI3waYBD0kYuC2NFWsLckKAS2VLlBRZXLumtUopibWSjb5+XMn9dAKJXGk6k5rWHgRBHs26wmUkdWB8oJAcTLK98BMouQioHCcuIvtt/tqP5FWMRaew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=dSnXOeqc; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=byWwxfUv; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="dSnXOeqc";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="byWwxfUv"
Received: from phl-compute-02.internal (phl-compute-02.nyi.internal [10.202.2.42])
	by mailfout.nyi.internal (Postfix) with ESMTP id 0C849138FCE5;
	Fri, 16 Aug 2024 04:56:59 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-02.internal (MEProxy); Fri, 16 Aug 2024 04:56:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1723798619; x=1723885019; bh=OXWalzTFc4
	FNVw6teJewSP6UL1rKnyuTQvntJbAWPHY=; b=dSnXOeqc3pC6ZCouTHVJzhPSER
	Zy5C2gisjyNZ/ktF+y57gcue4hwLsIW2hMs0eKs/ckqFg3P+3goY1U+02rw3+ZXh
	5IgB75wvE3JsSqUlmFbXhj3phTfPf56s9zx1IUHLi8pq+9e5TxjZ6BW9p7l4YuFa
	PiXnVRWFgGSi9EI564uccXoWGYG/arnzQ/Fxm/bGiVX8a2j7HPEk10NwWvqGzDtn
	bsCHz4A1cHsCD1uYxQ9CBJhzYhUKN9Xnnmun5/Jm6MYXDQMkf16gOCVtPC9QNVc+
	ltaWagRYkP4huvJgFb0cl39oHSRUI0lx4oYYh/uzd4CkWHPgQ2UlitOOMlfA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1723798619; x=1723885019; bh=OXWalzTFc4FNVw6teJewSP6UL1rK
	nyuTQvntJbAWPHY=; b=byWwxfUvaMBbwNio7ZDz70pTvk+DeNAEdjOPr3gRwndG
	Vw0uw/CJkmNdTqSxWR4L8kdRL+ZqW/2rcF7p74gOh0VYCKcsYfdbvhhnV1rboC7C
	1KkH0W9VMVPAYU4Y+fx6Bnf0j+L/Kz/9snBrrEfgU++mPmhq97U7OP3gQSjtQeqr
	9jWZPlFdQaG3OAhg0/0xt8j6y5qKPSagzZ0UnkyK7dvACrtAlMMFuo7maYsUtJRL
	E2vXih10HxAEut0Rva0noV6nuQmhAAbEio5ZTUZJLktbfAIDbbIM8FXaXANAizAN
	DGITKZeUwzsa7+aXFJKP886hVuIYgXgkSdCjxWDyeg==
X-ME-Sender: <xms:WhS_Zu1Qr2k215YvJKGoM0jjgR4v1A_fItN5eRD6DVyOlMc16onZ4g>
    <xme:WhS_ZhF_zOrNrB74PiwBHdbGG6okr9guUMiMHa-8-Dd3GhRjRfC13EOrGdhl07WtY
    -3Pf_yPZgY45TcUBw>
X-ME-Received: <xmr:WhS_Zm64R4xIx5QUUZKfT3SHwTiwXlUkKjXXr2CS36cAVhL4Cu67ObVMopJBiKT9ZPhig8w0Ytp3eBuZqgMP_CMKOmBprM_m4rqZf05cEQIlNT0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddruddtkedgtdekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefgueeg
    udfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohephedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepjhhlthhosghlvghrsehgmhgrihhlrdgtohhmpdhrtg
    hpthhtohepghhithhsthgvrhesphhosghogidrtghomhdprhgtphhtthhopehsshgthhhu
    sggvrhhthhesghhmrghilhdrtghomhdprhgtphhtthhopehsrghnuggrlhhssegtrhhush
    hthihtohhothhhphgrshhtvgdrnhgvthdprhgtphhtthhopehgihhtsehvghgvrhdrkhgv
    rhhnvghlrdhorhhg
X-ME-Proxy: <xmx:WhS_Zv3Gh9j-2qjm9SJhq9VQo5juPJLcxniipmWvB2BUyLBestq09Q>
    <xmx:WhS_ZhHMFkI1yNyAakTbiN1Cqg7Af6gdA553uXAWKfQ8EEDr9DPlmQ>
    <xmx:WhS_Zo_Fnv13dFAciKAx4iUFX0oufI9O0jmCcGE2dQVOwXMjJyyVCw>
    <xmx:WhS_ZmkpijYtrqlyOdZdeo0Nacw-5dbcKJT8ayao24M2qFMMOM3zhQ>
    <xmx:WxS_ZqMXmpyPC9cE48Vxff0Z3jAyXKRDEMdmCYiRf3EjTi_pNPn3oRR->
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 16 Aug 2024 04:56:57 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id a6cebb4d (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 16 Aug 2024 08:56:34 +0000 (UTC)
Date: Fri, 16 Aug 2024 10:56:55 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Sebastian Schuberth <sschuberth@gmail.com>,
	Justin Tobler <jltobler@gmail.com>,
	"brian m. carlson" <sandals@crustytoothpaste.net>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 2/5] t0001: delete repositories when object format tests
 finish
Message-ID: <6b0cefef6af3a94cd3b650b2ab06de489dbdaf20.1723798388.git.ps@pks.im>
References: <cover.1723708417.git.ps@pks.im>
 <cover.1723798388.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1723798388.git.ps@pks.im>

The object format tests create one-shot repositories that are only used
by the respective test, but never delete them. This makes it hard to
pick a proper repository name in subsequent tests, as more and more
names are taken already.

Delete these repositories via `test_when_finished`.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 t/t0001-init.sh | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/t/t0001-init.sh b/t/t0001-init.sh
index 2093f5c1ee..795408e16c 100755
--- a/t/t0001-init.sh
+++ b/t/t0001-init.sh
@@ -500,6 +500,7 @@ test_expect_success 're-init from a linked worktree' '
 '
 
 test_expect_success 'init honors GIT_DEFAULT_HASH' '
+	test_when_finished "rm -rf sha1 sha256" &&
 	GIT_DEFAULT_HASH=sha1 git init sha1 &&
 	git -C sha1 rev-parse --show-object-format >actual &&
 	echo sha1 >expected &&
@@ -511,6 +512,7 @@ test_expect_success 'init honors GIT_DEFAULT_HASH' '
 '
 
 test_expect_success 'init honors --object-format' '
+	test_when_finished "rm -rf explicit-sha1 explicit-sha256" &&
 	git init --object-format=sha1 explicit-sha1 &&
 	git -C explicit-sha1 rev-parse --show-object-format >actual &&
 	echo sha1 >expected &&
@@ -522,6 +524,7 @@ test_expect_success 'init honors --object-format' '
 '
 
 test_expect_success 'extensions.objectFormat is not allowed with repo version 0' '
+	test_when_finished "rm -rf explicit-v0" &&
 	git init --object-format=sha256 explicit-v0 &&
 	git -C explicit-v0 config core.repositoryformatversion 0 &&
 	test_must_fail git -C explicit-v0 rev-parse --show-object-format
-- 
2.46.0.46.g406f326d27.dirty

