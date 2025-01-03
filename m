Received: from fout-a3-smtp.messagingengine.com (fout-a3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 361041FA8F1
	for <git@vger.kernel.org>; Fri,  3 Jan 2025 14:47:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735915631; cv=none; b=uEytpTzoa9kAO5VWMJzM1vw4ISl+JxrGXAufURM6cAKfqfW3jVPgkUOaDNoQxQdgL24pIo2e8uM7RcYZUV9upzGFBLuxksgBnRtrEf7YtgdNNxr2RbR8nQi00jpU8b3HMTHckGXB1RsTYlofNA11piGsTfq/fGN2y2YXsNy8pR0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735915631; c=relaxed/simple;
	bh=ag0LjdPz1is6+wSZ6RpWja+1quW6UZ22PPZqgSzH9j8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=r5A61/2FlezyZTlBrMSjOg8tsfm+nQfVyVO44ZwkqReNZT6uh3Xno/6Acu5HysO9KkauWmCIlAGOT1ZYQIO7BzbVTELNM3nrEjpYpMRiOTR5JC95vapZS8YNLQPxoijw8pmmlY9NVs8Ocgpz96uc62mkqR78Yl0EIo/z4928Sl8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=hU+lqgei; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=DDQYm8+a; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="hU+lqgei";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="DDQYm8+a"
Received: from phl-compute-12.internal (phl-compute-12.phl.internal [10.202.2.52])
	by mailfout.phl.internal (Postfix) with ESMTP id 17C0D1380677
	for <git@vger.kernel.org>; Fri,  3 Jan 2025 09:47:09 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-12.internal (MEProxy); Fri, 03 Jan 2025 09:47:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1735915629;
	 x=1736002029; bh=Atwd77NT7D3mRyg8Qw4wyrfdolqj/IFeSJ1NkBdBIJQ=; b=
	hU+lqgeih3Kt+2/INJeR1Hf2GUgb1Mj5Xb/n+7cA4qba2g9KHnUtZ3UKGMRPs10R
	a3RjAhgfkZtNrOkgZ81LKLrmIAKk328RvRpsOc6ZLV7DXK+9rPMybCunMBxUd/vr
	mpmY3auo288fv0T94BaWLgqYEeAfaWyYF+qqZmHjRaZl/lSdXs0hy7HE6XUk1mIy
	F1AonoEI0oG4f6OyphCowiU4njz6OhfGmp2UVLPVtAOGv3zNT0GBYDJkCWBf4ff0
	1kPmU0GQTd5Pe6JhSGC/JvhncxAHBkkTNKbxiR8AhcIsVX53L26GK+/K/8CpAQ+2
	P2j4ykt5+/+NxecdUgFoNw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1735915629; x=
	1736002029; bh=Atwd77NT7D3mRyg8Qw4wyrfdolqj/IFeSJ1NkBdBIJQ=; b=D
	DQYm8+a3+luFsbLtFVf+fjeGP5mXEM0APMJT9sOgOqBxQcag9IvmyjUHCsC1hDgD
	FFKDhlqK+auYsUp6ilbsIblBCoTZom+ZDJPBFX/m0UKf9ZPUOaJOREbO/6lGfKp4
	VV7hP86p6aHo2NlnrYLt6AEu9iWGxUn4K17aFPhZwoY1ehNUYS31VVToVPCcL+Yi
	omNRQv/RmQ/6nlL5VvucQbxp+yHNGyBLHdsKCldx1ViDexDwnHdPlsvyLuzuwch9
	9VpsOuBkKMb/32fVrOnRdZsEMoCDUmuE9rOmMcZ6JzH2xGQxhPhcqKgcs3FADVfD
	x1e1ogWx5CgeMg3Q2QCOA==
X-ME-Sender: <xms:bPh3Zyjg8G7wJyj_JMw-83DDS2IS2wBgcrBJfrVMSMsO9h-VOn311g>
    <xme:bPh3ZzB9yUKbM9yU90Bsqd0A3heIUoM8TFuSqv5SkJDEPBJqYFSFhFmx89Tf3LP9J
    ZM1n4sEdEOdltJw_A>
X-ME-Received: <xmr:bPh3Z6HF43U3PWQydTL4JBcVj1GaORrLICvoAJNZB4IZ6tmpnV-XVK6KHspWHuA5QDhKrFVzmEJMjoxxOJqnMSx4F5he4-kiikTKVxfQtcuRZ9w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudefgedgieekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpefhfffugg
    gtgffkfhgjvfevofesthejredtredtjeenucfhrhhomheprfgrthhrihgtkhcuufhtvghi
    nhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnhepffeuieduje
    dvkeehuedvkeefffeivdeuleetkeduheejteekgedvudfgtdfgieelnecuvehluhhsthgv
    rhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnh
    gspghrtghpthhtohepuddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithes
    vhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:bPh3Z7Q32ehsKm0lBMAL-rjbKYG8L_hYudzfQXRfyE-P5ZzEQjyVfg>
    <xmx:bPh3Z_wzvPqBF5H5afZc5TGsOPonWu5S1qAd0mwM1hJlUc2gQx2iRg>
    <xmx:bPh3Z54mDc5ve8IzbWJOiHrz14DiE-QsGlfzI52s2QAbMzebd-Vs_Q>
    <xmx:bPh3Z8z2kJz1B0hFPTub3ZgJCYFdIfozaQ8pA8asJG0ks2t7SsSs9g>
    <xmx:bfh3Z4oF9OHBsNYFDZ31FDpHIconIV5aOp7nb-21UNzZAGImtPmtnPYb>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Fri, 3 Jan 2025 09:47:08 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 170e099e (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Fri, 3 Jan 2025 14:47:08 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Fri, 03 Jan 2025 15:46:43 +0100
Subject: [PATCH 06/10] gitlab-ci: remove the "linux-old" job
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250103-b4-pks-ci-fixes-v1-6-a9bb95dff833@pks.im>
References: <20250103-b4-pks-ci-fixes-v1-0-a9bb95dff833@pks.im>
In-Reply-To: <20250103-b4-pks-ci-fixes-v1-0-a9bb95dff833@pks.im>
To: git@vger.kernel.org
Cc: 
X-Mailer: b4 0.14.2

The "linux-old" job was historically testing against the oldest
supported LTS release of Ubuntu. But with c85bcb5de1 (gitlab-ci: switch
from Ubuntu 16.04 to 20.04, 2024-10-31) it has been converted to test
against Ubuntu 20.04, which already gets exercised in a couple of other
CI jobs. It's thus not adding any significant test coverage.

Drop the job.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 .gitlab-ci.yml | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
index 9254e01583306e67dc12b6b9e0015183e1108655..00bc727865031620752771af4a9030c7de1b73df 100644
--- a/.gitlab-ci.yml
+++ b/.gitlab-ci.yml
@@ -36,9 +36,6 @@ test:linux:
       fi
   parallel:
     matrix:
-      - jobname: linux-old
-        image: ubuntu:20.04
-        CC: gcc
       - jobname: linux-sha256
         image: ubuntu:latest
         CC: clang

-- 
2.48.0.rc1.241.g6c04ab211c.dirty

