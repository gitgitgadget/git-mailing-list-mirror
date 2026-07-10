Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C04C4195BE
	for <git@vger.kernel.org>; Fri, 10 Jul 2026 11:39:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783683609; cv=none; b=dN+YWvkTyOkRnnu/jndNmT8dgFJs0WSUIKd/C+Eq6vZoaw022B74hnGwKs81E0JuCliRbhMIFYp1pE6SRA124L92XX9kJYpZXh0qArIZRR85w9Bi/BzN826Ywd3u2rgMZyBDUl2JLvtdyV9mNJ+8PvnJ9u86fvt1ikxkHAT5X9E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783683609; c=relaxed/simple;
	bh=+x67F2fKVx4GxnaF78HflAWjJ4sfy0cPJ1Gq6i9/yuc=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=ADxKOMQfm5CD4Wtt68WtU39NIjSzRB5T63Xy1WpJBgW5ADKs62DR+9lYZwHkHEYpplwVIurKCH4oFvvAldpYeEGcTNa7NsGyW93qfWBe1571exYU/LtrIzl6KnrxPZNwaoymY+QOMyHeLO+Z+LsyrLPDcuKc/SSLAJf9rXTX9Nw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PW/ALn9a; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PW/ALn9a"
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-3811074a8c5so784788a91.1
        for <git@vger.kernel.org>; Fri, 10 Jul 2026 04:39:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783683592; x=1784288392; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=4UfU/66jZsh8xZPfG6jdMuYwVgMGZ5Ss/GIFAM2NVL0=;
        b=PW/ALn9aIoQpOeTXIRw3h06LWzhpwtfN42shSKorrD8LtSKhu5dDqMmdCzMp5qAm64
         2aZEkWDi27fLSJXuXBw3amjuC3mOebmFz1l+dz/+fT5KXScRtYbLdzfYb5RgVxH1+tXG
         DpjHQYtFYn0TMn0VjKG8z1MjdBJBmLCY/9tNRGHjK3HghtgEfPqNml+ZILYGsvwomLmB
         X9ws8eN7L61bQG1dXwM92L3mhgBCGk8omAyvf0+tGAZ3j8EACVuVnEjDDy0UkU93D+EM
         gldtUXsN83BiFtk0ZGpNdodsBHpvFeLiMqyHwZaI72BAYs29UTBSSHGNT2XVc8Ln336a
         oD1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783683592; x=1784288392;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=4UfU/66jZsh8xZPfG6jdMuYwVgMGZ5Ss/GIFAM2NVL0=;
        b=mGk0e4qk2WBF1JXRB6bKZxlrjn5YFhDoVDCoej5iw+JlrCDvSPe8Dyj8fa/6SrVxDT
         DEC3/qoW7jDaj397B+0ImDvFjMbuRp3y7FPoUHIyBKzg0ahtn7/o83wjwH/PHQ1IibY8
         tE/7A7g2QTO93IfZb9GUae5Eq+TwfDnQurjhYa+7HFXaePEcNLzPDB64VJeFHlFvRAF5
         MvDWu4wwi8y/oJb9WGBC1aLveyD9uHwk9RhKdH0h79kLRj29hU9n6/qWjQfBL/75tfxD
         XQ/kHniaP2Sirf928PJ/Mhp1e/3plS2DP8PDrDfyjVtAvTkoDbfGDWjXg9+rvxiHkRs8
         BSLw==
X-Gm-Message-State: AOJu0Yy3Xu9vK0vejj73kIp0CpkfuhKMvbnUzw4zQjQt7RDBey/gHokU
	2Za+D7rHm4OrnvOa1UR7Zq/EPLszY89v3ngL2valmQvHTMgDwvaFmw3bGMU0GO/a
X-Gm-Gg: AfdE7ckTiwlCTdAA2l5JiC9Zy8F1t1+Pm9Nivafvmxe2ax+Ml/FnfIlG/134lopmaTS
	60n+NdPFKU+CPRpnKtNHWfeyK7gUkc2UjgymVdaQ5k6ZdhrCAkC37caogDJIzqlYMMZ08w5dAh0
	Po5yWPpKV0O1TkBEmp5sWwnpCsZIDEVCdiYG9PB7hGsRTxqKdKYNjm0NWz3KqV6ex2hCNpu0VVb
	2BaO0Nq3Q+HLW1ESr0HCkdUUW93hTME0cV7oP9dnONjhagL14JVl2M9/yIE6lx7+foTcPflQpvB
	0XV2TTx0ku6FpuluMpQxIoD/8bSNEC0qPJ47EN72rmcvheRqQc0PfgqmU9e1+hNtuzOsNwJviZ0
	POpYqokGui+/4aUwf8s2YJyrg+Ct2jCregPMhF5R8k1hDvLUWoJRo1J/wZ6egIQccQ5zqh1S3Zb
	y0tOtL3tg0jeZAr5vH
X-Received: by 2002:a17:90b:2e8c:b0:387:e0db:bc29 with SMTP id 98e67ed59e1d1-3894269286cmr12593750a91.41.1783683592081;
        Fri, 10 Jul 2026 04:39:52 -0700 (PDT)
Received: from [127.0.0.1] ([172.185.47.202])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-38a5516abffsm2580045a91.4.2026.07.10.04.39.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jul 2026 04:39:51 -0700 (PDT)
Message-Id: <41285dd8e1df9d010648459d5ff93db72bff7c1a.1783683577.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2174.v2.git.1783683577.gitgitgadget@gmail.com>
References: <pull.2174.git.1783590159.gitgitgadget@gmail.com>
	<pull.2174.v2.git.1783683577.gitgitgadget@gmail.com>
From: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 10 Jul 2026 11:39:32 +0000
Subject: [PATCH v2 08/12] revision: avoid dereferencing NULL in
 `add_parents_only()`
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

This function resolves revision suffixes like commit^@ (all parents),
commit^! (commit minus parents), and commit^-N (exclude Nth parent). It
calls `get_reference()` in a loop to peel through tag objects until it
reaches a commit.

The existing NULL check after `get_reference()` only handles the
ignore_missing case, but get_reference() can return NULL through three
distinct paths:

  1. revs->ignore_missing: the caller asked to silently skip missing
     objects.

  2. revs->exclude_promisor_objects: the object is a lazy promisor
     object that should be excluded from the walk.

  3. revs->do_not_die_on_missing_objects: the caller wants to record
     missing OIDs for later reporting (used by `git rev-list
     --missing=print`) rather than dying.

In the latter two instances, the code falls through to dereference the
NULL pointer.

Handle all three cases explicitly:

  - ignore_missing: return 0, matching the existing behavior and
    the pattern in `handle_revision_arg()`.

  - do_not_die_on_missing_objects: return 0. The missing OID has already
    been recorded in `revs->missing_commits` by `get_reference()`.
    Returning 0 is consistent with `handle_revision_arg()` and
    `process_parents()`, both of which continue without error when this flag
    is set. The broader codebase pattern for this flag is "record and
    continue": list-objects.c, builtin/rev-list.c, and process_parents
    all skip the die/error and keep walking.

  - everything else (only the `exclude_promisor_objects` case in
    practice): return -1, consistent with `handle_revision_arg()` where
    the condition only matches `ignore_missing` or
    `do_not_die_on_missing_objects`, falling through to ret = -1 for the
    promisor case.

Note: the callers of `add_parents_only()` in
`handle_revision_pseudo_opt()` treat any nonzero return as "handled"
(`if (add_parents_only(...)) { ret = 0; }`), so the -1 for the promisor
case is indistinguishable from success there. This means a
promisor-excluded tag target referenced via commit^@ would be silently
skipped rather than producing an error.  This is a pre-existing
limitation of the caller's return value handling and not made worse by
this change; the alternative (a NULL dereference crash) _would be_
strictly worse.

Pointed out by Coverity.

Assisted-by: Claude Opus 4.6
Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 revision.c               |  9 +++++++--
 t/t0410-partial-clone.sh | 18 ++++++++++++++++++
 2 files changed, 25 insertions(+), 2 deletions(-)

diff --git a/revision.c b/revision.c
index e91d7e1f11..7f3999b551 100644
--- a/revision.c
+++ b/revision.c
@@ -1903,8 +1903,13 @@ static int add_parents_only(struct rev_info *revs, const char *arg_, int flags,
 		return 0;
 	while (1) {
 		it = get_reference(revs, arg, &oid, 0);
-		if (!it && revs->ignore_missing)
-			return 0;
+		if (!it) {
+			if (revs->ignore_missing)
+				return 0;
+			if (revs->do_not_die_on_missing_objects)
+				return 0;
+			return -1;
+		}
 		if (it->type != OBJ_TAG)
 			break;
 		if (!((struct tag*)it)->tagged)
diff --git a/t/t0410-partial-clone.sh b/t/t0410-partial-clone.sh
index dff442da20..cc070019be 100755
--- a/t/t0410-partial-clone.sh
+++ b/t/t0410-partial-clone.sh
@@ -489,6 +489,24 @@ test_expect_success 'rev-list dies for missing objects on cmd line' '
 	done
 '
 
+test_expect_success '--exclude-promisor-objects with ^@ on missing object' '
+	rm -rf repo &&
+	test_create_repo repo &&
+	test_commit -C repo foo &&
+	test_commit -C repo bar &&
+
+	COMMIT=$(git -C repo rev-parse foo) &&
+	promise_and_delete "$COMMIT" &&
+
+	git -C repo config core.repositoryformatversion 1 &&
+	git -C repo config extensions.partialclone "arbitrary string" &&
+
+	# Ensure that "$COMMIT^@" is handled gracefully even though the
+	# actual commits are missing.
+	git -C repo rev-list --exclude-promisor-objects "$COMMIT^@" >out &&
+	test_must_be_empty out
+'
+
 test_expect_success 'single promisor remote can be re-initialized gracefully' '
 	# ensure one promisor is in the promisors list
 	rm -rf repo &&
-- 
gitgitgadget

