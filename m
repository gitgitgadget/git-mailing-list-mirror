Received: from fhigh-a5-smtp.messagingengine.com (fhigh-a5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A0882D8767
	for <git@vger.kernel.org>; Mon,  9 Feb 2026 17:35:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770658530; cv=none; b=oDW3cgwIfGsDDvDW1vy2upAnoyvbXG8OBgRvCLbZjDQ9YkHGkDgsrTsQFjNaSrpN5zCpc9oU9m7iLYyHYmWWM3WOsIy8U5e+L64AD4MobvokED3Js9qvnDTMV1OguGITe8Wx24iywuTZhi1RyiYH5We6ccnEf/4wdXQhMxfvxyk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770658530; c=relaxed/simple;
	bh=NP/V85HHlC5nV+yXCct+97HYTl0zrMWsoHoIMN9KREA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=rPmekiGvcy7Hpn3NbyWxKO1W1mlFSgqVHjPUe3iGDlf5p3gXWOk12v0w0BKAT+PES0dhUJdFR61Lzg1HpMiJvQG0CXBXy1twzGpMNZ/93qUJY82GkeRZk48X8Lk/ve6TrqgOhCiyU4C8L3a8WxoF9TLaxvbrjz4UXpdr9x7fiEc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=DIW7Hgon; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ZXoVHL0R; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="DIW7Hgon";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ZXoVHL0R"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id C018B1400081;
	Mon,  9 Feb 2026 12:35:28 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Mon, 09 Feb 2026 12:35:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:message-id:mime-version:reply-to
	:subject:subject:to:to; s=fm3; t=1770658528; x=1770744928; bh=oN
	0pxLQQ9T9EvfiN0adXG2GBigxsGEEvy7icKypYeas=; b=DIW7Hgonoa8nWC7/lu
	yE9MPFA3UqKe9YHMmaGuPAqEk83rn8i7ralZkjXBJ4w6CPLi7uOaKFbGrh1Opzn6
	fN8xjE6xJYa5KxI40KeDKUdr9Hgp9eToGnfzLS2EfWwuxi6JdNh6/d9ok2682eUb
	a0ktSxxH5y6fVX4r0J2pUxDSYV7HYDQ85hWjRSnqII9mA8I+jrydLnsn90FyCqz7
	smtGp5YI0IrvgXR3stSPNQOYs4p8RGeecVKzWMoK782G5/fa+U+aNatAT6DoIQgZ
	dydfmSySo7eE7M+IhoQt3p12eh7rxNDJz6ru873YiKe2QYm7SzAC/bdxeu+Wg6sS
	Z/7w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1770658528; x=1770744928; bh=oN0pxLQQ9T9EvfiN0adXG2GBigxs
	GEEvy7icKypYeas=; b=ZXoVHL0RM4+F/3sAadZRzHWVpTIxag8wJzMVrbOGJhI5
	iHhG7iuzzRQpsJOILljPPxpDA/P/WxZ0E4sJAIcRFtK9siLdIrtj6u4Bt7nIzI5P
	KvtBeS89iUeNJVXe4Nqyg1fnyAAHdTtYDHf0ObAAus/Ic/9thtGSsRTeI9nwB+fH
	Yw165GquqocO64Vt6vzxhTMdmNRSS93Z5bAx7ZuHFFx8Jrl7gs/zcPRyBEuRe/HF
	RyRq8MRVt1LE7g4L2SmihUDBJwAbCgMlmcMs57RpGt3OM76g042rF91UjukJJ/rk
	2+1qSz5IHzZhYz+HjtbsRNWeFHr0/YYK6UGlr/9hjg==
X-ME-Sender: <xms:4BqKaRRvSaAOgTGaGs0SwB1hydIEQJtafBJ-2wA6SX4Z4N869RIIRKY>
    <xme:4BqKaQzjE9Da3b8qyfpZ088iJ-_pPQsKAw8qljzvqTMvgJciKTDlrqLQ-CjUJ7Bvk
    dQFIa2DTV8f6B8IoTJFI0p09EiSeEtSv4BnoD6btsliuoWJizu5XA>
X-ME-Received: <xmr:4BqKaUdqzWHsnX8NyPxqW6y49lM-nCAgoivCeVC2PU6kTkupMCoZzrQqKvjR7K-cP1YMcOFfN-Bj9jwVlCjitc0aY1V9uMmjUj0WefE>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdduleejgedvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucgfrhhlucfvnfffucdlfeehmdenucfjughrpefhvfevuf
    ffkffogggtgfesthekredtredtjeenucfhrhhomhepkhhrihhsthhofhhfvghrhhgruhhg
    shgsrghkkhesfhgrshhtmhgrihhlrdgtohhmnecuggftrfgrthhtvghrnheptefgkeejff
    dufeefffegkeevgfevvdegffeujeejleegudfhtdffieekleefhffgnecuvehluhhsthgv
    rhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepkhhrihhsthhofhhfvghrhh
    gruhhgshgsrghkkhesfhgrshhtmhgrihhlrdgtohhmpdhnsggprhgtphhtthhopedvpdhm
    ohguvgepshhmthhpohhuthdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrd
    horhhgpdhrtghpthhtoheptghouggvsehkhhgruhhgshgsrghkkhdrnhgrmhgv
X-ME-Proxy: <xmx:4BqKaUJTQOXJFhqaKMV5rQArk6Qk_g_ODHe4e141aZtetcbSPLnrkw>
    <xmx:4BqKadE8z02fPZTdDJoFXAt_kJXHg9zuiVG86QYD4wjT4rHB6GppyQ>
    <xmx:4BqKaWqWJD5Q6Z58RRRC4mnVWYuPPiaQoQjcVKlim9D2mqCYZ5S3ZA>
    <xmx:4BqKaeT5A8ZmKJ-JiimgVriazHmzhpzL4K_hk6JKq-fX2MXRk_t6Lw>
    <xmx:4BqKaUqXh8VdUqObmpCRiwdTHueJ7JQMKyyosfXAHOUWam2_GfqkUrvL>
Feedback-ID: i8b11424c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 9 Feb 2026 12:35:27 -0500 (EST)
From: kristofferhaugsbakk@fastmail.com
To: git@vger.kernel.org
Cc: Kristoffer Haugsbakk <code@khaugsbakk.name>
Subject: [PATCH 0/4] doc: am: improve command linking and add am.messageId
Date: Mon,  9 Feb 2026 18:34:33 +0100
Message-ID: <doc_am_gitlinks_and_am.messageId.321@msgid.xyz>
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

Topic name: kh/doc-am-messageid

Topic summary: I noticed that `am.messageId` was not documented. In the
process I thought that the way that git-am(1) refers to commands is a
bit off. Replace all things like 'git am'/`git rebase` with
`linkgit`. Also fill out hook documentation.

Notes to the maintainer: this conflicts with topic
kh/doc-am-format-sendmail in `seen` because of an adjacent paragraph.

Kristoffer Haugsbakk (4):
  doc: am: normalize git(1) command links
  doc: am: say that --message-id adds a trailer
  doc: am: add missing config am.messageId
  doc: am: fill out hook discussion

 Documentation/config/am.adoc | 24 +++++++++------
 Documentation/git-am.adoc    | 58 ++++++++++++++++++++----------------
 2 files changed, 47 insertions(+), 35 deletions(-)


base-commit: 67ad42147a7acc2af6074753ebd03d904476118f
-- 
2.53.0.26.g2afa8602a26

