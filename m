Received: from fhigh-a7-smtp.messagingengine.com (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F091241DEEB
	for <git@vger.kernel.org>; Wed, 12 Aug 2026 10:12:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786529527; cv=none; b=IdltQS5/Fpy5tbBC7+fVRNjutM7oLCu/d4WRE/DoofeZiqMyFO/6n6OJGTnfVFd8UT9w+8i94gu++yjg6PTi8hLrYdBDc71d+gR3gRNE2sf3kbWVi3vrDjm9HLoFU8YlTX8c09hDUEW5wOwLlYJAriRAUkuI5He3+92rGA+1gH0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786529527; c=relaxed/simple;
	bh=7ZWZhhpHkycwpjBfUQbMj5unl4aybthLk+QwZMQa7UQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Erf8fFtu0Ev8emGr3DPe77kVAdBKtzianx40m8elFNaMz/TQcNlhSI1J94eNZJby28PVPUOOaekVBZMB7pr388rrZAiy2fIZmrZsnNBcX6lb0A9Lbp19RdhW3GMdVkm6EHiVRsGgBsKe3qSdiZiDK109i/Bd6pTiSPQA7fStXfY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=RMgmwP1i; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=D8GRHh/r; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="RMgmwP1i";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="D8GRHh/r"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 113E414000F6;
	Wed, 12 Aug 2026 06:12:05 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Wed, 12 Aug 2026 06:12:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1786529525;
	 x=1786615925; bh=2vOKjXl5RbLYWkWzayDO7QzjRVmTx22eJwQVRw7D9Mc=; b=
	RMgmwP1i5RISHvFNolfzjCzJEZOT03HaCiNhI9rQkb6x1e74O8hGDgwgK+4ONInY
	rScU1S9WUINM9Y+M0t4M7Gu/+otEL1ew04AUSEjdggkym4RiuNbOxpj3MDR6ECn5
	oewFyQt6CUaqVC4w08Bfs2UxeIlbvesMJa0oJcmek3ecUKdFARd6gqUUJ/wA2tzc
	/6QBOirmhyooNt6aikIgrAYtppdd46b9n8i8NejCs1fW68grklmtQbySXXs8ysXo
	Itdr0MH5ofNHYEXbdoTgx6CePHL2t0BeWkLR4kbtjWVMNW5JJfkMDOINrzR7kK+S
	+CNXNE+ADttheQGgLCqg0Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1786529525; x=
	1786615925; bh=2vOKjXl5RbLYWkWzayDO7QzjRVmTx22eJwQVRw7D9Mc=; b=D
	8GRHh/rL4jIRNnjk60dpxW8XLqtAefZb34oHK61NSBlb946+KQhXy9m/zYy8bnn6
	ivGupwR8VZnKgdUqeuhEJFvP0K9+yLR816h1+zPYydebhmHb21HQ2lgDYTyAmEhy
	szx9+fL26KHPi75WjYnCUfbJScC/cRImb2WhZg1IBd1nfvcBZZimJEAPpkQ3qrPc
	yrUqs4FLv9biahO3FC2PO7peCn25uditOUHj4zeMZx2MqZjLezoQ8ig6t1ZW94j3
	APE/fKvsETPiDbp30szrB4UQOJw2upbIumQrxh9/hoQf/0K/xaqqLIt5GRP5LnGI
	q3G6SJoY9/hqKHorrXKLw==
X-ME-Sender: <xms:9UZ8asCx5SeFi5cWv4_Ap4IHUUfOX826iLBBL1_OC_KCWq-7yId4oQ>
    <xme:9UZ8akjOEpBPHJIH5sMr6qEaLlPOuB95MhHh4P8CDXauAnmFWRGi95N1AXmX84o4r
    226vro6OXbBwo7E1fT9pdNj3m6pVTz8K5OxtsgrU7HgRNIhuNYJvgg>
X-ME-Received: <xmr:9UZ8atN6_wunUwTDz8uJ0J_UDwLkr5JUpaGss1oE9IiTpVRui7wT6dXSYLMCZs40eyqFCN9WR4bS-8UtAJGdJUgDmbzKiFjRmuudYpqT9g>
X-ME-Proxy-Cause: dmFkZTEWZLKncZ1tO08F6TzNZ7R+9GKt2vqJbkMyfqtcDB2gqR92xRcNTw+9bEthkHU6hO
    put4UkXlJAaod3DA97TkJBqFL8b3ap6c6Q87Xr2vo9if296Fwdn+yyLenT8uoChtX0nYwY
    PZ1iQJIqUPR+6RZbN7wi/CGzDVcyhiyJu4xifJy7ivJCHT5GTC+aYLaQ3WxixoWCXxdiw6
    UYF3nhClb7rL/ZR/FPRarWGEabsTDbgioxxrzVEbPGEj8chuw70X7x4klFyG0moLbzmmyh
    NPmywlZPmmSXL6fdPBSOyEFfajKyv25MW3O+OdsDqzISQw3Bsu31wpqpk12n6iWcXlA8MW
    boVWPE4WiPD6pFphBgVwYFnZlS6D5uygVqsvoi7GdW7K4K8DNwWP2bMiJa9bomRoFXL3lb
    d36f5Yme8pEHh/R0z3yMliNsfRP7wyYjS8G8HaOm30ni1L4pvuEN4jUXltc/Rno4ayPjF3
    5IDK9l4BBWpdycpZwyMwgBPkj1Jc5qtCHBq94hos1xRAXSp2POT5WWibcXps9VIxFFiKD9
    4pj2Jkqh/YlAxRSupU/s3AwQzlAZ+lkL28Cn4UbIXjGA+6I9CrOSG2dIqcwgEjFRevnNQA
    tETvrovjhRJykQg7fhTTjv6SQ5QDOsie8l3ambDvZF7bq5TKheI0rGfm5VGQ
X-ME-Proxy: <xmx:9UZ8at4mfwDSmbJqri0dFvvwVFI0WJafj8t-ktnk0ufmv6RxHbLFcQ>
    <xmx:9UZ8aj1-fbVt1l9xA9d2mXTuuCjscJtzguJHuQskY2hB3k2KRkFMLQ>
    <xmx:9UZ8amZ5remqtgiL2mSGapQzYS6Wj2i1aRxMzWvo1SndpophXAWFiQ>
    <xmx:9UZ8ajAHi5OgHpri9khDM9v1CEFXcKGQC7Dw5yCHyi3rhqrLO2mq1w>
    <xmx:9UZ8arzIcRSfmVA49ryFKJo2sM15SkUpFyN1z3Ynb_HIGqDngvIlUNAK>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 12 Aug 2026 06:12:03 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id dc94c3e3 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 12 Aug 2026 10:12:02 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Wed, 12 Aug 2026 12:11:47 +0200
Subject: [PATCH v2 2/2] t7900: fix flaky "maintenance.strategy" test
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260812-pks-t7900-fix-flaky-test-v2-2-9ea0e1ac0edd@pks.im>
References: <20260812-pks-t7900-fix-flaky-test-v2-0-9ea0e1ac0edd@pks.im>
In-Reply-To: <20260812-pks-t7900-fix-flaky-test-v2-0-9ea0e1ac0edd@pks.im>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>
X-Mailer: b4 0.15.2

One of our tests for whether "maintenance.strategy" is being respected
in t7900 is flaky in our CI systems:

    + GIT_TRACE2_EVENT=/tmp/test-output/trash directory.t7900-maintenance/repo/trace2.txt git -c maintenance.strategy=incremental maintenance run --quiet
    + test_maintenance_tasks trace2.txt
    + cat
    + sed -ne s/.*"region_enter".*"category":"maintenance\([^"]*\)".*"label":"\([^"][^"]*\)".*/\2\1/p trace2.txt
    + test_cmp expect actual
    + test 2 -ne 2
    + eval /usr/bin/diff -u "$@"
    + /usr/bin/diff -u expect actual
    --- expect	2026-08-07 06:20:51.388322602 +0000
    +++ actual	2026-08-07 06:20:51.388322602 +0000
    @@ -1,2 +0,0 @@
    -gc foreground
    -gc

When running with the "incremental" strategy, we expect two git-gc(1)
tasks to have been executed, but sometimes the test simply doesn't
execute any of those tasks.

A first hunch may be that maybe the disk-state is sometimes different
and thus we decide not to run maintenance. But git-maintenance(1)
doesn't run with the "--auto" switch, so we should execute those tasks
regardless of the on-disk state.

But there's a second condition that may cause us to not execute tasks,
namely when the "maintenance.lock" file exists due to a concurrently
running git-maintenance(1) process. We usually disable auto-maintenance
from detaching in our test suite to avoid exactly these kinds of race
conditions by exporting `GIT_TEST_MAINT_AUTO_DETACH=false`. But in t7900
we unset "GIT_TEST_MAINT_AUTO_DETACH" and thus enable the auto-detach
logic. The intent of this is to exercise git-maintenance(1) closer to
how it would run in a real-world scenario, but it does cause us to race
when the detached maintenance job that was triggered by `test_commit()`
lives long enough.

We could trivially fix this race by disabling auto-maintenance for this
specific test. But that doesn't fix this class of races in this test
suite: while I haven't seen any of the other tests fail in the same way,
a bunch of them have this race, as well.

Instead, let's retain "GIT_TEST_MAINT_AUTO_DETACH" and only unset it as
required.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 t/t7900-maintenance.sh | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/t/t7900-maintenance.sh b/t/t7900-maintenance.sh
index 6735a9e082..5fbb16f0f0 100755
--- a/t/t7900-maintenance.sh
+++ b/t/t7900-maintenance.sh
@@ -7,9 +7,6 @@ test_description='git maintenance builtin'
 GIT_TEST_COMMIT_GRAPH=0
 GIT_TEST_MULTI_PACK_INDEX=0
 
-# Ensure that auto-maintenance detaches as usual.
-sane_unset GIT_TEST_MAINT_AUTO_DETACH
-
 test_lazy_prereq XMLLINT '
 	xmllint --version
 '
@@ -71,6 +68,7 @@ test_expect_success 'maintenance.auto config option' '
 	git init repo &&
 	(
 		cd repo &&
+		sane_unset GIT_TEST_MAINT_AUTO_DETACH &&
 
 		GIT_TRACE2_EVENT="$(pwd)/default" git commit --quiet --allow-empty -m 1 &&
 		test_subcommand git maintenance run --auto --quiet --detach <default &&
@@ -90,6 +88,7 @@ test_expect_success 'gc.auto config option' '
 	git init repo &&
 	(
 		cd repo &&
+		sane_unset GIT_TEST_MAINT_AUTO_DETACH &&
 
 		GIT_TRACE2_EVENT="$(pwd)/default" git commit --quiet --allow-empty -m 1 &&
 		test_subcommand git maintenance run --auto --quiet --detach <default &&
@@ -107,6 +106,7 @@ test_expect_success 'maintenance.auto overrides gc.auto' '
 	git init repo &&
 	(
 		cd repo &&
+		sane_unset GIT_TEST_MAINT_AUTO_DETACH &&
 
 		git config set maintenance.auto false &&
 		git config set gc.auto 1 &&

-- 
2.55.0.679.g6767b8d81c.dirty

