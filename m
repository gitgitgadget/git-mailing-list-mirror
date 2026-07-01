Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A419C372EC2
	for <git@vger.kernel.org>; Wed,  1 Jul 2026 16:37:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782923842; cv=none; b=i0vSwtMr1YuRmgyTMSkK2ou2T3AXSpXy1WAfHmVFVbssynAgB7xXRp3SeMzTVDxHXKPMrlGypXs068Q1QoGvH1e6+KJBZxsH7zbtQfz+CVMSlGwARehzf5zUdqY8qd28fMZMiLl9w7bFBnZcbJXCyw+k1JioDWbr3h7dFeRe1fY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782923842; c=relaxed/simple;
	bh=DBgB+4XWYBKLH+Q0YWrMVRgFQMBbPSyP8svf8UfPWS8=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=MCX5l6qLw3/odignV6XtWCsxrMmPfHJ7j8VIQKnAMp9nYx3L5Masi4iV/ys2/TkvK7ltnh8B+e7MaT7BT/LrffiuFinkkMwvQdLsI9bvtVAI+0innFjxUOJ1ArDA3Cu8mUr//+5NBdSFgFivXbYRuTYuAHF9uJuV7uvC3xvcU+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HCO0FwO4; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HCO0FwO4"
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-84347ad88edso788220b3a.1
        for <git@vger.kernel.org>; Wed, 01 Jul 2026 09:37:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782923840; x=1783528640; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=E5s3ibmT2to/y3XD6nDaFEyC5h3FTVAJu+ijGdYR2Hs=;
        b=HCO0FwO4JwNl52//w2CcyF9LVoRwUJgaKX92vYbPIlMaM8veI1WoX2DmcoH/p+fMBM
         F5eKdlcV4SsA9DB9iX+DWBUkf0cgw8H3LkLj5lnzljzGjRhs0lPl96SfdEyEpBk2OzXZ
         s7d8tuNDvjP28ONbL/UY9FZzm4vKyIkHmJQe1dMv6olWR3UIdqISd4I2pLUMJlXdB3lI
         CL7aVJ8LrFHzXGvL1D6J4cRNwvZ0XgmGvNtV6baLtliXZeRMW4w7N6upmcg6bCSxAWY5
         5liuEXKU6RkmL3vlHS6EE5q+f5uvkszk4S/Kh7CVKJas4rorq1r1FyoZ/zy+Cnf2ceoJ
         SVUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782923840; x=1783528640;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=E5s3ibmT2to/y3XD6nDaFEyC5h3FTVAJu+ijGdYR2Hs=;
        b=SZJzAv6EZLFRH0kiON6YyVguRdBNU6W1IcmqWv/xCyZ+LlQrwVaxb3vra4yhcyYyif
         Yb66KaIXIaNzK0Emp6bqVHiWjTFvAFBhx8TpxLHviPLefJUACdCJzCVa6zgR3MEr40x0
         xZiOPUXTjQ7LOWwGgRsbXIVImEbXTwEug7a+WXN5o2VcFSsrXf+LTgWqEJG7mfCqQqWT
         KWfu0t8lm7v2e2QNBlczHLUi992pS1ASyB7uicR6vQ0i2EUkr/Sy3DYblaHLMBNPEsso
         DHt4nSQy4fxnyect1nmkuKVVRmPeHjhMiXcwmf6OUXS5XbvuI7Dfg+4dUl6xekZojg81
         /q0w==
X-Gm-Message-State: AOJu0YwVGFVBJ+J134BwZTCf90LdT/Qk/X7B1Atx5WpuT18JQi+Wp4Xx
	FMPkaWxPdx1PxShrjHcpJMeZDp/juNuB2uGEvLJrVKpjwQI6RYJimJCJ6FQgfQ==
X-Gm-Gg: AfdE7cndpa+/8yXr7UFeNCT1Tn/NBh9h39TXrZ1ZcicqJhVSS9SHOmN5xOxqg6z6I4h
	90mhKxFtUTC4IziqFugPnn9AgUf+siIY690bZnNePseI6hWBkn42pY+1lb69RbhBNtlAAMNar0r
	rw+MSkqHJYZ87f06Ezd/hc0swzyMtNUgdb+sYbjtg2W4xfkKi9cCLjh4/If6YUv0MbgDzdqKHIz
	UmI0gE0dq4OrtXn+S5ZFijJSLEhEnKqut8GcBetY7725WF3xMjYTYEA5YYhoq3ZG8bxKvQzt8FJ
	OH/Gea3X5Ou5UraoaRxuF5H3w6585rJ9H7JbtTZliv4GFcdbONzRjXGMan3Ab85v5N8J0x64+a6
	tKET7U4dnpLAKcETR9j7s/06Ma86SC7mFp5+o5A+cSQrlqlOT1YbFcD7wm07KHlJBb5CNQuB6Au
	3I+T6W12Ar8Rpz2+4=
X-Received: by 2002:a05:6a00:4fc4:b0:845:d284:9e10 with SMTP id d2e1a72fcca58-847c51bf115mr1539223b3a.55.1782923839735;
        Wed, 01 Jul 2026 09:37:19 -0700 (PDT)
Received: from [127.0.0.1] ([20.57.198.170])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-847cb6e3281sm84575b3a.5.2026.07.01.09.37.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Jul 2026 09:37:18 -0700 (PDT)
Message-Id: <eec4a9d92638aa099eb7be223ab9a5b9377f5721.1782923832.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2149.v5.git.1782923832.gitgitgadget@gmail.com>
References: <pull.2149.v4.git.1782649547.gitgitgadget@gmail.com>
	<pull.2149.v5.git.1782923832.gitgitgadget@gmail.com>
From: "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 01 Jul 2026 16:37:04 +0000
Subject: [PATCH v5 03/10] t6600: add test cases for side-exhaustion edge cases
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
    Elijah Newren <newren@gmail.com>

From: Elijah Newren <newren@gmail.com>

Add test cases to t6600-test-reach.sh that exercise edge cases in the
side-exhaustion optimization for paint_down_to_common():

 - in_merge_bases_many:self: commit is both A and one of the X inputs
 - get_merge_bases_many:duplicate-twos: duplicate entries in X list
 - get_merge_bases_many:pending-stale: STALE transition on an
   already-painted commit (ps-* diamond topology)
 - get_merge_bases_many:infinity-both-sides: both tips outside the
   commit-graph with non-monotonic dates (pi-* topology)

Signed-off-by: Elijah Newren <newren@gmail.com>
Signed-off-by: Kristofer Karlsson <krka@spotify.com>
---
 t/t6600-test-reach.sh | 110 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 110 insertions(+)

diff --git a/t/t6600-test-reach.sh b/t/t6600-test-reach.sh
index b5b314e570..b536a5952a 100755
--- a/t/t6600-test-reach.sh
+++ b/t/t6600-test-reach.sh
@@ -49,6 +49,61 @@ test_expect_success 'setup' '
 			git tag -a -m "$x-$i" tag-$x-$i commit-$x-$i || return 1
 		done
 	done &&
+
+	# Build a small side topology to exercise the (PARENT1|PARENT2) ->
+	# (PARENT1|PARENT2|STALE) transition in paint_down_to_common(); the
+	# 10x10 grid above does not exercise it because no merge-base candidate
+	# there is a descendant of another, so STALE never reaches a
+	# still-pending candidate.
+	#
+	#       ps-X
+	#       /|\
+	#      / | \
+	#   ps-Z ps-B ps-W
+	#     |  / \  |
+	#     | /   \ |
+	#     |/     \|
+	#   ps-T1   ps-T2
+	#
+	# where ps-T1=merge(ps-Z,ps-B), ps-T2=merge(ps-W,ps-B), so
+	# merge-base(ps-T1,ps-T2) = ps-B. During the walk, ps-X transitions
+	# to (PARENT1|PARENT2) via ps-Z and ps-W before ps-B is dequeued;
+	# then the STALE-walk from ps-B transitions ps-X to
+	# (PARENT1|PARENT2|STALE).
+	git checkout --orphan ps-orphan &&
+	test_commit ps-X &&
+	git checkout -b ps-B-br ps-X && test_commit ps-B &&
+	git checkout -b ps-Z-br ps-X && test_commit ps-Z &&
+	git checkout -b ps-W-br ps-X && test_commit ps-W &&
+	git checkout -b ps-T1 ps-Z &&
+	git merge --no-ff -m ps-T1 ps-B &&
+	git checkout -b ps-T2 ps-W &&
+	git merge --no-ff -m ps-T2 ps-B &&
+
+	# Build a side topology that lives entirely outside the half
+	# commit-graph and has non-monotonic commit dates, to exercise the
+	# INFINITY-gate in paint_down_to_common. With both tips outside
+	# the graph, generation is INFINITY and the queue falls back to
+	# commit-date order, which here is non-monotonic.
+	#
+	#   pi-X (date 500, PARENT1 tip) --> pi-P, pi-D
+	#   pi-D (date 480) --> pi-C
+	#   pi-C (date 200) --> pi-B
+	#   pi-B (date 100, PARENT2 tip) --> pi-P
+	#   pi-P (date 450, root)
+	#
+	# merge-base(pi-X, pi-B) = pi-B (it is an ancestor of pi-X and is
+	# itself one of the queried tips).
+	git checkout --orphan pi-orphan &&
+	test_commit --date "@450 +0000" pi-P &&
+	test_commit --date "@100 +0000" pi-B &&
+	test_commit --date "@200 +0000" pi-C &&
+	test_commit --date "@480 +0000" pi-D &&
+	GIT_AUTHOR_DATE="@500 +0000" GIT_COMMITTER_DATE="@500 +0000" \
+		git commit-tree -p pi-D -p pi-P -m pi-X pi-D^{tree} >pi-X-oid &&
+	pi_x="$(cat pi-X-oid)" &&
+	git branch -f pi-X-br "$pi_x" &&
+	git tag pi-X "$pi_x" &&
 	git commit-graph write --reachable &&
 	mv .git/objects/info/commit-graph commit-graph-full &&
 	chmod u+w commit-graph-full &&
@@ -146,6 +201,16 @@ test_expect_success 'in_merge_bases_many:miss-heuristic' '
 	test_all_modes in_merge_bases_many
 '
 
+test_expect_success 'in_merge_bases_many:self' '
+	cat >input <<-\EOF &&
+	A:commit-6-8
+	X:commit-5-9
+	X:commit-6-8
+	EOF
+	echo "in_merge_bases_many(A,X):1" >expect &&
+	test_all_modes in_merge_bases_many
+'
+
 test_expect_success 'is_descendant_of:hit' '
 	cat >input <<-\EOF &&
 	A:commit-5-7
@@ -183,6 +248,51 @@ test_expect_success 'get_merge_bases_many' '
 	test_all_modes get_merge_bases_many
 '
 
+test_expect_success 'get_merge_bases_many:duplicate-twos' '
+	cat >input <<-\EOF &&
+	A:commit-5-7
+	X:commit-4-8
+	X:commit-4-8
+	X:commit-6-6
+	X:commit-6-6
+	X:commit-8-3
+	EOF
+	{
+		echo "get_merge_bases_many(A,X):" &&
+		git rev-parse commit-5-6 \
+			      commit-4-7 | sort
+	} >expect &&
+	test_all_modes get_merge_bases_many
+'
+
+test_expect_success 'get_merge_bases_many:pending-stale' '
+	# Exercises the (PARENT1|PARENT2) -> (...|STALE) transition path in
+	# paint_down_to_common(). See the topology comment in the setup test.
+	cat >input <<-\EOF &&
+	A:ps-T1
+	X:ps-T2
+	EOF
+	{
+		echo "get_merge_bases_many(A,X):" &&
+		git rev-parse ps-B
+	} >expect &&
+	test_all_modes get_merge_bases_many
+'
+
+test_expect_success 'get_merge_bases_many:infinity-both-sides' '
+	# Exercises the push-time INFINITY-gate in paint_down_to_common(). See
+	# the pi-* topology comment in the setup test.
+	cat >input <<-\EOF &&
+	A:pi-X
+	X:pi-B
+	EOF
+	{
+		echo "get_merge_bases_many(A,X):" &&
+		git rev-parse pi-B
+	} >expect &&
+	test_all_modes get_merge_bases_many
+'
+
 test_expect_success 'reduce_heads' '
 	cat >input <<-\EOF &&
 	X:commit-1-10
-- 
gitgitgadget

