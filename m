Received: from fout-a6-smtp.messagingengine.com (fout-a6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9218113E02E
	for <git@vger.kernel.org>; Mon, 11 Nov 2024 08:25:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731313516; cv=none; b=lkyLRtIK/0al4ZIDp20JGHd8jmAXiokmg3+x+6itdJyUq/uzHE953N6cW5YdPxcLMr8VXtBr16jfUYGcbynumEr5Mtds+Pth24dzcCNCtP6cUbJaxwfYGfyTQnZhnVVWptZJ5DnkzoshJ3lUUmhWs9OrYPHchqMqNC6vVfwv4qs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731313516; c=relaxed/simple;
	bh=fIduMhsGrBrNOaUV82Rm9WbZX0B/C6iuyugpw0bjMFE=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 In-Reply-To:References:To:Cc; b=srOWlQO1pMIdd+NLZ5ozBy30pPDbV87dzW8xm4QzUBFAEiZJtg6R8DaGAQ3vTWQ/MdhOY9QfpHFNpWSWvOIg3DKoF5+4nd1Or51J+jbDDwr38aHZtvFc4jxrayUUCRPNeD0JKqruUa3UJuwA2HCwNhqgLfjI+KCPd+X0n4nSXDo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=uXK0DLn6; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Ly6bq7ZQ; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="uXK0DLn6";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Ly6bq7ZQ"
Received: from phl-compute-12.internal (phl-compute-12.phl.internal [10.202.2.52])
	by mailfout.phl.internal (Postfix) with ESMTP id 71BEC1380136;
	Mon, 11 Nov 2024 03:25:12 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-12.internal (MEProxy); Mon, 11 Nov 2024 03:25:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1731313512;
	 x=1731399912; bh=+QEGQQy5vTS+uhCNkv5jyz7vwQqr7b6dr/g443re6hk=; b=
	uXK0DLn64gGRf4qzcB/uJ93bbjCgYDJz9uGq84Pm86ukFYVFgCjRrFj8lPUZafCv
	wjbj2EgJBczr1czV2iE65f3YucDEpYissthydzsp7DAJbDw677JwQEKcLFn9rplG
	dUS7JVE5hoRIdLkP2k3zDQ8bKFs2M5tJidxAmPPswZY0AJdFEpVlT44w2ju9A2tQ
	AnTJ3YKIyhUpLbQgwjWn35CYJLeIcvuvRf4xica/pY89fajEGlddlHWDfaQ9bxFL
	dbDIil939PaL12SKQWtbk86YncaLJv59Ntu5E7uJwJ5nunCxj+g3bjkiIq8GOTfb
	ZLvRgt2GfIuLpqp5JLxs3Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1731313512; x=
	1731399912; bh=+QEGQQy5vTS+uhCNkv5jyz7vwQqr7b6dr/g443re6hk=; b=L
	y6bq7ZQo6tfye/HEByGe4s+QpiwHMTwL2PKeVDIos/4sdWKX37XKfyxUR5hI4+pA
	3OEo3KXmN/Piiejt2ahUoJ8cQmmWEboMV5bzayzqYu7oagN8tkHjxvz3l0Hc7wyc
	fJQDMwWm6MmzvMla91uuWJPcR0BXFti85rnFOzJKBhL/AU3kRtn5iDOwf1CE28s7
	MIC4+7xvNsAKB99iPBE2idJ0CJ4Qkm8jVoS5npsvyNWf1sxbczAWcmcpBM2pJypn
	fDMY6E0EZgJABgdssmyB4J7ATYchghMzp93P7rKCQAUYqaeK0SzAt9sKMqRdPsf3
	V8kO2iT3WkOcvg4dRrgqw==
X-ME-Sender: <xms:aL8xZ4_AA687zEeEIn38h2KLiTV3o2SNUg9DFcBLCHCVhPZoSuODiA>
    <xme:aL8xZwuTY7F4ik_3IyE1yQvsQ1qDaEl88EvkXZiBQG3aM5jTjxlX09tLNJWR1OwCc
    lr4SJ0ddAxiyzAzKQ>
X-ME-Received: <xmr:aL8xZ-DVBQ2M_o5XLRXai335HXJ8vnK7TqK-r3B5ZwnCOB_UFD8rior0ksMiD1QIdzW-35de8lhnyseTMT7ddsp37EipLTRabG1ohrDR6_2OTfcw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddruddugdduudekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhephffufffkgggtgfgjfhfvvefosehtjeertdertdej
    necuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrih
    hmqeenucggtffrrghtthgvrhhnpeetueeuhefhhfeitdeuhedttdeikeeftdduhedtheef
    hfegffevgeegtdfhheeuvdenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuvehluh
    hsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhi
    mhdpnhgspghrtghpthhtohepgedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepph
    hhihhllhhiphdrfihoohguuddvfeesghhmrghilhdrtghomhdprhgtphhtthhopehgihht
    shhtvghrsehpohgsohigrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnh
    gvlhdrohhrghdprhgtphhtthhopehjohhhrghnnhgvshdrshgthhhinhguvghlihhnsehg
    mhigrdguvg
X-ME-Proxy: <xmx:aL8xZ4e8BnlxIa9IViHOZuVkmndXpJAqzOGy1-A5oayhuA_OoNV7kA>
    <xmx:aL8xZ9NT96-WvqlyS88r67P4YyIPCxgvspte4cLcz-LxoDKwUvOzAA>
    <xmx:aL8xZynfCOM6760ocG-CkOyUv2glavMyT4SXCGJOfMHZc9-7ifuR_A>
    <xmx:aL8xZ_trr10feSKtRZtQ5m23L9Ifru9E3eaZRiIjaoOHHM363vwZDg>
    <xmx:aL8xZypf5txp8weGDnv1yM7RqqM8_UrXis-K0hnIyM9jY1vUuRxQ-8UH>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 11 Nov 2024 03:25:11 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id d4f02a83 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 11 Nov 2024 08:24:34 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Subject: [PATCH v2 0/4] Build improvements for clar
Date: Mon, 11 Nov 2024 09:24:56 +0100
Message-Id: <20241111-pks-clar-build-improvements-v2-0-d4794d8d1b30@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAFi/MWcC/42NQQ6CMBBFr0Jm7RhaBKwr72FY1DKVibSQFhsN4
 e5WTuDyvfy8v0KkwBThUqwQKHHkyWeQhwLMoP2DkPvMIEt5EqI84/yMaEYd8P7isUd2c5gSOfJ
 LRGEq1UitdKss5MIcyPJ7r9+6zAPHZQqf/SyJn/2vmwSWKGsjLDW1oaq95vWRHXTbtn0Bc7KqH
 8MAAAA=
X-Change-ID: 20241108-pks-clar-build-improvements-1c3962a9a79f
In-Reply-To: <20241108-pks-clar-build-improvements-v1-0-25c1fe65ce37@pks.im>
References: <20241108-pks-clar-build-improvements-v1-0-25c1fe65ce37@pks.im>
To: git@vger.kernel.org
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>, 
 Phillip Wood <phillip.wood123@gmail.com>, 
 Junio C Hamano <gitster@pobox.com>
X-Mailer: b4 0.14.2

Hi,

Dscho has reported in [1] that the CMake build instructions for clar do
not work well on Windows/MSVC because we execute the shell scripts
directly instead of using the discovered `SH_EXE`. This small patch
series fixes the issue.

Changes in v2:

    - Wrap overly long lines in the CMake build instructions.
    - Add the VERBATIM option.

Link to v1: https://lore.kernel.org/r/20241108-pks-clar-build-improvements-v1-0-25c1fe65ce37@pks.im

Thanks!

Patrick

[1]: <3b2cb360-297a-915c-ae27-c45f38fa49b9@gmx.de>

To: git@vger.kernel.org
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc: Phillip Wood <phillip.wood123@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>

Patrick Steinhardt (4):
      t/unit-tests: convert "clar-generate.awk" into a shell script
      cmake: use SH_EXE to execute clar scripts
      cmake: use verbatim arguments when invoking clar commands
      Makefile: let clar header targets depend on their scripts

 Makefile                             |  6 ++--
 contrib/buildsystems/CMakeLists.txt  | 16 ++++++---
 t/unit-tests/clar-generate.awk       | 50 ----------------------------
 t/unit-tests/generate-clar-suites.sh | 63 ++++++++++++++++++++++++++++++++++++
 4 files changed, 78 insertions(+), 57 deletions(-)

Range-diff versus v1:

1:  23d84e6c50 ! 1:  832222f7f5 t/unit-tests: convert "clar-generate.awk" into a shell script
    @@ Commit message
         may otherwise be a problem with build systems on platforms that use a
         different shell.
     
    +    While at it, wrap the overly lines in the CMake build instructions.
    +
         Signed-off-by: Patrick Steinhardt <ps@pks.im>
     
      ## Makefile ##
    @@ contrib/buildsystems/CMakeLists.txt: add_custom_command(OUTPUT "${CMAKE_BINARY_D
      add_custom_command(OUTPUT "${CMAKE_BINARY_DIR}/t/unit-tests/clar.suite"
     -	COMMAND awk -f "${CMAKE_SOURCE_DIR}/t/unit-tests/clar-generate.awk" "${CMAKE_BINARY_DIR}/t/unit-tests/clar-decls.h" > "${CMAKE_BINARY_DIR}/t/unit-tests/clar.suite"
     -	DEPENDS "${CMAKE_SOURCE_DIR}/t/unit-tests/clar-generate.awk" "${CMAKE_BINARY_DIR}/t/unit-tests/clar-decls.h")
    -+	COMMAND "${CMAKE_SOURCE_DIR}/t/unit-tests/generate-clar-suites.sh" "${CMAKE_BINARY_DIR}/t/unit-tests/clar-decls.h" "${CMAKE_BINARY_DIR}/t/unit-tests/clar.suite"
    -+	DEPENDS "${CMAKE_SOURCE_DIR}/t/unit-tests/generate-clar-suites.sh" "${CMAKE_BINARY_DIR}/t/unit-tests/clar-decls.h")
    ++	COMMAND "${CMAKE_SOURCE_DIR}/t/unit-tests/generate-clar-suites.sh"
    ++		"${CMAKE_BINARY_DIR}/t/unit-tests/clar-decls.h"
    ++		"${CMAKE_BINARY_DIR}/t/unit-tests/clar.suite"
    ++	DEPENDS "${CMAKE_SOURCE_DIR}/t/unit-tests/generate-clar-suites.sh"
    ++		"${CMAKE_BINARY_DIR}/t/unit-tests/clar-decls.h")
      
      add_library(unit-tests-lib ${clar_test_SUITES}
      	"${CMAKE_SOURCE_DIR}/t/unit-tests/clar/clar.c"
2:  a41b1f4746 < -:  ---------- cmake: use SH_EXE to execute clar scripts
-:  ---------- > 2:  38601f7bdf cmake: use SH_EXE to execute clar scripts
-:  ---------- > 3:  146ebd3841 cmake: use verbatim arguments when invoking clar commands
3:  01c1c51e6a = 4:  341c831192 Makefile: let clar header targets depend on their scripts

---
base-commit: facbe4f633e4ad31e641f64617bc88074c659959
change-id: 20241108-pks-clar-build-improvements-1c3962a9a79f

