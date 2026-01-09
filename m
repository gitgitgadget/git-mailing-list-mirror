Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3094368264
	for <git@vger.kernel.org>; Fri,  9 Jan 2026 20:05:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767989124; cv=none; b=GSGeTEmod2baxTNNRpW+c3lD+0kiguGIcaIfEoNGeUOCFVzCbKWJeAuQiIp4naXvJvfdMqOkPY3ADOWLWUfsx1NQvqs7wyWrHiRCeZ/rWySH9sGBbNnjzzqeXnxj8CNQdGEeOLaoQjm282wxIL/4Ht+7KpxMRdUD0zhkSB8SJoI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767989124; c=relaxed/simple;
	bh=QJJNEexfgNcRECliHs+p6WFG4fOwar9kTiYhtDH6A4o=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=lmwuKBG1b4FKRrFdPxtyE3hay14n4dSl97RZdPIryuhZ3gtrr1dlSUvW2TvzMqU+w2Uwly845caP0kyMnhoRuZhwzAiZFH/2MXpb3Y+/tj/usXurffx1aIXUJ2F5hWNnKpJRfk/1PN2lMzDGRm24QijbHEqUMUcNmBs5aclv/NQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BIJ0NTbz; arc=none smtp.client-ip=209.85.222.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BIJ0NTbz"
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-8b1e54aefc5so405060585a.1
        for <git@vger.kernel.org>; Fri, 09 Jan 2026 12:05:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767989121; x=1768593921; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Po7Q9hev9G0Pu+UHLakh9d26xzbT8wiTjwt6xgj9FvY=;
        b=BIJ0NTbzEOEgibKTQvU09B7Ki9KL7yuu6DERUC9NxC8pVoQ5/1hG5Efl3cxhX45vjN
         y2WjXzK36rLwwI9nGAq/InBr3B3bCyYaADDhjseCimTMZ5KoGKPgGdcO7jM6fyQ/50ja
         iveKmBy/Hd4AkdwRwFH6poiCHg467WF0ugxdeSFof2MB6tsBYHtavaUpFTFyIaWMQfGY
         CCThOUeBTF24kplu6eMQ+cUt761aknhTQpinA7c6eFtklL7TBu8e800v3ivuvLNRW4dO
         mGdhhv+Mj56CYjnSR98eAn+4CTMjS2miGXtr1ruggDzGvzPz/4IJ+/GXjOjTB6+Wa4Nl
         Ya6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767989121; x=1768593921;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Po7Q9hev9G0Pu+UHLakh9d26xzbT8wiTjwt6xgj9FvY=;
        b=GfTPpPMDu8BO/6VlQ6lu2VqSzO1XkLuyVY6kluK6J1ZacH6h/4CTBMGAiFo2y+A1dM
         o398k+QXHhi4iX8WV3//Ud3kTkGMv1EojiyKYvmwNsUbDlbNoQLmax0+vLJI0KejqFVu
         wa1nujLcLh/a6cUkOKt7JP9B0ZWqypu+a+PRYYF9ZhNHH3pFy85wizxSlDAnDo5BYyYR
         SlnBc9ZEZBHchw17XmvLCKuWzwOc7Vg7bhhZEA8DzPEjspJDvZ7C8buNCIlWmxVduBbZ
         6e8ELykwqumCAMIyyJDP8VE3KKIa2zXCK5rhc0sOirkPt39p8tGJFjzr58IOQb1feyRd
         edSA==
X-Gm-Message-State: AOJu0Ywv1A2kw7DQOQyI1zYVVMWHknGw4HJXKxLPfgqizHpV3gA7PON0
	K4M3qDrYP/8PaO0HmEDtZoFv08ACkL5zAQk3HaSS3hF26HdA2b690gljHd4AMc+Z
X-Gm-Gg: AY/fxX7UfS3c603dkzE+6rhx15tV7PCnq7/qfOv83B0wmSwX+itXV+W4XpruMGltbpD
	UeMVwttn0XfLjYTW2Q6vpqrfdSHO2D1nl0q6edEHYcZnwYjZMp7EiOGbpOBE9KLQRc2ElkpaiKV
	K5E/1OpL0FhOFEEl7ybxLoaxCIa+dyrHHXzqARqgu0xXtXI3QxhIN0b3yMveD60KW79c0kSouyn
	ckUp7q/aLEsME2Kk2OgDAcsiNHAuqGjO9keemzzA4BjA3AUJcWcP1Jm4BQkDDwZMjlwUIhq+KAt
	OunE4+idfHF44y7a6zwaSWLY1pfWFd9FHhONKlwe2kcN6RDxtJcbiZANHU3Y6LlYiGjbbpbSDux
	4UeS0qX0HBLn6bEyCv3nAr2CN1L378Jcj3Hwu+3cwzNfxMKWz/O22lrbFmcJtPz/vF1OJwEqFQj
	455S36NOKibU7e
X-Google-Smtp-Source: AGHT+IHdw66pxBgfwXTrINJ5ZSFr7nucAHZkl5H0//j/9ep6RUD7lPjw5/48yCNlLH4H6esncoZ7Xw==
X-Received: by 2002:a05:620a:370d:b0:8b2:d30c:a30e with SMTP id af79cd13be357-8c3893ef7ebmr1316624985a.46.1767989121124;
        Fri, 09 Jan 2026 12:05:21 -0800 (PST)
Received: from [127.0.0.1] ([20.161.67.219])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8907723469fsm91150486d6.37.2026.01.09.12.05.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Jan 2026 12:05:20 -0800 (PST)
Message-Id: <a6355789c359f3631d5a8de7cbd1cbdbb719f8d1.1767989115.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2018.v2.git.1767989115.gitgitgadget@gmail.com>
References: <pull.2018.git.1765980535.gitgitgadget@gmail.com>
	<pull.2018.v2.git.1767989115.gitgitgadget@gmail.com>
From: "Karsten Blees via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 09 Jan 2026 20:05:01 +0000
Subject: [PATCH v2 04/18] mingw: let `mingw_lstat()` error early upon problems
 with reparse points
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

When obtaining lstat information for reparse points, we need to call
`FindFirstFile()` in addition to `GetFileInformationEx()` to obtain
the type of the reparse point (symlink, mount point etc.). However,
currently there is no error handling whatsoever if `FindFirstFile()`
fails.

Call `FindFirstFile()` before modifying the `stat *buf` output parameter
and error out if the call fails.

Note: The `FindFirstFile()` return value includes all the data
that we get from `GetFileAttributesEx()`, so we could replace
`GetFileAttributesEx()` with `FindFirstFile()`. We don't do that because
`GetFileAttributesEx()` is about twice as fast for single files. I.e.
we only pay the extra cost of calling `FindFirstFile()` in the rare case
that we encounter a reparse point.

Please also note that the indentation the remaining reparse point
code changed, and hence the best way to look at this diff is with
`--color-moved -w`. That code was _not_ moved because a subsequent
commit will move it to an altogether different function, anyway.

Signed-off-by: Karsten Blees <karsten.blees@gmail.com>
Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 compat/mingw.c | 24 ++++++++++++++----------
 1 file changed, 14 insertions(+), 10 deletions(-)

diff --git a/compat/mingw.c b/compat/mingw.c
index ec6c2801d3..23a926c7d1 100644
--- a/compat/mingw.c
+++ b/compat/mingw.c
@@ -920,6 +920,7 @@ static int has_valid_directory_prefix(wchar_t *wfilename)
 int mingw_lstat(const char *file_name, struct stat *buf)
 {
 	WIN32_FILE_ATTRIBUTE_DATA fdata;
+	WIN32_FIND_DATAW findbuf = { 0 };
 	wchar_t wfilename[MAX_PATH];
 	int wlen = xutftowcs_path(wfilename, file_name);
 	if (wlen < 0)
@@ -934,6 +935,13 @@ int mingw_lstat(const char *file_name, struct stat *buf)
 	}
 
 	if (GetFileAttributesExW(wfilename, GetFileExInfoStandard, &fdata)) {
+		/* for reparse points, use FindFirstFile to get the reparse tag */
+		if (fdata.dwFileAttributes & FILE_ATTRIBUTE_REPARSE_POINT) {
+			HANDLE handle = FindFirstFileW(wfilename, &findbuf);
+			if (handle == INVALID_HANDLE_VALUE)
+				goto error;
+			FindClose(handle);
+		}
 		buf->st_ino = 0;
 		buf->st_gid = 0;
 		buf->st_uid = 0;
@@ -946,20 +954,16 @@ int mingw_lstat(const char *file_name, struct stat *buf)
 		filetime_to_timespec(&(fdata.ftLastWriteTime), &(buf->st_mtim));
 		filetime_to_timespec(&(fdata.ftCreationTime), &(buf->st_ctim));
 		if (fdata.dwFileAttributes & FILE_ATTRIBUTE_REPARSE_POINT) {
-			WIN32_FIND_DATAW findbuf;
-			HANDLE handle = FindFirstFileW(wfilename, &findbuf);
-			if (handle != INVALID_HANDLE_VALUE) {
-				if ((findbuf.dwFileAttributes & FILE_ATTRIBUTE_REPARSE_POINT) &&
-						(findbuf.dwReserved0 == IO_REPARSE_TAG_SYMLINK)) {
-					buf->st_mode = S_IFLNK | S_IREAD;
-					if (!(findbuf.dwFileAttributes & FILE_ATTRIBUTE_READONLY))
-						buf->st_mode |= S_IWRITE;
-				}
-				FindClose(handle);
+			if ((findbuf.dwFileAttributes & FILE_ATTRIBUTE_REPARSE_POINT) &&
+					(findbuf.dwReserved0 == IO_REPARSE_TAG_SYMLINK)) {
+				buf->st_mode = S_IFLNK | S_IREAD;
+				if (!(findbuf.dwFileAttributes & FILE_ATTRIBUTE_READONLY))
+					buf->st_mode |= S_IWRITE;
 			}
 		}
 		return 0;
 	}
+error:
 	switch (GetLastError()) {
 	case ERROR_ACCESS_DENIED:
 	case ERROR_SHARING_VIOLATION:
-- 
gitgitgadget

