Received: from fout-a3-smtp.messagingengine.com (fout-a3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2476C4915BC
	for <git@vger.kernel.org>; Thu,  8 Oct 2026 10:01:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791453702; cv=none; b=TjKyQdLSUiCioLknJNCsFjPnxth2p2qHTWRtPrdrjgiZtZRgGzgU6mNV3mwZFfhzrMv26YMECARAxD04/w2U7za9U1GjpONIjJOPHIG5JN4Fq+nBxnWHBsW9lwAmCs0jWx/0fIq+e42QEFlCOgipmzkvRrUlGXctSIc5C/z/k2g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791453702; c=relaxed/simple;
	bh=+gQ/hNNrZvTD8eRyZ4a0c6FK7UBohxx1r7/bIX2mMyU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=LMnrhMV0bBgL3KugSqny+b7P0kkjQsDqY9M8atqmcM1rq49GrXzLo32Dz6VEUw3exaUn5yBDfhXgSG/CBTjpkR6kJk/QW4zEREjNTHu05svGUCB5CTQ9ApDmHV04vJbfBXGN+apLydBYjQaMdK0A53UXEJjfjMiqTXKUKEz7Jrg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=QGm2uQyQ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=UnTJ/vni; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="QGm2uQyQ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="UnTJ/vni"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.phl.internal (Postfix) with ESMTP id 42953EC00F3
	for <git@vger.kernel.org>; Thu,  8 Oct 2026 06:01:40 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Thu, 08 Oct 2026 06:01:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1791453700;
	 x=1791540100; bh=BBliUku6FFoIqZVtE4SuJX/eWkHGyWEGdGysraLS1iE=; b=
	QGm2uQyQvwO636rvWcYK8OfaqpQbrV+cLi6+F6jnAuqdmNeOAf7vCpZoK1mYd3Gn
	zZ2+nTVnyg0ABHYY5V6nXwiH+eI7znapcGQsptUbMYKD0qh/GoBylzmkYwpkfKKF
	cixNL9kEO4xMyFSn9Qp3g9QDBwcOvbPsQEeLYwKP1lD1FvCEDQZokRfcHp6/O2yL
	D8tP0MkwZ1e5DaUG5b0S0mDCHxuy0ke0wnVvdVF9U+wNZxZfMIHc323JLib/DwYM
	Mt51WX1r2LKvZ5qWSzFSCqiMN97ByOLaldtp7QN4dHJM8bK9SzlLjk5+SKLYd9Hd
	e+3aTJGv9hcuqLrwimHluQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1791453700; x=
	1791540100; bh=BBliUku6FFoIqZVtE4SuJX/eWkHGyWEGdGysraLS1iE=; b=U
	nTJ/vninUwae7GyZfnd/+FkJll41Uix5hF1XaZmcqZYPSLmkY9SYV/0K8Rlz9aXw
	CFDSn7BsAvK3N/PyFmNR6bPlhipNW2lVFss3ruhqyQCWgdOgYwt5BIi/34nQPCkg
	/W/CirAQyOJXOTaZGoBHP882nCzgbmdipY+VSgriyRtsjIaOPCJbRMPxsBegsoA9
	esZPWIAa+gKTGZiiIsKxAR1/f4Q1FgS/D3Ev9/5qLPq+exkxCnZjRCPWkTDiy6TT
	WWLFQHOoqIPphx7PB6G+Zjvs9MAXS4+VWrT494CIzA0UDwdejzvk3YGp3BT8LAfu
	whoN/YhBQh006HjaT5fJA==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
	action=sign d=pks.im a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1791453700; d=pks.im; mf=PHBzQHBrcy5pbT4=;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:viQUpf0DPwfMWDD/FMLLWaUjdgBGgxuaH6rCJKAQ/yeZiXf
	+9Uc9hGwUrTFD19okRJM8Z56RwatjeavMMRDgjHEepGTMPp5yLY5GFWouZhwyJM7
	C5KNe4b5b+Gn67L4dlsCuk6+kIPStcJ5aNdeLNXNGZ7xm8WkjcxU4a6eMqqkBjt4
	nd2NzYj1t56egJw2wfQ05F5q4oxzgKmcaPN9zsLiPVYXyrvQbZeBYIxrMKOJmhbQ
	Bw3cIJVs1i/Xbjv9py8XNtbmPIzyQt9F3mircXAYkDNvFhmy2/53v562VL7b39ob
	a2DHS5hBB+PmSz5FgUpY7c/4qznfyJvH5/bcxkg==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-transfer-encoding,content-type,date,feedback-id,
	from,in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:Fsk54hZ9G7ZFTSDk1q/jDjEtwVCjOj8A0Bi2x1aBIJs=:+gQ/hNNrZvTD8eRyZ4a0c6FK7UBohxx1r7/bIX2mMyU=;
X-ME-Sender: <xms:BGrHatbiJ-dfPah0MwlPJMeljJ3rAdwICJ0XrZysFltsJfu1PDvvfw>
    <xme:BGrHar3Q4aTOc9aKTdvc_yMY6t4gardrGrCSWuCTZCGDFTYwQHToL3Er8DCU8T23E
    vLH060QnyuAks2L49_52iLpL9ix_NNxcgv5zKp6watsYxmwbEKp5aM>
X-ME-Received: <xmr:BGrHatW2aZ6pi4LK8us9YmatoegMhILNpH-jrwrIZKvUgINKI6XRFw>
X-ME-Proxy-Cause: dmFkZTFcPkAz1MwdF9G91Q2HHt/DMwRQeFnKx+x68D7GybYDQ/i0KpIs24O8mGC97InV5x
    l9pAW0ts/UU9KH515tlBDmv+WZ0+KYrQRh6xeKbZfQat2Qz+Sg1rXt3b5uJznUCyp0m8uY
    71BCRA4fNnv9oBdGpbiziYXhCQjhE8NT9KNX8KIfhb0V1qRTBvsVj704A31+Hni2pY1ggP
    a3q+zc2dU5mDDUUOQmy2j1zpr2bNPvsQxh6Ysa48mXJ+zQrThKKxZGkcT5LdtAIGkRdeOf
    ck2bD2X0g14DJXkT4iu1Awq0JBVy1rhu1vpE3BYH9j6MP3iwrywFfxgjL3LV3YpxuArGK0
    uPhxXpLa8/zIlHKOxXqx8DD9nScZq5vtTDZZ/dt3WHgeizpneLH7psKYL9mQCJfKIisIEh
    m5Y/Wf3Lt6wSgV+H735veHjg/QUpQ1HSkEAdcYAJ5+w8Tgn08iCGFHiowSC2gjvskcpVMH
    8mJbmRBEYNkpaTqmjJcK0jmMbmmuISb1WPI9/GJWShazq1QoXIVvYqFXOVvEHYnGprUiQW
    GhKThST6T0FM6rcyi43H+QPYQWeGwjaogogwjqmYQt7eb1zwBr4EPFBP8bMB38X7DBQoJr
    ZPVvxfidgM/mibbWURxKt3gGtvseGpfie0dL0kIS0MH0+qhlUTQLAQq+Rxvw
X-ME-Proxy: <xmx:BGrHalW6bJiKhdoBbeTL5rpUOsbM2wYs4HjILXPCUZTMnsyK5Aq2pw>
    <xmx:BGrHascvcXwsxZ8k0kIDr_QNQIAKDw-RcruxgndYaPnob5nd2STo-g>
    <xmx:BGrHauWiI1WIzgayS5G2cZKF6vUSUaXqEvUD3ziGNsNcKjdJyZzGzA>
    <xmx:BGrHalcjdXMENbseushNWx2ye4FmyHJXJ9oQ8fXg7jPK8qNRc-3wlg>
    <xmx:BGrHain-Kg6YoF1YjxyuGQ3LIJN1kAfK7ZPrd73tEeBVVxnZqmeBKmQp>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 8 Oct 2026 06:01:39 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 46059ff0 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 8 Oct 2026 10:01:39 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Thu, 08 Oct 2026 12:01:23 +0200
Subject: [PATCH 5/8] ci: rename linux-TEST-vars job
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261008-pks-ci-housekeeping-v1-5-baf015c589c0@pks.im>
References: <20261008-pks-ci-housekeeping-v1-0-baf015c589c0@pks.im>
In-Reply-To: <20261008-pks-ci-housekeeping-v1-0-baf015c589c0@pks.im>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>
X-Mailer: b4 0.15.2

The "linux-TEST-vars" job exercises Git with a bunch of non-default
options enabled. The name of that job makes you want to cry though due
to the weird upper-casing and because it doesn't really tell you what it
even intends to do.

Rename the job to "linux-exotic" instead.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 .github/workflows/main.yml | 2 +-
 .gitlab-ci.yml             | 2 +-
 ci/run-build-and-tests.sh  | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/.github/workflows/main.yml b/.github/workflows/main.yml
index 6d1e37c8f1..d7a301ec98 100644
--- a/.github/workflows/main.yml
+++ b/.github/workflows/main.yml
@@ -408,7 +408,7 @@ jobs:
         - jobname: linux-reftable
           image: ubuntu:rolling
           cc: clang
-        - jobname: linux-TEST-vars
+        - jobname: linux-exotic
           image: ubuntu:20.04
           cc: gcc
           cc_package: gcc-8
diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
index 7d972f0c8b..27a16ed086 100644
--- a/.gitlab-ci.yml
+++ b/.gitlab-ci.yml
@@ -42,7 +42,7 @@ test:linux:
       - jobname: linux-reftable
         image: ubuntu:rolling
         CC: clang
-      - jobname: linux-TEST-vars
+      - jobname: linux-exotic
         image: ubuntu:20.04
         CC: gcc
         CC_PACKAGE: gcc-8
diff --git a/ci/run-build-and-tests.sh b/ci/run-build-and-tests.sh
index 23e87cbbd6..9381ff8893 100755
--- a/ci/run-build-and-tests.sh
+++ b/ci/run-build-and-tests.sh
@@ -22,7 +22,7 @@ fedora-breaking-changes-meson|linux-breaking-changes)
 	export WITH_BREAKING_CHANGES=YesPlease
 	MESONFLAGS="$MESONFLAGS -Dbreaking_changes=true"
 	;;
-linux-TEST-vars)
+linux-exotic)
 	export OPENSSL_SHA1_UNSAFE=YesPlease
 	export GIT_TEST_SPLIT_INDEX=yes
 	export GIT_TEST_FULL_IN_PACK_ARRAY=true

-- 
2.56.0.406.ga2d225a756.dirty

