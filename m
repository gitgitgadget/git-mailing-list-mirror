Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E20FC761AF
	for <git@archiver.kernel.org>; Tue,  4 Apr 2023 01:22:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232365AbjDDBW5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 3 Apr 2023 21:22:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231791AbjDDBWn (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 3 Apr 2023 21:22:43 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF3D31FE0
        for <git@vger.kernel.org>; Mon,  3 Apr 2023 18:22:41 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id j24so31188111wrd.0
        for <git@vger.kernel.org>; Mon, 03 Apr 2023 18:22:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680571360;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=boZ6fcnt7ctDwF1u6HOkW+EwH6wRx7nmlUTj4OrUQD4=;
        b=PylQ3cWxtqk+LZys6HoMA65n6PlrjhWqbslNdSQk/tDvTBpAbA9N4NRamJejv41+/b
         moUL8Ware4Vxh4BsRNMrkgDcbBC4gowHUZ593sbI7Qlht3/H31DF7GOHqHQVYtgTkbZI
         oEnUJD9yV6iO649Ifgbl97nqMLaoxCoFiidByHZwFRv8U2lYuzkZJ+xobZmUmhvNHJhw
         LWL7UTF3sgLt22ZSCXIeZ0pJQJz+yh3xCORkGhRjkkgKp7GbctI6by0eDykwSO0iAzpJ
         he8jEoKXQceJGxe1gI3I2j/X9z8UV5cA3jgIKkfZ+QvnDsP96HhgMWCx3V8CAeF2+wDo
         N74g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680571360;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=boZ6fcnt7ctDwF1u6HOkW+EwH6wRx7nmlUTj4OrUQD4=;
        b=cUuwL7i+7mCdTSqBVdU1gzSVM2n0Zp+ASM7CgpydX6n12PdZgGu9vxRqWGn3WOrh0V
         ve609cLzinLisoc8JrbpXbgubHO42LIXJFHXNxafY0qIkOfirMVmtGj3ZSCVLHmRcmEd
         w7AByJyEphVhN3d3s63+wDSRgNt/7QHV7KMeowTgMI/f+x1cJaFmHxJHFkpwUea9wK6+
         HG5paieirF+UyMr5yzIKdDLhImxR9X6OwjMkwYJmZ/tFjOBeUWYpUkCQfsuh3f3A3Liv
         DEvXadRdZagbLT3fTzebAVWf6VHRN+z9nqdyjBjGVZ/kbN9R/V7JvJHi3aCJ75QjDm7K
         QoCg==
X-Gm-Message-State: AAQBX9c6TqNZD5dxcYyz8GaL2Ys+hrtnkkyuYqLNAHGmsVdvyz1z1Th5
        feaeixYOOb/q+YkvMLewHuWMwJymH4Q=
X-Google-Smtp-Source: AKy350YKX7HgbraWvNM/p+dJK9m90N/LrvsHw2/CfsyYLU7qdpjnhIvOQBxUbp3DahQPrI38tlVB8Q==
X-Received: by 2002:a05:6000:1111:b0:2ce:9877:5120 with SMTP id z17-20020a056000111100b002ce98775120mr460692wrw.21.1680571360004;
        Mon, 03 Apr 2023 18:22:40 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id a2-20020adfed02000000b002c55de1c72bsm10888406wro.62.2023.04.03.18.22.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Apr 2023 18:22:39 -0700 (PDT)
Message-Id: <3c12d5ba6c3fd6e711fc0619799898db733d3033.1680571351.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1509.v2.git.1680571348.gitgitgadget@gmail.com>
References: <pull.1509.git.1680361837.gitgitgadget@gmail.com>
        <pull.1509.v2.git.1680571348.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 04 Apr 2023 01:22:11 +0000
Subject: [PATCH v2 07/24] treewide: remove unnecessary cache.h inclusion
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Calvin Wan <calvinwan@google.com>,
        Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

Several files were including cache.h solely to get other headers, such
as trace.h and trace2.h.  Since the last few commits have modified
files to make these dependencies more explicit, the inclusion of cache.h
is no longer needed in several cases.  Remove it.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 compat/simple-ipc/ipc-unix-socket.c | 2 +-
 connect.c                           | 1 -
 fetch-pack.c                        | 2 +-
 pack-write.c                        | 2 +-
 promisor-remote.c                   | 2 +-
 protocol.c                          | 2 +-
 scalar.c                            | 2 +-
 t/helper/test-date.c                | 1 -
 trace.c                             | 2 +-
 upload-pack.c                       | 2 +-
 10 files changed, 8 insertions(+), 10 deletions(-)

diff --git a/compat/simple-ipc/ipc-unix-socket.c b/compat/simple-ipc/ipc-unix-socket.c
index 7064475b39f..b2f4f22ce44 100644
--- a/compat/simple-ipc/ipc-unix-socket.c
+++ b/compat/simple-ipc/ipc-unix-socket.c
@@ -1,4 +1,4 @@
-#include "cache.h"
+#include "git-compat-util.h"
 #include "gettext.h"
 #include "simple-ipc.h"
 #include "strbuf.h"
diff --git a/connect.c b/connect.c
index 929f72ec5d7..5d8036197d5 100644
--- a/connect.c
+++ b/connect.c
@@ -1,5 +1,4 @@
 #include "git-compat-util.h"
-#include "cache.h"
 #include "config.h"
 #include "environment.h"
 #include "gettext.h"
diff --git a/fetch-pack.c b/fetch-pack.c
index 7d4f190fb1d..677102465a1 100644
--- a/fetch-pack.c
+++ b/fetch-pack.c
@@ -1,4 +1,4 @@
-#include "cache.h"
+#include "git-compat-util.h"
 #include "alloc.h"
 #include "repository.h"
 #include "config.h"
diff --git a/pack-write.c b/pack-write.c
index 152c14aa7aa..d9b460fab4c 100644
--- a/pack-write.c
+++ b/pack-write.c
@@ -1,4 +1,4 @@
-#include "cache.h"
+#include "git-compat-util.h"
 #include "environment.h"
 #include "gettext.h"
 #include "hex.h"
diff --git a/promisor-remote.c b/promisor-remote.c
index 9d83d2f4b9c..1adcd6fb0a5 100644
--- a/promisor-remote.c
+++ b/promisor-remote.c
@@ -1,4 +1,4 @@
-#include "cache.h"
+#include "git-compat-util.h"
 #include "gettext.h"
 #include "hex.h"
 #include "object-store.h"
diff --git a/protocol.c b/protocol.c
index 4d8eb887e82..079ba75acf4 100644
--- a/protocol.c
+++ b/protocol.c
@@ -1,4 +1,4 @@
-#include "cache.h"
+#include "git-compat-util.h"
 #include "config.h"
 #include "environment.h"
 #include "protocol.h"
diff --git a/scalar.c b/scalar.c
index f7680463e1b..af64f75ca66 100644
--- a/scalar.c
+++ b/scalar.c
@@ -2,7 +2,7 @@
  * The Scalar command-line interface.
  */
 
-#include "cache.h"
+#include "git-compat-util.h"
 #include "abspath.h"
 #include "gettext.h"
 #include "parse-options.h"
diff --git a/t/helper/test-date.c b/t/helper/test-date.c
index a01eec99f35..7adadd41e0b 100644
--- a/t/helper/test-date.c
+++ b/t/helper/test-date.c
@@ -1,5 +1,4 @@
 #include "test-tool.h"
-#include "cache.h"
 #include "date.h"
 #include "trace.h"
 
diff --git a/trace.c b/trace.c
index d8eaa0a786a..592c141d785 100644
--- a/trace.c
+++ b/trace.c
@@ -21,7 +21,7 @@
  *  along with this program; if not, see <http://www.gnu.org/licenses/>.
  */
 
-#include "cache.h"
+#include "git-compat-util.h"
 #include "abspath.h"
 #include "environment.h"
 #include "quote.h"
diff --git a/upload-pack.c b/upload-pack.c
index e17545a834a..0305fb2fbdc 100644
--- a/upload-pack.c
+++ b/upload-pack.c
@@ -1,4 +1,4 @@
-#include "cache.h"
+#include "git-compat-util.h"
 #include "config.h"
 #include "environment.h"
 #include "gettext.h"
-- 
gitgitgadget

