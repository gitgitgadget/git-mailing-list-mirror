Received: from fhigh-a3-smtp.messagingengine.com (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3B1323CEFC
	for <git@vger.kernel.org>; Mon,  3 Mar 2025 20:45:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741034710; cv=none; b=Nbt5YcCxTl7+qJlfxuXSAI+7Gy1dYxzfFiA7mG8F1IWM4SRJ8NTimdTH4cjcJ6e0X3mo5qef0CG6Uhx8xxQVr3k4ahZeemNV6Oo7v9tvsNIwthQ0AerE2XSPCVkwsgxsF7QZIL3lYlxuM47Fviuk1Mw1BgG/HK3ynv5OlrWWuvY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741034710; c=relaxed/simple;
	bh=ihXKB3Q3XtlxRoYg/e0AEP6UA1N7IJYdMFDqjXgnj/A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hz2le/LX6nqQtbRplMp0/B3G8b73Xdq/V1zo8xcK09IzhdAdXD0LRfFPMLPIXLsqLGHwjHe4DhswoxKBuaG5/ROS6f5A5ccmft66VuHlvKviqfxQ2kduJwlQCJDOE6sQoKp6Jgi2MwnwVI18M/5hCOccX7qheKu3wWMYHkhfeIk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=TD44j18g; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=0JYrKp3R; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="TD44j18g";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="0JYrKp3R"
Received: from phl-compute-09.internal (phl-compute-09.phl.internal [10.202.2.49])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 383A111401C3;
	Mon,  3 Mar 2025 15:45:08 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-09.internal (MEProxy); Mon, 03 Mar 2025 15:45:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm3; t=1741034708; x=
	1741121108; bh=bZ0Mw0OW9n9jqHTJ+NR/gA29iKQ36+oovsChOJEWUbE=; b=T
	D44j18gxdrYsi4e63O1p85vqwCONFv/Z3Sm9S9e79MNn5IL7Zts4NILG3nnRo0yO
	fOn5wssRLj4ZMkY9rWGd08oQ2bfbgJA61JcYlqWur7FmXwFXRfbP5gz/N++l8zNQ
	4BbEsrLxH75X3QGwIKtA49kbH3BQZ463amBuDFi+IkecrZP9uN2Bo1B6avytkmWt
	lUMS6z4/0w1jJSFcQIp+KaQUBB9lUjjFadZU1BmzDSj9ly3wRxZtSKZti0QoYEl2
	9umHD9Xs/walVnCYduwlzrJciyiSHlq5UjUCwK28iEJTawOgRCEjm8VlZFYkr/vB
	CYvKxWedLNXlyM9nDOjvg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm1; t=1741034708; x=1741121108; bh=b
	Z0Mw0OW9n9jqHTJ+NR/gA29iKQ36+oovsChOJEWUbE=; b=0JYrKp3RELr8ACe72
	XE2F7EiB/yiyZKhWTiGH0oX1FzFkocsaaOrHNz6OFgp6AIKWBHIOMtUGsipxvNj6
	mQ24aakmGk+MYDaX5A6O2bAI5Alt4dXoG0cGDJR6+NBnvj+xkdkpECWVxbR++mpb
	VAYhKrMkbXLWIHQcUDYoADWn/oox1Ro5ynmK1JWfiCgbyqQw2FznxORaiscMtG1Z
	ayz5yTEaALOLZ6L9vgb/R23HhyyUQA6tJn4ua6/fkK6NUn9+ek5/uDCb+fMSnFGP
	mKksAG8hfx3f5YN/PdaJLPDSdCA3bulvBx2+4mxnMTuPl2OSVFeUhW98ZM3LE/fD
	EUFiw==
X-ME-Sender: <xms:1BTGZ7Fiu6upyrwnZjxg5TuNq4iE4oCY7FABGrOIrxmPoHtbz2hnGg>
    <xme:1BTGZ4UnljqUIaEtlJb5UVmI8vTvhg7sDPPe7ofFOUGrgkky1XcoVxvZ94wgm5LSo
    -TWxbasH4-shxWu6w>
X-ME-Received: <xmr:1BTGZ9KpbJXZPHJEe7j91m8NEj1VfbRJ1bASpur7dNjHbjFhmq6iqocsaJt3VMlG672kWHyXuSVDAWw45F_byXCF1ms>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddutddtuddvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpefhvf
    evufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpefvohguugcukghulhhlihhn
    ghgvrhcuoehtmhiisehpohgsohigrdgtohhmqeenucggtffrrghtthgvrhhnpeejuefggf
    ehieeugeeuheevgfegudetheetuedvveeuueeileeuhfeigeefkeekieenucevlhhushht
    vghrufhiiigvpedvnecurfgrrhgrmhepmhgrihhlfhhrohhmpehtmhiisehpohgsohigrd
    gtohhmpdhnsggprhgtphhtthhopeefpdhmohguvgepshhmthhpohhuthdprhgtphhtthho
    pehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepghhithhsthgvrh
    esphhosghogidrtghomhdprhgtphhtthhopehsrghnuggrlhhssegtrhhushhthihtohho
    thhhphgrshhtvgdrnhgvth
X-ME-Proxy: <xmx:1BTGZ5FmUi4rapNSe1jL_U43CMFeByTbEtl_tJG8ooe2aIFOqVqu8A>
    <xmx:1BTGZxW2K0npaRkbO50uToJR856msNpJwwuHtIMwDuOBfgMzc8N8AA>
    <xmx:1BTGZ0MBdv8XisBnuSJ8teMOg7hKA-EjAQk2L67ESGce-H9SsG1cTw>
    <xmx:1BTGZw1NwoAiVeXJVaDIPksqFy-xuameNyNHZw-mAcVaimtkMPo_Uw>
    <xmx:1BTGZ0QsVuparjMf6eG8A3J65f_QTts5Q2KCmxDcegS63u4JJuGIghdq>
Feedback-ID: ia13843cf:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 3 Mar 2025 15:45:07 -0500 (EST)
From: Todd Zullinger <tmz@pobox.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	"brian m. carlson" <sandals@crustytoothpaste.net>
Subject: [PATCH 21/34] object-name.c: *.txt -> *.adoc fixes
Date: Mon,  3 Mar 2025 15:44:19 -0500
Message-ID: <20250303204443.360595-22-tmz@pobox.com>
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
 object-name.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/object-name.c b/object-name.c
index 945d5bdef2..76749fbfe6 100644
--- a/object-name.c
+++ b/object-name.c
@@ -1273,7 +1273,7 @@ static int peel_onion(struct repository *r, const char *name, int len,
 }
 
 /*
- * Documentation/revisions.txt says:
+ * Documentation/revisions.adoc says:
  *    '<describeOutput>', e.g. 'v1.7.4.2-679-g3bee7fb'::
  *      Output from `git describe`; i.e. a closest tag, optionally
  *      followed by a dash and a number of commits, followed by a dash, a
-- 
2.49.0.rc0

