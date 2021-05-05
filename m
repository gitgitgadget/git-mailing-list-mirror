Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96A82C433B4
	for <git@archiver.kernel.org>; Wed,  5 May 2021 12:21:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 61B78613BE
	for <git@archiver.kernel.org>; Wed,  5 May 2021 12:21:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231300AbhEEMWy (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 5 May 2021 08:22:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232856AbhEEMWp (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 May 2021 08:22:45 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14E5AC061574
        for <git@vger.kernel.org>; Wed,  5 May 2021 05:21:49 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id 4-20020a05600c26c4b0290146e1feccd8so1016180wmv.1
        for <git@vger.kernel.org>; Wed, 05 May 2021 05:21:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=zS6ophnKtkiDHTtqAseOYy53yyYN1IQ85wSXkky/qOM=;
        b=eNTyp1Zd6LhFHcF4XA6auIL4AKijt7RhLWx6WBwCUrsDB3zaF+mG2aTAna2ceh7N+o
         PAKlggx3XFp0SE1cxisV71u7Sc0Zt91qFYIXaW/OTo3fM4JI2hzqT0VCivL63ZTzOERA
         bz9doH6WjSHfZfbG/5IguJQN7XNY0Pq/i0xgw5sGT3QJdjJ45PofMn+TfT2k2aA2H6nG
         V23p+b1/+e6XGKJWD12RPwqFE0S+OIWOXYoRqqdNMOxciV+4LA6GvrVr+s8Fr4R4qjG9
         6rPrskbw33ETMZJNqDvkXv6q6lWJPyvPUsnrqyqkL3VO3/sWjlxAe8pT5FcBNqlLtr0C
         AISg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=zS6ophnKtkiDHTtqAseOYy53yyYN1IQ85wSXkky/qOM=;
        b=scCXLDEsDB0h/QgNxZx86MlO8TtJa9xD5Qhs2jsNlPlBlTaLbbtGwGfOrOtMU3ivOa
         gFBFBVeKEkt1oi77+6bW7UW7vM+1+qGUk3kf47H0Kg4qwV2vuoLYrPkKs7R3jxBqlAO7
         HHHEA4I/7vqPLxO91dLKUmpTA2gBb/iVwB9HGmamfY/HxYwlGbUIoiqjjDAhOIbavYR6
         KFGwgFXhGXIi4tTKDbt/mNcha7iIMtUKDZuZFK3UqyAUj8izCr8+3nw4g6wQ9RxVMaTT
         mhcoUb2Yr/EY9wuUYh/zdY8VdZkZ09AsyJmLFDwoDsWo/XBAg5mO3DchXIa6OXsBLhr8
         hIIQ==
X-Gm-Message-State: AOAM533SVl4r9UPYuGThKTFADD69eFk8Ljg9n9SHr0F0QqOJPRKQDt1V
        Vc8qS9CNeh7qP3qNWwhzimfn/DYh5R2MxQ==
X-Google-Smtp-Source: ABdhPJyYwHUZNYWnlxta3S2LvnhUEqEVmEziMudjRRdZ6LNhBIICkh6Qq54IrH1YAbWws7KdpCjpVw==
X-Received: by 2002:a1c:1bca:: with SMTP id b193mr33790031wmb.28.1620217307465;
        Wed, 05 May 2021 05:21:47 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id k15sm19886643wro.87.2021.05.05.05.21.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 May 2021 05:21:46 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 4/4] perl: use mock i18n functions under NO_GETTEXT=Y
Date:   Wed,  5 May 2021 14:21:41 +0200
Message-Id: <patch-4.4-97247cb72a5-20210505T121857Z-avarab@gmail.com>
X-Mailer: git-send-email 2.31.1.838.g7ac6e98bb53
In-Reply-To: <cover-0.4-00000000000-20210505T121857Z-avarab@gmail.com>
References: <cover-0.4-00000000000-20210505T121857Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Change the logic of the i18n functions I added in 5e9637c6297 (i18n:
add infrastructure for translating Git with gettext, 2011-11-18) to
use pass-through functions when NO_GETTEXT is defined.

This speeds up the compilation time of commands that use this library
when NO_GETTEXT=Y is in effect. Loading it and POSIX.pm is around 20ms
on my machine, whereas it takes 2ms to just instantiate perl itself.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 Makefile         |  3 +++
 perl/Git/I18N.pm | 10 ++++++++++
 2 files changed, 13 insertions(+)

diff --git a/Makefile b/Makefile
index 574b25512e7..b8d6b313056 100644
--- a/Makefile
+++ b/Makefile
@@ -1986,6 +1986,7 @@ ETC_GITCONFIG_SQ = $(subst ','\'',$(ETC_GITCONFIG))
 ETC_GITATTRIBUTES_SQ = $(subst ','\'',$(ETC_GITATTRIBUTES))
 
 DESTDIR_SQ = $(subst ','\'',$(DESTDIR))
+NO_GETTEXT_SQ = $(subst ','\'',$(NO_GETTEXT))
 bindir_SQ = $(subst ','\'',$(bindir))
 bindir_relative_SQ = $(subst ','\'',$(bindir_relative))
 mandir_SQ = $(subst ','\'',$(mandir))
@@ -2276,6 +2277,7 @@ PERL_DEFINES += $(PERLLIB_EXTRA_SQ)
 PERL_DEFINES += $(perllibdir_SQ)
 PERL_DEFINES += $(RUNTIME_PREFIX)
 PERL_DEFINES += $(NO_PERL_CPAN_FALLBACKS)
+PERL_DEFINES += $(NO_GETTEXT)
 
 # Support Perl runtime prefix. In this mode, a different header is installed
 # into Perl scripts.
@@ -2680,6 +2682,7 @@ endif
 perl/build/lib/%.pm: perl/%.pm GIT-PERL-DEFINES
 	$(QUIET_GEN)mkdir -p $(dir $@) && \
 	sed -e 's|@@LOCALEDIR@@|$(perl_localedir_SQ)|g' \
+	    -e 's|@@NO_GETTEXT@@|$(NO_GETTEXT_SQ)|g' \
 	    -e 's|@@NO_PERL_CPAN_FALLBACKS@@|$(NO_PERL_CPAN_FALLBACKS_SQ)|g' \
 	< $< > $@
 
diff --git a/perl/Git/I18N.pm b/perl/Git/I18N.pm
index 2037f387c89..895e759c57a 100644
--- a/perl/Git/I18N.pm
+++ b/perl/Git/I18N.pm
@@ -16,9 +16,19 @@ BEGIN
 our @EXPORT = qw(__ __n N__);
 our @EXPORT_OK = @EXPORT;
 
+# See Git::LoadCPAN's NO_PERL_CPAN_FALLBACKS_STR for a description of
+# this "'@@' [...] '@@'" pattern.
+use constant NO_GETTEXT_STR => '@@' . 'NO_GETTEXT' . '@@';
+use constant NO_GETTEXT => (
+	q[@@NO_GETTEXT@@] ne ''
+	and
+	q[@@NO_GETTEXT@@] ne NO_GETTEXT_STR
+);
+
 sub __bootstrap_locale_messages {
 	our $TEXTDOMAIN = 'git';
 	our $TEXTDOMAINDIR ||= $ENV{GIT_TEXTDOMAINDIR} || '@@LOCALEDIR@@';
+	die "NO_GETTEXT=" . NO_GETTEXT_STR if NO_GETTEXT;
 
 	require POSIX;
 	POSIX->import(qw(setlocale));
-- 
2.31.1.838.g7ac6e98bb53

