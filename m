From: =?UTF-8?Q?J=C3=B6rg?= Sommer <joerg@alea.gnuu.de>
Subject: git commit --interactive creates empty commits
Date: Mon, 14 Apr 2008 00:35:47 +0000 (UTC)
Message-ID: <slrng059n3.nd8.joerg@alea.gnuu.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Apr 14 02:53:36 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JlCwy-0004J2-3J
	for gcvg-git-2@gmane.org; Mon, 14 Apr 2008 02:53:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753999AbYDNAwM convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 13 Apr 2008 20:52:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753988AbYDNAwL
	(ORCPT <rfc822;git-outgoing>); Sun, 13 Apr 2008 20:52:11 -0400
Received: from banki.eumelnet.de ([83.246.114.63]:1656 "EHLO uucp.gnuu.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753801AbYDNAv6 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 13 Apr 2008 20:51:58 -0400
Received: by uucp.gnuu.de (Postfix, from userid 10)
	id 7E84848809F; Mon, 14 Apr 2008 02:51:56 +0200 (CEST)
Received: from news by alea.gnuu.de with local (Exim 4.63)
	(envelope-from <news@alea.gnuu.de>)
	id 1JlCfk-0006J9-5P
	for git@vger.kernel.org; Mon, 14 Apr 2008 02:35:48 +0200
Path: not-for-mail
Newsgroups: local.mailinglist.git
X-Trace: alea.gnuu.de 1208133347 24249 192.168.0.5 (14 Apr 2008 00:35:47 GMT)
X-Complaints-To: usenet@alea.gnuu.de
User-Agent: slrn/pre0.9.9-102 (Debian)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/79438>

Hi,

is it expected that this test fails?

diff --git a/t/t7501-commit.sh b/t/t7501-commit.sh
index c0288f3..2c21428 100755
--- a/t/t7501-commit.sh
+++ b/t/t7501-commit.sh
@@ -123,6 +123,18 @@ test_expect_success \
 	"interactive add" \
 	"echo 7 | git-commit --interactive | grep 'What now'"
=20
+cat >editor <<\EOF
+#!/bin/sh
+echo invalid commit > $1
+EOF
+chmod 755 editor
+
+test_expect_success \
+	"interactive fails on empty index" \
+	"export VISUAL=3D./editor &&=20
+	test_must_fail git commit --interactive < /dev/null &&
+	unset VISUAL"
+
 test_expect_success \
 	"showing committed revisions" \
 	"git-rev-list HEAD >current"

Bye, J=C3=B6rg.
--=20
Damit das M=C3=B6gliche entsteht, mu=C3=9F immer wieder das Unm=C3=B6gl=
iche versucht
werden.                                       (Hermann Hesse)
