Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6C4281F404
	for <e@80x24.org>; Tue, 10 Apr 2018 15:06:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754139AbeDJPGH (ORCPT <rfc822;e@80x24.org>);
        Tue, 10 Apr 2018 11:06:07 -0400
Received: from mail-qk0-f182.google.com ([209.85.220.182]:46384 "EHLO
        mail-qk0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753953AbeDJPGE (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 10 Apr 2018 11:06:04 -0400
Received: by mail-qk0-f182.google.com with SMTP id p67so13698246qke.13
        for <git@vger.kernel.org>; Tue, 10 Apr 2018 08:06:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=vwz/UnPVD3mafhaMNTYPPfxJsGCtmpL8Hlj5LekKqYk=;
        b=XPRYZjstVWxe9W+S6PaC+aDxkmIyoFXJWUp2M0ksN8chROtXa9T46HFhBLJBoFb4rp
         YlYxSMHsbotSkP/wo0+ScjCeLacM7xNJulP5xQAjH3fUstKulQ8MKPEAFtHe8VmiOlZe
         g8sDP405tee5dpQjgkLx7DPUVSQ+kdm4bm86qcK7ABghdz7l3d9EmT4yXIW1O+GjOscZ
         tkacC2Ne+h6WzbD35WNM6vgnoevfRQCqu7CaINUocqQwpOv7SO3b3F4M0Rw1cxwdnXae
         4TNqBH166/4ngDGVZRTwTvJA7Pc1TEqsN7PEu+1b9mx9+iR1TSugX5shFnDGpF7TxRQF
         +LeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=vwz/UnPVD3mafhaMNTYPPfxJsGCtmpL8Hlj5LekKqYk=;
        b=lG/8S2JROkhjfXeocnzfFby/XShik3KFMk5ZnCVqQIr+CQN7EGBFFp6fOqzLXxK3lv
         w6oi3pApE7lFdbhWtx/QbVP52LvW6dIOu+jK7eacoWhecB9ItL7rnBbd37Ktf79Amhi1
         6H53Pq6v1kNgJOAo/Yq8r1Cf2U+eylpsl/BFXi0CKhABqDL1hFBTvQI8k0esWEwdUzRy
         Ie9W+9C7YRwFjymeuM2DN2Rn7VJO2GFYExrWXB6lQKkuwn7VYX6XDi7QapJY7kU5IhFe
         nHFZykexskwtqgcIC/tn1Ua/6QU/B11bcqAOWToh+5YrGZmT1Fk5KLuIokIMzF58Eybm
         S12Q==
X-Gm-Message-State: ALQs6tDHahOMbkDpw2eFF9bEd55oSIA6dJ+cn8fg3FYV3QO93OhPqDJW
        ifCVnvplioHG2iWFEmk7fOSBhlms3LE=
X-Google-Smtp-Source: AIpwx4+olyjePK6rjhpEMo0DHy+DvcdP7f7S+x+3y8bnWXs3w5mBdQk84XwTO3Bi8tQwjD1E1ft9fw==
X-Received: by 10.55.162.146 with SMTP id l140mr1181343qke.122.1523372761786;
        Tue, 10 Apr 2018 08:06:01 -0700 (PDT)
Received: from dnj-macbookpro.roam.corp.google.com.com ([100.67.16.96])
        by smtp.gmail.com with ESMTPSA id c137sm2333526qkb.2.2018.04.10.08.05.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 10 Apr 2018 08:05:57 -0700 (PDT)
From:   Dan Jacques <dnj@google.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, avarab@gmail.com, Johannes.Schindelin@gmx.de,
        Dan Jacques <dnj@google.com>
Subject: [PATCH v8 1/5] Makefile: generate Perl header from template file
Date:   Tue, 10 Apr 2018 11:05:42 -0400
Message-Id: <20180410150546.38062-2-dnj@google.com>
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
index 96f6138f6..ec7cf5a0f 100644
--- a/Makefile
+++ b/Makefile
@@ -1984,20 +1984,15 @@ git.res: git.rc GIT-VERSION-FILE
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
@@ -2011,6 +2006,16 @@ GIT-PERL-DEFINES: FORCE
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
@@ -2788,7 +2793,7 @@ ifndef NO_TCLTK
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

