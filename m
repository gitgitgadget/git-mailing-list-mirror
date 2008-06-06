From: Catalin Marinas <catalin.marinas@gmail.com>
Subject: [StGIT PATCH 4/5] Convert "init" to the new StGIT infrastructure
Date: Fri, 06 Jun 2008 21:46:02 +0100
Message-ID: <20080606204602.8805.44240.stgit@localhost.localdomain>
References: <20080606204322.8805.32313.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: Karl =?utf-8?q?Hasselstr=C3=B6m?= <kha@treskal.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jun 06 22:47:33 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K4iqP-0001dA-4Z
	for gcvg-git-2@gmane.org; Fri, 06 Jun 2008 22:47:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1764864AbYFFUqJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 Jun 2008 16:46:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1765001AbYFFUqI
	(ORCPT <rfc822;git-outgoing>); Fri, 6 Jun 2008 16:46:08 -0400
Received: from mtaout02-winn.ispmail.ntl.com ([81.103.221.48]:41340 "EHLO
	mtaout02-winn.ispmail.ntl.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1764833AbYFFUqG (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 6 Jun 2008 16:46:06 -0400
Received: from aamtaout02-winn.ispmail.ntl.com ([81.103.221.35])
          by mtaout02-winn.ispmail.ntl.com with ESMTP
          id <20080606205024.YPPZ7070.mtaout02-winn.ispmail.ntl.com@aamtaout02-winn.ispmail.ntl.com>;
          Fri, 6 Jun 2008 21:50:24 +0100
Received: from localhost.localdomain ([86.7.22.36])
          by aamtaout02-winn.ispmail.ntl.com with ESMTP
          id <20080606204903.IROB29365.aamtaout02-winn.ispmail.ntl.com@localhost.localdomain>;
          Fri, 6 Jun 2008 21:49:03 +0100
In-Reply-To: <20080606204322.8805.32313.stgit@localhost.localdomain>
User-Agent: StGIT/0.14.2.168.ge637
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/84111>

Signed-off-by: Catalin Marinas <catalin.marinas@gmail.com>
---

 stgit/commands/init.py |   14 ++++----------
 1 files changed, 4 insertions(+), 10 deletions(-)

diff --git a/stgit/commands/init.py b/stgit/commands/init.py
index 475a4ce..b68acd7 100644
--- a/stgit/commands/init.py
+++ b/stgit/commands/init.py
@@ -16,13 +16,8 @@ along with this program; if not, write to the Free Software
 Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA
 """
 
-import sys, os
-from optparse import OptionParser, make_option
-
-from stgit.commands.common import *
-from stgit.utils import *
-from stgit import stack, git
-
+from stgit.commands import common
+from stgit.lib import stack
 
 help = 'initialise the current branch for use with StGIT'
 usage = """%prog [options]
@@ -31,14 +26,13 @@ Initialise the current GIT branch to be used as an StGIT stack. Note
 that you must already be in a GIT repository and .git/HEAD must point
 to a valid file in refs/heads/."""
 
-directory = DirectoryHasRepository()
+directory = common.DirectoryHasRepositoryLib()
 options = []
 
-
 def func(parser, options, args):
     """Performs the repository initialisation
     """
     if len(args) != 0:
         parser.error('incorrect number of arguments')
 
-    crt_series.init()
+    stack.Stack.initialise(directory.repository)
