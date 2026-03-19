Received: from fhigh-a7-smtp.messagingengine.com (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E8B72E1722
	for <git@vger.kernel.org>; Thu, 19 Mar 2026 05:33:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773898416; cv=none; b=fOaDS0LxMPXnmrBg2ih4Wq8rEEbXmM/LCDUr+Ov452RaxH2Psmqa2CXE+Tz3XOCph3lNQcLky3FFEwh3zVrL4Z23OVuF5uq3OKldek3yjy2tzLl/I0NJ6+TBXwlGHaP/M6uI/WGM8hkajID91vIXfGiiJW4hIybpTKSMWDFMEFE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773898416; c=relaxed/simple;
	bh=wgciiojjec9s7CbLwDMPMrejbLhOMmrqwEP/kEuFzQw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=CxbxIvRRQ7/Ie64x3e4HWZqmd1noLk0HOEgxUqyEGy8LVI+QCkB3nfBB9GeiuQdYXl5gymTcdcGgh1eLxwr/9VmpXTAPMAghEDTRlPXBNqF8duPz9I8s/w9sBYHy86LGAyFlE6GjXRurAAKSlA838ch4lz7l6MSsVzFhU+E2kzE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=kumRKq3C; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=nM7w7woJ; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="kumRKq3C";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="nM7w7woJ"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 4F1E61400227;
	Thu, 19 Mar 2026 01:33:34 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Thu, 19 Mar 2026 01:33:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1773898414;
	 x=1773984814; bh=BT1yhkpjKmLdHy7o0xGMxT9G7TrLFr4ZPak1DFXfTwo=; b=
	kumRKq3CxcyF8Vd8NButO/6UC4+sIrlEjGaApR5n/mrVOskiI97E5/3f9x0FITs9
	WR8Msz7hrbQz1+RxY+yMa+h70XrbFhuw/b6DqR+FHZULxYMLKENyJDGhsD3rrUPF
	y3jKeq6BfgdvyPousuZ4YE8daQ1WYjWjLHL/mUZgtMSGaosYOoxKaXPSNsqviNTv
	0w2HH+QC/ojjCle8BSl9X1mv6pQRkiGYpEuKILHzeHA6QS8SL8EqySUIT/rDUjwK
	l4X3yO//0dd0ViTjx5tLvmDwfZYEUiGZwNkpFxVo2tzgBlCTZV47fgDHImLAlWsO
	mxtjnmlWZfgTmSjwWk7MYw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1773898414; x=
	1773984814; bh=BT1yhkpjKmLdHy7o0xGMxT9G7TrLFr4ZPak1DFXfTwo=; b=n
	M7w7woJ3TrZpLC2wxZ+1J7SUBvwbcsGlVsj/9wYeN24dQ5doCPud6AMXvd5S7j9r
	hoXVV+9KjtXM/iK3V+CNxWf+pYXaAgWHVkEcnSedhyU7oHuFbSD3uq9Hw4zPBykW
	NpnKbNhE2LoZhAHYGLpP2ZzWmplBi4Hn6U3P0NHG21R49N6MnPXdF7W9pJ7c19XY
	wqTH38t297ZhrP1bijdxDZqIYBrEaXISuf7o45pIKT3PZgReqZmm+CX6u+doly6D
	WYSUJDp8XmMAXI7F9p7Z9d6h+mq3X/Ok61nq2y+kbicmF40a3Wi5is6t5EUd2gck
	uuLCm+wEHrES9asEqFurw==
X-ME-Sender: <xms:roq7aXQp7tc2QrdMBsKBoLbk22ziJder3Pg3Pzc7qgQnqtVPBA4aHQ>
    <xme:roq7aaQINz4dZ8B82oMrBHT9OjR0R4ziO2aCk9K9uR0AM42eR9mg6O2cnA4JKh8hD
    ewyJYLxKPMoOnejrXUe5ACUtFZ2Ivcv0iBMmGACQcMSgFTPJDNSTg>
X-ME-Received: <xmr:roq7ac7Cd1OtpWk0Wp_MeUN7QazjHrYaMkELkksT30FCxP4HYN3rOaelSLY5uEFDryEnP4Hjy9nUtjW1c4IEy5Yhm00gjVHWF1YvozEdnlHV>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdeftdeiudekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeffueeiudejvdekheeuvdekfeffiedvueelteekudehjeetkeegvddugfdtgfeileen
    ucevlhhushhtvghrufhiiigvpedunecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhmpdhnsggprhgtphhtthhopeehpdhmohguvgepshhmthhpohhuthdprhgtphht
    thhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepphhhihhllh
    hiphdrfihoohguseguuhhnvghlmhdrohhrghdruhhkpdhrtghpthhtohepghhithhsthgv
    rhesphhosghogidrtghomhdprhgtphhtthhopehsiigvuggvrhdruggvvhesghhmrghilh
    drtghomhdprhgtphhtthhopehkrhhishhtohhffhgvrhhhrghughhssggrkhhksehfrghs
    thhmrghilhdrtghomh
X-ME-Proxy: <xmx:roq7aW1f52CBnbDG0VlHlIJZ6YNx9NF0IKOhe130nvJLCjvO4023zA>
    <xmx:roq7aXDX9PaP4ke46g6vFdtNgBkybluQUkAOM4Cq_R9FjqgiosqM8Q>
    <xmx:roq7aROcf9LrjqAb2VJanJvCDHvOwV0-5mwlkgtdYSx_-vGrPc9mLw>
    <xmx:roq7acbg1eoY_0QlhNSWDyI5rE02_ttQsPuHvh0V95aEwSq6aDAYDg>
    <xmx:roq7aeFLhHXmipRzVGoh9QD6JOoal7K7cfHbzwlD4ksDUazNgOlbBAwn>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 19 Mar 2026 01:33:33 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 2d821453 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 19 Mar 2026 05:33:32 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Thu, 19 Mar 2026 06:33:22 +0100
Subject: [PATCH v3 3/8] contrib: move "coverage-diff.sh" script into
 "tools/"
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260319-b4-pks-build-infra-improvements-v3-3-82f5fb3edc3f@pks.im>
References: <20260319-b4-pks-build-infra-improvements-v3-0-82f5fb3edc3f@pks.im>
In-Reply-To: <20260319-b4-pks-build-infra-improvements-v3-0-82f5fb3edc3f@pks.im>
To: git@vger.kernel.org
Cc: =?utf-8?q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>, 
 Junio C Hamano <gitster@pobox.com>, 
 Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>, 
 Phillip Wood <phillip.wood@dunelm.org.uk>
X-Mailer: b4 0.14.3

The "coverage-diff.sh" script can be used to get information about test
coverage fro the Git codebase. It is thus rather specific to our build
and test infrastructure and part of the developer-facing tooling. The
fact that this script is part of "contrib/" is thus rather misleading
and a historic wart.

Promote the tool into the new "tools/" directory.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 {contrib => tools}/coverage-diff.sh | 0
 1 file changed, 0 insertions(+), 0 deletions(-)

diff --git a/contrib/coverage-diff.sh b/tools/coverage-diff.sh
similarity index 100%
rename from contrib/coverage-diff.sh
rename to tools/coverage-diff.sh

-- 
2.53.0.959.g497ff81fa9.dirty

