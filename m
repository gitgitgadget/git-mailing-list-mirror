From: Elia Pinto <gitter.spiros@gmail.com>
Subject: [PATCH 055/144] t5301-sliding-window.sh: use the $( ... ) construct for command substitution
Date: Tue, 25 Mar 2014 01:25:00 -0700
Message-ID: <1395735989-3396-56-git-send-email-gitter.spiros@gmail.com>
References: <1395735989-3396-1-git-send-email-gitter.spiros@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Elia Pinto <gitter.spiros@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Mar 25 09:33:32 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WSMna-00064f-CK
	for gcvg-git-2@plane.gmane.org; Tue, 25 Mar 2014 09:33:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753853AbaCYIdU convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 25 Mar 2014 04:33:20 -0400
Received: from mail-pa0-f48.google.com ([209.85.220.48]:58291 "EHLO
	mail-pa0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753837AbaCYI1j (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 25 Mar 2014 04:27:39 -0400
Received: by mail-pa0-f48.google.com with SMTP id hz1so128088pad.21
        for <git@vger.kernel.org>; Tue, 25 Mar 2014 01:27:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=FqP6MIDSE3RNVxBkYLzi/t7WrSKd4QyLa5t8/Yo407Y=;
        b=jPnszVekaZsqAmyDmXqy9XKJAGDMyjCgIZuVdxvd8fp0IynvYv3cPkhVw9cIQjMO4p
         kUuSwuSo2jEKcDYdmu2GO8YvovSpxHJiv5j+4kwm5doIk8J0cZo2geZ6oB8EZgMDHAjO
         wPVgi6XhrxwjLmAsmtGHR8THsM/9dtGHF0TKmulcwH95wJ1MaLRokuHGKU+aZG4avakl
         zEfpg3xHKIYTNrWmHOG+7DwCfO7W7dZ1VxyjjIrNk4Kti3CdKDtMStyLG7MsuHgUSoM6
         jXhR+jP9K0fjaavgn61UKOizWhaar4xc8Z7Xhb2NfuqZ7pnejTQJdQ3tBh6uHG9CPrpw
         1wRw==
X-Received: by 10.68.197.36 with SMTP id ir4mr75920416pbc.46.1395736058876;
        Tue, 25 Mar 2014 01:27:38 -0700 (PDT)
Received: from devzero2000ubu.nephoscale.com (140.195.207.67.nephoscale.net. [67.207.195.140])
        by mx.google.com with ESMTPSA id pr4sm41327198pbb.53.2014.03.25.01.27.37
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Tue, 25 Mar 2014 01:27:37 -0700 (PDT)
X-Mailer: git-send-email 1.7.10.4
In-Reply-To: <1395735989-3396-1-git-send-email-gitter.spiros@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/244975>

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
 t/t5301-sliding-window.sh |   14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/t/t5301-sliding-window.sh b/t/t5301-sliding-window.sh
index 2fc5af6..cae8c2e 100755
--- a/t/t5301-sliding-window.sh
+++ b/t/t5301-sliding-window.sh
@@ -16,12 +16,12 @@ test_expect_success \
          git update-index --add $i || return 1
      done &&
      echo d >d && cat c >>d && git update-index --add d &&
-     tree=3D`git write-tree` &&
-     commit1=3D`git commit-tree $tree </dev/null` &&
+     tree=3D$(git write-tree) &&
+     commit1=3D$(git commit-tree $tree </dev/null) &&
      git update-ref HEAD $commit1 &&
      git repack -a -d &&
-     test "`git count-objects`" =3D "0 objects, 0 kilobytes" &&
-     pack1=3D`ls .git/objects/pack/*.pack` &&
+     test "$(git count-objects)" =3D "0 objects, 0 kilobytes" &&
+     pack1=3D$(ls .git/objects/pack/*.pack) &&
      test -f "$pack1"'
=20
 test_expect_success \
@@ -43,11 +43,11 @@ test_expect_success \
     'repack -a -d, packedGit{WindowSize,Limit} =3D=3D 1 page' \
     'git config core.packedGitWindowSize 512 &&
      git config core.packedGitLimit 512 &&
-     commit2=3D`git commit-tree $tree -p $commit1 </dev/null` &&
+     commit2=3D$(git commit-tree $tree -p $commit1 </dev/null) &&
      git update-ref HEAD $commit2 &&
      git repack -a -d &&
-     test "`git count-objects`" =3D "0 objects, 0 kilobytes" &&
-     pack2=3D`ls .git/objects/pack/*.pack` &&
+     test "$(git count-objects)" =3D "0 objects, 0 kilobytes" &&
+     pack2=3D$(ls .git/objects/pack/*.pack) &&
      test -f "$pack2" &&
      test "$pack1" \!=3D "$pack2"'
=20
--=20
1.7.10.4
