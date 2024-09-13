Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0229A126C01
	for <git@vger.kernel.org>; Fri, 13 Sep 2024 21:16:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726262189; cv=none; b=o4ycvvI3r+YB3GrdXlqLjL9FDsah06cq4gtXD2jELqZkgbmD+15W/SDhs6dIr/gqTQbT8UjVnEKsoJAatx4TLArvf69tQ8+x0YAMSwNGr135vZDlrvhZb7kxXKA7y8gSHe59bT/blSAvVXS80VpoM3vN03slsZmCw/lECLtS+qw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726262189; c=relaxed/simple;
	bh=pbTLTq8gvGlhAvlykKvK6r0faaG72KQ6Ha17AUaCOMM=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=XhAVfts6k1/mMjVzyD3zq1EmLv/6S+OVvlXuLZmQcT9W5UOOP4oL030TggFOo4o+S7xmYizkf3FsrhVBzJE+rTshwqzVBNe5iQPT5gMfgxlFoAHADlQquPUTnBxC2pWk+WFhNwO3W/LYeDoSv3LGMTbOy0RwO97v0M0Twb1BFs0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GwYcvrFC; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GwYcvrFC"
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-a8d4093722bso342070866b.0
        for <git@vger.kernel.org>; Fri, 13 Sep 2024 14:16:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726262185; x=1726866985; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WlQzmh8iODDei80cmuaBu/SQ2JbYeOpq93/AYpKAzA8=;
        b=GwYcvrFCsYEAARk3BmIB0xTeQcIwYy0MsqsI9xTSUmzEr0kCL42MFf86M614zkrulx
         B7ccjuEtXQGuAvSsVGDLhmoBkiXYRikcSgV4cRv6mQkUVmyPpVlPH6nIqyk/xOML2Ns/
         tsC1/iByQsQYwbKIFgb6Kp8pGSOXR64uPfSw9kpibzqkMsb3txx2wTdT/tKLxzQOmLDo
         GHot3btMxN8pM/50t8j64tnUQ4EbgLriDa1JN02K9DTBc9NqttORh1pnnerWd1gw3wVS
         hMvNMerTTOMIzMQAv0qQTpfFN2K0WkISX7ui5ayNyDht8n3uIarz1EX41XUJq0YIzvzQ
         H6fQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726262185; x=1726866985;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WlQzmh8iODDei80cmuaBu/SQ2JbYeOpq93/AYpKAzA8=;
        b=qdCqJL8aoUyTDDm/zoUITOKbnvHtF1vDCg8c3y5QKqEvD4WSCuuPvEnuZP2WMQAswI
         OSuJEi0GAl3SuR1oVjqkuvDk718Vb+YV5lK0mppn8cY/rHPWLlH2WODnGew74kpbA7MP
         TnVLpU83CkSPNDwzMXLeHoXhc6NIhXbfAXRRBsPXudCW5CGPT9rSaA0d4Go6HlsEf63g
         H6MPnW8zCT8ty5a977YAu49fHXk/LuKgst3Cg+gOdUAnkOyhSAhRHzgbVg12YaNtNmGe
         eFnFUFnxpQV74sbDJ9k9L20pNNbHLDNbdUmlrIOhJtOG8C4BM1nD/mI6uA860U0I3rI4
         NA9g==
X-Gm-Message-State: AOJu0YxikgW+KDVJg7NWfkkFu/LjKGDL42MYiHStU12Xih9a/N0jouLy
	Fs27fxfzCk4Mku/vGjf+VAAJTWQZv+N+eJNWqUNm4b3DCcYvOCMmhGpvEg==
X-Google-Smtp-Source: AGHT+IFB6RrSqw7Orf/f8PlQIU5hn3pSQoJKQgacHbuZaihTZQhBnNu3veyAP2FiBv4wdGS6mIb8Dw==
X-Received: by 2002:a17:907:e214:b0:a86:c1ff:c973 with SMTP id a640c23a62f3a-a902961ded5mr749678766b.47.1726262185016;
        Fri, 13 Sep 2024 14:16:25 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9061096689sm1624866b.27.2024.09.13.14.16.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Sep 2024 14:16:24 -0700 (PDT)
Message-Id: <004283a1e5baf2ca60609600b7b5f75bdfc776ee.1726262178.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1778.v3.git.git.1726262177.gitgitgadget@gmail.com>
References: <pull.1778.v2.git.git.1726001960.gitgitgadget@gmail.com>
	<pull.1778.v3.git.git.1726262177.gitgitgadget@gmail.com>
From: "John Cai via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 13 Sep 2024 21:16:16 +0000
Subject: [PATCH v3 3/4] builtin: remove USE_THE_REPOSITORY for those without
 the_repository
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
Cc: Patrick Steinhardt <ps@pks.im>,
    Jeff King <peff@peff.net>,
    John Cai <johncai86@gmail.com>,
    John Cai <johncai86@gmail.com>

From: John Cai <johncai86@gmail.com>

For builtins that do not operate on a repository, remove
the #define USE_THE_REPOSITORY.

Signed-off-by: John Cai <johncai86@gmail.com>
---
 builtin/check-ref-format.c  | 1 -
 builtin/credential-cache.c  | 1 -
 builtin/diagnose.c          | 1 -
 builtin/get-tar-commit-id.c | 1 -
 builtin/mailsplit.c         | 1 -
 builtin/prune-packed.c      | 1 -
 builtin/remote-ext.c        | 1 -
 builtin/remote-fd.c         | 1 -
 builtin/upload-pack.c       | 1 -
 9 files changed, 9 deletions(-)

diff --git a/builtin/check-ref-format.c b/builtin/check-ref-format.c
index 65945171b3f..e86d8ef980b 100644
--- a/builtin/check-ref-format.c
+++ b/builtin/check-ref-format.c
@@ -1,7 +1,6 @@
 /*
  * GIT - The information manager from hell
  */
-#define USE_THE_REPOSITORY_VARIABLE
 #include "builtin.h"
 #include "refs.h"
 #include "setup.h"
diff --git a/builtin/credential-cache.c b/builtin/credential-cache.c
index 1918c474f02..5de8b9123bf 100644
--- a/builtin/credential-cache.c
+++ b/builtin/credential-cache.c
@@ -1,4 +1,3 @@
-#define USE_THE_REPOSITORY_VARIABLE
 #include "builtin.h"
 #include "credential.h"
 #include "gettext.h"
diff --git a/builtin/diagnose.c b/builtin/diagnose.c
index 5ac7872b998..66a22d918e6 100644
--- a/builtin/diagnose.c
+++ b/builtin/diagnose.c
@@ -1,4 +1,3 @@
-#define USE_THE_REPOSITORY_VARIABLE
 #include "builtin.h"
 #include "abspath.h"
 #include "gettext.h"
diff --git a/builtin/get-tar-commit-id.c b/builtin/get-tar-commit-id.c
index 272384a6b15..6bec0d1854c 100644
--- a/builtin/get-tar-commit-id.c
+++ b/builtin/get-tar-commit-id.c
@@ -1,7 +1,6 @@
 /*
  * Copyright (c) 2005, 2006 Rene Scharfe
  */
-#define USE_THE_REPOSITORY_VARIABLE
 #include "builtin.h"
 #include "commit.h"
 #include "tar.h"
diff --git a/builtin/mailsplit.c b/builtin/mailsplit.c
index 24254221417..b8f7150ce9a 100644
--- a/builtin/mailsplit.c
+++ b/builtin/mailsplit.c
@@ -4,7 +4,6 @@
  * It just splits a mbox into a list of files: "0001" "0002" ..
  * so you can process them further from there.
  */
-#define USE_THE_REPOSITORY_VARIABLE
 #include "builtin.h"
 #include "gettext.h"
 #include "string-list.h"
diff --git a/builtin/prune-packed.c b/builtin/prune-packed.c
index 0720d825c83..4d63f26b0a1 100644
--- a/builtin/prune-packed.c
+++ b/builtin/prune-packed.c
@@ -1,4 +1,3 @@
-#define USE_THE_REPOSITORY_VARIABLE
 #include "builtin.h"
 #include "gettext.h"
 #include "parse-options.h"
diff --git a/builtin/remote-ext.c b/builtin/remote-ext.c
index 119f33895e7..33c8ae0fc7d 100644
--- a/builtin/remote-ext.c
+++ b/builtin/remote-ext.c
@@ -1,4 +1,3 @@
-#define USE_THE_REPOSITORY_VARIABLE
 #include "builtin.h"
 #include "transport.h"
 #include "run-command.h"
diff --git a/builtin/remote-fd.c b/builtin/remote-fd.c
index b27ea81e4fb..ae896eda57b 100644
--- a/builtin/remote-fd.c
+++ b/builtin/remote-fd.c
@@ -1,4 +1,3 @@
-#define USE_THE_REPOSITORY_VARIABLE
 #include "builtin.h"
 #include "transport.h"
 
diff --git a/builtin/upload-pack.c b/builtin/upload-pack.c
index 363091c31e8..3b6c83fbce3 100644
--- a/builtin/upload-pack.c
+++ b/builtin/upload-pack.c
@@ -1,4 +1,3 @@
-#define USE_THE_REPOSITORY_VARIABLE
 #include "builtin.h"
 #include "exec-cmd.h"
 #include "gettext.h"
-- 
gitgitgadget

