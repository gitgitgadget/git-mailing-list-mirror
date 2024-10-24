Received: from fhigh-b8-smtp.messagingengine.com (fhigh-b8-smtp.messagingengine.com [202.12.124.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F7201D63D9
	for <git@vger.kernel.org>; Thu, 24 Oct 2024 12:39:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729773603; cv=none; b=Ey0Jazo//leHjNtJlWu8oYVoYYyjNmrQzgMw2CVsFVCPGUOkdltC/9jH2rYupw7IIIT2wBFCOrkw1XzcJMqn+3OP/XRDv44e9pGe19caItA2TnmVxPGr1xXte1tzAuyfpt3VtBtJLM8zHpdOAZMmkFyHk1wv5Xl/cBqPGpyiE/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729773603; c=relaxed/simple;
	bh=qcczTi+erRvQrICQgisGX6kY4TzWRJ/+1ffqQInLOuc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mqmyfdH+AlSwXS6HgPil9YcSXwtIjNHnTwQAYlqoLvpG83MLr10Nm/EgtDyfcaV5vaBXS1MeIJCKDmV7nRhROcAC8zrgV4hJFt8Qyz4yROvEU7vPB4gc++PkqVETbkPM/1ZnaaPSU0s0VJ4vH5wv1h/R+xYb2csengpYs5x/b5w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=RRz7Sv+Y; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=WktMryRU; arc=none smtp.client-ip=202.12.124.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="RRz7Sv+Y";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="WktMryRU"
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfhigh.stl.internal (Postfix) with ESMTP id EEF382540144;
	Thu, 24 Oct 2024 08:39:58 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Thu, 24 Oct 2024 08:39:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1729773598; x=1729859998; bh=hb/9hYq8of
	L2uNukPd/72A0KWiEAH4RLqgqfEhNnaTQ=; b=RRz7Sv+YIiQ63uxhC+Ab2JbsRd
	FsAyiA4orWr+DKcjEXYSf6nPDajbR5iglDCRSqYgmJlKjS1S57+jXxS1QxZZBLDr
	GPQggShmdpsQkIQ6MShh8/eNc5jHMebaV2NF7pf13Uf1anHlHcEJyzQcbI3rbjAX
	JoSeBtE1GoK6D6UJ+xqiDSuW9LHD7SjjVHcMBFzyNOrVchFjDwURwKqlexnanwje
	YcfF3eeMq6tRxBJm4lyT1gv+wh3DvSy7Jt7W+rq7itIgVmRN86GymrQzWo/YEj/4
	HvPwVbBklbT5TMRy9dBYpaj3OMwY6ZSiUH3OcSvGomvbfo30nyFGTNMnswUw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1729773598; x=1729859998; bh=hb/9hYq8ofL2uNukPd/72A0KWiEA
	H4RLqgqfEhNnaTQ=; b=WktMryRUwf+b+Wh55Ihn/df81UOe4hEB7dmYJJ6zOgA6
	NZt1sfT5vOMF2A4RSvPFr/YOFZaZ9U8VPsIgKgrAJwrRP0lV5Lvo2gCpFmtMPb0j
	kCq9ogy2qI1GTEmclyEk6WYrFfa2cNZg99l49qPZwtUQPk90no3r4WnwDIwtsqIk
	TF3upT6wyjsFIFNMN8id/pO+p0NN8M+S/O6dAIDesrT1eCeNCf3BJpT4q86KTTIm
	ny9CnkL0GACorLCzp365ShL/KI8rMRbL13fDsjtGIqp2FyfOKpUJfUD07geWzoys
	dZuC/F4tdeS4t2XTvZqjrGkzanQc/6evL0q5Z6pcgA==
X-ME-Sender: <xms:HkAaZ6Ty-y1wtGNGFnaVpqkGWWfDlLugkReifWoyqiZ9W2XhRv114A>
    <xme:HkAaZ_zDax8sAfXa-kWTiMc_ECP550IZtvKjGhB2X5SKTZ8Y4EkwQJu-pLMWMPXGN
    dHaI0gQoCbxmMicLw>
X-ME-Received: <xmr:HkAaZ30yp16w-3M3l_1_jeyyhiOeZqKQlZdtRg6o2NQNdxy3RfS-KqLWWuOfP_7L5QZH7QoyBnoiS4oodGvU5E1rVcJTVCAfZNT9r0F2ijKjX0lG>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdejtddgvdelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefgueeg
    udfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepjedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtoheprhgrmhhsrgihsehrrghmshgrhihjohhnvghsrdhplh
    hushdrtghomhdprhgtphhtthhopehphhhilhhlihhprdifohhougduvdefsehgmhgrihhl
    rdgtohhmpdhrtghpthhtohepvghstghhfigrrhhtiiesghgvnhhtohhordhorhhgpdhrtg
    hpthhtohepghhithhsthgvrhesphhosghogidrtghomhdprhgtphhtthhopehgihhtsehv
    ghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepshhunhhshhhinhgvsehsuhhnsh
    hhihhnvggtohdrtghomhdprhgtphhtthhopehmvgesthhtrgihlhhorhhrrdgtohhm
X-ME-Proxy: <xmx:HkAaZ2A5rLoP8Uh6YENXcksv858Qra6WVr0v4nfFQMcSoIr7dRWr4g>
    <xmx:HkAaZzhypJfZqrpWRfkIfXU4fi4gffV3cgctGDgTAqu3TKRvOTbivQ>
    <xmx:HkAaZyqOKaylbEjNJxghzdSzK_u8k6zUy1nUJkCy_vNelR0i07yuFw>
    <xmx:HkAaZ2jVwJDHNNemkSd3Ccb-JIWChIcsPrcdO72KRaAQ6il5_vyNzQ>
    <xmx:HkAaZzhFfhJLL-U-hO6Aqtz0EKeBfCIvc2E9c3l8y6r7alV2XSnOZSyR>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 24 Oct 2024 08:39:57 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id abe0ac63 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 24 Oct 2024 12:39:59 +0000 (UTC)
Date: Thu, 24 Oct 2024 14:39:54 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Eli Schwartz <eschwartz@gentoo.org>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Phillip Wood <phillip.wood123@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Ramsay Jones <ramsay@ramsayjones.plus.com>,
	Taylor Blau <me@ttaylorr.com>
Subject: [RFC PATCH v4 03/19] Makefile: consistently use PERL_PATH
Message-ID: <20e77ffc5f5a5b4222a4882dc7429dd482f1fbab.1729771605.git.ps@pks.im>
References: <cover.1727881164.git.ps@pks.im>
 <cover.1729771605.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1729771605.git.ps@pks.im>

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
2.47.0.118.gfd3785337b.dirty

