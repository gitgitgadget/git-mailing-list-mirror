Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2B8E420A40
	for <e@80x24.org>; Wed, 29 Nov 2017 15:56:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933638AbdK2P4s (ORCPT <rfc822;e@80x24.org>);
        Wed, 29 Nov 2017 10:56:48 -0500
Received: from mail-qt0-f193.google.com ([209.85.216.193]:41371 "EHLO
        mail-qt0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753937AbdK2P4q (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 29 Nov 2017 10:56:46 -0500
Received: by mail-qt0-f193.google.com with SMTP id i40so4900509qti.8
        for <git@vger.kernel.org>; Wed, 29 Nov 2017 07:56:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ZOFRhNPR4suSbK0GgdAjPeLoIOXTBihk2g9GPaFul8M=;
        b=akuDHF2olWulKS1x3zA/t8KJDNwN95MENgrFgtoBcMZvppDknMOUlz6XZkC2FNm20o
         AAKnd01Tasi68fZW+74S+1n5hAqgEbwcZJYxDstfK2FEM063jGdqsbTYh/KZDdH4JfWB
         EdrEhwdlNVPAz70A93I5e5Y6YuzUhdvAP0KUl/gACyLfDTqShSjovzmPr1GFbBS+WYru
         AF/XvPbVOSCOlt6ueXMMcDAEIfztcg3H4jeyCPwl8Z6jSk2u93bVIrdjScK3ivPeG16r
         D8Jn1e08kpbbyCq9m/bm/ggonwCGX3J2x/8ilp57Qs8grrNemDZ2RK1ijBQc6nhZcZyz
         s+ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ZOFRhNPR4suSbK0GgdAjPeLoIOXTBihk2g9GPaFul8M=;
        b=GWekk1RFiEQ9qYySnTGNqpMo0G6Ho+JvDNzFDi/ta7rv5vbjLk9wiGRGD3uqGKOgA/
         Qq/DGC1woxkx2E+01THsJun+3sasddBwtoqbDpSnUJ9ETgQKWeK4SH671S2cOTaBLS91
         7Cu6923N71jOMvMLKqz8ucDoDeJHqi79ZFVgMe2iVGxuTL9ANMoi2SymRVoAksixStAo
         gOYuT1s3li1kocPwLdjRXwtcpUPt4tg2qFKvokowjURzMm7OfVxDJ0kpOyX4TYc4V5Mj
         +s2CvOP9q4VElSjN4WFTi9OS47Sy94kRznCIqf4/rkUDr75ONrYUMCvKlCghCxjzDj0p
         wZJg==
X-Gm-Message-State: AJaThX5PtPH7pY80EjfU89wxpKHcHYL/RTf/Ksa+ZPbRXxu/kXdCu0f8
        4Y7YMU8vz2wfH4XckFuZeO0vX1ofvS0=
X-Google-Smtp-Source: AGs4zMZpyIqRwfhANc60Ig+4hOkdlwXvTUdAypOhTvmtWlSQ9W/ARqAgoxOFy69bkitGkvz677DXgA==
X-Received: by 10.200.54.86 with SMTP id n22mr4888813qtb.224.1511971004677;
        Wed, 29 Nov 2017 07:56:44 -0800 (PST)
Received: from dnj-macbookpro.roam.corp.google.com.com ([100.67.16.103])
        by smtp.gmail.com with ESMTPSA id z126sm1390465qka.70.2017.11.29.07.56.43
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Wed, 29 Nov 2017 07:56:44 -0800 (PST)
From:   Dan Jacques <dnj@google.com>
To:     git@vger.kernel.org, gitster@pobox.com
Cc:     Johannes.Schindelin@gmx.de, avarab@gmail.com,
        Dan Jacques <dnj@google.com>
Subject: [PATCH v4 1/4] Makefile: generate Perl header from template file
Date:   Wed, 29 Nov 2017 10:56:34 -0500
Message-Id: <20171129155637.89075-2-dnj@google.com>
X-Mailer: git-send-email 2.15.0.chromium12
In-Reply-To: <20171129155637.89075-1-dnj@google.com>
References: <20171129155637.89075-1-dnj@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
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
Thanks-to: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
Thanks-to: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 .gitignore                           |  1 +
 Makefile                             | 24 +++++++++++++++---------
 perl/header_fixed_prefix.pl.template |  1 +
 3 files changed, 17 insertions(+), 9 deletions(-)
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
index e53750ca0..f7c4ac207 100644
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
@@ -1989,6 +1986,15 @@ GIT-PERL-DEFINES: FORCE
 		echo "$$FLAGS" >$@; \
 	    fi
 
+GIT-PERL-HEADER: $(PERL_HEADER_TEMPLATE) GIT-PERL-DEFINES perl/perl.mak Makefile
+	$(QUIET_GEN)$(RM) $@ && \
+	INSTLIBDIR=`MAKEFLAGS= $(MAKE) -C perl -s --no-print-directory instlibdir` && \
+	INSTLIBDIR_EXTRA='$(PERLLIB_EXTRA_SQ)' && \
+	INSTLIBDIR="$$INSTLIBDIR$${INSTLIBDIR_EXTRA:+:$$INSTLIBDIR_EXTRA}" && \
+	sed -e 's=@@PATHSEP@@=$(pathsep)=g' \
+	    -e 's=@@INSTLIBDIR@@='$$INSTLIBDIR'=g' \
+	    $< >$@+ && \
+	mv $@+ $@
 
 .PHONY: gitweb
 gitweb:
@@ -2707,7 +2713,7 @@ ifndef NO_TCLTK
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

