Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE9C839B6CF
	for <git@vger.kernel.org>; Wed, 17 Dec 2025 14:09:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765980561; cv=none; b=l954FM8UxZFo8ndHUohvWKQUCUTe37hw0un2/ZknieiBjcU+pdwxzzMGjXlDstDNrFT1q5/olVP81/sI+4a8YkLRva56jHfgdzXGPIUUD3ZtbLx6ON3Tj68GbYvvpH/+Wdckru89gsROymCsVwUIXpSs//hVlHrTQX8XQepEQ0Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765980561; c=relaxed/simple;
	bh=EVKS2OVYJGUwM438PczPWJ3bngTswkZv2NqTkRMMeR0=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=Q1hw8pqpxJlRB7gPuyShh99OyHUVAFrx19002qmoMkrm6DbcrKnZTu+1HxTX8hbuSwqITqxIVQd7DDFvOoVoF4TVZ752FLd+tb1w5n0SxEEKbPSFCUF2J6VqMuT5H2UClcR6gSbLcRfGtlirmAs12CrQRKGWAjKg8IcZHoegLPE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZIOQKdc2; arc=none smtp.client-ip=209.85.222.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZIOQKdc2"
Received: by mail-qk1-f175.google.com with SMTP id af79cd13be357-8b2627269d5so591921985a.2
        for <git@vger.kernel.org>; Wed, 17 Dec 2025 06:09:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765980557; x=1766585357; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1bbfbdfaKP+u+6yftgOzJJhA9NKGv3sSeyTEF4yPudw=;
        b=ZIOQKdc2ngQW2XFocvxOBnpRKNc1fMmm8ue14BZoK8fivgEtvLNroQAlA8dS2op5+g
         +d6X/hhia/k2LRbq7T18d9DWpZBcXRJp7QdPIBzEXsYl5Z73TsQBS8fumKFH5vRye974
         0GrBHH73v4vm9U2NtW6x4u5iFCl1e3hJQ0lMH5tB8uj6RDsw/Ft1OCod4UQ0eJLvPMhy
         dMh7c5Gq/xgrNxw/ElHcREvAfCvOXk5MHoGwto/wfhdUAZgNk+lXVLl6JiOnviAbeuu3
         0IzPZ9KjBFiKwH/ev2/5rGgnqhCbinxAX5lyFCwuNuCUaEadsKVXA1SlRiPTo/vgkEJh
         Kz6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765980557; x=1766585357;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=1bbfbdfaKP+u+6yftgOzJJhA9NKGv3sSeyTEF4yPudw=;
        b=bce9gtMdcEnrR2dhs2T/cfr0GEgY93l4H2Uv7AO6WSu8E/CBijsuFEEtHjVDKF6sTn
         vX2CMLF6A9wCDLS6lRQTgvCUwJcyrs7X2B+ZM1+pAGo3Q6Nv/EQZnvU3Cwhk9VYxcDSV
         6Lysgz1vFaLAit6u3rel0GbajjTtKgRTSD+c5o1QTiwCrpSA4jnhnbQ6IOg7aOSavS6q
         LcYMOnLqTkjoOoC6L3uOoz+NVjF4YNdpe67hyn+nUOD4FKvwJqt5lir+PD5Ibtdn6wwl
         WytfvGoKvOrhbqDrzlFvkPdu14l1GoXgRGNhKCC/5VZFvti7vhHekg+TkOXE3oXnjTx5
         duQg==
X-Gm-Message-State: AOJu0Yx6f2YmY0rzNGoKC0dSDpf+64jdyngNBPXLdM+mHmDhrMiwlXm9
	TsQ7DhZNIKREFo4aiBj9EkZfyYIOYBrO/A/8rS1tvIzzypqbjN1SE7miFg0dEQBQ
X-Gm-Gg: AY/fxX482vdMg4EQwR5pVhOIYPfNxf1VeKZX4AE2DQY2xJINua6PmZmbPEHt6ARSzya
	X5fe7nvocYT0uOcZrHNe312For7wp1LV0GNftswkY07CK6uE8SeshmXrNbxm4jnLpoH+3L/Mq2l
	WP0LCK/B7zl+S95P5Q50t4MEuL3QDu/P5FLtEZwt6wjmYqv70O4yudYyPfKoLB/DeDcJB0iAlIC
	ouX4ErhmoReGkclM8b9lDDqopie1+mdPqCYRrU2kAWydfqzqFrVcwOGW8SD7RVLP/Ztd/og8+l6
	1+vXoUYo8pxyS3YdiNa7GxYHhTeYiwM62Hqcvnur5iltJV1prMSL5LePHmHDLSvRjaknCE2TO4A
	xfy/5+lY3x7p8hjnZO23uG91PAHEvs8fYO2W9NOfYG4lpLiIUBtl+48JSCTYU4nLOhkshZPh63g
	NG33CvfvF6hZE=
X-Google-Smtp-Source: AGHT+IGSWGFH7KZz7sVN+jOzoTytz+yT97QDUphzTLmrK2gQH2lgCtQOeNMwE+/7NYMo37SON2NGLg==
X-Received: by 2002:a05:620a:1929:b0:8b2:64b1:692c with SMTP id af79cd13be357-8bb39faf665mr2601724185a.29.1765980557201;
        Wed, 17 Dec 2025 06:09:17 -0800 (PST)
Received: from [127.0.0.1] ([48.214.53.69])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8be31b669e9sm403046785a.37.2025.12.17.06.09.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Dec 2025 06:09:16 -0800 (PST)
Message-Id: <7b6dbc73f74e2fb6539034ab54f8d1a098d398da.1765980535.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2018.git.1765980535.gitgitgadget@gmail.com>
References: <pull.2018.git.1765980535.gitgitgadget@gmail.com>
From: "Karsten Blees via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 17 Dec 2025 14:08:52 +0000
Subject: [PATCH 15/18] mingw: add support for symlinks to directories
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

Symlinks on Windows have a flag that indicates whether the target is a
file or a directory. Symlinks of wrong type simply don't work. This even
affects core Win32 APIs (e.g. `DeleteFile()` refuses to delete directory
symlinks).

However, `CreateFile()` with FILE_FLAG_BACKUP_SEMANTICS does work. Check
the target type by first creating a tentative file symlink, opening it,
and checking the type of the resulting handle. If it is a directory,
recreate the symlink with the directory flag set.

It is possible to create symlinks before the target exists (or in case
of symlinks to symlinks: before the target type is known). If this
happens, create a tentative file symlink and postpone the directory
decision: keep a list of phantom symlinks to be processed whenever a new
directory is created in `mingw_mkdir()`.

Limitations: This algorithm may fail if a link target changes from file
to directory or vice versa, or if the target directory is created in
another process. It's the best Git can do, though.

Signed-off-by: Karsten Blees <blees@dcon.de>
Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 compat/mingw.c | 164 +++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 164 insertions(+)

diff --git a/compat/mingw.c b/compat/mingw.c
index 8d366794c4..59a32e454e 100644
--- a/compat/mingw.c
+++ b/compat/mingw.c
@@ -296,6 +296,131 @@ int mingw_core_config(const char *var, const char *value,
 	return 0;
 }
 
+static inline int is_wdir_sep(wchar_t wchar)
+{
+	return wchar == L'/' || wchar == L'\\';
+}
+
+static const wchar_t *make_relative_to(const wchar_t *path,
+				       const wchar_t *relative_to, wchar_t *out,
+				       size_t size)
+{
+	size_t i = wcslen(relative_to), len;
+
+	/* Is `path` already absolute? */
+	if (is_wdir_sep(path[0]) ||
+	    (iswalpha(path[0]) && path[1] == L':' && is_wdir_sep(path[2])))
+		return path;
+
+	while (i > 0 && !is_wdir_sep(relative_to[i - 1]))
+		i--;
+
+	/* Is `relative_to` in the current directory? */
+	if (!i)
+		return path;
+
+	len = wcslen(path);
+	if (i + len + 1 > size) {
+		error("Could not make '%ls' relative to '%ls' (too large)",
+		      path, relative_to);
+		return NULL;
+	}
+
+	memcpy(out, relative_to, i * sizeof(wchar_t));
+	wcscpy(out + i, path);
+	return out;
+}
+
+enum phantom_symlink_result {
+	PHANTOM_SYMLINK_RETRY,
+	PHANTOM_SYMLINK_DONE,
+	PHANTOM_SYMLINK_DIRECTORY
+};
+
+/*
+ * Changes a file symlink to a directory symlink if the target exists and is a
+ * directory.
+ */
+static enum phantom_symlink_result
+process_phantom_symlink(const wchar_t *wtarget, const wchar_t *wlink)
+{
+	HANDLE hnd;
+	BY_HANDLE_FILE_INFORMATION fdata;
+	wchar_t relative[MAX_PATH];
+	const wchar_t *rel;
+
+	/* check that wlink is still a file symlink */
+	if ((GetFileAttributesW(wlink)
+			& (FILE_ATTRIBUTE_REPARSE_POINT | FILE_ATTRIBUTE_DIRECTORY))
+			!= FILE_ATTRIBUTE_REPARSE_POINT)
+		return PHANTOM_SYMLINK_DONE;
+
+	/* make it relative, if necessary */
+	rel = make_relative_to(wtarget, wlink, relative, ARRAY_SIZE(relative));
+	if (!rel)
+		return PHANTOM_SYMLINK_DONE;
+
+	/* let Windows resolve the link by opening it */
+	hnd = CreateFileW(rel, 0,
+			FILE_SHARE_READ | FILE_SHARE_WRITE | FILE_SHARE_DELETE, NULL,
+			OPEN_EXISTING, FILE_FLAG_BACKUP_SEMANTICS, NULL);
+	if (hnd == INVALID_HANDLE_VALUE) {
+		errno = err_win_to_posix(GetLastError());
+		return PHANTOM_SYMLINK_RETRY;
+	}
+
+	if (!GetFileInformationByHandle(hnd, &fdata)) {
+		errno = err_win_to_posix(GetLastError());
+		CloseHandle(hnd);
+		return PHANTOM_SYMLINK_RETRY;
+	}
+	CloseHandle(hnd);
+
+	/* if target exists and is a file, we're done */
+	if (!(fdata.dwFileAttributes & FILE_ATTRIBUTE_DIRECTORY))
+		return PHANTOM_SYMLINK_DONE;
+
+	/* otherwise recreate the symlink with directory flag */
+	if (DeleteFileW(wlink) && CreateSymbolicLinkW(wlink, wtarget, 1))
+		return PHANTOM_SYMLINK_DIRECTORY;
+
+	errno = err_win_to_posix(GetLastError());
+	return PHANTOM_SYMLINK_RETRY;
+}
+
+/* keep track of newly created symlinks to non-existing targets */
+struct phantom_symlink_info {
+	struct phantom_symlink_info *next;
+	wchar_t *wlink;
+	wchar_t *wtarget;
+};
+
+static struct phantom_symlink_info *phantom_symlinks = NULL;
+static CRITICAL_SECTION phantom_symlinks_cs;
+
+static void process_phantom_symlinks(void)
+{
+	struct phantom_symlink_info *current, **psi;
+	EnterCriticalSection(&phantom_symlinks_cs);
+	/* process phantom symlinks list */
+	psi = &phantom_symlinks;
+	while ((current = *psi)) {
+		enum phantom_symlink_result result = process_phantom_symlink(
+				current->wtarget, current->wlink);
+		if (result == PHANTOM_SYMLINK_RETRY) {
+			psi = &current->next;
+		} else {
+			/* symlink was processed, remove from list */
+			*psi = current->next;
+			free(current);
+			/* if symlink was a directory, start over */
+			if (result == PHANTOM_SYMLINK_DIRECTORY)
+				psi = &phantom_symlinks;
+		}
+	}
+	LeaveCriticalSection(&phantom_symlinks_cs);
+}
+
 /* Normalizes NT paths as returned by some low-level APIs. */
 static wchar_t *normalize_ntpath(wchar_t *wbuf)
 {
@@ -479,6 +604,8 @@ int mingw_mkdir(const char *path, int mode UNUSED)
 	if (xutftowcs_path(wpath, path) < 0)
 		return -1;
 	ret = _wmkdir(wpath);
+	if (!ret)
+		process_phantom_symlinks();
 	if (!ret && needs_hiding(path))
 		return set_hidden_flag(wpath, 1);
 	return ret;
@@ -2723,6 +2850,42 @@ int symlink(const char *target, const char *link)
 		errno = err_win_to_posix(GetLastError());
 		return -1;
 	}
+
+	/* convert to directory symlink if target exists */
+	switch (process_phantom_symlink(wtarget, wlink)) {
+	case PHANTOM_SYMLINK_RETRY:	{
+		/* if target doesn't exist, add to phantom symlinks list */
+		wchar_t wfullpath[MAX_PATH];
+		struct phantom_symlink_info *psi;
+
+		/* convert to absolute path to be independent of cwd */
+		len = GetFullPathNameW(wlink, MAX_PATH, wfullpath, NULL);
+		if (!len || len >= MAX_PATH) {
+			errno = err_win_to_posix(GetLastError());
+			return -1;
+		}
+
+		/* over-allocate and fill phantom_symlink_info structure */
+		psi = xmalloc(sizeof(struct phantom_symlink_info)
+			+ sizeof(wchar_t) * (len + wcslen(wtarget) + 2));
+		psi->wlink = (wchar_t *)(psi + 1);
+		wcscpy(psi->wlink, wfullpath);
+		psi->wtarget = psi->wlink + len + 1;
+		wcscpy(psi->wtarget, wtarget);
+
+		EnterCriticalSection(&phantom_symlinks_cs);
+		psi->next = phantom_symlinks;
+		phantom_symlinks = psi;
+		LeaveCriticalSection(&phantom_symlinks_cs);
+		break;
+	}
+	case PHANTOM_SYMLINK_DIRECTORY:
+		/* if we created a dir symlink, process other phantom symlinks */
+		process_phantom_symlinks();
+		break;
+	default:
+		break;
+	}
 	return 0;
 }
 
@@ -3424,6 +3587,7 @@ int wmain(int argc, const wchar_t **wargv)
 
 	/* initialize critical section for waitpid pinfo_t list */
 	InitializeCriticalSection(&pinfo_cs);
+	InitializeCriticalSection(&phantom_symlinks_cs);
 
 	/* set up default file mode and file modes for stdin/out/err */
 	_fmode = _O_BINARY;
-- 
gitgitgadget

