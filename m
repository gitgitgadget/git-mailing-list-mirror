Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2BE2C433EF
	for <git@archiver.kernel.org>; Tue, 18 Jan 2022 15:14:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344977AbiARPOY (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 18 Jan 2022 10:14:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235679AbiARPOW (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 18 Jan 2022 10:14:22 -0500
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75CFAC061574
        for <git@vger.kernel.org>; Tue, 18 Jan 2022 07:14:22 -0800 (PST)
Received: by mail-ed1-x532.google.com with SMTP id z22so80979252edd.12
        for <git@vger.kernel.org>; Tue, 18 Jan 2022 07:14:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=3/NAj2qhizjbu1NShQNBiPUi49Q3gx0QD8a2dbAaoPs=;
        b=oLojtdtE4qaoVi4bkcLAZeNyf1IrWDhk7tpEc44Ks8RZIwekz9Sf/ro6/YD6J/ImNB
         LAFMsg+wDcVrlQKfRRo8IVsgPh9re9edR6ApgyntyWMvcBe50Xw2gHJcBib65AYXvr2N
         jwPM1noi4VukilkKSA8jJGVW7Lm/5rgYADBRX/olkau/JKfHYRmJmbaK82Qc0azkIDHv
         p1VssqfXvoiaYZIcj+94vbsQTww+/FeqEctms5qkuzWUMAXzAbl+8oTHhrRLGXeprJ0J
         pOXywSjw6VZoA0z+UpLxem/RpX1EEbR0kEoOBu2FIs4/pLgJf2qYhWCw/g5x1lTjD2WJ
         aRvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3/NAj2qhizjbu1NShQNBiPUi49Q3gx0QD8a2dbAaoPs=;
        b=d8SNBE3L+yzPKqi4KWnmT0quyXTTG9mkIXJ2K5wqzrUVanOdEpY09F64q+oVJEKafQ
         b9+vZQE4w0Ey3wHYySbZ9yJ8mDu/Bd0JL4J8pcORikhrCmb+SFsxddVXjBFRcbAgG4hG
         mzFv2kvW29GUM4X5gTf58C0CBm+mZLCRvtnVbbUhnzj8TATzbMWXTg0EAUYiGKmog8db
         uZ2fDr15qXKf4XZAg8183PUtbi2c9VmUCnlLC6jGagdOTkh0pEUxdhfR+1pIV6cQL2N3
         MBXo49Vi2dXnfqlFJE0iZCdHVJSqf8utkayMFelpGCbqNABeiay8Z7YFdJzsfbZp2J8H
         F0qw==
X-Gm-Message-State: AOAM530v47mL69tJuWQAMn68HYNX80NRYCMXMvk6a0dJKZ23urePtk+D
        EzcdU+TK71h0FryhI2CH4gB3xGc2qL5vqQ==
X-Google-Smtp-Source: ABdhPJzx4mWbch1ePrWTqPHnP2dK+ti/8P1wqPoaZfw/eCNc4Oao7Bd51W9Jp5OJmnfdp2WQm4dqXw==
X-Received: by 2002:a05:6402:149a:: with SMTP id e26mr22663917edv.14.1642518860725;
        Tue, 18 Jan 2022 07:14:20 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id c8sm6290edu.60.2022.01.18.07.14.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Jan 2022 07:14:20 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Han-Wen Nienhuys <hanwen@google.com>,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>, fuz@fuz.su,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH] config.mak.dev: fix DEVELOPER=1 on FreeBSD with -std=gnu99
Date:   Tue, 18 Jan 2022 16:14:17 +0100
Message-Id: <patch-1.1-06cc12be94d-20220118T151234Z-avarab@gmail.com>
X-Mailer: git-send-email 2.35.0.rc1.862.gadd77378860
In-Reply-To: <220113.86tue7vr6d.gmgdl@evledraar.gmail.com>
References: <220113.86tue7vr6d.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Since the addition of -std=gnu99 to CFLAGS under DEVELOPER=1 in
5f46385309b (config.mak.dev: specify -std=gnu99 for gcc/clang,
2021-12-08) the compilation has been broken on newer FreeBSD
systems. E.g. on FreeBSD 13 we'll now get this when compiling
archive.o:

    archive.c:337:35: error: '_Generic' is a C11 extension [-Werror,-Wc11-extensions]
                    strbuf_addstr(&path_in_archive, basename(path));
                                                    ^
    /usr/include/libgen.h:61:21: note: expanded from macro 'basename'
    #define basename(x)     __generic(x, const char *, __old_basename, basename)(x)
                            ^
    /usr/include/sys/cdefs.h:325:2: note: expanded from macro '__generic'
            _Generic(expr, t: yes, default: no)
            ^

This issue is a bug in FreeBSD introduced in
freebsd/freebsd-src@62b7f85d4749 (Leave the C11 keywords alone when we
have a recent version of GCC., 2014-09-03)[1].

That commit started conditionally using the C11 _Generic() keyword as
a function of either a __STDC_VERSION__ check, or
__has_extension(c_generic_selections). The current FreeBSD code in
sys/cdefs.h being (slightly modified since that commit):

    #if (defined(__STDC_VERSION__) && __STDC_VERSION__ >= 201112L) || \
        __has_extension(c_generic_selections)
    [...]

The inherent problem is that __has_extension() is a way to ask
Clang (and GCC) whether the compiler supports that feature, but the
-Wc11-extensions warning will be issued on the basis of the selected
__STDC_VERSION__. With -std=gnu99 the __has_extension() built-in will
return true, but the warning will still fire.

Let's narrowly work around this by checking whether:

 A. We are under FreeBSD
 B. We are using a C standard older than C11

In that case we'll include sys/cdefs.h, and undefine FreeBSD's
__generic() wrapper if it's been defined. We'll then load libgen.h,
and restore whatever __generic definition we temporarily undefined
earlier.

An alternate solution would be to simply define NO_LIBGEN_H=Y in
config.mak.uname for FreeBSD, but this way we'll use its OS-provided
basename() and dirname(), and in the general case ensure that nothing
changes outside of DEVELOPER=1 builds.

1. https://github.com/freebsd/freebsd-src/commit/62b7f85d4749

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 git-compat-util.h | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/git-compat-util.h b/git-compat-util.h
index 1229c8296b9..69d9b5f202f 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -318,7 +318,25 @@ static inline int setitimer(int which, const struct itimerval *value, struct iti
 #endif
 
 #ifndef NO_LIBGEN_H
+/*
+ * FreeBSD's libgen.h inadvertently requires C11 features, due to its
+ * sys/cdefs.h using _Generic() if
+ * __has_extension(c_generic_selections) is true, regardless of
+ * __STDC_VERSION__....
+ */
+#if defined(__FreeBSD__) && __STDC_VERSION__ - 0 < 201112L
+#include <sys/cdefs.h>
+#ifdef __generic
+#define __fbsd_generic __generic
+#endif
+#undef __generic
+#endif
 #include <libgen.h>
+/* ...continue FreeBSD-specific hack above */
+#ifdef __fbsd_generic
+#define __generic __fbsd_generic
+#undef __fbsd_generic
+#endif
 #else
 #define basename gitbasename
 char *gitbasename(char *);
-- 
2.35.0.rc1.862.gadd77378860

