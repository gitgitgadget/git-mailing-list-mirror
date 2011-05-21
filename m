From: =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
Subject: [PATCH v2 21/48] i18n: git-submodule $update_module say + die messages
Date: Sat, 21 May 2011 18:44:02 +0000
Message-ID: <1306003469-22939-22-git-send-email-avarab@gmail.com>
References: <1306003469-22939-1-git-send-email-avarab@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat May 21 20:45:38 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QNrBA-0000JJ-4W
	for gcvg-git-2@lo.gmane.org; Sat, 21 May 2011 20:45:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756897Ab1EUSpb convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 21 May 2011 14:45:31 -0400
Received: from mail-ey0-f174.google.com ([209.85.215.174]:39530 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756514Ab1EUSpW (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 21 May 2011 14:45:22 -0400
Received: by mail-ey0-f174.google.com with SMTP id 24so1444607eyx.19
        for <git@vger.kernel.org>; Sat, 21 May 2011 11:45:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer
         :in-reply-to:references:mime-version:content-type
         :content-transfer-encoding;
        bh=+wXQtTsWdXcihhDbOv7b67xk12uWGjf0TFZZU24LupQ=;
        b=RlKygMz4QWa15X8zJdbrM9z34ouprDSk1R4SZC9T9Tr2p5vvrg5Xw5ArnQWqorZhtb
         lfgQUlObF/NSvk3XvvL6QdmrokJT8utk89HkMKosd/B52OOfZ3lHHOem0xQU0TsM24cj
         6k3pgjvdUx1RhBe1A+OOWbM5SLOe1VJwGlbOc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=f2p7o8oDJqt9jviUkB5YE2SiPScuGIaBG+3A1fJtBXHZnozdNHu7H00hQ5l/b8XC9N
         /HM9k/PJZSW7L/ICxcRajz8nOGVxlbRaPoVxYeZVSXajuivAwj9nlBo5zHUszCQn1tmR
         fbTfnFL91v1z0bFa37OKlua/7zuDhsYAvfw4k=
Received: by 10.213.103.72 with SMTP id j8mr277610ebo.137.1306003521369;
        Sat, 21 May 2011 11:45:21 -0700 (PDT)
Received: from w.nix.is (w.nix.is [188.40.98.140])
        by mx.google.com with ESMTPS id y14sm1130434eeh.3.2011.05.21.11.45.20
        (version=SSLv3 cipher=OTHER);
        Sat, 21 May 2011 11:45:20 -0700 (PDT)
X-Mailer: git-send-email 1.7.5.1
In-Reply-To: <1306003469-22939-1-git-send-email-avarab@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/174125>

Gettextize $update_module say and die messages. These messages needed
to be split up to make them translatable.

Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com=
>
---
 git-submodule.sh            |   17 ++++++++---------
 t/t7406-submodule-update.sh |    2 +-
 2 files changed, 9 insertions(+), 10 deletions(-)

diff --git a/git-submodule.sh b/git-submodule.sh
index de5048c..7eb1de0 100755
--- a/git-submodule.sh
+++ b/git-submodule.sh
@@ -511,24 +511,23 @@ cmd_update()
 			case "$update_module" in
 			rebase)
 				command=3D"git rebase"
-				action=3D"rebase"
-				msg=3D"rebased onto"
+				die_msg=3D"$(eval_gettext "Unable to rebase '\$sha1' in submodule =
path '\$path'")"
+				say_msg=3D"$(eval_gettext "Submodule path '\$path': rebased into '=
\$sha1'")"
 				;;
 			merge)
 				command=3D"git merge"
-				action=3D"merge"
-				msg=3D"merged in"
+				die_msg=3D"$(eval_gettext "Unable to merge '\$sha1' in submodule p=
ath '\$path'")"
+				say_msg=3D"$(eval_gettext "Submodule path '\$path': merged in '\$s=
ha1'")"
 				;;
 			*)
 				command=3D"git checkout $subforce -q"
-				action=3D"checkout"
-				msg=3D"checked out"
+				die_msg=3D"$(eval_gettext "Unable to checkout '\$sha1' in submodul=
e path '\$path'")"
+				say_msg=3D"$(eval_gettext "Submodule path '\$path': checked out '\=
$sha1'")"
 				;;
 			esac
=20
-			(clear_local_git_env; cd "$path" && $command "$sha1") ||
-			die "Unable to $action '$sha1' in submodule path '$path'"
-			say "Submodule path '$path': $msg '$sha1'"
+			(clear_local_git_env; cd "$path" && $command "$sha1") || die $die_m=
sg
+			say $say_msg
 		fi
=20
 		if test -n "$recursive"
diff --git a/t/t7406-submodule-update.sh b/t/t7406-submodule-update.sh
index 4f16fcc..60e33be 100755
--- a/t/t7406-submodule-update.sh
+++ b/t/t7406-submodule-update.sh
@@ -90,7 +90,7 @@ test_expect_success 'submodule update does not fetch =
already present commits' '
 	(cd super &&
 	  git submodule update > ../actual 2> ../actual.err
 	) &&
-	test_cmp expected actual &&
+	test_i18ncmp expected actual &&
 	! test -s actual.err
 '
=20
--=20
1.7.5.1
