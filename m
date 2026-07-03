Received: from fhigh-b5-smtp.messagingengine.com (fhigh-b5-smtp.messagingengine.com [202.12.124.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70BDD3B3886
	for <git@vger.kernel.org>; Fri,  3 Jul 2026 09:24:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783070674; cv=none; b=b6lJKtaX5fUoKdDSu5rdNnzjs82OntFo3Q1m4A05UQjkklcRhM18gm7eP26mtyJm0umozaHs0KTDG0fNuOjJOiveiAoEJKR4RFF87sIVyY5Bipydb7yNxIhQHruhDaxjTWsWDDVlQKKd18UAJT/+ZnD09riEAfQAznTSj2GwZ7U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783070674; c=relaxed/simple;
	bh=sLwjvmafoDo5UaowhNntjxfWTFcn54ClAuNuhJKwGPE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=HaCfplvCZSgg3RFUH2acTPww3gnvqE/42YfTKEyekVOtC16zy/2lDiqywmiuq5CZM9vsNm5kafUaVjeMS9cO3qn9KWI0KAUyb1aATLTpqhPDcEhODap61UeXWelcsA+rXW+Zk57VrkJlz1p98GZZPX+e5I/vI/jielL5blroiMQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=htaPFHVL; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=TX0k8qIY; arc=none smtp.client-ip=202.12.124.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="htaPFHVL";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="TX0k8qIY"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 5403F7A00FD;
	Fri,  3 Jul 2026 05:24:31 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Fri, 03 Jul 2026 05:24:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1783070671;
	 x=1783157071; bh=fiFrhafz6OObCTYSBJtLK2LjjZtkJuNknazpaNjGclw=; b=
	htaPFHVLHnH7x6H6qOfmLLiJyOFuYROfmpC3DNM2ZjZf25fQBEJKwWU9TuO4eGmq
	f9zQsQ1Hfq6T3xxS6rSVv9eVzzLvTnvBZoN9XUrCJ3Msi0CKGFdPuK+caE4zLdQx
	T1P6MWHXXVs3LHt86wduhEFEpKDSDKrlxpGR/rni5ofWgK1IKvniOJ0hwsdBdZ8P
	W26gEItacWUJV/panYY9A7o11p4zhY9JvQiQw8xQFpF9ssIZbaAIIAHnR6kd8SKP
	LFk95l3lD98pr+Wg9t/KGHUVDz8rAu10H6YkAZ5ynzgcUPgJ3DXixpLeW4HpjmEi
	DA1n4Mu74l5XVx31Ov+EGQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1783070671; x=
	1783157071; bh=fiFrhafz6OObCTYSBJtLK2LjjZtkJuNknazpaNjGclw=; b=T
	X0k8qIY+6rh3MC93eX7fNk30FT2h0njJkpjuRTO5RX5DjY1q/kQ8jSUtR4TryT88
	h8Lug5/LUI1DYSydkt29oXtqfWyXN8YuhkAc/wpC3UwI+yGlpBboXJI6MnOtBqO3
	eO1nLkFLba7Bi2ztro6nRG+tqxwwH8KhfkvGCRhJr1oHjUDvWe8/5y04tnVeMA4b
	JsIFb+xuVYCI/uS2zEUwL3IcXkW7q0cPKZbXQXx0AXuZeHYq89+9kEwMfqRTBdtI
	QaVTfVIjMvWVuVMmv9RvFO+YRepdCBZrfXjmeSGr6PLXtOvlbr3b+Zs05rydNI8Z
	2HhhZmo7tRWav6rCxdnTA==
X-ME-Sender: <xms:z39Haj5imyHzmQTxcT-pXtRWodJ0XzTHFqrxRx-4Xg0nQP4ZE6qgag>
    <xme:z39HavxuwVnGbcu6z10kD3BBWVp8jP0P3JLnULstvDM8OdKcSI7aq3U7WzoIdFrl-
    kSoZhH1OB9DNLTJLn2GaTJIrfLgunrPj4ExF6CRScG2pSVPigdn>
X-ME-Received: <xmr:z39Haiw8dXyFP2y7S3cmFgsfoaz-C3wtOdVSX6_vH0lFJRBN4Ohc46v2MTFV8lrFfYGBAQM1diEGdWauKnWcxrJj_fIwHxFqmN8GAH2lTQ>
X-ME-Proxy-Cause: dmFkZTFyyNOLAcshjgVd4Q9FXxgzHw2qDJRjTUAvWuBVqYeS1MyOxkL1QG5dKt9VZ/5NYc
    LnChgBFugEjGNqn1M8WPg94Dc3uINRvg43BZwl++VXe4wBnviUmQAV55q1lqyY9KsfTWOT
    vGnCMyKHWZhdXHRc6KF2/qw/OHM8tMLo8xwsMTBUhdu77axrQwlpo28CdcSR8ec97pwpz6
    u/JJAK0kDrcUWeg06bvhiU0v8M+S5R10ar79laPC3mAo21ViXFcg6s9vmJ8olk8ZCnRmMh
    jfE6JFlQiz7KvvXg/RGPKn9nii0HX0eSWP/VtECnLrjd8vAPtPbSwyN8LUX5ySsC9mnTqZ
    T2U4Hh2BsgzOrbXOrRgnKdEHwOip0sC0Pgcr9PyLArRkqQ6DzJ3kgaV3iJPFPiwjJraj/m
    3F07jXA1ZDSCENMTbbZBwNnGGipBEQjXaDxeIbhZuZFbuhJTWTxXAGe+3OYv7rd139D/6x
    mk4zzxtzzxlke7rrNTRiYdb3jalwDKZhpIGxDcaUneyztu06zOoSLW3XYhnFrSLPhFVO0Z
    mRIIGLssndk0QnFaov6KPvxVfOc2aN6SEDdhDr9mo6Vw63PvL0xZl4ji2Z3ZDF9lI1RtOp
    SxtzhAqSqvbVYO8WgO6CIYpi9PmoExqE0weEb0dDYue9qGCiwGpUfArZ5lqA
X-ME-Proxy: <xmx:z39HavxQK3iLbrbqxGrhza0Iv7DPFROt4v0-voaDVV3PkjwbaaNX3w>
    <xmx:z39HakagmXo-ORmysX-NOyQtWGUztM5KnJz9ST2lgbUsaGMzXJFoIA>
    <xmx:z39HaoV77LHq4crI30gSIT-qAYkgVxWcgLO7ydcW6maurQMM4pbvdw>
    <xmx:z39Haqhdf8OEDRNO8Io-vqaaHhz2fU5x1DuIIyTnYgLoyZnPPcPZPQ>
    <xmx:z39HajMbtr4spaOIezaMHyuDdg6DyfdFC3_fC2sJicN7aa-pKD8U1eIu>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 3 Jul 2026 05:24:30 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 159f25ac (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 3 Jul 2026 09:24:29 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Fri, 03 Jul 2026 11:24:09 +0200
Subject: [PATCH v2 6/9] t7900: clean up large EXPENSIVE repository
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260703-b4-pks-t-fixes-for-GIT-TEST-LONG-v2-6-79076a7e0c62@pks.im>
References: <20260703-b4-pks-t-fixes-for-GIT-TEST-LONG-v2-0-79076a7e0c62@pks.im>
In-Reply-To: <20260703-b4-pks-t-fixes-for-GIT-TEST-LONG-v2-0-79076a7e0c62@pks.im>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, 
 Johannes Schindelin <Johannes.Schindelin@gmx.de>, 
 =?utf-8?q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>, 
 Jeff King <peff@peff.net>
X-Mailer: b4 0.15.2

One of the tests in t7900 is marked with EXPENSIVE because we create a
repository with 2GB of data that we end up repacking. We never clean up
that repository though, so we occupy the full 2GB of data until the end
of the test suite.

Besides clogging our disk, having an EXPENSIVE test that alters the
repository's state used by subsequent tests is also a bad idea, as it
can easily have an impact on the heuristics used by other maintenance
tasks.

Adapt the test so that we create the data in a standalone repository
that we clean up at the end of the test. While at it, also disable
auto-maintenance so that it does not race with our manual maintenance.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 t/t7900-maintenance.sh | 56 ++++++++++++++++++++++++++++----------------------
 1 file changed, 31 insertions(+), 25 deletions(-)

diff --git a/t/t7900-maintenance.sh b/t/t7900-maintenance.sh
index d7f82e1bec..8a7e1306d0 100755
--- a/t/t7900-maintenance.sh
+++ b/t/t7900-maintenance.sh
@@ -461,36 +461,42 @@ test_expect_success 'incremental-repack task' '
 '
 
 test_expect_success EXPENSIVE 'incremental-repack 2g limit' '
-	test_config core.compression 0 &&
+	test_when_finished rm -rf expensive-repo &&
+	git init expensive-repo &&
+	(
+		cd expensive-repo &&
+		git config set core.compression 0 &&
+		git config set maintenance.auto false &&
 
-	for i in $(test_seq 1 5)
-	do
-		test-tool genrandom foo$i $((512 * 1024 * 1024 + 1)) >>big ||
-		return 1
-	done &&
-	git add big &&
-	git commit -qm "Add big file (1)" &&
+		for i in $(test_seq 1 5)
+		do
+			test-tool genrandom foo$i $((512 * 1024 * 1024 + 1)) >>big ||
+			return 1
+		done &&
+		git add big &&
+		git commit -qm "Add big file (1)" &&
 
-	# ensure any possible loose objects are in a pack-file
-	git maintenance run --task=loose-objects &&
+		# ensure any possible loose objects are in a pack-file
+		git maintenance run --task=loose-objects &&
 
-	rm big &&
-	for i in $(test_seq 6 10)
-	do
-		test-tool genrandom foo$i $((512 * 1024 * 1024 + 1)) >>big ||
-		return 1
-	done &&
-	git add big &&
-	git commit -qm "Add big file (2)" &&
+		rm big &&
+		for i in $(test_seq 6 10)
+		do
+			test-tool genrandom foo$i $((512 * 1024 * 1024 + 1)) >>big ||
+			return 1
+		done &&
+		git add big &&
+		git commit -qm "Add big file (2)" &&
 
-	# ensure any possible loose objects are in a pack-file
-	git maintenance run --task=loose-objects &&
+		# ensure any possible loose objects are in a pack-file
+		git maintenance run --task=loose-objects &&
 
-	# Now run the incremental-repack task and check the batch-size
-	GIT_TRACE2_EVENT="$(pwd)/run-2g.txt" git maintenance run \
-		--task=incremental-repack 2>/dev/null &&
-	test_subcommand git multi-pack-index repack \
-		 --no-progress --batch-size=2147483647 <run-2g.txt
+		# Now run the incremental-repack task and check the batch-size
+		GIT_TRACE2_EVENT="$(pwd)/run-2g.txt" git maintenance run \
+			--task=incremental-repack 2>/dev/null &&
+		test_subcommand git multi-pack-index repack \
+			--no-progress --batch-size=2147483647 <run-2g.txt
+	)
 '
 
 run_incremental_repack_and_verify () {

-- 
2.55.0.795.g602f6c329a.dirty

