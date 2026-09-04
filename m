Received: from fhigh-b3-smtp.messagingengine.com (fhigh-b3-smtp.messagingengine.com [202.12.124.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C58FF42E01B
	for <git@vger.kernel.org>; Fri,  4 Sep 2026 07:03:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788505413; cv=none; b=qqWnUEUGNJGpPzYcfFbolvJQSQKhbKhmxfxAhiLDebZnNaFod+WlMTTmJh4CjDUfJejAzDAd9eCXbYR7Ffk7nLyp8Bm+BtJb5ku1/LET/4uJ1Gus9/cVMLHOg2/tLzuOWjQWogdInJ6DAcQ79uUPKPHOHgp+LXutvcFt2IvJTRY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788505413; c=relaxed/simple;
	bh=a08bJK/Lz+b0YGKozfRkrB4kOxfFeHFYPtgIJN4MXPs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=OeUH7UgT6CwgdGhdSJgIgY6aLUJmINSUKSpEt1fIbzszOhUmQd1LoNM8NI3Kk12d8ianorgTEqsNQKegc24KuNFAj1iEVpqKBre4hu21M30B1LOEcxUAM67VCHejc098/w7ybjdiiMWvrujnpDsxG5Pv58N/6f1JZUxNU/pz19g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=ML7axkIr; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=bmTfEiCP; arc=none smtp.client-ip=202.12.124.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="ML7axkIr";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="bmTfEiCP"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.stl.internal (Postfix) with ESMTP id CF6D27A01BE;
	Fri,  4 Sep 2026 03:03:30 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-03.internal (MEProxy); Fri, 04 Sep 2026 03:03:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1788505410;
	 x=1788591810; bh=isu1G70/nxq/kKDdY6c9bj0FnP3FmH8B47Ww6yMVqYU=; b=
	ML7axkIrsTgBup/7x6XQMtkMRMZjSxFmO/mC2t1zLKZOJtCGNC9xTO9vVBZHSUQV
	NnYFtI+AdrQTPGrti5wtqzAqbzBpQfGT8GX6pa9TvWA4byLGX6AYNxtFrhjQx6Un
	MNaHQhniXUlEl5ubvmIA8Ba5hl3RGmHVkopf2fKOlTnz3pLhIs2WbHgVKEOJRNKb
	VAUQ3NnOiGAyifXlMBhhFd9xpumnm9sOvkX/Ld/ejsfs6xYCF7jcvFn6x+AyS09Y
	n8xWRifUvHLCdGZaEMQ7P6WLfz3Fucq8n2W+zrP5u76z0WBIg/4TEOBdINEDPcBc
	+wqWGfxSQZLzdTKh2JF9Hw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1788505410; x=
	1788591810; bh=isu1G70/nxq/kKDdY6c9bj0FnP3FmH8B47Ww6yMVqYU=; b=b
	mTfEiCPQteydd1N/MJEa09xkq9F5ba4fFwHQUN8r66DJ9w7wr8HwHSQWMC+BTSH3
	HYmC4+3ux18l05n0o4MKWwOCxLQ01PkGpVUJp1dx1K3G2eYuxivwcL5ZpQjUJieQ
	1w4pHQ+UiDYMJs33P2/4cOekqkZeVUCq8EaBF4AxTVvSS+IwadxtTRphNT+Bd9mI
	sGzBUyJK/xRnkvG5P5TRcRTiBdTcyQf/OzPnYPHlw1/4+vmhOsp0xtBCcnloKVvU
	5yAMZ4HsTm/sdRl3uoWnFC2vdZOO/E6PD5kpeavwxNS6w/lravUJ2X5XYKrCxIL6
	pijmMI0bmIOj6fhm6j05A==
X-ME-Sender: <xms:Qm2aahxBqsZZmKT7-zGmvIbrIFUV5f2WxI8mFWXRN3_r8zxIJEWcOQ>
    <xme:Qm2aavHu7LP6o5pR2ArnBoGoT67O75g5FLR1cm1cmZrUGEAS73boP_jyziFuZ1o0D
    xzezWuaaxaEAYW1Vv0mkcxowvWX4f60XbGSqBypRXfV1vebskh0bok>
X-ME-Received: <xmr:Qm2aalx4-2siN8tVvJ_uKd0zHQWgeiJfvHoT9grlS133tDS3NjWM3i8tUabWkmbvUSMR2A>
X-ME-Proxy-Cause: dmFkZTG4DU55IfknScj1sTTDLmOoVhyU6b0Po/qKQaiBAsSl78hCtR0FKhixXUHzpQ7XvS
    2qqWfv7+0mCTyvIaSPny+33xq/QYxuKV9OgSaZ6/FQCQw+p3XD+K/+EFCmzeO6Z32xEYPl
    gWVgVUsoVCHT4hKiGBs7rZhfSr+8Bek1FFvQ2wxBZdAcoL01XoE2CQQ/ePyTwlTCkRHW4R
    mRwv1kUvFn4AMK2vvzBwUjbLhcdHJi2LTY1vdtmggrmOfiVBKMirDcP8sod/CL6UKopbUf
    U9YKgP5FnTsXSsx57AK5z4LRgaTMLAojh8ZoZHLfzVT0aeYahHkrenEk70WcW33bxMW5pg
    0kNXx+gItsicqb9CC8ciHf4bF/msIWv1mRbHyNxgnv3up+sBPpnROfPqgZyzFbxcMgxl5j
    1WhOd5PHc7INylxThD0Zb1jv7tiABHHHYWCAzqWB4ypYFXSbNI4S4dDMzgEDriQXqAthmA
    lOyBb6xEnvh1oLG3JcCNdEPIFEYtqSy75c55Karbzfw5CCX1tOeEiy8EA1P/YH6UkUCdvA
    HKjT3pujc0tteeYn0Tg9v7zo+pnNYpZOigxXNa1KQLG8cUkJV+6yWTcRZX2DcMMZAOYNer
    ja0m1FfJYxyUIC8MFdWBxCAkyQklGDKgfNusx1JznHgiLqWETahcbuf4yHUg
X-ME-Proxy: <xmx:Qm2aags1m_OHC-zNTxO8KXTyTTJXq_i7-oGibXUsaUfSMaVwPhfNvA>
    <xmx:Qm2aai2LzCJHgXntxuXXRB2THZcLfWV0Biq76rbMNzAFm9s10nCk-A>
    <xmx:Qm2aar-WygTHtIccAitywDvC8-8dyJAbd5WdPF-p11HhfQ5IFi5WEw>
    <xmx:Qm2aajNc2Eo_Bm7wipFseKjHTuRNTo5Z0qjTUi3VEwKieSyfFu-Dng>
    <xmx:Qm2aaiZQm0dmBP6QZiOp2yyP3ulrYVnSI0VnTVoD4WpiUhoZFEZuxXEs>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 4 Sep 2026 03:03:29 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id bce092d8 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 4 Sep 2026 07:03:28 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Fri, 04 Sep 2026 09:03:06 +0200
Subject: [PATCH v2 2/2] builtin/maintenance: improve heuristic for "rerere
 gc"
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260904-b4-pks-maintenance-rerere-gc-heuristic-v2-2-b1691121fe1c@pks.im>
References: <20260904-b4-pks-maintenance-rerere-gc-heuristic-v2-0-b1691121fe1c@pks.im>
In-Reply-To: <20260904-b4-pks-maintenance-rerere-gc-heuristic-v2-0-b1691121fe1c@pks.im>
To: git@vger.kernel.org
Cc: Thomas Bachem <mail@thomasbachem.com>, 
 Derrick Stolee <stolee@gmail.com>, 
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
 builtin/gc.c                          | 28 ++++------------
 rerere.c                              | 50 ++++++++++++++++++++++++++++
 rerere.h                              |  6 ++++
 t/t7900-maintenance.sh                | 61 +++++++++++++++++++++++++++--------
 5 files changed, 113 insertions(+), 40 deletions(-)

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
index de2f9e7fed..57a3520263 100644
--- a/builtin/gc.c
+++ b/builtin/gc.c
@@ -396,31 +396,15 @@ static int maintenance_task_rerere_gc(struct maintenance_run_opts *opts UNUSED,
 
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
+	if (!limit)
+		return 0; /* never prune */
+	if (limit < 0)
+		return 1; /* always prune */
 
-out:
-	strbuf_release(&path);
-	if (dir)
-		closedir(dir);
-	return should_gc;
+	return rerere_gc_needed(the_repository, (size_t)limit);
 }
 
 #define OPTIMIZE_FIELDS_FROM_GC_CONFIG(cfg, aggressive) \
diff --git a/rerere.c b/rerere.c
index 073422dbf3..1c3745d9e3 100644
--- a/rerere.c
+++ b/rerere.c
@@ -1222,6 +1222,56 @@ static int is_rr_cache_dirname(const char *path)
 	return !parse_oid_hex(path, &oid, &end) && !*end;
 }
 
+bool rerere_gc_needed(struct repository *r, size_t limit)
+{
+	timestamp_t cutoff_resolve, cutoff_noresolve;
+	struct strbuf buf = STRBUF_INIT;
+	bool needed = false;
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
+				if (count >= limit) {
+					needed = true;
+					goto out;
+				}
+			}
+		}
+	}
+
+out:
+	if (dir)
+		closedir(dir);
+	free_rerere_dirs();
+	strbuf_release(&buf);
+	return needed;
+}
+
 void rerere_gc(struct repository *r, struct string_list *rr)
 {
 	struct string_list to_remove = STRING_LIST_INIT_DUP;
diff --git a/rerere.h b/rerere.h
index d4b5f7c932..feeb0e2c9f 100644
--- a/rerere.h
+++ b/rerere.h
@@ -39,6 +39,12 @@ int rerere_remaining(struct repository *, struct string_list *);
 void rerere_clear(struct repository *, struct string_list *);
 void rerere_gc(struct repository *, struct string_list *);
 
+/*
+ * Check whether garbage collection for rerere entries is needed, which is
+ * the case when there's at least `limit` stale entries that would be pruned.
+ */
+bool rerere_gc_needed(struct repository *r, size_t limit);
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
2.55.0.1007.g17ff1f9808.dirty

