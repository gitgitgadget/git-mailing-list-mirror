Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 633A81369A0
	for <git@vger.kernel.org>; Wed,  3 Apr 2024 15:42:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712158928; cv=none; b=PuOP0gpsOgxYq9/cKUXuNbwv8z397B1uh0vZSVm9vX26VMk+PYunkZTRwdBUHoNpVhph+UtfsUeAy5ZBfimCxOaQch0iWvFNv7bphIWD5r47pGj7VzhfegUNDXjLJKYIja05Dn+0Zv7p9oD3c4aoJa38uHt1aRFRspn/ymVlisY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712158928; c=relaxed/simple;
	bh=tE3kdovcm3UVJr0AqA56ntk2orLTMc55shurdjoWAvI=;
	h=Message-Id:From:Date:Subject:MIME-Version:Content-Type:To:Cc; b=KZvYidA9I70gqbdRY9QQKihPEKf0kVM7K1lsg/DA63Wb9Ri803yCyw21nUVzxQ9JJQ2gW2Gy+DJwtPA49Er3F1zByijKg6ImtYtDQNBCupYgQrqYJWlzlqPLGNtEFgGckee+8QWTNI7uiYQmQ8KD9GjpeGhAWuv3sCvLoSRGbWI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=a4cRsypq; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a4cRsypq"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-416244fd0a2so5352275e9.3
        for <git@vger.kernel.org>; Wed, 03 Apr 2024 08:42:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712158924; x=1712763724; darn=vger.kernel.org;
        h=cc:to:fcc:content-transfer-encoding:mime-version:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=VAyCFiW7Iu8paXT2D39QYQQQUepSPASuq7OeiPA+mX0=;
        b=a4cRsypqWP1ZnzuXYELl/e+svdGN8e3sR4yhShdr6YjAfy03t+bLA2lQDiWjmb1uhp
         U2wc2ATY9ePeSp9IjonA8wacma/ElXNmUtqk91PaP3Xtz12Hqe1qZYDusvLYWDr00T+5
         aaK08D3SPEz7ZnbitpoGEGUP3mbA+Pa/+5nrSbXaw3YRgGP8PxD1cuJtbIeXKCVkLFc1
         xCClvbtIVxTBafTBvUNGuE7pxD5XZFWFW8wVPKMvGBYbsjRQVKfyDIKBuozbraDAw6hs
         wQ07B9rt09zVJO+A1KQGrNs9BWi0VdOFCxMwWW3pDATWZAwPOkgcF6L4MH2p2gZvxYqd
         4znQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712158924; x=1712763724;
        h=cc:to:fcc:content-transfer-encoding:mime-version:subject:date:from
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VAyCFiW7Iu8paXT2D39QYQQQUepSPASuq7OeiPA+mX0=;
        b=ZRYXHjXO4QyDJG73FzCds+oT9IW2+O/FP+VkyKijAAawWWKNdnrfprbj5jKbWl8HrR
         tkKF2EtC7hCNnAL9NreIfnNDncwdQ3uSB9v/uTDHbNUUzFM+QEWRhTZjsFrobEY1ez/2
         AtZnC7IrbUWj8sefzJ6WhwzFSiEx5Y+PV6mESRRRZBUAt34+2l1dml2LADC7sGHlTq69
         fB3ejpjQW8kChHph0uOwgVli2veby5iTLId5Zptzl29HAhKs9nLCsvich+P8NBQaYIlN
         C601Sk6Lm50k8Y6XQva0KarfghHe4iF08EpaBQCfHlYSk3BOIC463cYerhw9yLzaObrZ
         GdwQ==
X-Gm-Message-State: AOJu0YzSNeGlK1oh7WAWvcGj1m+Z+vLVFJgsKODas2xjd+k22to2LDqI
	9rLEhL5OJ1a99m2S0Gs2igzQOBZH0L9VdSJ5cO/RimvyIteVjqnZgrepHzLR
X-Google-Smtp-Source: AGHT+IH/flJ6nZXzFyQyAihhAjzGFYMTak3I65H8f1P+s/p6q9bTGfYUoxrhJGF3U+v6hnBN8Tbh3g==
X-Received: by 2002:a05:600c:3b21:b0:415:6cf0:47c9 with SMTP id m33-20020a05600c3b2100b004156cf047c9mr10166wms.26.1712158923995;
        Wed, 03 Apr 2024 08:42:03 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id l13-20020a05600c4f0d00b004161af729f4sm6141781wmq.31.2024.04.03.08.42.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Apr 2024 08:42:03 -0700 (PDT)
Message-Id: <pull.1708.git.1712158923106.gitgitgadget@gmail.com>
From: "Matthias =?UTF-8?Q?A=C3=9Fhauer?= via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 03 Apr 2024 15:42:02 +0000
Subject: [PATCH] Win32: detect unix socket support at runtime
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
Cc: Eric Wong <e@80x24.org>,
    Leslie Cheng <leslie.cheng5@gmail.com>,
    Johannes Schindelin <Johannes.Schindelin@gmx.de>,
    M Hickford <mirth.hickford@gmail.com>,
    Carlo Marcelo Arenas =?UTF-8?Q?Bel=C3=B3n?= <carenas@gmail.com>,
    Denton Liu <liu.denton@gmail.com>,
    SZEDER =?UTF-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
    Jeff King <peff@peff.net>,
    Matthias =?UTF-8?Q?A=C3=9Fhauer?= <mha1993@live.de>,
    =?UTF-8?q?Matthias=20A=C3=9Fhauer?= <mha1993@live.de>

From: =?UTF-8?q?Matthias=20A=C3=9Fhauer?= <mha1993@live.de>

Windows 10 build 17063 introduced support for unix sockets to Windows.
bb390b1 (git-compat-util: include declaration for unix sockets in
windows, 2021-09-14) introduced a way to build git with unix socket
support on Windows, but you still had to decide at build time which
Windows version the compiled executable was supposed to run on.

We can detect at runtime wether the operating system supports unix
sockets and act accordingly for all supported Windows versions.

This fixes https://github.com/git-for-windows/git/issues/3892

Signed-off-by: Matthias Aßhauer <mha1993@live.de>
---
    Win32: detect unix socket support at runtime
    
    Microsoft recommends checking for unix socket support on the command
    line trough the sc command. [1][2]
    
    > Check whether your Windows build has support for unix socket by
    > running “sc query afunix” from a Windows admin command prompt.
    
    That command queries wether the Service afunix exists and what it's
    current status is. [2]
    
    Using OpenSCManagerA() [3], OpenServiceA() [4], QueryServiceStatusEx()
    [5] and CloseServiceHandle() [6] we can query the same information
    without spawning a new process and parsing the output.
    
    All the used APIs are available Windows XP/Server 2003. [3][4][5][6].
    They're also available on Nano Server images [7] and should thus be
    available in docker containers.
    
    A quick test with time git credential-cache exit shows a negligible
    startup penalty of 2ms.
    
    I've decided against introducing a third behaviour (disabled at compile
    time/dynamic detection/enabled at compile time), because the main
    difference would be a more cryptic error message on unsupported systems
    and the aforementioned ~2ms startup time difference.
    
    This conflicts slightly with the patch series at [8], but rebasing onto
    v2 made little sense with a v3 seemongly in the making.
    
    [1] https://devblogs.microsoft.com/commandline/af_unix-comes-to-windows/
    [2]
    https://learn.microsoft.com/en-us/windows-server/administration/windows-commands/sc-query
    [3]
    https://learn.microsoft.com/en-us/windows/win32/api/winsvc/nf-winsvc-openscmanagera
    [4]
    https://learn.microsoft.com/en-us/windows/win32/api/winsvc/nf-winsvc-openservicea
    [5]
    https://learn.microsoft.com/en-us/windows/win32/api/winsvc/nf-winsvc-queryservicestatusex
    [6]
    https://learn.microsoft.com/en-us/windows/win32/api/winsvc/nf-winsvc-closeservicehandle
    [7]
    https://learn.microsoft.com/en-us/previous-versions/windows/desktop/legacy/mt588480(v=vs.85)
    [8]
    https://lore.kernel.org/git/pull.1681.git.git.1708506863243.gitgitgadget@gmail.com/

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1708%2Frimrul%2Fwin32-unix-socket-runtime-check-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1708/rimrul/win32-unix-socket-runtime-check-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/1708

 builtin/credential-cache--daemon.c |  2 ++
 builtin/credential-cache.c         |  3 +++
 compat/mingw.c                     | 19 +++++++++++++++++++
 compat/mingw.h                     |  6 ++++++
 config.mak.uname                   |  2 --
 git-compat-util.h                  | 12 ++++++++++++
 t/t0301-credential-cache.sh        |  8 ++++++++
 7 files changed, 50 insertions(+), 2 deletions(-)

diff --git a/builtin/credential-cache--daemon.c b/builtin/credential-cache--daemon.c
index 3a6a750a8eb..17f929dede3 100644
--- a/builtin/credential-cache--daemon.c
+++ b/builtin/credential-cache--daemon.c
@@ -294,6 +294,8 @@ int cmd_credential_cache_daemon(int argc, const char **argv, const char *prefix)
 	argc = parse_options(argc, argv, prefix, options, usage, 0);
 	socket_path = argv[0];
 
+	if (!have_unix_sockets())
+		die(_("credential-cache--daemon unavailable; no unix socket support"));
 	if (!socket_path)
 		usage_with_options(usage, options);
 
diff --git a/builtin/credential-cache.c b/builtin/credential-cache.c
index bba96d4ffd6..bef120b5375 100644
--- a/builtin/credential-cache.c
+++ b/builtin/credential-cache.c
@@ -149,6 +149,9 @@ int cmd_credential_cache(int argc, const char **argv, const char *prefix)
 		usage_with_options(usage, options);
 	op = argv[0];
 
+	if (!have_unix_sockets())
+		die(_("credential-cache unavailable; no unix socket support"));
+
 	if (!socket_path)
 		socket_path = get_socket_path();
 	if (!socket_path)
diff --git a/compat/mingw.c b/compat/mingw.c
index 320fb99a90e..4876344b5b8 100644
--- a/compat/mingw.c
+++ b/compat/mingw.c
@@ -3158,3 +3158,22 @@ int uname(struct utsname *buf)
 		  "%u", (v >> 16) & 0x7fff);
 	return 0;
 }
+
+int mingw_have_unix_sockets(void)
+{
+	SC_HANDLE scm, srvc;
+	SERVICE_STATUS_PROCESS status;
+	DWORD bytes;
+	int ret = 0;
+	scm = OpenSCManagerA(NULL, NULL, SC_MANAGER_CONNECT);
+	if (scm) {
+		srvc = OpenServiceA(scm, "afunix", SERVICE_QUERY_STATUS);
+		if (srvc) {
+			if(QueryServiceStatusEx(srvc, SC_STATUS_PROCESS_INFO, (LPBYTE)&status, sizeof(SERVICE_STATUS_PROCESS), &bytes))
+				ret = status.dwCurrentState == SERVICE_RUNNING;
+			CloseServiceHandle(srvc);
+		}
+		CloseServiceHandle(scm);
+	}
+	return ret;
+}
diff --git a/compat/mingw.h b/compat/mingw.h
index 6aec50e4124..27b61284f46 100644
--- a/compat/mingw.h
+++ b/compat/mingw.h
@@ -631,3 +631,9 @@ void open_in_gdb(void);
  * Used by Pthread API implementation for Windows
  */
 int err_win_to_posix(DWORD winerr);
+
+#ifndef NO_UNIX_SOCKETS
+int mingw_have_unix_sockets(void);
+#undef have_unix_sockets
+#define have_unix_sockets mingw_have_unix_sockets
+#endif
diff --git a/config.mak.uname b/config.mak.uname
index d0dcca2ec55..fcf3e2d785a 100644
--- a/config.mak.uname
+++ b/config.mak.uname
@@ -447,7 +447,6 @@ ifeq ($(uname_S),Windows)
 	NO_POLL = YesPlease
 	NO_SYMLINK_HEAD = YesPlease
 	NO_IPV6 = YesPlease
-	NO_UNIX_SOCKETS = YesPlease
 	NO_SETENV = YesPlease
 	NO_STRCASESTR = YesPlease
 	NO_STRLCPY = YesPlease
@@ -661,7 +660,6 @@ ifeq ($(uname_S),MINGW)
 	NO_LIBGEN_H = YesPlease
 	NO_POLL = YesPlease
 	NO_SYMLINK_HEAD = YesPlease
-	NO_UNIX_SOCKETS = YesPlease
 	NO_SETENV = YesPlease
 	NO_STRCASESTR = YesPlease
 	NO_STRLCPY = YesPlease
diff --git a/git-compat-util.h b/git-compat-util.h
index 7c2a6538e5a..044f87454a2 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -218,6 +218,18 @@ struct strbuf;
 #define GIT_WINDOWS_NATIVE
 #endif
 
+#if defined(NO_UNIX_SOCKETS) || !defined(GIT_WINDOWS_NATIVE)
+static inline int _have_unix_sockets(void)
+{
+#if defined(NO_UNIX_SOCKETS)
+	return 0;
+#else
+	return 1;
+#endif
+}
+#define have_unix_sockets _have_unix_sockets
+#endif
+
 #include <unistd.h>
 #include <stdio.h>
 #include <sys/stat.h>
diff --git a/t/t0301-credential-cache.sh b/t/t0301-credential-cache.sh
index 8300faadea9..f2c146fa2a1 100755
--- a/t/t0301-credential-cache.sh
+++ b/t/t0301-credential-cache.sh
@@ -8,6 +8,14 @@ test -z "$NO_UNIX_SOCKETS" || {
 	skip_all='skipping credential-cache tests, unix sockets not available'
 	test_done
 }
+if test_have_prereq MINGW
+then
+	service_running=$(sc query afunix | grep "4  RUNNING")
+	test -z "$service_running" || {
+		skip_all='skipping credential-cache tests, unix sockets not available'
+		test_done
+	}
+fi
 
 uname_s=$(uname -s)
 case $uname_s in

base-commit: c2cbfbd2e28cbe27c194d62183b42f27a6a5bb87
-- 
gitgitgadget
