From: Miklos Vajna <vmiklos@frugalware.org>
Subject: [PATCH 5/5] hg-to-git: use git rev-parse instead of git show
Date: Sun,  6 Jul 2008 05:15:21 +0200
Message-ID: <d93e9bf965d52f749c8bf63afb73815043ebf88d.1215313871.git.vmiklos@frugalware.org>
References: <cover.1215313871.git.vmiklos@frugalware.org>
 <89a68bb21125c4ff706412cde5c04f5d96658789.1215313871.git.vmiklos@frugalware.org>
 <ca2e01fa1446afa551f5a6a36242a03d79cb685c.1215313871.git.vmiklos@frugalware.org>
 <5b692cd189e0afbd4b0e372f1671aa343dfb0d78.1215313871.git.vmiklos@frugalware.org>
 <b9e0cd170819882800fe1f0def7ac740a3176a7b.1215313871.git.vmiklos@frugalware.org>
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Stelian Pop <stelian@popies.net>
X-From: git-owner@vger.kernel.org Sun Jul 06 05:16:36 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KFKjs-0000sb-C3
	for gcvg-git-2@gmane.org; Sun, 06 Jul 2008 05:16:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753530AbYGFDPX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 5 Jul 2008 23:15:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753389AbYGFDPV
	(ORCPT <rfc822;git-outgoing>); Sat, 5 Jul 2008 23:15:21 -0400
Received: from yugo.dsd.sztaki.hu ([195.111.2.114]:57930 "EHLO
	yugo.frugalware.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753505AbYGFDPM (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 5 Jul 2008 23:15:12 -0400
Received: from vmobile.example.net (catv-5062e651.catv.broadband.hu [80.98.230.81])
	by yugo.frugalware.org (Postfix) with ESMTP id B76DC1DDC60;
	Sun,  6 Jul 2008 05:15:08 +0200 (CEST)
Received: by vmobile.example.net (Postfix, from userid 1003)
	id B229F1A9CF4; Sun,  6 Jul 2008 05:15:21 +0200 (CEST)
X-Mailer: git-send-email 1.5.6.1.322.ge904b.dirty
In-Reply-To: <b9e0cd170819882800fe1f0def7ac740a3176a7b.1215313871.git.vmiklos@frugalware.org>
In-Reply-To: <cover.1215313871.git.vmiklos@frugalware.org>
References: <cover.1215313871.git.vmiklos@frugalware.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/87488>

'show' is a high-level command, scripts are better if they use
'rev-parse'.

Signed-off-by: Miklos Vajna <vmiklos@frugalware.org>
---
 contrib/hg-to-git/hg-to-git.py |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/contrib/hg-to-git/hg-to-git.py b/contrib/hg-to-git/hg-to-git.py
index 7b03204..0ecb38b 100755
--- a/contrib/hg-to-git/hg-to-git.py
+++ b/contrib/hg-to-git/hg-to-git.py
@@ -233,7 +233,7 @@ for cset in range(int(tip) + 1):
         os.system('git branch -d %s' % otherbranch)
 
     # retrieve and record the version
-    vvv = os.popen('git show --quiet --pretty=format:%H').read()
+    vvv = os.popen('git rev-parse HEAD').read()
     print 'record', cset, '->', vvv
     hgvers[str(cset)] = vvv
 
-- 
1.5.6.1.322.ge904b.dirty
