From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH 1/2] Simplify and fix t9301
Date: Sun, 23 Nov 2008 12:55:18 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0811231254580.30769@pacific.mpi-cbg.de>
References: <1227378168-14992-1-git-send-email-vmiklos@frugalware.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, gitster@pobox.com
To: Miklos Vajna <vmiklos@frugalware.org>
X-From: git-owner@vger.kernel.org Sun Nov 23 12:48:54 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L4DSQ-00043D-7f
	for gcvg-git-2@gmane.org; Sun, 23 Nov 2008 12:48:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757505AbYKWLrR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 23 Nov 2008 06:47:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757366AbYKWLrR
	(ORCPT <rfc822;git-outgoing>); Sun, 23 Nov 2008 06:47:17 -0500
Received: from mail.gmx.net ([213.165.64.20]:49976 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1757185AbYKWLrQ (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 23 Nov 2008 06:47:16 -0500
Received: (qmail invoked by alias); 23 Nov 2008 11:47:13 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp013) with SMTP; 23 Nov 2008 12:47:14 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/w1kpPCdPwRi8lYtQMyh5MLUFy33RY+aHPMP5GfN
	yk73DRENSZDNBb
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <1227378168-14992-1-git-send-email-vmiklos@frugalware.org>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.61
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/101568>


The recent addition to the test to show the tag related breakage was
not minimal.

Further, it tested for the string "tag" at the start of the lines,
which matches, "tagger", too.  Test for "tag " instead.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---

	I'll have no problem if this is squashed into Miklos' patch.

 t/t9301-fast-export.sh |    5 +----
 1 files changed, 1 insertions(+), 4 deletions(-)

diff --git a/t/t9301-fast-export.sh b/t/t9301-fast-export.sh
index 078832f..9af50b5 100755
--- a/t/t9301-fast-export.sh
+++ b/t/t9301-fast-export.sh
@@ -234,11 +234,8 @@ test_expect_success 'fast-export -C -C | fast-import' '
 test_expect_failure 'fast-export | fast-import when master is tagged' '
 
 	git tag -m msg last &&
-	rm -rf new &&
-	mkdir new &&
-	git --git-dir=new/.git init &&
 	git fast-export -C -C --signed-tags=strip --all > output &&
-	test $(grep -c "^tag" output) = 3
+	test $(grep -c "^tag " output) = 3
 
 '
 
-- 
1.6.0.2.749.g0cc32
