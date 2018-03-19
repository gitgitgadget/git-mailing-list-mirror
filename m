Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C8EAE1F404
	for <e@80x24.org>; Mon, 19 Mar 2018 02:51:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754923AbeCSCuy (ORCPT <rfc822;e@80x24.org>);
        Sun, 18 Mar 2018 22:50:54 -0400
Received: from mail-qt0-f195.google.com ([209.85.216.195]:44699 "EHLO
        mail-qt0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754531AbeCSCuw (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 18 Mar 2018 22:50:52 -0400
Received: by mail-qt0-f195.google.com with SMTP id j26so1693583qtl.11
        for <git@vger.kernel.org>; Sun, 18 Mar 2018 19:50:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=eBHCQgw4BM8G1L6L9ZLmmVJVCq1JcimPC+0VrcRI2+E=;
        b=YV1+sfUp/wC+LrAP4FaD343KMVCw2FVszfPOQpEeVUE7wWm1TvNnDFlzOqUX28zb2E
         4VucIDOPiv4GcMOzgTcW+yBBuP4sbEXQlh0ullh7lQZRWO47nvt2C7VWojaqJ9Ao8a5i
         vvDqMCxbZFLOweIbDCVGKLyn64giYqiBBEnWODsklBoiWBfcMr91bv4NboCThJcUUEPn
         2qGcCItflJPGfqU6DccNwDWwq00vJNHByk/bvyUUQWL+wpIKeEoO24OvpUHn5SBgIN+w
         lCPPktXmcifFLk28UjevE/JIguv0tjYCyAOkxZ54Kv7xMswWMMywmU6nyCfDSUTUEWls
         Cr7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=eBHCQgw4BM8G1L6L9ZLmmVJVCq1JcimPC+0VrcRI2+E=;
        b=GIdbQr6IVO7q/+XOUnm2Jec1zNQcsLU9ER4cC8GbquJWv3vEOJEZKPt2inklSPLjbB
         z4mJf6Mc8rz0rk0ic3IjssI/QivD+0LrLBKX4EKHFyVkbdGVxcRPuoAq1eZifp7C8eFp
         FBIKJCHVC6sxyU3l333wxntnrB2aydU0DGWu3nAfVPGDPhCRRsi5OI7pvZBdCsxsiSj8
         Pjtto/Tzf/F/o7M8M6A3x3Fm2N30XnW405eKiVrIyELOIHt4SX5M+xE6zDXcksTdiStV
         9z9FiDoTemcCu7Eu/MG80wqiSu32EF7fZoNjuNkyuhWsgqKIHxLkeNUsuhIpXJUnF62f
         Y/RQ==
X-Gm-Message-State: AElRT7EOHDxuJ1mkgKQUluNciJENWGP7nl53iZtNlft4FyTkK7Mzc2Xx
        SKaYhmHivVAnBCa8zD6Au64fC6jtNI0=
X-Google-Smtp-Source: AG47ELtWj7twuvaq3SfbNpbzha2aPB+mklAjdHUZ4Vg6T3tb5AfD5O5RmEhY2wG2l3685Rbr6x87Tw==
X-Received: by 10.200.23.152 with SMTP id o24mr16113764qtj.255.1521427850681;
        Sun, 18 Mar 2018 19:50:50 -0700 (PDT)
Received: from localhost.localdomain (pool-74-109-218-108.pitbpa.fios.verizon.net. [74.109.218.108])
        by smtp.gmail.com with ESMTPSA id x8sm9877902qta.64.2018.03.18.19.50.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 18 Mar 2018 19:50:50 -0700 (PDT)
From:   Dan Jacques <dnj@google.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, avarab@gmail.com, Johannes.Schindelin@gmx.de,
        Dan Jacques <dnj@google.com>
Subject: [PATCH v6 1/3] Makefile: generate Perl header from template file
Date:   Sun, 18 Mar 2018 22:50:44 -0400
Message-Id: <20180319025046.58052-2-dnj@google.com>
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

