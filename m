From: =?utf-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH] generate-cmdlist.sh: avoid selecting synopsis at wrong place
Date: Thu, 18 Sep 2008 23:01:43 +0700
Message-ID: <1221753703-3331-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?utf-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Sep 18 18:04:29 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KgLyE-000619-R4
	for gcvg-git-2@gmane.org; Thu, 18 Sep 2008 18:03:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754827AbYIRQB4 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 18 Sep 2008 12:01:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754110AbYIRQB4
	(ORCPT <rfc822;git-outgoing>); Thu, 18 Sep 2008 12:01:56 -0400
Received: from mail-gx0-f16.google.com ([209.85.217.16]:60885 "EHLO
	mail-gx0-f16.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753107AbYIRQBz (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Sep 2008 12:01:55 -0400
Received: by gxk9 with SMTP id 9so31411848gxk.13
        for <git@vger.kernel.org>; Thu, 18 Sep 2008 09:01:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer:mime-version:content-type
         :content-transfer-encoding;
        bh=WMpsN3m0NF/p8B/Dzqe96sUkoHkWDm+H4ljtVXZ8FRo=;
        b=j0TRAwJZboRixpEWfc/jnETWW/22HvlTq03qA3y89v49BK4u+Xpf+0hKBIXQZOF+HG
         q21K4gd8+brvqd33ofuI+bJxX8FkII1Jc9xE+tpAZos6AlIKwUe9k0yzlxDUMlw2FP4x
         0AXEDcM73Tp/IK4K8uOXU18NxFn4TvCZLujDo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:mime-version
         :content-type:content-transfer-encoding;
        b=TGHfc2do3V5PqOgcnBKJdxIJwSxmMEeL+BT8IzrfiReJPmmZJ+TIwhXwW7TTs7Dm3/
         lykq1vrlQg3m7l9gZAsCCvFYR/phf0/uMBWYagseyfB7bA6Vrk/EFaflsQzN7UkPaUyz
         2nFVZwH2CXKwb/oORPl73GRKatnuO8tGNC0PI=
Received: by 10.142.229.5 with SMTP id b5mr1459016wfh.310.1221753713858;
        Thu, 18 Sep 2008 09:01:53 -0700 (PDT)
Received: from pclouds@gmail.com ( [117.5.36.54])
        by mx.google.com with ESMTPS id 28sm2252206wfg.15.2008.09.18.09.01.50
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 18 Sep 2008 09:01:52 -0700 (PDT)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Thu, 18 Sep 2008 23:01:43 +0700
X-Mailer: git-send-email 1.6.0.96.g2fad1.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/96207>

In "common" man pages there is luckily no "NAME" anywhere except at
beginning of documents. If there is another "NAME", sed could
mis-select it and lead to common-cmds.h corruption. So better nail it
at beginning of line, which would reduce corruption chance.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 generate-cmdlist.sh |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/generate-cmdlist.sh b/generate-cmdlist.sh
index a2913c2..75c68d9 100755
--- a/generate-cmdlist.sh
+++ b/generate-cmdlist.sh
@@ -14,7 +14,7 @@ sort |
 while read cmd
 do
      sed -n '
-     /NAME/,/git-'"$cmd"'/H
+     /^NAME/,/git-'"$cmd"'/H
      ${
             x
             s/.*git-'"$cmd"' - \(.*\)/  {"'"$cmd"'", "\1"},/
--=20
1.6.0.96.g2fad1.dirty
