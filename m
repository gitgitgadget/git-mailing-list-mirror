From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Fail softly if file system does not like test data.
Date: Wed, 31 Jan 2007 14:17:51 -0800
Message-ID: <7viremu9gw.fsf@assigned-by-dhcp.cox.net>
References: <20070130163219.GA14431@164.242.249.10.in-addr.arpa>
	<20070130224446.28311.31828.stgit@lathund.dewire.com>
	<200701310110.04429.robin.rosenberg.lists@dewire.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=-=-="
Cc: git@vger.kernel.org
To: Robin Rosenberg <robin.rosenberg.lists@dewire.com>
X-From: git-owner@vger.kernel.org Wed Jan 31 23:17:58 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HCNm8-0007tf-DK
	for gcvg-git@gmane.org; Wed, 31 Jan 2007 23:17:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161071AbXAaWRx (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 31 Jan 2007 17:17:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161072AbXAaWRx
	(ORCPT <rfc822;git-outgoing>); Wed, 31 Jan 2007 17:17:53 -0500
Received: from fed1rmmtao08.cox.net ([68.230.241.31]:53207 "EHLO
	fed1rmmtao08.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1161071AbXAaWRw (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 31 Jan 2007 17:17:52 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao08.cox.net
          (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP
          id <20070131221752.PDXR16632.fed1rmmtao08.cox.net@fed1rmimpo02.cox.net>;
          Wed, 31 Jan 2007 17:17:52 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id HyHr1W0141kojtg0000000; Wed, 31 Jan 2007 17:17:52 -0500
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/38298>

--=-=-=

Your patch does not seem to apply.  I wonder if the test path
needs to be that looooooooooooong to begin with.

One thing I noticed on Cygwin is that from inside Cygwin
environment t/trash directory becomes unremovable after the
original test fails.

I am wondering what use it would be to have ISO-8859-1 pathnames
in our test.  As far as the test is concerned I think the point
is to try non-ASCII paths, so I suspect this patch might be less
of an impact.

Sorry for sending an attachement but in this case the patch text
is _not_ in any particular encoding (the preimage is ISO-8859-1
but the postimage is in UTF-8) and transferring it as a textual
patch over e-mail is not possible without a way to annotate each
line which encoding it is in.


--=-=-=
Content-Type: text/x-diff; charset=utf-8
Content-Disposition: attachment; filename=zz.patch
Content-Transfer-Encoding: quoted-printable
Content-Description: Re-code the non-ascii path test to use UTF-8.

diff --git a/t/t9200-git-cvsexportcommit.sh b/t/t9200-git-cvsexportcommit.sh
index fd0a554..cc0a254 100755
--- a/t/t9200-git-cvsexportcommit.sh
+++ b/t/t9200-git-cvsexportcommit.sh
@@ -169,19 +169,19 @@ test_expect_success \
       test "$(echo $(sort "G g/CVS/Entries"|cut -d/ -f2,3,5))" =3D "with s=
paces.png/1.2/-kb with spaces.txt/1.2/"
       )'
=20
-# This test contains ISO-8859-1 characters
+# This test contains UTF-8 characters
 test_expect_success \
      'File with non-ascii file name' \
-     'mkdir -p =EF=BF=BD/goo/a/b/c/d/e/f/g/h/i/j/k/l/m/n/o/p/q/r/s/t/u/v/w=
/x/y/z/=EF=BF=BD/=EF=BF=BD/=EF=BF=BD &&
-      echo Foo >=EF=BF=BD/goo/a/b/c/d/e/f/g/h/i/j/k/l/m/n/o/p/q/r/s/t/u/v/=
w/x/y/z/=EF=BF=BD/=EF=BF=BD/=EF=BF=BD/g=EF=BF=BDrdets=EF=BF=BDg=EF=BF=BDrde=
t.txt &&
-      git add =EF=BF=BD/goo/a/b/c/d/e/f/g/h/i/j/k/l/m/n/o/p/q/r/s/t/u/v/w/=
x/y/z/=EF=BF=BD/=EF=BF=BD/=EF=BF=BD/g=EF=BF=BDrdets=EF=BF=BDg=EF=BF=BDrdet.=
txt &&
-      cp ../test9200a.png =EF=BF=BD/goo/a/b/c/d/e/f/g/h/i/j/k/l/m/n/o/p/q/=
r/s/t/u/v/w/x/y/z/=EF=BF=BD/=EF=BF=BD/=EF=BF=BD/g=EF=BF=BDrdets=EF=BF=BDg=
=EF=BF=BDrdet.png &&
-      git add =EF=BF=BD/goo/a/b/c/d/e/f/g/h/i/j/k/l/m/n/o/p/q/r/s/t/u/v/w/=
x/y/z/=EF=BF=BD/=EF=BF=BD/=EF=BF=BD/g=EF=BF=BDrdets=EF=BF=BDg=EF=BF=BDrdet.=
png &&
-      git commit -a -m "G=EF=BF=BDr det s=EF=BF=BD g=EF=BF=BDr det" && \
+     'mkdir -p =EF=BF=BD=EF=BF=BD/goo/a/b/c/d/e/f/g/h/i/j/k/l/m/n/o/p/q/r/=
s/t/u/v/w/x/y/z/=EF=BF=BD=EF=BF=BD/=EF=BF=BD=EF=BF=BD/=EF=BF=BD=EF=BF=BD &&
+      echo Foo >=EF=BF=BD=EF=BF=BD/goo/a/b/c/d/e/f/g/h/i/j/k/l/m/n/o/p/q/r=
/s/t/u/v/w/x/y/z/=EF=BF=BD=EF=BF=BD/=EF=BF=BD=EF=BF=BD/=EF=BF=BD=EF=BF=BD/g=
=EF=BF=BD=EF=BF=BDrdets=EF=BF=BD=EF=BF=BDg=EF=BF=BD=EF=BF=BDrdet.txt &&
+      git add =EF=BF=BD=EF=BF=BD/goo/a/b/c/d/e/f/g/h/i/j/k/l/m/n/o/p/q/r/s=
/t/u/v/w/x/y/z/=EF=BF=BD=EF=BF=BD/=EF=BF=BD=EF=BF=BD/=EF=BF=BD=EF=BF=BD/g=
=EF=BF=BD=EF=BF=BDrdets=EF=BF=BD=EF=BF=BDg=EF=BF=BD=EF=BF=BDrdet.txt &&
+      cp ../test9200a.png =EF=BF=BD=EF=BF=BD/goo/a/b/c/d/e/f/g/h/i/j/k/l/m=
/n/o/p/q/r/s/t/u/v/w/x/y/z/=EF=BF=BD=EF=BF=BD/=EF=BF=BD=EF=BF=BD/=EF=BF=BD=
=EF=BF=BD/g=EF=BF=BD=EF=BF=BDrdets=EF=BF=BD=EF=BF=BDg=EF=BF=BD=EF=BF=BDrdet=
.png &&
+      git add =EF=BF=BD=EF=BF=BD/goo/a/b/c/d/e/f/g/h/i/j/k/l/m/n/o/p/q/r/s=
/t/u/v/w/x/y/z/=EF=BF=BD=EF=BF=BD/=EF=BF=BD=EF=BF=BD/=EF=BF=BD=EF=BF=BD/g=
=EF=BF=BD=EF=BF=BDrdets=EF=BF=BD=EF=BF=BDg=EF=BF=BD=EF=BF=BDrdet.png &&
+      git commit -a -m "G=EF=BF=BD=EF=BF=BDr det s=EF=BF=BD=EF=BF=BD g=EF=
=BF=BD=EF=BF=BDr det" && \
       id=3D$(git rev-list --max-count=3D1 HEAD) &&
       (cd "$CVSWORK" &&
       git-cvsexportcommit -v -c $id &&
-      test "$(echo $(sort =EF=BF=BD/goo/a/b/c/d/e/f/g/h/i/j/k/l/m/n/o/p/q/=
r/s/t/u/v/w/x/y/z/=EF=BF=BD/=EF=BF=BD/=EF=BF=BD/CVS/Entries|cut -d/ -f2,3,5=
))" =3D "g=EF=BF=BDrdets=EF=BF=BDg=EF=BF=BDrdet.png/1.1/-kb g=EF=BF=BDrdets=
=EF=BF=BDg=EF=BF=BDrdet.txt/1.1/"
+      test "$(echo $(sort =EF=BF=BD=EF=BF=BD/goo/a/b/c/d/e/f/g/h/i/j/k/l/m=
/n/o/p/q/r/s/t/u/v/w/x/y/z/=EF=BF=BD=EF=BF=BD/=EF=BF=BD=EF=BF=BD/=EF=BF=BD=
=EF=BF=BD/CVS/Entries|cut -d/ -f2,3,5))" =3D "g=EF=BF=BD=EF=BF=BDrdets=EF=
=BF=BD=EF=BF=BDg=EF=BF=BD=EF=BF=BDrdet.png/1.1/-kb g=EF=BF=BD=EF=BF=BDrdets=
=EF=BF=BD=EF=BF=BDg=EF=BF=BD=EF=BF=BDrdet.txt/1.1/"
       )'
=20
 test_expect_success \

--=-=-=--
