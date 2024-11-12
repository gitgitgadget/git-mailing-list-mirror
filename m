Received: from fhigh-b2-smtp.messagingengine.com (fhigh-b2-smtp.messagingengine.com [202.12.124.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0243C214411
	for <git@vger.kernel.org>; Tue, 12 Nov 2024 17:03:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731431023; cv=none; b=NLv7k0tFJTTG23Oxbc4QS4lIOmyqfPWMXR+7Fn7vbSGcrQ5tXebLUYJaL/RP9ov700knoi93M1pwo8qzz58IF0c+RJxU929K/kkRoEO9T4P8cGwT4N+blH2uRNFp5zE5/NkFhqVXdBPT/WitfhjXSwSbXu5Pfho8ADFrVE8pRD4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731431023; c=relaxed/simple;
	bh=i5S2JIDAIg4kOuTNP/8W/TAjIwuYuFbHdIaTZId9MC0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=nP93UZRZgdNtrhKj8cbYcVr0y7rGTg09QYWurmoMQbNPktdfaaRJuR+aqNpA5ibkQtwtuhziQNFghz5WVpCYZi01Tb2aBDc2k0B2wqsNCy+XU7CxQYkWFxeXQj/H75PaNfB8KmwHN0oH/v/SHfER42hJmoUWD01g/GkShn+kFcc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=OoVPLwQ8; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=aQBEg44d; arc=none smtp.client-ip=202.12.124.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="OoVPLwQ8";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="aQBEg44d"
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfhigh.stl.internal (Postfix) with ESMTP id EC483254015F;
	Tue, 12 Nov 2024 12:03:39 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Tue, 12 Nov 2024 12:03:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1731431019;
	 x=1731517419; bh=wgJU1hQSAZMtOBe5l7rmB1tJLPkT0xhcZ+1WklJCIdg=; b=
	OoVPLwQ8H5UzcgOMBYavAaDvjw7uA4N5u1PdceCDNpr4wlFMY1ESFIEjQhOfW3VC
	+GYNn6VMTMiE5V7CZeb28JqzpyrHjLZMo+kSrIQKg7A6UdebMz53+tyYZXo3KA6f
	tZjnyX1d10C4rHa+JUzq7y0t+a6aoXTvrEmadt/eihOk5foEsZuaIq1RseM/cHAC
	Vss6a85kz0ziZl0/aWp6+L4oegVXPrBfgW37Zjntytd3XoQV8nBykHsZMHl2qTm8
	iqAQHc9nAzIqCOxZd55sxV0zI3Rx4Q1TafKKf7uNn9zmIqo2finGGTz3+coYlK6R
	urjXPv9uyEIrHUXZgJ00JQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1731431019; x=
	1731517419; bh=wgJU1hQSAZMtOBe5l7rmB1tJLPkT0xhcZ+1WklJCIdg=; b=a
	QBEg44dqPZsl4I4SOoQFXUFU/ah95wAzmCzbehEyLAhHak1NiEXirFOZuf+Z9ijI
	o7dsWX26yx+arul/gqonZsQ1ZhWft033hBchwaXiUAd2aFa7gft2MBEaBaHMeVBU
	3RUSzcLow06PvwSacuh8yzy3y5Tbfjr0F8K81j++bIzOZWjgFRFGCc2y0YuD3HkQ
	zmPvXO9vMPwHm6RtrjZzJNh72Uke49eHh7RtMFDCfOodse6CTQ/WTTHjA4bzoOFL
	hA39R6iGZniPniQWCX+XaXmveXr1LpKtl7uBJd3eD0E6JsffQO0wbhLVPJeNEYvu
	vXyicvFcv9V0TBignae0Q==
X-ME-Sender: <xms:a4ozZzBrtbExj0nt6bMkMmr8zHTRbRFKlQ7a3GgQQ2tVEiMueA7o4g>
    <xme:a4ozZ5jfwWDXWyRIyCiOX28I5_5eJAfBlTayMhEr5ccjjAHK907ZrE26PkYc4l-RB
    REh6P0CxBI6fflTGQ>
X-ME-Received: <xmr:a4ozZ-kb70jjC9LRxUVimQYOWqXuuXe4vlSpjaqCZRGE2gIwoXECH1ZyfIQ4Iv_hUFVNv0rnM9k7sG0IazbwBfgH9Jnwz14c0W-9sW-cGpCyC0A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudeggdelvdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
    hsucdlqddutddtmdenucfjughrpefhfffugggtgffkfhgjvfevofesthejredtredtjeen
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepffeuiedujedvkeehuedvkeefffeivdeuleetkeduheej
    teekgedvudfgtdfgieelnecuvehluhhsthgvrhfuihiivgepfeenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepledpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepmhgvsehtthgrhihlohhrrhdrtghomhdprhgtphhtth
    hopehrrghmshgrhiesrhgrmhhsrgihjhhonhgvshdrphhluhhsrdgtohhmpdhrtghpthht
    ohepshhunhhshhhinhgvsehsuhhnshhhihhnvggtohdrtghomhdprhgtphhtthhopegvsh
    gthhifrghrthiisehgvghnthhoohdrohhrghdprhgtphhtthhopehpvghffhesphgvfhhf
    rdhnvghtpdhrtghpthhtohepuggrvhhvihgusehgmhgrihhlrdgtohhmpdhrtghpthhtoh
    epphhhihhllhhiphdrfihoohguuddvfeesghhmrghilhdrtghomhdprhgtphhtthhopehg
    ihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepghhithhsthgvrhesph
    hosghogidrtghomh
X-ME-Proxy: <xmx:a4ozZ1ykke7jBdEzIbBeF9RAPdTrsJiIDAjGJD5EHO2D4a6LtPC2Ig>
    <xmx:a4ozZ4RnwfZpq0bxcwDd5KwlxI-3UEjOUNXTGtgzsRMfErdl6JPvRw>
    <xmx:a4ozZ4ZH8DmM7kbLMBxt-cI5uFN3TydMRUxWwlRBiz4q8kyAK0udDw>
    <xmx:a4ozZ5RptiFXL3tXpS71ogrVtgHDzWQ-RT0VPWRnORJRAmZPHEF4SA>
    <xmx:a4ozZx-UCM0xkMquJyc0lrdujGhAvkIzbhpyqpEyhgtN_opzmFifX_SL>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 12 Nov 2024 12:03:38 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 4f4ecc73 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 12 Nov 2024 17:02:59 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Tue, 12 Nov 2024 18:02:54 +0100
Subject: [PATCH RFC v6 11/19] Makefile: simplify building of templates
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241112-pks-meson-v6-11-648b30996827@pks.im>
References: <20241112-pks-meson-v6-0-648b30996827@pks.im>
In-Reply-To: <20241112-pks-meson-v6-0-648b30996827@pks.im>
To: git@vger.kernel.org
Cc: Eli Schwartz <eschwartz@gentoo.org>, 
 Eric Sunshine <sunshine@sunshineco.com>, 
 Phillip Wood <phillip.wood123@gmail.com>, 
 Junio C Hamano <gitster@pobox.com>, 
 Ramsay Jones <ramsay@ramsayjones.plus.com>, Taylor Blau <me@ttaylorr.com>, 
 David Aguilar <davvid@gmail.com>, Jeff King <peff@peff.net>
X-Mailer: b4 0.14.2

When we install Git we also install a set of default templates that both
git-init(1) and git-clone(1) populate into our build directories. The
way the pristine templates are laid out in our source directory is
somewhat weird though: instead of reconstructing the actual directory
hierarchy in "templates/", we represent directory separators with "--".

The only reason I could come up with for why we have this is the
"branches/" directory, which is supposed to be empty when installing it.
And as Git famously doesn't store empty directories at all we have to
work around this limitation.

Now the thing is that the "branches/" directory is a leftover to how
branches used to be stored in the dark ages. gitrepository-layout(5)
lists this directory as "slightly deprecated", which I would claim is a
strong understatement. I have never encountered anybody using it today
and would be surprised if it even works as expected. So having the "--"
hack in place for an item that is basically unused, unmaintained and
deprecated doesn't only feel unreasonable, but installing that entry by
default may also cause confusion for users that do not know what this is
supposed to be in the first place.

Remove this directory from our templates and, now that we do not require
the workaround anymore, restructure the templates to form a proper
hierarchy. This makes it way easier for build systems to install these
templates into place.

We should likely think about removing support for "branch/" altogether,
but that is outside of the scope of this patch series.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 contrib/buildsystems/CMakeLists.txt                | 34 +++++++------------
 templates/Makefile                                 | 39 ++++++++++++++--------
 templates/branches--                               |  1 -
 templates/{this--description => description}       |  0
 .../applypatch-msg.sample}                         |  0
 .../commit-msg.sample}                             |  0
 .../fsmonitor-watchman.sample}                     |  0
 .../post-update.sample}                            |  0
 .../pre-applypatch.sample}                         |  0
 .../pre-commit.sample}                             |  0
 .../pre-merge-commit.sample}                       |  0
 .../pre-push.sample}                               |  0
 .../pre-rebase.sample}                             |  0
 .../pre-receive.sample}                            |  0
 .../prepare-commit-msg.sample}                     |  0
 .../push-to-checkout.sample}                       |  0
 .../sendemail-validate.sample}                     |  0
 .../{hooks--update.sample => hooks/update.sample}  |  0
 templates/{info--exclude => info/exclude}          |  0
 19 files changed, 37 insertions(+), 37 deletions(-)

diff --git a/contrib/buildsystems/CMakeLists.txt b/contrib/buildsystems/CMakeLists.txt
index 4f652927b1f3a2906bc5cfd0f7ba44a025770883..f63661c6b5d9f51778a0e08fab7032bea5010e6f 100644
--- a/contrib/buildsystems/CMakeLists.txt
+++ b/contrib/buildsystems/CMakeLists.txt
@@ -106,8 +106,8 @@ project(git
 #TODO Enable NLS on windows natively
 
 #macros for parsing the Makefile for sources and scripts
-macro(parse_makefile_for_sources list_var regex)
-	file(STRINGS ${CMAKE_SOURCE_DIR}/Makefile ${list_var} REGEX "^${regex} \\+=(.*)")
+macro(parse_makefile_for_sources list_var makefile regex)
+	file(STRINGS ${makefile} ${list_var} REGEX "^${regex} \\+=(.*)")
 	string(REPLACE "${regex} +=" "" ${list_var} ${${list_var}})
 	string(REPLACE "$(COMPAT_OBJS)" "" ${list_var} ${${list_var}}) #remove "$(COMPAT_OBJS)" This is only for libgit.
 	string(STRIP ${${list_var}} ${list_var}) #remove trailing/leading whitespaces
@@ -672,20 +672,20 @@ include_directories(${CMAKE_BINARY_DIR})
 
 #build
 #libgit
-parse_makefile_for_sources(libgit_SOURCES "LIB_OBJS")
+parse_makefile_for_sources(libgit_SOURCES ${CMAKE_SOURCE_DIR}/Makefile "LIB_OBJS")
 
 list(TRANSFORM libgit_SOURCES PREPEND "${CMAKE_SOURCE_DIR}/")
 list(TRANSFORM compat_SOURCES PREPEND "${CMAKE_SOURCE_DIR}/")
 add_library(libgit ${libgit_SOURCES} ${compat_SOURCES})
 
 #libxdiff
-parse_makefile_for_sources(libxdiff_SOURCES "XDIFF_OBJS")
+parse_makefile_for_sources(libxdiff_SOURCES ${CMAKE_SOURCE_DIR}/Makefile "XDIFF_OBJS")
 
 list(TRANSFORM libxdiff_SOURCES PREPEND "${CMAKE_SOURCE_DIR}/")
 add_library(xdiff STATIC ${libxdiff_SOURCES})
 
 #reftable
-parse_makefile_for_sources(reftable_SOURCES "REFTABLE_OBJS")
+parse_makefile_for_sources(reftable_SOURCES ${CMAKE_SOURCE_DIR}/Makefile "REFTABLE_OBJS")
 
 list(TRANSFORM reftable_SOURCES PREPEND "${CMAKE_SOURCE_DIR}/")
 add_library(reftable STATIC ${reftable_SOURCES})
@@ -749,7 +749,7 @@ elseif(UNIX)
 endif()
 
 #git
-parse_makefile_for_sources(git_SOURCES "BUILTIN_OBJS")
+parse_makefile_for_sources(git_SOURCES ${CMAKE_SOURCE_DIR}/Makefile "BUILTIN_OBJS")
 
 list(TRANSFORM git_SOURCES PREPEND "${CMAKE_SOURCE_DIR}/")
 add_executable(git ${CMAKE_SOURCE_DIR}/git.c ${git_SOURCES})
@@ -886,24 +886,14 @@ file(STRINGS ${CMAKE_SOURCE_DIR}/git-p4.py content NEWLINE_CONSUME)
 string(REPLACE "#!/usr/bin/env python" "#!/usr/bin/python" content "${content}")
 file(WRITE ${CMAKE_BINARY_DIR}/git-p4 ${content})
 
-#templates
-file(GLOB templates "${CMAKE_SOURCE_DIR}/templates/*")
-list(TRANSFORM templates REPLACE "${CMAKE_SOURCE_DIR}/templates/" "")
-list(REMOVE_ITEM templates ".gitignore")
-list(REMOVE_ITEM templates "Makefile")
-list(REMOVE_ITEM templates "blt")# Prevents an error when reconfiguring for in source builds
-
-list(REMOVE_ITEM templates "branches--")
-file(MAKE_DIRECTORY ${CMAKE_BINARY_DIR}/templates/blt/branches) #create branches
-
+#${CMAKE_SOURCE_DIR}/Makefile templates
+parse_makefile_for_sources(templates ${CMAKE_SOURCE_DIR}/templates/Makefile "TEMPLATES")
+string(REPLACE " " ";" templates ${templates})
 #templates have @.*@ replacement so use configure_file instead
 foreach(tm ${templates})
-	string(REPLACE "--" "/" blt_tm ${tm})
-	string(REPLACE "this" "" blt_tm ${blt_tm})# for this--
-	configure_file(${CMAKE_SOURCE_DIR}/templates/${tm} ${CMAKE_BINARY_DIR}/templates/blt/${blt_tm} @ONLY)
+	configure_file(${CMAKE_SOURCE_DIR}/templates/${tm} ${CMAKE_BINARY_DIR}/templates/blt/${tm} @ONLY)
 endforeach()
 
-
 #translations
 if(MSGFMT_EXE)
 	file(GLOB po_files "${CMAKE_SOURCE_DIR}/po/*.po")
@@ -977,7 +967,7 @@ add_executable(test-fake-ssh ${CMAKE_SOURCE_DIR}/t/helper/test-fake-ssh.c)
 target_link_libraries(test-fake-ssh common-main)
 
 #unit-tests
-parse_makefile_for_sources(unit-test_SOURCES "UNIT_TEST_OBJS")
+parse_makefile_for_sources(unit-test_SOURCES ${CMAKE_SOURCE_DIR}/Makefile "UNIT_TEST_OBJS")
 list(TRANSFORM unit-test_SOURCES REPLACE "\\$\\(UNIT_TEST_DIR\\)/" "${CMAKE_SOURCE_DIR}/t/unit-tests/")
 add_library(unit-test-lib STATIC ${unit-test_SOURCES})
 
@@ -1035,7 +1025,7 @@ if(MSVC)
 endif()
 
 #test-tool
-parse_makefile_for_sources(test-tool_SOURCES "TEST_BUILTINS_OBJS")
+parse_makefile_for_sources(test-tool_SOURCES ${CMAKE_SOURCE_DIR}/Makefile "TEST_BUILTINS_OBJS")
 add_library(test-lib OBJECT ${CMAKE_SOURCE_DIR}/t/unit-tests/test-lib.c)
 
 list(TRANSFORM test-tool_SOURCES PREPEND "${CMAKE_SOURCE_DIR}/t/helper/")
diff --git a/templates/Makefile b/templates/Makefile
index 367ad00c24cb34c0668eb5236dc3b08a477a65b7..bd1e9e30c120032b209fb1d221b9d93eea31c649 100644
--- a/templates/Makefile
+++ b/templates/Makefile
@@ -29,24 +29,35 @@ all: boilerplates.made custom
 # in a file direc--tory--file in the source.  They will be
 # just copied to the destination.
 
-bpsrc = $(filter-out %~,$(wildcard *--*))
-boilerplates.made : $(bpsrc)
-	$(QUIET)umask 022 && ls *--* 2>/dev/null | \
-	while read boilerplate; \
+TEMPLATES  =
+TEMPLATES += description
+TEMPLATES += hooks/applypatch-msg.sample
+TEMPLATES += hooks/commit-msg.sample
+TEMPLATES += hooks/fsmonitor-watchman.sample
+TEMPLATES += hooks/post-update.sample
+TEMPLATES += hooks/pre-applypatch.sample
+TEMPLATES += hooks/pre-commit.sample
+TEMPLATES += hooks/pre-merge-commit.sample
+TEMPLATES += hooks/prepare-commit-msg.sample
+TEMPLATES += hooks/pre-push.sample
+TEMPLATES += hooks/pre-rebase.sample
+TEMPLATES += hooks/pre-receive.sample
+TEMPLATES += hooks/push-to-checkout.sample
+TEMPLATES += hooks/sendemail-validate.sample
+TEMPLATES += hooks/update.sample
+TEMPLATES += info/exclude
+
+boilerplates.made: $(TEMPLATES)
+	$(QUIET)umask 022 && for template in $(TEMPLATES); \
 	do \
-		case "$$boilerplate" in *~) continue ;; esac && \
-		dst=`echo "$$boilerplate" | sed -e 's|^this|.|;s|--|/|g'` && \
-		dir=`expr "$$dst" : '\(.*\)/'` && \
+		dir=$$(dirname "$$template") && \
 		mkdir -p blt/$$dir && \
-		case "$$boilerplate" in \
-		*--) continue;; \
-		esac && \
 		sed -e '1s|#!.*/sh|#!$(SHELL_PATH_SQ)|' \
 		    -e 's|@SHELL_PATH@|$(SHELL_PATH_SQ)|' \
-		    -e 's|@PERL_PATH@|$(PERL_PATH_SQ)|g' $$boilerplate > \
-			blt/$$dst && \
-		if test -x "$$boilerplate"; then rx=rx; else rx=r; fi && \
-		chmod a+$$rx "blt/$$dst" || exit; \
+		    -e 's|@PERL_PATH@|$(PERL_PATH_SQ)|g' $$template > \
+			blt/$$template && \
+		if test -x "$$template"; then rx=rx; else rx=r; fi && \
+		chmod a+$$rx "blt/$$template" || exit; \
 	done && \
 	date >$@
 
diff --git a/templates/branches-- b/templates/branches--
deleted file mode 100644
index fae88709a636f3a06cc813dd64b28bfee7fa2073..0000000000000000000000000000000000000000
--- a/templates/branches--
+++ /dev/null
@@ -1 +0,0 @@
-: this is just to ensure the directory exists.
diff --git a/templates/this--description b/templates/description
similarity index 100%
rename from templates/this--description
rename to templates/description
diff --git a/templates/hooks--applypatch-msg.sample b/templates/hooks/applypatch-msg.sample
similarity index 100%
rename from templates/hooks--applypatch-msg.sample
rename to templates/hooks/applypatch-msg.sample
diff --git a/templates/hooks--commit-msg.sample b/templates/hooks/commit-msg.sample
similarity index 100%
rename from templates/hooks--commit-msg.sample
rename to templates/hooks/commit-msg.sample
diff --git a/templates/hooks--fsmonitor-watchman.sample b/templates/hooks/fsmonitor-watchman.sample
similarity index 100%
rename from templates/hooks--fsmonitor-watchman.sample
rename to templates/hooks/fsmonitor-watchman.sample
diff --git a/templates/hooks--post-update.sample b/templates/hooks/post-update.sample
similarity index 100%
rename from templates/hooks--post-update.sample
rename to templates/hooks/post-update.sample
diff --git a/templates/hooks--pre-applypatch.sample b/templates/hooks/pre-applypatch.sample
similarity index 100%
rename from templates/hooks--pre-applypatch.sample
rename to templates/hooks/pre-applypatch.sample
diff --git a/templates/hooks--pre-commit.sample b/templates/hooks/pre-commit.sample
similarity index 100%
rename from templates/hooks--pre-commit.sample
rename to templates/hooks/pre-commit.sample
diff --git a/templates/hooks--pre-merge-commit.sample b/templates/hooks/pre-merge-commit.sample
similarity index 100%
rename from templates/hooks--pre-merge-commit.sample
rename to templates/hooks/pre-merge-commit.sample
diff --git a/templates/hooks--pre-push.sample b/templates/hooks/pre-push.sample
similarity index 100%
rename from templates/hooks--pre-push.sample
rename to templates/hooks/pre-push.sample
diff --git a/templates/hooks--pre-rebase.sample b/templates/hooks/pre-rebase.sample
similarity index 100%
rename from templates/hooks--pre-rebase.sample
rename to templates/hooks/pre-rebase.sample
diff --git a/templates/hooks--pre-receive.sample b/templates/hooks/pre-receive.sample
similarity index 100%
rename from templates/hooks--pre-receive.sample
rename to templates/hooks/pre-receive.sample
diff --git a/templates/hooks--prepare-commit-msg.sample b/templates/hooks/prepare-commit-msg.sample
similarity index 100%
rename from templates/hooks--prepare-commit-msg.sample
rename to templates/hooks/prepare-commit-msg.sample
diff --git a/templates/hooks--push-to-checkout.sample b/templates/hooks/push-to-checkout.sample
similarity index 100%
rename from templates/hooks--push-to-checkout.sample
rename to templates/hooks/push-to-checkout.sample
diff --git a/templates/hooks--sendemail-validate.sample b/templates/hooks/sendemail-validate.sample
similarity index 100%
rename from templates/hooks--sendemail-validate.sample
rename to templates/hooks/sendemail-validate.sample
diff --git a/templates/hooks--update.sample b/templates/hooks/update.sample
similarity index 100%
rename from templates/hooks--update.sample
rename to templates/hooks/update.sample
diff --git a/templates/info--exclude b/templates/info/exclude
similarity index 100%
rename from templates/info--exclude
rename to templates/info/exclude

-- 
2.47.0.251.gb31fb630c0.dirty

