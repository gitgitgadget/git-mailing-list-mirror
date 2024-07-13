Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4064E15538C
	for <git@vger.kernel.org>; Sat, 13 Jul 2024 21:08:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720904916; cv=none; b=ZkcpxUJlQpQ/di6XF9Wmibdy2iGNEI3BjknLO9OCnYNIIFiyFXxEpJhy+Y6ekf9Sn99qW032dbv/buCJ05zry6Pt/fFUsumxc5ABr4e/Fn7kgl5AYSKnCLFPe5cb2rtf5SvnNKyKSRO+Zxu9neuZ7p+3RM6PWZP5Sdq3ack1PxE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720904916; c=relaxed/simple;
	bh=wGI/u536ygogFWY5DiujXv3jyD5Cg7FCZEx8VWytJyU=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=ISMP9kBDPEovZ95CCQxQIFaLlz4oiV1pXPjlVokXrnc3vbzTYwi9ozQMUWPqbap+d9e/PQGd82TLeFMvHdkRynNTwHOR2Xp60GYGZ+wT+O57L3EIZKpmDclP558FXoIWnmME5rbu3n8IqwrrwOM6ATCW0cnwg3qnF89Qpv5P86s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bNTt5II0; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bNTt5II0"
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-3679df4cb4cso1935006f8f.0
        for <git@vger.kernel.org>; Sat, 13 Jul 2024 14:08:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720904913; x=1721509713; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pKBFxlpxtqw+lcKlQZcVepA2RqMBX87eNLI9J5v2lpI=;
        b=bNTt5II02PhPR4EhcSveoGeUfRupXpeH22Hxnsu7Zo4spIsbDsmxPA1QLnCcvYgJ/+
         AEBZhYGPvnanmCZvqViH9YpVn2bOzmLCt5oW0vRyNLERzoFAamINSlU5vY+vx3J+7MFJ
         VG9RkRDjFLheKjyfX8GZg8AHy9D/qq0YQgbVw/ZN0t5tSvc1/WLgY9fn0sJLmKiLI0In
         tWzZCC9tXCDUW6Q3AyoS/CDCyVmVOL0xzWYBQe1Rnl5ABmKsVrhFw2VcEdf1e+dzt67S
         k7Fg8x6pmxv9Pjxttl3Gzf/7Ncu8Da5WyCtC/Df4QxSz1zZIwlcP4rBh5XMd0JcLddTF
         8v4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720904913; x=1721509713;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pKBFxlpxtqw+lcKlQZcVepA2RqMBX87eNLI9J5v2lpI=;
        b=rYhJB2KoFOEzlOOxV5vNN1MtvUX+2ZTHm5DmVYFkHSKHOOyiF3A9LEeCRnJ/2XcXZE
         ArYxbuN05MYs4tUv0Sbls17zk5Qgch2USfo4TU2lGKuGHDp995peCmTCeXFkS0td1Wm0
         OWU1pMAnsyInMpDWFTxps2wx1NlR7HoF3ETlhMfOk84bK3IG/P3QjwMoppDhU6u9yahl
         VL+lmSgSjQu5WowKupqN1k+v0pAYfbTnauA3OnQ6Ii+V2wVlcYeJLq7wGtDqmsLZuzu5
         P73ZQdWpQaYJ02b6JjyEDXQFewD6k6yuCmvTTwxdFRlFWmFkCKEl+bhvxrR2GnG41NE0
         YJVw==
X-Gm-Message-State: AOJu0YySgAq+gPJHMPLseToPzcrFvsH9oZJX7npYNV26gtG3n9l7A5AL
	OWt6vjzbnF/yHM3K+jURS75kE5+a0ULmUxzPG9QhDb8kNE3KCNyBpUsJgg==
X-Google-Smtp-Source: AGHT+IFRh5sUyqNU1jChSAjBa+Us6ZGO3A9Qf6V1OU1NJL2/Q41Wq9sZCfvZ2Zc+GwIKFvagFVkktw==
X-Received: by 2002:adf:cd89:0:b0:367:865d:30b6 with SMTP id ffacd0b85a97d-367ff6edda7mr3982896f8f.8.1720904913231;
        Sat, 13 Jul 2024 14:08:33 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4279f09d1d8sm66703395e9.0.2024.07.13.14.08.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 13 Jul 2024 14:08:32 -0700 (PDT)
Message-Id: <7c53a4f4707ec1fcc0e0bf6ca049e632922b0bb3.1720904905.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1760.v3.git.1720904905.gitgitgadget@gmail.com>
References: <pull.1760.v2.git.1720739496.gitgitgadget@gmail.com>
	<pull.1760.v3.git.1720904905.gitgitgadget@gmail.com>
From: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sat, 13 Jul 2024 21:08:23 +0000
Subject: [PATCH v3 6/7] run-command: declare the `git_shell_path()` function
 globally
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
Cc: "brian m. carlson" <sandals@crustytoothpaste.net>,
    Phillip Wood <phillip.wood123@gmail.com>,
    Johannes Schindelin <johannes.schindelin@gmx.de>,
    Johannes Schindelin <johannes.schindelin@gmx.de>

From: Johannes Schindelin <johannes.schindelin@gmx.de>

The intention is to use it in `git var GIT_SHELL_PATH`, therefore we
need this function to stop being file-local only.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 run-command.c | 2 +-
 run-command.h | 5 +++++
 2 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/run-command.c b/run-command.c
index 60a79db8f0e..45ba5449323 100644
--- a/run-command.c
+++ b/run-command.c
@@ -274,7 +274,7 @@ int sane_execvp(const char *file, char * const argv[])
 	return -1;
 }
 
-static char *git_shell_path(void)
+char *git_shell_path(void)
 {
 #ifndef GIT_WINDOWS_NATIVE
 	return xstrdup(SHELL_PATH);
diff --git a/run-command.h b/run-command.h
index 55f6631a2aa..03e7222d8b5 100644
--- a/run-command.h
+++ b/run-command.h
@@ -195,6 +195,11 @@ int is_executable(const char *name);
  */
 int exists_in_PATH(const char *command);
 
+/**
+ * Return the path that is used to execute Unix shell command-lines.
+ */
+char *git_shell_path(void);
+
 /**
  * Start a sub-process. Takes a pointer to a `struct child_process`
  * that specifies the details and returns pipe FDs (if requested).
-- 
gitgitgadget

