Received: from fout-a7-smtp.messagingengine.com (fout-a7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E911E2F3C10
	for <git@vger.kernel.org>; Thu, 19 Feb 2026 06:25:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771482346; cv=none; b=ThVO4GrLevaoglAQ0uQWZ9xlzW1pWw5U4Fs9R9rlw82fEBV37lkXhtm3ZvKk8EpPVujNA5TOGBdigSvsgy7jYcGcr6yGrMMcjGmHUgGqNXYOqiqMBxHFDzUxbyG4DK8Xpnw8bNgiBVOSwRXt/Q+xglOTeNeiZ9ThZF/37qS5mp8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771482346; c=relaxed/simple;
	bh=ttSZzloBJxtl8aShjOxwIGY0ufV5tVavfYl+fcn0psk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=cx4W+ESzXvVqCnVN0stLnRiWzEOkkIyO8c1maqSG7sPe2F6UfBgy2eFt7/9PEQNCu+wCOcmqvas4e6PM7mWxLXcKxdyExVrr5RL5TBRHP45cOUKBuVsAqyV6meNMvbaR7S6CsuWNUPj2ao1baHuZVRg7sedSt2DZlJ0sJtHG3Ew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=OriQjkXY; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=QqhEH8cA; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="OriQjkXY";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="QqhEH8cA"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.phl.internal (Postfix) with ESMTP id EAAFCEC0664;
	Thu, 19 Feb 2026 01:25:40 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Thu, 19 Feb 2026 01:25:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1771482340;
	 x=1771568740; bh=ItIv8pqL409uflYPF+aD8q9pq5S8fECWZTTvg8Vd8dk=; b=
	OriQjkXYuw6bHIZmeSVyDklsc5JskEVSjEC++pTAIVO5wHzrDuhL0Cs9wiJECMPz
	UxwZG1xay5Mb8N/oOBcBjVdEjIlpoSmC6XOElFx6lyzctXwnk59SqUFr+0Gfqw9F
	YgdmkgBbrtAq5YOdp1VYh6xTaFLFXMUFnP5EMEjaugt2s0nzAB22ebJqgmhlgA/T
	k3gr/uo36mogMypFZsVLIag63DL8TVgHoC2CPmP/g6l5DxsF9uGMkY63mBRiqyiO
	GQER7Ztz+4f1OWcRGLrmngvZxOQ6YMkrbliGeYlM7M2ybvhWEcxRPPgqicxbh40y
	M7iqYhjtMJsBeBebIib54Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1771482340; x=
	1771568740; bh=ItIv8pqL409uflYPF+aD8q9pq5S8fECWZTTvg8Vd8dk=; b=Q
	qhEH8cAkUD66381I9a2g4J0e4t+rZPfakv/3fukAhLGcym1uhcnU1KBPJITDEr9B
	QefAkYaFrUdnVIu2DT3ND83SI7b8jtG6nuFmL3RSPi4m24r16avtiD7RXMt/NEaI
	45tuK1+DXQfXzci48L4i+n4P69bq37PbXiW6GPo8Qg3/irqfc3jHNahYpeZPJMVb
	R8f7DG6PW3K7iuA6XRCYeUUYV4oWIO3BljN7+63eIpP4UREfPslh6XVCUR6bQMoM
	6nhY6PLeEqcFKUDMgE2RCEIviYsLfNBdOAn8k5GhQsx/Eno00c3K6lu0gsS8CWOF
	kBGgmWCW1N771IPN1mGBg==
X-ME-Sender: <xms:5KyWaZtFZLB2c4IuWYQQIDlpXC9x8c18ndeFPUlpm4uIadhnuNGOpg>
    <xme:5KyWaZXLS-E2LsfSqkwMhS2PUn1W7lqAigWRAc5s2P3coBW5XxQ076rP-Yq7i0NcG
    fbRC2AXT0qNzm86aIP0CK1Oeb_BvyEQv1V7nFt7HVC0IueLITF6Kek>
X-ME-Received: <xmr:5KyWaVEfnIyR1qERGWN1wOQIZR_xtp4cxoLQbc3bTYJ5eGXC3stNHvfetl0MPc_TTFE18SodtGCK21n0TNT5AQvTg3BKL-YeqyKNMRKjMA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvvdegjeelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeffueeiudejvdekheeuvdekfeffiedvueelteekudehjeetkeegvddugfdtgfeileen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhmpdhnsggprhgtphhtthhopeehpdhmohguvgepshhmthhpohhuthdprhgtphht
    thhopehjohhhrghnnhgvshdrshgthhhinhguvghlihhnsehgmhigrdguvgdprhgtphhtth
    hopehjlhhtohgslhgvrhesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgv
    rhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepphgvfhhfsehpvghffhdrnhgvthdprh
    gtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:5KyWab1F6cSSlHGONt5Esg9H1jOqmKvUM2ldY_Nfz6csLU3J123pFQ>
    <xmx:5KyWaXM8TNGHkVG85TLUPHfSI0WhOpb7-4m-Tf_vl12GdzxKD0AQvg>
    <xmx:5KyWaa5oxRNkPzOQTD0d4yfsO5xzbpikFrV14RaV4bbAjpvxEW4TWw>
    <xmx:5KyWaR0uu4ERhJeV7rvLDez0hN8f6Rb7hgsvIOVkph1_9wTpyi7Log>
    <xmx:5KyWaZTU4YDwVy1Hyi0YDOngEZWnTPtg7rO1e1gfcqVtvKLl-lMdjKTK>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 19 Feb 2026 01:25:39 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 8a1d213f (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 19 Feb 2026 06:25:38 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Thu, 19 Feb 2026 07:25:29 +0100
Subject: [PATCH v2 3/7] meson: fix MERGE_TOOL_DIR with "--no-bin-wrappers"
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260219-b4-pks-ci-meson-improvements-v2-3-6047b8307ab2@pks.im>
References: <20260219-b4-pks-ci-meson-improvements-v2-0-6047b8307ab2@pks.im>
In-Reply-To: <20260219-b4-pks-ci-meson-improvements-v2-0-6047b8307ab2@pks.im>
To: git@vger.kernel.org
Cc: Justin Tobler <jltobler@gmail.com>, Junio C Hamano <gitster@pobox.com>, 
 Jeff King <peff@peff.net>, Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-Mailer: b4 0.14.3

On Windows, we execute tests with "--no-bin-wrappers". This has been
introduced via a87e427e35 (ci: speed up Windows phase, 2019-01-29) to
save some time: spawning processes is expensive on Windows, and shell
scripts tend to spawn a bunch of them. So overall, the bin-wrappers led
to a performance overhead of ~10-30%.

This causes test failures when using Meson on Windows:

  failure: t7610.28 mergetool --tool-help shows recognized tools
    ++ git mergetool --tool-help
    /d/a/git/git/build/git-mergetool--lib: line 45: cd: D:/a/git/git/build/mergetools: No such file or directory

The root cause here is that our bin-wrappers are usually responsible for
setting up the `MERGE_TOOL_DIR` environment variable so that we can
locate these scripts. But as we don't use the bin-wrappers, we'll
instead use the default location for merge tools, which is derived from
`GIT_EXEC_PATH`. And as `GIT_EXEC_PATH` points to our build directory,
which won't ever contain any of the merge tools, we will fail to locate
any of the merge tools.

This issue has went unnoticed for a long time given that we only skip
bin-wrappers on Windows, and because the CI jobs on Windows didn't
execute due to a bug.

Fix the issue by always setting the `MERGE_TOOL_DIR` environment
variable to the correct directory.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 t/meson.build | 1 +
 1 file changed, 1 insertion(+)

diff --git a/t/meson.build b/t/meson.build
index 19e8306298..5ba7efd603 100644
--- a/t/meson.build
+++ b/t/meson.build
@@ -1208,6 +1208,7 @@ endif
 
 test_environment = script_environment
 test_environment.set('GIT_BUILD_DIR', git_build_dir)
+test_environment.set('MERGE_TOOLS_DIR', meson.project_source_root() / 'mergetools')
 
 foreach integration_test : integration_tests
   test(fs.stem(integration_test), shell,

-- 
2.53.0.414.gf7e9f6c205.dirty

