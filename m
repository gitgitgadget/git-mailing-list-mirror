Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D540C2AE97
	for <git@vger.kernel.org>; Sat, 21 Dec 2024 11:50:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734781844; cv=none; b=tlUgORqkUAsVo9cvz4H6AATW8lWvD1IeldrcYSi7b5ssOkOl3JogpRcvx4/O3gD/XV21wLAzqwlLLTgaix6KiFW3xisy9srdYjv0INveAKtQvYYrZVsj1N6cFpBm/C2wLJNH+57PZK7N/EyHIzH6lh+uGD+tY7m/Bqg1RcbUB4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734781844; c=relaxed/simple;
	bh=g9MsG8hzrq+DIdlGlpCbPTrXaRpwPxnDqYAbeFDiCAg=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=Z24SLuH4c1fkFUAcjaSHttqwLyLdL3EuQVB20WDKR0/sN3ziMX882uGNWBleX06PDM0qhZeyuusS/psovU9Xg/K4PIHuma//XVHFL1+KY/ZyRDlMSf3ucW1dI7VcmlK4xRregjist8Ng0c45F2G9DamIGmp69l3yhy8sC3873rM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=BBntSKB4; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=nPlJquvU; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="BBntSKB4";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="nPlJquvU"
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfout.phl.internal (Postfix) with ESMTP id C92F813801F8;
	Sat, 21 Dec 2024 06:50:40 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Sat, 21 Dec 2024 06:50:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to; s=fm2; t=1734781840; x=1734868240; bh=2boIUgodX9
	ZuzVGjxojXn8zRVrP6qLTpQ8Wne+BS5tM=; b=BBntSKB4HD2oXxvRMGjYWNJui8
	saRi9S2Co0YTGO+g4xt/hXpKIcuKK0qmMwH6iqm8Owk0i7d8vfaZ6KS3jhZRfSzn
	kQOlhYCzozAjIOCxjAcjckxXpUhLSyfU0wP2IbsTY4nGA9YysbE0y0vSY7cuKlZs
	2DqNUGTe+TT6Rzkzd18UVPfT/H41guE/J6+muZY+k13dDqR9VJeCGv/wGIHZCLzh
	Mzg391a8HyAMRNZ6Jxb2bf4feJg0ikA36nlZGDNRkRdSMHeqpuip5SM0KC1J2WRd
	uR8IE1AJxY4Rzjgdu6jbsm/ltVyepMqdaShdyPGR7HlkItGtsrDj1p2+EXKQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1734781840; x=1734868240; bh=2boIUgodX9ZuzVGjxojXn8zRVrP6
	qLTpQ8Wne+BS5tM=; b=nPlJquvUGorRsEvJEG6E6iCVnnCJHKRUiQqgtOAC49Kq
	iy0yElomPA2hL+KAUeuyBW9O30GWBL08UjbKLE12ixT+NmdLHiO3Oyeffv4GZi2k
	72iT1ToqqMY25yY7VOuM2aahRcx7VvGPol9PjaYvp4L3Y+1raYyQxp1LeajNl2fv
	q5+LcZEsRriqVZMjzkQwc27NgOOTrlOFsZudFJSuEwxHjTmMyOO+k54xd9sKrTlR
	QaP5U4ipEsUn+7O81hHjiQqpLyi1aPKDbTkenj2yrQQPvvWgPdkqrRNJh5jdAbcB
	oDAhvkUqoYVNXHXqSxtUqExXIFDP4xpCvnZ2X2bUBg==
X-ME-Sender: <xms:kKtmZ90rQV_WpYm5WdJEL0xY0pFhtTkZllpdiZGLYz0TOEbuyKGdiA>
    <xme:kKtmZ0FX2nlQsDSo5TXavcMkP2qqsaj1XoMeqx9mUqRrIG9G42WWX0TCDjDkTwHS7
    XILugWbaZ0EKIDmPQ>
X-ME-Received: <xmr:kKtmZ97kp9FSC_XLnijJWbVjahn3OxFCEMTkc4fw8pH0SxtCL90Qy-UVe4IJlrxDZa1NLnQO2N-Cqk7mRi1rXUsPwoODEdAREAdik9jfH9hzxRdvgA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddruddthedguddtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhephffufffkgggtgffvvefosehtjeertdertdejnecu
    hfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqe
    enucggtffrrghtthgvrhhnpeevueegkedtteeigeejueehuedugfevleefveehueehgfet
    ffffvefhuefhueekveenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrih
    hlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeefpdhmohguvgepshhm
    thhpohhuthdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhmpdhrtghpth
    htohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehrrghnuggr
    lhhlrdgsvggtkhgvrhesnhgvgigsrhhiughgvgdrtggr
X-ME-Proxy: <xmx:kKtmZ61Sp-E3xR70vn4HmULdoH4Hgbl78fRhIBl321bAZXy_yiSxYQ>
    <xmx:kKtmZwFmReKatvsGZiujp-ooqGpgQ4Oe9dBzee6ogw3nKJu0mZ_OaA>
    <xmx:kKtmZ7_wAxl7jJfOrluyU7KRjo81kArm1PvFO5KoiAmQu0Sc7EMVtg>
    <xmx:kKtmZ9msqjVzONfLTPdY2L0ok14x9-FD8ApPO2FkDcKMlfQBEkNWMQ>
    <xmx:kKtmZ0APTP6HJ77NzAqvFu2QIu9aujzXI0dba1MErfp6PvKlUqnzUN2M>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 21 Dec 2024 06:50:39 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 684618cd (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Sat, 21 Dec 2024 11:48:40 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Subject: [PATCH 0/4] reftable: fix out-of-memory errors on NonStop
Date: Sat, 21 Dec 2024 12:50:06 +0100
Message-Id: <20241221-b4-pks-reftable-oom-fix-without-readers-v1-0-12db83a3267c@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAG6rZmcC/x2N3QqDMAxGX0VyvUAtxf28ythFNekM26w0dRPEd
 zfs8vBxvrOBchFWuDUbFP6KSp4M2lMDwxinJ6OQMXjnQ+u9wz7g/FIsnGrs34w5fzDJij+pY16
 qDZG4KA5nuiSKrrsGAnubzZD1X7o/9v0ABIWld3kAAAA=
X-Change-ID: 20241220-b4-pks-reftable-oom-fix-without-readers-c7d8fda0694d
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, 
 "Randall S. Becker" <randall.becker@nexbridge.ca>
X-Mailer: b4 0.14.2

Hi,

this small patch series fixes out-of-memory errors on NonStop with the
reftable backend. These errors are caused by zero-sized allocations,
which return `NULL` pointers on NonStop.

Thanks!

Patrick

---
Patrick Steinhardt (4):
      reftable/stack: don't perform auto-compaction with less than two tables
      reftable/merged: fix zero-sized allocation when there are no readers
      reftable/stack: fix zero-sized allocation when there are no readers
      reftable/basics: return NULL on zero-sized allocations

 reftable/basics.c |  7 +++++++
 reftable/merged.c | 12 +++++++-----
 reftable/stack.c  | 47 ++++++++++++++++++++++++++---------------------
 3 files changed, 40 insertions(+), 26 deletions(-)


---
base-commit: ff795a5c5ed2e2d07c688c217a615d89e3f5733b
change-id: 20241220-b4-pks-reftable-oom-fix-without-readers-c7d8fda0694d

