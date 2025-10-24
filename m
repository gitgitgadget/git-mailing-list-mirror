Received: from fout-a5-smtp.messagingengine.com (fout-a5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBB9928A72B
	for <git@vger.kernel.org>; Fri, 24 Oct 2025 06:57:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761289074; cv=none; b=dpw/jyBug/UK36YHVT4qFJEMJsAnfmP/pPRjKlM96unPJKt4NlZT/co30iUNZOvVa+PqKcH1uDYEUvNOCXK6do10zaqs0EW1NjgFD55v5tO45oqlD/iUGb5ti/pNXBIgZR0V57Ixt/GIF8XEU2rWlG4/Wh7i+e1gwadH6Qq6c2Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761289074; c=relaxed/simple;
	bh=xA5repudW481pB2ZRIrU/SwC33X1+XdJ6sxr9qgEmXU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=FL1+GJ+ZNe196oSOGg9oOn7zOAGcJA1t6iKt5iJ3MAQwCQygDl2oWKqvBsBa8Oq/wgxrDXQWlAmslsWKoGAHiEQAKEw0aXuBXNPuvlm1x4iN7HbHp05zWHYehG1rO4KConLHcQEMMHjsCVzW4LniGll5t1FhFtzkVhS/QcfCS2o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=ldXCmlDk; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=bCgxPGoA; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="ldXCmlDk";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="bCgxPGoA"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.phl.internal (Postfix) with ESMTP id DA1E2EC0294;
	Fri, 24 Oct 2025 02:57:51 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Fri, 24 Oct 2025 02:57:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1761289071;
	 x=1761375471; bh=sfAq2/hHiKl4A8nDc6LYVpTJPf81j5YME0jCiEbbJTE=; b=
	ldXCmlDkzAlB7Q7xkcSr2R2oM0dqe8ji39nY/WNPW5at2OxSxSNLLzkQjtV2fdEe
	B8WgaP0c6b+pQ/Ru9o8LI3hCRHrkxA7pHShNrdXlxADIEGrH0EdT/CNF64XYriR+
	5CqdJ9tJgSXc2kymS0EKVa5F4T90ddySibHe5UILphu3Xpqdd6YucV92W9moALzt
	iqUnt94xhdjiaPldBg6FOTLGR2VD2iL/ajGbVUilpy+OO8SXfjfIje/SKwUQxSQA
	6cRDt4BIQ4hFPD/gWJcH2pee9hRJ8o/ZC/N0p75MpCXFCdtF4WlkrLVElGcBMIQN
	gRJazQkfCe2kKLORgHwCCw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1761289071; x=
	1761375471; bh=sfAq2/hHiKl4A8nDc6LYVpTJPf81j5YME0jCiEbbJTE=; b=b
	CgxPGoAgCswmfQmVFpnOoobcd0a19egSkQgHE4A1HMg8eu7alQYRIvTBn64mm25E
	J/cYOJyure7jinyJZ9dl/qxeyGnUdwPfDlRB3R21ZrAHR9PRVd/tlFSDZlPz7R1Q
	/kl/FIrHfoC8p8bVafUs5QEtTROWDui2Qee8ucVlA4gl6jiGvuYObzGo4KhJ5jaP
	PKR/otc8TRsyWxJXz0bXBRtp/twYVPdrbE05F8zaqwO6COaw/a7CgD+I5c2lfzF3
	sVBv7apeT6w+ip40amiNxZEmN/5eN0XkJ3TPbwO8mM1k4qO3/asPvbYmyO0BPaxW
	0k7Vc2jjVXWHzzCaR+uDg==
X-ME-Sender: <xms:byP7aOcqfZ-ocxfuZIg5g3SFyFVw-JdNvaFGmLOKK674AvsvGz62lw>
    <xme:byP7aPG091a5s1yLsjpQx8lu7-6CWoFrlIi_Jj1FvoCFmLnS8JPWluyyWJrYAB1BT
    WuLBtWFwBXyfCde6B7alvB-71zj1KN6mQOwEWWPFtNqFYnsP0pjow>
X-ME-Received: <xmr:byP7aH0jRwMyu8BPCUd3wH7S1p-UrOkSa8-XyJI7RCDDY8_DFEg9QiRnNpfjJyYN71zVbvsG6f4DBvqmU1X_NXBgkGnRm-lO7cAAyg34wg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddugeekieejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeffueeiudejvdekheeuvdekfeffiedvueelteekudehjeetkeegvddugfdtgfeileen
    ucevlhhushhtvghrufhiiigvpeehnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhmpdhnsggprhgtphhtthhopeehpdhmohguvgepshhmthhpohhuthdprhgtphht
    thhopehsthholhgvvgesghhmrghilhdrtghomhdprhgtphhtthhopehjlhhtohgslhgvrh
    esghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdho
    rhhgpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomhdprhgtphhtthhope
    hmvgesthhtrgihlhhorhhrrdgtohhm
X-ME-Proxy: <xmx:byP7aHmUCfJugnQQL9vF92hrS6lB78NyGEUjat5sFUm-7-r8Doc1hg>
    <xmx:byP7aH-qGqxR_5-F3AAl0qqIVbmf7u4ylxVr4ZvDNg-RHrI4pXHA4w>
    <xmx:byP7aMoLmY-DjfhUFMNZ-7HKqYQdzY_llddjyWg1LgErH1vWiPAaPA>
    <xmx:byP7aAnJMgX7-MGZOHy2JjawyUxKfgIakUmO1O5xjosXEz5rxVP10w>
    <xmx:byP7aN4HIDJIImzjC5U9LBZTi5SjtbjGgb5aWCtJApmOFGvxliwafDVS>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 24 Oct 2025 02:57:50 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id d35eb252 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Fri, 24 Oct 2025 06:57:50 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Fri, 24 Oct 2025 08:57:23 +0200
Subject: [PATCH v3 10/10] builtin/maintenance: introduce "geometric"
 strategy
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251024-pks-maintenance-geometric-strategy-v3-10-9b5b3bdb4387@pks.im>
References: <20251024-pks-maintenance-geometric-strategy-v3-0-9b5b3bdb4387@pks.im>
In-Reply-To: <20251024-pks-maintenance-geometric-strategy-v3-0-9b5b3bdb4387@pks.im>
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
index 85e0cea4d96..0d76693feec 100755
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

