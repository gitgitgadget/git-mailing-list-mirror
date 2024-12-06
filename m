Received: from fout-b8-smtp.messagingengine.com (fout-b8-smtp.messagingengine.com [202.12.124.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 028FE20E004
	for <git@vger.kernel.org>; Fri,  6 Dec 2024 13:25:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733491538; cv=none; b=QrsvUWoLWsKeAp0sxBvolEPqsLoVA9lrO+8Iig5RnJoUBv37C4iIeS+cewlawzbaXqTrOYqQ9Y9TyeAflJcm2/zhKOiDX7H8h/V/QAA+YqAPl94mik3+dR0VVGxpRPcEVQEGfpbYr20TYhUWMgSOTceXDbXO/twj9kB1dx+Ysv4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733491538; c=relaxed/simple;
	bh=9YFLeXLpMMk24OoP0Xp43CeSBgqLnFkBpIRT6jJoOLo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=nwLGJW79BqMNfEMKy+/6/0IHWQ+G85e7b9DQLbyvJQBujZodz1NRG4z57W7abUnr3Wcc+OsoBafB9UmuMTdIl7jbImc4F2jkdjwsdwdJeQl6G+LooV1Cp/0VG8m3GT/sjpvmWaEDyB/IrowhZth99VA0sYjGknWX+KWZbKcZWwM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=W+vdN9+Z; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=uGBw79uk; arc=none smtp.client-ip=202.12.124.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="W+vdN9+Z";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="uGBw79uk"
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfout.stl.internal (Postfix) with ESMTP id 140D411401C6;
	Fri,  6 Dec 2024 08:25:36 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Fri, 06 Dec 2024 08:25:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1733491535;
	 x=1733577935; bh=2y0HT57xMM1a9c3z6T5hKbUfKoGPK3rFiHgN2fVzkPY=; b=
	W+vdN9+ZVtp425LPSeIOniK2R2phamcpZVqfvFWsX7m6cC+AQCFDPOBE/yfwFY3S
	O/eLFppJz0aLFruR/3QPgoKSOl4MgOkejQBHxbzHHTDc4fgA1RBYFMjDGdiZz9rk
	BzKj6/LtPCzKeRtuOlGU0LnoTaXmPZBeEoX1WZglPJoUqjarlI4XuKmaknnDP71o
	RBjiztfUnV/D30OaKDe8He9Lri3BHAlzpnoqI6e2lOa0JhFQEQrAk0QZjqJlzuu1
	CBFAH0oGiM8b6OT/I94mz2jrhNGdmE11UABK9OC8MtwE7LpzhKmM3EIjA6mTlZgE
	RggKqFqDfu20JsEoRKZ4Zg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1733491535; x=
	1733577935; bh=2y0HT57xMM1a9c3z6T5hKbUfKoGPK3rFiHgN2fVzkPY=; b=u
	GBw79ukSTHD58AHLioRTE61ipX+fzjYnZCiZ/+u92S41ngpvqu+eI3Bu6yaKX+Ip
	wd9UZcBkMPkieU354/x+2KOrmSjGJj6VmtNTcKRapjW1lzLjlwN6ddr9kKLGz0xe
	GgMsmjQw8vJWHPojZAFKxEWE880zXmU+xBDWpoQlspf55KaN95B4nmJO+l7CoivK
	V5uXLLIrbBa190x9K+xGZuW5iwWbJGGqXNQhvz7IMWw8JjNuOOHl1NYvpg3tp6dK
	Fc+BIyaviZpGX7nJYzxK1sdojEcBFTf/GrN8DA+lrJxnlV9Dclor8TUrjPeV0Aej
	Zk3g2sdQ/ksc/pweixaJA==
X-ME-Sender: <xms:T_tSZ1DO0oiCauLvoPY4YM3Eamr3VqyW3A9f0BOJQYpVaoLL8g0S0A>
    <xme:T_tSZzjU04AT4KaNCIQ6SIDCLL7mrhMWTMQMwqjUiaKukz5MAcEHpqpOftwdp_Pch
    J_XbYvuNOyjqIXP3w>
X-ME-Received: <xmr:T_tSZwkE3FU0fs-Pf-m9Dx6MzY78j_q7277Ypl4JKnEKOgr7_Gi_8-2OfNl45BliBT4dNjZh8DmIZT8lCoozMRtUWhLBLQDFgGc1UK_vKgZDjg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrieelgdehudcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
    hsucdlqddutddtmdenucfjughrpefhfffugggtgffkfhgjvfevofesthejredtredtjeen
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepffeuiedujedvkeehuedvkeefffeivdeuleetkeduheej
    teekgedvudfgtdfgieelnecuvehluhhsthgvrhfuihiivgepudenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepuddupdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopegvshgthhifrghrthiisehgvghnthhoohdrohhrgh
    dprhgtphhtthhopehphhhilhhlihhprdifohhougduvdefsehgmhgrihhlrdgtohhmpdhr
    tghpthhtohepphgvfhhfsehpvghffhdrnhgvthdprhgtphhtthhopehrrghmshgrhiesrh
    grmhhsrgihjhhonhgvshdrphhluhhsrdgtohhmpdhrtghpthhtoheptghhrhhishgtohho
    lhesthhugihfrghmihhlhidrohhrghdprhgtphhtthhopehgihhtshhtvghrsehpohgsoh
    igrdgtohhmpdhrtghpthhtohepuggrvhhvihgusehgmhgrihhlrdgtohhmpdhrtghpthht
    ohepmhgvsehtthgrhihlohhrrhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkh
    gvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:T_tSZ_w5fQVIhUMkl2-9FtUyizo6zDtrSMOFl803vs58RcBcfwXzig>
    <xmx:T_tSZ6Tc_RAqiDdMaKW7G4tcv3rF2OOK7LwPiKO7ZtIbPRgcGThgAA>
    <xmx:T_tSZybmaHDUzRMG5fKTNtwEYnT3E67vInOeBnsyxORt4DVSvSLEYA>
    <xmx:T_tSZ7SzFa0Kru_0k__RzMfd1QCAibmS9YpQFyKwlVXU7_crToljzg>
    <xmx:T_tSZ2bOPCTt5ov7r-8O5PVYrQQMTDZ5BWVTOWktk9jm0SMnBJoPrG2P>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 6 Dec 2024 08:25:33 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 44600dd6 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 6 Dec 2024 13:24:06 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Fri, 06 Dec 2024 14:24:51 +0100
Subject: [PATCH v11 16/26] Makefile: write absolute program path into
 bin-wrappers
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241206-pks-meson-v11-16-525ed4792b88@pks.im>
References: <20241206-pks-meson-v11-0-525ed4792b88@pks.im>
In-Reply-To: <20241206-pks-meson-v11-0-525ed4792b88@pks.im>
To: git@vger.kernel.org
Cc: Eli Schwartz <eschwartz@gentoo.org>, 
 Eric Sunshine <sunshine@sunshineco.com>, 
 Phillip Wood <phillip.wood123@gmail.com>, 
 Junio C Hamano <gitster@pobox.com>, 
 Ramsay Jones <ramsay@ramsayjones.plus.com>, Taylor Blau <me@ttaylorr.com>, 
 David Aguilar <davvid@gmail.com>, Jeff King <peff@peff.net>, 
 Johannes Sixt <j6t@kdbg.org>, Christian Couder <chriscool@tuxfamily.org>
X-Mailer: b4 0.14.2

Write the absolute program path into our bin-wrappers. This allows us to
simplify the Meson build instructions we are about to introduce a bit.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 Makefile                            | 2 +-
 bin-wrappers/wrap-for-bin.sh        | 6 +++---
 contrib/buildsystems/CMakeLists.txt | 6 +++---
 3 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/Makefile b/Makefile
index ed9bae0f2ed692c910cb7e5956694f72d557eb9b..5ce4c09c3862499e83c5d50780e581a77c56ecb9 100644
--- a/Makefile
+++ b/Makefile
@@ -3206,7 +3206,7 @@ all:: $(TEST_PROGRAMS) $(test_bindir_programs) $(UNIT_TEST_PROGS) $(CLAR_TEST_PR
 $(test_bindir_programs): bin-wrappers/%: bin-wrappers/wrap-for-bin.sh
 	$(QUIET_GEN)sed -e '1s|#!.*/sh|#!$(SHELL_PATH_SQ)|' \
 	     -e 's|@BUILD_DIR@|$(shell pwd)|' \
-	     -e 's|@PROG@|$(patsubst test-%,t/helper/test-%,$(@F))$(if $(filter-out $(BINDIR_PROGRAMS_NO_X),$(@F)),$(X),)|' < $< > $@ && \
+	     -e 's|@PROG@|$(shell pwd)/$(patsubst test-%,t/helper/test-%,$(@F))$(if $(filter-out $(BINDIR_PROGRAMS_NO_X),$(@F)),$(X),)|' < $< > $@ && \
 	chmod +x $@
 
 # GNU make supports exporting all variables by "export" without parameters.
diff --git a/bin-wrappers/wrap-for-bin.sh b/bin-wrappers/wrap-for-bin.sh
index 7898a1c238dde20617cf96d144930dc59f67feab..2feaec81f2bd8e908346358654c1234be34f9a06 100755
--- a/bin-wrappers/wrap-for-bin.sh
+++ b/bin-wrappers/wrap-for-bin.sh
@@ -22,15 +22,15 @@ export GIT_EXEC_PATH GITPERLLIB PATH GIT_TEXTDOMAINDIR
 
 case "$GIT_DEBUGGER" in
 '')
-	exec "${GIT_EXEC_PATH}/@PROG@" "$@"
+	exec "@PROG@" "$@"
 	;;
 1)
 	unset GIT_DEBUGGER
-	exec gdb --args "${GIT_EXEC_PATH}/@PROG@" "$@"
+	exec gdb --args "@PROG@" "$@"
 	;;
 *)
 	GIT_DEBUGGER_ARGS="$GIT_DEBUGGER"
 	unset GIT_DEBUGGER
-	exec ${GIT_DEBUGGER_ARGS} "${GIT_EXEC_PATH}/@PROG@" "$@"
+	exec ${GIT_DEBUGGER_ARGS} "@PROG@" "$@"
 	;;
 esac
diff --git a/contrib/buildsystems/CMakeLists.txt b/contrib/buildsystems/CMakeLists.txt
index 9348665f226e21dd94e0b832b938b4521e79bfbe..849d6b3765fd6df5ed6206ac82cc32825d43cd97 100644
--- a/contrib/buildsystems/CMakeLists.txt
+++ b/contrib/buildsystems/CMakeLists.txt
@@ -1097,20 +1097,20 @@ set(wrapper_test_scripts
 foreach(script ${wrapper_scripts})
 	file(STRINGS ${CMAKE_SOURCE_DIR}/bin-wrappers/wrap-for-bin.sh content NEWLINE_CONSUME)
 	string(REPLACE "@BUILD_DIR@" "${CMAKE_BINARY_DIR}" content "${content}")
-	string(REPLACE "@PROG@" "${script}${EXE_EXTENSION}" content "${content}")
+	string(REPLACE "@PROG@" "${CMAKE_BINARY_DIR}/${script}${EXE_EXTENSION}" content "${content}")
 	file(WRITE ${CMAKE_BINARY_DIR}/bin-wrappers/${script} ${content})
 endforeach()
 
 foreach(script ${wrapper_test_scripts})
 	file(STRINGS ${CMAKE_SOURCE_DIR}/bin-wrappers/wrap-for-bin.sh content NEWLINE_CONSUME)
 	string(REPLACE "@BUILD_DIR@" "${CMAKE_BINARY_DIR}" content "${content}")
-	string(REPLACE "@PROG@" "t/helper/${script}${EXE_EXTENSION}" content "${content}")
+	string(REPLACE "@PROG@" "${CMAKE_BINARY_DIR}/t/helper/${script}${EXE_EXTENSION}" content "${content}")
 	file(WRITE ${CMAKE_BINARY_DIR}/bin-wrappers/${script} ${content})
 endforeach()
 
 file(STRINGS ${CMAKE_SOURCE_DIR}/bin-wrappers/wrap-for-bin.sh content NEWLINE_CONSUME)
 string(REPLACE "@BUILD_DIR@" "${CMAKE_BINARY_DIR}" content "${content}")
-string(REPLACE "@PROG@" "git-cvsserver" content "${content}")
+string(REPLACE "@PROG@" "${CMAKE_BINARY_DIR}/git-cvsserver" content "${content}")
 file(WRITE ${CMAKE_BINARY_DIR}/bin-wrappers/git-cvsserver ${content})
 
 #options for configuring test options

-- 
2.47.0.366.g5daf58cba8.dirty

