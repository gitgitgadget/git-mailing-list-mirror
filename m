Received: from fhigh-a3-smtp.messagingengine.com (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7799A19C543
	for <git@vger.kernel.org>; Mon, 11 Nov 2024 10:39:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731321550; cv=none; b=OztHnc2CPTaqfxcrBe0TZBxfkVFw/e3v0KVzxwoV9cTI+oNG45zYduFBHLEbnXDjNQ0iiiS72Olrj/MCCGzAufZPK3ZgQnN6P6dEOE9vyWIKcxulXzdiURSXhWGf/GmHV3zPyP9GsIM+oQKZdjbUuH5ED0Ckvt9QuEm9j6+nlNE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731321550; c=relaxed/simple;
	bh=ghIe91RFyq+hQVaQ0Fy/hwkyygRAf0sTGhfAapHnEBw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=gpFJT0Pw4nYRxsrOm2gYmsTXt9GvoXwnJ7CZWLF+l2EcKGPUHnwRA55m+P4ulxJjyVGNygiT5e3+Nb+VTcob4mRahLOQW79R0tejn5e5WiYsmMjrKywgA8CdMzV3GeCpJWeDrHuHPdZEOEHK88IVZ8Fj6/BZGdJnhMaqxfCooz0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=fD4yeWpW; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=RC1f8aEm; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="fD4yeWpW";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="RC1f8aEm"
Received: from phl-compute-08.internal (phl-compute-08.phl.internal [10.202.2.48])
	by mailfhigh.phl.internal (Postfix) with ESMTP id A9A5A1140156;
	Mon, 11 Nov 2024 05:39:08 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-08.internal (MEProxy); Mon, 11 Nov 2024 05:39:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1731321548;
	 x=1731407948; bh=FCWHgBZqO7nD8zNNUyh/2dQqqAMmVSSq/7or+hvstOw=; b=
	fD4yeWpW3FL0hX6WGLD0BABIR4xBGHEPHcR+IpFPSeLq69kLMf/D1HzDiz/GspQ8
	1YyEPImOxtvNbIpZ0SGCuEm5P5Mfy102yE222YMGdutCuPBSjfVJiiVZpQA4fbca
	HGTp/+ofzpMvV7e8QkkOingx8RvGBe15Dofw8mIdeeGykXCo7NZTABuxC4M/e/8X
	Ey2SlA+CnaqSt/j4mVMvWYJPygDOOFX7xaVxq6Jn/LPQVCH8OBAAvdNiIgsR/7Co
	w6865v/wzS0wQtdC+ueq70YEejB5C7TNtuxJEFJOKJPe6D5+/yC+rSq+L9muhS5v
	IF0CHhNFSsLIcU1nTzEtIg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1731321548; x=
	1731407948; bh=FCWHgBZqO7nD8zNNUyh/2dQqqAMmVSSq/7or+hvstOw=; b=R
	C1f8aEmi/Ik9p85Gs0h1l/VQgyyWZ4/0Gdkil1LkS25+AQhCAGZeY4s/wqTjCGo4
	XycXdv5NUcThwAZOEMxDfSkj+95smXAUJs1nCEGHC1ZcpZIW3mwv9kE2CwnV+se4
	n0Jskm6HTPQF2z3xAbIuk+Um49xkZo4wld4TwQZTUyiqA4AjOnzH+3DDhTk37WkJ
	15CIfcovh79mJWs6YU1GHHbBqBNcRgQuVfED5O4xnETMhFrz04O1fahPaKdbt4pw
	LNlJwikOZxaCz9DmIIUvGf/b5u1uOitR5xE4rA3sW+VrlCgeCs3uTpUOpMd0eibc
	TbY1om+Hx9rfl0vsOIZ7w==
X-ME-Sender: <xms:zN4xZ1wtVYA_NgRHoveS6X_HzEoE-8Eek_G_X-K0uohsUwayjz5heg>
    <xme:zN4xZ1QUywskVixt0dXSs1712IWVhgjEckMabMMRKvDa6fWEgPIoi0abQSRREjjfl
    GUkcDGq5ip13Lm6Wg>
X-ME-Received: <xmr:zN4xZ_V3iwbvriT1ganWedKvFKe7igCg_pMBzIqH2gBdSN1trduwmGCUM0Onmjd_8xMe6siWk6hrNZZaaGZDrxNmXLiP9YUtrz3yZLikqW2mieuD>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddruddvgddukecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
    hsucdlqddutddtmdenucfjughrpefhfffugggtgffkfhgjvfevofesthejredtredtjeen
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepffeuiedujedvkeehuedvkeefffeivdeuleetkeduheej
    teekgedvudfgtdfgieelnecuvehluhhsthgvrhfuihiivgepfeenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepvddpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprh
    gtphhtthhopehrjhhushhtohesghhmrghilhdrtghomh
X-ME-Proxy: <xmx:zN4xZ3id52eAYka4epkd4Z-D9VK0UOUGnA2NMOAy9B2I1mK3mU03_g>
    <xmx:zN4xZ3Cg-8vPHruV0NmPpoV5hfxyL41yHEeaEtDLNKNkkRP-hf2M9Q>
    <xmx:zN4xZwKMbnTNgoR78f38JqlwG0f-JoObSdyMjrqTAwr0bgTODJyakw>
    <xmx:zN4xZ2D6UCWOEB9B3_McNRPobdLVUXgrqMflprpqK0Y1S6gzAz0sww>
    <xmx:zN4xZ6NLEBGkZda9kQGnBdlspPB7JDoBXqHtkC5_66U2LFSWbOM4mAFo>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 11 Nov 2024 05:39:07 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id f0ef606f (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 11 Nov 2024 10:38:32 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Mon, 11 Nov 2024 11:38:53 +0100
Subject: [PATCH v2 24/27] t: mark some tests as leak free
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241111-b4-pks-leak-fixes-pt10-v2-24-6154bf91f0b0@pks.im>
References: <20241111-b4-pks-leak-fixes-pt10-v2-0-6154bf91f0b0@pks.im>
In-Reply-To: <20241111-b4-pks-leak-fixes-pt10-v2-0-6154bf91f0b0@pks.im>
To: git@vger.kernel.org
Cc: =?utf-8?q?Rub=C3=A9n_Justo?= <rjusto@gmail.com>
X-Mailer: b4 0.14.2

Both t5558 and t5601 are leak-free starting with 6dab49b9fb (bundle-uri:
plug leak in unbundle_from_file(), 2024-10-10). Mark them accordingly.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 t/t5558-clone-bundle-uri.sh | 1 +
 t/t5601-clone.sh            | 1 +
 2 files changed, 2 insertions(+)

diff --git a/t/t5558-clone-bundle-uri.sh b/t/t5558-clone-bundle-uri.sh
index 3816ed5058d90118b4cbc700d65e97aa9c9987c0..b488b505b928ab6e58258360364ba53bec704eca 100755
--- a/t/t5558-clone-bundle-uri.sh
+++ b/t/t5558-clone-bundle-uri.sh
@@ -2,6 +2,7 @@
 
 test_description='test fetching bundles with --bundle-uri'
 
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 . "$TEST_DIRECTORY"/lib-bundle.sh
 
diff --git a/t/t5601-clone.sh b/t/t5601-clone.sh
index d0c18660e33113e64a293c695239a1c1a7975add..3b5285cfcf326fa02015d7a808b4312c62283487 100755
--- a/t/t5601-clone.sh
+++ b/t/t5601-clone.sh
@@ -5,6 +5,7 @@ test_description=clone
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 X=

-- 
2.47.0.229.g8f8d6eee53.dirty

