From: =?utf-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 1/8] generate-cmdlist.sh: avoid selecting synopsis at wrong place
Date: Sun, 30 Nov 2008 17:54:31 +0700
Message-ID: <1228042478-1886-2-git-send-email-pclouds@gmail.com>
References: <1228042478-1886-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?utf-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Nov 30 11:56:30 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L6jyV-0005WI-DQ
	for gcvg-git-2@gmane.org; Sun, 30 Nov 2008 11:56:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751381AbYK3KzH convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 30 Nov 2008 05:55:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751375AbYK3KzG
	(ORCPT <rfc822;git-outgoing>); Sun, 30 Nov 2008 05:55:06 -0500
Received: from wf-out-1314.google.com ([209.85.200.171]:31243 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751213AbYK3KzE (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 30 Nov 2008 05:55:04 -0500
Received: by wf-out-1314.google.com with SMTP id 27so2162618wfd.4
        for <git@vger.kernel.org>; Sun, 30 Nov 2008 02:55:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=Ef4+79jt2EJc65yjVvq9JjQgX24tmleccGzHr+I4Ymw=;
        b=ftfj63QoWmNNZcG4loh2z6aUM135+wmn5mlfP0TwIG5LbPz8bdpvtLBHSRodBIOvAS
         WBrEeW2pTuj34TwXdJXzowrl56Ik6EnfmHn/Pb4yo5NZT649p9DhxwJlTGnrOgHsWClx
         EdgcbD5UmlPWt14x9NcjzfxoQU8I2NIPQEIoo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=UjCmbisZ3+Zs/ulod5jMqnZN6A0NaoCefejJoQA0suoaPrgDVb54ESgcycvZcpi2Sa
         vYLjk/7X5KE50IQKjQXoj9PaKGXGzhEaoD/r3+WJcXc5NfovwlvnTmh7lSoBXv0GtVzf
         8hhnPYsoqFWjEMUm7q/QlBJAPqnYWMmBnj8zw=
Received: by 10.142.134.20 with SMTP id h20mr4056237wfd.178.1228042503663;
        Sun, 30 Nov 2008 02:55:03 -0800 (PST)
Received: from pclouds@gmail.com ([115.73.222.32])
        by mx.google.com with ESMTPS id 22sm3886064wfd.33.2008.11.30.02.54.59
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 30 Nov 2008 02:55:01 -0800 (PST)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Sun, 30 Nov 2008 17:54:46 +0700
X-Mailer: git-send-email 1.6.0.3.890.g95457
In-Reply-To: <1228042478-1886-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/101962>

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
1.6.0.3.890.g95457
