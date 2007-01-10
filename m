From: Juergen Ruehle <j.ruehle@bmiag.de>
Subject: [PATCH] Quick hack to avoid double qp encoding
Date: Wed, 10 Jan 2007 21:07:17 +0100
Message-ID: <11684596371612-git-send-email-j.ruehle@bmiag.de>
References: <17829.12657.814000.514351@lapjr.intranet.kiel.bmiag.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org,
	=?utf-8?q?J=C3=BCrgen_R=C3=BChle?= <j-r@online.de>
X-From: git-owner@vger.kernel.org Wed Jan 10 21:07:55 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H4jje-0004bS-Mw
	for gcvg-git@gmane.org; Wed, 10 Jan 2007 21:07:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965062AbXAJUHo (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 10 Jan 2007 15:07:44 -0500
X-Warning: Original message contained 8-bit characters, however during
	   the SMTP transport session the receiving system did not announce
	   capability of receiving 8-bit SMTP (RFC 1651-1653), and as this
	   message does not have MIME headers (RFC 2045-2049) to enable
	   encoding change, we had very little choice.
X-Warning: We ASSUME it is less harmful to add the MIME headers, and
	   convert the text to Quoted-Printable, than not to do so,
	   and to strip the message to 7-bits.. (RFC 1428 Appendix A)
X-Warning: We don't know what character set the user used, thus we had to
	   write these MIME-headers with our local system default value.
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965065AbXAJUHo
	(ORCPT <rfc822;git-outgoing>); Wed, 10 Jan 2007 15:07:44 -0500
Received: from meriadoc.bmiag.de ([62.154.210.133]:56902 "EHLO
	meriadoc.bmiag.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965062AbXAJUHn (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Jan 2007 15:07:43 -0500
Received: from localhost (localhost.localdomain [127.0.0.1])
	by meriadoc.bmiag.de (Postfix) with ESMTP id 4AFF13AED7;
	Wed, 10 Jan 2007 21:07:41 +0100 (CET)
Received: from meriadoc.bmiag.de ([127.0.0.1])
	by localhost (meriadoc [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 18203-02; Wed, 10 Jan 2007 21:07:41 +0100 (CET)
Received: from eorl.intranet.kiel.bmiag.de (eorl.intranet.kiel.bmiag.de [10.131.2.1])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by meriadoc.bmiag.de (Postfix) with ESMTP id 6C2383AED2;
	Wed, 10 Jan 2007 21:07:30 +0100 (CET)
Received: from localhost (localhost.localdomain [127.0.0.1])
	by eorl.intranet.kiel.bmiag.de (Postfix) with ESMTP id 414533ADC8;
	Wed, 10 Jan 2007 21:07:30 +0100 (CET)
Received: from eorl.intranet.kiel.bmiag.de ([127.0.0.1])
	by localhost (eorl [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
	id 22963-06; Wed, 10 Jan 2007 21:07:25 +0100 (CET)
Received: from localhost.localdomain (dialin5.galadriel.bmiag.de [192.168.251.5])
	by eorl.intranet.kiel.bmiag.de (Postfix) with ESMTP id 874C73ADC6;
	Wed, 10 Jan 2007 21:07:19 +0100 (CET)
To: Junio C Hamano <junkio@cox.net>
X-Mailer: git-send-email 1.5.0.rc0.g525e
In-Reply-To: <17829.12657.814000.514351@lapjr.intranet.kiel.bmiag.de>
X-Virus-Scanned: by amavisd-new-20030616-p10 (Debian) at eorl.intranet.kiel.bmiag.de
X-Virus-Scanned: by amavisd-new-20030616-p10 (Debian) at meriadoc.bmiag.de
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/36526>

=46rom: J=C3=BCrgen_R=C3=BChle <j-r@online.de>

Signed-off-by: J=C3=BCrgen R=C3=BChle <j-r@online.de>
---
 This is just a hack since I know next to nothing about perl.

 git-send-email.perl |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/git-send-email.perl b/git-send-email.perl
index ba39d39..a4a22d3 100755
--- a/git-send-email.perl
+++ b/git-send-email.perl
@@ -555,6 +555,7 @@ foreach my $t (@files) {
 	}
 	close F;
 	if (defined $author_not_sender) {
+		$author_not_sender =3D~ s/=3D\?utf-8\?q\?([^?]*)\?=3D/my $bla =3D $1=
; $bla =3D~ s|=3D([0-9a-fA-F]{2})|sprintf '%c', hex($1)|eg; $bla/eg;
 		$message =3D "From: $author_not_sender\n\n$message";
 	}
=20
--=20
1.5.0.rc0.g525e
