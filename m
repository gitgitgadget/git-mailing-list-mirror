Received: from fout-b4-smtp.messagingengine.com (fout-b4-smtp.messagingengine.com [202.12.124.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB01A1991CD
	for <git@vger.kernel.org>; Mon, 25 Nov 2024 09:57:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732528649; cv=none; b=KoNk418rlMbcrHwvtFpEKb6rxn52gFMocs3SVpCG7rbsT+qVxkm1AAQp/MuIjn6qbeD2SZddpMnxwCN7otp3Uon26aMLZI3WtkWfA0JNkvdA7BlEgnJdB8FaoY2goI13lz80MffxqvU3dFOWN87EPxEnPewJYzi0T+9QLwAv9Hs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732528649; c=relaxed/simple;
	bh=5k6ou6ckjrSnX39/P9fEkCR/Wdb2BIht2KnAMqGxVpw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=b4vlh7Qj27y9ej5ed2HP3CcxJZIvB1ejkPLWxbebfiFyVjmJkSDTVwrromxFm11y8D+Nuy5uFsxwuwnIM2CBcVphCRrzGheZFSs6vR1tmrkG0YLAMTaIIqdUa+qTQ3trbZ/vV3hYWL2Tk4waHh9oewHx3Ur25lXR6msmLJ/c0a0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=jSP/cLBM; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=G1TluG8a; arc=none smtp.client-ip=202.12.124.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="jSP/cLBM";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="G1TluG8a"
Received: from phl-compute-08.internal (phl-compute-08.phl.internal [10.202.2.48])
	by mailfout.stl.internal (Postfix) with ESMTP id B31EF1140135;
	Mon, 25 Nov 2024 04:57:26 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-08.internal (MEProxy); Mon, 25 Nov 2024 04:57:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1732528646;
	 x=1732615046; bh=XpMAjxTKsRTlzMdgVKqNTT+utWc1gFHvG0zpnmc0hUI=; b=
	jSP/cLBM1azsf/oK4d+PCq9lGp0JKTdOUSkx872aWJbcGU+BCPz2baBZi9rPWI9j
	lHRmyATKVrcRYNfa6QWz/YVhUWqfSTDmMdeB8oYAAE25UBUiUjmNHRfZkmllrpGJ
	/G7UYTJiz3lgSh6YY1S2PXaZyO1F3dkcBUohAfpxKuHC3Xj8a+EjsU4ypd2HGLNy
	23eiZ/8LaOwc1PR1HlmmJfYBsBA6zL8BPs+HBO+bNPfFEJG6KcBtH9K0ag9PIw9Y
	FUgscxmjiZaiQeYJ57HE9N8NJe+Td77aJagaVRrJcqLfHp+dxYXz0bnfiismoEfP
	KXZLzRzuWJGkLcYfZJqCiw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1732528646; x=
	1732615046; bh=XpMAjxTKsRTlzMdgVKqNTT+utWc1gFHvG0zpnmc0hUI=; b=G
	1TluG8aHRtNYaVoDYxksrPHWqzt5K55ZAV3Hq4DYYICzl/+uzpsrQlbQV8dYnoMv
	yoCj9BIsCCFj4XK0lBFLHrObUQpT3BuCQrGfDtPugW+VXt5D+7OSDAkTRbXbTNMH
	sABFqUozpmpank/OcGI5yHnWedJmQok/usGXDVcIXHnOkDYTCz9uCimO+72vvxea
	IwcMjYEXeO520Mwn6Bj1ljzSKrRGLbfdOVv2uFc05H2ZZU0FovJnn+39cJv3mQ6c
	0kM37QSuI52SVEHFwRQrviok4FK71+AyfCu+BBV5HSl4oz9KKW1gF7zMyM2M7t94
	hkF3hpoR6uPurttDvBeGw==
X-ME-Sender: <xms:BkpEZ34FinWJVdapAkyH4mL6sG4JN_dZdRU9SFfb1tyHPTNazdz1Ag>
    <xme:BkpEZ86m0ailzfHp0BWKRWvew4Iv6Tw4DEcHlRbONkgE_SUlA0Yr8bxN0uVgtc3is
    LSUXp-DC3unxJKbTw>
X-ME-Received: <xmr:BkpEZ-dxaZ4O3LrpIa-TXrfvSD5ivO98w6kmGdAxCO1oMryGSDp7UnMt8XYrKQwhoCoa-GMlOPftyIsXL2wYLxaM5OVZTLcSqNvQgHL664mJTQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrgeehgddtkecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
    hsucdlqddutddtmdenucfjughrpefhfffugggtgffkfhgjvfevofesthejredtredtjeen
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepffeuiedujedvkeehuedvkeefffeivdeuleetkeduheej
    teekgedvudfgtdfgieelnecuvehluhhsthgvrhfuihiivgepvdenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepuddupdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopehpvghffhesphgvfhhfrdhnvghtpdhrtghpthhtoh
    eprhgrmhhsrgihsehrrghmshgrhihjohhnvghsrdhplhhushdrtghomhdprhgtphhtthho
    pehphhhilhhlihhprdifohhougduvdefsehgmhgrihhlrdgtohhmpdhrtghpthhtohepsh
    hunhhshhhinhgvsehsuhhnshhhihhnvggtohdrtghomhdprhgtphhtthhopegvshgthhif
    rghrthiisehgvghnthhoohdrohhrghdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrh
    hnvghlrdhorhhgpdhrtghpthhtoheptghhrhhishgtohholhesthhugihfrghmihhlhidr
    ohhrghdprhgtphhtthhopegurghvvhhiugesghhmrghilhdrtghomhdprhgtphhtthhope
    hmvgesthhtrgihlhhorhhrrdgtohhm
X-ME-Proxy: <xmx:BkpEZ4J1Eseuo2XMoephX9XQNWyZCw7pnTEPuuK-cSnyCpcsMV1DNw>
    <xmx:BkpEZ7KYiqR8qISrlZgfo831Wunu4Sw8EhaKBH4zVtmHX8j3l7Wp2w>
    <xmx:BkpEZxyMMTXSmuEvQmWQSvKKWCnfVo5MQeZmwgUSWcMIFtMX-Rkx4w>
    <xmx:BkpEZ3JhZw5ikRzBpjXWOAQLDfyKS_98XCIOktx69Z595OdecW4E0g>
    <xmx:BkpEZ9zd8h9FZ9n8DjYqg6K89Gt_gHGzjQLYyhhVCsspcVxz2TzwUi_O>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 25 Nov 2024 04:57:24 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id a55342ae (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 25 Nov 2024 09:56:19 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Mon, 25 Nov 2024 10:57:03 +0100
Subject: [PATCH v9 15/23] Makefile: simplify building of templates
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241125-pks-meson-v9-15-1c6cf242a5f1@pks.im>
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
index 259dc838b73dcda6ab98776fab61788d90754e03..21dc90ef9a83e5d751f251c9eefbdf43c989bf53 100644
--- a/contrib/buildsystems/CMakeLists.txt
+++ b/contrib/buildsystems/CMakeLists.txt
@@ -99,8 +99,8 @@ project(git
 #TODO Enable NLS on windows natively
 
 #macros for parsing the Makefile for sources and scripts
-macro(parse_makefile_for_sources list_var regex)
-	file(STRINGS ${CMAKE_SOURCE_DIR}/Makefile ${list_var} REGEX "^${regex} \\+=(.*)")
+macro(parse_makefile_for_sources list_var makefile regex)
+	file(STRINGS ${makefile} ${list_var} REGEX "^${regex} \\+=(.*)")
 	string(REPLACE "${regex} +=" "" ${list_var} ${${list_var}})
 	string(REPLACE "$(COMPAT_OBJS)" "" ${list_var} ${${list_var}}) #remove "$(COMPAT_OBJS)" This is only for libgit.
 	string(STRIP ${${list_var}} ${list_var}) #remove trailing/leading whitespaces
@@ -662,7 +662,7 @@ include_directories(${CMAKE_BINARY_DIR})
 
 #build
 #libgit
-parse_makefile_for_sources(libgit_SOURCES "LIB_OBJS")
+parse_makefile_for_sources(libgit_SOURCES ${CMAKE_SOURCE_DIR}/Makefile "LIB_OBJS")
 
 list(TRANSFORM libgit_SOURCES PREPEND "${CMAKE_SOURCE_DIR}/")
 list(TRANSFORM compat_SOURCES PREPEND "${CMAKE_SOURCE_DIR}/")
@@ -680,13 +680,13 @@ list(APPEND libgit_SOURCES "${CMAKE_BINARY_DIR}/version-def.h")
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
@@ -757,7 +757,7 @@ elseif(UNIX)
 endif()
 
 #git
-parse_makefile_for_sources(git_SOURCES "BUILTIN_OBJS")
+parse_makefile_for_sources(git_SOURCES ${CMAKE_SOURCE_DIR}/Makefile "BUILTIN_OBJS")
 
 list(TRANSFORM git_SOURCES PREPEND "${CMAKE_SOURCE_DIR}/")
 add_executable(git ${CMAKE_SOURCE_DIR}/git.c ${git_SOURCES})
@@ -905,24 +905,14 @@ file(STRINGS ${CMAKE_SOURCE_DIR}/git-p4.py content NEWLINE_CONSUME)
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
@@ -996,7 +986,7 @@ add_executable(test-fake-ssh ${CMAKE_SOURCE_DIR}/t/helper/test-fake-ssh.c)
 target_link_libraries(test-fake-ssh common-main)
 
 #unit-tests
-parse_makefile_for_sources(unit-test_SOURCES "UNIT_TEST_OBJS")
+parse_makefile_for_sources(unit-test_SOURCES ${CMAKE_SOURCE_DIR}/Makefile "UNIT_TEST_OBJS")
 list(TRANSFORM unit-test_SOURCES REPLACE "\\$\\(UNIT_TEST_DIR\\)/" "${CMAKE_SOURCE_DIR}/t/unit-tests/")
 add_library(unit-test-lib STATIC ${unit-test_SOURCES})
 
@@ -1062,7 +1052,7 @@ if(MSVC)
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
2.47.0.274.g962d0b743d.dirty

