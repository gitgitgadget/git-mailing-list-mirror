Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FB613128C4
	for <git@vger.kernel.org>; Sat, 29 Nov 2025 18:28:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764440927; cv=none; b=JFhD6qY/yHDsMWnCHGUM/DDNjBrEKDDmZOPEyHrJCq30NzfiQWeHytc9if4Or88e3Wj/oG7ZgO2UZhGB7WOXhCqn9hM9q/QLUi+eM6E7RJh0Mbbcd788cLvh/kLRWB6e1XmWpIrYy3+fe+Q6gwFWSQjPZmOhkJ0o4J7m7UaRRpE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764440927; c=relaxed/simple;
	bh=hkwGW0SzcxKIK0L+P8mwqJs/mITxKd/0eUXkQCkTaQw=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=knrfQ7OpX7/XudnDik+rGd3cJHxAvnqQaPo5nGUfb1yN39Fbg8LPIgunahlJpSoJBIZVisj94sa5cAb3RB07+SExus6KaNUzh6n7AkvWrBB2n94FlZvyluxELSgkPQXCMJb0bhr5bQkVxKd/JvyoEBL+j1YEA5A5fTEmXkErp1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UCrK4U1z; arc=none smtp.client-ip=209.85.222.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UCrK4U1z"
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-8b220ddc189so303187985a.0
        for <git@vger.kernel.org>; Sat, 29 Nov 2025 10:28:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764440923; x=1765045723; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=54Vt0vmZSupI9w72nezfaIk/eRrol5y+XvPkVD275jo=;
        b=UCrK4U1zC67p+NJdOFoJ2swieqJogiLc9K65r5lw1aZUptLcE08zjdtMnT+H2voYhz
         h7J9heZE46oQPHxY4sPXBKnvIJnDzRbzT+p1d40NONts1fNODm8T3UxEjDzY5fZIReMF
         tKzNnU+d9kAe++WwH2Ek0dT/Yiko6ItwJ/1Hf+ya/1Z7JPNShC2iFtsqTUxS1LueFBB1
         S6bGdMMZfLdu+xJtU/VYj34/dsJovpxQgDymlfprEQ3P74DtWr5NOuKj8D4CxQWEScPs
         GyHmr/5PTTAqnalE6nrsUvLaxehva/6Pq7vWZ+mI/kUWgx8BhZKaEZlRoDC5cXMVMdY7
         zhAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764440923; x=1765045723;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=54Vt0vmZSupI9w72nezfaIk/eRrol5y+XvPkVD275jo=;
        b=MWdO3xWiEZqGWXOJIqr8yHO4diWmocOe+opEndNnoyoDH/FZBaTXXaRPEHHMRjMe3J
         JyAJv+igbfPqmFUn5lr7Rq7sDw9hVUy+Ka6PqGADg4n4JOqhqNM1bGuSYoojEpaHupo+
         UIL1QqJ2RUwtUdGAhr4vXTJ5yOaXscaqT3t2Dfq8ZA98BbumYgW2Ma+X+xT/GGhz9DA8
         pk52jmz4ExlDapy3Gat2T/JwUr04jfimHQFNQYeAEFnrgl3uqqrvd+qZH/UruT8EyoiA
         KQuZvt7n6YJuX9MB7ro38cbet7lkkGwlsKfTiHsneJ7oRWJkOe7cEJ93tRuy93rpIZeV
         sT1w==
X-Gm-Message-State: AOJu0Yz0J8jVpUg1eZVrYCb7RitIqng232n2w22u8EcFZkWdt0kMbR3B
	aVKmcuhl2wmDuNOHKQxcvK/uljFDOfuoBVRjCAx5e+AutWRzyjSoX6+QoJ8zyA==
X-Gm-Gg: ASbGncvMveCz4H0J/SkN5V8oZbGrxa9y6YXcNQPDSHLZQgLVjM15RAgB6Szr7elhLN7
	K/QHDKaIhFQg/lkgw/sfNuQ93U8zELA5ufyhBNKdEWcAIy2f3S06CojzeZbGallR2umk3VuKDsl
	lvkjnxj2QjYz+GX1KFEOkjBTNymxDHXtrbor5ucYAVksK44dty8qcB7aOvlQOIGkXYMyn8bww5R
	5HHgi6XXO9q6ibdRYD5/LFo71uTA7ks3R95OllkbaIIdeZv9tH+qDssjsIqjCu26bevHej0UF5N
	yKPsCm51xaS+U5FsGkW1D5gF1VzDKqQWtO8RIG8l/5YAyloK52CyNaCaW8qKv+aqiHZzNpBErxu
	jAEPrUOJmMnbLGLTmJR6fjY2VdMiAMYhZWpe9uTCt3NOS7i1opBiBTz4pzQYIBkNyILReYq9GLr
	mm4Eh/xRRlCTtQ
X-Google-Smtp-Source: AGHT+IHCDtIBUQNn6guHGpewxbhj/8liVMOODRRa7NKp6KDOMpBzWko2Fho4Ou8SVClIJwcw2pCJ9g==
X-Received: by 2002:a05:620a:4146:b0:8b2:edfc:bb9a with SMTP id af79cd13be357-8b33d49884amr4155624985a.59.1764440923318;
        Sat, 29 Nov 2025 10:28:43 -0800 (PST)
Received: from [127.0.0.1] ([20.97.198.243])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8b52a1b759esm539838985a.31.2025.11.29.10.28.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 29 Nov 2025 10:28:42 -0800 (PST)
Message-Id: <f7f1e91cef81068f3572b745aebc33d1d2a26c06.1764440906.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2009.git.1764440906.gitgitgadget@gmail.com>
References: <pull.2009.git.1764440906.gitgitgadget@gmail.com>
From: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sat, 29 Nov 2025 18:28:26 +0000
Subject: [PATCH 10/10] t7800: work around the MSYS path conversion on Windows
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

Git's test suite's relies on Unix shell scripting, which is
understandable, of course, given Git's firm roots (and indeed, ongoing
focus) on Linux.

This fact, combined with Unix shell scripting's natural
habitat -- which is, naturally... *drumroll*... Unix --
often has unintended side effects, where developers expect the test
suite to run in a Unix environment, which is an incorrect assumption.

One instance of this problem can be observed in the 'difftool --dir-diff
handles modified symlinks' test case in `t7800-difftool.sh`, which
assumes that that all absolute paths start with a forward slash. That
assumption is incorrect in general, e.g. on Windows, where absolute
paths have many shapes and forms, none of which starts with a forward
slash.

The only saving grace is that this test case is currently not run on
Windows because of the `SYMLINK` prerequisite. However, I am currently
working towards upstreaming symbolic link support from Git for Windows
to upstream Git, which will put a crack into that saving grace.

Let's change that test case so that it does not rely on absolute paths
(which are passed to the "external command" `ls` as parameters and are
therefore part of its output, and which the test case wants to filter
out before verifying that the output is as expected) starting with a
forward slash. Let's instead rely on the much more reliable fact that
`ls` will output the path in a line that ends in a colon, and simply
filter out those lines by matching said colon instead.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 t/t7800-difftool.sh | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/t/t7800-difftool.sh b/t/t7800-difftool.sh
index 9b74db5563..bf0f67378d 100755
--- a/t/t7800-difftool.sh
+++ b/t/t7800-difftool.sh
@@ -752,11 +752,11 @@ test_expect_success SYMLINKS 'difftool --dir-diff handles modified symlinks' '
 		c
 	EOF
 	git difftool --symlinks --dir-diff --extcmd ls >output &&
-	grep -v ^/ output >actual &&
+	grep -v ":\$" output >actual &&
 	test_cmp expect actual &&
 
 	git difftool --no-symlinks --dir-diff --extcmd ls >output &&
-	grep -v ^/ output >actual &&
+	grep -v ":\$" output >actual &&
 	test_cmp expect actual &&
 
 	# The left side contains symlink "c" that points to "b"
@@ -786,11 +786,11 @@ test_expect_success SYMLINKS 'difftool --dir-diff handles modified symlinks' '
 
 	EOF
 	git difftool --symlinks --dir-diff --extcmd ls >output &&
-	grep -v ^/ output >actual &&
+	grep -v ":\$" output >actual &&
 	test_cmp expect actual &&
 
 	git difftool --no-symlinks --dir-diff --extcmd ls >output &&
-	grep -v ^/ output >actual &&
+	grep -v ":\$" output >actual &&
 	test_cmp expect actual
 '
 
-- 
gitgitgadget
