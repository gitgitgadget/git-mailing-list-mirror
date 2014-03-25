From: Elia Pinto <gitter.spiros@gmail.com>
Subject: [PATCH 079/144] t6001-rev-list-graft.sh: use the $( ... ) construct for command substitution
Date: Tue, 25 Mar 2014 01:25:24 -0700
Message-ID: <1395735989-3396-80-git-send-email-gitter.spiros@gmail.com>
References: <1395735989-3396-1-git-send-email-gitter.spiros@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Elia Pinto <gitter.spiros@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Mar 25 09:28:22 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WSMiY-0008K0-Fz
	for gcvg-git-2@plane.gmane.org; Tue, 25 Mar 2014 09:28:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753927AbaCYI2J convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 25 Mar 2014 04:28:09 -0400
Received: from mail-pd0-f174.google.com ([209.85.192.174]:37269 "EHLO
	mail-pd0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752134AbaCYI2E (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 25 Mar 2014 04:28:04 -0400
Received: by mail-pd0-f174.google.com with SMTP id y13so131323pdi.5
        for <git@vger.kernel.org>; Tue, 25 Mar 2014 01:28:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=7Eki2Jkzkl2vCpz1RQd7UgY/Xb5Jvkb6YSmyjKVrt9I=;
        b=uyOA/ll0INf0+bTCCsvFEihA5hTMTgKYP8TOdwi49bpKwAQUGDW0rFJ4ETkttPuK4K
         DZHfWmNTUluNGlXiRhkP6YdKo3kQhSQfR9SYgIGD8fg5zbfSGRBzlydX+JB6aEccwVj3
         IymlcFRPH4AYhLkkunCCCDmlx20db+ADBzV1tmBwF5rQjpFtO3RrVQoKw3Bj7ZRhED+E
         931cDxEINTHeOkZiKmnlrlukNdserIk1wz6s84fziTzbASeDp2/1JTGlXVwvghSJSpv/
         xyFJmb7zUgFNvQY9y+Q8sqkgAbsH03WwCcbZ78GJMjiKDyFPbV72SnPBSO8XrzYnNg//
         jkcg==
X-Received: by 10.66.137.109 with SMTP id qh13mr53725072pab.39.1395736084038;
        Tue, 25 Mar 2014 01:28:04 -0700 (PDT)
Received: from devzero2000ubu.nephoscale.com (140.195.207.67.nephoscale.net. [67.207.195.140])
        by mx.google.com with ESMTPSA id pr4sm41327198pbb.53.2014.03.25.01.28.03
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Tue, 25 Mar 2014 01:28:03 -0700 (PDT)
X-Mailer: git-send-email 1.7.10.4
In-Reply-To: <1395735989-3396-1-git-send-email-gitter.spiros@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/244931>

The Git CodingGuidelines prefer the $( ... ) construct for command
substitution instead of using the back-quotes, or grave accents (`..`).

The backquoted form is the historical method for command substitution,
and is supported by POSIX. However,all but the simplest uses become
complicated quickly. In particular,embedded command substitutions
and/or the use of double quotes require careful escaping with the backs=
lash
character. Because of this the POSIX shell adopted the $(=E2=80=A6) fea=
ture from
the Korn shell.

Signed-off-by: Elia Pinto <gitter.spiros@gmail.com>
---
 t/t6001-rev-list-graft.sh |   12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/t/t6001-rev-list-graft.sh b/t/t6001-rev-list-graft.sh
index 8efcd13..05ddc69 100755
--- a/t/t6001-rev-list-graft.sh
+++ b/t/t6001-rev-list-graft.sh
@@ -10,15 +10,15 @@ test_expect_success setup '
 	echo >subdir/fileB fileB &&
 	git add fileA subdir/fileB &&
 	git commit -a -m "Initial in one history." &&
-	A0=3D`git rev-parse --verify HEAD` &&
+	A0=3D$(git rev-parse --verify HEAD) &&
=20
 	echo >fileA fileA modified &&
 	git commit -a -m "Second in one history." &&
-	A1=3D`git rev-parse --verify HEAD` &&
+	A1=3D$(git rev-parse --verify HEAD) &&
=20
 	echo >subdir/fileB fileB modified &&
 	git commit -a -m "Third in one history." &&
-	A2=3D`git rev-parse --verify HEAD` &&
+	A2=3D$(git rev-parse --verify HEAD) &&
=20
 	rm -f .git/refs/heads/master .git/index &&
=20
@@ -26,15 +26,15 @@ test_expect_success setup '
 	echo >subdir/fileB fileB again &&
 	git add fileA subdir/fileB &&
 	git commit -a -m "Initial in alternate history." &&
-	B0=3D`git rev-parse --verify HEAD` &&
+	B0=3D$(git rev-parse --verify HEAD) &&
=20
 	echo >fileA fileA modified in alternate history &&
 	git commit -a -m "Second in alternate history." &&
-	B1=3D`git rev-parse --verify HEAD` &&
+	B1=3D$(git rev-parse --verify HEAD) &&
=20
 	echo >subdir/fileB fileB modified in alternate history &&
 	git commit -a -m "Third in alternate history." &&
-	B2=3D`git rev-parse --verify HEAD` &&
+	B2=3D$(git rev-parse --verify HEAD) &&
 	: done
 '
=20
--=20
1.7.10.4
