From: =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
Subject: [PATCH/RFC 20/20] gettextize: git-bisect bisect_next_check "You need to" message
Date: Tue, 14 Sep 2010 13:52:20 +0000
Message-ID: <1284472340-7049-21-git-send-email-avarab@gmail.com>
References: <1284472340-7049-1-git-send-email-avarab@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Sep 14 15:54:22 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OvVxi-0004ov-Vm
	for gcvg-git-2@lo.gmane.org; Tue, 14 Sep 2010 15:54:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753621Ab0INNyJ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 14 Sep 2010 09:54:09 -0400
Received: from mail-ew0-f46.google.com ([209.85.215.46]:44826 "EHLO
	mail-ew0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753556Ab0INNyH (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 14 Sep 2010 09:54:07 -0400
Received: by ewy23 with SMTP id 23so3077305ewy.19
        for <git@vger.kernel.org>; Tue, 14 Sep 2010 06:54:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=rYGIApcwbjIQhmvXMIBWAdeWLoHlI6ePrYpaz76gzwU=;
        b=CvhIQTnVQwvypeaLKSk6rB7gihRgQs0vZIqrqxUWxye5eCl97ZYhI6fSgIzhcn+qcd
         bMuZtb+TbqI+p3hKKdv/F+R3N7RoHhZBaVh5nhZniAov7sd4P4anD2mgjA07KTtmlbUa
         gip2kRTGFux4uLOZ+aiqt5NkLKAuMvEQuqTaQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=HX21CbVY9I2LHPSotKa73Xir/x0XptACOoIobptfNVVun7v7bEDI7E89o5yP6D/KhG
         qMYeoq6gkLSvnRbKGsKLDNkBU1vM34ZCYnBtDex+tEcKBR+vyZ15RgGAn4NhpYueXjAt
         eDan86dQ5/kktFI9j+1+d9kJqQaCTt+6/Q3eo=
Received: by 10.216.59.131 with SMTP id s3mr5793055wec.71.1284472446237;
        Tue, 14 Sep 2010 06:54:06 -0700 (PDT)
Received: from v.nix.is (v.nix.is [109.74.193.250])
        by mx.google.com with ESMTPS id v11sm158854weq.16.2010.09.14.06.54.03
        (version=SSLv3 cipher=RC4-MD5);
        Tue, 14 Sep 2010 06:54:04 -0700 (PDT)
X-Mailer: git-send-email 1.7.3.rc1.234.g8dc15
In-Reply-To: <1284472340-7049-1-git-send-email-avarab@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/156186>

Gettextize the "You need to start by" message in
bisect_next_check. This message assembled English output by hand so it
needed to be split up to make it translatable.

Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com=
>
---
 git-bisect.sh |   19 ++++++++++---------
 1 files changed, 10 insertions(+), 9 deletions(-)

diff --git a/git-bisect.sh b/git-bisect.sh
index b130129..b5836dd 100755
--- a/git-bisect.sh
+++ b/git-bisect.sh
@@ -255,15 +255,16 @@ bisect_next_check() {
 		: bisect without good...
 		;;
 	*)
-		THEN=3D''
-		test -s "$GIT_DIR/BISECT_START" || {
-			echo >&2 'You need to start by "git bisect start".'
-			THEN=3D'then '
-		}
-		echo >&2 'You '$THEN'need to give me at least one good' \
-			'and one bad revisions.'
-		echo >&2 '(You can use "git bisect bad" and' \
-			'"git bisect good" for that.)'
+
+		if test -s "$GIT_DIR/BISECT_START"
+		then
+			echo >&2 "$(gettext "You need to give me at least one good and one =
bad revisions.
+(You can use \"git bisect bad\" and \"git bisect good\" for that.)")"
+		else
+			echo >&2 "$(gettext "You need to start by \"git bisect start\".
+You then need to give me at least one good and one bad revisions.
+(You can use \"git bisect bad\" and \"git bisect good\" for that.)")"
+		fi
 		exit 1 ;;
 	esac
 }
--=20
1.7.3.rc1.234.g8dc15
