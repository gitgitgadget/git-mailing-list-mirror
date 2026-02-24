Received: from fout-a2-smtp.messagingengine.com (fout-a2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F28D036828B
	for <git@vger.kernel.org>; Tue, 24 Feb 2026 08:46:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771922766; cv=none; b=skjWopnJDNZHLHBswV/0ibmueup9Q6SHH53yg0+55J0inhThqL+0SIEV/gwtuIIBrYSKTvuDU+wqz17VFAZyZGCWwYaOsJYFLMyb9YPja8lUz/FBIcwtk7k7Kv86Nys+ondebg1ex73m5gpMoS7KaXJM/ixDfYiEMvS1qzmu/3o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771922766; c=relaxed/simple;
	bh=2VfG8hxTYHGDEz7YdTsnJ8/80PTc3smtV9CdO3zPtIU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=JgpiP63mMBa4N2zQAMoJPA9OiqfUoSur8tZo8pRZd2SHbJ6H4vUSxQzpY1/Ys9NKQWd8cDSKT7cLTSSZrDtZ0dhlO7hZeCVCWjRyihwmxhLL+qjXiSIfe3FfFza6eEcC32Ejf8zppxSZm0oCteI+uddZDmpmlUFospRzOXw5R9Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=X2F/wEKb; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Q0gCUoyk; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="X2F/wEKb";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Q0gCUoyk"
Received: from phl-compute-11.internal (phl-compute-11.internal [10.202.2.51])
	by mailfout.phl.internal (Postfix) with ESMTP id 42C6EEC059B;
	Tue, 24 Feb 2026 03:46:04 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-11.internal (MEProxy); Tue, 24 Feb 2026 03:46:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1771922764;
	 x=1772009164; bh=OiqGzEk5Ag90HmMsWjVg7JwfmqXNvix3PfGXbQAgk04=; b=
	X2F/wEKbsJ/8srH6yGLiR15VWZLoCnXjzTX4NZLyzluYy67pN5ZQ+pLinYmSJz2B
	Hqvcdpbw7IlSZn98CJTrieI6HQEeKKcuV1uVkP4uBjnKWCPLeoF7znnOP62gvByj
	CEv8IOoafBeMKvq4NrPThHuJWZDmee7ucvobGoYFoZHUiWA+PtJCJd4N3YGo01c1
	9BtvnQaip78zktdeSQalvrxzHuf2Rtx11ZFmEgsa+vaaw+/lXO1m5fZSwWa9tUFt
	p7fL6MZc8MoOvbpuiJMIhsULET2cZCbThLcSLjIFn3cBKM87Bawh4aXm9HiPZpZI
	WmSBWjnf7vVah48G/pmiMQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1771922764; x=
	1772009164; bh=OiqGzEk5Ag90HmMsWjVg7JwfmqXNvix3PfGXbQAgk04=; b=Q
	0gCUoykjAy3P1As/4aSwExgpq5k8o0xUNo3wqnpeQrh6AeqZNEsjFKHLQ96/jt8x
	O/cKyF3F7FlyMsPDb4Rr/Bib0fQeQDKDxb7plQ75+zhBLVTHsPf9X+9GzR/pqAbE
	Q+NyFr2xvKLJy5FKOJ0jP9k8mrHcGHlRlBbiwu8461Zzmp/2LwGt9dTjnDmLEvAP
	CEUr5rWNBmmJM36uroc3v6VaOt/HqQ4fvVL0gQKKy8n+9yRikGjZ9NYXvXeEse5T
	68ymBa/UZPeqV5PwR6Lm/6lTm6MurEVPFddfqSDZARxr8/f8ZopzPG49refNnbwv
	AkQbPb0NcJOoF+pNtH2CA==
X-ME-Sender: <xms:TGWdae1JVNjT82TJK-KyBphEYNICD3-SQ1uDzZw-Ul03lEuXBNJ95A>
    <xme:TGWdaYEo-eWdP0w_JQzIHk_UE4CI2LkITHMhZ305VW-ktX6YxcITt0-tFKFeYfgsL
    cwrDIjgJ9DU4PB6FZSNM90iDp855B8RV-7_MeA4FOMA1lZG5gNEvOI>
X-ME-Received: <xmr:TGWdab4yUGiiGZSQBt126c8HE7KbuTjHB01cQhbEascLeNJrI-YVU7TniZRS837sJaxvwpUigB86zthdIaBYg9bO2HDUJXfbesnLbC7xpFTIgg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvfeeljedvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeffueeiudejvdekheeuvdekfeffiedvueelteekudehjeetkeegvddugfdtgfeileen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhmpdhnsggprhgtphhtthhopeegpdhmohguvgepshhmthhpohhuthdprhgtphht
    thhopehsthholhgvvgesghhmrghilhdrtghomhdprhgtphhtthhopehmvgesthhtrgihlh
    horhhrrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdp
    rhgtphhtthhopehjlhhtohgslhgvrhesghhmrghilhdrtghomh
X-ME-Proxy: <xmx:TGWdaetcBNyDyt207Jjjoq_kdyZeZNUVSnsn2kl7wQ1xJZK8KAxUhw>
    <xmx:TGWdac7nO7kAq6hbhaRSYsFTVpKUvFn_q6lWrU2xuMxFXmehCAwB2Q>
    <xmx:TGWdaZUUQ1UD3pzYUH4vVlDLRy5GwwmHj-oANkSFUMt8rYzoff15eQ>
    <xmx:TGWdae-0VEn9AudzX4TtB38HcbpI0BaQ3IAEUoA4gOJZwpGvOgJFbg>
    <xmx:TGWdaf0MwaUMlFda8v_ggFx9065Dr8gUr-CRao6uJVIkQsMKxQWOCAhe>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 24 Feb 2026 03:46:03 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 15575096 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 24 Feb 2026 08:46:03 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Tue, 24 Feb 2026 09:45:48 +0100
Subject: [PATCH v2 4/8] t5400: explicitly use "gc" strategy
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260224-b4-pks-maintenance-default-geometric-strategy-v2-4-8657338c6fa1@pks.im>
References: <20260224-b4-pks-maintenance-default-geometric-strategy-v2-0-8657338c6fa1@pks.im>
In-Reply-To: <20260224-b4-pks-maintenance-default-geometric-strategy-v2-0-8657338c6fa1@pks.im>
To: git@vger.kernel.org
Cc: Derrick Stolee <stolee@gmail.com>, Taylor Blau <me@ttaylorr.com>, 
 Justin Tobler <jltobler@gmail.com>
X-Mailer: b4 0.14.3

In t5400 we verify that git-receive-pack(1) runs automated repository
maintenance in the remote repository. The check is performed indirectly
by observing an effect that git-gc(1) would have, namely to prune a
temporary object from the object database. In a subsequent commit we're
about to switch to the "geometric" strategy by default though, and here
we stop observing that effect.

Adapt the test to explicitly use the "gc" strategy to prepare for that
upcoming change.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 t/t5400-send-pack.sh | 1 +
 1 file changed, 1 insertion(+)

diff --git a/t/t5400-send-pack.sh b/t/t5400-send-pack.sh
index 83b42ff073..b32a0a6aa7 100755
--- a/t/t5400-send-pack.sh
+++ b/t/t5400-send-pack.sh
@@ -187,6 +187,7 @@ test_expect_success 'receive-pack runs auto-gc in remote repo' '
 		cd child &&
 		git config gc.autopacklimit 1 &&
 		git config gc.autodetach false &&
+		git config maintenance.strategy gc &&
 		git branch test_auto_gc &&
 		# And create a file that follows the temporary object naming
 		# convention for the auto-gc to remove

-- 
2.53.0.536.g309c995771.dirty

