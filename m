Received: from fhigh-b2-smtp.messagingengine.com (fhigh-b2-smtp.messagingengine.com [202.12.124.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1ECCB218955
	for <git@vger.kernel.org>; Tue, 12 Nov 2024 17:03:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731431026; cv=none; b=Ues+P5SdusC1bjKiNFeDowYSLnGcUH3MHnWkfYLAeOEq9/NbG4QesYz9R/irgx57K01yxg3eoLY1GrKqakCcYy0D8D/6VR8QJgMb8R99aNjrQ7jYoGkSVhDjDomZifi+SSv3yfx6Sk/Y9i9c9RUPZZP8ZnE4u8UH2nAypLaK4gY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731431026; c=relaxed/simple;
	bh=8Eij0btoDsI0YNHHTeKGe8M1vyXiMXma9wvHmqq2rrE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=XQBQ0Gh/ioLYQWQ/s5C1RpJ0UW79YKbxBeHPao1dkdgeW654F3M3D4rLGEl0QUJ4d9P0PWp+pqaJEMiD4PqBOV/VX41cCcU7fuwjw0Zx6CjXij0GrLZ7feXK3XTSHqTMBUxc7PDto7irfDnDGva5lG60OMwnwRUaS9YGpxfQLgQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=XC9HNNw1; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=N0USDdV/; arc=none smtp.client-ip=202.12.124.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="XC9HNNw1";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="N0USDdV/"
Received: from phl-compute-10.internal (phl-compute-10.phl.internal [10.202.2.50])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 18DBC2540175;
	Tue, 12 Nov 2024 12:03:44 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-10.internal (MEProxy); Tue, 12 Nov 2024 12:03:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1731431023;
	 x=1731517423; bh=TEnYstT2S9C49MzFHgX13KNEUOK7toE9nCIQh84gDzg=; b=
	XC9HNNw19LfDSTFJJC9nVrA9TYfuGiMx0I40VqcioS4f4kauAo9RRiw/Z2SrSAhc
	HwiWYlXQkgEk/M8kzcQN0sWrJL5Puv+aEIxzK4aIelBWUTPbDUYyib6evTDuhAwu
	ebu5bgtZrjqIeel+1SL8WtaYqmUvLtIJgO0V27KPnsDjgUPsEtAkL+/OnNq/pBNf
	27XC/aKWxgmk+VDP5wxwftjPk5vZ34ZFfrSDsVizNJyqVJ/RosALlEGAjH26TMNJ
	e4x8KjgWNc3OHDLLdTXEqrZQ1bmvKeS9c08yYEXkH4DSxmRxazubHWdkVRPDgYys
	W94n53Hl0cuOUlsEQEK2cA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1731431023; x=
	1731517423; bh=TEnYstT2S9C49MzFHgX13KNEUOK7toE9nCIQh84gDzg=; b=N
	0USDdV/DvlZ6XVXrmzkcbhnmwzWDzzG0NBcFrh4CEGd1i+3uETCXfp/7YwR6Wk/U
	UpqMXFd+fuTeqj9Hb9jeWgMoEHhm20MktgIrPnAcd4BeHsVGVLm8zyAsldA4ruXS
	UbRARs5tiqiV5SGgCcDNsB0zV/OXXU/qCB4273SWOks64PWkxLRLTs16T6Eh0dkX
	EkZk9h/+jNoAFqme0+bRojJXQDP0tLFsHv2iSnQFgc2p+9TdVG0xh3NE0DLi/TjA
	tKA/QUZtcPf+Pa8aqEUvbsV1rL4FEgAspdzsYf8hI5nj3mnxMrziKWrzwU2cERXI
	xI5q7hWKzC8Jgr8OPkzlw==
X-ME-Sender: <xms:b4ozZ1qwZOy-DMfDOZDdBnR_beyrTTplhOSPbgy58LPc6sZUDgILeg>
    <xme:b4ozZ3oOPgR9_1aCQ-kFh-zgTvqVOVi4UYrPhWOHloF3Otq45BvaZoxtc7y6OHAFs
    c9qmJrcerxiOjytoQ>
X-ME-Received: <xmr:b4ozZyMeRqs69z2ZtMCI8X6V6ZvfzVn0boPgC4NCrd_0z-67lpdapOTeGrOkDcynur8tM3bWeAbuVpqUVOyd_U0lMV1fLy5ZrnLeJ38ng-CtJG4>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudeggdelvdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
    hsucdlqddutddtmdenucfjughrpefhfffugggtgffkfhgjvfevofesthejredtredtjeen
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepffeuiedujedvkeehuedvkeefffeivdeuleetkeduheej
    teekgedvudfgtdfgieelnecuvehluhhsthgvrhfuihiivgepvdenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepledpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprh
    gtphhtthhopehphhhilhhlihhprdifohhougduvdefsehgmhgrihhlrdgtohhmpdhrtghp
    thhtohepghhithhsthgvrhesphhosghogidrtghomhdprhgtphhtthhopegvshgthhifrg
    hrthiisehgvghnthhoohdrohhrghdprhgtphhtthhopehsuhhnshhhihhnvgesshhunhhs
    hhhinhgvtghordgtohhmpdhrtghpthhtoheprhgrmhhsrgihsehrrghmshgrhihjohhnvg
    hsrdhplhhushdrtghomhdprhgtphhtthhopehmvgesthhtrgihlhhorhhrrdgtohhmpdhr
    tghpthhtohepuggrvhhvihgusehgmhgrihhlrdgtohhmpdhrtghpthhtohepphgvfhhfse
    hpvghffhdrnhgvth
X-ME-Proxy: <xmx:b4ozZw6zFVNSE6ShVkRRo8jDN9o1h2iRDsIcwCD_gxRA-vl9yijK1A>
    <xmx:b4ozZ06VR1AOH192TiFFLfaca_MzZNke4HJcu6h7mhAslbehb0zS9g>
    <xmx:b4ozZ4hCbUeUmeC2zEOgGoKRtgPCcmBQ9EA-hqJrmoh-Ag9u9gMAUQ>
    <xmx:b4ozZ24VSUu-9wppA7aHcpiZ8vDUlYsW8dObRy-p_hoTGWjZAe4YXw>
    <xmx:b4ozZxwXFmno7ZwxaEKJnPE4A0e6G0sh5daqtJu9WBmR7Xzk1Ve3zJIc>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 12 Nov 2024 12:03:41 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 3ea153c7 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 12 Nov 2024 17:03:03 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Tue, 12 Nov 2024 18:02:59 +0100
Subject: [PATCH RFC v6 16/19] t: allow overriding build dir
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241112-pks-meson-v6-16-648b30996827@pks.im>
References: <20241112-pks-meson-v6-0-648b30996827@pks.im>
In-Reply-To: <20241112-pks-meson-v6-0-648b30996827@pks.im>
To: git@vger.kernel.org
Cc: Eli Schwartz <eschwartz@gentoo.org>, 
 Eric Sunshine <sunshine@sunshineco.com>, 
 Phillip Wood <phillip.wood123@gmail.com>, 
 Junio C Hamano <gitster@pobox.com>, 
 Ramsay Jones <ramsay@ramsayjones.plus.com>, Taylor Blau <me@ttaylorr.com>, 
 David Aguilar <davvid@gmail.com>, Jeff King <peff@peff.net>
X-Mailer: b4 0.14.2

Our "test-lib.sh" assumes that our build directory is the parent
directory of "t/". While true when using our Makefile, it's not when
using build systems that support out-of-tree builds.

In commit ee9e66e4e7 (cmake: avoid editing t/test-lib.sh, 2022-10-18),
we have introduce support for overriding the GIT_BUILD_DIR by creating
the file "$GIT_BUILD_DIR/GIT-BUILD-DIR" with its contents pointing to
the location of the build directory. The intent was to stop modifying
"t/test-lib.sh" with the CMake build systems while allowing out-of-tree
builds. But "$GIT_BUILD_DIR" is somewhat misleadingly named, as it in
fact points to the _source_ directory. So while that commit solved part
of the problem for out-of-tree builds, CMake still has to write files
into the source tree.

Solve the second part of the problem, namely not having to write any
data into the source directory at all, by also supporting an environment
variable that allows us to point to a different build directory. This
allows us to perform properly self-contained out-of-tree builds.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 t/test-lib.sh | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/t/test-lib.sh b/t/test-lib.sh
index 677424ced06a0351133d6e44d1b7ca1e77623a59..096af9be6b11b2f7f0caaa5dc187e00f4bdbf1c0 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -35,7 +35,7 @@ else
 	# needing to exist.
 	TEST_DIRECTORY=$(cd "$TEST_DIRECTORY" && pwd) || exit 1
 fi
-GIT_BUILD_DIR="${TEST_DIRECTORY%/t}"
+GIT_BUILD_DIR="${GIT_BUILD_DIR:-${TEST_DIRECTORY%/t}}"
 if test "$TEST_DIRECTORY" = "$GIT_BUILD_DIR"
 then
 	echo "PANIC: Running in a $TEST_DIRECTORY that doesn't end in '/t'?" >&2
@@ -513,6 +513,7 @@ unset VISUAL EMAIL LANGUAGE $("$PERL_PATH" -e '
 		PERF_
 		CURL_VERBOSE
 		TRACE_CURL
+		BUILD_DIR
 	));
 	my @vars = grep(/^GIT_/ && !/^GIT_($ok)/o, @env);
 	print join("\n", @vars);

-- 
2.47.0.251.gb31fb630c0.dirty

