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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01537C433E6
	for <git@archiver.kernel.org>; Tue, 23 Feb 2021 11:43:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B88F864E31
	for <git@archiver.kernel.org>; Tue, 23 Feb 2021 11:43:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232377AbhBWLnO (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 23 Feb 2021 06:43:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232217AbhBWLnI (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 Feb 2021 06:43:08 -0500
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9FA3C061793
        for <git@vger.kernel.org>; Tue, 23 Feb 2021 03:41:50 -0800 (PST)
Received: by mail-wm1-x32a.google.com with SMTP id a207so2151143wmd.1
        for <git@vger.kernel.org>; Tue, 23 Feb 2021 03:41:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=wIdVbQf1fLrm6gBvdCH6azbDyveX+hG8HEnnj4ey14g=;
        b=TOO6lZSJOzjNgkaiIvNMhqWJcHD3hjDlKx63hZBIetNSS15M3j3RBwsZENLT43Koqe
         e5Jn/BQUTKP2bOnUymoUGD/2T4p1SQRf1teVXqlSipqFlC9LKIuLgT1h2t8RVBbQe93z
         jJ3xOHRVJuBbJghMCs9AgpcD3a7kVaSw3eVtGMFy2fSt0MrT10VPqnkIIe9aAo0dxqTN
         mqSL4h3XDMFeNnj+LZx20H1GSt1rW5/F2UIQD1bZ2lNU/5SuBVV8B60JDBspvD0blvDX
         hoJv7ku20mHA4P1/bosy9FQNWjGDE62p7maHLEAr/NdxlVvWak5lkMP+8o/TJJ9t6fOa
         sNtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=wIdVbQf1fLrm6gBvdCH6azbDyveX+hG8HEnnj4ey14g=;
        b=XQ8OTreatgWE6hevQ9+xixsOdK3waAIWKk/yMmuwgeeajYo2d3vKVIzI+Hlx9kpOdS
         DslOt9l3S6qzhMhzPWTMeXo0k+tpkri6aaHB7gtXm3iLzCGXD8e/QgHIxNlv4BMaWlFD
         UD8oSIczG+F8tfUo8GNv+5UXeCVuCDwOvOKGC4q5ANbbDW3vna4uc69uV3KG8X++tqu6
         LCve+BjvGUfWnNtQg2GYluXPw0DsrHN7w4YxwxN7QeGSL42AMCTMaJ3fRYT2XjSwSA1b
         SCAzq1d2IeUkpXuLdVB6lW3Vc7fwdqw2VseHGhf9nx7f68MVDMMEt0x7Dd5jBASWMn37
         3sCw==
X-Gm-Message-State: AOAM5337WKyYnA5G7XEFbfYt65I63jDrWWGVsyaUMv3rNB45/n8O8N/f
        lQWR6GTXDrKnXh/6i/03lXd1px0XeFbjkA==
X-Google-Smtp-Source: ABdhPJxBmLaqphow5684Mui9XJMB8zQmWqMRG4hc3ZlEzQarryaHItDyyCHNg2K/zkfBPOjdYpjkpw==
X-Received: by 2002:a1c:7301:: with SMTP id d1mr24472776wmb.33.1614080509333;
        Tue, 23 Feb 2021 03:41:49 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id n9sm2391336wmi.43.2021.02.23.03.41.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Feb 2021 03:41:48 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v3 6/6] Makefile: build "$(FUZZ_OBJS)" in CI, not under "all"
Date:   Tue, 23 Feb 2021 12:41:32 +0100
Message-Id: <20210223114132.24345-7-avarab@gmail.com>
X-Mailer: git-send-email 2.30.0.284.gd98b1dd5eaa7
In-Reply-To: <20210201111715.10200-1-avarab@gmail.com>
References: <20210201111715.10200-1-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Adding $(FUZZ_OBJS) as a dependency on "all" was intentionally done in
5e472150800 (fuzz: add basic fuzz testing target., 2018-10-12).

Rather than needlessly build these objects which aren't required for
the build every time we make "all", let's instead move them to be
built by the CI jobs.

The goal is to make sure that we don't inadvertently break these, we
can accomplish that goal by building them in CI, rather than slowing
down every build of git for everyone everywhere.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 Makefile                  | 7 ++-----
 ci/run-build-and-tests.sh | 1 +
 2 files changed, 3 insertions(+), 5 deletions(-)

diff --git a/Makefile b/Makefile
index 10f7baa74b0..cfad590a194 100644
--- a/Makefile
+++ b/Makefile
@@ -665,9 +665,6 @@ FUZZ_OBJS += fuzz-pack-idx.o
 .PHONY: fuzz-objs
 fuzz-objs: $(FUZZ_OBJS)
 
-# Always build fuzz objects even if not testing, to prevent bit-rot.
-all:: $(FUZZ_OBJS)
-
 FUZZ_PROGRAMS += $(patsubst %.o,%,$(FUZZ_OBJS))
 
 # Empty...
@@ -3322,8 +3319,8 @@ FUZZ_CXXFLAGS ?= $(CFLAGS)
 
 .PHONY: fuzz-all
 
-$(FUZZ_PROGRAMS): all
+$(FUZZ_PROGRAMS): all fuzz-objs
 	$(QUIET_LINK)$(CXX) $(FUZZ_CXXFLAGS) $(LIB_OBJS) $(BUILTIN_OBJS) \
 		$(XDIFF_OBJS) $(EXTLIBS) git.o $@.o $(LIB_FUZZING_ENGINE) -o $@
 
-fuzz-all: $(FUZZ_PROGRAMS)
+fuzz-all: $(FUZZ_PROGRAMS) $(FUZZ_OBJS)
diff --git a/ci/run-build-and-tests.sh b/ci/run-build-and-tests.sh
index a66b5e8c75a..85d260476c5 100755
--- a/ci/run-build-and-tests.sh
+++ b/ci/run-build-and-tests.sh
@@ -10,6 +10,7 @@ windows*) cmd //c mklink //j t\\.prove "$(cygpath -aw "$cache_dir/.prove")";;
 *) ln -s "$cache_dir/.prove" t/.prove;;
 esac
 
+make fuzz-objs
 make
 case "$jobname" in
 linux-gcc)
-- 
2.30.0.284.gd98b1dd5eaa7

