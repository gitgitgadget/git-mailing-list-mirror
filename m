Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BF7D1F03DE
	for <git@vger.kernel.org>; Tue, 17 Dec 2024 12:52:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734439930; cv=none; b=AADMoWVDAJYUSJJJmTqIY0EAHq814Va9j1RLE4kpKXkWAPl3bmiGGGbdqcAu0GiEOzjQ6JvJFMGfk45PUzMBToK4RhpdjhiAJ/1WveAi6ZTrJezOXdSX3BXUkAgDnzF0WDrXXYtvWRGa9P+oVZaQMl6m2XOLmL2uRMkat31J8PI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734439930; c=relaxed/simple;
	bh=T1J5bzf87RWNl8tE0onf9VZoPbT79WqFK8uIx23/Txk=;
	h=Message-Id:From:Date:Subject:Content-Type:MIME-Version:To:Cc; b=VRJOmUcgegTwymirgvcatnmbZ9v4f0imBwtYWnBsPuhhdi8bPxnBYUuluwxaEcdQ2m/jzE8AotWxrjHA231PpcoJECMwxRQaUJPNSunHGUGZ162k/GONBmapYZBolezc6XVRSVDOqzwEiNMe07Gs8JY+j4sqydJfd4IWsVn8diM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZPvrwpdJ; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZPvrwpdJ"
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-386329da1d9so2449751f8f.1
        for <git@vger.kernel.org>; Tue, 17 Dec 2024 04:52:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734439926; x=1735044726; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=qqzs6LX9hRHMXm/wFHloW2srIsbZQFtlgPHXz1OigL0=;
        b=ZPvrwpdJG54p0w0gv/oY3zBMVB4XxB+iIdc5Q0JdHxr6IAY0Froz7oY901RGF+vSc/
         qGVAhlEKND/BW9+z6i29ivnpMAFS0pNrrxjQDyfxm3XMx9FGk2iL9kUJohiapEhMZyQd
         pWHKrM+4sw5RRx5aQBd36NkFpUWAfThn/DPUbCdYDvcEGB96KsUXvkRwUO11sLIB6iJl
         snzjSgQq8VA2fAguBdBrwLx8LDdATOKa4Bezd7BNV1HdGwz/h7bXc1nrjnp6yHPRHazd
         2aK1dDzVP/oY4ioPl488CSaQsxE7cxCYG0D1L6hw4zmFS44JQ+mqnTFbDL2o5hrqXEqJ
         U+/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734439926; x=1735044726;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qqzs6LX9hRHMXm/wFHloW2srIsbZQFtlgPHXz1OigL0=;
        b=tWY7yvUMJldmUjRD4C/C/Uj00vIqxUWWkDhlF9GDHjzXRymOnxoQrKTYo50wH4SfcW
         NHEFUgHCo5zCy4DdgyT/0NnSYZOi3wCo5iB0Qo6MGc4/+R7HKb4l36BnCI18k2EQPdiv
         EqvWUWZHzSlaVymanBvfnkl9fLfpiFTEv9BjuVW4WGGGno3R/AQp4a5DmfVTfTWiT2mD
         46B8R8fBVVOyVqZFKA48pKs8bx9BExqAk+ayI5GpQI5hE+TVZk9eP8Ly4VW05DdEvNOu
         DVbLdAziU2sbp5OY5HC9d/diRHpGTk/MfDKQraqwZzMgPbJbmmQjSZ8IBEmi+dcZGoci
         ZkrA==
X-Gm-Message-State: AOJu0Ywrm1FWPZIEmDaBl1EIxXtCb3cTmRP63Qg/SupAULw8ZASTHgAO
	dm6iIM8NFRuIMh97yJ4g+5Z74ixOW+pp4/8Fu9wyFtxpTH4yabyOEMwxzg==
X-Gm-Gg: ASbGncsYMU6RfZ7eAg4H617pM69GYqPnvwBLWWxspdPpgS0pOYitIzUFNrQWANm3qUN
	p4bwRaUugiH0i0mHJr8bF93QrXuOhoxic6J3XhjXyU3xCJLRj3jj6wGLLbW2AnKfqcHzYtIT1F3
	WmHdQJjTxtV/zMcGhBzgUrEfSzm0fx+H9EDWAAwsuYuoNgx7uJ1xI4gjoDY5HfDgdqDIvrWZO4k
	CUESDS2+JnbZmRLYiSPiXPhJP7tripKj0mFedcwwOsx2hoxxgMMuJhtAA==
X-Google-Smtp-Source: AGHT+IE5JRTUx2S/JmVaEDe6G9JHFEjhDwTREROVcpZzOYUCA5UMxlioOtO5xd5KTm1Rop6l5Qm1PA==
X-Received: by 2002:a05:6000:156b:b0:386:3d16:9609 with SMTP id ffacd0b85a97d-38880ad7959mr13539713f8f.17.1734439925817;
        Tue, 17 Dec 2024 04:52:05 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4363602b1a1sm117828635e9.10.2024.12.17.04.52.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Dec 2024 04:52:05 -0800 (PST)
Message-Id: <pull.1839.git.1734439924842.gitgitgadget@gmail.com>
From: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 17 Dec 2024 12:52:04 +0000
Subject: [PATCH] mingw_rename: do support directory renames
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
Cc: Patrick Steinhardt <ps@pks.im>,
    Johannes Schindelin <johannes.schindelin@gmx.de>,
    Johannes Schindelin <johannes.schindelin@gmx.de>

From: Johannes Schindelin <johannes.schindelin@gmx.de>

In 391bceae435 (compat/mingw: support POSIX semantics for atomic
renames, 2024-10-27), we taught the `mingw_rename()` function to respect
POSIX semantics, but we did so only as a fallback after `_wrename()`
fails.

This hid a bug in the implementation that was not caught by Git's test
suite: The `CreateFileW()` function _can_ open handles to directories,
but not when asked to use the `FILE_ATTRIBUTE_NORMAL` flag, as that flag
only is allowed for files.

Let's fix this by using the common `FILE_FLAG_BACKUP_SEMANTICS` flag
that can be used for opening handles to directories, too.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
    mingw_rename: do support directory renames
    
    This is not quite a critical bug fix for Git because (unlike Git for
    Windows) it attempts _wrename() first. If that succeeds, we'll not
    bother with the POSIX semantics.
    
    However, Git for Windows knows how to deal with symbolic links, and
    _wrename() does not work for them. Therefore, that _wrename() call was
    patched out there and we rely on the native Win32 API call to
    SetFileInformationByHandle() to rename files and directories.
    
    It is that latter part that is at heart of this here bug fix: To be able
    to call SetFileInformationByHandle(), we need a handle, and
    CreateFileW() is what we use, for files, and crucially, also for
    directories.
    
    So while it is not critical for Git to take this patch, it still is
    important because that _wrename() call can fail, even when renaming
    directories, and then we want the fallback to fail not because we tried
    to obtain a handle using incorrect flags, but only because the actual
    rename operation failed.
    
    This patch is based on ps/mingw-rename.

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1839%2Fdscho%2Fps%2Fmingw-rename-followup-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1839/dscho/ps/mingw-rename-followup-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/1839

 compat/mingw.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/compat/mingw.c b/compat/mingw.c
index c4320769db6..e8f491d03a7 100644
--- a/compat/mingw.c
+++ b/compat/mingw.c
@@ -2273,7 +2273,7 @@ repeat:
 
 		old_handle = CreateFileW(wpold, DELETE,
 					 FILE_SHARE_WRITE | FILE_SHARE_READ | FILE_SHARE_DELETE,
-					 NULL, OPEN_EXISTING, FILE_ATTRIBUTE_NORMAL, NULL);
+					 NULL, OPEN_EXISTING, FILE_FLAG_BACKUP_SEMANTICS, NULL);
 		if (old_handle == INVALID_HANDLE_VALUE) {
 			errno = err_win_to_posix(GetLastError());
 			return -1;

base-commit: 391bceae4350136a05d977573caeaa07059f2136
-- 
gitgitgadget
