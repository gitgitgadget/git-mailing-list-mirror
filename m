Received: from fout-a2-smtp.messagingengine.com (fout-a2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCE9F291C0D
	for <git@vger.kernel.org>; Mon,  7 Jul 2025 11:08:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751886535; cv=none; b=MY0jgjA6RRkgdtLwlhLaJQ4oQRLiogxmpcmzvvXDuorsKoy/qWxb8kmun389tDml4RCOO/owknUjR+0CPUI2yIlve51MHH+FCenVG3R8hmFNAC5yrSnjVpuhIeqQvUE3ILGV83WbAH4kvjeSY4n0ndO6Vo6hnST+7YPD+Qr8r+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751886535; c=relaxed/simple;
	bh=XWbvfC7VRPHcCWdAMOl4NJ8/8xp4OEelKtqdfCnk/AY=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=gGXIK19M4Ptcxjs3FGahsEES80fc38TvbCZCETv8TUaMBShmd8D2ENiTcesNjhLVrTZakpsfnzwsaBETxAAmG/LgJvBkra8Bp4LrJAM7OXxLy3e4XgmF+OicJh4NfhEBy4Mwt5Ycs+iOhZQN0/gaIXPgPE3i6rotTrpHv/dMNF4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=GbiME9e3; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=nqrRlLfi; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="GbiME9e3";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="nqrRlLfi"
Received: from phl-compute-02.internal (phl-compute-02.phl.internal [10.202.2.42])
	by mailfout.phl.internal (Postfix) with ESMTP id CCFD0EC07BC;
	Mon,  7 Jul 2025 07:08:52 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-02.internal (MEProxy); Mon, 07 Jul 2025 07:08:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to; s=fm2; t=1751886532; x=1751972932; bh=Rdn6xHHh/J
	Z6yHlPiIINVBW8ZXuMcU9JmPg68EHaHIE=; b=GbiME9e3VKhnMA65XvDzqEM0C2
	cUef8UciGYc3sX4A5WqKHxPasvPECEfo+jaquZVq9f5VBEEokXAbXViXpwmq5VmB
	EfVFvpDV35SBb67xsN3P5TImw4JLV9z+9iSSyQXxdq+6ZmEhaSZlc5BdkhfV1rWi
	36r+AirZor199Ql37ZaqU2yUWau8uU+71pALQY5zs/wmvaoPCTnaFfJd7dwBqmPN
	sy8c4Qc9BtJ1lNCdYcCVJXfTDHDqRq+PT2WeIXM3AbY3hxDxuV8ke7+OGjy42J47
	w0m321OlJRHyv0BQVy/GwMPOKHU6JXvQxV3BYf/oTzWtU4jQGIFFYBbhyyTw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1751886532; x=1751972932; bh=Rdn6xHHh/JZ6yHlPiIINVBW8ZXuM
	cU9JmPg68EHaHIE=; b=nqrRlLfi6sjKFHVWP4bSpH5fp6cOAZs7+i1CkwhIIAL5
	3Y/B6UlCvdb/xMR6brEqLr93+7bnsC3GlB/aHtiimBm5Pb/faGqbnmxEKO5QGnnm
	XF6XlOvCKMciHcZObZUFPLsExQtCzU1s3oiZ5LyUYUlnb5usW0s2Dt5MiL86PQk8
	cl0fwZZVpyIFEQlBZoe1jHTNJp6Fs0Rs57NJ0KZoc18fmYBUAb19Cj4sfH65X6qz
	cAGcLMejuwafEaSf+OVv9c9JmgZ0fL6z7s/ZsHpL8l0iqlFQlL7WNxfvt95u5YYw
	LxFkpY52xURMd/TIo5zac/2SZ+J50eb6+u9LJYA3wQ==
X-ME-Sender: <xms:xKpraGke1TcBnQl1i-2A91xiE1n650Xdd--zfysHQdTsgcIDMMpRtA>
    <xme:xKpraBFRWopJOoD_aZbMgy_Ed1Z5u2K_7v2BL0okjcUDam1osuVcQkbjsiFahcHk8
    vDOC-vQaYoF8axG9A>
X-ME-Received: <xmr:xKpraOFNwG-49ndhcGXHCCJbGkoOmOg0WjFw6lIkm9fCsYG8ZxV4c1D2CnFTqh9p538Ugcfjtvf6hNlHPAbWbK07sefQFTrQ_Ng0OV9aAw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdefudeigecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecunecujfgurhephffufffkgggtgffvvefosehtjeertdertd
    ejnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdr
    ihhmqeenucggtffrrghtthgvrhhnpeevueegkedtteeigeejueehuedugfevleefveehue
    ehgfetffffvefhuefhueekveenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhep
    mhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeefpdhmohguvg
    epshhmthhpohhuthdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhg
    pdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomhdprhgtphhtthhopehsii
    gvuggvrhdruggvvhesghhmrghilhdrtghomh
X-ME-Proxy: <xmx:xKpraGPKpq5CB-nbXUA_zjeOF3RvKt94GCH2mMOmaGhGXXp5slozOg>
    <xmx:xKpraFGfrq6FcJ_KVJAAaWvu3TJ5aMK84Nt20N-geV3hOWLjAvX2-g>
    <xmx:xKpraFOl-81GJRcgILlR_GlyfzHtysQ4dD5pvzUVaayea6mY9qUtiA>
    <xmx:xKpraO-2YJD4DbfmPKtto3SLlXuTseYhfVXh7U46fkIk48XXWCRIAQ>
    <xmx:xKpraNtkB7eKOUwVyOmljULnFDBmslSuoAYAyk2_L4bGwaUsUO8V7BVM>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 7 Jul 2025 07:08:51 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 7db53160 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Mon, 7 Jul 2025 11:08:50 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Subject: [PATCH 0/2] t: fixes for Perl-less tests
Date: Mon, 07 Jul 2025 13:08:32 +0200
Message-Id: <20250707-b4-pks-t-perlless-fixes-v1-0-92b2de1c3dd0@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIALCqa2gC/x3LQQqDMBBG4auEWXcgBpuUXkW6qOZvHRQNGSmFk
 LsbXH48XiFFFig9TaGMn6jsW0N3MzTN7+0LlthMzrq7DTbw2HNalA9OyOsKVf7IH8p9jM49bIT
 3ntqdMq7Q5uFV6wmRoVjpaQAAAA==
X-Change-ID: 20250707-b4-pks-t-perlless-fixes-4dd2280de666
To: git@vger.kernel.org
Cc: =?utf-8?q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>, 
 Junio C Hamano <gitster@pobox.com>
X-Mailer: b4 0.14.2

Hi,

this small patch series addresses two issues introduced by my
conversion away from Perl in some of our tests, as reported by SZEDER
[1].

Thanks!

Patrick

[1]: <aEiNBwUkjbo2QlFY@szeder.dev>

---
Patrick Steinhardt (2):
      t4150: fix warning printed by awk due to escaped '\@'
      t5333: fix missing terminator for sed(1) 's' command

 t/t4150-am.sh                   | 2 +-
 t/t5333-pseudo-merge-bitmaps.sh | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)


---
base-commit: 8b6f19ccfc3aefbd0f22f6b7d56ad6a3fc5e4f37
change-id: 20250707-b4-pks-t-perlless-fixes-4dd2280de666

