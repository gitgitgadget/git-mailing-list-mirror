Received: from fhigh-b5-smtp.messagingengine.com (fhigh-b5-smtp.messagingengine.com [202.12.124.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DD55196446
	for <git@vger.kernel.org>; Mon, 25 Nov 2024 09:57:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732528645; cv=none; b=oyAnwvRhDRCL6xViUpeb6DG8rCkZye9WXm+sTXzF4E+mOln0zK9Xi1VWbuq7ce9F7Lmsr6Wspcalw+PS6sYgeYDabtIcQzJui6ccA9ll4YyZEHht+zcAdd4b6BFlsfFLl2R4jc2hyA12itWVAOdMXooF3ep2phxoECv+bAjrxRQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732528645; c=relaxed/simple;
	bh=hM5T6Y+TjzANIfEGPXNPblPT9OLRHGmA3Rpv+X1AkDM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=cGaeKtIXN/awP+GgaZOOEPqoaEuwU6wNDABV6KpPMhQu7Tbb8R9udmDzoNdWb15z0FQ/Th+gfQl09Gd/Z3gGmK6uKwBtdCNQlS7uX8efEqVtSbpfyzJjFl2avWaXbUjWVDskv9K3q5vo+be53YamFH3NgJ7l2S7LgG8fE6Hdxhs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=JCZLDFjU; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=i5+y/gRp; arc=none smtp.client-ip=202.12.124.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="JCZLDFjU";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="i5+y/gRp"
Received: from phl-compute-10.internal (phl-compute-10.phl.internal [10.202.2.50])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 04E20254014C;
	Mon, 25 Nov 2024 04:57:22 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-10.internal (MEProxy); Mon, 25 Nov 2024 04:57:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1732528642;
	 x=1732615042; bh=S0rvq/K4UAETS3qevBluUlmDz+sU8DtEOfNrCyoALhE=; b=
	JCZLDFjUGZpBJbLRuTuQob1VureEi3A3TbBI/AVg0T3O9g3SxblREr8hKm2JUKs3
	ptMupWtvl71RocpijMlA+Mzdng+mzdKm1tImxGSEG74KnPbqyoKsH6P5MmIL7Ote
	OPXogzoprSXfoyFcCZKhp+XEtcDuIjSTuaTZBwFhFyNEgSfF4KznF4AxTfNa/OdE
	AaZF7kSjhIZU+ya5edBz0b9FagpTJg65Et0V+Z1BiDM0AnN3PNUkqxDzGRKZSSCT
	4k14psTRsbfIXVCupt+2mUCe5muItYc9XEKPYr5tEPm4r+Y1E+VSAngAmU30qaVy
	7fkwByMQR0EF6Z1owzPDNQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1732528642; x=
	1732615042; bh=S0rvq/K4UAETS3qevBluUlmDz+sU8DtEOfNrCyoALhE=; b=i
	5+y/gRp0/tiPTBMB6mI0pvC2DhAA6R4aG/b1ke0PjmUJo/7mjpqzKy0l+UMS1I/W
	iTkAKgD993+AHRiXcAW7/BdIzKvPDsVi1+ByvAbFZH3sRh+y5Aqzx8gjWNtXzt/P
	z9fDH9ode7UwCyAcZIboxbhwBIYg0pN4O1af1UcK3wo7j+RyR8U1iNDCvtNM609J
	7O1VHTmPWrykjl7OLw5sMeTd2suZ4ycxV9L4KblTzklqHbmxH+C2tvozWsylBj9x
	HutiQ1/tNZDouJh1VYMq/npIkD9k/WZ1uREeQJTmZXwtU5/NJLeeogMpQFK2FyTj
	8oG23oYHczUmJ3YWFzPOg==
X-ME-Sender: <xms:AkpEZxuBpeLUsJYERL8e3F2lg1VaYsNpecbyJyhJJyv2rsoq5Fcbvg>
    <xme:AkpEZ6dWUOk81GrdrcMGxYKFtmvTgMuG0yKgWRbY9WpSQDqbqpnVCCQ09UjUIEgx9
    UUMAZB4gUptS-TOyg>
X-ME-Received: <xmr:AkpEZ0xHYzAZGf_2YsJ4XzWEt6pnkV03cB3KUuhvfyvvR4Ayf_HfVYvGES2bSR-HofSpZVeyt8iJfswNZRdzd-sZDL5uhLXdC-BKCOAwxIXGcQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrgeehgddtlecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
    hsucdlqddutddtmdenucfjughrpefhfffugggtgffkfhgjvfevofesthejredtredtjeen
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepffeuiedujedvkeehuedvkeefffeivdeuleetkeduheej
    teekgedvudfgtdfgieelnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepuddupdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopegurghvvhhiugesghhmrghilhdrtghomhdprhgtph
    htthhopehmvgesthhtrgihlhhorhhrrdgtohhmpdhrtghpthhtoheptghhrhhishgtohho
    lhesthhugihfrghmihhlhidrohhrghdprhgtphhtthhopehphhhilhhlihhprdifohhoug
    duvdefsehgmhgrihhlrdgtohhmpdhrtghpthhtohepphgvfhhfsehpvghffhdrnhgvthdp
    rhgtphhtthhopehjiehtsehkuggsghdrohhrghdprhgtphhtthhopehrrghmshgrhiesrh
    grmhhsrgihjhhonhgvshdrphhluhhsrdgtohhmpdhrtghpthhtohepshhunhhshhhinhgv
    sehsuhhnshhhihhnvggtohdrtghomhdprhgtphhtthhopegvshgthhifrghrthiisehgvg
    hnthhoohdrohhrgh
X-ME-Proxy: <xmx:AkpEZ4MPR7MOGfxGAMC_WIphiHJm-2QA40vy5A1RBxnEpJLQWGOjUg>
    <xmx:AkpEZx8ROVBSO80Zc2JfLkFQKctvSJ0cGq13sRzEBnYO9hHj3ABeBQ>
    <xmx:AkpEZ4XAKJlYKWPPqnJ6DM12T6nYivLGvdfj9W72KTbQzPdKNhaQdQ>
    <xmx:AkpEZycIixaszeZ23ov62pTiBya7-QyZZUVTBk6c1_tVz32sRIgYMg>
    <xmx:AkpEZ4X-s48eYnYEFJ6J6PoMWXG_-xf16lCnIpHYSmgbAP36JMMCPTmG>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 25 Nov 2024 04:57:20 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 410e037d (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 25 Nov 2024 09:56:15 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Mon, 25 Nov 2024 10:56:59 +0100
Subject: [PATCH v9 11/23] Makefile: extract script to generate gitweb.cgi
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241125-pks-meson-v9-11-1c6cf242a5f1@pks.im>
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
index 0000000000000000000000000000000000000000..ede9038c3352d2155340c7fb1c62c467f8ce96ab
--- /dev/null
+++ b/gitweb/generate-gitweb-cgi.sh
@@ -0,0 +1,47 @@
+#!/bin/sh
+
+set -e
+
+if test $# -ne 4
+then
+	echo >&2 "USAGE: $0 <GITWEB-BUILD-OPTIONS> <GIT-VERSION-FILE> <INPUT> <OUTPUT>"
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

