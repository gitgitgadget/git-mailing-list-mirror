Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4823F3DB635
	for <git@vger.kernel.org>; Wed,  9 Sep 2026 19:17:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788981456; cv=none; b=IB5iViCBY9GT+lPtRzldPp3JYgKSXx5CHlVCTJlJ2q8WLHrFUH5xX6mwT7lfHPPQwj9zTHv05lq+dQLmRATcrUBVF/2VYbj1SZaSBQaFwMeyiMJFChmFGuuIfcWl/I4pcTV/9iI5ZkgJdu6HaG9uI+j3Z/3eep+x09eR7TuzFEM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788981456; c=relaxed/simple;
	bh=Wb0z0ScONlBnC2myqKjPXPkp8TZ2zjW/gBlQDKwyE+E=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=ZCxoMlvCVvpJTMgZaRbsDRPL3zRpGjMctF7jdNRfGRztaSqpvCUHKWKAiqp57lzAdBeBcXmUQz8OyojBqpK3nehcc2KoYEHTonJ808Gj8fjQjoCySFJKp5q/eg/vGd7Eew4UjP57WmzekfiPz/S9BS+brQWROsz3vIZByBUczFA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hPD6sZ1o; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hPD6sZ1o"
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-398c1101c1bso6010079a91.1
        for <git@vger.kernel.org>; Wed, 09 Sep 2026 12:17:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788981453; x=1789586253; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=wp5NKYlxEj5uoYdkzvpvhMd8uALMSstbiZSfAcu3H5o=;
        b=hPD6sZ1o4HbSM7g5q2KxdFDAnV1Sdea7JroO2qAKl1TWelKE0xmoY3Hg8bT7hKHKev
         CF6sOe1L7xhhi+yfdI9EecARYTvdIL1Iv9vuvxCuy0FKMNtTVdWtmbfqJP/HfGF4Snu0
         2mot5T8h5ErfNTZ/vnppFSSlzNMi04bnzxhcQcqnKc/WX+cV25cmeZy0j0rDZiD5z+EU
         j89CbeGco+D3ZEf3RsytFVcbF8ooXWG1KJDyhkEcUACPr6cFqHVXW4kiqF9OZvE9SZDP
         TyA87m1Sh8WOc7fz3k0ShrqJs7tk7b6Q7+T/aQIeEozIWBHyRe/F5br971s/NpoUH9CW
         6YKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788981453; x=1789586253;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=wp5NKYlxEj5uoYdkzvpvhMd8uALMSstbiZSfAcu3H5o=;
        b=IuXeVnJsvEx86ubYlQsg4kABImL4jECXVwilVtJJdFYZDqtvgettWoxvNkYwk1/BcQ
         WZLSEW0v7gcMzrbZaeOUb8w87HAjKo/gMZvdAv/mbuH0genysnKsN+VlTf+pEN3FzhzT
         3l9fVxSJQjfSzBkgIqLw3ZdCu7qH5I2lVDfVkdIPiZ66IDj4lPkgM7yM4q6LhbwO4jzE
         F2qVEXOW/kWWWm7c/60i8DbW2RAU6bpNvp2SUgqWd8ZTB+VbE3qbgvBXa3bI8a8dvJ+G
         P5MoPOoovaxS+ePYYRDF9iUjczRNQFVxjK0yvfcz+gJmeBpGYFAR1ZRt4V+hNQtIege8
         18Xw==
X-Gm-Message-State: AFuF++kobUZ6jVh6NgDl4ppd1OWOT8e6wkJxMTU493lHcyfuF3ahj0tY
	oUooRGYC9iONpWjbo2e8Cx0GdeSVVO1VN/IvMMvppUYshdl/iG7m85+BeghhWg==
X-Gm-Gg: AYBFou3q2Rc0loJYJuxjP9jiYXogDslvhyEDXQpW+f5Kof5+C3JNoUWcmFBnD9HY3DI
	rVoftsRVM58bRCz8UtvwqFG0dCBq174TTla2aawGLBwZcahAnCCSE7CEYyX4WFluWZ08w64jL8O
	+jzwNSziNONqdgGhwkX/1GNXFdz1ahCSv0CeZtzaSpXWnsfm+mpkPzEqjZxfbmf68PzSudJrToo
	Xr+P9mBr4o7pUzrbBPJnILw80xWnL0WM5+mz4tb4NJ473DEZOpg0E1fDMREkH3jPGFgZXo9ew9v
	drS4ClW8L4VbhKlvnNcFcHvyuqMqMaS9xCu1hpOX/FLBYQ/db0SwGdZ4g4k9kWimgahRt50EYXw
	ZhKSgE+DCyp5/LRjzPn6G7tVMqMtMeT5rydN4lEfoT1/e0qmL9eKZWUfHsfxzGlIlu29Cp9gHqC
	KUpUKWvHN8QTLyagZka3brIZyAQ46p4eMvnv7wGWCFHbrTAEQNPkQrH7mfSWV7qQOT21SLUAAJ
X-Received: by 2002:a17:90b:580e:b0:385:393e:7124 with SMTP id 98e67ed59e1d1-39b261cfd97mr51810554a91.14.1788981453148;
        Wed, 09 Sep 2026 12:17:33 -0700 (PDT)
Received: from [127.0.0.1] ([13.83.161.18])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-338f7bad290sm15620993eec.14.2026.09.09.12.17.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Sep 2026 12:17:32 -0700 (PDT)
Message-Id: <19c600cbeead056c8725e7fa34e6f8aeb46df54a.1788981436.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2195.v3.git.1788981436.gitgitgadget@gmail.com>
References: <pull.2195.git.1785939999.gitgitgadget@gmail.com>
	<pull.2195.v3.git.1788981436.gitgitgadget@gmail.com>
From: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 09 Sep 2026 19:17:13 +0000
Subject: [PATCH v3 09/12] windows: skip linking `git-<command>` for built-ins
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
Cc: Johannes Sixt <j6t@kdbg.org>,
    Johannes Schindelin <johannes.schindelin@gmx.de>,
    Johannes Schindelin <johannes.schindelin@gmx.de>

From: Johannes Schindelin <johannes.schindelin@gmx.de>

It is merely a historical wart that, say, `git-commit` exists in the
`libexec/git-core/` directory, a tribute to the original idea to let Git
be essentially a bunch of Unix shell scripts revolving around very few
"plumbing" (AKA low-level) commands.

Git has evolved a lot from there. These days, most of Git's
functionality is contained within the `git` executable, in the form of
"built-in" commands.

To accommodate for scripts that use the "dashed" form of Git commands,
even today, Git provides hard-links that make the `git` executable
available as, say, `git-commit`, just in case that an old script has not
been updated to invoke `git commit`.

Those hard-links do not come cheap: they take about half a minute for
every build of Git on Windows, they are mistaken for taking up huge
amounts of space by some Windows Explorer versions that do not
understand hard-links, and therefore many a "bug" report had to be
addressed.

The "dashed form" has been officially deprecated in Git version 1.5.4,
which was released on February 2nd, 2008, i.e. a very long time ago.
This deprecation was never finalized by skipping these hard-links, but
we can start the process now, in Git for Windows.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 config.mak.uname | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/config.mak.uname b/config.mak.uname
index 3a90995587..88bbe1d78f 100644
--- a/config.mak.uname
+++ b/config.mak.uname
@@ -518,6 +518,7 @@ ifeq ($(uname_S),Windows)
 	NO_POSIX_GOODIES = UnfortunatelyYes
 	NATIVE_CRLF = YesPlease
 	DEFAULT_HELP_FORMAT = html
+	SKIP_DASHED_BUILT_INS = YabbaDabbaDoo
 ifeq (/mingw64,$(subst 32,64,$(subst clangarm,mingw,$(prefix))))
 	# Move system config into top-level /etc/
 	ETC_GITCONFIG = ../etc/gitconfig
@@ -710,6 +711,7 @@ ifeq ($(uname_S),MINGW)
 	FSMONITOR_DAEMON_BACKEND = win32
 	FSMONITOR_OS_SETTINGS = win32
 
+	SKIP_DASHED_BUILT_INS = YabbaDabbaDoo
 	RUNTIME_PREFIX = YesPlease
 	HAVE_WPGMPTR = YesWeDo
 	NO_ST_BLOCKS_IN_STRUCT_STAT = YesPlease
-- 
gitgitgadget

