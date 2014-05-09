From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v1 10/25] contrib: reomve 'thunderbird-patch-inline'
Date: Thu,  8 May 2014 19:58:21 -0500
Message-ID: <1399597116-1851-11-git-send-email-felipe.contreras@gmail.com>
References: <1399597116-1851-1-git-send-email-felipe.contreras@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 09 03:11:04 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WiZL0-0000zM-VJ
	for gcvg-git-2@plane.gmane.org; Fri, 09 May 2014 03:10:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756066AbaEIBKR convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 8 May 2014 21:10:17 -0400
Received: from mail-yk0-f178.google.com ([209.85.160.178]:50446 "EHLO
	mail-yk0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756058AbaEIBKP (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 May 2014 21:10:15 -0400
Received: by mail-yk0-f178.google.com with SMTP id 20so2891315yks.37
        for <git@vger.kernel.org>; Thu, 08 May 2014 18:10:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=XCut3KJ6utYTQHrhrGlA0POql4CXhjY7x3FWS3kOsEM=;
        b=sJiGgdoAUT+TlabsKLTzuxWMNvmbyAJxsDt88/ef+GaOKgHMLVu5YflyYOPEazs0tD
         VGdPBqSb+1SE+mExKEqTD+jovMMmuZMyHyrJTrabRKa3ZOVXTd09Ng5y97Z2Lpaovhwb
         VOJUlKX9/mnQrHF2RPzmGrMXYMovjUWKo1kBH4r59BScpTCEDSm5OaW0jjH4k5YqtPnV
         64R5UvFebTFWgOojBfUIRI0y87PA3cNYqlMgINseDNV3eXCfthSnFcZ0Cfee6i28Ue3+
         31EVdldx6BkfsrDlqeicp2cCIJrevEUbJgDDSQf265FYN2uHo8Q43N2Rw9h0wA1B5aD+
         U3dQ==
X-Received: by 10.236.160.165 with SMTP id u25mr10118788yhk.39.1399597815207;
        Thu, 08 May 2014 18:10:15 -0700 (PDT)
Received: from localhost (189-211-224-40.static.axtel.net. [189.211.224.40])
        by mx.google.com with ESMTPSA id k70sm3914016yhm.38.2014.05.08.18.10.10
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 08 May 2014 18:10:12 -0700 (PDT)
X-Mailer: git-send-email 1.9.2+fc1.27.gbce2056
In-Reply-To: <1399597116-1851-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/248483>

No activity, no tests.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 contrib/thunderbird-patch-inline/README  | 20 ------------
 contrib/thunderbird-patch-inline/appp.sh | 55 ------------------------=
--------
 2 files changed, 75 deletions(-)
 delete mode 100644 contrib/thunderbird-patch-inline/README
 delete mode 100755 contrib/thunderbird-patch-inline/appp.sh

diff --git a/contrib/thunderbird-patch-inline/README b/contrib/thunderb=
ird-patch-inline/README
deleted file mode 100644
index 000147b..0000000
--- a/contrib/thunderbird-patch-inline/README
+++ /dev/null
@@ -1,20 +0,0 @@
-appp.sh is a script that is supposed to be used together with External=
Editor
-for Mozilla Thunderbird. It will let you include patches inline in e-m=
ails
-in an easy way.
-
-Usage:
-- Generate the patch with git format-patch.
-- Start writing a new e-mail in Thunderbird.
-- Press the external editor button (or Ctrl-E) to run appp.sh
-- Select the previously generated patch file.
-- Finish editing the e-mail.
-
-Any text that is entered into the message editor before appp.sh is cal=
led
-will be moved to the section between the --- and the diffstat.
-
-All S-O-B:s and Cc:s in the patch will be added to the CC list.
-
-To set it up, just install External Editor and tell it to use appp.sh =
as the
-editor.
-
-Zenity is a required dependency.
diff --git a/contrib/thunderbird-patch-inline/appp.sh b/contrib/thunder=
bird-patch-inline/appp.sh
deleted file mode 100755
index 8dc73ec..0000000
--- a/contrib/thunderbird-patch-inline/appp.sh
+++ /dev/null
@@ -1,55 +0,0 @@
-#!/bin/sh
-# Copyright 2008 Lukas Sandstr=C3=B6m <luksan@gmail.com>
-#
-# AppendPatch - A script to be used together with ExternalEditor
-# for Mozilla Thunderbird to properly include patches inline in e-mail=
s.
-
-# ExternalEditor can be downloaded at http://globs.org/articles.php?ln=
g=3Den&pg=3D2
-
-CONFFILE=3D~/.appprc
-
-SEP=3D"-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D# Don't remove this line #=3D=
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-"
-if [ -e "$CONFFILE" ] ; then
-	LAST_DIR=3D$(grep -m 1 "^LAST_DIR=3D" "${CONFFILE}"|sed -e 's/^LAST_D=
IR=3D//')
-	cd "${LAST_DIR}"
-else
-	cd > /dev/null
-fi
-
-PATCH=3D$(zenity --file-selection)
-
-if [ "$?" !=3D "0" ] ; then
-	#zenity --error --text "No patchfile given."
-	exit 1
-fi
-
-cd - > /dev/null
-
-SUBJECT=3D$(sed -n -e '/^Subject: /p' "${PATCH}")
-HEADERS=3D$(sed -e '/^'"${SEP}"'$/,$d' $1)
-BODY=3D$(sed -e "1,/${SEP}/d" $1)
-CMT_MSG=3D$(sed -e '1,/^$/d' -e '/^---$/,$d' "${PATCH}")
-DIFF=3D$(sed -e '1,/^---$/d' "${PATCH}")
-
-CCS=3D`echo -e "$CMT_MSG\n$HEADERS" | sed -n -e 's/^Cc: \(.*\)$/\1,/gp=
' \
-	-e 's/^Signed-off-by: \(.*\)/\1,/gp'`
-
-echo "$SUBJECT" > $1
-echo "Cc: $CCS" >> $1
-echo "$HEADERS" | sed -e '/^Subject: /d' -e '/^Cc: /d' >> $1
-echo "$SEP" >> $1
-
-echo "$CMT_MSG" >> $1
-echo "---" >> $1
-if [ "x${BODY}x" !=3D "xx" ] ; then
-	echo >> $1
-	echo "$BODY" >> $1
-	echo >> $1
-fi
-echo "$DIFF" >> $1
-
-LAST_DIR=3D$(dirname "${PATCH}")
-
-grep -v "^LAST_DIR=3D" "${CONFFILE}" > "${CONFFILE}_"
-echo "LAST_DIR=3D${LAST_DIR}" >> "${CONFFILE}_"
-mv "${CONFFILE}_" "${CONFFILE}"
--=20
1.9.2+fc1.27.gbce2056
