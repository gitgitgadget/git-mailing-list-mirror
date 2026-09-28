Received: from fout-a8-smtp.messagingengine.com (fout-a8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7820947ACC6
	for <git@vger.kernel.org>; Mon, 28 Sep 2026 10:41:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790592100; cv=none; b=gjTFasxln1yrmYZfKdD1+TsAZssJQYCLxhfOKoD2HxfLelChOe2TGBD063pcjdOoDnduGrAgbLpUx5JFidvPyZZ0sizhhDQrIrcZrCcvXvi3leWAgswMtcLhJ6UuNMTbWgVJb5ACk2bjxDhNv06COiGkS0PMNC1yqVDomD4yoc4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790592100; c=relaxed/simple;
	bh=Up8YzfWrVv1OlZMbSwLow+uXBWFgKi9C9BdP3LbENxw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=qwB6+XyIa3ftl6UkZAObrlInVM6/GQsClgW2+ARGLU5LNC5yxIITipe1u5OKqxSjbMSF0FmzTjy3SsM5wk8Nq5izUHv0fjoAUCxGw2EgkxjC0EK5agjex6s3eSINAHXF0PJI+Nn99pUAerJB0umMBaaLT3WJKINBOa7h5LOrneI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=QD3g3DxO; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=LZtxSkm+; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="QD3g3DxO";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="LZtxSkm+"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.phl.internal (Postfix) with ESMTP id 7ACEAEC0182;
	Mon, 28 Sep 2026 06:41:37 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Mon, 28 Sep 2026 06:41:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:message-id:mime-version:reply-to
	:subject:subject:to:to; s=fm1; t=1790592097; x=1790678497; bh=ih
	VEtQFRw+/KuY4C76O2EHfqdAGLu1GImoyDZhhBpCc=; b=QD3g3DxO/64uo3+ItO
	d0zJom55JdJAx0y1/lyOrlR/E97iDx4ZR569W17sg/LjwAaSSF6/R2AWcI6j3pkE
	ny1xgpzCXsv19LkTqkD3jDonIwkzXVgXIB7LbEW/Y2eqYHoGL9ipkNHdL6+TuJLc
	Haq7u5s4alKtAUB0wT+SxKwUhMKeT98MGCH/XnJ+CBbDNIC4PnQyHfN1XK+gfCQm
	wpDUCB8zBQeNjoGI3XlxMrRbtPa8wshBJe3dqrpx1YJEbrC6OFUNzE8qU7pfPwhf
	968D46IZsyRDb2kDk7ctx0tzSO0tGT+y5YD/44Zw3F7MR+YbcZnm2vux1j4nnPkL
	kqWw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1790592097; x=1790678497; bh=ihVEtQFRw+/KuY4C76O2EHfqdAGL
	u1GImoyDZhhBpCc=; b=LZtxSkm+naEWmSar6nF0VslXyUAnCjIs4Y69zhlMAaKp
	L6D6XacaaM/59JGsmNy4fPsS5ICy0kNv+83w6X5AdvfklSjP0qSZT0gkw7nuH/hW
	GGsoUg3Yg/h5qTNr+bOemXyhQijEYfEnARg+0vYH7HAq079vLYoCHr/HN0Qfgoi9
	LyatD92gVESQdU/VOexEtqySgglMNijkJQx88rEIvKQ9kV/AYI4UykgUly7Uwdh1
	H2RJngWKMNeAlPUG1q0DOr+VJtT38CW8DRbyPJ+/acdQlZyyJ1gE/Q7lnWin18K8
	HKgljBFo9wudgbetqEykbgvgqOr1CHGyScVtSEujDA==
X-ME-Sender: <xms:YUS6aixfk0HWs-t--mBVaceVIXyJjBNSFfU4_Jq8yePxnBtI1daiKvw>
    <xme:YUS6alsFo-kY0kQyD4nBroGwYct1HaT1DQgry29w79AzituYWNsgOMNMf9tWk_s6Y
    XrmHHjg2lPfecqk0GX2qFZ3Oc0dMaMargVvDUrFU5qyJprn1kMXCw>
X-ME-Received: <xmr:YUS6ahsSm_8N5dyOHI4PJtB3brLSL0PsUQptYVnEWmD4BLjFlcCmE8NUPTmfBJEECHpC48LMBtRzBQtwkjLw7rg3FKrD_7ZI44hawaU>
X-ME-Proxy-Cause: dmFkZTFrEXdjGZL4M5LjzTdSt/qBmcmp/FGogSofAaqZSBoEqLxYgQ7E7hT6YP/7PLVF7h
    rtvuBHsO50SWAQ9AKwlV96pZ294bVUpiNDacewk+UA8eM1/RwmY/j5qwQd9fTHPiylDTr5
    zMX96M0MQzUvQpN7cf2L3wOrsQFb+1bNOvu6YHavJQPyp/KDWJ24JS76Cgxoj3bgLO15u3
    v/1PkWA1hYZnoY4KzRy5goMtTJwhmKANCd+adDNFOFN7r+CT+zFkR9q9j1zxkeZusSeVu4
    zaLI7Cno4UdvwFfjE3+AYtIrBBX08fVAqbo30bKlDXCOaFeI4qr9lFviSbv7HiIeKBUECU
    aVexum58DKp4WDwvcPprVgTnTBBIW+JJTTZCw2iQUvoh6z4lZ46OqTh8c9GGWrJYiyiQY4
    YPkMkSOEHPr6fx6ZtzSdCrTpKoT9dsjZ+mKPAVGTlpYwcvyTOcI0C+Rr+VQxlS1ZsPzR9g
    433Vi9sevn61zM8aNiSOeCyrTVK3taKypIkro61eqMdem/gtwHHQ2b+z6KteGBVuG7HRfa
    4UtRieHaGzA9XZKTYlB7SPPVdlOvXlYT4M83KHH2VbQIaNgmd/lsTJ5F/m7sg0aR88ePqk
    55owXZC6BfGpIo+9iHw09NIBPoDgJHItyFvIRIVaCfD+gvfIud93cuLO90rA
X-ME-Proxy: <xmx:YUS6aiN7-SojFGWeieVs1khf8EDzXbO2jhOqM1O5O_uCmCeR-RwCZQ>
    <xmx:YUS6an1bgLmW-M3i2ppDK9MPkwY8wDCBL2lN2WK5yoaX2O5dcCZR3g>
    <xmx:YUS6amPDphVpuZ22Xgr4xBu20KW0qFm8W6wlC2ZhSF4s-Ksu3hxaIA>
    <xmx:YUS6av0so3KGAXw9PeZcDYSudQ9KxH-McMJ707MvvwvcCNmJqiBrnA>
    <xmx:YUS6at08C99k_jXMsoxeMFVgsDTd0x8PjTMyPsBTF41qlP95rsUTE5zb>
Feedback-ID: i8b11424c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 28 Sep 2026 06:41:36 -0400 (EDT)
From: kristofferhaugsbakk@fastmail.com
To: git@vger.kernel.org
Cc: Kristoffer Haugsbakk <code@khaugsbakk.name>,
	Patrick Steinhardt <ps@pks.im>
Subject: [RFC PATCH 0/4] doc: move BreakingChanges to a manpage
Date: Mon, 28 Sep 2026 12:41:24 +0200
Message-ID: <CV_gitbrchanges7_please.d1c@m5gid.xyz>
X-Mailer: git-send-email 2.55.0.793.gc667de3f2c5
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Kristoffer Haugsbakk <code@khaugsbakk.name>

Topic name: kh/doc-gitbreaking-changes7

Topic summary: Move BreakingChanges document to a manpage for easier
visibility.

Users are the ones who are impacted by breaking changes. Certainly much
more than Git developers who are already plugged in to the development
channels that discuss the trajectory of the project. Advertizing the
planned breaking changes to all users will help the whole Git community
prepare.

[1/4] doc: transform breaking changes doc to a manpage
[2/4] doc: gitbreaking-changes: replace msg-ids with URLs
[3/4] doc: gitbreaking-changes: add note about living document
[4/4] doc: git: mention gitbreaking-changes(7)

 Documentation/BreakingChanges.adoc     | 360 +----------------------
 Documentation/Makefile                 |   1 +
 Documentation/git.adoc                 |   5 +-
 Documentation/gitbreaking-changes.adoc | 387 +++++++++++++++++++++++++
 Documentation/meson.build              |   1 +
 command-list.txt                       |   1 +
 6 files changed, 395 insertions(+), 360 deletions(-)
 create mode 100644 Documentation/gitbreaking-changes.adoc


base-commit: 0f8e75abebff0877cae681a3d5ff31ac47f54220
-- 
2.55.0.793.gc667de3f2c5

