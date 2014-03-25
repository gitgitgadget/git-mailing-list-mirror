From: Elia Pinto <gitter.spiros@gmail.com>
Subject: [PATCH 036/144] t3600-rm.sh: use the $( ... ) construct for command substitution
Date: Tue, 25 Mar 2014 01:24:41 -0700
Message-ID: <1395735989-3396-37-git-send-email-gitter.spiros@gmail.com>
References: <1395735989-3396-1-git-send-email-gitter.spiros@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Elia Pinto <gitter.spiros@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Mar 25 09:34:43 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WSMok-0007WS-Uz
	for gcvg-git-2@plane.gmane.org; Tue, 25 Mar 2014 09:34:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754088AbaCYIed convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 25 Mar 2014 04:34:33 -0400
Received: from mail-pd0-f173.google.com ([209.85.192.173]:41561 "EHLO
	mail-pd0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753760AbaCYI1S (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 25 Mar 2014 04:27:18 -0400
Received: by mail-pd0-f173.google.com with SMTP id z10so128802pdj.32
        for <git@vger.kernel.org>; Tue, 25 Mar 2014 01:27:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=Aw3mr1J7j7VnjpXeCb9qtbbQC0OtEulD8swWycEQPcU=;
        b=zigbdWCHwBQ8oqfO2ewRTFcoHlFUlaUx7T5Q4k0hOOArO0x/yQBuvCIFLiHS85nYxh
         ATR3kVrwwdHjemzxAFh78u455t0BMhPKZhjDj/f4oC0vCIfqZinuNJ3d4rRrtgY/eyBJ
         nRcnHFtyqys2z0C5Jq0IhY1SMxDwtv9q2IRRWHSLiaRWu6cA0CHawCUcUDZU6zalcgy9
         LJFfYJPpvLIDUOM/OtHuxC3GvY6Kq6CmAmx6fyXg5vfBYn5ExIZzJiRnBxo3/cZ5LQyH
         dAyHhDQUSpnSdjvTx3E+lnvuFyPMiwZCov6knXHao0JAj3VKCVM57FDkr/w3L4XjqYYG
         GnWQ==
X-Received: by 10.68.194.202 with SMTP id hy10mr77043907pbc.94.1395736038284;
        Tue, 25 Mar 2014 01:27:18 -0700 (PDT)
Received: from devzero2000ubu.nephoscale.com (140.195.207.67.nephoscale.net. [67.207.195.140])
        by mx.google.com with ESMTPSA id pr4sm41327198pbb.53.2014.03.25.01.27.17
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Tue, 25 Mar 2014 01:27:17 -0700 (PDT)
X-Mailer: git-send-email 1.7.10.4
In-Reply-To: <1395735989-3396-1-git-send-email-gitter.spiros@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/244987>

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
 t/t3600-rm.sh |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/t/t3600-rm.sh b/t/t3600-rm.sh
index 3d30581..96f7949 100755
--- a/t/t3600-rm.sh
+++ b/t/t3600-rm.sh
@@ -115,7 +115,7 @@ test_expect_success '"rm" command printed' '
 	git add test-file &&
 	git commit -m "add file for rm test" &&
 	git rm test-file > rm-output &&
-	test `grep "^rm " rm-output | wc -l` =3D 1 &&
+	test $(grep "^rm " rm-output | wc -l) =3D 1 &&
 	rm -f test-file rm-output &&
 	git commit -m "remove file from rm test"
 '
@@ -125,7 +125,7 @@ test_expect_success '"rm" command suppressed with -=
-quiet' '
 	git add test-file &&
 	git commit -m "add file for rm --quiet test" &&
 	git rm --quiet test-file > rm-output &&
-	test `wc -l < rm-output` =3D 0 &&
+	test $(wc -l < rm-output) =3D 0 &&
 	rm -f test-file rm-output &&
 	git commit -m "remove file from rm --quiet test"
 '
--=20
1.7.10.4
