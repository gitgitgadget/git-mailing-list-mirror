Received: from fhigh-a7-smtp.messagingengine.com (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C55BB49553B
	for <git@vger.kernel.org>; Tue, 12 May 2026 08:30:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778574648; cv=none; b=lcLL66mllVqJ0HuEhslslvYnRa90KNV2BsXuXEYS9Fi9YII1ul3kyop1N85kgyfMZ95RniSBFgxHlFNelNAdMeG60q6/pCaewF4Ptlx6WN/DOLpXVNWwL4pJa9d1nuzEygbK5bETeMU4gxmbEBt474SGyga9VluAcSnMFQnqlJ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778574648; c=relaxed/simple;
	bh=2kqUVEeMY6vr27HDQl3tIjh+3KWzEPNmAvPAE2Diiv8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=eT64yLM6MMT7ltG1RZTKDxRB1PwGK99+oIXbpWhqL9jq190JrOaEZxUZgRMNeBZzUa80JHflcTf272eKybWMOhjHfJPcamediwmBsQXP2zXGGWau0LE4FrYDqk/eh8Ca0rMXsmLLRCNVb0ssKsuHXg0uPwXJ+lyTYCGIYVMHZKc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=FLHEVBEs; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=BqODivCo; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="FLHEVBEs";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="BqODivCo"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.phl.internal (Postfix) with ESMTP id C827F1400207;
	Tue, 12 May 2026 04:30:42 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-03.internal (MEProxy); Tue, 12 May 2026 04:30:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1778574642;
	 x=1778661042; bh=7zuVvQcvRXsV/Gvq0EOAcawHfuvSUUQKh4WBHiIyMNw=; b=
	FLHEVBEsqBYhelPAvbCYcxbErXRwlV0PvKxVmitEu2zI/ek9+uiRSJNMp4W7fsag
	tIX8R7ke4l1uxa+pWeZGCtjwQemN+ilvyJjoyWj6eVFbetTOYp0plxeM+7gw1gqr
	lqJsrzAkueRantRWauvT9IA5cI/T9fqTZQvJaoJm4daBrWA2Uw68nJ20D7jYAIKt
	YVZKdAkVw3BnN6vbnTd+wNLgFgF1ta0V2OVKujMq812JuLVOguNb8MoBI8ESHRvb
	Ea2fKITIu+TnTT9E5ELK7DxfdpFj86bMz+bGlLgh/NpyR9ZXpJYuY2IEbrh1pto1
	BsNYK8P1m3tq6rRXDC16pQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1778574642; x=
	1778661042; bh=7zuVvQcvRXsV/Gvq0EOAcawHfuvSUUQKh4WBHiIyMNw=; b=B
	qODivCokgG8GwIseJgjq8A7UiJIeunvSEDpRXO8BgqNW1oPOhwwgXOz9p+Zre3mW
	jVMlUw6mw+lIV9k6skO/Eux3ZFg+nAuWPdqr4TCsDyM5TMssY/A9+5M0n+dPnT6R
	eeOpmhvFEFtDg7hwid/BV34g4fnkVM9KGumjRDy1c3ECJgRpgW2s/OSajVArn8hq
	45XySwq/rhmhbbGNMZhFilb6wbgOieoJioQjP2AopYa2wYyN1mYUqUYwUA7Zv4QY
	/65RgsG3gXzm1B36+XEmbPbx2/p12nBma/PR7FHt6rafB/7bcagqvhgSdbeiQq/U
	Q2iotQXp0Mlv80gA+yDtg==
X-ME-Sender: <xms:MuUCavZAFSNjZ1kcSFUhGZ7SY-3zKfbo8nKybbn26g3tqOqZQ2ZWng>
    <xme:MuUCagqx_z28sJAFwX6G9tkk8NqUtIFI0p3qDSeETKoOOxdSfcPhPVOIaTvsv8Jup
    ZmCKAWFeW6eKyWh3hTcz0Kn_BzPldpzP7rUwjZKL44O5VA_1PX6>
X-ME-Received: <xmr:MuUCakM5aeu3PczkUt77Qj8Gi4fGlMzZtpKfeVOotGQApFaDfbg89YM0HCYyrNseYbzZ5VF-uND9eF4Ez6KdwHgWJy75bGP8nygJ8mtG79U>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdduvddufeefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeffueeiudejvdekheeuvdekfeffiedvueelteekudehjeetkeegvddugfdtgfeileen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhmpdhnsggprhgtphhtthhopeejpdhmohguvgepshhmthhpohhuthdprhgtphht
    thhopehmvgesthhtrgihlhhorhhrrdgtohhmpdhrtghpthhtohepghhithhsthgvrhesph
    hosghogidrtghomhdprhgtphhtthhopehmihhkrggthhhusehgmhgrihhlrdgtohhmpdhr
    tghpthhtohepshhtohhlvggvsehgmhgrihhlrdgtohhmpdhrtghpthhtohepphgvfhhfse
    hpvghffhdrnhgvthdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhg
    pdhrtghpthhtoheprggtthhiohhnmhihshhtihhquhgvsehgmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:MuUCaroBszczROb-TrHpkNY2t1nYdw7uIjPUSoCo--jQ5t1hpgzPWA>
    <xmx:MuUCapes8bU79r-gPXRaWN8CouI2UWCzD6UEiWpAC-9eXmZPVyR5IQ>
    <xmx:MuUCahSGd_jrlZollLUCrJwkcUvVgyHW3tct8z3_7FyWQMzBlsGVKw>
    <xmx:MuUCaiZqpJMTcxVre9ajOhhaEHcuPBEnVj4N1vFuXJxRrSN-6IgFFA>
    <xmx:MuUCauyo6qMDm3sxiK3Id2rJraYnTzZf4_7NOuxcbwc5Chr6Ik3yVxil>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 12 May 2026 04:30:41 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 922ff1fd (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 12 May 2026 08:30:41 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Tue, 12 May 2026 10:30:31 +0200
Subject: [PATCH v2 2/2] run-command: honor "gc.auto" for auto-maintenance
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260512-pks-maintenance-fix-lock-with-detach-v2-2-dc6f2d284b6d@pks.im>
References: <20260512-pks-maintenance-fix-lock-with-detach-v2-0-dc6f2d284b6d@pks.im>
In-Reply-To: <20260512-pks-maintenance-fix-lock-with-detach-v2-0-dc6f2d284b6d@pks.im>
To: git@vger.kernel.org
Cc: Jean-Christophe Manciot <actionmystique@gmail.com>, 
 Mikael Magnusson <mikachu@gmail.com>, Jeff King <peff@peff.net>, 
 Taylor Blau <me@ttaylorr.com>, Derrick Stolee <stolee@gmail.com>, 
 Junio C Hamano <gitster@pobox.com>
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
 run-command.c          | 10 +++++++---
 t/t7900-maintenance.sh | 25 +++++++++++++++++++++++++
 2 files changed, 32 insertions(+), 3 deletions(-)

diff --git a/run-command.c b/run-command.c
index c146a56532..28202a81d8 100644
--- a/run-command.c
+++ b/run-command.c
@@ -1944,10 +1944,14 @@ void run_processes_parallel(const struct run_process_parallel_opts *opts)
 int prepare_auto_maintenance(struct repository *r, int quiet,
 			     struct child_process *maint)
 {
-	int enabled, auto_detach;
+	int enabled = 1, auto_detach;
 
-	if (!repo_config_get_bool(r, "maintenance.auto", &enabled) &&
-	    !enabled)
+	if (repo_config_get_bool(r, "maintenance.auto", &enabled)) {
+		int gc_threshold;
+		if (!repo_config_get_int(r, "gc.auto", &gc_threshold))
+			enabled = gc_threshold > 0;
+	}
+	if (!enabled)
 		return 0;
 
 	/*
diff --git a/t/t7900-maintenance.sh b/t/t7900-maintenance.sh
index df0bbc1669..97c8c701bb 100755
--- a/t/t7900-maintenance.sh
+++ b/t/t7900-maintenance.sh
@@ -73,6 +73,31 @@ test_expect_success 'maintenance.auto config option' '
 	test_subcommand ! git maintenance run --auto --quiet --detach <false
 '
 
+test_expect_success 'gc.auto config option' '
+	GIT_TRACE2_EVENT="$(pwd)/default" git commit --quiet --allow-empty -m 1 &&
+	test_subcommand git maintenance run --auto --quiet --detach <default &&
+	GIT_TRACE2_EVENT="$(pwd)/true" \
+		git -c gc.auto=1 commit --quiet --allow-empty -m 2 &&
+	test_subcommand git maintenance run --auto --quiet --detach <true &&
+	GIT_TRACE2_EVENT="$(pwd)/false" \
+		git -c gc.auto=0 commit --quiet --allow-empty -m 3 &&
+	test_subcommand ! git maintenance run --auto --quiet --detach <false
+'
+
+test_expect_success 'maintenance.auto overrides gc.auto' '
+	test_when_finished "rm -f trace" &&
+
+	test_config maintenance.auto false &&
+	test_config gc.auto 1 &&
+	GIT_TRACE2_EVENT="$(pwd)/trace" git commit --quiet --allow-empty -m 1 &&
+	test_subcommand ! git maintenance run --auto --quiet --detach <trace &&
+
+	test_config maintenance.auto true &&
+	test_config gc.auto 0 &&
+	GIT_TRACE2_EVENT="$(pwd)/trace" git commit --quiet --allow-empty -m 1 &&
+	test_subcommand git maintenance run --auto --quiet --detach <trace
+'
+
 for cfg in maintenance.autoDetach gc.autoDetach
 do
 	test_expect_success "$cfg=true config option" '

-- 
2.54.0.545.g6539524ca2.dirty

