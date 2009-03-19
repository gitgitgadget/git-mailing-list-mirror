From: Johannes Sixt <j6t@kdbg.org>
Subject: Re: [PATCH 00/11] Test on Windows - prequel
Date: Thu, 19 Mar 2009 21:58:46 +0100
Message-ID: <200903192158.46680.j6t@kdbg.org>
References: <cover.1237410682.git.j6t@kdbg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Mar 19 22:00:30 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LkPLn-0004PW-50
	for gcvg-git-2@gmane.org; Thu, 19 Mar 2009 22:00:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753399AbZCSU6z convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 19 Mar 2009 16:58:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752274AbZCSU6y
	(ORCPT <rfc822;git-outgoing>); Thu, 19 Mar 2009 16:58:54 -0400
Received: from bsmtp.bon.at ([213.33.87.14]:42535 "EHLO bsmtp.bon.at"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751066AbZCSU6x (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Mar 2009 16:58:53 -0400
Received: from dx.sixt.local (unknown [93.83.142.38])
	by bsmtp.bon.at (Postfix) with ESMTP id 3955E10028;
	Thu, 19 Mar 2009 21:58:46 +0100 (CET)
Received: from localhost (localhost [IPv6:::1])
	by dx.sixt.local (Postfix) with ESMTP id C31773A9C1;
	Thu, 19 Mar 2009 21:58:46 +0100 (CET)
User-Agent: KMail/1.9.9
In-Reply-To: <cover.1237410682.git.j6t@kdbg.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/113827>

On Mittwoch, 18. M=E4rz 2009, Johannes Sixt wrote:
> I'm preparing a series of patches that adjust the test suite so that =
it
> passes on Windows (MinGW port). This is the initial part of it. Anoth=
er
> dozen or more are to follow. By splitting the series I hope to get
> earlier feedback.
>
> The series is also available from
>
>  git://repo.or.cz/git/mingw/j6t.git for-junio
>
>  http://repo.or.cz/w/git/mingw/j6t.git?a=3Dshortlog;h=3Drefs/heads/fo=
r-junio

I've updated the series. Would you please pick up it up from the URL
above?

The changes in particular are:

- [PATCH 02/10] test suite: Use 'say' to say something instead of...

  Updated commit message.

- [PATCH 04/10] test-lib: Replace uses of $(expr ...) by POSIX...

  No changes to t4013 and t5515 anymore; the next patch removes the
  lines that this patch touched.

- [PATCH 05/10] test-lib: Simplify test counting.

  Do not use $test_count+1 in t4013 and t5515.

- [PATCH 08/10] t2200, t7004: Avoid glob pattern that also...

  Added path2 to the list.

Below is the interdiff.

-- Hannes =20

diff --git a/t/t2200-add-update.sh b/t/t2200-add-update.sh
index 652801e..5a8d52f 100755
--- a/t/t2200-add-update.sh
+++ b/t/t2200-add-update.sh
@@ -150,7 +150,7 @@ test_expect_success 'add -u resolves unmerged paths=
' '
 	echo 2 >path3 &&
 	echo 2 >path5 &&
 	git add -u &&
-	git ls-files -s path1 path3 path4 path5 path6 >actual &&
+	git ls-files -s path1 path2 path3 path4 path5 path6 >actual &&
 	{
 		echo "100644 $three 0	path1"
 		echo "100644 $one 1	path3"
diff --git a/t/t4013-diff-various.sh b/t/t4013-diff-various.sh
index 9c30b29..426e64e 100755
--- a/t/t4013-diff-various.sh
+++ b/t/t4013-diff-various.sh
@@ -101,8 +101,7 @@ do
 	'' | '#'*) continue ;;
 	esac
 	test=3D`echo "$cmd" | sed -e 's|[/ ][/ ]*|_|g'`
-	cnt=3D$(($test_count+1))
-	pfx=3D`printf "%04d" $cnt`
+	pfx=3D`printf "%04d" $test_count`
 	expect=3D"$TEST_DIRECTORY/t4013/diff.$test"
 	actual=3D"$pfx-diff.$test"
=20
diff --git a/t/t5515-fetch-merge-logic.sh b/t/t5515-fetch-merge-logic.s=
h
index 0b39503..dbb927d 100755
--- a/t/t5515-fetch-merge-logic.sh
+++ b/t/t5515-fetch-merge-logic.sh
@@ -129,8 +129,7 @@ do
 	'' | '#'*) continue ;;
 	esac
 	test=3D`echo "$cmd" | sed -e 's|[/ ][/ ]*|_|g'`
-	cnt=3D$(($test_count+1))
-	pfx=3D`printf "%04d" $cnt`
+	pfx=3D`printf "%04d" $test_count`
 	expect_f=3D"$TEST_DIRECTORY/t5515/fetch.$test"
 	actual_f=3D"$pfx-fetch.$test"
 	expect_r=3D"$TEST_DIRECTORY/t5515/refs.$test"
