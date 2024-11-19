Received: from fout-a7-smtp.messagingengine.com (fout-a7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A87511CC161
	for <git@vger.kernel.org>; Tue, 19 Nov 2024 11:51:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732017069; cv=none; b=J8MEqA8MOuy/OpqQ4ihhrYJu5LGGbbNZiX2QfLlkrItdX8ZgYGxa5nvuQSiXQYgV096KgHSthzpbLxRDPqlseMoi1lGDELbctFpFBT3bfGmn9PSBDNMJiQ6FgIZcjsdwIykDTmlVqUfXjAMXhG0IlknbZJNY8GU28cOrgBWWcwo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732017069; c=relaxed/simple;
	bh=cPaRI18dxvBG5j4AiV1/CvO4H/oYerhY0RJAGq6PEWg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=r4eGtG0IHeQ3Lxilj/Rhpj5HxYmWXvf3e1YrocdLEmx16QG1laEbsqxY0oSltEzBerI8nEHHVwJ8oEUSL26xc2GmUdTwRNu8PLYoXbWEALT06mBQ0SIDG2FUmJa/WmlFSIdsYoIf/gU1NsXp8+KKePj9YKk0/Dbwq2H9AA7VN3Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=STgqO2Gp; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=T51l4QUO; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="STgqO2Gp";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="T51l4QUO"
Received: from phl-compute-07.internal (phl-compute-07.phl.internal [10.202.2.47])
	by mailfout.phl.internal (Postfix) with ESMTP id D4CF11380540;
	Tue, 19 Nov 2024 06:51:06 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-07.internal (MEProxy); Tue, 19 Nov 2024 06:51:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1732017066;
	 x=1732103466; bh=LuUf9HsHqR64h03geLgGz/7poZ8eY4ZjHnxGcjBOQts=; b=
	STgqO2GpK0tcQOZ2u39g8Axarx63wetC5n5OvJb4mkf1HQzjHl5U/J6GnJypdXJ9
	POdJIfIjxIfOyOKK21bJP7GdAt9iesDMBXzIHAspLmG9R2hekpTS+k3dsof54R/p
	vBw/8vL85uIUphv6SZfCJL5ZpQwF/Qq+zBWX1ztyeJs+pctcdfyXYsizlH8OwBoj
	jBJBSIQBfeRfLcqHeswtoWeOKrvlCIxeaM1okMV+ckmMh9zcrKpetCbWav1u4To1
	+tc/616aamIEfioLrf5o1Rg6g604is99QgzosKLSIUqIgiGEBBgBWQKYVV9XZRvE
	3GpOcVCnl16eJtZ67XtQbg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1732017066; x=
	1732103466; bh=LuUf9HsHqR64h03geLgGz/7poZ8eY4ZjHnxGcjBOQts=; b=T
	51l4QUOw/4XZqP5bas7lclK1Tj/m++raVYZ1/9DNZe4FNWHH6OAxggPoHG7XWe/4
	+CmSFPzLIl1jBUElycStB4MrlrrwL1yDDEHqwriZPQpjzIeUYJAtPKCTMx1jhQCZ
	dkXzaGsLFodceKIgH1olO8oqynQaXDzx7MjFR5Pr390Pb86yJLCZ335X8YiYI08P
	n21IvoyYfVzvpR6rSGDiJSE4ejwuDognmYpEz7RFpuyCdimvkzQIO9yRvJ5376c7
	SY/XwSnefPcUZMfBUjE5bwuaJMwPly7052XLStzDUMGj6citzLKVgnEtUYxfnjj2
	qqLkMgYeeQBIs2scBTBmA==
X-ME-Sender: <xms:qns8Z_Et08ay-Rf7xLX0B1kD4g4rBP6ID1habuTQtSf6hZJkJBE70A>
    <xme:qns8Z8UxUwP9q3eTzgmxc_PZj06TfVJzXroyW2Q91TlZ2YQjwN89XnnyGDDqkcpn0
    RyzCAr7pmDVX7OpEg>
X-ME-Received: <xmr:qns8ZxKHH9jnxT_XosHg34UpP3m4geC-AUmv_eY5sHqoo7LQrnph6n5QqMQIoxh-czK2_frEhm54mYCRjL_6KYOwI0T7Kcyx0n6Y53h8Lc8FLMg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrfedvgdefudcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
    hsucdlqddutddtmdenucfjughrpefhfffugggtgffkfhgjvfevofesthejredtredtjeen
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepffeuiedujedvkeehuedvkeefffeivdeuleetkeduheej
    teekgedvudfgtdfgieelnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepuddtpdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopehmvgesthhtrgihlhhorhhrrdgtohhmpdhrtghpth
    htohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopegthhhrihhs
    tghoohhlsehtuhigfhgrmhhilhihrdhorhhgpdhrtghpthhtohepvghstghhfigrrhhtii
    esghgvnhhtohhordhorhhgpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtgho
    mhdprhgtphhtthhopehpvghffhesphgvfhhfrdhnvghtpdhrtghpthhtohepshhunhhshh
    hinhgvsehsuhhnshhhihhnvggtohdrtghomhdprhgtphhtthhopegurghvvhhiugesghhm
    rghilhdrtghomhdprhgtphhtthhopehphhhilhhlihhprdifohhougduvdefsehgmhgrih
    hlrdgtohhm
X-ME-Proxy: <xmx:qns8Z9EaQr4flb8VMLXjFUYzt22eysh8RAPbcS7I5yrS24sWgA3LfA>
    <xmx:qns8Z1X1LJm94gELnRDvMo86sHuyi5Us25dflVA9Do1LNybqB7Fz5A>
    <xmx:qns8Z4Nv0f29SkWnq2fTgmU7aMWxNj5YOGCroenlmsmTHajxysQahw>
    <xmx:qns8Z02-vRVaL_LF5KgMll4yp-8SIUyI_n4wwVb-j2kglZBULGV6YA>
    <xmx:qns8Z-OGP9mIema2WPpTNKgmlrjBzvjMLnUNB8XS3E5qBSNE-vtrGhUB>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 19 Nov 2024 06:51:04 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id c522968b (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 19 Nov 2024 11:50:13 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Tue, 19 Nov 2024 12:50:48 +0100
Subject: [PATCH v8 11/23] Makefile: extract script to generate gitweb.cgi
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241119-pks-meson-v8-11-809bf7f042f3@pks.im>
References: <20241119-pks-meson-v8-0-809bf7f042f3@pks.im>
In-Reply-To: <20241119-pks-meson-v8-0-809bf7f042f3@pks.im>
To: git@vger.kernel.org
Cc: Eli Schwartz <eschwartz@gentoo.org>, 
 Eric Sunshine <sunshine@sunshineco.com>, 
 Phillip Wood <phillip.wood123@gmail.com>, 
 Junio C Hamano <gitster@pobox.com>, 
 Ramsay Jones <ramsay@ramsayjones.plus.com>, Taylor Blau <me@ttaylorr.com>, 
 David Aguilar <davvid@gmail.com>, Jeff King <peff@peff.net>, 
 Christian Couder <chriscool@tuxfamily.org>
X-Mailer: b4 0.14.2

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
 gitweb/GITWEB-BUILD-OPTIONS.in | 24 +++++++++++++++++
 gitweb/Makefile                | 59 +++++++++++++++++++++---------------------
 gitweb/generate-gitweb-cgi.sh  | 47 +++++++++++++++++++++++++++++++++
 gitweb/gitweb.perl             |  2 +-
 4 files changed, 101 insertions(+), 31 deletions(-)

diff --git a/gitweb/GITWEB-BUILD-OPTIONS.in b/gitweb/GITWEB-BUILD-OPTIONS.in
new file mode 100644
index 0000000000000000000000000000000000000000..41ac20654c4f79917993bafa8f7e447669552b9d
--- /dev/null
+++ b/gitweb/GITWEB-BUILD-OPTIONS.in
@@ -0,0 +1,24 @@
+PERL_PATH=@PERL_PATH@
+JSMIN=@JSMIN@
+CSSMIN=@CSSMIN@
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
index 164c8d53757f98599ad14eeb22ca8d542eb7502a..16a2ef2d1e5664d99f6f1d8ff4224c36769c55fb 100644
--- a/gitweb/Makefile
+++ b/gitweb/Makefile
@@ -77,43 +77,42 @@ GITWEB_JSLIB_FILES += static/js/javascript-detection.js
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
 
+$(MAK_DIR_GITWEB)gitweb.cgi: $(MAK_DIR_GITWEB)generate-gitweb-cgi.sh
 $(MAK_DIR_GITWEB)gitweb.cgi: $(MAK_DIR_GITWEB)GITWEB-BUILD-OPTIONS
+$(MAK_DIR_GITWEB)gitweb.cgi: GIT-VERSION-FILE
 $(MAK_DIR_GITWEB)gitweb.cgi: $(MAK_DIR_GITWEB)gitweb.perl
 	$(QUIET_GEN)$(RM) $@ $@+ && \
-	sed -e '1s|#!.*perl|#!$(PERL_PATH_SQ)|' \
-		$(GITWEB_REPLACE) $< >$@+ && \
-	chmod +x $@+ && \
+	$(MAK_DIR_GITWEB)generate-gitweb-cgi.sh $(MAK_DIR_GITWEB)/GITWEB-BUILD-OPTIONS ./GIT-VERSION-FILE $< $@+ && \
 	mv $@+ $@
 
 $(MAK_DIR_GITWEB)static/gitweb.js: $(addprefix $(MAK_DIR_GITWEB),$(GITWEB_JSLIB_FILES))
diff --git a/gitweb/generate-gitweb-cgi.sh b/gitweb/generate-gitweb-cgi.sh
new file mode 100755
index 0000000000000000000000000000000000000000..67a646aeb7c22fd69817ed14c9937f3123736405
--- /dev/null
+++ b/gitweb/generate-gitweb-cgi.sh
@@ -0,0 +1,47 @@
+#!/bin/sh
+
+set -e
+
+if test $# -ne 4
+then
+	echo "USAGE: $0 <GITWEB-BUILD-OPTIONS> <GIT-VERSION-FILE> <INPUT> <OUTPUT>" >&2
+	exit 1
+fi
+
+GITWEB_BUILD_OPTIONS="$1"
+GIT_VERSION_FILE="$2"
+INPUT="$3"
+OUTPUT="$4"
+
+. "$GITWEB_BUILD_OPTIONS"
+. "$GIT_VERSION_FILE"
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
index 76e1f4e244fd23dd29b935e83753efa9c6d5bb5e..41bc64ec73f9f05666480025c3b70650607b4cd8 100755
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
2.47.0.274.g962d0b743d.dirty

