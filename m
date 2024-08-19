Received: from fout2-smtp.messagingengine.com (fout2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DFB812C52E
	for <git@vger.kernel.org>; Mon, 19 Aug 2024 07:48:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724053684; cv=none; b=H6/do/bIgdall4VkQE4CHaeA2eIWJToXN86NXwJ0dZEd66t4CO+alE0SbViTql8r2aKanyDIB3vKMftbbQlD3otsvGe1yHuVNlderEHuNuU1wuQmGzyYxv/wy1DbGdVeT7xc+iK+jVc+Rwz457eu+LVtEGHQZvCxFimCBsGp3iY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724053684; c=relaxed/simple;
	bh=VHze4qHcknoWZ75Oyb9Ea6mF9VvVfRCrmcudJMZWccI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JhvaF5vLCHD556Xp9X5Ib/j7erVT5pQBCNQOlxrmCPOKig2B3sxZPN7jirY9JbGFsox7KG/cHWjrwN6O4MZdeMj/w93K/aanY2W8pQe9q12g12mrDGJKQp1K4wDPtzFhebOesIhoapwaN+VuqLMP+NbSCNDtbbyJVJatXwk6B18=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=lAR4E8ps; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=IuRMyhoG; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="lAR4E8ps";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="IuRMyhoG"
Received: from phl-compute-03.internal (phl-compute-03.nyi.internal [10.202.2.43])
	by mailfout.nyi.internal (Postfix) with ESMTP id 84883138FD25;
	Mon, 19 Aug 2024 03:48:01 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Mon, 19 Aug 2024 03:48:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1724053681; x=1724140081; bh=TKpbTSkP5N
	U7XguIHHHHlBc1IOVZiMPPAtxaaoqHA90=; b=lAR4E8ps2GFcCDDr6DbRwIdPjA
	WypvG1P5osgXxJH2DHp7K9/GobWCEUH1BzCh1iZtKsBTbzHkNsFOJxEqH+yr3qe/
	mWUXd0yrt8E1GgPeu/XMSkNgBYqBV3vLZJNt5YUzV7cjr2hlVMv6uoXjYoeeZRXu
	ryiKfrgMljaBM4AGG/VmNecrIyTHaflxewl/1KzB4OK6XWu8hOy0188a7LzYXdYG
	xbEEZ9+CG8NTnBoQzA6CpZZ4eXEDn4pJP8B489r6bILMDXoshpBDLOdg0xMCpdA5
	Zh/DphHZ1ByeSgUKJo89uM0XpGhrvw3antYRGTsfvMLaUK1iay+4WsvKdd0g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1724053681; x=1724140081; bh=TKpbTSkP5NU7XguIHHHHlBc1IOVZ
	iMPPAtxaaoqHA90=; b=IuRMyhoGgnvknHxjJSK/yqn8le7pPq96dUZxCgDWiUEY
	+0z7oRvsrqru3UlgZBJ3eDnc2qanX7Wq1O3V3OY95PQbRnY2nTiC/k9DHzAF1qOH
	XBJX6rbsPtyj2Jm20ffIYEpZWDgPFqk28rLb65ho9zinPA7JhsjbtGvWheXdl5IS
	26CQClNeCoLgJgQs7lFgrxfaHDjO6LkSKaJ/LeJhLx8FgThiVglDbtQt8u1cXlv6
	KfWOJjrhnKqTQm1bkhJzh+j4yU6Ail6lf0BY8cB9et5u5yVOMKtRxOS08YHafkI/
	vNm6GZl5oBtHPfj0F8K/Ty3vqGXVXFH6SAjKDzxOmA==
X-ME-Sender: <xms:sfjCZh4nV2IaySI7A_BLw-3PGSn31Y6TRwMayksmgKhPZae8TDJDEQ>
    <xme:sfjCZu633offsJFC2Mify1oH3Wba8bJbVDufWwi2JbNvwoEuvcBRxxXGHCF1jMKSX
    TuUb8b5OsVOd4lUQw>
X-ME-Received: <xmr:sfjCZod83N2_aTpP8kMw0BA1MCPwcy5jV-uy4UM5Vp-gd0AJDMOaAkkidJ4EZNKxXFuZDDO7nVEA2jyaIBD8XFDfbBlNscv1IMjL945e228ldiU>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddruddufedguddviecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddv
    necuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrih
    hmqeenucggtffrrghtthgvrhhnpeevkeekfffhiedtleduiefgjedttedvledvudehgfeu
    gedugffhueekhfejvdektdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmh
    grihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeeipdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpd
    hrtghpthhtohepphhhihhllhhiphdrfihoohguuddvfeesghhmrghilhdrtghomhdprhgt
    phhtthhopehsthholhgvvgesghhmrghilhdrtghomhdprhgtphhtthhopehjrghmvghsse
    hjrghmvghslhhiuhdrihhopdhrtghpthhtohepphhhihhllhhiphdrfihoohguseguuhhn
    vghlmhdrohhrghdruhhkpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:sfjCZqK7GbKEbfOKy52sxuAd3KUAlRd1X88eOSskLuSwit5sXA1EpQ>
    <xmx:sfjCZlI0JKUTvBFgekMXmVjT-EotXiw-VVdrbkMIHKVtP8R6O5XCHw>
    <xmx:sfjCZjyP6q8Svs6sYdm5MPO3M3BIiYX1yYAUPOOrfvOmG6v4WnprDA>
    <xmx:sfjCZhJ2fClt1JkTzxFgfRBgGy8d1VSl9M-F0FxSfcWkBz_nsZdQ-Q>
    <xmx:sfjCZt-PdEtRMc8Dm8qNJiB1nzKsK64qs-YiPRZP4bFnAIZju8fH5khH>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 19 Aug 2024 03:47:59 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id c2ea1930 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 19 Aug 2024 07:47:29 +0000 (UTC)
Date: Mon, 19 Aug 2024 09:47:56 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Phillip Wood <phillip.wood123@gmail.com>, phillip.wood@dunelm.org.uk,
	James Liu <james@jamesliu.io>, Derrick Stolee <stolee@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 0/3] Fixups for git-maintenance(1) tests
Message-ID: <cover.1724053639.git.ps@pks.im>
References: <ZsLjcjhgI8Wk2tIV@tanuki>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZsLjcjhgI8Wk2tIV@tanuki>

Hi,

this small patch series fixes up the test flakes and issues on Windows
as reported by Peff:

  - We now wait for git-maintenance(1) to run to completion.

  - Instead of checking for the detach logic via the output, we now have
    a new trace2 region that allows us to check whether the detaching
    logic was executed.

  - Fix another bug that caused the "loose-objects" task to emit the
    packfile hash. This is a preexisting issue, but Peff made me have a
    deeper look at it.

Patrick

Patrick Steinhardt (3):
  t7900: fix flaky test due to leaking background job
  t7900: exercise detaching via trace2 regions
  builtin/maintenance: fix loose objects task emitting pack hash

 builtin/gc.c           | 11 ++++++++++-
 t/t7900-maintenance.sh | 28 +++++++++++++++++++++++++---
 2 files changed, 35 insertions(+), 4 deletions(-)


base-commit: 98077d06b28b97d508c389886ee5014056707a5e
-- 
2.46.0.164.g477ce5ccd6.dirty

