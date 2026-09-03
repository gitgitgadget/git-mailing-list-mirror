Received: from fhigh-b1-smtp.messagingengine.com (fhigh-b1-smtp.messagingengine.com [202.12.124.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F0F946C4D1
	for <git@vger.kernel.org>; Thu,  3 Sep 2026 09:05:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788426323; cv=none; b=GdOU1JQeHM0C/Q6Wq4LpSFdRphU5ejPtA4Jz1LiM0fpLBRcEED9zn3R6yIYLX/SLla4vdtzfKthlWUuU2CFFIgvxMiBo0S+HgCWCkvzVtIbVfZimDx3re7u/RWoEqPEoZdE4ikiEZcdoPmIxmMMk6jh572k4AtiGiFU8vRL4+0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788426323; c=relaxed/simple;
	bh=4YcoQSmS5yqd/soijVhMwTJvoL7s7++a+3SSpo6vnFY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Syoc8g5ruRDGcp2Wwf019A3Ln8xvPTcqb3JAnYRz1zZ24LrM3rc/Qsz0SOcEL1ygXIHMvfJ2C3PV5ZBYhBusYrXx9ElZUBXw64WIl0VvxRQ5LERHSyT0V9cVLT1VFapf8gq4acFUwZtyPRn0Nc0ZI9X2rFwQZqvqr/A3yfpa9qc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=pNlc94WW; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=wGNA6PTH; arc=none smtp.client-ip=202.12.124.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="pNlc94WW";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="wGNA6PTH"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 42ABC7A012E;
	Thu,  3 Sep 2026 05:05:20 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Thu, 03 Sep 2026 05:05:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1788426320;
	 x=1788512720; bh=Ige9i7c3CCDH+yvegXe3t5cMJuU+EyGYd5N4UZEtsms=; b=
	pNlc94WWy4KPVdK3SrMiGeWVXqiN9Yu0Ya8piGxFn91OQZWCg7U4DFOv+UZp3fcQ
	06W46T9SXoYmOrqhFLQiNyIpg2BfRTSNo3X+lwkl69YTm5NXoqns8BdsI/oOWYpG
	u17bU7587O2qsGx7xpJyJFDRF2ZHyGhK3deQIktqbiOpVqI3/XSp49cZ7jrrUhPg
	/BVQi7kF2QrZVpurRzWGMsyrGLiTqg1o+sgmcEYvSpcVkkgL6evLAB8qXtqzYuIH
	b1uQeP3y+PhM9hjgYE5dXU2+PR6Iuxgj2Jrr+1onbjTh7yUO8tdfY09S3AZ9hSl9
	xhc/iIMHc73897TpLmcuTQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1788426320; x=
	1788512720; bh=Ige9i7c3CCDH+yvegXe3t5cMJuU+EyGYd5N4UZEtsms=; b=w
	GNA6PTHGLJwS3WTcT0KpF2EPdqn5XJ5HpGvkqr2WhOgU5ttLBu6NKFakSNNmwVZh
	F++0nDM1zN6+Fs+52/O0ogy+QgrFCGJ8VAKyKt4e5NL4mIGTTGOn3lkFUjR6qSgG
	YRB7FpiKN8GPFCmBuy/m5qF9IhBLISzm018AzSFrexYOoq1XpYzGvyEiDmeiwLAv
	75D7nExqk0I/WiypCQPqAxJId1gejzEYlCuyGjXFWkZyjL6w8u813m5DUHdJ7XmB
	ieQX5gfv422yu9FiIp80wCjZnuzZPgyEuE2M0R7NVr9FBFRM2FI1HWQDndLCsbJM
	jpuHkNPU9ZbvHP1Gpa3Kg==
X-ME-Sender: <xms:UDiZanlPyFMjK3GQqm9N9sJlToXUfJqprgfn22yDc_WOWWo__w1A0g>
    <xme:UDiZaikQB7528RVvBhUugEO4uod6OfTRXFiDZ5KNk8TrT1fksnn570KX7d5hrjSPz
    EVYM4IcGUacLJgrEMXBpYQhcIqi2kPZr1XL48L3ecujsv2VEoAlclY>
X-ME-Received: <xmr:UDiZagsztB99hjQf9zAHbZFmW4QTNcNFULwD-g1jgTyj7wuRetV_Cg>
X-ME-Proxy-Cause: dmFkZTGFsIilehzAwVwhvuAUFgtmqUyQMCQkyrNa+G3tRp2+i2q3AoKSfeW+R9AvDhl+hb
    +ClSFfYj470S3Bkel0e8/M4a0SVEtwt0LxzlJ4YpozaomMr6WKH8r4062zuRKYIcS/Ja+b
    S783M74gdBDxRNaHVevgEzoGNtcPKZLKrL303kmFLFQEBgg2PtLNTmCiYFpYVSJZSvaeM+
    1hucueymkxcmXTc3yIs83mk4W+Kvtx5rED4+/WEtLO1qMjTUM/IUKTiDyiOUcd5gedkDDn
    Misl7IHT6d9NjMoFxwDgQilqaR0T24ujK9LQrT8I3m4lrrEWalDPFjaIq23AiXKXy5Myk9
    Zlr/EFwCOek9aOj7C+i1lErOfLQBjrd4ZIyUCFrTyL+dwoA8MV8wjrv/ZjFqpJS/yxC0i8
    UtpStuP2lFOzkVPU5N5n82AeXdB9ZSq3slqWxev9DdZp8iwOdQ0hK7rKf0Ch1LyizgSWta
    50lHHoahcnLeyDJn7739Zm4FUrh41LRBWhUGB+fyiEXD1dC75fM2gQxjRH7SenodklPB4i
    rpyVJ4pPo87gMkbdrALRL0idR4Zw3cF88bOS7XPxZ9ZJ77kc72F+SCH9TtGL89b9dw9Eer
    lcPBOvqzIfx5BBF5XeDUaWEcT9+lyrkUPSeLQpyiqzVg0Ll/pi50WJe26jKw
X-ME-Proxy: <xmx:UDiZatkeSwgV-Y0OlSGaXuJNmTLHhTw1Mw4HNrokMTb8hGuIccvcCQ>
    <xmx:UDiZajsikhHgJ7Z9Qxr4SHGtbOsx_4Fp2j_QAE2UU8MfpAleQbvo3g>
    <xmx:UDiZardVjOEsUCP4d6HkT1-JeKRgmu9D2WLepp2aZiVCYpCBbZFmjA>
    <xmx:UDiZarz2YELrXgNwAnv_lJXX-WVwUMRb1MW4KwqyVjWvWd3jhjrhJw>
    <xmx:UDiZatpHdvU6nPVLrrsvvVGoYj2GCQPuIRzVLKffYRHJnYBu28OyZTyn>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 3 Sep 2026 05:05:19 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id dde0841c (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 3 Sep 2026 09:05:22 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Thu, 03 Sep 2026 11:04:58 +0200
Subject: [PATCH 2/2] builtin/maintenance: improve heuristic for "rerere gc"
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260903-b4-pks-maintenance-rerere-gc-heuristic-v1-2-9929c45a9788@pks.im>
References: <20260903-b4-pks-maintenance-rerere-gc-heuristic-v1-0-9929c45a9788@pks.im>
In-Reply-To: <20260903-b4-pks-maintenance-rerere-gc-heuristic-v1-0-9929c45a9788@pks.im>
To: git@vger.kernel.org
Cc: Thomas Bachem <mail@thomasbachem.com>, 
 Phillip Wood <phillip.wood@dunelm.org.uk>
X-Mailer: b4 0.15.2

The "rerere-gc" maintenance task is responsible for pruning rerere
entries older than a certain configurable cutoff point. Whether or not
the task gets run during auto-maintenance can be configured via
"maintenance.rerere-gc.auto":

  - A negative value indicates that maintenance should always run.

  - A zero value indicates that maintenance should never run.

  - Otherwise, a positive value indicates that maintenance should always
    run in case we have at least a single rerere entry.

While the first two conditions are sensible, the last one is less so as
it does not account for whether we would even prune old entries in the
first place. Instead, it effectively implies that we unconditionally
spawn "git rerere gc" when rerere is enabled. Chances are high though
that there is nothing to prune, as the default cutoff dates are 60 days
for resolved rerere entries and 15 days for unresolved ones.

Besides being a waste of compute, it also obstructs concurrent processes
that want to write new resolutions as garbage collection takes a central
lock file, as reported in [1]. That race is a longstanding one that
existed even before we introduced fine-grained maintenance tasks, and
the proper fix is to use a locking timeout in the writing processes. But
the race is made worse by us performing garbage collection a lot more
often.

Refine the heuristic to take into account whether any entries can be
pruned in the first place. This ensures that we'll only ever run this
task in situations where it will do anything, and should thus result in
a lot less frequent invocations of "git rerere gc".

Furthermore, tweak the meaning of "maintenance.rerere-gc.auto" so that
positive values allow the user to configure the number of prunable
entries that need to exist before we run it and set the default value to
512. This number is pulled out of thin air, but it ensures that we know
to batch-delete entries instead of pruning every single entry that is
older than the cutoff point.

Note that this now requires us to actually open the rerere-entry
directories and stat the individual files in there, which does add a bit
of overhead when one has lots of rerere entries. To counteract this
overhead, we thus use the same sampling heuristic as we do for loose
objects, where we only consider those entries that start with a "17".

[1]: <pull.2214.git.1788337897490.gitgitgadget@gmail.com>

Reported-by: Thomas Bachem <mail@thomasbachem.com>
Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 Documentation/config/maintenance.adoc |  8 ++---
 builtin/gc.c                          | 26 +++------------
 rerere.c                              | 47 +++++++++++++++++++++++++++
 rerere.h                              |  6 ++++
 t/t7900-maintenance.sh                | 61 +++++++++++++++++++++++++++--------
 5 files changed, 108 insertions(+), 40 deletions(-)

diff --git a/Documentation/config/maintenance.adoc b/Documentation/config/maintenance.adoc
index da8be9f812..77977dcc48 100644
--- a/Documentation/config/maintenance.adoc
+++ b/Documentation/config/maintenance.adoc
@@ -121,10 +121,10 @@ maintenance.rerere-gc.auto::
 	This integer config option controls how often the `rerere-gc` task
 	should be run as part of `git maintenance run --auto`. If zero, then
 	the `rerere-gc` task will not run with the `--auto` option. A negative
-	value will force the task to run every time. Otherwise, any positive
-	value implies the command will run when the "rr-cache" directory exists
-	and has at least one entry, regardless of whether it is stale or not.
-	This heuristic may be refined in the future. The default value is 1.
+	value will force the task to run every time. Otherwise, a positive
+	value implies the command should run when the estimated number of stale
+	entries that would be pruned is greater than or equal to the configured
+	value. The default value is 512.
 
 maintenance.worktree-prune.auto::
 	This integer config option controls how often the `worktree-prune` task
diff --git a/builtin/gc.c b/builtin/gc.c
index de2f9e7fed..9147418a61 100644
--- a/builtin/gc.c
+++ b/builtin/gc.c
@@ -396,31 +396,13 @@ static int maintenance_task_rerere_gc(struct maintenance_run_opts *opts UNUSED,
 
 static int rerere_gc_condition(struct gc_config *cfg UNUSED)
 {
-	struct strbuf path = STRBUF_INIT;
-	int should_gc = 0, limit = 1;
-	DIR *dir = NULL;
+	int limit = 512;
 
 	repo_config_get_int(the_repository, "maintenance.rerere-gc.auto", &limit);
-	if (limit <= 0) {
-		should_gc = limit < 0;
-		goto out;
-	}
-
-	/*
-	 * We skip garbage collection in case we either have no "rr-cache"
-	 * directory or when it doesn't contain at least one entry.
-	 */
-	repo_git_path_replace(the_repository, &path, "rr-cache");
-	dir = opendir(path.buf);
-	if (!dir)
-		goto out;
-	should_gc = !!readdir_skip_dot_and_dotdot(dir);
+	if (limit <= 0)
+		return limit < 0;
 
-out:
-	strbuf_release(&path);
-	if (dir)
-		closedir(dir);
-	return should_gc;
+	return rerere_gc_estimate(the_repository, limit) >= (size_t)limit;
 }
 
 #define OPTIMIZE_FIELDS_FROM_GC_CONFIG(cfg, aggressive) \
diff --git a/rerere.c b/rerere.c
index d01af6b71b..87a42c4cc3 100644
--- a/rerere.c
+++ b/rerere.c
@@ -1215,6 +1215,53 @@ static int is_rr_cache_dirname(const char *path)
 	return !parse_oid_hex(path, &oid, &end) && !*end;
 }
 
+size_t rerere_gc_estimate(struct repository *r, size_t limit)
+{
+	timestamp_t cutoff_resolve, cutoff_noresolve;
+	struct strbuf buf = STRBUF_INIT;
+	struct dirent *e;
+	size_t count = 0;
+	DIR *dir;
+
+	dir = opendir(repo_git_path_replace(r, &buf, "rr-cache"));
+	if (!dir)
+		goto out;
+
+	rerere_gc_cutoffs(r, &cutoff_resolve, &cutoff_noresolve);
+
+	while ((e = readdir_skip_dot_and_dotdot(dir))) {
+		struct rerere_id id;
+
+		/*
+		 * We estimate the number of stale entries by only considering
+		 * those starting with "17". This is the same strategy that we
+		 * use for estimating the number of loose objects.
+		 */
+		if (!starts_with(e->d_name, "17") ||
+		    !is_rr_cache_dirname(e->d_name))
+			continue;
+
+		id.collection = find_rerere_dir(e->d_name);
+		for (id.variant = 0;
+		     id.variant < id.collection->status_nr;
+		     id.variant++) {
+			if (rerere_id_is_stale(&id, cutoff_resolve,
+					       cutoff_noresolve)) {
+				count += 256;
+				if (count >= limit)
+					goto out;
+			}
+		}
+	}
+
+out:
+	if (dir)
+		closedir(dir);
+	free_rerere_dirs();
+	strbuf_release(&buf);
+	return count;
+}
+
 void rerere_gc(struct repository *r, struct string_list *rr)
 {
 	struct string_list to_remove = STRING_LIST_INIT_DUP;
diff --git a/rerere.h b/rerere.h
index d4b5f7c932..898ebdd25a 100644
--- a/rerere.h
+++ b/rerere.h
@@ -39,6 +39,12 @@ int rerere_remaining(struct repository *, struct string_list *);
 void rerere_clear(struct repository *, struct string_list *);
 void rerere_gc(struct repository *, struct string_list *);
 
+/*
+ * Estimate the number of stale entries that a run of "git rerere gc"
+ * would prune.
+ */
+size_t rerere_gc_estimate(struct repository *r, size_t limit);
+
 #define OPT_RERERE_AUTOUPDATE(v) OPT_UYN(0, "rerere-autoupdate", (v), \
 	N_("update the index with reused conflict resolution if possible"))
 
diff --git a/t/t7900-maintenance.sh b/t/t7900-maintenance.sh
index 5fbb16f0f0..4f65fa9439 100755
--- a/t/t7900-maintenance.sh
+++ b/t/t7900-maintenance.sh
@@ -1016,37 +1016,70 @@ test_expect_success 'rerere-gc task without --auto always collects garbage' '
 	test_expect_rerere_gc git maintenance run --task=rerere-gc
 '
 
-test_expect_success 'rerere-gc task with --auto only prunes with prunable entries' '
+test_expect_success 'rerere-gc task with --auto only prunes with stale entries' '
 	test_when_finished "rm -rf .git/rr-cache" &&
+	entry_1=.git/rr-cache/171$(echo $ZERO_OID | cut -c4-) &&
+	entry_2=.git/rr-cache/172$(echo $ZERO_OID | cut -c4-) &&
+	entry_3=.git/rr-cache/173$(echo $ZERO_OID | cut -c4-) &&
+
+	# Without the "rr-cache" directory there is nothing to prune.
 	! git maintenance is-needed --auto --task=rerere-gc &&
 	test_expect_rerere_gc ! git maintenance run --auto --task=rerere-gc &&
-	mkdir .git/rr-cache &&
+
+	# Fresh unresolved entries are not stale.
+	for e in $entry_1 $entry_2 $entry_3
+	do
+		mkdir -p $e &&
+		echo preimage >$e/preimage || return 1
+	done &&
 	! git maintenance is-needed --auto --task=rerere-gc &&
 	test_expect_rerere_gc ! git maintenance run --auto --task=rerere-gc &&
-	: >.git/rr-cache/entry &&
+
+	# Entries are sampled using the "17" prefix, so we scale up the
+	# estimate by 256. A single entry is not sufficient to reach the
+	# default limit of 512.
+	test-tool chmtime =-$((16 * 86400)) $entry_1/preimage &&
+	! git maintenance is-needed --auto --task=rerere-gc &&
+
+	# A second prunable entry will reach the limit though and will thus get
+	# pruned.
+	test-tool chmtime =-$((16 * 86400)) $entry_2/preimage &&
 	git maintenance is-needed --auto --task=rerere-gc &&
-	test_expect_rerere_gc git maintenance run --auto --task=rerere-gc
+
+	# The prunable entries are gone, the other one remains.
+	test_expect_rerere_gc git maintenance run --auto --task=rerere-gc &&
+	test_path_is_missing $entry_1 &&
+	test_path_is_missing $entry_2 &&
+	test_path_is_dir $entry_3
 '
 
 test_expect_success 'rerere-gc task with --auto honors maintenance.rerere-gc.auto' '
 	test_when_finished "rm -rf .git/rr-cache" &&
+	entry=.git/rr-cache/171$(echo $ZERO_OID | cut -c4-) &&
 
 	# A negative value should always prune.
 	git -c maintenance.rerere-gc.auto=-1 maintenance is-needed --auto --task=rerere-gc &&
 	test_expect_rerere_gc git -c maintenance.rerere-gc.auto=-1 maintenance run --auto --task=rerere-gc &&
 
-	# A positive value prunes when there is at least one entry.
-	! git -c maintenance.rerere-gc.auto=9000 maintenance is-needed --auto --task=rerere-gc &&
-	test_expect_rerere_gc ! git -c maintenance.rerere-gc.auto=9000 maintenance run --auto --task=rerere-gc &&
-	mkdir .git/rr-cache &&
-	! git -c maintenance.rerere-gc.auto=9000 maintenance is-needed --auto --task=rerere-gc &&
-	test_expect_rerere_gc ! git -c maintenance.rerere-gc.auto=9000 maintenance run --auto --task=rerere-gc &&
-	: >.git/rr-cache/entry-1 &&
-	git -c maintenance.rerere-gc.auto=9000 maintenance is-needed --auto --task=rerere-gc &&
-	test_expect_rerere_gc git -c maintenance.rerere-gc.auto=9000 maintenance run --auto --task=rerere-gc &&
+	# A positive value prunes only when the estimated number of stale
+	# entries is at least as big. A single sampled entry counts for 256
+	# estimated entries.
+	mkdir -p $entry &&
+	echo preimage >$entry/preimage &&
+	test-tool chmtime =-$((16 * 86400)) $entry/preimage &&
+
+	! git -c maintenance.rerere-gc.auto=257 maintenance is-needed --auto --task=rerere-gc &&
+	test_expect_rerere_gc ! git -c maintenance.rerere-gc.auto=257 maintenance run --auto --task=rerere-gc &&
+	test_path_is_dir $entry &&
+
+	git -c maintenance.rerere-gc.auto=256 maintenance is-needed --auto --task=rerere-gc &&
+	test_expect_rerere_gc git -c maintenance.rerere-gc.auto=256 maintenance run --auto --task=rerere-gc &&
+	test_path_is_missing $entry &&
 
 	# Zero should never prune.
-	: >.git/rr-cache/entry-1 &&
+	mkdir -p $entry &&
+	echo preimage >$entry/preimage &&
+	test-tool chmtime =-$((16 * 86400)) $entry/preimage &&
 	! git -c maintenance.rerere-gc.auto=0 maintenance is-needed --auto --task=rerere-gc &&
 	test_expect_rerere_gc ! git -c maintenance.rerere-gc.auto=0 maintenance run --auto --task=rerere-gc
 '

-- 
2.55.0.979.g7e5102b832.dirty

