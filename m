Received: from fout-a5-smtp.messagingengine.com (fout-a5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B825A43030A
	for <git@vger.kernel.org>; Fri,  7 Aug 2026 10:59:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786100354; cv=none; b=cN2Oes6mfFljqZxQV3ICLpflSSWtFauCdOg5EcBiFsq1LHIXphTolAnm8NGsGsVRshpw+kzDBrO+o7I/iI/5Xhkkhc68PkeduJADYmpIOMfMZMKcNpbiYNOi4YvIa69NAeSigYNsegDST9qeCu+NGc6mQrG8YyaeoFm42VQ4Ct8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786100354; c=relaxed/simple;
	bh=9YUGBqtWNt7UeCcf3N5l5wXxcOc0i/k7K9J/r/S/4ec=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=nxE/ExTYmdjKwkVPHJusfbgOHmi+tTBODGUbPO4GfwR3nQt1+6+SlDcpJk5fmcziakrqJrGRPjlsn4HsW54vyA7c6VZ5NdFzJR5C9Bgco+QAKq+FXoOR+sFyspJ2/JILtGp/h/Nf3V9fkjRmhBs9xLynLPbYxp0c/lXAxdX9dao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=B52LGLrS; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=EsgMFmVm; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="B52LGLrS";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="EsgMFmVm"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.phl.internal (Postfix) with ESMTP id BC7BDEC011B
	for <git@vger.kernel.org>; Fri,  7 Aug 2026 06:59:11 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Fri, 07 Aug 2026 06:59:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1786100351;
	 x=1786186751; bh=tChN+QoBFSyPUR2UpJXJDJiuZ89G2rY3Yucib+v5q3s=; b=
	B52LGLrSuK6OLq6GLXQ+l0OAbD70v1t8UQ0Vy348mxqhxEyV5jrljNB8dZ+JWpcM
	goxTA5TN/+te1XqGDeGtU3TgFbXUcgwEjp/Xdv0mLO+1lMpdQvvX3xuhZjlNnEnx
	m6CQ5IgVU97LB09nSCmr+uIf7I3D7QICnWRsg8bK7ckro8LxpjY79AyLBUlSPcCU
	cg9DwtxVWPCUwLZd38VfnQaNwsMRz5rWump0Tn1O3TvAkdn/BSUhYe9a6YzNI9rS
	2swygH0aGXoC41t/bFV690rYc5lHHOL6UkyjuGHlmTeQQf/Uw0QvorbFTut/YGoL
	ZV2ADpKC6pYd/enzRRmc+w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1786100351; x=
	1786186751; bh=tChN+QoBFSyPUR2UpJXJDJiuZ89G2rY3Yucib+v5q3s=; b=E
	sgMFmVmh+SniIrL02BLRUTW40ZtjS/3FzeP2MxnBpf84sPl3lSm4XelfguDIj51w
	em+Nj33xsa7qUOvkuOoVXzkVPlP9gWaX6dzMiZiC0PSOh+fDvqSgEIMRIEfDHdvz
	Ag59itj9r7End6JRRqw1cdhqnL/Pf19xr9yVj3vSZovCk/zyJuEaz/xi3pt586lw
	xHA8TZO+cGGLe0NMh44PFTV5H0s+dtZu2xi8qCrEXyIReFV1Cnlv5ItEn7xRzTqy
	7NKcbesjMie+XXybQFTio3ITl2STUlutpGfkxOwzGaqjwOtrT+f4GVMe94i0Gr5P
	IreHUDqR7mKMeYJmEcq2g==
X-ME-Sender: <xms:f7p1ah78vbPS6wmiXTEKjHFu-sGHF9VuEUdpHL_eVyWx5rfgBG5YiA>
    <xme:f7p1al1hr05dTOeknlDsjVE_2X31P21uOz1C5TtbpKw0fU1_MD5X7HR7o-YGqlO3g
    q5mC4jTo1OmFHwDoDsUnm247py5ZmZ4BVJi1gUFZZf7V_-dva-46h8>
X-ME-Received: <xmr:f7p1auFtBPYYqEfEHwsxb7O6tx7KJIPVEH2KrHLSQqD-x28EHAEk5lOwwd7hvkAs-vHobHp2QI3qEAAxs_VkT8BXlCMyVwuprMm9EJl4XTflPQ>
X-ME-Proxy-Cause: dmFkZTEbu99otfHh8LAFyCPxK0Y4e7mjatBmVn+4biSTGAMQrlhf1LxIE/5cxO1NZZahBZ
    nTC+O1qQbD/4ygBaWO4Gl8fqwFhMErx4ZYOQei70UnB8WoRKs1ry2MuoclM+LTws/n3y+I
    AVFOfgLSRHLc1htuDPKg8HluDck/GHY9lCS/+CqT5aKp3NI0+4yGaANMKEaiuUeN54ZA8+
    jCCvoCl1epzwbnGh/CH9Z0tl819P2mnpqwbvc2EmyL+AMZYyr4Bw+32ErCdUaW/IbFi+l2
    g3T6oJpKujzykRVb6YO0S/RwWdddViXdaLHzFqkXufloT/zs45yRbWiUNwht4IiEzdoWbn
    LSVSEUYrrRHGysf0fq9oB2DFFIpMuPSY4zXscrNYZzCeSui9urnSuOzuIa9DhgPKpn01SR
    d0FLo+8dc3li0sWv9N+Nx5o8mw3LXhaEN+6nydWLo8wXLbLyYlUk6T1VWINJeSr3/336/n
    T3nR1OwLgpO4C0sLmF/xKh5oh9IzPhKWBAGBkoUZInazqyFVk/V7qd4LQF1qmTox+sYOIi
    2BEGDkC9uLHBaAdbDmu1rEKyux8b3X0JcCjklxjjBBF7ZqWAK1sGazBFSK/h6eUWmm5HJd
    AD+fbigaC3nlVi6si7vNyGvzPrq8NNBwtrOFSkGnYuOjlb4Eoh8KBKlUtXzg
X-ME-Proxy: <xmx:f7p1avRvfIzZ4qm2bN_zc_ZHTfLdrn69SdViRMmrlfUj3nyhzKdwUQ>
    <xmx:f7p1alDYpQt541xIYmvbZsu5Frs1eWr1iAjRwZw8nj-wQaZ852aWNw>
    <xmx:f7p1av3mX4GRHEog2BDXqaIfA_MJ_akz5k8OSno9oNSuW3QF3LHV0w>
    <xmx:f7p1ajWxl6XJqegO6PH93PFLuAjv591YOG8wOyJVVjLR8hOdzNkGsA>
    <xmx:f7p1amak_ECubotCKpaLVIo9oyg3Ubisaykqw1r9cOt4yzczA0guhD6W>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Fri, 7 Aug 2026 06:59:11 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 4e5262f6 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Fri, 7 Aug 2026 10:59:10 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Fri, 07 Aug 2026 12:59:02 +0200
Subject: [PATCH 2/2] t7900: fix flaky "maintenance.strategy" test
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260807-pks-t7900-fix-flaky-test-v1-2-08d0ea0fbbc5@pks.im>
References: <20260807-pks-t7900-fix-flaky-test-v1-0-08d0ea0fbbc5@pks.im>
In-Reply-To: <20260807-pks-t7900-fix-flaky-test-v1-0-08d0ea0fbbc5@pks.im>
To: git@vger.kernel.org
Cc: 
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
running tasks. We usually disable auto-maintenance from detaching in our
test suite to avoid exactly these kinds of race conditions, but in t7900
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

