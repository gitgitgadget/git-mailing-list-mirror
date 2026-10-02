Received: from mail-dy2-f42.google.com (mail-dy2-f42.google.com [74.125.229.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09F31218E91
	for <git@vger.kernel.org>; Fri,  2 Oct 2026 11:11:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.229.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790939498; cv=none; b=YrsPtxHPNh47Q4C/6QcWEiNJVOBgSqfiva19MlNbm9ej7j4PayhajAmiJ2kJYh1w+j0++LPvOl/6Lv9Vbs68vbSKWqYD2DZO25IztQTHOeU5m32fw5EJNiscJHORbPLlcCfeGX8bDR/EoPabMsu3NjM9zVGdO5Ze1s/uW7ZFM+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790939498; c=relaxed/simple;
	bh=CUmHLF1cqEwuIalXqxPmsUelZQvTiVT3YcaPB5lkePA=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=fn5gPW+Gm56aDaeZHus9t/h3/LYVIcXBw8BfLYVp81ygLbSM0FnACR8z9oFU1XX4vFaIzeOFIrgtANYt/yU3D6Y4D1tuyux+6y8rqOMHaK8BhQ0ZSSPW2zHbO53g6jpcudMf33YGprf2G6t9dYRjVfObG+rkxTD/6NTaxjDY4Ss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Hx1/V/jN; arc=none smtp.client-ip=74.125.229.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Hx1/V/jN"
Received: by mail-dy2-f42.google.com with SMTP id 5a478bee46e88-3428f70d7e7so4290115eec.3
        for <git@vger.kernel.org>; Fri, 02 Oct 2026 04:11:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790939496; x=1791544296; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=CLCPjoW3ghJIxFZ/PH27G0ZixLDpQ2GzU4amH579QMA=;
        b=Hx1/V/jNaLCUi3zOnZQM9S833hmAsXu79xL11WH3iMT8P1gAHkPZ/lI8/JATNSK/7R
         j9F/sEJoBMTuexhd4ImSQcI27u6lI1e2n6k0YeAJMA7OHD4a/li75Gqq5878NAu4Thcb
         X2wU2jHS4PSr3XrDIx1uQIPo6yXc/hINHdU0yoya/N+S/S1QB6bou2r4PeZ4b8KccoGo
         kefRzylHNG1HEveYnOADvpvHplMFS4Ns7YVdP8ir7gpI+RqwfdWvcLofEEASbmT0t9IX
         Tft+51atyczwHYlToQ9kui6fWEmTuPyrWfVIxT4bG6gaUlGxeduUVsm92Fdp2wVNa6bU
         dp7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790939496; x=1791544296;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=CLCPjoW3ghJIxFZ/PH27G0ZixLDpQ2GzU4amH579QMA=;
        b=vfSH6tK4Pps8Qrf/eBceD2/xacxHJDUJrmjNqeIcBEuzG0+OmqCnbBpO6hezslDduL
         /1F8KuDgkxTr4IPkapH46DktV/prGClrQIYeeSjZCMnfqHk95wmmsT1INyH5zBf7Le6O
         e6q1vx9vazYHkgBVvvnjTJh8YKbotZy903+DOaJ18+YPCTFs7z41+vhnSEQEctHE8Tie
         ubR84fTkoHBrnS5IIexMUtSRs6YlP+V4418Iz59pAzHXFLon4nn1vg6TkxEfm9c+CM/V
         /zeckcqopdxITrSg2dQsG4pM+SbsNkRJPEjrFdMT7RlbTGDXoTTSQgkj8oa4kuHX5ehH
         g8jg==
X-Gm-Message-State: AFq9FYI+tK6NPPf76KWMhAoOKbRSQozsvjuZVoekF7tSkIKs/pkxMUyr
	MRwQhLvQz1eOj6vsBGV+T0LJJyeGRs2lTm+rYo43aGLoWR5y35RpdtjpWtYvKg==
X-Gm-Gg: AYBFou0TQlUMz3XGkTuz0ukaS8Cn6Ugo1uc+QviyUQECNzSNTc/RB2Rk7dcmHzQ68EU
	qia3rnbZet2s8s+13NBjOf56t94GJMrxjhKpS9TJ5BHt2XT4el1fUm91diNwIL24b3WowtRHEtZ
	IQkl5Kz96qY4l3BmVi+nxEwHJsmu2pB+cE9ieXPF9EdM2kB511wn6yUEZ+G7TILbbUXMTrNQ3aB
	wr/jOIbLCrWvqLzhTTDruRnpMtdKJyPuOY/oZv1ge0sgVEt941iLSUgUJdVLbhgDlQhc2hCfW4a
	i6aQIC0RwaeTTPIVdTme6HxoNLl4c2fdSlsdzVtEGgNe9LKiogNvyGwwm8dME+KIAlIbOGfHQM5
	nUKT+CAaXVE+QsF1D14v1Ah8E71LAaQ5a7v7mrzW+7RH58eakgS8qeIhKmp/wN4X8VQDlAhTOMB
	1LAp6dU3xI/DSqrhfNnBNhOqVnlCstNtSUv5FBpwnW5mX8Bx4iKlALh2zs6fu4DxErPr18EUU=
X-Received: by 2002:a05:7300:ce98:b0:33c:e74:4625 with SMTP id 5a478bee46e88-34f2185df75mr2136676eec.28.1790939495757;
        Fri, 02 Oct 2026 04:11:35 -0700 (PDT)
Received: from [127.0.0.1] ([52.161.59.3])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-34f14f98527sm5421078eec.16.2026.10.02.04.11.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Oct 2026 04:11:35 -0700 (PDT)
Message-Id: <3dc3d02f12a3118ac9e270c19960815f6b8170cb.1790939492.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2214.v6.git.1790939492.gitgitgadget@gmail.com>
References: <pull.2214.git.1788337897490.gitgitgadget@gmail.com>
	<pull.2214.v6.git.1790939492.gitgitgadget@gmail.com>
From: "Thomas Bachem via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 02 Oct 2026 11:11:30 +0000
Subject: [PATCH v6 1/3] rerere: wait for MERGE_RR.lock before giving up
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

setup_rerere() takes MERGE_RR.lock with LOCK_DIE_ON_ERROR, so of two
processes that want it at the same time the second one dies. That
used to be rare. Since 452b12c2e0 (builtin/maintenance: use
"geometric" strategy by default, 2026-02-24) the auto maintenance
after a commit runs "git rerere gc" whenever rr-cache has enough
stale entries, and the gc holds the lock while it prunes.

A rebase whose next pick conflicts while that happens dies inside
repo_rerere(), before the sequencer has written the state that
"git rebase --continue" needs. Every later "git rebase --continue"
then fails with "you have staged changes in your working tree".

Wait for the lock for up to rerere.lockTimeout milliseconds, 1000 by
default, and only then fail as before. Pruning a few thousand entries
takes well under a second, so the default covers a rebase that runs
into the gc.

Assisted-by: Claude Fable 5.1
Signed-off-by: Thomas Bachem <mail@thomasbachem.com>
---
 Documentation/config/rerere.adoc |  8 +++++
 rerere.c                         | 22 ++++++++++---
 t/t4200-rerere.sh                | 53 ++++++++++++++++++++++++++++++++
 3 files changed, 78 insertions(+), 5 deletions(-)

diff --git a/Documentation/config/rerere.adoc b/Documentation/config/rerere.adoc
index 3a78b5ebb1..30e827f32b 100644
--- a/Documentation/config/rerere.adoc
+++ b/Documentation/config/rerere.adoc
@@ -10,3 +10,11 @@ rerere.enabled::
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
+	for any other lock it cannot take.
diff --git a/rerere.c b/rerere.c
index 1c3745d9e3..64fac07c71 100644
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
 
@@ -882,12 +887,19 @@ int setup_rerere(struct repository *r, struct string_list *merge_rr, int flags)
 
 	if (flags & (RERERE_AUTOUPDATE|RERERE_NOAUTOUPDATE))
 		rerere_autoupdate = !!(flags & RERERE_AUTOUPDATE);
-	if (flags & RERERE_READONLY)
+	if (flags & RERERE_READONLY) {
 		fd = 0;
-	else
-		fd = repo_hold_lock_file_for_update(r, &write_lock,
-						    git_path_merge_rr(r),
-						    LOCK_DIE_ON_ERROR);
+	} else {
+		/*
+		 * Another process may hold the lock for a while, e.g.
+		 * "git rerere gc" while it prunes rr-cache, so wait for
+		 * it instead of dying right away.
+		 */
+		fd = repo_hold_lock_file_for_update_timeout(r, &write_lock,
+							    git_path_merge_rr(r),
+							    LOCK_DIE_ON_ERROR,
+							    rerere_lock_timeout_ms);
+	}
 	read_rr(r, merge_rr);
 	return fd;
 }
diff --git a/t/t4200-rerere.sh b/t/t4200-rerere.sh
index 7bb601e117..7bd92235dc 100755
--- a/t/t4200-rerere.sh
+++ b/t/t4200-rerere.sh
@@ -242,6 +242,59 @@ test_expect_success 'old records rest in peace' '
 	test_path_is_missing $rr2/preimage
 '
 
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
+test_expect_success 'rerere, forget, clear and gc fail on a lock they cannot take' '
+	test_when_finished "rm -f .git/MERGE_RR.lock" &&
+	>.git/MERGE_RR.lock &&
+	test_must_fail git -c rerere.lockTimeout=0 rerere 2>err &&
+	test_grep "Unable to create" err &&
+	test_must_fail git -c rerere.lockTimeout=0 rerere forget a1 2>err &&
+	test_grep "Unable to create" err &&
+	test_must_fail git -c rerere.lockTimeout=0 rerere clear 2>err &&
+	test_grep "Unable to create" err &&
+	test_must_fail git -c rerere.lockTimeout=0 rerere gc 2>err &&
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
-- 
gitgitgadget

