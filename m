From: Elia Pinto <gitter.spiros@gmail.com>
Subject: [PATCH 035/144] t3511-cherry-pick-x.sh: use the $( ... ) construct for command substitution
Date: Tue, 25 Mar 2014 01:24:40 -0700
Message-ID: <1395735989-3396-36-git-send-email-gitter.spiros@gmail.com>
References: <1395735989-3396-1-git-send-email-gitter.spiros@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Elia Pinto <gitter.spiros@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Mar 25 09:34:39 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WSMof-0007PV-V7
	for gcvg-git-2@plane.gmane.org; Tue, 25 Mar 2014 09:34:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754089AbaCYIed convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 25 Mar 2014 04:34:33 -0400
Received: from mail-pb0-f48.google.com ([209.85.160.48]:61902 "EHLO
	mail-pb0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752520AbaCYI1R (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 25 Mar 2014 04:27:17 -0400
Received: by mail-pb0-f48.google.com with SMTP id md12so133256pbc.7
        for <git@vger.kernel.org>; Tue, 25 Mar 2014 01:27:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=L6lypR+vrN55A9iHxxFloHY5R2ft+X2XAYxoUtvUUag=;
        b=inwF/XqY3faotsCKmIYYP0AZRkNSt9QKKpYIsy2RvXWT5qz7g3qyxKqsdSbICIpjLy
         8JRLCEo3+BZIh8ZT/PeeD6TxYzNHC2F6Sv/md2ZeryB77j9l023i8ga8sAKZoeGC37yD
         Hom/lfkZsxpvMWMD2xrHV2jW9/RiTZrrX+0m8xs+VwTOTRMYl6pUpPK5SekJGKDne3Wz
         JeFeBabjmWDuqEPVU0cY3uYlppAfvomTo7VSb/ZMnl/9SM/I5JC3lo0lkqg3X37NKwdo
         IehpHE7ExmYcTwGDatRmky+GJwULhhaxB3GAfpnIopPgKkd0MpDgYnY16Ih2+p5dCiv1
         Lv5Q==
X-Received: by 10.68.231.196 with SMTP id ti4mr44118733pbc.48.1395736037149;
        Tue, 25 Mar 2014 01:27:17 -0700 (PDT)
Received: from devzero2000ubu.nephoscale.com (140.195.207.67.nephoscale.net. [67.207.195.140])
        by mx.google.com with ESMTPSA id pr4sm41327198pbb.53.2014.03.25.01.27.16
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Tue, 25 Mar 2014 01:27:16 -0700 (PDT)
X-Mailer: git-send-email 1.7.10.4
In-Reply-To: <1395735989-3396-1-git-send-email-gitter.spiros@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/244986>

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
 t/t3511-cherry-pick-x.sh |   14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/t/t3511-cherry-pick-x.sh b/t/t3511-cherry-pick-x.sh
index f977279..f60a037 100755
--- a/t/t3511-cherry-pick-x.sh
+++ b/t/t3511-cherry-pick-x.sh
@@ -59,7 +59,7 @@ test_expect_success setup '
=20
 test_expect_success 'cherry-pick -x inserts blank line after one line =
subject' '
 	pristine_detach initial &&
-	sha1=3D`git rev-parse mesg-one-line^0` &&
+	sha1=3D$(git rev-parse mesg-one-line^0) &&
 	git cherry-pick -x mesg-one-line &&
 	cat <<-EOF >expect &&
 		$mesg_one_line
@@ -96,7 +96,7 @@ test_expect_success 'cherry-pick -s inserts blank lin=
e after non-conforming foot
=20
 test_expect_success 'cherry-pick -x inserts blank line when conforming=
 footer not found' '
 	pristine_detach initial &&
-	sha1=3D`git rev-parse mesg-no-footer^0` &&
+	sha1=3D$(git rev-parse mesg-no-footer^0) &&
 	git cherry-pick -x mesg-no-footer &&
 	cat <<-EOF >expect &&
 		$mesg_no_footer
@@ -121,7 +121,7 @@ test_expect_success 'cherry-pick -s inserts blank l=
ine when conforming footer no
=20
 test_expect_success 'cherry-pick -x -s inserts blank line when conform=
ing footer not found' '
 	pristine_detach initial &&
-	sha1=3D`git rev-parse mesg-no-footer^0` &&
+	sha1=3D$(git rev-parse mesg-no-footer^0) &&
 	git cherry-pick -x -s mesg-no-footer &&
 	cat <<-EOF >expect &&
 		$mesg_no_footer
@@ -146,7 +146,7 @@ test_expect_success 'cherry-pick -s adds sob when l=
ast sob doesnt match committe
=20
 test_expect_success 'cherry-pick -x -s adds sob when last sob doesnt m=
atch committer' '
 	pristine_detach initial &&
-	sha1=3D`git rev-parse mesg-with-footer^0` &&
+	sha1=3D$(git rev-parse mesg-with-footer^0) &&
 	git cherry-pick -x -s mesg-with-footer &&
 	cat <<-EOF >expect &&
 		$mesg_with_footer
@@ -169,7 +169,7 @@ test_expect_success 'cherry-pick -s refrains from a=
dding duplicate trailing sob'
=20
 test_expect_success 'cherry-pick -x -s adds sob even when trailing sob=
 exists for committer' '
 	pristine_detach initial &&
-	sha1=3D`git rev-parse mesg-with-footer-sob^0` &&
+	sha1=3D$(git rev-parse mesg-with-footer-sob^0) &&
 	git cherry-pick -x -s mesg-with-footer-sob &&
 	cat <<-EOF >expect &&
 		$mesg_with_footer_sob
@@ -182,7 +182,7 @@ test_expect_success 'cherry-pick -x -s adds sob eve=
n when trailing sob exists fo
=20
 test_expect_success 'cherry-pick -x treats "(cherry picked from..." li=
ne as part of footer' '
 	pristine_detach initial &&
-	sha1=3D`git rev-parse mesg-with-cherry-footer^0` &&
+	sha1=3D$(git rev-parse mesg-with-cherry-footer^0) &&
 	git cherry-pick -x mesg-with-cherry-footer &&
 	cat <<-EOF >expect &&
 		$mesg_with_cherry_footer
@@ -205,7 +205,7 @@ test_expect_success 'cherry-pick -s treats "(cherry=
 picked from..." line as part
=20
 test_expect_success 'cherry-pick -x -s treats "(cherry picked from..."=
 line as part of footer' '
 	pristine_detach initial &&
-	sha1=3D`git rev-parse mesg-with-cherry-footer^0` &&
+	sha1=3D$(git rev-parse mesg-with-cherry-footer^0) &&
 	git cherry-pick -x -s mesg-with-cherry-footer &&
 	cat <<-EOF >expect &&
 		$mesg_with_cherry_footer
--=20
1.7.10.4
