From: =?UTF-8?Q?J=C3=BCrgen_Kreileder?= <jk@blackdown.de>
Subject: [PATCH] gitweb: Call to_utf8() on input string in chop_and_escape_str()
Date: Tue, 29 Nov 2011 22:41:40 +0100
Message-ID: <CAKD0Uuy8y7Dc6gfvYVe-FJ=Reiu0M3wOY4r4VVPtEYmahZcdwA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Tue Nov 29 22:42:14 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RVVRJ-0002Vf-Tr
	for gcvg-git-2@lo.gmane.org; Tue, 29 Nov 2011 22:42:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754879Ab1K2VmF convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 29 Nov 2011 16:42:05 -0500
Received: from mail-fx0-f46.google.com ([209.85.161.46]:34578 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754487Ab1K2VmB convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 29 Nov 2011 16:42:01 -0500
Received: by faaq16 with SMTP id q16so153882faa.19
        for <git@vger.kernel.org>; Tue, 29 Nov 2011 13:42:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackdown.de; s=google;
        h=mime-version:from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=0dI2qN5QlypQyjCRl7ZwtW7QUtemkoP2Sa4NlEjlqSY=;
        b=Me6SpgLV/9q02lV2AUaISOh/V2XBHFIi54YcPO4baULOKrowPVys7pEAIJBi7t8Tw+
         D+GZBq+maWDff7Mw5CboBCeH/PM1LPgU3hw5NquO2irGZ+RsUXtWRmqeILyiTX44adCn
         RcbA/CHuZsfc5B1FXazOgu3k7/g2TEeMZIpWs=
Received: by 10.180.74.141 with SMTP id t13mr49049525wiv.68.1322602920414;
 Tue, 29 Nov 2011 13:42:00 -0800 (PST)
Received: by 10.180.87.37 with HTTP; Tue, 29 Nov 2011 13:41:40 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/186087>

a) To fix the comparison with the chopped string
b) To give the title attribute correct encoding

Signed-off-by: J=C3=BCrgen Kreileder <jk@blackdown.de>
---
 gitweb/gitweb.perl |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index 4f0c3bd..4237ea6 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -1695,11 +1695,11 @@ sub chop_and_escape_str {
 	my ($str) =3D @_;

 	my $chopped =3D chop_str(@_);
-	if ($chopped eq $str) {
+	if ($chopped eq to_utf8($str)) {
 		return esc_html($chopped);
 	} else {
 		$str =3D~ s/[[:cntrl:]]/?/g;
-		return $cgi->span({-title=3D>$str}, esc_html($chopped));
+		return $cgi->span({-title =3D> to_utf8($str)}, esc_html($chopped));
 	}
 }

--=20
1.7.5.4
