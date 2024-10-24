Received: from fout-b5-smtp.messagingengine.com (fout-b5-smtp.messagingengine.com [202.12.124.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72C7B1D9A46
	for <git@vger.kernel.org>; Thu, 24 Oct 2024 12:40:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729773614; cv=none; b=EpS7NHzCfP81fus4jcxphpzxiQCNzA93pHAnAWZYZHUyXbLP8yIZwUWhitS3iZ/F+p+hG22QmcFs+hzY5IFf1qUHSYMxEsNjz9/tvZQP8fgyEH288A57OUZx8EhnJJwQYsaEWn+pC+jUlaU7EPFBiefCAgXXXrRr5dlZxsDjw7I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729773614; c=relaxed/simple;
	bh=HpFX2DfkwCxIU7Qb7jvJTmLR7GkRDR2zWL9P6KYRKqU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Kdc81d1lxqA/Ttt8X6tOuXV71LBW3HeAy+2quvmWVfBOtgk/IgQCv6e4J3EWq4fcbvLqNCOMHGFkYnPQBACUq/iBTNqYH6lEX1r4EVJJSyBzlZ3yglGETj2Ps97NArYa2IYAmO7nwFeQf/cB3znE6e0HT9fE0MQneKtKRPgulms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=v8k/h1vx; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=YkTTPb5s; arc=none smtp.client-ip=202.12.124.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="v8k/h1vx";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="YkTTPb5s"
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfout.stl.internal (Postfix) with ESMTP id 724871140125;
	Thu, 24 Oct 2024 08:40:11 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Thu, 24 Oct 2024 08:40:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1729773611; x=1729860011; bh=KuSQTn/tOF
	yBSN30YXlWynnlBg3gXZasuq8CSqtb9bg=; b=v8k/h1vxnm1HEz/+8DObgC5PiH
	nIRBYqWPBj/Al2mU3heVRRuRP2Pko7FMs5tCA5L7bvNBpVsD8gM8rnpTtju2CS7b
	2c5WNPfCO/ZsuKB2t3Wt33lR9eBtTfyTCEXDPeoAa4/pbVsyiuJ/DWUo86RkdJ0J
	uzN1xNh051mRLVQ63duqakT/4fV327k4CFcOV9WdAImWGIDMLDF0Eu97iulQGkxA
	kLJWcAS8FEegpUbFS8ZiWP0MoJLy+JY8G5eUsLp9JJY7T++2xeHfpNagUn6UMvUy
	tjZz1OwUsxunBcg+tAUYhOK4apsIuQC0UPHVbuSrFKFVnunNcr2gvUs+3VQA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1729773611; x=1729860011; bh=KuSQTn/tOFyBSN30YXlWynnlBg3g
	XZasuq8CSqtb9bg=; b=YkTTPb5s29ZDK8zTbe1hY/Q6Jv0x7M5HUdnv8enwziqu
	Hzooij+EuR04e9zqP+06lttxcBvtC9Z0O+meYu7HkRr9MSznN9AQKW64lYzN/iTV
	A3XH2R/UXVcoqMlf4ZqvSSe35BE6LjyyfMjchmU4k7AKIEVKXrkMoYl7613ozoug
	b035ERcElz20LSrxG5vVKc7k6TPrPa5wMFHOhXneZbJ2gZAwV3blk5W0tzi072LP
	28dGMR/jjwA5BX5EEF5cEMfiXTOlH5i81Lz20/DVsXfJge9dUDCj8oCo2t9b7fwg
	zu2/lOPawOOFYZhfVVBIkG4rQiU92jCvf4PzBdZ/KQ==
X-ME-Sender: <xms:K0AaZ8Yw3clL8nbxF1txzNJbThgSYtG7zBUjwEcOmWpRwZOo2XPzbA>
    <xme:K0AaZ3bEfZ_vY6ZgpHp9Rds0bFq65lSobSXnxWhLE2vwKfkM4WByv2R83cTJo-V2o
    duY1r4vBIythhrqIA>
X-ME-Received: <xmr:K0AaZ28CN09g5fdztKbDQFLTj2PT9NSKHjzfilfcLUn2ZMseKw8tb4IIyHs2YJLJCTPUGliORXTWdzBu69QxFvZsoDPtfnUjSikzSumoQTOLt7hT>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdejtddgvdelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefgueeg
    udfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgepudenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepjedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepmhgvsehtthgrhihlohhrrhdrtghomhdprhgtphhtth
    hopehsuhhnshhhihhnvgesshhunhhshhhinhgvtghordgtohhmpdhrtghpthhtohepvghs
    tghhfigrrhhtiiesghgvnhhtohhordhorhhgpdhrtghpthhtohepghhithesvhhgvghrrd
    hkvghrnhgvlhdrohhrghdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
    pdhrtghpthhtohepphhhihhllhhiphdrfihoohguuddvfeesghhmrghilhdrtghomhdprh
    gtphhtthhopehrrghmshgrhiesrhgrmhhsrgihjhhonhgvshdrphhluhhsrdgtohhm
X-ME-Proxy: <xmx:K0AaZ2ov0-sfY8D2m50sZa7mG9_KPPzrameBNBI4bA2idMRTFjltKA>
    <xmx:K0AaZ3owgAOpDN4lJ2yPTXhzjsPAFG-saaPUEGqqvvCxT_5e6o8_Fw>
    <xmx:K0AaZ0TcgKYWlBf5kqTivIxXnpXoliqlIdtR4Tje6OoVUEIbWvAVnw>
    <xmx:K0AaZ3pyECS6_PSNCe1PyykEjPXg_GQWLRpT7gS5GZsuUyfU6wH0Bg>
    <xmx:K0AaZzJYWbJLsvmYaEzF7OLGr3zfBF7LHSZ1Ta1SLar1I9BvAzx9Paqv>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 24 Oct 2024 08:40:09 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 161d0979 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 24 Oct 2024 12:40:12 +0000 (UTC)
Date: Thu, 24 Oct 2024 14:40:07 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Eli Schwartz <eschwartz@gentoo.org>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Phillip Wood <phillip.wood123@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Ramsay Jones <ramsay@ramsayjones.plus.com>,
	Taylor Blau <me@ttaylorr.com>
Subject: [RFC PATCH v4 07/19] Makefile: extract script to generate gitweb.cgi
Message-ID: <e8abda661cfcbde210c36b1f6af03c094af65002.1729771605.git.ps@pks.im>
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

In order to generate "gitweb.cgi" we have to replace various different
placeholders. This is done ad-hoc and is thus not easily reusable across
different build systems.

Introduce a new GITWEB-BUILD-OPTIONS.in template that we populate at
configuration time with the expected options. This script is then used
as input for a new "generate-gitweb.sh" script that generates the final
"gitweb.cgi" file. While this requires us to repeat the options multiple
times, it is in line to how we generate other build options like our
GIT-BUILD-OPTIONS file.

While at it, refactor how we replace the GITWEB_PROJECT_MAXDEPTH. Even
though this variable is supposed to be an integer, the source file has
the value quoted. The quotes are eventually stripped via sed(1), which
replaces `"@GITWEB_PROJECT_MAXDEPTH@"` with the actual value, which is
rather nonsensical. This is made clearer by just dropping the quotes in
the source file.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 gitweb/GITWEB-BUILD-OPTIONS.in | 25 +++++++++++++++
 gitweb/Makefile                | 58 ++++++++++++++++------------------
 gitweb/generate-gitweb.sh      | 45 ++++++++++++++++++++++++++
 gitweb/gitweb.perl             |  2 +-
 4 files changed, 99 insertions(+), 31 deletions(-)
 create mode 100644 gitweb/GITWEB-BUILD-OPTIONS.in
 create mode 100755 gitweb/generate-gitweb.sh

diff --git a/gitweb/GITWEB-BUILD-OPTIONS.in b/gitweb/GITWEB-BUILD-OPTIONS.in
new file mode 100644
index 00000000000..20a6487796f
--- /dev/null
+++ b/gitweb/GITWEB-BUILD-OPTIONS.in
@@ -0,0 +1,25 @@
+PERL_PATH=@PERL_PATH@
+JSMIN=@JSMIN@
+CSSMIN=@CSSMIN@
+GIT_VERSION=@GIT_VERSION@
+GIT_BINDIR=@GIT_BINDIR@
+GITWEB_CONFIG=@GITWEB_CONFIG@
+GITWEB_CONFIG_SYSTEM=@GITWEB_CONFIG_SYSTEM@
+GITWEB_CONFIG_COMMON=@GITWEB_CONFIG_COMMON@
+GITWEB_HOME_LINK_STR=@GITWEB_HOME_LINK_STR@
+GITWEB_SITENAME=@GITWEB_SITENAME@
+GITWEB_PROJECTROOT=@GITWEB_PROJECTROOT@
+GITWEB_PROJECT_MAXDEPTH=@GITWEB_PROJECT_MAXDEPTH@
+GITWEB_EXPORT_OK=@GITWEB_EXPORT_OK@
+GITWEB_STRICT_EXPORT=@GITWEB_STRICT_EXPORT@
+GITWEB_BASE_URL=@GITWEB_BASE_URL@
+GITWEB_LIST=@GITWEB_LIST@
+GITWEB_HOMETEXT=@GITWEB_HOMETEXT@
+GITWEB_CSS=@GITWEB_CSS@
+GITWEB_LOGO=@GITWEB_LOGO@
+GITWEB_FAVICON=@GITWEB_FAVICON@
+GITWEB_JS=@GITWEB_JS@
+GITWEB_SITE_HTML_HEAD_STRING=@GITWEB_SITE_HTML_HEAD_STRING@
+GITWEB_SITE_HEADER=@GITWEB_SITE_HEADER@
+GITWEB_SITE_FOOTER=@GITWEB_SITE_FOOTER@
+HIGHLIGHT_BIN=@HIGHLIGHT_BIN@
diff --git a/gitweb/Makefile b/gitweb/Makefile
index 164c8d53757..48c3958bc66 100644
--- a/gitweb/Makefile
+++ b/gitweb/Makefile
@@ -77,43 +77,41 @@ GITWEB_JSLIB_FILES += static/js/javascript-detection.js
 GITWEB_JSLIB_FILES += static/js/adjust-timezone.js
 GITWEB_JSLIB_FILES += static/js/blame_incremental.js
 
-
-GITWEB_REPLACE = \
-	-e 's|@GIT_VERSION@|$(GIT_VERSION)|g' \
-	-e 's|@GIT_BINDIR@|$(bindir)|g' \
-	-e 's|@GITWEB_CONFIG@|$(GITWEB_CONFIG)|g' \
-	-e 's|@GITWEB_CONFIG_SYSTEM@|$(GITWEB_CONFIG_SYSTEM)|g' \
-	-e 's|@GITWEB_CONFIG_COMMON@|$(GITWEB_CONFIG_COMMON)|g' \
-	-e 's|@GITWEB_HOME_LINK_STR@|$(GITWEB_HOME_LINK_STR)|g' \
-	-e 's|@GITWEB_SITENAME@|$(GITWEB_SITENAME)|g' \
-	-e 's|@GITWEB_PROJECTROOT@|$(GITWEB_PROJECTROOT)|g' \
-	-e 's|"@GITWEB_PROJECT_MAXDEPTH@"|$(GITWEB_PROJECT_MAXDEPTH)|g' \
-	-e 's|@GITWEB_EXPORT_OK@|$(GITWEB_EXPORT_OK)|g' \
-	-e 's|@GITWEB_STRICT_EXPORT@|$(GITWEB_STRICT_EXPORT)|g' \
-	-e 's|@GITWEB_BASE_URL@|$(GITWEB_BASE_URL)|g' \
-	-e 's|@GITWEB_LIST@|$(GITWEB_LIST)|g' \
-	-e 's|@GITWEB_HOMETEXT@|$(GITWEB_HOMETEXT)|g' \
-	-e 's|@GITWEB_CSS@|$(GITWEB_CSS)|g' \
-	-e 's|@GITWEB_LOGO@|$(GITWEB_LOGO)|g' \
-	-e 's|@GITWEB_FAVICON@|$(GITWEB_FAVICON)|g' \
-	-e 's|@GITWEB_JS@|$(GITWEB_JS)|g' \
-	-e 's|@GITWEB_SITE_HTML_HEAD_STRING@|$(GITWEB_SITE_HTML_HEAD_STRING)|g' \
-	-e 's|@GITWEB_SITE_HEADER@|$(GITWEB_SITE_HEADER)|g' \
-	-e 's|@GITWEB_SITE_FOOTER@|$(GITWEB_SITE_FOOTER)|g' \
-	-e 's|@HIGHLIGHT_BIN@|$(HIGHLIGHT_BIN)|g'
-
 .PHONY: FORCE
 $(MAK_DIR_GITWEB)GITWEB-BUILD-OPTIONS: FORCE
-	@rm -f $@+
-	@echo "x" '$(PERL_PATH_SQ)' $(GITWEB_REPLACE) "$(JSMIN)|$(CSSMIN)" >$@+
+	@sed -e 's|@PERL_PATH@|$(PERL_PATH_SQ)|' \
+	     -e 's|@JSMIN@|$(JSMIN)|' \
+	     -e 's|@CSSMIN@|$(CSSMIN)|' \
+	     -e 's|@GIT_VERSION@|$(GIT_VERSION)|' \
+	     -e 's|@GIT_BINDIR@|$(bindir)|' \
+	     -e 's|@GITWEB_CONFIG@|$(GITWEB_CONFIG)|' \
+	     -e 's|@GITWEB_CONFIG_SYSTEM@|$(GITWEB_CONFIG_SYSTEM)|' \
+	     -e 's|@GITWEB_CONFIG_COMMON@|$(GITWEB_CONFIG_COMMON)|' \
+	     -e 's|@GITWEB_HOME_LINK_STR@|$(GITWEB_HOME_LINK_STR)|' \
+	     -e 's|@GITWEB_SITENAME@|$(GITWEB_SITENAME)|' \
+	     -e 's|@GITWEB_PROJECTROOT@|$(GITWEB_PROJECTROOT)|' \
+	     -e 's|@GITWEB_PROJECT_MAXDEPTH@|$(GITWEB_PROJECT_MAXDEPTH)|' \
+	     -e 's|@GITWEB_EXPORT_OK@|$(GITWEB_EXPORT_OK)|' \
+	     -e 's|@GITWEB_STRICT_EXPORT@|$(GITWEB_STRICT_EXPORT)|' \
+	     -e 's|@GITWEB_BASE_URL@|$(GITWEB_BASE_URL)|' \
+	     -e 's|@GITWEB_LIST@|$(GITWEB_LIST)|' \
+	     -e 's|@GITWEB_HOMETEXT@|$(GITWEB_HOMETEXT)|' \
+	     -e 's|@GITWEB_CSS@|$(GITWEB_CSS)|' \
+	     -e 's|@GITWEB_LOGO@|$(GITWEB_LOGO)|' \
+	     -e 's|@GITWEB_FAVICON@|$(GITWEB_FAVICON)|' \
+	     -e 's|@GITWEB_JS@|$(GITWEB_JS)|' \
+	     -e 's|@GITWEB_SITE_HTML_HEAD_STRING@|$(GITWEB_SITE_HTML_HEAD_STRING)|' \
+	     -e 's|@GITWEB_SITE_HEADER@|$(GITWEB_SITE_HEADER)|' \
+	     -e 's|@GITWEB_SITE_FOOTER@|$(GITWEB_SITE_FOOTER)|' \
+	     -e 's|@HIGHLIGHT_BIN@|$(HIGHLIGHT_BIN)|' \
+	     $(MAK_DIR_GITWEB)GITWEB-BUILD-OPTIONS.in >"$@+"
 	@cmp -s $@+ $@ && rm -f $@+ || mv -f $@+ $@
 
+$(MAK_DIR_GITWEB)gitweb.cgi: $(MAK_DIR_GITWEB)generate-gitweb.sh
 $(MAK_DIR_GITWEB)gitweb.cgi: $(MAK_DIR_GITWEB)GITWEB-BUILD-OPTIONS
 $(MAK_DIR_GITWEB)gitweb.cgi: $(MAK_DIR_GITWEB)gitweb.perl
 	$(QUIET_GEN)$(RM) $@ $@+ && \
-	sed -e '1s|#!.*perl|#!$(PERL_PATH_SQ)|' \
-		$(GITWEB_REPLACE) $< >$@+ && \
-	chmod +x $@+ && \
+	$(MAK_DIR_GITWEB)generate-gitweb.sh $(MAK_DIR_GITWEB)/GITWEB-BUILD-OPTIONS $< $@+ && \
 	mv $@+ $@
 
 $(MAK_DIR_GITWEB)static/gitweb.js: $(addprefix $(MAK_DIR_GITWEB),$(GITWEB_JSLIB_FILES))
diff --git a/gitweb/generate-gitweb.sh b/gitweb/generate-gitweb.sh
new file mode 100755
index 00000000000..b47ea6e599e
--- /dev/null
+++ b/gitweb/generate-gitweb.sh
@@ -0,0 +1,45 @@
+#!/bin/sh
+
+set -e
+
+if test $# -ne 3
+then
+	echo "USAGE: $0 <GITWEB-BUILD-OPTIONS> <INPUT> <OUTPUT>" >&2
+	exit 1
+fi
+
+GITWEB_BUILD_OPTIONS="$1"
+INPUT="$2"
+OUTPUT="$3"
+
+. "$GITWEB_BUILD_OPTIONS"
+
+sed -e "1s|#!/usr/bin/perl|#!$PERL_PATH|" \
+    -e "s|@PERL_PATH@|$PERL_PATH|" \
+    -e "s|@JSMIN@|$JSMIN|" \
+    -e "s|@CSSMIN@|$CSSMIN|" \
+    -e "s|@GIT_VERSION@|$GIT_VERSION|" \
+    -e "s|@GIT_BINDIR@|$GIT_BINDIR|" \
+    -e "s|@GITWEB_CONFIG@|$GITWEB_CONFIG|" \
+    -e "s|@GITWEB_CONFIG_SYSTEM@|$GITWEB_CONFIG_SYSTEM|" \
+    -e "s|@GITWEB_CONFIG_COMMON@|$GITWEB_CONFIG_COMMON|" \
+    -e "s|@GITWEB_HOME_LINK_STR@|$GITWEB_HOME_LINK_STR|" \
+    -e "s|@GITWEB_SITENAME@|$GITWEB_SITENAME|" \
+    -e "s|@GITWEB_PROJECTROOT@|$GITWEB_PROJECTROOT|" \
+    -e "s|@GITWEB_PROJECT_MAXDEPTH@|$GITWEB_PROJECT_MAXDEPTH|" \
+    -e "s|@GITWEB_EXPORT_OK@|$GITWEB_EXPORT_OK|" \
+    -e "s|@GITWEB_STRICT_EXPORT@|$GITWEB_STRICT_EXPORT|" \
+    -e "s|@GITWEB_BASE_URL@|$GITWEB_BASE_URL|" \
+    -e "s|@GITWEB_LIST@|$GITWEB_LIST|" \
+    -e "s|@GITWEB_HOMETEXT@|$GITWEB_HOMETEXT|" \
+    -e "s|@GITWEB_CSS@|$GITWEB_CSS|" \
+    -e "s|@GITWEB_LOGO@|$GITWEB_LOGO|" \
+    -e "s|@GITWEB_FAVICON@|$GITWEB_FAVICON|" \
+    -e "s|@GITWEB_JS@|$GITWEB_JS|" \
+    -e "s|@GITWEB_SITE_HTML_HEAD_STRING@|$GITWEB_SITE_HTML_HEAD_STRING|" \
+    -e "s|@GITWEB_SITE_HEADER@|$GITWEB_SITE_HEADER|" \
+    -e "s|@GITWEB_SITE_FOOTER@|$GITWEB_SITE_FOOTER|" \
+    -e "s|@HIGHLIGHT_BIN@|$HIGHLIGHT_BIN|" \
+    "$INPUT" >"$OUTPUT"
+
+chmod a+x "$OUTPUT"
diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index 76e1f4e244f..41bc64ec73f 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -88,7 +88,7 @@ sub evaluate_uri {
 
 # fs traversing limit for getting project list
 # the number is relative to the projectroot
-our $project_maxdepth = "@GITWEB_PROJECT_MAXDEPTH@";
+our $project_maxdepth = @GITWEB_PROJECT_MAXDEPTH@;
 
 # string of the home link on top of all pages
 our $home_link_str = "@GITWEB_HOME_LINK_STR@";
-- 
2.47.0.118.gfd3785337b.dirty

