Received: from fhigh-a1-smtp.messagingengine.com (fhigh-a1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2D5F27FD48
	for <git@vger.kernel.org>; Fri, 24 Oct 2025 06:57:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761289061; cv=none; b=OueFZk2Tkvk8sBcpTtZg1ip+xnbKfPEPoYwki8PQs727lcmOtnKDcsqDdI9lqpXYkkTiTeZSfu5eTw/uBvTcMbmokxwmnWBx+v9fCOUdR44TV9G2wqTErEDhN7s4HV1WTCOiEzvv+QEgPfft42gsvB9uoR76AfhuJWNGtZYmkRw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761289061; c=relaxed/simple;
	bh=BUQEldietD2qF2OHXLoLT0H2+lK0dKIZn2ftRoxFwdg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=L1D0oo4v7XborhRJywyFkIRAPzoOaiklmSuSNjb+ypE4QGKPbBQOUXnt/Nnjkmf2Gkv0LHDo/iOCOm4V7z/eZS5CudkqPSc08AqB5yBbQxJsIN+MVBybF11z5AGzoyORgz4Ci7eAQdmgHstNBS/2z36t7sfRh0GDL1T0KzVlk8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=Y4X1ch8w; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=d6n/+/Hb; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Y4X1ch8w";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="d6n/+/Hb"
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfhigh.phl.internal (Postfix) with ESMTP id BEBF41400159;
	Fri, 24 Oct 2025 02:57:38 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-10.internal (MEProxy); Fri, 24 Oct 2025 02:57:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1761289058;
	 x=1761375458; bh=YNoqqQCjPopIFWZCw3RxFWk2BDgsKYH8IGxV+sfm298=; b=
	Y4X1ch8w4uy+JRoFaXJ8HIfwXt3gBvLBU5VuP4PjsnjJ7grQlTrU3hZZcLmXuffj
	copeGjn4LMlaw2W93P74LpZtQ47sod2IvfnGvlOMO2sNWyqiKEfkMNL63XVkSegk
	nQeImYQ3/7vf0ZLJEs72qPqaD8uUnlJmxHbBoNFe1Tu+iMom3MHtrkxBPh9Spjwp
	IBuWRInyG+Mjn6zpBye2thnYDjmZaSwGswbLDGsv05Rlze2bV3P0O6vQN3xQRjwc
	TpoP0yugg6nQNx9zZdBo74tofeAS0rFILJC29cT1FL9QqYya2rqH9Nelp0POazNW
	AeMHj8ja9WLAJv54zRIrnA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1761289058; x=
	1761375458; bh=YNoqqQCjPopIFWZCw3RxFWk2BDgsKYH8IGxV+sfm298=; b=d
	6n/+/HbMBLl8KIUk42g2cyANrUetWosxIhOBq11ynzzN5iiavQxIyZQoI+27uFNA
	Qjylb3WpmBz7COUT89ZkdgfY3V85bDLsns54kgKjn9unEMKLzG8fj71jcueSqKBW
	cIY6jo89aTcd/NoYw5Bot4/j9gA/eW3hZ2odLU+UtpJ5XUvtCBmu6soz1c5t/B29
	0S7EO6t0SiPowyBf1q2/pssvHkLv3ObD9ZAHVNI88+5004wljtHrZ2Mf4Pddlftp
	XlQD0BKTcfo/FYJrcaklkUIj8OeOTmPqmOwLBKuimjKjn6vofPd8GRo+MoIdvx4X
	iI0qvfVpIl6wc07X5stnQ==
X-ME-Sender: <xms:YiP7aH9AFhgckXLlGzwXlP4SaSOrT8DvhF04XCTV7kJNMQsnAA_pvQ>
    <xme:YiP7aKl2rPFb1ft-9EP0A8Rbe__DUB2zn6h49XVvCTOgjmAcoIsWtrfQi-BvCUZI8
    Q7Kk2Mlhm4yyeuh3ZhRQRVk2_n7yeox_jE554IdqB_5n7RisxegYw>
X-ME-Received: <xmr:YiP7aNXu6G1wsLXdXkPjeKfrQ1cixn09N5AvmF6uhSx65KaTPztPE_FvB5UuCoWBH7OQaTvPPLbL1uJrLlRl386PC1r2YAeZ7qEIP7m6Vw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddugeekieekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeffueeiudejvdekheeuvdekfeffiedvueelteekudehjeetkeegvddugfdtgfeileen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhmpdhnsggprhgtphhtthhopeehpdhmohguvgepshhmthhpohhuthdprhgtphht
    thhopehmvgesthhtrgihlhhorhhrrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrd
    hkvghrnhgvlhdrohhrghdprhgtphhtthhopehsthholhgvvgesghhmrghilhdrtghomhdp
    rhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhmpdhrtghpthhtohepjhhlth
    hosghlvghrsehgmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:YiP7aPE4vnrN3cTfhTNA_eZupmpa2Zk3r3fbP4QA0NEQJrLsKCX7YQ>
    <xmx:YiP7aJeBaNtfcmD6PMIQtraJLxfs88FTZTPVDEFSLzCbL8OstTQbDQ>
    <xmx:YiP7aAIxHb1fHk0dbc5j0e28rXtbuXybYc1GcQhHVIb5DSrIxg_ZrA>
    <xmx:YiP7aOHxhv8YpBEi1uu-5IaJwtqXM5q5gH58xLO0HzqLPGwtNPZg8w>
    <xmx:YiP7aJcjlHTOLWwk5e90mEx2n08luLWGfrhKcK6b03WD5g51Qdb99moP>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 24 Oct 2025 02:57:37 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 7c0651a4 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Fri, 24 Oct 2025 06:57:37 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Fri, 24 Oct 2025 08:57:19 +0200
Subject: [PATCH v3 06/10] builtin/maintenance: improve readability of
 strategies
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251024-pks-maintenance-geometric-strategy-v3-6-9b5b3bdb4387@pks.im>
References: <20251024-pks-maintenance-geometric-strategy-v3-0-9b5b3bdb4387@pks.im>
In-Reply-To: <20251024-pks-maintenance-geometric-strategy-v3-0-9b5b3bdb4387@pks.im>
To: git@vger.kernel.org
Cc: Derrick Stolee <stolee@gmail.com>, Taylor Blau <me@ttaylorr.com>, 
 Justin Tobler <jltobler@gmail.com>, Junio C Hamano <gitster@pobox.com>
X-Mailer: b4 0.14.3

Our maintenance strategies are essentially a large array of structures,
where each of the tasks can be enabled and scheduled individually. With
the current layout though all the configuration sits on the same nesting
layer, which makes it a bit hard to discern which initialized fields
belong to what task.

Improve readability of the individual tasks by using nested designated
initializers instead.

Suggested-by: Taylor Blau <me@ttaylorr.com>
Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/gc.c | 36 +++++++++++++++++++++++++-----------
 1 file changed, 25 insertions(+), 11 deletions(-)

diff --git a/builtin/gc.c b/builtin/gc.c
index 726d944d3bd..0ba6e59de14 100644
--- a/builtin/gc.c
+++ b/builtin/gc.c
@@ -1835,23 +1835,37 @@ struct maintenance_strategy {
 };
 
 static const struct maintenance_strategy none_strategy = { 0 };
+
 static const struct maintenance_strategy default_strategy = {
 	.tasks = {
-		[TASK_GC].enabled = 1,
+		[TASK_GC] = {
+			.enabled = 1,
+		},
 	},
 };
+
 static const struct maintenance_strategy incremental_strategy = {
 	.tasks = {
-		[TASK_COMMIT_GRAPH].enabled = 1,
-		[TASK_COMMIT_GRAPH].schedule = SCHEDULE_HOURLY,
-		[TASK_PREFETCH].enabled = 1,
-		[TASK_PREFETCH].schedule = SCHEDULE_HOURLY,
-		[TASK_INCREMENTAL_REPACK].enabled = 1,
-		[TASK_INCREMENTAL_REPACK].schedule = SCHEDULE_DAILY,
-		[TASK_LOOSE_OBJECTS].enabled = 1,
-		[TASK_LOOSE_OBJECTS].schedule = SCHEDULE_DAILY,
-		[TASK_PACK_REFS].enabled = 1,
-		[TASK_PACK_REFS].schedule = SCHEDULE_WEEKLY,
+		[TASK_COMMIT_GRAPH] = {
+			.enabled = 1,
+			.schedule = SCHEDULE_HOURLY,
+		},
+		[TASK_PREFETCH] = {
+			.enabled = 1,
+			.schedule = SCHEDULE_HOURLY,
+		},
+		[TASK_INCREMENTAL_REPACK] = {
+			.enabled = 1,
+			.schedule = SCHEDULE_DAILY,
+		},
+		[TASK_LOOSE_OBJECTS] = {
+			.enabled = 1,
+			.schedule = SCHEDULE_DAILY,
+		},
+		[TASK_PACK_REFS] = {
+			.enabled = 1,
+			.schedule = SCHEDULE_WEEKLY,
+		},
 	},
 };
 

-- 
2.51.1.930.gacf6e81ea2.dirty

