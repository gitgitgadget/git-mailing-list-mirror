Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D077A185B78
	for <git@vger.kernel.org>; Fri, 15 Nov 2024 07:21:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731655303; cv=none; b=GqDVbueVABvIGUI7n9mogTV8FKVuM8KjOPcstVGZgYW9mM+mCQgVf4obmmdcxPkvCAGoLZs3q1NnU6fCH4UIDTKyEYAwMxpb38Wbjr/faWb3rZHYOO2uz9i7gfuKeqD7SrsPTqFMqzwQkQw3K4e+mv3bsAYXn6PZ3aWFUd4CBpw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731655303; c=relaxed/simple;
	bh=j+2rftyXLj2VE4gQkZJV1mnTYRTEQDG+d5xxUl/eTCw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=l64lj62h6DOh+ulH1gR3/wEjqv6THPksecx0uHB/jqsndhv02q5BPASEHn8Mz7bl/GLyMFdSLPlGkm0ap9oKvmGBgTnjFaB9cDETaO57YH1SZ1nsWW0g5/C6hAI+1YH54PYJYmz2c7fX9N+I8PK+zb3wjkmilvbyyHVs2+hHkOo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=xP1TYH6q; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=iBBmE2p6; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="xP1TYH6q";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="iBBmE2p6"
Received: from phl-compute-02.internal (phl-compute-02.phl.internal [10.202.2.42])
	by mailfout.phl.internal (Postfix) with ESMTP id DCA5C138060C;
	Fri, 15 Nov 2024 02:21:40 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Fri, 15 Nov 2024 02:21:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1731655300;
	 x=1731741700; bh=W4lX0r9CRrrzZKppV38VXsi1dI7e3gVX3OJONGgvKeM=; b=
	xP1TYH6q1A+SjQDX8Dc9MwCKv60mS+G4X75zofpMnBRvyavlrozfQ7Al3MD1SfMT
	sDodRIqrPI2jqaTAa2rSLwsXYK84/tt6yEnDFJ+jo/KY1GQwI88RBSmCC4x28CIt
	rVEtiID0vevuXgjn5YeqShT5MdPoUuy5qDJZGAG7c1V0T31W36/EeQB7ktyeaSEr
	S2AG8QQjGLwm1kpezrq6N8du0q/DnfNcYtPyAgtnfqfvbwlzJnoKO8GZdRhtEQ4V
	BYIiwFCZJJwyXfQ+H5LotCLDHl5ifiewG+L/+D6n8OkBR5pQ9ZQm5XXTpHnfg5md
	YwEEvmF47vKdkTW53SuNLQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1731655300; x=
	1731741700; bh=W4lX0r9CRrrzZKppV38VXsi1dI7e3gVX3OJONGgvKeM=; b=i
	BBmE2p6UDne1x5qhiSIPSUsYofAc5MGNuBaCZ0cnrWhu0m4uRKQNt3sl1iJOnUvg
	yN6VnCefWLPP9h1evyKeqBPuurHDRUk2dvwLq+SzrH4+MoDRRNQ98zRe5/u1S6Dp
	cxhT61eYaFm4jG6+jmAu3Zwg1ftmbaZ4O10SvsiNXx9ENBlke2OS0daBmWdQDXjQ
	G+czsSA2Bpgpbq0IBDpgZZSki5Qtt5OrTc5nwJmO3AJVecdIixLEOI6s52bl2Tsn
	a6fvixZG/MwTmA4qjbFS3xPY67YbCRfv1eRQNJYZ4dV/StAsuM4PnIiZn0QemlVW
	VJXBs3VTzV/OkNwfONWhw==
X-ME-Sender: <xms:hPY2ZwbJVtZZsJqheBzohirKzQvFImi55AuSHKMVV_qZQ1_I7AxtnA>
    <xme:hPY2Z7YXDQm7hgjOPuaY35Wv94NhImnAgAG4a-hkXVlWLvEjmk4EueI9cw2On2k7a
    GFmUYczagQ-bBj5eg>
X-ME-Received: <xmr:hPY2Z6_0CEXqgZRit-LcNtoQIYLv9tA7LoGfGdj_s4hO-MglplPe2sVPKhGo10rHxSn12x3Auz0okc4w86-jVj7M86a9Y63U0-LrE0Ivxta141Lr5Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrvdefgddutdefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdej
    necuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrih
    hmqeenucggtffrrghtthgvrhhnpeffueeiudejvdekheeuvdekfeffiedvueelteekudeh
    jeetkeegvddugfdtgfeileenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmh
    grihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopedutddpmhhouggv
    pehsmhhtphhouhhtpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomhdprh
    gtphhtthhopehmvgesthhtrgihlhhorhhrrdgtohhmpdhrtghpthhtohepshhunhhshhhi
    nhgvsehsuhhnshhhihhnvggtohdrtghomhdprhgtphhtthhopegurghvvhhiugesghhmrg
    hilhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhr
    tghpthhtohepphgvfhhfsehpvghffhdrnhgvthdprhgtphhtthhopehphhhilhhlihhprd
    ifohhougduvdefsehgmhgrihhlrdgtohhmpdhrtghpthhtoheptghhrhhishgtohholhes
    thhugihfrghmihhlhidrohhrghdprhgtphhtthhopehrrghmshgrhiesrhgrmhhsrgihjh
    honhgvshdrphhluhhsrdgtohhm
X-ME-Proxy: <xmx:hPY2Z6rU3AjYo_TOGmkLAcFGWZSeycNPlZsg3CKTjMPrgCaxdgQYZA>
    <xmx:hPY2Z7oME-I6m30w4G-M7uJdGKxZLSTZlArSMVQuvAk5mVA62utBfw>
    <xmx:hPY2Z4Qj6udE9UJhVrJJNaawE1wgJtbDGn-3_16ecR8MNsYGdnO75A>
    <xmx:hPY2Z7pI58JGDvJ4iMjlS2pb3owO4KhztSiperl2b6UYgMTFcHR47Q>
    <xmx:hPY2Z4hBnqEb_uGWSe4mgazUpkbpIKJk94mN4fmCjU4va1aoDGvRSGET>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 15 Nov 2024 02:21:38 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 62c1cd0c (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 15 Nov 2024 07:20:53 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Fri, 15 Nov 2024 08:21:18 +0100
Subject: [PATCH RFC v7 06/22] Makefile: consistently use PERL_PATH
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241115-pks-meson-v7-6-47ec19b780b2@pks.im>
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
index eced752985caa10a21870c4ba638b4e6fbb3e5ec..fd4b061d0ad140cf0c9fcc09aa5946b2ca0ca7a5 100644
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
2.47.0.251.gb31fb630c0.dirty

