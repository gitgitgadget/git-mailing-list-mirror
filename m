Received: from fhigh-b8-smtp.messagingengine.com (fhigh-b8-smtp.messagingengine.com [202.12.124.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D1DC1DB352
	for <git@vger.kernel.org>; Fri, 18 Oct 2024 12:24:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729254272; cv=none; b=h9ZKS53+iLFOCmOCq1JCdqORgnzjqo/DTyVDLJCW6jqh3a305loTbCnayhNd/zZDKYRJg4WIgNtKaCEca52xkvwv1BevrouXUZCLmsAqy9R6crDP8+9KQWoc23I7WbkYOfrr1RyEuo+W6WADUX9c1Xe74q9Jojb6hXFdLegWVyQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729254272; c=relaxed/simple;
	bh=PBqF3mB6A6jFLqzMGXUuo9LH8TshggxasH/296Bau6o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ScFigjxPJt6Z3iWnM8PDUnes3bjAsS3jNGOGUp5T/2bJoovT4arfVUC7mxJWGEPdL1xLQc056OPRrRh6rT4XM9sglda8BZY14rzHi57voM6n4VNd2Gy1LR8LQ6C6EWCOElbtglQ7nxHAMx+FoRnjmUAkg9czMsE2x2UgEyqLYXQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=RPrgR8Is; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=nZ5GylWw; arc=none smtp.client-ip=202.12.124.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="RPrgR8Is";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="nZ5GylWw"
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 3EBCC25400C1;
	Fri, 18 Oct 2024 08:24:29 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Fri, 18 Oct 2024 08:24:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1729254269; x=1729340669; bh=W/+cmipETW
	YLiHmHagmlWuSwS1ZBxfofuLDlm2P8KgM=; b=RPrgR8IsXemT7S29BIrh4Z2Flw
	Vyk3ykKfuM/5oCKl2k5M79SkgKvi0cYnpPSLz4O/jyn/McSguYn6UbDNHSmZziB2
	y2lpWT5obhTfP3WmCnwiwOL6qfGUqRXFRSRVuvUHmsuON+QkODysVLr2aGotmfxg
	piGBqMUvkKGZfQol6I4Rkh37TtUl16r9ODb5WhbCO9uQB/EEU143rXfvm8/6hE4w
	tkppk+GvE+/NPCtsFUvMntbBxjOBcNoMJQc7eJHwPIQ/gJ+bRMu0wljR0xQ/mWxO
	64M2lBZudW/kV/4Y615CXKadcBT1u1XDp4X9ivbnqMcdSEjE9NHI5rtQgUDQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1729254269; x=1729340669; bh=W/+cmipETWYLiHmHagmlWuSwS1ZB
	xfofuLDlm2P8KgM=; b=nZ5GylWwupLTjK5bbfxgvFcRvcd2c4qZaWYM9rKXaV/1
	7I1v7fDFbAj7MjYlhXpO4OLR/laXCKirThHMKMP/FPwHVBNZfgrDvFRMhaAJKe1s
	3QJ+wIqH1spuJT2+dLgWYenHqkPAzVG9wWiCsBQIakfM8a60rBnEsAHNkVDQpKYD
	pTSGB1YwJEv92HzeTUXjnt3cnwGPHMSKs/v/7rNkZIIY0nCY+yWF0qLeJHW1Hndf
	8dwNNFpLoPtWtn5VgLb8Z7JnmMT22iOAp1o5MhN+q2eWFSh6E1YieOCxI42t5MBn
	UqhzVxPQUG3X5RDwdLRdIivOvBdMP68sgQAOl0x6RA==
X-ME-Sender: <xms:fFMSZ6zgebbbQTFJ5rA4zo-_EyYqjqkeuI4oqIurh-bwjESc3P1BMA>
    <xme:fFMSZ2RNRcA8ZuFxnau5wB_kj-0fBXsy82SAaqDKM2wXWh8VtiQBvyT7rJLlVj1hI
    bARnCwKf7LCLTXL0A>
X-ME-Received: <xmr:fFMSZ8UjmigD-RNex9i6Ia3M5ZHJJmU2rutsy-imF86rR2FftrxXZT8IiD_Ln2ULg7Muwtbnb82uu32XjXASEQjHzUdimL_0J0Um1TRibrrz>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdehfedggeelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefgueeg
    udfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgepvdenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepiedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepshhunhhshhhinhgvsehsuhhnshhhihhnvggtohdrtg
    homhdprhgtphhtthhopehrrghmshgrhiesrhgrmhhsrgihjhhonhgvshdrphhluhhsrdgt
    ohhmpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomhdprhgtphhtthhope
    hgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepvghstghhfigrrhht
    iiesghgvnhhtohhordhorhhgpdhrtghpthhtohepphhhihhllhhiphdrfihoohguuddvfe
    esghhmrghilhdrtghomh
X-ME-Proxy: <xmx:fFMSZwilQ9ofQC4VSLQC1WY3ZP3zffZOWamof84ChIhcDqhXRoLCOg>
    <xmx:fVMSZ8A4tgQ4Gf5ksh0lPfzv41rqD4XTVRahJjQd7jZJQEO6G9E_lg>
    <xmx:fVMSZxJGeQpHC6apkHqerMAW8wjIJ1V-Zi4KwgbEWc1Nn_nic3p7ww>
    <xmx:fVMSZzCTzBGitLOQ9xL2ZbJyJ4FL3AiKlhQRhSMK7_oDjNTj3mkY9w>
    <xmx:fVMSZ-3IEEKXy7MtPlcFa5U4Oobw9nqGVyfUIHG9wPLG8KOFQ3Ee4aOb>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 18 Oct 2024 08:24:27 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 446a5d25 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 18 Oct 2024 12:23:06 +0000 (UTC)
Date: Fri, 18 Oct 2024 14:24:27 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Eli Schwartz <eschwartz@gentoo.org>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Phillip Wood <phillip.wood123@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Ramsay Jones <ramsay@ramsayjones.plus.com>
Subject: [RFC PATCH v3 11/15] Makefile: simplify building of templates
Message-ID: <1c37d6d1f19322b22bb62216ff17a0c6b431678a.1729254070.git.ps@pks.im>
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

When we install Git we also install a set of default templates that both
git-init(1) and git-clone(1) populate into our build directories. The
way the pristine templates are layed out in our source directory is
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
index fdf0c0ff769..ad4e3f0b6ce 100644
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
@@ -665,20 +665,20 @@ include_directories(${CMAKE_BINARY_DIR})
 
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
@@ -742,7 +742,7 @@ elseif(UNIX)
 endif()
 
 #git
-parse_makefile_for_sources(git_SOURCES "BUILTIN_OBJS")
+parse_makefile_for_sources(git_SOURCES ${CMAKE_SOURCE_DIR}/Makefile "BUILTIN_OBJS")
 
 list(TRANSFORM git_SOURCES PREPEND "${CMAKE_SOURCE_DIR}/")
 add_executable(git ${CMAKE_SOURCE_DIR}/git.c ${git_SOURCES})
@@ -874,24 +874,14 @@ file(STRINGS ${CMAKE_SOURCE_DIR}/git-p4.py content NEWLINE_CONSUME)
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
@@ -965,7 +955,7 @@ add_executable(test-fake-ssh ${CMAKE_SOURCE_DIR}/t/helper/test-fake-ssh.c)
 target_link_libraries(test-fake-ssh common-main)
 
 #unit-tests
-parse_makefile_for_sources(unit-test_SOURCES "UNIT_TEST_OBJS")
+parse_makefile_for_sources(unit-test_SOURCES ${CMAKE_SOURCE_DIR}/Makefile "UNIT_TEST_OBJS")
 list(TRANSFORM unit-test_SOURCES REPLACE "\\$\\(UNIT_TEST_DIR\\)/" "${CMAKE_SOURCE_DIR}/t/unit-tests/")
 add_library(unit-test-lib STATIC ${unit-test_SOURCES})
 
@@ -1023,7 +1013,7 @@ if(MSVC)
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
2.47.0.72.gef8ce8f3d4.dirty

