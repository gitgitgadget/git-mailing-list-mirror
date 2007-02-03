From: Brian Gernhardt <benji@silverinsanity.com>
Subject: [PATCH] Use "-f" when adding files with odd names in t9200.
Date: Sat, 3 Feb 2007 13:13:29 -0500
Message-ID: <20070203181329.GA10192@179.242.249.10.in-addr.arpa>
References: <1AAD2384-C52D-4D60-A948-4F14C9515B53@silverinsanity.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=unknown-8bit
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Feb 03 19:13:35 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HDPOH-0002qm-2f
	for gcvg-git@gmane.org; Sat, 03 Feb 2007 19:13:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750983AbXBCSNb convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Sat, 3 Feb 2007 13:13:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750990AbXBCSNb
	(ORCPT <rfc822;git-outgoing>); Sat, 3 Feb 2007 13:13:31 -0500
Received: from vs072.rosehosting.com ([216.114.78.72]:51024 "EHLO
	silverinsanity.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750979AbXBCSNa (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 3 Feb 2007 13:13:30 -0500
Received: from localhost.localdomain (localhost [127.0.0.1])
	by silverinsanity.com (Postfix) with ESMTP id E1E171FFC02B
	for <git@vger.kernel.org>; Sat,  3 Feb 2007 18:13:29 +0000 (UTC)
Received: from Mutt by mutt-smtp-wrapper.pl 1.2  (www.zdo.com/articles/mutt-smtp-wrapper.shtml)
Content-Disposition: inline
In-Reply-To: <1AAD2384-C52D-4D60-A948-4F14C9515B53@silverinsanity.com>
User-Agent: Mutt/1.4.2.1i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/38581>

Without -f, the UTF-8 named files are ignored (supposedly via
=2Egitignore) on systems with a different UTF-8 encoding.
This patch makes the test pass on OS X on HFS+, in particular.

Signed-off-by: Brian Gernhardt <benji@silverinsanity.com>
---
=20
 I still think that the behavior of git-add here is an error.  The file
 is NOT in any ignore file and so should not be marked as such. However=
,
 this allows me to finally use "make test && sudo make install".

 t/t9200-git-cvsexportcommit.sh |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/t/t9200-git-cvsexportcommit.sh b/t/t9200-git-cvsexportcomm=
it.sh
index c443f32..6955cdd 100755
--- a/t/t9200-git-cvsexportcommit.sh
+++ b/t/t9200-git-cvsexportcommit.sh
@@ -174,9 +174,9 @@ test_expect_success \
      'File with non-ascii file name' \
      'mkdir -p =C3=85/goo/a/b/c/d/e/f/g/h/i/j/k/l/m/n/o/p/q/r/s/t/u/v/=
w/x/y/z/=C3=A5/=C3=A4/=C3=B6 &&
       echo Foo >=C3=85/goo/a/b/c/d/e/f/g/h/i/j/k/l/m/n/o/p/q/r/s/t/u/v=
/w/x/y/z/=C3=A5/=C3=A4/=C3=B6/g=C3=A5rdets=C3=A5g=C3=A5rdet.txt &&
-      git add =C3=85/goo/a/b/c/d/e/f/g/h/i/j/k/l/m/n/o/p/q/r/s/t/u/v/w=
/x/y/z/=C3=A5/=C3=A4/=C3=B6/g=C3=A5rdets=C3=A5g=C3=A5rdet.txt &&
+      git add -f =C3=85/goo/a/b/c/d/e/f/g/h/i/j/k/l/m/n/o/p/q/r/s/t/u/=
v/w/x/y/z/=C3=A5/=C3=A4/=C3=B6/g=C3=A5rdets=C3=A5g=C3=A5rdet.txt &&
       cp ../test9200a.png =C3=85/goo/a/b/c/d/e/f/g/h/i/j/k/l/m/n/o/p/q=
/r/s/t/u/v/w/x/y/z/=C3=A5/=C3=A4/=C3=B6/g=C3=A5rdets=C3=A5g=C3=A5rdet.p=
ng &&
-      git add =C3=85/goo/a/b/c/d/e/f/g/h/i/j/k/l/m/n/o/p/q/r/s/t/u/v/w=
/x/y/z/=C3=A5/=C3=A4/=C3=B6/g=C3=A5rdets=C3=A5g=C3=A5rdet.png &&
+      git add -f =C3=85/goo/a/b/c/d/e/f/g/h/i/j/k/l/m/n/o/p/q/r/s/t/u/=
v/w/x/y/z/=C3=A5/=C3=A4/=C3=B6/g=C3=A5rdets=C3=A5g=C3=A5rdet.png &&
       git commit -a -m "G=C3=A5r det s=C3=A5 g=C3=A5r det" && \
       id=3D$(git rev-list --max-count=3D1 HEAD) &&
       (cd "$CVSWORK" &&
--=20
1.5.0.rc3.22.g5057
