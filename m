Received: from flow-b4-smtp.messagingengine.com (flow-b4-smtp.messagingengine.com [202.12.124.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA4DA549378
	for <git@vger.kernel.org>; Tue, 22 Sep 2026 14:31:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790087485; cv=none; b=gnXaG/XPyy+vQv8Z7zwlpQ5ihugdPoGeOLWFJGHpwPXcJpdmIHO2w4lHu+eW4ELUSh+fJpBj2pon9nQfV41/yG/gB8Ri+ICtWSqTwbXhSdlxMQrlLqzUDDZan31197c8vzGew11PjwdZysBSBIXgALj6IBDFpUM9jkYu5VT//kA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790087485; c=relaxed/simple;
	bh=fHt1t+pycxZ1twjYjm4GEEaCtyrJD0yoj9vc3kijleQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=twLx2lR5eu+QNmGWGaQBW9YkAj1lBw6YF/lhtSM+s/KE1sRQJz3YBbyZ9xYr154N9Uh06A3MRQFppYjo0j8ocWeOwZFpYb74/ADd5TMWVmkEHsFwwjimJMUEyJn11CjkR2MLY+97PUQh+vVDUK1nUsC4JXQ+kQ2tMo/DOmt+Or4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=CTxacXeD; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Wmw3QnH5; arc=none smtp.client-ip=202.12.124.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="CTxacXeD";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Wmw3QnH5"
Received: from phl-compute-08.internal (phl-compute-08.internal [10.202.2.48])
	by mailflow.stl.internal (Postfix) with ESMTP id EF4D113002B1;
	Tue, 22 Sep 2026 10:31:22 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-08.internal (MEProxy); Tue, 22 Sep 2026 10:31:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to; s=fm1; t=1790087482; x=1790091082; bh=+ADsPIZlUECuUNYuYvwdg
	c4icKnbVRZcglytah7t6mY=; b=CTxacXeDENsjvIWjaWW++l+CJdZ0C9kopsaM8
	GbplHgGH73c0N0K15kdnefQh+MVmJeinYYJCZdKPTh7oCpStMhzTwtco2a0jNJ4e
	cv0CY4ooDki+Hv+/Qsc6xhRjJOhgom3gjt9/qRM/GtbnRzSUalGw/8Uugbfje4/m
	PxHmHGUlXFFCQu5WMwC8akqNFswC9KNqG+9wahJQX4aLu+kK9CbXaGIjacck8mtD
	3b8q7FVmUcBQ29Bz8nQFfWBB70weH12yR4YUp7ZcXxQG6LiIESGmkCcjuLIpursy
	tAwYe/bcwQ84pYfAxEA48+j0xMwdKj0SF4wZlrqu93+fZSPxw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1790087482; x=1790091082; bh=+ADsPIZlUECuUNYuYvwdgc4icKnbVRZcgly
	tah7t6mY=; b=Wmw3QnH5C3QOWclBLHvB2OVtVkAWJ9mkWiexk9y+QEPaLT8o7SM
	HSyGk3CgxdVd0dnUHrf9G4AQEb2m8UC52tE3hODkt1CX0y8nkwV8Ki6IPKL3WSEa
	/7rJcsMfMwVejOmna5Pu5crmr5Sd3wN3EDoISasbL6UE5hKyJQFBi//Z0qgRKKZP
	9XEIRLcfX95i+QMBIxb8KO1ghWV40xw0m6j6Yh9c4YrZNoh/QHrHVD6z13oPFmnL
	fPkDV1MnQTrNkB/qPJ6FLoQwIyk0YCSWzcknHZOtOdMese0w5Me5+qqtnftEoxe+
	CsC+LLAXaaC6EWnO6qxyy14lhN17+vWGoOQ==
X-ME-Sender: <xms:OpGyaqncdQ0WcegdcU16thP41AHsyNFp7tkf9isiLH2vBX-yPk7djA>
    <xme:OpGyan1pznHPd35X0pnKqSP2RJUGBY4HjoZx-Ti6UaEeIjjVFWCH0SmrNXZckFKHY
    CQ0yInN9RJDnVz6sv9ln_YP6UoCB2eFHRXlsAR5YMRVY1pb7bg8atTC>
X-ME-Received: <xmr:OpGyamQuLsG5fs_zPvGNAA9DyFFuHDDc_6J-E4dp82PVM0I-llJn1KXmut9kD4nokJn4e6yVTlhRBeA8VlkzgjNUxK_98OV_c3_qCer1-scxUA>
X-ME-Proxy-Cause: dmFkZTF0yIklqKpiWJd7YJ7/MJOxCehHJTUXtcnEO46+uBZIsSbHk1tcb7FJMSt+1IBlAG
    INkFFMtz/v+WYrSQDY2Y/TSFps0LfEmCmwvI7DgXkBnM8C/oFZj2wERDPL2Vx5sdcAwqER
    OB0wyPPWa578Bo/BEMQvg3i0xIU2wrD1yMfusVhAqUb6PAcGmy16+20XkP5j9oZ8PUSCUU
    eR+UvUlhi7sowcWS25VeCtYCzlc76uplOXoGIK8DquTPA9UYgbBzAKLyWSEedeJEj94Z1g
    tbcrpjaWJmZrFh+NeQ1c9srUWuV9G8vD/cwzmp0+xKaCwFVPCjPOVUGxUmdC2r/F/qcWdB
    cX5i2nmShbcIaDAAManrqyiYahkYZtxw3TPX45HPUqo6/zLbkNtheEnTod8YQgDKsSOe9g
    gN41OeG9Yu5nLmjzWYnk8aumAcoxKb9N8HDvoUHr01pFNqTkJWjV7l1AjCGZYV8OIAjpCT
    qeBCDBDCfmuKKYm4+Tfmh++gOfFFW0RhBXPUX644U1kVJpR/Ga/RjkjJVIb68pSuG4RGYR
    R0wk1TqbkBOSuvR+KrJsrxJLX679U/O8fBKiXvqcHz3h48l5vD735py8W1cdDE9m2NqRrK
    pICF1l30fUvivzDYn0BDA0c4mmmrTl4pR/jyL+jFvBs2nVw2zzIqlJP0Ohew
X-ME-Proxy: <xmx:OpGyapvhYWIYGp-ZE4EYIyZNtL-bfYFQ5TmLQKjgN0j9breYSQygow>
    <xmx:OpGyarbOCCN__hK64f0AI47fk20-ywQK32CgVGfFqUn2Lg-Zf46GZw>
    <xmx:OpGyauty19WZl5iSBzu1MxpwWiKAnJpvUL5IHHZ75ddQbFsgD1PMiA>
    <xmx:OpGyatHCMzTaAw2Y-le32DmeOhypnp6q7ZT7X0cQr9E-iwTZ_nipKg>
    <xmx:OpGyauT7ZG9B9JT8h3sPd6gQtUPgUYyOnq-pZOzkc6ff-r10-Lxf11k6>
Feedback-ID: id2564aa6:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 22 Sep 2026 10:31:21 -0400 (EDT)
From: "Mark C. Chu-Carroll" <markchucarroll@fastmail.com>
To: git@vger.kernel.org
Cc: "Mark C. Chu-Carroll" <markchucarroll@fastmail.com>
Subject: [PATCH v5 0/3] t40*: modernize
Date: Tue, 22 Sep 2026 10:31:16 -0400
Message-ID: <20260922143119.3313620-1-markchucarroll@fastmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Changes in v5:
- Update t4001.sh to the correct commit version. (Argh!)

- Link to v4: https://lore.kernel.org/git/20260918171847.2670739-1-markchucarroll@fastmail.com/

Changes in v4:
- use a "test_expect_success 'setup'" instead of setup functions
- make capitalization in test assertions consistent.
- improve naming of rename tests.
- make all indentations use tabs correctly.

- Link to v3: https://lore.kernel.org/all/20260917195436.1102981-1-markchucarroll@fastmail.com/

Changes in v3:
- Correct cover letter and commit message issues

- Link to v2: https://lore.kernel.org/all/20260910-modernize-t4001-v2-0-ac53e9f5d717@fastmail.com/

Changes in v2:
- Merged setups into main test bodies.
- Removed unnecessary echos.
- Cleaned up here-docs.
- Updated names to modern style.

- Link to v1: https://patch.msgid.link/20260908-modernize-t4001-v1-0-cab3933a173f@fastmail.com

Mark C. Chu-Carroll (3):
  t4001: modernize
  t4009: modernize
  t4010: modernize

 t/t4001-diff-rename.sh   |  91 +++++++++++--------------
 t/t4009-diff-rename-4.sh | 142 +++++++++++++++++++--------------------
 t/t4010-diff-pathspec.sh | 120 ++++++++++++++++-----------------
 3 files changed, 166 insertions(+), 187 deletions(-)

-- 
2.53.0

