From: =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
Subject: [PATCH 51/51] i18n: git-bisect bisect_next_check "You need to" message
Date: Sun,  3 Apr 2011 16:46:15 +0000
Message-ID: <1301849175-1697-52-git-send-email-avarab@gmail.com>
References: <1301849175-1697-1-git-send-email-avarab@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Apr 03 18:48:27 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q6QTP-0005RJ-BJ
	for gcvg-git-2@lo.gmane.org; Sun, 03 Apr 2011 18:48:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753200Ab1DCQr3 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 3 Apr 2011 12:47:29 -0400
Received: from mail-ew0-f46.google.com ([209.85.215.46]:33259 "EHLO
	mail-ew0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753179Ab1DCQrY (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 3 Apr 2011 12:47:24 -0400
Received: by mail-ew0-f46.google.com with SMTP id 4so1505908ewy.19
        for <git@vger.kernel.org>; Sun, 03 Apr 2011 09:47:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer
         :in-reply-to:references:mime-version:content-type
         :content-transfer-encoding;
        bh=RnWWX7EmNmegwq2LIaJVxhsmcuDF6GIunvPKYK+y80w=;
        b=lC3FPfx1/4yWycIHjHGwlG+z5Egiw7goV/YJ9hSsEpUBF0boVvCXAkfbrnNi+Qrd6Q
         o6vTWm7NulmT5fPtBcn+X7r9YtspizbxfQWjygH3AEM6UAgfZmU1QY4jZPpvwYBlmUye
         kZJ0r53BhI+5RIBx0Id2xMlUv7fbmyr2XVL6c=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=kHdJQbdrQvyaKfS2pIO9GzJQgVmREZRgnhrSJSY6blDHz8DATdC5auMKwKemk4g9Xj
         eEv/iYYUHKbdlHitSWTcM1xwWIY6r3g7s539Gdu+nugZyP2AY3Y11KtkFat/RCQaYpr1
         inVxbvGVCkIHElfnSnqMwjxAg1aU682ZfJxjc=
Received: by 10.213.21.24 with SMTP id h24mr3139772ebb.117.1301849243734;
        Sun, 03 Apr 2011 09:47:23 -0700 (PDT)
Received: from w.nix.is (w.nix.is [188.40.98.140])
        by mx.google.com with ESMTPS id w59sm2750567eeh.24.2011.04.03.09.47.22
        (version=SSLv3 cipher=OTHER);
        Sun, 03 Apr 2011 09:47:23 -0700 (PDT)
X-Mailer: git-send-email 1.7.4.1
In-Reply-To: <1301849175-1697-1-git-send-email-avarab@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/170736>

Gettextize the "You need to start by" message in
bisect_next_check. This message assembled English output by hand so it
needed to be split up to make it translatable.

Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com=
>
---
 git-bisect.sh |   19 ++++++++++---------
 1 files changed, 10 insertions(+), 9 deletions(-)

diff --git a/git-bisect.sh b/git-bisect.sh
index 9bc18fe..2b17615 100755
--- a/git-bisect.sh
+++ b/git-bisect.sh
@@ -255,15 +255,16 @@ bisect_next_check() {
 		: bisect without good...
 		;;
 	*)
-		THEN=3D''
-		test -s "$GIT_DIR/BISECT_START" || {
-			echo >&2 'You need to start by "git bisect start".'
-			THEN=3D'then '
-		}
-		echo >&2 'You '$THEN'need to give me at least one good' \
-			'and one bad revisions.'
-		echo >&2 '(You can use "git bisect bad" and' \
-			'"git bisect good" for that.)'
+
+		if test -s "$GIT_DIR/BISECT_START"
+		then
+			echo >&2 "$(gettext "You need to give me at least one good and one =
bad revisions.
+(You can use \"git bisect bad\" and \"git bisect good\" for that.)")"
+		else
+			echo >&2 "$(gettext "You need to start by \"git bisect start\".
+You then need to give me at least one good and one bad revisions.
+(You can use \"git bisect bad\" and \"git bisect good\" for that.)")"
+		fi
 		exit 1 ;;
 	esac
 }
--=20
1.7.4.1
