Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0D0901F404
	for <e@80x24.org>; Mon, 19 Mar 2018 02:51:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754992AbeCSCu5 (ORCPT <rfc822;e@80x24.org>);
        Sun, 18 Mar 2018 22:50:57 -0400
Received: from mail-qk0-f195.google.com ([209.85.220.195]:40745 "EHLO
        mail-qk0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754917AbeCSCuy (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 18 Mar 2018 22:50:54 -0400
Received: by mail-qk0-f195.google.com with SMTP id o64so1175077qkl.7
        for <git@vger.kernel.org>; Sun, 18 Mar 2018 19:50:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=0LVIdLk0PnNoPg1wDA8XlhQCO7d+4HxwhQ4o5y1UtNk=;
        b=amtvWHVemzj7yCmvh5cJZHwnZ6rcR1d9n/E9qO1K5Z/MfKFek7cbzzmRhSjzE9VpBJ
         K1iPRf74r8xHvnK4BWoviIivqv9BH0dP8pMoqMuexfHRP7l9qr63hSp1R+7CBYkZ6Puj
         bQpkx8kC4SnodN7HELy8OB0ZGKTDkDuuSybXlp7EMSiCpZGlNjAxBxNfTv2Yn2umf/n7
         dim4cjHpeQG12ZIL+YwsPlt8MMPshjtWuvtg+XciMBhTY10nB9DP441XAULRp0zqwDw7
         XGz7sHctyVFDK7CRwHM9DebXbsV4Mw4KaGCyaj+KEmiMVQhzldkPdQM8pZChGn9TFIY+
         JUsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0LVIdLk0PnNoPg1wDA8XlhQCO7d+4HxwhQ4o5y1UtNk=;
        b=N76QTykAHeZa5SrAWHadqGlewO+M5NFKvZ5elNApWF3cZE1Nb7kN6KURe9TSs+FJRn
         ENdzjxu49cnrBVwkxkg1VRxw1hChJhQYiiV/nZjQ3kAnrEMl2TLbFKpGMuKB7c/0givX
         5vtLVJsYZAZpwTMLcfX0TgLf51nf7UVzEpCvzi/BQOKMb1Wa0zh1rFY/IdrVJ0vno+37
         urLBBxqcCKc2bZLd3wdg6fo7pO/S4vgFOzHIywToMu6uGz4pjkLRG6Df1ArmaRcVChVQ
         B9UoYbJ4TH27ScrucFsCJVu9cGVpprGn9XmiWWiGIJZNu4EbLCsNZk7aryDPMimAV7eW
         09hA==
X-Gm-Message-State: AElRT7F0muG7dGg5TOqcEjZr9GaJiAiDD6UUBqTqo2uDoCAW7glG7T0k
        bNr6w+hCgwXxw3Js6G2MllzSdrEavAQ=
X-Google-Smtp-Source: AG47ELvqDPRTIOSS1oEUCC4Qb+LpQW4kpqE+wQbYmt53DZ1awOzzVa3elpxicV8zrVU38a0KY6aFKw==
X-Received: by 10.55.144.71 with SMTP id s68mr15355050qkd.285.1521427852499;
        Sun, 18 Mar 2018 19:50:52 -0700 (PDT)
Received: from localhost.localdomain (pool-74-109-218-108.pitbpa.fios.verizon.net. [74.109.218.108])
        by smtp.gmail.com with ESMTPSA id x8sm9877902qta.64.2018.03.18.19.50.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 18 Mar 2018 19:50:51 -0700 (PDT)
From:   Dan Jacques <dnj@google.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, avarab@gmail.com, Johannes.Schindelin@gmx.de,
        Dan Jacques <dnj@google.com>
Subject: [PATCH v6 2/3] Makefile: add Perl runtime prefix support
Date:   Sun, 18 Mar 2018 22:50:45 -0400
Message-Id: <20180319025046.58052-3-dnj@google.com>
X-Mailer: git-send-email 2.15.0.chromium12
In-Reply-To: <20180319025046.58052-1-dnj@google.com>
References: <20180319025046.58052-1-dnj@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add a new Makefile flag, RUNTIME_PREFIX_PERL, which, when enabled,
configures Perl scripts to locate the Git installation's Perl support
libraries by resolving against the script's path, rather than
hard-coding that path at build-time.

RUNTIME_PREFIX_PERL requires that system paths are expressed relative to
a common installation directory, and uses that relationship to locate
support files based on the known starting point of the script being
executed, much like RUNTIME_PREFIX does for the Git binary.

This change enables Git's Perl scripts to work when their Git installation
is relocated or moved to another system.

Signed-off-by: Dan Jacques <dnj@google.com>
Thanks-to: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
Thanks-to: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 Makefile                                         | 67 +++++++++++++++++++++++-
 perl/Git/I18N.pm                                 |  2 +-
 perl/header_templates/runtime_prefix.template.pl | 40 ++++++++++++++
 3 files changed, 107 insertions(+), 2 deletions(-)
 create mode 100644 perl/header_templates/runtime_prefix.template.pl

diff --git a/Makefile b/Makefile
index e479822ce..101a98a78 100644
--- a/Makefile
+++ b/Makefile
@@ -434,6 +434,13 @@ all::
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
@@ -471,6 +478,8 @@ ARFLAGS = rcs
 #   mandir
 #   infodir
 #   htmldir
+#   localedir
+#   perllibdir
 # This can help installing the suite in a relocatable way.
 
 prefix = $(HOME)
@@ -492,9 +501,12 @@ lib = lib
 # DESTDIR =
 pathsep = :
 
+gitexecdir_relative = $(patsubst $(prefix)/%,%,$(gitexecdir))
 mandir_relative = $(patsubst $(prefix)/%,%,$(mandir))
 infodir_relative = $(patsubst $(prefix)/%,%,$(infodir))
+localedir_relative = $(patsubst $(prefix)/%,%,$(localedir))
 htmldir_relative = $(patsubst $(prefix)/%,%,$(htmldir))
+perllibdir_relative = $(patsubst $(prefix)/%,%,$(perllibdir))
 
 export prefix bindir sharedir sysconfdir gitwebdir perllibdir localedir
 
@@ -1740,10 +1752,13 @@ mandir_relative_SQ = $(subst ','\'',$(mandir_relative))
 infodir_relative_SQ = $(subst ','\'',$(infodir_relative))
 perllibdir_SQ = $(subst ','\'',$(perllibdir))
 localedir_SQ = $(subst ','\'',$(localedir))
+localedir_relative_SQ = $(subst ','\'',$(localedir_relative))
 gitexecdir_SQ = $(subst ','\'',$(gitexecdir))
+gitexecdir_relative_SQ = $(subst ','\'',$(gitexecdir_relative))
 template_dir_SQ = $(subst ','\'',$(template_dir))
 htmldir_relative_SQ = $(subst ','\'',$(htmldir_relative))
 prefix_SQ = $(subst ','\'',$(prefix))
+perllibdir_relative_SQ = $(subst ','\'',$(perllibdir_relative))
 gitwebdir_SQ = $(subst ','\'',$(gitwebdir))
 
 SHELL_PATH_SQ = $(subst ','\'',$(SHELL_PATH))
@@ -1754,6 +1769,31 @@ TCLTK_PATH_SQ = $(subst ','\'',$(TCLTK_PATH))
 DIFF_SQ = $(subst ','\'',$(DIFF))
 PERLLIB_EXTRA_SQ = $(subst ','\'',$(PERLLIB_EXTRA))
 
+# RUNTIME_PREFIX's resolution logic requires resource paths to be expressed
+# relative to each other and share an installation path.
+#
+# This is a dependnecy in:
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
@@ -1974,10 +2014,31 @@ git.res: git.rc GIT-VERSION-FILE
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
@@ -1990,6 +2051,7 @@ $(SCRIPT_PERL_GEN): % : %.perl GIT-PERL-DEFINES GIT-PERL-HEADER GIT-VERSION-FILE
 	chmod +x $@+ && \
 	mv $@+ $@
 
+PERL_DEFINES := $(subst $(space),:,$(PERL_DEFINES))
 GIT-PERL-DEFINES: FORCE
 	@FLAGS='$(PERL_DEFINES)'; \
 	    if test x"$$FLAGS" != x"`cat $@ 2>/dev/null`" ; then \
@@ -2005,6 +2067,9 @@ GIT-PERL-HEADER: $(PERL_HEADER_TEMPLATE) GIT-PERL-DEFINES Makefile
 	sed -e 's=@@PATHSEP@@=$(pathsep)=g' \
 	    -e 's=@@INSTLIBDIR@@='$$INSTLIBDIR'=g' \
 	    -e 's=@@PERLLIBDIR@@='$(perllibdir_SQ)'=g' \
+	    -e 's=@@PERLLIBDIR_REL@@=$(perllibdir_relative_SQ)=g' \
+	    -e 's=@@GITEXECDIR_REL@@=$(gitexecdir_relative_SQ)=g' \
+	    -e 's=@@LOCALEDIR_REL@@=$(localedir_relative_SQ)=g' \
 	    $< >$@+ && \
 	mv $@+ $@
 
@@ -2328,7 +2393,7 @@ endif
 
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
index 000000000..a18913967
--- /dev/null
+++ b/perl/header_templates/runtime_prefix.template.pl
@@ -0,0 +1,40 @@
+# BEGIN RUNTIME_PREFIX generated code.
+#
+# This finds our Git::* libraries relative to the script's runtime path.
+sub __git_system_path {
+	my ($relpath) = @_;
+	my $gitexecdir_relative = '@@GITEXECDIR_REL@@';
+
+	# GIT_EXEC_PATH is supplied by `git` or the test suite.
+	my $exec_path = $ENV{GIT_EXEC_PATH};
+	if ($exec_path eq "") {
+		# This can happen if this script is being directly invoked instead of run
+		# by "git".
+		require FindBin;
+		$exec_path = $FindBin::Bin;
+	}
+
+	# Trim off the relative gitexecdir path to get the system path.
+	(my $prefix = $exec_path) =~ s=${gitexecdir_relative}$==;
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

