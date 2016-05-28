From: =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Subject: [PATCH v2 4/8] xdiff: ignore empty lines before added functions with
 -W
Date: Sat, 28 May 2016 17:02:24 +0200
Message-ID: <5749B300.3000804@web.de>
References: <xmqqh9e5mvjs.fsf@gitster.mtv.corp.google.com>
 <xmqq4ma5msrd.fsf@gitster.mtv.corp.google.com> <5740AC28.6010202@web.de>
 <5749AF59.2070704@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: 7bit
Cc: Ramsay Jones <ramsay@ramsayjones.plus.com>
To: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat May 28 17:02:39 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b6fl8-0005mC-Am
	for gcvg-git-2@plane.gmane.org; Sat, 28 May 2016 17:02:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752894AbcE1PCe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 28 May 2016 11:02:34 -0400
Received: from mout.web.de ([212.227.15.3]:58594 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752852AbcE1PCd (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 28 May 2016 11:02:33 -0400
Received: from [192.168.178.36] ([79.213.120.97]) by smtp.web.de (mrweb004)
 with ESMTPSA (Nemesis) id 0MQ8vL-1bBKKI25rv-005E8G; Sat, 28 May 2016 17:02:25
 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:38.0) Gecko/20100101
 Thunderbird/38.7.2
In-Reply-To: <5749AF59.2070704@web.de>
X-Provags-ID: V03:K0:tS5XKBBbftuGD5PIcke1NcNMv2m8Vb1ghpREqHue5T7cRBsk+3L
 7fV3fymtIfdddBwZKCFF+Q8VvGpfBeXLGqOmrrMQ7cfW02Xgk3Meaf8jahspe2H2erTOdb7
 fcKxahTAKh8r6agKFk5Gm6SshNC9Lup/6fvVF5iiOs1nvxhNok3qHLALj5LfjjjxgqNHuxp
 E/N0+HWcvLia0zsZNtXxg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:OK28fD2qWII=:0I6sBZu6PFjHAYFbGD+S0g
 Fg7r9lcBaG8RatNMrq15O5zk3kYA/eSaMCLqcDbdQmxh4jt7gWhRWOEa9XgXS7JYz995FxMRM
 5tWiJUUAiH3IWySDb5PxYxzFRoIUynWBmEFqes60BEQb7C5jd57SJrE7VKmmLTxhT16D+hkND
 q3wuj2HVL+6PzPCwKWwVcn5doa/QDovs89CxkhFoeS+6NTXNz13/NyV7oHwQNvjVq9A2oO2zR
 lXxNwsCE/WQFo6k30OqZ2sl9bMO2nv+VQuADTgUnTlkL7Y3LUdKttz4jYxKQlANYdl4AHyLE8
 EL+/dj1jXjcjKAACrTrsjEQc/xIDh7xlFuoNZa5oyUaUqI8xucO+IbG9pOK9b1Xh6jKZDlB+q
 sNiGncyQNsk7DfODKl9lgueEeMViEg9US4Bx5OnQNJrqka8mPiqkA6TO4e1jZBr6KR3FX+DB/
 uh5n81BxejHGuWWB7FWOQsS6yLLQf+Pv3AHctI9Ir0UH5L5eauGjjPopxrUwhtqBhjzCyEVvl
 WKu5fLmxEyJ5shno5Np3fF0wtxg6kaNve2jjBVzvohL47M+Z0zBMeO/ZjLvBiGeL0k0Cssgvq
 A2/y8IFJlkM/BNU/H3MfiREXX7iI6GSHTvQjg3mQMYAIZh24lXswh7gkSetq92vEo7TmbZPqC
 SIS7SGlbgGxeJP/5IOZTQCs6IkLUKFUfC9lC4iFDyg9Nax3K3OWFwLEETrBVIUFUm+HxkkG9H
 V+TNBq8svUlnA1P9Yf6lh9drgvC0QCvCdbfADavUInyTApJMwpIDaisJ9Iww77FcLOyuxklv 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/295821>

If a new function and a preceding empty line is appended, diff -W shows
the previous function in full in order to provide context for that empty
line.  In most languages empty lines between sections are not
interesting in and off themselves and showing a whole extra function for
them is not what we want.

Skip empty lines when checking of the appended chunk starts with a
function line, thereby avoiding to extend the context just for them.

Helped-by: Ramsay Jones <ramsay@ramsayjones.plus.com>
Signed-off-by: Rene Scharfe <l.s.r@web.de>
---
 t/t4051-diff-function-context.sh |  2 +-
 xdiff/xemit.c                    | 22 ++++++++++++++++++++--
 2 files changed, 21 insertions(+), 3 deletions(-)

diff --git a/t/t4051-diff-function-context.sh b/t/t4051-diff-function-context.sh
index d78461d..b191c655 100755
--- a/t/t4051-diff-function-context.sh
+++ b/t/t4051-diff-function-context.sh
@@ -117,7 +117,7 @@ test_expect_success ' context includes end' '
 	grep "^[+].*End of first part" appended.diff
 '
 
-test_expect_failure ' context does not include other functions' '
+test_expect_success ' context does not include other functions' '
 	test $(grep -c "^[ +-].*Begin" appended.diff) -le 1
 '
 
diff --git a/xdiff/xemit.c b/xdiff/xemit.c
index 969100d..29cec12 100644
--- a/xdiff/xemit.c
+++ b/xdiff/xemit.c
@@ -155,6 +155,18 @@ static long get_func_line(xdfenv_t *xe, xdemitconf_t const *xecfg,
 	return -1;
 }
 
+static int is_empty_rec(xdfile_t *xdf, long ri)
+{
+	const char *rec;
+	long len = xdl_get_rec(xdf, ri, &rec);
+
+	while (len > 0 && XDL_ISSPACE(*rec)) {
+		rec++;
+		len--;
+	}
+	return !len;
+}
+
 int xdl_emit_diff(xdfenv_t *xe, xdchange_t *xscr, xdemitcb_t *ecb,
 		  xdemitconf_t const *xecfg) {
 	long s1, s2, e1, e2, lctx;
@@ -176,12 +188,18 @@ int xdl_emit_diff(xdfenv_t *xe, xdchange_t *xscr, xdemitcb_t *ecb,
 			/* Appended chunk? */
 			if (i1 >= xe->xdf1.nrec) {
 				char dummy[1];
+				long i2 = xch->i2;
 
 				/*
 				 * We don't need additional context if
-				 * a whole function was added.
+				 * a whole function was added, possibly
+				 * starting with empty lines.
 				 */
-				if (match_func_rec(&xe->xdf2, xecfg, xch->i2,
+				while (i2 < xe->xdf2.nrec &&
+				       is_empty_rec(&xe->xdf2, i2))
+					i2++;
+				if (i2 < xe->xdf2.nrec &&
+				    match_func_rec(&xe->xdf2, xecfg, i2,
 						   dummy, sizeof(dummy)) >= 0)
 					goto post_context_calculation;
 
-- 
2.8.3
