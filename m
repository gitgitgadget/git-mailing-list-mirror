Received: from fout-a7-smtp.messagingengine.com (fout-a7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 243361BFDEC
	for <git@vger.kernel.org>; Thu, 28 Nov 2024 16:12:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732810358; cv=none; b=acC7spQAULGCS8uNT0/PGeYjSyiRw8xqMk6zdxn0yMiIa7U/pBS+fZoRR+9I9UiB/RrKwD7rgyljk03CL3hx3i0uIyWO7+2feu66HXQ7LJwBhdKCl1in9WjaSzTRIDiIzMq6cowxSXsPiLcAVWhUum6HXdRoiNtJmCK8uC+NUpM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732810358; c=relaxed/simple;
	bh=HWLOGdFQ4wID9E3DOf40SlPtO2Gm0NQHdL3nYFGueXQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=U1jX6zEHzygO4ke0oQuFk8pu2imjyD8/uPRbmOFNHbnGBKVxlRz7Af2HE/IzK3Yv/tw5YXDfSz4GWg/85q0bCv1rqLdNv1iFsYIa58l+2xFPPugVRU9p811Z+jYZRxWFh5RFpYGnCjcU5I3VMkilQw9uC1GTHCXO3/gxMLa8QqI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=V6l8xi3w; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=NA+WbKBJ; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="V6l8xi3w";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="NA+WbKBJ"
Received: from phl-compute-12.internal (phl-compute-12.phl.internal [10.202.2.52])
	by mailfout.phl.internal (Postfix) with ESMTP id 3A8F3138028D;
	Thu, 28 Nov 2024 11:12:36 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-12.internal (MEProxy); Thu, 28 Nov 2024 11:12:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1732810356;
	 x=1732896756; bh=JTzz1O4pLkqoVsNaWwt31oNGmI59lGQke4pzOLwPPeI=; b=
	V6l8xi3wsZFYnUjNL/Cblw3hSmEXMLCZ+fbbRkoROQbmG2usjeGX8CYAt6XKUlQJ
	LegUrgLenVrNeNSHIeGcGdqC2KSOFcJl1M9bPbdvZ8ErIBAKX80/X3I5Pg2JdYWd
	AVhKry+rHvoMtj8hnqNTrldcALvuITB1kMtuVy6DetD2J4/LL2Z5qBPEItdhb2/O
	Ve3irjJnxmnk2vCcll+iuhVY0zTBrm/QVYVeqsc/Ukl7z0kL4KWXM0eg7L+lZIkW
	x7YpGiE6mbxBOMujtUO+epXDrw6B8a5C8jDM43QxSCzLSlEqnirwTouCZ4ox0PPk
	qQL/S+HKRDYI1iJNUqOkSg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1732810356; x=
	1732896756; bh=JTzz1O4pLkqoVsNaWwt31oNGmI59lGQke4pzOLwPPeI=; b=N
	A+WbKBJi/8pPQoQiCkNZpbYiE/JJCIdzM0JNctHD/YX/cTLdOg9jPBNRpFt6KwAL
	ddJBzQUzt8fofF1KvNwiMnDyRa3xxEeel8F3DOibPT3nIKYP6DLS7NGIN2heFVJj
	WSog/a/R9/PrNP4nWI2XWtNvE+OroEz4rw0zR+agWJnZpF267lPUpi8SCZqfyz9t
	u7lef0jYIb8FNsE0j5ulvG41r8BE0GWJyDd6LrjaRqWmIao4m7RT1sO2MimW9Str
	eMhSJwHFr2yup0Mcq5UHSvn04WeSt3b7jPHKJ/7BadD9YOcOaAoKtnrLeHOxvuHv
	foU5yzzu65G+hhAD+EsAg==
X-ME-Sender: <xms:c5ZIZy6Ih2KtOVjwL7Y4pjigJWGleIdmdOc0-5JFVXobn6KkmB01Rg>
    <xme:c5ZIZ75rbG6zAPqfOv-GEJDJSfnAwU6pGCF1kKrsbNwI4BlBVeGX6Qw8eV4ewo3kZ
    m7OVDcWsyC90X4KhQ>
X-ME-Received: <xmr:c5ZIZxfsfnvjvennTrtCGUoORi7Q_NKS1WaK0_U9B2cNb7bMIgebvHHRa2vI59m1dcb3Qc6SlyrDXv56tJpdPxkNMKpmCsErF9laok43G6559A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrhedugdekfecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
    hsucdlqddutddtmdenucfjughrpefhfffugggtgffkfhgjvfevofesthejredtredtjeen
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepffeuiedujedvkeehuedvkeefffeivdeuleetkeduheej
    teekgedvudfgtdfgieelnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepuddupdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopegthhhrihhstghoohhlsehtuhigfhgrmhhilhihrd
    horhhgpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphht
    thhopegurghvvhhiugesghhmrghilhdrtghomhdprhgtphhtthhopehmvgesthhtrgihlh
    horhhrrdgtohhmpdhrtghpthhtohepphgvfhhfsehpvghffhdrnhgvthdprhgtphhtthho
    pehphhhilhhlihhprdifohhougduvdefsehgmhgrihhlrdgtohhmpdhrtghpthhtohepjh
    eitheskhgusghgrdhorhhgpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtgho
    mhdprhgtphhtthhopehsuhhnshhhihhnvgesshhunhhshhhinhgvtghordgtohhm
X-ME-Proxy: <xmx:c5ZIZ_KbPnmOwR_Ft_zf5ZrTK0N9tSJgBsSKY8vOIq7ThhdBvonTPw>
    <xmx:c5ZIZ2KWH7uqeX5IHdHb_JnkcEPvKHZaGTN-jz5jRTpk3DnZZX_dGA>
    <xmx:c5ZIZwywzSwy4bvpkMKIZJLdekCGM1wIGMvQD1PaLxfLd9aepkz3aA>
    <xmx:c5ZIZ6JObAVkpBllohoShswFJsU6ZEhLXnnXRv1b-wBX7qD9uTFM-A>
    <xmx:dJZIZ8zdn395Wii4GUXGuoRffImWefwyeDEBZngmMJw-CkwyQMIUwWe9>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 28 Nov 2024 11:12:34 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id ac73234f (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 28 Nov 2024 16:11:20 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Thu, 28 Nov 2024 17:12:12 +0100
Subject: [PATCH v10 11/23] Makefile: extract script to generate gitweb.cgi
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241128-pks-meson-v10-11-79a3fb0cb3a6@pks.im>
References: <20241128-pks-meson-v10-0-79a3fb0cb3a6@pks.im>
In-Reply-To: <20241128-pks-meson-v10-0-79a3fb0cb3a6@pks.im>
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
2.47.0.366.g5daf58cba8.dirty

