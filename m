Received: from fhigh-b8-smtp.messagingengine.com (fhigh-b8-smtp.messagingengine.com [202.12.124.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BA3A18E351
	for <git@vger.kernel.org>; Fri, 18 Oct 2024 12:23:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729254241; cv=none; b=eMJdbxCQZmgPQEZXpv3vNefJV0cK+kQmh2tocen5Wm/5sbQ2L8VWdYOTW4lyttpRORXGRQBnMnht63C1cglObdVIjqbep9ptCytGNVddKUcL+LnDlip2CkCTNgRswK23OIE13N9jxEIBP8C0SG9uNcvCcTrxJ1FfpJBpB0kAsBg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729254241; c=relaxed/simple;
	bh=y3x2TmVg10abpPrSEx1w90O+/vKSh4FZErwNzN+mi+I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fs98chbP6WZr9ioJTAQhfMfkoYxoQ4IbEYWo4h1UKbx/YZRdlZ8L83paZFSE+87uF/Zmtd2VdyS3nIyxK9Q/OOfMAPkEeiTNM/cpId3z1enEViFc5731LKm7GoX0a2oNUhaypyAmZOm0Cz8Oif08qEhSN/FkNbc+fmGut+SSi88=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=oZ1US2F5; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=HZHXWbga; arc=none smtp.client-ip=202.12.124.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="oZ1US2F5";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="HZHXWbga"
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 8819A2540078;
	Fri, 18 Oct 2024 08:23:58 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Fri, 18 Oct 2024 08:23:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1729254238; x=1729340638; bh=l0sj3FtxDz
	LGFstkMrJgeEvbZZac+7TvzBXHa745CPA=; b=oZ1US2F56NroiT3AHRtdB48aXT
	941k8GkLsAji4+fYtuQhRMzAK1Mx2aYvtQzbywjNhDLugMRrycbFFAvOz8kN7rUN
	yV3yvmAZUTA9/6p8GiClEvlEqN+eb2YtLmWjE5QYU/bgdB9y3NVZiLT5+6sb+MGC
	UgyPB+ubHto3LA8bzn0X1h8bkNytjhiXMSAsB+sX/wlABBxGCfC77NakA5oDylxf
	XYlo+LfzRmdNRwkx0P2AvQUkXkKGk1HnLUsDp5lCB7DTiXpE26SYi1gaLZ8Z5Han
	p17GOpJjuv+TniezN2yG87dbyMa44c1A7mX1uAuDCjkPL6M2EZLhd7+GlKuQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1729254238; x=1729340638; bh=l0sj3FtxDzLGFstkMrJgeEvbZZac
	+7TvzBXHa745CPA=; b=HZHXWbgaS3ej5NTQqyDhCv+WeC/LukJKqDfFxicduEx0
	Gbj5z37b6pIjTng6+0xDCVcW7/NNYjWU11poyutoC/DsbkoO9ufE/fzxXHtr043K
	perQtMA/NOlTKUdlvREgLOSTAcFjJAocG0GSM/ycYPRGvqC1tvpQ8S3vi2lPmSya
	P7SLw5GyQ+xq84Aw/h3wCF67ngPMlfNPcgbWfo42NunNEEZKRUXMN31SCn1Ekvbg
	raKKRW4ogLteg66O9Yp9ui+bNYBuTMbXufcIpMl1EKrrp3qPHfQqkEWpNQZEgQYE
	jTp8wG6sClzT3SD0EAOx76I3MJIowPfpTos9Zi3GXw==
X-ME-Sender: <xms:XlMSZxsI7Z7SL_2RJh8gig7xTJxJW5Pk9cQxR7ObLAXnVi-iya0l3A>
    <xme:XlMSZ6fRDsunQhdQLFyVzTqM0XjpG69PhLfPHpbBjPJI5-Evanhsa258AYj_CXpjH
    VRuPD1WyjaOJSuK6Q>
X-ME-Received: <xmr:XlMSZ0ym_9TraMbFxyr07Xf9J6DYXLVN5p54EKK_r53KrSMcOW302iFsxO3Xbt_4X2KJmfTq_MA_qLvYdZnCdJ6vMwZe2TqagLNIkKdtyKFm>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdehfedggeelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefgueeg
    udfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgepudenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepiedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprh
    gtphhtthhopegvshgthhifrghrthiisehgvghnthhoohdrohhrghdprhgtphhtthhopehp
    hhhilhhlihhprdifohhougduvdefsehgmhgrihhlrdgtohhmpdhrtghpthhtohepshhunh
    hshhhinhgvsehsuhhnshhhihhnvggtohdrtghomhdprhgtphhtthhopehgihhtshhtvghr
    sehpohgsohigrdgtohhmpdhrtghpthhtoheprhgrmhhsrgihsehrrghmshgrhihjohhnvg
    hsrdhplhhushdrtghomh
X-ME-Proxy: <xmx:XlMSZ4OCNdsbuWu9Gpftwltggi_kEwyDkuZvMg9r-qpCOZtNeyP3HA>
    <xmx:XlMSZx8IEpAeEfKW3x_sxSg0rcrRKNojz06oglL6OBWSimVgM5OzqA>
    <xmx:XlMSZ4Xrc2pj_yC9ZQ8WkAebZyDLVXIljo77kxnPoRFL9-YBFSkY9g>
    <xmx:XlMSZydXLmCz_2WsfKI-UGwb2PqBpNXLi9MTyaDz1YpleiPOT-wkDg>
    <xmx:XlMSZxyq6KtqGmvwiUYI1A6nw7KqXcBKQW7nuksHo2jXRhTNqGLmt6qF>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 18 Oct 2024 08:23:56 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 4db74ebc (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 18 Oct 2024 12:22:35 +0000 (UTC)
Date: Fri, 18 Oct 2024 14:23:56 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Eli Schwartz <eschwartz@gentoo.org>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Phillip Wood <phillip.wood123@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Ramsay Jones <ramsay@ramsayjones.plus.com>
Subject: [RFC PATCH v3 03/15] Makefile: consistently use PERL_PATH
Message-ID: <8261f108968a30748cc8555922adb6ef32645449.1729254070.git.ps@pks.im>
References: <cover.1727881164.git.ps@pks.im>
 <cover.1729254070.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1729254070.git.ps@pks.im>

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
index d98ce366c08..394466b716d 100644
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
2.47.0.72.gef8ce8f3d4.dirty

