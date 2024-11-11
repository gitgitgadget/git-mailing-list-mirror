Received: from fout-a3-smtp.messagingengine.com (fout-a3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3324119E82A
	for <git@vger.kernel.org>; Mon, 11 Nov 2024 15:30:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731339057; cv=none; b=Dp5+BqJmOQCPVw67cjKNQUcJSW5szehMdv0zoiDXW2rzPzpe5lT+cnLDsl+AsSkfhLVC7/OC1334iV2HJis8M6H5feBg1QgOcBRK0mJKn1J4DHUD1YXdprTPel+RoGEqz9A/e4rkM6EM6YPRlBddReyCTLtltxUdEV2n9OmzCS0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731339057; c=relaxed/simple;
	bh=aJahixFxk8of3FbsdvBQ21yELY6r41ZjFZE0/pRRMEM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bhuM9Qg+psyi/swbmIqRJPD1fPdclmuGbeTPAaFKxjXKLLJsnVYrpG5I4jj4Lh9Gl447diKe5XrKyjk3ktBlurnH4JgOgpMmpDgQIrYfrtRFCR1wCgDYBfQ5LBSGWVrNT9ltZ3k522RAVdmvxtszskDWZKsbEc2eMdTqYchcLBw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=Da+uHo+3; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=mjsGxu25; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Da+uHo+3";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="mjsGxu25"
Received: from phl-compute-08.internal (phl-compute-08.phl.internal [10.202.2.48])
	by mailfout.phl.internal (Postfix) with ESMTP id 2248D13806E3;
	Mon, 11 Nov 2024 10:30:54 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-08.internal (MEProxy); Mon, 11 Nov 2024 10:30:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1731339054; x=1731425454; bh=KcJrDRTByb
	Xd2Uctt9Nz/0Sd7rTC04FEuhqS7SGrKSE=; b=Da+uHo+304IS1vJe1Bf9mQ1gcQ
	9lBC9J+WJZMYhR1w/V20umXWZCaGNcHSu0eRyDUyn8tiL9B5H3nV9xuXCwi+pBVU
	N+OXQRP0EKv+J65IA0e3c14Pfu8gJU+B2UXJ9455Yq+eJ4I7CWH2RXbpF5W/YhJ3
	roKsBC3stWjnrJA3N3ZnGpByd2Rm+M+bAY1kw7i+R1t3VnEBEyTYfToBHOPYHdpT
	OKesrH8huB0l+gm24yMcJ9MA+J034doj3mnAxfAhnhSF2DAo+xgTyGk53apgUkOd
	K8tVbP71MLbgf4r6iYnLxjgKN0e0UGOb/VxN5BB7j4aDpBTj2p2JvPHgN0IA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1731339054; x=1731425454; bh=KcJrDRTBybXd2Uctt9Nz/0Sd7rTC04FEuhq
	S7SGrKSE=; b=mjsGxu250LplyHESgEQbZhVTbpLmkqaK4Y3sV3clR14z9FIm4pU
	m2aWCV+t7qedMCY/fTYarzUmQ2PdG6hQ5RAWiXvHvpv8GueUF76xvLko8NLS/NnM
	eMv9kvYL5piZIfiXFnTnpbbEcKQiETlzhob/Y66G9UF+1aGbNKDH2rngXFl3CuX1
	pX1GsixSbxN3Np9QWwofCQrsNAXOEJxkBXYBjsdBcEnIVT57kMbL3tzCmW4T9AQD
	6wi4yCoBF9QgWum1DzZ5VJnnhjqT+7wAZYyYZC4AsD0zvme/UZIiFawa3ZKXxz45
	tkQDwI3L1aQA2yZfJ842JDQ2n1wUm8zkSRA==
X-ME-Sender: <xms:LSMyZ0IsR9hVhzr-jAdjj0tdeSvw7rSsWSuSSGE-J7fqjnBlGqR6tQ>
    <xme:LSMyZ0JA31g5CWKteFYVZKkAWmzUwhlhJjRF5LukOjgEDt6_1gm_VBAYJgPDMQu02
    k79csNxMS408MQUqg>
X-ME-Received: <xmr:LSMyZ0sAAtvqzY2MycEiIQdZk_-3vovKOd9d1MBCySs2Fs4iMzPRDJiYxU0U4diMvq1mMzVD8HJEhbSQFOgUOHceg7hihdYA9Vue9VoE3ax65mC7>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddruddvgdejiecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
    hsucdlqddutddtmdenucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecu
    hfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqe
    enucggtffrrghtthgvrhhnpeevkeekfffhiedtleduiefgjedttedvledvudehgfeugedu
    gffhueekhfejvdektdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrih
    hlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeekpdhmohguvgepshhm
    thhpohhuthdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtg
    hpthhtohepmhgvsehtthgrhihlohhrrhdrtghomhdprhgtphhtthhopehrrghmshgrhies
    rhgrmhhsrgihjhhonhgvshdrphhluhhsrdgtohhmpdhrtghpthhtohepphhhihhllhhiph
    drfihoohguuddvfeesghhmrghilhdrtghomhdprhgtphhtthhopegvshgthhifrghrthii
    sehgvghnthhoohdrohhrghdprhgtphhtthhopegurghvvhhiugesghhmrghilhdrtghomh
    dprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhmpdhrtghpthhtohepshhu
    nhhshhhinhgvsehsuhhnshhhihhnvggtohdrtghomh
X-ME-Proxy: <xmx:LSMyZxbuJKB5wmmxj33aI2twWXRiGBWcfQfgpMo_RRZ6QH2-6x9PVg>
    <xmx:LSMyZ7bnLCpIqXZR9BM0e17JW5bT4RTy16NzsUs_0Z-pH7RTTWxoZw>
    <xmx:LSMyZ9DI-j2ssZqNHZpr8l1Lw-tyheNc-HNHAKV731TdtneoIIucdQ>
    <xmx:LSMyZxbyj6bqO4hiK-uyVnm177-jcLJjZLL_JobujugOqnOakkdiCA>
    <xmx:LiMyZ5ORLRk3E5eqbjembKult9-cC79n10W6g0BuY7Uvdm9x7NmeCYcI>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 11 Nov 2024 10:30:52 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id e7efdec3 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 11 Nov 2024 15:30:17 +0000 (UTC)
Date: Mon, 11 Nov 2024 16:30:43 +0100
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Eli Schwartz <eschwartz@gentoo.org>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Phillip Wood <phillip.wood123@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Ramsay Jones <ramsay@ramsayjones.plus.com>,
	Taylor Blau <me@ttaylorr.com>, David Aguilar <davvid@gmail.com>
Subject: [RFC PATCH v5 03/19] Makefile: consistently use PERL_PATH
Message-ID: <20e77ffc5f5a5b4222a4882dc7429dd482f1fbab.1731335939.git.ps@pks.im>
References: <cover.1727881164.git.ps@pks.im>
 <cover.1731335938.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1731335938.git.ps@pks.im>

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
index 8a2b292e3d2..22ed53f39e7 100644
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
index a41540458b7..608ad9714d4 100644
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
index c8efb1205a8..5ad50160bb0 100755
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
index 10c88639e28..775ba8ea11a 100755
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
2.47.0.229.g8f8d6eee53.dirty

