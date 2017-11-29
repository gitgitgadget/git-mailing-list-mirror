Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E35E320A40
	for <e@80x24.org>; Wed, 29 Nov 2017 15:57:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933647AbdK2P5D (ORCPT <rfc822;e@80x24.org>);
        Wed, 29 Nov 2017 10:57:03 -0500
Received: from mail-qk0-f170.google.com ([209.85.220.170]:43100 "EHLO
        mail-qk0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932989AbdK2P4r (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 29 Nov 2017 10:56:47 -0500
Received: by mail-qk0-f170.google.com with SMTP id j207so4939931qke.10
        for <git@vger.kernel.org>; Wed, 29 Nov 2017 07:56:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=YOGi2dyMgH2zX8VXOlp0XNesXN/CIGf7JUsnXnNO/pU=;
        b=PthraCV1qADdj3FIAv3AAz0riw88AcV2lhC9UwaWj0MCz6PbHAueKeToM7+unsjGco
         YvtvWooDZnQrOJLpxMUbZN47+/9G6i/sW2x2XpGqu4igHbrfa+qXVrjdMAvQ2fWgokwV
         +T8E/1X18xWsz8UDDUJsPA4FEgC2aOXaNqjqinRaAHugkBzk6wQDuX/jSyr/Lx/AnCfz
         lOhg/L4pmodHgxehFRVv4r5NYzSznEZdrLBCRF3AVRNSi7nlVjImmKnekJPy4Wt7qcFX
         HQocUgfKbkq5Gi01TEnC2zmN0CphOGz0JGLtA4ag8UX7P/Y0VSHYcaQkg3L2YVLIfKwG
         dB3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=YOGi2dyMgH2zX8VXOlp0XNesXN/CIGf7JUsnXnNO/pU=;
        b=TxNML88o1nlCghUJ3oBGM0UOopd+qzKK0f650AxNI0e1vi4JE8wYVJCy4WCgMU+IA0
         qcgnpRgtEfKX4791E6eNi73dVn6da0f/nSwFuYOozN4UfziuW9C/7B87oNxPi33T7nR1
         +Ho0/ZiwpBuS/XIhJEaUGEbrYqEu2eOvzU5ZJ6G3Ycd3CcEnaUb0oBIPx3O4lFG3Eajf
         iLMMB8BVrZIR7NQr1USnumoOfayUOtaZwv9z7EnlCDrK0WWSNg95XV3MkCdfZcNc+cLa
         FlWUQ7ZUeajpivtm6R9IHAi59RezdrW5ZsEu5LFYb/KLm/i8Y8ojexyoaTyiyeccAMcV
         a4fg==
X-Gm-Message-State: AJaThX5YsEkJHguiel0+gSEGguRit9LWcJDKluW/oqYYtOyzcCrvh0W4
        Xp2QutJhnWhWms8xWU4oyWkKAGda16g=
X-Google-Smtp-Source: AGs4zMZIifROoJPvCy0RsS8RwiGzqeCBE0oHaE9pEYUrzzUUDHxBwuDnRLi4qzOH7Szu2dyqf2pzuw==
X-Received: by 10.55.145.197 with SMTP id t188mr5064686qkd.267.1511971005652;
        Wed, 29 Nov 2017 07:56:45 -0800 (PST)
Received: from dnj-macbookpro.roam.corp.google.com.com ([100.67.16.103])
        by smtp.gmail.com with ESMTPSA id z126sm1390465qka.70.2017.11.29.07.56.44
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Wed, 29 Nov 2017 07:56:45 -0800 (PST)
From:   Dan Jacques <dnj@google.com>
To:     git@vger.kernel.org, gitster@pobox.com
Cc:     Johannes.Schindelin@gmx.de, avarab@gmail.com,
        Dan Jacques <dnj@google.com>
Subject: [PATCH v4 2/4] Makefile: add support for "perllibdir"
Date:   Wed, 29 Nov 2017 10:56:35 -0500
Message-Id: <20171129155637.89075-3-dnj@google.com>
X-Mailer: git-send-email 2.15.0.chromium12
In-Reply-To: <20171129155637.89075-1-dnj@google.com>
References: <20171129155637.89075-1-dnj@google.com>
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
index f7c4ac207..80904f8b0 100644
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

