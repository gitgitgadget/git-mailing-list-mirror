Received: from fhigh-a8-smtp.messagingengine.com (fhigh-a8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75044356749
	for <git@vger.kernel.org>; Mon, 13 Jul 2026 05:52:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783921940; cv=none; b=CrLFntDs9vJvzx+vNkTmB1UOTllvj4dCRT2eFYB5iopY9V0dVo1BlYrJZmO6/xlZVuqrz17H71Aph8+aL+lQNwsOWOJopPSYq4ogOAWoqxEaGod73ojJgUZW+paWEz3/TuuS/MlEhyjANv3JSDKASNJnJAy1QNaaZHzsYhtChH8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783921940; c=relaxed/simple;
	bh=ayiiLcLYb91JfZiSc5/D282/xoFvTVKq38BYrB4ckzI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=JzLzbX08sTubboYEyQgw+pj8v5YL6krVDeXH9G7vNjRVICisHoyF9DscuC14cS7Y73d1KD9B6J+2zGPRP2e9Iqz0iKmfyshj9wQk+teSv75Rqns2zvIY4hA/5118+y6HmIrNRfRr1A7pVlWb4SFqt7rMhy5Csxqk+z/CYLB+LxQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=Pcpmi0fs; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=PVqTxBiP; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Pcpmi0fs";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="PVqTxBiP"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 996411400074;
	Mon, 13 Jul 2026 01:52:17 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Mon, 13 Jul 2026 01:52:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1783921937;
	 x=1784008337; bh=LeGN4den3s1sQSaVgofz+nUYZG5nG8qQRXPmIlptPBA=; b=
	Pcpmi0fsI9zta7xM2xKIa0OdrZf04vQCy7NBu5Q7PUIYTqTiYQ2NncUkGlO1+mbG
	BccbmH6zhEIlNNkGI2UpEtYY3/mKbUxRu0jOI76ujb8AU0klgXbBXARjd97ho2WP
	old9EYMckgjLRxAQoVvbdieIV0Q3Wv25aWJvK8QYlDYb8wHEMebQIhxRR44lgoK2
	57PDJeLqa8gbmejnYSkPiMhhMb9A9bAOlki9rleQqLlHe955E9+7DTbzlj+1HkEo
	QO+MtXrUTNKVED4SslfhZLcCsFr7L++p7bpNKTRu5tIqP03FCnrglk5G9CRA2HxE
	XVXQXnceXXPT/TaR7gtCPA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1783921937; x=
	1784008337; bh=LeGN4den3s1sQSaVgofz+nUYZG5nG8qQRXPmIlptPBA=; b=P
	VqTxBiPFNyEF5645qG5ZGDPbmeCpJmpn766wg9giaUBSdwBo1hsLQPVz/nHykUA+
	I58SqA8Zi5gTMMKkLFd+EsQtJC1Ry1MJNTYNWD98dXjn/2QCSLEzpw8cqyM46W3q
	c+iT26mzf6J/DFwuRpue/0MAXXGy1PQ/cMAfBsQHXNnrRAaNzz0W+SOzYT2Tf33L
	SY3PP3Ij+0ulnv3DjPxb6uXElbXltS/wSQpGnNDbJ+eloWAwtDF5BVqpMGBugiDW
	ipYR0fZU2UoJCSeFsg0r9fbQjnDS9HkFSnfqUIziRgKQJjzqJwpP1YCoWD0ThvTq
	0k7FMlD/Tf1D8Cx6MQBRg==
X-ME-Sender: <xms:EX1UakUJmP7BOxgXj700GEELUKwx1OF_IpyKoeESdgmpr7Bx3at_Tg>
    <xme:EX1UaumPPzm3v3wQhgY_Bsw3Ok0--x8VQiY50yFJmMDJ88RfX6JRNWDr3_PSzHQWn
    bfzn28uxPNuF7IyuzQvhcIZLo_P9EkNHxz1qT7ifEy4dHZt9iLMVQ>
X-ME-Received: <xmr:EX1UamCScGjufWzcHrwMnvntBB3RxQLRcV5muXcvvs7uXXdiYwHe_gskn1-SxctRgR71CYQAkQIXYwDMFMhOJMvRIwSU5vXoD-rlIkwk>
X-ME-Proxy-Cause: dmFkZTFVlBlgcNjg2o3p/KkL+66ltXy35IqcBFfLR5CO3tjSjgJ8ng54RTzVt55TpxWFuU
    7Mb/JTp2qz4tEGM568oYlRNYiubDFZUIXnLW4rLV3Iz49kvP1nXixbbkycdUBWMhp4Yvkk
    951s8qYicEoFHrtapi4FKxCcp9810/t5wFq+xtRSrY2Df5k/T1z+PRpD59P3O0lcmkXiGS
    mzf8Lp7wRXywPSgiOLAlbFIltJnX4TseHUuTn94fi31ah83g1HDzgTQPE97iK7nDpVsGAq
    kPKoQz78ZbQWxjW6I5M5SUjBDS9Ew1gFWvJ30kKVUz+WZQDpLBCgJ5tzmwZhDdxzTirjeh
    9689iLOpmT055OJ7OAlTELMImxMANOgitaS92sqE4Zrj8y3gbMLSdZbycXJopOmAwcrf+b
    3BQLt2Gj7Y2qQBsXxkIYkGtOPPZ+xMs4IqWmXsKfEr/Fgd0LIMg5s4sEPxbXQ38j17yucm
    FOvF8VCTxL0eY9GVGxi8fjflIZr6zgHDhmRJSfz8blbDkvkS3eIlVQrX9GLoK9GgztOCCq
    Jle8kQo7ACvW+v9YwTJZYyBH+ZfCdZ5Df9ELqbBWzg72tnAy0WajnGLy/knZCFVNlMS14s
    NK7qESxjwxNrsCy/SpJzxQK9KCJ1/Mw/0n17RHYVffg14z554C8rMRx6SMsQ
X-ME-Proxy: <xmx:EX1UaufbyvPnOUX1tPrpil7HFay5kCpP0Sx2unpqgrBoxqAFYwqbkg>
    <xmx:EX1UahKpqwMElpKu1rnnCJXakdKTINHDUHEMIz4pmUm1uRt2RxA7UQ>
    <xmx:EX1UahcULeAdhAEDc2NNjSDj2CIGxSxGnf6qCrDxa5TWl-et5l28_Q>
    <xmx:EX1Uao3qBkatt0I_wFkNEpzunFxR2KrLcLxgmKK281qzmPiDPA0img>
    <xmx:EX1UavsdjNipYElySjae1pfEEMJa-EDjceuMP74mlm_cegRNLvzdh6Hv>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 13 Jul 2026 01:52:16 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 6aa7492d (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 13 Jul 2026 05:52:16 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Mon, 13 Jul 2026 07:52:04 +0200
Subject: [PATCH v2 01/12] t7900: simplify how we check for maintenance
 tasks
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260713-b4-pks-odb-optimize-v2-1-9c2c3ee94b38@pks.im>
References: <20260713-b4-pks-odb-optimize-v2-0-9c2c3ee94b38@pks.im>
In-Reply-To: <20260713-b4-pks-odb-optimize-v2-0-9c2c3ee94b38@pks.im>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>
X-Mailer: b4 0.15.2

We have several tests in t7900 that verify whether specific maintenance
tasks did or did not run. This is done rather ad-hoc by checking for
spawned Git commands, which is awfully fragile:

  - We have to adjust tests whenever arguments to the spawned Git
    commands change.

  - We don't have a way to verify that negative matches are still
    working as expected.

  - We rely on maintenance tasks spawning a Git command in the first
    place.

We can do much better though, as we already have trace2 regions for each
of the maintenance tasks. Introduce a helper function that extracts all
such regions so that we can get a direct list of all maintenance tasks
that a certain command ran.

Adapt tests that care about whether or not a specific task ran to use
this new helper. Note that many tests still use `test_subcommand`
though, as they really care about the exact command that was executed.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 t/t7900-maintenance.sh | 194 ++++++++++++++++++++++++++-----------------------
 1 file changed, 102 insertions(+), 92 deletions(-)

diff --git a/t/t7900-maintenance.sh b/t/t7900-maintenance.sh
index d7f82e1bec..129829f1f4 100755
--- a/t/t7900-maintenance.sh
+++ b/t/t7900-maintenance.sh
@@ -23,6 +23,12 @@ test_xmllint () {
 	fi
 }
 
+test_maintenance_tasks () {
+	cat >expect &&
+	sed -ne "s/.*\"region_enter\".*\"category\":\"maintenance\([^\"]*\)\".*\"label\":\"\([^\"][^\"]*\)\".*/\2\1/p" "$1" >actual &&
+	test_cmp expect actual
+}
+
 test_lazy_prereq SYSTEMD_ANALYZE '
 	systemd-analyze verify /lib/systemd/system/basic.target
 '
@@ -180,8 +186,9 @@ test_expect_success 'maintenance.<task>.enabled' '
 	git config maintenance.gc.enabled false &&
 	git config maintenance.commit-graph.enabled true &&
 	GIT_TRACE2_EVENT="$(pwd)/run-config.txt" git maintenance run 2>err &&
-	test_subcommand ! git gc --quiet <run-config.txt &&
-	test_subcommand git commit-graph write --split --reachable --no-progress <run-config.txt
+	test_maintenance_tasks run-config.txt <<-\EOF
+	commit-graph
+	EOF
 '
 
 test_expect_success 'run --task=<task>' '
@@ -189,16 +196,20 @@ test_expect_success 'run --task=<task>' '
 		git maintenance run --task=commit-graph 2>/dev/null &&
 	GIT_TRACE2_EVENT="$(pwd)/run-gc.txt" \
 		git maintenance run --task=gc 2>/dev/null &&
-	GIT_TRACE2_EVENT="$(pwd)/run-commit-graph.txt" \
-		git maintenance run --task=commit-graph 2>/dev/null &&
 	GIT_TRACE2_EVENT="$(pwd)/run-both.txt" \
 		git maintenance run --task=commit-graph --task=gc 2>/dev/null &&
-	test_subcommand ! git gc --quiet --no-detach --skip-foreground-tasks <run-commit-graph.txt &&
-	test_subcommand git gc --quiet --no-detach --skip-foreground-tasks <run-gc.txt &&
-	test_subcommand git gc --quiet --no-detach --skip-foreground-tasks <run-both.txt &&
-	test_subcommand git commit-graph write --split --reachable --no-progress <run-commit-graph.txt &&
-	test_subcommand ! git commit-graph write --split --reachable --no-progress <run-gc.txt &&
-	test_subcommand git commit-graph write --split --reachable --no-progress <run-both.txt
+	test_maintenance_tasks run-commit-graph.txt <<-\EOF &&
+	commit-graph
+	EOF
+	test_maintenance_tasks run-gc.txt <<-\EOF &&
+	gc foreground
+	gc
+	EOF
+	test_maintenance_tasks run-both.txt <<-\EOF
+	gc foreground
+	commit-graph
+	gc
+	EOF
 '
 
 test_expect_success 'core.commitGraph=false prevents write process' '
@@ -235,12 +246,19 @@ test_expect_success 'commit-graph auto condition' '
 	GIT_TRACE2_EVENT="$(pwd)/cg-two-satisfied.txt" \
 		git -c maintenance.commit-graph.auto=2 $COMMAND &&
 
-	COMMIT_GRAPH_WRITE="git commit-graph write --split --reachable --no-progress" &&
-	test_subcommand ! $COMMIT_GRAPH_WRITE <cg-no.txt &&
-	test_subcommand $COMMIT_GRAPH_WRITE <cg-negative-means-yes.txt &&
-	test_subcommand ! $COMMIT_GRAPH_WRITE <cg-zero-means-no.txt &&
-	test_subcommand $COMMIT_GRAPH_WRITE <cg-one-satisfied.txt &&
-	test_subcommand $COMMIT_GRAPH_WRITE <cg-two-satisfied.txt
+	test_maintenance_tasks cg-no.txt <<-\EOF &&
+	EOF
+	test_maintenance_tasks cg-negative-means-yes.txt <<-\EOF &&
+	commit-graph
+	EOF
+	test_maintenance_tasks cg-zero-means-no.txt <<-\EOF &&
+	EOF
+	test_maintenance_tasks cg-one-satisfied.txt <<-\EOF &&
+	commit-graph
+	EOF
+	test_maintenance_tasks cg-two-satisfied.txt <<-\EOF
+	commit-graph
+	EOF
 '
 
 test_expect_success 'commit-graph auto condition with merges' '
@@ -910,24 +928,28 @@ test_expect_success '--schedule inheritance weekly -> daily -> hourly' '
 
 	GIT_TRACE2_EVENT="$(pwd)/hourly.txt" \
 		git maintenance run --schedule=hourly 2>/dev/null &&
-	test_subcommand git prune-packed --quiet <hourly.txt &&
-	test_subcommand ! git commit-graph write --split --reachable \
-		--no-progress <hourly.txt &&
-	test_subcommand ! git multi-pack-index write --no-progress <hourly.txt &&
+	test_maintenance_tasks hourly.txt <<-\EOF &&
+	prefetch
+	loose-objects
+	EOF
 
 	GIT_TRACE2_EVENT="$(pwd)/daily.txt" \
 		git maintenance run --schedule=daily 2>/dev/null &&
-	test_subcommand git prune-packed --quiet <daily.txt &&
-	test_subcommand git commit-graph write --split --reachable \
-		--no-progress <daily.txt &&
-	test_subcommand ! git multi-pack-index write --no-progress <daily.txt &&
+	test_maintenance_tasks daily.txt <<-\EOF &&
+	prefetch
+	loose-objects
+	commit-graph
+	EOF
 
 	GIT_TRACE2_EVENT="$(pwd)/weekly.txt" \
 		git maintenance run --schedule=weekly 2>/dev/null &&
-	test_subcommand git prune-packed --quiet <weekly.txt &&
-	test_subcommand git commit-graph write --split --reachable \
-		--no-progress <weekly.txt &&
-	test_subcommand git multi-pack-index write --no-progress <weekly.txt
+	test_maintenance_tasks weekly.txt <<-\EOF
+	pack-refs foreground
+	prefetch
+	loose-objects
+	incremental-repack
+	commit-graph
+	EOF
 '
 
 test_expect_success 'maintenance.strategy inheritance' '
@@ -946,29 +968,25 @@ test_expect_success 'maintenance.strategy inheritance' '
 	GIT_TRACE2_EVENT="$(pwd)/incremental-weekly.txt" \
 		git maintenance run --schedule=weekly --quiet &&
 
-	test_subcommand git commit-graph write --split --reachable \
-		--no-progress <incremental-hourly.txt &&
-	test_subcommand ! git prune-packed --quiet <incremental-hourly.txt &&
-	test_subcommand ! git multi-pack-index write --no-progress \
-		<incremental-hourly.txt &&
-	test_subcommand ! git pack-refs --all --prune \
-		<incremental-hourly.txt &&
-
-	test_subcommand git commit-graph write --split --reachable \
-		--no-progress <incremental-daily.txt &&
-	test_subcommand git prune-packed --quiet <incremental-daily.txt &&
-	test_subcommand git multi-pack-index write --no-progress \
-		<incremental-daily.txt &&
-	test_subcommand ! git pack-refs --all --prune \
-		<incremental-daily.txt &&
-
-	test_subcommand git commit-graph write --split --reachable \
-		--no-progress <incremental-weekly.txt &&
-	test_subcommand git prune-packed --quiet <incremental-weekly.txt &&
-	test_subcommand git multi-pack-index write --no-progress \
-		<incremental-weekly.txt &&
-	test_subcommand git pack-refs --all --prune \
-		<incremental-weekly.txt &&
+	test_maintenance_tasks incremental-hourly.txt <<-\EOF &&
+	prefetch
+	commit-graph
+	EOF
+
+	test_maintenance_tasks incremental-daily.txt <<-\EOF &&
+	prefetch
+	loose-objects
+	incremental-repack
+	commit-graph
+	EOF
+
+	test_maintenance_tasks incremental-weekly.txt <<-\EOF &&
+	pack-refs foreground
+	prefetch
+	loose-objects
+	incremental-repack
+	commit-graph
+	EOF
 
 	# Modify defaults
 	git config maintenance.commit-graph.schedule daily &&
@@ -980,30 +998,26 @@ test_expect_success 'maintenance.strategy inheritance' '
 	GIT_TRACE2_EVENT="$(pwd)/modified-daily.txt" \
 		git maintenance run --schedule=daily --quiet &&
 
-	test_subcommand ! git commit-graph write --split --reachable \
-		--no-progress <modified-hourly.txt &&
-	test_subcommand git prune-packed --quiet <modified-hourly.txt &&
-	test_subcommand ! git multi-pack-index write --no-progress \
-		<modified-hourly.txt &&
+	test_maintenance_tasks modified-hourly.txt <<-\EOF &&
+	prefetch
+	loose-objects
+	EOF
 
-	test_subcommand git commit-graph write --split --reachable \
-		--no-progress <modified-daily.txt &&
-	test_subcommand git prune-packed --quiet <modified-daily.txt &&
-	test_subcommand ! git multi-pack-index write --no-progress \
-		<modified-daily.txt
+	test_maintenance_tasks modified-daily.txt <<-\EOF
+	prefetch
+	loose-objects
+	commit-graph
+	EOF
 '
 
 test_strategy () {
 	STRATEGY="$1"
 	shift
 
-	cat >expect &&
 	rm -f trace2.txt &&
 	GIT_TRACE2_EVENT="$(pwd)/trace2.txt" \
 		git -c maintenance.strategy=$STRATEGY maintenance run --quiet "$@" &&
-	sed -n 's/{"event":"child_start","sid":"[^/"]*",.*,"argv":\["\(.*\)\"]}/\1/p' <trace2.txt |
-		sed 's/","/ /g'  >actual
-	test_cmp expect actual
+	test_maintenance_tasks trace2.txt
 }
 
 test_expect_success 'maintenance.strategy is respected' '
@@ -1017,48 +1031,44 @@ test_expect_success 'maintenance.strategy is respected' '
 		test_grep "unknown maintenance strategy: .unknown." err &&
 
 		test_strategy incremental <<-\EOF &&
-		git pack-refs --all --prune
-		git reflog expire --all
-		git gc --quiet --no-detach --skip-foreground-tasks
+		gc foreground
+		gc
 		EOF
 
 		test_strategy incremental --schedule=weekly <<-\EOF &&
-		git pack-refs --all --prune
-		git prune-packed --quiet
-		git multi-pack-index write --no-progress
-		git multi-pack-index expire --no-progress
-		git multi-pack-index repack --no-progress --batch-size=1
-		git commit-graph write --split --reachable --no-progress
+		pack-refs foreground
+		prefetch
+		loose-objects
+		incremental-repack
+		commit-graph
 		EOF
 
 		test_strategy gc <<-\EOF &&
-		git pack-refs --all --prune
-		git reflog expire --all
-		git gc --quiet --no-detach --skip-foreground-tasks
+		gc foreground
+		gc
 		EOF
 
 		test_strategy gc --schedule=weekly <<-\EOF &&
-		git pack-refs --all --prune
-		git reflog expire --all
-		git gc --quiet --no-detach --skip-foreground-tasks
+		gc foreground
+		gc
 		EOF
 
 		test_strategy geometric <<-\EOF &&
-		git pack-refs --all --prune
-		git reflog expire --all
-		git repack -d -l --geometric=2 --quiet --write-midx
-		git commit-graph write --split --reachable --no-progress
-		git worktree prune --expire 3.months.ago
-		git rerere gc
+		pack-refs foreground
+		reflog-expire foreground
+		geometric-repack
+		commit-graph
+		worktree-prune
+		rerere-gc
 		EOF
 
 		test_strategy geometric --schedule=weekly <<-\EOF
-		git pack-refs --all --prune
-		git reflog expire --all
-		git repack -d -l --geometric=2 --quiet --write-midx
-		git commit-graph write --split --reachable --no-progress
-		git worktree prune --expire 3.months.ago
-		git rerere gc
+		pack-refs foreground
+		reflog-expire foreground
+		geometric-repack
+		commit-graph
+		worktree-prune
+		rerere-gc
 		EOF
 	)
 '

-- 
2.55.0.313.g8d093f411d.dirty

