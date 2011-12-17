From: Jakub Narebski <jnareb@gmail.com>
Subject: [PATCH 1/3] gitweb: Call to_utf8() on input string in chop_and_escape_str()
Date: Sat, 17 Dec 2011 10:22:21 +0100
Message-ID: <1324113743-21498-2-git-send-email-jnareb@gmail.com>
References: <1324113743-21498-1-git-send-email-jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Juergen Kreileder <jk@blackdown.de>,
	John Hawley <warthog9@kernel.org>, admin@repo.or.cz
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Dec 17 10:23:18 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RbqUA-0002fp-0Y
	for gcvg-git-2@lo.gmane.org; Sat, 17 Dec 2011 10:23:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751598Ab1LQJXM convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 17 Dec 2011 04:23:12 -0500
Received: from mail-ee0-f46.google.com ([74.125.83.46]:57049 "EHLO
	mail-ee0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751502Ab1LQJXF (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 17 Dec 2011 04:23:05 -0500
Received: by eekc4 with SMTP id c4so3913384eek.19
        for <git@vger.kernel.org>; Sat, 17 Dec 2011 01:23:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=UmBUY0G1lChBfiAwmXsrYkS6XCB3RgKbG7p2ifuJb9U=;
        b=ahqsQ+BQxROtM8yyUo74WDZbHLAyqnIP7Ymw8OhHvrybTlniMrfg7+UYPAMLAl9rF6
         6x+jNGnqVdaI6Oj9fI5GvskNnb3sE/Xaas9B6BNzeOicR9Mzjv/fpce5M9d2LxGweRAM
         EYtMlSov38RfitFl3n1Los9kcFRW1mUcYfWoQ=
Received: by 10.14.95.140 with SMTP id p12mr889915eef.105.1324113784118;
        Sat, 17 Dec 2011 01:23:04 -0800 (PST)
Received: from localhost.localdomain (abrz159.neoplus.adsl.tpnet.pl. [83.8.119.159])
        by mx.google.com with ESMTPS id 58sm10768875eet.11.2011.12.17.01.23.02
        (version=SSLv3 cipher=OTHER);
        Sat, 17 Dec 2011 01:23:03 -0800 (PST)
X-Mailer: git-send-email 1.7.6
In-Reply-To: <1324113743-21498-1-git-send-email-jnareb@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/187357>

=46rom: J=C3=BCrgen Kreileder <jk@blackdown.de>

a) To fix the comparison with the chopped string,
   otherwise we compare bytes with characters, as
   chop_str() must run to_utf8() for correct operation
b) To give the title attribute correct encoding;
   we need to mark strings as UTF-8 before outpur

Signed-off-by: J=C3=BCrgen Kreileder <jk@blackdown.de>
Acked-by: Jakub Nar=C4=99bski <jnareb@gmail.com>
---
 gitweb/gitweb.perl |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index f80f259..35126cd 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -1696,6 +1696,7 @@ sub chop_and_escape_str {
 	my ($str) =3D @_;
=20
 	my $chopped =3D chop_str(@_);
+	$str =3D to_utf8($str);
 	if ($chopped eq $str) {
 		return esc_html($chopped);
 	} else {
--=20
1.7.6
