Received: from fhigh-a4-smtp.messagingengine.com (fhigh-a4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27CE82FFF9B
	for <git@vger.kernel.org>; Thu, 16 Oct 2025 07:27:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760599632; cv=none; b=DRw7FWQY9/tclaha5dqbYKEzGEHD7NxORew1vdBIezAjncPht62jfMY1PpRsi8Ou8Sy/GBaeil5UgtlZQ+Eijs8d7BH28Zb/4MI9i1+UCZSTPevgnzMicmNba6/zFcHgVS6L7Sdo3o+SxK6XlpcBfM4vNlvzIZJ+IpZhruQkgg8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760599632; c=relaxed/simple;
	bh=UVrFbchjtuzidecFZxTbvUs4iTwVpaxfMk6oucdmk+w=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=a7YSa4F4M1vyJe08Pi6riQMDsOh7ve6MjKlrXcx8HBKlvW4hlLEtzjdieyWq0+VCPkUWexxLmEZwZsPdhiamDz5gnmqKANqtp1KedLJgnl0OWiOgqkjGOyCtBhkbXy/lTkLchJ0tk71G2TPj9MjL92nNAFqIgvZsbfEzCwRUlRU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=rO5llCMH; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=wkq8XKlu; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="rO5llCMH";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="wkq8XKlu"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 545961400097;
	Thu, 16 Oct 2025 03:27:09 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Thu, 16 Oct 2025 03:27:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1760599629;
	 x=1760686029; bh=7Rg9SvE0PWWGfmgJS9cYhNC0lwNiTgb3YPE+VNXtP+g=; b=
	rO5llCMHy+7nIxssKS3AAFw6dysIJ19LSN2SwSoSfElrCzHZb5o5VS6/K6JqCMsZ
	feWpMM0Tn0O6DxbwlhfkuSs7IOEFH0JChCrzyMZLqfIBeW+6F8mP+2ib5ukwAQxI
	KxgAEwvC8Wc0brpqCduRweiRz7u+VUI1Duuuc+/OZ+WxZVdECp7qlH6TLSlhiOtp
	E4OkNT082UcKhIjkeiridH3uRgCyE3WyxspCwm5qY8RTrabaWs3UHd3t/zQZoL5W
	lobin0o29dpaEkxBUEwReXGYqGbmacbbatI70ENOZpyLAdZ6mvoZ3oQpRGE/tMsY
	iCfi76wujyh0F3CQAq5ePQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1760599629; x=
	1760686029; bh=7Rg9SvE0PWWGfmgJS9cYhNC0lwNiTgb3YPE+VNXtP+g=; b=w
	kq8XKlunKEKtewXgQiygagkDM6w5iQUrmzLkY0je5Q7uuUrKK3UNhHVaz3YrK0iw
	oVNyABarkHbJynKIcA5kPzK+yjzxXbnHs3UVS8mq77vnzbIFYq7vPP/ZhdAKJdcE
	s8bQFRb0VoRjnXAa2szTaD77V8D6W5nL3SyNP9OsHw/MaNq+mranYHB+v5GzHnqn
	NInMEqnf+VNQzdjYdCmSmq78dNyURl4ELSB3OwiVdh6TeVlL0eCeaJXwAyWOoiVu
	TbcIMMEiyzZZyWQlHohzFmn0yLJjciKcXNCjGcXi/YgIpmUua4ACcVa1OORk7Hhg
	b1MrPnOqvSYQiZMc585Rw==
X-ME-Sender: <xms:TZ7waAckRRUAxgSe8cTFn94CSe2BXO7OcTKyiP7llVABgGuVHTCOEQ>
    <xme:TZ7waJqYFCfKnlPxIPXKkPdcBT5bs6l63OEBe_i-wkcu55TGLUx_EMtPXg47cHGLR
    7BdeP3vXoXm83DYWV6KbSKFfII_qZkMBEcm-8AFi9jC8HE-X2au>
X-ME-Received: <xmr:TZ7waO5dVZOu48SaO8pqC9GXGNJykfjQ7RdBGBGJzu8FmwXP115EDp0Fc8Uq6g5VpzqsGKFiNY419Ha3RINwbG5iu7brWy_KDXN68HpPeaxuQQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdduvdehieelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeffueeiudejvdekheeuvdekfeffiedvueelteekudehjeetkeegvddugfdtgfeileen
    ucevlhhushhtvghrufhiiigvpedvnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhmpdhnsggprhgtphhtthhopeefpdhmohguvgepshhmthhpohhuthdprhgtphht
    thhopehsthholhgvvgesghhmrghilhdrtghomhdprhgtphhtthhopehmvgesthhtrgihlh
    horhhrrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:TZ7waPpV71GSU0c9tYvIa4RH6EysNkhmSbNEBgqVZ4gqNTUmt2yVKw>
    <xmx:TZ7waAiz_2LHjCilI2196yUApISmUIFrL2bfOzHmxM_vibc2O1apNg>
    <xmx:TZ7waJLrqedZOQyyP8mtynN9bzMEynej6ari7PkZM7zcjfTaSN9kEQ>
    <xmx:TZ7waACDaYGyXtykgg9VV36nqeQJLRamAK3aDJoszAS3hGwpFrykTA>
    <xmx:TZ7waMEUgNPiN42NrKv8C6SiYwiP7yiTC4PeL_ROkAfdkcHIsGDh5b7G>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 16 Oct 2025 03:27:08 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 4bfa94ee (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Thu, 16 Oct 2025 07:27:07 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Thu, 16 Oct 2025 09:26:39 +0200
Subject: [PATCH 8/8] builtin/maintenance: introduce "geometric" strategy
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251016-pks-maintenance-geometric-strategy-v1-8-18943d474203@pks.im>
References: <20251016-pks-maintenance-geometric-strategy-v1-0-18943d474203@pks.im>
In-Reply-To: <20251016-pks-maintenance-geometric-strategy-v1-0-18943d474203@pks.im>
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
index 648b6db47c6..5ab88c2b328 100644
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
index 3673f3db630..bf603de8a2f 100644
--- a/builtin/gc.c
+++ b/builtin/gc.c
@@ -1871,12 +1871,31 @@ static const struct maintenance_strategy incremental_strategy = {
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
index 1acd701830e..bb61b4d7f44 100755
--- a/t/t7900-maintenance.sh
+++ b/t/t7900-maintenance.sh
@@ -897,11 +897,29 @@ test_expect_success 'maintenance.strategy is respected' '
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
2.51.0.869.ge66316f041.dirty

