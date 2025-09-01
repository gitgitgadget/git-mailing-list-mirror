Received: from fout-b4-smtp.messagingengine.com (fout-b4-smtp.messagingengine.com [202.12.124.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03AD82EC090
	for <git@vger.kernel.org>; Mon,  1 Sep 2025 18:04:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756749872; cv=none; b=YYssRpjWBzFliZ0tlBlYYwy4pFU9DFfgcC7XXmjiccY3hRy/GP6sTV3g22b9+eez4gH1IBouqJRF7A79ZbYAWC8a/fS800n1ckJ/GQ+IYGe5ir33QU89AQEj+PMTbgqx6BnwwvxdVwUFSy66cfwV07L2AWan1C9PCYljKcLVHsc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756749872; c=relaxed/simple;
	bh=t41A5LYSW0lzwFSbATocERSH3PaKQgap8dHEPuzhgOw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=u8s8elEKFKSDlAxMiknnRq71mvbG0uUMM0sBpEcdW0DN5nNiwv1XgPblUl1rV3COGDBi6anr0rf7uZxmeHwwPbLZuW7IlSV2DshMluGsQPTKoX+kD29BrvFnmWaE4cbZcCx/TaiGGN7u8tsSs2yudxSDx8iC9rMC5zlo0XqG+tE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kemitchell.com; spf=pass smtp.mailfrom=kemitchell.com; dkim=pass (2048-bit key) header.d=kemitchell.com header.i=@kemitchell.com header.b=T2dywQkH; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=QHU2ikvP; arc=none smtp.client-ip=202.12.124.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kemitchell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kemitchell.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kemitchell.com header.i=@kemitchell.com header.b="T2dywQkH";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="QHU2ikvP"
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailfout.stl.internal (Postfix) with ESMTP id E0D5D1D0028B;
	Mon,  1 Sep 2025 14:04:28 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-09.internal (MEProxy); Mon, 01 Sep 2025 14:04:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kemitchell.com;
	 h=cc:cc:content-transfer-encoding:content-type:date:date:from
	:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to; s=fm1; t=1756749868; x=1756836268; bh=fQYeFgeKD2
	/z7vOtqE71lKzoKF6tR4XUcHPCsqw9+CU=; b=T2dywQkHj0hl964Jy5v1gdt5l/
	iO2fw8PODTtrSimC2Ao9Ehfa8s2klHDxrV28eorEvhgyzv7I3ZwORVq2hr8AMkIs
	zFn4G/t5mI2sGG5APccJjUtCYX4pNi/t+yojBQWyeTRuSHGxp/j+ybmDSFSBQ0iB
	l3EQ0NpqH2ewGf04vZiT8/JnE0gFy6Zek6+ZMNjPZHH+Rdgfaz62BBX3WlYpwPA5
	B63Ojd0AO//eF/MyAInw6OqbQFcZNcYIyN3c1L91/tPQh1l+Xj9hkTseDbEuSyZ1
	vbLqHgLpsxmxVScda1IZDvP/DstVn4mDS7mMx/F2AutRogPp2qTj/PJY7edQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1756749868; x=1756836268; bh=fQYeFgeKD2/z7vOtqE71lKzoKF6tR4XUcHP
	Csqw9+CU=; b=QHU2ikvPfTX8Ae/ANaf+ofo3ExOjPk26+s8k1nNs28vx3sqvnP3
	GIBWRHswneJ0QkbLeJY/qEfRIHV0DgXg0Tbf2X2f6+bzWFhUReXpCAjNv2j3ejJu
	mo8TeQzrP9GWUjx2hWHm/A8l5Il6KHWQhEN3trNrEuKBNnh1pBQsMgnIwrIa2EMa
	qb9HxtsHpClcPb100VjxjeZIZrX3TmAz1zCCUtb44BSEqFmG0VmISZ5L/X8arrgs
	N5blr34VDvYK1WiBJaCfrbHaa0mHygYGJzsLv6esPkMXlC0yJ7SXcKDBmhUTWKCq
	8hVOLyy5duDXiciRpn3NlztUuAxDn+azIRg==
X-ME-Sender: <xms:LOC1aLy1SZoD7qvghgPyu4RFmORmtH5DSZ-L7sCsCnEzLqRXqh-7qg>
    <xme:LOC1aN1W4-ks1MX12I-ESxFIphMwiG_Na_faLsYawyPz_xRBRNEY6poZREqZscZoV
    rLV2hgwSnASIwQS4Q>
X-ME-Received: <xmr:LOC1aB6Ysmi-K86Lgio6jCtyG9ktBDbWHE_xdrlX-X87OInmomUIFBji7s8YrOMRjivB1jQ84uwzOupXS3LT91eW6f9W4Ij5>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdduledvkedvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefufffkofgggfestdekredtredttdenucfhrhhomhepfdfmhihlvgcugfdr
    ucfoihhttghhvghllhdfuceokhihlhgvsehkvghmihhttghhvghllhdrtghomheqnecugg
    ftrfgrthhtvghrnhepvdehteevjeegtedtheelkedukeehheeguedujeeffefgtddtieeu
    hedthefgheetnecuffhomhgrihhnpehgihhtqdhstghmrdgtohhmnecuvehluhhsthgvrh
    fuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepkhihlhgvsehkvghmihhttghh
    vghllhdrtghomhdpnhgspghrtghpthhtohepgedpmhhouggvpehsmhhtphhouhhtpdhrtg
    hpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehkhihl
    vgeskhgvmhhithgthhgvlhhlrdgtohhmpdhrtghpthhtohepihifihgvnhgrnhgusehrvg
    guhhgrthdrtghomhdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:LOC1aIXunvUu8ny-gc3DTjmTtAN5Njbc18IqGmVGuypylItzVxRpzw>
    <xmx:LOC1aIBaKeZ_fTb1XFvOT-VmewfgArkCMU1NIbmKNPRKlbQ9imLpRA>
    <xmx:LOC1aP6b1Rxu1BKYVPHjMIMSPTUKxQ-rOBCsNewbPWPq7k4BYTx19A>
    <xmx:LOC1aLyFbl4WsW4QfZXQbWzmz6BVnyvm54X7pNV3_gkF-gDRdUSw7A>
    <xmx:LOC1aNKnDkkocgT0PD6desYdqhDgp0lqJa_yWRv-Ip9P6vg7XsUHnqjk>
Feedback-ID: if76040f2:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 1 Sep 2025 14:04:27 -0400 (EDT)
From: "Kyle E. Mitchell" <kyle@kemitchell.com>
To: git@vger.kernel.org
Cc: "Kyle E. Mitchell" <kyle@kemitchell.com>,
	Ian Wienand <iwienand@redhat.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH] doc: fix formatting of function-wrap shell alias
Date: Mon,  1 Sep 2025 11:04:18 -0700
Message-ID: <20250901180419.2212086-1-kyle@kemitchell.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a missed backtick to the end of a code segment so that it will be
rendered like preceding examples.

I deeply appreciate the thoroughness of this documentation.  I noticed
the formatting discrepancy reading https://git-scm.com/docs/git-config.

Signed-off-by: Kyle E. Mitchell <kyle@kemitchell.com>
---
 Documentation/config/alias.adoc | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/config/alias.adoc b/Documentation/config/alias.adoc
index 2c5db0ad84..95825354bf 100644
--- a/Documentation/config/alias.adoc
+++ b/Documentation/config/alias.adoc
@@ -38,6 +38,6 @@ it will be treated as a shell command.  For example, defining
 ** A convenient way to deal with this is to write your script
    operations in an inline function that is then called with any
    arguments from the command-line.  For example `alias.cmd = "!c() {
-   echo $1 | grep $2 ; }; c" will correctly execute the prior example.
+   echo $1 | grep $2 ; }; c"` will correctly execute the prior example.
 ** Setting `GIT_TRACE=1` can help you debug the command being run for
    your alias.
-- 
2.51.0

