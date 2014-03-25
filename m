From: Elia Pinto <gitter.spiros@gmail.com>
Subject: [PATCH 026/144] t1410-reflog.sh: use the $( ... ) construct for command substitution
Date: Tue, 25 Mar 2014 01:24:31 -0700
Message-ID: <1395735989-3396-27-git-send-email-gitter.spiros@gmail.com>
References: <1395735989-3396-1-git-send-email-gitter.spiros@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Elia Pinto <gitter.spiros@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Mar 25 09:36:56 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WSMqq-0001hH-6h
	for gcvg-git-2@plane.gmane.org; Tue, 25 Mar 2014 09:36:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753694AbaCYIgp convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 25 Mar 2014 04:36:45 -0400
Received: from mail-pd0-f180.google.com ([209.85.192.180]:47276 "EHLO
	mail-pd0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753224AbaCYI1I (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 25 Mar 2014 04:27:08 -0400
Received: by mail-pd0-f180.google.com with SMTP id v10so132691pde.11
        for <git@vger.kernel.org>; Tue, 25 Mar 2014 01:27:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=PfM2G6QwZCKSpJ8Nw4LyZXwl743PcfNBjotshCIVu3I=;
        b=I412okeX6jZFQBUZJTAjg2+LmtuuCk/kH57SnYoRpnhUARbAjeMoriF7/hk9NIA3JV
         zUCT5PFqcEtKhtKovHcULlKkUPhVhOyWLYCCSTNmgh/JxLAz6dLCSUnwuW1MUgoUgPul
         xU6Jm4zzrT+S3xBaJLWw1L3FmX1bSyJlDB75LBPXNT75QEsOdAklEkUg07/6UfHP+hMN
         ZfAHyJeT6HRzdGOols6aLfuTYB+IgujY0VDmaUBd3bMShZxaUOCkTQVvodze5T3/LdJg
         LFAFOn6pMPZIfk0huf1mi/l999pzsrew5RtdZYaA7ywcf4phOkelek4jQS0DZdq0e+Oz
         czAw==
X-Received: by 10.68.194.202 with SMTP id hy10mr77043139pbc.94.1395736028147;
        Tue, 25 Mar 2014 01:27:08 -0700 (PDT)
Received: from devzero2000ubu.nephoscale.com (140.195.207.67.nephoscale.net. [67.207.195.140])
        by mx.google.com with ESMTPSA id pr4sm41327198pbb.53.2014.03.25.01.27.07
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Tue, 25 Mar 2014 01:27:07 -0700 (PDT)
X-Mailer: git-send-email 1.7.10.4
In-Reply-To: <1395735989-3396-1-git-send-email-gitter.spiros@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/244999>

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
 t/t1410-reflog.sh |   24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/t/t1410-reflog.sh b/t/t1410-reflog.sh
index 236b13a..0a9502a 100755
--- a/t/t1410-reflog.sh
+++ b/t/t1410-reflog.sh
@@ -62,18 +62,18 @@ test_expect_success setup '
 	git add . &&
=20
 	test_tick && git commit -m rabbit &&
-	H=3D`git rev-parse --verify HEAD` &&
-	A=3D`git rev-parse --verify HEAD:A` &&
-	B=3D`git rev-parse --verify HEAD:A/B` &&
-	C=3D`git rev-parse --verify HEAD:C` &&
-	D=3D`git rev-parse --verify HEAD:A/D` &&
-	E=3D`git rev-parse --verify HEAD:A/B/E` &&
+	H=3D$(git rev-parse --verify HEAD) &&
+	A=3D$(git rev-parse --verify HEAD:A) &&
+	B=3D$(git rev-parse --verify HEAD:A/B) &&
+	C=3D$(git rev-parse --verify HEAD:C) &&
+	D=3D$(git rev-parse --verify HEAD:A/D) &&
+	E=3D$(git rev-parse --verify HEAD:A/B/E) &&
 	check_fsck &&
=20
 	test_chmod +x C &&
 	git add C &&
 	test_tick && git commit -m dragon &&
-	L=3D`git rev-parse --verify HEAD` &&
+	L=3D$(git rev-parse --verify HEAD) &&
 	check_fsck &&
=20
 	rm -f C A/B/E &&
@@ -81,15 +81,15 @@ test_expect_success setup '
 	echo horse >A/G &&
 	git add F A/G &&
 	test_tick && git commit -a -m sheep &&
-	F=3D`git rev-parse --verify HEAD:F` &&
-	G=3D`git rev-parse --verify HEAD:A/G` &&
-	I=3D`git rev-parse --verify HEAD:A` &&
-	J=3D`git rev-parse --verify HEAD` &&
+	F=3D$(git rev-parse --verify HEAD:F) &&
+	G=3D$(git rev-parse --verify HEAD:A/G) &&
+	I=3D$(git rev-parse --verify HEAD:A) &&
+	J=3D$(git rev-parse --verify HEAD) &&
 	check_fsck &&
=20
 	rm -f A/G &&
 	test_tick && git commit -a -m monkey &&
-	K=3D`git rev-parse --verify HEAD` &&
+	K=3D$(git rev-parse --verify HEAD) &&
 	check_fsck &&
=20
 	check_have A B C D E F G H I J K L &&
--=20
1.7.10.4
