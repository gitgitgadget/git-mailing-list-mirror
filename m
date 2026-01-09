Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E7A736997D
	for <git@vger.kernel.org>; Fri,  9 Jan 2026 20:05:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767989136; cv=none; b=UvPR/llr8/JnZG9t0rDgOpJzcdB2FbCTrSjFMBz5tAjvdIU5T3aX8aV6UwebS5UcI14Uz4Y1i27HWx3tbp9qWLIBWUpVlRKUe06QwvVF3C5nCwM0D+9q8UfiQAQlFpLgOEEXAhZIJ6tzdigkKpJT4uNxtMRz0EFIWMQFzK1Oh6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767989136; c=relaxed/simple;
	bh=rkBoUiIb+FetbnQYhx2HHbSKzoMomCGZY8VNNPsq+RY=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=UjLY/NeErHlG5RVNR3bUT0Ill0D/gT6Ru4SheeV5CC5+cXD4nuSLqLzKmcbeH+p27EodOITdmhC27gq2gsDioGzmTO3xnU5zb7d+hB7BFXnQcNsAY2FL0d4ce4n0qtko6YQbAnwZW2sA+zDZ4qsaFXlddiqVrf+olH1MjjjnQc4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SvKqLImb; arc=none smtp.client-ip=209.85.222.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SvKqLImb"
Received: by mail-qk1-f171.google.com with SMTP id af79cd13be357-8b21fc25ae1so502162385a.1
        for <git@vger.kernel.org>; Fri, 09 Jan 2026 12:05:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767989133; x=1768593933; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8lO+zryE/AtAEhqe3OiJcTOV+C4DY78rgrd5WRFmWiE=;
        b=SvKqLImbVBsFJqqfHbtcluBBTI2ZJp+J44NhlsxATF+MeVTCNfsJD2YdMsQ4cFPcrn
         NVc/6miyM4qRM7ijBaZ/i9vXnYqe3chXitWr4ZCHp55AZmoUO/Dr2sQCLDOrc01OQOKk
         VoJXLbJZiYQ4gpRxDpTK44gN6PDKpoGU8tc00uSK3dHZj962K4LWRM4FjsKINM9JzOiv
         laHRmICLbM5rB1U29q0Vc3jH4URM/v7s5QPkzjif1kssWhmjZqyiaVgKjHXKg1ibNPI+
         qEkcqK+IADcAOUE+ZmN4PTEFGQBiPaTyqi9ajpZHlHX4EZPVprK+ub5K+/D4p3LwH9ih
         pKZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767989133; x=1768593933;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=8lO+zryE/AtAEhqe3OiJcTOV+C4DY78rgrd5WRFmWiE=;
        b=kqdm9b951avOo9S8PIoxe3+i5LBDyfcngDEPRpXthQtUWdGXR2jRaJT/nxJIgg+h5z
         HYDGxBgx3bS/g+l+EazPCh7t8rD0hGdRcEMKC4f+ODyHbh51035z7A34/MWHhX8gvHOO
         MhaEwLC7rgM5svUe841Al5riRJE5YAEdiQaasDx9n9NRhFZtgVpGG2nEJ1oF40pr0JDf
         kdIyGSfTXRmuPsBP+fJxglP+pTVxZeTQN+bOcQo/MZoUcPmvdMJPh72k6kvRETVHeedx
         Hf+Q4niN0U9FjbpLK8q8cgfXIMFivkH6Ec3ZgAr9OAAhlEvAluYQndXrV/s/4UC6w1Iu
         G0UQ==
X-Gm-Message-State: AOJu0Yw18KWEChsy3BFjS/T9VM2qavDQvukLgdZxPC/U17s3863+WUWN
	l92/wsaJNlhVLhzX2pD0aL/XlEVAa1s6uzz5jeclbGlqGcQa84/sBqK9uW62z05H
X-Gm-Gg: AY/fxX7ZxntelKKgDzc8FKWMMhsWk+4Wxi+C6wXQWTcBXX8Rnml7J2QFCt9Mlhyzg2s
	9AF0qXpK+sy52x9LErwser9YeRqNFWmcQAAMh3dbZkfyOmF2pr05oCLCvCwRzN9zoe8eZ8Y1BRF
	lycoHcb70Gjd9tF0wyrxEp6J8aIwjBtTnmbq6gAzGIxj5V1b/0GslM2FJC7F7IxOukzjGCtAbgx
	jCsb+hXOQ+gWtJP6u+RmpdFVyO0C2VuwIdygXkwYIhwFf9j58eiS0U/pu8ErJ/SSAdMTbNj3+AB
	wbIYFbMF+tb9CLEwmHHeFhv0TYXbjxK+Yw0a1jNtdcvURGPJCwxwGiz9GDebQib0m5f5HlQ423i
	1gpoLfVCycJm1qSMoq03GvOUdB675YdCUz0xyntk5mhGenHLN8RUj//lnvuVzr+YI/T2ae5Tz6r
	zMu9ezNmPhf+pf
X-Google-Smtp-Source: AGHT+IENhRMI0IMdyr8c9jeWAABg2EG4dUGLalggNcR+aDQ00WBuc6C/6BaZ8p3D60OvcJ8/F/HMJQ==
X-Received: by 2002:a05:620a:444e:b0:8b2:ea5a:4149 with SMTP id af79cd13be357-8c3893f7cc8mr1450869685a.65.1767989132726;
        Fri, 09 Jan 2026 12:05:32 -0800 (PST)
Received: from [127.0.0.1] ([20.161.67.219])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8c37f530c35sm892094685a.40.2026.01.09.12.05.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Jan 2026 12:05:32 -0800 (PST)
Message-Id: <1ae9c63a89e6b35d1658042685fdec0a572b375a.1767989115.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2018.v2.git.1767989115.gitgitgadget@gmail.com>
References: <pull.2018.git.1765980535.gitgitgadget@gmail.com>
	<pull.2018.v2.git.1767989115.gitgitgadget@gmail.com>
From: "Karsten Blees via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 09 Jan 2026 20:05:10 +0000
Subject: [PATCH v2 13/18] mingw: implement `readlink()`
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

Implement `readlink()` by reading NTFS reparse points via the
`read_reparse_point()` function that was introduced earlier to determine
the length of symlink targets. Works for symlinks and directory
junctions.

Signed-off-by: Karsten Blees <karsten.blees@gmail.com>
Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 compat/mingw-posix.h |  3 +--
 compat/mingw.c       | 24 ++++++++++++++++++++++++
 2 files changed, 25 insertions(+), 2 deletions(-)

diff --git a/compat/mingw-posix.h b/compat/mingw-posix.h
index 0939feff27..896aa976b1 100644
--- a/compat/mingw-posix.h
+++ b/compat/mingw-posix.h
@@ -121,8 +121,6 @@ struct utsname {
  * trivial stubs
  */
 
-static inline int readlink(const char *path UNUSED, char *buf UNUSED, size_t bufsiz UNUSED)
-{ errno = ENOSYS; return -1; }
 static inline int symlink(const char *oldpath UNUSED, const char *newpath UNUSED)
 { errno = ENOSYS; return -1; }
 static inline int fchmod(int fildes UNUSED, mode_t mode UNUSED)
@@ -197,6 +195,7 @@ int setitimer(int type, struct itimerval *in, struct itimerval *out);
 int sigaction(int sig, struct sigaction *in, struct sigaction *out);
 int link(const char *oldpath, const char *newpath);
 int uname(struct utsname *buf);
+int readlink(const char *path, char *buf, size_t bufsiz);
 
 /*
  * replacements of existing functions
diff --git a/compat/mingw.c b/compat/mingw.c
index 5d2a8c247c..b407a2ac07 100644
--- a/compat/mingw.c
+++ b/compat/mingw.c
@@ -2698,6 +2698,30 @@ int link(const char *oldpath, const char *newpath)
 	return 0;
 }
 
+int readlink(const char *path, char *buf, size_t bufsiz)
+{
+	WCHAR wpath[MAX_PATH];
+	char tmpbuf[MAX_PATH];
+	int len;
+	DWORD tag;
+
+	if (xutftowcs_path(wpath, path) < 0)
+		return -1;
+
+	if (read_reparse_point(wpath, TRUE, tmpbuf, &len, &tag) < 0)
+		return -1;
+
+	/*
+	 * Adapt to strange readlink() API: Copy up to bufsiz *bytes*, potentially
+	 * cutting off a UTF-8 sequence. Insufficient bufsize is *not* a failure
+	 * condition. There is no conversion function that produces invalid UTF-8,
+	 * so convert to a (hopefully large enough) temporary buffer, then memcpy
+	 * the requested number of bytes (including '\0' for robustness).
+	 */
+	memcpy(buf, tmpbuf, min(bufsiz, len + 1));
+	return min(bufsiz, len);
+}
+
 pid_t waitpid(pid_t pid, int *status, int options)
 {
 	HANDLE h = OpenProcess(SYNCHRONIZE | PROCESS_QUERY_INFORMATION,
-- 
gitgitgadget

