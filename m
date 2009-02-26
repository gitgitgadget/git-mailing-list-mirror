From: Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: [PATCH 1/2] clone: do not ignore --no-hardlinks
Date: Fri, 27 Feb 2009 00:31:22 +0100 (CET)
Message-ID: <da2c9173f403c4fb509609fb823b6be0728d94f3.1235690903u.git.johannes.schindelin@gmx.de>
References: <alpine.DEB.1.00.0902262352380.10279@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
To: git@vger.kernel.org, Daniel Barkalow <barkalow@iabervon.org>,
	gitster@pobox.com
X-From: git-owner@vger.kernel.org Fri Feb 27 00:31:51 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lcphj-0000Ri-3p
	for gcvg-git-2@gmane.org; Fri, 27 Feb 2009 00:31:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755478AbZBZXaK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 Feb 2009 18:30:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755114AbZBZXaJ
	(ORCPT <rfc822;git-outgoing>); Thu, 26 Feb 2009 18:30:09 -0500
Received: from mail.gmx.net ([213.165.64.20]:37413 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1755366AbZBZXaI (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 Feb 2009 18:30:08 -0500
Received: (qmail invoked by alias); 26 Feb 2009 23:30:05 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp007) with SMTP; 27 Feb 2009 00:30:05 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+geskGwM+ghvL1pEh1RVG214wX/8yCwP6JCEe5g9
	/Bv+cxGx98dmw1
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <alpine.DEB.1.00.0902262352380.10279@pacific.mpi-cbg.de>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.61
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/111612>

Somehow --no-hardlinks got broken by making clone a builtin.  This
was discovered during my work on --depth being ignored for local
clones.

There will be a test case that tests for --no-hardlinks in conjunction
with --depth, so this patch is not accompanied by a separate test.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 builtin-clone.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/builtin-clone.c b/builtin-clone.c
index c338910..5540372 100644
--- a/builtin-clone.c
+++ b/builtin-clone.c
@@ -511,7 +511,7 @@ int cmd_clone(int argc, const char **argv, const char *prefix)
 	refspec.src = src_ref_prefix;
 	refspec.dst = branch_top.buf;
 
-	if (path && !is_bundle)
+	if (path && !is_bundle && use_local_hardlinks)
 		refs = clone_local(path, git_dir);
 	else {
 		struct remote *remote = remote_get(argv[0]);
-- 
1.6.2.rc2.404.g8394e
