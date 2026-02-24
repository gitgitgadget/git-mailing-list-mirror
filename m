Received: from fout-a2-smtp.messagingengine.com (fout-a2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB168368275
	for <git@vger.kernel.org>; Tue, 24 Feb 2026 08:46:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771922772; cv=none; b=VECnZX2e4fuDuinvRm4eRB2ApV5iKDxVwwdT+tEre4I5wsCDuatJUapUElXs+oOqwWGiRLFWLrl84YCWDKfrUD99uczqZL4ejQTCvhf3esM8fl5WAHllFXwhp9PnhN5HvxbAoclalvkBrvw6KFYqO4jfupNJb+3ZaYrU2HBXQ8I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771922772; c=relaxed/simple;
	bh=B2nmYfUCxOnI/NZZ6cfQ4sP1OXKCyhSO8jSZWfK5b/Y=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=bB674fUOaMgCivASutOfta/Kjwb/dKKMpP1nPvkEkiVUzYxPf3HZKSGQeX3+sWqXfBl7wTiqmz6MVbOC4CCOo7TnbEZ7VQboTUbfY8V87Km5ALhUU9/CzJ3MiWj5kjyhnUQ8fdaW6+u7SN82scqHcLX40FhnnCkVPkqpLY9QQOQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=bel07maf; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=FxBkhqEi; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="bel07maf";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="FxBkhqEi"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.phl.internal (Postfix) with ESMTP id 5EC3FEC0597;
	Tue, 24 Feb 2026 03:46:10 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Tue, 24 Feb 2026 03:46:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1771922770;
	 x=1772009170; bh=UdywW1x+k3hamWS0XVGGJSsdflkN1WWkDRl8HlQk/wE=; b=
	bel07mafMmAHCI2o/OHRjxLeJoYUyzMcXtRnymJTwKzQyfRkscjhpwyzY7FZf32U
	85F0JHITE/uer/pOuX9uaI9QWktzSKqdwk7U/8y/QcNGSVt1yI7oflf1BzZvghid
	76tc25aXS6bW/bt7lpwm8HKm3PReAplBDlId/EcVzvAcrypKsTI3oi0RVC9/5uNm
	1H9eO/jNhyLznX3VF9f61Q3hTgmFxV67G3BGo9yHW5BvSI8bDqe8UC1gfiVuboW6
	e6zy/F0ahGf8aB4KKLZ7rnf3l+AwKtnofPkjMUCQUlXWmx7SWIu2URpWu41FUvFS
	2K8IJa3/IrBkTHktXhe+0Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1771922770; x=
	1772009170; bh=UdywW1x+k3hamWS0XVGGJSsdflkN1WWkDRl8HlQk/wE=; b=F
	xBkhqEiCFd+sNk1nymGgMGdTJwwE3sGhjESX1VhCUgHx2vyYlOP0cS/ZxxxF67de
	xEDJDLostiVFG0DxbQLMMyHLL1am6qwobOIAjnsLXNRzbB6HxggZ7hhmPVz2fxcH
	8StWtP+FqfJwxE9ifBnO0QBz4hrodnGjEhB0PaBa4FoH5et/CCeQPWFlBZxWQz6x
	25tJy1AVyX9ZSxOJdZrVuxWBzCkwz+4sQRj8pz/PqZv+vm+RfIhTn3SkLW+EO4hG
	xZF64/hUSZQLi8o2+4dCJS4N50SXIxy2ZytUibdGePevIzlaYJPxWZpHUfNEVRSR
	H+f1Tdov3mauzZ026c4vQ==
X-ME-Sender: <xms:UmWdaYxHXcW-lkzKrR1BBo-Uk4vmyO5QbCEds-yL0JpKJgr5JWN7fQ>
    <xme:UmWdaTT_PZcHivk2dPlyasoGjxlg6dRCMJ2sn6M-CkVOLxE4iMSpSxLsAwCpPrCiM
    i0iFsUk1uqveFcdGxP6iOUQO3Px3s2d8lznIslooorf1XBpfaKHRg>
X-ME-Received: <xmr:UmWdafVuiOIpECVYd4AZhirlXpIV0swS2a4B4Jt7MmLLCNH4doEO6LNQlhBRUwd5Yg1mkZfCeBxxe74IdLD2TkTID7BYtZ8Ztjc0fMbyAWDtXA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvfeeljedvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeffueeiudejvdekheeuvdekfeffiedvueelteekudehjeetkeegvddugfdtgfeileen
    ucevlhhushhtvghrufhiiigvpedunecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhmpdhnsggprhgtphhtthhopeegpdhmohguvgepshhmthhpohhuthdprhgtphht
    thhopehmvgesthhtrgihlhhorhhrrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrd
    hkvghrnhgvlhdrohhrghdprhgtphhtthhopehjlhhtohgslhgvrhesghhmrghilhdrtgho
    mhdprhgtphhtthhopehsthholhgvvgesghhmrghilhdrtghomh
X-ME-Proxy: <xmx:UmWdaVZqw6Bp83rBEx8K6IoLpoDCrnuKLpiJ0zRLA4Wl3dpd2ImMaw>
    <xmx:UmWdaV3ARk3Jr5RxfKYRXYvE7Hpawef7VPXBn7pc8cOHTthgIAl4DQ>
    <xmx:UmWdaXjDRcIirpIFAttfCPxPCiBz9WBRWaHHACN9lW6XdHOSmSD-PQ>
    <xmx:UmWdaZYd3S_wmWcht-xAWfa916O6Vx6hvy7e51ANJrRDWSlaqJlt5w>
    <xmx:UmWdaQTyvPfpoyEeuEakRdIw-3lwH8aOS6JYw1dGlZSYnY6xQ-g6-7v3>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 24 Feb 2026 03:46:09 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id e9377556 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 24 Feb 2026 08:46:08 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Tue, 24 Feb 2026 09:45:50 +0100
Subject: [PATCH v2 6/8] t6500: explicitly use "gc" strategy
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260224-b4-pks-maintenance-default-geometric-strategy-v2-6-8657338c6fa1@pks.im>
References: <20260224-b4-pks-maintenance-default-geometric-strategy-v2-0-8657338c6fa1@pks.im>
In-Reply-To: <20260224-b4-pks-maintenance-default-geometric-strategy-v2-0-8657338c6fa1@pks.im>
To: git@vger.kernel.org
Cc: Derrick Stolee <stolee@gmail.com>, Taylor Blau <me@ttaylorr.com>, 
 Justin Tobler <jltobler@gmail.com>
X-Mailer: b4 0.14.3

The test in t6500 explicitly wants to exercise git-gc(1) and is thus
highly specific to the actual on-disk state of the repository and
specifically of the object database. An upcoming change modifies the
default maintenance strategy to be the "geometric" strategy though,
which breaks a couple of assumptions.

One fix would arguably be to disable auto-maintenance altogether, as we
do want to explicitly verify git-gc(1) anyway. But as the whole test
suite is about git-gc(1) in the first place it feels more sensible to
configure the default maintenance strategy to be "gc".

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 t/t6500-gc.sh | 1 +
 1 file changed, 1 insertion(+)

diff --git a/t/t6500-gc.sh b/t/t6500-gc.sh
index bef472cb8d..ea9aaad470 100755
--- a/t/t6500-gc.sh
+++ b/t/t6500-gc.sh
@@ -11,6 +11,7 @@ test_expect_success 'setup' '
 	# behavior, make sure we always pack everything to one pack by
 	# default
 	git config gc.bigPackThreshold 2g &&
+	git config set --global maintenance.strategy gc &&
 	test_oid_init
 '
 

-- 
2.53.0.536.g309c995771.dirty

