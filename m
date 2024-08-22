Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FA1B1CBEA3
	for <git@vger.kernel.org>; Thu, 22 Aug 2024 13:52:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724334738; cv=none; b=UatQ0xhvUT+NzoRcQT54HWk0XnSbJhR4ayVrG0hIrtJ0UDv0clOdQd5aiWpx3AdJyF4Fnvs7tWZXN5wn1bsPzeNkD1491UdHVTAW+1ONPdeNzednfZEekI4Kfpy+HTikLkAyI60JTe/iLpPT5R9q8MxO6IJeiHWbS3Swh+rApck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724334738; c=relaxed/simple;
	bh=4ZJLsjvwgUN6AjIkhsZ7Tnje5A4OynzUlEr3WCNY0do=;
	h=Message-Id:From:Date:Subject:Content-Type:MIME-Version:To:Cc; b=TBLInUeDIWM/q+ulJ19WjeGn3Z2FKF9IvgmXMbvTpadqhso/6PgcrDygzQ7nnOvwSeIvpyJdxX7P8DukwK3OQCPw+fCkWWJEd6MzYSO+lKwOnwaUI4pIBqfvyJWh/rdbhPgNf0llMiamxqR/UZI65s3GFK5qzlm/efn8GnxDxpg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cF7lILs6; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cF7lILs6"
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-a7a9cf7d3f3so123938366b.1
        for <git@vger.kernel.org>; Thu, 22 Aug 2024 06:52:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724334734; x=1724939534; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=b+NdsCErubiLGJIR5dXdi8R9RG3AGEU2sfKs0rufTPs=;
        b=cF7lILs6pBi/Lu14dVl2O1Gku6uXhT40oYqK22DdUyFAfEdd+1Flz6eAP81S+rWYGv
         E0aYMOcG78Mc6X7OHwRdVNp/Fe7g3tnk0ceTWV7bCXtWxMnUmQ6o/2dEmIq1sELvrOZZ
         /oTODptANj6rnCRl+JeOaEHmISiDTVnQyBSjYona2kmh8W3m+kkuQHmfI/kVWcbkDuc3
         3KnUK1j9cN0K9jtPLLbrBcD5Wn/EDfppc5EpNDVd/l8c7jzvLJmKNlMh0tEdgRhCiNsU
         VQ8nSN7bQIOjSN1R25/JxYlIK8x2GaswgrjLvi67WYPWov/BlbIJA/0tTzhcGWVAv3k3
         +RFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724334734; x=1724939534;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=b+NdsCErubiLGJIR5dXdi8R9RG3AGEU2sfKs0rufTPs=;
        b=Yj+RBOp43rH18kkm30JmY9oHKSPbObjhHptqR8xuDZdudIiT3cDewvqbCWhZ8mF4pY
         YSl8w6R1/Kj3BNfIzaPMmYSNRZb14cCQnYkNfIs/P1XVEnFLB08Ab+/l2VhAvxcELrWc
         XOqXD7pyGcbvT7FfqXuE8LuNCQoR+w9sWfCJLjSTyU0JmEGyk+0gim5UtPloFrs2IuVF
         rOldvZDKw0iLWHttjSsHnxS1zY0EevvkMYiUsgRSwXy1a+zlCzW3dYUUFOoZ+P5nxYF+
         57JOaWJWMRtxz6ILcaQrYbasFozOIBSl7F+a6e5YkA+IlRrsgUzh79sxnG0pKS2PS4Mz
         Y6hg==
X-Gm-Message-State: AOJu0YxGm/Qql2WcmNKfb3geXriWXCYI+Ots5FjNzrTM386zfOm/Z9jw
	NEEpLpPc2Ca6VjOL6ufLAws1LU2794q+TTuEhMp10t7Nj+c+N9YKUVC+zg==
X-Google-Smtp-Source: AGHT+IHw5KLqhnaDCKvmcClb5NVH1tVbSiJufZBuhgUjmyJUqbLYjm+y0rppbAOPQGomKHCzSCWOyA==
X-Received: by 2002:a17:907:3d8a:b0:a7a:8cb9:7491 with SMTP id a640c23a62f3a-a866f8f391dmr374703866b.54.1724334733658;
        Thu, 22 Aug 2024 06:52:13 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a868f29a568sm123389166b.53.2024.08.22.06.52.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Aug 2024 06:52:13 -0700 (PDT)
Message-Id: <pull.1769.git.git.1724334732249.gitgitgadget@gmail.com>
From: "Haritha  via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 22 Aug 2024 13:52:12 +0000
Subject: [PATCH] exec_cmd: RUNTIME_PREFIX on z/OS systems
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
Cc: Haritha  <harithamma.d@ibm.com>,
    D Harithamma <harithamma.d@ibm.com>

From: D Harithamma <harithamma.d@ibm.com>

Enable Git to resolve its own binary location using __getprogramdir
and getprogname.

Since /proc is not a mandatory filesystem on z/OS, we cannot rely on the
git_get_exec_path_procfs method to determine Git's executable path. To
address this, we have implemented git_get_exec_path_zos, which resolves
the executable path by extracting it from the current program's
directory and filename.

Signed-off-by: D Harithamma <harithamma.d@ibm.com>
---
    exec_cmd: RUNTIME_PREFIX on z/OS systems
    
    Enable Git to resolve its own binary location using __getprogramdir and
    getprogname.
    
    Since /proc is not a mandatory filesystem on z/OS, we cannot rely on the
    git_get_exec_path_procfs method to determine Git's executable path. To
    address this, we have implemented git_get_exec_path_zos, which resolves
    the executable path by extracting it from the current program's
    directory and filename.

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1769%2FHarithaIBM%2FexecmdFix-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1769/HarithaIBM/execmdFix-v1
Pull-Request: https://github.com/git/git/pull/1769

 Makefile         |  8 ++++++++
 config.mak.uname |  1 +
 exec-cmd.c       | 23 +++++++++++++++++++++++
 3 files changed, 32 insertions(+)

diff --git a/Makefile b/Makefile
index a87e18b317d..bdc68234823 100644
--- a/Makefile
+++ b/Makefile
@@ -385,6 +385,10 @@ include shared.mak
 # supports calling _NSGetExecutablePath to retrieve the path of the running
 # executable.
 #
+# When using RUNTIME_PREFIX, define HAVE_ZOS_GET_EXECUTABLE_PATH if your platform
+# supports calling __getprogramdir and getprogname to retrieve the path of the
+# running executable.
+#
 # When using RUNTIME_PREFIX, define HAVE_WPGMPTR if your platform offers
 # the global variable _wpgmptr containing the absolute path of the current
 # executable (this is the case on Windows).
@@ -2155,6 +2159,10 @@ ifdef HAVE_NS_GET_EXECUTABLE_PATH
 	BASIC_CFLAGS += -DHAVE_NS_GET_EXECUTABLE_PATH
 endif
 
+ifdef HAVE_ZOS_GET_EXECUTABLE_PATH
+        BASIC_CFLAGS += -DHAVE_ZOS_GET_EXECUTABLE_PATH
+endif
+
 ifdef HAVE_WPGMPTR
 	BASIC_CFLAGS += -DHAVE_WPGMPTR
 endif
diff --git a/config.mak.uname b/config.mak.uname
index aa0fd26bd53..904bcf35987 100644
--- a/config.mak.uname
+++ b/config.mak.uname
@@ -648,6 +648,7 @@ ifeq ($(uname_S),OS/390)
 	NO_GECOS_IN_PWENT = YesPlease
 	HAVE_STRINGS_H = YesPlease
 	NEEDS_MODE_TRANSLATION = YesPlease
+	HAVE_ZOS_GET_EXECUTABLE_PATH = YesPlease
 endif
 ifeq ($(uname_S),MINGW)
         ifeq ($(shell expr "$(uname_R)" : '1\.'),2)
diff --git a/exec-cmd.c b/exec-cmd.c
index 909777f61f4..507e67d528b 100644
--- a/exec-cmd.c
+++ b/exec-cmd.c
@@ -150,6 +150,25 @@ static int git_get_exec_path_darwin(struct strbuf *buf)
 }
 #endif /* HAVE_NS_GET_EXECUTABLE_PATH */
 
+#ifdef HAVE_ZOS_GET_EXECUTABLE_PATH
+/*
+ * Resolves the executable path from current program's directory and name.
+ *
+ * Returns 0 on success, -1 on failure.
+ */
+static int git_get_exec_path_zos(struct strbuf *buf)
+{
+	char *dir = __getprogramdir();
+	char *exe = getprogname();
+	if (dir && exe) {
+		strbuf_addf(buf, "%s/%s", dir, exe);
+		return 0;
+	}
+	return -1;
+}
+
+#endif /* HAVE_ZOS_GET_EXECUTABLE_PATH */
+
 #ifdef HAVE_WPGMPTR
 /*
  * Resolves the executable path by using the global variable _wpgmptr.
@@ -206,6 +225,10 @@ static int git_get_exec_path(struct strbuf *buf, const char *argv0)
 		git_get_exec_path_wpgmptr(buf) &&
 #endif /* HAVE_WPGMPTR */
 
+#ifdef HAVE_ZOS_GET_EXECUTABLE_PATH
+		git_get_exec_path_zos(buf) &&
+#endif /*HAVE_ZOS_GET_EXECUTABLE_PATH */
+
 		git_get_exec_path_from_argv0(buf, argv0)) {
 		return -1;
 	}

base-commit: 3a7362eb9fad0c4838f5cfaa95ed3c51a4c18d93
-- 
gitgitgadget
