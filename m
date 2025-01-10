Received: from fhigh-a5-smtp.messagingengine.com (fhigh-a5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDCC51714AC
	for <git@vger.kernel.org>; Fri, 10 Jan 2025 11:32:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736508730; cv=none; b=fBgS7pRneZK5YJMt+DK6/wJQKkhbZ9fH06/VRC/VSo0XK9p3U80UsoYN6eM6VI6f5pIJTxZAchfxO0++z2MajEIUj77FaaQsUl82++qXKJafW5VnWWqQoWwBZ9ARZMszgzFNexPtTi9ji5k+oggQIlXXcmCMePYZQh4V0ujFSbc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736508730; c=relaxed/simple;
	bh=E92e8c5L6odZSBnMNkLTL5dfQ2c1V4fRGOQFonxGVH8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=K0Pk7n1IV3RQGMWkeqZceyryxAk9d0ocAk/JPRyXV4B/kW8ldcUYTnyIJdEJpDFKF+okZZ9aXpAE9mU0QUNBWzEAeDy6kmb3CgwxL4ABFOE7Hq19a58bRvnuvVS8wYDi4SwrCnAyVhfDPLHgE+V710ff6C3BUx8UieqSO7BX0o4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=vdbGgJZx; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=bj2eo7sx; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="vdbGgJZx";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="bj2eo7sx"
Received: from phl-compute-08.internal (phl-compute-08.phl.internal [10.202.2.48])
	by mailfhigh.phl.internal (Postfix) with ESMTP id EF7B911401D9;
	Fri, 10 Jan 2025 06:32:07 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-08.internal (MEProxy); Fri, 10 Jan 2025 06:32:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1736508727;
	 x=1736595127; bh=xq3etOtcJkx79x1HGzYdICpQFtUlynF8xfRcB845rBg=; b=
	vdbGgJZxQKsc/o8PV6mcyLD4wF4sfbQoGHUmy0ilGoqizcGriRRFY8nZFGz2g4L2
	zRM8LBHihOPDgpzgQqx9vQnjzUoffQRUkn9vxjfdTMchSZgA45NAaMyoTyU8RELk
	ynMWCObSoR2DWa+4uyrf0lLBUxdKB+LVeL/Y44mule6sJTFre14QaW+rj5rf1pNk
	y5zfviVp5dMi2bqdpFzzDrmDqT1/2bEsHJMD+vfC23a0MS/XNtaolyyR59HkrqiN
	ma35yTUEc8dH2UIWITs7FF/l2E7Sme7zqnLBT5DEd6GwP1XQP1igIAqMMIl0SR8P
	2IFVTluPtlHgSVriNM/qbg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1736508727; x=
	1736595127; bh=xq3etOtcJkx79x1HGzYdICpQFtUlynF8xfRcB845rBg=; b=b
	j2eo7sxKBGiOyuG5VSyO4QsvgFm8IupzyJfO1SQz+EKOljd8x72bzI+cim40zY1A
	1wPo5f4zHWYTN0n8/jvhlk/huBwYgNM9+fxDLRgKZmuHhcQC9zxKEovaGvP7sn1T
	VGLN0WrpHu2ZroIiqfM0cmLSipcrfiIELRIFoXPjVKAzXNnx94y+L9FhDEZAjjgZ
	tVNF+VC5vSL5NmSsRNl44fy7p/GPPMfGyRi4oXzuPMXyBnYDP0j4rwwvEKOMit2j
	8Erdrr+GkghwKeyuZZsLH1RNKMLZU2r/1qdFf1qMK9sddwC7FGUDWDgaNmUvcWRv
	TfXJc0oXfm83oU7KpJwQQ==
X-ME-Sender: <xms:NwWBZ3dw_ZS88D90apO1WuSfECYMKa58SfPXAOdY8lJK8YE83wRD8g>
    <xme:NwWBZ9PonUqpuiw89KByKjI-LqWZRYZNAQ5BZpGNtxUesBIFciLunlTEvQbn6YzFl
    eAw5Go9IrnAMoPoJQ>
X-ME-Received: <xmr:NwWBZwgMTjjFDaVr6MYrKUmKKQ5XOCkEKLdRocTEER1Bff9LzPb4pqHVEPDkghv3oQWvosmOusSUW8j583E_EWwzylfm9QvKj3QZEsp-DIJP5A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudegkedgvdekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdej
    necuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrih
    hmqeenucggtffrrghtthgvrhhnpeffueeiudejvdekheeuvdekfeffiedvueelteekudeh
    jeetkeegvddugfdtgfeileenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmh
    grihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeegpdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhmpdhrtg
    hpthhtohepphgvfhhfsehpvghffhdrnhgvthdprhgtphhtthhopehgihhtsehvghgvrhdr
    khgvrhhnvghlrdhorhhgpdhrtghpthhtohepphhhihhllhhiphdrfihoohguseguuhhnvg
    hlmhdrohhrghdruhhk
X-ME-Proxy: <xmx:NwWBZ4-7TWTY_O1Lnpmns7_redTXc0feEmmQHTcTIonvF1iWZGd5fw>
    <xmx:NwWBZzsas7GFdJQDHDMGaXshh-ACuB4A6Mc69zOruwTty5wGvk9a9A>
    <xmx:NwWBZ3HJHWzGsumxW7rhSd15m7RE1HUaGHyStcAt5yssfPudqUoy2g>
    <xmx:NwWBZ6Pcc_Dnjc6cNBNvboKZ0lJCIqZ9fvic5Wit6RgdsIOo3nzvdA>
    <xmx:NwWBZ9I8eWp2_zY3r8_FQPqtxq9UFBg_ELWRIRuePI1F5Z6HI4_qSvva>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 10 Jan 2025 06:32:06 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 90535c23 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 10 Jan 2025 11:32:06 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Fri, 10 Jan 2025 12:32:03 +0100
Subject: [PATCH v4 07/10] gitlab-ci: add linux32 job testing against i386
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250110-b4-pks-ci-fixes-v4-7-6e4613446080@pks.im>
References: <20250110-b4-pks-ci-fixes-v4-0-6e4613446080@pks.im>
In-Reply-To: <20250110-b4-pks-ci-fixes-v4-0-6e4613446080@pks.im>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>, 
 Phillip Wood <phillip.wood@dunelm.org.uk>
X-Mailer: b4 0.14.2

Add another job to GitLab CI that tests against the i386 architecture.
This job is equivalent to the same job in GitHub Workflows.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 .gitlab-ci.yml | 2 ++
 ci/lib.sh      | 2 +-
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
index 00bc727865031620752771af4a9030c7de1b73df..29e9056dd5010f8843e42aeae8410973c825de54 100644
--- a/.gitlab-ci.yml
+++ b/.gitlab-ci.yml
@@ -66,6 +66,8 @@ test:linux:
         image: fedora:latest
       - jobname: linux-musl
         image: alpine:latest
+      - jobname: linux32
+        image: i386/ubuntu:20.04
       - jobname: linux-meson
         image: ubuntu:latest
         CC: gcc
diff --git a/ci/lib.sh b/ci/lib.sh
index f8b68ab8a6546802756fd516ca15a2c97223da5f..2293849ada3b45873f80e4392ab93c65657d0f13 100755
--- a/ci/lib.sh
+++ b/ci/lib.sh
@@ -269,7 +269,7 @@ then
 		CI_OS_NAME=osx
 		JOBS=$(nproc)
 		;;
-	*,alpine:*|*,fedora:*|*,ubuntu:*)
+	*,alpine:*|*,fedora:*|*,ubuntu:*|*,i386/ubuntu:*)
 		CI_OS_NAME=linux
 		JOBS=$(nproc)
 		;;

-- 
2.48.0.rc2.279.g1de40edade.dirty

