Received: from fhigh-a7-smtp.messagingengine.com (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82551399348
	for <git@vger.kernel.org>; Thu, 19 Mar 2026 05:33:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773898418; cv=none; b=qCO+NwXOR1m0KQzJ9XBvfM5wRSF16B7m7hnU7fPSaIXwPGRwfu9N/Ez6MLKEZhuq4TiIwO207GT4/j3eZg8bzo3qwBl6fVZXmJCQXT6kG0mSJcZA1E2nVVZ1G0+0Pt0JFqdpsY9qIgfFpg5aXLgco8YPe2H2J6i9G7jjydiKYSc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773898418; c=relaxed/simple;
	bh=AIEoBKHn5fHIseGde8DzC6ceFeHij7L80zSSoaraWi4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Q/TKC1mqTCK2thHy6agwux/7sHqE8SPM5Vwug4bRcg+AT/Tx41/rIi1SapTWpSmkf1/CqPf19jMdGWIv9Ut/lCSyxjX6Gzz/sLDf8c7FoZ63PAlmkcYLVvNbpB+G8qVnKslX16Z8rsiA9tU3RVRujVMygQf+K8hggoiDVz3ZgXM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=U5pI1TMu; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=S/135esj; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="U5pI1TMu";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="S/135esj"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 7E0C8140022F;
	Thu, 19 Mar 2026 01:33:36 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Thu, 19 Mar 2026 01:33:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1773898416;
	 x=1773984816; bh=Lz9gSTQ4ojhN8cad9+6SbAZX6cncf6hCw33cnAQRK/o=; b=
	U5pI1TMujNZy6I/f7pdU6RArIV2C1ke4/BvQuDGJToZizGQ9zNC+f669k5aiwAFN
	9GJqfSgMkIkwSpN+30Mc1e3o3HiTuY4fw5J1o/gkNANM70tW8YpwQrmoKJzW8aiB
	0i+9jMvjsd8bzhvk9UFclXTz5590OhyT/GP3RgGiTduNN43/QQNqpXKECfG1OJMj
	2gk2Cq+JP/zb9YCpheukfDeoNQbfmtzoZPEUvBoqRQxzpUGI8dgdi2y8eLvYERLe
	tfHafwGcsa9Q0KQ9/CYRhW2adpMzfvMvGSxjJArX5VCLdKFUJpYGi257Ckgnpwul
	xDSnUV6UL2bjCeOnQNWUsQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1773898416; x=
	1773984816; bh=Lz9gSTQ4ojhN8cad9+6SbAZX6cncf6hCw33cnAQRK/o=; b=S
	/135esj6LUvlZc4fIz2Mr85+QgPXXoleW6gROuPoEyQsVnS7WeQQY/rRT5VpnAC2
	EgK4vv+cR6gwpCwj9QowaHCuUHhJsYgb1JJuiiYta8BMJdKv9XhF4Jv911BNXHda
	JpAyKczkNKuy35uyzxNdr/pUu2ssOHe61PbPYV4Sst8wDLUItA1dkm/x8tOxEUOm
	31QDZxdz0AsrIHDiC8w6iGDLvYREPvVkAx499IAGdnrhekKESNOD7g+6kj/QP3EC
	sl8XzLQek6EEDbsmwLLMt+bLiUoLjsMcOrw9GHCoecx3hPtNNRpTuhtOu/6xo8SH
	KX6Ww2p74EWLg5+tnSf/Q==
X-ME-Sender: <xms:sIq7aUSGH15q0JCxfGLpwxyU_2DgNEaCKhqlBHP424rPTPpcAlV7JA>
    <xme:sIq7aTRtXqp9V9qeUzFuOv5BOXzuRWrvd6ks18_rJ2ji2qyT7NWcK26KwWZZRPtkZ
    ZqjECzW488siEv8UciiDz_lXeJ95W6n5aW-m2jcNuSIDOQbtLi58yU>
X-ME-Received: <xmr:sIq7aR70VllGKEozUUQ_JOGH99n2vuMyxfnQge-XGAAkMd6yiRHpWlU5WDtnS199NdNSuQ6aW0OtSfDvw9owCD8WGfK5FJY5A7jC_D-Jwge2>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdeftdeiudekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeffueeiudejvdekheeuvdekfeffiedvueelteekudehjeetkeegvddugfdtgfeileen
    ucevlhhushhtvghrufhiiigvpedunecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhmpdhnsggprhgtphhtthhopeehpdhmohguvgepshhmthhpohhuthdprhgtphht
    thhopehkrhhishhtohhffhgvrhhhrghughhssggrkhhksehfrghsthhmrghilhdrtghomh
    dprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohep
    shiivgguvghrrdguvghvsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithhsthgvrh
    esphhosghogidrtghomhdprhgtphhtthhopehphhhilhhlihhprdifohhougesughunhgv
    lhhmrdhorhhgrdhukh
X-ME-Proxy: <xmx:sIq7aX0-_TxkfV4nM7OmrSwub6jDf8Ij-WKgzejrrX0EgCtY4r0hxw>
    <xmx:sIq7aUAxbdV8Go9CwrE9_dnsnaMJ8yjEE_XFRU-heUnO6U4HYvuA9w>
    <xmx:sIq7aaO5LthlN47da8ZGIi2neDFYIB3ZuWyEY-ejMIS5h-VLrOd5gQ>
    <xmx:sIq7aRbXtMuZmg8kdM3xzjx-JBq3cVz-xzuSGBfQJezt3Wu2eNQZQA>
    <xmx:sIq7afHj3sE_1Xkvfgbrk_w25eCxHC_a2zA-m9mOw-P-4O9uTT6rHe-W>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 19 Mar 2026 01:33:35 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 3ea24a56 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 19 Mar 2026 05:33:35 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Thu, 19 Mar 2026 06:33:23 +0100
Subject: [PATCH v3 4/8] contrib: move "update-unicode.sh" script into
 "tools/"
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260319-b4-pks-build-infra-improvements-v3-4-82f5fb3edc3f@pks.im>
References: <20260319-b4-pks-build-infra-improvements-v3-0-82f5fb3edc3f@pks.im>
In-Reply-To: <20260319-b4-pks-build-infra-improvements-v3-0-82f5fb3edc3f@pks.im>
To: git@vger.kernel.org
Cc: =?utf-8?q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>, 
 Junio C Hamano <gitster@pobox.com>, 
 Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>, 
 Phillip Wood <phillip.wood@dunelm.org.uk>
X-Mailer: b4 0.14.3

The "update-unicode.sh" script is used to update the unicode data
compiled into Git whenever a new version of the Unicode standard has
been released. As such, it is a natural part of our developer-facing
tooling, and its presence in "contrib/" is misleading.

Promote the script into the new "tools/" directory.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 {contrib => tools}/update-unicode/.gitignore        | 0
 {contrib => tools}/update-unicode/README            | 0
 {contrib => tools}/update-unicode/update_unicode.sh | 0
 3 files changed, 0 insertions(+), 0 deletions(-)

diff --git a/contrib/update-unicode/.gitignore b/tools/update-unicode/.gitignore
similarity index 100%
rename from contrib/update-unicode/.gitignore
rename to tools/update-unicode/.gitignore
diff --git a/contrib/update-unicode/README b/tools/update-unicode/README
similarity index 100%
rename from contrib/update-unicode/README
rename to tools/update-unicode/README
diff --git a/contrib/update-unicode/update_unicode.sh b/tools/update-unicode/update_unicode.sh
similarity index 100%
rename from contrib/update-unicode/update_unicode.sh
rename to tools/update-unicode/update_unicode.sh

-- 
2.53.0.959.g497ff81fa9.dirty

