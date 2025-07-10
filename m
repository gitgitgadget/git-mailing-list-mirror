Received: from fhigh-a5-smtp.messagingengine.com (fhigh-a5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29CFA28B4E0
	for <git@vger.kernel.org>; Thu, 10 Jul 2025 07:56:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752134219; cv=none; b=deL9rE4wmjtq+/+QaQZTS+UBDkn7ZzQ9m8cBOFwz1zb4REbAidUaFuGDLPc0bIQ1ZaIgg4AdedA0yp4Owd6mQq02hyvOlaWQ/Bln1KfLjTb6O7VU4IYcxrW/MNng8JTEnILsRBkL68/rq3gHjLxXOqYmoipbWfc3GWomsBIyB2A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752134219; c=relaxed/simple;
	bh=55YAHwedSB4z5/r7zqmJwkdbpSmT6CjVLUl5japNkPY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=GUiTAAOdTo3r8oeN6CwUWQdTK9eWILwaDjp8RME/3KrLMgj5OUu3jI5/SYzarU01yO/Ww2qTz+qadbAbfDKFgasRAAc61OOVbdUdq/s8qOzaUusZOUbxStZcfFlUSJbKBZE/xZuDXWZ6lsf/+NbdJ0rhAH0dpR50HjrT2Wbhcpk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=xrkAFoey; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=S0HBCH3t; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="xrkAFoey";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="S0HBCH3t"
Received: from phl-compute-12.internal (phl-compute-12.phl.internal [10.202.2.52])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 1C76614001DB;
	Thu, 10 Jul 2025 03:56:56 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-12.internal (MEProxy); Thu, 10 Jul 2025 03:56:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to; s=fm2; t=1752134216; x=1752220616; bh=kiPREdMYld
	UcusZgPbhKH2GIOmUawOXOInqzq40Wav4=; b=xrkAFoeylYB4P9Un9ojRTrN8hE
	hAs8CXnfhJrBau1O6r4/wAU6OCFNN0HUmDAQH7qMX2j59BSbbaUiOJAJP+bsYvEM
	pTWU3LYNS9fPo+pXLMIheK4TtsN/gmCRwIZInOKN2/0LLOnXAWcUaLOtzfg3AZlg
	a0wdV3lt1EPPPniJLFmJkKcZUZCGCqd2uOfNXE8w5GQGkCZjsvLUCDLYM0WgX7k7
	ht/3bmzhfAsi2jWlz9cmj3cnPJygHcCbBYJ8501kfMNgmY5MKBEH5sVf/ztr6toq
	D74vA6nv9RacK2uYfJJqggVkxiZNpDiw3JNHzx6uxr697MZ4g11cGTxbXC1w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1752134216; x=1752220616; bh=kiPREdMYldUcusZgPbhKH2GIOmUa
	wOXOInqzq40Wav4=; b=S0HBCH3tBcEGEVQlVaH1rMQRjrEMKeNdoZwGo6j15YjB
	/KLMj9LV8weoCUZ/QyI6Nd7ZZ+XrHG5YPDy7uwazbwZmA5BNVVLowP43eV8+tZFZ
	BAQSygShawVa7J5PQmxtGaFkkXccPk7+2Os2mEAgdXHBR6Joq3jpL8kcb3MEXnKQ
	mQB7m67WDRHLafDwxAYey7vVMlfCr3dlEzSp0Asv0lVKZoNscWwLejEyLkahXdgg
	vGZzhIrSm8K/G/1qoZQePSQZRp7U6mx67S+mKgMDtcwAd3o712g2ycD9Ztv6U0OQ
	p62hyIRhp6ZQTj2r4xFP8A5l7ARf1TRNzsHPniMtWg==
X-ME-Sender: <xms:R3JvaHcn4adzMhmj_yFvS8JeNBm9BnxgW8WgvuR6_sfJuoRR_eaK_g>
    <xme:R3JvaNatT4xfXxZKCnqvyr_5H2V58YzIMPJCb4MIwxTWHxJ6eVD9HEi5VDPYSHuHF
    kr2B1jC9S3gwqBpLA>
X-ME-Received: <xmr:R3JvaCWRPVHXb1n1EODiz2g6AtfDjzhUoLzv7me9x3CrzPLUT85ZTdf_24CARXanbs01gRCMuZafrBARxRR6k_9BnC18buZntzrGzF1stUGY3w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdefleeltdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhfffugggtgffkvfevofesthejredtredtjeenucfhrhhomheprfgrthhrihgtkhcu
    ufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnhepie
    fgiedtffffvddvueehheejheehleduudfhheekkeeggefgueffheevgeetjeefnecuvehl
    uhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrd
    himhdpnhgspghrtghpthhtohepvddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohep
    shhtrghnhhhusehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvg
    hrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:R3JvaHiIgLUjhobFLkmFnTB7wQZVMx-wPnjY23i8CUldeMRnUqS1oA>
    <xmx:R3JvaIXWjT4C9LSKcZC94TGK4MfSBX6KqiiczjHV4TSSDO4U63A3zQ>
    <xmx:R3JvaGOHUAWGIOjeHOsaRIFCoQ4ymM33JOPKkreLfGTwPg-2_JaqHQ>
    <xmx:R3JvaMaOAviVaqno4cGyA0WsoVApUSe_msNHU9ENBqOhKZAiXBL5Rw>
    <xmx:SHJvaLsT3Y1GfBxV_4otkvCJnHl_AcMqPTZ5YRg4Cwfo_1X2R_s0jwy3>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 10 Jul 2025 03:56:55 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id cfb55b1f (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Thu, 10 Jul 2025 07:56:53 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Thu, 10 Jul 2025 09:56:35 +0200
Subject: [PATCH] sane-ctype: fix compiler error on Amazon Linux 2
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250710-pks-ctype-v1-1-c668b308d628@pks.im>
X-B4-Tracking: v=1; b=H4sIADJyb2gC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI1MDc0MD3YLsYt3kksqCVF1j0xQjwyRLEzPTJAMloPqCotS0zAqwWdGxtbU
 Ac64gmFsAAAA=
X-Change-ID: 20250710-pks-ctype-35d21b9465b0
To: git@vger.kernel.org
Cc: Stan Hu <stanhu@gmail.com>
X-Mailer: b4 0.14.2

Compiling Git fails on Amazon Linux 2 when using GCC 7.3.1 with the
following compiler error:

    In file included from compat/posix.h:449:0,
                     from git-compat-util.h:26,
                     from daemon.c:3:
    compat/../sane-ctype.h:29:60: error: expected expression before ']' token
     #define sane_istest(x,mask) ((sane_ctype[(unsigned char)(x)] & (mask)) != 0)
                                                                ^
    compat/../sane-ctype.h:29:72: error: expected ')' before '!=' token
     #define sane_istest(x,mask) ((sane_ctype[(unsigned char)(x)] & (mask)) != 0)
                                                                            ^
    compat/../sane-ctype.h:29:60: error: expected expression before ']' token
     #define sane_istest(x,mask) ((sane_ctype[(unsigned char)(x)] & (mask)) != 0)
                                                                ^
    ... lots of similar lines ...

    compat/../sane-ctype.h:45:50: error: expected declaration specifiers or '...' before numeric constant
     #define toupper(x) sane_case((unsigned char)(x), 0)
                                                      ^
    /usr/include/ctype.h:142:12: error: expected identifier or '(' before 'int'
     extern int isascii (int __c) __THROW;
                ^
    compat/../sane-ctype.h:30:26: error: expected ')' before '&' token
     #define isascii(x) (((x) & ~0x7f) == 0)
                              ^
    compat/../sane-ctype.h:30:35: error: expected ')' before '==' token
     #define isascii(x) (((x) & ~0x7f) == 0)
                                       ^
    In file included from /usr/include/features.h:423:0,
                     from /usr/include/unistd.h:25,
                     from compat/posix.h:90,
                     from git-compat-util.h:26,
                     from daemon.c:3:
    compat/../sane-ctype.h:44:30: error: expected declaration specifiers or '...' before '(' token
     #define tolower(x) sane_case((unsigned char)(x), 0x20)
                                  ^
    compat/../sane-ctype.h:44:50: error: expected declaration specifiers or '...' before numeric constant
     #define tolower(x) sane_case((unsigned char)(x), 0x20)
                                                      ^
    compat/../sane-ctype.h:45:30: error: expected declaration specifiers or '...' before '(' token
     #define toupper(x) sane_case((unsigned char)(x), 0)
                                  ^
    compat/../sane-ctype.h:45:50: error: expected declaration specifiers or '...' before numeric constant
     #define toupper(x) sane_case((unsigned char)(x), 0)
                                                      ^

This error bisect back to 75a044f748 (git-compat-util.h: split out
POSIX-emulating bits, 2025-02-18), where lots of bits got split out of
"git-compat-util.h" into a new "compat/posix.h" header.

The compiler error isn't immediately obvious, doubly so because the
actual errors are ~3x as long as the above snippet. But what happens
here is that we transitively include <ctype.h> after we have included
our own "sane-ctype.h" header. Consequently, the function declarations
that exist in <ctype.h> for isascii(3p) et al will be mangled by our
macros of the same type. The result is of course completely broken.

It's unclear why this issue only happens on Amazon Linux 2. My guess is
that it's either specific to the compiler version or specific to the
glibc v
