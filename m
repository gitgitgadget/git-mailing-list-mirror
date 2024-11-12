Received: from fhigh-b2-smtp.messagingengine.com (fhigh-b2-smtp.messagingengine.com [202.12.124.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8E982123EE
	for <git@vger.kernel.org>; Tue, 12 Nov 2024 17:03:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731431016; cv=none; b=NMHS6bEDiQb7NSeOUH3XcCzDHjVftQXuM5h8J5uDs56Zls8BRfhAv8x/4QSneAks4XLP8DyTyOfOAmU7oDTbW8XXpyY//XOtuaRw94w0zeS13Q9WSR6iFtxjp8/Qcp7Ya4bgy2269ZV6e5kW2TKcJ/ZHD4yAllKZWwu8bzUfhx0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731431016; c=relaxed/simple;
	bh=PPJl1qOxbqRSV49VEbXnfqGIUf/yH62WGfgkbWYOhAI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=qIpFpGQbxKy3h0wuL4pnIzTCzV3QP8d03MflCxz3UvMkOotxO8HlAu+uP8g1F1H2XOD0RhVQabWFVDThR46VE5MvGNEU1fEEG+8Ra8ur08BLjdy6nlYy7CAWK5FU1KJY6kmyXuJEoHgKCUB+0wGNtTwt0J7cpTKvg9ybkWK+Jv0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=I7gUHpz0; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=gR2Uhm/o; arc=none smtp.client-ip=202.12.124.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="I7gUHpz0";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="gR2Uhm/o"
Received: from phl-compute-10.internal (phl-compute-10.phl.internal [10.202.2.50])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 8BF03254013A;
	Tue, 12 Nov 2024 12:03:32 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-10.internal (MEProxy); Tue, 12 Nov 2024 12:03:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1731431012;
	 x=1731517412; bh=IGcPAtFftrcVWW0KGz0u7NZu2kXhKqgOXv10tsUPj3A=; b=
	I7gUHpz0r8aEjZDyaLhXeqZMzJeRGKd7Mv9gF9BeT54jWAqNmUVAqcHfCdxWxtnu
	uG5YbbvrB5RZmTbVg1LGLO9QWOegevM3LG9YL57LQVXWpVsVbSC2yt7cDRCdl/P0
	HtQKB/YwlEDdFAR2/8NrowsGdc3VaqAxqOqujYoN011yzOkTfX/xU4gX9wRj94G8
	1PE/1Y5BbluMJbf+acxSb2vAo6g2KWIydmRjWv+iomMo+/R9VuDcBw0myfZEmrIM
	NMFuYsDlJqXVbLHu/DXDhQes0z9GIrW0Mr9wGiATuNkEeiwUuRoox6qSec9Vk8AE
	23r11KRyhIWXtC462uxZEw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1731431012; x=
	1731517412; bh=IGcPAtFftrcVWW0KGz0u7NZu2kXhKqgOXv10tsUPj3A=; b=g
	R2Uhm/ofm3nuyZ6RzWX2QeTAxWT3K2MJkE7VoW3k2Jc8W/91a3/BiSb4EF71sHX/
	276bXOAhroFIthhc62nnw1N5DJNfVbOMCU8DBWCcvqqPYjznJtF3wEOCnqrseI85
	fp6iFELyP42zJOTir5phiHHy98+zeVUY356RZRDmJNlldK0hz80Hm/sJh2BuyO0R
	gkfUO7T7/1VNY1ix5NSCqxMO4CIOpG337uSecPolB5ji9S5GnZ1+s0dMSmu//+1h
	sIRU+9C7PB8ndtORWCQQPSYH5yFEceLzyTTyc0Blxr3SvWwx7KJChUg2w8bQ2jEa
	ILiXVWPStCE419WjQkXZw==
X-ME-Sender: <xms:ZIozZ0xrp9C9fSQM7JPuhIDmOe24gIiWhVgFP-FX1Irqp2XhxQutjg>
    <xme:ZIozZ4QTtVs64tDFdKEhIxDwJRNXwbXd_Pc0QQu4HenzQVBUfYkvzd5wMDn2XLK52
    DAAAPuY18ffM7ChCQ>
X-ME-Received: <xmr:ZIozZ2U_sihIza29EuCHNxiqVtKqWFHPViXg1quHxl6OcUzoaAesn--oFFhearqIzo3Io8qyPBP_rzQ2cF7B4VErp36sfkBVPtYAcFzgwFrNDkc>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudeggdelvdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
    hsucdlqddutddtmdenucfjughrpefhfffugggtgffkfhgjvfevofesthejredtredtjeen
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepffeuiedujedvkeehuedvkeefffeivdeuleetkeduheej
    teekgedvudfgtdfgieelnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepledpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepmhgvsehtthgrhihlohhrrhdrtghomhdprhgtphhtth
    hopehphhhilhhlihhprdifohhougduvdefsehgmhgrihhlrdgtohhmpdhrtghpthhtohep
    phgvfhhfsehpvghffhdrnhgvthdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvg
    hlrdhorhhgpdhrtghpthhtohepshhunhhshhhinhgvsehsuhhnshhhihhnvggtohdrtgho
    mhdprhgtphhtthhopegvshgthhifrghrthiisehgvghnthhoohdrohhrghdprhgtphhtth
    hopehrrghmshgrhiesrhgrmhhsrgihjhhonhgvshdrphhluhhsrdgtohhmpdhrtghpthht
    ohepghhithhsthgvrhesphhosghogidrtghomhdprhgtphhtthhopegurghvvhhiugesgh
    hmrghilhdrtghomh
X-ME-Proxy: <xmx:ZIozZygo2cShFUBLGmbs5Cy4HerT9B5afb4ihl_90lwNBLVjUqlpIw>
    <xmx:ZIozZ2DNrdt52yG1kGqk2jv0OriWlN6dwrRW9fv_jRpYK84bupWezA>
    <xmx:ZIozZzJO68QlpTg203NnDGJX0x9Glg6w0AZK4kyyVONspKy7ApXQHw>
    <xmx:ZIozZ9DIJiWOSgQhDyQiTOj3OVHgPSvxQJhKI_aD3MGTLAAL7nuNiA>
    <xmx:ZIozZ-uiqPx0ZIZXF0eRQKRRZl_bOLmn4qTb0ym6zXtbMKk1Qd1mIa3g>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 12 Nov 2024 12:03:30 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id b5efeac7 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 12 Nov 2024 17:02:51 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Tue, 12 Nov 2024 18:02:46 +0100
Subject: [PATCH RFC v6 03/19] Makefile: consistently use PERL_PATH
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241112-pks-meson-v6-3-648b30996827@pks.im>
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
index d59f6c16868e24a1e13b0c16cc05adb79f81bbc8..2a08473824ede4699e370de7f8b8af183449536a 100644
--- a/Makefile
+++ b/Makefile
@@ -2553,7 +2553,7 @@ sed -e '1s|#!.*/sh|#!$(SHELL_PATH_SQ)|' \
     -e 's/@USE_GETTEXT_SCHEME@/$(USE_GETTEXT_SCHEME)/g' \
     -e $(BROKEN_PATH_FIX) \
     -e 's|@GITWEBDIR@|$(gitwebdir_SQ)|g' \
-    -e 's|@PERL@|$(PERL_PATH_SQ)|g' \
+    -e 's|@PERL_PATH@|$(PERL_PATH_SQ)|g' \
     -e 's|@PAGER_ENV@|$(PAGER_ENV_SQ)|g' \
     $@.sh >$@+
 endef
diff --git a/contrib/buildsystems/CMakeLists.txt b/contrib/buildsystems/CMakeLists.txt
index a41540458b7ae4f50ec92c115dc6fab3ef5088ff..608ad9714d460b362e07d7169a9c386ba819d40a 100644
--- a/contrib/buildsystems/CMakeLists.txt
+++ b/contrib/buildsystems/CMakeLists.txt
@@ -842,7 +842,7 @@ foreach(script ${git_shell_scripts})
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
2.47.0.251.gb31fb630c0.dirty

