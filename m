Received: from fout-a7-smtp.messagingengine.com (fout-a7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B29B1F3D5B
	for <git@vger.kernel.org>; Tue,  7 Jan 2025 15:27:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736263633; cv=none; b=mZknNzJse7X9O8pK+041p/CIgM7WBnnbIeILT5hCdybGz3drUimPlJUE3WWA7b5fKaJM210jL5Nlc3h9+FX0FE+VOYHLvx+422DfD86UVKdHu8br3btrvbiPHsli1wQew2BciG7rNX+8ieYAAFHZNQBn3p66ipVuHIYqdJrnCYM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736263633; c=relaxed/simple;
	bh=PTt2QQy+Vlp7De5brRFSlohbEUcyt+B1D412X7SEj/Q=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=ryrzhdfssxN1758O1re8gbNr6vfLjKuGG5ySFzmdKvoFX1tDWhO+MMnaK/8NcAgsA71Oy9E6bmlApUA2s+Geln0sr/NlYXi6emkbZcIgfdYaw2YrtON9xDosANwjbYWdGmXPXHhJxd3Npozk/sTQWKOtH9FfVlmAT6bUH8GqfPo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=ETmSDPFo; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=vlnhWVbW; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="ETmSDPFo";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="vlnhWVbW"
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfout.phl.internal (Postfix) with ESMTP id 1BD6B138016D;
	Tue,  7 Jan 2025 10:27:10 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Tue, 07 Jan 2025 10:27:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to; s=fm2; t=1736263630; x=1736350030; bh=Pj7DMJ63c3
	ieBcsjx136CEujSvXcb0Hg0hxue1qwNJc=; b=ETmSDPFon7uNLjs6BYcxMv015I
	WUxHyxRim/GWuNjSXA+118CF0EHfr62EIBIVRgxsjnwqp+ZhXBSM2p599yXZL/ha
	Ew26KSQdvbrUG76HjvlB3SnAfRHPFwQgJeMaFft/UQ91PxapJuSFDMJ9QAcI3Dp4
	5oUwXZ39CkublIHAYgvltSNCMds2CJy4gyvAKxQ3mkIGNmtQS59nA/MXsgiS4Pmp
	P1puSsyDNE1KMNHczhg5+TRDs7zJk3A8xsPTIXq1ESFi2V21Tpzv0q0xYqgk85R1
	ATBOHQgOSUpO8515oz+JwcYpwhk4A68kflPI126lhKQT6lXQrCDW83nX8rCw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1736263630; x=1736350030; bh=Pj7DMJ63c3ieBcsjx136CEujSvXc
	b0Hg0hxue1qwNJc=; b=vlnhWVbWGw6w8Kpin4qLUltnsqa5MR/iObUcUaPNY2yr
	llwIzof4laka1q0ft8T+7FugLNpGuL9xTDCXYi5p8ZKfzXKHhBb7f9c1zlmKvYW1
	GD3viJR/1czvk+2HSCweUfNQiCEMNeQ9ttKsl5VSnzV1dr36ThNfi60U7kgWVAtl
	iiNt1qZ0iS1/bMN/orN7jb7ZvZo+0bJ63rMY9Wunug7mGpOT4q41ddap0Dys/SWG
	8TwBFVVYu6xHEr2adiodTXuB7XPUPNaEDXD9ibTxY+NTVZy8donoH7j7DjTYzRe9
	wH7I0lzW6DGp3+9rUNPy2eSDYX7t2PKOV9z+DSHkng==
X-ME-Sender: <xms:zUd9Z6zFm_M9SCgJvNb1vjL0hzvY0ueZsNVCTG7WDihVGdtVtUCMFQ>
    <xme:zUd9Z2TOcVfe6Jt6pKsPQLO1qPDxWCsUuhSb3cXkBmUl8X_94INBF7iEfbSo1M7tf
    t1pQtwDLTu8-MIa6g>
X-ME-Received: <xmr:zUd9Z8UQc24hJjOD2xPV9bHYYuinb8Ww2r0X3jGuhyGJTbv-ESkhIjnGJAzWoFUCTcG7C1zWxW2DYTtjTtohnpSLDIbGErMr5TJ3kTD6jb-VfA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudegvddgjeehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhephffufffkgggtgffvvefosehtjeertdertdejnecu
    hfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqe
    enucggtffrrghtthgvrhhnpeevueegkedtteeigeejueehuedugfevleefveehueehgfet
    ffffvefhuefhueekveenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrih
    hlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopedvpdhmohguvgepshhm
    thhpohhuthdprhgtphhtthhopehrrghnuggrlhhlrdgsvggtkhgvrhesnhgvgigsrhhiug
    hgvgdrtggrpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:zUd9ZwiOjvjNRkOWVTb7M5HY3MggoyOaiQngwP12G01_KCox1AndHA>
    <xmx:zUd9Z8Bt8QN3gQvlvn3znbtnbgsG03uYuOlY--N0Uc2ctcqWWnpkVQ>
    <xmx:zUd9ZxLXTMToSAFGRIxdCn4okhZBtnMU6atSvQ1tXSWj6vzt6NHd2A>
    <xmx:zUd9ZzBQJ_EbQ1JbRIM0o-cp8PlF2wYkCHCVYrCTxmZ73rzoBiSCXA>
    <xmx:zkd9Z_Ny1E75AbljMuYZog6PSiauR-ZFGBk27LGCuuAEVw6gxDE4cqAS>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 7 Jan 2025 10:27:09 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 70c8b33d (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 7 Jan 2025 15:27:06 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Subject: [PATCH 0/2] reftable/stack: stop dying on exhausted entropy pool
Date: Tue, 07 Jan 2025 16:26:58 +0100
Message-Id: <20250107-b4-pks-reftable-csprng-v1-0-6109a54a8756@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAMJHfWcC/x2MSQqAMAwAvyI5G6hacfmKeKht1KDU0ogI4t8tH
 gdm5gGhyCTQZw9Eulj48AmKPAO7Gr8QsksMpSprVagGJ41hE4w0n2baCa2E6BfsyGlqnWsrqyH
 FIQl8/+NhfN8PbZzKDmgAAAA=
X-Change-ID: 20250107-b4-pks-reftable-csprng-9ed4e8dd83c4
To: git@vger.kernel.org
Cc: "Randall S. Becker" <randall.becker@nexbridge.ca>
X-Mailer: b4 0.14.2

Hi,

this small patch series fixes the issue reported by Randall [1], where
an exhausted entropy pool can cause us to die when writing a new table
to the reftable stack. I _think_ that this is only an issue with the
OpenSSL backend of `csprng_bytes()`:

  - `arc4random_buf()` never returns an error.

  - `getrandom()` pulls from "/dev/urandom" by default.

  - `getentropy()` seems to block when there is not enough randomness
    available.

  - `GtlGenRandom()` I cannot really tell.

  - The fallback reads from "/dev/urandom", which also returns bytes in
    case the entropy pool is drained.

So OpenSSL's `RAND_bytes()` seems to be the only one that returns an
error when the entropy pool is empty. I did wonder whether we even need
to introduce the new flag in the first place, or whether we cannot just
use `RAND_pseudo_bytes()` unconditionally. But I'm a bit uneasy about it
given that OpenSSL has this doc:

    RAND_pseudo_bytes() puts num pseudo-random bytes into buf.
    Pseudo-random byte sequences generated by RAND_pseudo_bytes() will
    be unique if they are of sufficient length, but are not necessarily
    unpredictable. They can be used for non-cryptographic purposes and
    for certain purposes in cryptographic protocols, but usually not for
    key generation etc.

It might be too easy to accidentally rely on `csprng_bytes()` where it
actually requires strong cryptographic data, so I was erring on the side
of caution.

Thanks!

---
Patrick Steinhardt (2):
      wrapper: allow generating insecure random bytes
      reftable/stack: accept insecure random bytes

 builtin/gc.c                        |  2 +-
 reftable/stack.c                    |  4 ++--
 t/helper/test-csprng.c              |  2 +-
 t/unit-tests/t-reftable-readwrite.c |  6 +++---
 wrapper.c                           | 24 ++++++++++++++----------
 wrapper.h                           | 16 ++++++++++++----
 6 files changed, 33 insertions(+), 21 deletions(-)


---
base-commit: b74ff38af58464688b211140b90ec90598d340c6
change-id: 20250107-b4-pks-reftable-csprng-9ed4e8dd83c4

