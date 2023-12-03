Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DdAtyFTe"
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3DD4F4
	for <git@vger.kernel.org>; Sat,  2 Dec 2023 22:41:30 -0800 (PST)
Received: by mail-wr1-x42b.google.com with SMTP id ffacd0b85a97d-3333224c7b9so1517406f8f.1
        for <git@vger.kernel.org>; Sat, 02 Dec 2023 22:41:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701585689; x=1702190489; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wSCkfIpGZxL9WKaqL8EtN8rgM9Yovl63d21O0EWr+bw=;
        b=DdAtyFTeKFUh+KHi7AGIIoqEbL0QR7gkMMf4JKvuULqhGnEQLFSJgRbtojUFlNqToZ
         7WWpR7M7D8nyxZdKTbcUftbdDbLGHt6czokSqdAT1KZtYj25MacKnGtiJgg8yua01vei
         3bz74ZpPFJQMklN/lqUCMVMkGeA+08x9YPgBNmP5Vmm+dR5tzcx4rRhSuZ2V0w7d30ml
         qXDKpXIIlTDFHwDmGQMeYa8HINvmQbumcmY86aN7BK0HNddPUXlf4cGv1/ovl+wAoNoi
         Wkyfzy4plLFF3xts+tJDcJaaVd5OIDD1/+48lohARhiaF/oGtygjLr1KEQw27Nzxkaeg
         BoWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701585689; x=1702190489;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wSCkfIpGZxL9WKaqL8EtN8rgM9Yovl63d21O0EWr+bw=;
        b=XLWJSK8ONpRr4+kGJcEac9a0KJg6CqgTfuJnN14s8koEkcK7xDSYYqARhauPuxIAXX
         ZO3RQCq/9UDxa+qKqedJ6TQ9nJWAwzUqESfMcSAYgJpnNWPOpLsnT2TsW/S8qeK6nhaE
         EXCCiX9/gvRVzeKkdRu/phLNgu4TYRSeeSUgEl5zE7slQnBan4N9LBw051BoFQ/q2npc
         HGduGpqvf959Rpowt3FdsUiQHvBmpVoEoXMmNv+rfYSRcm/EZMxs6rNVdpPSK4s9KH89
         so66ReRhqXwzAMKtS4Uu88GsT4mcH8+LDEgcqBTR+OHYcAMjnZOf/0P3ddPCBn59LFfI
         1/ag==
X-Gm-Message-State: AOJu0Yw90ChpGWe4uax7pQqdfWMnt3Ou/+d5vZ53gj+l1H05/MrrQemM
	0X0uaR+YUhdEdeUfnW0jxoUIR7O8sa4=
X-Google-Smtp-Source: AGHT+IFPLttA+7rU7MduIBYL+AkPgKIe16VujzT0Rl2QRs07o2Mq/MHrFtpx2yqUdhxoKLMztD3oVw==
X-Received: by 2002:a05:6000:1372:b0:332:fbd4:1f98 with SMTP id q18-20020a056000137200b00332fbd41f98mr2171339wrz.38.1701585688716;
        Sat, 02 Dec 2023 22:41:28 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id q11-20020a5d658b000000b003333298eb4bsm5498870wru.61.2023.12.02.22.41.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 02 Dec 2023 22:41:27 -0800 (PST)
Message-ID: <a2e4bcc56fb7a25c2b55213d95b4fffe074f6e91.1701585683.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1617.git.1701585682.gitgitgadget@gmail.com>
References: <pull.1617.git.1701585682.gitgitgadget@gmail.com>
From: "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sun, 03 Dec 2023 06:41:14 +0000
Subject: [PATCH 05/12] fsmonitor--daemon.h: remove unnecessary includes
Fcc: Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
To: git@vger.kernel.org
Cc: Elijah Newren <newren@gmail.com>,
    Elijah Newren <newren@gmail.com>

From: Elijah Newren <newren@gmail.com>

The unnecessary include in the header transitively pulled in some
other headers actually needed by source files, though.  Have those
source files explicitly include the headers they need.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 builtin/fsmonitor--daemon.c          | 2 ++
 compat/fsmonitor/fsm-health-win32.c  | 1 +
 compat/fsmonitor/fsm-listen-darwin.c | 1 +
 compat/fsmonitor/fsm-listen-win32.c  | 1 +
 fsmonitor--daemon.h                  | 4 +---
 5 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/builtin/fsmonitor--daemon.c b/builtin/fsmonitor--daemon.c
index 5d01db5c029..7260604534f 100644
--- a/builtin/fsmonitor--daemon.c
+++ b/builtin/fsmonitor--daemon.c
@@ -1,6 +1,7 @@
 #include "builtin.h"
 #include "abspath.h"
 #include "config.h"
+#include "dir.h"
 #include "environment.h"
 #include "gettext.h"
 #include "parse-options.h"
@@ -14,6 +15,7 @@
 #include "simple-ipc.h"
 #include "khash.h"
 #include "pkt-line.h"
+#include "run-command.h"
 #include "trace.h"
 #include "trace2.h"
 
diff --git a/compat/fsmonitor/fsm-health-win32.c b/compat/fsmonitor/fsm-health-win32.c
index 2d4e245beb1..2aa8c219ace 100644
--- a/compat/fsmonitor/fsm-health-win32.c
+++ b/compat/fsmonitor/fsm-health-win32.c
@@ -4,6 +4,7 @@
 #include "fsm-health.h"
 #include "fsmonitor--daemon.h"
 #include "gettext.h"
+#include "simple-ipc.h"
 
 /*
  * Every minute wake up and test our health.
diff --git a/compat/fsmonitor/fsm-listen-darwin.c b/compat/fsmonitor/fsm-listen-darwin.c
index 11b56d3ef12..2fc67442eb5 100644
--- a/compat/fsmonitor/fsm-listen-darwin.c
+++ b/compat/fsmonitor/fsm-listen-darwin.c
@@ -29,6 +29,7 @@
 #include "fsmonitor--daemon.h"
 #include "fsmonitor-path-utils.h"
 #include "gettext.h"
+#include "simple-ipc.h"
 #include "string-list.h"
 #include "trace.h"
 
diff --git a/compat/fsmonitor/fsm-listen-win32.c b/compat/fsmonitor/fsm-listen-win32.c
index 90a24122844..5a21dade7b8 100644
--- a/compat/fsmonitor/fsm-listen-win32.c
+++ b/compat/fsmonitor/fsm-listen-win32.c
@@ -4,6 +4,7 @@
 #include "fsm-listen.h"
 #include "fsmonitor--daemon.h"
 #include "gettext.h"
+#include "simple-ipc.h"
 #include "trace2.h"
 
 /*
diff --git a/fsmonitor--daemon.h b/fsmonitor--daemon.h
index 673f80d2aad..5cbbec8d940 100644
--- a/fsmonitor--daemon.h
+++ b/fsmonitor--daemon.h
@@ -3,9 +3,7 @@
 
 #ifdef HAVE_FSMONITOR_DAEMON_BACKEND
 
-#include "dir.h"
-#include "run-command.h"
-#include "simple-ipc.h"
+#include "hashmap.h"
 #include "thread-utils.h"
 #include "fsmonitor-path-utils.h"
 
-- 
gitgitgadget

