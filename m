Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2534370ADA
	for <git@vger.kernel.org>; Wed,  1 Jul 2026 16:37:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782923847; cv=none; b=iE8nB7JmvCY9mHOEnaA9QBRbAVgSrTxroOI4NU/shhze0Nd82AHpwhij0oqHCLyuFzh9LTFC5cUOPhJ+f7n8b4heW1iiewfbKMzjPmeyY+5JDjw23dl4r+tQ9qqPRNfSsZ0Pd7LOnp0413ljdlWin5ZdQcgnaPJIyRtl2CIyXlM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782923847; c=relaxed/simple;
	bh=BKDzaGPfRO4AXLrseo3jOH65NNZJw3zpqIoYOXlAioA=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=tQPhjPuQtPLvCh5H6nBsVZ5wWH52mWw4Q01C1xqnQETz00d+7MXIjDXtwQg2w+QQN4OE4QJpA09mtEC9MHFUIaI1ITy93ZvhAYJglyceHDc/sq5mNVnu1rTR8Tk1ZhQEHG3VfHPFUXMckbpKNSesWrBy0oQRHSVd5ZyZMmgtCCc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Oz7QKjwW; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Oz7QKjwW"
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-8478fe07f0fso683759b3a.0
        for <git@vger.kernel.org>; Wed, 01 Jul 2026 09:37:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782923844; x=1783528644; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wRNag0reELlIwxvnPsLxSimiW3wNZkNm5RU6i4Q3Sx8=;
        b=Oz7QKjwW8Nd/tJnsS16zJqDP7A2Gqn+lPCo293SPy1hr0Snyn2f6RC6ZH+lwzKab/9
         jer0pMBZwhA7agxZb9bm6gHttGCXB76+mEaqhO76lEQHz121wrPp8XOKoH+14VwWgXVA
         Go/QHSE7Ut25vde1uvVSzum4LuyJ4MY9Lgn2+XgV7lKgZ6VM2jkUTKJL5SQwjUzU+ZUi
         cx7RPXWXfX9oTqWC3GYZI0XYUoh7sM7nSN+1R7Aq9XoaE6SQH6VFVlZesgJrg63O27SK
         VF80j24qIN5E/+MGLljTXcMDbr4Eu985snKGCIvUmy9Q7zFFQbECBdK5kFLf8bOOOPQ4
         0UBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782923844; x=1783528644;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=wRNag0reELlIwxvnPsLxSimiW3wNZkNm5RU6i4Q3Sx8=;
        b=UHrRR55tB250sGyKy8A3fuuQH45HDNhTE/69GQdFMoylZZxRhwawCMw+r2nIJ4rOtH
         eahZJS5bELdpwKks43FX0HMwhipyihp5OJ3JPgNCnTJOqwx1kHYWU9N602ISTgp5GHy3
         CZ+7Zx7SEMJww94C9KaHsCkiTA6AOXPrMi5B6AJ4e+w5k+YbecMUw2S5rV9PpYtFd8sf
         HtNxthH0kisCC3hMMmngnX61wA6VbVma4hRWHxA4bt9BFjTsk89DKFRsjb9A/c8Y7vLG
         xAQhxfHjiXjHrrOLWZC7CjKyHlI92Q5WnjYrbp7eaC9Bj1C9PP26q9v5H6zEBtaYOxWS
         c35Q==
X-Gm-Message-State: AOJu0YzxINSeSaUbWKDcAdYgQRXH65U6Ju1qG9KmXG5Yxar8Mck0zMWz
	/iGJ0GWFv8Wf6OrOK1ELxWzqd86wvq098jkbjnJ4KfWPnMXL0vxLHrfLopkVUA==
X-Gm-Gg: AfdE7cm+rOJM981yXx9FkVWCtfv5IPUPQ4IiIkGP0NsIGUczOsHdystbaCwIMTQrmxA
	KPyEQS6e2UUyP/YVQtigx+q71VLu0euy2u9CafzMwF2fybuSPYBDXfUpQirqSGjfeh5jGx89B4N
	9Du1rr1u6yiRuy6XH4olb+MziIWFO8wnu4HxKo76E5PS7ZYvUDbO+RstP4htkdqwF+DoguJ+Qs1
	EFTTFX8/RgT3eFR3NZieUUPjyO0P/i3WOX5qJaghZyjDzjB7T7/Mm1Gx55cgR4DBI7SVWCqEzas
	mFtK9pNmOWRirr01GaysMD5NTdjQCwl875ESZTI5zNhAukigdQCyiujmZ8RvpW2ONxPCbpfuHcq
	nHOFss6iF/wq3TfyYHPQg7lUBh6L6SDlLhc82WTdOg/mmXyyZbKxxW711KGmKXn+4PjtpFEhusk
	Lhg0Lk+xxA4YGWkhk=
X-Received: by 2002:a05:6a00:849:b0:845:4cb5:2343 with SMTP id d2e1a72fcca58-847c06f3d03mr2253415b3a.19.1782923843640;
        Wed, 01 Jul 2026 09:37:23 -0700 (PDT)
Received: from [127.0.0.1] ([20.57.198.170])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-847cb9902efsm60846b3a.45.2026.07.01.09.37.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Jul 2026 09:37:22 -0700 (PDT)
Message-Id: <b9fb8bfe2697cc63eb33ae6cc7645ec484715187.1782923832.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2149.v5.git.1782923832.gitgitgadget@gmail.com>
References: <pull.2149.v4.git.1782649547.gitgitgadget@gmail.com>
	<pull.2149.v5.git.1782923832.gitgitgadget@gmail.com>
From: "Kristofer Karlsson via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 01 Jul 2026 16:37:06 +0000
Subject: [PATCH v5 05/10] commit-reach: add trace2 instrumentation to
 paint_down_to_common()
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
Cc: Kristofer Karlsson <krka@spotify.com>,
    Kristofer Karlsson <krka@spotify.com>

From: Kristofer Karlsson <krka@spotify.com>

Add a step counter and trace2_data_intmax() call so that the number
of commits visited during the paint walk is observable via
GIT_TRACE2_EVENT. This provides a way to measure the impact of
future optimizations without relying on wall-clock benchmarks alone.

Signed-off-by: Kristofer Karlsson <krka@spotify.com>
---
 commit-reach.c        |  5 +++++
 t/t6600-test-reach.sh | 44 ++++++++++++++++++++++++++++++-------------
 2 files changed, 36 insertions(+), 13 deletions(-)

diff --git a/commit-reach.c b/commit-reach.c
index a9483759e0..f6a438550b 100644
--- a/commit-reach.c
+++ b/commit-reach.c
@@ -11,6 +11,7 @@
 #include "tag.h"
 #include "commit-reach.h"
 #include "ewah/ewok.h"
+#include "trace2.h"
 
 /* Remember to update object flag allocation in object.h */
 #define PARENT1		(1u<<16)
@@ -112,6 +113,7 @@ static int paint_down_to_common(struct repository *r,
 		{ compare_commits_by_gen_then_commit_date }
 	};
 	int i;
+	int steps = 0;
 	timestamp_t last_gen = GENERATION_NUMBER_INFINITY;
 	struct commit_list **tail = result;
 
@@ -135,6 +137,7 @@ static int paint_down_to_common(struct repository *r,
 		struct commit_list *parents;
 		int flags;
 		timestamp_t generation = commit_graph_generation(commit);
+		steps++;
 
 		if (min_generation && generation > last_gen)
 			BUG("bad generation skip %"PRItime" > %"PRItime" at %s",
@@ -190,6 +193,8 @@ static int paint_down_to_common(struct repository *r,
 	}
 
 	clear_nonstale_queue(&queue);
+	trace2_data_intmax("paint_down_to_common", r,
+			   "steps", steps);
 	commit_list_sort_by_date(result);
 	return 0;
 }
diff --git a/t/t6600-test-reach.sh b/t/t6600-test-reach.sh
index b536a5952a..7a9a35023f 100755
--- a/t/t6600-test-reach.sh
+++ b/t/t6600-test-reach.sh
@@ -117,24 +117,34 @@ test_expect_success 'setup' '
 '
 
 run_all_modes () {
-	test_when_finished rm -rf .git/objects/info/commit-graph &&
-	"$@" <input >actual &&
-	test_cmp expect actual &&
-	cp commit-graph-full .git/objects/info/commit-graph &&
-	"$@" <input >actual &&
-	test_cmp expect actual &&
-	cp commit-graph-half .git/objects/info/commit-graph &&
-	"$@" <input >actual &&
-	test_cmp expect actual &&
-	cp commit-graph-no-gdat .git/objects/info/commit-graph &&
-	"$@" <input >actual &&
-	test_cmp expect actual
+	graph=.git/objects/info/commit-graph &&
+	test_when_finished rm -rf "$graph" "${graph}s" &&
+	rm -f trace-mode-*.txt &&
+
+	for mode in none full half no-gdat
+	do
+		rm -rf "$graph" "${graph}s" &&
+		cp "commit-graph-${mode}" "$graph" 2>/dev/null ||
+		true &&
+		GIT_TRACE2_EVENT="$(pwd)/trace-mode-${mode}.txt" \
+			"$@" <input >actual &&
+		test_cmp expect actual || return 1
+	done
 }
 
 test_all_modes () {
 	run_all_modes test-tool reach "$@"
 }
 
+test_paint_down_steps () {
+	for mode in none full half no-gdat
+	do
+		test_trace2_data_singular paint_down_to_common steps "$1" \
+			"mode=$mode" <"trace-mode-${mode}.txt" || return 1
+		shift
+	done
+}
+
 test_expect_success 'ref_newer:miss' '
 	cat >input <<-\EOF &&
 	A:commit-5-7
@@ -208,7 +218,8 @@ test_expect_success 'in_merge_bases_many:self' '
 	X:commit-6-8
 	EOF
 	echo "in_merge_bases_many(A,X):1" >expect &&
-	test_all_modes in_merge_bases_many
+	test_all_modes in_merge_bases_many &&
+	test_paint_down_steps 45 2 25 3
 '
 
 test_expect_success 'is_descendant_of:hit' '
@@ -293,6 +304,13 @@ test_expect_success 'get_merge_bases_many:infinity-both-sides' '
 	test_all_modes get_merge_bases_many
 '
 
+test_expect_success 'merge-base --all commit-walk steps' '
+	>input &&
+	git rev-parse commit-9-1 >expect &&
+	run_all_modes git merge-base --all commit-9-9 commit-9-1 &&
+	test_paint_down_steps 81 80 81 81
+'
+
 test_expect_success 'reduce_heads' '
 	cat >input <<-\EOF &&
 	X:commit-1-10
-- 
gitgitgadget

