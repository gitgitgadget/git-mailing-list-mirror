Received: from fout-b6-smtp.messagingengine.com (fout-b6-smtp.messagingengine.com [202.12.124.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B68C13A71AA
	for <git@vger.kernel.org>; Wed, 13 May 2026 07:31:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778657486; cv=none; b=I20u+M7MvsP9DF7TDrgDgSw2+rw2tsR9qrn2LmKSHjhVuC8pYNdc7rFO0+gD1MqzaTmTZe/Id/l1W8UwepkP/Z2grIwFd784MwJJGkitjO9HztGwCROfqlcd8ixUpy4QKush841phT/VklG2rVPYHuUsD1vjrWR8vUWJu/Vgstc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778657486; c=relaxed/simple;
	bh=HszYVr4CqmCL1Ty6CaXW2GJCMZEeZrAUh9dSBdtoMuY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=b6i1iL3LRU2L+sUNhSR3+CzFQZoojIwW6LU0eS5Cbn8Gg9RAG5n6rQ5QGn0izLYmAkPlG3VovbaUtgU0dEVzuRG7XBdg3oxiUziT/w/sAIwtEWjBhRcYdIT5BJiFTWHzdU5JHhENqxoQty+OE+TWM4BzqCoYkXm7R8LtHzU4Sgk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=F/DQtS/c; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=PEXGgYWO; arc=none smtp.client-ip=202.12.124.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="F/DQtS/c";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="PEXGgYWO"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfout.stl.internal (Postfix) with ESMTP id 070611D00123;
	Wed, 13 May 2026 03:31:24 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-03.internal (MEProxy); Wed, 13 May 2026 03:31:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1778657483;
	 x=1778743883; bh=hcJh+iOiV8QOVcrUB29tAy2AaIh50EwtQ1CBbHRme1I=; b=
	F/DQtS/c7GQ6D1+cQkjIntlea2cG7xzhvvMwtpuoAGnY1UvSsbaTfwQ/9r2+r63z
	YmGxL//J/Dk+U32UXbeXHO4PG6PO2dA4unzrX1LucTejC7KzjP5cwJC1S9wwx/Ys
	k7eoHyhTNyiyCswDukmXzLqnbRuG4cz//5KVF+m4r8H3oi50LW7r68fGWBxXeZ8s
	S6qBL39dGYPwe7PaxZKUxSc2H+rDAMW0fNCzksfg0vedFUQZsurgfsAmvcKSp9jI
	lSIZziFoWFyosu+epFa8nLh5xcBqjuoPQbvcYeYEr28o1WAOkVjocGCs2HlFFuqF
	BodKmnwTFBpQVgGmi1PvPA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1778657483; x=
	1778743883; bh=hcJh+iOiV8QOVcrUB29tAy2AaIh50EwtQ1CBbHRme1I=; b=P
	EXGgYWO/FIplxJWGJ1Am3zQMtd/iuY6VNBSG+w2Zn4RSLV08FQ+4XjfvtkBCcscq
	F1VDkCm7a5VXGTMDUgW+OVA5dN6w7aHBLcD5YnAlqRiq56OP93oCDErawNZ9V7Ro
	o//eCG9h2Yfrau1E59l5oRdQiOhykJMkcbsPaZht+yUL02hN18GZ3g8L5NjESwyv
	rOqHnjqYqsZXIkNcse8MPHvi/X3V3n2ElyufwzvsGZY7iPrlRBw8znhPV9IcxFgo
	/68DP9ohYutF+0kMnev4pSW4SY4RitVF207vQyX9Fpwr583Shv4NmblW6+hGqxuw
	laEP9zX2AR1HbfsGDyK6A==
X-ME-Sender: <xms:yygEahRVQEqo3lymb2YvLwueQ5VKjDxkQZivbhAvS2g2hFHHMHtz9w>
    <xme:yygEatA1Ei9bYqaYoJaNeR6Wqb_VrVqBD_gFWNwya0EZSs-xgaxi1iIR1t6w2nUq3
    N7riVuobJGMAZ6zkLcDkfpT-dMes8aWaRBcCEhr8Ib1_ILhDHzW69E>
X-ME-Received: <xmr:yygEapGlHU4mLJzjhJwr_cxxNGZQGbQy0SjmjGs8hVkKaEcnIsRmE_Qrzs73sgAKPC4DfbDuCoBLiOAlpMxpUlMbUL0hgaKeGRUMoTL5kuE>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdduvdegtdekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeffueeiudejvdekheeuvdekfeffiedvueelteekudehjeetkeegvddugfdtgfeileen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhmpdhnsggprhgtphhtthhopeejpdhmohguvgepshhmthhpohhuthdprhgtphht
    thhopehmihhkrggthhhusehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvg
    hrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgt
    ohhmpdhrtghpthhtohepphgvfhhfsehpvghffhdrnhgvthdprhgtphhtthhopehsthholh
    gvvgesghhmrghilhdrtghomhdprhgtphhtthhopehmvgesthhtrgihlhhorhhrrdgtohhm
    pdhrtghpthhtoheprggtthhiohhnmhihshhtihhquhgvsehgmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:yygEavAyu9MsNz1zO63Djw0TLG5Zrg8wp79P5oOw00-6b70mUNUIVw>
    <xmx:yygEapUkbbN_zzsV45ASmqz1TlNZ_T4yQ49kboMdnWzH8S3PdWygbg>
    <xmx:yygEajrR_7XG5HB9682wosmHRTTi1jAcm5HiBm364u_GlDwHCLD7BQ>
    <xmx:yygEalSNOPUwW9Zh9YOnMCTX_KsPMRtrJD65iUSX0jSfqev7PxPNXA>
    <xmx:yygEaiC0N110B-coiUhIDl44yRY2foITRS_RgQFCTKX9EPjQl6T2wDR0>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 13 May 2026 03:31:22 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id b68e7e95 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 13 May 2026 07:31:21 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Wed, 13 May 2026 09:31:14 +0200
Subject: [PATCH v3 2/2] run-command: honor "gc.auto" for auto-maintenance
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260513-pks-maintenance-fix-lock-with-detach-v3-2-f27a1ac82891@pks.im>
References: <20260513-pks-maintenance-fix-lock-with-detach-v3-0-f27a1ac82891@pks.im>
In-Reply-To: <20260513-pks-maintenance-fix-lock-with-detach-v3-0-f27a1ac82891@pks.im>
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
2.54.0.709.gd731d7959a.dirty

