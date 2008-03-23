From: =?UTF-8?Q?J=C3=B6rg?= Sommer <joerg@alea.gnuu.de>
Subject: git-merge adds test to a message -- bug?
Date: Sun, 23 Mar 2008 23:13:31 +0000 (UTC)
Message-ID: <slrnfudp0q.19k.joerg@alea.gnuu.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Mar 24 00:16:01 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JdZPw-0007Nl-UI
	for gcvg-git-2@gmane.org; Mon, 24 Mar 2008 00:15:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756048AbYCWXPQ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 23 Mar 2008 19:15:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755962AbYCWXPQ
	(ORCPT <rfc822;git-outgoing>); Sun, 23 Mar 2008 19:15:16 -0400
Received: from banki.eumelnet.de ([83.246.114.63]:1937 "EHLO uucp.gnuu.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755983AbYCWXPP (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 23 Mar 2008 19:15:15 -0400
Received: by uucp.gnuu.de (Postfix, from userid 10)
	id 42F4348802B; Mon, 24 Mar 2008 00:15:13 +0100 (CET)
Received: from news by alea.gnuu.de with local (Exim 4.63)
	(envelope-from <news@alea.gnuu.de>)
	id 1JdZNb-0005jX-NA
	for git@vger.kernel.org; Mon, 24 Mar 2008 00:13:31 +0100
Path: not-for-mail
Newsgroups: local.mailinglist.git
X-Trace: alea.gnuu.de 1206314011 22041 192.168.0.5 (23 Mar 2008 23:13:31 GMT)
X-Complaints-To: usenet@alea.gnuu.de
User-Agent: slrn/pre0.9.9-97 (Debian)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/77975>

Hi,

is it correct, that this test fails?

diff --git a/t/t6032-merge-message.sh b/t/t6032-merge-message.sh
new file mode 100755
index 0000000..97157bd
--- /dev/null
+++ b/t/t6032-merge-message.sh
@@ -0,0 +1,30 @@
+#!/bin/sh
+
+test_description=3D'test for merge message'
+
+. ./test-lib.sh
+
+test_expect_success setup '
+	: > file1 &&
+	git add file1 &&
+        test_tick &&
+	git commit -m "commit 1" &&
+	: > file2 &&
+	git add file2 &&
+        test_tick &&
+	git commit -m "commit 2" &&
+
+	git checkout -b new-branch HEAD~1 &&
+	: > file3 &&
+	git add file3 &&
+        test_tick &&
+	git commit -m "commit 3"
+'
+
+test_expect_success merge 'git merge -m master-merge master'
+
+test_expect_failure 'merge message check' '
+	test "$(git cat-file commit HEAD | sed "1,/^\$/d")" =3D master-merge
+'
+
+test_done

Bye, J=C3=B6rg.
--=20
Unsere Zweifel sind Verr=C3=A4ter und oft genug verspielen wir den m=C3=
=B6glichen
Gewinn, weil wir den Versuch nicht wagen.
