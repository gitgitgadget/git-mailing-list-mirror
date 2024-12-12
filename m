Received: from fout-a8-smtp.messagingengine.com (fout-a8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEB893201
	for <git@vger.kernel.org>; Thu, 12 Dec 2024 06:47:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733986061; cv=none; b=Iq70OESox3aiwsjJEraqPmT23XRukrSL0tHsup2avxHeRgyDWV1LvFb0gGNRGXMfbvpCpguqf1ZBjL46QGsGttFi+wBaOsAwhWk4aLUioqCx6jrhuacGlvh3/LyEmuNARzNKYRKplexwkmW6Cu3vD4+TQrb9q20JDjsIApieVMQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733986061; c=relaxed/simple;
	bh=n0f1XCJp5sTGtpkm5VwIPJ9goKkSQQ+xmheNRz1SUJ4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=MPiM0HDMWUYFMc5uIuPAO5m5KYonwMzQH0vYbflkSHm9QwbbpwGFU4hp3rulNoIMhafbdrkN2pZEyhyeCDXW7j6AisA4/X1r3nHz19Bdb8PIFYjIJIleTISRRwZTpuqI2x9ZW4mOFHJCOR97OE9yfN0aCdp/mhZYJ7ZgWpF+wWo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=oa75INqi; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=qEoWdlqs; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="oa75INqi";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="qEoWdlqs"
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfout.phl.internal (Postfix) with ESMTP id D4A20138221E;
	Thu, 12 Dec 2024 01:47:36 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-03.internal (MEProxy); Thu, 12 Dec 2024 01:47:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1733986056;
	 x=1734072456; bh=nwaPGmVOuZKUpPKpKFaqliSlmVSJnrB/Ki7/Ot1STjg=; b=
	oa75INqiCb+wpbDuTwHEklt9OVQtZAbb6kh264p+2tFTBiUSloYjctnK/pww/dCn
	RtPiR958wSAoREy5SM9yIDMAw4aeXpGzw/zPiNs/tzXxaG/GDXLQl91DkPl/Z0hS
	Ae25dPGqSvQjlHVC9QU19JQMrIjQs1FC3ZWtupWBmIfTj7ipAmJCx2OOeUqFaFsf
	Tk/KlG2G75hSE9je+rKWx5j3MHOPtdYEiVZSc4/Zh0AcnBDwt2kKgWev4jTXzpL2
	da28I7w9aN9BBwY6EzFKdoQtDgassaj/ntRXllPnEgf2LAEIvpcav7M/dqdsDxAO
	xxlI0uBlsQ+0bte9H8EKcQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1733986056; x=
	1734072456; bh=nwaPGmVOuZKUpPKpKFaqliSlmVSJnrB/Ki7/Ot1STjg=; b=q
	EoWdlqsAUPvM0NzzyDCb7TY3XxIpssztKQiqeVnVz9ZaDmmysuO79J1rWufEgpSD
	vnmE5XPOMTbHnd0krIIFsEDSNvpEdLyzwSxMDg5aYYaZVJAalM719/Z3Uj/GGSsx
	PSuGRTPWtpjFDVzBFf8Snp4OIjQIjWVXuyu+M9nmZZpGE3Ws/rNlRCEJO79cULs0
	Ym1XLmcb9W+hA2ViI+VMnsjUbcn23qRcptqvKG2ItbNrCurFIng7DfdqMfidbd3h
	azqBCPtPy0+iboE7qUfVxlPuX0o2J0KLMA9hcDeKD9QzCjdyVP/4aEwjsWcMpE0K
	nGYfvLUMuApDc6fIfECeQ==
X-ME-Sender: <xms:CIdaZyxliL9DWBlpiBirARxcm-CRFlyj7OosO_ZYM-gzyr94rZTigQ>
    <xme:CIdaZ-S3fsxOA1MRFw9FqTgEdmULLYYrXr9QBzg99mMoQg19toBCm-kkjp9qXt_jE
    2LEMzan2e4p1snT2A>
X-ME-Received: <xmr:CIdaZ0V8uyAJ1aKvZhTf2X6dAe-ZovxQ2C-Jx8Y-yhr8h22tClx4-PklXXbPUvUZv4dNyDmiLnvyT4r37thYCtUWh1KusUwzpxfDzHTYTJAMCQbh>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrkeeggddvtdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
    hsucdlqddutddtmdenucfjughrpefhfffugggtgffkfhgjvfevofesthejredtredtjeen
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepffeuiedujedvkeehuedvkeefffeivdeuleetkeduheej
    teekgedvudfgtdfgieelnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepgedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepohhsfigrlhgurdgsuhguuggvnhhhrghgvghnsehgmh
    igrdguvgdprhgtphhtthhopehtohhonhesihhothgtlhdrtghomhdprhgtphhtthhopehg
    ihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepkhgrrhhthhhikhdrud
    ekkeesghhmrghilhdrtghomh
X-ME-Proxy: <xmx:CIdaZ4hT-QsqU0kqB2Y2dLnoaehhBs6XGHRgYnb6SWGiVzA-zSLX9Q>
    <xmx:CIdaZ0CF2EfTJNCcvmmmR_UliDR2sMFZeOz8kKag3DihwW4UmOpHcA>
    <xmx:CIdaZ5LYzvYbs1jUsobxbeju5HYOzPSXG-mryFFZxgMhLdmEG1UycQ>
    <xmx:CIdaZ7Dz2qF_98zi-nk53rB_ZPp8gXjwArr3sEq8XG-sucQW9AqPqw>
    <xmx:CIdaZ39I9bc9qxuaZZexSs5AXufYDb2KfcCjnLIMPsOkqiruOZxfdw6Z>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 12 Dec 2024 01:47:35 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id ec0267d0 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 12 Dec 2024 06:45:55 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Thu, 12 Dec 2024 07:47:14 +0100
Subject: [PATCH v3 1/4] gitlab-ci: update macOS images to Sonoma
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241212-pks-ci-section-fixes-v3-1-d9fe6baee21e@pks.im>
References: <20241212-pks-ci-section-fixes-v3-0-d9fe6baee21e@pks.im>
In-Reply-To: <20241212-pks-ci-section-fixes-v3-0-d9fe6baee21e@pks.im>
To: git@vger.kernel.org
Cc: Oswald Buddenhagen <oswald.buddenhagen@gmx.de>, 
 karthik nayak <karthik.188@gmail.com>, Toon Claes <toon@iotcl.com>
X-Mailer: b4 0.14.2

The macOS Ventura images we use for GitLab CI runners have been
deprecated. Update them to macOS 14, aka Sonoma.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 .gitlab-ci.yml | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
index 526ecfe030a43e0a5a83ddd35cb7c96d46ab2485..61c56ccac8fdc940075d91dd4cb0b54ee33d5199 100644
--- a/.gitlab-ci.yml
+++ b/.gitlab-ci.yml
@@ -99,10 +99,10 @@ test:osx:
   parallel:
     matrix:
       - jobname: osx-clang
-        image: macos-13-xcode-14
+        image: macos-14-xcode-15
         CC: clang
       - jobname: osx-reftable
-        image: macos-13-xcode-14
+        image: macos-14-xcode-15
         CC: clang
   artifacts:
     paths:

-- 
2.47.1.447.ga7e8429e30.dirty

