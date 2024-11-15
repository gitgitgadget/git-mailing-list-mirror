Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4820518FC81
	for <git@vger.kernel.org>; Fri, 15 Nov 2024 07:21:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731655311; cv=none; b=Qx6UeJhSKtgsHQFEOVGWGB64lNIL88c+Xm7LmuFZInThtu+1YdC5Y/DBUBTOE3wP3u34gDUj9hszV+ea1CQQxaKM+WS+Su0Behb1t3uJAEoFbRP/fTbGW+uZlcs0QZR1qkY6eVmc4UXFjbtsv3guOvkFZ1uz75baZn05bFdE+Co=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731655311; c=relaxed/simple;
	bh=FB1DxCO5H+jwHfulP8w8O8G0GxMLrqkAKNbN3VDP3sY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=H4L9T63mEHR/VuPp0wI+00gxWLOLPiJyg/VKnD1FWNk6Itqmw7Yc+Y163x/FZ52rmLGIKEWx49yT6Liu3Y0K0Dvy138lvmFzcpY7BU/fqtF2pBO7NygwQ1b3Cs+KLLkVimuHArSE4EtacG068cH7BtjkhPUs9vx+9MfIeN40Rko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=JiLiihMU; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=XkhHP8UF; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="JiLiihMU";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="XkhHP8UF"
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfout.phl.internal (Postfix) with ESMTP id A715513806E0;
	Fri, 15 Nov 2024 02:21:49 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Fri, 15 Nov 2024 02:21:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1731655309;
	 x=1731741709; bh=HeUxmEavZzyo7DF7xpIqSoXboHw/2KN1/ycOKs2smn8=; b=
	JiLiihMUrzifEeBDp0vJQItgOV5ZMu4XjSJ/7ABQBHNAO/Pfn2JSCIU6bQRYba9v
	AE/Ml6z0+SPKS+/OC/FRwxXzp0PSx6bWJJ7SGUWUB5b/dEJHwnzA22sfiUPKi8ZC
	+UJskZdB3ItPvyHkh1YJy+2i78qgLDr6sEzom0Ils/f79FOEU1eZW1p/qiqU5cGH
	2B20+fXelu0PTLDp2YmecE6BNQz72TWxTsLCbCyB16tDrBXkyzvLdlMfEdQyahvu
	FN0L168k1/swLUhWZhd0rW2oj/yhwEDYIYoqiHuQqGVDrTHCTFs1hGU46AvIfyP/
	XHWzq5H7HXOfolji++KKRg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1731655309; x=
	1731741709; bh=HeUxmEavZzyo7DF7xpIqSoXboHw/2KN1/ycOKs2smn8=; b=X
	khHP8UF9A7Kv7nzpL4tReo71Chf63lslonVkM8LN9uX47ILNbqsQecaROTKS5//U
	9LmwXbt1Vive4A9il0LiLUmHD9cQ/l3X0Jt3uXI4Pj8ZNHcFefMFUJ08/sPwp8gl
	NYvTVQCAai7Vs++aATp4IU0TPpSVu2Raa6Kq0gZSWOwPejzico3iojO7KhID5jEt
	UhOFkiU8ORrLxx/JE4i1brj3+dix0HhRbwWFEWQz/IFrR3apGhaan7zC0AbsiEFC
	3vvYZopod7j4Lt1BMZ7L21ctdtXFUN01dGPj394RL3dZ6oXhUHhSJoRTOSs37CpB
	PDaqHT9YqbL+ZRnmEARJQ==
X-ME-Sender: <xms:jfY2Z3WdtGiVYsEq5P-4vH2auboIVP2bngZ8CSJ_L3Se-D0D2G1tKw>
    <xme:jfY2Z_lEMMDieufOf9dp49PuwDVltIRLZskzj52PoLVOK-HP--lKfPx5fmqak3DsW
    zf7eReNUsKXlVSyAA>
X-ME-Received: <xmr:jfY2ZzZsca3PWc6Wm26150HRuX_8ec2Ry6QrrB-wGUujDE8X_jUeDxLuURqFA6x1El-Y4fP_oCtwhK0CxIfHeSv6iXj2QdTTah4vBjcGzcJiy-VuOw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrvdefgddutdegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdej
    necuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrih
    hmqeenucggtffrrghtthgvrhhnpeffueeiudejvdekheeuvdekfeffiedvueelteekudeh
    jeetkeegvddugfdtgfeileenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmh
    grihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopedutddpmhhouggv
    pehsmhhtphhouhhtpdhrtghpthhtoheprhgrmhhsrgihsehrrghmshgrhihjohhnvghsrd
    hplhhushdrtghomhdprhgtphhtthhopehsuhhnshhhihhnvgesshhunhhshhhinhgvtgho
    rdgtohhmpdhrtghpthhtoheptghhrhhishgtohholhesthhugihfrghmihhlhidrohhrgh
    dprhgtphhtthhopegurghvvhhiugesghhmrghilhdrtghomhdprhgtphhtthhopehgihht
    sehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepphhhihhllhhiphdrfihooh
    guuddvfeesghhmrghilhdrtghomhdprhgtphhtthhopehmvgesthhtrgihlhhorhhrrdgt
    ohhmpdhrtghpthhtohepphgvfhhfsehpvghffhdrnhgvthdprhgtphhtthhopegvshgthh
    ifrghrthiisehgvghnthhoohdrohhrgh
X-ME-Proxy: <xmx:jfY2ZyUDL5s3D6B_de-6xY0plAX_zMCMd8Rc31PswLWW1MNMvK8qfg>
    <xmx:jfY2ZxlZN4jT_v0-Ut0HfsPef0VGyjq_-SzOdSiV1DISW3OcZnJ3TA>
    <xmx:jfY2Z_cBkAsEhNitUd7z4fpr3yzG4_wZhDLQsQ7NvPHsqXiouwzwbw>
    <xmx:jfY2Z7FRZsJPxyQmSX6HP26ekRpe-SfyGecR_YaWjRCLpZoNrldInw>
    <xmx:jfY2Z6djelR6Nzwk5eMzzgXwkuaWgHcMr3lTb6OZ3rkfAgNRv5_BRA6e>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 15 Nov 2024 02:21:47 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 2a946d0c (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 15 Nov 2024 07:21:06 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Fri, 15 Nov 2024 08:21:31 +0100
Subject: [PATCH RFC v7 19/22] t: allow overriding build dir
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241115-pks-meson-v7-19-47ec19b780b2@pks.im>
References: <20241115-pks-meson-v7-0-47ec19b780b2@pks.im>
In-Reply-To: <20241115-pks-meson-v7-0-47ec19b780b2@pks.im>
To: git@vger.kernel.org
Cc: Eli Schwartz <eschwartz@gentoo.org>, 
 Eric Sunshine <sunshine@sunshineco.com>, 
 Phillip Wood <phillip.wood123@gmail.com>, 
 Junio C Hamano <gitster@pobox.com>, 
 Ramsay Jones <ramsay@ramsayjones.plus.com>, Taylor Blau <me@ttaylorr.com>, 
 David Aguilar <davvid@gmail.com>, Jeff King <peff@peff.net>, 
 Christian Couder <chriscool@tuxfamily.org>
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
index ceb926c4258db853eeb50b2259a7f521501cf719..cce0069287af48a607bc24fa474006a47014ea49 100644
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
@@ -522,6 +522,7 @@ unset VISUAL EMAIL LANGUAGE $("$PERL_PATH" -e '
 		PERF_
 		CURL_VERBOSE
 		TRACE_CURL
+		BUILD_DIR
 	));
 	my @vars = grep(/^GIT_/ && !/^GIT_($ok)/o, @env);
 	print join("\n", @vars);

-- 
2.47.0.251.gb31fb630c0.dirty

