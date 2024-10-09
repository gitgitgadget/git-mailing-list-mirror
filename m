Received: from fout-a3-smtp.messagingengine.com (fout-a3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07BCA1A2C25
	for <git@vger.kernel.org>; Wed,  9 Oct 2024 14:57:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728485826; cv=none; b=ndr/PTVR6hWTGkdtkRZvJ3HaW5MyKssI781Kih0Fo14flw+ieADuS/EhTaOLuztgFZo5FIYAZGRuPO9QrNvojBsMvWrPRHMoUkzIF3Qkg/2A2AdSFPLxrFAg+4eZs2tXLWeG39xQZCdyVkCyDh32D7zuZ6KgrLZn6FEAOG1mUyM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728485826; c=relaxed/simple;
	bh=0by8LkXDNgsPxRMG1PZOtkaW26TdmvmwdPE2yO8+wFU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Y7U8sIerfQP3HEUZMeR0IQ+SXRwAHI5Y2KlcFW3o7Aazw6nrYTlgd0LfZTsbz8siZP4e4ObuDXrDgUzlymy2083xTgD6tBsVSiyezFhd171wpN1q9QUZlcJ2zVGsuZgDxZKj27CL7T8eAEdCNgTkPT+ue72JqtUP51jVzOPoeio=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=m0jRV2zn; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=a28HdvE/; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="m0jRV2zn";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="a28HdvE/"
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfout.phl.internal (Postfix) with ESMTP id 2521E13801C2;
	Wed,  9 Oct 2024 10:57:04 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Wed, 09 Oct 2024 10:57:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1728485824; x=1728572224; bh=ygP2rr4wb3
	eQAKOQl5UybY5qjYpF/N/0aIERRXCYnTc=; b=m0jRV2znfAINqG87zTaWDK5jxf
	O+b0PuS2Gvl0dUWWj2YCBh2CkOvf3Ukp5GylwnYc7MvvvJBjbGe6UCTKZIJxeglE
	o6Wg4V/w5gV2RTjTgDE3mTZSVuGzkhYAzw2xcvBAz+eGX1DkST78TSfcUtt1/s5E
	UL/bV/03PRN1eKzO5cj0vs7lHgy+TQsO1T7lqtMnIhPPGw2TvAoquYuTm2Tu2fpj
	FYo7f6Gr/Z93NHiGu/ovZRpbcZs9OCYoMQOOA9tEoexPdADtCDik4toE4IxoFmWw
	Q2WOpR8maGXF0UXuQUJnwBNiqHJG2lFB0bCDD8EwE0zRoP1IeUEF1uaHFawQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1728485824; x=1728572224; bh=ygP2rr4wb3eQAKOQl5UybY5qjYpF
	/N/0aIERRXCYnTc=; b=a28HdvE/BR7dvPEtw+GjNlKci1ZN7hbqaXV+6x7CoPI9
	40fx70zKf14TLuTsLjKGhzqVFJk2OZh8hr3vMVO340qZnD6qVAjZESjAC1JaOPNk
	BzTwsGl9uKfVlEZ5B289uZRpP7reko79lsDVpk3cf5mxAzuoM/8B8kaL//qhqVtV
	kWjZhFj5jtHAr/5Q6PjfGNwitzJjbomQ8nS8X6kbP5Nvrej2aL55eZXqd5RkTzoL
	o5baMfhl721TaUueu9JHDo3OPr/U6LS+u0yKKhnS/vmErlghnaUNL01Rc22lAz7M
	YN3GIUk+z671hfkA+X3P399J8GwrCd2X4meQ6KS//g==
X-ME-Sender: <xms:wJkGZyd8lW2TOM0k2VnEOzOzh5u0nmyQAwqC-2rkOvj9A_nmBXikYA>
    <xme:wJkGZ8MCG4SX57RhMbYNSjbqAp2CIpvKUrDu-GJgU-G7VtUP4ZIbha_KMt9VAzXqm
    wUJnhM69ixLGNRrtQ>
X-ME-Received: <xmr:wJkGZzi3HyFkEES7d6ivy1fNoa4VsF0u-POkcOTAiFyinSFLxpEbzcImwKzLcmGKzlUIg-m0NRvo1AoLDwPSqzu2yQYgVMa27zTdPYaKnIe8mg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdeffedgkeehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefgueeg
    udfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgepvdenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohephedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomhdprhgtph
    htthhopegvshgthhifrghrthiisehgvghnthhoohdrohhrghdprhgtphhtthhopehsuhhn
    shhhihhnvgesshhunhhshhhinhgvtghordgtohhmpdhrtghpthhtohepghhithesvhhgvg
    hrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehphhhilhhlihhprdifohhougduvdef
    sehgmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:wJkGZ_--oFUnnjGNm3RF5AGJKd5-REozPQfLysoGRvnYXuHD3kthdQ>
    <xmx:wJkGZ-swYlJD_uj3ZgQ6K0PtqgrrnFfgNmOTO0fWOyp4GdHN_jhDvw>
    <xmx:wJkGZ2GSTK9owG-WdNMcLOxAQQBlc-jjE1CCp5jn7HtF8_eb7nbM_Q>
    <xmx:wJkGZ9MKJ_GPVt6LJA21RMPpXkx_Din3gs3twM_m045o1b-nYcKf1A>
    <xmx:wJkGZwUwU4gS3KGb8PLdWQM4cDJL0klGbkdcRsQP067u6BgJTGg6NJJX>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 9 Oct 2024 10:57:02 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id de674e38 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 9 Oct 2024 14:55:59 +0000 (UTC)
Date: Wed, 9 Oct 2024 16:56:59 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Eli Schwartz <eschwartz@gentoo.org>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Phillip Wood <phillip.wood123@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: [RFC PATCH v2 18/24] Makefile: consistently use PERL_PATH
Message-ID: <1ee9c61fc33eb0da44f223ef5c86334f4d8e3666.1728485139.git.ps@pks.im>
References: <cover.1727881164.git.ps@pks.im>
 <cover.1728485139.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1728485139.git.ps@pks.im>

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
index 9f710a7cba9..46327596275 100644
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
index 73008bf2d18..d63c9078345 100644
--- a/contrib/buildsystems/CMakeLists.txt
+++ b/contrib/buildsystems/CMakeLists.txt
@@ -839,7 +839,7 @@ foreach(script ${git_shell_scripts})
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
2.47.0.rc1.33.g90fe3800b9.dirty

