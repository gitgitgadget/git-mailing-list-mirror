Received: from fhigh-a1-smtp.messagingengine.com (fhigh-a1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0E8D2DF6F6
	for <git@vger.kernel.org>; Wed, 18 Feb 2026 20:26:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771446402; cv=none; b=FZ4v8vxR6QdPii2xi448MPbP4uPUBjmekT7e//zhrnHovpRvhzer8p6snaB1J4Zo8xYhqbCmavP51P7NjjNQppLYj/9c4er2dL7K4+l/6FOuovXD0160mmcrOty4XIo6oOY6qXJFiHo3W9c6Z6zT2sDJYivyBXjlU4CI0rePYwM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771446402; c=relaxed/simple;
	bh=o7ltVtOEogGwgIBUptlC+zh8uM6FAw16mOr3QiVnOiQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=uFe/v3STNRjPJcmkwK9Jod2l6hsQQYgH45HUOX6viebS2sUr7OdR0it6GzHjYy/aPnHxleTftv4O7abwSSOjVUeAZNvUOnhufAXq1p7HlHHp0o/lWwFcFNOnxUw0e2AQZ9AiQRjVjDe8+NpQZCAsyXNOvq80XXq+wYOFwMnfBEA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=h/SdoLTQ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=a1dpo8z4; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="h/SdoLTQ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="a1dpo8z4"
Received: from phl-compute-07.internal (phl-compute-07.internal [10.202.2.47])
	by mailfhigh.phl.internal (Postfix) with ESMTP id DB9A71400024;
	Wed, 18 Feb 2026 15:26:38 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-07.internal (MEProxy); Wed, 18 Feb 2026 15:26:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:message-id:mime-version:reply-to
	:subject:subject:to:to; s=fm3; t=1771446398; x=1771532798; bh=VM
	VZomzPq2qA5ese8vjcyFA/Pwibmu7PjFQ7+X3HwM8=; b=h/SdoLTQfooQqwht01
	tDRs6Q+RktxIgwXhHKKx09BiPs/mEZzfMakL2a34LsMzkqyLzj3mGr+N6STfdXKw
	vNRmN64v/KPJEemuFhZ5f5YzwkhXUMUywzTXpCoEU2IxZ6JPKIFYzu/SKHyCME/t
	gkVyfyBSLgKkFit95Tjf3jdYgh8ynfEOHLGio10cFuKvHO7kqzy2GYdka/EEWv0R
	7PZj+oMgQCGPdu+Wc8gqkDUL7CjF782hmgPL4gTlv9jzgqnvuPnkdS3HVN+8AjqI
	a7aXUU2XDaDK0rJ+fXw4vuJFDwMBZkJVfRFLjGgj1s7Jr/BCqnv3EJ/Hb66KjqNb
	MMIg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1771446398; x=1771532798; bh=VMVZomzPq2qA5ese8vjcyFA/Pwib
	mu7PjFQ7+X3HwM8=; b=a1dpo8z4aEshL2vIlwM6aqtLTkVJ0OLsKQpOBXwXD61k
	onKQB9lcS52vgvhYBK3JiIjK6dez5yaUA81To9eDPXjfxRFJG+abPMudnLknMbbP
	1zoxFnoHL/Mm9WGcXG3DU760t6adyxHzuONFXmlO9JHtvv0cZmPUSmcumP1ExyrY
	SlHqteN5JR47o3V1hXusVlSRvF1b1Q+DU9wlTQSdbcYTQxPPLD/VJnM+B8vhkcFM
	h3g7R3kR+LhavJsp4WxjC8AXsayDWiwe9VkwWpGZEiQ8H1I9Gpc2JtF3pUR3ONZM
	TqJDGQifRTyFIniaYhgMkIDZgfP5cxqN4RVBGDeOxQ==
X-ME-Sender: <xms:fiCWaW98NZbSaOGSHi4ifQ9RLHg4fUg1k4PW4NioHEFKeeA4nRaOEIw>
    <xme:fiCWaeKst6wsG-ozS-VUb36DI0dniq41m-avAddpRhsjxg31fpFpCAeuiXNZFCd58
    YmeFcXk7sPcxcK3mBAwhzmvZf40hCldQy4ayL4iKJHIYHgxn9LmxQY>
X-ME-Received: <xmr:fiCWaZawXSAEKpDjsSbFTAHwk23WtRB-ebHUl3-NxOFhdyUgZxt6POgYlyNmM5eNNgtCyIVQNlpOVWnjQ3pIOH-jZ19nj21PZNe3rf5-UOS_pGJ6RN1uFiutww>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvvdefheelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucgfrhhlucfvnfffucdlvdefmdenucfjughrpefhvfevuf
    ffkffogggtgfesthekredtredtjeenucfhrhhomhepkhhrihhsthhofhhfvghrhhgruhhg
    shgsrghkkhesfhgrshhtmhgrihhlrdgtohhmnecuggftrfgrthhtvghrnhepheelhefhie
    euheejveeftdfgiedtueevhfdugedvheekvedvuedtueeffeeigeevnecuffhomhgrihhn
    pehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmh
    grihhlfhhrohhmpehkrhhishhtohhffhgvrhhhrghughhssggrkhhksehfrghsthhmrghi
    lhdrtghomhdpnhgspghrtghpthhtohepfedpmhhouggvpehsmhhtphhouhhtpdhrtghpth
    htohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopegtohguvges
    khhhrghughhssggrkhhkrdhnrghmvgdprhgtphhtthhopehpvghffhesphgvfhhfrdhnvg
    ht
X-ME-Proxy: <xmx:fiCWaYJ3nbs7Qr6SZJCwgQIwjs73cXYnO8XYlU9sNgnw1yVRmZxyDQ>
    <xmx:fiCWafAppK29WHFKTOsRFPGE1ogJcz63Lfm9umWJvb6fK0OLjP2C4g>
    <xmx:fiCWaVr8ZEDv8F2gyKa_IXSyZe-YxOHkiVodWWmkJK6-FKJdeFGNPg>
    <xmx:fiCWaShYg0I0HvRvqYWK-WCNjRPFqCRH97umLg36eK4GwcNIvwi3ow>
    <xmx:fiCWaW6gClYeoijauc7YZYmpTuD30Ma1MxFzN8OTM8287z9hs-zcYX2B>
Feedback-ID: i8b11424c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 18 Feb 2026 15:26:37 -0500 (EST)
From: kristofferhaugsbakk@fastmail.com
To: git@vger.kernel.org
Cc: Kristoffer Haugsbakk <code@khaugsbakk.name>,
	peff@peff.net
Subject: [PATCH 0/2] format-patch: make boolean and mention in diff-options.adoc
Date: Wed, 18 Feb 2026 21:26:16 +0100
Message-ID: <CV_format.noprefix_boolean.39c@msgid.xyz>
X-Mailer: git-send-email 2.53.0.26.g2afa8602a26
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Kristoffer Haugsbakk <code@khaugsbakk.name>

See: https://lore.kernel.org/git/a9602602-5fea-40c0-a505-34133ed4d58c@app.fastmail.com/

Topic name: kh/format-noprefix-boolean

Topic summary: The config `format.noprefix` should act like a
boolean. But now it is active no matter what the value is. Change it to
act like a boolean like `diff.noprefix`. Also mention it instead of
`diff.noprefix` in git-format-patch(1) doc.

This is a breaking change. But I have opted to die if the config is not
a boolean and just hint about the change. See also Peff’s comment on
such a breaking change in that link.

I have also asked here about marking breaking changes:

https://lore.kernel.org/git/3124b359-2929-4f3f-9ac6-793277fe422b@jontes.page/T/#ma8856238748d0794a0da6c64e1c0c8a4824b996f

Kristoffer Haugsbakk (2):
  format-patch: make format.noprefix a boolean
  doc: diff-options.adoc: show format.noprefix for format-patch

 Documentation/diff-options.adoc |  4 +++-
 builtin/log.c                   | 13 ++++++++++++-
 t/t4014-format-patch.sh         | 16 ++++++++++++++++
 3 files changed, 31 insertions(+), 2 deletions(-)


base-commit: 67ad42147a7acc2af6074753ebd03d904476118f
-- 
2.53.0.26.g2afa8602a26

