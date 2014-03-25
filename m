From: Elia Pinto <gitter.spiros@gmail.com>
Subject: [PATCH 037/144] t3700-add.sh: use the $( ... ) construct for command substitution
Date: Tue, 25 Mar 2014 01:24:42 -0700
Message-ID: <1395735989-3396-38-git-send-email-gitter.spiros@gmail.com>
References: <1395735989-3396-1-git-send-email-gitter.spiros@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Elia Pinto <gitter.spiros@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Mar 25 09:34:14 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WSMoH-0006tY-QZ
	for gcvg-git-2@plane.gmane.org; Tue, 25 Mar 2014 09:34:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753804AbaCYI13 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 25 Mar 2014 04:27:29 -0400
Received: from mail-pa0-f52.google.com ([209.85.220.52]:53109 "EHLO
	mail-pa0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753781AbaCYI1Z (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 25 Mar 2014 04:27:25 -0400
Received: by mail-pa0-f52.google.com with SMTP id rd3so124924pab.39
        for <git@vger.kernel.org>; Tue, 25 Mar 2014 01:27:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=BYdClUEpyhofBm1u9xlfTqZQkqxSio3B/fXQHT8Uy9I=;
        b=Sij7sNX2VFItchFg9NzpPNIP9C01vdIM3m1Ep4T5Caf25/t7k0nCCD03qDSEN7jl2G
         3QOYcQHFOT7qRpeVMdo5jqlu69+pxH6QNRjMDnSzUP1bVVgbFetltWyRi8sikWno0y1r
         o9WjWI5md7/A/2DlOvr/49EjgI2RQLcsoAW/bG2J6wZ0SgSV6fC9T9NYrD0EKhyFLvL2
         nRiKIyyWZ641A9uXEJ3gIIrPZ/c99xMPM0Fr3pGN/8a2j88x87Rq/5boeUOUEKwQyNrs
         Bbz4AEXGNAZ/KrEQQpaZo7e8JblayiRN9FMdIdp8D9s04Gt9v+rMjrhBRE1GpQcA/l0X
         1TOw==
X-Received: by 10.66.66.66 with SMTP id d2mr77286760pat.80.1395736039642;
        Tue, 25 Mar 2014 01:27:19 -0700 (PDT)
Received: from devzero2000ubu.nephoscale.com (140.195.207.67.nephoscale.net. [67.207.195.140])
        by mx.google.com with ESMTPSA id pr4sm41327198pbb.53.2014.03.25.01.27.18
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Tue, 25 Mar 2014 01:27:19 -0700 (PDT)
X-Mailer: git-send-email 1.7.10.4
In-Reply-To: <1395735989-3396-1-git-send-email-gitter.spiros@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/244982>

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
 t/t3700-add.sh |   16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/t/t3700-add.sh b/t/t3700-add.sh
index fe274e2..95eb234 100755
--- a/t/t3700-add.sh
+++ b/t/t3700-add.sh
@@ -25,7 +25,7 @@ test_expect_success \
 	 echo foo >xfoo1 &&
 	 chmod 755 xfoo1 &&
 	 git add xfoo1 &&
-	 case "`git ls-files --stage xfoo1`" in
+	 case "$(git ls-files --stage xfoo1)" in
 	 100644" "*xfoo1) echo pass;;
 	 *) echo fail; git ls-files --stage xfoo1; (exit 1);;
 	 esac'
@@ -33,7 +33,7 @@ test_expect_success \
 test_expect_success 'git add: filemode=3D0 should not get confused by =
symlink' '
 	rm -f xfoo1 &&
 	test_ln_s_add foo xfoo1 &&
-	case "`git ls-files --stage xfoo1`" in
+	case "$(git ls-files --stage xfoo1)" in
 	120000" "*xfoo1) echo pass;;
 	*) echo fail; git ls-files --stage xfoo1; (exit 1);;
 	esac
@@ -45,7 +45,7 @@ test_expect_success \
 	 echo foo >xfoo2 &&
 	 chmod 755 xfoo2 &&
 	 git update-index --add xfoo2 &&
-	 case "`git ls-files --stage xfoo2`" in
+	 case "$(git ls-files --stage xfoo2)" in
 	 100644" "*xfoo2) echo pass;;
 	 *) echo fail; git ls-files --stage xfoo2; (exit 1);;
 	 esac'
@@ -53,7 +53,7 @@ test_expect_success \
 test_expect_success 'git add: filemode=3D0 should not get confused by =
symlink' '
 	rm -f xfoo2 &&
 	test_ln_s_add foo xfoo2 &&
-	case "`git ls-files --stage xfoo2`" in
+	case "$(git ls-files --stage xfoo2)" in
 	120000" "*xfoo2) echo pass;;
 	*) echo fail; git ls-files --stage xfoo2; (exit 1);;
 	esac
@@ -63,7 +63,7 @@ test_expect_success \
 	'git update-index --add: Test that executable bit is not used...' \
 	'git config core.filemode 0 &&
 	 test_ln_s_add xfoo2 xfoo3 &&	# runs git update-index --add
-	 case "`git ls-files --stage xfoo3`" in
+	 case "$(git ls-files --stage xfoo3)" in
 	 120000" "*xfoo3) echo pass;;
 	 *) echo fail; git ls-files --stage xfoo3; (exit 1);;
 	 esac'
@@ -166,14 +166,14 @@ test_expect_success 'git add with filemode=3D0, s=
ymlinks=3D0 prefers stage 2 over st
=20
 test_expect_success 'git add --refresh' '
 	>foo && git add foo && git commit -a -m "commit all" &&
-	test -z "`git diff-index HEAD -- foo`" &&
+	test -z "$(git diff-index HEAD -- foo)" &&
 	git read-tree HEAD &&
-	case "`git diff-index HEAD -- foo`" in
+	case "$(git diff-index HEAD -- foo)" in
 	:100644" "*"M	foo") echo pass;;
 	*) echo fail; (exit 1);;
 	esac &&
 	git add --refresh -- foo &&
-	test -z "`git diff-index HEAD -- foo`"
+	test -z "$(git diff-index HEAD -- foo)"
 '
=20
 test_expect_success 'git add --refresh with pathspec' '
--=20
1.7.10.4
