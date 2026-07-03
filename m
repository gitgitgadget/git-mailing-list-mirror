Received: from fout-b3-smtp.messagingengine.com (fout-b3-smtp.messagingengine.com [202.12.124.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DB6A3B27D8
	for <git@vger.kernel.org>; Fri,  3 Jul 2026 09:24:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783070681; cv=none; b=O5bA3ub5F3fOPFZs/n3TcGksYjOqfgRYqKGM94zVmBoNXa7RxxwqilYep/5Id49qFROxYkhahCff87ZzFoHdj8+oc4MW5UnTv8ZdOW4Wll5vTQtygYWSuaZGBWJ7dPj96SX7BYNfAUZi5pV2P/baWox9gckeARF4rnWyWVzd8GU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783070681; c=relaxed/simple;
	bh=SZcZJhmh5DaKPGCsrn4GJv9rj0zaTKFOdl7C15bWz+M=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=a8OnLmd6Axa7hH6qwcis0qwwOwtALyFFyBQVxg9JVN/MWbb5z5Q4ekYzGD7x0+wEEEdmD/x0JDg9C4wl7TkrnIZ6apDjV6gQ/tlMB/9zw3Uhbf5r1jkDXiIoTzlWJR14A10VXAkBtwN/6ZuIOzbhi9DAr2ipTgmw0jdGIn1PfVo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=P1wdxAAQ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=V2Sn6s/N; arc=none smtp.client-ip=202.12.124.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="P1wdxAAQ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="V2Sn6s/N"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.stl.internal (Postfix) with ESMTP id C60DB1D000E7;
	Fri,  3 Jul 2026 05:24:39 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Fri, 03 Jul 2026 05:24:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1783070679;
	 x=1783157079; bh=M76ySHe1+ZP3S3R7CuWibA4lkzAccC4tBQS/QEjE4dY=; b=
	P1wdxAAQkvZbt3nTWBJ3uT8IQc6RxWHpSZYw5FQcsoGfPrC2yEcEj4rHukgkJNMY
	T7E+22YOL/FV8iJMwpTZDsugQ1iJCbfaW+2mOFfbG+xIZMWHjkKA0rIT1YxHDlu+
	Z6f+HPG73A1Ckn2QNSqyvG/94qahHhmmC4GlslB4sv9Wq8YtmpImeKEIzC2Yq8Q1
	/tFZ1QgRXHL1QWW8kufNFtaUBnFBrq+1sKiw6CqeZZdauff/hI5bXAkzwb6vmR/J
	Hjw7rMUtXK6LPUmNbQhSiHnx9vg6LhI4R2zMzhkeylNmY2iFLqSZWLv+w3j2xD0j
	v8oOpATwvfrtmgSUb0PuVg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1783070679; x=
	1783157079; bh=M76ySHe1+ZP3S3R7CuWibA4lkzAccC4tBQS/QEjE4dY=; b=V
	2Sn6s/N0X2D0i3N30qhcubAARFpsstrGfoF5HJmQmEW4xEbzIR/jOp3I83InV7C4
	vA5h68qQyh0WUbzUCjM1DG0gfEFBc7KGGCCn5idELzTAzbVdIWFFwbwUeqV6upnJ
	Nf0edNFyTE+QKXg81UfetsT7DP73vClWtJ2cGrA117Jdj9O2D9wSHwrnvxhMmhFs
	ptOAEdefyYqTdWsgy4DM2SCbPOEQPe19LiEu6Q/cSzLw+mWCS5HYXYb4HOAWhCjI
	Fu0D9eQiQIiZHXtTYVoyPn8Jws/PMpIWxG1cwklYaV5zqH6dTU53xW4srXZYVVdZ
	l4TdgSXOwuaSq4zZrdSog==
X-ME-Sender: <xms:139HajzVYAHMDivZnfMJ4YcJbd7H2n4LUGpQKJ3VHW7MG7RLFoqbyA>
    <xme:139HaiKZS0zwivl-WJ9f7h8u8Z7LRkxW5HMjtqeRi6sSC3fvW87stbzcB0Gn7BaWF
    nlmwWnBQ9DdeJUjF5CZTbFecNAJp6zATVT9cciy_SPvEaBic7hx>
X-ME-Received: <xmr:139HalpSL7IA92YUuHQWRLP3q59HV9SuKM8rFhaIrdIDGsQL4hGX9Frh0gU-Rhb-VX88-NLK0ZH1LA_-0Yspuiz6Oak1i39zrSxONmECKA>
X-ME-Proxy-Cause: dmFkZTFb5SBx9MeY3S5o5Ioqnar670cY/8XxsDOxiA7WSBgrFSHAkUx7DJ0mPTSh10hln+
    NvG5kJwq+PLRpa2VvbP94nrwnDUpfQlL2ITJTS7KvpW0pBHth0nIMzLG4LynhomUdIvyDJ
    u7b6wdnb8qmyq1yalx2lBNTUPFRXgACFqe6+WmflmFjQCd3WBVU5JMykP+n0J4vOdH3i8c
    347HlXopohgkAcU3cCdVhV5PDW2AAEkCy9H9oDK53D4ymfi9YiEH/y5z33uo35SfKFPzkL
    ugMGN+2d+N1xOG8hGC+IDD16+J8NTf0Zq9UsUiODtp88ohGckjL+H2Ebe6Ez3qdDLqrDsf
    C6vhHoCAPjBVAKgKbXvKd8Xg6ooMtj0uW2CsZbi+n5upgBc02wMA5S5ObZ01kQvPV1dOf7
    3gCT5Ce4GTPLlrKNf7VEfZ719CnbjqkSuzh6GSa7uOAA9pmSRK6zvCROQQeu8nRLCQux1a
    vL9tb0jiq1Qu8c4HBULBrSFDbOO/qbBcGge2UV80wN8Pq7BxTCaZgdxKZ/g3kbPDnOxDuJ
    j4OLdyXEoEXjka1A+o8qdyoggCKa/M8Z5uhRTbjpEDgXzlCzI8VaMGiS4PYmNUYxiRIRXr
    qzZCtmxqoMyz2DQPd0VT12sEX8cm+c7/VGuuTLah9WD077YKbKtdYg0PVWhQ
X-ME-Proxy: <xmx:139HapIWvN4z5zkbTwlK4yWNpdHy0jbGekz8gjxV3fFyl_ByzTfXhg>
    <xmx:139HaiSFCnKSxMIDJ--ksqgWnp6OTjFMxAEhIz5VFAUmdD-aOlomSw>
    <xmx:139HagtiRfsM8gv6idDfwcNndPCEI55DZGXQ6GYn-sNFFZIz-vkHZg>
    <xmx:139Harbo_ZRgqmYGIjdSeNUxiG8RXWzI5broY-MCwsfe-354gP0QyQ>
    <xmx:139Haonm51SsjwP3vcclEwuLXw53EDnivrUSqHLDWE2oAzWtWNGr5qb0>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 3 Jul 2026 05:24:38 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id ab6f5987 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 3 Jul 2026 09:24:37 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Fri, 03 Jul 2026 11:24:12 +0200
Subject: [PATCH v2 9/9] gitlab-ci: enable "GIT_TEST_LONG"
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260703-b4-pks-t-fixes-for-GIT-TEST-LONG-v2-9-79076a7e0c62@pks.im>
References: <20260703-b4-pks-t-fixes-for-GIT-TEST-LONG-v2-0-79076a7e0c62@pks.im>
In-Reply-To: <20260703-b4-pks-t-fixes-for-GIT-TEST-LONG-v2-0-79076a7e0c62@pks.im>
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

