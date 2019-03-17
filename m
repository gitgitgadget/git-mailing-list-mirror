Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 415EF20248
	for <e@80x24.org>; Sun, 17 Mar 2019 18:36:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726717AbfCQSg4 (ORCPT <rfc822;e@80x24.org>);
        Sun, 17 Mar 2019 14:36:56 -0400
Received: from mail-lj1-f174.google.com ([209.85.208.174]:37182 "EHLO
        mail-lj1-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726333AbfCQSgz (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 17 Mar 2019 14:36:55 -0400
Received: by mail-lj1-f174.google.com with SMTP id a17so12053570ljd.4
        for <git@vger.kernel.org>; Sun, 17 Mar 2019 11:36:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=WR2ae7C12OGlWJ7eMj3WsScuNbqV2IiIc/0tqfOECQ8=;
        b=WToPZSIrLKxJDvovAASPuWZVCvyVh2tE6whGfGpqHNbqvSN1nJ235L0+CabeN95s9M
         iopLaoU0Oau0ooG4UL0/OU/eHWVkzlYbJFoBhhhTS/9NqOJVH3I60f8664gFyuwSpG+O
         lHKskkw7xPuV4qGm2osG7t7WzN7DSrcAT4E6cCyDVFYhOIS7Vowsg6cre0Rifq/yjaUJ
         Se0W2u3Qh9H6yrFh58edtg6KFO7uKlcb7s978iSdDnjVw682HQER+EsLNqNug8UAWdH0
         gh2n6iXcMIRHK5jnODVotpvnRfV3ry5tQlsP6iswcz9V5ADNoCRCpZDR7USim/J0KtD5
         f3Mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=WR2ae7C12OGlWJ7eMj3WsScuNbqV2IiIc/0tqfOECQ8=;
        b=Rlwy9R/jrWHhscnH6wCbndQA95Esm1bt9iUMzJ6s+Nvrm2//c9/CnRXsYuwaAIr11v
         J+hhmo17jk9ZBtw+gmXYS6xuNxoJEkHIJ13nlnCyKfyV2xeiQCuWi1iTXR4x7ku9gtRB
         Em4Xku83+e2lJKBqi7vjpPNJJXCFuV094/OGJmrFtHAf4PDzpaW2QOCsrTTRrspPdeHf
         PTvKiGOpV2O7oynAu+7RndJ3xtqdr+VE8R/KbYjjxfmIZf//2K64O+nj+AKx6jiPN6xV
         44Ys7FOFeQ1OO3zks9Ku+jjrMkzXTX5U70pvphOPXJ85WVPnkYf+6C5Xr837wWPkIv94
         b+Kg==
X-Gm-Message-State: APjAAAWR0V6DSXUrTPMjLHrFFxSuIZhuuQ38UkJ0GkP9UtQV7EuS9XUI
        OsyrxnJOCf2NT34WgDzO+q1jIdmf
X-Google-Smtp-Source: APXvYqxTX1Bwhd6OVb/M238Rp+aOAKccuZYlv+w2c3oBM2Th6xRckzj422dP7RcydFqu8wck4Wghhw==
X-Received: by 2002:a2e:1508:: with SMTP id s8mr8392600ljd.8.1552847813195;
        Sun, 17 Mar 2019 11:36:53 -0700 (PDT)
Received: from localhost.localdomain (31-211-229-121.customers.ownit.se. [31.211.229.121])
        by smtp.gmail.com with ESMTPSA id e2sm1589484lfc.75.2019.03.17.11.36.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 17 Mar 2019 11:36:51 -0700 (PDT)
From:   =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>
Subject: [PATCH 1/4] Doc: auto-detect changed build flags
Date:   Sun, 17 Mar 2019 19:36:00 +0100
Message-Id: <d35014bf3733b24f674510eaf428e05f74bf20be.1552838239.git.martin.agren@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <cover.1552838239.git.martin.agren@gmail.com>
References: <cover.1552838239.git.martin.agren@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

If you build the documentation switching between different options,
e.g., to build with both Asciidoc and Asciidoctor, you'll probably find
yourself running `make -C Documentation clean` either too often (wasting
time) or too rarely (getting mixed builds).

Track the flags we're using in the documentation build, similar to how
the main Makefile tracks CFLAGS and prefix flags. Track ASCIIDOC_COMMON
directly rather than its individual components -- that should make it
harder to forget to update the tracking if/when we modify the build
commands.

Signed-off-by: Martin Ågren <martin.agren@gmail.com>
---
 Documentation/.gitignore |  1 +
 Documentation/Makefile   | 23 +++++++++++++++++------
 2 files changed, 18 insertions(+), 6 deletions(-)

diff --git a/Documentation/.gitignore b/Documentation/.gitignore
index 3ef54e0adb..bf2bf271b5 100644
--- a/Documentation/.gitignore
+++ b/Documentation/.gitignore
@@ -13,3 +13,4 @@ mergetools-*.txt
 manpage-base-url.xsl
 SubmittingPatches.txt
 tmp-doc-diff/
+GIT-ASCIIDOCFLAGS
diff --git a/Documentation/Makefile b/Documentation/Makefile
index 26a2342bea..b534623012 100644
--- a/Documentation/Makefile
+++ b/Documentation/Makefile
@@ -331,6 +331,15 @@ mergetools-list.made: ../git-mergetool--lib.sh $(wildcard ../mergetools/*)
 		show_tool_names can_merge "* " || :' >mergetools-merge.txt && \
 	date >$@
 
+TRACK_ASCIIDOCFLAGS = $(subst ','\'',$(ASCIIDOC_COMMON):$(ASCIIDOC_HTML):$(ASCIIDOC_DOCBOOK))
+
+GIT-ASCIIDOCFLAGS: FORCE
+	@FLAGS='$(TRACK_ASCIIDOCFLAGS)'; \
+	    if test x"$$FLAGS" != x"`cat GIT-ASCIIDOCFLAGS 2>/dev/null`" ; then \
+		echo >&2 "    * new asciidoc flags"; \
+		echo "$$FLAGS" >GIT-ASCIIDOCFLAGS; \
+            fi
+
 clean:
 	$(RM) *.xml *.xml+ *.html *.html+ *.1 *.5 *.7
 	$(RM) *.texi *.texi+ *.texi++ git.info gitman.info
@@ -340,13 +349,14 @@ clean:
 	$(RM) SubmittingPatches.txt
 	$(RM) $(cmds_txt) $(mergetools_txt) *.made
 	$(RM) manpage-base-url.xsl
+	$(RM) GIT-ASCIIDOCFLAGS
 
-$(MAN_HTML): %.html : %.txt asciidoc.conf
+$(MAN_HTML): %.html : %.txt asciidoc.conf GIT-ASCIIDOCFLAGS
 	$(QUIET_ASCIIDOC)$(RM) $@+ $@ && \
 	$(TXT_TO_HTML) -d manpage -o $@+ $< && \
 	mv $@+ $@
 
-$(OBSOLETE_HTML): %.html : %.txto asciidoc.conf
+$(OBSOLETE_HTML): %.html : %.txto asciidoc.conf GIT-ASCIIDOCFLAGS
 	$(QUIET_ASCIIDOC)$(RM) $@+ $@ && \
 	$(TXT_TO_HTML) -o $@+ $< && \
 	mv $@+ $@
@@ -358,12 +368,12 @@ manpage-base-url.xsl: manpage-base-url.xsl.in
 	$(QUIET_XMLTO)$(RM) $@ && \
 	$(XMLTO) -m $(MANPAGE_XSL) $(XMLTO_EXTRA) man $<
 
-%.xml : %.txt asciidoc.conf
+%.xml : %.txt asciidoc.conf GIT-ASCIIDOCFLAGS
 	$(QUIET_ASCIIDOC)$(RM) $@+ $@ && \
 	$(TXT_TO_XML) -d manpage -o $@+ $< && \
 	mv $@+ $@
 
-user-manual.xml: user-manual.txt user-manual.conf
+user-manual.xml: user-manual.txt user-manual.conf GIT-ASCIIDOCFLAGS
 	$(QUIET_ASCIIDOC)$(RM) $@+ $@ && \
 	$(TXT_TO_XML) -d book -o $@+ $< && \
 	mv $@+ $@
@@ -373,7 +383,8 @@ technical/api-index.txt: technical/api-index-skel.txt \
 	$(QUIET_GEN)cd technical && '$(SHELL_PATH_SQ)' ./api-index.sh
 
 technical/%.html: ASCIIDOC_EXTRA += -a git-relative-html-prefix=../
-$(patsubst %,%.html,$(API_DOCS) technical/api-index $(TECH_DOCS)): %.html : %.txt asciidoc.conf
+$(patsubst %,%.html,$(API_DOCS) technical/api-index $(TECH_DOCS)): %.html : %.txt \
+	asciidoc.conf GIT-ASCIIDOCFLAGS
 	$(QUIET_ASCIIDOC)$(TXT_TO_HTML) $*.txt
 
 SubmittingPatches.txt: SubmittingPatches
@@ -430,7 +441,7 @@ $(patsubst %,%.html,$(ARTICLES)) : %.html : %.txt
 WEBDOC_DEST = /pub/software/scm/git/docs
 
 howto/%.html: ASCIIDOC_EXTRA += -a git-relative-html-prefix=../
-$(patsubst %.txt,%.html,$(wildcard howto/*.txt)): %.html : %.txt
+$(patsubst %.txt,%.html,$(wildcard howto/*.txt)): %.html : %.txt GIT-ASCIIDOCFLAGS
 	$(QUIET_ASCIIDOC)$(RM) $@+ $@ && \
 	sed -e '1,/^$$/d' $< | \
 	$(TXT_TO_HTML) - >$@+ && \
-- 
2.21.0

