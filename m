Received: from mail-oi1-f179.google.com (mail-oi1-f179.google.com [209.85.167.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89EE736D4E0
	for <git@vger.kernel.org>; Wed, 17 Dec 2025 14:19:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765981148; cv=none; b=MEC7RG2W67zb9btCIZxDeSwavajqnNhZT3dq97UD6hb7B/i1RRbxJXYQollgdWtpc0B7k0Ly4iP12FNTycKGGeK2bhSdu68M+Dp8Bee5+hEN6UFejpqdEui72UeMrIRdNYgPLqolNOj8B1jLOVrX0gzrU+6k0cHDmby/9ai3QZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765981148; c=relaxed/simple;
	bh=2VfQit1KacBHCYA5GK+sLpvalM7bM/E/vJtRGbY8Rkw=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=Nf2IEIYBQaGWoiAQVgAGCjkvATV3bJAalASEt0xqQWVWppx+IFDlE0dnPL07PEUXNQNgKx2C5fRF7iXA2Zcjle1yT3hVlp0YPZXHVV3W4iHFRxzsZ9Jvzz5LJ0sHONUJ+H7kpntwD3HPH0NDHasuXsbdK6LM5SkHrRL3dyPQgdE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=h1zQ3aC0; arc=none smtp.client-ip=209.85.167.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h1zQ3aC0"
Received: by mail-oi1-f179.google.com with SMTP id 5614622812f47-45085a4ab72so3378924b6e.1
        for <git@vger.kernel.org>; Wed, 17 Dec 2025 06:19:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765981141; x=1766585941; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dp3icUk0BgVzAoV0eS8ExmZLwZUm1qYrjh29LN/N6Kw=;
        b=h1zQ3aC0YTWfdonJcWO6uC9SxvfyOPG9AwTrj4FtOOjZVhXbBT5YzrfRBfC7LDxmjo
         dXYjsFKfuUOfULrcpJEl/Hwc1UDpJLAjQ2f9Yy42m9rubx6zwjAkafoN7dV4D8qJuNYx
         +FV2JoUL0YZt7SaAPb6ggJEJ4QzQ3EYhxVmajrA7ltGrOwNAe5jkui63wmxGi8bSUKLU
         i2uUegCDtvRN/6/ip7eK+oPj4lqaitblUhz9iFZXTLoLwCwldWciPp1pR9BRycexdXr7
         P7pKHhvOqK6a5iFH3ycYktwiK/nil/nUpHnkWNDaPSC5WqdVC4qgacZpzO15SrOw1j+3
         b8EQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765981141; x=1766585941;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=dp3icUk0BgVzAoV0eS8ExmZLwZUm1qYrjh29LN/N6Kw=;
        b=Hn56CYZRQ7VGneKS95nbihTos+QxQ+YD04nAa5wpc9D27Bo8RjBw2TH9QBakVDQ3xe
         zyJtSNmAPGzoGK0rzWCrLUeml6TgZcr1b80WnRpkAfF5TMdnmV8m6iFqBPLOzPVgraiU
         O+5H63IRN/yxwDMQPW+XDR9RQHIbOWmX2jgtSHH6uEyhfpkPWWLBJztGrhQew36QkNA6
         4+7vxqpqXUyUmDebdinabmB6DP8Hg9aPJQNz/igI5yxiQrrPbTThPKVLt4KeuwReSw+6
         cSySLl0OXVFqddIsWUm7CLLnkCIS7kF+PajIdPXO4+LsoupEnDT4Tt6yJAvX9y6mkgTz
         KVoA==
X-Gm-Message-State: AOJu0YxXvwW05/tjd62jVtjYEPGF3xLigKe208EQokUpZSFb4OYRmbIz
	8+3Rx3CP12Ir3LjnkUhi4EyOBpr4bElX/f1mHts2h3gUjWRHE+kxj9L7c3ceic4FaMGVjg==
X-Gm-Gg: AY/fxX6t380k8DSBnScmoym8FphkfhaRjSbkJacoGPfcNUKjsUxLzSME1PbOy9/SWKY
	6Bryp4Udto45xN7StU6hDVBTrq1Cs984Fkq21dRyfWIdH8XQIjEhGMFB4H8tlxhKujvvUkNktKi
	PlCrrzwBGJZvHBYMYo9L7xLkYjIxFBTAVfhv2nKRwspGMSFc4ulHOTX0IApmsYrzvJdk5+Z+CX+
	/8EHo3eA2MYqC6BYOGQ8Em8msi6+I/nylGhysyDpVaX8jB17GMJbKcQvqvQwiKIzvRCuXLmOtiM
	EX8e1X1Xs8YBOa78nCIGo+YVroJGdrn4o2kh+4gI07P8FW8pFkg8bPmQP0FfZ/8GaWVNV5fGwDR
	P0gAHblSXR4xALX/rOsTNDWp3FC2yQcBiToGcGbVWAbeTEiDq0I/gMurtQ0YnuOeG43fiNZR3yE
	4VVdXukU++QCWT
X-Google-Smtp-Source: AGHT+IFZQhSXa1b5kAiqk2AJhNriLr8qCH4ieG9SVfDNJNZir1sQzsPvylHM0nIctliolfcaS2zswg==
X-Received: by 2002:a05:6808:10c8:b0:451:4da2:47d1 with SMTP id 5614622812f47-455ac961552mr8600023b6e.45.1765981141185;
        Wed, 17 Dec 2025 06:19:01 -0800 (PST)
Received: from [127.0.0.1] ([135.119.38.57])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-455bb6b895asm6532302b6e.16.2025.12.17.06.18.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Dec 2025 06:19:00 -0800 (PST)
Message-Id: <6caf8bf0b193f325ac4a3787b5619b8338154298.1765981126.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2009.v4.git.1765981126.gitgitgadget@gmail.com>
References: <pull.2009.v3.git.1765885577.gitgitgadget@gmail.com>
	<pull.2009.v4.git.1765981126.gitgitgadget@gmail.com>
From: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 17 Dec 2025 14:18:46 +0000
Subject: [PATCH v4 10/10] t7800: work around the MSYS path conversion on
 Windows
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
Cc: Eric Sunshine <sunshine@sunshineco.com>,
    Patrick Steinhardt <ps@pks.im>,
    Johannes Schindelin <johannes.schindelin@gmx.de>,
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
assumes that all absolute paths start with a forward slash. That
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
