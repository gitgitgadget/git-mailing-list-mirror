Received: from fhigh-b4-smtp.messagingengine.com (fhigh-b4-smtp.messagingengine.com [202.12.124.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2970D38F226
	for <git@vger.kernel.org>; Tue,  2 Jun 2026 11:59:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780401575; cv=none; b=naQeMkGw2MG91fjDXcol2r2hXaLpsLzyQWokE3srfAj5zQCdpLIJW0WEBPv9sYLC6nITyHPc4PCE/sH6B2udgDF6qtAeo0jLij8zKjM/cFkR0XSJVWhnHglKSbV5S90BuyhLxECMTXOGRvLYgbZJLJr/y/zND9Zm2SEIsaoriTk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780401575; c=relaxed/simple;
	bh=bBROM1JBX0YpzmS8ZoOgJR3fEANa5Y4vuhvuCwhXFNU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Bn4o0whWfxkFZCZerEfLW5KmARL5+OJ/HJzJz8GYSICFi220/de4FO2NgsOd5WgYbuc9AJOUpB7fjw2ZG9KWhqM1EXbxfCQqxhqeuH5dMpPPv8XjG8QbiFAnbvsyT5xIaVyDuPjD+m76c4I5IY0edFFfNJe7zMp2qFC1u9ZSPYo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=hZwS+ADy; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=dfo1Vypc; arc=none smtp.client-ip=202.12.124.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="hZwS+ADy";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="dfo1Vypc"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 653FE7A0136;
	Tue,  2 Jun 2026 07:59:32 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Tue, 02 Jun 2026 07:59:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1780401572;
	 x=1780487972; bh=YMLLis7yYSW+hMNy5YlQQozYNNDCbZO8Xwtg/VNnZpM=; b=
	hZwS+ADyzceuQ2KiGRiNNibQLzO0/d7YKNbYiBcvSrhYKrDWj1CDwMhrUokSk68Z
	8nVJmKkVBSHOXLpUI/xXpllWY/ajvgL7AKnCJ2RRoMOatM+mrFmUZnMbvqmBw3zA
	m1gZLVXDUJRy+bmz2BG4AUa02ZMtYMraBTJRABVzaTiH9IGeRISTBj0klv52OCbV
	MXtLD4BMqINRi5V7ENwV9xLP8BBDS68EljShdDsmXepYRdrp3Kg0kEfa0eQJ9rKh
	a/Gkiy5BR7IOEvaegSMNawQXbjV1AE5h/gXtPhcbAzFWy3ntLU7CprsBIBshBQR1
	LJt+J4gicPYC9FAv6rGCAg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1780401572; x=
	1780487972; bh=YMLLis7yYSW+hMNy5YlQQozYNNDCbZO8Xwtg/VNnZpM=; b=d
	fo1VypcKdxESKcC4yAgyOrvbrgMcU6pZm2qACz+I8nuqyg2XKf2c1EsVIVlNJuE0
	RysZb4hMX8MOHaBL2mYCl2OD4ulY9b9qlVT6mOz66/JvnMk/02q5p/FGDPXuNsLb
	4ICQhvIHiB3rBLybE/fYlAFZ4y88AFzJAcQ66CXn0R8qWSKdo974GM1xiV9tOfTj
	dXI6RgEF/K9JEJoqtNGzKu33BxXBO3q+hMDblZ6CCLxzywK7UdsCDixFW91AsvSv
	QmZrh5Qdz4CFHR7t8qWytZnDV3TMuy8dTP42U4TNj8pm+DeE7oAsyT3s8efvLfwD
	7PQQrKsInTr+7vk86O6cQ==
X-ME-Sender: <xms:pMUearVsRv99xc6HjxuyhKkpGaP2wsYLrEKhaYE0u6B3rO_O5K86TQ>
    <xme:pMUeajzdy1e_D9s0AtDN6TkLwWOOZbe_IlPgHJjrJqEfDIG3lrjkiwPe4Uh2nR2UY
    7ni3JyJslI6yQES_JMmX8bnh9AF6BX_vswE-OXjVoRq8Mj7zx0Lyg>
X-ME-Received: <xmr:pMUeapNju60y3vwTv7uMrPhg88pFsUdk2qA51ZpnkN5ziNuDUTHeSoT71F6mMpch-AQOUWSf7xe3AZUvw-oqWkvyI4OfTh7bRqBVdlAcpw>
X-ME-Proxy-Cause: dmFkZTFspp7G1jWdJHzScggUSqqSC7vDflqwZ44NpFv4e4H3ReS2gf60mYt1j0tA45xUkK
    KlPxujo9YcxhiIdwu7x02Znnp9l/Hbrgzy6lpbZzh+hV42gd+MUDEm0JT9q8x+Av2TxXCq
    oh6k59d2X/fDtUsg6ynMFoHGnfefnSBaE4n9flu/kdq6j+M5IUFaCqmsCTajqtoA00TKOF
    tIeIizPeq6voe/IKcS2TBRMQPN8Wqm/Agt79BznpDRGC1GyLnMpHemjlq9rYQMr/zKiI58
    6PINoRR/NyU3PCGViFkIFbnhb0PKREnT7KeYtc/sT07ik/1UKyz6v4aVvfRnVEBakUIGb/
    uUKJKqxazLvoa+6i70QZihK7rKQenSiClaglvPW8BclQCEaQIkYlCINMVbmRwRGiHZjkfj
    oUb7fkS+bhJlqHJIC34aYn67ztR9DmUpyAE9k/HGBgFOwf4muFNhZWkWDR40IhzRKbDiox
    LKAYD8e4lYrSDeB2Fxp2FR3yLxLhYKHAi3ZYieqxlqTlQ1qSI51jKNarZPZ82eyWmve0Se
    ZZl67isQreIeZly+AATAwPtOwi+c3BpTocKTNKMrArWyiLpK8TGczyMjkPVYugAcFrARFt
    LMcDvC97ojW25IJVEFsnzRz1CY0I4TBuVoMIHN4E7luar8xnqU5vQEuDA5vA
X-ME-Proxy: <xmx:pMUeak71iYN31MRB9SXscOqt4bWDe_NjjB79dMkqm5g-HbKAM8Q0PQ>
    <xmx:pMUeaqNxoVmdpGGbGhpcof-mA-Kb1O5_Z8WsKHkBP0Ba2j7P308UUQ>
    <xmx:pMUeaimHri1JQt_gTgae5w5GulegcR_9fmSI6gRSxBctOHlLFTI6kQ>
    <xmx:pMUeahRaXBrJy1u22ijxbSj_3Je11wq7L_J572g6Sky0kROHl_WJAg>
    <xmx:pMUeat7mPKb01ScZVlvtXdSDi6ICYH4b2vn_hz23OKXt5KK50UwZ4DI_>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 2 Jun 2026 07:59:31 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 894ebdbd (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 2 Jun 2026 11:59:30 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Tue, 02 Jun 2026 13:59:09 +0200
Subject: [PATCH 1/2] b4: introduce configuration for the Git project
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260602-pks-b4-v1-1-a7ae5a49e9cf@pks.im>
References: <20260602-pks-b4-v1-0-a7ae5a49e9cf@pks.im>
In-Reply-To: <20260602-pks-b4-v1-0-a7ae5a49e9cf@pks.im>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>
X-Mailer: b4 0.15.2

We're about to extend our documentation to recommend b4 for sending
patch series ot the mailing list. Prepare for this by introducing a b4
configuration so that the tool knows to honor our preferences. For now,
this configuration does two things:

  - It configures "send-same-thread = shallow", which tells b4 to always
    send subsequent versions of the same patch series as a reply to the
    cover letter of the first version.

  - It configures "prep-cover-template", which tells b4 to use a custom
    template for the cover letter. The most important change compared to
    the default template is that our custom template also includes a
    range-diff.

There's potentially more things that we may want to configure going
forward, like for example auto-configuration of folks to Cc on certain
patches. But these two tweaks feel like a good place to start.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 .b4-config         |  3 +++
 .b4-cover-template | 11 +++++++++++
 2 files changed, 14 insertions(+)

diff --git a/.b4-config b/.b4-config
new file mode 100644
index 0000000000..14124728ce
--- /dev/null
+++ b/.b4-config
@@ -0,0 +1,3 @@
+[b4]
+send-same-thread = shallow
+prep-cover-template = ./.b4-cover-template
diff --git a/.b4-cover-template b/.b4-cover-template
new file mode 100644
index 0000000000..ab864933b5
--- /dev/null
+++ b/.b4-cover-template
@@ -0,0 +1,11 @@
+${cover}
+
+---
+${shortlog}
+
+${diffstat}
+
+${range_diff}
+---
+base-commit: ${base_commit}
+${prerequisites}

-- 
2.54.0.1064.gd145956f57.dirty

