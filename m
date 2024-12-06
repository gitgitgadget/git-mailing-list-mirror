Received: from fout-b6-smtp.messagingengine.com (fout-b6-smtp.messagingengine.com [202.12.124.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3BEE201010
	for <git@vger.kernel.org>; Fri,  6 Dec 2024 10:27:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733480863; cv=none; b=SlxxuF6Ha6V37ncyL26b//8ZfYNtiOOopYuNOA5FONagaEfxHbvgvRs/8zdvWv0Y5IO3tTB8MuSd6xNQRG/zvSd6RhEva/FoPvAjCuerRUBasj4ptdJ3Nh2ieThoQLfIxJQR7V1ub4hXfo+A1Hkh1yFY7c7Hq+84+rax09/83aU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733480863; c=relaxed/simple;
	bh=KB1iPDo37816jUbxvuR2sy93KKs96H5bcCpgcFLXcXY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=lHFf9w2hhkDSF5lOw/0zSsLslBrL4FWwqNBfFd26124A53mNtNisoayMUDnslYWLPKGA8lAZIofZ5+yRRUUCOAY7LTAX7xHLl+3N3E3MM3grKNsCEin/1zZl6VNq4gO+krOd+RACBoEcTt00p6ReYkYLzlEGD+BKa/2aGrIv4yg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=aBJNLkLu; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=AWiyPwFh; arc=none smtp.client-ip=202.12.124.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="aBJNLkLu";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="AWiyPwFh"
Received: from phl-compute-12.internal (phl-compute-12.phl.internal [10.202.2.52])
	by mailfout.stl.internal (Postfix) with ESMTP id C2637114017A;
	Fri,  6 Dec 2024 05:27:40 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-12.internal (MEProxy); Fri, 06 Dec 2024 05:27:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1733480860;
	 x=1733567260; bh=a6Rz2IryRT8K18I8oNDuG+1cT2TDOOc6NtZ42HoqJMk=; b=
	aBJNLkLu9wNV125U3ss/z2t4KW2j0eaMMFhE/02hcUI2hZren1W+TzMdPSY1zILc
	j5RefulBqPgoxPFMkM5pjY9V05TyY2YFa5A2dLwOoA69FGjUQHuEOFWNMgtgYdau
	3XGs//ggbfo+dGrouLQnXoGiaMBf6IaYEpFIhn2yNu4EleWQASIGmF4VLh9eD0/4
	IlcLj2HxAlf91MqmK2rtLi9DggyGjVlz00FS2RyWKC9oG5FvjsIKEwq8HKEGWRvP
	Zr2cxGQv1BMook75sApdg/NbPdcZ7lm+cUwjMJjr5PBjspboz3N67LpjWOkioCay
	sJBprMhlhz1XYzkG3JPu/w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1733480860; x=
	1733567260; bh=a6Rz2IryRT8K18I8oNDuG+1cT2TDOOc6NtZ42HoqJMk=; b=A
	WiyPwFh0tJIalCbSXFc0nYhzqzeoD9K85PVLje1lA/lzpXv992Cjnf5MXkhbyyyY
	zbPOaaFMdnjJVwcM2jggNWzcpEQ58aQR3SZzgDwPOi1v4Xv368QSn8JwUCxO0AuR
	71zB9jMzG74zp19VGUHNCGmr01Ev/yyhA36G0AhU7m3NqE2vbjX49SKBU2YtI11+
	aZAXGyZcbowMOTCzDHbIHMSF5SrAksm1oEM7JGeFN388nUEX6jMxIGCuOu+/mv8M
	G1y1xxjn1nnLTb/D8bxvPQTK+SRoiAzZht1PtvOv0wNGEWkWNcDJ2rKOQQHtGzJ3
	OQopf7kE3sMJWmOppFO/g==
X-ME-Sender: <xms:nNFSZzosquq536fxc0w_G3xyLQRw6v3geUTUmEuMajtGM3axJtUZOg>
    <xme:nNFSZ9oMnye-crgzCUXFOkzZ7cDavFtMQ9cKrdBZOsMp1pMdytOcGYg8ut9ffzOjC
    pCJK2WGasNjZyyaXA>
X-ME-Received: <xmr:nNFSZwOtnKBBhbVXI6w6-z7oOm0zWlkApDBOgHN7ppTPXTRE9hItEst6BVeT0HsHXLYvZgDKjcfiz25KHHnIGpOu0gd_H-mE7YQw5GHPXnNicw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrieelgdduhecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecunecujfgurhephfffufggtg
    fgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhn
    hhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpedtueekgfehtd
    egleeukedvkefgtdfhfedvudeiueelheelgeeujeetvdfgteevteenucffohhmrghinhep
    mhgrkhdruggvvhenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfh
    hrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeegpdhmohguvgepshhmthhp
    ohhuthdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpth
    htohepphgvfhhfsehpvghffhdrnhgvthdprhgtphhtthhopehshhgvjhhirghluhhosehg
    mhgrihhlrdgtohhmpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:nNFSZ27IzYPLJubeuBgr7dIYDGxKBiOZwfquEyeNrJA08Cw31sivgQ>
    <xmx:nNFSZy7vXGbdwcpMx9lGjhZVfzWpr2mOcgofqZv-CAn2uiSKur_pBw>
    <xmx:nNFSZ-jGw_ct8cBw8lfGFS-f-SpS27NEjKYFa5f6oIag2RQmoWXZhg>
    <xmx:nNFSZ06yjWPmPxaxunio0SdVEDPrfOb3dX4tXxJPqA0SMtJE6NkG1Q>
    <xmx:nNFSZ938OWM9M8be0ZMIXKc8u5dYJ65mDfBW_NfDmU98Zfo7eRQURCgn>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 6 Dec 2024 05:27:39 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 1d05b8f0 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 6 Dec 2024 10:26:15 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Fri, 06 Dec 2024 11:27:20 +0100
Subject: [PATCH v4 05/16] config.mak.dev: drop `-Wno-sign-compare`
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241206-pks-sign-compare-v4-5-0344c6dfb219@pks.im>
References: <20241206-pks-sign-compare-v4-0-0344c6dfb219@pks.im>
In-Reply-To: <20241206-pks-sign-compare-v4-0-0344c6dfb219@pks.im>
To: git@vger.kernel.org
Cc: shejialuo <shejialuo@gmail.com>, Jeff King <peff@peff.net>, 
 Junio C Hamano <gitster@pobox.com>
X-Mailer: b4 0.14.2

There is no need anymore to disable `-Wsign-compare` now that all files
that cause warnings have been marked accordingly. Drop the option.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 config.mak.dev | 1 -
 1 file changed, 1 deletion(-)

diff --git a/config.mak.dev b/config.mak.dev
index 8eca7fa22823b46ebdf02b73d53031784fd5ba2a..0fd8cc4d355ebb7428e1d8258154926dedf8827b 100644
--- a/config.mak.dev
+++ b/config.mak.dev
@@ -53,7 +53,6 @@ ifeq ($(filter extra-all,$(DEVOPTS)),)
 # These are disabled because we have these all over the place.
 DEVELOPER_CFLAGS += -Wno-empty-body
 DEVELOPER_CFLAGS += -Wno-missing-field-initializers
-DEVELOPER_CFLAGS += -Wno-sign-compare
 endif
 endif
 

-- 
2.47.0.366.g5daf58cba8.dirty

