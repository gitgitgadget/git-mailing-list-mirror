Received: from mail-yx1-f54.google.com (mail-yx1-f54.google.com [74.125.224.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B50643901A
	for <git@vger.kernel.org>; Tue, 28 Apr 2026 12:52:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777380783; cv=none; b=XuB65FxfLBK2SkiEawiqbuCXGVIFbvKdSDFSFEnPQkdYpjR+p8fU3u2I1aU7YmBDOJvskKzXbr0ahCvl7yz9gI8JvIbS9Q2wduNsW9m30MDs2/ZkF9cdp/Tk9APDQsPl84Y9cNZCOCcbAf+7mvhVXcADrUnMYkoURbgxkuPrxpc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777380783; c=relaxed/simple;
	bh=VfCQMAmV6FoOsGJZLbGBAAcrs+3HFqLvCCiBA8BbE5A=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=iNi8orEmDFe/uL38dyFF6VToL6e3z+/J2vPgVW3Ho20M6fV4hLnm95IoHWjQTSWzAs4OpCCldWAPoPHDZVE3F+t+YKgeaoxGtj0PoVpzY20Kv9dLqjs0zsyAYAof6LnBy2sYizpisLYFnQ1H5rgNSlgt9TW1QSKZUJQXoOsrSFg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=h3x/2El1; arc=none smtp.client-ip=74.125.224.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h3x/2El1"
Received: by mail-yx1-f54.google.com with SMTP id 956f58d0204a3-6530dd51ccaso10222403d50.3
        for <git@vger.kernel.org>; Tue, 28 Apr 2026 05:52:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777380773; x=1777985573; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Fo3zsNr6OqCl4Zg3E/x5GcDvn0VbcU76B0K3epfV0sI=;
        b=h3x/2El1BxEsVeJB+sx+C3kBRLi+1ikwtaZL3076TjPXXXeXm01048QZyyJxZ5Ry4v
         Q9V9MkOJ5LpvntS7fn4mo2ASd4v0ZZ6mhCMeaRASufxEzgjAcLULR82GgIE0tDx2G5z9
         j8SWJfx4MrEwO+W5YMm48gjFJTeRCU9RmRpAfGN0AgrZzhmGLidkj3A+eZ6bBPNEAEBx
         hAmVBeEdPNkZHuxyAbYoMf9BI/y82jRi76FJSnsbAN2qv9pmJy7PKstB1Kn4tNvFok3r
         E6suxfMzlMM2YpEWiEZNCuY/0vnuMvEWK3eDGcj6XCu2XD26f/3cRvZVOAY2hhGLZxAU
         v5qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777380773; x=1777985573;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Fo3zsNr6OqCl4Zg3E/x5GcDvn0VbcU76B0K3epfV0sI=;
        b=ExTyBwyNKTP2uDJ8NDd3EyHGgVIMkDDor9ZgMUDgaSThzvqM3lsuQ1ILY8q0O9epDU
         IQ85hLl69WYjzS1hx62+F+aUGL8XGzeLk7s0jnjzRwwGXZvkMj4RNA5lTjKw0hzcP8BN
         oyh2ttbOWInusgEgs0muGmCK/9gT/5nn6R6k/cuaxWHCLIUJzZtEypKFcPNdZ5j6+ieG
         Qh3v+3UnvEkUdE3nnBtQ8b5t4Td2QdjeaqLW/RYFGuSNObbHptsgsnmPs8QjUM3SliMY
         OaB7483pgLCQwI4J5L9jYldvLeCFCOiKxTzC8U9pLdUyc+KrgUmTIM598uyGEEE5RN/S
         WQdQ==
X-Gm-Message-State: AOJu0YzDiFBNAfrrxVk8VF3l+SOnyaXnRLR0pWZda1u1aXsQnVngoqJH
	tsFr+7mL1EWF7qqiBsHYpG45IUvd4l6cqnRIVlDC/f8vCh1yXkP46lexVhUBQQ==
X-Gm-Gg: AeBDiettU+Xh10VuxM+fCh8piFtYLgF6RLSaLhVo/9Ny0C5DiPPBAvSsEURjTvAXUTz
	M41/LXZV3CH6bOVrNkfAZmqj+bNxyJOjVZK48BMTAJY3pTwyJ+wH7U73d3lhM1PIl5eZ7Kxgjbm
	2Bo6g3EW997oDT9FXNitwFQVISQ2UbAuGekNE0L8gGe5Oxe88ki5hKsN77e3C4gyBV9oCKFVZmz
	0JPYy1ZwSo+RNLt5OilXdr5xkbTxjr0GjlF9GgEjg8eEKHEDuUJhImszJ4auUGohmhqsJ+O/vWY
	PnWDrccPCzoex5qx/SacD0x5RO1V046h9dNTAYiDCRUAycOFyOEi17t1vHa49ZECzRekg35raT6
	VIpYTU9F7BmT9pJ+oBCV4vosAaPKhQrSkk9vr3yQJQTmKRb5x7Kmp0uSvWU7URs0VJS9Z5iikAM
	wGPIQgQNdGbtWg2rFE3ilys9T2qYetf2tLMCd/qG+dPDKWW81/
X-Received: by 2002:a05:690e:130d:b0:657:a0f4:ac1d with SMTP id 956f58d0204a3-65beed1d82bmr2267236d50.12.1777380773232;
        Tue, 28 Apr 2026 05:52:53 -0700 (PDT)
Received: from [127.0.0.1] ([57.151.137.185])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-65bee29f1b4sm1603418d50.5.2026.04.28.05.52.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Apr 2026 05:52:52 -0700 (PDT)
Message-Id: <12ebd5c56ff02cdbae87b0af9404bb666133bb04.1777380768.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2103.git.1777380768.gitgitgadget@gmail.com>
References: <pull.2103.git.1777380768.gitgitgadget@gmail.com>
From: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 28 Apr 2026 12:52:48 +0000
Subject: [PATCH 2/2] maintenance(geometric): do release the `.idx` files
 before repacking
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
Cc: Johannes Schindelin <johannes.schindelin@gmx.de>,
    Johannes Schindelin <johannes.schindelin@gmx.de>

From: Johannes Schindelin <johannes.schindelin@gmx.de>

As is done for all the other maintenance tasks, let's release the ODB
also before starting the geometric repacking. That way, the `.idx` files
won't be `mmap()`ed when they are to be deleted (which does not work on
Windows because you cannot delete files on that platform as long as they
are kept open by a process).

This regression was introduced by 9bc151850c1c (builtin/maintenance:
introduce "geometric-repack" task, 2025-10-24), but was only noticed
once geometric repacking was made the default in 452b12c2e0fe (builtin/
maintenance: use "geometric" strategy by default, 2026-02-24).

The fix recapitulates my work from df76ee7b77f0 (run-command: offer to
close the object store before running, 2021-09-09) & friends.

To guard against future regressions of this kind, add a check to
`run_and_verify_geometric_pack()` in `t7900` that detects orphaned
`.idx` files left behind after repacking. Contrary to interactive
calls, the `git maintenance` call in that test case would _not_ block on
Windows, asking whether to retry deleting that file, which is the reason
why this bug was not caught earlier.

Furthermore, since the default behavior of `DeleteFileW()` was changed
at some point between Windows 10 Build 17134.1304 and Build 18363.657
to use POSIX semantics (see https://stackoverflow.com/a/60512798),
the added orphaned-`.idx` check would be insufficient to catch this
regression on modern Windows without emulating legacy delete semantics
via `GIT_TEST_LEGACY_DELETE=1`.

This fixes https://github.com/git-for-windows/git/issues/6210.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 builtin/gc.c           |  1 +
 t/t7900-maintenance.sh | 22 +++++++++++++++++++++-
 2 files changed, 22 insertions(+), 1 deletion(-)

diff --git a/builtin/gc.c b/builtin/gc.c
index 3a71e314c9..84a66d3240 100644
--- a/builtin/gc.c
+++ b/builtin/gc.c
@@ -1590,6 +1590,7 @@ static int maintenance_task_geometric_repack(struct maintenance_run_opts *opts,
 	pack_geometry_split(&geometry);
 
 	child.git_cmd = 1;
+	child.odb_to_close = the_repository->objects;
 
 	strvec_pushl(&child.args, "repack", "-d", "-l", NULL);
 	if (geometry.split < geometry.pack_nr)
diff --git a/t/t7900-maintenance.sh b/t/t7900-maintenance.sh
index 4700beacc1..f497f51b23 100755
--- a/t/t7900-maintenance.sh
+++ b/t/t7900-maintenance.sh
@@ -532,7 +532,16 @@ run_and_verify_geometric_pack () {
 
 	# And verify that there are no loose objects anymore.
 	git count-objects -v >count &&
-	test_grep '^count: 0$' count
+	test_grep '^count: 0$' count &&
+
+	# Verify that no orphaned .idx files were left behind. On
+	# Windows, a missing odb_to_close causes the parent to hold
+	# mmap handles on .idx files, silently preventing their
+	# deletion by the child git-repack process.
+	ls .git/objects/pack/pack-*.idx .git/objects/pack/pack-*.pack |
+	sed "s/\.pack$/.idx/" |
+	sort | uniq -u >orphaned-idx &&
+	test_must_be_empty orphaned-idx
 }
 
 test_expect_success 'geometric repacking task' '
@@ -580,8 +589,19 @@ test_expect_success 'geometric repacking task' '
 
 		# And these two small packs should now be merged via the
 		# geometric repack. The large packfile should remain intact.
+		cp -R .git/objects .git/objects.save &&
 		run_and_verify_geometric_pack 2 &&
 
+		# On Windows, verify the same with legacy delete semantics
+		# that reject deletion of mmap-held .idx files.
+		if test_have_prereq MINGW
+		then
+			rm -rf .git/objects &&
+			mv .git/objects.save .git/objects &&
+			test_env GIT_TEST_LEGACY_DELETE=1 \
+				run_and_verify_geometric_pack 2
+		fi &&
+
 		# If we now add two more objects and repack twice we should
 		# then see another all-into-one repack. This time around
 		# though, as we have unreachable objects, we should also see a
-- 
gitgitgadget
