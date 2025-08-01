Received: from fout-b3-smtp.messagingengine.com (fout-b3-smtp.messagingengine.com [202.12.124.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A0201F4181
	for <git@vger.kernel.org>; Fri,  1 Aug 2025 14:47:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754059680; cv=none; b=qTK/h3qCchfuNwnTUB7SheRwQ4hzMxVkGadOpZ9sLiNgFDkr1z65zLdTOF8B58lvuoGd8L97Qk8hhiUiRFzr8gv4xdGx4cx1+KE08sgnmjN+qyDkwAknjVCXCMmAhnDIf+hWkP7vg13XmmXSEinjrEmRUEWNsJkOhfzLDZBio8w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754059680; c=relaxed/simple;
	bh=HJMZZ9MTLfvoI8DMWgGpCOhTNFyvEZ33Km/wu9WqQQ0=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=PGWBppDvQye2nRgZGswOIM3L6fYn2VUAyeFxEV8jDwFfG4SJR4u8IFzERIxy7eA/GI+4hwsIp8Ij+kYUAMyzasq/ocyjFno1CYObJ5P1LjNmvZTqAk1ZfwM3Va0ycCblHHpunHcrnn3Po7+f25iqKUdJ85X4PPkmxaur3VwKT7g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=MFKHsFGS; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=VAkm4Nfm; arc=none smtp.client-ip=202.12.124.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="MFKHsFGS";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="VAkm4Nfm"
Received: from phl-compute-12.internal (phl-compute-12.phl.internal [10.202.2.52])
	by mailfout.stl.internal (Postfix) with ESMTP id 38B081D0086D
	for <git@vger.kernel.org>; Fri,  1 Aug 2025 10:47:58 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-12.internal (MEProxy); Fri, 01 Aug 2025 10:47:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to; s=fm3; t=1754059678; x=1754146078; bh=JKPb3ZB6Rv
	KXtFp7GILQt5ChMS6OyRgSbn0CZI2ns9E=; b=MFKHsFGSBJoZvrZzcCvssjK1Xd
	mPTLFFfMN2ZFGO681YmcUTg4tM3vDvQn+CXeW3dk0YSGuXK997L0B+4mDWQRPKPI
	ys7WJSFxDugwN4wDeNtk1t/u/abwAlaqgI7G6RmuFT5xACawQZDTFBUTsOteINxD
	qKZH9Aq8M/f6101mgHNLVmtQvyKxoTbRmEkY97qgUx3bhX86foczlF5mEmhZICBe
	BOvBlF6lupL4b1V3d63e4DYAAWZ7oWg67FmchyTv39lVNKzOWrErPOa4PRG/zdCt
	SV0TcX2rTVNUDPRrINjAh6IinkblYPJE14KuBSrsjMyMgTIUhQj8K/WnOgMQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1754059678; x=1754146078; bh=JKPb3ZB6RvKXtFp7GILQt5ChMS6O
	yRgSbn0CZI2ns9E=; b=VAkm4Nfm+KIIKfW+PviQWHy4Td5PEePDXwzpW3cTek/r
	b8EUNurusNZyfsAftbKHT7jYmveMehjlqSSQip8tBtyF1GrI0GSK5K5leQiM8ZgT
	zFLPLocu5KxOgM8ZqXjTpidM406wE1vgU/XpA+P4DhgJHzGcHZU9L51Q+tVjkrnG
	ovwUpGdfyOek4hY0I8l0DscX26j9JGa20n4YEB5w4HkYQufCWwXklX3lLSZ+YTea
	fCtuJdHYp4QZYA6BByRnxaO8gETypZVzQ55KgW8F+JNcWEsI4AZ0HQmfFX9vGDlA
	T2TAJnkq/xo0rcMaCfKE+qmWBh/JXic1QlCv4BsL0Q==
X-ME-Sender: <xms:ndOMaEqJqACr-whHvpFnn4T3-6-vdNYHRXE69YMQAduXnwnyh6xljA>
    <xme:ndOMaMpbdevbXk6XbGOCWQpOgilJj271op_4f2gVvSdHY65m1iF_6gJbNryiF5Nr1
    SepJd7AwbQwrfdmeA>
X-ME-Received: <xmr:ndOMaCkSHeTsMlW9l4Q2KeaLnpv7twHXIm5Ipge_UWb37GsUFpJQ29nLhwdBr68SuHFguAzDvQ-OLF6nP6WiHtzHPUtOPCUNs7c1v1J82UDy>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgddutdefleejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefhufffkfggtgfgvfevofesthejredtre
    dtjeenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhs
    rdhimheqnecuggftrfgrthhtvghrnhepveeugeektdetieegjeeuheeuudfgveelfeevhe
    euhefgteffffevhfeuhfeukeevnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghm
    pehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepuddpmhhoug
    gvpehsmhhtphhouhhtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhr
    gh
X-ME-Proxy: <xmx:ndOMaOGGoislNZsYWplllzPn880LKer701U1iJvLBQzgPd51CniKnQ>
    <xmx:ndOMaLqAeNC-neTgb1DmPrOmWNnETlbU4rWHu7spzvcBTx_10-ytuw>
    <xmx:ndOMaK70bA17N2E8d6h2Tv9Bh3OwmSbrgZG8TdUX2cJJ423KT_mXEg>
    <xmx:ndOMaJ4hNOhpBzcWfiDmZmRpiOhh2fPJMDQ6I_5RyDuysjLIdmfN4Q>
    <xmx:ntOMaBAmcalhbNX8z1S-e--oplf-ju-kiwRJPLLjbt9jjA7mYHkZzuZl>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Fri, 1 Aug 2025 10:47:57 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 5c9b70cc (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO)
	for <git@vger.kernel.org>;
	Fri, 1 Aug 2025 14:47:55 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Subject: [PATCH 0/5] reftable: a couple of improvements for libgit2
Date: Fri, 01 Aug 2025 16:47:46 +0200
Message-Id: <20250801-pks-reftable-fixes-for-libgit2-v1-0-f446e1c33cb9@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAJLTjGgC/xXM0QpAQBBA0V/RPJtaqxV+RR52mWUitCMp+Xfj8
 dbpPiCUmATa7IFEFwvvm0aRZzDMfpsIedQGa6wztSnwWAQTxdOHlTDyTYJxT7hymPi06CobGtd
 4V5kSdHKo/ZE+uv59P4zxi2hwAAAA
X-Change-ID: 20250801-pks-reftable-fixes-for-libgit2-562b959a5603
To: git@vger.kernel.org
Cc: 
X-Mailer: b4 0.14.2

Hi,

this small patch series contains a couple of improvements I required for
libgit2. With those changes libgit2 is now able to run its full test
suite with reftable-enabled repositories. I still need to invest a bit
of work to make it memory-leak free and compile on Windows, but overall
I think that support for reftables is almost ready.

Thanks!

Patrick

---
Patrick Steinhardt (5):
      reftable/writer: fix type used for number of records
      reftable/writer: drop Git-specific `QSORT()` macro
      reftable/stack: fix compiler warning due to missing braces
      reftable/stack: reorder code to avoid forward declarations
      reftable/stack: allow passing flags to `reftable_stack_add()`

 refs/reftable-backend.c         |   8 +-
 reftable/reftable-stack.h       |   9 +-
 reftable/reftable-writer.h      |   4 +-
 reftable/stack.c                | 366 +++++++++++++++++++---------------------
 reftable/writer.c               |  23 +--
 t/unit-tests/t-reftable-stack.c |  50 +++---
 6 files changed, 227 insertions(+), 233 deletions(-)


---
base-commit: e813a0200a7121b97fec535f0d0b460b0a33356c
change-id: 20250801-pks-reftable-fixes-for-libgit2-562b959a5603

