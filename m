Received: from fout-a8-smtp.messagingengine.com (fout-a8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51142239594
	for <git@vger.kernel.org>; Mon,  3 Mar 2025 20:45:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741034702; cv=none; b=lXUeMBRaP8dvqybQZ+OFV4Npjw1y19zCIOZ0vuUiJ6+5IoUMzafMLjnVqB0YZubyBcBdMzXqWXvnAqv8A3SaWmJd/l63eC9hd1ToTe5Li3qcztNqr6V+yMBiDEiQqdXx3z9ZuCZzawkZKgGuGprSm0FyxgkgCQCYMze+FQQBkis=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741034702; c=relaxed/simple;
	bh=ah3IyVvFPpmFE3T8VCXWOpiiZrKSBxua7lC82muUMeo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lXal9EBQd3p2dez1nTjNISMTDs5ZOAqSkjHOhsV3jdIKKUbrJ935AAQBDf4CF8idI6P3TH9/pvYiKVXcgIc2whMLQ+bX5biJyjQXHEm9xs3sjy+vva75bMh1d3ASo3G80w/Jilr+pDCPLAatICqVcH56p/Ix05OYshTgdbU8gHI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=j1jSJYt7; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=heXHxXxY; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="j1jSJYt7";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="heXHxXxY"
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfout.phl.internal (Postfix) with ESMTP id 9F4731382C53;
	Mon,  3 Mar 2025 15:45:00 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-03.internal (MEProxy); Mon, 03 Mar 2025 15:45:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm3; t=1741034700; x=
	1741121100; bh=9+MIOi1V0TlfIa8DDpLE1bIkoF/qtsC5DxvQKWYBFzo=; b=j
	1jSJYt73yYPU73W5ql0/6DikTGiP/cmaxMb7Bohs2UwnChxoVE9kHlBou2v9BASX
	1hGxrlRrCu+TJCVKCzRoFssJnyDO3SsqBma4i2cPA4AY0rd7t19MsWNKjiGt0xqd
	WDgr+ifCcUXmsSuFHDQw63msEPPzlr1rnfnNVo7uW14+iqHGiAgnKWGVMJ1ca6V9
	oY5lmBAdi0KZXWzaO6VmGw2S9a+iXbMowWxGk9DyCz8OOOc6EYdLLpfuINkSUyuS
	ifDJcTJPgmbGyytPZJS/hjuwmlTz94u1bVsCF8IcMaTfDRRWV+fslgrnLoM42Zsa
	VAWNFTCwyKu8SkySeLFew==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm1; t=1741034700; x=1741121100; bh=9
	+MIOi1V0TlfIa8DDpLE1bIkoF/qtsC5DxvQKWYBFzo=; b=heXHxXxYkB5k3AUpC
	U/BhG1uRACJJDCx3eiYLXZHncBfF36orup8uJRYFJSKKTPZva1wLShyXxy7Ok0eq
	N0IjLSYwK1gGN1+rwmJRBCuwhvnih5I2j+PIkdFzHdUR1MH/R6f291iycWiGpGft
	eI/J3chAX4FFzvbv5VJxuhqzgZsLjI775LaC/EYFzZJQ3uaOvM51oVsM/nNVW5Q0
	cueRGz4NjV7729XXDPgoQKrUUKCqhBd+6/RtnY0M/EDIHluhojbUNdK8i0X8+10z
	w9cVVtYrUVVtFaPQA3KDM3MddmnrL0+vXpVHlndWmegLK8cWooXSD15LF2iAzd5n
	73LKw==
X-ME-Sender: <xms:zBTGZ0ztJIUHPrZQ9uGMFAYJkvXUih0mqArfqotHDUr6Jrc0xyVqOA>
    <xme:zBTGZ4Rt8c8AtU_1SNUhyCMU93KX-uF8F1VYEBPgk1NeMcrw9tBy0Mb61wCBXIl2o
    ZrO5Ww--kjmX4V4bw>
X-ME-Received: <xmr:zBTGZ2WRQNcoTwRt1P19K8z3TETH32U4CAY7sgp6AmVdrdgWvzSg3dz4ke1jIgAeGKcqUPmYLUaJn6CFJk6iRQw3_XI>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddutddtudduucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpefhvf
    evufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpefvohguugcukghulhhlihhn
    ghgvrhcuoehtmhiisehpohgsohigrdgtohhmqeenucggtffrrghtthgvrhhnpeejuefggf
    ehieeugeeuheevgfegudetheetuedvveeuueeileeuhfeigeefkeekieenucevlhhushht
    vghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehtmhiisehpohgsohigrd
    gtohhmpdhnsggprhgtphhtthhopeefpdhmohguvgepshhmthhpohhuthdprhgtphhtthho
    pehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepghhithhsthgvrh
    esphhosghogidrtghomhdprhgtphhtthhopehsrghnuggrlhhssegtrhhushhthihtohho
    thhhphgrshhtvgdrnhgvth
X-ME-Proxy: <xmx:zBTGZygSHo2il1AHqJwDmlz8CbFK4LBwGdf8icXho_r6ZTcz3nPadA>
    <xmx:zBTGZ2BvQcMuYIJ9IChtPU6dX-kybdEDxyRFwXopU7oQWuCGZuN3Ng>
    <xmx:zBTGZzJIU1rYLPZkE26WDKtw152a1YFc5dL38hd0HXhmmtUCpyZRGQ>
    <xmx:zBTGZ9A6CKVknlhKqTWlkcPG5yxQD5Rl2ZAH-WYOdko0KyblNudrwQ>
    <xmx:zBTGZxPCdcEUdWEQt_RGs_kHVN7XsbqQw5i4fOx5wGg_8bmWws-fFWcj>
Feedback-ID: ia13843cf:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 3 Mar 2025 15:45:00 -0500 (EST)
From: Todd Zullinger <tmz@pobox.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	"brian m. carlson" <sandals@crustytoothpaste.net>
Subject: [PATCH 10/34] technical/partial-clone: update reference to rev-list-options.adoc
Date: Mon,  3 Mar 2025 15:44:08 -0500
Message-ID: <20250303204443.360595-11-tmz@pobox.com>
X-Mailer: git-send-email 2.49.0.rc0
In-Reply-To: <20250303204443.360595-1-tmz@pobox.com>
References: <20250303204443.360595-1-tmz@pobox.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Signed-off-by: Todd Zullinger <tmz@pobox.com>
---
 Documentation/technical/partial-clone.adoc | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/technical/partial-clone.adoc b/Documentation/technical/partial-clone.adoc
index bf5ec5c82d..e513e391ea 100644
--- a/Documentation/technical/partial-clone.adoc
+++ b/Documentation/technical/partial-clone.adoc
@@ -85,7 +85,7 @@ See "filter" in linkgit:gitprotocol-pack[5].
   server to request filtering during packfile construction.
 +
 There are various filters available to accommodate different situations.
-See "--filter=<filter-spec>" in Documentation/rev-list-options.txt.
+See "--filter=<filter-spec>" in Documentation/rev-list-options.adoc.
 
 - On the server pack-objects applies the requested filter-spec as it
   creates "filtered" packfiles for the client.
-- 
2.49.0.rc0

