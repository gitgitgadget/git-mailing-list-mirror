From: Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: [PATCH] Fix off-by-one in read_tree_recursive
Date: Mon, 20 Apr 2009 19:44:53 +0200 (CEST)
Message-ID: <f62793069ecb99138c435edf37533906c4aae301.1240249482u.git.johannes.schindelin@gmx.de>
References: <cover.1240249482u.git.johannes.schindelin@gmx.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Mon Apr 20 19:46:53 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LvxZg-0002HZ-Ch
	for gcvg-git-2@gmane.org; Mon, 20 Apr 2009 19:46:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753317AbZDTRo5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 20 Apr 2009 13:44:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752085AbZDTRo5
	(ORCPT <rfc822;git-outgoing>); Mon, 20 Apr 2009 13:44:57 -0400
Received: from mail.gmx.net ([213.165.64.20]:47538 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751644AbZDTRo4 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Apr 2009 13:44:56 -0400
Received: (qmail invoked by alias); 20 Apr 2009 17:44:54 -0000
Received: from cbg-off-client.mpi-cbg.de (EHLO intel-tinevez-2-302.mpi-cbg.de) [141.5.11.5]
  by mail.gmx.net (mp067) with SMTP; 20 Apr 2009 19:44:54 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX187ASYt7f077bDdiJLIUumjtcNFs521oCZMuMqZ78
	4H27iSUgBR6AMf
X-X-Sender: schindel@intel-tinevez-2-302
In-Reply-To: <cover.1240249482u.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.67
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/117010>

Found by valgrind.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 tree.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/tree.c b/tree.c
index 0d703a0..5ab90af 100644
--- a/tree.c
+++ b/tree.c
@@ -62,6 +62,7 @@ static int match_tree_entry(const char *base, int baselen, const char *path, uns
 				continue;
 			/* pathspecs match only at the directory boundaries */
 			if (!matchlen ||
+			    baselen == matchlen ||
 			    base[matchlen] == '/' ||
 			    match[matchlen - 1] == '/')
 				return 1;
-- 
1.6.2.1.493.g67cf3
