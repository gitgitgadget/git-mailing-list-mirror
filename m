Received: from fout-b4-smtp.messagingengine.com (fout-b4-smtp.messagingengine.com [202.12.124.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE124204F92
	for <git@vger.kernel.org>; Mon,  2 Dec 2024 12:05:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733141106; cv=none; b=Z0KrqrwbLavXMNXj86xs/aJWaDDivI5bHXjH0RuY1Qw30b+BGa56KX81qviL84z+33QOss88DQrC36HY+4SCcRQY24UkuN4n44x/ItmyAC+uOYarl5arBGFnEiEyw+qAqnVc8xiN6el9jhdHB/STmMOLSQQ1iC0kvycf/f7tVcA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733141106; c=relaxed/simple;
	bh=KB1iPDo37816jUbxvuR2sy93KKs96H5bcCpgcFLXcXY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=d7/jwuWRyziJqEqRXfR2vLdgRwET1QFzeM3PQpeSMBPLkve0Sy0FkaWC1gDptBdb9WiHeBOyAIm7uJo+kpllWoQL/9spCGM0cQOX5VH3T3+BVvfuWSYkGLRjE6J9ab3HZa/b8vEFdKX8cp1yOJs5XLTA08jpCOS/ry0Y9t8pDvE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=XWMavssJ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ZIi+HEjs; arc=none smtp.client-ip=202.12.124.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="XWMavssJ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ZIi+HEjs"
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfout.stl.internal (Postfix) with ESMTP id E1F531140183;
	Mon,  2 Dec 2024 07:05:03 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Mon, 02 Dec 2024 07:05:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1733141103;
	 x=1733227503; bh=a6Rz2IryRT8K18I8oNDuG+1cT2TDOOc6NtZ42HoqJMk=; b=
	XWMavssJltKY/XXQo0qSdLRrAUo9li3qCTuCuWLgu0NveKONKEdhxXkEZUNkZnqX
	MXuSBCFIm1O+WwPf524DfIbU9xJUBCKhgsWDzuOkz3en8D8qvGejyNvPQPz7Wt6I
	ZgJ+3ftAMZZcDQPDE3wfvIH4CYejWCgIitMNeCBggAVZl2PyL6WC1cASBZ4UPGeQ
	COD84sx0piRYgeCdtWSlenvivaAyu0P4NtBiNAoaeUi4XBMBK0p07TM7pCPbX5Xj
	rihkHKGBq98YkSkDytER9QUI5Tll2TxztyArVsZ5iLoKpMQYVG7C8RXh9b9Eyiwa
	9M7pQxMk8eIAf8TcddvoPw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1733141103; x=
	1733227503; bh=a6Rz2IryRT8K18I8oNDuG+1cT2TDOOc6NtZ42HoqJMk=; b=Z
	Ii+HEjsKao4SuP+hoE/3ZTskJ5bxlPnYO6WqIQDohciBsMECyxIMmx5bdmvkgMTw
	4oFn9xuuMi9I3y/48V0qMZM8pN6lQwbGVT/Ywa/rehCGaFlEd5Ir0llQMgCD3PVj
	xxyNSsFV83VFW2APwHSswdka9wNDaCgfkM5mKCVUNp3L9Dt5Jwux7Rcwcoacv0O5
	YupXr+qkEpsiAkKvEqWNGpilaB/+lbMtC5aB/AXxVt19ei01L3RN1wBsYMg9S+Kb
	RZT8AO+0z41o0rMTLbYIopdKM+XdT0t0dVRfFw10M8GSNzlu/5u26+UWzVNLvlP0
	U2+SQXVBaz5nu7LIYkV7w==
X-ME-Sender: <xms:b6JNZ9mAyZQvYJmI_b19agzihTYi5sCTzbf5uIr1gTUejI-pNJdxTw>
    <xme:b6JNZ43ukKFMck9pet5A2NwfLn9aBUE0lKRV-GHplaCEUhhUrNtIQu7yfWtRmf8T4
    IbvC6DOpq1flOhwmw>
X-ME-Received: <xmr:b6JNZzqYZCgctQ6drLBeGEme2T8d6cKx3YPV6uc8wGD-TUPIPgE8xbPggXNvk6wLbGYroOOxxOfypEp8PuYQB4HPcefNvFkQ2grO_bWRPj7A8blIYQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrheelgdefgecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecunecujfgurhephfffufggtg
    fgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhn
    hhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpedtueekgfehtd
    egleeukedvkefgtdfhfedvudeiueelheelgeeujeetvdfgteevteenucffohhmrghinhep
    mhgrkhdruggvvhenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfh
    hrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeefpdhmohguvgepshhmthhp
    ohhuthdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpth
    htohepphgvfhhfsehpvghffhdrnhgvthdprhgtphhtthhopehshhgvjhhirghluhhosehg
    mhgrihhlrdgtohhm
X-ME-Proxy: <xmx:b6JNZ9lY9HmKAjEXIk7SZrmqmPuuMXCGeYvn-rGNyHms4NX4yttTyA>
    <xmx:b6JNZ72OLMfn5GNn15WEvu4gCLqX8pH94MVlEAWwzAHMkGkSs0HkIQ>
    <xmx:b6JNZ8swWdNntIKBIhnrzu1DmYEaR0B9qsfgkeoPpgSRloL5emZL8g>
    <xmx:b6JNZ_W5kZblHkgrimOmOzfKav1rFJVszQFCJToIjlYtuI9Gji2JaA>
    <xmx:b6JNZ8zEzKuopsdLkRUSPJtrGKsqDEgSvX3kpzZcFpm2Jz3ubcuHUxJ4>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 2 Dec 2024 07:05:02 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 3bfa8ebb (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 2 Dec 2024 12:03:43 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Mon, 02 Dec 2024 13:04:37 +0100
Subject: [PATCH v2 05/14] config.mak.dev: drop `-Wno-sign-compare`
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241202-pks-sign-compare-v2-5-e7f0ad92a749@pks.im>
References: <20241202-pks-sign-compare-v2-0-e7f0ad92a749@pks.im>
In-Reply-To: <20241202-pks-sign-compare-v2-0-e7f0ad92a749@pks.im>
To: git@vger.kernel.org
Cc: shejialuo <shejialuo@gmail.com>, Jeff King <peff@peff.net>
X-Mailer: b4 0.14.2

There is no need anymore to disable `-Wsign-compare` now that all files
that cause warnings have been marked accordingly. Drop the option.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 config.mak.dev | 1 -
 1 file changed, 1 deletion(-)

diff --git a/config.mak.dev b/config.mak.dev
index 8eca7fa22823b46ebdf02b73d53031784fd5ba2a..0fd8cc4d355ebb7428e1d8258154926dedf8827b 100644
--- a/config.mak.dev
+++ b/config.mak.dev
@@ -53,7 +53,6 @@ ifeq ($(filter extra-all,$(DEVOPTS)),)
 # These are disabled because we have these all over the place.
 DEVELOPER_CFLAGS += -Wno-empty-body
 DEVELOPER_CFLAGS += -Wno-missing-field-initializers
-DEVELOPER_CFLAGS += -Wno-sign-compare
 endif
 endif
 

-- 
2.47.0.366.g5daf58cba8.dirty

