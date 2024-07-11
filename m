Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 688E61A0B13
	for <git@vger.kernel.org>; Thu, 11 Jul 2024 23:11:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720739507; cv=none; b=d7U5MIGoKvoDDNXIGVfT+m8eBOIkonHiauuaVbvamSU3fRSrcrxtfXxMzJzvgrGuWpLLk4a3AspiqHe+xGvX9tlRm68NMQPIwFLJfmRyVhpT4mypOBwy3yJlSFVlybl4ajQnFy2NClgEAObl4CfSlrh5Tr3faD4y6ejAvDhtmiw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720739507; c=relaxed/simple;
	bh=Zn6Q79lF4XV6seukFGYGo0mSUEYlc/kiG1ZjPcbLdcs=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=ub+JG0/i6tY5MAMRp1MhWGiGyaBeKD2f1fQQAKsm4WKhSSsyNXEbeWQV/dEOLUQVTELGsMrYnMAMkaLLUg6e59MTOKGO8QtwZwLhdGIexeJuwVZw5WpMBiSn+FdWBS7rd6BRz35/UDTo0eXDLbccbftNvwkXJsd86kl3seFRvNw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=S9oyJSqE; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S9oyJSqE"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4266fd39527so10407535e9.1
        for <git@vger.kernel.org>; Thu, 11 Jul 2024 16:11:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720739503; x=1721344303; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pKJhnuUlrb2EY3P+9i3X5QJfDX5c5R6ixjlHNz1mdSA=;
        b=S9oyJSqEUJ+S7vOXmrf1PqVx70wNhxNSs6btnFLG738tDytoZK1hNOeJzhuP7O4Dj1
         B+5A7rMz4tvscGsHw9UCioiWXumd6IrtKvk0eEXFnIO0CZ8FbPPD4qGz9gdYyAb1Tk1I
         1jyGlRG4QySNqSMkoXyE4RCKNxnGHc5ICA3l1Aymb9qc0zGLVS0pnnYXPf4AekspDlgP
         MCPuwpFuf3QmLYShzrWlwhmLTtTN6HZjTEIWWedMfBS8kM0UIjHmwBE5BA1ZwaqL0Nc6
         xQCErZeeQynIdlKUHIAh6RWiGc+v09vtuRnrJWkwe6DbZgHzBaVT7Blp6AR31MMsm2rt
         fUhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720739503; x=1721344303;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pKJhnuUlrb2EY3P+9i3X5QJfDX5c5R6ixjlHNz1mdSA=;
        b=uOE1nINRDw4334C8gRU8wVwe7t2l6kzqI6NI7p5IYF3aiS1aRi/3pVI3SMtS1jwmsP
         FOkkGn5aRjXVAxhXLCtzxNB/eiRRVJlP0eUGDgHPbtbJEcOh+Vd3P/yiKwI3CecHmOje
         f1Uet19pBG/gEOGpDtEJdDpezSQiaTczJniV3FYZQb1m74+IRK0t6wYizfZrQbR0rGty
         AZ100kSLddfmXwOVSc/011w1uEYhK/RgaIdqLlMPZ8lfHAoU86ZWbsIF7TZCtW0AFAeP
         w8c1lM0DwyPJDiOgLij9xpEoSmlM+WelOlUWu9tcIpEWdSROPb+8AmslRDqpOgLi9IGG
         Tbzw==
X-Gm-Message-State: AOJu0YzaowNcsBI8sw/USubMijzzxBY4Xn6+Ic+WFJncN9tTxdz57Uda
	6aWNgjhmW3dAAq8sJ/YD9h63mpgN5VE6IvAd343t8cZC6iT0P47ANO8aHw==
X-Google-Smtp-Source: AGHT+IGGazqBoPgq+d6UE+X5v0tcguU8e1Lwgr4Vk5T1nmHqghm38Bj5DXiwFCwry/3zuBVxmMgJuw==
X-Received: by 2002:a7b:cbd5:0:b0:426:5585:931f with SMTP id 5b1f17b1804b1-426707cac04mr69027925e9.10.1720739503322;
        Thu, 11 Jul 2024 16:11:43 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-367cdfa0689sm8804385f8f.85.2024.07.11.16.11.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jul 2024 16:11:42 -0700 (PDT)
Message-Id: <707daf246bd74f05428fc95c5b84b4836b06c648.1720739496.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1760.v2.git.1720739496.gitgitgadget@gmail.com>
References: <pull.1760.git.1720443778074.gitgitgadget@gmail.com>
	<pull.1760.v2.git.1720739496.gitgitgadget@gmail.com>
From: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 11 Jul 2024 23:11:34 +0000
Subject: [PATCH v2 5/7] run-command(win32): resolve the path to the Unix shell
 early
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

In 776297548e (Do not use SHELL_PATH from build system in
prepare_shell_cmd on Windows, 2012-04-17), the hard-coded path to the
Unix shell was replaced by passing `sh` instead when executing Unix
shell scripts in Git.

This was done because the hard-coded path to the Unix shell is incorrect
on Windows because it not only is a Unix-style absolute path instead of
a Windows one, but Git uses the runtime prefix feature on Windows, i.e.
the correct path cannot be hard-coded.

Naturally, the `sh` argument will be resolved to the full path of said
executable eventually.

To help fixing the bug where `git var GIT_SHELL_PATH` currently does not
reflect that logic, but shows that incorrect hard-coded Unix-style
absolute path, let's resolve the full path to the `sh` executable early
in the `git_shell_path()` function so that we can use it in `git var`,
too, and be sure that the output is equivalent to what `run_command()`
does when it is asked to execute a command-line using a Unix shell.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 run-command.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/run-command.c b/run-command.c
index 59e433bf91c..60a79db8f0e 100644
--- a/run-command.c
+++ b/run-command.c
@@ -274,12 +274,14 @@ int sane_execvp(const char *file, char * const argv[])
 	return -1;
 }
 
-static const char *git_shell_path(void)
+static char *git_shell_path(void)
 {
 #ifndef GIT_WINDOWS_NATIVE
-	return SHELL_PATH;
+	return xstrdup(SHELL_PATH);
 #else
-	return "sh";
+	char *p = locate_in_PATH("sh");
+	convert_slashes(p);
+	return p;
 #endif
 }
 
@@ -289,7 +291,7 @@ static const char **prepare_shell_cmd(struct strvec *out, const char **argv)
 		BUG("shell command is empty");
 
 	if (strcspn(argv[0], "|&;<>()$`\\\"' \t\n*?[#~=%") != strlen(argv[0])) {
-		strvec_push(out, git_shell_path());
+		strvec_push_nodup(out, git_shell_path());
 		strvec_push(out, "-c");
 
 		/*
-- 
gitgitgadget

