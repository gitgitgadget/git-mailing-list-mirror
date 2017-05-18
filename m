Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_MSPIKE_H3,
	RCVD_IN_MSPIKE_WL,RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2A9B4201CF
	for <e@80x24.org>; Thu, 18 May 2017 21:29:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756125AbdERV3T (ORCPT <rfc822;e@80x24.org>);
        Thu, 18 May 2017 17:29:19 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:35151 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756122AbdERV3R (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 18 May 2017 17:29:17 -0400
Received: by mail-wm0-f67.google.com with SMTP id v4so14074491wmb.2
        for <git@vger.kernel.org>; Thu, 18 May 2017 14:29:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=hqYmgGEmDavyaeV/CdN9EmmBz26I7SxaKgmxn0J6u60=;
        b=uZSCzb64TAKZjRBpTVK7Y1FEqpyJ9xtk2a+gp6hNEsnxWtyaTpOZxnVz0SPQyapwMl
         +NYy5muLk++Byr7HwcqZdazGAtdPhj2Q5AJXMXjcWU7r2sO3qxqTGdYD9ZQ/5484aqAA
         s7MOjdys2Luz+mAyuItZ7b9zH0qVtJcujkfJJlUtIIlBI/YIzAXo1tLpHlWNlmcg932I
         JN++BSPYVcLLPHQAizCuDkW7cv+pKtrmyXKgVCcMe60cFuZgRNWT6siWVYJJrUYsUDiV
         icrJ2Fcti+47E1ZxV8vBJGbaIj8+bMC1roFR+p1xKb9tOGqyQGQjSv0QrIiFJSkW2IKp
         iKMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=hqYmgGEmDavyaeV/CdN9EmmBz26I7SxaKgmxn0J6u60=;
        b=qFldBpBTG+EGW+bs+5vqNgWQSWB4N0+gdnGDjB7h7CYleytw+cCdOXYoc8BqT+9R9v
         KYmC7rVt0Mt2/TLVysCtDNJeUJfWqU7of90bE8SiGHXczbMWsxAM7bJxMXyhZw7ZlouO
         SeCNXhkp7k0Fpt9qzYa51AOOI03z2uvp12+/xVeGfK7YVTyzCZEyf8uHDnbN9Kz2/UqR
         tE4PcGGZGlyawunI2dRBpXdkO7/jaxxSVRvifF4RV+fDZIBXMQUbznzyzBJvbsrBNfaR
         J8IRU0TvY+RbcC5FmNDPe9RGEDRU0lvHcsTuY/qNKg2vkFSU5Rm/kCNpsUSx7qSImniU
         hvYw==
X-Gm-Message-State: AODbwcBmbKMZtFRIuLK3jlypwelSC98to8mSPb72E0GRCQUXCzu91PgC
        zu3Epol3G7z+YA==
X-Received: by 10.28.154.133 with SMTP id c127mr3840831wme.42.1495142955986;
        Thu, 18 May 2017 14:29:15 -0700 (PDT)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id k18sm416181wre.9.2017.05.18.14.29.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 18 May 2017 14:29:14 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Marc Stevens <marc@marc-stevens.nl>,
        Michael Kebe <michael.kebe@gmail.com>,
        Jeff King <peff@peff.net>, Stefan Beller <sbeller@google.com>,
        Brandon Williams <bmwill@google.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 2/3] sha1dc: use sha1collisiondetection as a submodule
Date:   Thu, 18 May 2017 21:28:57 +0000
Message-Id: <20170518212858.3649-3-avarab@gmail.com>
X-Mailer: git-send-email 2.13.0.303.g4ebf302169
In-Reply-To: <20170518212858.3649-1-avarab@gmail.com>
References: <20170518212858.3649-1-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Replace the forked sha1dc directory with a copy of the upstream code
imported as a submodule. This is the exact same code as now exists in
the sha1dc/ directory.

The initial reason for copy/pasting the code into sha1dc and locally
modifying it was that it needed to be altered to work with the git
project.

The upstream project has accepted my code changes to allow us to use
their code as-is, see the preceding commit for details. So import the
code as a submodule instead, this will make it easier to keep
up-to-date with any upstream fixes or improvements.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 .gitmodules            | 4 ++++
 Makefile               | 4 ++--
 hash.h                 | 2 +-
 sha1collisiondetection | 1 +
 4 files changed, 8 insertions(+), 3 deletions(-)
 create mode 100644 .gitmodules
 create mode 160000 sha1collisiondetection

diff --git a/.gitmodules b/.gitmodules
new file mode 100644
index 0000000000..cbeebdab7a
--- /dev/null
+++ b/.gitmodules
@@ -0,0 +1,4 @@
+[submodule "sha1collisiondetection"]
+	path = sha1collisiondetection
+	url = https://github.com/cr-marcstevens/sha1collisiondetection.git
+	branch = master
diff --git a/Makefile b/Makefile
index ffa6da71b7..d7f506e790 100644
--- a/Makefile
+++ b/Makefile
@@ -1412,8 +1412,8 @@ ifdef APPLE_COMMON_CRYPTO
 	BASIC_CFLAGS += -DSHA1_APPLE
 else
 	DC_SHA1 := YesPlease
-	LIB_OBJS += sha1dc/sha1.o
-	LIB_OBJS += sha1dc/ubc_check.o
+	LIB_OBJS += sha1collisiondetection/lib/sha1.o
+	LIB_OBJS += sha1collisiondetection/lib/ubc_check.o
 	BASIC_CFLAGS += \
 		-DSHA1_DC \
 		-DSHA1DC_NO_STANDARD_INCLUDES \
diff --git a/hash.h b/hash.h
index a11fc9233f..9d9892ac3e 100644
--- a/hash.h
+++ b/hash.h
@@ -8,7 +8,7 @@
 #elif defined(SHA1_OPENSSL)
 #include <openssl/sha.h>
 #elif defined(SHA1_DC)
-#include "sha1dc/sha1.h"
+#include "sha1collisiondetection/lib/sha1.h"
 #else /* SHA1_BLK */
 #include "block-sha1/sha1.h"
 #endif
diff --git a/sha1collisiondetection b/sha1collisiondetection
new file mode 160000
index 0000000000..b45fcefc71
--- /dev/null
+++ b/sha1collisiondetection
@@ -0,0 +1 @@
+Subproject commit b45fcefc71270d9a159028c22e6d36c3817da188
-- 
2.13.0.303.g4ebf302169

