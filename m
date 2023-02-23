Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBADDC61DA4
	for <git@archiver.kernel.org>; Thu, 23 Feb 2023 08:05:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230048AbjBWIFn (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 23 Feb 2023 03:05:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233018AbjBWIFe (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Feb 2023 03:05:34 -0500
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3EB22DE57
        for <git@vger.kernel.org>; Thu, 23 Feb 2023 00:05:28 -0800 (PST)
Received: by mail-wr1-x433.google.com with SMTP id i11so3745387wrp.5
        for <git@vger.kernel.org>; Thu, 23 Feb 2023 00:05:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=66yT4IR/Kh5UEh3Fpk/pth6pxmHxbTQb/Jp9GIuHxMA=;
        b=XBtfkawVdXhQMDVHngcPaaNJ6XHmTu6qi+imYqDqMM6fd5tVRaRIwIVS46CbwTik/X
         l6sR7imylhx0zJjiOzsPnlsp/sb7SYuN1RTyAOL9uGDyNAz/8Px0akvaPYlPdb8ZCdWm
         sfT3DIulXCo53gdPa4kFtKg6E3ztwaM1oEgOVI2B0+HCMjiZkUVUmiissg1uN8o3BHf7
         ps97nwny3qYqE+yDuVoPydtok/NAAhPzzbrTmcPc9+cSPAr25APsDwgtEGiC3eCYwiJN
         E9zPgcJyvPngNw62VeVOYSU5ktHWzrnIIDCUeCb2e9cFiP0cf1D3efPWK97rk+bpSROu
         YaNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=66yT4IR/Kh5UEh3Fpk/pth6pxmHxbTQb/Jp9GIuHxMA=;
        b=bsK9bTXGAkVSmGpQO+/rryI4wvZMUenuxOP0TxYN/EbRYTV2eN2DKyk1sJHD38X+p4
         MD5XSYczP1LwZ3vOtlaAKUyznPK/y8DaFyuFO07rnwAgK7ccpSy7LbtRD6eUq/IyPp+A
         PHGPx7rN+C2h2SupnHkyeuYRpKEAmCyBOkPLGWC2kfX4OI2wAjHrk+wTT4KEh2+mR4OO
         Osu7rXZxWVKS6pRS2bk9ZBIfaG52cXEDj3phWVSt2uUZtYbPhN+TYJAxMSVpEm6oH0x0
         tO63jtZ11ngTKWS6nupC92bOHnUuDJajfrDuWXSCdk0DwWdwR0L7NWPh97KPZLQMKdZO
         mCfg==
X-Gm-Message-State: AO0yUKXQQ+2d/Buo4EWoZ5wYZUTCQZoIQZvYjYsE5DponMDRh/u8x95Q
        so6e5njSAECvTARH72X8EcWkjPgxaJI=
X-Google-Smtp-Source: AK7set9XGFhHS6eTepVaaECN6f/uZZ74ngh7zJg5z2PELuJGSgnVKFKysbBedzsbboz3lK53HNxiZQ==
X-Received: by 2002:adf:f2cf:0:b0:2c7:a3c:5b90 with SMTP id d15-20020adff2cf000000b002c70a3c5b90mr4707592wrp.9.1677139526694;
        Thu, 23 Feb 2023 00:05:26 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id n30-20020a05600c3b9e00b003e206cc7237sm11727291wms.24.2023.02.23.00.05.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Feb 2023 00:05:26 -0800 (PST)
Message-Id: <bec6f89d82c98c594f88a1fd5e3cd44973c9a1c2.1677139521.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1485.git.1677139521.gitgitgadget@gmail.com>
References: <pull.1485.git.1677139521.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 23 Feb 2023 08:05:09 +0000
Subject: [PATCH 04/16] treewide: remove unnecessary cache.h includes in source
 files
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Emily Shaffer <nasamuffin@google.com>,
        Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

We had several C files include cache.h unnecessarily.  Replace those
with an include of "git-compat-util.h" instead.  Much like the previous
commit, these have all been verified via both ensuring that
    gcc -E $SOURCE_FILE | grep '"cache.h"'
found no hits and that
    make DEVELOPER=1 ${OBJECT_FILE_FOR_SOURCE_FILE}
successfully compiles without warnings.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 hashmap.c                    | 2 +-
 imap-send.c                  | 2 +-
 json-writer.c                | 2 +-
 kwset.c                      | 2 +-
 levenshtein.c                | 2 +-
 linear-assignment.c          | 2 +-
 mem-pool.c                   | 2 +-
 oidmap.c                     | 2 +-
 repo-settings.c              | 2 +-
 serve.c                      | 3 ++-
 shell.c                      | 2 +-
 t/helper/test-crontab.c      | 1 -
 t/helper/test-ctype.c        | 1 -
 t/helper/test-json-writer.c  | 1 -
 t/helper/test-pcre2-config.c | 1 -
 t/helper/test-prio-queue.c   | 1 -
 t/helper/test-run-command.c  | 2 --
 t/helper/test-sigchain.c     | 1 -
 t/helper/test-simple-ipc.c   | 3 ++-
 t/helper/test-wildmatch.c    | 1 -
 thread-utils.c               | 2 +-
 trace2.c                     | 3 ++-
 trace2/tr2_ctr.c             | 2 +-
 trace2/tr2_tbuf.c            | 2 +-
 trace2/tr2_tgt_event.c       | 2 +-
 trace2/tr2_tgt_normal.c      | 2 +-
 trace2/tr2_tgt_perf.c        | 2 +-
 trace2/tr2_tmr.c             | 3 ++-
 unix-stream-server.c         | 2 +-
 29 files changed, 25 insertions(+), 30 deletions(-)

diff --git a/hashmap.c b/hashmap.c
index cf5fea87eb0..ee45ef00852 100644
--- a/hashmap.c
+++ b/hashmap.c
@@ -1,7 +1,7 @@
 /*
  * Generic implementation of hash-based key value mappings.
  */
-#include "cache.h"
+#include "git-compat-util.h"
 #include "hashmap.h"
 
 #define FNV32_BASE ((unsigned int) 0x811c9dc5)
diff --git a/imap-send.c b/imap-send.c
index a50af56b827..93e9018439c 100644
--- a/imap-send.c
+++ b/imap-send.c
@@ -21,7 +21,7 @@
  *  along with this program; if not, see <http://www.gnu.org/licenses/>.
  */
 
-#include "cache.h"
+#include "git-compat-util.h"
 #include "config.h"
 #include "credential.h"
 #include "exec-cmd.h"
diff --git a/json-writer.c b/json-writer.c
index f1cfd8fa8c6..005c820aa42 100644
--- a/json-writer.c
+++ b/json-writer.c
@@ -1,4 +1,4 @@
-#include "cache.h"
+#include "git-compat-util.h"
 #include "json-writer.h"
 
 void jw_init(struct json_writer *jw)
diff --git a/kwset.c b/kwset.c
index 08aadf03117..4b14d4f86b8 100644
--- a/kwset.c
+++ b/kwset.c
@@ -32,7 +32,7 @@
    String Matching:  An Aid to Bibliographic Search," CACM June 1975,
    Vol. 18, No. 6, which describes the failure function used below. */
 
-#include "cache.h"
+#include "git-compat-util.h"
 
 #include "kwset.h"
 #include "compat/obstack.h"
diff --git a/levenshtein.c b/levenshtein.c
index d2632690d51..fd8026fe201 100644
--- a/levenshtein.c
+++ b/levenshtein.c
@@ -1,4 +1,4 @@
-#include "cache.h"
+#include "git-compat-util.h"
 #include "levenshtein.h"
 
 /*
diff --git a/linear-assignment.c b/linear-assignment.c
index ecffc09be6e..5416cbcf409 100644
--- a/linear-assignment.c
+++ b/linear-assignment.c
@@ -3,7 +3,7 @@
  * algorithm for dense and sparse linear assignment problems</i>. Computing,
  * 38(4), 325-340.
  */
-#include "cache.h"
+#include "git-compat-util.h"
 #include "linear-assignment.h"
 
 #define COST(column, row) cost[(column) + column_count * (row)]
diff --git a/mem-pool.c b/mem-pool.c
index 599d8e895f8..c34846d176c 100644
--- a/mem-pool.c
+++ b/mem-pool.c
@@ -2,7 +2,7 @@
  * Memory Pool implementation logic.
  */
 
-#include "cache.h"
+#include "git-compat-util.h"
 #include "mem-pool.h"
 
 #define BLOCK_GROWTH_SIZE (1024 * 1024 - sizeof(struct mp_block))
diff --git a/oidmap.c b/oidmap.c
index 49965fe8568..8c1a139c974 100644
--- a/oidmap.c
+++ b/oidmap.c
@@ -1,4 +1,4 @@
-#include "cache.h"
+#include "git-compat-util.h"
 #include "oidmap.h"
 
 static int oidmap_neq(const void *hashmap_cmp_fn_data UNUSED,
diff --git a/repo-settings.c b/repo-settings.c
index 3dbd3f0e2ec..0a6c0b381fe 100644
--- a/repo-settings.c
+++ b/repo-settings.c
@@ -1,4 +1,4 @@
-#include "cache.h"
+#include "git-compat-util.h"
 #include "config.h"
 #include "repository.h"
 #include "midx.h"
diff --git a/serve.c b/serve.c
index cbf4a143cfe..d128822347d 100644
--- a/serve.c
+++ b/serve.c
@@ -1,4 +1,4 @@
-#include "cache.h"
+#include "git-compat-util.h"
 #include "repository.h"
 #include "config.h"
 #include "pkt-line.h"
@@ -8,6 +8,7 @@
 #include "serve.h"
 #include "upload-pack.h"
 #include "bundle-uri.h"
+#include "trace2.h"
 
 static int advertise_sid = -1;
 static int client_hash_algo = GIT_HASH_SHA1;
diff --git a/shell.c b/shell.c
index af0d7c734f8..5c67e7bd97e 100644
--- a/shell.c
+++ b/shell.c
@@ -1,4 +1,4 @@
-#include "cache.h"
+#include "git-compat-util.h"
 #include "quote.h"
 #include "exec-cmd.h"
 #include "strbuf.h"
diff --git a/t/helper/test-crontab.c b/t/helper/test-crontab.c
index e6c1b1e22bb..597027a96e9 100644
--- a/t/helper/test-crontab.c
+++ b/t/helper/test-crontab.c
@@ -1,5 +1,4 @@
 #include "test-tool.h"
-#include "cache.h"
 
 /*
  * Usage: test-tool crontab <file> -l|<input>
diff --git a/t/helper/test-ctype.c b/t/helper/test-ctype.c
index 92c4c2313e7..d6c1a2ed09c 100644
--- a/t/helper/test-ctype.c
+++ b/t/helper/test-ctype.c
@@ -1,5 +1,4 @@
 #include "test-tool.h"
-#include "cache.h"
 
 static int rc;
 
diff --git a/t/helper/test-json-writer.c b/t/helper/test-json-writer.c
index 8c3edacc000..86887f53203 100644
--- a/t/helper/test-json-writer.c
+++ b/t/helper/test-json-writer.c
@@ -1,5 +1,4 @@
 #include "test-tool.h"
-#include "cache.h"
 #include "json-writer.h"
 
 static const char *expect_obj1 = "{\"a\":\"abc\",\"b\":42,\"c\":true}";
diff --git a/t/helper/test-pcre2-config.c b/t/helper/test-pcre2-config.c
index 5258fdddba0..5d0b2a2e10f 100644
--- a/t/helper/test-pcre2-config.c
+++ b/t/helper/test-pcre2-config.c
@@ -1,5 +1,4 @@
 #include "test-tool.h"
-#include "cache.h"
 #include "grep.h"
 
 int cmd__pcre2_config(int argc, const char **argv)
diff --git a/t/helper/test-prio-queue.c b/t/helper/test-prio-queue.c
index 133b5e6f4ae..ac4c65d7056 100644
--- a/t/helper/test-prio-queue.c
+++ b/t/helper/test-prio-queue.c
@@ -1,5 +1,4 @@
 #include "test-tool.h"
-#include "cache.h"
 #include "prio-queue.h"
 
 static int intcmp(const void *va, const void *vb, void *data)
diff --git a/t/helper/test-run-command.c b/t/helper/test-run-command.c
index 3ecb830f4a8..67b42ef50eb 100644
--- a/t/helper/test-run-command.c
+++ b/t/helper/test-run-command.c
@@ -9,8 +9,6 @@
  */
 
 #include "test-tool.h"
-#include "git-compat-util.h"
-#include "cache.h"
 #include "run-command.h"
 #include "strvec.h"
 #include "strbuf.h"
diff --git a/t/helper/test-sigchain.c b/t/helper/test-sigchain.c
index d013bccddae..d1cf7377b7c 100644
--- a/t/helper/test-sigchain.c
+++ b/t/helper/test-sigchain.c
@@ -1,5 +1,4 @@
 #include "test-tool.h"
-#include "cache.h"
 #include "sigchain.h"
 
 #define X(f) \
diff --git a/t/helper/test-simple-ipc.c b/t/helper/test-simple-ipc.c
index 28365ff85b6..3d1436da598 100644
--- a/t/helper/test-simple-ipc.c
+++ b/t/helper/test-simple-ipc.c
@@ -3,13 +3,14 @@
  */
 
 #include "test-tool.h"
-#include "cache.h"
+#include "gettext.h"
 #include "strbuf.h"
 #include "simple-ipc.h"
 #include "parse-options.h"
 #include "thread-utils.h"
 #include "strvec.h"
 #include "run-command.h"
+#include "trace2.h"
 
 #ifndef SUPPORTS_SIMPLE_IPC
 int cmd__simple_ipc(int argc, const char **argv)
diff --git a/t/helper/test-wildmatch.c b/t/helper/test-wildmatch.c
index 2c103d1824c..a95bb4da9b1 100644
--- a/t/helper/test-wildmatch.c
+++ b/t/helper/test-wildmatch.c
@@ -1,5 +1,4 @@
 #include "test-tool.h"
-#include "cache.h"
 
 int cmd__wildmatch(int argc, const char **argv)
 {
diff --git a/thread-utils.c b/thread-utils.c
index 53298456913..1f89ffab4c3 100644
--- a/thread-utils.c
+++ b/thread-utils.c
@@ -1,4 +1,4 @@
-#include "cache.h"
+#include "git-compat-util.h"
 #include "thread-utils.h"
 
 #if defined(hpux) || defined(__hpux) || defined(_hpux)
diff --git a/trace2.c b/trace2.c
index 279bddf53b4..e8ba62c0c3d 100644
--- a/trace2.c
+++ b/trace2.c
@@ -1,4 +1,4 @@
-#include "cache.h"
+#include "git-compat-util.h"
 #include "config.h"
 #include "json-writer.h"
 #include "quote.h"
@@ -6,6 +6,7 @@
 #include "sigchain.h"
 #include "thread-utils.h"
 #include "version.h"
+#include "trace.h"
 #include "trace2/tr2_cfg.h"
 #include "trace2/tr2_cmd_name.h"
 #include "trace2/tr2_ctr.h"
diff --git a/trace2/tr2_ctr.c b/trace2/tr2_ctr.c
index 483ca7c308f..b342d3b1a3c 100644
--- a/trace2/tr2_ctr.c
+++ b/trace2/tr2_ctr.c
@@ -1,4 +1,4 @@
-#include "cache.h"
+#include "git-compat-util.h"
 #include "thread-utils.h"
 #include "trace2/tr2_tgt.h"
 #include "trace2/tr2_tls.h"
diff --git a/trace2/tr2_tbuf.c b/trace2/tr2_tbuf.c
index 2498482d9ad..c3b3822ed7e 100644
--- a/trace2/tr2_tbuf.c
+++ b/trace2/tr2_tbuf.c
@@ -1,4 +1,4 @@
-#include "cache.h"
+#include "git-compat-util.h"
 #include "tr2_tbuf.h"
 
 void tr2_tbuf_local_time(struct tr2_tbuf *tb)
diff --git a/trace2/tr2_tgt_event.c b/trace2/tr2_tgt_event.c
index 16f6332755e..9e7aab6d510 100644
--- a/trace2/tr2_tgt_event.c
+++ b/trace2/tr2_tgt_event.c
@@ -1,4 +1,4 @@
-#include "cache.h"
+#include "git-compat-util.h"
 #include "config.h"
 #include "json-writer.h"
 #include "run-command.h"
diff --git a/trace2/tr2_tgt_normal.c b/trace2/tr2_tgt_normal.c
index fbbef68dfc0..8672c2c2d04 100644
--- a/trace2/tr2_tgt_normal.c
+++ b/trace2/tr2_tgt_normal.c
@@ -1,4 +1,4 @@
-#include "cache.h"
+#include "git-compat-util.h"
 #include "config.h"
 #include "run-command.h"
 #include "quote.h"
diff --git a/trace2/tr2_tgt_perf.c b/trace2/tr2_tgt_perf.c
index adae8032639..3f2b2d53118 100644
--- a/trace2/tr2_tgt_perf.c
+++ b/trace2/tr2_tgt_perf.c
@@ -1,4 +1,4 @@
-#include "cache.h"
+#include "git-compat-util.h"
 #include "config.h"
 #include "run-command.h"
 #include "quote.h"
diff --git a/trace2/tr2_tmr.c b/trace2/tr2_tmr.c
index 786762dfd26..31d0e4d1bd1 100644
--- a/trace2/tr2_tmr.c
+++ b/trace2/tr2_tmr.c
@@ -1,8 +1,9 @@
-#include "cache.h"
+#include "git-compat-util.h"
 #include "thread-utils.h"
 #include "trace2/tr2_tgt.h"
 #include "trace2/tr2_tls.h"
 #include "trace2/tr2_tmr.h"
+#include "trace.h"
 
 #define MY_MAX(a, b) ((a) > (b) ? (a) : (b))
 #define MY_MIN(a, b) ((a) < (b) ? (a) : (b))
diff --git a/unix-stream-server.c b/unix-stream-server.c
index efa2a207abc..22ac2373e07 100644
--- a/unix-stream-server.c
+++ b/unix-stream-server.c
@@ -1,4 +1,4 @@
-#include "cache.h"
+#include "git-compat-util.h"
 #include "lockfile.h"
 #include "unix-socket.h"
 #include "unix-stream-server.h"
-- 
gitgitgadget

