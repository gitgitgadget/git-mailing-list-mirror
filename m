From: =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
Subject: [PATCH v2 04/48] i18n: git-am eval_gettext messages
Date: Sat, 21 May 2011 18:43:45 +0000
Message-ID: <1306003469-22939-5-git-send-email-avarab@gmail.com>
References: <1306003469-22939-1-git-send-email-avarab@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat May 21 20:45:33 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QNrB6-0000JJ-SO
	for gcvg-git-2@lo.gmane.org; Sat, 21 May 2011 20:45:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756350Ab1EUSpT convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 21 May 2011 14:45:19 -0400
Received: from mail-ey0-f174.google.com ([209.85.215.174]:42788 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754886Ab1EUSpG (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 21 May 2011 14:45:06 -0400
Received: by mail-ey0-f174.google.com with SMTP id 24so1444603eyx.19
        for <git@vger.kernel.org>; Sat, 21 May 2011 11:45:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer
         :in-reply-to:references:mime-version:content-type
         :content-transfer-encoding;
        bh=8BWLm86tYNVOGMF0EjAEuVZYvxWf7bMir/nHGFJHpG4=;
        b=UIWgMuSQbUj8AEbO41rQsspj1K7XRDn3hviMg6MET+97gz2OLOa4/8VsSzkQ5qGPf5
         v5Rhdg+BqBn8m6Q2O7+QSguklfEaybsuNsCyDTPTNcZbfQFkr7qdOZeLB+w56WEDCuqt
         55CfArC/CqJUgEWDgRVMO5lBak9oTuiHYx0nw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=wcITO4T7cpKxp7RmFmFDB2l93hFqFtRIOkHysPobth4Y1MR2M9U2oz1zY0OMCmX7YB
         0jRczqKxHpuAMmZYzGOfr+THO/0ehkzvM8iHJl/mhL5jxGDHJ/50uQeG/A3/iaKxw16L
         tFKjc20SNpwMuZh1iQMkqDxIMqa0F6pFAdLlY=
Received: by 10.213.113.204 with SMTP id b12mr567836ebq.104.1306003505827;
        Sat, 21 May 2011 11:45:05 -0700 (PDT)
Received: from w.nix.is (w.nix.is [188.40.98.140])
        by mx.google.com with ESMTPS id y14sm1130434eeh.3.2011.05.21.11.45.05
        (version=SSLv3 cipher=OTHER);
        Sat, 21 May 2011 11:45:05 -0700 (PDT)
X-Mailer: git-send-email 1.7.5.1
In-Reply-To: <1306003469-22939-1-git-send-email-avarab@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/174123>

Messages that use variables to be interpolated need to use
eval_gettext(), this wrapper will eval the message and expand the
variable for us.

Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com=
>
---
 git-am.sh |   12 ++++++------
 1 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/git-am.sh b/git-am.sh
index 5a152b0..7c0273c 100755
--- a/git-am.sh
+++ b/git-am.sh
@@ -99,9 +99,9 @@ stop_here_user_resolve () {
 	    printf '%s\n' "$resolvemsg"
 	    stop_here $1
     fi
-    echo "When you have resolved this problem run \"$cmdline --resolve=
d\"."
-    echo "If you would prefer to skip this patch, instead run \"$cmdli=
ne --skip\"."
-    echo "To restore the original branch and stop patching run \"$cmdl=
ine --abort\"."
+    eval_gettext "When you have resolved this problem run \"\$cmdline =
--resolved\".
+If you would prefer to skip this patch, instead run \"\$cmdline --skip=
\".
+To restore the original branch and stop patching run \"\$cmdline --abo=
rt\"."; echo
=20
     stop_here $1
 }
@@ -608,9 +608,9 @@ do
 			go_next && continue
=20
 		test -s "$dotest/patch" || {
-			echo "Patch is empty.  Was it split wrong?"
-			echo "If you would prefer to skip this patch, instead run \"$cmdlin=
e --skip\"."
-			echo "To restore the original branch and stop patching run \"$cmdli=
ne --abort\"."
+			eval_gettext "Patch is empty.  Was it split wrong?
+If you would prefer to skip this patch, instead run \"\$cmdline --skip=
\".
+To restore the original branch and stop patching run \"\$cmdline --abo=
rt\"."; echo
 			stop_here $this
 		}
 		rm -f "$dotest/original-commit" "$dotest/author-script"
--=20
1.7.5.1
