Received: from fout-b4-smtp.messagingengine.com (fout-b4-smtp.messagingengine.com [202.12.124.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91C5C2DFA2B
	for <git@vger.kernel.org>; Tue,  2 Sep 2025 20:36:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756845371; cv=none; b=Ld+LQzr99YHwSwB63Eat7wx5ITRJOyvgxvMQyErdYv3aIcD5/IeCHjGtRGeFPKeDymbr0ck4sjAnhgmB4pi1pDNzO5K3/7sFiLSO7RGLsfAcM1GIR57PlXgLKCuzUjHEhCvbK5FAXowmC/+QSKCz0irehBnuXAbN3zWrNnDysws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756845371; c=relaxed/simple;
	bh=cj4Q5s7x7H4WoLXj/zFYUZ60qLHJAyz1WHedw1iS/94=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=nzCD/5ZCfDfyyAr/r7dJdEkLcLePl7mdrp8H0sazLdl2Zq+wEPm/zf0QHe2jUfp6VLTuXf0JAM4idhNRbJGhxzIkkHh902YjgpyOsS4Hu5phOAcH63dOhU6jHxKGywDI0eIjATQd9/c5uDIiuIe1USqL/cWLkAG6tkwxXvl7bo8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=it0jdcz3; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=aKgz1+6Y; arc=none smtp.client-ip=202.12.124.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="it0jdcz3";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="aKgz1+6Y"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.stl.internal (Postfix) with ESMTP id 980341D0048D;
	Tue,  2 Sep 2025 16:36:08 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Tue, 02 Sep 2025 16:36:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to; s=fm1; t=1756845368; x=1756931768; bh=M6t5JjCg8tR17cCaJ43NU
	fNGEBygk3o431o06P2I6Pw=; b=it0jdcz3RbHuCmc6X39ZBEQK8v2jibO3NfYL8
	YRxlE7x5kHshrILTJpPF4xX2ggD/n+OOoOlDEhoHaI74CjIBm8txUz6vXOWz+8py
	BIvnvcPP+VhgRwDn9o31maX2XdE4/ZOZFLs+FkfVf/dBfc5QO9SJcm8a/EjJac+z
	HwktfnLEhkp9HODczvZYwvsjioFwG+A7SfE2CORM/cWM+9RxcL9k1DJbamzeTwQK
	T2/OnQteOkQkLzsQpyWQFega+V7FSEVK//o2D7187i80QfwZOSq7M5I5AX6tYi2j
	JirufnSXRt6LMJWnjZGM5CIdXF97HcudjSJ4DPCuLLlaXtahw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1756845368; x=1756931768; bh=M6t5JjCg8tR17cCaJ43NUfNGEBygk3o431o
	06P2I6Pw=; b=aKgz1+6Y6jMXLSA5qaIm1s2PzYIvjfySoCqIsy8JG1tDRqZz83M
	jzQWM3acM/oroSXW1F4V4Dx1cTRTcVsT6mHTqbC3SUkT2AXIvp30oh1F6ab/f61E
	xlCOhsCXfhPdQx1Gb+A/injIflS0oDXhC1d39SznIR1jDA4bdCQD5V4nXQc1rnFu
	kpR24ac6TwZfrUJ8kdHfOLoKxjagHMMX11I+aYm/GkA5q0PfIFXeUgz69UHDT8Ob
	UjKanWdDjQfoUXYRQvIltirrATlvYLh1StHw5VDkeXmgpMhx1IGwr1i5PO4DCFDk
	gu7LrG1JN45/cilwPusZs6ZGBZaom3ugRlA==
X-ME-Sender: <xms:OFW3aAIuy1E_RAV6bj2vd-YpXxVbqH40_mLYtHo1KdrL3FuwR0shX6E>
    <xme:OFW3aAVZ-biwkKPD3bnR6FxC51aQWu5iiI72iMMhcXBV0VvaQGPNLSFwLwWIJHB2y
    AjsIpm87z2Bqxb2hg>
X-ME-Received: <xmr:OFW3aCium1aYa2-AZzc2PqKLAC7MWRKvzfnSt80oNTarsZvfoITvvNLv9qOWz2DbGvgrS7n0n5zDfCK1TpQX73CSb6YawK3VwJP1dQwAkwu5PEsbXqDtVlGp8A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdduvdegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceurghi
    lhhouhhtmecufedttdenucenucfjughrpefhvfevufffkffoggfgsedtkeertdertddtne
    cuhfhrohhmpehkrhhishhtohhffhgvrhhhrghughhssggrkhhksehfrghsthhmrghilhdr
    tghomhenucggtffrrghtthgvrhhnpeeiueevledtteejueejleejgfevtedugffgffevgf
    dukeehgeehffffvdehffelffenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuvehl
    uhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepkhhrihhsthhofh
    hfvghrhhgruhhgshgsrghkkhesfhgrshhtmhgrihhlrdgtohhmpdhnsggprhgtphhtthho
    pedvpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrh
    hnvghlrdhorhhgpdhrtghpthhtoheptghouggvsehkhhgruhhgshgsrghkkhdrnhgrmhgv
X-ME-Proxy: <xmx:OFW3aL-UZ-Wcy_bXY1oPp7-nIxHOrs5AAzlJeC4nvjhJx5zbShzyDg>
    <xmx:OFW3aMDaaRzPExUaBj__2d1cUEvIGARfP5A__XURhaqPFscGrKpgZA>
    <xmx:OFW3aIJWLzjEPtou-hw7BfgBTzCDhFgamcltG9VhdNeYqPPwjYfVNw>
    <xmx:OFW3aPmYiqHLhRpMzTWNIF9g3iFpAXxgbPDsZ-QzilhK4jRc7hA-Lw>
    <xmx:OFW3aKtShVAmQ1TVWYIpAxpqv6wOJ5K_i4jPNYwFn30LePhfnwFjKpwe>
Feedback-ID: i8b11424c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 2 Sep 2025 16:36:07 -0400 (EDT)
From: kristofferhaugsbakk@fastmail.com
To: git@vger.kernel.org
Cc: Kristoffer Haugsbakk <code@khaugsbakk.name>
Subject: [PATCH 0/2] doc: add/remove backticks for inline-verbatim markup
Date: Tue,  2 Sep 2025 22:35:45 +0200
Message-ID: <cover.1756845314.git.code@khaugsbakk.name>
X-Mailer: git-send-email 2.51.0.16.gcd94ab5bf81
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Kristoffer Haugsbakk <code@khaugsbakk.name>

Fix markup where either a backtick (for inline-verbatim) was missed or
one too many was used.

Ignores the one in `Documentation/config/alias.adoc` because [1] already
covers that one.

[1]: topic km/alias-doc-markup-fix;
    https://lore.kernel.org/git/20250901180419.2212086-1-kyle@kemitchell.com/

Kristoffer Haugsbakk (2):
  doc: add missing backtick for inline-verbatim
  doc: remove extra backtick for inline-verbatim

 Documentation/fetch-options.adoc        | 2 +-
 Documentation/git-fast-import.adoc      | 2 +-
 Documentation/git-multi-pack-index.adoc | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)


base-commit: 2462961280690837670d997bde64bd4ebf8ae66d
-- 
2.51.0.16.gcd94ab5bf81

