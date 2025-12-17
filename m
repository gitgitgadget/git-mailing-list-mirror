Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com [209.85.219.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 443E9397D3F
	for <git@vger.kernel.org>; Wed, 17 Dec 2025 14:09:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765980549; cv=none; b=Erx7jt/un/7H37q5SSh3daVWWpNuejt4PKT3PcQVpyIo4JEOHyiZg5suXyaf2Qrw7I4to6DqeQBwVuMAhVLzFJPbIYvy71nOdLxo9fQCPm5Lp80TFSWlnMe2f7lpHzLFdWZcl/iM7OkVE9dteyd4Cwx9Y6XV+wxGpyGFJz5LpFw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765980549; c=relaxed/simple;
	bh=aXev6TIOc/MWQfylnDhHmfXobDcGGXDmX9pwZ/nt7+E=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=pZoWmAaPx+6zGeLrPlzvmq9LETR1wpnK8z/LTzcFhXCo6gqmxKbdnaNNrIOmABHQPt4M3ygHhCBnpnAW9awusbDdycbeDaL06GmQFpdHi1rUnghKo5qLdgH7FWURxvZT0I7iE54mSUR7KXP6FSgi/jgvChixWR1+CpOM4eTujEk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kQUqVyPy; arc=none smtp.client-ip=209.85.219.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kQUqVyPy"
Received: by mail-qv1-f53.google.com with SMTP id 6a1803df08f44-88a32bf0248so29019786d6.0
        for <git@vger.kernel.org>; Wed, 17 Dec 2025 06:09:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765980546; x=1766585346; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bCHYB8vdqtqkpHqEmRwWvhJKR4ntYogsPM7PbWbh5tM=;
        b=kQUqVyPylgratq55zmL16RMm9UazLyusX69cG8Wh7NpFdzvq4lU9fqXOS6w/czb/lX
         acmTTLu13OnNDGQPXBYcVHCd55dO87MX7P12o2cLAKUDECdaehGZe5F//OoAyeCitFJo
         bJukXFgSVx9JudJfDISw+0OtdC4RBlOA4WHU86/nMJ85+lr/nDnkwXu6mfzTz/3hIgoB
         JitmxCC+viSL0Nq0EuertJyupJ6NCh2Sl5lFrK7dy9/3BZAngTxVa80kRSS++AGGBBup
         enT47fk7J8teZ+2b18orgWVGzrGNeFOqRCHbOPRB9oUksQT4cjVo2/zW1d+Kpzypdajn
         vgNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765980546; x=1766585346;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=bCHYB8vdqtqkpHqEmRwWvhJKR4ntYogsPM7PbWbh5tM=;
        b=QcgxRRJAI9Se9OlOM1fa8hvqpwhq3IXw2if4nYL0Ylx9otZY1i3pQrD37v8YbKp3vx
         RlHKPz5+K8GlkieVmTqRWpXwzr5fbsIZdPDIVFnsoaHM0tWCle43e+R4Ust/Mqt67wu9
         Sv8Lu+UJnbO8rNIBaec4QGn2h+n34xLVqMp53J7HgqAUnsKixg/8tXdQjMe9svvtu8x+
         Mub0TQJp02ZKcDtctU8Dmqc6MPp2OtbwWi3IXFTUZYXDdN2NSax2nxtNCIIhxENmjTJB
         xfFi/Nvkis9hg0AQTYqGU8v2QYK78llzxzGRzMwmpBMnCjCysrPvZIq+X8/T3yapWu27
         n/Dw==
X-Gm-Message-State: AOJu0Yx6h1EBaonxexWQ/TMpDpTN3jBeKplq06wXcviTF//jsHpalnA8
	jfJqtxsPXzyV2Pj3NS0PTUhLKgiscfZntLjzrcoVgHXVfVNxBvAzAfXCqytPQDhS
X-Gm-Gg: AY/fxX6GglV0ZoDYmujyGLyqcms7aGkRkIzfxT0qtkgSWyweF8ZCnUmN72fJ7BFxiC9
	3psHGIE9Ni+yAK7XP/MGGIo2qxxA0UgB4LokY/vshv/g+iZ6P7UT6vzf1D6+PbijEsVguXwaf3u
	j1Ex8ObqRlkovzePLaMWY/oqadS49pKMz3NyvodTZ0f3BPfJKUhaGPi/Jh99aqXFw9eN5HplIsy
	UQ5bTNOaXTyrwElnIVbBOuegROiAgKfjsn6YpdRMXojW7n8reCXTj2BNe7BDYBpWGcS1BwxC5tP
	dpFWkm6RwmmFkxfj624MXQrdYTLkTc+ZXWraFbWX0WSR8ichbFYn7vv0Wi1QSEyUVjJGN9fWzte
	hwNeb3gZuXtk1djxekUGDnTWvISyCaDckNIMY8WtowbRzkvHa4Fsj8O2JEvDdJtr5pAQO9/YSKb
	5nGGlatO7W+q0=
X-Google-Smtp-Source: AGHT+IFkDcwwJq6MpFSVF3PgrqhW/rgVXe8xVcr+psgcy0WVPIK9AykCd7e6Dpz1LKiboID/1/3R3g==
X-Received: by 2002:a05:6214:4611:b0:88a:442c:2988 with SMTP id 6a1803df08f44-88a442c2afcmr90962636d6.6.1765980545228;
        Wed, 17 Dec 2025 06:09:05 -0800 (PST)
Received: from [127.0.0.1] ([48.214.53.69])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-889a85eab16sm94883706d6.39.2025.12.17.06.09.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Dec 2025 06:09:04 -0800 (PST)
Message-Id: <ad74d540f2f6bd19f248606e29ae45d226c264f9.1765980535.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2018.git.1765980535.gitgitgadget@gmail.com>
References: <pull.2018.git.1765980535.gitgitgadget@gmail.com>
From: "Karsten Blees via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 17 Dec 2025 14:08:44 +0000
Subject: [PATCH 07/18] mingw: factor out the retry logic
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

In several places, Git's Windows-specific code follows the pattern where
it tries to perform an operation, and retries several times when that
operation fails, sleeping an increasing amount of time, before finally
giving up and asking the user whether to rety (after, say, closing an
editor that held a handle to a file, preventing the operation from
succeeding).

This logic is a bit hard to use, and inconsistent:
`mingw_unlink()` and `mingw_rmdir()` duplicate the code to retry,
and both of them do so incompletely. They also do not restore `errno` if the
user answers 'no'.

Introduce a `retry_ask_yes_no()` helper function that handles retry with
small delay, asking the user, and restoring `errno`.

Note that in `mingw_unlink()`, we include the `_wchmod()` call in the
retry loop (which may fail if the file is locked exclusively).

In `mingw_rmdir()`, we include special error handling in the retry loop.

Signed-off-by: Karsten Blees <blees@dcon.de>
Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 compat/mingw.c | 104 ++++++++++++++++++++++---------------------------
 1 file changed, 46 insertions(+), 58 deletions(-)

diff --git a/compat/mingw.c b/compat/mingw.c
index c7571951dc..26e64c6a5a 100644
--- a/compat/mingw.c
+++ b/compat/mingw.c
@@ -28,8 +28,6 @@
 
 #define HCAST(type, handle) ((type)(intptr_t)handle)
 
-static const int delay[] = { 0, 1, 10, 20, 40 };
-
 void open_in_gdb(void)
 {
 	static struct child_process cp = CHILD_PROCESS_INIT;
@@ -205,15 +203,12 @@ static int read_yes_no_answer(void)
 	return -1;
 }
 
-static int ask_yes_no_if_possible(const char *format, ...)
+static int ask_yes_no_if_possible(const char *format, va_list args)
 {
 	char question[4096];
 	const char *retry_hook;
-	va_list args;
 
-	va_start(args, format);
 	vsnprintf(question, sizeof(question), format, args);
-	va_end(args);
 
 	retry_hook = mingw_getenv("GIT_ASK_YESNO");
 	if (retry_hook) {
@@ -238,6 +233,31 @@ static int ask_yes_no_if_possible(const char *format, ...)
 	}
 }
 
+static int retry_ask_yes_no(int *tries, const char *format, ...)
+{
+	static const int delay[] = { 0, 1, 10, 20, 40 };
+	va_list args;
+	int result, saved_errno = errno;
+
+	if ((*tries) < ARRAY_SIZE(delay)) {
+		/*
+		 * We assume that some other process had the file open at the wrong
+		 * moment and retry. In order to give the other process a higher
+		 * chance to complete its operation, we give up our time slice now.
+		 * If we have to retry again, we do sleep a bit.
+		 */
+		Sleep(delay[*tries]);
+		(*tries)++;
+		return 1;
+	}
+
+	va_start(args, format);
+	result = ask_yes_no_if_possible(format, args);
+	va_end(args);
+	errno = saved_errno;
+	return result;
+}
+
 /* Windows only */
 enum hide_dotfiles_type {
 	HIDE_DOTFILES_FALSE = 0,
@@ -298,7 +318,7 @@ static wchar_t *normalize_ntpath(wchar_t *wbuf)
 
 int mingw_unlink(const char *pathname, int handle_in_use_error)
 {
-	int ret, tries = 0;
+	int tries = 0;
 	wchar_t wpathname[MAX_PATH];
 	if (xutftowcs_path(wpathname, pathname) < 0)
 		return -1;
@@ -306,29 +326,19 @@ int mingw_unlink(const char *pathname, int handle_in_use_error)
 	if (DeleteFileW(wpathname))
 		return 0;
 
-	/* read-only files cannot be removed */
-	_wchmod(wpathname, 0666);
-	while ((ret = _wunlink(wpathname)) == -1 && tries < ARRAY_SIZE(delay)) {
+	do {
+		/* read-only files cannot be removed */
+		_wchmod(wpathname, 0666);
+		if (!_wunlink(wpathname))
+			return 0;
 		if (!is_file_in_use_error(GetLastError()))
 			break;
 		if (!handle_in_use_error)
-			return ret;
+			return -1;
 
-		/*
-		 * We assume that some other process had the source or
-		 * destination file open at the wrong moment and retry.
-		 * In order to give the other process a higher chance to
-		 * complete its operation, we give up our time slice now.
-		 * If we have to retry again, we do sleep a bit.
-		 */
-		Sleep(delay[tries]);
-		tries++;
-	}
-	while (ret == -1 && is_file_in_use_error(GetLastError()) &&
-	       ask_yes_no_if_possible("Unlink of file '%s' failed. "
-			"Should I try again?", pathname))
-	       ret = _wunlink(wpathname);
-	return ret;
+	} while (retry_ask_yes_no(&tries, "Unlink of file '%s' failed. "
+			"Should I try again?", pathname));
+	return -1;
 }
 
 static int is_dir_empty(const wchar_t *wpath)
@@ -355,7 +365,7 @@ static int is_dir_empty(const wchar_t *wpath)
 
 int mingw_rmdir(const char *pathname)
 {
-	int ret, tries = 0;
+	int tries = 0;
 	wchar_t wpathname[MAX_PATH];
 	struct stat st;
 
@@ -381,7 +391,11 @@ int mingw_rmdir(const char *pathname)
 	if (xutftowcs_path(wpathname, pathname) < 0)
 		return -1;
 
-	while ((ret = _wrmdir(wpathname)) == -1 && tries < ARRAY_SIZE(delay)) {
+	do {
+		if (!_wrmdir(wpathname)) {
+			invalidate_lstat_cache();
+			return 0;
+		}
 		if (!is_file_in_use_error(GetLastError()))
 			errno = err_win_to_posix(GetLastError());
 		if (errno != EACCES)
@@ -390,23 +404,9 @@ int mingw_rmdir(const char *pathname)
 			errno = ENOTEMPTY;
 			break;
 		}
-		/*
-		 * We assume that some other process had the source or
-		 * destination file open at the wrong moment and retry.
-		 * In order to give the other process a higher chance to
-		 * complete its operation, we give up our time slice now.
-		 * If we have to retry again, we do sleep a bit.
-		 */
-		Sleep(delay[tries]);
-		tries++;
-	}
-	while (ret == -1 && errno == EACCES && is_file_in_use_error(GetLastError()) &&
-	       ask_yes_no_if_possible("Deletion of directory '%s' failed. "
-			"Should I try again?", pathname))
-	       ret = _wrmdir(wpathname);
-	if (!ret)
-		invalidate_lstat_cache();
-	return ret;
+	} while (retry_ask_yes_no(&tries, "Deletion of directory '%s' failed. "
+			"Should I try again?", pathname));
+	return -1;
 }
 
 static inline int needs_hiding(const char *path)
@@ -2384,20 +2384,8 @@ repeat:
 			SetFileAttributesW(wpnew, attrs);
 		}
 	}
-	if (tries < ARRAY_SIZE(delay) && gle == ERROR_ACCESS_DENIED) {
-		/*
-		 * We assume that some other process had the source or
-		 * destination file open at the wrong moment and retry.
-		 * In order to give the other process a higher chance to
-		 * complete its operation, we give up our time slice now.
-		 * If we have to retry again, we do sleep a bit.
-		 */
-		Sleep(delay[tries]);
-		tries++;
-		goto repeat;
-	}
 	if (gle == ERROR_ACCESS_DENIED &&
-	       ask_yes_no_if_possible("Rename from '%s' to '%s' failed. "
+	       retry_ask_yes_no(&tries, "Rename from '%s' to '%s' failed. "
 		       "Should I try again?", pold, pnew))
 		goto repeat;
 
-- 
gitgitgadget

