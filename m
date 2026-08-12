Received: from fhigh-a7-smtp.messagingengine.com (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C18441D127
	for <git@vger.kernel.org>; Wed, 12 Aug 2026 10:12:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786529523; cv=none; b=dmYsX8NEDipeB4g85nk357DNdQH2beRFM/KMrbRTmASTQMds9Dsk+2ENKiAx05fr6TjJQLJwX1+ilDUCf9bNGROb16a5WXjzjoCEB4Kk+vyfP5CA8YCYk73dmjX0tP8x8bGe18y1Aew+MCe/Yme/XzzIN1ExSLeo5k8PvWAYKoY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786529523; c=relaxed/simple;
	bh=VCYm9vbgyci9w9ukQZ4uYQn1w5HAjz2Tkxv5Kiy/Tok=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Zi/ay7IlrTsCPUdO1hHBA7VsdyvfjPHV10675t0L8mjIJ+T60KBmHocnYi4Ti/XaecoSNR0+iPLbRLWG6bEfQYVMsL2V8wQnEM3ng/bWL90G/4t8w/jG4sZngx7RVNAB7xIXl2Hd/sbcLImFulTX3+akxMhpnYW2Nt9TXxwE8TU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=IDO54HzE; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=jWqYHLfE; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="IDO54HzE";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="jWqYHLfE"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 84B561400073;
	Wed, 12 Aug 2026 06:12:00 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-02.internal (MEProxy); Wed, 12 Aug 2026 06:12:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1786529520;
	 x=1786615920; bh=6BrnT9+JCXGiSoL1pBcQiKxkk4wAUlj3L4S0P06HiLE=; b=
	IDO54HzEniidO79RxVKfJqaMgV2yK3CTmSLn5N7F76e/Ailr3LYQdLYvC4C9wisi
	7GmyJFgXrIeiMdakK7JZ+56vtGAl5yevGswAn3QFNZ+CcT7krVvRkfDGVJfKqSyH
	s5t1zDH+Ofm4EehAcqkG22AJ+PjFClcF7o4WGykz1Ryfq8zVs4D8lXghaKr4BbX6
	Qg/ko0J3N559BsAgrUuiOWLcC86b24Ir+K+gdWSIDK0u4bU4wpOS4NbNWe6Y7EAz
	tSo+kzn3ul81516XVVPzGrA/Pklkcj8cVkSGaPXG+W7lWK2mRdimIbV2py8JH5WR
	Ith7kb0qTz/u6eRQVgsMOA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1786529520; x=
	1786615920; bh=6BrnT9+JCXGiSoL1pBcQiKxkk4wAUlj3L4S0P06HiLE=; b=j
	WqYHLfE7pN3Wa26Z+Ecq4GmR9uv2fPW0QfqNhXGlkgBunVwjiIbpvhbb1iURDaM6
	gpZN57pBC1S6gtAz0OIPeoiYa2EBibg8ZQLATeZDFxeTbuoPPireAwweW4Sos9fo
	iTuuaqT3bu/l/jYk3Q5zlaV7O3ZReyD+bLgHk6vqSWsOo1FkPiEs2OyIKIsGeQnQ
	8lF0mrqgTdJETHDrJ0o9TEiEERYoxxaiipSmY4zmRSKL1EnC+0BRz2eF373ZHA25
	FLcrxn7CcDl248p6l4kRAlKuWAptOR4wKVGW0KR4BQhmE22WcsRMdL0EVLrVcDOk
	8PJQqqJVdZka5Q8QvGe2A==
X-ME-Sender: <xms:8EZ8aoq8npGLWF5R7F7xUvyuw4j7pziD3jHqZQeStIVkGLWR1eSiFA>
    <xme:8EZ8akrixfG8hS3518R5cduuklsN4hN5c5VUh44yNudGp3uifptMqH8L7ht_6uzp-
    fVc8U9DLHUAjVqP5UOEH-3MHcFJJNJie7IuOso8RWTE28_0Cdcygts>
X-ME-Received: <xmr:8EZ8aq3LELe7joOMTkJCbHc_MapcjX_YzR0YEAwblbgHw_jzOh-fgDoH6C4HOHvWm8s_m_dLECJmtwf307wVmkpPLQrWUc9ZhUsZwTUQMQ>
X-ME-Proxy-Cause: dmFkZTEJnL7sKIjD/9S3XTEzPmbXqggQR686ZmaIYUTRfarC3BoNseG9FBmJHm6ADKcvF/
    fpSurAaBODW3GRObG+4fOLiZmPEq8iYEn5+/Y9ZLl43kWxORjBhdb2nDe9heWxRKhSPR6Z
    O7P8lJD+kSVxuId11UYMYw7ZfYuZXnooXipB03rqw6Ww4KD8DB+1fBydZ7eOzXEnhH8PyN
    TZZweYNbhQkdpOzmdSpbhWkf2VZ33iFgYOkW41aQZeF0r09HkLQlBuhifP2AdSMAY3Ie1/
    Sf/COyG73QfX7WltWuRP1Ph5JBJSqkEFdbDcaEB49hUWKNd41wpBJverkZBube+i3TE/hB
    nbzBawY8EUw1tlhMFdiNwZWEEwmu/oOzyH4QHa5nmyZO94DU1bHI7Jw71CPe3i8+wxj4lS
    Z6NhTuqgzITeSwI7rlNiKbCUurDqbhOZguxEBHtqPUxmWWDaaqnvFjPsGWkHyGTYm5kNCu
    0wtWAT92pLBcVCE1Jks94q3sxCFcMvUuiTWxI8KLZ+Cmolx/6nmQBX3lx5nYS6DFKUSMyj
    s7yRHnAbvAgcWlm3DkLwA155RgvQtZQbLhgfTtiLA0Dv+B6bEdlHDCjoLpDQbgYB59KL8a
    FjsDOmPRMRrR8sVWnJbXMW2K0b18azzR4G7lXyh4aijr9PYe+mXXRVVcTisw
X-ME-Proxy: <xmx:8EZ8arBvevqyQ6OpNc5hhJipXxV2fEqOmv59g8sNfg-K82Tmu1oy1Q>
    <xmx:8EZ8aqcrgCaa2Fdt7fMppyh7bHp3Tu8BA2XKfrx4b6m_5ZI0ySHj2w>
    <xmx:8EZ8aoiLVjlEbL9PpjnJTpk0qzGQWJZYItBfDdKF2-O73XuRI_tUPA>
    <xmx:8EZ8aqpLKpjpptJ9j9oZgeEb04lARTZ1KIWDvhc_Bnjedw4eU_i0CA>
    <xmx:8EZ8aibwwPBjC4cZQOKf05i_Of-nQQsFvvVyROplLaEV54s49Rm4qKwY>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 12 Aug 2026 06:11:59 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 8c9e4c4f (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 12 Aug 2026 10:11:59 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Wed, 12 Aug 2026 12:11:46 +0200
Subject: [PATCH v2 1/2] t7900: adapt some tests to use a throwaway
 repository
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260812-pks-t7900-fix-flaky-test-v2-1-9ea0e1ac0edd@pks.im>
References: <20260812-pks-t7900-fix-flaky-test-v2-0-9ea0e1ac0edd@pks.im>
In-Reply-To: <20260812-pks-t7900-fix-flaky-test-v2-0-9ea0e1ac0edd@pks.im>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>
X-Mailer: b4 0.15.2

Many of the tests in t7900 operate inside the main trash repository
that's set up by default by our test suite. This is overall quite
fragile as we're exercising repository maintenance in those tests, and
maintenance is of course intricately tied towards the on-disk state of a
repository. Consequently, the tests can easily impact one another.

Furthermore, in the next commit we'll have to modify the environment in
a handful of those tests. As tests don't run in a subshell, doing so
would impact all subsequent tests by default, as well.

Adapt exactly those tests to use a throwaway repository. This makes the
tests more neatly self-contained and allows us to trivially modify the
environment in the next commit.

Note that we adapt calls to `test_config ()` to use git-config(1)
instead. This is because on the one hand we don't need the auto-revert
logic of `test_config ()` as we're using a throwaway repository anyway.
On the other hand it's not possible to use `test_config ()` as it uses
`test_when_finished ()`, which errors out when we run it in a subshell.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 t/t7900-maintenance.sh | 70 +++++++++++++++++++++++++++++++-------------------
 1 file changed, 43 insertions(+), 27 deletions(-)

diff --git a/t/t7900-maintenance.sh b/t/t7900-maintenance.sh
index 4238569b68..6735a9e082 100755
--- a/t/t7900-maintenance.sh
+++ b/t/t7900-maintenance.sh
@@ -67,41 +67,57 @@ test_expect_success 'run [--auto|--quiet] with gc strategy' '
 '
 
 test_expect_success 'maintenance.auto config option' '
-	GIT_TRACE2_EVENT="$(pwd)/default" git commit --quiet --allow-empty -m 1 &&
-	test_subcommand git maintenance run --auto --quiet --detach <default &&
-	GIT_TRACE2_EVENT="$(pwd)/true" \
-		git -c maintenance.auto=true \
-		commit --quiet --allow-empty -m 2 &&
-	test_subcommand git maintenance run --auto --quiet --detach <true &&
-	GIT_TRACE2_EVENT="$(pwd)/false" \
-		git -c maintenance.auto=false \
-		commit --quiet --allow-empty -m 3 &&
-	test_subcommand ! git maintenance run --auto --quiet --detach <false
+	test_when_finished "rm -rf repo" &&
+	git init repo &&
+	(
+		cd repo &&
+
+		GIT_TRACE2_EVENT="$(pwd)/default" git commit --quiet --allow-empty -m 1 &&
+		test_subcommand git maintenance run --auto --quiet --detach <default &&
+		GIT_TRACE2_EVENT="$(pwd)/true" \
+			git -c maintenance.auto=true \
+			commit --quiet --allow-empty -m 2 &&
+		test_subcommand git maintenance run --auto --quiet --detach <true &&
+		GIT_TRACE2_EVENT="$(pwd)/false" \
+			git -c maintenance.auto=false \
+			commit --quiet --allow-empty -m 3 &&
+		test_subcommand ! git maintenance run --auto --quiet --detach <false
+	)
 '
 
 test_expect_success 'gc.auto config option' '
-	GIT_TRACE2_EVENT="$(pwd)/default" git commit --quiet --allow-empty -m 1 &&
-	test_subcommand git maintenance run --auto --quiet --detach <default &&
-	GIT_TRACE2_EVENT="$(pwd)/true" \
-		git -c gc.auto=1 commit --quiet --allow-empty -m 2 &&
-	test_subcommand git maintenance run --auto --quiet --detach <true &&
-	GIT_TRACE2_EVENT="$(pwd)/false" \
-		git -c gc.auto=0 commit --quiet --allow-empty -m 3 &&
-	test_subcommand ! git maintenance run --auto --quiet --detach <false
+	test_when_finished "rm -rf repo" &&
+	git init repo &&
+	(
+		cd repo &&
+
+		GIT_TRACE2_EVENT="$(pwd)/default" git commit --quiet --allow-empty -m 1 &&
+		test_subcommand git maintenance run --auto --quiet --detach <default &&
+		GIT_TRACE2_EVENT="$(pwd)/true" \
+			git -c gc.auto=1 commit --quiet --allow-empty -m 2 &&
+		test_subcommand git maintenance run --auto --quiet --detach <true &&
+		GIT_TRACE2_EVENT="$(pwd)/false" \
+			git -c gc.auto=0 commit --quiet --allow-empty -m 3 &&
+		test_subcommand ! git maintenance run --auto --quiet --detach <false
+	)
 '
 
 test_expect_success 'maintenance.auto overrides gc.auto' '
-	test_when_finished "rm -f trace" &&
+	test_when_finished "rm -rf repo" &&
+	git init repo &&
+	(
+		cd repo &&
 
-	test_config maintenance.auto false &&
-	test_config gc.auto 1 &&
-	GIT_TRACE2_EVENT="$(pwd)/trace" git commit --quiet --allow-empty -m 1 &&
-	test_subcommand ! git maintenance run --auto --quiet --detach <trace &&
+		git config set maintenance.auto false &&
+		git config set gc.auto 1 &&
+		GIT_TRACE2_EVENT="$(pwd)/trace" git commit --quiet --allow-empty -m 1 &&
+		test_subcommand ! git maintenance run --auto --quiet --detach <trace &&
 
-	test_config maintenance.auto true &&
-	test_config gc.auto 0 &&
-	GIT_TRACE2_EVENT="$(pwd)/trace" git commit --quiet --allow-empty -m 1 &&
-	test_subcommand git maintenance run --auto --quiet --detach <trace
+		git config set maintenance.auto true &&
+		git config set gc.auto 0 &&
+		GIT_TRACE2_EVENT="$(pwd)/trace" git commit --quiet --allow-empty -m 1 &&
+		test_subcommand git maintenance run --auto --quiet --detach <trace
+	)
 '
 
 for cfg in maintenance.autoDetach gc.autoDetach

-- 
2.55.0.679.g6767b8d81c.dirty

