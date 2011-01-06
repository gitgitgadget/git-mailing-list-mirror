From: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
Subject: [RFC/PATCH] t9157-*.sh: Add an svn version check
Date: Thu, 06 Jan 2011 18:29:23 +0000
Message-ID: <4D260A03.90903@ramsay1.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, stevenrwalter@gmail.com,
	normalperson@yhbt.net
To: GIT Mailing-list <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Jan 06 19:30:44 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Paubk-0000Oo-3E
	for gcvg-git-2@lo.gmane.org; Thu, 06 Jan 2011 19:30:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753143Ab1AFSac (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 6 Jan 2011 13:30:32 -0500
Received: from lon1-post-3.mail.demon.net ([195.173.77.150]:57027 "EHLO
	lon1-post-3.mail.demon.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753109Ab1AFSab (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 6 Jan 2011 13:30:31 -0500
Received: from ramsay1.demon.co.uk ([193.237.126.196])
	by lon1-post-3.mail.demon.net with esmtp (Exim 4.69)
	id 1PaubW-0006WM-dk; Thu, 06 Jan 2011 18:30:30 +0000
User-Agent: Thunderbird 1.5.0.2 (Windows/20060308)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/164652>


Signed-off-by: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
---

This test fails for me, because my svn version(s) are too old (1.4.3 and 1.4.6), and
so I've got into the habit of running the tests with NO_SVN_TESTS=1. (which is a bit
of a shame in terms of test coverage, but it is *much* quicker!)

I don't know the details, but it seems that the 'svn merge' of this vintage does not
support the operations required by this test. Unfortunately, I don't know what the
minimum required version of svn is, so I'm hoping that someone can take this patch
and fix it up properly ...

ATB,
Ramsay Jones

 t/t9157-git-svn-fetch-merge.sh |    8 ++++++++
 1 files changed, 8 insertions(+), 0 deletions(-)

diff --git a/t/t9157-git-svn-fetch-merge.sh b/t/t9157-git-svn-fetch-merge.sh
index da582c5..accf61e 100755
--- a/t/t9157-git-svn-fetch-merge.sh
+++ b/t/t9157-git-svn-fetch-merge.sh
@@ -6,6 +6,14 @@
 test_description='git svn merge detection'
 . ./lib-git-svn.sh
 
+svn_ver="$(svn --version --quiet)"
+case $svn_ver in
+[0-1].[0-4].[0-6])
+	skip_all="skipping git-svn test - SVN too old ($svn_ver)"
+	test_done
+	;;
+esac
+
 test_expect_success 'initialize source svn repo' '
 	svn_cmd mkdir -m x "$svnrepo"/trunk &&
 	svn_cmd mkdir -m x "$svnrepo"/branches &&
-- 
1.7.3
