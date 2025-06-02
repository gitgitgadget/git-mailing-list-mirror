Received: from fout-b8-smtp.messagingengine.com (fout-b8-smtp.messagingengine.com [202.12.124.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F38D1A00FA
	for <git@vger.kernel.org>; Mon,  2 Jun 2025 06:45:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748846704; cv=none; b=IJce+6my6JkXKRHofotlJaHXGalmpgxvCYj1Wk8PlJhDx9sEDjewFBLpAltXpM4VDBUq7oSRX7U1MvSZ3I2+yqrjhnFP3Tnm0MSiWpnWvz/pb7SENmo4QglcwncVfor0D1gi39LNIu8HFxdMYn1kUTSZ82h2/UcLKP/KDmqeoJQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748846704; c=relaxed/simple;
	bh=mJ5o9NroEREMNun62xMMSGSfjEjDcEBpv9hqmau1aPo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=T28DzpZZCRizJRYOHsXS3NuGorI2VbdEwjmV42YoYDV1yoPx10AIZIrrMHCJ2K5ONH/N1DTHkmBIErYVla0mRuoWz0zLg5ZyUelnOUD+CvEpsjIF23r/+DxLmztCyp46mTGTQrmRT9fSKZndm9o242JPMuwO2ENqXb1HhLVM1SA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=SVahdSoF; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=fBfB51B1; arc=none smtp.client-ip=202.12.124.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="SVahdSoF";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="fBfB51B1"
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfout.stl.internal (Postfix) with ESMTP id 68C94114014F;
	Mon,  2 Jun 2025 02:45:01 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Mon, 02 Jun 2025 02:45:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1748846701;
	 x=1748933101; bh=d7VYdJ4hG1GOef+SLnr7lAqxsiVTn2hOl4nKfIU7t9U=; b=
	SVahdSoFMPxulmkgqt+7xCbnN8WzEEuNuzXktM0CUeMC2CTTp4O2+tlykOePZ64V
	v0lpB6xz64Qslc0i8aT/tVaJkZkJxYsfj9MhkJ1MOb/4VfvrKhXa0JWDMVHsEJIP
	JFvknGwj3/FacSu6nyH9lV8IHzLExH1GEITk+SPYCY3nSPaZYSJ5w6lb0prArdJz
	S4QLUy/F+zMOkPEclTAty7UkTPGYhGv1SRkGCL/8OmB9T0mFPXUb++SCa9+8CfCB
	sib6DAmGMkvsbmmjkljcE67zVegaCn3FDh0GSqCG6Wu9vPrquVhAUexi2VeDCocX
	LH9mcV5iRGJvt4BMaAptug==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1748846701; x=
	1748933101; bh=d7VYdJ4hG1GOef+SLnr7lAqxsiVTn2hOl4nKfIU7t9U=; b=f
	BfB51B1sASrHGNcE9UwGBiNwmWZKB02UoWh1fMQIgGDw1RY/RMXiZ+cYmtRvIGFN
	n/lUAuJ6b9QMseyAQWCfIrUpkOz8Wh14kzaUJGw7SOBhwIQL9oUZtb9S9wN4SngC
	69911oIMnrmvkKsKJVK8i2O/oiXtQTae24ox382NwGu34Nz0bBeGcOhuU74lr+Dz
	JOW1Or/t4/L2aY37BqzEMm9MNta0IpwNO/n9V+MWax4MFinp2NsQxHXZZt9G+1T8
	p8Ywdz6q6MBNqH0AfdsSbE3rbjMk1q4WMtfdBC7QhfRUqIVC1QJu8IzaHyB7IuvW
	4/8C04Jax9sNx+NFSzXww==
X-ME-Sender: <xms:bUg9aNLMdgx2EtHVdK9vDC4XO9ilwqD2ufjKH2xb_LnCA6-ul5QfhQ>
    <xme:bUg9aJL9J0BI3moEE0Dr2zpg-4hgfTwvgdIrbHIWKJxMXdf1ODn1cKUC0WgHHqd-p
    6ix8pEMWxT9uq2n3Q>
X-ME-Received: <xmr:bUg9aFt70JSKO5bE7D1zKmk5bLOIZ5cpSI_A4PXH5f5fhQr6TAso_eP49wVLDCc7DLOswvp7cdUfGlqNj0Q0OuwysxltJOJvMXYYs2dsBwZxWw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddtgdefieelleculddtuddrgeefvddrtd
    dtmdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggft
    fghnshhusghstghrihgsvgdpuffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftd
    dtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhfffugggtgffk
    fhgjvfevofesthejredtredtjeenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrg
    hrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnhepffeuiedujedvkeeh
    uedvkeefffeivdeuleetkeduheejteekgedvudfgtdfgieelnecuvehluhhsthgvrhfuih
    iivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghr
    tghpthhtohepkedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepkhgrrhhthhhikh
    drudekkeesghhmrghilhdrtghomhdprhgtphhtthhopehtmhiisehpohgsohigrdgtohhm
    pdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhope
    hgihhtshhtvghrsehpohgsohigrdgtohhmpdhrtghpthhtohepvghstghhfigrrhhtiies
    ghgvnhhtohhordhorhhgpdhrtghpthhtohepshhunhhshhhinhgvsehsuhhnshhhihhnvg
    gtohdrtghomhdprhgtphhtthhopehphhhilhhlihhprdifohhougduvdefsehgmhgrihhl
    rdgtohhmpdhrtghpthhtoheprhgrmhhsrgihsehrrghmshgrhihjohhnvghsrdhplhhush
    drtghomh
X-ME-Proxy: <xmx:bUg9aOazX5LRS5usa7fiXpV3sagoK50JDpDjOZVv2rSLRhcjiXKiSg>
    <xmx:bUg9aEYBrNa62nf606Xz__0WYTAQ4vPi9QqcjddQam-8fj8HJs9yqA>
    <xmx:bUg9aCAL0FGJrshuGVyxeU150K1Y0W62LMJc0XuNuzD6xiGrwt4Xzw>
    <xmx:bUg9aCYOsTNdpXb_viMsjpiu0OBKwNKuj96vHBOcpMbvL3pS-Agq3w>
    <xmx:bUg9aCsAqSfmlEoXHdVo51Is3mNPfEJGYudGaL07rsYuZSL8I3WmXvbx>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 2 Jun 2025 02:44:59 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id dc8d7c5d (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Mon, 2 Jun 2025 06:44:52 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Mon, 02 Jun 2025 08:44:47 +0200
Subject: [PATCH v4 07/10] t7815: fix unexpectedly passing test on macOS
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250602-pks-meson-tap-v4-7-052dfde0818a@pks.im>
References: <20250602-pks-meson-tap-v4-0-052dfde0818a@pks.im>
In-Reply-To: <20250602-pks-meson-tap-v4-0-052dfde0818a@pks.im>
To: git@vger.kernel.org
Cc: Phillip Wood <phillip.wood123@gmail.com>, 
 Junio C Hamano <gitster@pobox.com>, Karthik Nayak <karthik.188@gmail.com>, 
 Ramsay Jones <ramsay@ramsayjones.plus.com>, 
 Eli Schwartz <eschwartz@gentoo.org>, Todd Zullinger <tmz@pobox.com>, 
 Eric Sunshine <sunshine@sunshineco.com>
X-Mailer: b4 0.14.2

In t7815, we have the following test:

    test_expect_failure !CYGWIN 'git grep .fi a' '
        git grep .fi a
    '

The test passes if '.' matches a NUL byte, which we expect to only
happen on Cygwin. The upcoming changes to support parsing TAP output in
Meson surface that this test, surprisingly, passes on macOS as well.

It is unclear how long the test has been passing on macOS already.
064eed36c7f (config.mak.uname: only set NO_REGEX on cygwin for v1.7,
2025-04-17) mentions that the test started to pass for Cygwin. This was
attributed to a new implementation of regcomp(3p) and friends, which was
inherited from FreeBSD. Given the BSD lineage of macOS it is feasible
that it also inherited similar code eventually that made the test pass
now.

It is somewhat dubious what the test actually brings to the table given
that it is quite platform specific. Ideally, we would fix this mess by
having a configure-time check whether regcomp(3p) works as expected,
including NUL bytes, and use our bundled version of the regex library in
case it doesn't. Like this, we could ensure that all platforms work the
same in this edge case and mark the new behaviour as expected.

This change is outside of the scope of this patch series, which only
introduces support for TAP. So instead of fixing the bigger issue,
ignore the test on Darwin like we already do for Cygwin.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 t/t7815-grep-binary.sh | 2 +-
 t/test-lib.sh          | 3 +++
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/t/t7815-grep-binary.sh b/t/t7815-grep-binary.sh
index b7d83f9a5de..55d5e6de17c 100755
--- a/t/t7815-grep-binary.sh
+++ b/t/t7815-grep-binary.sh
@@ -63,7 +63,7 @@ test_expect_success 'git grep ile a' '
 	git grep ile a
 '
 
-test_expect_failure !CYGWIN 'git grep .fi a' '
+test_expect_failure !CYGWIN,!MACOS 'git grep .fi a' '
 	git grep .fi a
 '
 
diff --git a/t/test-lib.sh b/t/test-lib.sh
index 8c0d76ea5f0..0a124ffad38 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -1636,6 +1636,9 @@ fi
 # Fix some commands on Windows, and other OS-specific things
 uname_s=$(uname -s)
 case $uname_s in
+Darwin)
+	test_set_prereq MACOS
+	;;
 *MINGW*)
 	# Windows has its own (incompatible) sort and find
 	sort () {

-- 
2.50.0.rc0.629.g846fc57c9e.dirty

