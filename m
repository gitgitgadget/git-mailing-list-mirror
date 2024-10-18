Received: from fhigh-b8-smtp.messagingengine.com (fhigh-b8-smtp.messagingengine.com [202.12.124.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95E941D9686
	for <git@vger.kernel.org>; Fri, 18 Oct 2024 12:24:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729254257; cv=none; b=YqvdMcCymLyq+XEmFrh6kYtjs22ZpxOZ9Rk7Gm3BB59FoBNyep5kh6q9dTTxlmqEjwFXKBRMWha5gOGZ1wjDscCsjxJ1rh0zjlnxxM/E111Z534bByrnT7qMfZNJkNJNGIi8HvFDA/oUKwX2vKjDOFFgsRZlix2zobp1W9JteCA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729254257; c=relaxed/simple;
	bh=Xw+/GFz8NRyKCO2bU7zQEHrM8bCvnPDUcAe70az+4Y4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=g6QUmvlZuihENKA09y6UDvCWIzh3nnwjHgdvNG0k16LHrcoM/CaW29JN1a7TzWKLrvUokrQT0kvn6CKjuzNhDu27NxYlHjGyPSXjysPBrRD0DwYIkzaV6hQszXt66sZnkq4DOqV+4dzRCqYOjuYQcOGeLFI0wXNryaizSWgGg20=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=HQS0c7AO; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=aHffmltZ; arc=none smtp.client-ip=202.12.124.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="HQS0c7AO";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="aHffmltZ"
Received: from phl-compute-08.internal (phl-compute-08.phl.internal [10.202.2.48])
	by mailfhigh.stl.internal (Postfix) with ESMTP id B15C525400BE;
	Fri, 18 Oct 2024 08:24:14 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-08.internal (MEProxy); Fri, 18 Oct 2024 08:24:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1729254254; x=1729340654; bh=uYRA+UhiIZ
	2meGKF3pCaG3C02HgAmJstFAMwj5fAgI4=; b=HQS0c7AOzA4FbS3RS5FuohQgaY
	X3EJ7z/ztBhv8EWI62zlLB/ts0FQTca6BY0LtNXy4khhPihSeRcgSY2BOBOPj8E4
	QLSUK2miXD+CNAfqh4H8Ph2U3fnur/k1drhfmhDBBpURRLaLMyl+4rIkjkGitjaY
	nv//7DS0GJrZtFlerDou0JdEeN+ykGUIWCu1Qi90PLi22QS8HtHyM9VcYKIMimrM
	H5y3oYXW9gxb2fX2qkJyAlYTW0a9EQsssWss7sdLgWi5IJibkn2OGe/HY6gYILOF
	2UB+x6TEKcB9rOvlOd/wAeEd76VOd3sxjxp5pCfvG3Ko+impMsLFrs6lYk9g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1729254254; x=1729340654; bh=uYRA+UhiIZ2meGKF3pCaG3C02HgA
	mJstFAMwj5fAgI4=; b=aHffmltZIB4iUKPbrXv0Mv9YOFgfv/+rmibozNS+u/EU
	FHl1qUvURTBEFwsps6mGA13q0MLvFtC4i1eCxbQDGqq/A/1fDZApVSWOCpjOEpLI
	6Rtg+PVvufDW32I0ttADsNLsMzqGTz2a762p527BgrJrP9tUmgDij0z3IQNZeJfl
	OhsFPZgTO/XusFnqJllHFnycvLYi9Ny8Lj17st1afzNFt2GDc+nt1tJlhYPYRMmy
	t+GEIyUttZhGBW8mMHXb8hyvzlrAwZNIg/2FjnqUL7nX4zjQHb8Lqg+MD5kI/RlX
	2ORtHDgNO1Rty+eZ3j5BOVjBZenjS7W7ciAO10D1Tg==
X-ME-Sender: <xms:blMSZ--ZHZ45fzBCVkVB1P1HZ4ncn-6eVq1KZBOtYOLkz9jm6eDXQg>
    <xme:blMSZ-tgMV1Ygq9jBcXunxReUFtAGZfZ02P4pIUSrp3MidWxoyN6w0Fclju_DcGt7
    zFRe4fSFb4yHf1wkg>
X-ME-Received: <xmr:blMSZ0C-HSVxfMt1tFOFEdT4YzFquZAYTEWmUoXJG8NmO5RZiXmVlMJGkjPevr2Upv48eWeWPL1jzXNrt6pEH715HaebSe9PjHS57kA5SKxk>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdehfedggeelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefgueeg
    udfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepiedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtoheprhgrmhhsrgihsehrrghmshgrhihjohhnvghsrdhplh
    hushdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhr
    tghpthhtohepphhhihhllhhiphdrfihoohguuddvfeesghhmrghilhdrtghomhdprhgtph
    htthhopegvshgthhifrghrthiisehgvghnthhoohdrohhrghdprhgtphhtthhopehsuhhn
    shhhihhnvgesshhunhhshhhinhgvtghordgtohhmpdhrtghpthhtohepghhithhsthgvrh
    esphhosghogidrtghomh
X-ME-Proxy: <xmx:blMSZ2fteq4l-PF5-LeuxKiYAUcqH0RS5wHpIBaakuxpUmQpJAVMdw>
    <xmx:blMSZzNj2SQne8WCCx_pZagAR5XFYnivIF6zkrMumVu7vwYi41mRkw>
    <xmx:blMSZwmrmS1gWHLjxjfvJxa6wQ-B_JLRjrwkQh95Q9LQCF0P75wFcg>
    <xmx:blMSZ1t6AWd3AKCwrQIiVAlUyOPuAwa07FLG19piV1jSM_J1eL9ARA>
    <xmx:blMSZ_BYcWwjN65tnnsXFFY7HRVEuhZIO308gpQFwyY7ObyTMdjYtLe5>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 18 Oct 2024 08:24:13 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 67b76630 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 18 Oct 2024 12:22:51 +0000 (UTC)
Date: Fri, 18 Oct 2024 14:24:12 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Eli Schwartz <eschwartz@gentoo.org>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Phillip Wood <phillip.wood123@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Ramsay Jones <ramsay@ramsayjones.plus.com>
Subject: [RFC PATCH v3 07/15] Makefile: extract script to generate gitweb.cgi
Message-ID: <ebffd855836f1ba00ae8819a48bad7b9ce4141b2.1729254070.git.ps@pks.im>
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
2.47.0.72.gef8ce8f3d4.dirty

