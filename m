From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: [PATCH] Add abbreviated commit hash to rebase conflict message
Date: Sat,  5 Nov 2011 15:02:39 +0100
Message-ID: <1320501759-27236-1-git-send-email-srabbelier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Sverre Rabbelier <srabbelier@gmail.com>
To: =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>,
	=?UTF-8?q?Jonas=20Flod=C3=A9n?= <jonas@floden.nu>,
	Junio C Hamano <gitster@pobox.com>,
	Eric Herman <eric@f
X-From: git-owner@vger.kernel.org Sat Nov 05 15:15:32 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RMh1v-0003di-7Q
	for gcvg-git-2@lo.gmane.org; Sat, 05 Nov 2011 15:15:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751248Ab1KEODq convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 5 Nov 2011 10:03:46 -0400
Received: from mail-ey0-f174.google.com ([209.85.215.174]:41737 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750755Ab1KEODp (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 5 Nov 2011 10:03:45 -0400
Received: by eye27 with SMTP id 27so2738182eye.19
        for <git@vger.kernel.org>; Sat, 05 Nov 2011 07:03:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:mime-version
         :content-type:content-transfer-encoding;
        bh=sGOKkr7Lq2ehtWLxv4rvx9xnjt4sFEiPNCEp/wUij2c=;
        b=Gdwa/0Lsfn3vQJza43wVH8B+tw2uhzxDpw6JD+JAp93pdIM+0Ya82L69mrT95QA60O
         nwhlVwQa43Ullwtngz4yYmmLR1dKqyrMbcOGtkxZziAIzsqR1F1BClicW4wuu9F2bUwf
         YZ1F1ofuY9SYf9WqQYROPVtICooVKZVQtwY+c=
Received: by 10.14.12.16 with SMTP id 16mr137724eey.243.1320501824529;
        Sat, 05 Nov 2011 07:03:44 -0700 (PDT)
Received: from laptop-sverre.home (sd4406ed1.adsl.wanadoo.nl. [212.64.110.209])
        by mx.google.com with ESMTPS id o4sm34158785eeb.0.2011.11.05.07.03.42
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sat, 05 Nov 2011 07:03:43 -0700 (PDT)
X-Mailer: git-send-email 1.7.8.rc0.36.g67522.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/184847>

Also move the $msgnum to a more sensible location.

Before:
	Patch failed at 0001 msg
After:
	Patch 0001 failed at [da65151] msg

Reviewed-by: Eric Herman <eric@freesa.org>
Reviewed-by: Fernando Vezzosi <buccia@repnz.net>
Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com=
>
Signed-off-by: Sverre Rabbelier <srabbelier@gmail.com>
---
 git-am.sh |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/git-am.sh b/git-am.sh
index 9042432..9d70588 100755
--- a/git-am.sh
+++ b/git-am.sh
@@ -837,7 +837,8 @@ did you forget to use 'git add'?"
 	fi
 	if test $apply_status !=3D 0
 	then
-		eval_gettextln 'Patch failed at $msgnum $FIRSTLINE'
+		abbrev_commit=3D$(git log -1 --pretty=3D%h $commit)
+		eval_gettextln 'Patch $msgnum failed at [$abbrev_commit] $FIRSTLINE'
 		stop_here_user_resolve $this
 	fi
=20
--=20
1.7.8.rc0.36.g67522.dirty
