Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 892F520C11
	for <e@80x24.org>; Mon, 27 Nov 2017 16:41:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932195AbdK0QlW (ORCPT <rfc822;e@80x24.org>);
        Mon, 27 Nov 2017 11:41:22 -0500
Received: from mail-qt0-f178.google.com ([209.85.216.178]:41031 "EHLO
        mail-qt0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932104AbdK0QlG (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 27 Nov 2017 11:41:06 -0500
Received: by mail-qt0-f178.google.com with SMTP id i40so28632761qti.8
        for <git@vger.kernel.org>; Mon, 27 Nov 2017 08:41:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=vzgcl9Qdc9i2YPher3qguEcVGbg908WOY/H5bQ5hP4U=;
        b=gbsP/E5VkuMkviIuwiE5guxY6Wlg7AtZlrvtH8OUinDaPyYf7jPnrHB1H3lOhzzPyV
         yyFxKWJUF2sQWnq2RarTf4UU69hcec70xFNsptffemV6hZ6UJs5C7WYa6foWDTQdK0LR
         YBQdLnk9N/8w0P8/uazF+rt4uI091Ugr9wVzkPsakg8j6rgXJJyqIw5u+Sjm2ubO3l/U
         +Hpa/PrBNw5Mt3J+tsXOZuB5iMYTn/SrP2K2xYnQ/zmKQwoibxOHghYPgZOVa5Wux0Yj
         Zps1Hb0xjWog8Qqnj94aYwXTPKd2sfAA949CC3H8iEhgZxEo8d7PRujaFVgt5s2ct6Wo
         d++w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=vzgcl9Qdc9i2YPher3qguEcVGbg908WOY/H5bQ5hP4U=;
        b=KcSDMH4yBecpS3NAVvnWJTVy0rWpePNsbNjnf9scYs3rUD/Xgfjw0JzoUe0HUi0Ct2
         nZe2Laca+4J9YKk+XQO1sbxW9FRvre6ON5S8Z9fUXRtZZXfZz8S/M2IT08yqoOFCdcVj
         Cnwu9M/YC8++YRaHe48EI04BErE57XGGhmB3G82gjedsrg767DY5P8QQAlbc/7F4RR9O
         hZKSJvBnWAXOlPgGIn5ohQUtKbekqhJqN6NLQLXX6liz6UUu4/nySAL1cuKooHdDm+Ob
         g95YOWSZJh7kx/qgoTvhedkN5VGdms/7T/bjY3qSnlmDeTr4QOLUhuo5u7jxs77rmDOb
         cR6Q==
X-Gm-Message-State: AJaThX7lI3Xn0cT2b7hxmgiXBIFASAonjkTp0gg2xoFJdojooVau535/
        eQ5t3Op+Yr5dRqA/T2ePm7J3A5psg1U=
X-Google-Smtp-Source: AGs4zMbdePtublqtXU/hogfj4Inb884FhtPH5kVAMoX6fy4Kxxq9aLBPMKX/NrbJnVGNFdCpiF2bDg==
X-Received: by 10.200.53.238 with SMTP id l43mr59825214qtb.269.1511800864065;
        Mon, 27 Nov 2017 08:41:04 -0800 (PST)
Received: from dnj-macbookpro.fios-router.home (pool-108-32-46-175.pitbpa.fios.verizon.net. [108.32.46.175])
        by smtp.gmail.com with ESMTPSA id y9sm9696394qkl.17.2017.11.27.08.41.02
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Mon, 27 Nov 2017 08:41:02 -0800 (PST)
From:   Dan Jacques <dnj@google.com>
To:     git@vger.kernel.org
Cc:     Johannes.Schindelin@gmx.de, avarab@gmail.com, dnj@google.com,
        gitster@pobox.com
Subject: [PATCH v3 2/4] Makefile: add support for "perllibdir"
Date:   Mon, 27 Nov 2017 11:40:53 -0500
Message-Id: <20171127164055.93283-3-dnj@google.com>
X-Mailer: git-send-email 2.15.0.chromium12
In-Reply-To: <20171127164055.93283-1-dnj@google.com>
References: <20171127164055.93283-1-dnj@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add the "perllibdir" Makefile variable, which allows the customization
of the Perl library installation path.

The Perl library installation path is currently left entirely to the
Perl Makefile implementation, either MakeMaker (default) or a fixed path
when NO_PERL_MAKEMAKER is enabled. This patch introduces "perllibdir", a
Makefile variable that can override that Perl module installation path.

As with some other Makefile variables, "perllibdir" may be either
absolute or relative. In the latter case, it is treated as relative to
"$(prefix)".

Add some incidental documentation to perl/Makefile.

Explicitly specifying an installation path is necessary for Perl runtime
prefix support, as runtime prefix resolution code must know in advance
where the Perl support modules are installed.

Signed-off-by: Dan Jacques <dnj@google.com>
---
 Makefile      | 18 +++++++++++++-----
 perl/Makefile | 52 ++++++++++++++++++++++++++++++++++++++++++++++------
 2 files changed, 59 insertions(+), 11 deletions(-)

diff --git a/Makefile b/Makefile
index 5ad60a54c..7a2ed8857 100644
--- a/Makefile
+++ b/Makefile
@@ -462,6 +462,7 @@ ARFLAGS = rcs
 #   mandir
 #   infodir
 #   htmldir
+#   perllibdir
 # This can help installing the suite in a relocatable way.
 
 prefix = $(HOME)
@@ -1721,6 +1722,7 @@ gitexecdir_SQ = $(subst ','\'',$(gitexecdir))
 template_dir_SQ = $(subst ','\'',$(template_dir))
 htmldir_relative_SQ = $(subst ','\'',$(htmldir_relative))
 prefix_SQ = $(subst ','\'',$(prefix))
+perllibdir_SQ = $(subst ','\'',$(perllibdir))
 gitwebdir_SQ = $(subst ','\'',$(gitwebdir))
 
 SHELL_PATH_SQ = $(subst ','\'',$(SHELL_PATH))
@@ -1955,17 +1957,22 @@ $(SCRIPT_PERL_GEN): perl/perl.mak
 
 perl/perl.mak: perl/PM.stamp
 
-perl/PM.stamp: FORCE
+perl/PM.stamp: GIT-PERL-DEFINES FORCE
 	@$(FIND) perl -type f -name '*.pm' | sort >$@+ && \
+	cat GIT-PERL-DEFINES >>$@+ && \
 	$(PERL_PATH) -V >>$@+ && \
 	{ cmp $@+ $@ >/dev/null 2>/dev/null || mv $@+ $@; } && \
 	$(RM) $@+
 
-perl/perl.mak: GIT-CFLAGS GIT-PREFIX perl/Makefile perl/Makefile.PL
-	$(QUIET_SUBDIR0)perl $(QUIET_SUBDIR1) PERL_PATH='$(PERL_PATH_SQ)' prefix='$(prefix_SQ)' $(@F)
-
 PERL_HEADER_TEMPLATE = perl/header_fixed_prefix.pl.template
-PERL_DEFINES = $(PERL_PATH_SQ):$(PERLLIB_EXTRA_SQ)
+
+PERL_DEFINES := $(PERL_PATH_SQ) $(PERLLIB_EXTRA_SQ)
+PERL_DEFINES += $(NO_PERL_MAKEMAKER)
+PERL_DEFINES += $(perllibdir)
+
+perl/perl.mak: GIT-CFLAGS GIT-PREFIX perl/Makefile perl/Makefile.PL
+	$(QUIET_SUBDIR0)perl $(QUIET_SUBDIR1) PERL_PATH='$(PERL_PATH_SQ)' \
+	  prefix='$(prefix_SQ)' perllibdir='$(perllibdir_SQ)' $(@F)
 
 $(SCRIPT_PERL_GEN): % : %.perl perl/perl.mak GIT-PERL-DEFINES GIT-PERL-HEADER GIT-VERSION-FILE
 	$(QUIET_GEN)$(RM) $@ $@+ && \
@@ -1979,6 +1986,7 @@ $(SCRIPT_PERL_GEN): % : %.perl perl/perl.mak GIT-PERL-DEFINES GIT-PERL-HEADER GI
 	chmod +x $@+ && \
 	mv $@+ $@
 
+PERL_DEFINES := $(subst $(space),:,$(PERL_DEFINES))
 GIT-PERL-DEFINES: FORCE
 	@FLAGS='$(PERL_DEFINES)'; \
 	    if test x"$$FLAGS" != x"`cat $@ 2>/dev/null`" ; then \
diff --git a/perl/Makefile b/perl/Makefile
index f657de20e..b2aeeb0d8 100644
--- a/perl/Makefile
+++ b/perl/Makefile
@@ -1,6 +1,22 @@
 #
 # Makefile for perl support modules and routine
 #
+# This Makefile generates "perl.mak", which contains the actual build and
+# installation directions.
+#
+# PERL_PATH must be defined to be the path of the Perl interpreter to use.
+#
+# prefix must be defined as the Git installation prefix.
+#
+# localedir must be defined as the path to the locale data.
+#
+# perllibdir may be optionally defined to override the default Perl module
+# installation directory, which is relative to prefix. If perllibdir is not
+# absolute, it will be treated as relative to prefix.
+#
+# NO_PERL_MAKEMAKER may be defined to use a built-in Makefile generation method
+# instead of Perl MakeMaker.
+
 makfile:=perl.mak
 modules =
 
@@ -12,6 +28,16 @@ ifndef V
 	QUIET = @
 endif
 
+# If a library directory is provided, and it is not an absolute path, resolve
+# it relative to prefix.
+ifneq ($(perllibdir),)
+ifneq ($(filter /%,$(firstword $(perllibdir))),)
+perllib_instdir = $(perllibdir)
+else
+perllib_instdir = $(prefix)/$(perllibdir)
+endif
+endif
+
 all install instlibdir: $(makfile)
 	$(QUIET)$(MAKE) -f $(makfile) $@
 
@@ -25,7 +51,12 @@ clean:
 $(makfile): PM.stamp
 
 ifdef NO_PERL_MAKEMAKER
-instdir_SQ = $(subst ','\'',$(prefix)/lib)
+
+ifeq ($(perllib_instdir),)
+perllib_instdir = $(prefix)/lib
+endif
+
+instdir_SQ = $(subst ','\'',$(perllib_instdir))
 
 modules += Git
 modules += Git/I18N
@@ -42,7 +73,7 @@ modules += Git/SVN/Prompt
 modules += Git/SVN/Ra
 modules += Git/SVN/Utils
 
-$(makfile): ../GIT-CFLAGS Makefile
+$(makfile): ../GIT-CFLAGS ../GIT-PERL-DEFINES Makefile
 	echo all: private-Error.pm Git.pm Git/I18N.pm > $@
 	set -e; \
 	for i in $(modules); \
@@ -79,12 +110,21 @@ $(makfile): ../GIT-CFLAGS Makefile
 	echo '	cp private-Error.pm "$$(DESTDIR)$(instdir_SQ)/Error.pm"' >> $@
 	echo instlibdir: >> $@
 	echo '	echo $(instdir_SQ)' >> $@
+
 else
-$(makfile): Makefile.PL ../GIT-CFLAGS
-	$(PERL_PATH) $< PREFIX='$(prefix_SQ)' INSTALL_BASE='' --localedir='$(localedir_SQ)'
+
+# This may be empty if perllibdir was empty.
+instdir_SQ = $(subst ','\'',$(perllib_instdir))
+
+$(makfile): Makefile.PL ../GIT-CFLAGS ../GIT-PERL-DEFINES
+	$(PERL_PATH) $< \
+	  PREFIX='$(prefix_SQ)' INSTALL_BASE='' \
+	  LIB='$(instdir_SQ)' \
+	  --localedir='$(localedir_SQ)'
+
 endif
 
 # this is just added comfort for calling make directly in perl dir
 # (even though GIT-CFLAGS aren't used yet. If ever)
-../GIT-CFLAGS:
-	$(MAKE) -C .. GIT-CFLAGS
+../GIT-CFLAGS ../GIT-PERL-DEFINES:
+	$(MAKE) -C .. $(@F)
-- 
2.15.0.chromium12

