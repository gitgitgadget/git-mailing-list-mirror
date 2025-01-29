Received: from fhigh-a8-smtp.messagingengine.com (fhigh-a8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7457BA50
	for <git@vger.kernel.org>; Wed, 29 Jan 2025 16:24:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738167862; cv=none; b=KaW0O7OsbfzAxPtF62qCMAguAUCvNCQh8eTbZKwd5IWZ1di0kLYrDMqqaJzBpJIyB0Ak7a+SSi2MEsy9K/CS/ktR9tVDTO4moqfnEVo0YYwORCizM05fUn0XcVH8MFRAADEyFx50l5Q50AenpWWyOR0oLMQ/m17cx5+JP24Z3DM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738167862; c=relaxed/simple;
	bh=h0l/Ct9TT00pq8GbHa1ksVBNfnzShPfXIvz/WJKGtUw=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To; b=LC5vg/Qi6c0CYc3wU4+77n84Wcu7R+40y+QwuhXyqemLX5OqKAY409+/R89WfdA7QsKx8UWd+WXMYmpJk27v7/8mHjdGptInVe2WYhQL+Jb7qMGQvYiHKroP97QP9OlwUpiZFeVrf0E8XyjykjGlHqFjeCejUXASSTCXuXw5Il8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=c9328VCH; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=pkW3cmn5; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="c9328VCH";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="pkW3cmn5"
Received: from phl-compute-11.internal (phl-compute-11.phl.internal [10.202.2.51])
	by mailfhigh.phl.internal (Postfix) with ESMTP id C759D1140114
	for <git@vger.kernel.org>; Wed, 29 Jan 2025 11:24:18 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-11.internal (MEProxy); Wed, 29 Jan 2025 11:24:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to; s=fm3; t=1738167858; x=1738254258; bh=/YlPZ5GRJo
	oQJc6opoWxocoQCN3e54g1D55EOgqKYNA=; b=c9328VCHfbkc0rnKnXIO+KUiM3
	382Q7kSMOK9+n26a6h7V/d31BQS6WBVIuayMdaTu55KQNsb0ZCNkKPDzXserVk7f
	Vh5nSvly7QXLDUScM/4f2nJzgsfDSAnyAaJSiLvQC0pHl9Q56iXwqq549b7spNNk
	qqRxONFf0HlIMc4xYK+Dy0h98+WbyikcG/f1/4XvUqdvUYdTZNWPajh0aX2NjeOJ
	ucFs60BivgApudzEbfGzVQWBrKnUgJpYNhgEM9rk9HZeiQZjj/BuXtUW2h7wWiAZ
	+pV9dDYDE4Sgg1TczVOt45cTQfJX+mpv3jkJdayIKbJo/y/YHOwZyyJxOetQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1738167858; x=1738254258; bh=/YlPZ5GRJooQJc6opoWxocoQCN3e54g1D55
	EOgqKYNA=; b=pkW3cmn5jW1/78wj3sWl4j6e6x/1MBoSl/dpHPcsPth1JMpJGfZ
	ctkoXQMCm5PBx+yXBKU2qOuOffLKe/Bsmt+/ISGzdMRj5wkclp9pgrrtV+6JYQgF
	oxcFkzDbPQpoGSNNc7N4fvk2xV8a90ou+k/bQiTN0/aKAi0OHYlxbJhxSLN+AccL
	PoSUnDsQSK/Oe6JK9ckhWg/SxGoMpoZM5dtRKpSjCyMUvRmrVXY2Ukb9gYGy+xvY
	LbUctmK1PUpsfGF+cTX+iIoqHrSztzyNIwtfdSfcpV2EkhchUVdA9FdsXtoFuF30
	GaalIzW417aQLYMLeXhzBiRam5/gP3ggc1w==
X-ME-Sender: <xms:MlaaZ-xPHOeVl5ZkbAoOZNdT3-_o6KBn3zat8jV8CWcDk6aKQbWY1Q>
    <xme:MlaaZ6QrYnQt3YxDHsS1MVOWIBrpQM9mY6VOno0KbpER6bs2BtUdQnUm-624a2LST
    X2OTytRWFruke6klA>
X-ME-Received: <xmr:MlaaZwVFkivkTd1E4_gkTctGGg7cdri0b_0xw_nr2NrJQJ3Keso51G-1GOx1pK3uGDGVsMIFxLYPvNmgAPJ3Rxgco5ZJB7KhU5iqStBI-jaQUPVPqw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdefgeejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpefhufffkf
    ggtgfgvffosehtjeertdertdejnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgr
    rhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpeeigeejffffhfdthe
    ehteffffefleffgeefudektdduffejhfegffehudekgedtueenucevlhhushhtvghrufhi
    iigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprh
    gtphhtthhopedupdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehgihhtsehvghgv
    rhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:MlaaZ0hNyTLQAQRCC2K3-H_U-ZFU3fDpkcF07UB6dW6mf2T2Ar19Ag>
    <xmx:MlaaZwBcyGUNgM872jECJMwd-7CbxFEhjnyL4LmEnWpUP72TjZYrag>
    <xmx:MlaaZ1LI3ak73gASSnsg-XStAwCGZh5F3hucjLBR2yhdeFvmiobfpg>
    <xmx:MlaaZ3CInc-wED9TaynQ3Pp36qkz-ZVAJJhEhuCVyR3kJdAYza_qkQ>
    <xmx:MlaaZ565sZEOOkXpRV-dhJNvi6r2Gv3Cdb31kvm2l9f0cEci7_TSGSD6>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Wed, 29 Jan 2025 11:24:18 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 02a5945a (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Wed, 29 Jan 2025 16:24:15 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Subject: [PATCH 0/2] Plug two memory leaks exposed via Meson
Date: Wed, 29 Jan 2025 17:24:13 +0100
Message-Id: <20250129-b4-pks-memory-leaks-v1-0-79e41299eb0c@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAC1WmmcC/x3MOwqAMBBF0a3I1A4kUUHdilhEfdHBLwmIIu7dY
 HmKex8K8IJAdfKQxylB9i1Cpwn1k91GsAzRZJQplDYVdzkfc+AV6+5vXmAjjM10icI69JpieXg
 4uf5r077vB6ji4q1lAAAA
X-Change-ID: 20250129-b4-pks-memory-leaks-2a318e5afec1
To: git@vger.kernel.org
X-Mailer: b4 0.14.2

Hi,

I've had the need to play around with the memory leak sanitizer today
and for the first time used it with Meson. Interestingly enough, a test
run with Meson flags two memory leaks that our Makefile doesn't. I
haven't found the time yet to figure out why that is, but this small
patch series fixes both of these leaks.

Thanks!

Patrick

---
Patrick Steinhardt (2):
      unix-socket: fix memory leak when chdir(3p) fails
      scalar: free result of `remote_default_branch()`

 scalar.c      | 4 +++-
 unix-socket.c | 4 +++-
 2 files changed, 6 insertions(+), 2 deletions(-)


---
base-commit: da898a5c645ce9b6d72c2d39abe1bc3d48cb0fdb
change-id: 20250129-b4-pks-memory-leaks-2a318e5afec1

