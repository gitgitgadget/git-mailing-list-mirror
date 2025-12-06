Received: from fout-b2-smtp.messagingengine.com (fout-b2-smtp.messagingengine.com [202.12.124.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93296222585
	for <git@vger.kernel.org>; Sat,  6 Dec 2025 11:47:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765021678; cv=none; b=T6CcdJDQdfJNr0l5xN7ChsXpjdowze+9tEmPTv15b7XKGoZopx8SOJ/q+lyaHLEDlaGETLQDqbE2bZMMcNs4ILjm0pIq1hj6dFouM8m8RO9MP7EaMKaOun3oESI+nhv6rxcJHu/l2HnRAP+JJQY2kixEYDDGjeJ16FfJ/s14VOQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765021678; c=relaxed/simple;
	bh=T9Th/8u+U0CVDxPif65zd9R0GU9EEWIcr4W00zgNGuU=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 In-Reply-To:References:To:Cc; b=e4H2C01QvHQCtuWlSj8V0t/nKz/sYEuLnrRJ9zjQ03t+37k4wR+Qak6hJVRVsZ8MhSdIZ260bk2bU++7+IuuWlSwinn2BYmN3FaHZTvmEhIqxNnE+c9uQbyTPmmv2X87XwG/a9tzgE4teXaIIsidTmlUJYOh1sQcQOrpN56/Hh8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=nNIj6VNT; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=EvsKaKtM; arc=none smtp.client-ip=202.12.124.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="nNIj6VNT";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="EvsKaKtM"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfout.stl.internal (Postfix) with ESMTP id B5F8C1D00141;
	Sat,  6 Dec 2025 06:47:55 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Sat, 06 Dec 2025 06:47:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1765021675;
	 x=1765108075; bh=B9dcCg/hA4KJm/m4hN1QNHcvK0SVMPJ1zylNw6mhzv4=; b=
	nNIj6VNT6rgDSHLtDTG2iQ2VoyB0pTklDEBTuuY2fRuem1jtW2NYTMBg+SJJA0bj
	CAHfrlJcsxFj5yU7PxG3Cy7GLFDmEHYwyCTFFaCCrg5Az/Y8FtIfimZ/IIYKcDv1
	k5fh/85Ly9cpPqapoL1CPaMyxdi38Kckn6sjNLjZNBO6I06uYHqI1+HHm6Xo3nws
	2nOC7hnQ3bEvYZR9bX4ehpry6MXKwKt2TlrUpLXaccVPmyDsd6K03qTO7ir5+GXh
	xyBitvrj+CYjUF43gcxkm+SdkXQ9T1Q7r1etFG+MIz/AzZTCniIedREjfhdJunbZ
	KbiSYnkvSBWWwQfqTzZC6g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1765021675; x=
	1765108075; bh=B9dcCg/hA4KJm/m4hN1QNHcvK0SVMPJ1zylNw6mhzv4=; b=E
	vsKaKtMbdZPGvQ/vAb2aCM0iynS2050I49bSjjuisfnAw0qsQztB5wHbgPcYnrvl
	5w97FspkfgPSzAljkyRxF4BdKLjaVdXL6K4heZRTD2SRGanq2pwTiPh1mqoxUjta
	6S1j/5NpAoXrdGALkSAKEBoYmCIbP8lBrHZvlqVoqCo2let5U3K4sY2G8tBA2dwL
	JHY3jqlnoEl8AEn84VA7Q5bsW+xNt9M3eH7FfJjiERTpO6YxS6LdFFDI/6lsoOrL
	IxHRDPozBkkW9I4FXfU+i6th17+RFSjTZqhQklpiZlbDu6uSOXd8ke33w7fuazNZ
	t5XNd7YAKO1IW10UIifOQ==
X-ME-Sender: <xms:6xc0aeYnw0YDeDPvjdT8cOpTj1Wgp1q_4vDJxl0QLhsAAmix3TBdvg>
    <xme:6xc0aYZhJxaSLOKGIW-YXyH1ymWUwzuSAQWt656TgMvL26PTNyxQCakDWsM3V7rqi
    Ut5W-gOISW4R-BLbdMOsfry0uYvJ_73dLy3I03DrelgIZLwQM0lYOE>
X-ME-Received: <xmr:6xc0ad_31Fl4ml6CcY-4EXngITGux78VCJcP1Z38ccIuH6iGMiiaW-GEMuuiZLP2Z_TiXE6KGUi90c0L9WG53yfAwxMM2CjYbdZY4jVP>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddutdekiecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhufffkfggtgfgjghfvfevofesthejredtredtjeenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epteeuueehhffhiedtueehtddtieekfedtudehtdehfefhgeffveeggedthfehuedvnecu
    ffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpedtnecurf
    grrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeeg
    pdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrd
    gtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphht
    thhopehphhhilhhlihhprdifohhougduvdefsehgmhgrihhlrdgtohhmpdhrtghpthhtoh
    epphgvfhhfsehpvghffhdrnhgvth
X-ME-Proxy: <xmx:6xc0afjxE1Mvr8CD5b2GSW5h3-S6o5R2EDmYaigVkt4qKS6KqPTQAg>
    <xmx:6xc0aVcMxBiqftL3TP-HzV2g9pA0HiJbpG7JJg3mnFdViTWTWpZDiA>
    <xmx:6xc0aeq4Wc88bFQ-sCiac4mpp9-OAoJwsW_9XUrJqW95RKQB-2LZTg>
    <xmx:6xc0aSAL-dDkAZMoY1FLQthcsBBNaGHJ5xNdX80aA52VIO4dzV7BHw>
    <xmx:6xc0ab5gmHMQ7Njw5K4xZOVXBn3XJJrafZ51Hmo7-vUcrl3Bb2QMLqTn>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 6 Dec 2025 06:47:54 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id dcb4004b (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Sat, 6 Dec 2025 11:47:53 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Subject: [PATCH v2 0/3] Update clar for improved integer handling
Date: Sat, 06 Dec 2025 12:47:31 +0100
Message-Id: <20251206-b4-pks-clar-update-v2-0-9a14b10c1a36@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIANMXNGkC/32NSw6CQBBEr0J6bZumA1FceQ/CYj6NdFQgM0g0Z
 O7uyAFcvkrVqw2iBJUIl2KDIKtGncYMfCjADWa8CarPDExcl0w12grne0T3MAFfszeLYNVbYm7
 o7MRDHs5Ben3v0rbLPGhcpvDZP9byl/7VrSUS9v5Exjg2tqFrbhz1CV1K6Qt+rqtXsQAAAA==
X-Change-ID: 20251205-b4-pks-clar-update-4fb022908ced
In-Reply-To: <20251205-b4-pks-clar-update-v1-0-fd70aac2ab90@pks.im>
References: <20251205-b4-pks-clar-update-v1-0-fd70aac2ab90@pks.im>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, Phillip Wood <phillip.wood123@gmail.com>, 
 Junio C Hamano <gitster@pobox.com>
X-Mailer: b4 0.14.3

Hi,

this patch series updates clar. Most importantly, the update contains
properly typed handling of integers as well as a set of new asserts that
perform relative comparisons, like "less than" or "greater or equal".

Thanks!

Patrick

---
Changes in v2:
- EDITME: describe what is new in this series revision.
- EDITME: use bulletpoints and terse descriptions.
- Link to v1: https://lore.kernel.org/r/20251205-b4-pks-clar-update-v1-0-fd70aac2ab90@pks.im

---
Patrick Steinhardt (3):
      t/unit-tests: update clar to 39f11fe
      t/unit-tests: demonstrate use of integer comparison assertions
      gitattributes: disable blank-at-eof errors for clar test expectations

 .gitattributes                                     |   1 +
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
 14 files changed, 520 insertions(+), 70 deletions(-)

Range-diff versus v1:

1:  58f8836bde = 1:  d709d75f25 t/unit-tests: update clar to 39f11fe
2:  1b4e93d5b4 = 2:  6b56ad714e t/unit-tests: demonstrate use of integer comparison assertions
-:  ---------- > 3:  a1b6aec468 gitattributes: disable blank-at-eof errors for clar test expectations

---
base-commit: f0ef5b6d9bcc258e4cbef93839d1b7465d5212b9
change-id: 20251205-b4-pks-clar-update-4fb022908ced

