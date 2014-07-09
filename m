From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v6 14/32] git-sh-setup.sh: use rev-parse --git-path to get $GIT_DIR/objects
Date: Wed,  9 Jul 2014 14:32:59 +0700
Message-ID: <1404891197-18067-15-git-send-email-pclouds@gmail.com>
References: <1404891197-18067-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jul 09 09:34:53 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X4mOu-0003fv-LM
	for gcvg-git-2@plane.gmane.org; Wed, 09 Jul 2014 09:34:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754840AbaGIHeo convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 9 Jul 2014 03:34:44 -0400
Received: from mail-pd0-f171.google.com ([209.85.192.171]:59049 "EHLO
	mail-pd0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754753AbaGIHeo (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 Jul 2014 03:34:44 -0400
Received: by mail-pd0-f171.google.com with SMTP id fp1so8561311pdb.2
        for <git@vger.kernel.org>; Wed, 09 Jul 2014 00:34:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=y4fjiYOCRQyT1y3KXCYFMRdCUViRVbjaw2FcmxnpjJY=;
        b=k4GmeJ3g1970/nN5rqDk2kAxXc4HI18/XknZIa9RYBOSkgwZGIplOc7hTVmcT/ynMA
         1TSl2h8WQJYIIZdcpgiDwZrdpmP1Sb5w2tsPyVZ9X5KpSPMWy1I/7KN6tIQT5E81gviY
         KnzrcIOeshlc65BwJQzvNGxecLBjqlLOJRUtdFPfab3nMhvpWvHWOF7Fs6ebkLj62TF+
         vvaTJxTNsgubTbpKHgYJuO6+M5OnV9k2kOsWymCqer+FGc4+TGj16WNtVlEVoOO3QP1P
         6bwnt4l4P0VpVmLB8F+lpeiQ1c2hayHwLZopIMQUKBIq5qPwQWQD+fV0fvevEaAPKKIf
         whtg==
X-Received: by 10.68.181.165 with SMTP id dx5mr40233223pbc.38.1404891283783;
        Wed, 09 Jul 2014 00:34:43 -0700 (PDT)
Received: from lanh ([115.73.209.165])
        by mx.google.com with ESMTPSA id hs5sm57903138pbb.92.2014.07.09.00.34.41
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 09 Jul 2014 00:34:43 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Wed, 09 Jul 2014 14:34:38 +0700
X-Mailer: git-send-email 1.9.1.346.ga2b5940
In-Reply-To: <1404891197-18067-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/253089>

If $GIT_COMMON_DIR is set, $GIT_OBJECT_DIRECTORY should be
$GIT_COMMON_DIR/objects, not $GIT_DIR/objects. Just let rev-parse
--git-path handle it.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 git-sh-setup.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/git-sh-setup.sh b/git-sh-setup.sh
index 9447980..d3dbb2f 100644
--- a/git-sh-setup.sh
+++ b/git-sh-setup.sh
@@ -345,7 +345,7 @@ then
 		echo >&2 "Unable to determine absolute path of git directory"
 		exit 1
 	}
-	: ${GIT_OBJECT_DIRECTORY=3D"$GIT_DIR/objects"}
+	: ${GIT_OBJECT_DIRECTORY=3D"$(git rev-parse --git-path objects)"}
 fi
=20
 peel_committish () {
--=20
1.9.1.346.ga2b5940
