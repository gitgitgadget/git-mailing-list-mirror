From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH] send-email: support coloring dry-run output
Date: Thu, 17 May 2012 20:16:36 +0700
Message-ID: <1337260596-15498-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 17 15:20:37 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SV0dA-0003II-KZ
	for gcvg-git-2@plane.gmane.org; Thu, 17 May 2012 15:20:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965807Ab2EQNUa convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 17 May 2012 09:20:30 -0400
Received: from mail-pz0-f46.google.com ([209.85.210.46]:64343 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761885Ab2EQNU3 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 May 2012 09:20:29 -0400
Received: by dady13 with SMTP id y13so2413100dad.19
        for <git@vger.kernel.org>; Thu, 17 May 2012 06:20:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:mime-version
         :content-type:content-transfer-encoding;
        bh=9sb4OcMZ+I7jbQlNVRAOre5EwpKoOpJXXgE5iWL8OvE=;
        b=kYJ1Y+BepQG/qRhbVgwzVQWgNLcTX2mQApsDDHVB4dku/W3aWwF9sLngOCZgm07US7
         qjkzHYZQM4e6W1pGojDRBOI67YC/KQExwAlgXw4EUsdzYZmGiqsjxj2ZclvK1kOM2oAx
         yjXiiK0EmgTGmCAS/iMHUW0rPHmtV5kjnkCVwBoKjxP+p9vqPckc9GPkpTAG1IkTQqRE
         BJ9R4nXapXktkBE8WfwUbIkUr69wyLSn8ZLneAzcVC4RnVAweX3DdnOWJBWz2hX12+ey
         g+raAYc5fnJvE8KLSJ+qbI3HPJmq2VtCjPJJfJRq9IMU9KiBkFtWQjqEZ09bW4jU6wiS
         KSQQ==
Received: by 10.68.225.170 with SMTP id rl10mr27434143pbc.76.1337260828365;
        Thu, 17 May 2012 06:20:28 -0700 (PDT)
Received: from pclouds@gmail.com ([115.74.36.213])
        by mx.google.com with ESMTPS id ud10sm9123219pbc.25.2012.05.17.06.20.23
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 17 May 2012 06:20:26 -0700 (PDT)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Thu, 17 May 2012 20:16:37 +0700
X-Mailer: git-send-email 1.7.10.2.525.gd34301a.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/197917>

It highlights sendmail command and subject lines. The most important
lines to me.

I'm no Perl expert. This patch is by no means for submission. But
maybe it'll motivate someone to do a proper patch.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 git-send-email.perl |    6 +++++-
 1 files changed, 5 insertions(+), 1 deletions(-)

diff --git a/git-send-email.perl b/git-send-email.perl
index ef30c55..033ca5e 100755
--- a/git-send-email.perl
+++ b/git-send-email.perl
@@ -1157,9 +1157,13 @@ X-Mailer: git-send-email $gitversion
 			    print "RCPT TO:<$entry>\n";
 			}
 		} else {
+			print color 'yellow';
 			print "Sendmail: $smtp_server ".join(' ',@sendmail_parameters)."\n"=
;
+			print color 'reset';
 		}
-		print $header, "\n";
+		my $colored_header =3D $header;
+		$colored_header =3D~ s/^(Subject: .*)/color("bold").$1.color("reset"=
)/em;
+		print $colored_header, "\n";
 		if ($smtp) {
 			print "Result: ", $smtp->code, ' ',
 				($smtp->message =3D~ /\n([^\n]+\n)$/s), "\n";
--=20
1.7.8.36.g69ee2
