Received: from fout-a5-smtp.messagingengine.com (fout-a5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 662EB33DEDE
	for <git@vger.kernel.org>; Tue, 21 Oct 2025 14:13:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761056035; cv=none; b=ajXcBNO8d133PUHKyazPFVo3LfJZ+VKTSOqzQhIp34sfhRr+P+BbeRv6b8yOd0JBiJqVFf19xbWU13b1KsdGS8UZiTzfvCoEgK+oltpBBDFKk474PlWVAdK16jZRkENZNtkueqiaFqrsm617wRNzN9JZ2bg2kzQrAtq/envSqNw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761056035; c=relaxed/simple;
	bh=dD4sdiaIyBWJslPS4h2ObgiqG8fZdD6zTOdXxtKlhBU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=O6/u97dbnNy80rh09dygCmH7ha2dh9TDwHbJCBImIlfvtPW9CqxSVIgHBsE8lMKQaqS0s9I7saX4GAphQquXXlcHtL5/d8mTGsXij3w7/SvQN5dA/aqz8yyNqFXAiFylMbWLMIDvH6uM4+wg99wx7Sw0P/cDfv/cM2ezHYjT5mk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=gIxmARj9; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=OLuv4zyI; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="gIxmARj9";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="OLuv4zyI"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.phl.internal (Postfix) with ESMTP id B5C29EC0108;
	Tue, 21 Oct 2025 10:13:52 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Tue, 21 Oct 2025 10:13:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1761056032;
	 x=1761142432; bh=D4WHY5pFRBfGc+q2zO+lrjC5b30mY+me/vJO4iWwIB4=; b=
	gIxmARj9cO2YEdUCzoq+g8kT1tcMA3aA8DyT/eHQMzSfEKeGNlsJIi3FBKS6rpYd
	c4bRhLZKeJICrnRuZ3Uc5Nlcd8bFGAnPFPP7RVsxCILz+YzFX+gqFfi9Wk4f7ojI
	bmpmqrHdqwm/dyvHZnRQPckQpAzm+TzlrA7xNcnUF+XoIHcv6E18IEfF17iBCXQF
	m2J2nzLWEyrzCeVV2uxiYrkiE9manc9DDO+GXiL+PT1vgnN5+ouJ+l2jHSzMFITu
	x8dliUdMKxCHUNHsvmbUxtfxo7s0HzGCI4XH6KAcVJ6Swx84ruvtCf6opDWGrChW
	yTocdYgWk6S1oUjgYhCZBw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1761056032; x=
	1761142432; bh=D4WHY5pFRBfGc+q2zO+lrjC5b30mY+me/vJO4iWwIB4=; b=O
	Luv4zyI0AJKNrqFoDTtisf0CcocBwI4F62hhpu2TJpnZ4DHGRntSqqedD7z/Q+yE
	9e+mNNibyC2vHLK6p3Ddkfs8chfrRg+cuoIyWhrhMnHuvdu1Sq1LVWQGQdIryXha
	fHFiUlm0ds5Iklx3iYAd0/fILNrAvSzk2iCS4jqUyY4R5oeyxPNMMBe3L4SEjH/8
	Yd/Sk+15dHNub/gHkq/nv5bYYwoCZkthVlRAY9LRxoxmOyUkzt0tjtBudY1KDEM8
	EUh5guUXSH7Y2aFFKFP9yTKGaqiBOxV7WjfzukR2rrAsOXw5mdYLD1n63b00JFTa
	2K5dLhgj7juinzPNgZy6A==
X-ME-Sender: <xms:IJX3aI4-HUcNapOJpUnK6zm2BaUVkHoMqIbYOQyaVwqIraS9eQWeew>
    <xme:IJX3aBUuYQ7C6AWKNddEf3xkaaQ_nd_UZvWSSDUpwoe0wgBOjvOw13ogNh1LqaUAZ
    RnTNHMrAeYqHhGZ8NROVZZsz59uvFX8WZzSlQ_3KUGMhknrT8g4xw>
X-ME-Received: <xmr:IJX3aE2FoVTShcK3YvVv8dpxQrmif1jtAtcLCU9ptiL4H36PpeVlva3xkLpCsEl2noEy3Hr_zQ4XrxdCyzcx9y8ZsVXrM3mmiOoZzIfn8UJ62A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddugedtledtucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeffueeiudejvdekheeuvdekfeffiedvueelteekudehjeetkeegvddugfdtgfeileen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhmpdhnsggprhgtphhtthhopeefpdhmohguvgepshhmthhpohhuthdprhgtphht
    thhopehsthholhgvvgesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrh
    drkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepmhgvsehtthgrhihlohhrrhdrtghomh
X-ME-Proxy: <xmx:IJX3aG1zT7jnP8m35fILzlKDjd6x-8X7FUGfhusy3tFov9U1sKFiPA>
    <xmx:IJX3aP-OZTR1ociR_VtHNo_Oe5lMoOgcLqUfLe_cWcdfsd5zDpzS4Q>
    <xmx:IJX3aL19XI3qC6NH6MhlJf2KakOUv_YHoMq6m3eoVnBc2y2y19U40A>
    <xmx:IJX3aE9haIf_m3Zu96titNp8JjZLQe1fA6h9nqijs-lqHeTck3MQlg>
    <xmx:IJX3aMxFQR5qTU8pxhr4S-0Hnleu4YYO1n6aI88idjaEMfwKzMl-73Pg>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 21 Oct 2025 10:13:51 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 9aa82f07 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Tue, 21 Oct 2025 14:13:51 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Tue, 21 Oct 2025 16:13:31 +0200
Subject: [PATCH v2 9/9] builtin/maintenance: introduce "geometric" strategy
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251021-pks-maintenance-geometric-strategy-v2-9-f0d727832b80@pks.im>
References: <20251021-pks-maintenance-geometric-strategy-v2-0-f0d727832b80@pks.im>
In-Reply-To: <20251021-pks-maintenance-geometric-strategy-v2-0-f0d727832b80@pks.im>
To: git@vger.kernel.org
Cc: Derrick Stolee <stolee@gmail.com>, Taylor Blau <me@ttaylorr.com>
X-Mailer: b4 0.14.3

We have two different repacking strategies in Git:

  - The "gc" strategy uses git-gc(1).

  - The "incremental" strategy uses multi-pack indices and `git
    multi-pack-index repack` to merge together smaller packfiles as
    determined by a specific batch size.

The former strategy is our old and trusted default, whereas the latter
has historically been used for our scheduled maintenance. But both
strategies have their shortcomings:

  - The "gc" strategy performs regular all-into-one repacks. Furthermore
    it is rather inflexible, as it is not easily possible for a user to
    enable or disable specific subtasks.

  - The "incremental" strategy is not a full replacement for the "gc"
    strategy as it doesn't know to prune stale data.

So today, we don't have a strategy that is well-suited for large repos
while being a full replacement for the "gc" strategy.

Introduce a new "geometric" strategy that aims to fill this gap. This
strategy invokes all the usual cleanup tasks that git-gc(1) does like
pruning reflogs and rerere caches as well as stale worktrees. But where
it differs from both the "gc" and "incremental" strategy is that it uses
our geometric repacking infrastructure exposed by git-repack(1) to
repack packfiles. The advantage of geometric repacking is that we only
need to perform an all-into-one repack when the object count in a repo
has grown significantly.

One downside of this strategy is that pruning of unreferenced objects is
not going to happen regularly anymore. Every geometric repack knows to
soak up all loose objects regardless of their reachability, and merging
two or more packs doesn't consider reachability, either. Consequently,
the number of unreachable objects will grow over time.

This is remedied by doing an all-into-one repack instead of a geometric
repack whenever we determine that the geometric repack would end up
merging all packfiles anyway. This all-into-one repack then performs our
usual reachability checks and writes unreachable objects into a cruft
pack. As cruft packs won't ever be merged during geometric repacks we
can thus phase out these objects over time.

Of course, this still means that we retain unreachable objects for far
longer than with the "gc" strategy. But the maintenance strategy is
intended especially for large repositories, where the basic assumption
is that the set of unreachable objects will be significantly dwarfed by
the number of reachable objects.

If this assumption is ever proven to be too disadvantageous we could for
example introduce a time-based strategy: if the largest packfile has not
been touched for longer than $T, we perform an all-into-one repack. But
for now, such a mechanism is deferred into the future as it is not clear
yet whether it is needed in the first place.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 Documentation/config/maintenance.adoc |  9 +++++++++
 builtin/gc.c                          | 19 +++++++++++++++++++
 t/t7900-maintenance.sh                | 20 +++++++++++++++++++-
 3 files changed, 47 insertions(+), 1 deletion(-)

diff --git a/Documentation/config/maintenance.adoc b/Documentation/config/maintenance.adoc
index b2bacdc822..d0c38f03fa 100644
--- a/Documentation/config/maintenance.adoc
+++ b/Documentation/config/maintenance.adoc
@@ -32,6 +32,15 @@ The possible strategies are:
   strategy for scheduled maintenance.
 * `gc`: This strategy runs the `gc` task. This is the default strategy for
   manual maintenance.
+* `geometric`: This strategy performs geometric repacking of packfiles and
+  keeps auxiliary data structures up-to-date. The strategy expires data in the
+  reflog and removes worktrees that cannot be located anymore. When the
+  geometric repacking strategy would decide to do an all-into-one repack, then
+  the strategy generates a cruft pack for all unreachable objects. Objects that
+  are already part of a cruft pack will be expired.
++
+This repacking strategy is a full replacement for the `gc` strategy and is
+recommended for large repositories.
 * `incremental`: This setting optimizes for performing small maintenance
   activities that do not delete any data. This does not schedule the `gc`
   task, but runs the `prefetch` and `commit-graph` tasks hourly, the
diff --git a/builtin/gc.c b/builtin/gc.c
index aaff0bae15..9739bb0ea2 100644
--- a/builtin/gc.c
+++ b/builtin/gc.c
@@ -1878,12 +1878,31 @@ static const struct maintenance_strategy incremental_strategy = {
 	},
 };
 
+static const struct maintenance_strategy geometric_strategy = {
+	.tasks = {
+		[TASK_COMMIT_GRAPH].type = MAINTENANCE_TYPE_SCHEDULED | MAINTENANCE_TYPE_MANUAL,
+		[TASK_COMMIT_GRAPH].schedule = SCHEDULE_HOURLY,
+		[TASK_GEOMETRIC_REPACK].type = MAINTENANCE_TYPE_SCHEDULED | MAINTENANCE_TYPE_MANUAL,
+		[TASK_GEOMETRIC_REPACK].schedule = SCHEDULE_DAILY,
+		[TASK_PACK_REFS].type = MAINTENANCE_TYPE_SCHEDULED | MAINTENANCE_TYPE_MANUAL,
+		[TASK_PACK_REFS].schedule = SCHEDULE_DAILY,
+		[TASK_RERERE_GC].type = MAINTENANCE_TYPE_SCHEDULED | MAINTENANCE_TYPE_MANUAL,
+		[TASK_RERERE_GC].schedule = SCHEDULE_WEEKLY,
+		[TASK_REFLOG_EXPIRE].type = MAINTENANCE_TYPE_SCHEDULED | MAINTENANCE_TYPE_MANUAL,
+		[TASK_REFLOG_EXPIRE].schedule = SCHEDULE_WEEKLY,
+		[TASK_WORKTREE_PRUNE].type = MAINTENANCE_TYPE_SCHEDULED | MAINTENANCE_TYPE_MANUAL,
+		[TASK_WORKTREE_PRUNE].schedule = SCHEDULE_WEEKLY,
+	},
+};
+
 static struct maintenance_strategy parse_maintenance_strategy(const char *name)
 {
 	if (!strcasecmp(name, "incremental"))
 		return incremental_strategy;
 	if (!strcasecmp(name, "gc"))
 		return gc_strategy;
+	if (!strcasecmp(name, "geometric"))
+		return geometric_strategy;
 	die(_("unknown maintenance strategy: '%s'"), name);
 }
 
diff --git a/t/t7900-maintenance.sh b/t/t7900-maintenance.sh
index 2770148fd1..aedb9e7e8e 100755
--- a/t/t7900-maintenance.sh
+++ b/t/t7900-maintenance.sh
@@ -931,11 +931,29 @@ test_expect_success 'maintenance.strategy is respected' '
 		git gc --quiet --no-detach --skip-foreground-tasks
 		EOF
 
-		test_strategy gc --schedule=weekly <<-\EOF
+		test_strategy gc --schedule=weekly <<-\EOF &&
 		git pack-refs --all --prune
 		git reflog expire --all
 		git gc --quiet --no-detach --skip-foreground-tasks
 		EOF
+
+		test_strategy geometric <<-\EOF &&
+		git pack-refs --all --prune
+		git reflog expire --all
+		git repack -d -l --geometric=2 --quiet --write-midx
+		git commit-graph write --split --reachable --no-progress
+		git worktree prune --expire 3.months.ago
+		git rerere gc
+		EOF
+
+		test_strategy geometric --schedule=weekly <<-\EOF
+		git pack-refs --all --prune
+		git reflog expire --all
+		git repack -d -l --geometric=2 --quiet --write-midx
+		git commit-graph write --split --reachable --no-progress
+		git worktree prune --expire 3.months.ago
+		git rerere gc
+		EOF
 	)
 '
 

-- 
2.51.1.851.g4ebd6896fd.dirty

