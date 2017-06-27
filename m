Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 65CD020401
	for <e@80x24.org>; Tue, 27 Jun 2017 12:17:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752920AbdF0MRr (ORCPT <rfc822;e@80x24.org>);
        Tue, 27 Jun 2017 08:17:47 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:34724 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752191AbdF0MRo (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Jun 2017 08:17:44 -0400
Received: by mail-wm0-f67.google.com with SMTP id p204so623150wmg.1
        for <git@vger.kernel.org>; Tue, 27 Jun 2017 05:17:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=Br+593ULnr9gfGnbSW6jnC4ilv0Quy7gYNE1bL+vCTU=;
        b=RDyJZR+OwZWdw8HHxeHdSZiZrqqx41mtPBjnC9FDq72oT7H741C66d8mLMZ2hc2KPP
         AoKKWxglvukYsHuIVdfL6tIB8knXcrwv7upT21hnB7bbxuKA5Ms3ZHIJw4ANKeaV21rP
         X3sBo0R94mbxqB53abBPyjzzsK/8wd/ZeEZJiE9mrCC1+NzXO0eMHH03VKlSBLmJnOFk
         8M2lCFlr+HAgqYKKNjeujYAGY02Y/aM/M+ZGhLn+78kqh2RUcR2FZTHzs06WCRivjCX6
         vhwtUt5XgQWRYhaH3SYcqqw9/K/5rudFBBIMnqhCx36rBlqFMIX989PKQjXgXoFRmw+u
         B1tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=Br+593ULnr9gfGnbSW6jnC4ilv0Quy7gYNE1bL+vCTU=;
        b=dkhhJuuDfYRrcfaNnqa2L41WPsLU/pTujivkZ5/seDfNtKTwNX0yAhLVm2TI8rojec
         v5W2l15zi0hRsZ4St8WG0fP9J3YNQjKJZuuJkGzm6ayUCGWTRU8KOCxV/Ue2KEQzwOMn
         C4kcdYAJdnCm699DrFCD2LX7dZIikBpuOT68fuAmtyN/Q4XgRFX3lbmsvX4G2g8eiyjB
         HxBGIignOGVuWzD35qyH1rjBA2VX5HNtmzDmVAMJdfEz3334LJo5CSUZ29Qt/40nx6u1
         ZjIYFrkcugatTId06e/kpng9KSi+AA65DEJjGoT90q89MVP9Eiem2Nc2dB9HVTNGwSIt
         nMvw==
X-Gm-Message-State: AKS2vOyq/LQw6K5CSCALe2XkeFZcobQWAIj91fXwfucSbW2HmKhZRXoM
        mYQ+2ZFFVqQsByzuNcQ=
X-Received: by 10.80.173.235 with SMTP id b40mr3803361edd.110.1498565852768;
        Tue, 27 Jun 2017 05:17:32 -0700 (PDT)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id l17sm1510926edc.39.2017.06.27.05.17.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 27 Jun 2017 05:17:31 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Michael Kebe <michael.kebe@gmail.com>,
        "Liam R . Howlett" <Liam.Howlett@Oracle.com>,
        Adam Dinwoodie <adam@dinwoodie.org>,
        Stefan Beller <sbeller@google.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 2/3] sha1dc: optionally use sha1collisiondetection as a submodule
Date:   Tue, 27 Jun 2017 12:17:17 +0000
Message-Id: <20170627121718.12078-3-avarab@gmail.com>
X-Mailer: git-send-email 2.13.1.611.g7e3b11ae1
In-Reply-To: <20170627121718.12078-1-avarab@gmail.com>
References: <20170627121718.12078-1-avarab@gmail.com>
In-Reply-To: <CAKKM46tHq13XiW5C8sux3=PZ1VHSu_npG8ExfWwcPD7rkZkyRQ@mail.gmail.com>
References: <CAKKM46tHq13XiW5C8sux3=PZ1VHSu_npG8ExfWwcPD7rkZkyRQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add an option to use the sha1collisiondetection library from the
submodule in sha1collisiondetection/ instead of in the copy in the
sha1dc/ directory.

This allows us to try out the submodule in sha1collisiondetection
without breaking the build for anyone who's not expecting them as we
work out any kinks.

This uses my own fork which integrates PR #36. See the preceding
commit ("sha1dc: update from my PR #36", 2017-06-27) for details.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 .gitmodules            |  4 ++++
 Makefile               | 12 ++++++++++++
 hash.h                 |  4 ++++
 sha1collisiondetection |  1 +
 4 files changed, 21 insertions(+)
 create mode 100644 .gitmodules
 create mode 160000 sha1collisiondetection

diff --git a/.gitmodules b/.gitmodules
new file mode 100644
index 0000000000..2fea9996e9
--- /dev/null
+++ b/.gitmodules
@@ -0,0 +1,4 @@
+[submodule "sha1collisiondetection"]
+	path = sha1collisiondetection
+	url = https://github.com/avar/sha1collisiondetection.git
+	branch = bigend-detect-solaris-again
diff --git a/Makefile b/Makefile
index b94cd5633c..f0cac1f246 100644
--- a/Makefile
+++ b/Makefile
@@ -162,6 +162,12 @@ all::
 # algorithm. This is slower, but may detect attempted collision attacks.
 # Takes priority over other *_SHA1 knobs.
 #
+# Define DC_SHA1_SUBMODULE in addition to DC_SHA1 to use the
+# sha1collisiondetection shipped as a submodule instead of the
+# non-submodule copy in sha1dc/. This is an experimental option used
+# by the git project to migrate to using sha1collisiondetection as a
+# submodule.
+#
 # Define OPENSSL_SHA1 environment variable when running make to link
 # with the SHA1 routine from openssl library.
 #
@@ -1448,8 +1454,14 @@ ifdef APPLE_COMMON_CRYPTO
 	BASIC_CFLAGS += -DSHA1_APPLE
 else
 	DC_SHA1 := YesPlease
+ifdef DC_SHA1_SUBMODULE
+	LIB_OBJS += sha1collisiondetection/lib/sha1.o
+	LIB_OBJS += sha1collisiondetection/lib/ubc_check.o
+	BASIC_CFLAGS += -DDC_SHA1_SUBMODULE
+else
 	LIB_OBJS += sha1dc/sha1.o
 	LIB_OBJS += sha1dc/ubc_check.o
+endif
 	BASIC_CFLAGS += \
 		-DSHA1_DC \
 		-DSHA1DC_NO_STANDARD_INCLUDES \
diff --git a/hash.h b/hash.h
index a11fc9233f..bef3e630a0 100644
--- a/hash.h
+++ b/hash.h
@@ -8,7 +8,11 @@
 #elif defined(SHA1_OPENSSL)
 #include <openssl/sha.h>
 #elif defined(SHA1_DC)
+#ifdef DC_SHA1_SUBMODULE
+#include "sha1collisiondetection/lib/sha1.h"
+#else
 #include "sha1dc/sha1.h"
+#endif
 #else /* SHA1_BLK */
 #include "block-sha1/sha1.h"
 #endif
diff --git a/sha1collisiondetection b/sha1collisiondetection
new file mode 160000
index 0000000000..56ab30c4c9
--- /dev/null
+++ b/sha1collisiondetection
@@ -0,0 +1 @@
+Subproject commit 56ab30c4c998e1e7f3075705087a2f0c4c4202d7
-- 
2.13.1.611.g7e3b11ae1

