Received: from fout-b4-smtp.messagingengine.com (fout-b4-smtp.messagingengine.com [202.12.124.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E4C21799F
	for <git@vger.kernel.org>; Mon,  5 Jan 2026 13:16:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767619014; cv=none; b=R2sfF3vhr3FP3BR3VEa5HYFgvu2D40ODVIsnLEnSDqVuiGjXG6bzsaZnFLeeuUngZR8azwHIDd1729re8e4vHHbAETQJKfM+HYkP4GmAYLTstTNsAROKHoNX7iV6eOELlctun5bzf9oUSsAyYP7taH4LX9agybaTyDrQr8B29FU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767619014; c=relaxed/simple;
	bh=Fe3HwfYp5Cn7P282jygebBzMs6SQGCitpy8CqD2v7vg=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=qifruGxbQcm63XjWmPKgTCRqQTpwTo7lwkVV8FTTd3uCoCVTH/ywTr2oWp10xpcz4WEAkQUXJrskDDo0bLjZDuNyx8GDFh28dwswgty636AL0Ch+vVCa17VY68qz3dh/ja7YxDsntXB6cCMn8RxUikZMhO35i6CO+/IbVnGdxfM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=j4Z4JKd3; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=eg5wS7qT; arc=none smtp.client-ip=202.12.124.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="j4Z4JKd3";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="eg5wS7qT"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.stl.internal (Postfix) with ESMTP id 7B3601D00103;
	Mon,  5 Jan 2026 08:16:51 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Mon, 05 Jan 2026 08:16:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to; s=fm2; t=1767619011; x=1767705411; bh=ff8R1YvGMi
	5qzAJ719mshuvjYinTp+AjXqQcFadK2Qg=; b=j4Z4JKd3OfbGQvPrOE9+HsSVxB
	LTQ6ySuOf3i6cAdPzGRJz6m9Yed88if1h/kiDELlLIXil2lmJTis4s3AUnsUFD2T
	niWvOZVM4eWkQps0rcsHq4IU3AsVjhJk3Ib6S8AF9hIZtUPDsvT5NL6QICcb5znw
	yxMAtTMTwGuR6LWBb4Hky/rVY9R3bFAF1sK1j6emcEMSMyGl4T2zzsomkIaB2UBE
	VtgSTITMUtRHWJwRBsYr0a+oaCtICncvZGc+/MXITngNULwddWFHUk+b/iN4Wain
	W8bb0MbJ5pncOfwEUCdcZ/968cs1X5g5uzAeXhqqTYPviLLq6uD4B+upgpLA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1767619011; x=1767705411; bh=ff8R1YvGMi5qzAJ719mshuvjYinT
	p+AjXqQcFadK2Qg=; b=eg5wS7qTmxxAyCaVZPp4di4nJYjiwp26+UAW8Ln651ue
	AzpZ7duPYniU8u+BFpT21xrK7iJZCfJjVD3WGvuZ07BLi7CkbgkenY8K/7CGYxTh
	XscEqNBdEx24hswmzgpx7fcIw4ik5ZAIF1mdvc2zcESrDPgBYMYcxLqe6iHZ2xG0
	x1zv2rxtgdqsuARSJS8zl5EN3NxKBEGq4Ot4qg5oer0aviAkaWZF1+rsKCRRVXOb
	LJLn9FYJ+FA0cqKIUqYDlv5A/3cPa+yvCEkMpIvlyVPf7a92rBJK8UuWBcb1Ff7G
	lcPeLhRBVmWi95K4OwIjqgwalV+U3fGk52ughZ7iLQ==
X-ME-Sender: <xms:w7lbaYAiHz_IkXMfyF2wzMtcZHy8fDXEoHjHub4oV5kiAm0g8_CrOA>
    <xme:w7lbaQhQ1H-AAg6b85dGFt2fRtpDEjKsM4R0b5KCxxnj3-maktuS5amiJaMlmT6kL
    fIvh9ZbgmC17chkz6i4YVbusAP3yDc2jBLU8W2mUnW7l4OlJYpaIg>
X-ME-Received: <xmr:w7lbaZM59hg842Mp9cPafvO7C4fwH82dOeknAfOE46eqVVXRJothGrBQ4glN-FuXWh3_KonFL-m2KTHBMDdNVQkurUPe8yVWsIdW98m2>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdeljeegtdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecunecujfgurhephffufffkgggtgffvvefosehtjeertdertd
    ejnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdr
    ihhmqeenucggtffrrghtthgvrhhnpeevueegkedtteeigeejueehuedugfevleefveehue
    ehgfetffffvefhuefhueekveenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhep
    mhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopedvpdhmohguvg
    epshhmthhpohhuthdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhg
    pdhrtghpthhtohepmhgvsehtthgrhihlohhrrhdrtghomh
X-ME-Proxy: <xmx:w7lbaZ7e7o1jADZXqsIR5OdAnRPicM3ho8KqfCAHt-uC-m7mnJna6A>
    <xmx:w7lbaf06JTJgcvwre4IH-MsgMVdWw2Ofdi69b0ry9MpZpJR4cf165Q>
    <xmx:w7lbaSZXrTEjFx2XvF3xCo-sfplM0StAJtFT-lsHj6utF4T1GJPHYg>
    <xmx:w7lbafDxtgkTxMUlVvFasYwfrZPl2V-stYqib8MzejIgaqg7Da2Lrg>
    <xmx:w7lbabJxcN7utL4sLB0er7p-pbTQ_vnGrOEaXfyNXiQCEXcBTRJLfqvi>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 5 Jan 2026 08:16:50 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 2469ce14 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 5 Jan 2026 13:16:49 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Subject: [PATCH 0/5] builtin/repack: make geometric repacking compatible
 with promisors
Date: Mon, 05 Jan 2026 14:16:40 +0100
Message-Id: <20260105-pks-geometric-repack-with-promisors-v1-0-c4660573437e@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIALi5W2kC/x3NQQqDMBBA0avIrB2Iwca2VxEXNhl1EE2YES1I7
 t7Q5dv8f4OSMCm8qxuETlaOe0FTV+CXcZ8JORSDNdaZxjwwrYozxY0OYY9CafQrXnwsmCRurFE
 U7fRqn8GFT9e1UEpJaOLv/9IPOf8AVxd7cHUAAAA=
X-Change-ID: 20260105-pks-geometric-repack-with-promisors-2f948d6db774
To: git@vger.kernel.org
Cc: Taylor Blau <me@ttaylorr.com>
X-Mailer: b4 0.14.3

Hi,

I recently noticed that geometric repacking is incompatible with
promisor remotes. This is because we invoke git-pack-objects(1) with
both "--stdin-packs" and "--exclude-promisor-objects", and those flags
are mutually exclusive. Next to us dying though, we also don't have any
logic to mark merged packs as promisors in case any of the source packs
was a promisor.

This patch series fixes this by making these flags work with one another
and by introducing special handling for promisor packs during geometric
repacks.

Thanks!

Patrick

---
Patrick Steinhardt (5):
      builtin/pack-objects: exclude promisor objects with "--stdin-packs"
      repack-geometry: extract function to compute repacking split
      repack-promisor: extract function to finalize repacking
      repack-promisor: extract function to remove redundant packs
      builtin/repack: handle promisor packs with geometric repacking

 builtin/pack-objects.c        | 14 +++++--
 builtin/repack.c              |  3 ++
 repack-geometry.c             | 89 ++++++++++++++++++++++++++-------------
 repack-promisor.c             | 97 ++++++++++++++++++++++++++++++-------------
 repack.h                      | 10 +++++
 t/t5331-pack-objects-stdin.sh | 39 +++++++++++++++++
 t/t7703-repack-geometric.sh   | 61 +++++++++++++++++++++++++++
 7 files changed, 250 insertions(+), 63 deletions(-)


---
base-commit: 68cb7f9e92a5d8e9824f5b52ac3d0a9d8f653dbe
change-id: 20260105-pks-geometric-repack-with-promisors-2f948d6db774

