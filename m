Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3E2F248880
	for <git@vger.kernel.org>; Wed,  2 Sep 2026 08:31:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788337901; cv=none; b=iAMquoXo88/ZSuMdjfhMfY+bO9MLGMrhkqHHuuVk1/nibXWo6vxwCbJMBaMcJGdN4msEWoEBvwNrzifBeYofmMGUVxmC8tO+WI8ryyRr5g5322WbI1HRsYPWem/FTyQlHJo6WgBqwe8/4fLIDDYLeGKDD/ntxqsZj6d6HHLlTRs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788337901; c=relaxed/simple;
	bh=qidmvwze7y5Dy9IzBUaUC7F0o6svrV+ZBQ5wuCAok/M=;
	h=Message-Id:From:Date:Subject:Content-Type:MIME-Version:To:Cc; b=QnbDjVVcGNgI2NswcbPLA4xQ3rXxcTuI5BPMc30LR+dFDkAYMJR9e6/FdCblq+zacgsRGX5t6KawTsl8aRTk//wAJXi5o0yCpY3nCf8COF1Shseg5q9TmqyJIZMuSk2HWtl2883GwCLPmvM+u/V8IqbzqECiV/PTpCJif5s5NME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WebA/Zsq; arc=none smtp.client-ip=209.85.222.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WebA/Zsq"
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-92e99ef0902so72241185a.2
        for <git@vger.kernel.org>; Wed, 02 Sep 2026 01:31:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788337899; x=1788942699; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=z/9kT641hyZpsj0cgKRk5IreibSJlv1KYxRAM6zyENk=;
        b=WebA/Zsq/s0tzmVv95C9IDCu2VPUN4Qia/WTEHYyN7L8EZvDlwk3s8z7xHDzaocAC1
         V4rm7RrARIptiUH0zOSaYeFHkXMhjVF6HCYd9DaFfFYUlxo5blGQ10A7StPoDuDRRCTo
         WV758l0VVEsyfoJskkjYcBhvXxEl0v4VhZLCV+Jbljt5JKNI4XppI+TusfSU9uYXfG78
         ny+bKNu0qD4k2Aqp2UYbhrQ7dJDVaV62EvTQNZ36UNJc5awXrte0z/9p4cSYYwbXcWLQ
         cmXQUl/WHZxiUz7KGq3EDXvlP41+qtmoMGbaKF4xA7uZ6qwzJKj2RerB2HvYt9uWXbFA
         8ceA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788337899; x=1788942699;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=z/9kT641hyZpsj0cgKRk5IreibSJlv1KYxRAM6zyENk=;
        b=O0L0TezC9wXQKiZ3liuAiajFxCcGxS6eDGRXBzpeR4jIPXSnDL9mqpPpmPap+Wd9Rm
         dCle09/50FZ0x3oNJY1Ew3JA5/koR7Awhb1HKGVah8uPprfwjOrqtGy3weCPElUqFvgn
         7UsG4nd3ow+PQNOgkKMu2GiQsHntCzAoXcnflUECNoaIyZUzI2exHkvcXIG05uekHXd5
         6vxM8vjOLsc5T+kGc+qHjFbKSOyOhYHhg1aBolllMEXJSU+0S65D+C/NVt2jg2eLM8dt
         vlugsn58hNxErwRRyXIUKbC+BMB+iJKpEA6OiEcD5qnqtZXqYTGzUyZtxa3GZDjNW+pu
         hAFg==
X-Gm-Message-State: AFuF++m2DyZ7ccDCafCF0ej/bXXkSmXUeYpjLW5L2LA5NZsSNpQIXgpF
	8R54obPTf49rM/LtZNavH0wpyX/IZFnCxmN59eyX1PsYAhKUdncTEf8uLJv5jw==
X-Gm-Gg: AR+sD12MWr2KOLK5RG7cPrNe0tXCMD2zJBGDpVVYpVeAPeQ9o0umMKKRMWKvIFU9WGW
	3w4nXV3Qk8cDbt07EiA4lEzfA3gudyrauORAb/xClpeA1/CjQ7okHHUHZpExoIoLn4iL9bTlA7N
	En0Ejzu8MfnWG198HxQy7+0RvXWdMMpSPPW9n1zmHSTA/c5m3F2IdiVWO79lCjZp2D/+kpto+eF
	WbvFeF+AfFNKUxuddsmAwr9kNaTM99KddXORSGPWtK2hDJoMMKXDQyzdVb1VOuPncT1gLb3jlmb
	fSud3YxkkhpIvaF7R+kNnY5cwqQFYl/BJH35qAmQnXENGr+OlJXi8KXAcF5pZxmJDxwLm38sSaG
	Oq42qaHVD5KhFCO8oNgZc0QodufrRJdCi9qsIb4bxYhDrTbapkKzZe9Cul9xkQ6itpB/Jg5ENfR
	s/Lk11iBWCnL4CZb5RvD7BHOyWeFkw13KBtJup/KWW8bkT/zOiSoevd7ZU0nSAaTE=
X-Received: by 2002:a05:620a:2881:b0:939:34c6:a333 with SMTP id af79cd13be357-9396100e7e0mr284632085a.40.1788337898559;
        Wed, 02 Sep 2026 01:31:38 -0700 (PDT)
Received: from [127.0.0.1] ([48.211.213.33])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-9395f187083sm152975485a.15.2026.09.02.01.31.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Sep 2026 01:31:38 -0700 (PDT)
Message-Id: <pull.2214.git.1788337897490.gitgitgadget@gmail.com>
From: "Thomas Bachem via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 02 Sep 2026 08:31:37 +0000
Subject: [PATCH] rerere: keep a background gc from killing a rebase
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
    Thomas Bachem <mail@thomasbachem.com>,
    Thomas Bachem <mail@thomasbachem.com>

From: Thomas Bachem <mail@thomasbachem.com>

Since 2.54 unscheduled maintenance uses the "geometric" strategy, so
the "git maintenance run --auto --detach" behind every "git commit"
runs "git rerere gc" in the background whenever rr-cache has an entry.
That includes the "git commit" the sequencer runs for a resolved pick
on "git rebase --continue".

rerere_gc() takes MERGE_RR.lock through setup_rerere(), which uses
LOCK_DIE_ON_ERROR, and so does the sequencer's repo_rerere() at the
next conflict a few milliseconds later. Whichever comes second dies.
When it is the rebase, it dies in do_pick_commit() with the index
written but before make_patch() writes rebase-merge/{message,patch,
stopped-sha}, and every later "git rebase --continue" refuses with
"you have staged changes in your working tree". When it is the "git
commit" of a later continue, that one dies in its post-commit
repo_rerere() after the commit was made. Before 2.54 the same
collision needed an auto gc to actually run, since gc runs
"rerere gc" at its end.

A rebase with two conflicts in a row shows it. The filler makes the
pick slower than the ~5 ms the background task needs to take the
lock, and keeps the lock held for about 0.4 s. It hit 6 of 6 runs
here on 2.55.0, and a test suite driving rebases on toy repositories
with a single rr-cache entry hit it in both runs that were traced:

    git init -q -b main r && cd r
    git config rerere.enabled true
    git config maintenance.auto false
    mkdir pad && seq 20000 | (cd pad && split -l 1 -a 5)
    echo base >f && git add -A && git commit -qm base
    git checkout -q -b topic
    echo b >f && git commit -qam B
    echo c >f && git commit -qam C
    git checkout -q main
    echo a >f && git commit -qam A
    git repack -adq
    seq 20000 | awk '{printf ".git/rr-cache/%040x\n", $1}' \
        | xargs mkdir -p
    for d in .git/rr-cache/*/; do echo x >$d/preimage; done
    git config --unset maintenance.auto
    git checkout -q topic
    git rebase main
    echo ab >f && git add f
    GIT_EDITOR=true git rebase --continue

The second continue dies with "Unable to create '.git/MERGE_RR.lock':
File exists" while the gc spawned by its own commit holds the lock,
and after resolving C every further continue refuses. Maintenance
stays off during the setup so that no repack is pending: a repack due
at that commit runs ahead of rerere-gc in the task list and would
spend the window.

The gc needs the lock: it removes every rr-cache directory it finds
empty, and a rerere that has just created its directory but not yet
written the preimage looks exactly like that. So keep the lock and fix
both orders. When the gc finds the lock busy, let it warn and do
nothing this time, the way "maintenance run" treats its own lock, so a
manual "git rerere gc" sees the warning and the maintenance task and
"git gc" see a clean exit. When the gc holds the lock, let every other
caller wait it out instead of dying at once, for rerere.lockTimeout
milliseconds with the semantics of core.packedRefsTimeout: 1000 by
default, 0 for the old behaviour, -1 for an unbounded wait. Walking a
20000-entry rr-cache takes about 0.4 s here.

That rebase now completes. The tests cover the gc under a held lock,
directly and through the maintenance task, a merge that waits a lock
out within a five second rerere.lockTimeout, and one that fails at
once with a timeout of 0.

Assisted-by: Claude Fable 5.1
Signed-off-by: Thomas Bachem <mail@thomasbachem.com>
---
    rerere: keep a background gc from killing a rebase

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-2214%2Fthomasbachem%2Frerere-gc-lock-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-2214/thomasbachem/rerere-gc-lock-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/2214

 Documentation/config/rerere.adoc |  8 +++++++
 Documentation/git-rerere.adoc    |  4 +++-
 rerere.c                         | 27 +++++++++++++++++----
 rerere.h                         |  1 +
 t/t4200-rerere.sh                | 40 ++++++++++++++++++++++++++++++++
 t/t7900-maintenance.sh           |  8 +++++++
 6 files changed, 82 insertions(+), 6 deletions(-)

diff --git a/Documentation/config/rerere.adoc b/Documentation/config/rerere.adoc
index 3a78b5ebb1..8041a1587b 100644
--- a/Documentation/config/rerere.adoc
+++ b/Documentation/config/rerere.adoc
@@ -10,3 +10,11 @@ rerere.enabled::
 	enabled if there is an `rr-cache` directory under the
 	`$GIT_DIR`, e.g. if "rerere" was previously used in the
 	repository.
+
+rerere.lockTimeout::
+	The length of time, in milliseconds, to retry when trying to
+	take the rerere lock while another process holds it, typically
+	a background `git rerere gc`.  Value 0 means not to retry at
+	all; -1 means to try indefinitely.  Default is 1000 (i.e.,
+	retry for 1 second).  `git rerere gc` itself does not wait and
+	skips its run instead.
diff --git a/Documentation/git-rerere.adoc b/Documentation/git-rerere.adoc
index 4e6ab9a27c..05935b0603 100644
--- a/Documentation/git-rerere.adoc
+++ b/Documentation/git-rerere.adoc
@@ -70,7 +70,9 @@ occurred a long time ago.  By default, unresolved conflicts older
 than 15 days and resolved conflicts older than 60
 days are pruned.  These defaults are controlled via the
 `gc.rerereUnresolved` and `gc.rerereResolved` configuration
-variables respectively.
+variables respectively.  If another process holds the lock on the
+recorded resolutions, for example a merge or rebase that is recording
+a conflict, `gc` does nothing and reports so.
 
 
 DISCUSSION
diff --git a/rerere.c b/rerere.c
index 8232542585..22d114262b 100644
--- a/rerere.c
+++ b/rerere.c
@@ -32,6 +32,7 @@ static int rerere_enabled = -1;
 
 /* automatically update cleanly resolved paths to the index */
 static int rerere_autoupdate;
+static int rerere_lock_timeout_ms = 1000;
 
 #define RR_HAS_POSTIMAGE 1
 #define RR_HAS_PREIMAGE 2
@@ -876,6 +877,8 @@ static void git_rerere_config(void)
 {
 	repo_config_get_bool(the_repository, "rerere.enabled", &rerere_enabled);
 	repo_config_get_bool(the_repository, "rerere.autoupdate", &rerere_autoupdate);
+	repo_config_get_int(the_repository, "rerere.locktimeout",
+			    &rerere_lock_timeout_ms);
 	repo_config(the_repository, git_default_config, NULL);
 }
 
@@ -908,12 +911,26 @@ int setup_rerere(struct repository *r, struct string_list *merge_rr, int flags)
 
 	if (flags & (RERERE_AUTOUPDATE|RERERE_NOAUTOUPDATE))
 		rerere_autoupdate = !!(flags & RERERE_AUTOUPDATE);
-	if (flags & RERERE_READONLY)
+	if (flags & RERERE_READONLY) {
 		fd = 0;
-	else
+	} else if (flags & RERERE_SKIP_LOCKED) {
 		fd = hold_lock_file_for_update(&write_lock,
-					       git_path_merge_rr(r),
-					       LOCK_DIE_ON_ERROR);
+					       git_path_merge_rr(r), 0);
+		if (fd < 0) {
+			warning_errno(_("unable to lock '%s', skipping"),
+				      git_path_merge_rr(r));
+			return -1;
+		}
+	} else {
+		/*
+		 * A background "rerere gc" holds the lock for as long as it
+		 * takes to walk rr-cache, so wait it out rather than die.
+		 */
+		fd = hold_lock_file_for_update_timeout(&write_lock,
+						       git_path_merge_rr(r),
+						       LOCK_DIE_ON_ERROR,
+						       rerere_lock_timeout_ms);
+	}
 	read_rr(r, merge_rr);
 	return fd;
 }
@@ -1237,7 +1254,7 @@ void rerere_gc(struct repository *r, struct string_list *rr)
 	timestamp_t cutoff_resolve = now - 60 * 86400;
 	struct strbuf buf = STRBUF_INIT;
 
-	if (setup_rerere(r, rr, 0) < 0)
+	if (setup_rerere(r, rr, RERERE_SKIP_LOCKED) < 0)
 		return;
 
 	repo_config_get_expiry_in_days(the_repository, "gc.rerereresolved",
diff --git a/rerere.h b/rerere.h
index d4b5f7c932..87964bb3c5 100644
--- a/rerere.h
+++ b/rerere.h
@@ -10,6 +10,7 @@ struct repository;
 #define RERERE_AUTOUPDATE   01
 #define RERERE_NOAUTOUPDATE 02
 #define RERERE_READONLY     04
+#define RERERE_SKIP_LOCKED  010
 
 /*
  * Marks paths that have been hand-resolved and added to the
diff --git a/t/t4200-rerere.sh b/t/t4200-rerere.sh
index 1717f407c8..6b90294435 100755
--- a/t/t4200-rerere.sh
+++ b/t/t4200-rerere.sh
@@ -242,6 +242,46 @@ test_expect_success 'old records rest in peace' '
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
+	test_grep "MERGE_RR" err &&
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
+		(sleep 1 && rm -f .git/MERGE_RR.lock) &
+	} &&
+	test_must_fail git -c rerere.lockTimeout=5000 merge first 2>err &&
+	wait &&
+	test_grep ! "Unable to create" err &&
+	grep "^=======\$" $rr/preimage
+'
+
+test_expect_success 'rerere.lockTimeout=0 fails at once on a held lock' '
+	git reset --hard &&
+	rm -rf $rr &&
+	test_when_finished "rm -f .git/MERGE_RR.lock" &&
+	>.git/MERGE_RR.lock &&
+	test_must_fail git -c rerere.lockTimeout=0 merge first 2>err &&
+	test_grep "Unable to create" err &&
+	test_path_is_missing $rr/preimage
+'
+
 rerere_gc_custom_expiry_test () {
 	five_days="$1" right_now="$2"
 	test_expect_success "rerere gc with custom expiry ($five_days, $right_now)" '
diff --git a/t/t7900-maintenance.sh b/t/t7900-maintenance.sh
index d7f82e1bec..a55ca2e829 100755
--- a/t/t7900-maintenance.sh
+++ b/t/t7900-maintenance.sh
@@ -885,6 +885,14 @@ test_expect_success 'rerere-gc task with --auto honors maintenance.rerere-gc.aut
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

base-commit: e9019fcafe0040228b8631c30f97ae1adb61bcdc
-- 
gitgitgadget
