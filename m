From: =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
Subject: [PATCH v2 48/48] i18n: git-bisect bisect_next_check "You need to" message
Date: Sat, 21 May 2011 18:44:29 +0000
Message-ID: <1306003469-22939-49-git-send-email-avarab@gmail.com>
References: <1306003469-22939-1-git-send-email-avarab@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat May 21 20:46:37 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QNrC5-0000od-Hu
	for gcvg-git-2@lo.gmane.org; Sat, 21 May 2011 20:46:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757152Ab1EUSqW convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 21 May 2011 14:46:22 -0400
Received: from mail-ew0-f46.google.com ([209.85.215.46]:45234 "EHLO
	mail-ew0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757025Ab1EUSpr (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 21 May 2011 14:45:47 -0400
Received: by mail-ew0-f46.google.com with SMTP id 4so1451059ewy.19
        for <git@vger.kernel.org>; Sat, 21 May 2011 11:45:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer
         :in-reply-to:references:mime-version:content-type
         :content-transfer-encoding;
        bh=jcfRVJOjXVDPUyzexCaCC3d9F2H/JCRTigwJqfn4Elc=;
        b=Q/ylFJKns+/dRZ7MSrDCEhpXctzGp6DH1OCyx+SJ2O57TNQUUf+pYUro3UzhsCJGj3
         AvWs35Dj/pkRCymugpDbu6WiAbWlXSa4GdBZvoXDKF4qIMPOxDU9F56oF8aELKanN1AG
         yNES7OLp5MydJZZpk4QIx1/RyM2qfiGpUCPQ0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=RFaeG6cnnJV/AM7HHcVYzWDzIg7DrJyFDEKc64Gf2bQBs4AAH2SfBVxwFJxU4sW5/T
         LTwxx+qLgt5FWbaYlJJcQXU6sbX1t5Pl6ebT6Ci4imSZkTUVpn8KVTQ55dEm7tjM+ysU
         73QKg9hfTe7zgaRxSBZOBSPqoYVHsDKCRnXiw=
Received: by 10.213.26.136 with SMTP id e8mr580811ebc.9.1306003546718;
        Sat, 21 May 2011 11:45:46 -0700 (PDT)
Received: from w.nix.is (w.nix.is [188.40.98.140])
        by mx.google.com with ESMTPS id y14sm1130434eeh.3.2011.05.21.11.45.45
        (version=SSLv3 cipher=OTHER);
        Sat, 21 May 2011 11:45:46 -0700 (PDT)
X-Mailer: git-send-email 1.7.5.1
In-Reply-To: <1306003469-22939-1-git-send-email-avarab@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/174139>

Gettextize the "You need to start by" message in
bisect_next_check. This message assembled English output by hand so it
needed to be split up to make it translatable.

Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com=
>
---
 git-bisect.sh |   25 ++++++++++++++++---------
 1 files changed, 16 insertions(+), 9 deletions(-)

diff --git a/git-bisect.sh b/git-bisect.sh
index 4416455..375b187 100755
--- a/git-bisect.sh
+++ b/git-bisect.sh
@@ -261,15 +261,22 @@ bisect_next_check() {
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
+			(
+				gettext "You need to give me at least one good and one bad revisio=
ns.
+(You can use \"git bisect bad\" and \"git bisect good\" for that.)" &&
+				echo
+			) >&2
+		else
+			(
+				gettext "You need to start by \"git bisect start\".
+You then need to give me at least one good and one bad revisions.
+(You can use \"git bisect bad\" and \"git bisect good\" for that.)" &&
+				echo
+			) >&2
+		fi
 		exit 1 ;;
 	esac
 }
--=20
1.7.5.1
