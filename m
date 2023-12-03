Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b4fZ5KA+"
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44F4AEB
	for <git@vger.kernel.org>; Sat,  2 Dec 2023 22:41:36 -0800 (PST)
Received: by mail-wr1-x42e.google.com with SMTP id ffacd0b85a97d-33338c67d20so929528f8f.0
        for <git@vger.kernel.org>; Sat, 02 Dec 2023 22:41:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701585694; x=1702190494; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eWLJcNfIQIUp4tzQE7++unCeOFOjKzm/JkqM5nU7tSY=;
        b=b4fZ5KA+pAKELaoNxJJwP9NJYRXYJP+vzz4EP9o1RABQ0mKXskJgZnAaF6/evv6/CI
         67mnoJEtlUB5kruvj76nMEP3d0h4HasigBHhXTaLeTDu+weXy07mVn6GWsKypd+FW47T
         7k22UMGU4Eg8G5n4UQaHGksSiM9wM/imnMyKVuvOUCTbDvRJKqDC8PQvDsldGjJhWEjq
         V7sg2lAWdu4uXslsrL/10HRJJ/4d+/zm65DGDmu0ZGtqVddFrGsu7cARys1dWnWmpfwC
         ljQEsfC2eGSYYnuRJPyHAVWKy0nnu2Yl6qoTARjnVTwCgkTujIYfDoEO21a883F/Y1pT
         rIOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701585694; x=1702190494;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eWLJcNfIQIUp4tzQE7++unCeOFOjKzm/JkqM5nU7tSY=;
        b=tu1swk2yHls21Tx4MxJ3Tq/a5vyGQOSwP1RBOqh9p4odfJELWHFxFgR280mA4ySde/
         IBiR50NaeM3uMVfiublOXqRLmDtrFUMpYF+ZEKqNNM9AibDxi4zosnIdzHg5GwOgBbDZ
         vm2eKSbX4+G1dNqYSyiQUE0+OP93jUUm4uJRf2juY0eRPEdSvmjqrCw8r1bPGiU6vdEe
         PA3szTZIc+paRnWiRgFKThVjeJdd0u9P61rInRehFKA6raZ+OXzkRm/IQKa673DZcA7G
         Ih71ae/PsKQT74doynlCFWQV1fuyw1xY9BGCb1GixUC3fWloBL5/jjfeW0YcvQwO9npk
         O++g==
X-Gm-Message-State: AOJu0Yx/G3D3bmmWd2pnWoFIYZA2GLh7FeXb4eash5h/ZPXUmlxjIsL3
	6+XawAKgeOR99OnV7TZ5zNjniUN0LZA=
X-Google-Smtp-Source: AGHT+IHuv+8UeQ4KFqJqgumUHhhA3q5tpDyLyZ51D/DIPiA+gFxMAvnXfE7KwrtmiXri8HJo4ENTwA==
X-Received: by 2002:a05:600c:1381:b0:40b:5e21:e259 with SMTP id u1-20020a05600c138100b0040b5e21e259mr1431675wmf.70.1701585694031;
        Sat, 02 Dec 2023 22:41:34 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id l10-20020a05600c1d0a00b00407460234f9sm10773321wms.21.2023.12.02.22.41.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 02 Dec 2023 22:41:33 -0800 (PST)
Message-ID: <c11b94bfc7c084d03ed46a24b81ec1dfa9c51c69.1701585683.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1617.git.1701585682.gitgitgadget@gmail.com>
References: <pull.1617.git.1701585682.gitgitgadget@gmail.com>
From: "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sun, 03 Dec 2023 06:41:20 +0000
Subject: [PATCH 11/12] treewide: add direct includes currently only pulled in
 transitively
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

The next commit will remove a bunch of unnecessary includes, but to do
so, we need some of the lower level direct includes that files rely on
to be explicitly specified.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 builtin/commit-graph.c      | 1 +
 builtin/for-each-ref.c      | 1 +
 builtin/fsmonitor--daemon.c | 1 +
 commit-graph.c              | 1 +
 4 files changed, 4 insertions(+)

diff --git a/builtin/commit-graph.c b/builtin/commit-graph.c
index c5684342ecf..81a28c6fcdd 100644
--- a/builtin/commit-graph.c
+++ b/builtin/commit-graph.c
@@ -11,6 +11,7 @@
 #include "object-store-ll.h"
 #include "progress.h"
 #include "replace-object.h"
+#include "strbuf.h"
 #include "tag.h"
 #include "trace2.h"
 
diff --git a/builtin/for-each-ref.c b/builtin/for-each-ref.c
index 6235d72f9d3..b5bc700d13c 100644
--- a/builtin/for-each-ref.c
+++ b/builtin/for-each-ref.c
@@ -1,4 +1,5 @@
 #include "builtin.h"
+#include "commit.h"
 #include "config.h"
 #include "gettext.h"
 #include "object.h"
diff --git a/builtin/fsmonitor--daemon.c b/builtin/fsmonitor--daemon.c
index 7260604534f..9f80b9eaff5 100644
--- a/builtin/fsmonitor--daemon.c
+++ b/builtin/fsmonitor--daemon.c
@@ -12,6 +12,7 @@
 #include "compat/fsmonitor/fsm-health.h"
 #include "compat/fsmonitor/fsm-listen.h"
 #include "fsmonitor--daemon.h"
+#include "repository.h"
 #include "simple-ipc.h"
 #include "khash.h"
 #include "pkt-line.h"
diff --git a/commit-graph.c b/commit-graph.c
index 5bfee53e87b..e7212400da3 100644
--- a/commit-graph.c
+++ b/commit-graph.c
@@ -1,5 +1,6 @@
 #include "git-compat-util.h"
 #include "config.h"
+#include "csum-file.h"
 #include "gettext.h"
 #include "hex.h"
 #include "lockfile.h"
-- 
gitgitgadget

