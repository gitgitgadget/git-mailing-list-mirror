From: =?UTF-8?q?Micha=C5=82=20Kiedrowicz?= <michal.kiedrowicz@gmail.com>
Subject: [PATCH v3 1/8] gitweb: Use descriptive names in esc_html_hl_regions()
Date: Wed,  4 Apr 2012 21:57:06 +0200
Message-ID: <1333569433-3245-2-git-send-email-michal.kiedrowicz@gmail.com>
References: <1333569433-3245-1-git-send-email-michal.kiedrowicz@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jakub Narebski <jnareb@gmail.com>,
	=?UTF-8?q?Micha=C5=82=20Kiedrowicz?= <michal.kiedrowicz@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Apr 04 21:57:37 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SFWKk-0001cc-Ji
	for gcvg-git-2@plane.gmane.org; Wed, 04 Apr 2012 21:57:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932620Ab2DDT5Z convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 4 Apr 2012 15:57:25 -0400
Received: from mail-wi0-f178.google.com ([209.85.212.178]:53202 "EHLO
	mail-wi0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932586Ab2DDT5X (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Apr 2012 15:57:23 -0400
Received: by wibhq7 with SMTP id hq7so630903wib.1
        for <git@vger.kernel.org>; Wed, 04 Apr 2012 12:57:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=RiPtXM0TsaecZ4O0TVoW8nvN9Zy2De0jcJi9qGpNWO0=;
        b=vWHkLjwyPi7loNLkDndbwuZfBnJNsOYPSspUzVnFxGeNQysrQDWS5ZUZKFDTFhTaXe
         umFwxuEPr8NrArUgP18Qahej+UF34Rc7HeYF/XliINMYkejx5xTWNB8Cd0Tw6yirAc5p
         qRhH6kPNuy8Z6MJWWqowtHE9H5QYsl2uhzAY7+JNQ/L1xEVP/WgMaX2zg9QMsGAvyf3o
         9YvIUwezNksRqrJlZVgvbOYr7UZTCJ+TjuNkZEgapKhue7vndNCiNDMiMKYLXYq9bBuG
         9TBSLHVonB3UD6UlxBo+AK2Y4GbhUniscEvTXH68vzsG/T+GpfYS5nFJzYuG/STkP//j
         45Hw==
Received: by 10.216.132.216 with SMTP id o66mr2212879wei.14.1333569441673;
        Wed, 04 Apr 2012 12:57:21 -0700 (PDT)
Received: from localhost (77-177-78-94.net.stream.pl. [94.78.177.77])
        by mx.google.com with ESMTPS id bx13sm7349794wib.10.2012.04.04.12.57.20
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 04 Apr 2012 12:57:21 -0700 (PDT)
X-Mailer: git-send-email 1.7.8.4
In-Reply-To: <1333569433-3245-1-git-send-email-michal.kiedrowicz@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/194727>

The $s->[0] and $s->[1] variables look a bit cryptic.  Let's rename the=
m
to $beg and $end so that it's clear what they do.

Suggested-by: Jakub Nar=C4=99bski <jnareb@gmail.com>
Signed-off-by: Micha=C5=82 Kiedrowicz <michal.kiedrowicz@gmail.com>
---
 gitweb/gitweb.perl |   10 ++++++----
 1 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index a8b5fad..a3754ff 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -1738,12 +1738,14 @@ sub esc_html_hl_regions {
 	my $pos =3D 0;
=20
 	for my $s (@sel) {
-		$out .=3D esc_html(substr($str, $pos, $s->[0] - $pos))
-			if ($s->[0] - $pos > 0);
+		my ($beg, $end) =3D @$s;
+
+		$out .=3D esc_html(substr($str, $pos, $beg - $pos))
+			if ($beg - $pos > 0);
 		$out .=3D $cgi->span({-class =3D> $css_class},
-		                   esc_html(substr($str, $s->[0], $s->[1] - $s->[0])=
));
+		                   esc_html(substr($str, $beg, $end - $beg)));
=20
-		$pos =3D $s->[1];
+		$pos =3D $end;
 	}
 	$out .=3D esc_html(substr($str, $pos))
 		if ($pos < length($str));
--=20
1.7.8.4
