Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B9E138DF9
	for <git@vger.kernel.org>; Mon, 17 Nov 2025 20:46:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763412378; cv=none; b=RKD51t17Kk0YTg/EgpTk5Yo6oTiGRAHaQWdm5EVvCHF0nrQs9lTwN5/0V6Qi1XxH5ah1f6SVryt/+XgHehPMucBYExueOc1WNrz0riUENhnNCQWvSEC4KDSPadrwEbpYYcoaAnvhu/bG6Gyla3ArAZ6IqJ1ym1MKCPJ/cRP6JpU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763412378; c=relaxed/simple;
	bh=kzkTy8MzVAFsl3zVdIQd934tGbxqra7QK00IAKJDjrM=;
	h=Message-Id:From:Date:Subject:Content-Type:MIME-Version:To:Cc; b=YdPboaHjx5hoWBCFTncW7TDmRlukEVnbFuPUq2Vwk4tPoL3uet6Dzpo0m4rRHXWBK1w79F30FSYWRJ6lVZgmlUeso+N/4lvO0UgV/Jngcuwgh59oTQii2jr+wsgtk/uCfbC9C/ifCil8QMPyZ5qrnBlFpX4GOnw2Z2c2hC9Sfvs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Oub9oECa; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Oub9oECa"
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-7b8eff36e3bso682682b3a.2
        for <git@vger.kernel.org>; Mon, 17 Nov 2025 12:46:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763412376; x=1764017176; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=dVotKB2ig50QKhsZzjUqie7tNjV0OhN5OlO6ILaAU0k=;
        b=Oub9oECaMr17sEyMu2+kPT1aI8djESG6hAjfYurUrrzUJlj8erpFZoasfyKwIV6rW+
         +dtVz3vLR5TtdK5KWHtItphoe+4+65HaGCYaTXHpf89Cz7xC06jgxx4YRrz+xctZX5Np
         8K37S6tiQiTMu/421xevM5/dE7uZ7RIKvkndbBjfCb6iGhMbr3pGTeHZa4zDK4YpIpZ5
         NDlv6D0Rpz5j9BNBbNUFBehichm4xSSMc2h5VJq9toV774tik05tsywzvzM4M/4g4Zdk
         C8btU+vhxrGQrLfArjXFjlu5zkgKTvlbP0oIfFfvKh7ca2+fKHOZe3KO5beg6Z++N6l8
         PEhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763412376; x=1764017176;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dVotKB2ig50QKhsZzjUqie7tNjV0OhN5OlO6ILaAU0k=;
        b=qqQhES7RXVIwrQ6CKofGUUNI6DXw2BLrXlOuYFX9itw9thAilTDjTEfbJeYCNOId/F
         TDLW1wSmJ0psKB6Ml1D8Rq8GIJcFMAGfmmWXcqQ5Kk20wrKzFwDBDZQvN4LTCMai5TTN
         xjJONNjXEbw4jtfxudc2J4Yqzooc0PM5+nTK4o4EJGXtyarlxwckvaiKbCHsUDDrmPIM
         uKTsPOfkErdekpqb8IwBh0GpFwDJs7llx40zO5TFbSaHuFIzcDXm4nKgkIiNuULx2O0v
         KybHkbU9apQL9VoPmGR4DiiUyZHb+IJJSGEnpqmw0cK3N0l7J+JoX0qBQxEii7mrJZTk
         vX8w==
X-Gm-Message-State: AOJu0YwrLDVApGyauX/9AduVSPWfny7v7o9O6aqVYGmS7kxDExYF7ckD
	TH5vEj9QklJJ5Uqmm3IF+INQIOAyaYpGvVFSJbl9cmdzaf8CyFCILtUqWtw7/A==
X-Gm-Gg: ASbGnctT9ynurq0IQwYPjRaPpEsVJIHLnvvOTHZYxQj8M7MW+pRtp6r1YjQPtF1MdVq
	GFif6etYIWAzFd1sY8Wvx5VrhBHUW+0Cr8emgOJsd2J1SZXQ5jveV5VKC3nFbiDj26wV/8WTtBo
	41aZC8gk809LTiqSUwQpQH7g7TOiEFF+PL4dSFLVo2S97NvkyveTB6fzldrD9RIjzVjGhsfT6K/
	Mkk3q6uqt1Leu0uTfOE1/Uoc2ad+34D1EPAq3HsG108D3YIj16pEkyB2+N0vQys/vqPDw45Wn2S
	9DjBRk64BwlKYl/qTPaec+82xiKKIQ5rgeyGtmDzC/wGe/IU0XVERuxsiqTHxejqoFOhNy/Cfa1
	iESRqxCjLj6OhjwKU+Ssottia3MGKXLhFq1tgFGbMM2GZ3hbkHAluI46E8AJSWgSlDKa4mVix6g
	7u2Q==
X-Google-Smtp-Source: AGHT+IFs1MfoQpwMFEYIR8NQVa3wV4fZ/wW9Flcw6SkxfGz7tJJtDk8VtYDw8xksxl8IODOnKWA0zA==
X-Received: by 2002:a05:6a00:1251:b0:7a9:8770:ce5a with SMTP id d2e1a72fcca58-7ba3b1b0d6emr14937943b3a.20.1763412376178;
        Mon, 17 Nov 2025 12:46:16 -0800 (PST)
Received: from [127.0.0.1] ([20.168.118.82])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7b9250d32e8sm14261529b3a.24.2025.11.17.12.46.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Nov 2025 12:46:15 -0800 (PST)
Message-Id: <pull.2007.git.1763412374866.gitgitgadget@gmail.com>
From: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date: Mon, 17 Nov 2025 20:46:14 +0000
Subject: [PATCH] mingw: avoid the comma operator
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
Cc: Johannes Schindelin <johannes.schindelin@gmx.de>,
    Johannes Schindelin <johannes.schindelin@gmx.de>

From: Johannes Schindelin <johannes.schindelin@gmx.de>

The pattern `return errno = ..., -1;` is observed several times in
`compat/mingw.c`. It has served us well over the years, but now clang
starts complaining:

  compat/mingw.c:723:24: error: possible misuse of comma operator here [-Werror,-Wcomma]
    723 |                 return errno = ENOSYS, -1;
        |                                      ^

See for example this failing workflow run:
https://github.com/git-for-windows/git-sdk-arm64/actions/runs/15457893907/job/43513458823#step:8:201

Let's appease clang (and also reduce the use of the no longer common
comma operator).

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
    mingw: avoid the comma operator
    
    I wonder how many more times I will deal with the comma operator...

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-2007%2Fdscho%2Fmingw-avoid-the-comma-operator-5660--v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-2007/dscho/mingw-avoid-the-comma-operator-5660--v1
Pull-Request: https://github.com/gitgitgadget/git/pull/2007

 compat/mingw.c | 48 ++++++++++++++++++++++++++++--------------------
 1 file changed, 28 insertions(+), 20 deletions(-)

diff --git a/compat/mingw.c b/compat/mingw.c
index 736a07a028..90ba5cea9d 100644
--- a/compat/mingw.c
+++ b/compat/mingw.c
@@ -491,8 +491,10 @@ static int mingw_open_append(wchar_t const *wfilename, int oflags, ...)
 	DWORD create = (oflags & O_CREAT) ? OPEN_ALWAYS : OPEN_EXISTING;
 
 	/* only these flags are supported */
-	if ((oflags & ~O_CREAT) != (O_WRONLY | O_APPEND))
-		return errno = ENOSYS, -1;
+	if ((oflags & ~O_CREAT) != (O_WRONLY | O_APPEND)) {
+		errno = ENOSYS;
+		return -1;
+	}
 
 	/*
 	 * FILE_SHARE_WRITE is required to permit child processes
@@ -2450,12 +2452,14 @@ static int start_timer_thread(void)
 	timer_event = CreateEvent(NULL, FALSE, FALSE, NULL);
 	if (timer_event) {
 		timer_thread = (HANDLE) _beginthreadex(NULL, 0, ticktack, NULL, 0, NULL);
-		if (!timer_thread )
-			return errno = ENOMEM,
-				error("cannot start timer thread");
-	} else
-		return errno = ENOMEM,
-			error("cannot allocate resources for timer");
+		if (!timer_thread ) {
+			errno = ENOMEM;
+			return error("cannot start timer thread");
+		}
+	} else {
+		errno = ENOMEM;
+		return error("cannot allocate resources for timer");
+	}
 	return 0;
 }
 
@@ -2488,13 +2492,15 @@ int setitimer(int type UNUSED, struct itimerval *in, struct itimerval *out)
 	static const struct timeval zero;
 	static int atexit_done;
 
-	if (out)
-		return errno = EINVAL,
-			error("setitimer param 3 != NULL not implemented");
+	if (out) {
+		errno = EINVAL;
+		return error("setitimer param 3 != NULL not implemented");
+	}
 	if (!is_timeval_eq(&in->it_interval, &zero) &&
-	    !is_timeval_eq(&in->it_interval, &in->it_value))
-		return errno = EINVAL,
-			error("setitimer: it_interval must be zero or eq it_value");
+	    !is_timeval_eq(&in->it_interval, &in->it_value)) {
+		errno = EINVAL;
+		return error("setitimer: it_interval must be zero or eq it_value");
+	}
 
 	if (timer_thread)
 		stop_timer_thread();
@@ -2516,12 +2522,14 @@ int sigaction(int sig, struct sigaction *in, struct sigaction *out)
 {
 	if (sig == SIGCHLD)
 		return -1;
-	else if (sig != SIGALRM)
-		return errno = EINVAL,
-			error("sigaction only implemented for SIGALRM");
-	if (out)
-		return errno = EINVAL,
-			error("sigaction: param 3 != NULL not implemented");
+	else if (sig != SIGALRM) {
+		errno = EINVAL;
+		return error("sigaction only implemented for SIGALRM");
+	}
+	if (out) {
+		errno = EINVAL;
+		return error("sigaction: param 3 != NULL not implemented");
+	}
 
 	timer_fn = in->sa_handler;
 	return 0;

base-commit: 9a2fb147f2c61d0cab52c883e7e26f5b7948e3ed
-- 
gitgitgadget
