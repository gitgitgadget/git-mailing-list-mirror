Received: from fout7-smtp.messagingengine.com (fout7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B383F18CBF6
	for <git@vger.kernel.org>; Thu, 15 Aug 2024 08:00:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723708808; cv=none; b=n+0dGCDYsPVHKAiES6jsrEUq5PnBUhjLVmVh0QdaOXAMSNo2J5N+P63fuX/fY0+D94U8oFDCxTw59OY1BYhQVZ7It0ItANW94oS2+K47++Kx0cZ+WbCUUN8VRb5VAyLmpMLPPQI4fhNzu0l+meX9VaGLQjBzfT5IuGKXW+jQC+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723708808; c=relaxed/simple;
	bh=iwvBxeyOchcJfVlelwb+BzBURrC9sMspLnBIDaxUUf4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DC/25JUoB+SQ5ZT33lIF6653l4GPj7KR2MEPKTSceDM1bHcUDo+f+K1tcSoTugakQEpGflwEt+R3KAUgk90iTSdNGufYMuWletDxWKhE8ISMxZAG0Z46rgmuEAOdC4pnynirEvYa8Tiz3bOXTvpd9eA7c52/WY4rOhCQAt10YYU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=eLb0yZjm; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=IPDsYrlK; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="eLb0yZjm";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="IPDsYrlK"
Received: from phl-compute-03.internal (phl-compute-03.nyi.internal [10.202.2.43])
	by mailfout.nyi.internal (Postfix) with ESMTP id AB1A3139001F;
	Thu, 15 Aug 2024 04:00:05 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Thu, 15 Aug 2024 04:00:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1723708805; x=1723795205; bh=OXWalzTFc4
	FNVw6teJewSP6UL1rKnyuTQvntJbAWPHY=; b=eLb0yZjmQO+R0QN5A1IWp0oBl1
	UHUx/oaSd2WREaND3NM9cKFqt3BZjPgoUQZJNb93LIfhsH4dYqcEJzWObtSE+GF1
	1sP7mVL0eLOATu901/PQWpdJ5dst5UM9R1n3g3WXnI8W8QpPG9NKSErZXfzdsyW4
	CzAXqvUCI9FDZII8g5ekgnyfp/kwYyfuITe2/VzF0wDSDcN43XO4N2B+9SCibl+t
	iNoRXwSXbmCjf6lciww7/NhGAiXfbIoJ6DiOrnijHmDfWb+zugFkjJH+GG0926XQ
	tv9822KjLRxNWdfACvAC1VN12rwwfjEHYHYxiXnBxBQG5bHXceSuclodJEUg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1723708805; x=1723795205; bh=OXWalzTFc4FNVw6teJewSP6UL1rK
	nyuTQvntJbAWPHY=; b=IPDsYrlKiwDcZHlAm+Af82BYf4gCH3rn2+jth7Sp7aeT
	qCR/UkV9FDFBxUJK1PNr/Y+cmBneMZ5NWxeWXVoeuGS4G0l1qZ9Uaau7FRm4WL8w
	leEWJO6ezXu1R/OkIaZDvR39ybhwAvlIIzYSg4XvK5sty+GYtUm8tUYAkT+RD1tt
	KQF9QDmEg/aDGJltcCJ4Lgc8xlvmDeVXSi7dg9r4cuZxwK2JQGvfUFwcx/xgiMpA
	2tF4wP2/kmin89RedGSFfFUDqKD0+GNkfUbiJi6/jDHYysoSS865OYjGZPWk4a9N
	L76nm0BTPcGlzIaeacvUj768+/QZ4OOvarE+EYMRAw==
X-ME-Sender: <xms:hbW9Zq16EuKYy34ojgn7NdfXTB_a0DCibUOnVEEp161gG32wgQXP3A>
    <xme:hbW9ZtHFh0G2E1E1nC1-l10lQQTz2_8mjv1sZdPsifOlYpNIrsWugdIw4MMDGkFcO
    wyRmckP9HvMYeOUaw>
X-ME-Received: <xmr:hbW9Zi5YlXRsINTS6n_VJgvm-7LE55rgT13UvUZQnSXxdl7k1TXX9AWmy-XH157ebgQQYMqZ9-wFIGEN4HfObvOJkXm8lpbWsG1f8LJpi16EZw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddruddthedguddvkecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddv
    necuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrih
    hmqeenucggtffrrghtthgvrhhnpeevkeekfffhiedtleduiefgjedttedvledvudehgfeu
    gedugffhueekhfejvdektdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmh
    grihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopedvpdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpd
    hrtghpthhtohepshhstghhuhgsvghrthhhsehgmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:hbW9Zr1LG0QFX1SUhg7lZHQHnFduDSyJIgjPwRk2a48A8uinOiIVXA>
    <xmx:hbW9ZtHRKnr8rwF1-7tEbmt08ljP5kGrS-31XLzSsMtjdagaQPzmBQ>
    <xmx:hbW9Zk-4T6hIgejzCelz4htTNpvmx-jDbnAPKthdMsc2l1S5EBIWzA>
    <xmx:hbW9ZikF-iaGAHwP8M10ApWpoajYRNjRuIdU3XnnU4ne6LrfXuADCA>
    <xmx:hbW9ZiTo1TZBOnOm8msHonAFMCkYRI17Vz7Wzl2O7BGahVPoM5eGZliH>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 15 Aug 2024 04:00:04 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id b793aa09 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 15 Aug 2024 07:59:41 +0000 (UTC)
Date: Thu, 15 Aug 2024 10:00:00 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Sebastian Schuberth <sschuberth@gmail.com>
Subject: [PATCH 2/5] t0001: delete repositories when object format tests
 finish
Message-ID: <6b0cefef6af3a94cd3b650b2ab06de489dbdaf20.1723708417.git.ps@pks.im>
References: <cover.1723708417.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1723708417.git.ps@pks.im>

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

