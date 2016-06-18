Return-Path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D3FD420189
	for <e@80x24.org>; Sat, 18 Jun 2016 12:38:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751129AbcFRMiu (ORCPT <rfc822;e@80x24.org>);
	Sat, 18 Jun 2016 08:38:50 -0400
Received: from mout.gmx.net ([212.227.15.18]:60596 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750879AbcFRMiu (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 18 Jun 2016 08:38:50 -0400
Received: from virtualbox ([37.24.143.84]) by mail.gmx.com (mrgmx003) with
 ESMTPSA (Nemesis) id 0LoEPJ-1btw3w3MQD-00gDvA; Sat, 18 Jun 2016 14:38:37
 +0200
Date:	Sat, 18 Jun 2016 14:38:36 +0200 (CEST)
From:	Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:	git@vger.kernel.org
cc:	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH] mingw: let the build succeed with DEVELOPER=1
Message-ID: <200865f29df65ccc53ed76029c7f38578430e487.1466253284.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:Ugwl6G/ytWF6c1tt6IJL6VAYZ/RebUFqpWdQHBxh4HRNJfZ4v/6
 sJHEbhtYxWGlNNh1MY1IMni8zQdZ3VPEUBlievPpR8kgsSlvKQMxzUK/AEueyVuOU5ScdIS
 EH/ptqy0WzWpCWqCo5/ttx1NaC+tLv0SI1v1kS/4mppNZ1WyKEZXoOwqxcBnOPGCktiRKc7
 veS9yJi+y9sDgwL/2LkuQ==
X-UI-Out-Filterresults:	notjunk:1;V01:K0:pr12xItv1w4=:VJQwod/Er8678k8SLq8ia7
 yCWr7ue+K7h99PvHhf+qzYe57KoGhL3lvPuhj49J7T3cqfOJcZoOb/R3EF/n6iTglIrkcvN7i
 HtOvU3jZ6GOiX9CvUUbEBJMWvSl1lKRTvNneTMPr1CiovD89iiITaEyG2oSp4Y2vQ1hBPRefw
 aZ195OTjJYE3IaC0wtuSnxZvmByTC0Y9fZqavktqVkHFrd+iayTIhXscQi805HqWgZll/YS52
 1B4xDZPITGQUmUwxGWtBXg6j8/EzL/a+YByvKYXAQq4zx71dF+j2b4dR9bdGK1LaqkSfHSgGv
 S31A/R9qN5z07NsaxHOlP9PHNsMLfCEV3IzP0AIn1KtiYlT2r6YJf6A7kmyB//leiHvz6sRus
 9ZWj6r30s6kE4QqXiUGnLjoxEUDrOvSM+yqK0F15mUdz598IGyaLLzlggOCxMqYmkZaXk+7IH
 xvfedw7bZOLdwYIf9PY1oHOojmbt7fyoevw8sdGjpz2lyjjAvYAHK7tjbDvUMuDDUng0KBigR
 c+mluU/ry6Wq8HprlcLROXwkFSmE4bYYKSk9gSaN27WEtc/pll2P0ZLKat+49Pffu95H+M2n8
 phPJaG8igBjQtTJKQB9h5XYZk6qClL3PA5TywTpT8ygs6m7ozN1+s2Iz1tS1Y8YphozDIsPh8
 vXnnQkpYuU1WEQZpeqdIGcgogn+3+aNSFpbNHO+Wlo+U3Fg+nvu9cI5DSHlK3Ad0ravzqagwt
 zb0eE0debB8bLQXzayQxO4dhxJe15bClcbl7Ui7Kk24SHdxqcOiqiFSebB5C+Ups4QPWf8q34
 l936LZT
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

The recently introduced developer flags identified a couple of
old-style function declarations in the Windows-specific code where
the parameter list was left empty instead of specifying "void"
explicitly. Let's just fix them.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---

	This came up when working on the rebase--helper changes.

Published-As: https://github.com/dscho/git/releases/tag/mingw-dev-flags-v1
 compat/mingw.c   | 6 +++---
 compat/mingw.h   | 4 ++--
 compat/winansi.c | 2 +-
 3 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/compat/mingw.c b/compat/mingw.c
index a8218e6..2b5467d 100644
--- a/compat/mingw.c
+++ b/compat/mingw.c
@@ -2162,7 +2162,7 @@ int xwcstoutf(char *utf, const wchar_t *wcs, size_t utflen)
 	return -1;
 }
 
-static void setup_windows_environment()
+static void setup_windows_environment(void)
 {
 	char *tmp = getenv("TMPDIR");
 
@@ -2204,7 +2204,7 @@ typedef struct {
 extern int __wgetmainargs(int *argc, wchar_t ***argv, wchar_t ***env, int glob,
 		_startupinfo *si);
 
-static NORETURN void die_startup()
+static NORETURN void die_startup(void)
 {
 	fputs("fatal: not enough memory for initialization", stderr);
 	exit(128);
@@ -2224,7 +2224,7 @@ static char *wcstoutfdup_startup(char *buffer, const wchar_t *wcs, size_t len)
 	return memcpy(malloc_startup(len), buffer, len);
 }
 
-void mingw_startup()
+void mingw_startup(void)
 {
 	int i, maxlen, argc;
 	char *buffer;
diff --git a/compat/mingw.h b/compat/mingw.h
index 69bb43d..9a8803b 100644
--- a/compat/mingw.h
+++ b/compat/mingw.h
@@ -532,8 +532,8 @@ extern CRITICAL_SECTION pinfo_cs;
  * A replacement of main() that adds win32 specific initialization.
  */
 
-void mingw_startup();
-#define main(c,v) dummy_decl_mingw_main(); \
+void mingw_startup(void);
+#define main(c,v) dummy_decl_mingw_main(void); \
 static int mingw_main(c,v); \
 int main(int argc, char **argv) \
 { \
diff --git a/compat/winansi.c b/compat/winansi.c
index 3be60ce..db4a5b0 100644
--- a/compat/winansi.c
+++ b/compat/winansi.c
@@ -492,7 +492,7 @@ static inline ioinfo* _pioinfo(int fd)
 			(fd & (IOINFO_ARRAY_ELTS - 1)) * sizeof_ioinfo);
 }
 
-static int init_sizeof_ioinfo()
+static int init_sizeof_ioinfo(void)
 {
 	int istty, wastty;
 	/* don't init twice */
-- 
2.9.0.119.gb7b8d21

base-commit: 05219a1276341e72d8082d76b7f5ed394b7437a4
