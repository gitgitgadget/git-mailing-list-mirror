Received: from mail-oa1-f53.google.com (mail-oa1-f53.google.com [209.85.160.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70FB535DA48
	for <git@vger.kernel.org>; Tue, 21 Apr 2026 20:02:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776801723; cv=none; b=E9xTIwqrazy9Ui7l61G7AqgSTHPa9bTNcXEEak1JQ/Tkrkc3HCz3rkdGYyVwuRpBqWiaHYTUN4ngjx9OdP4RouAHm3PKFwKQGv7SXjKHQgAaL4z/NBCZETFJXnT7aDAPE/mIlacHVDj2+yeYkO53BBdQHGEpkCxkVoj/AQO69As=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776801723; c=relaxed/simple;
	bh=21cUDkIVjtgvYO8mFMcVyh6EXY4ksg5OyEzmjNhCcwQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bpEZelO0+UDU0rvAZVigC0cY8wHXYgA6x2egBRY86kWc3MYHgYzfgRxmNrFRUYoFBuLA9GwQTRM7rbKHF1qN+BgRCsEUhA3t94kGjyx6R+CgyjKF8bty3sDtdTVtQYOo53c8RWzoqfZl5C60cggr7jaVldB0b3RakSrgHYDyezw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b=nAx7JJP9; arc=none smtp.client-ip=209.85.160.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b="nAx7JJP9"
Received: by mail-oa1-f53.google.com with SMTP id 586e51a60fabf-4043b27ddeaso2492408fac.1
        for <git@vger.kernel.org>; Tue, 21 Apr 2026 13:02:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr.com; s=google; t=1776801720; x=1777406520; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=VOIQxnf95YribhEVrQzjXRn2qL2G6qci0T4KLDCNHRQ=;
        b=nAx7JJP99BI6COZ4SrJcp0QKBOFFAIFqmXkWTrfFMBDWg6+W5Ega7nrq9yKboF/cYw
         ZuaSgSaxJUqz6Kme6frzR/Kj6n9oOWMyG50dqeDlXOFJkBoylBEfZI/fX5vAZKPd8Mt9
         UKjLIgLVmoUc7780Ey/dSckOrAPU18DSckYiCzjuj0dPmZ3rHDaEY9uJ3rPTAz43WKa3
         zP0ldVxtYiKmmgYEMtKxDijJca+ZqOvF98Vv6c+JA1z33iF7PWChqHDJ7QV5/LOmHobd
         jXKcH/F3KBfpUZPahT03vmSUkDa7ffLymG241eIdBA6ry36gWe4QPHGAa2uG0dUwxmbE
         RrOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776801720; x=1777406520;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VOIQxnf95YribhEVrQzjXRn2qL2G6qci0T4KLDCNHRQ=;
        b=oVVBFokpxaTD3dDky9IW1EpuqteoTDRRJE3je0wwItSrLYnEKV13CD7k/Ewm2fZlfZ
         n2v1CFCa5VNUwVco7HS9kgFZOu07pfX4f4x+AXFir3dSIl4S7OM2SL8rz5t0ST4IIFG1
         ymAI1hHkwmPQFufiepql7TOuLFuG2ADJzz17AXYYGi3MdwYrntdo5DKZQhH4VGNx4tw9
         EfJm45KriDxR9ZO54ukkkgOABsYtA8fpJSUC85t+icxFdmUJ1iE7NhzYIvZ8iFUISqUq
         4lepYMJGoQwxt+r0jiTnXfM9QRIpCYiRMlKUMnzZNhb2OIV9eHx98ip3l3L8TIVzU8cu
         0+IQ==
X-Gm-Message-State: AOJu0YzcCPk5IVN0QQMWT2NLJfnA83zCRoqxMwGSA1SYFttjuT+Y5l8O
	e0qwCi/B5mg21+LIcjQ7o//IHdrO7v3ml4jNuDP1cI9Skuac5rQXPnbc06lXHrK0866W/4Pv9Cu
	yCGzpb1M=
X-Gm-Gg: AeBDieuiBo2LmDVREk6y8vjp+twfwx3SDwuIKF6ws8EISR01deg3AeaG2tbMKPCV00H
	2VnTltyO4pcleoHrvlXFhHATaLZ0KlimK71lwaApBoNMd14uMNrdelFCRmVv3IhpS+/DqsqOpn3
	doHvoN/RZaF6voQu7U9xrK44PcRHXxzsajatz93+tW6zIPYPHXvoXxwxZvO30Xp7EexBEYZ2OHR
	o9am3lF2Mvt6DnFjJfXTcY7Vmg+V2jpgGfU0SsIOZ1FTjeuK2bYJmWNBSt69Y0e9l0YWD7MY7MS
	l4PvUFdUem9AFqD/DIBtW8iRmMOUUd9ieXFxAcgVumFysSmtqedVGWWXAvQQGazun8KXK6hmO1x
	SP4YKCd8XgBCe1/EfvGSLSoXwLvGquzORu1KmZ5vEQTBMhNUUcsP7lfnR8M2Vdh9LngC9AqglyD
	EhscS+8kBvMJZetUge4rrR70856KS5zsgwqov+iCprTBRP6QodHw4iJwh5D+etfUq7Y9NCi04cY
	mWhESTia/WPATTEQ356t9TDN+Q53I+8ki0boQ7PNZsf9qJiYpWJCodDv86ARlfJDBux/iwg9Vyp
	wnDHGAMHTtqfZjm9JJirh0fKOqs=
X-Received: by 2002:a05:6870:2486:b0:42c:48c:3ef5 with SMTP id 586e51a60fabf-42c048c40c2mr6183373fac.35.1776801720163;
        Tue, 21 Apr 2026 13:02:00 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-42b9ac54ec5sm12198097fac.13.2026.04.21.13.01.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Apr 2026 13:01:59 -0700 (PDT)
Date: Tue, 21 Apr 2026 16:01:58 -0400
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Elijah Newren <newren@gmail.com>
Subject: [PATCH v2 2/9] t5333: demonstrate various pseudo-merge bugs
Message-ID: <11de33437264ef2d4eaae9b718ff2f3b1e26a114.1776801694.git.me@ttaylorr.com>
References: <cover.1776124588.git.me@ttaylorr.com>
 <cover.1776801694.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1776801694.git.me@ttaylorr.com>

Using the test helper introduced via the previous commit, add various
failing tests demonstrating bugs in the pseudo-merge implementation.

These are all marked as failing with one exception. The "sampleRate=0"
test describes a latent bug, which is only reachable through a code path
that is itself masked by a separate bug. A future commit will fix that
bug, and, in turn, cause the aforementioned test to fail. Accordingly,
that commit will mark the test as failing, and it will be re-marked as
passing in a separate commit which fixes the once-latent bug.

For the rest: the following commits will explain and fix the underlying
bugs in detail.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 t/t5333-pseudo-merge-bitmaps.sh | 198 ++++++++++++++++++++++++++++++++
 1 file changed, 198 insertions(+)

diff --git a/t/t5333-pseudo-merge-bitmaps.sh b/t/t5333-pseudo-merge-bitmaps.sh
index 1f7a5d82ee4..0e9638c31c3 100755
--- a/t/t5333-pseudo-merge-bitmaps.sh
+++ b/t/t5333-pseudo-merge-bitmaps.sh
@@ -462,4 +462,202 @@ test_expect_success 'use pseudo-merge in boundary traversal' '
 	)
 '
 
+test_expect_failure 'apply pseudo-merges during fill-in traversal' '
+	test_when_finished "rm -fr pseudo-merge-fill-in-traversal" &&
+	git init pseudo-merge-fill-in-traversal &&
+	(
+		cd pseudo-merge-fill-in-traversal &&
+
+		git config bitmapPseudoMerge.test.pattern refs/tags/ &&
+		git config bitmapPseudoMerge.test.maxMerges 1 &&
+		git config bitmapPseudoMerge.test.stableThreshold never &&
+
+		test_commit_bulk 64 &&
+		tag_everything &&
+		git repack -ad &&
+
+		pack=$(ls .git/objects/pack/pack-*.pack) &&
+		git rev-parse HEAD~63 >in &&
+		test-tool bitmap write "$(basename $pack)" <in &&
+
+		test_pseudo_merges >merges &&
+		test_line_count = 1 merges &&
+
+		test_commit stale &&
+
+		git rev-list --count --objects HEAD >expect &&
+
+		: >trace2.txt &&
+		GIT_TRACE2_EVENT=$PWD/trace2.txt \
+			git rev-list --count --objects --use-bitmap-index HEAD >actual &&
+		test_pseudo_merges_satisfied 1 <trace2.txt &&
+
+		test_cmp expect actual
+	)
+'
+
+test_expect_failure 'apply pseudo-merges from multiple groups during fill-in' '
+	test_when_finished "rm -fr pseudo-merge-fill-in-multi" &&
+	git init pseudo-merge-fill-in-multi &&
+	(
+		cd pseudo-merge-fill-in-multi &&
+
+		test_commit base &&
+		base=$(git rev-parse HEAD) &&
+
+		for side in left right
+		do
+			git checkout -B $side base &&
+
+			test_commit_bulk --id=$side 64 &&
+			git rev-list --no-object-names HEAD --not $base >in &&
+			while read oid
+			do
+				echo "create refs/group-$side/$oid $oid" || return 1
+			done <in | git update-ref --stdin || return 1
+		done &&
+
+		git checkout left &&
+		git merge right &&
+		git repack -ad &&
+
+		git config bitmapPseudoMerge.left.pattern "refs/group-left/" &&
+		git config bitmapPseudoMerge.left.maxMerges 1 &&
+		git config bitmapPseudoMerge.left.stableThreshold never &&
+
+		git config bitmapPseudoMerge.right.pattern "refs/group-right/" &&
+		git config bitmapPseudoMerge.right.maxMerges 1 &&
+		git config bitmapPseudoMerge.right.stableThreshold never &&
+
+		pack="$(ls .git/objects/pack/pack-*.pack)" &&
+		git rev-parse "$base" >in &&
+		test-tool bitmap write "$(basename $pack)" <in &&
+
+		test_pseudo_merges >merges &&
+		test_line_count = 2 merges &&
+
+		test_commit stale &&
+
+		git rev-list --count --objects HEAD >expect &&
+
+		: >trace2.txt &&
+		GIT_TRACE2_EVENT=$PWD/trace2.txt \
+			git rev-list --count --objects --use-bitmap-index HEAD >actual &&
+		test_pseudo_merges_satisfied 2 <trace2.txt &&
+
+		test_cmp expect actual
+	)
+'
+
+test_expect_failure 'apply pseudo-merges with overlapping groups during fill-in' '
+	test_when_finished "rm -fr pseudo-merge-fill-in-overlap" &&
+	git init pseudo-merge-fill-in-overlap &&
+	(
+		cd pseudo-merge-fill-in-overlap &&
+
+		test_commit_bulk 64 &&
+		tag_everything &&
+		git repack -ad &&
+
+		pack="$(ls .git/objects/pack/pack-*.pack)" &&
+
+		# Use two pseudo-merge group patterns that both match
+		# refs/tags/, so every tagged commit belongs to both
+		# groups. This exercises the extended lookup table
+		# path in apply_pseudo_merges_for_commit().
+		git config bitmapPseudoMerge.all.pattern "refs/tags/" &&
+		git config bitmapPseudoMerge.all.maxMerges 1 &&
+		git config bitmapPseudoMerge.all.stableThreshold never &&
+
+		git config bitmapPseudoMerge.tags.pattern "refs/tags/" &&
+		git config bitmapPseudoMerge.tags.maxMerges 1 &&
+		git config bitmapPseudoMerge.tags.stableThreshold never &&
+
+		git rev-parse HEAD~63 >in &&
+		test-tool bitmap write "$(basename $pack)" <in &&
+
+		test_pseudo_merges >merges &&
+		test_line_count = 2 merges &&
+
+		test_commit stale &&
+
+		git rev-list --count --objects HEAD >expect &&
+
+		: >trace2.txt &&
+		GIT_TRACE2_EVENT=$PWD/trace2.txt \
+			git rev-list --count --objects --use-bitmap-index HEAD >actual &&
+		test_pseudo_merges_satisfied 2 <trace2.txt &&
+
+		test_cmp expect actual
+	)
+'
+
+test_expect_failure 'pseudo-merge commits are correctly classified by date' '
+	test_when_finished "rm -fr pseudo-merge-date-classification" &&
+	git init pseudo-merge-date-classification &&
+	(
+		cd pseudo-merge-date-classification &&
+
+		test_commit_bulk 64 &&
+		tag_everything &&
+		git repack -ad &&
+
+		pack="$(ls .git/objects/pack/pack-*.pack)" &&
+
+		# Configure two pseudo-merge groups: one that only
+		# matches "stable" refs (older than one month), and one
+		# that matches all refs. With 64 freshly-created tags
+		# (all younger than one month) the stable group should
+		# have zero pseudo-merges and the catch-all group should
+		# have one.
+		#
+		# Use GIT_TEST_DATE_NOW to align "now" (and therefore
+		# "1.month.ago") with the test_tick timestamps so that
+		# the commits are within the last month.
+		#
+		# This exercises the date-based classification in
+		# find_pseudo_merge_group_for_ref(), which requires
+		# that commits are parsed before inspecting their date.
+		git config bitmapPseudoMerge.stable.pattern "refs/tags/" &&
+		git config bitmapPseudoMerge.stable.maxMerges 64 &&
+		git config bitmapPseudoMerge.stable.stableThreshold never &&
+		git config bitmapPseudoMerge.stable.threshold 1.month.ago &&
+
+		git config bitmapPseudoMerge.all.pattern "refs/tags/" &&
+		git config bitmapPseudoMerge.all.maxMerges 1 &&
+		git config bitmapPseudoMerge.all.stableThreshold never &&
+		git config bitmapPseudoMerge.all.threshold now &&
+
+		git rev-parse HEAD~63 >in &&
+		GIT_TEST_DATE_NOW=$test_tick \
+			test-tool bitmap write "$(basename $pack)" <in &&
+
+		test_pseudo_merges >merges &&
+		test_line_count = 1 merges
+	)
+'
+
+test_expect_success 'sampleRate=0 does not cause division by zero' '
+	test_when_finished "rm -fr pseudo-merge-sample-rate-zero" &&
+	git init pseudo-merge-sample-rate-zero &&
+	(
+		cd pseudo-merge-sample-rate-zero &&
+
+		test_commit_bulk 64 &&
+		tag_everything &&
+		git repack -ad &&
+
+		pack="$(ls .git/objects/pack/pack-*.pack)" &&
+
+		git config bitmapPseudoMerge.test.pattern "refs/tags/" &&
+		git config bitmapPseudoMerge.test.maxMerges 1 &&
+		git config bitmapPseudoMerge.test.sampleRate 0 &&
+		git config bitmapPseudoMerge.test.threshold now &&
+		git config bitmapPseudoMerge.test.stableThreshold never &&
+
+		git rev-parse HEAD~63 >in &&
+		test-tool bitmap write "$(basename $pack)" <in
+	)
+'
+
 test_done
-- 
2.54.0.9.gb905fd5d0ae

