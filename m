Received: from fhigh-a6-smtp.messagingengine.com (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79EDF2E8B7D
	for <git@vger.kernel.org>; Mon, 27 Oct 2025 08:31:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761553892; cv=none; b=Ab9viVPy9zWermqUxBikwKVdNrrRz1rnFPBbdtUNh1E3hfxiK2iJTBmQyjeS5vE/09O4arn09PZxSDygfn/Z37oamp/ggIwk5w+vsShjbv4X1ISb/x1mJ+dY5CLlaxJsZ/eLlmvqGdKRHUgjJVwnEwqGxYuyW+9b7m+AxH2qhWA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761553892; c=relaxed/simple;
	bh=qkbvh2ayNDiOLfbtOoBcCDoQ+rQWkGRNxnIzPsE9JxU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=n0CffOeOHJJMbPuveXk0ngd1iQXtZnOfbTqGnta6kOueOoU/L/upc8ez5t9bPy29fw1/uKhMZqZbw8FhCBe/LrKW98MWIidct8uQTTzPxZAKH4nKVMIpX4+2/fbzMc22RRSUKuiLeGGRcIv+UgdT58upK2exG03vrXVhpgHRKnE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=EQ+zE9oa; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=gg9R7Bao; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="EQ+zE9oa";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="gg9R7Bao"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 9961A14000BB;
	Mon, 27 Oct 2025 04:31:29 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Mon, 27 Oct 2025 04:31:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1761553889;
	 x=1761640289; bh=0FE3te9W3PiB+uwI2V2CM20YRGJ8XbKYakUgS8g8DCQ=; b=
	EQ+zE9oak0udl7ApaMXNYPfGvlnL/czvroUquaZAal/0X0ZP9SeW6moKl2Vlsw92
	jEqvUzQ8FxdpZtXOteDOXys69o5DgbgCKhIf8xZ0mUxcf82FK29/5j2qwDbmIhPy
	zgHoFK2YFX8QBGuOg5y11SCRYOe6h6D585dJNRe1WTnx38dycCl5zvJHWngloQVx
	wheAvzNuaaGvOHLxJjIgUClA1T3UwQt3Eoj1Qv1aT5RAnKZv5YRMfK8QvDugAiAW
	lSpOkTN7u197/L3/NLW8S1aKiFvbjK/00uDhbwC/WKeg+jekgpVqHxUJwdUzfF6Y
	Q0ritbDqDCSxFaCAwAmAAQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1761553889; x=
	1761640289; bh=0FE3te9W3PiB+uwI2V2CM20YRGJ8XbKYakUgS8g8DCQ=; b=g
	g9R7BaoYIBlxUyNLcOnIRjYlP2CKPvQ5sAHX3SjBUJeR8y4qLcoqixvhw7kXYOLi
	guZdiz0wivuzbWXXemBAQAErmzMAIueSAWSkzHrMQ3GfMCBfWkyFO87rUl4tivYL
	P9njgOx7Q/Uc7jQLRG9zsy9LpXbEU13FfuXfKpycAh+J9Dp+PhhGZfuvoV90Fy44
	NeaP5PV4A6jHB6DBXYAT3kslQH5o0bLIjLaRkYgRO+kFnIW0Mv0uKPXP6Epxh5pc
	cQ8cIivqiJiS7AJvEGkXfESvexz8d6S9BCE5Asl2XakKDMbmUrZ8OpWnsslS56u5
	K6b5HqTX2ZDIFNj0vLHHQ==
X-ME-Sender: <xms:4S3_aAwqekY0khxOMys8lkEYmhMFMNOQELkQK1mzAxc0PKhbLJaQgg>
    <xme:4S3_aLKVBwpKi2vLCvRP1gkpljztIeXJH66T8I4Btz3Q01-qk_Gvg95r1iRAPcseH
    Pi0LTfIATGhEkQP_KdHLtbJxurMFTvzYy-F-MU6_V06Q0TaEDbKdQ>
X-ME-Received: <xmr:4S3_aKo74xRvJtRaj0k0_EVbfY4nO_UKo5WGzPdICdzReMTO-PcegpIL80N9QXk7Ojs7DBIS2Yy0CGn07V5EuNqzzQ_XNnyXnnPi0aaJkA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdduheejgeelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeffueeiudejvdekheeuvdekfeffiedvueelteekudehjeetkeegvddugfdtgfeileen
    ucevlhhushhtvghrufhiiigvpeefnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhmpdhnsggprhgtphhtthhopeehpdhmohguvgepshhmthhpohhuthdprhgtphht
    thhopehjlhhtohgslhgvrhesghhmrghilhdrtghomhdprhgtphhtthhopehsthholhgvvg
    esghhmrghilhdrtghomhdprhgtphhtthhopehmvgesthhtrgihlhhorhhrrdgtohhmpdhr
    tghpthhtohepghhithhsthgvrhesphhosghogidrtghomhdprhgtphhtthhopehgihhtse
    hvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:4S3_aKJNtP4iEj4iF_0eszauSF7xyBBildmsDJQ3AZfHKtNwxetMwA>
    <xmx:4S3_aPRW8rJMvRBBqYPiIqU-E_EH9CSOzKS_14zfh1ujuMeHJTlkGg>
    <xmx:4S3_aJuXOrA1K9voWGtqlyBVBsxHRDUVz1jOPOYTg6VtNJSah-fz2A>
    <xmx:4S3_aAYXRTA9O8kz2ECcn9J-Zv54vWe058_d_Cp2-Y4RHpyzrWlUCg>
    <xmx:4S3_aCipZWkChncNiJ-ylIOGblw7-lBJ4VKy4-J8Oi2zaiEiO6Dx6LjY>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 27 Oct 2025 04:31:28 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 4ea87396 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Mon, 27 Oct 2025 08:31:27 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Mon, 27 Oct 2025 09:31:00 +0100
Subject: [PATCH v4 10/10] builtin/maintenance: introduce "geometric"
 strategy
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251027-pks-maintenance-geometric-strategy-v4-10-18049e4a0adf@pks.im>
References: <20251027-pks-maintenance-geometric-strategy-v4-0-18049e4a0adf@pks.im>
In-Reply-To: <20251027-pks-maintenance-geometric-strategy-v4-0-18049e4a0adf@pks.im>
To: git@vger.kernel.org
Cc: Derrick Stolee <stolee@gmail.com>, Taylor Blau <me@ttaylorr.com>, 
 Justin Tobler <jltobler@gmail.com>, Junio C Hamano <gitster@pobox.com>
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
 builtin/gc.c                          | 31 +++++++++++++++++++++++++++++++
 t/t7900-maintenance.sh                | 20 +++++++++++++++++++-
 3 files changed, 59 insertions(+), 1 deletion(-)

diff --git a/Documentation/config/maintenance.adoc b/Documentation/config/maintenance.adoc
index b2bacdc8220..d0c38f03fab 100644
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
index 8cab1450095..19be3f87e13 100644
--- a/builtin/gc.c
+++ b/builtin/gc.c
@@ -1891,12 +1891,43 @@ static const struct maintenance_strategy incremental_strategy = {
 	},
 };
 
+static const struct maintenance_strategy geometric_strategy = {
+	.tasks = {
+		[TASK_COMMIT_GRAPH] = {
+			.type = MAINTENANCE_TYPE_SCHEDULED | MAINTENANCE_TYPE_MANUAL,
+			.schedule = SCHEDULE_HOURLY,
+		},
+		[TASK_GEOMETRIC_REPACK] = {
+			.type = MAINTENANCE_TYPE_SCHEDULED | MAINTENANCE_TYPE_MANUAL,
+			.schedule = SCHEDULE_DAILY,
+		},
+		[TASK_PACK_REFS] = {
+			.type = MAINTENANCE_TYPE_SCHEDULED | MAINTENANCE_TYPE_MANUAL,
+			.schedule = SCHEDULE_DAILY,
+		},
+		[TASK_RERERE_GC] = {
+			.type = MAINTENANCE_TYPE_SCHEDULED | MAINTENANCE_TYPE_MANUAL,
+			.schedule = SCHEDULE_WEEKLY,
+		},
+		[TASK_REFLOG_EXPIRE] = {
+			.type = MAINTENANCE_TYPE_SCHEDULED | MAINTENANCE_TYPE_MANUAL,
+			.schedule = SCHEDULE_WEEKLY,
+		},
+		[TASK_WORKTREE_PRUNE] = {
+			.type = MAINTENANCE_TYPE_SCHEDULED | MAINTENANCE_TYPE_MANUAL,
+			.schedule = SCHEDULE_WEEKLY,
+		},
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
index 65417a1e9c3..614184a0978 100755
--- a/t/t7900-maintenance.sh
+++ b/t/t7900-maintenance.sh
@@ -930,11 +930,29 @@ test_expect_success 'maintenance.strategy is respected' '
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
2.51.1.930.gacf6e81ea2.dirty

