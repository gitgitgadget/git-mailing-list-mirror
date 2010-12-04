From: =?UTF-8?B?VG9yc3RlbiBCw7ZnZXJzaGF1c2Vu?= <tboegi@web.de>
Subject: [PATCH] t9143: do not fail when unhandled.log.gz is not created
Date: Sat, 04 Dec 2010 12:37:04 +0100
Message-ID: <4CFA27E0.8070308@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: tboegi@web.de
To: normalperson@yhbt.net, git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Sat Dec 04 12:37:41 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1POqQu-0003Ky-4x
	for gcvg-git-2@lo.gmane.org; Sat, 04 Dec 2010 12:37:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754880Ab0LDLhI convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 4 Dec 2010 06:37:08 -0500
Received: from fmmailgate02.web.de ([217.72.192.227]:54391 "EHLO
	fmmailgate02.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754860Ab0LDLhG (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 4 Dec 2010 06:37:06 -0500
Received: from smtp03.web.de  ( [172.20.0.65])
	by fmmailgate02.web.de (Postfix) with ESMTP id 6785218B7E6EC;
	Sat,  4 Dec 2010 12:37:05 +0100 (CET)
Received: from [213.64.3.195] (helo=birne.lan)
	by smtp03.web.de with asmtp (WEB.DE 4.110 #4)
	id 1POqQL-00079F-00; Sat, 04 Dec 2010 12:37:05 +0100
User-Agent: Mozilla/5.0 (Macintosh; U; Intel Mac OS X 10.6; en-US; rv:1.9.2.12) Gecko/20101027 Thunderbird/3.1.6
X-Sender: tboegi@web.de
X-Provags-ID: V01U2FsdGVkX18bhiBA1L8IwefhbJMV179ywFGxw38siYSLAceq
	uMFSmePU2YlEDBx06EljkjqIQiGvfJredaf9BuP2ANjTtAQySr
	ZDpb81UZk=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/162892>

Commit df73af5f66 is does not let the test case fail,
when Compress::Zlib is missing.
But:
On a MacOS X 10.6 system with missing Compress::Zlib
using svn version 1.6.5 (r38866) the gz file is created.
Solution:
Check for the existance of the unhandled.log.gz file.

Signed-off-by: Torsten B=C3=B6gershausen <tboegi@web.de>
---
  t/t9143-git-svn-gc.sh |    2 +-
  1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/t/t9143-git-svn-gc.sh b/t/t9143-git-svn-gc.sh
index 337ea59..8a95d78 100755
--- a/t/t9143-git-svn-gc.sh
+++ b/t/t9143-git-svn-gc.sh
@@ -37,7 +37,7 @@ test_expect_success 'git svn gc runs' 'git svn gc'
   test_expect_success 'git svn index removed' '! test -f=20
=2Egit/svn/refs/remotes/git-svn/index'
  -if perl -MCompress::Zlib -e 0 2>/dev/null
+if test -r .git/svn/refs/remotes/git-svn/unhandled.log.gz
  then
  	test_expect_success 'git svn gc produces a valid gzip file' '
  		 gunzip .git/svn/refs/remotes/git-svn/unhandled.log.gz
--=20
1.6.6
