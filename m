From: Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: [PATCH 5/8] t/Makefile: provide a 'valgrind' target
Date: Wed, 4 Feb 2009 00:26:18 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0902040026170.9822@pacific.mpi-cbg.de>
References: <cover.1233702893u.git.johannes.schindelin@gmx.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: gitster@pobox.com, peff@peff.net
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Feb 04 00:27:36 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LUUfx-0007K0-TR
	for gcvg-git-2@gmane.org; Wed, 04 Feb 2009 00:27:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752485AbZBCXZs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Feb 2009 18:25:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752360AbZBCXZr
	(ORCPT <rfc822;git-outgoing>); Tue, 3 Feb 2009 18:25:47 -0500
Received: from mail.gmx.net ([213.165.64.20]:38675 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752332AbZBCXZr (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Feb 2009 18:25:47 -0500
Received: (qmail invoked by alias); 03 Feb 2009 23:25:45 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp014) with SMTP; 04 Feb 2009 00:25:45 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19mpIgfbNNmZGnE63c/r9omPHBlnjfrXXmSvo66Uh
	zQrku0gIQtY11J
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <cover.1233702893u.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.51
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/108273>

It is easy to forget running valgrinded tests without -v, and it is
also easy to forget to redirect the output to "tee" (lest the output
scroll out of the terminal's buffer).  Running "make valgrind" will
take care of all that.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 t/Makefile |    5 ++++-
 1 files changed, 4 insertions(+), 1 deletions(-)

diff --git a/t/Makefile b/t/Makefile
index ed49c20..e544493 100644
--- a/t/Makefile
+++ b/t/Makefile
@@ -38,4 +38,7 @@ full-svn-test:
 	$(MAKE) $(TSVN) GIT_SVN_NO_OPTIMIZE_COMMITS=1 LC_ALL=C
 	$(MAKE) $(TSVN) GIT_SVN_NO_OPTIMIZE_COMMITS=0 LC_ALL=en_US.UTF-8
 
-.PHONY: pre-clean $(T) aggregate-results clean
+valgrind:
+	GIT_TEST_OPTS='--valgrind -v --tee' $(MAKE) -k
+
+.PHONY: pre-clean $(T) aggregate-results clean valgrind
-- 
1.6.1.2.582.g3fdd5
