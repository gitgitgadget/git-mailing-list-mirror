Received: from fout-a3-smtp.messagingengine.com (fout-a3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04BCD27F724
	for <git@vger.kernel.org>; Tue,  6 May 2025 14:12:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746540767; cv=none; b=Bi9/oirSStBymJemJwmtkk9A2Lpn4X6qZkd8SPq+IrWCzag1kRDu8vUWLqWc77CkVUoa5kTT5zyWoxKUeq+4x7dgga9rr5xDBtMheTaz9bpUietEdx3mBD0Oia4wgzgkbtIMqJPhyzql0gSCujzyrNtKqDT+FyuWiCdql65yQzk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746540767; c=relaxed/simple;
	bh=Dxl4F12S0AqAULVoIBZnSXJK741OVT5itaEeQEZsvik=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ngmj69n1oEfbceNfxel3mO1dyJibzqKXm2Zjf47hHWEPrESe9C1m0hYWmE+rYEUNxy5MWFxDrouD6Ul4Rm8qCz0AzQ5ksG8SIbSEWQMLBAEQy5WAySk/Bj5S3YCioykciPL1RNa7vuge/yC7YWvP9uPydf+jv7Lm7NYPZEdYMBI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=zcQuWSC6; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=PDPPlUvL; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="zcQuWSC6";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="PDPPlUvL"
Received: from phl-compute-11.internal (phl-compute-11.phl.internal [10.202.2.51])
	by mailfout.phl.internal (Postfix) with ESMTP id 1B29B138149B
	for <git@vger.kernel.org>; Tue,  6 May 2025 10:12:44 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-11.internal (MEProxy); Tue, 06 May 2025 10:12:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1746540764;
	 x=1746627164; bh=f/HIk+VuGff4a5KD3f6c7HUipP+E5+4wWKBwah+r49M=; b=
	zcQuWSC6jYzlOF/trpcG5nxrGDXsNlusoIOH8rq5vGBZF8TSfYsRxgBie0WOekWJ
	Bz2hr7dI4q3ZYhGLl3+fTeJ0WAA1cpqr7mPOsok6wvPmu40tTCrVcSifEQdZP/im
	h31DGfkuHRkhSTqZgx3oXyInj5IETjukTzfut9XQYiz/YQe/NIu8enG5aUVYgOxy
	Isnjz6ek0n2K7kGgcvOlBucgX5lzEks+mvUYS0t7wJ5JMMT1C+UkeaPwSl+7FDQe
	uaodBKwb4AK7DpQ+xJof5l3sQ8pPQtJZIONI5jc75eFuuK407lr/8rR1LUZfaPuo
	DEpfyUewQWG1rQqcfMOy4w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1746540764; x=
	1746627164; bh=f/HIk+VuGff4a5KD3f6c7HUipP+E5+4wWKBwah+r49M=; b=P
	DPPlUvLIxgZ4oM7HZRyEYlLInJcaOdy7P6VRs5pchhILq7SNWADPBYnHtciApnqM
	Q1CUnFQhfJeIeeOP1DkGZDaHfsyRDEdf48gIjHDQo+z0TpcNlF+V0rPizvZCXBLi
	YdaWZqlofFZagXypz6FYcw1ZwvXHL6Buz80CXlmqkokWjcSF4wma75O/ya8FnDBF
	NVtMjNkJpgb7jE1y4qos+XpoKYs2QEpS7X0uIamNAhCXXCE810Zu0P/zQlUiCx2k
	YZTFnanQNxgbST0Z7juZUc1NKCiMTefBZE4U5hYCOWyYujz+UU06IMYEAEJ54ZYH
	YsPiECtTrlF7oa1JUL8/A==
X-ME-Sender: <xms:2xgaaJFm_A5G4R-R2VhLowvXn2KEPl3SwfAs1MM8VAO0F4_ZsD_aXw>
    <xme:2xgaaOUNQLmI--aVuaf6mI30fxPlfBRQvWxoVcYbwAxnjmDFDPVSXQviWi-hb9mXv
    Xrcc9LZ3bwhdoxoCg>
X-ME-Received: <xmr:2xgaaLIAPsm7ulBlTjy_4gpAmcwUw9EHM_JaUKV7hxAUtcCfYdhxOcAA-aOEpLxEYQOT2g01xbS4WNh9uCv1qXdm5b9jqJ3HWO2kW7PK>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvkeegudelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpefhff
    fugggtgffkfhgjvfevofesthejredtredtjeenucfhrhhomheprfgrthhrihgtkhcuufht
    vghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnhepffeuie
    dujedvkeehuedvkeefffeivdeuleetkeduheejteekgedvudfgtdfgieelnecuvehluhhs
    thgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimh
    dpnhgspghrtghpthhtohepuddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepghhi
    thesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:2xgaaPGjAal6dS55sI2WgZT4sTgmxTAkfNujay5Em20IM0vuJmdLyQ>
    <xmx:2xgaaPUXbctqFQDB-sYDMwVSJESVc6aVo2x_oyOb6Vwq7RkZhlnS5A>
    <xmx:2xgaaKPtu60SSlg0oZ4hMcKFIwHcIR1aaTn0HFpftNu5RU0Ru5B83w>
    <xmx:2xgaaO0xZq9wewGrEIDAMrzFtbAZ1bFWnAB3yQV3ESg2_e6IiwOoyg>
    <xmx:3BgaaPSi-7ITs7TVfp2XkxINjU0NiyHl35njXst6DTJUshV6fmNSJjJF>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Tue, 6 May 2025 10:12:43 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 7a48f96f (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO)
	for <git@vger.kernel.org>;
	Tue, 6 May 2025 14:12:41 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Tue, 06 May 2025 16:12:35 +0200
Subject: [PATCH 02/10] contrib: remove "examples" directory
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250506-pks-contrib-spring-cleanup-v1-2-e6d5ddd79a72@pks.im>
References: <20250506-pks-contrib-spring-cleanup-v1-0-e6d5ddd79a72@pks.im>
In-Reply-To: <20250506-pks-contrib-spring-cleanup-v1-0-e6d5ddd79a72@pks.im>
To: git@vger.kernel.org
Cc: 
X-Mailer: b4 0.14.2

The "examples" directory used to contain scripted versions of some of
our builtins. These have all been removed in 49eb8d39c78 (Remove
contrib/examples/*, 2018-03-25), but we left a note in the directory to
make it discoverable that there used to be examples.

It is unlikely that anybody still looks at these examples more than 7
years after they have been removed. Remove the note and its directory.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 contrib/examples/README | 20 --------------------
 1 file changed, 20 deletions(-)

diff --git a/contrib/examples/README b/contrib/examples/README
deleted file mode 100644
index 18bc60b021b..00000000000
--- a/contrib/examples/README
+++ /dev/null
@@ -1,20 +0,0 @@
-This directory used to contain scripted implementations of builtins
-that have since been rewritten in C.
-
-They have now been removed, but can be retrieved from an older commit
-that removed them from this directory.
-
-They're interesting for their reference value to any aspiring plumbing
-users who want to learn how pieces can be fit together, but in many
-cases have drifted enough from the actual implementations Git uses to
-be instructive.
-
-Other things that can be useful:
-
- * Some commands such as git-gc wrap other commands, and what they're
-   doing behind the scenes can be seen by running them under
-   GIT_TRACE=1
-
- * Doing `git log` on paths matching '*--helper.c' will show
-   incremental effort in the direction of moving existing shell
-   scripts to C.

-- 
2.49.0.1045.g170613ef41.dirty

