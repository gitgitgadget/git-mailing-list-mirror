Received: from fhigh-a4-smtp.messagingengine.com (fhigh-a4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D294F42FCD9
	for <git@vger.kernel.org>; Fri,  7 Aug 2026 10:59:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786100351; cv=none; b=p2xWHvNMUF+9fSH0c2kt0cBHKOGr3TH9pD4m0rBkHqkKX30warIz+eGeGccR4xZTyMU1j11SMECQiwbqQRg4aRD3QsC+kqSHtKa7USQpJiGJgcr1/WeBVWYPfAa8SWri0zVDEnVi/0Kvu5EI+TkRL0Rc1N9DmwidlveIxUq6VIQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786100351; c=relaxed/simple;
	bh=P6Lcj8M0HZgqYnyWgro7+KVdcIieD0DpijTkx6qnOug=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=RZNViYitFm3DfzQeQSXH/vqEPI5wTwh+NQ9bjbZk+JSnpQtAJUMVN8g6ThQbKjnzgDILm2O+q71GbCEB5USltK+Kl8QLXax2m3AYsBkscnh+6tbMJXVnTClzLE8rzSWt+94LkDG848DDpz7tiz1axONNFjvuKNWZR0vGrQtsfrM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=QwZD/s4A; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=hBXSTcWb; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="QwZD/s4A";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="hBXSTcWb"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 0B8A914000EB
	for <git@vger.kernel.org>; Fri,  7 Aug 2026 06:59:09 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Fri, 07 Aug 2026 06:59:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1786100349;
	 x=1786186749; bh=6iCj5zmQUr0FJxwAl0kJ9fiQ58SpxACrXxNEjRr/IYc=; b=
	QwZD/s4AK2gqd1jsVV5NZOz55D4pavUY+HpMctDa9bqf5sBJOTNiI0ya3TFwwe/N
	x+R9xKNwuMJoUWvxYtYAmlO7xdc6Jp3ksV43ckgpEiR9Is795ehb5W3GUOSZ2b0H
	krE0keLxT9FifbXZtwXiIPokMvbf6qkhOhUpRNu1TDL4o85QRAxm0lNGnSFhScTI
	5QT69zJ0bQ43AhDd8xrsvrX5cULLgd/YEtNLX/Btp+Auc9fk/XGqdVlsWjv+gk2L
	P9r0RS669s+kab4iVjWjAmykFhOetpvlJZ0minjUCP4M7F5CJAAzEwbUhjlCgu2Z
	avS3001/iL+B4nlBBOEUBA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1786100349; x=
	1786186749; bh=6iCj5zmQUr0FJxwAl0kJ9fiQ58SpxACrXxNEjRr/IYc=; b=h
	BXSTcWb7JAP1i86yh1u4F56ZP69giRTMmYmumOVX+3AYbhUiPh3XrJbzaU6B0G4C
	GMh+YcUIbqu5stE3/YOwK5bOWkWqE90ba4EGkTaoTYsBsP/0hAigta7tsFO6daTt
	VCoZ2WjjL+41x5Z1p/VJHDdk01rKMrQjDnLy8alMvmA/8Likpq6p8Rd68bQbdj6H
	V3cG1e07BZC6IofZFMQ+QqPlEphvqhZKlAIxFs3htOpV4he9mzGHVJ1N59GvqeCl
	eYfVOvOjSpgcyxyTW6tl52MaCfWLXRlnNxYTk3kwRFMh1PIdpysGzP0ICLyBH51S
	AzlKLMRTvy2qhzXE2YLRg==
X-ME-Sender: <xms:fLp1aulhIDJ579RR4IeapMbTQ1mk5CNacU_HfvhXZI6neweR_IocMA>
    <xme:fLp1aswaLWcX1stexFsH9jnkKJktOIn3Sc8bBtfnv3UeII3jRK_f602CXMsxhvoB4
    xR6h-oQFBUyuHHeYDpb4P7xHrhhQp6qcFLz80MnNcdbap0QItmqJQ>
X-ME-Received: <xmr:fLp1aiQceoxLFzUpc0RgWXshp558TwM5qUGP9XJr1yir98tn-YBWTj1G18qavphhd3fXV0SmTNsGvqBQdlsnQkLJ_YpxI6E9cq9LiERdgFINXg>
X-ME-Proxy-Cause: dmFkZTEbu99otfHh8LAFyCPxK0Y4e7mjatBmVn+4biSTGAMQrlhf1LxIE/5cxO1NZZahBZ
    nTC+O1qQbD/4ygBaWO4Gl8fqwFhMErx4ZYOQei70UnB8WoRKs1ry2MuoclM+LTws/n3y+I
    AVFOfgLSRHLc1htuDPKg8HluDck/GHY9lCS/+CqT5aKp3NI0+4yGaANMKEaiuUeN54ZA8+
    jCCvoCl1epzwbnGh/CH9Z0tl819P2mnpqwbvc2EmyL+AMZYyr4Bw+32ErCdUaW/IbFi+l2
    g3T6oJpKujzykRVb6YO0S/RwWdddViXdaLHzFqkXufloT/zs45yRbWiUNwht4IiEzdoWFh
    Zm5eaCwPPekDTP6wm+GosNqiyuif7Sa3erguC08oMecqXGt3bXNuUhSfG1lz3pd2a1M+EI
    30JyldBcrNNIcE/ykmwx+yjGeoUkbWX2xTUCaEbJTSaauOz3RQju/aLMSQu0/KguKf+tx3
    fhNytqhQ75102kUBA9j+fzczsNbsjJ4F+O+AKR3nv2NTCORc2y6fin+VsWfj1AcD0XMRii
    EtNkWoUwJSS17VKL8W6fcGbEhoXuZsVTTSYhyAdyvQfPHnUtW3K2HyZ4nYRMSJjquBJBaH
    E59sDbTEvbYg+Cc+exUU2tGDrNFy4c5qlUdWyPyZES8V6+I1Xjdi0xse0QDQ
X-ME-Proxy: <xmx:fLp1anvU6xalCConbj23p-Rn2MStFy4KE6GRLo8Dl3IZFmbzVmcS6A>
    <xmx:fLp1asvv2M81FMxM3HhFaeB2n5SeT6x3ELG8umFcoT4tbdkju_RLtA>
    <xmx:fLp1alxonUEDc-sptceEhOG_ebsyoUJ0TuiK9IF_39-V3GC0xi_daQ>
    <xmx:fLp1aqggl2ebdATcXY1GbLVfhEC6Mtv_b7CwmMJ8RuLYbqX8xtAeSw>
    <xmx:fbp1aq04OnPlanczauSopcPS3KzsTVWCsgZjaUyhDWWW0rbdEPru8T8u>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Fri, 7 Aug 2026 06:59:08 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id cd2295d3 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Fri, 7 Aug 2026 10:59:07 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Fri, 07 Aug 2026 12:59:01 +0200
Subject: [PATCH 1/2] t7900: adapt some tests to use a throwaway repository
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260807-pks-t7900-fix-flaky-test-v1-1-08d0ea0fbbc5@pks.im>
References: <20260807-pks-t7900-fix-flaky-test-v1-0-08d0ea0fbbc5@pks.im>
In-Reply-To: <20260807-pks-t7900-fix-flaky-test-v1-0-08d0ea0fbbc5@pks.im>
To: git@vger.kernel.org
Cc: 
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

