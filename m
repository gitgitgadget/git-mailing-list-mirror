From: =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
Subject: [PATCH v2 40/48] i18n: git-bisect echo + gettext messages
Date: Sat, 21 May 2011 18:44:21 +0000
Message-ID: <1306003469-22939-41-git-send-email-avarab@gmail.com>
References: <1306003469-22939-1-git-send-email-avarab@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat May 21 20:46:39 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QNrC3-0000od-2X
	for gcvg-git-2@lo.gmane.org; Sat, 21 May 2011 20:46:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757103Ab1EUSqC convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 21 May 2011 14:46:02 -0400
Received: from mail-ey0-f174.google.com ([209.85.215.174]:64800 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756985Ab1EUSpk (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 21 May 2011 14:45:40 -0400
Received: by mail-ey0-f174.google.com with SMTP id 24so1444610eyx.19
        for <git@vger.kernel.org>; Sat, 21 May 2011 11:45:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer
         :in-reply-to:references:mime-version:content-type
         :content-transfer-encoding;
        bh=LlSSvf3XqvD5xQ+USWA8vEhoEcgReAhEvK5thEsZIrk=;
        b=idPGRdAKJm0BmVbDSB9oB65JvnpBYQe1u+ky4OUHxu1M9BaLwnvM8RueSt6jWf3mfj
         ifYPPz0cm76Kdp3RMgxB1U55Y8A3wxxeBy8ujNX8lEoQyAeS1KXGVEro4P1X2r6im74V
         qI0mqY01yiXjKhuEMMGvc7gfWJVTuMVuKIROU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=lmkbCdqRPiqlSB175l1SE/p05qg3rxfNQdu0YtktqjLCT5F9yevxhGGx8mQCRnYvEi
         2W9LPWqapW1zgU6ZfwtYo4GWgoF11nZiWXpI6j1zBEE7SFbunQtBjnsyOCVdmou2x1QO
         1O8AagylcCgN8mVIlTyZ7dqqZwKiV7GDpgf4A=
Received: by 10.14.22.5 with SMTP id s5mr264892ees.94.1306003539865;
        Sat, 21 May 2011 11:45:39 -0700 (PDT)
Received: from w.nix.is (w.nix.is [188.40.98.140])
        by mx.google.com with ESMTPS id y14sm1130434eeh.3.2011.05.21.11.45.39
        (version=SSLv3 cipher=OTHER);
        Sat, 21 May 2011 11:45:39 -0700 (PDT)
X-Mailer: git-send-email 1.7.5.1
In-Reply-To: <1306003469-22939-1-git-send-email-avarab@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/174146>

Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com=
>
---
 git-bisect.sh |   15 ++++++++++++---
 1 files changed, 12 insertions(+), 3 deletions(-)

diff --git a/git-bisect.sh b/git-bisect.sh
index 4420b46..b29238d 100755
--- a/git-bisect.sh
+++ b/git-bisect.sh
@@ -36,7 +36,10 @@ _x40=3D"$_x40$_x40$_x40$_x40$_x40$_x40$_x40$_x40"
=20
 bisect_autostart() {
 	test -s "$GIT_DIR/BISECT_START" || {
-		echo >&2 'You need to start by "git bisect start"'
+		(
+			gettext "You need to start by \"git bisect start\"" &&
+			echo
+		) >&2
 		if test -t 0
 		then
 			echo >&2 -n 'Do you want me to do it for you [Y/n]? '
@@ -239,7 +242,10 @@ bisect_next_check() {
 	t,,good)
 		# have bad but not good.  we could bisect although
 		# this is less optimum.
-		echo >&2 'Warning: bisecting only with a bad commit.'
+		(
+			gettext "Warning: bisecting only with a bad commit." &&
+			echo
+		) >&2
 		if test -t 0
 		then
 			printf >&2 'Are you sure [Y/n]? '
@@ -403,7 +409,10 @@ bisect_run () {
=20
       if sane_grep "first bad commit could be any of" "$GIT_DIR/BISECT=
_RUN" \
 		> /dev/null; then
-	  echo >&2 "bisect run cannot continue any more"
+	  (
+	      gettext "bisect run cannot continue any more" &&
+	      echo
+	  ) >&2
 	  exit $res
       fi
=20
--=20
1.7.5.1
