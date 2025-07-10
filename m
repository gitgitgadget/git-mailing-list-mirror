Received: from fout-a5-smtp.messagingengine.com (fout-a5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88D3228FAAB
	for <git@vger.kernel.org>; Thu, 10 Jul 2025 09:12:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752138775; cv=none; b=B6ZBzCWs8u754xRK+9bWS4z+VrPRDbX3YnxS5icx6DmleWMZKp/gy94eH2lL7Wh3R8Jgwh9WCJ9kEeWu0SQppTbG4aHPcAE5U8b/iEpSeiJ1QGfyPwrj3DCNPeXUlbghCvTdfXcfR2eE6gJKj1cYAejhrFgKRn1N5Iyt+djCixY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752138775; c=relaxed/simple;
	bh=BvLM0+5ji0kYDvRbrZdZ8CfMb+wi/Xo/LrjTMYNJJGk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=Qqm/VGm0zH6zsOQa3JEmXKWejYvCkaRbAfVeYsSqUY3WS/znMkLMqdRTrOZsspbUB3IpocXPAUUXpFP6qQ59t3vnNEMo7NPHYn3pT01Zp1hSCPCxkRFbkZTvX7nX+4xKHx5pfz2jY0exIfWbpqbyxwoVur9ewUnsTw9B+wnXdPE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=q541wfi7; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=VMZWuDkW; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="q541wfi7";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="VMZWuDkW"
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfout.phl.internal (Postfix) with ESMTP id 87500EC009A;
	Thu, 10 Jul 2025 05:12:52 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Thu, 10 Jul 2025 05:12:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to; s=fm2; t=1752138772; x=1752225172; bh=EM7KxOYf5W
	aaNdBRALOh190EJSLw4HFLOCrum2PKccc=; b=q541wfi751VKeO1T9JZPpeGzV8
	AVupuc6rWib6mHbxxkuNtTmJ0tLOxxK1M2vjd9xDYk7dTlM54np9T/A/JFet6mlS
	EdKC609Sn5oCbf9K6meLYtSr3VuRrLxahXSZvEFQclLkmoFFiaswJ1v5X68zcTB6
	3mRi4K8Ym1qQK2eP2c/ZW3mejdfRc4TD1zCBsGC5zyvshuQt1CrW52TMXxt+WB3S
	cyRFjKsPxvHbwq3pvoo8iw8+8JkJed94hYW2LD2ClIXWcARSw0Lyrlhv5WAXERME
	PTaqdcPWRRlHb1USFJ0rTo5FMG3YQ/eD/76KUegQ2Pz77kAC0GxsdtFlJWuw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1752138772; x=1752225172; bh=EM7KxOYf5WaaNdBRALOh190EJSLw
	4HFLOCrum2PKccc=; b=VMZWuDkWZ76U5fn4OlP8qffKRlhfEvPKAbRIzy4B8/th
	Vwz3L2SWBf2y9ANSFe/zZyqGL72P9hGSh250sg90TKDOv3ACHl5Qr04HfistZMrx
	A8vewXjhaM3tY+lU94DlsI2JfBv8SLozF1Q7Mw24XbmQSNenpA+vaw745LUuk6RR
	rjqZznECs72OULq00EEfGLQRE4tqjec8l588PlnhbPo4LNVkLv5FcnhxtzPogSoH
	h1wRuNlO+dRaUZCW/irqd/FeezrfHJ+mfpQR5RtMQD/YfjHVqpQaNknnG4x4Lt8t
	YQu1cSiybvY+9SU+6/FL6gJN9RoKJWB24DJPllU+2Q==
X-ME-Sender: <xms:FIRvaJdx1vIw8PhVMHn2wBI18kKdbH1UtZbRu69t10ELPYoK2sdTGg>
    <xme:FIRvaHb92OxzqPs6hgcd13ABOL7wagcly3Ojc7M4jrQJgOf4y3SDvcJELqLYN38K7
    f_IXSuO8JqJ4F1Uaw>
X-ME-Received: <xmr:FIRvaEU4vvDnQNGvNGP31MeQlyvAyTK4pUR-JT7sDw2242eApt3JAHupS9qf_aPvZ4iLBt7MOEUcIKNAYqfpg5yTQmj6c3BqQ4qxSxgqvnQSxw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdegtddthecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhfffugggtgffkvfevofesthejredtredtjeenucfhrhhomheprfgrthhrihgtkhcu
    ufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnhepie
    fgiedtffffvddvueehheejheehleduudfhheekkeeggefgueffheevgeetjeefnecuvehl
    uhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrd
    himhdpnhgspghrtghpthhtohepvddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohep
    shhtrghnhhhusehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvg
    hrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:FIRvaBhx7gYnLOMod_HGkc2l1Ct1qKjY9K3x0nxbK7--ptym_LQ6Qg>
    <xmx:FIRvaKWi2dzIEW2Yx3h2_ndg7q7SYgkSdxus4e1cyudZCoTx_YtOgw>
    <xmx:FIRvaAMxe3Klr9Q_z6sWUcIGzhRCvuvmhcyRLCV2jT6XvAkEcrtg_w>
    <xmx:FIRvaOaHEucT0GnCaxMxYi4AFHdohWfmki6Qmb52VPNI8TOSBTDywQ>
    <xmx:FIRvaAi9puN-9VAUOUopzbz5YfRLVF_rBKJ2T_7Q3YtFEKt_GfMGGvIx>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 10 Jul 2025 05:12:51 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 44414c25 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Thu, 10 Jul 2025 09:12:50 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Thu, 10 Jul 2025 11:12:40 +0200
Subject: [PATCH RESEND] sane-ctype: fix compiler error on Amazon Linux 2
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250710-pks-ctype-v1-1-1db7e7568ea2@pks.im>
To: git@vger.kernel.org
Cc: Stan Hu <stanhu@gmail.com>, Patrick Steinhardt <ps@pks.im>
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
glibc version. We don't explicitly include <ctypes.h> anywhere, but it's
being transitively included. So chances are that later versions of the
toolchain reorganized their headers so
