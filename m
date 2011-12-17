From: Jakub Narebski <jnareb@gmail.com>
Subject: [PATCH 3/3] gitweb: Output valid utf8 in git_blame_common('data')
Date: Sat, 17 Dec 2011 10:22:23 +0100
Message-ID: <1324113743-21498-4-git-send-email-jnareb@gmail.com>
References: <1324113743-21498-1-git-send-email-jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Juergen Kreileder <jk@blackdown.de>,
	John Hawley <warthog9@kernel.org>, admin@repo.or.cz
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Dec 17 10:23:19 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RbqUA-0002fp-IQ
	for gcvg-git-2@lo.gmane.org; Sat, 17 Dec 2011 10:23:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751638Ab1LQJXQ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 17 Dec 2011 04:23:16 -0500
Received: from mail-ey0-f174.google.com ([209.85.215.174]:56975 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751086Ab1LQJXI (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 17 Dec 2011 04:23:08 -0500
Received: by eaaj10 with SMTP id j10so3525607eaa.19
        for <git@vger.kernel.org>; Sat, 17 Dec 2011 01:23:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=EoMo+5Fx2OeRonySumhoc3pZH9CMqL0MfKa5r+XjaU8=;
        b=S2UqR/g/UmKuNGH7pjtvX3JDxtp0XdEm/IhwMjcm8J8kPRvw0jPNqMlKNaEQGtUzq1
         +XXB42Vj5h60g6VxEvysyhLj4KNhj2eJGDIMhI1SaEDp1Lc+8e4UbbJpDVycg9JSUYkJ
         IGCYjDaM/rAj1osppl2WjeZdZ/+oRrDY2hZlU=
Received: by 10.213.15.203 with SMTP id l11mr1042161eba.126.1324113786800;
        Sat, 17 Dec 2011 01:23:06 -0800 (PST)
Received: from localhost.localdomain (abrz159.neoplus.adsl.tpnet.pl. [83.8.119.159])
        by mx.google.com with ESMTPS id 58sm10768875eet.11.2011.12.17.01.23.05
        (version=SSLv3 cipher=OTHER);
        Sat, 17 Dec 2011 01:23:06 -0800 (PST)
X-Mailer: git-send-email 1.7.6
In-Reply-To: <1324113743-21498-1-git-send-email-jnareb@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/187359>

=46rom: J=C3=BCrgen Kreileder <jk@blackdown.de>

Otherwise when javascript-actions are enabled gitweb shown broken
author names in the tooltips on blame pages ('blame_incremental'
view).

Signed-off-by: J=C3=BCrgen Kreileder <jk@blackdown.de>
Acked-by: Jakub Nar=C4=99bski <jnareb@gmail.com>
---
 gitweb/gitweb.perl |    4 +++-
 1 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index dcf4658..d24763b 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -6244,7 +6244,9 @@ sub git_blame_common {
 			-type=3D>"text/plain", -charset =3D> "utf-8",
 			-status=3D> "200 OK");
 		local $| =3D 1; # output autoflush
-		print while <$fd>;
+		while (my $line =3D <$fd>) {
+			print to_utf8($line);
+		}
 		close $fd
 			or print "ERROR $!\n";
=20
--=20
1.7.6
