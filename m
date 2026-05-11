Received: from fhigh-b6-smtp.messagingengine.com (fhigh-b6-smtp.messagingengine.com [202.12.124.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7482E22D785
	for <git@vger.kernel.org>; Mon, 11 May 2026 12:30:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778502612; cv=none; b=COTWzdRVXh4dLDjOvMHBu6HE2yL6yTGCnX+KJhrNMMzwN/+qiwl7dJufcmP+cUOLGC/AuoUyd2PjOUPkMViFMdjB/2XLTtaARgv/6dEVb/mAWHYouqEUHiqAzDht3SXtDhThGbwPtrkaRKl7B2XxQZb9S8kp8owkNl/AjegBq70=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778502612; c=relaxed/simple;
	bh=DkgfxmdDshpxywW3DRz/p7/rIpFMXCaCbQmeXHXojKk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=MbUDUKs7YgLkvuCbsrYY+aG7NXdVmQ9LXIJcpSO8hZtu19+ITbV/IXfFKhG8mbO7RvcU3hvBdxz8o9DcCg5MVfgdwwBLvnv8YB4ASZRUiJsTzpKu9IaSweU8cMITd6ynI4Wb138a468YPSXvSmI5AWGtPQGi6qfP1cMR05xBKUo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=XEaJuJud; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ujXgt7qo; arc=none smtp.client-ip=202.12.124.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="XEaJuJud";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ujXgt7qo"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.stl.internal (Postfix) with ESMTP id AEA0F7A011F;
	Mon, 11 May 2026 08:30:09 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Mon, 11 May 2026 08:30:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1778502609;
	 x=1778589009; bh=cTmsSC2s+5eaHO8fssfGqBjwWK2IeKUWeBm1k0IU/nA=; b=
	XEaJuJudPatkSS4J876Jd5UllW1k1R3OQ6URSGG0O+ZJ4QovzWEioW8V7GwYEBKI
	+xfQX9vrd91adUk3qSbHCEB67PYhbagF5qIkGBtcB+wRcNG00doZwHy4H0z9eAs4
	MK/ToXjNux0j3e9QolQQHXAj+stN/K6AP5VYEKFDQp8AzUpQ8XH0ECl/QZVnUluG
	nWvWSvPDtIMHLlT2PaqU0ZtIsz+C2UjoZLF6TLLsnsO+VofX+ci89WA1AC2gBE8Y
	8nezaFmc3zKdMXLvYlSfZ9cO/y8t5sUgYVVJhCZaEwJtkKvdXZUgMazH925c9ZHf
	HWwLchXNKY6LcnuVO3PNdg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1778502609; x=
	1778589009; bh=cTmsSC2s+5eaHO8fssfGqBjwWK2IeKUWeBm1k0IU/nA=; b=u
	jXgt7qoG9Arz3+JMyo6PGL1Xp7ow0frPutwP8pFV4w/peu0/ROmwiFdJ1wvfcS4S
	sQIdqrlJHt9meueb03BGfkyxww5GZIAYXGlmgMGIHQWArwYgX7HM2BMGpbLhdw6B
	qMQ6EPuuJYFDCfI/ODO2XqRiHmr6IFEA0GGiMSx8fEqTU6Ew6eYeFFmC6BBPUI40
	f8/sJx96YWy1Z6fPXZiwZqXDP3vtPN+aUm9+SfGH6e6qJHoDy2eJATV3rjBxbtmW
	tl8Lqx9et7Dz9CR5v2mmsrTMOdkGqzNYnRjgqOGP8RNhoZVwE9Q/qkUrSm+yIOEL
	46cw+Vt9ZTt+xb4UNwixg==
X-ME-Sender: <xms:0csBanR4C98jH9bnmyPMz8ryc6k2OScAnnK_sOA14CbclihlhbUiTg>
    <xme:0csBasfCe-CmnwwuFiZAW8e_KIMRts3Uh6CdSlZ1AsNNC_obTcqsJq7uChBEK-8mJ
    7JFPRNz0VrIGLy2Mj-8VvMWGUv0fS4F0vh0OgHtivWdBoTlvmuKvA>
X-ME-Received: <xmr:0csBamoT6C9bohJEql0k_KgxJmqOs7KVy6t3iOwqSQ15DdMqZZkiOu2hYbYf5ZKl4uXP3tAASb1E1ZedJgCM-vKbI9zBsGwEw94tFs-6Hw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdduudekleefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeffueeiudejvdekheeuvdekfeffiedvueelteekudehjeetkeegvddugfdtgfeileen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhmpdhnsggprhgtphhtthhopeeipdhmohguvgepshhmthhpohhuthdprhgtphht
    thhopehmvgesthhtrgihlhhorhhrrdgtohhmpdhrtghpthhtohepphgvfhhfsehpvghffh
    drnhgvthdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghp
    thhtohepshhtohhlvggvsehgmhgrihhlrdgtohhmpdhrtghpthhtohepmhhikhgrtghhuh
    esghhmrghilhdrtghomhdprhgtphhtthhopegrtghtihhonhhmhihsthhiqhhuvgesghhm
    rghilhdrtghomh
X-ME-Proxy: <xmx:0csBat_v5pzD3ciOr1FHPjQrHsCxLmaBkPnFvmN5Ichts0TDtqEKIQ>
    <xmx:0csBaidL4DMbmpykoYrNW2dJmP2ZYrbVGsrUOHw2djw1mnuBPRnzMA>
    <xmx:0csBanIoKUPyyG-ZFSkwKo7_q_IOUnnWsEHovlQl3KwZGjZjL1lBvg>
    <xmx:0csBaigb_cWxCfShrSrXPJdvV8kc27_Zrq5CLiHdlMz5zNSBvOXf5w>
    <xmx:0csBaj3BeIsc5XR1JyFjhfakfp8wkTyozQdsknYELZos7_xGpK2vNv-C>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 11 May 2026 08:30:08 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 6a589d88 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 11 May 2026 12:30:07 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Mon, 11 May 2026 14:29:56 +0200
Subject: [PATCH 2/2] run-command: honor "gc.auto" for auto-maintenance
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260511-pks-maintenance-fix-lock-with-detach-v1-2-ccd7d62c9a40@pks.im>
References: <20260511-pks-maintenance-fix-lock-with-detach-v1-0-ccd7d62c9a40@pks.im>
In-Reply-To: <20260511-pks-maintenance-fix-lock-with-detach-v1-0-ccd7d62c9a40@pks.im>
To: git@vger.kernel.org
Cc: Jean-Christophe Manciot <actionmystique@gmail.com>, 
 Mikael Magnusson <mikachu@gmail.com>, Jeff King <peff@peff.net>, 
 Taylor Blau <me@ttaylorr.com>, Derrick Stolee <stolee@gmail.com>
X-Mailer: b4 0.15.2

The "gc.auto" configuration has traditionally been used to turn off
running git-gc(1) as part of our auto-maintenance. We have eventually
switched over to git-maintenance(1) in a95ce12430 (maintenance: replace
run_auto_gc(), 2020-09-17), and with 1942d48380 (maintenance: optionally
skip --auto process, 2020-08-28) we have introduced "maintenance.auto"
to control whether or not to run auto-maintenance.

At that point though we still shelled out to git-gc(1) internally. So
if "gc.auto=0" was set we would still _execute_ git-maintenance(1), but
the command would have exited fast because git-gc(1) itself knew to
honor the config key.

This has recently changed though, as we have adapted the default
maintenance strategy to not use git-gc(1) anymore. The consequence is
that "gc.auto=0" doesn't have an effect anymore, which is a somewhat
surprising change in behaviour for our users.

Adapt `run_auto_maintenance()` so that it knows to also read "gc.auto",
similar to how it also reads both "maintenance.autoDetach" and
"gc.autoDetach".

Reported-by: Jean-Christophe Manciot <actionmystique@gmail.com>
Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 run-command.c          |  6 ++++--
 t/t7900-maintenance.sh | 37 ++++++++++++++++++++++++++-----------
 2 files changed, 30 insertions(+), 13 deletions(-)

diff --git a/run-command.c b/run-command.c
index c146a56532..1e7b789010 100644
--- a/run-command.c
+++ b/run-command.c
@@ -1946,8 +1946,10 @@ int prepare_auto_maintenance(struct repository *r, int quiet,
 {
 	int enabled, auto_detach;
 
-	if (!repo_config_get_bool(r, "maintenance.auto", &enabled) &&
-	    !enabled)
+	if (repo_config_get_bool(r, "maintenance.auto", &enabled) &&
+	    repo_config_get_bool(r, "gc.auto", &enabled))
+		enabled = 1;
+	if (!enabled)
 		return 0;
 
 	/*
diff --git a/t/t7900-maintenance.sh b/t/t7900-maintenance.sh
index df0bbc1669..1f70462678 100755
--- a/t/t7900-maintenance.sh
+++ b/t/t7900-maintenance.sh
@@ -60,17 +60,32 @@ test_expect_success 'run [--auto|--quiet] with gc strategy' '
 	test_subcommand git gc --no-quiet --no-detach --skip-foreground-tasks <run-no-quiet.txt
 '
 
-test_expect_success 'maintenance.auto config option' '
-	GIT_TRACE2_EVENT="$(pwd)/default" git commit --quiet --allow-empty -m 1 &&
-	test_subcommand git maintenance run --auto --quiet --detach <default &&
-	GIT_TRACE2_EVENT="$(pwd)/true" \
-		git -c maintenance.auto=true \
-		commit --quiet --allow-empty -m 2 &&
-	test_subcommand git maintenance run --auto --quiet --detach <true &&
-	GIT_TRACE2_EVENT="$(pwd)/false" \
-		git -c maintenance.auto=false \
-		commit --quiet --allow-empty -m 3 &&
-	test_subcommand ! git maintenance run --auto --quiet --detach <false
+for cfg in maintenance.auto gc.auto
+do
+	test_expect_success "$cfg config option" '
+		GIT_TRACE2_EVENT="$(pwd)/default" git commit --quiet --allow-empty -m 1 &&
+		test_subcommand git maintenance run --auto --quiet --detach <default &&
+		GIT_TRACE2_EVENT="$(pwd)/true" \
+			git -c $cfg=true commit --quiet --allow-empty -m 2 &&
+		test_subcommand git maintenance run --auto --quiet --detach <true &&
+		GIT_TRACE2_EVENT="$(pwd)/false" \
+			git -c $cfg=false commit --quiet --allow-empty -m 3 &&
+		test_subcommand ! git maintenance run --auto --quiet --detach <false
+	'
+done
+
+test_expect_success "maintenance.auto overrides gc.auto" '
+	test_when_finished "rm -f trace" &&
+
+	test_config maintenance.auto false &&
+	test_config gc.auto true &&
+	GIT_TRACE2_EVENT="$(pwd)/trace" git commit --quiet --allow-empty -m 1 &&
+	test_subcommand ! git maintenance run --auto --quiet --detach <trace &&
+
+	test_config maintenance.auto true &&
+	test_config gc.auto false &&
+	GIT_TRACE2_EVENT="$(pwd)/trace" git commit --quiet --allow-empty -m 1 &&
+	test_subcommand git maintenance run --auto --quiet --detach <trace
 '
 
 for cfg in maintenance.autoDetach gc.autoDetach

-- 
2.54.0.545.g6539524ca2.dirty

