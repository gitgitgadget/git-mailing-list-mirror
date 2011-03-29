From: Maxin john <maxin@maxinbjohn.info>
Subject: contrib/thunderbird-patch-inline: do not require /bin/bash to run
Date: Tue, 29 Mar 2011 10:08:07 +0300
Message-ID: <AANLkTinUh0BX3O+2Y1CiUTx7xvzW6ydrAGiGQUx4pbeP@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?ISO-8859-1?Q?=C1ngel_Gonz=E1lez?= <ingenit@zoho.com>,
	=?ISO-8859-1?Q?Lukas_Sandstr=F6m?= <luksan@gmail.com>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Mar 29 09:08:15 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q4T2F-0007m7-8M
	for gcvg-git-2@lo.gmane.org; Tue, 29 Mar 2011 09:08:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751729Ab1C2HIK convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 29 Mar 2011 03:08:10 -0400
Received: from mail-gx0-f174.google.com ([209.85.161.174]:50939 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751376Ab1C2HIJ convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 29 Mar 2011 03:08:09 -0400
Received: by gxk21 with SMTP id 21so1478384gxk.19
        for <git@vger.kernel.org>; Tue, 29 Mar 2011 00:08:08 -0700 (PDT)
Received: by 10.150.47.2 with SMTP id u2mr5163139ybu.340.1301382487824; Tue,
 29 Mar 2011 00:08:07 -0700 (PDT)
Received: by 10.150.139.2 with HTTP; Tue, 29 Mar 2011 00:08:07 -0700 (PDT)
X-Originating-IP: [91.154.177.92]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/170235>

contrib/thunderbird-patch-inline: do not require /bin/bash to run

Modified the patch by incorporating the suggestions from =C1ngel
Gonz=E1lez <ingenit@zoho.com> and Junio C Hamano <gitster@pobox.com>

Signed-off-by: Maxin B. John <maxin@maxinbjohn.info>
---
diff --git a/contrib/thunderbird-patch-inline/appp.sh
b/contrib/thunderbird-patch-inline/appp.sh
index cc518f3..1d109a5 100755
--- a/contrib/thunderbird-patch-inline/appp.sh
+++ b/contrib/thunderbird-patch-inline/appp.sh
@@ -1,8 +1,8 @@
-#!/bin/bash
+#!/bin/sh
 # Copyright 2008 Lukas Sandstr=F6m <luksan@gmail.com>
 #
 # AppendPatch - A script to be used together with ExternalEditor
-# for Mozilla Thunderbird to properly include pathes inline i e-mails.
+# for Mozilla Thunderbird to properly include patches inline in e-mail=
s.

 # ExternalEditor can be downloaded at http://globs.org/articles.php?ln=
g=3Den&pg=3D2

@@ -16,7 +16,12 @@ else
        cd > /dev/null
 fi

-PATCH=3D$(zenity --file-selection)
+#check whether zenity is present
+if ! type zenity >/dev/null 2>&1 ; then
+       exit 1
+fi
+
+PATCH=3D`zenity --file-selection`

 if [ "$?" !=3D "0" ] ; then
        #zenity --error --text "No patchfile given."
