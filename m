Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E4CBC1F42D
	for <e@80x24.org>; Sun, 18 Mar 2018 08:18:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751656AbeCRISt (ORCPT <rfc822;e@80x24.org>);
        Sun, 18 Mar 2018 04:18:49 -0400
Received: from mail-lf0-f67.google.com ([209.85.215.67]:36177 "EHLO
        mail-lf0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751186AbeCRISr (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 18 Mar 2018 04:18:47 -0400
Received: by mail-lf0-f67.google.com with SMTP id z143-v6so14808131lff.3
        for <git@vger.kernel.org>; Sun, 18 Mar 2018 01:18:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=xpa5yPGqIISZECB6kW7CknCVFJadASTLsvrRDbboI6U=;
        b=imyuAMSXjRwrnwG+gJ/u3L+mOKcbkjne39WbS2u5JnVtlmypvkayQiyvUZ8aBnqPv7
         FYLrRBw5WsCSAHiIVC+Rzup7E46uBFhINBvkEEa4hRjTxvfosjl7mS91G1UbEpk6ARXC
         UWxBQBd2X2MzW5AECLHfohoBF2G/gk46XJbKghk58gKdtFsuj560zjxam4gBOWMr4nFY
         w3X/QlocaiDq4r7+NR1JivXeSZhPyQQPHj+7wrBxRvXUTuuckN4UfC2HgdkqjO/pMoV+
         NsUv2AgpXywQbFoj93wTL8u6nUIawyUwM1rRtyxVhMHS92Die5Bx41FzO0CXefJ+eUwA
         WVyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=xpa5yPGqIISZECB6kW7CknCVFJadASTLsvrRDbboI6U=;
        b=khhnyYJrl9DK1oASklBNFr9yRO5ud3AL9fv3uWeMDdkH3tabqP3DVBJ3jOhFQ2LjIU
         QtSRxt1sL7sArUflI0raovlkl3EF55hzmxh7XFvYirfjq2r+4zNTR9mKtVBEwW3ueBGJ
         3+DQpe7x73oRgGarRzaiHO6DvivPEowsEPJOxWtwOqG2TokD9/OY77bYWd/Ghq3OXMWj
         9raD6Ef1loLks3v5XUY85Rj/VAUp8eK+y8WrMnUdHq4DIY/L2aYDumzir3hEe6lJrd4/
         LOZ+++KiFth1eW8G5Xhutu908OO5kitm34479gL4U1ygQyG93LiYyV+iXNf7WQ7VS3BO
         0kGw==
X-Gm-Message-State: AElRT7EsZRKZ4z3WWcrzRACtWelOTPf2IkzvdL+Yvl0RUI4smLhJnJ0A
        NH8leLGK6o7Ax1OYz2Ap/VjTpg==
X-Google-Smtp-Source: AG47ELvUNMkzYj7mI6C76pftcEkXDeO5FfjzFUzYYqZ7pHpM0QjGsmTy8Jqr5GF+x6B8A6odUBlCog==
X-Received: by 10.46.134.25 with SMTP id a25mr5104278lji.87.1521361125754;
        Sun, 18 Mar 2018 01:18:45 -0700 (PDT)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id c76-v6sm237587lfh.17.2018.03.18.01.18.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 18 Mar 2018 01:18:44 -0700 (PDT)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     peff@peff.net
Cc:     git@vger.kernel.org, larsxschneider@gmail.com, pclouds@gmail.com,
        Junio C Hamano <gitster@pobox.com>
Subject: [PATCH] Makefile: detect compiler and enable more warnings in DEVELOPER=1
Date:   Sun, 18 Mar 2018 09:18:34 +0100
Message-Id: <20180318081834.16081-1-pclouds@gmail.com>
X-Mailer: git-send-email 2.17.0.rc0.347.gf9cf61673a
In-Reply-To: <20180317160832.GB15772@sigill.intra.peff.net>
References: <20180317160832.GB15772@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The set of extra warnings we enable when DEVELOPER has to be
conservative because we can't assume any compiler version the
developer may use. Detect the compiler version so we know when it's
safe to enable -Wextra and maybe more.

Helped-by: Jeff King <peff@peff.net>
Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 -dumpversion does not work correctly for clang. So I use "-v" instead
 which seems to produce the same output for both gcc and clang (with a
 minor difference in freebsd where it says "FreeBSD clang" instead of
 just "clang"). Not sure if it helps your "cc on debian" case though

 Tested with clang-5.0.1 and gcc-6.4.0 (too lazy to test on freebsd
 clang 3.4.1 but I don't expect surprises there)

 I will still need to pull more modern gcc/clang on travis, but that
 can wait until this patch settles.

 Makefile        | 11 +----------
 config.mak.dev  | 28 +++++++++++++++++++++++++++
 detect-compiler | 50 +++++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 79 insertions(+), 10 deletions(-)
 create mode 100644 config.mak.dev
 create mode 100755 detect-compiler

diff --git a/Makefile b/Makefile
index a1d8775adb..9dfd152a1e 100644
--- a/Makefile
+++ b/Makefile
@@ -442,15 +442,6 @@ GIT-VERSION-FILE: FORCE
 # CFLAGS and LDFLAGS are for the users to override from the command line.
 
 CFLAGS = -g -O2 -Wall
-DEVELOPER_CFLAGS = -Werror \
-	-Wdeclaration-after-statement \
-	-Wno-format-zero-length \
-	-Wold-style-definition \
-	-Woverflow \
-	-Wpointer-arith \
-	-Wstrict-prototypes \
-	-Wunused \
-	-Wvla
 LDFLAGS =
 ALL_CFLAGS = $(CPPFLAGS) $(CFLAGS)
 ALL_LDFLAGS = $(LDFLAGS)
@@ -1051,7 +1042,7 @@ include config.mak.uname
 -include config.mak
 
 ifdef DEVELOPER
-CFLAGS += $(DEVELOPER_CFLAGS)
+include config.mak.dev
 endif
 
 comma := ,
diff --git a/config.mak.dev b/config.mak.dev
new file mode 100644
index 0000000000..59aef342c4
--- /dev/null
+++ b/config.mak.dev
@@ -0,0 +1,28 @@
+CFLAGS += -Werror
+CFLAGS += -Wdeclaration-after-statement
+CFLAGS += -Wno-format-zero-length
+CFLAGS += -Wold-style-definition
+CFLAGS += -Woverflow
+CFLAGS += -Wpointer-arith
+CFLAGS += -Wstrict-prototypes
+CFLAGS += -Wunused
+CFLAGS += -Wvla
+
+COMPILER_FEATURES := $(shell ./detect-compiler $(CC))
+
+ifneq ($(filter clang4,$(COMPILER_FEATURES)),)
+CFLAGS += -Wtautological-constant-out-of-range-compare
+endif
+
+ifneq ($(or $(filter gcc6,$(COMPILER_FEATURES)),$(filter clang4,$(COMPILER_FEATURES))),)
+CFLAGS += -Wextra
+CFLAGS += -Wmissing-prototypes
+CFLAGS += -Wno-empty-body
+CFLAGS += -Wno-missing-field-initializers
+CFLAGS += -Wno-sign-compare
+CFLAGS += -Wno-unused-function
+CFLAGS += -Wno-unused-parameter
+ifneq ($(filter gcc6,$(COMPILER_FEATURES)),)
+CFLAGS += -Wno-maybe-uninitialized
+endif
+endif
diff --git a/detect-compiler b/detect-compiler
new file mode 100755
index 0000000000..bc2ea39ef5
--- /dev/null
+++ b/detect-compiler
@@ -0,0 +1,50 @@
+#!/bin/sh
+#
+# Probe the compiler for vintage, version, etc. This is used for setting
+# optional make knobs under the DEVELOPER knob.
+
+CC="$*"
+
+# we get something like (this is at least true for gcc and clang)
+#
+# FreeBSD clang version 3.4.1 (tags/RELEASE...)
+get_version_line() {
+	"$CC" -v 2>&1 | grep ' version '
+}
+
+get_family() {
+	get_version_line | sed 's/^\(.*\) version [0-9][^ ]* .*/\1/'
+}
+
+get_version() {
+	get_version_line | sed 's/^.* version \([0-9][^ ]*\) .*/\1/'
+}
+
+print_flags() {
+	family=$1
+	version=$(get_version | cut -f 1 -d .)
+
+	# Print a feature flag not only for the current version, but also
+	# for any prior versions we encompass. This avoids needing to do
+	# numeric comparisons in make, which are awkward.
+	while test "$version" -gt 0
+	do
+		echo $family$version
+		version=$((version - 1))
+	done
+}
+
+case "$(get_family)" in
+gcc)
+	print_flags gcc
+	;;
+*clang)
+	print_flags clang
+	;;
+"FreeBSD clang")
+	print_flags clang
+	;;
+*)
+	: unknown compiler family
+	;;
+esac
-- 
2.17.0.rc0.347.gf9cf61673a

