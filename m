Received: from fout-b6-smtp.messagingengine.com (fout-b6-smtp.messagingengine.com [202.12.124.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 837DE3D525E
	for <git@vger.kernel.org>; Mon,  6 Jul 2026 06:24:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783319068; cv=none; b=elyIKCjEpE9mnNvCTWYaA/HKQF1OY5TW6SwfDW6FLM+BXHZ93XdslhY2fiPDBpC+xZHJDwe/1lgUAsZMd54y5WIpxkOv0uf3fQASbTn9jaE6cFqEb8AmZf9/GDQAxq61AGCPcF+7dys7pKz/G5bAZzZiwpy31PKGkdmpJ/6qoGM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783319068; c=relaxed/simple;
	bh=Jl3GJIY7/9cDbfjCrlNi2BHzibY3HLXyycIm+bl+j9I=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=oD+GILeATBp4nVHYumCLAvYZF2fNTzBP6UBO83RNEklRR3qlBlFBIzGJ+WcC9hsSXElB79nOEjoonJSJrBxWIC84JpkAO4SwtjYxO7IOiQ2A8H76ADIOH5cC7JFj+ZzFcM1S/RV4cnFqqDptZSqNX4t2vQ8tF1bd4Eb3uQBk0ow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=aIhSSP/S; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=P0mBQc5I; arc=none smtp.client-ip=202.12.124.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="aIhSSP/S";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="P0mBQc5I"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.stl.internal (Postfix) with ESMTP id E9B2A1D000BD;
	Mon,  6 Jul 2026 02:24:20 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Mon, 06 Jul 2026 02:24:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1783319060;
	 x=1783405460; bh=Bi22qJ+c5ZltwLA6XIbB/YqHsWgC1UX0IgyRBEk6Oz4=; b=
	aIhSSP/S9FQr5PvaiwFfWxhj9TzyoMd83gXeeTrQ2VgiYRsxt9qKK7N1MkGL5RZV
	L09krghoy9KzReRdt3TK+M7KqBze9bRGzDryMKmkeiqn3F9CZiQBKiVSb6btPQXV
	3sUfCOoxN3+ujKtX4KQlztZBgWpEVqAJC9aiw/zM0DUlQbRxg+wOfSQUOol4wJah
	48xPqtECGgM+89UN46v+C/YqQ2DnLY9cwUzVQ5lRY55TEBFDh5iCzz0FzbkKlqT7
	ddV/WWqTCh8Lt0MPCPTeXJp0aSF9CucUDTCKN4uJARXDH8pwNG76JrVrG6vr3aEt
	wHykN2XCKVOyMhCr+VyzOA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1783319060; x=
	1783405460; bh=Bi22qJ+c5ZltwLA6XIbB/YqHsWgC1UX0IgyRBEk6Oz4=; b=P
	0mBQc5IMDyXT5PV6GCJ9wzNqGjm0Do6Lk0gf7PIx4biLoi4TE4QfD+IHXQmqmjoh
	Ce79qvQt22y4WOAPZmZgzAM5pLj/7Ds2Z34MKnrI1GR3A46toa9UtMXVSfc9jDK9
	ELn7JxnUGHMeBgKbEoijk8RZhBjD1ojcXucuFqqYrFN/s83IRW/Uvg4KHZwfPKmq
	M1+2bAnDtq0CuoTHIJTZEEx7GuD/M0BBPpN8ITwe9YE3ISbedLpsTY+xj2n4Wysz
	ZjaIMOFQYcZmuaWQGmjeUtZUFv2soVCAOSPkfDEjwbXLl5aAMKR6m7oRGLx/icAi
	IRltZ7O5Sk5eP6bIi/9OA==
X-ME-Sender: <xms:FEpLahXS3JRizFAjoSdR1j9vAzUhhep2p87U8K4CliRR0M1JBlxwjg>
    <xme:FEpLaoc3TcMg2k1FEjrg2m3PIKC1MMb6NbXjnCLEW8cP1tntlKcN1gm0aHU22lyE9
    8DCsMegKbfOOcfz-kDh3js_VRu6PMCuD_87zhPxoI_Ll1RNVRo1PQ>
X-ME-Received: <xmr:FEpLaluBSm00kQkwZV5EJbCyai_e_bz6A8b2ighNqa-w2n2pRhfz0fHNGWLQjMfvDWw95JQUh4JkSEQPDFrKM9dD3PinBgEuTRL4BdSWwhY>
X-ME-Proxy-Cause: dmFkZTFexpsNN8+D1iB4kmccXHNXSwz7Jj2Jci0dIahDOLBK3JR9GzpNXmk8ZjVQMNuAiz
    NbxPUSm/PPCoV5/3Ush0TGdOppTlxnJBxvn7l+1vf0sw9WBdKEtSWeUoeOI8fST8Mn4Nhv
    qjSftjyM2Tm9bdl+gmtQ8CVkJ6YNokwW2zLSkH4xJ27EzwvUZ/SzWJEQ6+9g2PMn/YNd1X
    gwXl+0oCzj2ubEWj5XVNiCl0luAzOyh3YEPf/A72yEFJNE0KGPybhEUrD1QNfTKFPzlhBL
    Oz6CorBRX/mF1rpMTmdXsbloSzqKJjGhncv6qKPHwGyHHt4/5bePAsn+WRPDLz0/8nkCP/
    XWXmJzm8t9N73CoA0l/F71ppWsH5noRKLmqCp9T7wGCtPWJSW2nnS53Taj+cIR/MLnI6Ga
    60rDKckwtEH9KksmQJYTdridxo1YRr2mYxXPLjCEvMMx0tPDYNNiPB1g/iE9cynR6JEYtV
    4phWbmTVH0ZphS3N3NIIoSf1HENVRPuxq9Ts7vLx0WEBJhljbWQ4/egwpnmrTE6Om3iAgx
    lLQJiixp0Jkn4QOv5jBCPLdtN5B6U0t9bc+rkGiUn5hVS0Bc+AfKazw/UV5E2yORmBV8Nr
    KHZ4B7UaKocxd8MIGRIIQtRepvdYqGI8gGcOIDRrrdyon+eQyaxMAnWXPJ/A
X-ME-Proxy: <xmx:FEpLav__dSgc1Bx3gIdjGriJesqCid9Zr4eT4dnpj4y4l3B98uNzUg>
    <xmx:FEpLao3WZpR4bWRA6Af-6DLK0RptJyZopbFsPuQ9VRlMaqxtspfk0g>
    <xmx:FEpLasBhhKgyw4j9cNP4ZON-kuYKK1Q1lbMnbFTeAyE3w5-U6-nF5Q>
    <xmx:FEpLasdmaaNI_7sc5tKLBq32RPYGP3VRyth_cLFFp2kn5n3RorOV0A>
    <xmx:FEpLahaQZQB4a9e1wWUoocTnFcxXmof6pTE1A_hI3B0mxaMM0ezUM_hd>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 6 Jul 2026 02:24:19 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id d6b39cfc (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 6 Jul 2026 06:24:19 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Mon, 06 Jul 2026 08:24:02 +0200
Subject: [PATCH v3 7/9] t: use `test_bool_env` to parse GIT_TEST_LONG
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260706-b4-pks-t-fixes-for-GIT-TEST-LONG-v3-7-4f6c5a37fd1f@pks.im>
References: <20260706-b4-pks-t-fixes-for-GIT-TEST-LONG-v3-0-4f6c5a37fd1f@pks.im>
In-Reply-To: <20260706-b4-pks-t-fixes-for-GIT-TEST-LONG-v3-0-4f6c5a37fd1f@pks.im>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, 
 Johannes Schindelin <Johannes.Schindelin@gmx.de>, 
 =?utf-8?q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>, 
 Jeff King <peff@peff.net>
X-Mailer: b4 0.15.2

It's currently hard to explicitly disable GIT_TEST_LONG by setting it to
`false`. Fix this by using `test_bool_env` instead.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 ci/lib.sh     | 2 +-
 t/test-lib.sh | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/ci/lib.sh b/ci/lib.sh
index b939110a6e..01a0bc6b75 100755
--- a/ci/lib.sh
+++ b/ci/lib.sh
@@ -321,7 +321,7 @@ export SKIP_DASHED_BUILT_INS=YesPlease
 # enable the long tests for pushes to the integration branches as well.
 case "$GITHUB_EVENT_NAME,$CI_BRANCH" in
 pull_request,*|push,*next*|push,*master*|push,*main*|push,*maint*)
-	export GIT_TEST_LONG=YesPlease
+	export GIT_TEST_LONG=true
 	;;
 esac
 
diff --git a/t/test-lib.sh b/t/test-lib.sh
index ceefb99bff..623fcfb747 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -210,7 +210,7 @@ parse_option () {
 	-i|--i|--im|--imm|--imme|--immed|--immedi|--immedia|--immediat|--immediate)
 		immediate=t ;;
 	-l|--l|--lo|--lon|--long|--long-|--long-t|--long-te|--long-tes|--long-test|--long-tests)
-		GIT_TEST_LONG=t; export GIT_TEST_LONG ;;
+		GIT_TEST_LONG=true; export GIT_TEST_LONG ;;
 	-r)
 		mark_option_requires_arg "$opt" run_list
 		;;
@@ -1849,7 +1849,7 @@ test_lazy_prereq AUTOIDENT '
 '
 
 test_lazy_prereq EXPENSIVE '
-	test -n "$GIT_TEST_LONG"
+	test_bool_env GIT_TEST_LONG false
 '
 
 test_lazy_prereq EXPENSIVE_ON_WINDOWS '

-- 
2.55.0.795.g602f6c329a.dirty

