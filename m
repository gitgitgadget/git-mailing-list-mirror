From: Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: [PATCH v2 5/5] compat/winansi: support compiling with MSys2
Date: Thu, 14 Jan 2016 17:52:02 +0100 (CET)
Message-ID: <42e165cf0cfd5791136c719e5c4fa3e5755b3580.1452790142.git.johannes.schindelin@gmx.de>
References: <cover.1452691805.git.johannes.schindelin@gmx.de> <cover.1452790142.git.johannes.schindelin@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jan 14 17:52:21 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aJl8F-0005CH-IO
	for gcvg-git-2@plane.gmane.org; Thu, 14 Jan 2016 17:52:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753995AbcANQwP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 14 Jan 2016 11:52:15 -0500
Received: from mout.gmx.net ([212.227.17.22]:49564 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751941AbcANQwN (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Jan 2016 11:52:13 -0500
Received: from virtualbox ([37.24.143.74]) by mail.gmx.com (mrgmx102) with
 ESMTPSA (Nemesis) id 0MVJze-1agGc92uVi-00YlXI; Thu, 14 Jan 2016 17:52:03
 +0100
X-X-Sender: virtualbox@virtualbox
In-Reply-To: <cover.1452790142.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
X-Provags-ID: V03:K0:yyVfcdccCHQR+D0Nn1IiUMOGz8JbD34gdRPOdCRYe7QjsYai9ss
 c5VLI42Uhl4HxI+XY8rIW87FSQNthOJ5sMOMGcY2bB4IbHvKUhWks+j6hXO1l84fJgQnYil
 +2/oh8V514kLj0kyJ0Gc7Dxwgq4xJO8BfQl9aGL85GaO4EiD4NY51P56vVDvtg8Pf6Aif9o
 22GcaUTD0qXzmQQGbQrcA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:F8ey9/oBAts=:VZpS2a0d4UJnnv25rxzRIC
 Y4fSsPQjG+r6jJhgxuif3CZnhee/bvpobC0jRWEC4B1q+nVoZ5bzvXjdFmO91gXfETxCmwwc7
 98lUIL7u99DevKDKBDY9++lV/EZTJ8uo4U95hnCUECEq5CzyT8zFWHUAgkWFmC2w5kBu1RmlE
 JZsgDUorZSM42mz2sE+HxQ2+uymfW3+ClBlTT7qVhrOVmsFkAAWa++odlIdfGYR9owIrZTwQj
 aq/BwpZuAPP5l6d+rDyer0Y6okNUfNF8ltAFHVleH5wmdJJJxcReWoDnLyx7Bk8hHN/CV7yNA
 yAWKlL/lqYT8Bfr6LthX9+gcNhvLbsFAF17IlFR5pXb4ao/8BMEcfdoBqNChRhWKi65cuqDib
 I4GG7BPSDy1B0kTwEZlqEwkPB+JzxaogFQ4WYl+ErX0msM7U1I21GNKB2VNlL9Uwg0LZMdDkE
 UGMeBmvIPT302d1dm4nVTIi5rccqV+NT26pJgAJYveIXsxvIB0PzWI2J/6zwH764XEDuZdn/g
 rJmZLUni985f8UMPGT0de0eSLnjlra/TAJKCTEADYPZlfBDeU9XbVkoZX2u0BqaqFVKCTs7gK
 /D+d2eHwk4BtU4uW7BoccPTetvhZ3Tj8kYNl9aolHkttyx639QQwljuH3GZj3nck32uaU3EqO
 TX6wfxG3qD8m42uOKWWsArXPWbnFmaYaEHkLOTu5TjDT3Kla9LfyDLqT6lDDRKXbYILTJNSGV
 R7IX7qOIf6pU28jLRmgdx5ihu8yNy/9bYAuOhS6pX/W5gN7JwtrY4o3j4ktNMQxzsHYYx9K2 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/284064>

MSys2 already defines the _CONSOLE_FONT_INFOEX structure.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 compat/winansi.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/compat/winansi.c b/compat/winansi.c
index ceff55b..3aa5535 100644
--- a/compat/winansi.c
+++ b/compat/winansi.c
@@ -23,6 +23,7 @@ static HANDLE hthread, hread, hwrite;
 static HANDLE hconsole1, hconsole2;
 
 #ifdef __MINGW32__
+#if !defined(__MINGW64_VERSION_MAJOR) || __MINGW64_VERSION_MAJOR < 5
 typedef struct _CONSOLE_FONT_INFOEX {
 	ULONG cbSize;
 	DWORD nFont;
@@ -32,6 +33,7 @@ typedef struct _CONSOLE_FONT_INFOEX {
 	WCHAR FaceName[LF_FACESIZE];
 } CONSOLE_FONT_INFOEX, *PCONSOLE_FONT_INFOEX;
 #endif
+#endif
 
 typedef BOOL (WINAPI *PGETCURRENTCONSOLEFONTEX)(HANDLE, BOOL,
 		PCONSOLE_FONT_INFOEX);
-- 
2.7.0.windows.1.7.g55a05c8
