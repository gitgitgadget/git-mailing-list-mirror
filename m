Received: from fout-b4-smtp.messagingengine.com (fout-b4-smtp.messagingengine.com [202.12.124.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 066FA193072
	for <git@vger.kernel.org>; Mon, 25 Nov 2024 09:57:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732528642; cv=none; b=a/LRUp4iV+bGHUdt7rMOt+pZT5EYjPS/JiLHfX3ujDeAPj1ujxq1lhMfR71F0an7a9ERtxCtLzLbqo5XRwk6ia+qqSPtjVdE1pUo0vf4pQerb8WpzDuMXZNTv2MDYI2lXuAGjY8UKl1/ntBqaRffrbKdK/N7HkhAE835dNhR/TE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732528642; c=relaxed/simple;
	bh=RbZiM2FcACZgD3QR67Q0lDSnfBNB388cU+iR067buSc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=MQCEVK1fI54mOcwUd1CtN1ZLYAEY7RFZV8/LvM0GkhuxGDmr0d/v3r2Opakt66U9y+Z5/eNt4lnkqvPtnrw6n9qop2DHemaSy6dEoLrN/GyMxQQV7GxRrLuAe2pCoMaP4tUOvanG1GA97mOJ8k1oXhzGnmxw2YcGlOfgfnc5T4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=Ql/ijwPA; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=IM2ipzH6; arc=none smtp.client-ip=202.12.124.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Ql/ijwPA";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="IM2ipzH6"
Received: from phl-compute-09.internal (phl-compute-09.phl.internal [10.202.2.49])
	by mailfout.stl.internal (Postfix) with ESMTP id 2D42A1140146;
	Mon, 25 Nov 2024 04:57:20 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-09.internal (MEProxy); Mon, 25 Nov 2024 04:57:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1732528640;
	 x=1732615040; bh=Y0tDNAD7lwcOFrFQwqRVKkccwtoHD09bn9q7bxg8Gow=; b=
	Ql/ijwPA4nXpOu1zKkL8r2q/Y+7kRAiX52wkuIM7kAiwRUcD/6HYm1U5pWU0sSyi
	A2YKr2wP455Mt8fUrCGiB4VxBpGcBsg89joSJSyA0apMjq7y0HDiEjO5h+DUNyae
	pOSzfncvmgzZgDsuCvZYH9c/4ZozQibRuxNjFxtCG508cZFwoi/4tpj499FqWGNz
	bFS/DP5d+vGXJ9rXZlWzS1J0RqB1emthDyrwuZYSf8kOI7mC9p/0a5babNTA2Kmk
	OhzdRMe4zBK3V37qqa8NpAVmm7pRQA0tyCpAGDwkH3WIeJbDsuPe3wDI50XYCNVk
	80RP8L+B0LUab329FC/r0w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1732528640; x=
	1732615040; bh=Y0tDNAD7lwcOFrFQwqRVKkccwtoHD09bn9q7bxg8Gow=; b=I
	M2ipzH63UVAJNynd23ezOLDghxhbnypKDKJOctvnw1lymQy3abLwsjL/y+OKTIYi
	akMnBqYV1HtNySF/Mj3W2XdVCfWxAZe6tb9qFMzIwBNilX9QGckUOAmIiOEmBaAv
	chWHMCC369pXSVjhiOWsswFwa6kOp6timlo6VAmBbTzVS1Mt+AuZqhHa07jC0aEV
	czQhctFnuozWkdiBHwyZtYu+Sc80+pOMUKjRve9axUMT+8J/9x6731wkJtdGPGQw
	VQEAuyEHK/Szf/h4Ey1TDoKGsjheqD3S060O2DaNTFKrXO0N9BiIJiGNA1MtsJXf
	+pAQp9qcqt1E0DTGJAfHA==
X-ME-Sender: <xms:_0lEZ9IJ757veHbB5hhrvh-duVvzFGQxS7uHkw_Be40XszYOaI-_Pg>
    <xme:_0lEZ5L2J-C-vaj74S99YtabXLZG898SlXfBubKP5_ix6yuVHqGqsfVojJAdUgWrt
    aOWpMbDNlOlon2euA>
X-ME-Received: <xmr:_0lEZ1uAgzrc6flzYjPA0Tk7VQ0ytVnr7Ot6qRwjqh_Qnt9VwiRDyZ9gOgqZcSC2UWBKSlA_mCggA1R-iL0BbwAzXnBsfAO1bbi70agufh5KyA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrgeehgddtkecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
    hsucdlqddutddtmdenucfjughrpefhfffugggtgffkfhgjvfevofesthejredtredtjeen
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepffeuiedujedvkeehuedvkeefffeivdeuleetkeduheej
    teekgedvudfgtdfgieelnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepuddupdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopehpvghffhesphgvfhhfrdhnvghtpdhrtghpthhtoh
    eptghhrhhishgtohholhesthhugihfrghmihhlhidrohhrghdprhgtphhtthhopehgihht
    sehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepjheitheskhgusghgrdhorh
    hgpdhrtghpthhtohepphhhihhllhhiphdrfihoohguuddvfeesghhmrghilhdrtghomhdp
    rhgtphhtthhopegvshgthhifrghrthiisehgvghnthhoohdrohhrghdprhgtphhtthhope
    hgihhtshhtvghrsehpohgsohigrdgtohhmpdhrtghpthhtohepshhunhhshhhinhgvsehs
    uhhnshhhihhnvggtohdrtghomhdprhgtphhtthhopegurghvvhhiugesghhmrghilhdrtg
    homh
X-ME-Proxy: <xmx:_0lEZ-bUFpLxXQUzBfgpohex00nOD0liAWUOpevwuuqdvhwTuDWMpw>
    <xmx:_0lEZ0YOS6twJjx_OCvYGRZuzjXMY0e6LvAGhUINnQFT51E8ciTeEQ>
    <xmx:_0lEZyCUNrsZqZMAuAnPs2046oCVgFRFnTytineZs4xUEfuIicqldA>
    <xmx:_0lEZyZjb3-4tO_f0w2g_xAWLlnHHpTmvHOooDOtKmJTM-gH6lq6gw>
    <xmx:AEpEZ-DuGVObSGg8f5pR19Pi8HwzFD4kzIkJxOXxLw5SpGrmsGOo6-n4>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 25 Nov 2024 04:57:17 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 925fcd92 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 25 Nov 2024 09:56:12 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Mon, 25 Nov 2024 10:56:55 +0100
Subject: [PATCH v9 07/23] Makefile: consistently use PERL_PATH
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241125-pks-meson-v9-7-1c6cf242a5f1@pks.im>
References: <20241125-pks-meson-v9-0-1c6cf242a5f1@pks.im>
In-Reply-To: <20241125-pks-meson-v9-0-1c6cf242a5f1@pks.im>
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
index 1255d222c2dec9a034dee2621192bf97afe905ee..0e289d1dbcbfa48e4566fb3e6d4eedd87ae2d141 100644
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
2.47.0.274.g962d0b743d.dirty

