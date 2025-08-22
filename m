Received: from mail-pl1-f193.google.com (mail-pl1-f193.google.com [209.85.214.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8DDD21A92F
	for <git@vger.kernel.org>; Fri, 22 Aug 2025 08:22:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755850978; cv=none; b=XNMpTcLjn6lIh0j3OJPGojlkTyirQa64361n52BAtTgO0IqXn6I4WIb58cVJ8Mqno5h/hvvtg8aMqpjryUyLG6Pfk7Ty2YV4Q6TJYB0xZp36x2vfzzsClDWvV6ajK43n8EUM+2/tF4oT8iA0h+0ZC0/iWQ82FXm0nLu0HpIKi84=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755850978; c=relaxed/simple;
	bh=aEzn0IKqVM6xY9ib7b3ZHZldvjnvDaD5hAz95NC6nv4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=CdEG2Ne1D0MoY1kPD4r+Qo3ApoQGzia0VqpvwyyBabe7VqTYeodKEgQ+/5MRK7ZLDeYg9iMkeqN2HpIusIL5S4xz2Eph3LuLuafvPd1P2eLPz10ZiirmlLq9E+hYBZgU9YDRiFgCWhYZC232U2nD9k/7AWUAnoU83o+vgZMg//w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YN2zIxHp; arc=none smtp.client-ip=209.85.214.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YN2zIxHp"
Received: by mail-pl1-f193.google.com with SMTP id d9443c01a7336-2445806d44fso15357145ad.1
        for <git@vger.kernel.org>; Fri, 22 Aug 2025 01:22:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755850976; x=1756455776; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=4fNCT58k/my+QCdopiXS4QQfQM4qUwmIuE3uOP2SW2k=;
        b=YN2zIxHprZIqK5x7J6FdVEviaHDvq+jnSs6q7wZVmju9nsy94zbDQnk3PnWj3s5iCo
         IuBiEH5vcagNhMkq4J59IUriJisztZqEUUZOxEZ1ruSHPqgJsxk4JUctzrEdqfQ3zTMT
         5bxef0INashf9KWj3dpdSOt2wgq0pWKSzL9xz1230Ghgm31BJVndl+YIyGknrDjcrJvZ
         QCkgd6uaQQWSbuM2qtrCDWXyCwll35T0p3k/oE+peZeOHWlidn3gu3fJVZesRzno70pp
         TS3VitVsRnQgS6KebcONPbUgYJxMVV3UHVJlmprgWzvAybDOcnj/eJb/DZZKPFOK0O9p
         Hp2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755850976; x=1756455776;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4fNCT58k/my+QCdopiXS4QQfQM4qUwmIuE3uOP2SW2k=;
        b=eXdzrScJMa6elAzInycGitzC9bixwAfxOHcrh+wizgdkPnLTRmWWO2PWJ4aLt7H0lD
         OGd097A6QX5XIscOSGh9qZcOyXRZeY8bOOCFUKUStoLCccpr+SdHH0nhF0FDZSiBVjH+
         8bPqff21eAK8bjqaIdgvAD8J+UiMsMVeBBd4nPtNxGEqVuifgv/pgkBxJNpAUnKnHw3s
         dJ2gFwPfplMEZ+4LR58UOf7DcmaYnheXD3utOt4nkmmNAvvouBCllWzIrae0h4Rq2X3s
         c6PViUGjQklfnsYPvd+goypWq4YPEpfsWfDcJQ6OWLLaA195rhEzeWUZp+zEpynxFKG3
         Ny5A==
X-Gm-Message-State: AOJu0YyGj4zKEtzIHmzWYsoTPQ0iC/DDtzvAR3J7cBU6KuNzqLkZaIND
	wO6mzvf0L8JnaoMbAleqlB3kDC3C8vF4NKMpSetaVcF9hBRju5yCBAePxHSsZVej
X-Gm-Gg: ASbGnctwf3bNgPHUWAOmBMsV2EbBOmxLToNRlV9LcJxwj5OOcGrqNcoAIMrU6qjVWEJ
	CeuaOza7DIRxq1AMPTKwCop4nKUJ1CkT7Wej66En0Wl66tTYl1nangUssgeNCPrbsp/q9jsS8dN
	vBNevWF2nXIhYrtORRya8WvfMKKXoedyCHs2qWp+bZnxCXeoCi93g1NfVU9TclbiMOauAjuBTVg
	9DTWZ565GpRWga9j+Z07yIeHRvrG90lHtPnBtpCOvkN/3vMtg8dP1+Dpd44w1Z9OYVRGrFc+Xu7
	lxGyhNWZ5nyksPemf1jp7QGh22aXc0FdVxahjAjVDd0/i09tsftm6gaBcG+z+1Iy0VZ42IMKVwW
	E0tNrfHvT39qydVJ2DKUR8MQoTykNV+ytbA==
X-Google-Smtp-Source: AGHT+IF1VMlawDOELnJEGFOp8ZdJNbG0L5JwsudedpEShctvAGl13nEsXmsCMH19ByjiNyKOdA4emQ==
X-Received: by 2002:a17:902:c404:b0:246:464d:1194 with SMTP id d9443c01a7336-246464d13f7mr15803585ad.2.1755850975904;
        Fri, 22 Aug 2025 01:22:55 -0700 (PDT)
Received: from ayush-sharma.. ([103.196.213.181])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-245ed4c749fsm76547925ad.91.2025.08.22.01.22.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Aug 2025 01:22:55 -0700 (PDT)
From: monarch <ayusharmagsoccontri@gmail.com>
X-Google-Original-From: monarch <ayushoffinfo17@gmail.com>
To: git@vger.kernel.org
Cc: monarch <ayushoffinfo17@gmail.com>
Subject: [PATCH] config: add "hostname" condition to includeIf
Date: Fri, 22 Aug 2025 13:52:48 +0530
Message-ID: <20250822082249.93127-1-ayushoffinfo17@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Teach "includeIf" to include configuration based on the machine's hostname,
as returned by gethostname(2).

Example:

    [includeIf "hostname:work-laptop"]
        path = ~/.gitconfig.work

    [includeIf "hostname:home-pc"]
        path = ~/.gitconfig.home

This allows users to write host-specific configuration without separate branches.

Signed-off-by: monarch <ayushoffinfo17@gmail.com>
---
 config.c | 37 +++++++++++++++++++++++++++++++------
 1 file changed, 31 insertions(+), 6 deletions(-)

diff --git a/config.c b/config.c
index e0ff35d426..dbc1a2bc75 100644
--- a/config.c
+++ b/config.c
@@ -7,6 +7,7 @@
  */
 
 #include "git-compat-util.h"
+#include <unistd.h>
 #include "abspath.h"
 #include "date.h"
 #include "branch.h"
@@ -391,23 +392,47 @@ static int include_by_remote_url(struct config_include_data *inc,
 					     inc->remote_urls);
 }
 
+static int include_by_hostname(const char *cond, size_t cond_len)
+{
+    char actual_hostname[1024];
+    struct strbuf target_hostname = STRBUF_INIT;
+    int ret = 0;
+
+    // Make sure the call to gethostname is correct and its return value is checked.
+    if (gethostname(actual_hostname, sizeof(actual_hostname)) != 0)
+        return 0; // If it fails, the condition is false.
+
+    strbuf_add(&target_hostname, cond, cond_len);
+
+    // The core of the logic: strcmp returns 0 when strings are equal.
+    if (strcmp(actual_hostname, target_hostname.buf) == 0)
+        ret = 1; // Success, the hostnames match!
+
+    strbuf_release(&target_hostname);
+    return ret;
+}
+
 static int include_condition_is_true(const struct key_value_info *kvi,
-				     struct config_include_data *inc,
-				     const char *cond, size_t cond_len)
+	struct config_include_data *inc,
+	const char *cond, size_t cond_len)
 {
-	const struct config_options *opts = inc->opts;
+const struct config_options *opts = inc->opts;
+
+
 
 	if (skip_prefix_mem(cond, cond_len, "gitdir:", &cond, &cond_len))
 		return include_by_gitdir(kvi, opts, cond, cond_len, 0);
 	else if (skip_prefix_mem(cond, cond_len, "gitdir/i:", &cond, &cond_len))
 		return include_by_gitdir(kvi, opts, cond, cond_len, 1);
-	else if (skip_prefix_mem(cond, cond_len, "onbranch:", &cond, &cond_len))
+	else if (skip_prefix_mem(cond, cond_len, "onbranch:", &cond, cond_len))
 		return include_by_branch(inc, cond, cond_len);
 	else if (skip_prefix_mem(cond, cond_len, "hasconfig:remote.*.url:", &cond,
-				   &cond_len))
+  &cond_len))
 		return include_by_remote_url(inc, cond, cond_len);
+	else if (skip_prefix_mem(cond, cond_len, "hostname:", &cond, &cond_len))
+		return include_by_hostname(cond, cond_len);
 
-	/* unknown conditionals are always false */
+/* unknown conditionals are always false */
 	return 0;
 }
 
-- 
2.43.0

