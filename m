Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F1B2C433F5
	for <git@archiver.kernel.org>; Wed, 17 Nov 2021 10:21:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 55F8161BF9
	for <git@archiver.kernel.org>; Wed, 17 Nov 2021 10:21:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236256AbhKQKYI (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 17 Nov 2021 05:24:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236265AbhKQKXl (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 17 Nov 2021 05:23:41 -0500
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E19A8C061204
        for <git@vger.kernel.org>; Wed, 17 Nov 2021 02:20:42 -0800 (PST)
Received: by mail-wm1-x331.google.com with SMTP id p3-20020a05600c1d8300b003334fab53afso4322602wms.3
        for <git@vger.kernel.org>; Wed, 17 Nov 2021 02:20:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=i17kNRFT2P/RSbdz+G5LrCD2E0MXRbAX9bdTm5/88QM=;
        b=lEzRXIuALFPn6duhhoBat2gHcrUq76vSQ69LqjEQ2HBXSjdcm/e/l2pN2Lwmhe58wb
         yCPb6dtIUWHTToZzrAHep9hW0hLGWz5/vA2/FHT6A/C+yFtGDVqwcKR/V8UUburfzFHM
         GrSgUVA4PDES3jB2I21cyVc1c6F66bB4pJAvp9eAH12M0j95Ebw0a26AOwmH97AFSZap
         m0UHNHu2sABaQb52NsWSgwv/fQEric3otF9UZ2uUTdjtEx7GM0kIH17x5cZecSJrXpAn
         fUvtnSbcupaLzzci1sr8g1HFo7zAGMQMxizegVDaW4CmM+wpT+G5Xoz/u+31/YNn8JwX
         yAbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=i17kNRFT2P/RSbdz+G5LrCD2E0MXRbAX9bdTm5/88QM=;
        b=e5hZ8LA4wP4/0bkTfVGxZWxSkqM44lN+g+ho3PrEi4gIqHYLCAha93vHNn2jheVxhX
         +BpdFf/V7Abl6kYFG77GT8R9/UBKlb5SXjBugwjM2wgv8JLnN+v+yZRi9PUvVdsSX8ux
         VwmHHYJ8Z3wLWHmxj3iEP8JY6hxTJDzO9zKGmAYjISaOR0mnlG32SN5LT2PYQ/zBl7k2
         SjX9lSZi6HuPc1FJTdQJOJaKd86Qn5Z7D9beqU3J0fJhbcujtQYVRmcfZTviB7B8cjNh
         YXChjxulQfm/qn0NCL3ZWBLigxFS8IEGIp6G26WDFPQBF9pxPXe2Zrp8n90/KI5O3gtZ
         2Slw==
X-Gm-Message-State: AOAM533K0KKWXbNYVha2pSDGe9vCVYEgYbHiovDTkgwOXxnju0Ir86eQ
        aT5qjUdDTB7sJPL/mRy4dGEGvfcaL75maA==
X-Google-Smtp-Source: ABdhPJx9gAkLhrOqgOL+IxdCvclAoedXM2gAB+TuJFNYGAkNZHP8yrykWtK8uKFn8po1tRwkvSiBGw==
X-Received: by 2002:a05:600c:21c3:: with SMTP id x3mr16170493wmj.13.1637144440982;
        Wed, 17 Nov 2021 02:20:40 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id n32sm6456256wms.1.2021.11.17.02.20.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Nov 2021 02:20:40 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Jeff King <peff@peff.net>, Dan Jacques <dnj@google.com>,
        Eric Wong <e@80x24.org>, Jonathan Nieder <jrnieder@gmail.com>,
        Mike Hommey <mh@glandium.org>,
        =?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?= 
        <congdanhqx@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v4 18/23] Makefiles: add and use wildcard "mkdir -p" template
Date:   Wed, 17 Nov 2021 11:20:17 +0100
Message-Id: <patch-v4-18.23-be5882b2c99-20211117T101807Z-avarab@gmail.com>
X-Mailer: git-send-email 2.34.0.796.g2c87ed6146a
In-Reply-To: <cover-v4-00.23-00000000000-20211117T101807Z-avarab@gmail.com>
References: <cover-v3-00.23-00000000000-20211116T114334Z-avarab@gmail.com> <cover-v4-00.23-00000000000-20211117T101807Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add a template to do the "mkdir -p" of $(@D) (the parent dir of $@)
for us, and use it for the "make lint-docs" targets I added in
8650c6298c1 (doc lint: make "lint-docs" non-.PHONY, 2021-10-15).

As seen in 4c64fb5aad9 (Documentation/Makefile: fix lint-docs mkdir
dependency, 2021-10-26) maintaining these manual lists of parent
directory dependencies is fragile, in addition to being obviously
verbose.

I used this pattern at the time because I couldn't find another method
than "order-only" prerequisites to avoid doing a "mkdir -p $(@D)" for
every file being created, which as noted in [1] would be significantly
slower.

But as it turns out we can use this neat trick of only doing a "mkdir
-p" if the $(wildcard) macro tells us the path doesn't exist. A re-run
of a performance test similar to thatnoted downthread of [1] in [2]
shows that this is faster, in addition to being less verbose and more
reliable (this uses my "git-hyperfine" thin wrapper for "hyperfine"[3]):

    $ git hyperfine -L rev HEAD~0,HEAD~1 -b 'make -C Documentation lint-docs' -p 'rm -rf Documentation/.build' 'make -C Documentation lint-docs'
    Benchmark 1: make -C Documentation lint-docs' in 'HEAD~0
      Time (mean ± σ):      2.129 s ±  0.011 s    [User: 1.840 s, System: 0.321 s]
      Range (min … max):    2.121 s …  2.158 s    10 runs

    Benchmark 2: make -C Documentation lint-docs' in 'HEAD~1
      Time (mean ± σ):      2.659 s ±  0.002 s    [User: 2.306 s, System: 0.397 s]
      Range (min … max):    2.657 s …  2.662 s    10 runs

    Summary
      'make -C Documentation lint-docs' in 'HEAD~0' ran
        1.25 ± 0.01 times faster than 'make -C Documentation lint-docs' in 'HEAD~1'

So let's use that pattern both for the "lint-docs" target, and a few
miscellaneous other targets.

This method of creating parent directories is explicitly racy in that
we don't know if we're going to say always create a "foo" followed by
a "foo/bar" under parallelism, or skip the "foo" because we created
"foo/bar" first. In this case it doesn't matter for anything except
that we aren't guaranteed to get the same number of rules firing when
running make in parallel.

1. https://lore.kernel.org/git/211028.861r45y3pt.gmgdl@evledraar.gmail.com/
2. https://lore.kernel.org/git/211028.86o879vvtp.gmgdl@evledraar.gmail.com/
3. https://gitlab.com/avar/git-hyperfine/

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 Documentation/Makefile | 25 +++----------------------
 Makefile               | 12 +++++++-----
 shared.mak             |  7 +++++++
 3 files changed, 17 insertions(+), 27 deletions(-)

diff --git a/Documentation/Makefile b/Documentation/Makefile
index 69a9af35397..d16b653394c 100644
--- a/Documentation/Makefile
+++ b/Documentation/Makefile
@@ -428,25 +428,11 @@ quick-install-html: require-htmlrepo
 print-man1:
 	@for i in $(MAN1_TXT); do echo $$i; done
 
-## Lint: Common
-.build:
-	$(QUIET)mkdir $@
-.build/lint-docs: | .build
-	$(QUIET)mkdir $@
-
 ## Lint: gitlink
-.build/lint-docs/gitlink: | .build/lint-docs
-	$(QUIET)mkdir $@
-.build/lint-docs/gitlink/howto: | .build/lint-docs/gitlink
-	$(QUIET)mkdir $@
-.build/lint-docs/gitlink/config: | .build/lint-docs/gitlink
-	$(QUIET)mkdir $@
 LINT_DOCS_GITLINK = $(patsubst %.txt,.build/lint-docs/gitlink/%.ok,$(HOWTO_TXT) $(DOC_DEP_TXT))
-$(LINT_DOCS_GITLINK): | .build/lint-docs/gitlink
-$(LINT_DOCS_GITLINK): | .build/lint-docs/gitlink/howto
-$(LINT_DOCS_GITLINK): | .build/lint-docs/gitlink/config
 $(LINT_DOCS_GITLINK): lint-gitlink.perl
 $(LINT_DOCS_GITLINK): .build/lint-docs/gitlink/%.ok: %.txt
+	$(call mkdir_p_parent_template)
 	$(QUIET_LINT_GITLINK)$(PERL_PATH) lint-gitlink.perl \
 		$< \
 		$(HOWTO_TXT) $(DOC_DEP_TXT) \
@@ -457,23 +443,18 @@ $(LINT_DOCS_GITLINK): .build/lint-docs/gitlink/%.ok: %.txt
 lint-docs-gitlink: $(LINT_DOCS_GITLINK)
 
 ## Lint: man-end-blurb
-.build/lint-docs/man-end-blurb: | .build/lint-docs
-	$(QUIET)mkdir $@
 LINT_DOCS_MAN_END_BLURB = $(patsubst %.txt,.build/lint-docs/man-end-blurb/%.ok,$(MAN_TXT))
-$(LINT_DOCS_MAN_END_BLURB): | .build/lint-docs/man-end-blurb
 $(LINT_DOCS_MAN_END_BLURB): lint-man-end-blurb.perl
 $(LINT_DOCS_MAN_END_BLURB): .build/lint-docs/man-end-blurb/%.ok: %.txt
+	$(call mkdir_p_parent_template)
 	$(QUIET_LINT_MANEND)$(PERL_PATH) lint-man-end-blurb.perl $< >$@
 .PHONY: lint-docs-man-end-blurb
-lint-docs-man-end-blurb: $(LINT_DOCS_MAN_END_BLURB)
 
 ## Lint: man-section-order
-.build/lint-docs/man-section-order: | .build/lint-docs
-	$(QUIET)mkdir $@
 LINT_DOCS_MAN_SECTION_ORDER = $(patsubst %.txt,.build/lint-docs/man-section-order/%.ok,$(MAN_TXT))
-$(LINT_DOCS_MAN_SECTION_ORDER): | .build/lint-docs/man-section-order
 $(LINT_DOCS_MAN_SECTION_ORDER): lint-man-section-order.perl
 $(LINT_DOCS_MAN_SECTION_ORDER): .build/lint-docs/man-section-order/%.ok: %.txt
+	$(call mkdir_p_parent_template)
 	$(QUIET_LINT_MANSEC)$(PERL_PATH) lint-man-section-order.perl $< >$@
 .PHONY: lint-docs-man-section-order
 lint-docs-man-section-order: $(LINT_DOCS_MAN_SECTION_ORDER)
diff --git a/Makefile b/Makefile
index c437aea9e4a..0a3f292bf82 100644
--- a/Makefile
+++ b/Makefile
@@ -2632,7 +2632,8 @@ all:: $(MOFILES)
 endif
 
 po/build/locale/%/LC_MESSAGES/git.mo: po/%.po
-	$(QUIET_MSGFMT)mkdir -p $(dir $@) && $(MSGFMT) -o $@ $<
+	$(call mkdir_p_parent_template)
+	$(QUIET_MSGFMT)$(MSGFMT) -o $@ $<
 
 ifndef NO_PERL
 LIB_PERL = $(wildcard perl/Git.pm perl/Git/*.pm perl/Git/*/*.pm perl/Git/*/*/*.pm)
@@ -2641,7 +2642,8 @@ LIB_CPAN = $(wildcard perl/FromCPAN/*.pm perl/FromCPAN/*/*.pm)
 LIB_CPAN_GEN = $(patsubst perl/%.pm,perl/build/lib/%.pm,$(LIB_CPAN))
 
 perl/build/lib/%.pm: perl/%.pm GIT-PERL-DEFINES
-	$(QUIET_GEN)mkdir -p $(dir $@) && \
+	$(call mkdir_p_parent_template)
+	$(QUIET_GEN) \
 	sed -e 's|@@LOCALEDIR@@|$(perl_localedir_SQ)|g' \
 	    -e 's|@@NO_GETTEXT@@|$(NO_GETTEXT_SQ)|g' \
 	    -e 's|@@NO_PERL_CPAN_FALLBACKS@@|$(call shq,$(NO_PERL_CPAN_FALLBACKS))|g' \
@@ -2655,8 +2657,8 @@ endif
 
 # install-man depends on Git.3pm even with NO_PERL=Y
 perl/build/man/man3/Git.3pm: perl/Git.pm
-	$(QUIET_GEN)mkdir -p $(dir $@) && \
-	pod2man $< $@
+	$(call mkdir_p_parent_template)
+	$(QUIET_GEN)pod2man $< $@
 
 FIND_SOURCE_FILES = ( \
 	git ls-files \
@@ -2780,7 +2782,7 @@ test_bindir_programs := $(patsubst %,bin-wrappers/%,$(BINDIR_PROGRAMS_NEED_X) $(
 all:: $(TEST_PROGRAMS) $(test_bindir_programs)
 
 bin-wrappers/%: wrap-for-bin.sh
-	@mkdir -p bin-wrappers
+	$(call mkdir_p_parent_template)
 	$(QUIET_GEN)sed -e '1s|#!.*/sh|#!$(SHELL_PATH_SQ)|' \
 	     -e 's|@@BUILD_DIR@@|$(shell pwd)|' \
 	     -e 's|@@PROG@@|$(patsubst test-%,t/helper/test-%$(X),$(@F))$(patsubst git%,$(X),$(filter $(@F),$(BINDIR_PROGRAMS_NEED_X)))|' < $< > $@ && \
diff --git a/shared.mak b/shared.mak
index 36f00e88bb8..8d3023c2782 100644
--- a/shared.mak
+++ b/shared.mak
@@ -56,6 +56,8 @@ ifndef V
 	QUIET          = @
 	QUIET_GEN      = @echo $(wspfx_sq) GEN $@;
 
+	QUIET_MKDIR_P_PARENT  = @echo $(wspfx_sq) MKDIR -p $(@D);
+
 ## Used in "Makefile"
 	QUIET_CC       = @echo $(wspfx_sq) CC $@;
 	QUIET_AR       = @echo $(wspfx_sq) AR $@;
@@ -88,6 +90,11 @@ ifndef V
 endif
 endif
 
+## Helpers
+define mkdir_p_parent_template
+$(if $(wildcard $(@D)),,$(QUIET_MKDIR_P_PARENT)$(shell mkdir -p $(@D)))
+endef
+
 ### Templates
 
 ## Template for making a GIT-SOMETHING, which changes if a
-- 
2.34.0.796.g2c87ed6146a

