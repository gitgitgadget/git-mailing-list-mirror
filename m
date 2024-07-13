Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2219114C586
	for <git@vger.kernel.org>; Sat, 13 Jul 2024 21:08:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720904915; cv=none; b=TOTKsnenslgO158DkCvAg6sBkrcCedHkpQ+1epD78KD48rSHLXJqXJuJyQZDlyg/wcgetRHjbQbaJEt1ri0YPh9fvq6mpfwLHGHmpAgPEV3xBkE1R46PIOCqdAIZxA8CJVTOqe+tuqLZrXYl/R4IC9TlEhWhSpBL7FAQcCOY0Cg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720904915; c=relaxed/simple;
	bh=Zn6Q79lF4XV6seukFGYGo0mSUEYlc/kiG1ZjPcbLdcs=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=jhXP/WEwom8FlUi2oF8loOggZoITprLu3xoyM2TZ1i2ZQ6F9RenslRCZaViq+6PxC3N0dhwJ/sdTeAC4hGimMF3FTwcKx/p6mBuE6C24jbiZ0hwO1LxylDilE8fpt1mWEZty5QR+P/6qxErbG6lfEwiMIqn0cn3yWmG2WiftJeQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ltyONaPs; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ltyONaPs"
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-367818349a0so1760176f8f.1
        for <git@vger.kernel.org>; Sat, 13 Jul 2024 14:08:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720904912; x=1721509712; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pKJhnuUlrb2EY3P+9i3X5QJfDX5c5R6ixjlHNz1mdSA=;
        b=ltyONaPsq2QU0Y2HimRJD1u1hiVV2pC48tO8T3qCvTcA4SwfIUFwDvwQ+oeJYLpiOq
         Y42git/YRuNEdCTHu/0UDfWO8DLiSmjNRHlG/NLR/4MHaT9i59j6J6undoi75l9PKVLY
         Kb7AkeUxqoSCUhqKZDj/NqPFnxi79Lx5AjnxWKboaefVswCKDa0HVBJy0FNjusYZhPa8
         mj2wY7WaKguE4iMNAUE8C0gnuIITKS0etYa51wjqXoAhEw6dr7cg5eAKlhyWwGxWAgca
         Vxc2UEaZKv9qfl6NNbIbvXqyyCfK7F6McFVwDNdAXdGvg7t1QIaNZ0+ZUYcMTVRrsnwB
         MC9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720904912; x=1721509712;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pKJhnuUlrb2EY3P+9i3X5QJfDX5c5R6ixjlHNz1mdSA=;
        b=tw4FwOr41yQkzJ86etsAvvxgIQyxsQt0pZJArIgBZjTOpAmaSdbJOS3+3au/yK7nCh
         3hwG6ghaCVRAP7Yzh7yIL+yHfCAik2yYXv/POyP3Dkkc9auq5W6Q9LdFtc3rskd4UTqV
         8Kc6gW0rD0vYwnxmLG28p73pbs03Css33OLdRg/Bn0R8AhGbRaymoC9MlOOKc5jF2Woq
         UcGKQJdklIxD9AHnRCoN7TqTkpwCkoLh7sc5xC2tkUwlyM3T9Y1e67bA9tFaqgpCxq1n
         jgEanIzPandsjgVdxVRgyAUBLfMP5BDcoQPJOFeWkxywctOYvwGkNu2zU5uTLPTBI3C/
         PILQ==
X-Gm-Message-State: AOJu0YyvKPL3fBa1DoLcjVqFdPGMoha5ZxZ1OeQDRc/GixhaJFCWn7g/
	aupXXFsexnBKFfjKUd8ClQMP2jS/M7nEYFY92TMxeJyaTvC/juXIRgbNEA==
X-Google-Smtp-Source: AGHT+IH5Y71I1PDIPC7YQ856+WDHlOWvUzZUSTG5LY0ZaTAaJxpLDwViz2f4V7Ofr1pQ3MgOIzZ1KQ==
X-Received: by 2002:a05:6000:156a:b0:366:d5ea:6098 with SMTP id ffacd0b85a97d-367cea46b19mr12580137f8f.3.1720904912101;
        Sat, 13 Jul 2024 14:08:32 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3680db0f26esm2360691f8f.116.2024.07.13.14.08.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 13 Jul 2024 14:08:31 -0700 (PDT)
Message-Id: <797cf9094ea39e9bedb2e60ef86fe3ca089009ba.1720904905.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1760.v3.git.1720904905.gitgitgadget@gmail.com>
References: <pull.1760.v2.git.1720739496.gitgitgadget@gmail.com>
	<pull.1760.v3.git.1720904905.gitgitgadget@gmail.com>
From: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sat, 13 Jul 2024 21:08:22 +0000
Subject: [PATCH v3 5/7] run-command(win32): resolve the path to the Unix shell
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

