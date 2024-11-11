Received: from fout-a3-smtp.messagingengine.com (fout-a3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A99A1A0715
	for <git@vger.kernel.org>; Mon, 11 Nov 2024 15:31:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731339077; cv=none; b=tOhsWP/MJPYUVWlvUBITZqeo95b+m+RDMm1QphYysstDN9ZJgSBYYaDApXvsXG0nWF5raxluh7stIgG3efAEcZnCUIh7PwQCfq/aqqjH7IUg+BCa/287Cqf66rCPyuEE0gepAPsXsxG2rppzayU0o7FjLdA5DhGDW94vqa1iaWA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731339077; c=relaxed/simple;
	bh=Z8r/g5nozhpNq7c75mdqkP2PcAug+hCbETHoxIttsDA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hkEZ/n3uL3gakvmulcGyrWH+O/kKhmjiqNOABKyuDKdJlx0ehtjprvvEtNvuuJH2CakpwXJl+WLnQzIUZuekIsEug+VDkCwykyF03Y6m8YEK8MIFDatzvgsAhhh2zleRuU0DA/N1QajLwLMhC6Bt6/Gv/2hpzW+Yx0R0YJ3alos=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=Q21f93HS; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=EMRP5KdX; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Q21f93HS";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="EMRP5KdX"
Received: from phl-compute-08.internal (phl-compute-08.phl.internal [10.202.2.48])
	by mailfout.phl.internal (Postfix) with ESMTP id 4451513805EE;
	Mon, 11 Nov 2024 10:31:14 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-08.internal (MEProxy); Mon, 11 Nov 2024 10:31:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1731339074; x=1731425474; bh=CRykph2rkA
	pYug2DRM6escJnalLyHSgbt1xuJ39R/fw=; b=Q21f93HSYbtRSq8ArayM5Vs5Jk
	xgHXL1BwLB34Wu4jKiTJYykOIBQTCXHZG5ZOVZWOCwEwdI3lIOFWn6trTmBqvKEF
	Vhzl6ROqAuaowYRJn4Vqr6dT/UipTFukO2h15FQ01BsdzCSx0FRbhTMN+fn11fGA
	5Y06iGvSz1ICNt/Y7dKUpJ6f6gIWOYvs3iPBxgNry/4O4PQGQjMfdlLU6RW6aiK5
	nBYU6w04qmm6hjSJC0h3DPGratLdtSP2ePNkn1tAgRTeVRJjsZE2APMUBFbe4ELH
	dXY0ZuuaExo2XK4J3EEAD6NRR60Mq3Ht53KLDivFSAgkzLOKWoymrBxo99rg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1731339074; x=1731425474; bh=CRykph2rkApYug2DRM6escJnalLyHSgbt1x
	uJ39R/fw=; b=EMRP5KdX1yjsJ6xt9W+3oE7DijkmaF6GCpzkFBRPLeMtv4DWYov
	sfCvymkF+4DC5QvqMb6hhTwxXknUthuGf2CEK/LnGUBOt9wHwxzSL4zaqbpRUmX3
	IZejKPn5Ze+lMtQLUaNpfhb7nHCDjHXwBaXNBcpYxr5vZ8QWl4ImMFywe7SRvwJZ
	ZAtXu05sg7cwz74Kk2zc3Pia4V9ox3EkgCrZFngItCNX21sf6VEHtYfas+/BakF1
	4jH9YOeA42tKk1zF79xB4XZALxy25mnoDBhGYkkn1Y0GA+TTlna19XrP6Ca84h8y
	60ygfkqQa6fWqJA1/pRzOEkNwI9Hr6Ue6FA==
X-ME-Sender: <xms:QiMyZ6NKmwl-F0OQaYfbxxGmvEmyVP1xsYtgqpxKiyk4bxsOSxJ5hQ>
    <xme:QiMyZ49VZwx82Zi9B7YSY-dhpUSkBYKv2-TsoJXQDH98CGLnlTI49Xv48Yfbyy28U
    GVphOrVKljtzY6vFw>
X-ME-Received: <xmr:QiMyZxRAEvg14TJm96N35Y24IBMNrsaiifr3XFAhcSwkgbRNRmy0iMXjmBI56-1aEb-Q8VJ1RoF8IQ-6Vr6lMJZmUWENx0KZAYmjTqYP4igtnVBP>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddruddvgdejjecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
    hsucdlqddutddtmdenucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecu
    hfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqe
    enucggtffrrghtthgvrhhnpeevkeekfffhiedtleduiefgjedttedvledvudehgfeugedu
    gffhueekhfejvdektdenucevlhhushhtvghrufhiiigvpedunecurfgrrhgrmhepmhgrih
    hlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeekpdhmohguvgepshhm
    thhpohhuthdprhgtphhtthhopegvshgthhifrghrthiisehgvghnthhoohdrohhrghdprh
    gtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepmhgv
    sehtthgrhihlohhrrhdrtghomhdprhgtphhtthhopehphhhilhhlihhprdifohhougduvd
    efsehgmhgrihhlrdgtohhmpdhrtghpthhtoheprhgrmhhsrgihsehrrghmshgrhihjohhn
    vghsrdhplhhushdrtghomhdprhgtphhtthhopehsuhhnshhhihhnvgesshhunhhshhhinh
    gvtghordgtohhmpdhrtghpthhtohepuggrvhhvihgusehgmhgrihhlrdgtohhmpdhrtghp
    thhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:QiMyZ6usqrQ_Gad5egCEfBcmiD706niulEVQLbEM73QRGdjfvHjB7w>
    <xmx:QiMyZyfrtPcGIFrQOPtS4YyFC0Q0sNLImsDLPfYsZIscHBEydgSbOg>
    <xmx:QiMyZ-3FJx5MBMOBHbcSV9buv6WrnxxbXynZQc-6G2aW_OopAFPkwA>
    <xmx:QiMyZ2_F2wEhJqCZKkfkE0zlszfl1Nd-yq4Qg1oQ37Rwx3lTp6uF2A>
    <xmx:QiMyZ5xV4eGcBkDDI0Q0I6zdGafpG7CD3ysm-QzldDorMMWUKwcMnYFp>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 11 Nov 2024 10:31:12 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id ec200e48 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 11 Nov 2024 15:30:37 +0000 (UTC)
Date: Mon, 11 Nov 2024 16:31:03 +0100
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Eli Schwartz <eschwartz@gentoo.org>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Phillip Wood <phillip.wood123@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Ramsay Jones <ramsay@ramsayjones.plus.com>,
	Taylor Blau <me@ttaylorr.com>, David Aguilar <davvid@gmail.com>
Subject: [RFC PATCH v5 11/19] Makefile: simplify building of templates
Message-ID: <a193157a2d8a44d593ef225575091ea30b296f58.1731335939.git.ps@pks.im>
References: <cover.1727881164.git.ps@pks.im>
 <cover.1731335938.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1731335938.git.ps@pks.im>

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
 contrib/buildsystems/CMakeLists.txt           | 34 ++++++----------
 templates/Makefile                            | 39 ++++++++++++-------
 templates/branches--                          |  1 -
 templates/{this--description => description}  |  0
 .../applypatch-msg.sample}                    |  0
 .../commit-msg.sample}                        |  0
 .../fsmonitor-watchman.sample}                |  0
 .../post-update.sample}                       |  0
 .../pre-applypatch.sample}                    |  0
 .../pre-commit.sample}                        |  0
 .../pre-merge-commit.sample}                  |  0
 .../pre-push.sample}                          |  0
 .../pre-rebase.sample}                        |  0
 .../pre-receive.sample}                       |  0
 .../prepare-commit-msg.sample}                |  0
 .../push-to-checkout.sample}                  |  0
 .../sendemail-validate.sample}                |  0
 .../update.sample}                            |  0
 templates/{info--exclude => info/exclude}     |  0
 19 files changed, 37 insertions(+), 37 deletions(-)
 delete mode 100644 templates/branches--
 rename templates/{this--description => description} (100%)
 rename templates/{hooks--applypatch-msg.sample => hooks/applypatch-msg.sample} (100%)
 rename templates/{hooks--commit-msg.sample => hooks/commit-msg.sample} (100%)
 rename templates/{hooks--fsmonitor-watchman.sample => hooks/fsmonitor-watchman.sample} (100%)
 rename templates/{hooks--post-update.sample => hooks/post-update.sample} (100%)
 rename templates/{hooks--pre-applypatch.sample => hooks/pre-applypatch.sample} (100%)
 rename templates/{hooks--pre-commit.sample => hooks/pre-commit.sample} (100%)
 rename templates/{hooks--pre-merge-commit.sample => hooks/pre-merge-commit.sample} (100%)
 rename templates/{hooks--pre-push.sample => hooks/pre-push.sample} (100%)
 rename templates/{hooks--pre-rebase.sample => hooks/pre-rebase.sample} (100%)
 rename templates/{hooks--pre-receive.sample => hooks/pre-receive.sample} (100%)
 rename templates/{hooks--prepare-commit-msg.sample => hooks/prepare-commit-msg.sample} (100%)
 rename templates/{hooks--push-to-checkout.sample => hooks/push-to-checkout.sample} (100%)
 rename templates/{hooks--sendemail-validate.sample => hooks/sendemail-validate.sample} (100%)
 rename templates/{hooks--update.sample => hooks/update.sample} (100%)
 rename templates/{info--exclude => info/exclude} (100%)

diff --git a/contrib/buildsystems/CMakeLists.txt b/contrib/buildsystems/CMakeLists.txt
index 4f652927b1f..f63661c6b5d 100644
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
index 367ad00c24c..bd1e9e30c12 100644
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
index fae88709a63..00000000000
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
2.47.0.229.g8f8d6eee53.dirty

