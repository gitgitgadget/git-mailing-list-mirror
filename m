Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com [209.85.219.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F6CD376A14
	for <git@vger.kernel.org>; Fri, 12 Jun 2026 21:49:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781300965; cv=none; b=pYInSm1+keGVxfelwKDleshvOlBdDhzLl6L+tFni0ueoLLAgiY8v036gXXmXrhYYVvuL2RT5CDkoo7TvqdwoD6LXZBbaW6/TBICnBPnazeZ6TF9+fcFKGdPadlHNVkOr5UJuC0+M384LhfxqzhfyplFu3yu7SKw3l4b0GHHfaMg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781300965; c=relaxed/simple;
	bh=dSuzC5UGEPRDp+gcxbU5yc+3gl1zEcLu0EI87Xm3zr0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=aKzkLwWhqSUSGwL+5oi2aw6NyCYzyUMSqUuBgMRsW1d4GEXj7NLUXydcpZIAquDVBlnx0i1i6KTVavloEiz0iQbmpvXag+f/MW7mcu54AcFLaNsujMmaDeymF/CRq4nf6dW47q2k39FCykg8xunb7AUr29n7kAmy32BlJnEyCEA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cCBaeHuf; arc=none smtp.client-ip=209.85.219.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cCBaeHuf"
Received: by mail-qv1-f45.google.com with SMTP id 6a1803df08f44-8ce65629acaso17126806d6.3
        for <git@vger.kernel.org>; Fri, 12 Jun 2026 14:49:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781300963; x=1781905763; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=N78Z7JroOznyP3zT79idQ67doXvN6wfR6LdF0GPwDQg=;
        b=cCBaeHufGnfKBs/qfxKRIvLpSHep9cENLzQ46b4xSYb5JooceThrFePWlbN+5pgGnr
         s+OkMUqTU4qBFKernHzCMo1/t5Dv83r8X+3H5DXugg9+dbjPc6UQ0SaiGTfQ2FtP2kvt
         jSt9/i4AF1nFdx9Kny444QJLKLs5WoZWtiRxtRvBcdHiSpjoK/yOLP6QEcZBLGIYomEB
         n6u8I45pdEwaVUdbbrlZHeE/52s06f8agT6NlcY3we3R9dcqDtSI+NT+itLrJTjAvay2
         AzP5GChjpOtqv8732JmIz31nAMAlXXtDdwt8wC9mjljGPiChy1nt1GrlkPN4AemtPQnq
         6MtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781300963; x=1781905763;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=N78Z7JroOznyP3zT79idQ67doXvN6wfR6LdF0GPwDQg=;
        b=TDJN6pMHzjcAYF8awZrwl9FpzaBQ/mjKs9OfCXkyZj7HWQY1e03dJQRhF4WxtiAltM
         sX4lze4Tp+7iiSBQbW11SpqXCSrk7D6JNmpEAH6Z+5zwNL7u/tWPcMammg+zOL5bhVXM
         9iAYlK9p8HUkIq8k8fzeSJWsZZeSmu8nKLvyf+j3O9a9XICPkYn2ApeuaZiJ9nso5p7y
         2fRhPANtEwCZOh71QlR7QjYeyq2HpXg5GZbWuEVHB0R4drfcQZOk7sZ0EFXqo7G6faBb
         jFLdrYTu/gap7722HcgRJGdsDB22OsNyZHR+RWO0DBTfaJ0cZVK03G7SzRh7cXXWbTvr
         MoYg==
X-Gm-Message-State: AOJu0YxCDXOQLxZ70xarN2DHAOOTqtEAxmYkvR6eRFr33ZMnjWm6ZhMq
	hXckHDKvbTWreEIa3A5W/cSGbFCxM9tZm3A5iyzLpqmgxb/HTdrgbfAa
X-Gm-Gg: Acq92OFIOs0OnbBtmbcMdQN7LpXi9BgoGbSNWf3aKTmmOyuz8y5XWyXwH3LFOVC3k/B
	pxrRR9HG5MvIXFzgmBO1nlRZdsVta09oHx8IeJ+CuX3sjVAkdS01oI8iSqUBE53H2ehvtHd7hBb
	iMcns38J3wpoCwZjgWn/7ZGgI8XscdesJcrPuLeD5KYZpyopyXZptuBiwxOWM3eI5sDB2GxF2Zq
	L0wAPOIq21hw4EoshW9zUF03JQ7praTSfYiwkN4NDiOsxsW0oizmfrRWtGU3p612kmnJ85cYRmS
	X3PyygzsKv+T/QHl+TIQUZN1hzwhSuDG8LkHjFVypbr3wyMFT1rmpsyM2KLitvWSFP3xCEGXpO6
	artT29cPKoyfLyrrzKRLX7rHmoutKzTicGEdyZkCE6srfM40IQOo9naud54GONcFeaBgVo+1vUq
	DF2dkNOSOYIBAuA6LPGcokjwQmJ5zKwpBLLF+NdhMRk0Ipg6ACEOQm87G+AlQwAutLUGoQvVXpS
	fdRggPACpK+IUjXwK0G08N9J5r0YCzEOoo6RR4RixBylVDXfQ+PdWLuEB6/cPKrB/h4puaC/vEP
	dkAsNUEGKrkrrMeW4j/xHwi/RwtOrKD3LLTw+YD/gBTWS8r0rE3bEAUmRHmMJwvI
X-Received: by 2002:a05:6214:d61:b0:8cc:611f:1972 with SMTP id 6a1803df08f44-8d32e30d2bamr76651376d6.34.1781300962925;
        Fri, 12 Jun 2026 14:49:22 -0700 (PDT)
Received: from 1.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.ip6.arpa ([2600:4808:6353:5c00:980:d7de:1287:a424])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8d302114676sm36593136d6.20.2026.06.12.14.49.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Jun 2026 14:49:21 -0700 (PDT)
From: Tamir Duberstein <tamird@gmail.com>
Date: Fri, 12 Jun 2026 17:49:13 -0400
Subject: [PATCH v4 2/3] ref-filter: memoize --contains with generations
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260612-ref-filter-memoized-contains-v4-2-5ed39fd001dd@gmail.com>
References: <20260612-ref-filter-memoized-contains-v4-0-5ed39fd001dd@gmail.com>
In-Reply-To: <20260612-ref-filter-memoized-contains-v4-0-5ed39fd001dd@gmail.com>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, Karthik Nayak <karthik.188@gmail.com>, 
 Junio C Hamano <gitster@pobox.com>, Victoria Dye <vdye@github.com>, 
 Derrick Stolee <stolee@gmail.com>, Elijah Newren <newren@gmail.com>, 
 Kristofer Karlsson <krka@spotify.com>, Tamir Duberstein <tamird@gmail.com>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openssh-sha256; t=1781300957; l=3525;
 i=tamird@gmail.com; h=from:subject:message-id;
 bh=dSuzC5UGEPRDp+gcxbU5yc+3gl1zEcLu0EI87Xm3zr0=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgtYz36g7iDMSkY5K7Ab51ksGX7hJgs
 MRt+XVZTrIzMVIAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QOlcwAumnCMBD8yh8jSno7/phDb2FPWp5y+zn0EFSmaY28SVOZSdVWLftS+j5sKeNowbQLw1j0O
 qzJjM7XH6MQQ=
X-Developer-Key: i=tamird@gmail.com; a=openssh;
 fpr=SHA256:264rPmnnrb+ERkS7DDS3tuwqcJss/zevJRzoylqMsbc

git branch and git for-each-ref run a separate reachability walk for
each ref considered by --contains and --no-contains. Refs with shared
history therefore traverse the same commits repeatedly.

git tag instead uses a depth-first walk that caches results across
refs. That walk can perform poorly without generation numbers: a
negative check may walk to the root instead of stopping at a nearby
divergence. Generation numbers let it stop below the oldest target.

Use the memoized walk for all ref-filter callers when generation
numbers are available. Keep git tag on its existing path without
generations. Caching still helps when many tags share deep history:
ffc4b8012d (tag: speed up --contains calculation, 2011-06-11) reduced
git tag --contains HEAD~200 in linux-2.6 from 15.417 to 5.329 seconds.

The new shared-history perf test improves from 0.72 to 0.03 seconds. In
a repository with 62,174 remote-tracking refs, running:

    git branch -r --contains c78ae85f3ce7e

improves from 104.365 seconds to 468 milliseconds.

Suggested-by: Jeff King <peff@peff.net>
Signed-off-by: Tamir Duberstein <tamird@gmail.com>
---
 commit-reach.c              |  3 ++-
 t/perf/p1500-graph-walks.sh | 28 +++++++++++++++++++++++++++-
 2 files changed, 29 insertions(+), 2 deletions(-)

diff --git a/commit-reach.c b/commit-reach.c
index e1bedc596d..18fcd69113 100644
--- a/commit-reach.c
+++ b/commit-reach.c
@@ -805,7 +805,8 @@ static enum contains_result contains_tag_algo(struct commit *candidate,
 int commit_contains(struct ref_filter *filter, struct commit *commit,
 		    struct commit_list *list, struct contains_cache *cache)
 {
-	if (filter->with_commit_tag_algo)
+	if (filter->with_commit_tag_algo ||
+	    generation_numbers_enabled(the_repository))
 		return contains_tag_algo(commit, list, cache) == CONTAINS_YES;
 	return repo_is_descendant_of(the_repository, commit, list);
 }
diff --git a/t/perf/p1500-graph-walks.sh b/t/perf/p1500-graph-walks.sh
index 5b23ce5db9..d167b4f7e1 100755
--- a/t/perf/p1500-graph-walks.sh
+++ b/t/perf/p1500-graph-walks.sh
@@ -32,7 +32,16 @@ test_expect_success 'setup' '
 		echo "X:$line" >>test-tool-tags || return 1
 	done &&
 
-	commit=$(git commit-tree $(git rev-parse HEAD^{tree})) &&
+	git rev-list --first-parent --max-count=8192 HEAD >contains-commits &&
+	test_file_not_empty contains-commits &&
+	git update-ref refs/contains-perf-base "$(tail -n 1 contains-commits)" &&
+	awk "{
+		printf \"update refs/contains-perf/%04d %s\\n\", NR, \$1
+	}" contains-commits |
+		git update-ref --stdin &&
+	git pack-refs --include "refs/contains-perf/*" &&
+
+	commit=$(git commit-tree HEAD^{tree}) &&
 	git update-ref refs/heads/disjoint-base $commit &&
 
 	git commit-graph write --reachable
@@ -62,6 +71,23 @@ test_perf 'contains: git tag --merged' '
 	xargs git tag --merged=HEAD <tags
 '
 
+test_perf 'contains: git for-each-ref' '
+	git for-each-ref --contains=refs/contains-perf-base --stdin <refs
+'
+
+test_perf 'contains: git branch' '
+	xargs git branch --contains=refs/contains-perf-base <branches
+'
+
+test_perf 'contains: git tag' '
+	xargs git tag --contains=refs/contains-perf-base <tags
+'
+
+test_perf 'contains: synthetic shared history' '
+	git for-each-ref --contains=refs/contains-perf-base \
+		refs/contains-perf/ >/dev/null
+'
+
 test_perf 'is-base check: test-tool reach (refs)' '
 	test-tool reach get_branch_base_for_tip <test-tool-refs
 '

-- 
2.54.0.548.gbe7bb2469c

