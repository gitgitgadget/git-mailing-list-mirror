Received: from fhigh-a1-smtp.messagingengine.com (fhigh-a1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6B141F03C7
	for <git@vger.kernel.org>; Tue,  7 Jan 2025 12:30:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736253059; cv=none; b=oHyZMpm19pNdxaPV0wjCJlNFHDsBNxwVUaadoDBd/+b/WD7er372vOhqovlCAgXIY4LCHYdE7/k4O0Ra0lRc9K5e+YgYg8ajF4bZVPmqe/bf8Eq3a4hvXolju83DWiLYzJ/T6WXHwvgSMtLEfYLum5ichpHxjw91R5Tgl5oLBew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736253059; c=relaxed/simple;
	bh=9U5pSa1Ya/qFA16RVITh0ufhTFoyrRiuuHsuhrHW4xI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=QDr2IiAouweKQlEJGIDBL/+9jTQhZsHrUJA14uUhaw9+C2qjGjxyU2gVJZwH5Swq0+Sdr2O3HMtYg/F+7Qsxvj4OQ8dMiv57CKvqxEMeKHZR+0aILa6skDQufC4VBSuu4UD64saA1O1PlaB0MLjFrDb1AXFiX26uuakBNxi22uY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=aOC7MjoC; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=J4fHypXq; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="aOC7MjoC";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="J4fHypXq"
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 28B641140190;
	Tue,  7 Jan 2025 07:30:53 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Tue, 07 Jan 2025 07:30:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1736253053;
	 x=1736339453; bh=NHmCDjoh5XWaGXJRxFyoi47O19R/mtulCqgmb/hGRHg=; b=
	aOC7MjoCgl/BUCa9vy1NRFNBcLDZthDIkvgzEJv6I6CjpGVWh578CiZCIW9utjmc
	t+OSeQSlIPWTdAd88I4cxNGoIikRk/6W9OxoP8m8/3tgMfIDy3YQBi9+NISlruWx
	8V8bYw/86mAB/UIVtcBjaI0KC2bfHeeL2auEDSchLfGE9NEblsm4I78kpcpWESWc
	Mm2aUPHYZS4jkktaDdTv0RbywLYENW4XQWs2GleyKSmm4H8YQBWt48jgtqlPpCjA
	+yEHUrCkUaZmR0FU0xUCsLMqZ0QjNzcgvfxJ9cZsMOS6typxBKe1TikMO1LGwwuE
	jDhcpPVvZ1gPzwZZpYJ2gQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1736253053; x=
	1736339453; bh=NHmCDjoh5XWaGXJRxFyoi47O19R/mtulCqgmb/hGRHg=; b=J
	4fHypXq4loUzMC2vNPa/juqY/TNkP2wJzWKvCPG+9kIdLcGoYj0o5DrQVmop4Yjb
	7GlaEBO5O76iw46ryoHJqWaZeM6vGq3/7NrtkZZsU069vYXIih0JUsV6cVWTQTWh
	OlgE12pzZ+a+CW4PAmFAOxFuySF5a1rPwuqnqI3FYo1bLXXv+8SRocFnveIR8b6x
	TN4G4c23PvACFVwtBEONqq37jWy3tGaoWB/pWyX92KGdrWkrWXd+WPcGRrCUQikz
	EOr5PnY9Bm6KzbI2yjBVga7l7PfXZCIslGfGYTvX7Z1ljQFrqtGSIGqjBsqkWa0f
	NyI7JB6ou/kGdNKnO2D6g==
X-ME-Sender: <xms:fB59ZxT-PyIC3x6umgnZ7z6p81i5W_SKKdiHstUDZOEmAza7wqE6eA>
    <xme:fB59Z6xC6-2gKi72tCdV2nSVsAQp25U7OygkKiRn_qvGc4tVCjZaEC-I73zDMlgU3
    Oce6VX_cBUo9Jjh3w>
X-ME-Received: <xmr:fB59Z21DAkGv020tw6NNG3jAsDRl-w7xyPjaO_Kx2NbZhMTDnCAWL7HYb5Fh7E3eQDW3q7v431MZV2KZB4P5WCX20sJDd4BzuHiE5tGG7k0f8A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudegvddggedtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdej
    necuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrih
    hmqeenucggtffrrghtthgvrhhnpeffueeiudejvdekheeuvdekfeffiedvueelteekudeh
    jeetkeegvddugfdtgfeileenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmh
    grihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeegpdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhmpdhrtg
    hpthhtohepphgvfhhfsehpvghffhdrnhgvthdprhgtphhtthhopehphhhilhhlihhprdif
    ohhougesughunhgvlhhmrdhorhhgrdhukhdprhgtphhtthhopehgihhtsehvghgvrhdrkh
    gvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:fB59Z5AP6qmO8LQ4gqzz9cJ0IEEmcSGudj99eqeft_OPKSM9p6Gymw>
    <xmx:fB59Z6jEpxft1fnbK9Ybd5cXj5qNY9JJjv-tmVBCQifQRocpkwh6pw>
    <xmx:fB59Z9pH5EjjrQfgQnSHK9dYUduIv3LZeBucHVIpLhvuqCoOVjD-YA>
    <xmx:fB59Z1gFVt2urpcBgAp9EdX00HneFX3Wca-IMRM6VU_CB5V0i21EDQ>
    <xmx:fR59ZyfnEbgA5X2YXNYHPd3sQ_MVRs1dGcAjZfRcfkrAAJWYHAf8kkw5>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 7 Jan 2025 07:30:51 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 46df0bc9 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 7 Jan 2025 12:30:51 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Tue, 07 Jan 2025 13:30:50 +0100
Subject: [PATCH v3 08/10] ci: stop special-casing for Ubuntu 16.04
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250107-b4-pks-ci-fixes-v3-8-546a0ebc8481@pks.im>
References: <20250107-b4-pks-ci-fixes-v3-0-546a0ebc8481@pks.im>
In-Reply-To: <20250107-b4-pks-ci-fixes-v3-0-546a0ebc8481@pks.im>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>, 
 Phillip Wood <phillip.wood@dunelm.org.uk>
X-Mailer: b4 0.14.2

With c85bcb5de1 (gitlab-ci: switch from Ubuntu 16.04 to 20.04,
2024-10-31) we have adapted the last CI job to stop using Ubuntu 16.04
in favor of Ubuntu 20.04. Remove the special-casing we still have in our
CI scripts.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 ci/lib.sh | 9 +--------
 1 file changed, 1 insertion(+), 8 deletions(-)

diff --git a/ci/lib.sh b/ci/lib.sh
index 2293849ada3b45873f80e4392ab93c65657d0f13..77a4aabdb8fb416c1733f02d02145b6bc0849998 100755
--- a/ci/lib.sh
+++ b/ci/lib.sh
@@ -347,14 +347,7 @@ ubuntu-*)
 	fi
 	MAKEFLAGS="$MAKEFLAGS PYTHON_PATH=/usr/bin/$PYTHON_PACKAGE"
 
-	case "$distro" in
-	ubuntu-16.04)
-		# Apache is too old for HTTP/2.
-		;;
-	*)
-		export GIT_TEST_HTTPD=true
-		;;
-	esac
+	export GIT_TEST_HTTPD=true
 
 	# The Linux build installs the defined dependency versions below.
 	# The OS X build installs much more recent versions, whichever

-- 
2.48.0.rc1.245.gb3e6e7acbc.dirty

