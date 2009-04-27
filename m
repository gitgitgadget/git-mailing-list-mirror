From: Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: [PATCH] t5701: do not get stuck in empty-push/
Date: Tue, 28 Apr 2009 00:12:31 +0200 (CEST)
Message-ID: <3fb85879424c45d4112e08ae4d20d55fd5b58171.1240870321u.git.johannes.schindelin@gmx.de>
References: <cover.1240870321u.git.johannes.schindelin@gmx.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Matthieu Moy <Matthieu.Moy@imag.fr>
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Tue Apr 28 00:13:06 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LyZ4T-0001N6-Ji
	for gcvg-git-2@gmane.org; Tue, 28 Apr 2009 00:13:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757005AbZD0WMW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 27 Apr 2009 18:12:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755714AbZD0WMU
	(ORCPT <rfc822;git-outgoing>); Mon, 27 Apr 2009 18:12:20 -0400
Received: from mail.gmx.net ([213.165.64.20]:54900 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754059AbZD0WMT (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 27 Apr 2009 18:12:19 -0400
Received: (qmail invoked by alias); 27 Apr 2009 22:12:17 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp053) with SMTP; 28 Apr 2009 00:12:17 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/p8o1AVD3pkgxjgilX23XhvJXFnJfGSFVbwYW16p
	JjWUqGBA4q7tIU
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <cover.1240870321u.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.64
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/117721>

When keeping own tests in a private Git tree, it is nice to assume that
the current working directory will not change just because another test
was added in the upstream repository.

Fix a162e78 in that respect.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 t/t5701-clone-local.sh |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/t/t5701-clone-local.sh b/t/t5701-clone-local.sh
index f26b511..19b5c0d 100755
--- a/t/t5701-clone-local.sh
+++ b/t/t5701-clone-local.sh
@@ -138,8 +138,8 @@ test_expect_success 'clone empty repository, and then push should not segfault.'
 	mkdir empty &&
 	(cd empty && git init) &&
 	git clone empty empty-clone &&
-	cd empty-clone &&
-	test_must_fail git push
+	(cd empty-clone &&
+	test_must_fail git push)
 '
 
 test_done
-- 
1.6.3.rc3.326.g039c1
