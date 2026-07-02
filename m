Received: from fhigh-b7-smtp.messagingengine.com (fhigh-b7-smtp.messagingengine.com [202.12.124.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EDC448C414
	for <git@vger.kernel.org>; Thu,  2 Jul 2026 12:01:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782993689; cv=none; b=tJRiOyE6R9LphGuywtRSeOrQ77ENiPLvIHmoMSq4hGPHIZ7pslux2qMDScMXYYqXyUbCmTj5nW5pTL9BY9ZPSZDeQ/2r0TugDjUCiYjvWsBQbypPvLs/wGAK9QEu9uSmC5p1N/5cn91oFOduP9sljyd43e+VF9MzbFrkKwtDkmk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782993689; c=relaxed/simple;
	bh=SZcZJhmh5DaKPGCsrn4GJv9rj0zaTKFOdl7C15bWz+M=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=lCYpG4qG7FWpqrCat21laauNQJ5nOuwSc7soi6HvUZmVN2t7DStmHAoEbQgdetx5d2SW/SZ/aIj36kd4whqEJ5TZeJWPyyJjaEx+srzvIAKCeVZ1dpZatsmFaipe6XmAMgC2olOVz+g6ZnC7Mkr27GqSBguG+hcI1O/q9A2d19U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=Cc+6O+L/; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=SBOhA3G7; arc=none smtp.client-ip=202.12.124.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Cc+6O+L/";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="SBOhA3G7"
Received: from phl-compute-11.internal (phl-compute-11.internal [10.202.2.51])
	by mailfhigh.stl.internal (Postfix) with ESMTP id CD1087A007C;
	Thu,  2 Jul 2026 08:01:27 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-11.internal (MEProxy); Thu, 02 Jul 2026 08:01:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1782993687;
	 x=1783080087; bh=M76ySHe1+ZP3S3R7CuWibA4lkzAccC4tBQS/QEjE4dY=; b=
	Cc+6O+L/lmh/PXAb/4iqP+1y1v0UGb9/PQTd9xr5PreNqs1HT/XnLNX6Fx5qN/8y
	blUjjr8yPWf/H12ft43hxryl7G/uKU+qrkis1H3pOwuGoo9fG8fBRoXdbGMIpJYb
	tP+Gf+qbs8KVkjvYcluCc6zjLcrSBy0nx7sFa2kPzKTYAEr/85nrfODllS1ufdzh
	O4O39xNZDAAhJuZHqHZSmsep14MwhD9C7BzQ65SanuorncgSJlVMuPiqQMiMdXwb
	rEl0bKpQBiNM+e3BD8s36zFbqNjHZNTQQ4DIjML3fldm7/IKm+G6uC/WoM3GBaTF
	Z3BzmGGB+bxw3yV5lXruSg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1782993687; x=
	1783080087; bh=M76ySHe1+ZP3S3R7CuWibA4lkzAccC4tBQS/QEjE4dY=; b=S
	BOhA3G7HH0C7uubUJ+6AL2k/KtTWQmnWk0tx1OoxbShbhA2ybgZxRNS+f0/Awm4k
	cxl26GGtk5LAqiK57qm902tE1rNrRE/G88qNzghNUi21zU58fgreoSHUdfJFk36q
	LINv89uXsIjRtbp9dsohE3FpalhFHQAO8O7YET+78NGXeHHA2RiT0EUU55G32hDn
	PQBBFFMo7osM9F+opQ/IOBeDkLR6qPnVTpssHeKUpI9JxOWjfE+OHPwNESTJPf6N
	3pEsphulozxfweEj4DubWb3g5nZf0XFeahPLwXYkS5t7SjaVI3z8noOiO0fPI+Nt
	/0mzbO+BjEhQSmy9FOoUg==
X-ME-Sender: <xms:F1NGasXzbBgMaf-2Tp-sSB_Lc9i6nfmZ0zcLVSOQCUhH6GBLbBAN2Q>
    <xme:F1NGaoDA1IqvT-UpP9uXcLgB_bzMhmgzXCuLzoA06EUV2Og32LN8EdXNgzEoUqTND
    hlD9-EBVb0pRjlSe6UQJ0MaR8J9byk_6qc2ndFtB1S1H1HV4aZb>
X-ME-Received: <xmr:F1NGatz-BuxJKh3rDYzcf0bwwZ0AFXwWOqkRp7Td2Ys5W7SasMiCE-FQBS0u0ds60xrPuXM3NgeOsIhtTo2lBMyWU_965Lw4uy5CJJYjlfP5mA>
X-ME-Proxy-Cause: dmFkZTEa/pMqGTBJ2nMWyF/M4a8PLqbQYM8Nj2TBdCbtW/8Wl7krpf8gxnRGQTQoquOhdo
    6VgJXEj9fWg+vgkmD70bOAB/bFoSLAuqcan+dMt5rMioyaUEAeajHYfNi8S+goKEJa5mLz
    7k9FPiIbhwgzMYGXdRG+/bYtjak55xD22cGzf8Id2pD4S7oDrhXjEr3qh91H6PPG9SsHEF
    6UEnQGdoO6xon/2UFlM1EAZROd6jgP1h9Qa2dFAGvhB4bfjz+1W8ggIx72TWAkmcAGgitf
    nllKaA218pMDAKPeKT+Xf4UsjlCevhsTMHjAopmf4n4pQpUVY6CWxmRB98ksf+AqVdp2AV
    /pqBIjAksIxDkjkLLZDZDTRrLbHy13wZum/ISBeNhnSI3hvRTlNoEMcaPpr+hT0ywsA5Iw
    Foy02RtJs8O2kpqd7n2LFRRnjiG+VM9BBN5+JMugMyZlaxhS7yS9FRFQoSXEjsskZKbyOo
    5f3mrPbRPfsjwjplDtNx+AlseE2MgmUCSOZ5YaiDL39/OytS7eL+2VfgU9Qo0EYARMUTC1
    cz2B1MHJATdmQ2cpslbjTGwNgmTV1vZ2KdWFV4XEbCBTAnTT+QWGpMVkS/3xpSbuq5e8XU
    KTUnU1tbKJCmdEImQBsLwaC336tLL6KLz+78gAVG51plfP/VF2q7heFjZCxA
X-ME-Proxy: <xmx:F1NGalCvjmun7djR6hnjZPgnFmGfx7Y8wcOmN2V_K-JtXysyFQGQCQ>
    <xmx:F1NGaqYAZGUs9UxTzGeIzz2GX-jaPAijscfZGlyyra1MfFHsPxY3rA>
    <xmx:F1NGatjrwpvM4NYKJsvzRpG1XbfZrBJGshv0FL-9Gym3Ue86F_Zd9A>
    <xmx:F1NGas6E1ZpEE50wxZYyK0hln_w9xUNzQqfYsJzegmK6EAS92qsqfQ>
    <xmx:F1NGailIlcZprS5pQD6fiK-e9U3N62fJfayXmOJgKCZoc5bk7uSYhA-5>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 2 Jul 2026 08:01:26 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id f4d6a72e (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 2 Jul 2026 12:01:26 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Thu, 02 Jul 2026 14:01:02 +0200
Subject: [PATCH 9/9] gitlab-ci: enable "GIT_TEST_LONG"
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260702-b4-pks-t-fixes-for-GIT-TEST-LONG-v1-9-76b4d7bab3d0@pks.im>
References: <20260702-b4-pks-t-fixes-for-GIT-TEST-LONG-v1-0-76b4d7bab3d0@pks.im>
In-Reply-To: <20260702-b4-pks-t-fixes-for-GIT-TEST-LONG-v1-0-76b4d7bab3d0@pks.im>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, 
 Johannes Schindelin <Johannes.Schindelin@gmx.de>
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

