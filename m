From: =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
Subject: [PATCH 12/16] send-email: is_rfc2047_quoted use qr// regexes
Date: Thu, 30 Sep 2010 13:43:05 +0000
Message-ID: <1285854189-10240-13-git-send-email-avarab@gmail.com>
References: <1285854189-10240-1-git-send-email-avarab@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Thomas Rast <trast@student.ethz.ch>,
	Ryan Anderson <rda@google.com>,
	Jay Soffian <jaysoffian@gmail.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Sep 30 15:44:48 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P1JRG-0001Kp-1p
	for gcvg-git-2@lo.gmane.org; Thu, 30 Sep 2010 15:44:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756080Ab0I3Nof convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 30 Sep 2010 09:44:35 -0400
Received: from mail-ww0-f48.google.com ([74.125.82.48]:55448 "EHLO
	mail-ww0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756078Ab0I3Noe (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 30 Sep 2010 09:44:34 -0400
Received: by wwb22 with SMTP id 22so762927wwb.5
        for <git@vger.kernel.org>; Thu, 30 Sep 2010 06:44:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=/zsse0RVfHfuns/ZB5qDVRHwegR+vxL95iNdpE47hD4=;
        b=G04gfRhxpGHPxSJu2y3Fj2iXk4ySdmFD4KN1r611RgGok81D1yW/UF8n8uqXy6cGMb
         XYiKvpru8hhOc6vVjyUrWeF1YfqQg65AYvQesegjwBbXrWlx4yC4cSZ8JxHQCAv1Ih9P
         A8CSWbosMOkYsKdCuWZgIA/P6Q94al1DIcRsU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=FJuiU2LbHguSF/s6IdXDaHYLQ71mbhduPujog4Lckt2KejPCJ/g6YhEGW9SyLfDFTa
         kOm5l8IaXEBdUYEg88e3acxS8/Fw7ivPbwsJ69OcpOQQwPITZdQMNRhI5ZFIKzb6oVKU
         Yt3roVFh+BXkDbNhW4y0K6ia9P9kVFQINaTCE=
Received: by 10.227.133.11 with SMTP id d11mr2916190wbt.199.1285854272668;
        Thu, 30 Sep 2010 06:44:32 -0700 (PDT)
Received: from v.nix.is (v.nix.is [109.74.193.250])
        by mx.google.com with ESMTPS id e56sm6328567wer.46.2010.09.30.06.44.31
        (version=SSLv3 cipher=RC4-MD5);
        Thu, 30 Sep 2010 06:44:31 -0700 (PDT)
X-Mailer: git-send-email 1.7.3.159.g610493
In-Reply-To: <1285854189-10240-1-git-send-email-avarab@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/157662>

Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com=
>
---
 git-send-email.perl |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/git-send-email.perl b/git-send-email.perl
index 5a0c4a8..b87c3f2 100755
--- a/git-send-email.perl
+++ b/git-send-email.perl
@@ -852,8 +852,8 @@ sub quote_rfc2047 {
=20
 sub is_rfc2047_quoted {
 	my $s =3D shift;
-	my $token =3D '[^][()<>@,;:"\/?.=3D \000-\037\177-\377]+';
-	my $encoded_text =3D '[!->@-~]+';
+	my $token =3D qr/[^][()<>@,;:"\/?.=3D \000-\037\177-\377]+/;
+	my $encoded_text =3D qr/[!->@-~]+/;
 	length($s) <=3D 75 &&
 	$s =3D~ m/^(?:"[[:ascii:]]*"|=3D\?$token\?$token\?$encoded_text\?=3D)=
$/o;
 }
--=20
1.7.3.159.g610493
