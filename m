Received: from fhigh-b6-smtp.messagingengine.com (fhigh-b6-smtp.messagingengine.com [202.12.124.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84C833D9DD6
	for <git@vger.kernel.org>; Mon, 11 May 2026 12:30:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778502610; cv=none; b=eQ2VB6wCdi1MUFeRiyreK7JXaI24Q2Lu+J3ZURcn4rEAQK4GEFtPOsmWBHFnS5TRVQPLh26CuhYesXIT9nLMQ2uwAnpFVAS6eelTz5qthwpicOI1Z5jlk2O1gyIB7Dal0vwlfxmBm1prEVK1C1s8YVV3frDtAALoQeM1rtdp5Hc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778502610; c=relaxed/simple;
	bh=sC2yOebk25Cy9dzpmw2mP95X/Wxmon4Ou+NBs11PSMs=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=JPsLHUsG/grVkYbYlcvX6MgYO2iGPz2+kiB9F/mLX9w1DA5vlUmUJHD8Icg63fULf8pFkzakIrQpVL+zwiK4IOKSQJ/+Zl/QcyndiA9lxOZ+iNFutIfz6fTnUCmGCWD4BzaMc7kXFGUYZeK3T3zv/mi80QBJ6gebwx9K3vi7OEQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=S/C5NJXX; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=maw8z+E5; arc=none smtp.client-ip=202.12.124.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="S/C5NJXX";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="maw8z+E5"
Received: from phl-compute-11.internal (phl-compute-11.internal [10.202.2.51])
	by mailfhigh.stl.internal (Postfix) with ESMTP id BA40A7A011B;
	Mon, 11 May 2026 08:30:08 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-11.internal (MEProxy); Mon, 11 May 2026 08:30:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to; s=fm3; t=1778502608; x=1778589008; bh=oGdMSStW1q
	ANiy4beqEMPkhWz+oHwvDaI098QMDgRtI=; b=S/C5NJXXOqKuNUX7YHNeUxsskX
	BkQ+9kIvixq6fBUBw9XZ/Nm561P8zs+YKP/AgSYt3nqcbjCni2/oe8WmEICCjA9l
	a+cXsvhIKO17TqkPBaEdS8jC1wRMvMofYwqt6pkaKAcipRJgNFWmZHeduYXwcp2J
	O4XHoIX1Vv2Tphvf6NwToT7ARZrTMRIn2ZcO4YoR8edbnjmem+7RVHjm6ewi7uIe
	fKTyrMIVFKpFrOs4MuyJx20QbvgHDAa/N0wo2rfJd0oEnQVtS0DhslvUHTAQ0s/2
	0ZwxaAdoX+j1ckI+sXkYAIpjr1jtzvowQ342Q4bC2XVjdDXodpRMYt+fyG/g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1778502608; x=1778589008; bh=oGdMSStW1qANiy4beqEMPkhWz+oH
	wvDaI098QMDgRtI=; b=maw8z+E5lvJPDSe8VmozkcLl/oCh0jjyqwQrRbmki4l5
	0EoLzUyZSN+rlrcWJHtrG+DQ+iMDQ1EB0/jxw38Z+yRbN6RDRZjoSt/LXFTPn6oZ
	+SOBPn5TZLfZ0UwUXa9v05vRvY/EunAqMvH4pF9vMhld7CmxH+D6zAfkhzs70AT1
	ReuhxopmouHK34ak+Upg5+6ySucd9dWkXlOYZ/oB/EFN3Utn6dGdvJXIP5k2/rCF
	HfIUddAqGwWbZaSVp76wcVhT4mhmb6+j5zJJFH27M1JthOxQZJ5kHCepuW+SafHK
	L6ZLUbLQqZsrDdOS7yCu5T+BHrNhy9Up4WG1t5q17Q==
X-ME-Sender: <xms:z8sBavmIZy_tMktcN7Zo5ZXqTSBV9Siy5L37Seolm1TJKRkxwDegbA>
    <xme:z8sBamhJIl_dxWXAIYLn5CfiGLP0TtU-TLdCo580jUubiU3WX8fZ3WZEDjX-HwigN
    VaXtLWAohEZn5XmBjRCAOb6VuQ_ZUspJCGFUmhksxzUAKjUl4w9WA>
X-ME-Received: <xmr:z8sBavcLMHQP5pFh5JS0IkDTWwQbrnsq8iHxi4gRGfnZ1aqr6PYbtBuTTUUhDdT_LSbGjLoYkGmlsz6XLM452OG_eDDP_GqhUmJ5X3uYRA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdduudekleefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffufffkgggtgffvvefosehtjeertdertdejnecuhfhrohhmpefrrghtrhhitghk
    ucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpe
    evueegkedtteeigeejueehuedugfevleefveehueehgfetffffvefhuefhueekveenucev
    lhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhksh
    drihhmpdhnsggprhgtphhtthhopeeipdhmohguvgepshhmthhpohhuthdprhgtphhtthho
    pehmvgesthhtrgihlhhorhhrrdgtohhmpdhrtghpthhtohepshhtohhlvggvsehgmhgrih
    hlrdgtohhmpdhrtghpthhtoheprggtthhiohhnmhihshhtihhquhgvsehgmhgrihhlrdgt
    ohhmpdhrtghpthhtohepphgvfhhfsehpvghffhdrnhgvthdprhgtphhtthhopehgihhtse
    hvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepmhhikhgrtghhuhesghhmrghi
    lhdrtghomh
X-ME-Proxy: <xmx:z8sBauhx1sAz3QdFf7h8QwgWzRxid6C7rpHL_SOj5-3Vn-7G7dRjXQ>
    <xmx:z8sBavy--l2FBau407vVU8RhLgn20Y8LKklbY6_i8U9rg-WpCvYFvQ>
    <xmx:z8sBaiPY2XKeIDQyM_znHyk71C1CK3o1d2q6dPb44oaixUNwsysGpA>
    <xmx:z8sBaoXvPEdmse3xVUPwfsP4S6e_BDY9nasB2JPAQE0q9EvghTikOw>
    <xmx:0MsBaiJUe6gMVciqqV_vyWW_bryAVEnESJKyh3Rkw2BU3X1EnZuEwZL8>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 11 May 2026 08:30:05 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 751d8f45 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 11 May 2026 12:30:02 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Subject: [PATCH 0/2] builtin/maintenance: fix locking and respect "gc.auto"
Date: Mon, 11 May 2026 14:29:54 +0200
Message-Id: <20260511-pks-maintenance-fix-lock-with-detach-v1-0-ccd7d62c9a40@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAMLLAWoC/yXN2wrCMBCE4Vcpe+1CUjCoryJebJLRrNW0NPEAp
 e9u1MsPhn8WKpgVhQ7dQjOeWnTMDXbTUUiSL2CNzdSb3pmttTwNhe+iuSJLDuCzvvk2hoFfWhN
 HVAmJxZkd9t5JhKeWmma03e/mePq7PPwVoX7btK4fe4M8xIgAAAA=
X-Change-ID: 20260511-pks-maintenance-fix-lock-with-detach-a608e9b6adeb
To: git@vger.kernel.org
Cc: Jean-Christophe Manciot <actionmystique@gmail.com>, 
 Mikael Magnusson <mikachu@gmail.com>, Jeff King <peff@peff.net>, 
 Taylor Blau <me@ttaylorr.com>, Derrick Stolee <stolee@gmail.com>
X-Mailer: b4 0.15.2

Hi,

this patch series addresses the issues reported in [1]. The series is
built on top of Git 2.54.0.

Thanks!

Patrick

[1]: <CAKcFC3arsYExb5dCMQspo4V9UFDadFaj8Q4PUsMWZJw_eYrMzA@mail.gmail.com>

---
Patrick Steinhardt (2):
      builtin/maintenance: fix locking with "--detach"
      run-command: honor "gc.auto" for auto-maintenance

 builtin/gc.c           | 26 ++++++++++++--
 lockfile.c             |  9 +++++
 lockfile.h             | 10 ++++++
 run-command.c          |  6 ++--
 setup.c                | 31 +++++++++++-----
 setup.h                |  1 +
 t/t7900-maintenance.sh | 95 ++++++++++++++++++++++++++++++++++++++++++++------
 7 files changed, 154 insertions(+), 24 deletions(-)


---
base-commit: 13ef77ce6e222bef3ab145642e6ef1486075211c
change-id: 20260511-pks-maintenance-fix-lock-with-detach-a608e9b6adeb

