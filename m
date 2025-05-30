Received: from fhigh-a5-smtp.messagingengine.com (fhigh-a5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6377F22B8B0
	for <git@vger.kernel.org>; Fri, 30 May 2025 13:31:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748611918; cv=none; b=eNGoWnbnC+c+HvM3bwK46zWAGaM8O5PB645geMdJBF5u5m9uBTIfGjQlfnX3GYCxYxLfXJTX6zXR6+LZe1NRku9ZWPJuUH3BwwRBQBiDftyP+cyzJEcjF4ecD+9FFoqc1Z/+RXRP2iu7m323weUbt4OGjXj991lc9Aee79ZOotk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748611918; c=relaxed/simple;
	bh=UqvP+0+YKP66l2+/UcTcdL+TIa5v85uvZ9t/4unA7/U=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=nrxukCc4bp8UwgkTqdQA8WmHcMuujmuB37+HFX3OYgbw10bdLj06tDIOVTkHDwfDMqSkl6jrOphnbyc/xJCTnBVaIIE41n9o64OtAp7Tdp0Ejkk7UATTjbDls+gIzh++LFXhUHBI1JDLqSVKquJu9vQC1WbF6A5V6ww2XMOiaf0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=pmsvz4Yf; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=OtxQdii1; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="pmsvz4Yf";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="OtxQdii1"
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 939A8114016C;
	Fri, 30 May 2025 09:31:55 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Fri, 30 May 2025 09:31:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1748611915;
	 x=1748698315; bh=UCOGs1jeI9vQTj8OpfCBgEtWq2hK/BCM4a7997hJgSY=; b=
	pmsvz4Yfa7UP9NN6G0EEsOcmZ1/c1TT3/WQJelorrnO+4kRFaEZSZKCTM8TZsd8b
	QzyCSTPpBY7iUOtkM0SBK8eT9NqKIUeeUjPW01TYYcuxJ+d1pf8DbqAfJ3UnpOFe
	b5iwWCyzwGOR4l6D23reAlN4vVoGq78TKlwgilqhL4CmXgNtp0ynwvO0w5tZ1eR2
	doIVzccusjdqvQbdpStDQbIRyoB26xwEG87IRj/+5mTHfTbBGi5TmStdZw28Q7eY
	dlvI/cLmnwC/bjs1U0EQilzorRQhxC0GQkVU9TeOS6gFWlXjrJzVLPTVOkQWvQN8
	GaAHgHEXkDX4vFLy0+Ofbg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1748611915; x=
	1748698315; bh=UCOGs1jeI9vQTj8OpfCBgEtWq2hK/BCM4a7997hJgSY=; b=O
	txQdii1MiNO7IbpoK9YHkYWz3+ujdkQMcNN6LDBMkq/uHfcPRzoEm8LUh+Sj8SSp
	95XMaFTJSpjEpDgkx+CBsLQ1oeIMTNuTpmdD+ueuEjWWJrTJgZHAmsvFxJXEQzUZ
	a7E6dRPDliSY3oNnSROPiE700jeSOBXwPiof52WYuP3yMWgAAPQSoJuZoR85dHHq
	DDBTrosW0Sa8bVLvvb8579Ka61ZOMioubyLmKEwuh3JxTP4VuE+qglfx409bqtSO
	r5ZxxclnPI2qOQTUTTEIMRYbacI7vfpVyxnB895cvk/wvL3GZ3ZVmMc2I0YJ47tJ
	6mJaRifkiHHsfu1kDo5Hw==
X-ME-Sender: <xms:S7M5aOzqGGr6jfZBAHU_RmQwEmR60jgTEeB1hxZ53tyrlolo4aTJvg>
    <xme:S7M5aKQqMhGxFtJXnfhNMQ7kuDf9UTgsISt-w8sPDd2EqBY4lbe6DHxmq-MEe6VR8
    N9ALlfQU9DPgSnQrg>
X-ME-Received: <xmr:S7M5aAXYO-MPdPsu6o_eahMvBh00hv0QDZr54Bs8GjqY_wS_00vpNrCfpmSulNYcx9jCERhyHzYh-Ob2H6DI-3ngXFMlVnTgiC85Tjoe2Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddtgddvledugeculddtuddrgeefvddrtd
    dtmdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggft
    fghnshhusghstghrihgsvgdpuffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftd
    dtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhfffugggtgffk
    fhgjvfevofesthejredtredtjeenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrg
    hrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnhepffeuiedujedvkeeh
    uedvkeefffeivdeuleetkeduheejteekgedvudfgtdfgieelnecuvehluhhsthgvrhfuih
    iivgepvdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghr
    tghpthhtohepkedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepkhgrrhhthhhikh
    drudekkeesghhmrghilhdrtghomhdprhgtphhtthhopehtmhiisehpohgsohigrdgtohhm
    pdhrtghpthhtohepphhhihhllhhiphdrfihoohguuddvfeesghhmrghilhdrtghomhdprh
    gtphhtthhopegvshgthhifrghrthiisehgvghnthhoohdrohhrghdprhgtphhtthhopehs
    uhhnshhhihhnvgesshhunhhshhhinhgvtghordgtohhmpdhrtghpthhtoheprhgrmhhsrg
    ihsehrrghmshgrhihjohhnvghsrdhplhhushdrtghomhdprhgtphhtthhopehgihhtshht
    vghrsehpohgsohigrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlh
    drohhrgh
X-ME-Proxy: <xmx:S7M5aEjkDkSMe5u7cEb9l0H-fJvaGfSMn685fqdGcLw1_J5x9iiD7w>
    <xmx:S7M5aACnE3r4EgzvpwXC53G1XyBbuTeD2ia7AgJRAYVoNP0pBnkV2Q>
    <xmx:S7M5aFK3TheT3-JX5psvapUhdJ_9xzj2R2c7PJnjSfk0GaAJd828FQ>
    <xmx:S7M5aHBLbTOcJ94W5FHd5t9ytP1hC83Q8MwRwsHvaSIRhDu1zDCUiw>
    <xmx:S7M5aMVXwWD0xTAavb01i2zn7y2sBVc7TB7H6vYScg7vFm4l1xhzJVLN>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 30 May 2025 09:31:53 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 7aec9c74 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Fri, 30 May 2025 13:31:52 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Fri, 30 May 2025 15:31:45 +0200
Subject: [PATCH v3 07/10] t7815: fix unexpectedly passing test on macOS
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250530-pks-meson-tap-v3-7-676f5e41f2e4@pks.im>
References: <20250530-pks-meson-tap-v3-0-676f5e41f2e4@pks.im>
In-Reply-To: <20250530-pks-meson-tap-v3-0-676f5e41f2e4@pks.im>
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
Meson surface that this test is also unexpectedly passing on macOS
though.

It is unclear how long the test has been passing on macOS already.
064eed36c7f (config.mak.uname: only set NO_REGEX on cygwin for v1.7,
2025-04-17) mentions that the test started to pass for Cygwin once it
has imported a newer implementation of regcomp(3p) et all, which was
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
introduce support for TAP. So instead of fixing the bigger issue, ignore
the test on Darwin like we already do for Cygwin.

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
2.50.0.rc0.604.gd4ff7b7c86.dirty

