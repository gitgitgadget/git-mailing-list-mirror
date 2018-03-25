Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 96C2F1F404
	for <e@80x24.org>; Sun, 25 Mar 2018 20:51:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752121AbeCYUv3 (ORCPT <rfc822;e@80x24.org>);
        Sun, 25 Mar 2018 16:51:29 -0400
Received: from mail-qk0-f195.google.com ([209.85.220.195]:46259 "EHLO
        mail-qk0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751897AbeCYUvZ (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 25 Mar 2018 16:51:25 -0400
Received: by mail-qk0-f195.google.com with SMTP id o184so18112624qkd.13
        for <git@vger.kernel.org>; Sun, 25 Mar 2018 13:51:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=8V1unDr6VqUeAGGZKFMp0URwuamGHLscUWLoqB4IGRw=;
        b=Ph7VlxxTbl+abkyGU88CR9FHEvyRBMSqcplZWn4OVFngNhCJwBr8C0S3rYLNyLDV5w
         Lx471t7RMEP++xiHT1xRnDc95XAAjRWPVq2pyCg2GDxoyaCdolUBxnNu9fpVpHMAxxNG
         nqORjcASns8EiwG97hoNI6Hl+xHJruQ+GN7xe/PMpUjqHogtbnKI/jieMybJ9T94M11M
         EAEwoZ4YIy9AmDKX/NiNPD5Eh/ENukm5NnHoyHEQugttxpLTT6R4JpdW4jy1k148U7HS
         WUv7tAEQzNuWx0hV7gRRX6iIgcVDnFwSzS9vsp0rPkB/m+yK11uJ5UyqGWEyaqm4MzmN
         9M9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=8V1unDr6VqUeAGGZKFMp0URwuamGHLscUWLoqB4IGRw=;
        b=Ibylw/C7Ur/deMdA+k+83jLbMZ27bkVaLW1Ra4OYi00DXE6mN2xYqiJRImxsEs0RIk
         BjIyw4EfgoYNkEjxSkJTkNZqHVTalQIdiSWp6sg6lkQ8Yjz/VVmi5aQ0xnQ1DYh9r13y
         aUOiNTHXzzLF60d4sr20vpEBjpLQ4kG+6FktxaHPSZF80MtJmVu37yJX6xdTYoqT0tQ3
         q4TSQmSCuXoUZ8e98dk28spaw9+qqdBtjLXnt/f9DAuDl2sAf7cA/1flD2POQspO/OAi
         /0zFZua2G80mDuNzRDW1bk7fk04Sw2Fx46BmoZTwyvBy8xEgOFgD2ZyS9U9nMwTTZoQu
         s4Vg==
X-Gm-Message-State: AElRT7HJ1ukbrKP3oPMs6HWq8YAoLALQDyBYSyLFjPxJbibu3H76GhhJ
        xSoQp8Cg1hwr8vGLxJ0LaDCRdV1FvJQ=
X-Google-Smtp-Source: AIpwx489IOoxAIgqgcARWMN68zLVF1BJXFD7YWuT6zUhAzOTB5FUvO9WC6huhHJykz5TO3g/xQGVEA==
X-Received: by 10.55.116.71 with SMTP id p68mr716955qkc.29.1522011084483;
        Sun, 25 Mar 2018 13:51:24 -0700 (PDT)
Received: from localhost.localdomain (pool-74-109-218-108.pitbpa.fios.verizon.net. [74.109.218.108])
        by smtp.gmail.com with ESMTPSA id 72sm10217537qtf.53.2018.03.25.13.51.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 25 Mar 2018 13:51:23 -0700 (PDT)
From:   Dan Jacques <dnj@google.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, avarab@gmail.com, Johannes.Schindelin@gmx.de,
        Dan Jacques <dnj@google.com>
Subject: [PATCH v7 1/3] Makefile: generate Perl header from template file
Date:   Sun, 25 Mar 2018 16:51:18 -0400
Message-Id: <20180325205120.17730-2-dnj@google.com>
X-Mailer: git-send-email 2.15.0.chromium12
In-Reply-To: <20180325205120.17730-1-dnj@google.com>
References: <20180325205120.17730-1-dnj@google.com>
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
move the header content into the "perl/" subdirectory. The generated
header content will now be stored in the "GIT-PERL-HEADER" file. This
allows the content of the Perl header to be controlled by changing the path
of the template in the Makefile.

Signed-off-by: Dan Jacques <dnj@google.com>
Thanks-to: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
Thanks-to: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 .gitignore                                     |  1 +
 Makefile                                       | 27 +++++++++++++++-----------
 perl/header_templates/fixed_prefix.template.pl |  1 +
 3 files changed, 18 insertions(+), 11 deletions(-)
 create mode 100644 perl/header_templates/fixed_prefix.template.pl

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
index a1d8775ad..e479822ce 100644
--- a/Makefile
+++ b/Makefile
@@ -1975,20 +1975,15 @@ git.res: git.rc GIT-VERSION-FILE
 $(SCRIPT_PERL_GEN): GIT-BUILD-OPTIONS
 
 ifndef NO_PERL
-$(SCRIPT_PERL_GEN):
-
+PERL_HEADER_TEMPLATE = perl/header_templates/fixed_prefix.template.pl
 PERL_DEFINES = $(PERL_PATH_SQ):$(PERLLIB_EXTRA_SQ):$(perllibdir_SQ)
-$(SCRIPT_PERL_GEN): % : %.perl GIT-PERL-DEFINES GIT-VERSION-FILE
+
+$(SCRIPT_PERL_GEN): % : %.perl GIT-PERL-DEFINES GIT-PERL-HEADER GIT-VERSION-FILE
 	$(QUIET_GEN)$(RM) $@ $@+ && \
-	INSTLIBDIR='$(perllibdir_SQ)' && \
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
@@ -2002,6 +1997,16 @@ GIT-PERL-DEFINES: FORCE
 		echo "$$FLAGS" >$@; \
 	    fi
 
+GIT-PERL-HEADER: $(PERL_HEADER_TEMPLATE) GIT-PERL-DEFINES Makefile
+	$(QUIET_GEN)$(RM) $@ && \
+	INSTLIBDIR='$(perllibdir_SQ)' && \
+	INSTLIBDIR_EXTRA='$(PERLLIB_EXTRA_SQ)' && \
+	INSTLIBDIR="$$INSTLIBDIR$${INSTLIBDIR_EXTRA:+:$$INSTLIBDIR_EXTRA}" && \
+	sed -e 's=@@PATHSEP@@=$(pathsep)=g' \
+	    -e 's=@@INSTLIBDIR@@='$$INSTLIBDIR'=g' \
+	    -e 's=@@PERLLIBDIR@@='$(perllibdir_SQ)'=g' \
+	    $< >$@+ && \
+	mv $@+ $@
 
 .PHONY: gitweb
 gitweb:
@@ -2770,7 +2775,7 @@ ifndef NO_TCLTK
 endif
 	$(RM) GIT-VERSION-FILE GIT-CFLAGS GIT-LDFLAGS GIT-BUILD-OPTIONS
 	$(RM) GIT-USER-AGENT GIT-PREFIX
-	$(RM) GIT-SCRIPT-DEFINES GIT-PERL-DEFINES GIT-PYTHON-VARS
+	$(RM) GIT-SCRIPT-DEFINES GIT-PERL-DEFINES GIT-PERL-HEADER GIT-PYTHON-VARS
 
 .PHONY: all install profile-clean clean strip
 .PHONY: shell_compatibility_test please_set_SHELL_PATH_to_a_more_modern_shell
diff --git a/perl/header_templates/fixed_prefix.template.pl b/perl/header_templates/fixed_prefix.template.pl
new file mode 100644
index 000000000..857b4391a
--- /dev/null
+++ b/perl/header_templates/fixed_prefix.template.pl
@@ -0,0 +1 @@
+use lib (split(/@@PATHSEP@@/, $ENV{GITPERLLIB} || '@@INSTLIBDIR@@'));
-- 
2.15.0.chromium12

