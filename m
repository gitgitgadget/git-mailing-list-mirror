Received: from mail-qk2-f13.google.com (mail-qk2-f13.google.com [74.125.230.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D32023F54A7
	for <git@vger.kernel.org>; Mon, 14 Sep 2026 08:04:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.230.205
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789373067; cv=none; b=hbHTRDqPoe9v96ia9oBOlAA17ijWQE6d9mN/80SEPgyKRPnI8V8f0FaEkrzgTAdr6K6PtNu4Sh4T4iiTLEasuE59RVljEeQD5RQeTXZy/QTQBIKadz9EiKMBFzAOOhNI3BhRjpp5x7HQzLWbJNaf/TOCZB7zSsAV5O11nLn7Wa8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789373067; c=relaxed/simple;
	bh=T4TjIZ/Ul/iuyl3ilS6lfTlkk0mzYavr2PFHYv36ENM=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=hre8xV8giP7rW6OXlUboVvZf/NTInImxV8HqSO3ETfJJudVQnBIElU/ivbpo2KjQxmulrCSoJRo3zK0vh+JhBnlOl3Brpgtc5eVE0y8nLNJP6y0dBYmF0j2KXeJP5egAdvBDLQ1dDHGyZ19PhFZ3bfJf55bCsegQt2e3cn5IAV4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=J71MnHVn; arc=none smtp.client-ip=74.125.230.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J71MnHVn"
Received: by mail-qk2-f13.google.com with SMTP id d75a77b69052e-52fb76798a2so6807771cf.1
        for <git@vger.kernel.org>; Mon, 14 Sep 2026 01:04:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789373063; x=1789977863; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=Bm1tLURndn8qbId12NtMIKK4EJ124PgyPF0qA5xIzUs=;
        b=J71MnHVnF4nh3ajvUfpo0TGQ+KpFmY/hQyN0X2JbyEC7WQx/o7R4jOGXbHIa9HHroV
         nU68JL2hxK7ypF+yj3OrpeyyeiVXKgimajtLAHClSBr+8L96gJRVc/4tzJlQZ9hmywKk
         qF3YPZ4c4Fsnea+jHqw46IjcBPyFONlzg22igz1HgDcKde244lZfrA/+xt1xBQzBpiMP
         otJBOQUqWAEOc4rzGwMVpahBRl79Y1+rFs+BqMJqJkIKhNe7FkugcrWelF8CVi/ZUXKY
         Knf4YO6lDpoZK/E227yskKuKAOvyLTb+iqgVMnYvbmVqUDunKJpByYqlOjpZAlvPvxy7
         4r0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789373063; x=1789977863;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Bm1tLURndn8qbId12NtMIKK4EJ124PgyPF0qA5xIzUs=;
        b=FCAC8RIlQQWV8Am2A6CtVfC0fMQFKpEVemjF1d680cLNaiL6WhWPtCkZMJSpJ9RCPn
         7hfF0cXIUJ7/0oVl/6a5rKpVB3ANleHv69QW+6ZML2lwGvt/sngEm7zF5fHY+tiw1s7t
         LZbDv7HeHzD2ALcT33QMTvdOJakhJZRp6Pwhr5RIP1AcMANYL17GrvJlwz6f+7J1tpun
         uMYwnk01eU9EzN7KNZo7k3zsXlZqo2c/yOISCSA2gzKx4tOl08NScpPHQ+IwI0T8QFts
         a96Xl5XH2/FJ8nifLQ4ACvIPXxM0vyi85ZaYsvksyXxBNeuwyMYXatwz5NKzJ8FrtFCi
         z5QA==
X-Gm-Message-State: AFuF++lNPn0/1MGWb60radO48b88y4x8cxn2zRaWgsOk+BNcyo1NaV6Y
	6swV6LEKxVFZNxXa0WK4JeACP3GjqJ+oc4MO72He1VX2vO2H95skBhrC84NCPQ==
X-Gm-Gg: AYBFou0hhlOxtMdrf2juC2u0BWsgqLf0dasq0C8RnKvyiOtQ9j7tTGFf3JSlNAddQq5
	HwAWxkqTkS3EWt1Gx6FAWjPdPESI5hW9g9/Kjm4tX5Su/Dy9XH6TbIZ362FM48eZdr28fw1t/0N
	/Zq3xLBIzlmRO/YDTDXjfw0nT18u7CFlH3BtHDTrKTJSWnr4B/52F9RnbmG4MIpIEwXm6FAHJ0G
	QspLmQJMDtFRd7pHEi71mw+ULrqxDlhyQKcAqij7NxZPd79cjxEx2Oar7P9RBopvNECXeNg+RE0
	V/S3BprUmIoKL2GI2hH3gDfffETrgTebZebLclg8fx5j4vZ59PU0RmY6nxIknaztXIPltGjjfoa
	lVYs15xdcllA98IN0kERgQ+pJVZsI9ark/ETuPGdSw9SJND3MfYrzW8FQ5Mz0WXzsA50nkhI3Jo
	5960RugjElFZp7c3iramDUFDrNAAxEYLhMDtuvZramY6KbNEePKH3NOrZZxPbISf+HkUQ8zS5yy
	4s=
X-Received: by 2002:ac8:5d10:0:b0:530:a450:4eb5 with SMTP id d75a77b69052e-5310d783c5fmr13323511cf.21.1789373063406;
        Mon, 14 Sep 2026 01:04:23 -0700 (PDT)
Received: from [127.0.0.1] ([48.211.210.118])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-530ff1bf4a2sm31641401cf.17.2026.09.14.01.04.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Sep 2026 01:04:22 -0700 (PDT)
Message-Id: <8a7a74d6aa359844a49593538ef6178cd1b02031.1789373061.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2214.v4.git.1789373061.gitgitgadget@gmail.com>
References: <pull.2214.git.1788337897490.gitgitgadget@gmail.com>
	<pull.2214.v4.git.1789373061.gitgitgadget@gmail.com>
From: "Thomas Bachem via GitGitGadget" <gitgitgadget@gmail.com>
Date: Mon, 14 Sep 2026 08:04:20 +0000
Subject: [PATCH v4 1/2] rerere: wait for MERGE_RR.lock, and let the gc skip it
Fcc: Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
To: git@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>,
    Phillip Wood <phillip.wood@dunelm.org.uk>,
    Junio C Hamano <gitster@pobox.com>,
    Phillip Wood <phillip.wood123@gmail.com>,
    Thomas Bachem <mail@thomasbachem.com>,
    Thomas Bachem <mail@thomasbachem.com>

From: Thomas Bachem <mail@thomasbachem.com>

setup_rerere() takes MERGE_RR.lock with LOCK_DIE_ON_ERROR. When two
processes want the lock at the same time, the second one dies. This
was always the case, but since 452b12c2e0 (builtin/maintenance: use
"geometric" strategy by default, 2026-02-24) it is easy to hit: auto
maintenance now runs "git rerere gc" after every commit whenever
rr-cache contains at least one entry, and the gc holds the lock
while it prunes.

A rebase whose next pick conflicts while the gc holds the lock dies
inside repo_rerere(). That runs before the sequencer writes the state
that "git rebase --continue" needs, so every later "git rebase
--continue" fails with "you have staged changes".

Instead of dying right away, wait for the lock for up to
rerere.lockTimeout milliseconds, 1000 by default, and only then fail
as before. The gc itself does not wait: when the lock is held, it
skips this run and leaves the pruning to the next one.

Assisted-by: Claude Fable 5.1
Signed-off-by: Thomas Bachem <mail@thomasbachem.com>
---
 Documentation/config/rerere.adoc |  9 +++++
 Documentation/git-rerere.adoc    |  4 +-
 rerere.c                         | 39 ++++++++++++++++---
 rerere.h                         |  2 +
 t/t4200-rerere.sh                | 67 ++++++++++++++++++++++++++++++++
 t/t7900-maintenance.sh           |  8 ++++
 6 files changed, 122 insertions(+), 7 deletions(-)

diff --git a/Documentation/config/rerere.adoc b/Documentation/config/rerere.adoc
index 3a78b5ebb1..cc9dd0c37b 100644
--- a/Documentation/config/rerere.adoc
+++ b/Documentation/config/rerere.adoc
@@ -10,3 +10,12 @@ rerere.enabled::
 	enabled if there is an `rr-cache` directory under the
 	`$GIT_DIR`, e.g. if "rerere" was previously used in the
 	repository.
+
+rerere.lockTimeout::
+	The length of time, in milliseconds, to wait for the rerere
+	lock when another process holds it, typically a background
+	`git rerere gc`.  Value 0 means not to wait at all; -1 means
+	to wait indefinitely.  Default is 1000 (i.e., wait for 1
+	second).  When the time is up, the command fails as it does
+	for any other lock it cannot take.  `git rerere gc` never
+	waits and skips its run while the lock is held.
diff --git a/Documentation/git-rerere.adoc b/Documentation/git-rerere.adoc
index 4e6ab9a27c..4df653367e 100644
--- a/Documentation/git-rerere.adoc
+++ b/Documentation/git-rerere.adoc
@@ -70,7 +70,9 @@ occurred a long time ago.  By default, unresolved conflicts older
 than 15 days and resolved conflicts older than 60
 days are pruned.  These defaults are controlled via the
 `gc.rerereUnresolved` and `gc.rerereResolved` configuration
-variables respectively.
+variables respectively.  If another process holds the rerere lock,
+for example a merge or rebase that is recording a conflict, `gc`
+does nothing and says so.
 
 
 DISCUSSION
diff --git a/rerere.c b/rerere.c
index 3d3bd0db16..7d44f3937c 100644
--- a/rerere.c
+++ b/rerere.c
@@ -33,6 +33,9 @@ static int rerere_enabled = -1;
 /* automatically update cleanly resolved paths to the index */
 static int rerere_autoupdate;
 
+/* how long to wait for MERGE_RR.lock, in milliseconds */
+static int rerere_lock_timeout_ms = 1000;
+
 #define RR_HAS_POSTIMAGE 1
 #define RR_HAS_PREIMAGE 2
 struct rerere_dir {
@@ -850,6 +853,8 @@ static void git_rerere_config(void)
 {
 	repo_config_get_bool(the_repository, "rerere.enabled", &rerere_enabled);
 	repo_config_get_bool(the_repository, "rerere.autoupdate", &rerere_autoupdate);
+	repo_config_get_int(the_repository, "rerere.locktimeout",
+			    &rerere_lock_timeout_ms);
 	repo_config(the_repository, git_default_config, NULL);
 }
 
@@ -882,12 +887,34 @@ int setup_rerere(struct repository *r, struct string_list *merge_rr, int flags)
 
 	if (flags & (RERERE_AUTOUPDATE|RERERE_NOAUTOUPDATE))
 		rerere_autoupdate = !!(flags & RERERE_AUTOUPDATE);
-	if (flags & RERERE_READONLY)
+	if ((flags & RERERE_READONLY) && (flags & RERERE_NOWAIT))
+		BUG("RERERE_READONLY takes no lock, so RERERE_NOWAIT does not apply");
+	if (flags & RERERE_READONLY) {
 		fd = 0;
-	else
-		fd = repo_hold_lock_file_for_update(r, &write_lock,
-						    git_path_merge_rr(r),
-						    LOCK_DIE_ON_ERROR);
+	} else {
+		const char *path = git_path_merge_rr(r);
+		int lock_flags = LOCK_DIE_ON_ERROR;
+		long timeout_ms = rerere_lock_timeout_ms;
+
+		/*
+		 * Another process may hold the lock for a while, e.g.
+		 * "git rerere gc" while it prunes rr-cache, so wait for
+		 * it instead of dying right away.  The gc itself never
+		 * waits: skipping one of its runs costs nothing.
+		 */
+		if (flags & RERERE_NOWAIT) {
+			lock_flags = 0;
+			timeout_ms = 0;
+		}
+		fd = repo_hold_lock_file_for_update_timeout(r, &write_lock,
+							    path, lock_flags,
+							    timeout_ms);
+		if (fd < 0) {
+			warning_errno(_("skipping rerere, "
+					"unable to create '%s.lock'"), path);
+			return -1;
+		}
+	}
 	read_rr(r, merge_rr);
 	return fd;
 }
@@ -1211,7 +1238,7 @@ void rerere_gc(struct repository *r, struct string_list *rr)
 	timestamp_t cutoff_resolve = now - 60 * 86400;
 	struct strbuf buf = STRBUF_INIT;
 
-	if (setup_rerere(r, rr, 0) < 0)
+	if (setup_rerere(r, rr, RERERE_NOWAIT) < 0)
 		return;
 
 	repo_config_get_expiry_in_days(the_repository, "gc.rerereresolved",
diff --git a/rerere.h b/rerere.h
index d4b5f7c932..a2712d543e 100644
--- a/rerere.h
+++ b/rerere.h
@@ -10,6 +10,8 @@ struct repository;
 #define RERERE_AUTOUPDATE   01
 #define RERERE_NOAUTOUPDATE 02
 #define RERERE_READONLY     04
+/* Never wait for MERGE_RR.lock, and skip the run when it is held */
+#define RERERE_NOWAIT       010
 
 /*
  * Marks paths that have been hand-resolved and added to the
diff --git a/t/t4200-rerere.sh b/t/t4200-rerere.sh
index 7bb601e117..27082a7676 100755
--- a/t/t4200-rerere.sh
+++ b/t/t4200-rerere.sh
@@ -242,6 +242,73 @@ test_expect_success 'old records rest in peace' '
 	test_path_is_missing $rr2/preimage
 '
 
+test_expect_success 'gc does nothing while MERGE_RR is locked' '
+	mkdir -p $rr2 &&
+	echo Hello >$rr2/preimage &&
+	test-tool chmtime =$just_over_15_days_ago $rr2/preimage &&
+
+	test_when_finished "rm -f .git/MERGE_RR.lock" &&
+	>.git/MERGE_RR.lock &&
+	git rerere gc 2>err &&
+	test_grep "MERGE_RR.lock" err &&
+	test_path_is_file $rr2/preimage &&
+
+	rm .git/MERGE_RR.lock &&
+	git rerere gc &&
+	test_path_is_missing $rr2/preimage
+'
+
+test_expect_success 'a held lock is waited out within rerere.lockTimeout' '
+	git reset --hard &&
+	rm -rf $rr &&
+	test_when_finished "rm -f .git/MERGE_RR.lock" &&
+	>.git/MERGE_RR.lock &&
+	{
+		( sleep 1 && rm -f .git/MERGE_RR.lock ) &
+	} &&
+	test_must_fail git -c rerere.lockTimeout=5000 merge first 2>err &&
+	wait &&
+	test_grep ! "MERGE_RR" err &&
+	test_grep "^=======\$" $rr/preimage
+'
+
+test_expect_success 'merge fails once rerere.lockTimeout is up' '
+	git reset --hard &&
+	rm -rf $rr &&
+	test_when_finished "rm -f .git/MERGE_RR.lock" &&
+	>.git/MERGE_RR.lock &&
+	test_must_fail git -c rerere.lockTimeout=0 merge first 2>err &&
+	test_grep "Unable to create" err &&
+	test_grep "^=======\$" a1 &&
+	test_path_is_missing $rr/preimage
+'
+
+test_expect_success 'rerere, forget and clear fail on a lock they cannot take' '
+	test_when_finished "rm -f .git/MERGE_RR.lock" &&
+	>.git/MERGE_RR.lock &&
+	test_must_fail git -c rerere.lockTimeout=0 rerere 2>err &&
+	test_grep "Unable to create" err &&
+	test_must_fail git -c rerere.lockTimeout=0 rerere forget a1 2>err &&
+	test_grep "Unable to create" err &&
+	test_must_fail git -c rerere.lockTimeout=0 rerere clear 2>err &&
+	test_grep "Unable to create" err
+'
+
+test_expect_success 'rebase --abort fails on a lock it cannot take' '
+	git reset --hard &&
+	git checkout -b lock-held-abort third &&
+	test_when_finished "git checkout third && git branch -D lock-held-abort" &&
+	test_must_fail git rebase first &&
+	test_when_finished "rm -f .git/MERGE_RR.lock" &&
+	>.git/MERGE_RR.lock &&
+	test_must_fail git -c rerere.lockTimeout=0 rebase --abort 2>err &&
+	test_grep "Unable to create" err &&
+	test_path_is_dir .git/rebase-merge &&
+	rm .git/MERGE_RR.lock &&
+	git rebase --abort &&
+	test_path_is_missing .git/rebase-merge
+'
+
 rerere_gc_custom_expiry_test () {
 	five_days="$1" right_now="$2"
 	test_expect_success "rerere gc with custom expiry ($five_days, $right_now)" '
diff --git a/t/t7900-maintenance.sh b/t/t7900-maintenance.sh
index 5fbb16f0f0..4a27767817 100755
--- a/t/t7900-maintenance.sh
+++ b/t/t7900-maintenance.sh
@@ -1051,6 +1051,14 @@ test_expect_success 'rerere-gc task with --auto honors maintenance.rerere-gc.aut
 	test_expect_rerere_gc ! git -c maintenance.rerere-gc.auto=0 maintenance run --auto --task=rerere-gc
 '
 
+test_expect_success 'rerere-gc task succeeds while MERGE_RR is locked' '
+	test_when_finished "rm -rf .git/rr-cache .git/MERGE_RR.lock" &&
+	mkdir .git/rr-cache &&
+	: >.git/rr-cache/entry &&
+	>.git/MERGE_RR.lock &&
+	test_expect_rerere_gc git maintenance run --task=rerere-gc
+'
+
 test_expect_success '--auto and --schedule incompatible' '
 	test_must_fail git maintenance run --auto --schedule=daily 2>err &&
 	test_grep "cannot be used together" err
-- 
gitgitgadget

