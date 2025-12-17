Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com [209.85.222.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30B2239B6D4
	for <git@vger.kernel.org>; Wed, 17 Dec 2025 14:09:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765980561; cv=none; b=VGiZtYSY2u4zOuVvNEQpVepiZlMCaYOTl4bBW/SzvcNvO4Ir0PttG6fiVUSXDPgJ+ILOacGH5Ew3wcDIZvF8sCkgOTNmhIhO8iR9t+yfuaqn8c0B8kD9wNcxK+MK5zBQYPV+9iovXO+FMbW0iJciv3C4PWmvtmlwszXLASIHx7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765980561; c=relaxed/simple;
	bh=9b46Mb73Y7Zax/2EZe/Iej8RoGP33qNmU+9tzgvST2Q=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=MqNVmTHtBxd7J1LTsBCb164E75D+ZYCReC/EtM4SYyp6eIU6V5Ed2U+EaKFHP/gaFcmAAby64D9jbegJF711uFw/wV4Axb2e+vs2XzdyHVlpLkCkTj/fjJvVfUbccCFl18bac/RHFqOEPmGtYb3Uf90EJhpiCrjyJEsrIBP9xLI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Nsc1CU+1; arc=none smtp.client-ip=209.85.222.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Nsc1CU+1"
Received: by mail-qk1-f181.google.com with SMTP id af79cd13be357-8ba3ffd54dbso812331785a.1
        for <git@vger.kernel.org>; Wed, 17 Dec 2025 06:09:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765980559; x=1766585359; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zV8OzHSFcIceZz+YHEpJtwlUrOcMv4E5jGSHlfDr+Jo=;
        b=Nsc1CU+1EKJeXsfARAOUNxdVLjC0Lk+pOzbxEs0wKylsqfsE9HXmmFcowl78J3ZtEO
         ZSHj6AMK+wdLzhqqy5wBNrvQbU1+TKFZhKLnX3Cb1KOTBJtr38Cl1IWuAtdNv6zoYNR/
         AfHuK/LdUjTZ53pJxL3cMKbsNfu01MY3YLLcp+e9LDiC4ruJKkVUh0ywZiQ/NkUeC0aE
         onetAh3+VgkIg7YQVTeqqhzVP4AKwQxQgLg6KyW0SiYm0tcQuU9iIaJTzxrr94fC9BA0
         URlEzKTfzcWKaRmTVfAt89alu3Blz2bMA9aO1GuwrZPIHAYdOtYegbqaBR3RMpI55dlG
         +iiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765980559; x=1766585359;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=zV8OzHSFcIceZz+YHEpJtwlUrOcMv4E5jGSHlfDr+Jo=;
        b=M9V/G2ryVDEevi+eMQuSv4KFOZdja65hZicndcWGb4SB47fEa5W89IOPY+p7oPTtOV
         gKNkM8qdTwSCM8ZmVd7CQMskajK1B9XH59dzqj6RWtcExy0jU+QZU6v18gIM01D2tk6X
         U47U3FNj1UmfJKhOyendPKA/Ib9pIWrwyLcmd6MWUlfKoqGDFQ9aRwo15MByqfQSxSNo
         ruJDVR2nlW/VtVdHy69PePlN6wuwBJ8FbboeOiyAjUmuAMdxx623C7gjOWwEPnyu6v9b
         1sc0Pcko8InsfuPLb/lYY9HZjukYfuCC3hnt4zZnqjrRxm7jolMR0a1wxrO1JjGMObb0
         LsJg==
X-Gm-Message-State: AOJu0YwnuUrcZBL4j4SP6zsz7xAzGvl/q3NAqUj44OB1ht3dUgQX4TSt
	cKC6TxrtPn5fkR8g2sWJSGt+ueasx2AzOQHEfQH0lT+AeNzwrmmgf18V1xkWqa5o
X-Gm-Gg: AY/fxX5czxuObA6hXknWdUIe5qkX41lrlGYo8pwgDoh8gMbnq/vdNoKcD6acqT2eDJx
	zEDJNUwKqtKXTPMteQadIWvg1h4uFfPz8u8+28Kv8LZpOTSV04gbXWEimsbIFGIKML+L/y2cec/
	2VLtJkgug5FYPBvfJgOpOcPEMENrSrpUQCG9zV8Ta46K1zMlVE0eivMy11WuFaWdTLP/As+ny7e
	SMiUYhojbwWjCQK2mnq6HOc0qHm4VSIDe1BA/beun8IMMY8h2/RWHglTj+haJds3HH9HLreDucZ
	t41Xek35F03Vw5oiI2B+Lm/IxBrgv2sV/VAQlY/MJ6TJIjM/Kam8Ychdj2onvQ4S87zhzPocluO
	hdr1IZajbd75YLM2u6l+bWR6jfXlNhW5ZELlQ7aksV2/MdzhgP5pWXjNp3ZU+ZFD3dlQjiKy9zl
	dMsVT1E+xi/0c=
X-Google-Smtp-Source: AGHT+IG6I2dm4mLdDJSbKfcPbgVWsom/hkvIX14dvN48vCOTTqEjM3JZjPL1AYdm3Y/3DHzuILyykg==
X-Received: by 2002:a05:620a:2952:b0:8b9:fa6f:7ea0 with SMTP id af79cd13be357-8bb3a3927f4mr2640888485a.87.1765980558509;
        Wed, 17 Dec 2025 06:09:18 -0800 (PST)
Received: from [127.0.0.1] ([48.214.53.69])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8be58b338d6sm317290985a.36.2025.12.17.06.09.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Dec 2025 06:09:17 -0800 (PST)
Message-Id: <d3b89c29b01e5ed19b40f45714b3a1db800afa5d.1765980535.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2018.git.1765980535.gitgitgadget@gmail.com>
References: <pull.2018.git.1765980535.gitgitgadget@gmail.com>
From: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 17 Dec 2025 14:08:53 +0000
Subject: [PATCH 16/18] mingw: try to create symlinks without elevated
 permissions
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

As of Windows 10 Build 14972 in Developer Mode, a new flag is supported
by `CreateSymbolicLink()` to create symbolic links even when running
outside of an elevated session (which was previously required).

This new flag is called `SYMBOLIC_LINK_FLAG_ALLOW_UNPRIVILEGED_CREATE`
and has the numeric value 0x02.

Previous Windows 10 versions will not understand that flag and return
an `ERROR_INVALID_PARAMETER`, therefore we have to be careful to try
passing that flag only when the build number indicates that it is
supported.

For more information about the new flag, see this blog post:
https://blogs.windows.com/buildingapps/2016/12/02/symlinks-windows-10/

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 compat/mingw.c | 26 ++++++++++++++++++++++++--
 1 file changed, 24 insertions(+), 2 deletions(-)

diff --git a/compat/mingw.c b/compat/mingw.c
index 59a32e454e..3e2110a87a 100644
--- a/compat/mingw.c
+++ b/compat/mingw.c
@@ -331,6 +331,8 @@ static const wchar_t *make_relative_to(const wchar_t *path,
 	return out;
 }
 
+static DWORD symlink_file_flags = 0, symlink_directory_flags = 1;
+
 enum phantom_symlink_result {
 	PHANTOM_SYMLINK_RETRY,
 	PHANTOM_SYMLINK_DONE,
@@ -381,7 +383,8 @@ process_phantom_symlink(const wchar_t *wtarget, const wchar_t *wlink)
 		return PHANTOM_SYMLINK_DONE;
 
 	/* otherwise recreate the symlink with directory flag */
-	if (DeleteFileW(wlink) && CreateSymbolicLinkW(wlink, wtarget, 1))
+	if (DeleteFileW(wlink) &&
+	    CreateSymbolicLinkW(wlink, wtarget, symlink_directory_flags))
 		return PHANTOM_SYMLINK_DIRECTORY;
 
 	errno = err_win_to_posix(GetLastError());
@@ -2846,7 +2849,7 @@ int symlink(const char *target, const char *link)
 			wtarget[len] = '\\';
 
 	/* create file symlink */
-	if (!CreateSymbolicLinkW(wlink, wtarget, 0)) {
+	if (!CreateSymbolicLinkW(wlink, wtarget, symlink_file_flags)) {
 		errno = err_win_to_posix(GetLastError());
 		return -1;
 	}
@@ -3523,6 +3526,24 @@ static void maybe_redirect_std_handles(void)
 				  GENERIC_WRITE, FILE_FLAG_NO_BUFFERING);
 }
 
+static void adjust_symlink_flags(void)
+{
+	/*
+	 * Starting with Windows 10 Build 14972, symbolic links can be created
+	 * using CreateSymbolicLink() without elevation by passing the flag
+	 * SYMBOLIC_LINK_FLAG_ALLOW_UNPRIVILEGED_CREATE (0x02) as last
+	 * parameter, provided the Developer Mode has been enabled. Some
+	 * earlier Windows versions complain about this flag with an
+	 * ERROR_INVALID_PARAMETER, hence we have to test the build number
+	 * specifically.
+	 */
+	if (GetVersion() >= 14972 << 16) {
+		symlink_file_flags |= 2;
+		symlink_directory_flags |= 2;
+	}
+
+}
+
 #ifdef _MSC_VER
 #ifdef _DEBUG
 #include <crtdbg.h>
@@ -3558,6 +3579,7 @@ int wmain(int argc, const wchar_t **wargv)
 #endif
 
 	maybe_redirect_std_handles();
+	adjust_symlink_flags();
 
 	/* determine size of argv and environ conversion buffer */
 	maxlen = wcslen(wargv[0]);
-- 
gitgitgadget

