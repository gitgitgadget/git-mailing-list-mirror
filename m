Received: from wfhigh6-smtp.messagingengine.com (wfhigh6-smtp.messagingengine.com [64.147.123.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 796EB199D9
	for <git@vger.kernel.org>; Wed, 13 Mar 2024 09:08:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710320936; cv=none; b=riETciCQMo9334us2T1mrwx0DKQaiGA92bsQHvdxt0AsV9/Sm55dGYXPKWj2V4cNGFmRnJjKQj5//bm9oyzLtp7ynoIIQyT9/OvQGCiyy10jtON8x7YZan2VQa/tCbqUD9nRGXYAXrH/VL4eCHqLxl57hF+rPOQW/DNgtv4kVc4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710320936; c=relaxed/simple;
	bh=Ac4R77CViyK5Kqcy21akoLke142tEyhhK7ZibeKMyz8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=DiE1DMqUxn2ZIoooDlqzkyTd1tRYZTAbq0FyKT48iuKbdflmn3PZERLWyBV9Y7z8MRzvffq4gVsk4JNQNUNNIDWVJ0u0DCCAWz/7W9ejx73M4CDsUlE4iG7k/T3F0sBgcWGbiX/QNewrVk6IyYoWYMBaLqbhWP1IYY0LDh/B4vs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jamesliu.io; spf=pass smtp.mailfrom=jamesliu.io; dkim=pass (2048-bit key) header.d=jamesliu.io header.i=@jamesliu.io header.b=U6SYO+/O; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=iMz3bk8K; arc=none smtp.client-ip=64.147.123.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jamesliu.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jamesliu.io
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jamesliu.io header.i=@jamesliu.io header.b="U6SYO+/O";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="iMz3bk8K"
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
	by mailfhigh.west.internal (Postfix) with ESMTP id 5AE8918000AA;
	Wed, 13 Mar 2024 05:08:53 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Wed, 13 Mar 2024 05:08:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jamesliu.io; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to; s=fm2; t=1710320932; x=1710407332; bh=JLexi+x6udSQS+BWl3hnA
	h3ITRKsYIfTFT7P0gkwvjw=; b=U6SYO+/OQb8veHIDN0bKmpq9xw+M6ZUOBssiq
	lBtdApsbkgt6mKyPPBvxo7QiLnFr+NIS0NDcK5W9V1TqIcrz6Kru7qIA754y6Enn
	tNAukxCdg0rIz3zLjCviIOu/bHW3YKyEN1qX8kff+8G51QqeQd77sIhfQcr9GDMO
	i1PXAckX7pX4D3P+AiItjbUx5izorLUKAKjlctk3cCVC+XqnfzPiPs8915P35ljm
	3c8cQY+OXivdbx5QRqXTdQWXQx1/JICYuKSDpECRSHwqtxdrxyrsG17uaZzJPB4C
	uZIMGcDt7jvjoq5Rk7fnkiM7dxoQ31/Hoc+szPDPRRwpIT0zQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1710320932; x=1710407332; bh=JLexi+x6udSQS+BWl3hnAh3ITRKs
	YIfTFT7P0gkwvjw=; b=iMz3bk8KM1o57VfjKDkjxW2p5UHLWOMEZpbakiCYo57J
	PFJZII19k4mqHQ8xxgPPclYZ9B+fn0VS3oHOpKDylFHX77lbxV2/MyDvoBPZnass
	MzgpCKBbD5RUCjFlmtUJQyUUmzhqDEUsIoYmSqCnHFC135h5+eyaDwPwJtgcY7PW
	IpNQ/AUJ1asr/w6khP352f9Qo20aKLcGdASlqpA272woKiAhz/aKz8ESPDN4ta3q
	w8jQ3P6P1V8B2tFy0Dfkxc7pCn961CMFqnUmUsoRmqYHwAaBC6x/r/hidHE0X2kr
	WOuuV6JzmmfrLXJTlnE//NHpwEmSK8/J3TEPrq5Viw==
X-ME-Sender: <xms:JG3xZWhPYcm8qxOcYlixHctcCGrrUqdrfbtgYPKVSP0-810tDexaCg>
    <xme:JG3xZXBbnNdmOvZK2tO0udFxQ3ujH_5aeGv1vu1hYoEZfWjFGyARxoHUMoex5bZda
    Sfh6g44NEiQX7acPw>
X-ME-Received: <xmr:JG3xZeHmWapTWTs-ksfB9huuA3LDTB0RqHLgcQQytS33uzhdl9szd8rGeyYviodG942jnjoXgYuND0_odzHS0vnyC75F9Y-Jnkehy2vC9O5Al-EsQCa02BZw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrjeehucetufdoteggodetrfdotffvucfrrh
    hofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgenuceurghi
    lhhouhhtmecufedttdenucenucfjughrpefhvfevufffkffoggfgsedtkeertdertddtne
    cuhfhrohhmpeflrghmvghsucfnihhuuceojhgrmhgvshesjhgrmhgvshhlihhurdhioheq
    necuggftrfgrthhtvghrnhepfeetueelkeeuheetudeigeeggeetgeegtdetudegfeefvd
    etjeehgfelffffheefnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghi
    lhhfrhhomhepjhgrmhgvshesjhgrmhgvshhlihhurdhioh
X-ME-Proxy: <xmx:JG3xZfTfBIg9yXo37IkvRg_rZyt4gMYTs01PEyMoWh-euDOcVKyaog>
    <xmx:JG3xZTxXfJS_I5PrqMWZFA6_J6O0wWdWsYOovbHsxt3mVrDF8T76_g>
    <xmx:JG3xZd6oh-Pmkqeredq_qUS3GPq1E4N8gb5mch6REeJbUfw3nTH-Nw>
    <xmx:JG3xZQzsv2X9MvVyAxEGfCFdqbualwpJKE7Hfl6SmAWBkHGk6z3r0Q>
    <xmx:JG3xZT8MHcYgyv14AqABwsVims2XCPGUmiwlx6Vp4uuEySpofCEXX_fINIs>
Feedback-ID: i93f149ec:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 13 Mar 2024 05:08:51 -0400 (EDT)
From: James Liu <james@jamesliu.io>
To: git@vger.kernel.org
Cc: James Liu <james@jamesliu.io>
Subject: [PATCH 0/1] log: make the --oneline option work with -L
Date: Wed, 13 Mar 2024 20:08:40 +1100
Message-ID: <20240313090841.36717-1-james@jamesliu.io>
X-Mailer: git-send-email 2.43.2
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hey folks,

This is a small patch to fix an issue I've experienced with git-log(1)
when certain combinations of flags are provided. This is also my very
first patch submission, so I've tried to limit the blast radius as much
as possible. I'm also unsure if this is the best place to implement the
change, so any feedback is welcome!

I'd like to ideally add a test as well, but I'm unsure where this should
slot in.

git-log accepts the --oneline option to display the short commit SHA and
title only. This is a convenient option when searching through Git
history, as it gives a rough idea of the changes introduced in each
commit. git-log also accepts the -L flag, which lets us provide a line
range for a given file. This is handy for limiting the search to a given
area of interest.

However, when --oneline is used in combination with -L, Git actually
outputs the single line commit information _as well_ as the full diff.
For example:

        git log --oneline -L 660:Documentation/MyFirstObjectWalk.txt

will incorrectly display the diffs too.

This patch aims to fix this behaviour by respecting the --oneline option
when used in conjunction with -L.

James Liu (1):
  log: ensure diffs are omitted with --oneline

 builtin/log.c | 4 ++++
 1 file changed, 4 insertions(+)

-- 
2.43.2

