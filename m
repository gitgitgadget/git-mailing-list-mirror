Received: from fout-b6-smtp.messagingengine.com (fout-b6-smtp.messagingengine.com [202.12.124.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED13A3D8900
	for <git@vger.kernel.org>; Mon,  6 Jul 2026 06:24:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783319075; cv=none; b=Wsbq5BWPQ3sg2/fKglJBwEbms0LcSqebeWNUlRW93qDLhyJ3/QlrRR1omW+/piLA8rRLnAp+wVMWvcOuHRDEpPNxNeGzktSnP+2XKoCEVI3WytSRQ7xGaoTz+d3fonsXhEqT+K1Yn+zzGmNqUAvjsovnDx4hhifex0krXfGYvEU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783319075; c=relaxed/simple;
	bh=SZcZJhmh5DaKPGCsrn4GJv9rj0zaTKFOdl7C15bWz+M=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=iMfGlDrbWSCdpodDbDrUkZI9JevDo06kNf0SRs4uPD7xU2x9xTyRi8hkJcMNmHW5LRn3HPpZdXZDThMfJNbPekkdHhgsjgnS6pJACn4GaHrKzlwYtQWaFth29msgPXCpkQB75XVQinnEghu1g71egVyeBQM4yMT4Z3B2/QEn0sQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=cf3IgTh9; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=mA8/15+r; arc=none smtp.client-ip=202.12.124.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="cf3IgTh9";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="mA8/15+r"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.stl.internal (Postfix) with ESMTP id 225DC1D000C3;
	Mon,  6 Jul 2026 02:24:26 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Mon, 06 Jul 2026 02:24:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1783319065;
	 x=1783405465; bh=M76ySHe1+ZP3S3R7CuWibA4lkzAccC4tBQS/QEjE4dY=; b=
	cf3IgTh95U7ukoAljSLoE+MiDNEJP6FO/fCBFzbJRGb3L3wksOqqW8r3Ngb7928n
	04DteD03Nor9bMco0utFiHU8SwBdFBef7YXAJxMzCJBCUDtDBRcvNNgY0LIw3sQ8
	Zu+M9zsDobxUWcEJbcOuUgG8r/y5GMdEqNu2FSqrJOgiLTePMOOXqyysfKLJzT5v
	zW14xvbBlNVUOZEsp0Ji39wf3wq6KYKqma0UOd3Ixf4UGh7uAl/e+wCXZPTm6CX2
	ExmbgFc16rasrjkBgZv9RYEtQcwT+EHRf4Eh63Y+AsLeLZGUfBFnx/wY31vXnF2/
	MRNKqYRAoiXmUJFVYS5HcA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1783319065; x=
	1783405465; bh=M76ySHe1+ZP3S3R7CuWibA4lkzAccC4tBQS/QEjE4dY=; b=m
	A8/15+rApJFSoVPhLVx8q8DCFHDWvmGONTej6rXF36DC0EjD9hLJnRwqCmWbpmv0
	qObm9eGzwnfoOHio0kiqolwlun5IUnRyx4QhsJBEQW75LVkh6OVnaqkSKfpCE3Nb
	YAj0HqhYog+lriM04aLVnuy2ZJX9qS2PeJcWhMtk8IaoFlQvuFupEa35aQ7Womio
	xjDpsmiGxUENyawIIq9/tpVG7+zr3CXE37ql2xuVl/R0zHOC45yPeAOEpTYip32s
	m2ta1XNFT2GdF/RWSAfVQGvC/07yJS19YMGUdKxZIaXlfr6buYRdmzmNN905SfOS
	UMXfBWl8DiP/AsJbtyeAQ==
X-ME-Sender: <xms:GUpLaiIcprc5-2fIvaUJKLp0C-F6dGHz5sfXnqDdMAFzGdza3Izohg>
    <xme:GUpLahBthfWcWBGPQSeX0n3pzM4wHyv05kM-E4LKoBb6n_7D97ZRNj0O-8JM9L0gC
    _eiP2vcvm0JwoQA6qsYYCNk2J5cBx5RidAEybSKmR2ySVh4MslzVA>
X-ME-Received: <xmr:GUpLarBinnefe4XIHjVjmAqw4cApetgUU430cV6XUCYrpINQesKx722PaKp7hExAfrsXdsjgSr3o2jqz4i48DmRJLI-yIyeQmCDJUpuQYvw>
X-ME-Proxy-Cause: dmFkZTFmtDwNISh74WWS0/J9hdQqLKv21ClKsUHf5vXif8xEKB/RVFgrRZ6eMF5TZ0F9FQ
    MLaMAHvMPW3ftQmynyDZOcfxi4Dr+jTvOAcrdb64R8lWWsxvJ+51TUUVsWU8+CG3AcmHdZ
    4sW3lkGXhyoxIGgR0aGTL8UWrIkK/JiiMzpF5AlLuhEnxcudttwi4+Ie/h7XfzxCIyQ/yh
    mDx4evcKBiM3lkwpV8jNZRrtNhn1dUmqpA1Rdk28Z3q1eIjAn7wqKusccB6k228ACjACeJ
    eVT+2pNAsU/vlBw4Da9JuECz9xgRVM3ZkCVhGQtwO1SvfGNcumAh3wmOq+vtFb0S3AddEP
    Zqb59d8KKMJH8ejPHo7Nl+IuguFiGaiqZ4doCWD6IKDsf50X9zWTkWgxYDDeQsXTUnLyeu
    6yQCQrW7/OjI2ovKZ1LCIWG1li6N+k+dXt5fLyTTHN0MhgO27HKzXMP12YF9vQQO5W5p2N
    wQyY5bTfOggy+ANluA7kcKcN8QNrjSGFo2aziU9KPDQwaX8oB+t49TGiWvbNGwLJKCYb0/
    iaaS0Mh7dBS7tUh4Vo6ZA8ENT1hHAPU8Q7+32AHtO/UNHJ+kWDUb7M/587WlIRPxbjkasq
    ZnGkEcLlI+xb7A4EP1gzWoyqr0uPPqE6ivArKgVKf8z+ly0dxNZjHIgmY/dA
X-ME-Proxy: <xmx:GUpLajBP-1qeWlRB-0xS-TuOwLR5IFLL-Y1RLEHe--4emQ1_PJSNcQ>
    <xmx:GUpLamqUe1vuQjHANIGBZtBijEFwVbi53knc0pV32HjylCf126l8PA>
    <xmx:GUpLatnGqbx0LH1pG4l_K9CipQ201lboFjJYRuHLxW7BZ0YMz6UQnQ>
    <xmx:GUpLamzoNbHqwVpQe_Zqr-Nc-2KGjGrnYRZcRS5e9dIqnT1UMNiDCA>
    <xmx:GUpLatM-1pbLQZGJiPRw9x98_UghB1CYJY8BTMmuMH3mg2l7ndr5nps6>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 6 Jul 2026 02:24:24 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 1529d7b2 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 6 Jul 2026 06:24:24 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Mon, 06 Jul 2026 08:24:04 +0200
Subject: [PATCH v3 9/9] gitlab-ci: enable "GIT_TEST_LONG"
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260706-b4-pks-t-fixes-for-GIT-TEST-LONG-v3-9-4f6c5a37fd1f@pks.im>
References: <20260706-b4-pks-t-fixes-for-GIT-TEST-LONG-v3-0-4f6c5a37fd1f@pks.im>
In-Reply-To: <20260706-b4-pks-t-fixes-for-GIT-TEST-LONG-v3-0-4f6c5a37fd1f@pks.im>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, 
 Johannes Schindelin <Johannes.Schindelin@gmx.de>, 
 =?utf-8?q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>, 
 Jeff King <peff@peff.net>
X-Mailer: b4 0.15.2

Starting with 7a094d68a2 (ci: run expensive tests on push builds to
integration branches, 2026-05-08) we run expensive tests in our CI for
certain events. So far, this has only been wired up for GitHub Workflows
though, which creates a test gap for GitLab CI.

Plug this gap by also making this work for the latter.

Note that these tests cannot be run on the Windows runners, as they only
have 7.5GB of RAM. This is insufficient for some of the EXPENSIVE tests,
so we explicitly disable "GIT_TEST_LONG" on these jobs.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 .gitlab-ci.yml |  6 ++++++
 ci/lib.sh      | 12 ++++++++++--
 2 files changed, 16 insertions(+), 2 deletions(-)

diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
index a4aebe8b71..1c4d04da9d 100644
--- a/.gitlab-ci.yml
+++ b/.gitlab-ci.yml
@@ -147,6 +147,9 @@ test:mingw64:
   needs:
     - job: "build:mingw64"
       artifacts: true
+  variables:
+    # Windows runners don't have enough RAM to run EXPENSIVE tests.
+    GIT_TEST_LONG: false
   before_script:
     - *windows_before_script
     - git-sdk/usr/bin/bash.exe -l -c 'tar xf artifacts/artifacts.tar.gz'
@@ -195,6 +198,9 @@ test:msvc-meson:
   script:
     - |
       & "C:/Program Files/Git/usr/bin/bash.exe" -l -c 'ci/run-test-slice-meson.sh build $CI_NODE_INDEX $CI_NODE_TOTAL'
+  variables:
+    # Windows runners don't have enough RAM to run EXPENSIVE tests.
+    GIT_TEST_LONG: false
   after_script:
     - |
       if ($env:CI_JOB_STATUS -ne "success") {
diff --git a/ci/lib.sh b/ci/lib.sh
index 01a0bc6b75..6c52154eac 100755
--- a/ci/lib.sh
+++ b/ci/lib.sh
@@ -215,6 +215,7 @@ then
 	test macos != "$CI_OS_NAME" || CI_OS_NAME=osx
 	CI_REPO_SLUG="$GITHUB_REPOSITORY"
 	CI_JOB_ID="$GITHUB_RUN_ID"
+	CI_EVENT="$GITHUB_EVENT_NAME"
 	CC="${CC_PACKAGE:-${CC:-gcc}}"
 	DONT_SKIP_TAGS=t
 	handle_failed_tests () {
@@ -239,6 +240,13 @@ then
 	CI_BRANCH="$CI_COMMIT_REF_NAME"
 	CI_COMMIT="$CI_COMMIT_SHA"
 
+	case "$CI_PIPELINE_SOURCE" in
+	merge_request_event)
+		CI_EVENT=pull_request;;
+	*)
+		CI_EVENT="$CI_PIPELINE_SOURCE";;
+	esac
+
 	case "$OS,$CI_JOB_IMAGE" in
 	Windows_NT,*)
 		CI_OS_NAME=windows
@@ -319,9 +327,9 @@ export SKIP_DASHED_BUILT_INS=YesPlease
 # enable "expensive" tests for PR events.
 # In order to catch bugs introduced at integration time by mismerges,
 # enable the long tests for pushes to the integration branches as well.
-case "$GITHUB_EVENT_NAME,$CI_BRANCH" in
+case "$CI_EVENT,$CI_BRANCH" in
 pull_request,*|push,*next*|push,*master*|push,*main*|push,*maint*)
-	export GIT_TEST_LONG=true
+	export GIT_TEST_LONG=${GIT_TEST_LONG:-true}
 	;;
 esac
 

-- 
2.55.0.795.g602f6c329a.dirty

