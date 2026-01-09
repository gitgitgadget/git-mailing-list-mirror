Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C815936826F
	for <git@vger.kernel.org>; Fri,  9 Jan 2026 20:05:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767989134; cv=none; b=g5TRa0T+mWQfajfjag7t8yVketF+BFlyvZz9VawYxLhYrKp+kSnr4gfYyj1Ecst440TtwP2Rqvb7Brae4cGiJ29sTn3fIlB7SA/XoK9WAnvIpFiU2s9iItBcK6jvTAIeFb291hYmsaYNwqM2sufO+hNUCODZMdy/KYaQYLJSsK8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767989134; c=relaxed/simple;
	bh=EflxFzjegqrsKb+xQuL+ilGTUmqzZu27pdRu4PYZhGs=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=JLERzWyMyAN9tvzmlCOB5Dluyt1q/sNUqxdYoJyfn/hWMmRtiYpU/yuV4kjA75JZUeUUrI7eyttAM5OfAT10FzD1x0ZLlyTZ8nYzxFvxpJNkHmlRKL4upJaVNjmzOxRczQXGpUUBV9SJnUq2IywDiPgw/t6Y4xsYkyZ8wyP9qJQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Y/Gvejc/; arc=none smtp.client-ip=209.85.222.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y/Gvejc/"
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-8ba3ffd54dbso679596985a.1
        for <git@vger.kernel.org>; Fri, 09 Jan 2026 12:05:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767989129; x=1768593929; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Vay3TxmdG7ouaIawsLZ/S63F1Xn0XclB1ik4VXrZnls=;
        b=Y/Gvejc/2570I8/gnXxJBNasD5SzyEWfGPn7cHbO8XpWB7psSJIRhnldq4w8OHErtX
         7Uma8t+al4U2VpDN0CUrx6MpyQtjqS1RhHIDOCuaA9cejCgNgg+FCtBIpV6yOKlUcMSD
         xdI2ihNlISsvFgDDiNjkhSCt8DR/EFHk3HJ9zdpv+qWcA3aTSZBLARJJ8EQDoUc4A07/
         03WcLDTrPJZrJwy8Z5xVKBIHj3g0aaZ7jFlSWA1yZaDb7HlM43kaQ7Qsu8P/rMxoOfCi
         fb0QudgfNhAClYyGR+0Gi/vHlShtlfVBPucFFqW19aQs86f1Qc+n8d91yk/BpoFuKbmA
         nENg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767989129; x=1768593929;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Vay3TxmdG7ouaIawsLZ/S63F1Xn0XclB1ik4VXrZnls=;
        b=Hdx9TWiNlSKZSReng/DL3AxVNW8E34JYA6jNdN9RgDIGlTXNU1Mt+0oUfDcvzmWvlA
         FIk56uwLoBP+dCOrZz/bDIxRpREBioySMRx9j0NlM58NwzFiNImVte1qfg91VDe+2AYb
         kLK0lJYL/Xj/vZxRJSytXB7o0ecjEcc6btymf9sCiVPzSlqzjTHaAM0Tbb12RERLnMxZ
         BpAEzO8h0UPapUuqxbDmOsB4ZuPHYK1mnT67kYejNqCEdjImdFHSD67KZSrp3p0yW0H9
         xVPujJ3ZJVQMVwNJQcxZUw3GXUdvFbcGKdWRBzZn11K2FsRNlkl54txyBJrG91GQgvtk
         cuEA==
X-Gm-Message-State: AOJu0YwN9qARM7G8cAM7C2RfaFHNA10PdA/CRecGDFaSgavAdYNEXFGP
	poMplRaUHurQrwROO9seCrsHPNe26WzoHPvfBqI7GJRH/cAtq0WOE32xkmAutZJJ
X-Gm-Gg: AY/fxX4XQxIHa05Ar/XPXjaCCiNBbnaHqsVbAlrg/iMmgRV/zPIRUdEeaHpq0mLOGpZ
	o8FKpVXWeRQj4kFq1XYhzzLJtzjGC6BC0CNj92hL1BsUznQAwZTl0kg0LzJf0JavK8K6Lv3HH+q
	qnl6/JYz82YHnRS73v8Q2+hj77HOAqodUOW0PtSpEIxOZng7Ry80/extLKE2VcTDcjLLaIpn/Lg
	yzonqbXF6TKpdXhwslyH/8L87+deqvvXDnuZ2+yn2GndftmytwDZ5nXwpw7yyr2WNM4iE3Of4wI
	DeVT0vmudLcDZdF82WICY4us5+ZK2yMtAY6mtmusofUBG3oLJ3AcXKco2lO8OmYXNguAmxr0Dai
	+zGp75SU7rc7J6vEhBdtAavSoUpAXUQ0DflIG0s9dUrTSb1xWNPNqlL513/ylk3bZyY8+eqy3FT
	eJBCNtPr4GBzGP
X-Google-Smtp-Source: AGHT+IEIaoCNTv+3GvuX7DGsVkJt70USQ7MJMAEm+ZdKBaDs56TTNi6AkAoT8rWQW5mL/2exR+itmA==
X-Received: by 2002:a05:620a:4620:b0:8b2:efe7:d82b with SMTP id af79cd13be357-8c389399f06mr1472396785a.30.1767989129343;
        Fri, 09 Jan 2026 12:05:29 -0800 (PST)
Received: from [127.0.0.1] ([20.161.67.219])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8c37f54427esm930909085a.48.2026.01.09.12.05.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Jan 2026 12:05:28 -0800 (PST)
Message-Id: <5dc90f9785d8f83f39d79788a3f1b9ed8fa539dc.1767989115.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2018.v2.git.1767989115.gitgitgadget@gmail.com>
References: <pull.2018.git.1765980535.gitgitgadget@gmail.com>
	<pull.2018.v2.git.1767989115.gitgitgadget@gmail.com>
From: "Karsten Blees via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 09 Jan 2026 20:05:07 +0000
Subject: [PATCH v2 10/18] mingw: handle symlinks to directories in
 `mingw_unlink()`
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
Cc: Ben Knoble <ben.knoble@gmail.com>,
    Johannes Sixt <j6t@kdbg.org>,
    Karsten Blees <karsten.blees@gmail.com>,
    Johannes Schindelin <johannes.schindelin@gmx.de>,
    Karsten Blees <karsten.blees@gmail.com>

From: Karsten Blees <karsten.blees@gmail.com>

The `_wunlink()` and `DeleteFileW()` functions refuse to delete symlinks
to directories on Windows; The error code would be `ERROR_ACCESS_DENIED`
in that case. Take that error code as an indicator that we need to try
`_wrmdir()` as well. In the best case, it will remove a symlink. In the
worst case, it will fail with the same error code again.

Signed-off-by: Karsten Blees <karsten.blees@gmail.com>
Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 compat/mingw.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/compat/mingw.c b/compat/mingw.c
index 0e8807196f..b1cc30d0f1 100644
--- a/compat/mingw.c
+++ b/compat/mingw.c
@@ -338,9 +338,16 @@ int mingw_unlink(const char *pathname, int handle_in_use_error)
 			return 0;
 		if (!is_file_in_use_error(GetLastError()))
 			break;
+		/*
+		 * _wunlink() / DeleteFileW() for directory symlinks fails with
+		 * ERROR_ACCESS_DENIED (EACCES), so try _wrmdir() as well. This is the
+		 * same error we get if a file is in use (already checked above).
+		 */
+		if (!_wrmdir(wpathname))
+			return 0;
+
 		if (!handle_in_use_error)
 			return -1;
-
 	} while (retry_ask_yes_no(&tries, "Unlink of file '%s' failed. "
 			"Should I try again?", pathname));
 	return -1;
-- 
gitgitgadget

