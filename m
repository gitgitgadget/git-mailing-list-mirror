From: Alexey Shumkin <alex.crezoff@gmail.com>
Subject: [PATCH 3/3] mergetool--lib: Add TortoiseMerge as a tool
Date: Thu, 24 Jan 2013 11:16:08 +0400
Message-ID: <1359011768-7665-3-git-send-email-Alex.Crezoff@gmail.com>
References: <1359011768-7665-1-git-send-email-Alex.Crezoff@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Pat Thoyts <patthoyts@users.sourceforge.net>,
	Alexey Shumkin <Alex.Crezoff@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jan 24 08:17:45 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TyH4C-0002ze-LX
	for gcvg-git-2@plane.gmane.org; Thu, 24 Jan 2013 08:17:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752426Ab3AXHRY convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 24 Jan 2013 02:17:24 -0500
Received: from mail-la0-f54.google.com ([209.85.215.54]:41507 "EHLO
	mail-la0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751776Ab3AXHRW (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Jan 2013 02:17:22 -0500
Received: by mail-la0-f54.google.com with SMTP id gw10so8982596lab.27
        for <git@vger.kernel.org>; Wed, 23 Jan 2013 23:17:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references:mime-version:content-type:content-transfer-encoding;
        bh=+FvFIqHp5TrEjkSlOCei7Q3K3daxWn+K69PrBAq4kwE=;
        b=KLfj9o3wUs7FWlhIorSwsY6OZ0rPjQOkYlwDDKS6lh1tk0KnaC0F73//FrfC/n9W10
         LV2cZ+QSnTRHzp70FgWu6BekeDWhaSEpDMlFk67Vm2v939Q7IPzAC+3iNSPE3NB3cSlF
         cw2zT3rRMeLosOYd+on1UkFkwcjA3F64YeRaDL7gVI3M2OZfiuca9dqWj3JVfUyR/WPL
         OnOL/m6sUJRXcnEniDQycLspLN2FBp6HEPmEfZhiwkJXbffKG45K75tvySHLkISrlAQM
         ciSzXkGFAinUYh3E+bFltKKNQbXva9bWXTUHH9z1lwD17yKcnOweBLQvJspUDw+iQl6g
         KIng==
X-Received: by 10.152.104.199 with SMTP id gg7mr876178lab.14.1359011841460;
        Wed, 23 Jan 2013 23:17:21 -0800 (PST)
Received: from ds212plus (ppp91-77-44-105.pppoe.mtu-net.ru. [91.77.44.105])
        by mx.google.com with ESMTPS id q4sm9194510lbj.15.2013.01.23.23.17.19
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Wed, 23 Jan 2013 23:17:20 -0800 (PST)
Received: from localhost (localhost [127.0.0.1])
	by ds212plus (Postfix) with ESMTP id B761B60002;
	Thu, 24 Jan 2013 11:17:46 +0400 (MSK)
X-Mailer: git-send-email 1.8.1.1.10.g9255f3f
In-Reply-To: <1359011768-7665-1-git-send-email-Alex.Crezoff@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/214407>

Also added Russian translation of the added error message
"%s cannot be used without a base"

Signed-off-by: Alexey Shumkin <Alex.Crezoff@gmail.com>
---
 git-gui/lib/mergetool.tcl | 10 ++++++++++
 git-gui/po/ru.po          |  4 ++++
 2 files changed, 14 insertions(+)

diff --git a/git-gui/lib/mergetool.tcl b/git-gui/lib/mergetool.tcl
index 837ce17..d978770 100644
--- a/git-gui/lib/mergetool.tcl
+++ b/git-gui/lib/mergetool.tcl
@@ -257,6 +257,16 @@ proc merge_resolve_tool2 {} {
 			set cmdline [list "$merge_tool_path" -o "$MERGED" "$LOCAL" "$REMOTE=
"]
 		}
 	}
+	tortoisemerge {
+		if {$base_stage ne {}} {
+			set cmdline [list "$merge_tool_path" \
+				-base:$BASE -mine:$LOCAL \
+				-theirs:$REMOTE -merged:$MERGED]
+		} else {
+			error_popup [mc "%s cannot be used without a base" "TortoiseMerge"]
+			return
+		}
+	}
 	vimdiff {
 		error_popup [mc "Not a GUI merge tool: '%s'" $tool]
 		return
diff --git a/git-gui/po/ru.po b/git-gui/po/ru.po
index ca4343b..e9ef810 100644
--- a/git-gui/po/ru.po
+++ b/git-gui/po/ru.po
@@ -1948,6 +1948,10 @@ msgstr "=D0=9A=D0=BE=D0=BD=D1=84=D0=BB=D0=B8=D0=BA=
=D1=82=D1=83=D1=8E=D1=89=D0=B8=D0=B9 =D1=84=D0=B0=D0=B9=D0=BB =D0=BD=D0=
=B5 =D1=81=D1=83=D1=89=D0=B5=D1=81=D1=82=D0=B2=D1=83=D0=B5=D1=82"
 msgid "Not a GUI merge tool: '%s'"
 msgstr "'%s' =D0=BD=D0=B5 =D1=8F=D0=B2=D0=BB=D1=8F=D0=B5=D1=82=D1=81=D1=
=8F =D0=BF=D1=80=D0=BE=D0=B3=D1=80=D0=B0=D0=BC=D0=BC=D0=BE=D0=B9 =D1=81=
=D0=BB=D0=B8=D1=8F=D0=BD=D0=B8=D1=8F"
=20
+#: lib/mergetool.tcl:280
+msgid "%s cannot be used without a base"
+msgstr "%s =D0=BD=D0=B5 =D0=BC=D0=BE=D0=B6=D0=B5=D1=82 =D0=B8=D1=81=D0=
=BF=D0=BE=D0=BB=D1=8C=D0=B7=D0=BE=D0=B2=D0=B0=D1=82=D1=8C=D1=81=D1=8F =D0=
=B1=D0=B5=D0=B7 =D0=B1=D0=B0=D0=B7=D0=BE=D0=B2=D0=BE=D0=B9 =D0=B2=D0=B5=
=D1=80=D1=81=D0=B8=D0=B8"
+
 #: lib/mergetool.tcl:268
 #, tcl-format
 msgid "Unsupported merge tool '%s'"
--=20
1.8.1.1.10.g9255f3f
