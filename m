From: =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
Subject: [PATCH 48/48] i18n: git-bisect bisect_next_check "You need to" message
Date: Sun,  8 May 2011 12:21:20 +0000
Message-ID: <1304857280-14773-49-git-send-email-avarab@gmail.com>
References: <1304857280-14773-1-git-send-email-avarab@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun May 08 14:23:11 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QJ30w-0004Hv-8C
	for gcvg-git-2@lo.gmane.org; Sun, 08 May 2011 14:23:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754090Ab1EHMWp convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 8 May 2011 08:22:45 -0400
Received: from mail-ey0-f174.google.com ([209.85.215.174]:37472 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752897Ab1EHMWU (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 May 2011 08:22:20 -0400
Received: by mail-ey0-f174.google.com with SMTP id 24so1325598eyx.19
        for <git@vger.kernel.org>; Sun, 08 May 2011 05:22:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer
         :in-reply-to:references:mime-version:content-type
         :content-transfer-encoding;
        bh=lWPg/FLUba7wDJczn7CAbbnOnLTX4F3H8QO4j9sWrWQ=;
        b=RE6z0Sx66m9HceIwnVTeBuCj2MkgEP6Yk2ZFcuDtPgvguGjqQ1qH4FEMjKJKadD23V
         n3jgwzD8Wfa4XLQwBexyOI9AkVmlfnXAfxZCHAFxx8IxFHD6PB+nuVclOrHzAiP5v1YT
         c19xX0vNu42PpbzmgXTalAlxlMheV6YMMB+pI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=b1VEB0CdhyPGj+dshfB/CR4iovV5vpIMHAQArXGeYX5FlsSe0Gj/4bHuVJKYoSm6ap
         vCLKQA0TJ2SWqenGVuDpJEEh4w69nIi8+abW0JYKLlBi0gKXolj1Wn/H1MKuG+590KFL
         QocQV/Uga7BNKqR9dHcK8jVxL5rrru0AoJrEg=
Received: by 10.213.106.200 with SMTP id y8mr1847592ebo.67.1304857339431;
        Sun, 08 May 2011 05:22:19 -0700 (PDT)
Received: from w.nix.is (w.nix.is [188.40.98.140])
        by mx.google.com with ESMTPS id n55sm2690046een.2.2011.05.08.05.22.18
        (version=SSLv3 cipher=OTHER);
        Sun, 08 May 2011 05:22:18 -0700 (PDT)
X-Mailer: git-send-email 1.7.4.4
In-Reply-To: <1304857280-14773-1-git-send-email-avarab@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/173136>

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
1.7.4.4
