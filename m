Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 503351FD99
	for <e@80x24.org>; Fri, 19 Aug 2016 08:39:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754158AbcHSIjs (ORCPT <rfc822;e@80x24.org>);
        Fri, 19 Aug 2016 04:39:48 -0400
Received: from mout.gmx.net ([212.227.17.21]:57017 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753410AbcHSIjp (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 19 Aug 2016 04:39:45 -0400
Received: from virtualbox ([37.24.141.212]) by mail.gmx.com (mrgmx101) with
 ESMTPSA (Nemesis) id 0MWgND-1bgyzR3P0l-00XphF; Fri, 19 Aug 2016 10:39:38
 +0200
Date:   Fri, 19 Aug 2016 10:39:38 +0200 (CEST)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>,
        Ralf Thielow <ralf.thielow@gmail.com>
Subject: [PATCH] Revert "display HTML in default browser using Windows' shell
 API"
Message-ID: <03ae6a9d47cb95a54960bfdc90c5392f890ff1e3.1471595956.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:hTGr8rAttv4Tr/x0XVyJMvWmaC1i8YMrkDG2u1mh2cV1LoKk8lz
 fTDWdAlRPPwoV/9llMXg0kng2k/l955BnRUlBEiuqDLbiSQtZ6itZ132Eh35ah30vatbsVH
 2isKmZTmhEuS0gxeUERcSAkmkZiwgCrM6iUqWvEmsniWLJtSq0pN0FopjjvyOEgADlB+uyH
 wbOTfLWbE9e5w6g4yTywg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:N1eGW/kBJMM=:6IGmfsXQ/kORjYp475yDNJ
 vRsnwgJpleVWO/UcOvVnsgDmvpyUF650wNE00D1pmx+Pv59Bg7GZKJvbauR1Evkkh3IHmTzlS
 KYcJMocFqGuTdaU4ElEQyEROcVNPjFHbKpMP+G3fbQViLWISAqJF46MWm5o/IRy8pux3Z4pbP
 FH4xyLlTk99DprsjgywqYMM22/8pRg7veQJBqPQXWCMbe1e5OOS4+Js6FdpKKlQ4qXZiDkD/w
 b8+0HUEPVOwSK3GkXyueDnieCI55q5lu8BuYQlyukN45tl/xfLdaMj8ye5trmDlaG244n/Qdc
 6sGnseIiKHeZTv94PQWjH5xUa74RD5Undzc12evveN66OwUVzUrLgo/ascV9NBH97GndjDJ6O
 /l2zk8f3fwvFlR6yoXDjQW28QRIh3F53OFpRSxQy5oMB/zSRFpuUXaDYQK306cEaEgJnnXA+x
 kfLel4aaOnfPLHx+UQavmS+b7l9OZkl1xy7ZLjkxSqAhO2XXk3u/Sq3U6ZKL7CJEaqSCDO46X
 bzlWIKmkuBugD8yOkdEkA5mQYEmKYq9vdcTsZmlzFBQdluzh2eZ2cCFLSHl+/WB25ENBaNsHV
 4FmqrgS0upnZ6B7oxnWoLkrUvIMCioRoY6yRUKnhtwn/p4ZCZ+uengbsmq7V4xFrNwFnqJrsE
 BJ7XvnH2k0XcGIVA+feKgC/OS/ip52eDDngmUs7ttoUWSV3lZPTtLudFR2bbubFz2Fkr15u9d
 Pm0dxSwu0PmItC0JUsGft5Dx9OsNgkz3cY8GvBt40z529hGDtLMN4ZnuUJCz9yhRG2Dn2kX2j
 97AQ/dL
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Since 4804aab (help (Windows): Display HTML in default browser using
Windows' shell API, 2008-07-13), Git for Windows used to call
`ShellExecute()` to launch the default Windows handler for `.html`
files.

The idea was to avoid going through a shell script, for performance
reasons.

However, this change ignores the `help.browser` config setting. Together
with browsing help not being a performance-critical operation, let's
just revert that patch.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
Published-As: https://github.com/dscho/git/releases/tag/mingw-help-v1
Fetch-It-Via: git fetch https://github.com/dscho/git mingw-help-v1

 builtin/help.c |  7 -------
 compat/mingw.c | 42 ------------------------------------------
 compat/mingw.h |  3 ---
 3 files changed, 52 deletions(-)

diff --git a/builtin/help.c b/builtin/help.c
index 8848013..e8f79d7 100644
--- a/builtin/help.c
+++ b/builtin/help.c
@@ -379,17 +379,10 @@ static void get_html_page_path(struct strbuf *page_path, const char *page)
 	free(to_free);
 }
 
-/*
- * If open_html is not defined in a platform-specific way (see for
- * example compat/mingw.h), we use the script web--browse to display
- * HTML.
- */
-#ifndef open_html
 static void open_html(const char *path)
 {
 	execl_git_cmd("web--browse", "-c", "help.browser", path, (char *)NULL);
 }
-#endif
 
 static void show_html_page(const char *git_cmd)
 {
diff --git a/compat/mingw.c b/compat/mingw.c
index 2b5467d..3fbfda5 100644
--- a/compat/mingw.c
+++ b/compat/mingw.c
@@ -1930,48 +1930,6 @@ int mingw_raise(int sig)
 	}
 }
 
-
-static const char *make_backslash_path(const char *path)
-{
-	static char buf[PATH_MAX + 1];
-	char *c;
-
-	if (strlcpy(buf, path, PATH_MAX) >= PATH_MAX)
-		die("Too long path: %.*s", 60, path);
-
-	for (c = buf; *c; c++) {
-		if (*c == '/')
-			*c = '\\';
-	}
-	return buf;
-}
-
-void mingw_open_html(const char *unixpath)
-{
-	const char *htmlpath = make_backslash_path(unixpath);
-	typedef HINSTANCE (WINAPI *T)(HWND, const char *,
-			const char *, const char *, const char *, INT);
-	T ShellExecute;
-	HMODULE shell32;
-	int r;
-
-	shell32 = LoadLibrary("shell32.dll");
-	if (!shell32)
-		die("cannot load shell32.dll");
-	ShellExecute = (T)GetProcAddress(shell32, "ShellExecuteA");
-	if (!ShellExecute)
-		die("cannot run browser");
-
-	printf("Launching default browser to display HTML ...\n");
-	r = HCAST(int, ShellExecute(NULL, "open", htmlpath,
-				NULL, "\\", SW_SHOWNORMAL));
-	FreeLibrary(shell32);
-	/* see the MSDN documentation referring to the result codes here */
-	if (r <= 32) {
-		die("failed to launch browser for %.*s", MAX_PATH, unixpath);
-	}
-}
-
 int link(const char *oldpath, const char *newpath)
 {
 	typedef BOOL (WINAPI *T)(LPCWSTR, LPCWSTR, LPSECURITY_ATTRIBUTES);
diff --git a/compat/mingw.h b/compat/mingw.h
index 95e128f..2cadb81 100644
--- a/compat/mingw.h
+++ b/compat/mingw.h
@@ -417,9 +417,6 @@ int mingw_offset_1st_component(const char *path);
 #include <inttypes.h>
 #endif
 
-void mingw_open_html(const char *path);
-#define open_html mingw_open_html
-
 /**
  * Converts UTF-8 encoded string to UTF-16LE.
  *
-- 
2.9.2.691.g78954f3

base-commit: d63263a4dee8fc7da9b97bbdedf9c0d1f33024d4
