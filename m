Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7549C1F404
	for <e@80x24.org>; Mon,  8 Jan 2018 03:03:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755061AbeAHDDQ (ORCPT <rfc822;e@80x24.org>);
        Sun, 7 Jan 2018 22:03:16 -0500
Received: from mail-qk0-f193.google.com ([209.85.220.193]:36645 "EHLO
        mail-qk0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754967AbeAHDDO (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 7 Jan 2018 22:03:14 -0500
Received: by mail-qk0-f193.google.com with SMTP id d21so1588581qkj.3
        for <git@vger.kernel.org>; Sun, 07 Jan 2018 19:03:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=MNoycIvv0+QTJKUxP45ujuvdoypoZdqd9J5uLiaREHg=;
        b=Q3wx6q8j26lim1eY6z0gAHjSz3kf42cDJlULmL22kHyLv4Hf8Jrn/vjSItTEYeEmcr
         2S2nP6iqQEhHkT2uRIaHut0bB95d0t+aE/Zw4TyhkdAYaDlh4BsQJaBiBngqHOI5rRLS
         04kZdhzRBXa1Qwo1bk5ClHkuKtELcWLovoTAMMSbKVYHsYdHE+K+qDpbMzriEuWEpq9l
         xUfP1J48wxM8UghSfVTrXVNZ5SpwaEPJWvtI7KOAbtVuANkGZWsGNz+xDuD5Ky5/uQIM
         u/s0dbg4m1ACwYijfuIlrXe+JrERSeogybnwHCp5B7nCz4nTeumWtN52rWrIPS/paWPU
         mHNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=MNoycIvv0+QTJKUxP45ujuvdoypoZdqd9J5uLiaREHg=;
        b=svRxWx8AMtY0cGp/9vUYdOcE0OnYtP/PdK0fBEG1thfYSb76GogHXzobmGgMWnelMA
         15ADPzN8hCrqVz/uxbCOipkAoFWuGTiImwaE7fnflIJEpfaCZ9foKgpv2YmOnWURWfh3
         e8xtxuGgmSKVkKKjem9acRw4t9w6S/ZWm+DV+YXEyjeiHjgtoH4zYHeGnTmvdARP/AZn
         lztRZ9oAli7jcdu/HJjeUEecZv1f5UEbzOPtT0zLr6woL3oh+h4QAa9q9psxZ+tyKu8C
         hbUitui3r1xiV6897+kzo8J9nDWxy6St19NmasbFNZlCQf3Vt3FA87MHcAriXK9LZbid
         GDNQ==
X-Gm-Message-State: AKwxytfR2XDohICtIQglr2pCN5wkpUqxeQCS/ZvkOjcj4g9vFRNrhifc
        tv/M4+eUVgetUyyxluey2q35I1F3oTU=
X-Google-Smtp-Source: ACJfBouK1sGof25fC7HfYGSY79f8dfYwFlPlgbYBcyB1LoCOKGueQFs9Yp3V4cd0UWUSCQZVoPTE5g==
X-Received: by 10.55.100.79 with SMTP id y76mr14222042qkb.188.1515380593453;
        Sun, 07 Jan 2018 19:03:13 -0800 (PST)
Received: from localhost.localdomain (ip-99-2-52-196.nyc.us.northamericancoax.com. [196.52.2.99])
        by smtp.gmail.com with ESMTPSA id m77sm7156345qke.76.2018.01.07.19.03.12
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Sun, 07 Jan 2018 19:03:12 -0800 (PST)
From:   Dan Jacques <dnj@google.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, avarab@gmail.com, Johannes.Schindelin@gmx.de,
        Dan Jacques <dnj@google.com>
Subject: [PATCH v5 1/3] Makefile: generate Perl header from template file
Date:   Sun,  7 Jan 2018 22:02:37 -0500
Message-Id: <20180108030239.92036-2-dnj@google.com>
X-Mailer: git-send-email 2.15.0.chromium12
In-Reply-To: <20180108030239.92036-1-dnj@google.com>
References: <20180108030239.92036-1-dnj@google.com>
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
index 37e02cec1..e5e81ca1b 100644
--- a/Makefile
+++ b/Makefile
@@ -1967,20 +1967,15 @@ git.res: git.rc GIT-VERSION-FILE
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
@@ -1994,6 +1989,16 @@ GIT-PERL-DEFINES: FORCE
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
@@ -2735,7 +2740,7 @@ ifndef NO_TCLTK
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

