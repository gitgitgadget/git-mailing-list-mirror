From: Elia Pinto <gitter.spiros@gmail.com>
Subject: [PATCH 14/15] git-am.sh: replace using expr for arithmetic operations with the equivalent shell builtin
Date: Thu,  4 Feb 2016 10:20:58 +0000
Message-ID: <1454581259-57095-1-git-send-email-gitter.spiros@gmail.com>
Cc: Elia Pinto <gitter.spiros@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Feb 04 11:21:18 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aRH2L-0002U6-Od
	for gcvg-git-2@plane.gmane.org; Thu, 04 Feb 2016 11:21:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933633AbcBDKVH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Feb 2016 05:21:07 -0500
Received: from mail-wm0-f66.google.com ([74.125.82.66]:33160 "EHLO
	mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933304AbcBDKVE (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Feb 2016 05:21:04 -0500
Received: by mail-wm0-f66.google.com with SMTP id r129so11462507wmr.0
        for <git@vger.kernel.org>; Thu, 04 Feb 2016 02:21:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=La/9od9o8YY0A6772xliWHwrzWlVsaEOVAHz9eAkVyk=;
        b=hheh7EZWBVEnfqmz9HSYutKBUFWA4P5tnPj3pX7HH7hW0iUf607SgXZkbdO7CzhajW
         ufuPOkYv67ry8/0ItEhzSFG22RMaz/TZfqVge8VKqhyUkZr0hW8i94OdMsc4sKRE46M7
         haM/dJnZOVso9yybj/N2jbbNV4QtcU83pDv8Pm4bi47hGBjssBuoNcUMe6XRZc9CWcEA
         kuRrEcDlcRpvwlsP4ht0bStgLQiRjkXYlwyvSKwgUaIURiKuRIQkqrzWOc2koRTEfnKN
         nWA2xelOWHU/ZJYUR0BdiyYfZV0lZaV9HqQIWcuXzOP+EC8N013SgV0p9++AOHxZPtDB
         Q5Aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=La/9od9o8YY0A6772xliWHwrzWlVsaEOVAHz9eAkVyk=;
        b=KOBZin5EZTxN7q/J+3axMObv5cxFUlmhqyyNnTPxxGe2IL2l7Y98AvkjF36aWRJ7rQ
         qNvsgrwOOH5QXUBI/PzXNuVqhkPD+vycU83Xut7DyGLYCt1xZI3Ht79iNpU9DT3YbKpf
         Y33xSR7r62in2fT41P9KMfjZzGMd4s2HWN3sAEXtPO9AZDrVUf0a/lwK164LOn6uWLEz
         7u8rdqvvBfhgilgo1c7X5qRcqnviIE+bfgXv8oIS2U8WI+6ADtnBdLMchewyRJ+uJpft
         K16xss1eTgbTAB9+v5GCO1UpX1kfdQGWN86cOATaR7xuDM1r+76Qovbp89sf87e3W7Vx
         XuEg==
X-Gm-Message-State: AG10YOR/q5b0E4suK5OCnqILLt87rKqViws/f4ojXcdpF5b4aXyY6fFLCxlpmR8FK7zV2w==
X-Received: by 10.28.111.10 with SMTP id k10mr21585699wmc.86.1454581263368;
        Thu, 04 Feb 2016 02:21:03 -0800 (PST)
Received: from ubuntu2pinto.pd5x2phgis1evm2itoce0l41ib.ax.internal.cloudapp.net ([40.113.119.92])
        by smtp.gmail.com with ESMTPSA id u4sm10636107wjz.4.2016.02.04.02.21.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 04 Feb 2016 02:21:02 -0800 (PST)
X-Mailer: git-send-email 2.0.0.rc3.377.gb2ff043
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/285448>

expr is considered generally antiquated. It is best to use for arithmetic operations
the shell $((..)).

To quote POSIX:

"The expr utility has a rather difficult syntax [...] In many cases, the arithmetic
and string features provided as part of the shell command language are easier to use
than their equivalents in expr. Newly written scripts should avoid expr in favor of
the new features within the shell."

Signed-off-by: Elia Pinto <gitter.spiros@gmail.com>
---
 git-am.sh | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/git-am.sh b/git-am.sh
index ee61a77..4f8148e 100755
--- a/git-am.sh
+++ b/git-am.sh
@@ -298,7 +298,7 @@ split_patches () {
 		this=0
 		for stgit in "$@"
 		do
-			this=$(expr "$this" + 1)
+			this=$(( "$this" + 1 ))
 			msgnum=$(printf "%0${prec}d" $this)
 			# Perl version of StGIT parse_patch. The first nonemptyline
 			# not starting with Author, From or Date is the
@@ -656,14 +656,14 @@ last=$(cat "$dotest/last")
 this=$(cat "$dotest/next")
 if test "$skip" = t
 then
-	this=$(expr "$this" + 1)
+	this=$(( "$this" + 1 ))
 	resume=
 fi
 
 while test "$this" -le "$last"
 do
 	msgnum=$(printf "%0${prec}d" $this)
-	next=$(expr "$this" + 1)
+	next=$(( "$this" + 1 ))
 	test -f "$dotest/$msgnum" || {
 		resume=
 		go_next
-- 
2.5.0
