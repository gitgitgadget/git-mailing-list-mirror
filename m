From: SZEDER =?iso-8859-1?Q?G=E1bor?= <szeder@ira.uka.de>
Subject: [PATCH] t1500: extend with tests of 'git rev-parse --git-dir'
Date: Mon, 19 Jan 2009 03:08:41 +0100
Message-ID: <20090119020841.GA9798@neumann>
References: <1232120253-1551-1-git-send-email-szeder@ira.uka.de>
	<alpine.DEB.1.00.0901161729070.3586@pacific.mpi-cbg.de>
	<4970BA2B.7090807@viscovery.net> <4970BAE5.8080006@viscovery.net>
	<7vr63386rc.fsf@gitster.siamese.dyndns.org>
	<7vhc3wuwxb.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Johannes Sixt <j.sixt@viscovery.net>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jan 19 03:10:09 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LOjab-0006gQ-5h
	for gcvg-git-2@gmane.org; Mon, 19 Jan 2009 03:10:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756532AbZASCIp convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 18 Jan 2009 21:08:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756227AbZASCIp
	(ORCPT <rfc822;git-outgoing>); Sun, 18 Jan 2009 21:08:45 -0500
Received: from moutng.kundenserver.de ([212.227.17.9]:55274 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756516AbZASCIp (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 18 Jan 2009 21:08:45 -0500
Received: from [127.0.1.1] (p5B1346DD.dip0.t-ipconnect.de [91.19.70.221])
	by mrelayeu.kundenserver.de (node=mrelayeu4) with ESMTP (Nemesis)
	id 0ML21M-1LOjZ90JZt-0007p1; Mon, 19 Jan 2009 03:08:42 +0100
Content-Disposition: inline
In-Reply-To: <7vhc3wuwxb.fsf@gitster.siamese.dyndns.org>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
X-Provags-ID: V01U2FsdGVkX18AdFIeX1nLygxJDA78OO8NgrvM7GU1vLhBWnP
 JSlaMHnyFSmxERUlyoQ1TB2hXizrBQ2wQh8zX9khvmsxgyh6XM
 ddyEg1H4N+NNCL5PQNQDg==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/106303>

Signed-off-by: SZEDER G=E1bor <szeder@ira.uka.de>
---

  These will pass with Junio's follow-up.


 t/t1500-rev-parse.sh |   17 ++++++++++++-----
 1 files changed, 12 insertions(+), 5 deletions(-)

diff --git a/t/t1500-rev-parse.sh b/t/t1500-rev-parse.sh
index 85da4ca..48ee077 100755
--- a/t/t1500-rev-parse.sh
+++ b/t/t1500-rev-parse.sh
@@ -26,21 +26,28 @@ test_rev_parse() {
 	"test '$1' =3D \"\$(git rev-parse --show-prefix)\""
 	shift
 	[ $# -eq 0 ] && return
+
+	test_expect_success "$name: git-dir" \
+	"test '$1' =3D \"\$(git rev-parse --git-dir)\""
+	shift
+	[ $# -eq 0 ] && return
 }
=20
-# label is-bare is-inside-git is-inside-work prefix
+# label is-bare is-inside-git is-inside-work prefix git-dir
+
+ROOT=3D$(pwd)
=20
-test_rev_parse toplevel false false true ''
+test_rev_parse toplevel false false true '' .git
=20
 cd .git || exit 1
-test_rev_parse .git/ false true false ''
+test_rev_parse .git/ false true false '' .
 cd objects || exit 1
-test_rev_parse .git/objects/ false true false ''
+test_rev_parse .git/objects/ false true false '' "$ROOT/.git"
 cd ../.. || exit 1
=20
 mkdir -p sub/dir || exit 1
 cd sub/dir || exit 1
-test_rev_parse subdirectory false false true sub/dir/
+test_rev_parse subdirectory false false true sub/dir/ "$ROOT/.git"
 cd ../.. || exit 1
=20
 git config core.bare true
--=20
1.6.1.201.g0e7e.dirty
