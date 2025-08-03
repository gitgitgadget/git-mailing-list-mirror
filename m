Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6C591EDA3A
	for <git@vger.kernel.org>; Sun,  3 Aug 2025 21:25:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754256323; cv=none; b=jV2HClTfCW9cFZhueDferl2PaY0RsGtOHaR+TTEzFzzwoDRQ8v48QavhE/OjlQalMsu4q+tLX0hhV1w+t5SJESC/7ArM1xUwF96B/SapdGFuJffZLT8qsLnXGcuupnyFQGbhP/nrqmA7yxzmOFyeyOvy3ru5jWXD2nzwQcYNsUw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754256323; c=relaxed/simple;
	bh=rB5Bkocpxn8bDqabQG5q3lh4UqAFNkuVDkDtJTb/dQg=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:MIME-Version:
	 Content-Type:To:Cc; b=Kvgxecbq9oyHtJX6xML1Fn8YxJaV272DzLTs6WSJite5ipM5gCMePmiNgu9uP/uDNwd5Q0E9A6SJ5R9BYI9V7g80QiRAic5hLMC1WgUmIKgBcqmusQMgbHXFsHS6f7wT4JIj/j/GXE4aj+MgVtjsbwBheCPkt1K5++HDCejg8XM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=I8zg4SVM; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I8zg4SVM"
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-af93bcaf678so260419666b.0
        for <git@vger.kernel.org>; Sun, 03 Aug 2025 14:25:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754256320; x=1754861120; darn=vger.kernel.org;
        h=cc:to:fcc:content-transfer-encoding:mime-version:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OTEAVjTobAtBlyvqRitPQnExAaK65r3v9XFKcyD/57E=;
        b=I8zg4SVMN+uF7eG1+m0/xZfCzfPSvoZJxUDjyimssvXLLvgbtWWyi2zR+VdP5E7+NM
         SKMIVmhtAN2PTQR2xi/1gHEAyy8vn0rFMOmVFLlxP89sHQv7ggJMmfbXXPs2YB0CkF9D
         8hEMNCdtK1lWAVDALVxOGi3abZM+HK97pgXY71QBPYmd2ReuIzpRfnszD/kV3zfCXU4w
         AFb39vpxII+BKhkXY3z3XlfcCXcVmB2C/XVc3o9vufO6Oms73p57WSyV6lUHdTY7hIsL
         bWURaVWkY38qHB2K1x2UffxjxIUGi7cSdLVEb1bVYPpqlcoUGdDglisB5EGg9OeOFzgS
         49qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754256320; x=1754861120;
        h=cc:to:fcc:content-transfer-encoding:mime-version:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OTEAVjTobAtBlyvqRitPQnExAaK65r3v9XFKcyD/57E=;
        b=qgQk12WeiojBF+JLJ4dYN6DcHD+BhGgUz2JGQWZC2s9m5ZlzVnBrA/m3DNzddM3BzU
         1TT8z1lvydyp8F/dmY0inyG/cnHfy2pk/Bzbv0MCvVeMKZQi3d4GpPNv8I1pQ5+Ysi93
         pLpouQxecn1U6GipzJt0BCI2U2Mn+0t8vqkPjTTUVbLoH4JxrtzOV0AaPn20PYIaKyRL
         kzEKKMnV7lTRMMMGcBd3R7F5v7dirqIhzPYPixJv6yWHtIOW8FV0XoW7YjyxKABXXp2T
         uUfa8NZsVDir5XgLWJ8mB+3EODeRCtGi5wq3a4YKnjkbMtab+30N7eJz2oBUxq6YGajP
         aVYg==
X-Gm-Message-State: AOJu0Yyqi+ISEhbJJMylsygosqFfFVDhEXIr+cQSbUwXD4lb1Kn6ygBq
	NgU0bBpUDURYhhFMwhJG4hBjnOTXXLsv24XDEjzKGRSHaJCVbjgnfqD/qkFNCg==
X-Gm-Gg: ASbGnctS2KghcIiLeWc9vjlt71qSxdtZzizmXSr2VRBPlIOvu0AcOQrwo/hLotayA2r
	+JieMV+1cKfOJKxvbwZ796HEOVpsWtPETIE1trIx+cZdj0K08xLXRsrVvJ0lcZGQHB7mDzZDlEE
	RJh5N1WfOSblWo4MmeTKGJvjsPhL27LOmMd3JQxnoG18r6nUdg+og5DB3jdlk+8Q+Bz7amaFjIz
	1RMAF/fVsnaqLgFBFywhvxDWtKr4LiYHCs08ls9UeMn787iEOM+m34lUKpFa3sDVuiVbHoSU99v
	EDlMHNjV8dHYpYManmSMzDQOHoi7a3I1qyJMAzbwEifV+nvCcXC6SZ2JvQgAihigTNKQcQ91Pkl
	YnbLrvt7A9UgtWjpwwfz6WRo=
X-Google-Smtp-Source: AGHT+IH6229L2QzLFxumKIP3ifHkRRhcoDOtEj3vQhaq85KWCaSgV18/AOjC230r23nu+q/85unRVw==
X-Received: by 2002:a17:907:3f99:b0:ae3:c767:da11 with SMTP id a640c23a62f3a-af940231530mr820516666b.50.1754256319622;
        Sun, 03 Aug 2025 14:25:19 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-af91a24062esm632116266b.126.2025.08.03.14.25.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Aug 2025 14:25:19 -0700 (PDT)
Message-Id: <0995ecadaff56d2ff44c965763800ec892490bad.1754256318.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1948.git.1754256318.gitgitgadget@gmail.com>
References: <pull.1948.git.1754256318.gitgitgadget@gmail.com>
From: "=?UTF-8?q?Matthias=20A=C3=9Fhauer?= via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sun, 03 Aug 2025 21:25:15 +0000
Subject: [PATCH 1/4] mingw_open_existing: handle directories better
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Fcc: Sent
To: git@vger.kernel.org
Cc: Johannes Schindelin <johannes.schindelin@gmx.de>,
    =?UTF-8?q?Matthias=20A=C3=9Fhauer?= <mha1993@live.de>

From: =?UTF-8?q?Matthias=20A=C3=9Fhauer?= <mha1993@live.de>

CreateFileW() requires FILE_FLAG_BACKUP_SEMANTICS to create a directory
handle [1] and errors out with ERROR_ACCESS_DENIED without this flag.
Fall back to accessing Directory handles this way.

[1] https://learn.microsoft.com/en-us/windows/win32/api/fileapi/nf-fileapi-createfilew#directories

This fixes https://github.com/git-for-windows/git/issues/5068

Signed-off-by: Matthias Aßhauer <mha1993@live.de>
---
 compat/mingw.c | 21 ++++++++++++++++-----
 1 file changed, 16 insertions(+), 5 deletions(-)

diff --git a/compat/mingw.c b/compat/mingw.c
index 5d69ae32f4b9..2dd5cbcaee0d 100644
--- a/compat/mingw.c
+++ b/compat/mingw.c
@@ -588,13 +588,24 @@ static int mingw_open_existing(const wchar_t *filename, int oflags, ...)
 			     &security_attributes, OPEN_EXISTING, FILE_ATTRIBUTE_NORMAL, NULL);
 	if (handle == INVALID_HANDLE_VALUE) {
 		DWORD err = GetLastError();
+		if (err == ERROR_ACCESS_DENIED) {
+			DWORD attrs = GetFileAttributesW(filename);
+			if (attrs != INVALID_FILE_ATTRIBUTES && (attrs & FILE_ATTRIBUTE_DIRECTORY))
+				handle = CreateFileW(filename, access,
+							FILE_SHARE_WRITE | FILE_SHARE_READ | FILE_SHARE_DELETE,
+							&security_attributes, OPEN_EXISTING, FILE_ATTRIBUTE_NORMAL| FILE_FLAG_BACKUP_SEMANTICS, NULL);
+		}
 
-		/* See `mingw_open_append()` for why we have this conversion. */
-		if (err == ERROR_INVALID_PARAMETER)
-			err = ERROR_PATH_NOT_FOUND;
+		if (handle == INVALID_HANDLE_VALUE) {
+			err = GetLastError();
 
-		errno = err_win_to_posix(err);
-		return -1;
+			/* See `mingw_open_append()` for why we have this conversion. */
+			if (err == ERROR_INVALID_PARAMETER)
+				err = ERROR_PATH_NOT_FOUND;
+
+			errno = err_win_to_posix(err);
+			return -1;
+		}
 	}
 
 	fd = _open_osfhandle((intptr_t)handle, oflags | O_BINARY);
-- 
gitgitgadget

