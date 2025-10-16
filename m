Received: from fhigh-a4-smtp.messagingengine.com (fhigh-a4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BA3E2FB989
	for <git@vger.kernel.org>; Thu, 16 Oct 2025 07:27:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760599629; cv=none; b=NQ0dwq6QMLB9hj8yEq9a3Hof9UZn66uNcykCVdv84W6S+K2224qCucwrO7UWLOZFNBpFQh5R4czHIHEd0qRqufejIOU24uxW3JMs7Ye4UOO5mDCVfd9Yt6FMBlHlKTwj3plduhbGdqt454DBBYotmsPxoNLgnrbROqfyBOhi0Ds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760599629; c=relaxed/simple;
	bh=1VoMbjZErZj/GD2+QjfQTr1LtBunFo+UERzXj14qJfI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=X86gJ3MNsmCnQlwegs1wrGZBfgn4eWc+dgbE0Z9HUrpgFhmiPObU8AnxAxQk4gkq9DRQz0nqYaU6kG1k9pDEh+wvncNTt3cZNqzbjHo+9CErzdqP8y4XctzdWASMOT/jBIKO23k4GMSyadvd1X1ozmHpo49XfZYknARm+NvIls4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=OHMoQwus; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=LpuU1YO5; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="OHMoQwus";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="LpuU1YO5"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 513A81400041;
	Thu, 16 Oct 2025 03:27:06 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Thu, 16 Oct 2025 03:27:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1760599626;
	 x=1760686026; bh=CsVtW2oQz0aazT0DlOPGHQF5za9Ge4Z6dmZGSq8tW8E=; b=
	OHMoQwusBTDJw0Ig2ODRHcGb/pUyOdfsczlH8Hn2kNzmWqtHi7nzVk+RTOaWdsaO
	Y5QM1XNkWrC0uDo8jdaXiaBs4XZKn+4VXu6BR5Kh4W+bgcIDLIjh7uZfcovkGAhr
	C3S4vo73CtKO1YoXi0MmB0e5WBmiAVFpZlywxV4k0FsiLl6rkIKqPVVrcV6pwr7g
	TH7PaZWmbCrCyRgpPoNhuHjxR++aNsMEIW6aNyjnO2YH8lvlCcz2Wll0ESI45Qc6
	vCDUvLVRp74/vQAwCQd9e6OE/SErg+xZt3uh5mY6LNHTROUBB/qFWIRpzw9egsbC
	K4dEotKm0mqiwEt+lyBlow==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1760599626; x=
	1760686026; bh=CsVtW2oQz0aazT0DlOPGHQF5za9Ge4Z6dmZGSq8tW8E=; b=L
	puU1YO5jHd7zZ65It/rY8o84K3kNVVQGksze55Nwl+pahMsWQF26YUvpDuwJZxIa
	kchtCPvgirdPPQHQYDTqgi+HCsyyELv0NoaqUHCC4uIxLgk/2K9Vd2HQObPvQonX
	VSiX4ACo+vhY5jqNJGzoBrLau/fKIDVJ2jEJdQwXNx9vb5xLhF2XQeLzfUfzTASJ
	QhF4KCJ4ciuk7gL5Z4PEzqJx3C71cSPmhzfROyV2bb3rFCqI+QDV8OqFpFwOps9R
	buT9+FHeQAa6AFn4Kkmo65Y5j960wLbhjUlQBsz+llkWOEpFLp6cttSFsFf/BjBT
	uCV6hJbavoohWggY/UkPQ==
X-ME-Sender: <xms:Sp7waLn3Q-iW-5WwSuRixwjrxUUapkTtwgBA4-H2-niy2JZb-CCbXA>
    <xme:Sp7waGSn3nM2XUdCO-Rr9aFyf9Li8HK21QX7geFP8D5MtUpfc3ciDPWB9GFYfMNHq
    FX1MrekInwv4PYODO3bs7q9LMepUXyJGu_D2iUJ9CQW0waM8oziJg>
X-ME-Received: <xmr:Sp7waPAl35wT4XuzY1T1gvYtpvYkh7fn32MVCG4vP-DBqcDjha65m-b1Xq-XSsCggD76K7wCypef1gduux9mY8Ap3OR76L0hLXBiamfJAB7nCw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdduvdehieelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeffueeiudejvdekheeuvdekfeffiedvueelteekudehjeetkeegvddugfdtgfeileen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhmpdhnsggprhgtphhtthhopeefpdhmohguvgepshhmthhpohhuthdprhgtphht
    thhopehmvgesthhtrgihlhhorhhrrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrd
    hkvghrnhgvlhdrohhrghdprhgtphhtthhopehsthholhgvvgesghhmrghilhdrtghomh
X-ME-Proxy: <xmx:Sp7waNRKI0n25winofCssHtSKO24vCGMKb_S3G0xqZhlqZ0dizVp4w>
    <xmx:Sp7waNrPEhf-ICFezwgK6nchzfcRH2AJj6SpSjOzZ3p7iU9NUiZE3Q>
    <xmx:Sp7waPzcSW2X14Ob2Hp4X9u7jfHoVaY4bICHMKArVyLzeWlCWWQVxQ>
    <xmx:Sp7waCKJIJMO_iZiZFJH0adzblFaE0PB7ACvEgCP4MavPHeenMNKVg>
    <xmx:Sp7waGtgxRYRr9Ba9exU03d4s2H_1qcOP0H4hbSowuDotvBHfeUrO8UB>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 16 Oct 2025 03:27:05 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 0b21892d (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Thu, 16 Oct 2025 07:27:05 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Thu, 16 Oct 2025 09:26:38 +0200
Subject: [PATCH 7/8] builtin/maintenance: make "gc" strategy accessible
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251016-pks-maintenance-geometric-strategy-v1-7-18943d474203@pks.im>
References: <20251016-pks-maintenance-geometric-strategy-v1-0-18943d474203@pks.im>
In-Reply-To: <20251016-pks-maintenance-geometric-strategy-v1-0-18943d474203@pks.im>
To: git@vger.kernel.org
Cc: Derrick Stolee <stolee@gmail.com>, Taylor Blau <me@ttaylorr.com>
X-Mailer: b4 0.14.3

While the user can pick the "incremental" maintenance strategy, it is
not possible to explicitly use the "gc" strategy. This has two
downsides:

  - It is impossible to use the default "gc" strategy for a specific
    repository when the strategy was globally set to a different strategy.

  - It is not possible to use git-gc(1) for scheduled maintenance.

Address these issues by making making the "gc" strategy configurable.
Furthermore, extend the strategy so that git-gc(1) runs for both manual
and scheduled maintenance.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 Documentation/config/maintenance.adoc |  2 ++
 builtin/gc.c                          |  9 ++++++---
 t/t7900-maintenance.sh                | 14 +++++++++++++-
 3 files changed, 21 insertions(+), 4 deletions(-)

diff --git a/Documentation/config/maintenance.adoc b/Documentation/config/maintenance.adoc
index dc6fd9b7fda..648b6db47c6 100644
--- a/Documentation/config/maintenance.adoc
+++ b/Documentation/config/maintenance.adoc
@@ -30,6 +30,8 @@ The possible strategies are:
 +
 * `none`: This strategy implies no tasks are run at all. This is the default
   strategy for scheduled maintenance.
+* `gc`: This strategy runs the `gc` task. This is the default strategy for
+  manual maintenance.
 * `incremental`: This setting optimizes for performing small maintenance
   activities that do not delete any data. This does not schedule the `gc`
   task, but runs the `prefetch` and `commit-graph` tasks hourly, the
diff --git a/builtin/gc.c b/builtin/gc.c
index 971d557d370..3673f3db630 100644
--- a/builtin/gc.c
+++ b/builtin/gc.c
@@ -1836,9 +1836,10 @@ struct maintenance_strategy {
 
 static const struct maintenance_strategy none_strategy = { 0 };
 
-static const struct maintenance_strategy default_strategy = {
+static const struct maintenance_strategy gc_strategy = {
 	.tasks = {
-		[TASK_GC].type = MAINTENANCE_TYPE_MANUAL,
+		[TASK_GC].type = MAINTENANCE_TYPE_MANUAL | MAINTENANCE_TYPE_SCHEDULED,
+		[TASK_GC].schedule = SCHEDULE_DAILY,
 	},
 };
 
@@ -1874,6 +1875,8 @@ static struct maintenance_strategy parse_maintenance_strategy(const char *name)
 {
 	if (!strcasecmp(name, "incremental"))
 		return incremental_strategy;
+	if (!strcasecmp(name, "gc"))
+		return gc_strategy;
 	die(_("unknown maintenance strategy: '%s'"), name);
 }
 
@@ -1917,7 +1920,7 @@ static void initialize_task_config(struct maintenance_run_opts *opts,
 		strategy = none_strategy;
 		type = MAINTENANCE_TYPE_SCHEDULED;
 	} else {
-		strategy = default_strategy;
+		strategy = gc_strategy;
 		type = MAINTENANCE_TYPE_MANUAL;
 	}
 
diff --git a/t/t7900-maintenance.sh b/t/t7900-maintenance.sh
index 439f1bfba0c..1acd701830e 100755
--- a/t/t7900-maintenance.sh
+++ b/t/t7900-maintenance.sh
@@ -882,7 +882,7 @@ test_expect_success 'maintenance.strategy is respected' '
 		git gc --quiet --no-detach --skip-foreground-tasks
 		EOF
 
-		test_strategy incremental --schedule=weekly <<-\EOF
+		test_strategy incremental --schedule=weekly <<-\EOF &&
 		git pack-refs --all --prune
 		git prune-packed --quiet
 		git multi-pack-index write --no-progress
@@ -890,6 +890,18 @@ test_expect_success 'maintenance.strategy is respected' '
 		git multi-pack-index repack --no-progress --batch-size=1
 		git commit-graph write --split --reachable --no-progress
 		EOF
+
+		test_strategy gc <<-\EOF &&
+		git pack-refs --all --prune
+		git reflog expire --all
+		git gc --quiet --no-detach --skip-foreground-tasks
+		EOF
+
+		test_strategy gc --schedule=weekly <<-\EOF
+		git pack-refs --all --prune
+		git reflog expire --all
+		git gc --quiet --no-detach --skip-foreground-tasks
+		EOF
 	)
 '
 

-- 
2.51.0.869.ge66316f041.dirty

