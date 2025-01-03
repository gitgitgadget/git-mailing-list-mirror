Received: from fhigh-a3-smtp.messagingengine.com (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A7F31C3BF8
	for <git@vger.kernel.org>; Fri,  3 Jan 2025 08:19:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735892401; cv=none; b=DYHIp2FjNp8pMD7TVYR5q3joFPqdHqFIoChsHZ3CoCMLjl9kmSOqroZEMhlDlY46eSS2g4epcjHUoUuhaau+sjcGK0jYXPSPrSsdS9VaFugMRRTtVRODKZJ/d/a2PwLVGT2NsiHiN75aw7Sx0G8PPq97P5pbs87eEuYMBjU3bug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735892401; c=relaxed/simple;
	bh=wiTtGOMboaTkVD8Gp1zt9Vlrw8Dg/eRHtxdzpyMOIf0=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=TOJ8K7CCn0w0sChnczfzMAZhzsAUjBr6srqHsRYgrC7Nubu58G7H5GbszBjc1offM+m4zOVLdx1bOGdrzYk63aA6PIpy6H2+TXmy5dNzW1zsAyh3gLCf3gHNy9uiMgXNtSB6F834DoUlihnpCioL80xS5UJp+4AQVWUxIgNMurY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=ivPX3CSg; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=VFVFxoFf; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="ivPX3CSg";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="VFVFxoFf"
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 5112F1140224;
	Fri,  3 Jan 2025 03:19:58 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Fri, 03 Jan 2025 03:19:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to; s=fm2; t=1735892398; x=1735978798; bh=nZpZ7lj+9B
	Y3wAEvu8Bf1m+F/xWpWy1g7txsbde8NcU=; b=ivPX3CSg43I0j1CFrWzQlJFTD5
	MM4RUKcskKCyg9o8rA5u9bWW+JRBD8fd0Mcdny3gUeThF2z60FSXiO6xcM+hCS2H
	PKUnUDDuTToAwCIv60f4vdo8zAZGSmc2mqPp+g63301mSwH+3kzlkEke4wKt5cMe
	z42xOaRu/MsFMEuh3F15D6i9QOVkXRqy37JE9qVQgq1z4G2C+ES71HZpxOlNsu3/
	onnH+N2yjY36qXL9fZtzmmBouWqzETc52KaxxXzZwQukjlRuOZYnlaL7p9izUdAn
	hpYLgujX9IBHQHUxESdx5t5Fpl07QL0dTNSyO0j51ZFnDgmxBGqYEbPgLGPQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1735892398; x=1735978798; bh=nZpZ7lj+9BY3wAEvu8Bf1m+F/xWp
	Wy1g7txsbde8NcU=; b=VFVFxoFf8UaySTmnvh4mbbEgxM4vwSJLMBDpQG4bQBCQ
	q9HuWWd6ausdHxxaQraQmoXIU9dzX1dhVlgUD3mKZU/0+2RMuuyQgod1cnthhI3s
	EfInAff5ulit81x50WOF3PjjK6HTxmTrTpSqiU0PmHypVjpRl4pktULqJQG7a7CP
	CI5tmWYGPDibba/35sKeZD7Bt1STfDe0GJVw2LR8qJnsxyXrMlSQ4RufxIQM7yaa
	Vc+Gf4sNFXruKVqt19Ts1DN3iTYcPiMGJDoj6HynF+g0HVCU33bA4pBQhqUzOrXv
	DDyH4th+lbdA/Sjh0TQqDZempzLOCHODZX4GgiioYg==
X-ME-Sender: <xms:rp13ZznxifvfqwSVDb-Rh_PMxnTB1A34rV0aXJez-6vRz3eMIrg83w>
    <xme:rp13Z20H9x52RmHYkDnR8DQR97d6QOvtityvZJhSWm1U42m4kmXa0qrVoCcU6EYw1
    TV1ZX43dVY4CvS3IA>
X-ME-Received: <xmr:rp13Z5pvtnV1q9GWTEruCyZaDKId4khLuorv7x6-dMKq23N06-nEYemoAnBfIb1C54GJzOQra_Bd56yxYtq15IBpg12ISWKtOuNEW1GzYhoeL_0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudeffedguddulecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecunecujfgurhephffuff
    fkgggtgffvvefosehtjeertdertdejnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhn
    hhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpeevueegkedtte
    eigeejueehuedugfevleefveehueehgfetffffvefhuefhueekveenucevlhhushhtvghr
    ufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsg
    gprhgtphhtthhopeefpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehgihhtsehv
    ghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepghhithhsthgvrhesphhosghogi
    drtghomhdprhgtphhtthhopehpvghffhesphgvfhhfrdhnvght
X-ME-Proxy: <xmx:rp13Z7lMzbn0BYprBvroP3qQRicyF8h0AHNkG0a5Lh6EZ6gJEnUcQA>
    <xmx:rp13Zx2lJ_RFV2veqMyHnro24MNzEXjz1jqRTqPhQXuWNIEmP9Jd5g>
    <xmx:rp13Z6v323D8cDrzN77JBkbph9wU2c7uUlwbt6nGBp7vVrh_Hpbz6Q>
    <xmx:rp13Z1Wnbbyonv_vqeOPFyvpxh143MKeENfW7k99qWQth-Omkh9Qpw>
    <xmx:rp13Z6yHjRHJ3TFZ6CDHuqg0dj-CS1l71myrsLBP0BSwd2VApePEBhIW>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 3 Jan 2025 03:19:57 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 0ecd17d0 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 3 Jan 2025 08:19:56 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Subject: [PATCH 0/2] object-file: retry linking file into place when
 occluding file vanishes
Date: Fri, 03 Jan 2025 09:19:53 +0100
Message-Id: <20250103-b4-pks-object-file-racy-collision-check-v1-0-6ef9e2da1f87@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAKmdd2cC/x2NwQrCMBAFf6Xs2QdprIX4K+IhWTd2bWhKIqKU/
 ruhxznMzEZVikqla7dRkY9WzUuD/tQRT355CvTRmKyxF9ObM8KAda7I4SX8RtQkKJ5/4JzSYYM
 n4Rl+HFwI0Y3eWWq1tUjU73G63ff9D2tJQyV5AAAA
X-Change-ID: 20250103-b4-pks-object-file-racy-collision-check-a649bbf96a92
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>
X-Mailer: b4 0.14.2

Hi,

this small patch series adapts the race fix for collision checks when
moving object files into place [1] to retry linking the object into
place instead of silently ignoring the error, as suggested by Peff in
[2].

The series at [1] has already been merged into 'next', so this is built
on top of 1b4e9a5f8b (Merge branch 'ps/build-meson-html', 2025-01-02)
with ps/object-collision-check at 0ad3d65652 (object-file: fix race in
object collision check, 2024-12-30) merged into it.

Thanks!

Patrick

[1]: <20241230-b4-pks-object-file-racy-collision-check-v1-1-11571294e60a@pks.im>
[2]: <20241231014220.GA225521@coredump.intra.peff.net>

---
Patrick Steinhardt (2):
      object-file: rename variables in `check_collision()`
      object-file: retry linking file into place when occluding file vanishes

 object-file.c | 61 +++++++++++++++++++++++++++++++++++------------------------
 1 file changed, 36 insertions(+), 25 deletions(-)


---
base-commit: 2be278337fd02495a86577a89fbf9387b2df6523
change-id: 20250103-b4-pks-object-file-racy-collision-check-a649bbf96a92

