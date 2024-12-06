Received: from fout-b8-smtp.messagingengine.com (fout-b8-smtp.messagingengine.com [202.12.124.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6BBD20767B
	for <git@vger.kernel.org>; Fri,  6 Dec 2024 13:25:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733491527; cv=none; b=ELQ6SqnfUF4g3eij1W39EFop7Rp2+zfyo19NwQEaCp33C6s/mPjvF+wMTSgkWD1sj576sfbBqX2hsh+4gRAOyN2AWwCKwESs5rBzGddoweooP+9KL2uuiHv5FOvoW81YfbljVBPsPOsIjtPIESpORau0I8fK1P9d5sinfcV10lo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733491527; c=relaxed/simple;
	bh=o/O3aDenxGekZ2TFZ0xTV2reFQwn6YLLb2tfje2zL6E=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=sFO41yVePybOiTn/oip9owvbUw8X9CgiVYo3g4HnynOHhBnEnVJAPg22o+8sXlGIE4ppzLqhW5b5ySUheuTIljgcp2Z2sEnbnR/71xxiddc8X5J19ERtieu5Qqa36KTD43FAJrmA4UarLycQVdP4GPpcMmEdFsJ/a1XgjLht72Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=yVG0Ckf/; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=2NXAwRM5; arc=none smtp.client-ip=202.12.124.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="yVG0Ckf/";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="2NXAwRM5"
Received: from phl-compute-12.internal (phl-compute-12.phl.internal [10.202.2.52])
	by mailfout.stl.internal (Postfix) with ESMTP id B2CC311401A1;
	Fri,  6 Dec 2024 08:25:22 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-12.internal (MEProxy); Fri, 06 Dec 2024 08:25:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1733491522;
	 x=1733577922; bh=rgG4ax6WndG7uOeCTJJI7WTUWlIf2o6fjRCHLl0bQFY=; b=
	yVG0Ckf/OUIC3eLRTYqFKVwOvVeqyHm9cwyFDbHp/ItuYwvQ+aYyAC/3am3q3Drl
	lSbKI8EK+mgn1LSliuLRDhawNiZoLyg0EVZ802wXQHjFZOWmAigGh4H0YV62+Tpp
	QjK1Y4mBc0UJMv7oivcW6Xy7urPU8wbPiVUIYX6RTpde2tyqa0xY3bm2YKD4NOgN
	HkXDXFuaYwfvdGtETlvXblnk+kb6xljWUQnzZ6hVepyuI6Lls2lAiV2xm3kLjtG1
	Tx64TlOT6WmHpq+vdQET+yy642MbSruQH66J/t67+Icbgp9ll5kbt8qolJBKMkSg
	Jz6WtLH2OPO+7ZfeVs8o0g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1733491522; x=
	1733577922; bh=rgG4ax6WndG7uOeCTJJI7WTUWlIf2o6fjRCHLl0bQFY=; b=2
	NXAwRM5meL3OG+7X4JbuvX9tqZv+oPp8zzX5z3awGtvUO6W7c4gidMhHhAR56C9e
	tIczyDPvdE7F1OW55A39YzVCZX97LhUfaxo61tuHyimu6nvAovVe+zWUv6JOfrz1
	QD9ilodzel6jpP0v16YDqTpvASAFFD01PdJC3pVAVsxbMJnnbWn9jnZ5DCr8Cwg8
	p8DXa4T1Gtn7NwK0WXuKQ9hItV3pSSJYKihaXGm+ola4m+asFE0gtZsukRYa1RGd
	QWU6rymfMv8dAHmVIGK7anxD0afQVjK7d4Qpq5lqeRCqYqNkVKBm+JKbcibanpvz
	Ci8idsJwlSGy6m7Ur98Rw==
X-ME-Sender: <xms:QvtSZ2dF-T6QgBpdfEkkEitXTw-72YUwFL_-_OZkgGqFJfWNdd4vSQ>
    <xme:QvtSZwMzZ1ksG4I_ft6WswtQEUEpetgga6mjE9QqWHeAmCRofX8h7U6rMjhXXy-_B
    CxevkB4l0tZS8TZsQ>
X-ME-Received: <xmr:QvtSZ3jC6WBtYA_YxsVKev3JxXys9SNDii-UDjxdOfz5VPSB6URswUi2Lppvo1I-n2RDPNwYmroqh7Jm5hZH49Qj9y01k3wlh1NjtMbv1R7xSw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrieelgdehtdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
    hsucdlqddutddtmdenucfjughrpefhfffugggtgffkfhgjvfevofesthejredtredtjeen
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepjeevveehfeehteegieeiteefhfeluddtveeggfevhfdu
    ueellefhkedvueeghefhnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghdprghnughrvg
    dqshhimhhonhdruggvnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghi
    lhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepuddupdhmohguvgepsh
    hmthhpohhuthdprhgtphhtthhopehmvgesthhtrgihlhhorhhrrdgtohhmpdhrtghpthht
    ohepghhithhsthgvrhesphhosghogidrtghomhdprhgtphhtthhopehgihhtsehvghgvrh
    drkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepphgvfhhfsehpvghffhdrnhgvthdprhgt
    phhtthhopegvshgthhifrghrthiisehgvghnthhoohdrohhrghdprhgtphhtthhopehrrg
    hmshgrhiesrhgrmhhsrgihjhhonhgvshdrphhluhhsrdgtohhmpdhrtghpthhtohepphhh
    ihhllhhiphdrfihoohguuddvfeesghhmrghilhdrtghomhdprhgtphhtthhopegthhhrih
    hstghoohhlsehtuhigfhgrmhhilhihrdhorhhgpdhrtghpthhtohepuggrvhhvihgusehg
    mhgrihhlrdgtohhm
X-ME-Proxy: <xmx:QvtSZz8Jw-MnkWtBuniaz0N3fTgIn-xuBDUkJdgJ7sYT2Qzv8UeyLQ>
    <xmx:QvtSZytOsZhIi7FoZq5rTmk0gxcobvNW0Uk8-9cWXeorWK69VtoNLg>
    <xmx:QvtSZ6GGQyo3G2jfyrBai3Efn0mJvzM0mB4IFmSJ_200aQU8AG5OIQ>
    <xmx:QvtSZxOKvtZdNNIfuEiwsDC3ys6urVFN9KeyPB8OUTnEkGNsXafv4g>
    <xmx:QvtSZ6GDvOGPGoZCuy6EOVdNhYpHcRNr2ZX4DA6SnbBETd_GgoUAW1IB>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 6 Dec 2024 08:25:20 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id ffd33737 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 6 Dec 2024 13:23:53 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Fri, 06 Dec 2024 14:24:37 +0100
Subject: [PATCH v11 02/26] Makefile: consistently use @PLACEHOLDER@ to
 substitute
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241206-pks-meson-v11-2-525ed4792b88@pks.im>
References: <20241206-pks-meson-v11-0-525ed4792b88@pks.im>
In-Reply-To: <20241206-pks-meson-v11-0-525ed4792b88@pks.im>
To: git@vger.kernel.org
Cc: Eli Schwartz <eschwartz@gentoo.org>, 
 Eric Sunshine <sunshine@sunshineco.com>, 
 Phillip Wood <phillip.wood123@gmail.com>, 
 Junio C Hamano <gitster@pobox.com>, 
 Ramsay Jones <ramsay@ramsayjones.plus.com>, Taylor Blau <me@ttaylorr.com>, 
 David Aguilar <davvid@gmail.com>, Jeff King <peff@peff.net>, 
 Johannes Sixt <j6t@kdbg.org>, Christian Couder <chriscool@tuxfamily.org>
X-Mailer: b4 0.14.2

We have a bunch of placeholders in our scripts that we replace at build
time, for example by using sed(1). These placeholders come in three
different formats: @PLACEHOLDER@, @@PLACEHOLDER@@ and ++PLACEHOLDER++.

Next to being inconsistent it also creates a bit of a problem with
CMake, which only supports the first syntax in its `configure_file()`
function. To work around that we instead manually replace placeholders
via string operations, which is a hassle and removes safeguards that
CMake has to verify that we didn't forget to replace any placeholders.
Besides that, other build systems like Meson also support the CMake
syntax.

Unify our codebase to consistently use the syntax supported by such
build systems.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 Makefile                                         | 44 ++++++++++++------------
 configure.ac                                     |  2 +-
 contrib/buildsystems/CMakeLists.txt              | 34 +++++++++---------
 git-cvsserver.perl                               |  2 +-
 git-instaweb.sh                                  |  8 ++---
 git-request-pull.sh                              |  2 +-
 git-send-email.perl                              |  2 +-
 git-sh-i18n.sh                                   |  6 ++--
 git-sh-setup.sh                                  |  6 ++--
 git-svn.perl                                     |  2 +-
 gitweb/Makefile                                  | 44 ++++++++++++------------
 gitweb/gitweb.perl                               | 44 ++++++++++++------------
 perl/Git/I18N.pm                                 |  6 ++--
 perl/Git/LoadCPAN.pm                             |  6 ++--
 perl/header_templates/fixed_prefix.template.pl   |  2 +-
 perl/header_templates/runtime_prefix.template.pl |  8 ++---
 unimplemented.sh                                 |  2 +-
 wrap-for-bin.sh                                  | 18 +++++-----
 18 files changed, 119 insertions(+), 119 deletions(-)

diff --git a/Makefile b/Makefile
index be91a0e44b322f001e98be69f32bc015626c806e..45c38088535fbb10fae7ea17eda44bd6fb6c91aa 100644
--- a/Makefile
+++ b/Makefile
@@ -1555,10 +1555,10 @@ endif
 
 ifdef SANE_TOOL_PATH
 SANE_TOOL_PATH_SQ = $(subst ','\'',$(SANE_TOOL_PATH))
-BROKEN_PATH_FIX = 's|^\# @@BROKEN_PATH_FIX@@$$|git_broken_path_fix "$(SANE_TOOL_PATH_SQ)"|'
+BROKEN_PATH_FIX = 's|^\# @BROKEN_PATH_FIX@$$|git_broken_path_fix "$(SANE_TOOL_PATH_SQ)"|'
 PATH := $(SANE_TOOL_PATH):${PATH}
 else
-BROKEN_PATH_FIX = '/^\# @@BROKEN_PATH_FIX@@$$/d'
+BROKEN_PATH_FIX = '/^\# @BROKEN_PATH_FIX@$$/d'
 endif
 
 ifeq (,$(HOST_CPU))
@@ -2548,13 +2548,13 @@ GIT-SCRIPT-DEFINES: FORCE
 define cmd_munge_script
 sed -e '1s|#!.*/sh|#!$(SHELL_PATH_SQ)|' \
     -e 's|@SHELL_PATH@|$(SHELL_PATH_SQ)|' \
-    -e 's|@@DIFF@@|$(DIFF_SQ)|' \
-    -e 's|@@LOCALEDIR@@|$(localedir_SQ)|g' \
-    -e 's/@@USE_GETTEXT_SCHEME@@/$(USE_GETTEXT_SCHEME)/g' \
+    -e 's|@DIFF@|$(DIFF_SQ)|' \
+    -e 's|@LOCALEDIR@|$(localedir_SQ)|g' \
+    -e 's/@USE_GETTEXT_SCHEME@/$(USE_GETTEXT_SCHEME)/g' \
     -e $(BROKEN_PATH_FIX) \
-    -e 's|@@GITWEBDIR@@|$(gitwebdir_SQ)|g' \
-    -e 's|@@PERL@@|$(PERL_PATH_SQ)|g' \
-    -e 's|@@PAGER_ENV@@|$(PAGER_ENV_SQ)|g' \
+    -e 's|@GITWEBDIR@|$(gitwebdir_SQ)|g' \
+    -e 's|@PERL@|$(PERL_PATH_SQ)|g' \
+    -e 's|@PAGER_ENV@|$(PAGER_ENV_SQ)|g' \
     $@.sh >$@+
 endef
 
@@ -2611,7 +2611,7 @@ $(SCRIPT_PERL_GEN): % : %.perl GIT-PERL-DEFINES GIT-PERL-HEADER GIT-VERSION-FILE
 	    -e '	r GIT-PERL-HEADER' \
 	    -e '	G' \
 	    -e '}' \
-	    -e 's/@@GIT_VERSION@@/$(GIT_VERSION)/g' \
+	    -e 's/@GIT_VERSION@/$(GIT_VERSION)/g' \
 	    $< >$@+ && \
 	chmod +x $@+ && \
 	mv $@+ $@
@@ -2629,11 +2629,11 @@ GIT-PERL-HEADER: $(PERL_HEADER_TEMPLATE) GIT-PERL-DEFINES Makefile
 	INSTLIBDIR='$(perllibdir_SQ)' && \
 	INSTLIBDIR_EXTRA='$(PERLLIB_EXTRA_SQ)' && \
 	INSTLIBDIR="$$INSTLIBDIR$${INSTLIBDIR_EXTRA:+:$$INSTLIBDIR_EXTRA}" && \
-	sed -e 's=@@PATHSEP@@=$(pathsep)=g' \
-	    -e "s=@@INSTLIBDIR@@=$$INSTLIBDIR=g" \
-	    -e 's=@@PERLLIBDIR_REL@@=$(perllibdir_relative_SQ)=g' \
-	    -e 's=@@GITEXECDIR_REL@@=$(gitexecdir_relative_SQ)=g' \
-	    -e 's=@@LOCALEDIR_REL@@=$(localedir_relative_SQ)=g' \
+	sed -e 's=@PATHSEP@=$(pathsep)=g' \
+	    -e "s=@INSTLIBDIR@=$$INSTLIBDIR=g" \
+	    -e 's=@PERLLIBDIR_REL@=$(perllibdir_relative_SQ)=g' \
+	    -e 's=@GITEXECDIR_REL@=$(gitexecdir_relative_SQ)=g' \
+	    -e 's=@LOCALEDIR_REL@=$(localedir_relative_SQ)=g' \
 	    $< >$@+ && \
 	mv $@+ $@
 
@@ -2649,7 +2649,7 @@ else # NO_PERL
 $(SCRIPT_PERL_GEN) git-instaweb: % : unimplemented.sh
 	$(QUIET_GEN) \
 	sed -e '1s|#!.*/sh|#!$(SHELL_PATH_SQ)|' \
-	    -e 's|@@REASON@@|NO_PERL=$(NO_PERL)|g' \
+	    -e 's|@REASON@|NO_PERL=$(NO_PERL)|g' \
 	    unimplemented.sh >$@+ && \
 	chmod +x $@+ && \
 	mv $@+ $@
@@ -2670,13 +2670,13 @@ else # NO_PYTHON
 $(SCRIPT_PYTHON_GEN): % : unimplemented.sh
 	$(QUIET_GEN) \
 	sed -e '1s|#!.*/sh|#!$(SHELL_PATH_SQ)|' \
-	    -e 's|@@REASON@@|NO_PYTHON=$(NO_PYTHON)|g' \
+	    -e 's|@REASON@|NO_PYTHON=$(NO_PYTHON)|g' \
 	    unimplemented.sh >$@+ && \
 	chmod +x $@+ && \
 	mv $@+ $@
 endif # NO_PYTHON
 
-CONFIGURE_RECIPE = sed -e 's/@@GIT_VERSION@@/$(GIT_VERSION)/g' \
+CONFIGURE_RECIPE = sed -e 's/@GIT_VERSION@/$(GIT_VERSION)/g' \
 			configure.ac >configure.ac+ && \
 		   autoconf -o configure configure.ac+ && \
 		   $(RM) configure.ac+
@@ -3105,9 +3105,9 @@ endif
 perl/build/lib/%.pm: perl/%.pm GIT-PERL-DEFINES
 	$(call mkdir_p_parent_template)
 	$(QUIET_GEN) \
-	sed -e 's|@@LOCALEDIR@@|$(perl_localedir_SQ)|g' \
-	    -e 's|@@NO_GETTEXT@@|$(NO_GETTEXT_SQ)|g' \
-	    -e 's|@@NO_PERL_CPAN_FALLBACKS@@|$(NO_PERL_CPAN_FALLBACKS_SQ)|g' \
+	sed -e 's|@LOCALEDIR@|$(perl_localedir_SQ)|g' \
+	    -e 's|@NO_GETTEXT@|$(NO_GETTEXT_SQ)|g' \
+	    -e 's|@NO_PERL_CPAN_FALLBACKS@|$(NO_PERL_CPAN_FALLBACKS_SQ)|g' \
 	< $< > $@
 
 perl/build/man/man3/Git.3pm: perl/Git.pm
@@ -3232,8 +3232,8 @@ all:: $(TEST_PROGRAMS) $(test_bindir_programs) $(UNIT_TEST_PROGS) $(CLAR_TEST_PR
 bin-wrappers/%: wrap-for-bin.sh
 	$(call mkdir_p_parent_template)
 	$(QUIET_GEN)sed -e '1s|#!.*/sh|#!$(SHELL_PATH_SQ)|' \
-	     -e 's|@@BUILD_DIR@@|$(shell pwd)|' \
-	     -e 's|@@PROG@@|$(patsubst test-%,t/helper/test-%,$(@F))$(if $(filter-out $(BINDIR_PROGRAMS_NO_X),$(@F)),$(X),)|' < $< > $@ && \
+	     -e 's|@BUILD_DIR@|$(shell pwd)|' \
+	     -e 's|@PROG@|$(patsubst test-%,t/helper/test-%,$(@F))$(if $(filter-out $(BINDIR_PROGRAMS_NO_X),$(@F)),$(X),)|' < $< > $@ && \
 	chmod +x $@
 
 # GNU make supports exporting all variables by "export" without parameters.
diff --git a/configure.ac b/configure.ac
index d1a96da14eb56766e1538da80ab97ed8a99b24f6..5923edc44aa7b6cc355fa6589b6d075b0c0a7772 100644
--- a/configure.ac
+++ b/configure.ac
@@ -142,7 +142,7 @@ fi
 ## Configure body starts here.
 
 AC_PREREQ(2.59)
-AC_INIT([git], [@@GIT_VERSION@@], [git@vger.kernel.org])
+AC_INIT([git], [@GIT_VERSION@], [git@vger.kernel.org])
 
 AC_CONFIG_SRCDIR([git.c])
 
diff --git a/contrib/buildsystems/CMakeLists.txt b/contrib/buildsystems/CMakeLists.txt
index 985004f5943128483e2138cd61aca8bd8ccbd240..1abf5f099c1c6735ae7aec345de96bf623e2aa18 100644
--- a/contrib/buildsystems/CMakeLists.txt
+++ b/contrib/buildsystems/CMakeLists.txt
@@ -836,14 +836,14 @@ set(git_shell_scripts
 foreach(script ${git_shell_scripts})
 	file(STRINGS ${CMAKE_SOURCE_DIR}/${script}.sh content NEWLINE_CONSUME)
 	string(REPLACE "@SHELL_PATH@" "${SHELL_PATH}" content "${content}")
-	string(REPLACE "@@DIFF@@" "diff" content "${content}")
+	string(REPLACE "@DIFF@" "diff" content "${content}")
 	string(REPLACE "@LOCALEDIR@" "${LOCALEDIR}" content "${content}")
 	string(REPLACE "@GITWEBDIR@" "${GITWEBDIR}" content "${content}")
-	string(REPLACE "@@NO_CURL@@" "" content "${content}")
-	string(REPLACE "@@USE_GETTEXT_SCHEME@@" "" content "${content}")
-	string(REPLACE "# @@BROKEN_PATH_FIX@@" "" content "${content}")
-	string(REPLACE "@@PERL@@" "${PERL_PATH}" content "${content}")
-	string(REPLACE "@@PAGER_ENV@@" "LESS=FRX LV=-c" content "${content}")
+	string(REPLACE "@NO_CURL@" "" content "${content}")
+	string(REPLACE "@USE_GETTEXT_SCHEME@" "" content "${content}")
+	string(REPLACE "# @BROKEN_PATH_FIX@" "" content "${content}")
+	string(REPLACE "@PERL@" "${PERL_PATH}" content "${content}")
+	string(REPLACE "@PAGER_ENV@" "LESS=FRX LV=-c" content "${content}")
 	file(WRITE ${CMAKE_BINARY_DIR}/${script} ${content})
 endforeach()
 
@@ -852,13 +852,13 @@ parse_makefile_for_scripts(git_perl_scripts "SCRIPT_PERL" ".perl")
 
 #create perl header
 file(STRINGS ${CMAKE_SOURCE_DIR}/perl/header_templates/fixed_prefix.template.pl perl_header )
-string(REPLACE "@@PATHSEP@@" ":" perl_header "${perl_header}")
-string(REPLACE "@@INSTLIBDIR@@" "${INSTLIBDIR}" perl_header "${perl_header}")
+string(REPLACE "@PATHSEP@" ":" perl_header "${perl_header}")
+string(REPLACE "@INSTLIBDIR@" "${INSTLIBDIR}" perl_header "${perl_header}")
 
 foreach(script ${git_perl_scripts})
 	file(STRINGS ${CMAKE_SOURCE_DIR}/${script}.perl content NEWLINE_CONSUME)
 	string(REPLACE "#!/usr/bin/perl" "#!/usr/bin/perl\n${perl_header}\n" content "${content}")
-	string(REPLACE "@@GIT_VERSION@@" "${PROJECT_VERSION}" content "${content}")
+	string(REPLACE "@GIT_VERSION@" "${PROJECT_VERSION}" content "${content}")
 	file(WRITE ${CMAKE_BINARY_DIR}/${script} ${content})
 endforeach()
 
@@ -873,8 +873,8 @@ file(GLOB_RECURSE perl_modules "${CMAKE_SOURCE_DIR}/perl/*.pm")
 foreach(pm ${perl_modules})
 	string(REPLACE "${CMAKE_SOURCE_DIR}/perl/" "" file_path ${pm})
 	file(STRINGS ${pm} content NEWLINE_CONSUME)
-	string(REPLACE "@@LOCALEDIR@@" "${LOCALEDIR}" content "${content}")
-	string(REPLACE "@@NO_PERL_CPAN_FALLBACKS@@" "" content "${content}")
+	string(REPLACE "@LOCALEDIR@" "${LOCALEDIR}" content "${content}")
+	string(REPLACE "@NO_PERL_CPAN_FALLBACKS@" "" content "${content}")
 	file(WRITE ${CMAKE_BINARY_DIR}/perl/build/lib/${file_path} ${content})
 #test-lib.sh requires perl/build/lib to be the build directory of perl modules
 endforeach()
@@ -1064,21 +1064,21 @@ set(wrapper_test_scripts
 
 foreach(script ${wrapper_scripts})
 	file(STRINGS ${CMAKE_SOURCE_DIR}/wrap-for-bin.sh content NEWLINE_CONSUME)
-	string(REPLACE "@@BUILD_DIR@@" "${CMAKE_BINARY_DIR}" content "${content}")
-	string(REPLACE "@@PROG@@" "${script}${EXE_EXTENSION}" content "${content}")
+	string(REPLACE "@BUILD_DIR@" "${CMAKE_BINARY_DIR}" content "${content}")
+	string(REPLACE "@PROG@" "${script}${EXE_EXTENSION}" content "${content}")
 	file(WRITE ${CMAKE_BINARY_DIR}/bin-wrappers/${script} ${content})
 endforeach()
 
 foreach(script ${wrapper_test_scripts})
 	file(STRINGS ${CMAKE_SOURCE_DIR}/wrap-for-bin.sh content NEWLINE_CONSUME)
-	string(REPLACE "@@BUILD_DIR@@" "${CMAKE_BINARY_DIR}" content "${content}")
-	string(REPLACE "@@PROG@@" "t/helper/${script}${EXE_EXTENSION}" content "${content}")
+	string(REPLACE "@BUILD_DIR@" "${CMAKE_BINARY_DIR}" content "${content}")
+	string(REPLACE "@PROG@" "t/helper/${script}${EXE_EXTENSION}" content "${content}")
 	file(WRITE ${CMAKE_BINARY_DIR}/bin-wrappers/${script} ${content})
 endforeach()
 
 file(STRINGS ${CMAKE_SOURCE_DIR}/wrap-for-bin.sh content NEWLINE_CONSUME)
-string(REPLACE "@@BUILD_DIR@@" "${CMAKE_BINARY_DIR}" content "${content}")
-string(REPLACE "@@PROG@@" "git-cvsserver" content "${content}")
+string(REPLACE "@BUILD_DIR@" "${CMAKE_BINARY_DIR}" content "${content}")
+string(REPLACE "@PROG@" "git-cvsserver" content "${content}")
 file(WRITE ${CMAKE_BINARY_DIR}/bin-wrappers/git-cvsserver ${content})
 
 #options for configuring test options
diff --git a/git-cvsserver.perl b/git-cvsserver.perl
index a4ad9a5d2db9e99ae0c4a5f26524ef344543aaa3..a4e1bad33ca2a3d4d6704b8d781a58be623b1100 100755
--- a/git-cvsserver.perl
+++ b/git-cvsserver.perl
@@ -26,7 +26,7 @@
 use File::Basename;
 use Getopt::Long qw(:config require_order no_ignore_case);
 
-my $VERSION = '@@GIT_VERSION@@';
+my $VERSION = '@GIT_VERSION@';
 
 my $log = GITCVS::log->new();
 my $cfg;
diff --git a/git-instaweb.sh b/git-instaweb.sh
index 8dbe21d5887595352bc0159ea9befdf296b8105f..c8efb1205a8e2a66a6aced840980978897e122bc 100755
--- a/git-instaweb.sh
+++ b/git-instaweb.sh
@@ -3,7 +3,7 @@
 # Copyright (c) 2006 Eric Wong
 #
 
-PERL='@@PERL@@'
+PERL='@PERL@'
 OPTIONS_KEEPDASHDASH=
 OPTIONS_STUCKLONG=
 OPTIONS_SPEC="\
@@ -38,8 +38,8 @@ conf="$GIT_DIR/gitweb/httpd.conf"
 # if installed, it doesn't need further configuration (module_path)
 test -z "$httpd" && httpd='lighttpd -f'
 
-# Default is @@GITWEBDIR@@
-test -z "$root" && root='@@GITWEBDIR@@'
+# Default is @GITWEBDIR@
+test -z "$root" && root='@GITWEBDIR@'
 
 # any untaken local port will do...
 test -z "$port" && port=1234
@@ -716,7 +716,7 @@ EOF
 
 gitweb_conf() {
 	cat > "$fqgitdir/gitweb/gitweb_config.perl" <<EOF
-#!@@PERL@@
+#!@PERL@
 our \$projectroot = "$(dirname "$fqgitdir")";
 our \$git_temp = "$fqgitdir/gitweb/tmp";
 our \$projects_list = \$projectroot;
diff --git a/git-request-pull.sh b/git-request-pull.sh
index 01640a044bb10f4167338fca957c43a240e1b6c0..10c88639e28c02650ffea3d4671afa9a9f0bb182 100755
--- a/git-request-pull.sh
+++ b/git-request-pull.sh
@@ -112,7 +112,7 @@ find_matching_ref='
 	}
 '
 
-set fnord $(git ls-remote "$url" | @@PERL@@ -e "$find_matching_ref" "${remote:-HEAD}" "$headrev")
+set fnord $(git ls-remote "$url" | @PERL@ -e "$find_matching_ref" "${remote:-HEAD}" "$headrev")
 remote_sha1=$2
 ref=$3
 
diff --git a/git-send-email.perl b/git-send-email.perl
index c4d12bebc8f7ed1f40c886656af2e294790fab45..798d59b84f1d6068261d65329ab4dde9b6ff8145 100755
--- a/git-send-email.perl
+++ b/git-send-email.perl
@@ -1501,7 +1501,7 @@ sub gen_header {
 	@recipients = unique_email_list(@recipients,@cc,@initial_bcc);
 	@recipients = (map { extract_valid_address_or_die($_) } @recipients);
 	my $date = format_2822_time($time++);
-	my $gitversion = '@@GIT_VERSION@@';
+	my $gitversion = '@GIT_VERSION@';
 	if ($gitversion =~ m/..GIT_VERSION../) {
 	    $gitversion = Git::version();
 	}
diff --git a/git-sh-i18n.sh b/git-sh-i18n.sh
index a15c0620db6893898152b1c9e363a0af7f1b304e..ae4b2d6ba9dc061ef40ef1867f0cd5e975df8fe5 100644
--- a/git-sh-i18n.sh
+++ b/git-sh-i18n.sh
@@ -9,7 +9,7 @@ TEXTDOMAIN=git
 export TEXTDOMAIN
 if test -z "$GIT_TEXTDOMAINDIR"
 then
-	TEXTDOMAINDIR="@@LOCALEDIR@@"
+	TEXTDOMAINDIR="@LOCALEDIR@"
 else
 	TEXTDOMAINDIR="$GIT_TEXTDOMAINDIR"
 fi
@@ -17,9 +17,9 @@ export TEXTDOMAINDIR
 
 # First decide what scheme to use...
 GIT_INTERNAL_GETTEXT_SH_SCHEME=fallthrough
-if test -n "@@USE_GETTEXT_SCHEME@@"
+if test -n "@USE_GETTEXT_SCHEME@"
 then
-	GIT_INTERNAL_GETTEXT_SH_SCHEME="@@USE_GETTEXT_SCHEME@@"
+	GIT_INTERNAL_GETTEXT_SH_SCHEME="@USE_GETTEXT_SCHEME@"
 elif test -n "$GIT_INTERNAL_GETTEXT_TEST_FALLBACKS"
 then
 	: no probing necessary
diff --git a/git-sh-setup.sh b/git-sh-setup.sh
index ce273fe0e48d997cb067e77707026616a9302eb2..19aef72ec2553027bb25a5968d4e428ba986fdb2 100644
--- a/git-sh-setup.sh
+++ b/git-sh-setup.sh
@@ -41,7 +41,7 @@ git_broken_path_fix () {
 	esac
 }
 
-# @@BROKEN_PATH_FIX@@
+# @BROKEN_PATH_FIX@
 
 # Source git-sh-i18n for gettext support.
 . "$(git --exec-path)/git-sh-i18n"
@@ -154,7 +154,7 @@ git_pager() {
 	else
 		GIT_PAGER=cat
 	fi
-	for vardef in @@PAGER_ENV@@
+	for vardef in @PAGER_ENV@
 	do
 		var=${vardef%%=*}
 		eval ": \"\${$vardef}\" && export $var"
@@ -280,7 +280,7 @@ get_author_ident_from_commit () {
 # remove lines from $1 that are not in $2, leaving only common lines.
 create_virtual_base() {
 	sz0=$(wc -c <"$1")
-	@@DIFF@@ -u -La/"$1" -Lb/"$1" "$1" "$2" | git apply --no-add
+	@DIFF@ -u -La/"$1" -Lb/"$1" "$1" "$2" | git apply --no-add
 	sz1=$(wc -c <"$1")
 
 	# If we do not have enough common material, it is not
diff --git a/git-svn.perl b/git-svn.perl
index 9c7c62993245fae5e6c95cfe4d231477795b9610..32c648c3956fa466491e21053ec56014b4284d92 100755
--- a/git-svn.perl
+++ b/git-svn.perl
@@ -9,7 +9,7 @@
 		$_revision $_repository
 		$_q $_authors $_authors_prog %users/;
 $AUTHOR = 'Eric Wong <normalperson@yhbt.net>';
-$VERSION = '@@GIT_VERSION@@';
+$VERSION = '@GIT_VERSION@';
 
 use Carp qw/croak/;
 use File::Basename qw/dirname basename/;
diff --git a/gitweb/Makefile b/gitweb/Makefile
index 3b68ab2d672c4afae62f8f4dc024e0911027b58d..164c8d53757f98599ad14eeb22ca8d542eb7502a 100644
--- a/gitweb/Makefile
+++ b/gitweb/Makefile
@@ -79,28 +79,28 @@ GITWEB_JSLIB_FILES += static/js/blame_incremental.js
 
 
 GITWEB_REPLACE = \
-	-e 's|++GIT_VERSION++|$(GIT_VERSION)|g' \
-	-e 's|++GIT_BINDIR++|$(bindir)|g' \
-	-e 's|++GITWEB_CONFIG++|$(GITWEB_CONFIG)|g' \
-	-e 's|++GITWEB_CONFIG_SYSTEM++|$(GITWEB_CONFIG_SYSTEM)|g' \
-	-e 's|++GITWEB_CONFIG_COMMON++|$(GITWEB_CONFIG_COMMON)|g' \
-	-e 's|++GITWEB_HOME_LINK_STR++|$(GITWEB_HOME_LINK_STR)|g' \
-	-e 's|++GITWEB_SITENAME++|$(GITWEB_SITENAME)|g' \
-	-e 's|++GITWEB_PROJECTROOT++|$(GITWEB_PROJECTROOT)|g' \
-	-e 's|"++GITWEB_PROJECT_MAXDEPTH++"|$(GITWEB_PROJECT_MAXDEPTH)|g' \
-	-e 's|++GITWEB_EXPORT_OK++|$(GITWEB_EXPORT_OK)|g' \
-	-e 's|++GITWEB_STRICT_EXPORT++|$(GITWEB_STRICT_EXPORT)|g' \
-	-e 's|++GITWEB_BASE_URL++|$(GITWEB_BASE_URL)|g' \
-	-e 's|++GITWEB_LIST++|$(GITWEB_LIST)|g' \
-	-e 's|++GITWEB_HOMETEXT++|$(GITWEB_HOMETEXT)|g' \
-	-e 's|++GITWEB_CSS++|$(GITWEB_CSS)|g' \
-	-e 's|++GITWEB_LOGO++|$(GITWEB_LOGO)|g' \
-	-e 's|++GITWEB_FAVICON++|$(GITWEB_FAVICON)|g' \
-	-e 's|++GITWEB_JS++|$(GITWEB_JS)|g' \
-	-e 's|++GITWEB_SITE_HTML_HEAD_STRING++|$(GITWEB_SITE_HTML_HEAD_STRING)|g' \
-	-e 's|++GITWEB_SITE_HEADER++|$(GITWEB_SITE_HEADER)|g' \
-	-e 's|++GITWEB_SITE_FOOTER++|$(GITWEB_SITE_FOOTER)|g' \
-	-e 's|++HIGHLIGHT_BIN++|$(HIGHLIGHT_BIN)|g'
+	-e 's|@GIT_VERSION@|$(GIT_VERSION)|g' \
+	-e 's|@GIT_BINDIR@|$(bindir)|g' \
+	-e 's|@GITWEB_CONFIG@|$(GITWEB_CONFIG)|g' \
+	-e 's|@GITWEB_CONFIG_SYSTEM@|$(GITWEB_CONFIG_SYSTEM)|g' \
+	-e 's|@GITWEB_CONFIG_COMMON@|$(GITWEB_CONFIG_COMMON)|g' \
+	-e 's|@GITWEB_HOME_LINK_STR@|$(GITWEB_HOME_LINK_STR)|g' \
+	-e 's|@GITWEB_SITENAME@|$(GITWEB_SITENAME)|g' \
+	-e 's|@GITWEB_PROJECTROOT@|$(GITWEB_PROJECTROOT)|g' \
+	-e 's|"@GITWEB_PROJECT_MAXDEPTH@"|$(GITWEB_PROJECT_MAXDEPTH)|g' \
+	-e 's|@GITWEB_EXPORT_OK@|$(GITWEB_EXPORT_OK)|g' \
+	-e 's|@GITWEB_STRICT_EXPORT@|$(GITWEB_STRICT_EXPORT)|g' \
+	-e 's|@GITWEB_BASE_URL@|$(GITWEB_BASE_URL)|g' \
+	-e 's|@GITWEB_LIST@|$(GITWEB_LIST)|g' \
+	-e 's|@GITWEB_HOMETEXT@|$(GITWEB_HOMETEXT)|g' \
+	-e 's|@GITWEB_CSS@|$(GITWEB_CSS)|g' \
+	-e 's|@GITWEB_LOGO@|$(GITWEB_LOGO)|g' \
+	-e 's|@GITWEB_FAVICON@|$(GITWEB_FAVICON)|g' \
+	-e 's|@GITWEB_JS@|$(GITWEB_JS)|g' \
+	-e 's|@GITWEB_SITE_HTML_HEAD_STRING@|$(GITWEB_SITE_HTML_HEAD_STRING)|g' \
+	-e 's|@GITWEB_SITE_HEADER@|$(GITWEB_SITE_HEADER)|g' \
+	-e 's|@GITWEB_SITE_FOOTER@|$(GITWEB_SITE_FOOTER)|g' \
+	-e 's|@HIGHLIGHT_BIN@|$(HIGHLIGHT_BIN)|g'
 
 .PHONY: FORCE
 $(MAK_DIR_GITWEB)GITWEB-BUILD-OPTIONS: FORCE
diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index c4e0008d597dc07c1043074c9fd1db0bd35653d2..dfb66fdd2aaf4df7d8aec4c70167bad6b0fee5e9 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -35,7 +35,7 @@ BEGIN
 	CGI->compile() if $ENV{'MOD_PERL'};
 }
 
-our $version = "++GIT_VERSION++";
+our $version = "@GIT_VERSION@";
 
 our ($my_url, $my_uri, $base_url, $path_info, $home_link);
 sub evaluate_uri {
@@ -80,46 +80,46 @@ sub evaluate_uri {
 
 # core git executable to use
 # this can just be "git" if your webserver has a sensible PATH
-our $GIT = "++GIT_BINDIR++/git";
+our $GIT = "@GIT_BINDIR@/git";
 
 # absolute fs-path which will be prepended to the project path
 #our $projectroot = "/pub/scm";
-our $projectroot = "++GITWEB_PROJECTROOT++";
+our $projectroot = "@GITWEB_PROJECTROOT@";
 
 # fs traversing limit for getting project list
 # the number is relative to the projectroot
-our $project_maxdepth = "++GITWEB_PROJECT_MAXDEPTH++";
+our $project_maxdepth = "@GITWEB_PROJECT_MAXDEPTH@";
 
 # string of the home link on top of all pages
-our $home_link_str = "++GITWEB_HOME_LINK_STR++";
+our $home_link_str = "@GITWEB_HOME_LINK_STR@";
 
 # extra breadcrumbs preceding the home link
 our @extra_breadcrumbs = ();
 
 # name of your site or organization to appear in page titles
 # replace this with something more descriptive for clearer bookmarks
-our $site_name = "++GITWEB_SITENAME++"
+our $site_name = "@GITWEB_SITENAME@"
                  || ($ENV{'SERVER_NAME'} || "Untitled") . " Git";
 
 # html snippet to include in the <head> section of each page
-our $site_html_head_string = "++GITWEB_SITE_HTML_HEAD_STRING++";
+our $site_html_head_string = "@GITWEB_SITE_HTML_HEAD_STRING@";
 # filename of html text to include at top of each page
-our $site_header = "++GITWEB_SITE_HEADER++";
+our $site_header = "@GITWEB_SITE_HEADER@";
 # html text to include at home page
-our $home_text = "++GITWEB_HOMETEXT++";
+our $home_text = "@GITWEB_HOMETEXT@";
 # filename of html text to include at bottom of each page
-our $site_footer = "++GITWEB_SITE_FOOTER++";
+our $site_footer = "@GITWEB_SITE_FOOTER@";
 
 # URI of stylesheets
-our @stylesheets = ("++GITWEB_CSS++");
+our @stylesheets = ("@GITWEB_CSS@");
 # URI of a single stylesheet, which can be overridden in GITWEB_CONFIG.
 our $stylesheet = undef;
 # URI of GIT logo (72x27 size)
-our $logo = "++GITWEB_LOGO++";
+our $logo = "@GITWEB_LOGO@";
 # URI of GIT favicon, assumed to be image/png type
-our $favicon = "++GITWEB_FAVICON++";
+our $favicon = "@GITWEB_FAVICON@";
 # URI of gitweb.js (JavaScript code for gitweb)
-our $javascript = "++GITWEB_JS++";
+our $javascript = "@GITWEB_JS@";
 
 # URI and label (title) of GIT logo link
 #our $logo_url = "https://www.kernel.org/pub/software/scm/git/docs/";
@@ -128,7 +128,7 @@ sub evaluate_uri {
 our $logo_label = "git homepage";
 
 # source of projects list
-our $projects_list = "++GITWEB_LIST++";
+our $projects_list = "@GITWEB_LIST@";
 
 # the width (in characters) of the projects list "Description" column
 our $projects_list_description_width = 25;
@@ -147,7 +147,7 @@ sub evaluate_uri {
 
 # show repository only if this file exists
 # (only effective if this variable evaluates to true)
-our $export_ok = "++GITWEB_EXPORT_OK++";
+our $export_ok = "@GITWEB_EXPORT_OK@";
 
 # don't generate age column on the projects list page
 our $omit_age_column = 0;
@@ -161,11 +161,11 @@ sub evaluate_uri {
 our $export_auth_hook = undef;
 
 # only allow viewing of repositories also shown on the overview page
-our $strict_export = "++GITWEB_STRICT_EXPORT++";
+our $strict_export = "@GITWEB_STRICT_EXPORT@";
 
 # list of git base URLs used for URL to where fetch project from,
 # i.e. full URL is "$git_base_url/$project"
-our @git_base_url_list = grep { $_ ne '' } ("++GITWEB_BASE_URL++");
+our @git_base_url_list = grep { $_ ne '' } ("@GITWEB_BASE_URL@");
 
 # default blob_plain mimetype and default charset for text/plain blob
 our $default_blob_plain_mimetype = 'text/plain';
@@ -200,7 +200,7 @@ sub evaluate_uri {
 # http://andre-simon.de/zip/download.php due to assumptions about parameters and output).
 # Useful if highlight is not installed on your webserver's PATH.
 # [Default: highlight]
-our $highlight_bin = "++HIGHLIGHT_BIN++";
+our $highlight_bin = "@HIGHLIGHT_BIN@";
 
 # information about snapshot formats that gitweb is capable of serving
 our %known_snapshot_formats = (
@@ -741,9 +741,9 @@ sub read_config_file {
 
 our ($GITWEB_CONFIG, $GITWEB_CONFIG_SYSTEM, $GITWEB_CONFIG_COMMON);
 sub evaluate_gitweb_config {
-	our $GITWEB_CONFIG = $ENV{'GITWEB_CONFIG'} || "++GITWEB_CONFIG++";
-	our $GITWEB_CONFIG_SYSTEM = $ENV{'GITWEB_CONFIG_SYSTEM'} || "++GITWEB_CONFIG_SYSTEM++";
-	our $GITWEB_CONFIG_COMMON = $ENV{'GITWEB_CONFIG_COMMON'} || "++GITWEB_CONFIG_COMMON++";
+	our $GITWEB_CONFIG = $ENV{'GITWEB_CONFIG'} || "@GITWEB_CONFIG@";
+	our $GITWEB_CONFIG_SYSTEM = $ENV{'GITWEB_CONFIG_SYSTEM'} || "@GITWEB_CONFIG_SYSTEM@";
+	our $GITWEB_CONFIG_COMMON = $ENV{'GITWEB_CONFIG_COMMON'} || "@GITWEB_CONFIG_COMMON@";
 
 	# Protect against duplications of file names, to not read config twice.
 	# Only one of $GITWEB_CONFIG and $GITWEB_CONFIG_SYSTEM is used, so
diff --git a/perl/Git/I18N.pm b/perl/Git/I18N.pm
index ab46edb608c711d3774ae117e7ab097fc1a156bf..162230af817722c8fe17fb11fcd1acd76add84b7 100644
--- a/perl/Git/I18N.pm
+++ b/perl/Git/I18N.pm
@@ -20,14 +20,14 @@ BEGIN
 # this "'@@' [...] '@@'" pattern.
 use constant NO_GETTEXT_STR => '@@' . 'NO_GETTEXT' . '@@';
 use constant NO_GETTEXT => (
-	q[@@NO_GETTEXT@@] ne ''
+	q[@NO_GETTEXT@] ne ''
 	and
-	q[@@NO_GETTEXT@@] ne NO_GETTEXT_STR
+	q[@NO_GETTEXT@] ne NO_GETTEXT_STR
 );
 
 sub __bootstrap_locale_messages {
 	our $TEXTDOMAIN = 'git';
-	our $TEXTDOMAINDIR ||= $ENV{GIT_TEXTDOMAINDIR} || '@@LOCALEDIR@@';
+	our $TEXTDOMAINDIR ||= $ENV{GIT_TEXTDOMAINDIR} || '@LOCALEDIR@';
 	die "NO_GETTEXT=" . NO_GETTEXT_STR if NO_GETTEXT;
 
 	require POSIX;
diff --git a/perl/Git/LoadCPAN.pm b/perl/Git/LoadCPAN.pm
index 61254fddbbb5059c52e517b74c76103d6c081426..92d63c71d24b65ff768a35b16a7f12c193d4d0eb 100644
--- a/perl/Git/LoadCPAN.pm
+++ b/perl/Git/LoadCPAN.pm
@@ -31,11 +31,11 @@ =head1 DESCRIPTION
 # Makefile, and allows for detecting whether the module is loaded from
 # perl/Git as opposed to perl/build/Git, which is useful for one-off
 # testing without having Error.pm et al installed.
-use constant NO_PERL_CPAN_FALLBACKS_STR => '@@' . 'NO_PERL_CPAN_FALLBACKS' . '@@';
+use constant NO_PERL_CPAN_FALLBACKS_STR => '@' . 'NO_PERL_CPAN_FALLBACKS' . '@';
 use constant NO_PERL_CPAN_FALLBACKS => (
-	q[@@NO_PERL_CPAN_FALLBACKS@@] ne ''
+	q[@NO_PERL_CPAN_FALLBACKS@] ne ''
 	and
-	q[@@NO_PERL_CPAN_FALLBACKS@@] ne NO_PERL_CPAN_FALLBACKS_STR
+	q[@NO_PERL_CPAN_FALLBACKS@] ne NO_PERL_CPAN_FALLBACKS_STR
 );
 
 sub import {
diff --git a/perl/header_templates/fixed_prefix.template.pl b/perl/header_templates/fixed_prefix.template.pl
index 857b4391a499394ea788a6b56773aecd5afd53c3..d571ca5cde513a98cc25e7acb52b5415b98ffe10 100644
--- a/perl/header_templates/fixed_prefix.template.pl
+++ b/perl/header_templates/fixed_prefix.template.pl
@@ -1 +1 @@
-use lib (split(/@@PATHSEP@@/, $ENV{GITPERLLIB} || '@@INSTLIBDIR@@'));
+use lib (split(/@PATHSEP@/, $ENV{GITPERLLIB} || '@INSTLIBDIR@'));
diff --git a/perl/header_templates/runtime_prefix.template.pl b/perl/header_templates/runtime_prefix.template.pl
index 9d28b3d8636c6c6d48ea287a5fef0f7833f6c08c..e6f8e661a164519d4fdb55429746380e84ae3fcb 100644
--- a/perl/header_templates/runtime_prefix.template.pl
+++ b/perl/header_templates/runtime_prefix.template.pl
@@ -3,7 +3,7 @@
 # This finds our Git::* libraries relative to the script's runtime path.
 sub __git_system_path {
 	my ($relpath) = @_;
-	my $gitexecdir_relative = '@@GITEXECDIR_REL@@';
+	my $gitexecdir_relative = '@GITEXECDIR_REL@';
 
 	# GIT_EXEC_PATH is supplied by `git` or the test suite.
 	my $exec_path;
@@ -24,11 +24,11 @@ sub __git_system_path {
 }
 
 BEGIN {
-	use lib split /@@PATHSEP@@/,
+	use lib split /@PATHSEP@/,
 	(
 		$ENV{GITPERLLIB} ||
 		do {
-			my $perllibdir = __git_system_path('@@PERLLIBDIR_REL@@');
+			my $perllibdir = __git_system_path('@PERLLIBDIR_REL@');
 			(-e $perllibdir) || die("Invalid system path ($relpath): $path");
 			$perllibdir;
 		}
@@ -36,7 +36,7 @@ BEGIN
 
 	# Export the system locale directory to the I18N module. The locale directory
 	# is only installed if NO_GETTEXT is set.
-	$Git::I18N::TEXTDOMAINDIR = __git_system_path('@@LOCALEDIR_REL@@');
+	$Git::I18N::TEXTDOMAINDIR = __git_system_path('@LOCALEDIR_REL@');
 }
 
 # END RUNTIME_PREFIX generated code.
diff --git a/unimplemented.sh b/unimplemented.sh
index fee21d24e8ab89208b4aa0af7007b7c033b753bc..41776b279d4263ae6a9034b30f1bd26ac9b792bd 100644
--- a/unimplemented.sh
+++ b/unimplemented.sh
@@ -1,4 +1,4 @@
 #!/bin/sh
 
-echo >&2 "fatal: git was built without support for $(basename $0) (@@REASON@@)."
+echo >&2 "fatal: git was built without support for $(basename $0) (@REASON@)."
 exit 128
diff --git a/wrap-for-bin.sh b/wrap-for-bin.sh
index 95851b85b6b7181130f0cd441c2bd7ac0bfb89da..7898a1c238dde20617cf96d144930dc59f67feab 100644
--- a/wrap-for-bin.sh
+++ b/wrap-for-bin.sh
@@ -4,33 +4,33 @@
 # to run test suite against sandbox, but with only bindir-installed
 # executables in PATH.  The Makefile copies this into various
 # files in bin-wrappers, substituting
-# @@BUILD_DIR@@ and @@PROG@@.
+# @BUILD_DIR@ and @PROG@.
 
-GIT_EXEC_PATH='@@BUILD_DIR@@'
+GIT_EXEC_PATH='@BUILD_DIR@'
 if test -n "$NO_SET_GIT_TEMPLATE_DIR"
 then
 	unset GIT_TEMPLATE_DIR
 else
-	GIT_TEMPLATE_DIR='@@BUILD_DIR@@/templates/blt'
+	GIT_TEMPLATE_DIR='@BUILD_DIR@/templates/blt'
 	export GIT_TEMPLATE_DIR
 fi
-GITPERLLIB='@@BUILD_DIR@@/perl/build/lib'"${GITPERLLIB:+:$GITPERLLIB}"
-GIT_TEXTDOMAINDIR='@@BUILD_DIR@@/po/build/locale'
-PATH='@@BUILD_DIR@@/bin-wrappers:'"$PATH"
+GITPERLLIB='@BUILD_DIR@/perl/build/lib'"${GITPERLLIB:+:$GITPERLLIB}"
+GIT_TEXTDOMAINDIR='@BUILD_DIR@/po/build/locale'
+PATH='@BUILD_DIR@/bin-wrappers:'"$PATH"
 
 export GIT_EXEC_PATH GITPERLLIB PATH GIT_TEXTDOMAINDIR
 
 case "$GIT_DEBUGGER" in
 '')
-	exec "${GIT_EXEC_PATH}/@@PROG@@" "$@"
+	exec "${GIT_EXEC_PATH}/@PROG@" "$@"
 	;;
 1)
 	unset GIT_DEBUGGER
-	exec gdb --args "${GIT_EXEC_PATH}/@@PROG@@" "$@"
+	exec gdb --args "${GIT_EXEC_PATH}/@PROG@" "$@"
 	;;
 *)
 	GIT_DEBUGGER_ARGS="$GIT_DEBUGGER"
 	unset GIT_DEBUGGER
-	exec ${GIT_DEBUGGER_ARGS} "${GIT_EXEC_PATH}/@@PROG@@" "$@"
+	exec ${GIT_DEBUGGER_ARGS} "${GIT_EXEC_PATH}/@PROG@" "$@"
 	;;
 esac

-- 
2.47.0.366.g5daf58cba8.dirty

