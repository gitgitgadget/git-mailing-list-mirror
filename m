Received: from fhigh-a1-smtp.messagingengine.com (fhigh-a1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C927C1D0DFE
	for <git@vger.kernel.org>; Wed,  2 Oct 2024 15:16:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727882192; cv=none; b=hHkkA4qok+5WXtsYvyXuGdziopxzZg7Nd6VqGuB+w4jUPLUqyetWmRT5BJigqi2ZExVu7JQEdntmfRccOvRKJbXt7riF3IsEsci7OrQY5e+tiPc9QlPoSN4vR488C2ETWQxJ9NvOZVnKGIuK2g7sIAhz9UckRh+ToeQQNqdB2L8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727882192; c=relaxed/simple;
	bh=FLAOOctICLznyGG1XS95Hf2Mxd8jY0egsLxQR4coKW4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FenfSv1cOqR/gRMm3xOGBrWOztNbAkp7sa0//Np2vwaFHKc8kB1NsRdBfhhJthlqvd+QB/Y0wSoiu5QQK/0uhSTGs8lgFO3eogZ4MYusy6IWl1N2Dl6BXt6l/uruxXVb/RI+XB78zgxboegpm5UbQUBN1FWeiPTu2nzDHCw+CTY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=C/jjh9ST; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=HkEel7/l; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="C/jjh9ST";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="HkEel7/l"
Received: from phl-compute-09.internal (phl-compute-09.phl.internal [10.202.2.49])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 002661140185;
	Wed,  2 Oct 2024 11:16:30 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-09.internal (MEProxy); Wed, 02 Oct 2024 11:16:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1727882189; x=1727968589; bh=hsctdS/VZS
	Q0w7fagrRSqyAwAfhk/NfFpVuADGGvIjA=; b=C/jjh9STGn2mrmvPMyJku0PQZi
	Ip788LqN3UPiFK9jZnw17hzLf7sLz77v4liUh55N0TKTPSssbrjBcdOQIh3bmbmJ
	hlC5mDfU6bpbOFetIWYdVV+uCFDpNv/QuuUeXGRyUz3cnjyBgBPDu++VYypFlHtl
	fwuXvWjcnLwoJOI1g68/f00d11QadXytX7z7Ev1RQysSs8XE0dcPBcV50i14b1d0
	iLvSmuFMC3lyKoXQJ95x8fv6JlqTbUDp8tP7MYKl9s0qTM1g/1FwxEIB3ewFVtMy
	ACM7Pu8tEUSq/95NCtwFMAcieKhtvQeMsFawXZEdivAUkc0NCq6NfGkNIEEQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1727882189; x=1727968589; bh=hsctdS/VZSQ0w7fagrRSqyAwAfhk
	/NfFpVuADGGvIjA=; b=HkEel7/lnCX7m4uo8oR+oXkVhR5EEyBylo0Mt6HlcmqS
	1iwRLS2vaYWqFdCFwU2zBsCzbIBb2GlBan+Ni3DJd4pL35G44ePN5QkEKI9b6b/7
	MJdWoqRMXBAW1qGAhDxHP1NdOMBD8IHd0T+qRaiUDK1QmLiH5EUfqhQYoaqqS0U/
	amNkK6htNtM1HAFA0XczTDag7T4QIXGswp2P5m/mUAfD4JMO6oyeGiiRhmFDR4WG
	epXyIJTOXmyMnTTf+X0SfGKq0ppJcOnG2tkaJCC31dEPxXLE0EIjXX9lNJUB1NzS
	HEYx5v6z1o1yB30fz7gQfpoDxChtHWeon7iSI/y1wg==
X-ME-Sender: <xms:zWP9ZoxsFfIMoDwg7dStP1sn6MU87TyLEn_RomPltKckcQ6j2rkEYQ>
    <xme:zWP9ZsQbqxMpO_TYepQqaBwMqmXASn__4pA897KozvhnitIQoCxlHQgFhUgkxjtHL
    sj_WV2xftU3O-Gp9Q>
X-ME-Received: <xmr:zWP9ZqVC3aJcVh0hWayRhHPSCw8mNRcgGoXdTPXtwSCwBQInJd-nWLf5lSwA6koFMsHqshzwgKQhsXA6RE8VJ3pYBnsW1iLVLqFrywwX98LxzCVz>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdduledgkeefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefgueeg
    udfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgepudenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepvddpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprh
    gtphhtthhopegvshgthhifrghrthiisehgvghnthhoohdrohhrgh
X-ME-Proxy: <xmx:zWP9ZmgKFe3UbXo15aQgpWNuRzR8BIGOjTByktdXDI_B2iNbnjsylw>
    <xmx:zWP9ZqCict0UGSRcSkvowFyswd0nlU6PznRW8HhjwGfrr1EtndbkdQ>
    <xmx:zWP9ZnKaUXRVNkbjRvjIPSrpCty1OpnymRdgomQSZ5u8K5iowveDgA>
    <xmx:zWP9ZhDANoev4anv5c-yHKSjpaNUC998oz0gqg7z_qPrANo41Naw6w>
    <xmx:zWP9ZtNjs1z0t523dFN18iRdz2tb9IdHwExlUDxv9yJ1erReS-MP7Bpb>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 2 Oct 2024 11:16:29 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 60f51472 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 2 Oct 2024 15:15:38 +0000 (UTC)
Date: Wed, 2 Oct 2024 17:16:26 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Eli Schwartz <eschwartz@gentoo.org>
Subject: [RFC PATCH 16/21] Makefile: consistently use PERL_PATH
Message-ID: <73417f39a5ecaebd53092f34e0ec4cc1f757959e.1727881164.git.ps@pks.im>
References: <cover.1727881164.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1727881164.git.ps@pks.im>

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
index 91e64c1222..380b6a3dbc 100644
--- a/Makefile
+++ b/Makefile
@@ -2529,7 +2529,7 @@ sed -e '1s|#!.*/sh|#!$(SHELL_PATH_SQ)|' \
     -e 's/@USE_GETTEXT_SCHEME@/$(USE_GETTEXT_SCHEME)/g' \
     -e $(BROKEN_PATH_FIX) \
     -e 's|@GITWEBDIR@|$(gitwebdir_SQ)|g' \
-    -e 's|@PERL@|$(PERL_PATH_SQ)|g' \
+    -e 's|@PERL_PATH@|$(PERL_PATH_SQ)|g' \
     -e 's|@PAGER_ENV@|$(PAGER_ENV_SQ)|g' \
     $@.sh >$@+
 endef
diff --git a/contrib/buildsystems/CMakeLists.txt b/contrib/buildsystems/CMakeLists.txt
index bf029b9428..5884fa73b1 100644
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
index c8efb1205a..5ad50160bb 100755
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
index 10c88639e2..775ba8ea11 100755
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
2.47.0.rc0.dirty

