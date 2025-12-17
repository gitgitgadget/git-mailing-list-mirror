Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CF7539B6A8
	for <git@vger.kernel.org>; Wed, 17 Dec 2025 14:09:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765980558; cv=none; b=Bbs8q4McW/nl3zlyVUibRV2Y8am2X7NooReZ5MAKrrnnYa7LIhGdoBJP2xaDobm15V+y3Ux4kVuQDfA5w7e8u8b/2itF86UXs0k+1zgR6pgEmhCoAdPdpPikBf5XUVRTckuIbLYdOiX6BO+Zu6g0uA54trc9vQm3ok2htk3G+sI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765980558; c=relaxed/simple;
	bh=3W58engbzmCoHzZLvykiMuINig0XlXikktjSjUscgGA=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=CjyHczsfYZYeHds69bGfPS4ddmlwqSVWr3MEOZ5x9FazS394HdjqnZkQO8A2YsNZC7hRIT/sIBQA4IljIqcgeO8EtSgknH51SjSn34RMaPZWsP/ZcBof5EZapD0JMkRwuYqPUE10YNfC3bLyQM+9pmCgajZ4CRGl0u+rUzw565A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KdOuuXwA; arc=none smtp.client-ip=209.85.222.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KdOuuXwA"
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-8b31a665ba5so726426385a.2
        for <git@vger.kernel.org>; Wed, 17 Dec 2025 06:09:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765980554; x=1766585354; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=R3cFXFaTLTo0OZMF3Q++G8wO6fr7DdQDwOOx6m95NNs=;
        b=KdOuuXwAjoutncpy8LrF0eKkUCSQ/GM55+haXqyJNzPXb4JF3Cy9gbhzy87rldL2NA
         QejOxIGfUJjLcJf0FHQw7Jnu1f81BFaq4PJRee6BPyg7GxbZsqABBvno5TYpTlg6DB35
         7iEPgnsm4pO3lPrHmJdTyeDjLXUG4p8dt5LMff7sTKqnuqQaIVnFKSjsO6iR5aCmJ7b/
         0sK3yg7cesHk082R4wp8ACL/H/yMaAS9mmebNurEB4OCocUhnkeffXCZhDqFDC3LBY8c
         9xmqrfGn1V680jWtzFp84rb9ydBL1WyuJTC/pOA5LjpT1GoIdBKMwtlC0/f73p3zAz3G
         gdog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765980554; x=1766585354;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=R3cFXFaTLTo0OZMF3Q++G8wO6fr7DdQDwOOx6m95NNs=;
        b=iB+6YEg9yuAZ40/bUql8h37RtKWGt5UXucCkkE95vMThU7fGuuNvk1va6ii7f1sEhQ
         nVgKQzuFZK3m2sK8RYlajR9/XPeGLIlZ1caeMH5uurc53jGN+ruCd6rRwbXCyJPPwZlk
         TI5H6GFZ9RGeUiIG3WU+XlwHVtQDahCq8OJ8jF+G1Hoxeq2TGCltTb9pMwu6dXWE5nJA
         rbEl/S2M3EUSWCW3eL4U+u2ODW2DOYlzTMWh/9paHG4MsVk8y3Cv6m9+FtcOX0Mhb0g/
         3Cb/FZBcbw4y9gFMd6XZVsrknTiM9+PTvJriVQy/ZBUmyepvRsx5hm91v8iUWe+HlomW
         M4Sg==
X-Gm-Message-State: AOJu0YwXnf6u9x4UrJ4KAxqBeKYFEJmRy0K81YEqLOnGcp50BoLqPu6F
	GDzo+H9kFfbb9Q5Mu3boszuHJsOOWBGSLAWYvSbsW5weoeiyl3bmqYGaotMcPUKs
X-Gm-Gg: AY/fxX4x4o9miXpYGthA6IdyMhQdsmweqRiX8IyE7OCadZGYgGt2gTXNr7DXbK4WM7w
	J/oQzGzj87BDznVGK71fGSgilMkdj60zF7eUbQImHVLXQFMD2+RWomLjSIOFzhlS0/6LaD2RHHE
	NNWXwJCJvaocXPjCamDysNqoonmG/GaOQIu9L/tbsJHfyYMfqTHPk9T/P0TbsKv6vewQ45gNgOr
	kBp6bNVqjaPfkfMcjGfOt0br35DLtA38fKw6PIlUGJ2gcUYyc14Gsg0g5Evc6uUtKQZtNK8UTsd
	7TlZJfHIUnqzzA1Jq9Jnp7BfLQZViSpQjhmtAirr+2pEQKau3OW+vGpVuu8MXCmGCEJuiVoz6f0
	chIcHpVHBDF8+mXiqNMEgPd+Nq08btIoPr9VmicP2mITLjSUhFwNNIu/b/pHRJ9uKohhcMVOMfW
	NTggGyg9syVoY=
X-Google-Smtp-Source: AGHT+IHLIpiJRaJcBKdxMtUlRrdNFe9ot50H+mssI7PKMp4/HjrMaU54kaSYhUSFrCEEnqb7rtlKFg==
X-Received: by 2002:a05:620a:400a:b0:8b2:e922:5282 with SMTP id af79cd13be357-8bb398e24d3mr2568518585a.26.1765980553740;
        Wed, 17 Dec 2025 06:09:13 -0800 (PST)
Received: from [127.0.0.1] ([48.214.53.69])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8be31b55a49sm406503485a.26.2025.12.17.06.09.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Dec 2025 06:09:13 -0800 (PST)
Message-Id: <49920839bb2f9e21d1cf91e54024ecd986fe32a9.1765980535.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2018.git.1765980535.gitgitgadget@gmail.com>
References: <pull.2018.git.1765980535.gitgitgadget@gmail.com>
From: "Karsten Blees via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 17 Dec 2025 14:08:49 +0000
Subject: [PATCH 12/18] mingw: allow `mingw_chdir()` to change to
 symlink-resolved directories
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
    Karsten Blees <blees@dcon.de>

From: Karsten Blees <blees@dcon.de>

If symlinks are enabled, resolve all symlinks when changing directories,
as required by POSIX.

Note: Git's `real_path()` function bases its link resolution algorithm
on this property of `chdir()`. Unfortunately, the current directory on
Windows is limited to only MAX_PATH (260) characters. Therefore using
symlinks and long paths in combination may be problematic.

Signed-off-by: Karsten Blees <blees@dcon.de>
Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 compat/mingw.c | 20 +++++++++++++++++++-
 1 file changed, 19 insertions(+), 1 deletion(-)

diff --git a/compat/mingw.c b/compat/mingw.c
index 55f0bb478e..5d2a8c247c 100644
--- a/compat/mingw.c
+++ b/compat/mingw.c
@@ -866,9 +866,27 @@ int mingw_access(const char *filename, int mode)
 int mingw_chdir(const char *dirname)
 {
 	wchar_t wdirname[MAX_PATH];
+
 	if (xutftowcs_path(wdirname, dirname) < 0)
 		return -1;
-	return _wchdir(wdirname);
+
+	if (has_symlinks) {
+		HANDLE hnd = CreateFileW(wdirname, 0,
+				FILE_SHARE_READ | FILE_SHARE_WRITE | FILE_SHARE_DELETE, NULL,
+				OPEN_EXISTING, FILE_FLAG_BACKUP_SEMANTICS, NULL);
+		if (hnd == INVALID_HANDLE_VALUE) {
+			errno = err_win_to_posix(GetLastError());
+			return -1;
+		}
+		if (!GetFinalPathNameByHandleW(hnd, wdirname, ARRAY_SIZE(wdirname), 0)) {
+			errno = err_win_to_posix(GetLastError());
+			CloseHandle(hnd);
+			return -1;
+		}
+		CloseHandle(hnd);
+	}
+
+	return _wchdir(normalize_ntpath(wdirname));
 }
 
 int mingw_chmod(const char *filename, int mode)
-- 
gitgitgadget

