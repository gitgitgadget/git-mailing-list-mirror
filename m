From: Jakub Narebski <jnareb@gmail.com>
Subject: [PATCH 3/3] gitweb: Output valid utf8 in git_blame_common('data')
Date: Sat, 17 Dec 2011 10:15:24 +0100
Message-ID: <1324113324-21328-4-git-send-email-jnareb@gmail.com>
References: <1324113324-21328-1-git-send-email-jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Juergen Kreileder <jk@blackdown.de>,
	John Hawley <warthog9@kernel.org>, admin@repo.or.cz
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Dec 17 10:16:47 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RbqNo-0000v5-Ne
	for gcvg-git-2@lo.gmane.org; Sat, 17 Dec 2011 10:16:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751464Ab1LQJQl convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 17 Dec 2011 04:16:41 -0500
Received: from mail-ey0-f174.google.com ([209.85.215.174]:35691 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751086Ab1LQJQI (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 17 Dec 2011 04:16:08 -0500
Received: by mail-ey0-f174.google.com with SMTP id j10so3522742eaa.19
        for <git@vger.kernel.org>; Sat, 17 Dec 2011 01:16:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=xuRjpDWWkvAeJDM7xgZiZ5+6P60PE/GazVIx8GT67z4=;
        b=WfikfSITplYqf7cMKtgx//hw737yziXmPzfgGtMU4Mlx5nbf46SxXZO4HI4nNpy+Rx
         zgKyKNiR7arzY/xeGvuysHIoZ0aS7SrV78TRASxa2TWINk9BqHCsdXbeOMmw0YiQOvRP
         zmC/GOql5RWSr9FUCMJbl1+F3ssGiha7OYHUs=
Received: by 10.213.35.12 with SMTP id n12mr1063658ebd.25.1324113367321;
        Sat, 17 Dec 2011 01:16:07 -0800 (PST)
Received: from localhost.localdomain (abrz159.neoplus.adsl.tpnet.pl. [83.8.119.159])
        by mx.google.com with ESMTPS id q28sm10728465eea.6.2011.12.17.01.16.06
        (version=SSLv3 cipher=OTHER);
        Sat, 17 Dec 2011 01:16:06 -0800 (PST)
X-Mailer: git-send-email 1.7.6
In-Reply-To: <1324113324-21328-1-git-send-email-jnareb@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/187356>

=46rom: J=FCrgen Kreileder <jk@blackdown.de>

Otherwise when javascript-actions are enabled gitweb shown broken
author names in the tooltips on blame pages ('blame_incremental'
view).

Signed-off-by: J=FCrgen Kreileder <jk@blackdown.de>
Acked-by: Jakub Nar=EAbski <jnareb@gmail.com>
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
