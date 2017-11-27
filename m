Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2519B20C11
	for <e@80x24.org>; Mon, 27 Nov 2017 16:41:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932196AbdK0QlG (ORCPT <rfc822;e@80x24.org>);
        Mon, 27 Nov 2017 11:41:06 -0500
Received: from mail-qt0-f194.google.com ([209.85.216.194]:41664 "EHLO
        mail-qt0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932174AbdK0QlD (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 27 Nov 2017 11:41:03 -0500
Received: by mail-qt0-f194.google.com with SMTP id i40so28632501qti.8
        for <git@vger.kernel.org>; Mon, 27 Nov 2017 08:41:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ZetyPtvXarorEkO0mtBBZAPf8lciTrz2JD2W1UKcSe4=;
        b=iqlLstW6L/ODQYuYDHDmXflBqlVs1zHjUB1h6BiFEv+uni/4j3d6Z1oHKgDaxuecoG
         dmaRgRcrN0ZTyZUXAlFumc6KZ2e4jLu2SI1LVWnhYEyioOoDwn9mgUZW6qWx14WTYhbm
         25j0vmgzDvnDN02CgPCwE3eI2TrXuzBXgdmIFG5oFWAC5iLY5FwIsoEcHb4HEl3r2R4c
         /Xj640CwRlAYrlon3I/M3hWKvAHES36mHCPdb1Ww3Lx8h25U1ZVV75s8UYZNn7gkEuDm
         w1gad/EbtUC7ZIohR67cW+78Zszs7wUzn10pn3SKzWc3jVpecO4DbA5DgtTHS/L5rD6n
         Lx+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=ZetyPtvXarorEkO0mtBBZAPf8lciTrz2JD2W1UKcSe4=;
        b=T0Ubz0Xu1CUvF01CsrLvIRKATEcJMYX3cMZlu/cTCe7yfVDS+U8ixBTQwW+gEcYJmM
         7dbJJmrLaUh6Gx4uVQ/kipDjos7KJcN3i0fjlWdhA8M/2QDbp+BrKB6niF6Ai7cwQKr9
         4HgrgtJr/BobvytNZvhB39Odhh2Qxf2rxwguO6bCEIlfAipM4lFWn7rzarFTbyC7Asi9
         fYE4pBFjtk9isP2807Kkbehfgr/ckzJ9gsUmnE4gJVX5ZKHXJLuxT90r81kotdYf/rl+
         cg5J5Y/zpmZdSo6PyY/491E0cHUtqLmQvKAwjpVjvf11D+Uay2aBgo5Oo1X0VfMQVIha
         URfQ==
X-Gm-Message-State: AJaThX6GQ8XOE21z+TCyfV/kRRQ+tMr8k7BopGmH+2k55Az8BBIrm9eM
        rmrlEqB3ocF8CbN8zQRP1E8AxmZlLV0=
X-Google-Smtp-Source: AGs4zMaMICqIfiarXvMm3CjPB37y8lVYx719kL+zHee6yhmhv7Mp+cZuYxL3OvK32oeyzzAwzgv9ZA==
X-Received: by 10.200.39.104 with SMTP id h37mr59356829qth.114.1511800861926;
        Mon, 27 Nov 2017 08:41:01 -0800 (PST)
Received: from dnj-macbookpro.fios-router.home (pool-108-32-46-175.pitbpa.fios.verizon.net. [108.32.46.175])
        by smtp.gmail.com with ESMTPSA id y9sm9696394qkl.17.2017.11.27.08.41.01
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Mon, 27 Nov 2017 08:41:01 -0800 (PST)
From:   Dan Jacques <dnj@google.com>
To:     git@vger.kernel.org
Cc:     Johannes.Schindelin@gmx.de, avarab@gmail.com, dnj@google.com,
        gitster@pobox.com
Subject: [PATCH v3 1/4] Makefile: generate Perl header from template file
Date:   Mon, 27 Nov 2017 11:40:52 -0500
Message-Id: <20171127164055.93283-2-dnj@google.com>
X-Mailer: git-send-email 2.15.0.chromium12
In-Reply-To: <20171127164055.93283-1-dnj@google.com>
References: <20171127164055.93283-1-dnj@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Currently, the generated Perl script headers are emitted by commands in
the Makefile. This mechanism restricts options to introduce alternative
header content, needed by Perl runtime prefix support, and obscures the
origin of the Perl script header.

Change the Makefile to generate a header by processing a template file and
move the header content into the "perl/" subdirectory. The processed
generated will now be stored in the "GIT-PERL-HEADER" file. This allows
the content of the Perl header to be controlled by changing the path of
the template in the Makefile.

Signed-off-by: Dan Jacques <dnj@google.com>
---
 .gitignore                           |  1 +
 Makefile                             | 23 ++++++++++++++---------
 perl/header_fixed_prefix.pl.template |  1 +
 3 files changed, 16 insertions(+), 9 deletions(-)
 create mode 100644 perl/header_fixed_prefix.pl.template

diff --git a/.gitignore b/.gitignore
index 833ef3b0b..89bd7bd8a 100644
--- a/.gitignore
+++ b/.gitignore
@@ -3,6 +3,7 @@
 /GIT-LDFLAGS
 /GIT-PREFIX
 /GIT-PERL-DEFINES
+/GIT-PERL-HEADER
 /GIT-PYTHON-VARS
 /GIT-SCRIPT-DEFINES
 /GIT-USER-AGENT
diff --git a/Makefile b/Makefile
index e53750ca0..5ad60a54c 100644
--- a/Makefile
+++ b/Makefile
@@ -1964,18 +1964,15 @@ perl/PM.stamp: FORCE
 perl/perl.mak: GIT-CFLAGS GIT-PREFIX perl/Makefile perl/Makefile.PL
 	$(QUIET_SUBDIR0)perl $(QUIET_SUBDIR1) PERL_PATH='$(PERL_PATH_SQ)' prefix='$(prefix_SQ)' $(@F)
 
+PERL_HEADER_TEMPLATE = perl/header_fixed_prefix.pl.template
 PERL_DEFINES = $(PERL_PATH_SQ):$(PERLLIB_EXTRA_SQ)
-$(SCRIPT_PERL_GEN): % : %.perl perl/perl.mak GIT-PERL-DEFINES GIT-VERSION-FILE
+
+$(SCRIPT_PERL_GEN): % : %.perl perl/perl.mak GIT-PERL-DEFINES GIT-PERL-HEADER GIT-VERSION-FILE
 	$(QUIET_GEN)$(RM) $@ $@+ && \
-	INSTLIBDIR=`MAKEFLAGS= $(MAKE) -C perl -s --no-print-directory instlibdir` && \
-	INSTLIBDIR_EXTRA='$(PERLLIB_EXTRA_SQ)' && \
-	INSTLIBDIR="$$INSTLIBDIR$${INSTLIBDIR_EXTRA:+:$$INSTLIBDIR_EXTRA}" && \
 	sed -e '1{' \
 	    -e '	s|#!.*perl|#!$(PERL_PATH_SQ)|' \
-	    -e '	h' \
-	    -e '	s=.*=use lib (split(/$(pathsep)/, $$ENV{GITPERLLIB} || "'"$$INSTLIBDIR"'"));=' \
-	    -e '	H' \
-	    -e '	x' \
+	    -e '	rGIT-PERL-HEADER' \
+	    -e '	G' \
 	    -e '}' \
 	    -e 's/@@GIT_VERSION@@/$(GIT_VERSION)/g' \
 	    $< >$@+ && \
@@ -1989,6 +1986,14 @@ GIT-PERL-DEFINES: FORCE
 		echo "$$FLAGS" >$@; \
 	    fi
 
+GIT-PERL-HEADER: $(PERL_HEADER_TEMPLATE) GIT-PERL-DEFINES perl/perl.mak
+	$(QUIET_GEN)$(RM) $@ && \
+	INSTLIBDIR=`MAKEFLAGS= $(MAKE) -C perl -s --no-print-directory instlibdir` && \
+	INSTLIBDIR_EXTRA='$(PERLLIB_EXTRA_SQ)' && \
+	INSTLIBDIR="$$INSTLIBDIR$${INSTLIBDIR_EXTRA:+:$$INSTLIBDIR_EXTRA}" && \
+	sed -e 's=@@PATHSEP@@='$(pathsep)'=g' \
+	    -e 's=@@INSTLIBDIR@@='$$INSTLIBDIR'=g' \
+	    $< >$@
 
 .PHONY: gitweb
 gitweb:
@@ -2707,7 +2712,7 @@ ifndef NO_TCLTK
 endif
 	$(RM) GIT-VERSION-FILE GIT-CFLAGS GIT-LDFLAGS GIT-BUILD-OPTIONS
 	$(RM) GIT-USER-AGENT GIT-PREFIX
-	$(RM) GIT-SCRIPT-DEFINES GIT-PERL-DEFINES GIT-PYTHON-VARS
+	$(RM) GIT-SCRIPT-DEFINES GIT-PERL-DEFINES GIT-PERL-HEADER GIT-PYTHON-VARS
 
 .PHONY: all install profile-clean clean strip
 .PHONY: shell_compatibility_test please_set_SHELL_PATH_to_a_more_modern_shell
diff --git a/perl/header_fixed_prefix.pl.template b/perl/header_fixed_prefix.pl.template
new file mode 100644
index 000000000..9a4bc4d30
--- /dev/null
+++ b/perl/header_fixed_prefix.pl.template
@@ -0,0 +1 @@
+use lib (split(/@@PATHSEP@@/, $ENV{GITPERLLIB} || "@@INSTLIBDIR@@"));
-- 
2.15.0.chromium12

