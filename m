Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC9C73CAA27
	for <git@vger.kernel.org>; Tue, 26 May 2026 08:03:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779782596; cv=none; b=AY8iQY/HefxmN/bCvcbRDoRWOnno8tshzWqyDY2TQx8E+MvkS+xoXWmQ5bEnzuGoRIl9t72SvogCst3hz1LkgxLJLHDsU9xaHya7yrAPKdSLfdwWe4EzzBiBLfqWXTlLig+1vbM+G0P7yj74Dqs0f+PtvIRoD6JE5WvN2VMvMek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779782596; c=relaxed/simple;
	bh=y8UB7Fn77/Mu0fxz+0XnZIOEAwpxJJlC+LAb628IBe4=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=c2rXE+aw1E5VcCYQwB7s0gVx8yGi2ed79BFUCk4Wq4IBH/JwSiI5excoBolXdi/iL/GlMIO9OGqfmbnFKvCW57NXyELtmYX/Wwfzp4Yh35Whr7DCEQyk5Z4A+wPeS/2ifXtp9h2+bQifR3LAHHEulp5r3n6h2Fn0daqoVkftFVQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hiTEQkbF; arc=none smtp.client-ip=209.85.222.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hiTEQkbF"
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-914bf8abeaeso288012685a.0
        for <git@vger.kernel.org>; Tue, 26 May 2026 01:03:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779782594; x=1780387394; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=s6xzmc8vichw8sTwdcfx20jb+K6vCQuw3mhnY/4wmG0=;
        b=hiTEQkbFQqBuC+JD03l1jZd/cL/CmGYLuualzIAophDfMpRHgbNgL8IQ7RG2/doJcG
         Pj/SHlrBL/0ObBMlQhEp2PVXc3MZsXWqUOwcf/WwR7Q68M1SOzsoLQzJBDak2fUmEoPB
         7SQ4cZ4kkyJ6/LFytaQpm28/J955T5kTJq0zEYkUFTtRmXEF2hIl35RhJMDg5rLrua9s
         amDYpCF8OgMgEG2wTRu/rWM2KbmWJrNVQhHcRlchLwwTM5Pm9I0HhH83RkNqP8SvLAyi
         JyPBAonnoQgp+j6ia2tEg/dt+6LNd1IDxe1mP3cCJkMaapfb13tOWSTguBI27RHb4NVB
         pMQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779782594; x=1780387394;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=s6xzmc8vichw8sTwdcfx20jb+K6vCQuw3mhnY/4wmG0=;
        b=KTdjDMWFa8QqMEl4qXZVRAmw94FZskl7vxz9TFFxfi210eFcAWQ1nSxp00Pz8d6YLB
         MVFZMG49+LhRricsWgsO6mN8ZPAfAcitjK+QCSkp2O3xUUfBMLoxTTkmVhBSkJKGcYEB
         t4bpMSOWThUZ4Rx+N7i9rKuRdczw47unoPn+KQwwqeNWTutBL1wSzzJqBQf31xMdfvD+
         2WS3iD2Q7h6xOtZr6nJm8IDssd4ne/HuNnRZK/7uc7mLL6cLncz2eRRTTWMZCGf+sYeS
         j6o6XAnlDOgz9FZfF6DnjgbT6JW9g/Raw+rAeqBk0uNyJbg4IABIPzNvQw/NgmnWtLqd
         IOcg==
X-Gm-Message-State: AOJu0YyFfBbJQ8JrCnOAEs3yla7KoTtw3D/tQTX2nNynRR0AKuHUqKBp
	YEXTuvs3j64ZqJM5zkRRo62M09N97e+8vbIwNGMibb44L7bruXEbZ/SI5TjqTbJm
X-Gm-Gg: Acq92OFqkZd8fvLN8xbyeCKNXZzkdMNh8EPoM5tADtQSOPQFn6uG7pjvodyvbCRt+cF
	VjLcBtWKBuwJh/MkdK+9DCehLOnzw4ou3Hi4tU4lbU/XA4ysSmOeOW4+G7nLOD77uCkC9vDoF64
	Y3DlTkvAsmr1tD2iQnRB5FUtFgznnHImarU31g/YB8RrdFo25gBOfGWZVYUIpOiMXpM55cM2/yF
	Gp/zFnq0Dio2c/ua+Qc2rcWA944EjmFexhwlpovIhaMhzt3PIM6amIaEmu/YCHlGek1xABxP48T
	2oCgBEUygF0XwkUZtGyE2J0BMadSHcB4EEvm72KFsz/jvhFNbfPWVwrcKCBCYPsoh8hgKbnH16R
	eFHKqKGeSKjNL1DnGU7OxAFWt9xCZV9++EvF10GCrpmnoYnfhwMf1H2K620XBGhAmRiGVRq7KPr
	VXTCzo2V2zLLzEQ1jpWVhNTxh5eUBhuI2HdF18CQ==
X-Received: by 2002:a05:620a:2a08:b0:914:7b4f:cf5b with SMTP id af79cd13be357-914b48e5b0emr2495700085a.16.1779782593771;
        Tue, 26 May 2026 01:03:13 -0700 (PDT)
Received: from [127.0.0.1] ([57.151.122.145])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-914f88022e5sm132074585a.37.2026.05.26.01.03.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 May 2026 01:03:13 -0700 (PDT)
Message-Id: <13063f998a43a9b3904cf8b338c038a51fb80150.1779782591.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2125.git.1779782591.gitgitgadget@gmail.com>
References: <pull.2125.git.1779782591.gitgitgadget@gmail.com>
From: "George Giorgidze via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 26 May 2026 08:03:09 +0000
Subject: [PATCH 1/2] preload-index: respect --really-refresh override of
 assume-unchanged
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
Cc: Junio C Hamano <gitster@pobox.com>,
    George Giorgidze <giorgidze@meta.com>,
    George Giorgidze <giorgidze@meta.com>

From: George Giorgidze <giorgidze@meta.com>

When refresh_index() is invoked with REFRESH_REALLY (e.g. via
"git update-index --really-refresh"), the documented behaviour is that
the "assume unchanged" bit on cache entries is disregarded so that
stale stat data on those entries is still refreshed.

The preload pass runs before the single-threaded refresh loop and is
intended to mark up-to-date entries quickly so the slow path only has
to deal with the leftovers. However, preload_thread() unconditionally
called ie_match_stat() with CE_MATCH_RACY_IS_DIRTY|CE_MATCH_IGNORE_FSMONITOR
and never with CE_MATCH_IGNORE_VALID, so it honoured the "assume
unchanged" bit. When a modified file's entry was marked
assume-unchanged, preload would conclude the entry was clean and call
ce_mark_uptodate(); the subsequent --really-refresh loop would then
skip the entry (because ce_uptodate(ce) is true) and never report it
as needing an update.

This only manifests when preload is active, so it has been latent in
default configurations. It is observable today via GIT_TEST_PRELOAD_INDEX=1.

Plumb the refresh flags through to the preload threads via a new
refresh_flags field on struct thread_data, and have preload_thread()
add CE_MATCH_IGNORE_VALID to its match options when REFRESH_REALLY is
in effect. Update refresh_index() to pass "flags & REFRESH_REALLY" to
preload_index() instead of a bare 0.

Add a regression test under t2106 that forces preload on and confirms
that "update-index --really-refresh" reports a modified
assume-unchanged entry as needing update.

Signed-off-by: George Giorgidze <giorgidze@meta.com>
---
 preload-index.c                          |  7 ++++++-
 read-cache.c                             |  2 +-
 t/t2106-update-index-assume-unchanged.sh | 11 +++++++++++
 3 files changed, 18 insertions(+), 2 deletions(-)

diff --git a/preload-index.c b/preload-index.c
index b222821b44..88bb486329 100644
--- a/preload-index.c
+++ b/preload-index.c
@@ -42,6 +42,7 @@ struct thread_data {
 	struct progress_data *progress;
 	int offset, nr;
 	int t2_nr_lstat;
+	unsigned int refresh_flags;
 };
 
 static void *preload_thread(void *_data)
@@ -60,6 +61,7 @@ static void *preload_thread(void *_data)
 	do {
 		struct cache_entry *ce = *cep++;
 		struct stat st;
+		unsigned int ce_option = CE_MATCH_RACY_IS_DIRTY | CE_MATCH_IGNORE_FSMONITOR;
 
 		if (ce_stage(ce))
 			continue;
@@ -87,7 +89,9 @@ static void *preload_thread(void *_data)
 		p->t2_nr_lstat++;
 		if (lstat(ce->name, &st))
 			continue;
-		if (ie_match_stat(index, ce, &st, CE_MATCH_RACY_IS_DIRTY|CE_MATCH_IGNORE_FSMONITOR))
+		if (p->refresh_flags & REFRESH_REALLY)
+			ce_option |= CE_MATCH_IGNORE_VALID;
+		if (ie_match_stat(index, ce, &st, ce_option))
 			continue;
 		ce_mark_uptodate(ce);
 		mark_fsmonitor_valid(index, ce);
@@ -150,6 +154,7 @@ void preload_index(struct index_state *index,
 			copy_pathspec(&p->pathspec, pathspec);
 		p->offset = offset;
 		p->nr = work;
+		p->refresh_flags = refresh_flags;
 		if (pd.progress)
 			p->progress = &pd;
 		offset += work;
diff --git a/read-cache.c b/read-cache.c
index 38a04b8de3..f5023b9a8b 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -1520,7 +1520,7 @@ int refresh_index(struct index_state *istate, unsigned int flags,
 	 * cache entries quickly then in the single threaded loop below,
 	 * we only have to do the special cases that are left.
 	 */
-	preload_index(istate, pathspec, 0);
+	preload_index(istate, pathspec, flags & REFRESH_REALLY);
 	trace2_region_enter("index", "refresh", NULL);
 
 	for (i = 0; i < istate->cache_nr; i++) {
diff --git a/t/t2106-update-index-assume-unchanged.sh b/t/t2106-update-index-assume-unchanged.sh
index 6b2ccc21a9..266c88d45d 100755
--- a/t/t2106-update-index-assume-unchanged.sh
+++ b/t/t2106-update-index-assume-unchanged.sh
@@ -24,4 +24,15 @@ test_expect_success 'do not switch branches with dirty file' '
 	test_grep overwritten err
 '
 
+test_expect_success '--really-refresh overrides assume-unchanged under preload' '
+	git reset --hard &&
+	test_commit really-refresh really-refresh original &&
+	git update-index --assume-unchanged really-refresh &&
+	printf "modified\n" >really-refresh &&
+	test-tool chmtime -100000 really-refresh &&
+	test_must_fail env GIT_TEST_PRELOAD_INDEX=1 \
+		git update-index --really-refresh >out 2>err &&
+	test_grep "needs update" out
+'
+
 test_done
-- 
gitgitgadget

