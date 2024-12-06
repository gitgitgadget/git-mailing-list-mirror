Received: from fhigh-b2-smtp.messagingengine.com (fhigh-b2-smtp.messagingengine.com [202.12.124.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5075220B7E4
	for <git@vger.kernel.org>; Fri,  6 Dec 2024 13:25:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733491531; cv=none; b=kkolwNMIDFuE0GQ3qXM5uZBmtEK3bmQUXYgGytehdFrLmWREdT+jdglE/tsMLArFdGfMg6hxO5kvhs5FKNMU8Lfgc3HrzbGkSGuaEKNXhDRv2IADaGC+ftF4dWuozcGhl4t1DHTPDLa0EL3UYCcWzHqJZsoQmyPfhwiuDBY8AoI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733491531; c=relaxed/simple;
	bh=bkb0m378D8xMPpRVkLGUgVvWEwpIWEuchn2YyuGrHo4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=A7vaKgvFP61kYab9BErGlgqNnNlvRv21kCEtorkgsICQ5jGE+Es8UtUHiNSTVrurldjViZEX5ZkhMFbL6sUSKQ5n7H9COKwqEoDFXYDdUfiQfaiaxAI4NCSyVmw5ImsGb6nRMwkQO3idAVsmGuC5sRdbqbbTAZWjba4PHiAi+CY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=GiNY9BQ0; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=0izRb/VW; arc=none smtp.client-ip=202.12.124.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="GiNY9BQ0";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="0izRb/VW"
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 1B2582540176;
	Fri,  6 Dec 2024 08:25:28 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Fri, 06 Dec 2024 08:25:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1733491527;
	 x=1733577927; bh=AjwVSx6FboWB0/W9CKLloAlNo6YfjhM+MNG5EadB9R0=; b=
	GiNY9BQ0w9tYPhUprIiGnhyjjBR6DOPN7g0R2ldGLqPgdZp2OIcoFTOjMCxeHvHp
	pZErstyI3TyjMIoUfcAbiz4PrnUWPpgrKM8+Tm4wsxd7l9MIFVu6ps4+1N0qA7BP
	M29A85rIR0g2sM3jhtYXGSPVBf7J2UQe8p9P2VW1VtY7jNUoxuc0K+vj+EgJpmJi
	+3HxVmlRGtTJfPGzSOLeKhGAUghh9RCbsMrZUPCicc3aZlv22I4ukjiocZLA+V7a
	x5+9lNY60JSiCvpXxgETZ/lY9nzMNGEhwTlxZziUCrqS2zl81hPMow2PUa73N36h
	4iv7kwoSW4E4bcosiAUDqg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1733491527; x=
	1733577927; bh=AjwVSx6FboWB0/W9CKLloAlNo6YfjhM+MNG5EadB9R0=; b=0
	izRb/VWFyKz2JHgPEjuKvde4LKCpNuEDkoB22zhhyTvn1J4MyK8CQIhvceHA+sCY
	ySKqD5ul/guyiZQNPVoXDNGBEyN5h+bDx7UN6r7kmyaXihPWVdTJcQA36o17VRVH
	0mLOqAUEsvlPgmx3oYmCVAPvRr+OQbWcSLZJQbFB7v94wVxPmuc3eXXie7m+N7Xk
	ewLBXIGllGuDS1b0Gk3PpkDQ7SEiP5d7MCwYGUT6FgdOYS0xR8G6MI2TtMMgTeBU
	93ZQqdYyk/pGgiXJ9gfZlggbSkJ1SAsEhdaMohVFOIWN6l5RbsITyfbjZqQ9O+Ud
	QzjLpOlYOSr9EdQfipXwA==
X-ME-Sender: <xms:R_tSZ6adsFGYl4oYvhuFP66Jt2dxkplignc-yxM3B-rdttnypa13Bg>
    <xme:R_tSZ9Zf1Aa-0iCm1yptSQip6hfuCvupPrhAV3suiboZoew8nUezuznqIyO1bVs5R
    x7JQqiL4EslXzqXow>
X-ME-Received: <xmr:R_tSZ09qL5sibHwJ9JTQwx7Gfay19Hzd_krFZFzS3Rv-6hK1AF-a72HezfxPqGVS8BSDqTUOR3JBMavPRl61Fx8iZsnUy-O5NqBmkF8M8EDYJg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrieelgdehtdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
    hsucdlqddutddtmdenucfjughrpefhfffugggtgffkfhgjvfevofesthejredtredtjeen
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepffeuiedujedvkeehuedvkeefffeivdeuleetkeduheej
    teekgedvudfgtdfgieelnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepuddupdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopehmvgesthhtrgihlhhorhhrrdgtohhmpdhrtghpth
    htohepphgvfhhfsehpvghffhdrnhgvthdprhgtphhtthhopegurghvvhhiugesghhmrghi
    lhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtg
    hpthhtohepghhithhsthgvrhesphhosghogidrtghomhdprhgtphhtthhopegthhhrihhs
    tghoohhlsehtuhigfhgrmhhilhihrdhorhhgpdhrtghpthhtohepjheitheskhgusghgrd
    horhhgpdhrtghpthhtohepvghstghhfigrrhhtiiesghgvnhhtohhordhorhhgpdhrtghp
    thhtoheprhgrmhhsrgihsehrrghmshgrhihjohhnvghsrdhplhhushdrtghomh
X-ME-Proxy: <xmx:R_tSZ8qpanQJ1L_XVLxc8X-OdAIM9ijQyro_CBLMSfuc3tT0XSkxfw>
    <xmx:R_tSZ1qLcVS_S3uS2ZdEWU2d6pEV6iNZGWypp1qW7sTZKU0Z0O-_eA>
    <xmx:R_tSZ6TNaftl-eAtL9IkXHDmh1l0nl-3lKCT4zcJyRmvbnwvGp0sgw>
    <xmx:R_tSZ1p4m1gFbgD0VDtT1n0M1e4xYhNePhTBNe0QO__eADVi7ZoK0g>
    <xmx:R_tSZ2SRXpZcpi37ouC2LuMmYmJWo4AbJNhEHJK9HkWu5o-fbw6a7YaI>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 6 Dec 2024 08:25:25 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 634dfed0 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 6 Dec 2024 13:23:58 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Fri, 06 Dec 2024 14:24:42 +0100
Subject: [PATCH v11 07/26] Makefile: consistently use PERL_PATH
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241206-pks-meson-v11-7-525ed4792b88@pks.im>
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
index f8ae750ffdb1dc4c4ad547029799710841665d1e..c0815b8fff297020a25deb73b2dc15d3bea2852e 100644
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
index 865b3af9fb2c1e7bdc1e7cecd0f021ee460971dd..ecaae8965cd43d4a5a36201b8760296b52147dc2 100644
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
2.47.0.366.g5daf58cba8.dirty

