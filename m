From: Simon 'corecode' Schubert <corecode@fs.ei.tum.de>
Subject: [PATCH] Lose perl dependency.
Date: Thu, 18 Jan 2007 11:21:30 +0100
Message-ID: <20070118102800.30B38A90C@diphong.localdomain>
X-From: git-owner@vger.kernel.org Thu Jan 18 11:28:12 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H7UV6-0006hd-BY
	for gcvg-git@gmane.org; Thu, 18 Jan 2007 11:28:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751867AbXARK2F (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 18 Jan 2007 05:28:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751901AbXARK2F
	(ORCPT <rfc822;git-outgoing>); Thu, 18 Jan 2007 05:28:05 -0500
Received: from stella.fs.ei.tum.de ([129.187.54.7]:49123 "EHLO
	stella.fs.ei.tum.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751023AbXARK2E (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Jan 2007 05:28:04 -0500
Received: from localhost (localhost [127.0.0.1])
	by localhost.fs.ei.tum.de (Postfix) with ESMTP id E08DD2815D;
	Thu, 18 Jan 2007 11:28:00 +0100 (CET)
X-Virus-Scanned: by amavisd-new at fs.ei.tum.de
Received: from stella.fs.ei.tum.de ([127.0.0.1])
	by localhost (stella.fs.ei.tum.de [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id 3yy81hvfb7se; Thu, 18 Jan 2007 11:28:00 +0100 (CET)
Received: from diphong.localdomain (ppp-62-216-203-232.dynamic.mnet-online.de [62.216.203.232])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by stella.fs.ei.tum.de (Postfix) with ESMTP id B763D28133;
	Thu, 18 Jan 2007 11:28:00 +0100 (CET)
Received: by diphong.localdomain (Postfix, from userid 1001)
	id 30B38A90C; Thu, 18 Jan 2007 11:28:00 +0100 (CET)
To: undisclosed-recipients:;
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/37074>

Perl is just used to reverse stdin, which can be done with a simple
sed construct as well.

Signed-off-by: Simon 'corecode' Schubert <corecode@fs.ei.tum.de>
---
 git-rebase.sh |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/git-rebase.sh b/git-rebase.sh
index c8bd0f9..c34a0d2 100755
--- a/git-rebase.sh
+++ b/git-rebase.sh
@@ -332,7 +332,7 @@ echo "$prev_head" > "$dotest/prev_head"
 
 msgnum=0
 for cmt in `git-rev-list --no-merges "$upstream"..ORIG_HEAD \
-			| @@PERL@@ -e 'print reverse <>'`
+			| sed -ne '1!G;$p;h'`
 do
 	msgnum=$(($msgnum + 1))
 	echo "$cmt" > "$dotest/cmt.$msgnum"
-- 
1.5.0.rc1.g8bef
