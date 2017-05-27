Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2BB1C1FD09
	for <e@80x24.org>; Sat, 27 May 2017 11:10:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756241AbdE0LKw (ORCPT <rfc822;e@80x24.org>);
        Sat, 27 May 2017 07:10:52 -0400
Received: from mail-wm0-f43.google.com ([74.125.82.43]:37818 "EHLO
        mail-wm0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752602AbdE0LKv (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 27 May 2017 07:10:51 -0400
Received: by mail-wm0-f43.google.com with SMTP id d127so12501453wmf.0
        for <git@vger.kernel.org>; Sat, 27 May 2017 04:10:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/rPGIE762Tp3wnhKb/W9zt34QRXsPEWu/UHqoXwsJOg=;
        b=P+n0JgKa1qwzWN0PpSr/XLcMwpDteEzwZayyBpycRqll4j2xdD7UJlWyK7dA4wUpoj
         ERwTkb+N8F+jFoV9k3VSx+s4se+b7hxMcvMuz0Qm9DoK7S0BtqPu8vhEt6ims682/MGn
         WGmq6jfM0W49dOmVVXIbO+xsdUf2mHPUcTfiizehQJhwta34ebHU0zxBoOlV1gQ0WpEJ
         hE8daSotrGq1bvgZcFUCoSXVnoLHR89ya3dCyx6Immk4qQx9n3sMH/UCcaKNsRyCCm0q
         BeVixAdLXbI2ZUx9rmLEZ9t7N+84G1SpVZTtP1+xt+tWlgok8hkZSy2uu0eUqYAUg/dD
         3cTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/rPGIE762Tp3wnhKb/W9zt34QRXsPEWu/UHqoXwsJOg=;
        b=KbkAyqQ99MI2r4fHyOUaRcu/OFfaNhc2KOwSL8kvHrO/9401ITmy/bCM/y2Y2XTwLw
         X24jAwzOglcFcDfaHOFFeEbjJF3BwfcARyk/WyGqY+QVphOtUSHAETX4fnkphsUn5IaV
         HCqDVYKopeAksQPu/UQ85e6Upqz0+Hhmho9J29UI/9O680Lnb+VioPO9n3DHiREJrlZ8
         mIvaXu1v+A5+MlNZgjMSBEGUeuJGI+qPJ50o7W7uKuYD8GqZOKFmTj2Sa/8XuhQNZJ9P
         Ep4wSLFz1WL0H3JSvZbzy/RvVnUITldahs/H4tNBUe8r+I8MVx0Gb+8wcWEZjhgVbW6a
         HSWw==
X-Gm-Message-State: AODbwcAtlFea4RVCgDb/mjRD7Fi3yNtd+xxrzuIgYWzqQzKvoz0E4ZQ6
        lgMpeF6NsYG+Nb1mNsg=
X-Received: by 10.28.30.139 with SMTP id e133mr5091258wme.71.1495883449241;
        Sat, 27 May 2017 04:10:49 -0700 (PDT)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id m11sm6820884wmg.34.2017.05.27.04.10.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 27 May 2017 04:10:47 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jeff King <peff@peff.net>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [RFC/PATCH] WIP: add deprecation & experimental process/interface
Date:   Sat, 27 May 2017 11:10:32 +0000
Message-Id: <20170527111032.30897-1-avarab@gmail.com>
X-Mailer: git-send-email 2.13.0.303.g4ebf302169
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is the WIP start of a deprecation & experimental interface to
git. The goal is to formalize the workflow around deprecating
features, or around introducing new experimental features.

This is much more idea than code at the moment, but included is an
example showing how :/ might be deprecated[1] (let's not discuss /if/
we should do that here, this is just an example).

The plan, subject to RFC feedback is to:

 * Add a new config variable `core.version`. E.g. `core.version =
   2.14.0` With this the user can specify that they'd like
   new/experimental features introduced in that version (and below),
   as well as immediately getting new deprecations added in that
   version as errors.

   This is similar to perl's "use v<VERSION>".

 * Add a deprecated() function to to mark deprecated features.

   This will emit an arbitrary warning about the use of a feature once
   per-process (via static variable). The call needs to declare in
   what version the deprecation was added, and in what version it
   should start warning/dying.

   This sets up a well-defined path to deprecation, and allows users &
   packagers to plan upgrades, and e.g. set `core.version` to N
   versions in the future to see what would start warning/dying in
   those releases.

 * TODO: Add an experimental() function to mark experimental features.

   Depending on parameters & config an experimental feature might be
   off by default unless `core.use_experimental_<NAME> = true`, or it
   might warn unless that config is set.

 * TODO: Add new documentation (gitdeprecated.txt /
   gitexperimental.txt) aiming to exhaustively list deprecated &
   experimental features, and when it's planned that each of those
   will be fully removed or start/stop warning when used.

 * TODO: Subject to RFC feedback add a gitpolicy.txt similar to
   "perlpolicy" (mainly
   http://perldoc.perl.org/perlpolicy.html#BACKWARD-COMPATIBILITY-AND-DEPRECATION)
   describing how this deprecation/experimental process works. See
   also [2].

1. https://public-inbox.org/git/CACBZZX6K7ppVB0qYah76_+pjTKjsco3rHT0xRyKtF2H1dS4k_w@mail.gmail.com/
2. https://public-inbox.org/git/CACBZZX5oVKGZLKgS4aF0=XXtHO67ynS+zxSopDN9ErJGzV9n-A@mail.gmail.com/

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 GIT-VERSION-GEN |  1 +
 Makefile        |  5 +++++
 deprecate.c     | 34 ++++++++++++++++++++++++++++++++++
 deprecate.h     |  7 +++++++
 sha1_name.c     |  3 +++
 5 files changed, 50 insertions(+)
 create mode 100644 deprecate.c
 create mode 100644 deprecate.h

diff --git a/GIT-VERSION-GEN b/GIT-VERSION-GEN
index 4f94fc7574..c76bbedf86 100755
--- a/GIT-VERSION-GEN
+++ b/GIT-VERSION-GEN
@@ -37,4 +37,5 @@ fi
 test "$VN" = "$VC" || {
 	echo >&2 "GIT_VERSION = $VN"
 	echo "GIT_VERSION = $VN" >$GVF
+	echo "GIT_VERSION_INT = $(echo $VN | sed -e 's/^\([0-9]*\)\.\([0-9]*\)\..*/\1\2/')" >>$GVF
 }
diff --git a/Makefile b/Makefile
index e35542e631..1614b2b067 100644
--- a/Makefile
+++ b/Makefile
@@ -739,6 +739,7 @@ LIB_OBJS += csum-file.o
 LIB_OBJS += ctype.o
 LIB_OBJS += date.o
 LIB_OBJS += decorate.o
+LIB_OBJS += deprecate.o
 LIB_OBJS += diffcore-break.o
 LIB_OBJS += diffcore-delta.o
 LIB_OBJS += diffcore-order.o
@@ -1793,6 +1794,10 @@ version.sp version.s version.o: EXTRA_CPPFLAGS = \
 	'-DGIT_VERSION="$(GIT_VERSION)"' \
 	'-DGIT_USER_AGENT=$(GIT_USER_AGENT_CQ_SQ)'
 
+deprecate.sp deprecate.s deprecate.o: GIT-VERSION-FILE
+deprecate.sp deprecate.s deprecate.o: EXTRA_CPPFLAGS = \
+	'-DGIT_VERSION_INT="$(GIT_VERSION_INT)"'
+
 $(BUILT_INS): git$X
 	$(QUIET_BUILT_IN)$(RM) $@ && \
 	ln $< $@ 2>/dev/null || \
diff --git a/deprecate.c b/deprecate.c
new file mode 100644
index 0000000000..035a1adea1
--- /dev/null
+++ b/deprecate.c
@@ -0,0 +1,34 @@
+#include "cache.h"
+#include "deprecate.h"
+
+void deprecate(int *state, const char *message,
+		int dep_at, int warn_at, int die_at, int remove_at)
+{
+	/*
+	 * If we're going to warn let's do it once per-process, not
+	 * spew lots of warnings in a loop.
+	 */
+	if (*state == 1)
+		return;
+	else
+		*state = 1;
+
+	if (remove_at >= GIT_VERSION_INT) {
+		die("BUG: The '%s' deprecation should be removed in this release!");
+	} else if (die_at >= GIT_VERSION_INT) {
+		die(_("Deprecation error: %s"), message);
+	} else if (warn_at >= GIT_VERSION_INT) {
+		warning(_("Deprecation warning: %s"), message);
+	} else if (1) {
+		/*
+		 * TODO: Instead of `if 1` we should check a
+		 * core.version variable here.
+		 *
+		 * I.e. if set to core.version=2.13 the user is opting
+		 * in to get deprecations set at dep_at right away,
+		 * and also perhaps experimental features from a
+		 * sister experimental() interface.
+		 */
+		die(_("Early bird deprecation error: %s"), message);
+	}
+}
diff --git a/deprecate.h b/deprecate.h
new file mode 100644
index 0000000000..7d565ef0ed
--- /dev/null
+++ b/deprecate.h
@@ -0,0 +1,7 @@
+#ifndef DEPRECATE_H
+#define DEPRECATE_H
+
+extern void deprecate(int *state, const char *message,
+		      int dep_at, int warn_at, int die_at, int remove_at);
+
+#endif
diff --git a/sha1_name.c b/sha1_name.c
index 35c1e2a9e3..b381c39bd4 100644
--- a/sha1_name.c
+++ b/sha1_name.c
@@ -1505,6 +1505,7 @@ static int get_sha1_with_context_1(const char *name,
 	int namelen = strlen(name);
 	const char *cp;
 	int only_to_die = flags & GET_SHA1_ONLY_TO_DIE;
+	static int dep_state = 0;
 
 	if (only_to_die)
 		flags |= GET_SHA1_QUIETLY;
@@ -1527,6 +1528,8 @@ static int get_sha1_with_context_1(const char *name,
 		char *new_path = NULL;
 		int pos;
 		if (!only_to_die && namelen > 2 && name[1] == '/') {
+			deprecate(&dep_state, _(":/<text> is deprecated. Use ^{/<text>} instead!"),
+				  213, 214, 215, 216);
 			struct commit_list *list = NULL;
 
 			for_each_ref(handle_one_ref, &list);
-- 
2.13.0.303.g4ebf302169

