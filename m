Received: from fhigh-a1-smtp.messagingengine.com (fhigh-a1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20F882D4816
	for <git@vger.kernel.org>; Wed,  3 Sep 2025 04:54:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756875269; cv=none; b=Sg1LSK1Fdpqb7cYRCp6RHXprFcsuZP0D6i5+Uz1aZ71wUbUK3a2mNy/2tLXkEtG8zNmmx0YbHnmsXCnLjnpCkIoP9veYXF0qTbZJHXMFUoy7tuuXIhIalCUio+9kB+gjiGZ5DjKn3XxuWOkMrgrSQ1YTb6l9sDTFl8AfrIlUWNg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756875269; c=relaxed/simple;
	bh=PbuTCTZKy1TWCFQw3U2mfcr+ghsGltbuOyHuHwUG2Gs=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=lQs4nVX3W5HZ0lcvi3yvSxN5sg1kBNe6QIg6l9Up6/PcDm/h+JwJrK5qtzJbRtjHJ7/pf36slqjJrBd9QbOaA+SEZhUsLmK2dzs7Hw3txrMM49Fd909mTe4UsKVEa1ZiLn5uNPNbEOfBKFXIDdEI7G7Eb1pBumSyfUjNBC25+rw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=h4duPJYe; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=B2UAg10Y; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="h4duPJYe";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="B2UAg10Y"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 3F3781400400;
	Wed,  3 Sep 2025 00:54:27 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Wed, 03 Sep 2025 00:54:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to; s=fm1; t=1756875267; x=1756961667; bh=skrIiWCFuX
	64BZwfYVAPLEO8HzJ58Y0NsFCeM6Wec6I=; b=h4duPJYeFY8eKT5MNQp10Fd3o/
	q/LiVHolhbhVqtz2lB9E7iY8l8S50CD3aaeNJR7brk3XI82vaBzw/fmbsaxrdA/l
	DV2tFfAak7bmaOFZA3XF18btI7GL7uJIo/C/nhxidJOXYa6u+yzZLG+grdk2AzFM
	C3TxrWeMWN9Sd63APl+kCg16jnyAV2OQyEsdBMbF4S6GG9sEtvoSt9+opn864AS+
	XowZvWstXcQbkZaYDEKjzy0vXTPIVTm9In48adM/6kkzdHaGRIihwOtXUCYAHFxn
	BPXGruao52IjYzm3GnyZIXm+O0LWmN31Gdt2v2mYjY+gaODLyFH6Pzh88GKg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1756875267; x=1756961667; bh=skrIiWCFuX64BZwfYVAPLEO8HzJ5
	8Y0NsFCeM6Wec6I=; b=B2UAg10Yb8ozhnKlyxvLgqeG0PdUDBHIvjvJhPCSorhf
	uH7ShA3AE9dRSu1mcB/OGXSUfCy8rPVWBhC447GaYFCgg5gyZu0YSVfuALd0SElz
	o0FmlJB4CAy0ekhTWzIwEx4i17OUx5fkGS+SpCABUZ6Ve3NjW8EUCeirDpzcvKDX
	CD//CeyuDMxDClobOxVFCRCMT/e4x9Ua6Q3mmhpCF7PBttEb8iHciY09uezLXyv9
	YW1uYwL9Qe3Vt5+hPQHWhZEv+wUZ67MneLNm8fSWtC4kr2gzzzjZ1774yjv9LpYR
	DGQ3ggWrjafvUgZg7/b77J5n04SuYfxAPftt24NHtg==
X-ME-Sender: <xms:Asq3aFaVPOITAya3IowjM8_zW-_7K3ppcyc8Us3SXRGRQVnC_yRuZw>
    <xme:Asq3aG_nKG-vou8z2xrGASn8J7Ka0Z4oZtcSwGq_SIqYPARcJYp-MZYRdj1iRG-Go
    ZrnoA_0raiP8u8OvA>
X-ME-Received: <xmr:Asq3aEhSzImhB3OUO-Ij8gNGTTxIi6RzNMxq3QDpGoPAP9QU7fWu8rsFVvujOpy-uklQN22FtLJhDeAWRXfWOCOEUStoViO4nkhDatU>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvvdegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceurghi
    lhhouhhtmecufedttdenucenucfjughrpefhufffkfggtgfgvfevofesthejredtredtje
    enucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhi
    mheqnecuggftrfgrthhtvghrnhepveeugeektdetieegjeeuheeuudfgveelfeevheeuhe
    fgteffffevhfeuhfeukeevnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehm
    rghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepgedpmhhouggvpe
    hsmhhtphhouhhtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdp
    rhgtphhtthhopehpvghffhesphgvfhhfrdhnvghtpdhrtghpthhtohepghhithhsthgvrh
    esphhosghogidrtghomhdprhgtphhtthhopehmvgesthhtrgihlhhorhhrrdgtohhm
X-ME-Proxy: <xmx:Asq3aGfujDVMw6mDGVXMeLNrpOtlIOAkr6GqWapbtZtARWuZOBXzLA>
    <xmx:A8q3aLpZvNLPhoSkF1NYKLZDqkVwZTMnpTuXPJKE7If3o1Uxp8SRWg>
    <xmx:A8q3aLBjMn77Tss8PrntVcYXRzUMgjOg9b_KUf96BeJlFiTF61aBtQ>
    <xmx:A8q3aIZ4caL7R28eOaB6jDfnxa6Z1VPtzKr6kYan2ffZoMewZiyv9g>
    <xmx:A8q3aBIqlkiABhzsUe5g9rmPph6jeqBzCfBf_IS82FgJtBC4_1Tm37X2>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 3 Sep 2025 00:54:26 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 639684af (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Wed, 3 Sep 2025 04:54:23 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Subject: [PATCH 0/2] upload-pack: don't ACK non-commits repeatedly
Date: Wed, 03 Sep 2025 06:54:09 +0200
Message-Id: <20250903-b4-pks-upload-pack-repeated-non-commit-acks-v1-0-4e019af4dddc@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAPHJt2gC/x2NwQrCMBAFf6Xs2YWkqUL9FfGQJk9dapOQbUUo/
 XeDx5nDzE6KKlC6djtVfEQlpwb21FF4+fQES2xMvenPZjSOp4HLrLyVd/aRiw8zVxT4FZFTThz
 yssjKzSsP4+QuDjYaWGrFUvGQ7/92ux/HD26yOn99AAAA
X-Change-ID: 20250903-b4-pks-upload-pack-repeated-non-commit-acks-49b363e1d0e1
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, Taylor Blau <me@ttaylorr.com>, 
 Junio C Hamano <gitster@pobox.com>
X-Mailer: b4 0.14.2

Hi,

this patch series addresses an issue with storing duplicate object IDs
sent by the client in git-upload-pack(1). If the client sends repeated
"have" lines for an object ID that doesn't refer to a commit, then we
end up storing that object ID repeatedly in the `have_obj` array. This
leads to sending out repeated "ACK"s for the same object.

The series applies on top of "maint" at c44beea485 (Git 2.51,
2025-08-17).

Thanks!

Patrick

---
Patrick Steinhardt (2):
      t5530: modernize tests
      upload-pack: don't ACK non-commits repeatedly in protocol v2

 t/t5530-upload-pack-error.sh | 68 +++++++++++++++++++++++++++-----------------
 upload-pack.c                | 19 ++++++-------
 2 files changed, 51 insertions(+), 36 deletions(-)


---
base-commit: c44beea485f0f2feaf460e2ac87fdd5608d63cf0
change-id: 20250903-b4-pks-upload-pack-repeated-non-commit-acks-49b363e1d0e1

