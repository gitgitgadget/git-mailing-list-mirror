From: Karl =?utf-8?q?Hasselstr=C3=B6m?= <kha@treskal.com>
Subject: [StGit PATCH 2/2] Use the builtin set() instead of sets.Set()
Date: Mon, 03 Sep 2007 23:48:51 +0200
Message-ID: <20070903214851.18057.89136.stgit@yoghurt>
References: <20070903214545.18057.79301.stgit@yoghurt>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Catalin Marinas <catalin.marinas@gmail.com>
X-From: git-owner@vger.kernel.org Mon Sep 03 23:49:12 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ISJnB-00080I-8g
	for gcvg-git@gmane.org; Mon, 03 Sep 2007 23:49:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754384AbXICVs4 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Mon, 3 Sep 2007 17:48:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754142AbXICVs4
	(ORCPT <rfc822;git-outgoing>); Mon, 3 Sep 2007 17:48:56 -0400
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:2702 "EHLO
	diana.vm.bytemark.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754379AbXICVsz (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Sep 2007 17:48:55 -0400
Received: from localhost ([127.0.0.1] helo=[127.0.1.1])
	by diana.vm.bytemark.co.uk with esmtp (Exim 3.36 #1 (Debian))
	id 1ISJmt-0004K8-00; Mon, 03 Sep 2007 22:48:51 +0100
In-Reply-To: <20070903214545.18057.79301.stgit@yoghurt>
User-Agent: StGIT/0.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/57508>

We can do that now that we're guaranteed to have Python 2.4 or later.

Signed-off-by: Karl Hasselstr=C3=B6m <kha@treskal.com>

---

 stgit/git.py |    8 +++-----
 1 files changed, 3 insertions(+), 5 deletions(-)


diff --git a/stgit/git.py b/stgit/git.py
index 8857209..4b4c626 100644
--- a/stgit/git.py
+++ b/stgit/git.py
@@ -26,7 +26,6 @@ from stgit.utils import *
 from stgit.out import *
 from stgit.run import *
 from stgit.config import config
-from sets import Set
=20
 # git exception class
 class GitException(Exception):
@@ -959,10 +958,9 @@ def __remotes_from_dir(dir):
 def remotes_list():
     """Return the list of remotes in the repository
     """
-
-    return Set(__remotes_from_config()) | \
-           Set(__remotes_from_dir('remotes')) | \
-           Set(__remotes_from_dir('branches'))
+    return (set(__remotes_from_config())
+            | set(__remotes_from_dir('remotes'))
+            | set(__remotes_from_dir('branches')))
=20
 def remotes_local_branches(remote):
     """Returns the list of local branches fetched from given remote
