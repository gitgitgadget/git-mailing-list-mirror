From: Elia Pinto <gitter.spiros@gmail.com>
Subject: [PATCH 007/144] git-web--browse.sh: use the $( ... ) construct for command substitution
Date: Tue, 25 Mar 2014 01:24:12 -0700
Message-ID: <1395735989-3396-8-git-send-email-gitter.spiros@gmail.com>
References: <1395735989-3396-1-git-send-email-gitter.spiros@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Elia Pinto <gitter.spiros@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Mar 25 09:27:04 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WSMhK-0006r1-3o
	for gcvg-git-2@plane.gmane.org; Tue, 25 Mar 2014 09:27:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753649AbaCYI0p convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 25 Mar 2014 04:26:45 -0400
Received: from mail-pa0-f46.google.com ([209.85.220.46]:58952 "EHLO
	mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753624AbaCYI0o (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 25 Mar 2014 04:26:44 -0400
Received: by mail-pa0-f46.google.com with SMTP id kp14so122929pab.33
        for <git@vger.kernel.org>; Tue, 25 Mar 2014 01:26:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=9ZqejgkFpZAhcvBCpVfvB15BMEGesCE8lY2DE/L4LPg=;
        b=W5Oq+ZtURdERku0TGmJfLC7BiLxEEk9kmr8lPkaK9qYev3UVg5fZ5dglJLmThEaztX
         lm9A1tqti09LTx94JtcNoWYvuYjyazR/nde5GZiGE8EaCLJAioRDmlp/yVALcJ5FpxCI
         Cm/8WD+uWsLBSf+2m2n7TA/bKcBfBVEOV87EUdOfm8RMx6XorQEZgmdPE9D9vOyaBh1z
         +d+F3ZnyGz3Xd7dC6wB9rotmvqBQJCbyVV8YRGcTM6ffa/RB/7ZS7uKHaWe21wrn6JBU
         8l1eIb5vs+beKknU6NkfRjBnk6arNsKIPKB7KsyltbRYDqldeAPNftkBzNo5D4KzLgN+
         Ai6A==
X-Received: by 10.66.164.36 with SMTP id yn4mr76839202pab.25.1395736003402;
        Tue, 25 Mar 2014 01:26:43 -0700 (PDT)
Received: from devzero2000ubu.nephoscale.com (140.195.207.67.nephoscale.net. [67.207.195.140])
        by mx.google.com with ESMTPSA id pr4sm41327198pbb.53.2014.03.25.01.26.42
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Tue, 25 Mar 2014 01:26:42 -0700 (PDT)
X-Mailer: git-send-email 1.7.10.4
In-Reply-To: <1395735989-3396-1-git-send-email-gitter.spiros@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/244911>

The Git CodingGuidelines prefer the $( ... ) construct for command
substitution instead of using the back-quotes, or grave accents (`..`).

The backquoted form is the historical method for command substitution,
and is supported by POSIX. However,all but the simplest uses become
complicated quickly. In particular,embedded command substitutions
and/or the use of double quotes require careful escaping with the backs=
lash
character. Because of this the POSIX shell adopted the $(=E2=80=A6) fea=
ture from
the Korn shell.

Signed-off-by: Elia Pinto <gitter.spiros@gmail.com>
---
 git-web--browse.sh |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/git-web--browse.sh b/git-web--browse.sh
index ebdfba6..ae15253 100755
--- a/git-web--browse.sh
+++ b/git-web--browse.sh
@@ -59,7 +59,7 @@ do
 	-b|--browser*|-t|--tool*)
 		case "$#,$1" in
 		*,*=3D*)
-			browser=3D`expr "z$1" : 'z-[^=3D]*=3D\(.*\)'`
+			browser=3D$(expr "z$1" : 'z-[^=3D]*=3D\(.*\)')
 			;;
 		1,*)
 			usage ;;
@@ -71,7 +71,7 @@ do
 	-c|--config*)
 		case "$#,$1" in
 		*,*=3D*)
-			conf=3D`expr "z$1" : 'z-[^=3D]*=3D\(.*\)'`
+			conf=3D$(expr "z$1" : 'z-[^=3D]*=3D\(.*\)')
 			;;
 		1,*)
 			usage ;;
@@ -100,7 +100,7 @@ then
 	for opt in "$conf" "web.browser"
 	do
 		test -z "$opt" && continue
-		browser=3D"`git config $opt`"
+		browser=3D"$(git config $opt)"
 		test -z "$browser" || break
 	done
 	if test -n "$browser" && ! valid_tool "$browser"; then
--=20
1.7.10.4
