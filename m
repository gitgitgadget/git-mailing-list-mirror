From: Elia Pinto <gitter.spiros@gmail.com>
Subject: [PATCH 096/144] t7700-repack.sh: use the $( ... ) construct for command substitution
Date: Tue, 25 Mar 2014 01:25:41 -0700
Message-ID: <1395735989-3396-97-git-send-email-gitter.spiros@gmail.com>
References: <1395735989-3396-1-git-send-email-gitter.spiros@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Elia Pinto <gitter.spiros@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Mar 25 09:29:19 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WSMjX-00011m-62
	for gcvg-git-2@plane.gmane.org; Tue, 25 Mar 2014 09:29:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751578AbaCYI3N convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 25 Mar 2014 04:29:13 -0400
Received: from mail-pa0-f54.google.com ([209.85.220.54]:61760 "EHLO
	mail-pa0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753957AbaCYI2V (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 25 Mar 2014 04:28:21 -0400
Received: by mail-pa0-f54.google.com with SMTP id lf10so130295pab.13
        for <git@vger.kernel.org>; Tue, 25 Mar 2014 01:28:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=dnXgqXv6z3IGSluCUO5fJ/DecVu/k5/2TlhlsxlJfd4=;
        b=BPF0vMQLmU/8q0yhxObjHMCV/iibLQ3IUvNXOCGnoRnrvJNmbkVP5a+rLfKBwGc4gf
         wcJTJ+L+pTsYlZWJTioGvZe080W4EDG5j64MKNMXv7lJoNU42AU00espa3cb6bBDEzVL
         fXMwXOl9VYGMyVW9OPBdyJfI+7UHql7ftMrfaYyqLs+Uqn5SmR3RFmx2JeoZyXXE17og
         ztleCUz7hG6C4aZ9YNvj5IAl+zqPGcbvxTgjgr5tsKJCyTrffCZROSiXGHDVOnX6J9Bl
         TshvyAeNa/zBEwUpDvi3B7ErKRjrYJO55EWVREFx5iWhGI7ttyqRDp6TBb/nnRXVTcTn
         KUzw==
X-Received: by 10.66.232.40 with SMTP id tl8mr14438235pac.137.1395736101622;
        Tue, 25 Mar 2014 01:28:21 -0700 (PDT)
Received: from devzero2000ubu.nephoscale.com (140.195.207.67.nephoscale.net. [67.207.195.140])
        by mx.google.com with ESMTPSA id pr4sm41327198pbb.53.2014.03.25.01.28.20
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Tue, 25 Mar 2014 01:28:21 -0700 (PDT)
X-Mailer: git-send-email 1.7.10.4
In-Reply-To: <1395735989-3396-1-git-send-email-gitter.spiros@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/244945>

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
 t/t7700-repack.sh |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/t/t7700-repack.sh b/t/t7700-repack.sh
index 284018e..ced4417 100755
--- a/t/t7700-repack.sh
+++ b/t/t7700-repack.sh
@@ -53,7 +53,7 @@ test_expect_success 'writing bitmaps can duplicate .k=
eep objects' '
=20
 test_expect_success 'loose objects in alternate ODB are not repacked' =
'
 	mkdir alt_objects &&
-	echo `pwd`/alt_objects > .git/objects/info/alternates &&
+	echo $(pwd)/alt_objects > .git/objects/info/alternates &&
 	echo content3 > file3 &&
 	objsha1=3D$(GIT_OBJECT_DIRECTORY=3Dalt_objects git hash-object -w fil=
e3) &&
 	git add file3 &&
@@ -152,7 +152,7 @@ test_expect_success 'packed unreachable obs in alte=
rnate ODB are not loosened' '
 '
=20
 test_expect_success 'local packed unreachable obs that exist in altern=
ate ODB are not loosened' '
-	echo `pwd`/alt_objects > .git/objects/info/alternates &&
+	echo $(pwd)/alt_objects > .git/objects/info/alternates &&
 	echo "$csha1" | git pack-objects --non-empty --all --reflog pack &&
 	rm -f .git/objects/pack/* &&
 	mv pack-* .git/objects/pack/ &&
--=20
1.7.10.4
