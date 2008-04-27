From: Alex Riesen <raa.lkml@gmail.com>
Subject: [PATCH] Use the modern syntax of git-diff-files in
	t2002-checkout-cache-u.sh
Date: Sun, 27 Apr 2008 13:31:23 +0200
Message-ID: <20080427113123.GA3712@steel.home>
Reply-To: Alex Riesen <raa.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <junkio@cox.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Apr 27 13:32:23 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jq57G-00073r-EA
	for gcvg-git-2@gmane.org; Sun, 27 Apr 2008 13:32:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754890AbYD0Lbc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 27 Apr 2008 07:31:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754827AbYD0Lbb
	(ORCPT <rfc822;git-outgoing>); Sun, 27 Apr 2008 07:31:31 -0400
Received: from mo-p07-ob.rzone.de ([81.169.146.188]:16535 "EHLO
	mo-p07-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752742AbYD0Lbb (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 27 Apr 2008 07:31:31 -0400
X-RZG-CLASS-ID: mo07
X-RZG-AUTH: z4gYkBuibEUndJ36PWMnarZw4lh2bA==
Received: from tigra.home (Faeb6.f.strato-dslnet.de [195.4.174.182])
	by post.webmailer.de (mrclete mo8) (RZmta 16.27)
	with ESMTP id f0148ck3R9ovL5 ; Sun, 27 Apr 2008 13:31:24 +0200 (MEST)
	(envelope-from: <raa.lkml@gmail.com>)
Received: from steel.home (steel.home [192.168.1.2])
	by tigra.home (Postfix) with ESMTP id 689D9277BD;
	Sun, 27 Apr 2008 13:31:24 +0200 (CEST)
Received: by steel.home (Postfix, from userid 1000)
	id DC0BB56D28; Sun, 27 Apr 2008 13:31:23 +0200 (CEST)
Content-Disposition: inline
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/80440>

As a nice side effect it also fixes t2002-checkout-cache-u.sh on FreeBSD 4,
/bin/sh of which has problems interpreting "! command" construction.

Signed-off-by: Alex Riesen <raa.lkml@gmail.com>
---

To be honest - it was the other way around: I wanted to fix the test
on FreeBSD, but ended up using --exit-code and test_must_fail

 t/t2002-checkout-cache-u.sh |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/t/t2002-checkout-cache-u.sh b/t/t2002-checkout-cache-u.sh
index 0f441bc..70361c8 100755
--- a/t/t2002-checkout-cache-u.sh
+++ b/t/t2002-checkout-cache-u.sh
@@ -21,13 +21,13 @@ test_expect_success \
 rm -f path0 &&
 git read-tree $t &&
 git checkout-index -f -a &&
-! git diff-files | diff - /dev/null'
+test_must_fail git diff-files --exit-code'
 
 test_expect_success \
 'with -u, git checkout-index picks up stat information from new files.' '
 rm -f path0 &&
 git read-tree $t &&
 git checkout-index -u -f -a &&
-git diff-files | diff - /dev/null'
+git diff-files --exit-code'
 
 test_done
-- 
1.5.5.1.113.g4af4
