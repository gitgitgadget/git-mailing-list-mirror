Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B1A61FECC3
	for <git@vger.kernel.org>; Tue, 20 May 2025 17:58:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747763889; cv=none; b=ILva3Baysy5bPkyiaNI4vof1644pWir7/FSwaOKnp29Dh/2nfwiPkEp8tHlP53+3UNNdAUOrwPOjEVdhkssSiyBLjZVbKKqDQKKs8yc5yx8KLIn4SS8/psJQStN3ir6/R08j/m98cPzhRa6S930FWTlE8Q4Pc31KoooTzy5mFlk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747763889; c=relaxed/simple;
	bh=4BtDaAuU/dm4uSvD+HLNbX/ZSlXJJTj/IdkZBRDXUW0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ntTafYjiO2hIyMttdCVkp569qq//7Q8tNXhIHM4BrfBwNnSinFnoBlQ8FDiU/MejAw/PZD3rQmXbRbaVsEFGrQ7qEQ29AkCtao0dFE/j5oCgJjMAiV5r6Dpk/kz/4ShRfe50NYJ+z6IjKKU7LceTyEeqa1TLoZmAc5ikoU564u0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=wgXRj9b3; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=cvcWzB9g; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="wgXRj9b3";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="cvcWzB9g"
Received: from phl-compute-09.internal (phl-compute-09.phl.internal [10.202.2.49])
	by mailfout.phl.internal (Postfix) with ESMTP id 90CAB1380421;
	Tue, 20 May 2025 13:58:04 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-09.internal (MEProxy); Tue, 20 May 2025 13:58:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:message-id:mime-version:reply-to
	:subject:subject:to:to; s=fm3; t=1747763884; x=1747850284; bh=2H
	PnxGtF/cTHHJnIzoJRmH6zklmqXVTrhn4l0CyHuRc=; b=wgXRj9b3AiS+/M16pK
	/qstWC017eg34k96k0EXkPeXWS0/pV7/iIQNgWN+dkbx0X8rH3SaPZB0+c2xCIQ5
	CxJ9uHPWYqIbYkFikMMojIeu2vaTo7VPqhTZdn+4ZlxTdRRaXDgZKenDNK6W4XIp
	tlup9cwmiSvZiIRlNH4LVM8oTA3FfBV1AeBJpK0rmiqLQMn3IVxOQV+ht3H8mJfy
	R+r2jI0U8sqj3VL9OgFxcJwkCIGxxwzcpEyw1qLE9cMdrbKtwUuB8KyFQSsVhVAc
	eb5pHtHBTn57mSRxoOgJaWiJu4XpWSm4ifOdxSN2j8MdujLXADPgHQ4vCTMTiByI
	hMEQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1747763884; x=1747850284; bh=2HPnxGtF/cTHHJnIzoJRmH6zklmq
	XVTrhn4l0CyHuRc=; b=cvcWzB9gQPo6GlzQ6NdY+Wg3WURiXvT/l1NHzJDSy8YQ
	BExgQHw1NDH6p4Fwx4k/RKhdFtdPnXQ8UgyvuVUMQvwtxu1U0kcVe01jl5ow3oi1
	1Lo7iMPuYF+7rr2H/DAAnOeUEh4ujJ/7iu/hxBWmtltCXxA0KrmwQ4bNJxVWTOpJ
	Q63pXtxmu73V/ZHAjCWa0UnQTizf1Quw6AkyL1dYE8T0Y69tmffQFLXuGc53jMnD
	JQBO09mDVT3VtPj7awaMgExlTHfibSMSxrpJHy6S8JYx7nhf2ermukKVs7fLY/ph
	7MDcpfGTaXWZ47+D+RH6o4MZjj5ifTwbyj9zXFnWgQ==
X-ME-Sender: <xms:rMIsaEaasglUIO_UISPfFtxyJKBYpQ5IlDVTXhBJ1g5suQp72wlVlkQ>
    <xme:rMIsaPavJMwaGJ23NbcvW-agXs3Lhfx2ttdP7GSovfHrdBC332wMzYFH1XV05jEoz
    gRptsKP5SagRDA6YA>
X-ME-Received: <xmr:rMIsaO9H3mMp20hnkrrt2A8QC5zSyx94SUsYvHmYo78rai9B9Z49eaybJv_gwERERQUyX4heKVzX0iHVudQnR1W19h14G2NUfT4>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddtgdekjeculddtuddrgeefvddrtddtmd
    cutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghn
    shhusghstghrihgsvgdpuffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtne
    cunecujfgurhephffvvefufffkofggtgfgsehtkeertdertdejnecuhfhrohhmpehkrhhi
    shhtohhffhgvrhhhrghughhssggrkhhksehfrghsthhmrghilhdrtghomhenucggtffrrg
    htthgvrhhnpeetgfekjeffudeffeffgeekvefgvedvgeffueejjeelgeduhfdtffeikeel
    fefhgfenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    hkrhhishhtohhffhgvrhhhrghughhssggrkhhksehfrghsthhmrghilhdrtghomhdpnhgs
    pghrtghpthhtohepgedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithesvh
    hgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopegtohguvgeskhhhrghughhssggr
    khhkrdhnrghmvgdprhgtphhtthhopehpvghffhesphgvfhhfrdhnvghtpdhrtghpthhtoh
    epugihrhhonhgvthgvnhhgsehgmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:rMIsaOrGfBEYrSo4om3EOFsDR_guhBNogqYqli7jvtQ3b9E8QfSkLw>
    <xmx:rMIsaPqx0hR55Q68_EGD_QOs-I6LCv-smWhobnrIVRD7o7-WkX93sg>
    <xmx:rMIsaMT_-ojeesTRo25GfDWh9ePViviJ6jAIGw_x1kLOO4AqvH4oxQ>
    <xmx:rMIsaPqP9gdpEE0EVwQazIMJBfEntENEr6ZvXg4U4y0v24NYwmJJIA>
    <xmx:rMIsaJgRcjki4vweB4DmKA2F4kg46lAUX5eeA29ZIhXFhzUU7s1E51SN>
Feedback-ID: i8b11424c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 20 May 2025 13:58:02 -0400 (EDT)
From: kristofferhaugsbakk@fastmail.com
To: git@vger.kernel.org
Cc: Kristoffer Haugsbakk <code@khaugsbakk.name>,
	Jeff King <peff@peff.net>,
	Teng Long <dyroneteng@gmail.com>
Subject: [PATCH 0/6] doc: --stdin on notes and core.commentChar mentions
Date: Tue, 20 May 2025 19:57:18 +0200
Message-ID: <cover.1747763769.git.code@khaugsbakk.name>
X-Mailer: git-send-email 2.49.0.780.g892193c3f50
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Kristoffer Haugsbakk <code@khaugsbakk.name>

I wanted to fix `--stdin` in the git-notes(1) documentation.  Then I
found some other things on that doc as well as things to do with
`core.commentChar`.

I was unsure how I should refer to the config since `core.commentChar`
and `core.commentString` are aliases.  I just went with the first since
no other docs mention the second.

§ CC

Peff: for 9ccf3e9b22b (config: add core.commentString, 2024-03-27)

Teng Long: for 3d6a3164649 (notes: introduce "--no-separator" option,
2023-05-27)

Kristoffer Haugsbakk (6):
  doc: stripspace: mention where the default comes from
  doc: config: mention core.commentChar on commit.cleanup
  doc: notes: split out options with negations
  doc: notes: mention comment character configuration
  doc: notes: point out copy --stdin use with argv
  doc: notes: treat --stdin equally between copy/remove

 Documentation/config/commit.adoc  |  7 ++++---
 Documentation/git-notes.adoc      | 24 ++++++++++++++++++------
 Documentation/git-stripspace.adoc |  3 ++-
 3 files changed, 24 insertions(+), 10 deletions(-)


base-commit: cb96e1697ad6e54d11fc920c95f82977f8e438f8
-- 
2.49.0.780.g892193c3f50

