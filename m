Received: from fhigh-a2-smtp.messagingengine.com (fhigh-a2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52A791CBEA8
	for <git@vger.kernel.org>; Tue, 19 Nov 2024 11:51:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732017067; cv=none; b=rsK7x8HRKHkgh/+ajjshTf/PZVkYv6tRzu4x4V3gWLqXC+lcq5aQhnCKmiSS3inHgUlMK+GTozT1UyEdq+ZWU4IrQpAbHotwT1Yj/kzgOVRgnfE18N1O+qStSEfvqoWHiSlCRIptzYI0MJpIMJEAxKKQmRtgH7cifqKIyrToPro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732017067; c=relaxed/simple;
	bh=mGAREgK+qDxm8A665lVFvH6SaO54SZHfHd3Xg6zdcBk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=rr5FVT3z7/OVCohHxbtP1Pds6jGd1L8iGAyJyVuNm8E0h9TKqbTqz0CGXql4JoLGaeZCoCJ0CZuAXJFb0X98gkGRtEPOBpZ/qiXAxLuAZ3QUkjj/Jyuz75OYwJvmnb8xHLahfkeW2nPl32SteNKuCZR+GYLJc7C0Kaw1nWOsMj0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=4a76gMcB; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=iw3SDBe9; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="4a76gMcB";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="iw3SDBe9"
Received: from phl-compute-11.internal (phl-compute-11.phl.internal [10.202.2.51])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 69B6E1140172;
	Tue, 19 Nov 2024 06:51:04 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-11.internal (MEProxy); Tue, 19 Nov 2024 06:51:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1732017064;
	 x=1732103464; bh=e/UFRJANl8VJskwPCld43zNGgNP7JAby3UJiFbvuFN4=; b=
	4a76gMcBuDtY+5jRg4w7t03NeILngRwYTLXS+spcpvzonnSjfyiP0HrgLRnlB2pD
	XUmeCDFhVBI5SLeN9/Iw1VjbQCWAyJCFBPt9hxM1JTiNSfLX/a+tf38vOI0yoxei
	7T5djBbYnxh3bpBN7ybP35edw294j/lUdGaBDIbpeldo5A0u+cDTe/ZBgbGlfZbS
	C9mvRVEn296cat6hVAns51y2CXQlMA2P7s8C4JSCVK0ZF2OYHmVEZ8KXxhBeA2wt
	kzaUrFa6tkI4p40l/yyL09Et08IwNVrC2OqJRqKKpoNACye8aKwKwWfG/QhUwjo8
	Fa3tor5iNKSWdGN1Xh9teQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1732017064; x=
	1732103464; bh=e/UFRJANl8VJskwPCld43zNGgNP7JAby3UJiFbvuFN4=; b=i
	w3SDBe9Qn6P/kmfk4f0Uu+8BjxFPMqN312nxbmH5sA7HXi0k7aelGltXXr35iCCG
	1XN0+3sKkbBiparZLTD+iRsJ/LApy0G8WnYwk7CHLU8HM1rWZPpXPVUOBU8FZjaq
	zom6MA6R+fPHYLMg8MsBMzo8o3e88BAfuPICDqv+CQUtEg64gKfRsEa+p9DGBpPo
	AeeOQ573bH8qZ/CyALMmEWDwKDxV9QAqTisttZG2ipUp3FwcnezEcG20I3mmyi/m
	s0lEoV18/zMVexwX8r4p2gY1F9yUqqLl0w1TbR0jMfJLGlQRMeMRBJAGATuffusv
	bpcYLe2smkBfGaw78hYSw==
X-ME-Sender: <xms:qHs8Z9uWOr4d3-AY_Gav8vhjFuZwVjQ4D9Z-5zOmmLV_zLBQkKkmSA>
    <xme:qHs8Z2cZVeawT8rzBBkE8P5t0q0CDaGNM7So3TwgmXQ-nwFeKVq3XAm9JbpiVDE1Q
    InUS1BXIOFeAlAePg>
X-ME-Received: <xmr:qHs8ZwyzYjt-VZ53p1kqvNRCvpN0SM0bbZ2dFu_NwuSZwB-z-g3AD1AIkui8NHh-viE7UH6ucd0z37tU93TcvovLpXafQOmvxr_jur6kqj3w_pQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrfedvgdefudcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
    hsucdlqddutddtmdenucfjughrpefhfffugggtgffkfhgjvfevofesthejredtredtjeen
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepffeuiedujedvkeehuedvkeefffeivdeuleetkeduheej
    teekgedvudfgtdfgieelnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepuddtpdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopehrrghmshgrhiesrhgrmhhsrgihjhhonhgvshdrph
    hluhhsrdgtohhmpdhrtghpthhtohepvghstghhfigrrhhtiiesghgvnhhtohhordhorhhg
    pdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhope
    gthhhrihhstghoohhlsehtuhigfhgrmhhilhihrdhorhhgpdhrtghpthhtohepuggrvhhv
    ihgusehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtg
    homhdprhgtphhtthhopehpvghffhesphgvfhhfrdhnvghtpdhrtghpthhtohepshhunhhs
    hhhinhgvsehsuhhnshhhihhnvggtohdrtghomhdprhgtphhtthhopehphhhilhhlihhprd
    ifohhougduvdefsehgmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:qHs8Z0Nw1rGdEC7UZKc9Tk6lHn8uKdGMZn2NYtHtVcmyVc7aQchjbw>
    <xmx:qHs8Z9_CMTXDPwqfBaO8TDjF61zTXVZeOqXQJItWUBH9mcydF9mn3g>
    <xmx:qHs8Z0XvvuNFRgmTHGW0E6P1HZpwIarL4rgc4d2zL27PctpPw0VtHg>
    <xmx:qHs8Z-dvfV_DYlSDPCgYBz1CKvoG2b1lNIIJgx1hJp4biEeNpm5SaA>
    <xmx:qHs8Z-3KmmIeql6szGztCoK_iOvPUoRhMWSxdN74JvAYUlPnkAKWtbK5>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 19 Nov 2024 06:51:02 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id d5731049 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 19 Nov 2024 11:50:09 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Tue, 19 Nov 2024 12:50:44 +0100
Subject: [PATCH v8 07/23] Makefile: consistently use PERL_PATH
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241119-pks-meson-v8-7-809bf7f042f3@pks.im>
References: <20241119-pks-meson-v8-0-809bf7f042f3@pks.im>
In-Reply-To: <20241119-pks-meson-v8-0-809bf7f042f3@pks.im>
To: git@vger.kernel.org
Cc: Eli Schwartz <eschwartz@gentoo.org>, 
 Eric Sunshine <sunshine@sunshineco.com>, 
 Phillip Wood <phillip.wood123@gmail.com>, 
 Junio C Hamano <gitster@pobox.com>, 
 Ramsay Jones <ramsay@ramsayjones.plus.com>, Taylor Blau <me@ttaylorr.com>, 
 David Aguilar <davvid@gmail.com>, Jeff King <peff@peff.net>, 
 Christian Couder <chriscool@tuxfamily.org>
X-Mailer: b4 0.14.2

When injecting the Perl path into our scripts we sometimes use '@PERL@'
while we othertimes use '@PERL_PATH@'. Refactor the code use the latter
consistently, which makes it easier to reuse the same logic for multiple
scripts.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 Makefile                            | 2 +-
 contrib/buildsystems/CMakeLists.txt | 2 +-
 git-instaweb.sh                     | 4 ++--
 git-request-pull.sh                 | 2 +-
 4 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/Makefile b/Makefile
index 13dc29695361af8ded3c5146ff0578e198b4d0ab..94b1ccc7b714743a149df5200a5a8d60b605c1ab 100644
--- a/Makefile
+++ b/Makefile
@@ -2554,7 +2554,7 @@ sed -e '1s|#!.*/sh|#!$(SHELL_PATH_SQ)|' \
     -e 's/@USE_GETTEXT_SCHEME@/$(USE_GETTEXT_SCHEME)/g' \
     -e $(BROKEN_PATH_FIX) \
     -e 's|@GITWEBDIR@|$(gitwebdir_SQ)|g' \
-    -e 's|@PERL@|$(PERL_PATH_SQ)|g' \
+    -e 's|@PERL_PATH@|$(PERL_PATH_SQ)|g' \
     -e 's|@PAGER_ENV@|$(PAGER_ENV_SQ)|g' \
     $@.sh >$@+
 endef
diff --git a/contrib/buildsystems/CMakeLists.txt b/contrib/buildsystems/CMakeLists.txt
index b893b0143a72ad284887d1d4ca72f1beb0a39ad7..f8892c49c6d317040b3b6447b88133b2bfff3fcf 100644
--- a/contrib/buildsystems/CMakeLists.txt
+++ b/contrib/buildsystems/CMakeLists.txt
@@ -846,7 +846,7 @@ foreach(script ${git_shell_scripts})
 	string(REPLACE "@NO_CURL@" "" content "${content}")
 	string(REPLACE "@USE_GETTEXT_SCHEME@" "" content "${content}")
 	string(REPLACE "# @BROKEN_PATH_FIX@" "" content "${content}")
-	string(REPLACE "@PERL@" "${PERL_PATH}" content "${content}")
+	string(REPLACE "@PERL_PATH@" "${PERL_PATH}" content "${content}")
 	string(REPLACE "@PAGER_ENV@" "LESS=FRX LV=-c" content "${content}")
 	file(WRITE ${CMAKE_BINARY_DIR}/${script} ${content})
 endforeach()
diff --git a/git-instaweb.sh b/git-instaweb.sh
index c8efb1205a8e2a66a6aced840980978897e122bc..5ad50160bb035885d8c180bee3ebb0a8e9622abc 100755
--- a/git-instaweb.sh
+++ b/git-instaweb.sh
@@ -3,7 +3,7 @@
 # Copyright (c) 2006 Eric Wong
 #
 
-PERL='@PERL@'
+PERL='@PERL_PATH@'
 OPTIONS_KEEPDASHDASH=
 OPTIONS_STUCKLONG=
 OPTIONS_SPEC="\
@@ -716,7 +716,7 @@ EOF
 
 gitweb_conf() {
 	cat > "$fqgitdir/gitweb/gitweb_config.perl" <<EOF
-#!@PERL@
+#!@PERL_PATH@
 our \$projectroot = "$(dirname "$fqgitdir")";
 our \$git_temp = "$fqgitdir/gitweb/tmp";
 our \$projects_list = \$projectroot;
diff --git a/git-request-pull.sh b/git-request-pull.sh
index 10c88639e28c02650ffea3d4671afa9a9f0bb182..775ba8ea11aa0fce90ae9bfaea8eac5b8bc584a4 100755
--- a/git-request-pull.sh
+++ b/git-request-pull.sh
@@ -112,7 +112,7 @@ find_matching_ref='
 	}
 '
 
-set fnord $(git ls-remote "$url" | @PERL@ -e "$find_matching_ref" "${remote:-HEAD}" "$headrev")
+set fnord $(git ls-remote "$url" | @PERL_PATH@ -e "$find_matching_ref" "${remote:-HEAD}" "$headrev")
 remote_sha1=$2
 ref=$3
 

-- 
2.47.0.274.g962d0b743d.dirty

