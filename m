Received: from fhigh-a5-smtp.messagingengine.com (fhigh-a5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F89C31ED75
	for <git@vger.kernel.org>; Fri,  5 Dec 2025 12:58:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764939489; cv=none; b=HFFalqOzWUF9FRap5Huqt2AfdjCsMakFsgB+wO25yHnDbu4hyOoizsohscYhKN0un9BbvoP75pvuqcZTjNOrKRpLWWBK2MgZJH/rSWH2CEuHiHcFMO8w5q7Jjh+a0a+RSZaBseJcQQcEoQP8yW4WBNjd1lkIxunC08SJFV63fbo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764939489; c=relaxed/simple;
	bh=E2pXlwXlvAP/jBz/R1V6dL4wVAN74aolfy5xTQt30pc=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=nYmLyZc3tGsXu5RS4rWzs7/eTgAnRsuAT3ZSsAvfD6naJhV7gt5bUClRshy8SB95hYkiA6a5Atj09uY7MtHsTBWOX4lxllLoy12lpn/OLf27N9/HIjoyjjXBUfUOTeKIBhdc4/PLSAwYKMCDQBlIU+KliyGH211Uo+t4mm5yoFs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=tYvUz1wF; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Y/JEOpFh; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="tYvUz1wF";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Y/JEOpFh"
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 0CB3514001D4;
	Fri,  5 Dec 2025 07:58:04 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-10.internal (MEProxy); Fri, 05 Dec 2025 07:58:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to; s=fm1; t=1764939484; x=1765025884; bh=nGAma5nFfV
	u83Yd7DOC3bxd747vtHM78yOKZjdxueqg=; b=tYvUz1wFLUYepJSD9WlqFO2PCk
	YSf/OtfjipqglGQtxECC8c8YI73l0VIVaol1bque0j6bnAD6vI8KmwefwV9Nqdwj
	Q2/zbcCtKKwoU7WLrU2tEK6/H84HLqH84LpOXAd4wNps6kY2MIPKwH/2Wasq2LKM
	OIo9m3SKA7nf3arpUalBgYKuOoUXOK31NmuS3LzU6m8omzAcOCAeYJcAxx6rY2re
	xlvEbAE/7Nd0aNR0XS+iw+ZXinauqkuTbpRL/Om+sWkBjDDJXIX9TnhfT5FIW6x7
	QSZi3ZRO9/9a3V1K3ZQDBqT2ZqUBj8HxrlqqOnIrjf64hyKWpdWyzdMtqfrA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1764939484; x=1765025884; bh=nGAma5nFfVu83Yd7DOC3bxd747vt
	HM78yOKZjdxueqg=; b=Y/JEOpFhDfnhVj0HyuWZPst48g0rs6izLcWE+ypoWcUG
	RDNvK6aEGIOLi+2872bc+9PEU7tos9Ucb121Ys2DvIdxfu9NFsj5rtynxdiYWu1z
	lGMjROGT1fffzMSBTocxH2q1JXjk3gJEFVXC0NVyGcYoAQgO/u5BkRwQXzB7GN22
	BNVFL/cUFMUpd922a5AqY6xE93re9j/FwFZnNbxgJSznV+iXRfaOwZZJFdkYjhR5
	6P66MNelHTd5ExAsA7gprAWQMB/BSzQxhFtehe3NSOPaQlObL8VrSaKLLCZL6lfE
	7DGVXFbST58bNj91bMSsIvrYBCyQW02xBc7YedQRCg==
X-ME-Sender: <xms:29YyaUkuuqxXznLuMiCk_aBqnywPxcAtp6hwfId2wM2I9vnEhStp-Q>
    <xme:29YyabRC-XsmTR4uX6ocZOyfXg7AdNzbzWhOXMxb_3OcUXjESFwHdoUTZXsfmN6ER
    L-iiqVc5I1RLtmwt_SCB2lSCRqju2g68cr9i9GPAcHviULBt91a7w>
X-ME-Received: <xmr:29YyaQAnfYUvQLwtkjacKcYHZvBsbr899sdZLwu89IBBkApssOt2W06BH96ja6zMfeg7As7tn5CpKag7g1NKoiyMQ9l-TcTA4Wd0IEDrZuc>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdekgeefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceurghi
    lhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurh
    ephffufffkgggtgffvvefosehtjeertdertdejnecuhfhrohhmpefrrghtrhhitghkucfu
    thgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpeevue
    egkedtteeigeejueehuedugfevleefveehueehgfetffffvefhuefhueekveenucevlhhu
    shhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrih
    hmpdhnsggprhgtphhtthhopeefpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehp
    vghffhesphgvfhhfrdhnvghtpdhrtghpthhtohepphhhihhllhhiphdrfihoohguuddvfe
    esghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdho
    rhhg
X-ME-Proxy: <xmx:29YyaaQeHiQe-2JL-5pOMX3NJhbjE_KfBjs_XY5XbjNE8QEP6V0NIg>
    <xmx:29YyaWrf61GpiSW7Tsy_rXXJYcqzeGoP_OsPuho_TCHhNgZ1ixygbw>
    <xmx:29YyaUzdcLge4HXNmYlf94TY2fzej2MQwJMKXoIN6XUj63TPPfAxOw>
    <xmx:29YyaTKLw0YA16DHHdFOSPcR1VoKRivbwBB3y2Qj9DsnElJf4qseig>
    <xmx:3NYyaY_hmm3umPoK3460BropQ4cRbv-aEeQCU-qaV1pnVa6qDT9lWIGD>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 5 Dec 2025 07:58:03 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 185e3926 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 5 Dec 2025 12:58:01 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Subject: [PATCH 0/2] Update clar for improved integer handling
Date: Fri, 05 Dec 2025 13:57:51 +0100
Message-Id: <20251205-b4-pks-clar-update-v1-0-fd70aac2ab90@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAM/WMmkC/x3MQQqAIBBA0avErBuwoaC6SrQwHWsoSrQikO6et
 HyL/xNEDsIR+iJB4FuiHHtGVRZgFr3PjGKzgRQ1FakGpxr9GtFsOuDlrT4Zazcpok61hi3k0Ad
 28vzTYXzfDwryrkdkAAAA
X-Change-ID: 20251205-b4-pks-clar-update-4fb022908ced
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, Phillip Wood <phillip.wood123@gmail.com>
X-Mailer: b4 0.14.3

Hi,

this patch series updates clar. Most importantly, the update contains
properly typed handling of integers as well as a set of new asserts that
perform relative comparisons, like "less than" or "greater or equal".

Thanks!

Patrick

---
Patrick Steinhardt (2):
      t/unit-tests: update clar to 39f11fe
      t/unit-tests: demonstrate use of integer comparison assertions

 t/unit-tests/clar/.github/workflows/ci.yml         |   2 +-
 t/unit-tests/clar/clar.c                           | 146 ++++++++++++++++++++-
 t/unit-tests/clar/clar.h                           |  82 +++++++++++-
 t/unit-tests/clar/clar/print.h                     |   2 +-
 t/unit-tests/clar/test/expected/quiet              |  40 +++++-
 .../clar/test/expected/summary_with_filename       |  42 +++++-
 .../clar/test/expected/summary_without_filename    |  42 +++++-
 t/unit-tests/clar/test/expected/tap                |  88 +++++++++++--
 t/unit-tests/clar/test/expected/without_arguments  |  42 +++++-
 t/unit-tests/clar/test/selftest.c                  |  10 +-
 t/unit-tests/clar/test/suites/combined.c           |  65 ++++++++-
 t/unit-tests/u-reftable-record.c                   |  22 ++--
 t/unit-tests/unit-test.h                           |   6 -
 13 files changed, 519 insertions(+), 70 deletions(-)


---
base-commit: f0ef5b6d9bcc258e4cbef93839d1b7465d5212b9
change-id: 20251205-b4-pks-clar-update-4fb022908ced

