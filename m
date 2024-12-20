Received: from fout-a3-smtp.messagingengine.com (fout-a3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 203252046A4
	for <git@vger.kernel.org>; Fri, 20 Dec 2024 12:23:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734697391; cv=none; b=H1FDxdL3fX8GPQJpKyjlXO1seDsiq31qG5zpoNsr/F7QW/++Lqbq4yDqN6vTxSBi0cd1MgmqIc1Lzxww+MXby7XWtT50xWs906AOikehfOaltsd8f0y986hw02538vZUnlXu4V2uTKJff6jhKuXuKW0d4eBNCCQLPP6zNvSJxuw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734697391; c=relaxed/simple;
	bh=BmIHvYmtLQ0YrlXEuCeU+f3RO/IIX7ECgByEvqOK62E=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=IVE5brSFBUt9F5fuk90AzryovcALRI0I1raYtNWlJ+N6vgvZFaNajapZbXBbPenEjfJ2nFF9FefuVEg7Ik3PlmB+/QXN+ociGbMln27e0XRDoY8J1kg/3WL46KZweXA9K7KSMHIQaeA/xyI08yEuD2R7Lgty2JtjUnvmqYB7OAw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=kDGmhAUy; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=5IN12MwG; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="kDGmhAUy";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="5IN12MwG"
Received: from phl-compute-07.internal (phl-compute-07.phl.internal [10.202.2.47])
	by mailfout.phl.internal (Postfix) with ESMTP id 113D31380227;
	Fri, 20 Dec 2024 07:23:09 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-07.internal (MEProxy); Fri, 20 Dec 2024 07:23:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1734697389;
	 x=1734783789; bh=6MJKtxu/GEX1NH87n/nbPAJ6yqi1SBUVJ3SPf2KN9PU=; b=
	kDGmhAUy9ug3R5Hci5QbObT1AiVfXvEVbBvZcQ1e7ZInpEk2XptIRS74wLrM7Qqn
	0AehRPjB7r/wl8fKkxuD5Nvj5sclaifFZNDw/JOMYP6Rln3FKez4rD30h65GQ8t5
	aTAw7Ml53aMJNbcVmvJZJXrrXnL5PgyD2qYO9a0m/iChUF9L7H/IilvNjv/hzpHU
	3SlwMMBtocyqy30+QX/HiQOwLat7pj2uVZmq6G++6wqLB3ZYrIYYEkKj2YORelpA
	zXrQZVhLDGSw/vYbuOqLMLKEQ7MfLnccdKl/2A05t2iFdyCAVEyA4kpYjsNELvOk
	+c7CMTJ3aKp7040XJp2D+A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1734697389; x=
	1734783789; bh=6MJKtxu/GEX1NH87n/nbPAJ6yqi1SBUVJ3SPf2KN9PU=; b=5
	IN12MwGPbz3HTDV2vTXFwAgfir7yEVc3VBfbmETa94NE5TsL/ZtiL5gTj5UoX1Rb
	hrGtxQRofu0P/qyxrm1nnDyVf0Lr/2P3dU2cAVBABbK4UHpLKg/Icv1CGuTWt61M
	KR+O9U3+y+FJqmiEwNGy/dt0JU3l+pag9FluOXwMovnHgqxmMR981tXSVwwT+cE1
	h+TIekGo7QbnYY/64+OmlzsZaPDEFX+pY9sf3HbgYs5Pf9q8kT7IAVbu0mXetDuk
	Sthlj9iFTAN0Do1MzctNah4peQa3vSgXzPLMxZ2CuQgrqN7+PI2J+mFhlee8yjZ7
	7CV1BtiNfBdgZLG1viDgA==
X-ME-Sender: <xms:rGFlZyjw2HILl2pc4fHfWCNaSAkvezOrUwFsOti7YpB8yRmXb1fSNg>
    <xme:rGFlZzBN-CpvusgbFlTqplJyCfw5gSvZ5wJWub4Mbz24KYe_9eRLIb694W9GOx9n4
    1k0BSFVMw_A3h2tPQ>
X-ME-Received: <xmr:rGFlZ6FVsiC1fooK343lw58W3hYWL9OOQN_8XMD9qwsZcGwFHTjt4bcAPEL80_kSO0t4nIqIEYPQpVFjvPaTKfUq6-V_RPGgfyKWwOwwNPlXU1s>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddruddtvddgfeejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpefhfffugg
    gtgffkfhgjvfevofesthejredtredtjeenucfhrhhomheprfgrthhrihgtkhcuufhtvghi
    nhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnhepffeuieduje
    dvkeehuedvkeefffeivdeuleetkeduheejteekgedvudfgtdfgieelnecuvehluhhsthgv
    rhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnh
    gspghrtghpthhtohepgedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithes
    vhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehsphgvtghtrhgrlhesghhooh
    hglhgvrdgtohhmpdhrtghpthhtohepphgvfhhfsehpvghffhdrnhgvthdprhgtphhtthho
    pehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:rGFlZ7SHLPjwqrzuznUVeLROC1e1ho7Ftn17t1IRoFO0CQ46RMjUBg>
    <xmx:rGFlZ_xDFRs_jVEo1s8rX7nrPW0UN9HMqJZ0bJxFTxpJxRPWZWInhA>
    <xmx:rGFlZ572WFirLR6mjor1PO94taZE504gcfWDwzXR5TZZO5RcI-ZCgg>
    <xmx:rGFlZ8yGuFtLipTlNOlw4TbB-VZCeDX0b3YCW_lXhDRPbqospAS7Cg>
    <xmx:rWFlZxuj7_LMjAoF0AEXbdjrhmO0_EgwNdYNAzjg3tYujwHcN6HRBkiV>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 20 Dec 2024 07:23:07 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id a75e2e63 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 20 Dec 2024 12:21:16 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Fri, 20 Dec 2024 13:22:46 +0100
Subject: [PATCH v2 2/5] GIT-VERSION-GEN: fix overriding
 GIT_BUILT_FROM_COMMIT and GIT_DATE
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241220-b4-pks-git-version-via-environment-v2-2-f1457a5e8c38@pks.im>
References: <20241220-b4-pks-git-version-via-environment-v2-0-f1457a5e8c38@pks.im>
In-Reply-To: <20241220-b4-pks-git-version-via-environment-v2-0-f1457a5e8c38@pks.im>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, 
 Kyle Lippincott <spectral@google.com>, Jeff King <peff@peff.net>
X-Mailer: b4 0.14.2

Same as with the preceding commit, neither GIT_BUILT_FROM_COMMIT nor
GIT_DATE can be overridden via the environment. Especially the latter is
of importance given that we set it in our own "Documentation/doc-diff"
script.

Make the values of both variables overridable.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 GIT-VERSION-GEN | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/GIT-VERSION-GEN b/GIT-VERSION-GEN
index 27f9d6a81f77248c652649ae21d0ec51b8f2d247..4273d5284008e2787854928163e31802bf8a3d27 100755
--- a/GIT-VERSION-GEN
+++ b/GIT-VERSION-GEN
@@ -61,8 +61,16 @@ then
     GIT_VERSION=$(expr "$VN" : v*'\(.*\)')
 fi
 
-GIT_BUILT_FROM_COMMIT=$(git -C "$SOURCE_DIR" rev-parse -q --verify HEAD 2>/dev/null)
-GIT_DATE=$(git -C "$SOURCE_DIR" show --quiet --format='%as' 2>/dev/null)
+if test -z "$GIT_BUILT_FROM_COMMIT"
+then
+    GIT_BUILT_FROM_COMMIT=$(git -C "$SOURCE_DIR" rev-parse -q --verify HEAD 2>/dev/null)
+fi
+
+if test -z "$GIT_DATE"
+then
+    GIT_DATE=$(git -C "$SOURCE_DIR" show --quiet --format='%as' 2>/dev/null)
+fi
+
 if test -z "$GIT_USER_AGENT"
 then
 	GIT_USER_AGENT="git/$GIT_VERSION"

-- 
2.48.0.rc0.184.g0fc57dec57.dirty

