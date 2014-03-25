From: Elia Pinto <gitter.spiros@gmail.com>
Subject: [PATCH 103/144] t9108-git-svn-glob.sh: use the $( ... ) construct for command substitution
Date: Tue, 25 Mar 2014 01:25:48 -0700
Message-ID: <1395735989-3396-104-git-send-email-gitter.spiros@gmail.com>
References: <1395735989-3396-1-git-send-email-gitter.spiros@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Elia Pinto <gitter.spiros@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Mar 25 09:28:55 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WSMj5-0000Vy-Og
	for gcvg-git-2@plane.gmane.org; Tue, 25 Mar 2014 09:28:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752722AbaCYI2q convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 25 Mar 2014 04:28:46 -0400
Received: from mail-pa0-f43.google.com ([209.85.220.43]:59839 "EHLO
	mail-pa0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753969AbaCYI23 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 25 Mar 2014 04:28:29 -0400
Received: by mail-pa0-f43.google.com with SMTP id bj1so130330pad.16
        for <git@vger.kernel.org>; Tue, 25 Mar 2014 01:28:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=6n7kE7doCstJT0qkK6Cn3HzZc5h1YPdBR1KgsICIcy0=;
        b=U/dTNLo2cn18t63mCFC9YXM+pEE6O471pa+GBy5woefbTEfpu3zTxCponPz48xCa+/
         hQlK4BErAO9EZcri5e1/LJzxoPOgs5u/nWDp0oKWxxUTKhPZbmH1a/LpodNruzA96UEN
         T2TRAjn/8aAYhQZz9afYFbjkKYRbAmC1Jh6FU71tlY8Ve/0XOwOMupj8CebO1w/0PqUd
         vJIm5L6vKtR9fPUJIHn8nTSASWf4P2hU9RJ0v4g6Lm3fxY8XMHF44So1c6kmtcRj0oXI
         KztyPKzCaALFU6lrqtRMGq5kGl+Jkl/8oI1tlrUDkcIwPde4xFZJ/wRSBw66sNYwMtk7
         fQcA==
X-Received: by 10.66.121.131 with SMTP id lk3mr77015983pab.61.1395736109329;
        Tue, 25 Mar 2014 01:28:29 -0700 (PDT)
Received: from devzero2000ubu.nephoscale.com (140.195.207.67.nephoscale.net. [67.207.195.140])
        by mx.google.com with ESMTPSA id pr4sm41327198pbb.53.2014.03.25.01.28.28
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Tue, 25 Mar 2014 01:28:28 -0700 (PDT)
X-Mailer: git-send-email 1.7.10.4
In-Reply-To: <1395735989-3396-1-git-send-email-gitter.spiros@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/244941>

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
 t/t9108-git-svn-glob.sh |   20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/t/t9108-git-svn-glob.sh b/t/t9108-git-svn-glob.sh
index d732d31..a526d60 100755
--- a/t/t9108-git-svn-glob.sh
+++ b/t/t9108-git-svn-glob.sh
@@ -50,10 +50,10 @@ test_expect_success 'test refspec globbing' '
 	git log --pretty=3Doneline refs/remotes/tags/end | \
 	    sed -e "s/^.\{41\}//" > output.end &&
 	test_cmp expect.end output.end &&
-	test "`git rev-parse refs/remotes/tags/end~1`" =3D \
-		"`git rev-parse refs/remotes/branches/start`" &&
-	test "`git rev-parse refs/remotes/branches/start~2`" =3D \
-		"`git rev-parse refs/remotes/trunk`" &&
+	test "$(git rev-parse refs/remotes/tags/end~1)" =3D \
+		"$(git rev-parse refs/remotes/branches/start)" &&
+	test "$(git rev-parse refs/remotes/branches/start~2)" =3D \
+		"$(git rev-parse refs/remotes/trunk)" &&
 	test_must_fail git rev-parse refs/remotes/tags/end@3
 	'
=20
@@ -75,12 +75,12 @@ test_expect_success 'test left-hand-side only globb=
ing' '
 		svn_cmd commit -m "try to try"
 	) &&
 	git svn fetch two &&
-	test `git rev-list refs/remotes/two/tags/end | wc -l` -eq 6 &&
-	test `git rev-list refs/remotes/two/branches/start | wc -l` -eq 3 &&
-	test `git rev-parse refs/remotes/two/branches/start~2` =3D \
-	     `git rev-parse refs/remotes/two/trunk` &&
-	test `git rev-parse refs/remotes/two/tags/end~3` =3D \
-	     `git rev-parse refs/remotes/two/branches/start` &&
+	test $(git rev-list refs/remotes/two/tags/end | wc -l) -eq 6 &&
+	test $(git rev-list refs/remotes/two/branches/start | wc -l) -eq 3 &&
+	test $(git rev-parse refs/remotes/two/branches/start~2) =3D \
+	     $(git rev-parse refs/remotes/two/trunk) &&
+	test $(git rev-parse refs/remotes/two/tags/end~3) =3D \
+	     $(git rev-parse refs/remotes/two/branches/start) &&
 	git log --pretty=3Doneline refs/remotes/two/tags/end | \
 	    sed -e "s/^.\{41\}//" > output.two &&
 	test_cmp expect.two output.two
--=20
1.7.10.4
