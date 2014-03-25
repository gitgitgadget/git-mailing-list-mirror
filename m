From: Elia Pinto <gitter.spiros@gmail.com>
Subject: [PATCH 086/144] t7001-mv.sh: use the $( ... ) construct for command substitution
Date: Tue, 25 Mar 2014 01:25:31 -0700
Message-ID: <1395735989-3396-87-git-send-email-gitter.spiros@gmail.com>
References: <1395735989-3396-1-git-send-email-gitter.spiros@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Elia Pinto <gitter.spiros@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Mar 25 09:29:46 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WSMjx-0001bN-Rq
	for gcvg-git-2@plane.gmane.org; Tue, 25 Mar 2014 09:29:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753941AbaCYI2O convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 25 Mar 2014 04:28:14 -0400
Received: from mail-pa0-f45.google.com ([209.85.220.45]:57513 "EHLO
	mail-pa0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753932AbaCYI2L (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 25 Mar 2014 04:28:11 -0400
Received: by mail-pa0-f45.google.com with SMTP id kl14so125728pab.32
        for <git@vger.kernel.org>; Tue, 25 Mar 2014 01:28:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=38ZvGWLKKKBCdABO7g5sEM968bsLh9sQc6prg8Lbjjs=;
        b=LDztgV/QShxXjIDrTu3/rnZ4Pp77nJe8TuEyX104RgGTp+vZGT4+2qxBmQraA9yYFB
         DT7rvUnP6xB2XkLy7o2BOImJm997DTfuui9UBJ5Y7kjHXSW3YLJjfK6kF80c/CHSUULy
         CyVbHmHRShHri+2C+fH4ghm0n2AwTh/VQhbJWCFCnjSwmnpL+9zdbrAI5FBoVwxgn/U9
         q9bK/W2vYt4xPgUPnuCbs34z4vA8pfy1ekZ2YTJE4QOWJXye2zEMDmT6nWMxTKb5ZYmF
         1rF/ZPU/yokOImXIY5b3aZwRLx4EGFAU4aHuOik5tNszruskj+DedITfcXW57ECuVN/X
         Isgw==
X-Received: by 10.66.144.200 with SMTP id so8mr78160615pab.15.1395736091203;
        Tue, 25 Mar 2014 01:28:11 -0700 (PDT)
Received: from devzero2000ubu.nephoscale.com (140.195.207.67.nephoscale.net. [67.207.195.140])
        by mx.google.com with ESMTPSA id pr4sm41327198pbb.53.2014.03.25.01.28.10
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Tue, 25 Mar 2014 01:28:10 -0700 (PDT)
X-Mailer: git-send-email 1.7.10.4
In-Reply-To: <1395735989-3396-1-git-send-email-gitter.spiros@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/244949>

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
 t/t7001-mv.sh |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/t/t7001-mv.sh b/t/t7001-mv.sh
index e3c8c2c..23564bf 100755
--- a/t/t7001-mv.sh
+++ b/t/t7001-mv.sh
@@ -156,11 +156,11 @@ test_expect_success "Michael Cassar's test case" =
'
 	echo b > partA/outline.txt &&
 	echo c > papers/unsorted/_another &&
 	git add papers partA &&
-	T1=3D`git write-tree` &&
+	T1=3D$(git write-tree) &&
=20
 	git mv papers/unsorted/Thesis.pdf papers/all-papers/moo-blah.pdf &&
=20
-	T=3D`git write-tree` &&
+	T=3D$(git write-tree) &&
 	git ls-tree -r $T | grep partA/outline.txt || {
 		git ls-tree -r $T
 		(exit 1)
--=20
1.7.10.4
