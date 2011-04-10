From: =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
Subject: [PATCH] Makefile: extract Q_() source strings as ngettext()
Date: Sun, 10 Apr 2011 19:37:01 +0000
Message-ID: <1302464221-23381-1-git-send-email-avarab@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Apr 10 21:37:19 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q90Re-0004fE-9o
	for gcvg-git-2@lo.gmane.org; Sun, 10 Apr 2011 21:37:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757910Ab1DJThJ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 10 Apr 2011 15:37:09 -0400
Received: from mail-ew0-f46.google.com ([209.85.215.46]:35937 "EHLO
	mail-ew0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753849Ab1DJThI (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 Apr 2011 15:37:08 -0400
Received: by ewy4 with SMTP id 4so1532816ewy.19
        for <git@vger.kernel.org>; Sun, 10 Apr 2011 12:37:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer
         :mime-version:content-type:content-transfer-encoding;
        bh=WKRWuLJjp5Bz+9MfwosoYIx7LX5eG7KoWYkilf4ag2Q=;
        b=oY0hyvh6x8WXeStOVuAHlIQSC2okav5eXXAP2BkuHrjIoJC9OvO2noxTyAcfQYQyNh
         6hWafFNX7IPH2bw8GEjc/qyEaM5pHlHwk0jYhU6hZrsDcKSXiaDR3mTArT5WGYBoITUf
         yTH083DtyvaDuGw3VdJVg3EECR/X+d28s4Bcw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:mime-version
         :content-type:content-transfer-encoding;
        b=kVO1HnNcWPDlikG1U28OkJQsUGlTjO0B5dZSS9IPtdO2ItZLjMCXbHHWvWbKuvwH4f
         uNNd80ACq5FvDnNFK7kUYt5TAscyfhpUpAK/tMAdg6a3xg8c7KdU0xqYDQYEVangvlFv
         SwkdUy+KAS7lrqrptrUmnTRZViXi04/91vJZQ=
Received: by 10.213.13.206 with SMTP id d14mr1727236eba.28.1302464226762;
        Sun, 10 Apr 2011 12:37:06 -0700 (PDT)
Received: from w.nix.is (w.nix.is [188.40.98.140])
        by mx.google.com with ESMTPS id y7sm3227280eeh.21.2011.04.10.12.37.05
        (version=SSLv3 cipher=OTHER);
        Sun, 10 Apr 2011 12:37:06 -0700 (PDT)
X-Mailer: git-send-email 1.7.4.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/171282>

The patch adding the Q_() wrapper function around ngettext[1] didn't
contain a corresponding update to the "pot" target in the Makefile. As
a result "make pot" wouldn't extract gettext messages using the plural
form.

1. added by Jonathan Nieder in v1.7.5-rc0~54^2~2 (i18n: add stub Q_()
   wrapper for ngettext).

Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com=
>
---
 Makefile |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/Makefile b/Makefile
index 92c1c5e..2441d56 100644
--- a/Makefile
+++ b/Makefile
@@ -2051,7 +2051,7 @@ XGETTEXT_FLAGS =3D \
 	--add-comments \
 	--msgid-bugs-address=3D"Git Mailing List <git@vger.kernel.org>" \
 	--from-code=3DUTF-8
-XGETTEXT_FLAGS_C =3D $(XGETTEXT_FLAGS) --keyword=3D_ --keyword=3DN_ --=
language=3DC
+XGETTEXT_FLAGS_C =3D $(XGETTEXT_FLAGS) --keyword=3D_ --keyword=3DN_ --=
keyword=3D"Q_:1,2" --language=3DC
 LOCALIZED_C :=3D $(C_OBJ:o=3Dc)
=20
 po/git.pot: $(LOCALIZED_C)
--=20
1.7.4.1
