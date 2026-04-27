Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5877C3EDAA7
	for <git@vger.kernel.org>; Mon, 27 Apr 2026 19:07:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777316828; cv=none; b=ROClAjvJZeb3+YBLnLAOPlSBeHs1HZjJFlcAuaj0XQ/7svxoNmBsHU8lig6cV9EGJJ68sjEJ3xezr9a4wXRfW7MHLnY4cmQDx/gha2ypGWltEdFgw8FpLowirdUKG8GUfPf6mUBr+Um4RzAe9A4KT0H1sGYeHFD19CnEQwqoSrU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777316828; c=relaxed/simple;
	bh=pxmzsZMyFEVMcrFu3zbIEvtnpBHKHcwr5l0Q+yxMvdc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=UeLNN8yzI0qhUikOySF18eImzjIs29WdhAggRKsS1wbOIOBawGAg7AIDaoUn9OlESYojL6rHi1sYCkDSHIvSiN8G/alYbD+V8xhUrtPtnlAdiCPN51UAd3eHbTk+aBK5TFLFK5lWKTUADsJ9tMfxizmPSxl/v1BOAk89U8ccTBI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=jO28NM5K; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=kliVZ49A; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="jO28NM5K";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="kliVZ49A"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.phl.internal (Postfix) with ESMTP id 7B3EDEC1811;
	Mon, 27 Apr 2026 15:07:05 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Mon, 27 Apr 2026 15:07:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to; s=fm2; t=1777316825; x=1777403225; bh=bhL0K3mq2iFlkB10YJTqP
	g5n9OMSJsO1U065OqBZJiA=; b=jO28NM5Kv3rUtcj6uCbOTAfMAZd7/70H3YISw
	z3Q6gpTq/aQ0eAXVdGNi4qtfczEhppaG1Ywsgz80D8eg7ViiG12s7vKboRl2O8rh
	/X1xwuNCEwRj7UdLVv7/n10anLDXLrlE/RE2icUQyf3nvkXs3TrVroVI0cdA0wb4
	s7/T0cZMleVDgGQYXiKwpcOZr59EZ0KDU4G/aSHyvPWRHUWN5b/A3rSTzkL7msGE
	Xv7kUP7F6l3naCLq/BCanoTzRA3tLkylGyoozR0ATWDamQeVrtZGkMNWcW4RU2Xj
	wFtfK2oJ5vgnQlET5I7IBqLaFTCqUYqIDGkrn0ybckOfDoNCw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1777316825; x=1777403225; bh=bhL0K3mq2iFlkB10YJTqPg5n9OMSJsO1U06
	5OqBZJiA=; b=kliVZ49AW91XESm99KSlVdNoB0KiDkdDEvg3B9DxFLU2l1TgXjP
	OdatDavM9SvCXtBaj98I4eIF/m8XKoexpioCE2+5rwLfYvZ1TPE0Rx5X3mFfsbAO
	egdcpef2pMOC6ZYVZK4YbJUSTBJprlrhEU1QbdU/n+wu+HPCc36+GlQSNKQO0nte
	YYUI+siiGx+r9gpojXa5cUtlZ55ZJ4y8loQqIQORtfRoOGzf0YWxxlglNb+USwEJ
	xSr/bV5L/gDk+DJTdthbx5DISWYbjzfnENMv+i3ZgvlNGvoBWPXVJ063/kxvHn5o
	eiOHsFRo2Jkh5g/m+mAqvCVRn8MiChvljow==
X-ME-Sender: <xms:2bPvaZuhiaCEUvPgT0FIGS72tfvdoJGPyKNqrd74mj5LHemsEhQsYPs>
    <xme:2bPvaZ4IgRhgxpYZwBiNyQTweCzIF9nOkHrthn9LxfYaGzJAuRfbn1q6q-ikdOh-B
    TcmlZ7NQ9v3goXsL2RUwDBqzlNKtfFzr0AdtADz5b_WNMUHQv1M>
X-ME-Received: <xmr:2bPvaaKn1IZnfw4RXNa8bVSweohLsMM9wSGIQYetugIHhd8OXE3GA90PveKIVAeKLDezJ0X4u65dFQxd0n03VkoudrlaWoZg4kjysDQHotNQCblO4jv3Gco>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdejleeglecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenfghrlh
    cuvffnffculdefhedmnecujfgurhephffvvefufffkofgggfestdekredtredttdenucfh
    rhhomhepkhhrihhsthhofhhfvghrhhgruhhgshgsrghkkhesfhgrshhtmhgrihhlrdgtoh
    hmnecuggftrfgrthhtvghrnhepvdehledvjeehjeejheevtedtjeekhffhffevtedtfffg
    keduvddvteefjefhuddtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrg
    hilhhfrhhomhepkhhrihhsthhofhhfvghrhhgruhhgshgsrghkkhesfhgrshhtmhgrihhl
    rdgtohhmpdhnsggprhgtphhtthhopeefpdhmohguvgepshhmthhpohhuthdprhgtphhtth
    hopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheptghouggvsehk
    hhgruhhgshgsrghkkhdrnhgrmhgvpdhrtghpthhtohepjhhnrdgrvhhilhgrsehfrhgvvg
    drfhhr
X-ME-Proxy: <xmx:2bPvaZ5vSWUnRaRlw8PdNfO0-AlVbCPkkMQSln5fHTxnhtWMx0D4Fw>
    <xmx:2bPvadz1lW4dZGsV5XmK6B79OXAMvE8hG7uBoWyhQ6caGoiMSpBJqA>
    <xmx:2bPvadbXHkr6OZJhL9RsDivh3KH5b7jREC0FOulTzEOcId06M_XSDA>
    <xmx:2bPvafQzJ0BpPIGiP--ljK5nV3SQR-rqiAPJdP7QT2jsKkUPG0LHmA>
    <xmx:2bPvaRhjtuhdZqKbuYWcrcvjKwI5Kh6pakGmtHGXqogCRuPQs5WidjFd>
Feedback-ID: i8b11424c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 27 Apr 2026 15:07:04 -0400 (EDT)
From: kristofferhaugsbakk@fastmail.com
To: git@vger.kernel.org
Cc: Kristoffer Haugsbakk <code@khaugsbakk.name>,
	=?UTF-8?q?Jean-No=C3=ABl=20Avila?= <jn.avila@free.fr>
Subject: [PATCH 0/2] doc: log: fix --decorate description list
Date: Mon, 27 Apr 2026 21:06:48 +0200
Message-ID: <CV_doc_log_--decorate_list.626@msgid.xyz>
X-Mailer: git-send-email 2.54.0.13.g9c7419e39f8
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Kristoffer Haugsbakk <code@khaugsbakk.name>

Topic name: kh/doc-log-decorate-list

Topic summary: Fix formatting of the '--decorate' description list.

[1/2] doc: log: fix --decorate description list
[2/2] doc: log: use the same delimiter in description list

 Documentation/git-log.adoc | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)


base-commit: 67ad42147a7acc2af6074753ebd03d904476118f
-- 
2.54.0.13.g9c7419e39f8

