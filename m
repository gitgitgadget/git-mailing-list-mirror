Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 096861F404
	for <e@80x24.org>; Tue, 10 Apr 2018 15:06:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754292AbeDJPGK (ORCPT <rfc822;e@80x24.org>);
        Tue, 10 Apr 2018 11:06:10 -0400
Received: from mail-qt0-f196.google.com ([209.85.216.196]:42107 "EHLO
        mail-qt0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753953AbeDJPGH (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 10 Apr 2018 11:06:07 -0400
Received: by mail-qt0-f196.google.com with SMTP id j3so13601221qtn.9
        for <git@vger.kernel.org>; Tue, 10 Apr 2018 08:06:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=I4tVoN3BJBFBUHv+9J2AJLBhL2jvJeZfn3Fv36F7Vwg=;
        b=GyDbVRS3bDhE0m7jT5WDoErEeZxA9vv+jZf4zjfELbjU4DDUIEw9Mwm+HX4i2rDeDo
         ez0Kycts6W4gMuBu2FeEkoGdz0lAsLD8EZsbT3XvXXbiLzIaX01Fwp/TZQGnFQU5ozOS
         n42f3qqXVAMyh1BqrDH+1/uFDy+YJ5yE/GvMLDxO/lTxIz3O76Jk+wdnz6PbD84KPtP5
         tiaVoT3VP225BOzCuPBx/QQ4uQHaJcv/ZE86kjtN0rGUxRTQR+Q+u+/nFwPSHtw+Hz7+
         0wGnNL3vx+dh1ks73EjGOfNfkcFn0LAl1ghREj5XTD1KhdJzrBphj6mkyfRMsgdtLwL8
         HWyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=I4tVoN3BJBFBUHv+9J2AJLBhL2jvJeZfn3Fv36F7Vwg=;
        b=IyInwTGv8kt3L0X7DKqMRNGKAm3jgn3VBZN0GbaHchzptidxgYse9M6RlJn09UJGJD
         Jht/5XdqXeE0HQHDIORQoMexhuV0chTbifitcdD85sLL1xOWgM2gMxkcMACveX5p4/OK
         VxYyzW/r65T4elntGJa4vAvu0F9XaRvNCwC6Hbr8xyeJLVtQhRDBHpjv4urLmD/BsMa9
         qzeDZ8KoIf3Q27ne7/3amWk6M+UMrfr3qS1ulhSlcIA/zl78bGJZrGnANJIbIA5o/Neo
         J0Eces8DQ+XMJ2g/J3Dgar6caQwwiAAzLc2YkYMkyn3wisV5L7tcV7zhc5zm1haAA1sD
         nLsw==
X-Gm-Message-State: ALQs6tAVvhkFKKn2eR2G5TvlA+ngkxtmuI9chi+812OVJPGbRSuuRB6I
        XvrSS1h+81FZrUKALKNwFsPEa4npQ/w=
X-Google-Smtp-Source: AIpwx491OSlC85uOYwy07gLSoHU2iSvM2fpXAo8TXClk0axhellk8LFJGWlT8q3dNNwJxkq+0n4hhA==
X-Received: by 10.237.33.167 with SMTP id l36mr1165303qtc.265.1523372765216;
        Tue, 10 Apr 2018 08:06:05 -0700 (PDT)
Received: from dnj-macbookpro.roam.corp.google.com.com ([100.67.16.96])
        by smtp.gmail.com with ESMTPSA id c137sm2333526qkb.2.2018.04.10.08.06.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 10 Apr 2018 08:06:02 -0700 (PDT)
From:   Dan Jacques <dnj@google.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, avarab@gmail.com, Johannes.Schindelin@gmx.de,
        Dan Jacques <dnj@google.com>
Subject: [PATCH v8 2/5] Makefile: add Perl runtime prefix support
Date:   Tue, 10 Apr 2018 11:05:43 -0400
Message-Id: <20180410150546.38062-3-dnj@google.com>
X-Mailer: git-send-email 2.15.0.chromium12
In-Reply-To: <20180410150546.38062-1-dnj@google.com>
References: <20180410150546.38062-1-dnj@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Broaden the RUNTIME_PREFIX flag to configure Git's Perl scripts to
locate the Git installation's Perl support libraries by resolving
against the script's path, rather than hard-coding that path at
build-time. Hard-coding at build time worked on previous
RUNTIME_PREFIX configurations (i.e., Windows) because the Perl
scripts were run within a virtual filesystem whose paths were
consistent regardless of the location of the actual installation.
This will no longer be the case for non-Windows RUNTIME_PREFIX users.

When enabled, RUNTIME_PREFIX now requires Perl's system paths to be
expressed relative to a common installation directory in the Makefile,
and uses that relationship to locate support files based on the known
starting point of the script being executed, much like RUNTIME_PREFIX
does for the Git binary.

This change enables Git's Perl scripts to work when their Git installation
is relocated or moved to another system, even when they are not in a
virtual filesystem environment.

Signed-off-by: Dan Jacques <dnj@google.com>
Thanks-to: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
Thanks-to: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 Makefile                                         | 65 +++++++++++++++++++++++-
 perl/Git/I18N.pm                                 |  2 +-
 perl/header_templates/runtime_prefix.template.pl | 42 +++++++++++++++
 3 files changed, 107 insertions(+), 2 deletions(-)
 create mode 100644 perl/header_templates/runtime_prefix.template.pl

diff --git a/Makefile b/Makefile
index ec7cf5a0f..13fb0e19a 100644
--- a/Makefile
+++ b/Makefile
@@ -441,6 +441,13 @@ all::
 #
 # When cross-compiling, define HOST_CPU as the canonical name of the CPU on
 # which the built Git will run (for instance "x86_64").
+#
+# Define RUNTIME_PREFIX to configure Git to resolve its ancillary tooling and
+# support files relative to the location of the runtime binary, rather than
+# hard-coding them into the binary. Git installations built with RUNTIME_PREFIX
+# can be moved to arbitrary filesystem locations. RUNTIME_PREFIX also causes
+# Perl scripts to use a modified entry point header allowing them to resolve
+# support files at runtime.
 
 GIT-VERSION-FILE: FORCE
 	@$(SHELL_PATH) ./GIT-VERSION-GEN
@@ -478,6 +485,8 @@ ARFLAGS = rcs
 #   mandir
 #   infodir
 #   htmldir
+#   localedir
+#   perllibdir
 # This can help installing the suite in a relocatable way.
 
 prefix = $(HOME)
@@ -502,7 +511,9 @@ bindir_relative = $(patsubst $(prefix)/%,%,$(bindir))
 mandir_relative = $(patsubst $(prefix)/%,%,$(mandir))
 infodir_relative = $(patsubst $(prefix)/%,%,$(infodir))
 gitexecdir_relative = $(patsubst $(prefix)/%,%,$(gitexecdir))
+localedir_relative = $(patsubst $(prefix)/%,%,$(localedir))
 htmldir_relative = $(patsubst $(prefix)/%,%,$(htmldir))
+perllibdir_relative = $(patsubst $(prefix)/%,%,$(perllibdir))
 
 export prefix bindir sharedir sysconfdir gitwebdir perllibdir localedir
 
@@ -1748,11 +1759,13 @@ mandir_relative_SQ = $(subst ','\'',$(mandir_relative))
 infodir_relative_SQ = $(subst ','\'',$(infodir_relative))
 perllibdir_SQ = $(subst ','\'',$(perllibdir))
 localedir_SQ = $(subst ','\'',$(localedir))
+localedir_relative_SQ = $(subst ','\'',$(localedir_relative))
 gitexecdir_SQ = $(subst ','\'',$(gitexecdir))
 gitexecdir_relative_SQ = $(subst ','\'',$(gitexecdir_relative))
 template_dir_SQ = $(subst ','\'',$(template_dir))
 htmldir_relative_SQ = $(subst ','\'',$(htmldir_relative))
 prefix_SQ = $(subst ','\'',$(prefix))
+perllibdir_relative_SQ = $(subst ','\'',$(perllibdir_relative))
 gitwebdir_SQ = $(subst ','\'',$(gitwebdir))
 
 SHELL_PATH_SQ = $(subst ','\'',$(SHELL_PATH))
@@ -1763,6 +1776,31 @@ TCLTK_PATH_SQ = $(subst ','\'',$(TCLTK_PATH))
 DIFF_SQ = $(subst ','\'',$(DIFF))
 PERLLIB_EXTRA_SQ = $(subst ','\'',$(PERLLIB_EXTRA))
 
+# RUNTIME_PREFIX's resolution logic requires resource paths to be expressed
+# relative to each other and share an installation path.
+#
+# This is a dependency in:
+# - Git's binary RUNTIME_PREFIX logic in (see "exec_cmd.c").
+# - The runtime prefix Perl header (see
+#   "perl/header_templates/runtime_prefix.template.pl").
+ifdef RUNTIME_PREFIX
+
+ifneq ($(filter /%,$(firstword $(gitexecdir_relative))),)
+$(error RUNTIME_PREFIX requires a relative gitexecdir, not: $(gitexecdir))
+endif
+
+ifneq ($(filter /%,$(firstword $(localedir_relative))),)
+$(error RUNTIME_PREFIX requires a relative localedir, not: $(localedir))
+endif
+
+ifndef NO_PERL
+ifneq ($(filter /%,$(firstword $(perllibdir_relative))),)
+$(error RUNTIME_PREFIX requires a relative perllibdir, not: $(perllibdir))
+endif
+endif
+
+endif
+
 # We must filter out any object files from $(GITLIBS),
 # as it is typically used like:
 #
@@ -1983,10 +2021,31 @@ git.res: git.rc GIT-VERSION-FILE
 # This makes sure we depend on the NO_PERL setting itself.
 $(SCRIPT_PERL_GEN): GIT-BUILD-OPTIONS
 
+# Used for substitution in Perl modules. Disabled when using RUNTIME_PREFIX
+# since the locale directory is injected.
+perl_localedir_SQ = $(localedir_SQ)
+
 ifndef NO_PERL
 PERL_HEADER_TEMPLATE = perl/header_templates/fixed_prefix.template.pl
 PERL_DEFINES = $(PERL_PATH_SQ):$(PERLLIB_EXTRA_SQ):$(perllibdir_SQ)
 
+PERL_DEFINES := $(PERL_PATH_SQ) $(PERLLIB_EXTRA_SQ) $(perllibdir_SQ)
+PERL_DEFINES += $(RUNTIME_PREFIX)
+
+# Support Perl runtime prefix. In this mode, a different header is installed
+# into Perl scripts.
+ifdef RUNTIME_PREFIX
+
+PERL_HEADER_TEMPLATE = perl/header_templates/runtime_prefix.template.pl
+
+# Don't export a fixed $(localedir) path; it will be resolved by the Perl header
+# at runtime.
+perl_localedir_SQ =
+
+endif
+
+PERL_DEFINES += $(gitexecdir) $(perllibdir) $(localedir)
+
 $(SCRIPT_PERL_GEN): % : %.perl GIT-PERL-DEFINES GIT-PERL-HEADER GIT-VERSION-FILE
 	$(QUIET_GEN)$(RM) $@ $@+ && \
 	sed -e '1{' \
@@ -1999,6 +2058,7 @@ $(SCRIPT_PERL_GEN): % : %.perl GIT-PERL-DEFINES GIT-PERL-HEADER GIT-VERSION-FILE
 	chmod +x $@+ && \
 	mv $@+ $@
 
+PERL_DEFINES := $(subst $(space),:,$(PERL_DEFINES))
 GIT-PERL-DEFINES: FORCE
 	@FLAGS='$(PERL_DEFINES)'; \
 	    if test x"$$FLAGS" != x"`cat $@ 2>/dev/null`" ; then \
@@ -2014,6 +2074,9 @@ GIT-PERL-HEADER: $(PERL_HEADER_TEMPLATE) GIT-PERL-DEFINES Makefile
 	sed -e 's=@@PATHSEP@@=$(pathsep)=g' \
 	    -e 's=@@INSTLIBDIR@@='$$INSTLIBDIR'=g' \
 	    -e 's=@@PERLLIBDIR@@='$(perllibdir_SQ)'=g' \
+	    -e 's=@@PERLLIBDIR_REL@@=$(perllibdir_relative_SQ)=g' \
+	    -e 's=@@GITEXECDIR_REL@@=$(gitexecdir_relative_SQ)=g' \
+	    -e 's=@@LOCALEDIR_REL@@=$(localedir_relative_SQ)=g' \
 	    $< >$@+ && \
 	mv $@+ $@
 
@@ -2337,7 +2400,7 @@ endif
 
 perl/build/lib/%.pm: perl/%.pm
 	$(QUIET_GEN)mkdir -p $(dir $@) && \
-	sed -e 's|@@LOCALEDIR@@|$(localedir_SQ)|g' \
+	sed -e 's|@@LOCALEDIR@@|$(perl_localedir_SQ)|g' \
 	    -e 's|@@NO_PERL_CPAN_FALLBACKS@@|$(NO_PERL_CPAN_FALLBACKS_SQ)|g' \
 	< $< > $@
 
diff --git a/perl/Git/I18N.pm b/perl/Git/I18N.pm
index dba96fff0..bfb4fb67a 100644
--- a/perl/Git/I18N.pm
+++ b/perl/Git/I18N.pm
@@ -18,7 +18,7 @@ our @EXPORT_OK = @EXPORT;
 
 sub __bootstrap_locale_messages {
 	our $TEXTDOMAIN = 'git';
-	our $TEXTDOMAINDIR = $ENV{GIT_TEXTDOMAINDIR} || '@@LOCALEDIR@@';
+	our $TEXTDOMAINDIR ||= $ENV{GIT_TEXTDOMAINDIR} || '@@LOCALEDIR@@';
 
 	require POSIX;
 	POSIX->import(qw(setlocale));
diff --git a/perl/header_templates/runtime_prefix.template.pl b/perl/header_templates/runtime_prefix.template.pl
new file mode 100644
index 000000000..9d28b3d86
--- /dev/null
+++ b/perl/header_templates/runtime_prefix.template.pl
@@ -0,0 +1,42 @@
+# BEGIN RUNTIME_PREFIX generated code.
+#
+# This finds our Git::* libraries relative to the script's runtime path.
+sub __git_system_path {
+	my ($relpath) = @_;
+	my $gitexecdir_relative = '@@GITEXECDIR_REL@@';
+
+	# GIT_EXEC_PATH is supplied by `git` or the test suite.
+	my $exec_path;
+	if (exists $ENV{GIT_EXEC_PATH}) {
+		$exec_path = $ENV{GIT_EXEC_PATH};
+	} else {
+		# This can happen if this script is being directly invoked instead of run
+		# by "git".
+		require FindBin;
+		$exec_path = $FindBin::Bin;
+	}
+
+	# Trim off the relative gitexecdir path to get the system path.
+	(my $prefix = $exec_path) =~ s/\Q$gitexecdir_relative\E$//;
+
+	require File::Spec;
+	return File::Spec->catdir($prefix, $relpath);
+}
+
+BEGIN {
+	use lib split /@@PATHSEP@@/,
+	(
+		$ENV{GITPERLLIB} ||
+		do {
+			my $perllibdir = __git_system_path('@@PERLLIBDIR_REL@@');
+			(-e $perllibdir) || die("Invalid system path ($relpath): $path");
+			$perllibdir;
+		}
+	);
+
+	# Export the system locale directory to the I18N module. The locale directory
+	# is only installed if NO_GETTEXT is set.
+	$Git::I18N::TEXTDOMAINDIR = __git_system_path('@@LOCALEDIR_REL@@');
+}
+
+# END RUNTIME_PREFIX generated code.
-- 
2.15.0.chromium12

