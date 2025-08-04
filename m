Received: from fout-b3-smtp.messagingengine.com (fout-b3-smtp.messagingengine.com [202.12.124.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA2E8246798
	for <git@vger.kernel.org>; Mon,  4 Aug 2025 09:40:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754300448; cv=none; b=PGKh6pQoCqS2M4quzgKM2aNIVvOykjuqcz7nfuklqO+MlBWDFBL8PESPdaR2SX//tbVq9d0MCruO2kIX99hQXD94zgUY+EqXWBo7+K5vWN7hH2jI2YHYP49vpyidzkcFfmLj2EmGcXHBs/3GnZj6PvxMQPdnmC0Eovp+jGv2wxU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754300448; c=relaxed/simple;
	bh=SeoQJ4WI3OQU20fHFP9N49hjpWsas2BP7qgIoe5D/Pg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Sbl4cxm3TmGIBW1lveFkl/gMOmnCIJmmiudiZTPxHwyk5M+RGI3pxs0kSUC5Dz6LAaC4G5YIGrhPd/k2zaDEpaoCe49HgAeuR7U3tS3XW4xsO5CL/uyaWbML5oakUMqhzAX6qmdO+zNyOo5yqZG7ZXhbmeBBz+WnnJz+PrnzyDw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=c8sfukXj; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=AAEIDpNK; arc=none smtp.client-ip=202.12.124.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="c8sfukXj";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="AAEIDpNK"
Received: from phl-compute-12.internal (phl-compute-12.phl.internal [10.202.2.52])
	by mailfout.stl.internal (Postfix) with ESMTP id DBD231D0008E;
	Mon,  4 Aug 2025 05:40:45 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-12.internal (MEProxy); Mon, 04 Aug 2025 05:40:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1754300445;
	 x=1754386845; bh=dp1ouZ5y7wPH1ULfCu9qH6y0R5A9gruQPLDjQkWlOcY=; b=
	c8sfukXjLC2F43JAZkYCK5jpP9dQ5i5mrqqxvQTix4jThWTdcCz6qCEQZCVajD/0
	6rCuR1SaGEVewIF7FIfPYqTjwSUR+AksZNUWtU4xyBTH8oPaUSC7oxOxxAC5Zz3a
	Nzp+H8LUR3ST/6Oyk519IurqwziQobXZjevVJY2LhwRSP7iKdRyglEVVyuUTdbmX
	4FkQQ5kqGzgW7Q7rg4e2/4l6tPBCNN+xgt9EOyfNJX82P6KMm+h4DN2P/fy2KSHq
	GydTcge9xhWIjenFZUyasmsjdnzvjFTlDJi1yNP0Y0bxju+ba4aDmW699ss3Bprm
	vMay5oyfu9TdyNSF+KKDxw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1754300445; x=
	1754386845; bh=dp1ouZ5y7wPH1ULfCu9qH6y0R5A9gruQPLDjQkWlOcY=; b=A
	AEIDpNKkwlygI8rf7m6A4igkTKDUvRsxaCvfhu4yQ1BcDfAuotP3lysLYKFBTP/U
	bgHrqEjC2lc5fI0LRMFxCeKv/ixFFyLd7JI7UHQFI02iD9gngxN/Qv670pg6DPnE
	LxlktwGt8ZSv7/ozDONKtBnHLaCLzUiJPWqM7qHoSL5RDByNXynfAB7dE/FsXh2x
	fX8Tr0QFH5Bf8ZztlnfEGjmJ7MEgNxyCH3A8104e5YRMR3WyWaJ/8JMB443UFN2u
	TX6w9z3ID42l528P3nLGaFsLEWoTtRRVD2q04RSXxleoupA1lm437JyF4yoLZcQO
	4yRZT5e1qQ1s8F9J85Gtg==
X-ME-Sender: <xms:HYCQaLAR6vj9SMLMfZQoe5N5gK28pDVxUL8j7ueTtAzhRSO1LBuyeA>
    <xme:HYCQaBueFmqsJ56Y63iteMiRAm7OIZ7kEW9He_duNTPvbDgMYTzVuo-gRdyJ075rd
    lBaNuwyHdA_w4o1yw>
X-ME-Received: <xmr:HYCQaIbca9BWmMzzqc-h2B8L6b1ZmDw6XlxU-H5_9zIAb75okmc_v2urlO1t9NTYztKxP3Nj52yQt6FRcjeGkkLvwdb6T_iS3C3JUHIHBnc>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdduudduleehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpedtieffuddtudduvddvveehuefffefgkefftdffleffhfffvddtjeffueejudetffen
    ucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivgeptdenuc
    frrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohep
    vddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnh
    gvlhdrohhrghdprhgtphhtthhopehsuhhnshhhihhnvgesshhunhhshhhinhgvtghordgt
    ohhm
X-ME-Proxy: <xmx:HYCQaMXGWw_5XiaVpb18Kf-wfz2hQTwTvua4UruaxIqCmwasFG8Sfg>
    <xmx:HYCQaE6L3K83NDxejcjobCfgk8RJ26u8DMlLfTZz7ZcUZmfTc9fqdg>
    <xmx:HYCQaPgWjPEe3ZtCHPsQNeMIeYqYxLE8kS-qtkt2UsQP47lqMitlPQ>
    <xmx:HYCQaDePuqMmIAzeF00QiPoFkGcNIZpYi9A-3LUhF5GCpO3gXeyy3w>
    <xmx:HYCQaFml9QRkV6PeUmaS40dXql91kJVknB36MnuOUCPGh96w5kylm6Wu>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 4 Aug 2025 05:40:44 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 348a2305 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Mon, 4 Aug 2025 09:40:44 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Mon, 04 Aug 2025 11:40:24 +0200
Subject: [PATCH v2 3/6] reftable/stack: fix compiler warning due to missing
 braces
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250804-pks-reftable-fixes-for-libgit2-v2-3-fef06209a984@pks.im>
References: <20250804-pks-reftable-fixes-for-libgit2-v2-0-fef06209a984@pks.im>
In-Reply-To: <20250804-pks-reftable-fixes-for-libgit2-v2-0-fef06209a984@pks.im>
To: git@vger.kernel.org
Cc: Eric Sunshine <sunshine@sunshineco.com>
X-Mailer: b4 0.14.2

While perfectly legal, older compiler toolchains complain when
zero-initializing structs that contain nested structs with `{0}`:

    /home/libgit2/source/deps/reftable/stack.c:862:35: error: suggest braces around initialization of subobject [-Werror,-Wmissing-braces]
            struct reftable_addition empty = REFTABLE_ADDITION_INIT;
                                             ^~~~~~~~~~~~~~~~~~~~~~
    /home/libgit2/source/deps/reftable/stack.c:707:33: note: expanded from macro 'REFTABLE_ADDITION_INIT'
    #define REFTABLE_ADDITION_INIT {0}
                                    ^

Silence this warning by using `{{0}}` instead.

Note that we had the discussion around whether or not we want to handle
such errors in the past already [1], where we basically decided that we
do not care about such old-and-buggy compilers. But the reftable library
is a special case because it is used by projects other than Git, and
libgit2 for example hits the above issue in its pipeline. As there is
only a single problematic instance of this issue we do the pragmatic
thing and simply make the compiler happy.

[1]: https://lore.kernel.org/git/20220710081135.74964-1-sunshine@sunshineco.com/T/

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 reftable/stack.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/reftable/stack.c b/reftable/stack.c
index 4caf96aa1d..3480ad21c3 100644
--- a/reftable/stack.c
+++ b/reftable/stack.c
@@ -704,7 +704,7 @@ struct reftable_addition {
 	uint64_t next_update_index;
 };
 
-#define REFTABLE_ADDITION_INIT {0}
+#define REFTABLE_ADDITION_INIT {{0}}
 
 static int reftable_stack_init_addition(struct reftable_addition *add,
 					struct reftable_stack *st,

-- 
2.50.1.723.g3e08bea96f.dirty

