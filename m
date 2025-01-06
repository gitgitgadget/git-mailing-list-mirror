Received: from fout-a6-smtp.messagingengine.com (fout-a6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A84AB1DC994
	for <git@vger.kernel.org>; Mon,  6 Jan 2025 11:17:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736162224; cv=none; b=cQFDUKbeaGBgN61Ssty9erfrxy+E2BToxNPMvTC1gMpsmFLuAisjoHiGNVWXMKG46CxEjR3nwqRD78UzzrS8BmHoaOs9ns9qHwvD71JY9DfZU23LIcgX6+o1iHbQf+er82xFhirflGQaoBGWED+Pcg1lI+zJib6mPz6vPWezVrc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736162224; c=relaxed/simple;
	bh=LidPJI6V9UmFgwMJw9iM67Ikb83ruK0/SpwILWhwL/s=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=IWrAItY30PKCXWjjQnWwQLsPd5XvPsc6NLqUUP0/fDGfYZ5wNWlIpHy5TaLC5YJ7/lm37T5OLRyr9ZPezJ6p26P4m7xjkrWNbbMmkRDSfUDQ1jSzteEx9ShQ+HERU+4hkvRHZue5BViz6OmQo+9gIvaOUxDNEuLXU2MPSfr9V1w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=ca5VBkB6; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=YfJFLn+k; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="ca5VBkB6";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="YfJFLn+k"
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfout.phl.internal (Postfix) with ESMTP id 5345E13809DC;
	Mon,  6 Jan 2025 06:16:59 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Mon, 06 Jan 2025 06:16:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1736162219;
	 x=1736248619; bh=xy8iUdpn3FdyTuKqG/1BpLHGxE9iZc8tfbGxMAfX/xI=; b=
	ca5VBkB6tvma0hpsSWJjeGLF1GpoFmyWmvvAhTZuSTXub2JtGi/s4GT9EH5E4Qag
	kFEhhl6ON5dAXTH3zxPZDgB9wKlp6S7k803YG2FyEbZIENbdlWdxNK8ScuLR9pOF
	HgfPXyXIgghhQE4d0BPqm8Er/ql40RiNA63VU/NNSptQLKX80TuzJ9r8uKkI9plq
	X/QxxwLXSkNzyDTtT+WWh25AZvzS0FEcP8m8YsCLJfCiyZLVFiED4FWyRdEQXGJQ
	5Xn/YysQUbCwJx9zFO/m1cwUXoj0v/K4nZfAwyNKPj2RTJsZBVaU/56lzGU1gDMx
	2gXHpQm88huvZwI3rerpLw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1736162219; x=
	1736248619; bh=xy8iUdpn3FdyTuKqG/1BpLHGxE9iZc8tfbGxMAfX/xI=; b=Y
	fJFLn+kR5i3K2XOx5zVltxwk3d+fNZs6dx0EtGCM2fjT/MD9wf3j/6z9qled3/wI
	iiMdd9440uEwpdfQ061Dps4aGHGcMIc0So0blHCPycDXLzfbbBakWavebmvkidXx
	RPuWv8OBXQO3zXEtlpOBYcnxbqy0tUsa+lBxy4wYoupaV9j60lzB9HwZx5UEFAkv
	08vTqezQ83Bw39xxEg9hGrl/typ6elCNFMnDDs7hLNQtGjEB7awiWCZ4ZJleFema
	p4ICm/RPx/0xg2sj6XJYdQmVFeX0p6XUcPIPb5aOW7pIrikhJWczTyhqf9cXu5PI
	rbI7SjaiTTNhyCWBSsImQ==
X-ME-Sender: <xms:q7t7Z0S7ty6iYuqEM2QM_NndsNhpE-WfOo20_WlDCXM7uoKGeZ2q9A>
    <xme:q7t7ZxzwH9meeQ4hU_LpC0nrIJmRSYTSFb7BFy4eEzbLf3Dcwokc5OuDCuqisyDyW
    VmCLbSCBIo6pA1Mng>
X-ME-Received: <xmr:q7t7Zx28gr3BqdvpfZZfCy6qA0GyfHN9YdSn8fEA8ksKFMOwKYxwz_3JmsUHAT2FSjZM9nsVLiDzHGRDnc7h9GAlIrr7k18GQZ2KpBr4rg_LQg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudegtddgvdeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpefhfffugg
    gtgffkfhgjvfevofesthejredtredtjeenucfhrhhomheprfgrthhrihgtkhcuufhtvghi
    nhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnhepffeuieduje
    dvkeehuedvkeefffeivdeuleetkeduheejteekgedvudfgtdfgieelnecuvehluhhsthgv
    rhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnh
    gspghrtghpthhtohepfedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithhs
    thgvrhesphhosghogidrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvg
    hlrdhorhhgpdhrtghpthhtohepphgvfhhfsehpvghffhdrnhgvth
X-ME-Proxy: <xmx:q7t7Z4CSS_uIA7IQVtj6syHPk-N9Cw97QmRHWuaJgeIVFEh95nrb1g>
    <xmx:q7t7Z9gkEC-2L17UdLo-YLWw0XGD872ldOWNSXFH-EjVFFhu7OtuSw>
    <xmx:q7t7Z0pcAFP262-xkWLhSzCnJANpcq3Ju4oRb9m-YGVKjyseh9KyMw>
    <xmx:q7t7ZwhZ51x9z9UQ0MOZAbnxThJasrUTA_dNrI0RIiu-fSkm72WeoQ>
    <xmx:q7t7ZytBuB4QEuAnzCSFA8ngu5qEwPS_hQKjJa1YABR-EAJfVB3XIqJY>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 6 Jan 2025 06:16:58 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id b44f913f (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 6 Jan 2025 11:16:57 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Mon, 06 Jan 2025 12:16:56 +0100
Subject: [PATCH v2 07/10] gitlab-ci: add linux32 job testing against i386
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250106-b4-pks-ci-fixes-v2-7-06ae540771b7@pks.im>
References: <20250106-b4-pks-ci-fixes-v2-0-06ae540771b7@pks.im>
In-Reply-To: <20250106-b4-pks-ci-fixes-v2-0-06ae540771b7@pks.im>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>
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
2.48.0.rc1.245.gb3e6e7acbc.dirty

