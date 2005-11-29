From: Chuck Lever <cel@netapp.com>
Subject: [PATCH 1/7] Make "stg export" save the base commit in the output directory
Date: Tue, 29 Nov 2005 17:09:38 -0500
Message-ID: <20051129220938.9885.37456.stgit@dexter.citi.umich.edu>
References: <20051129220552.9885.41086.stgit@dexter.citi.umich.edu>
Reply-To: Chuck Lever <cel@citi.umich.edu>
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Nov 29 23:13:53 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EhDfi-0006zv-25
	for gcvg-git@gmane.org; Tue, 29 Nov 2005 23:09:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964771AbVK2WJk (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 29 Nov 2005 17:09:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932440AbVK2WJk
	(ORCPT <rfc822;git-outgoing>); Tue, 29 Nov 2005 17:09:40 -0500
Received: from citi.umich.edu ([141.211.133.111]:30239 "EHLO citi.umich.edu")
	by vger.kernel.org with ESMTP id S932438AbVK2WJi (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 29 Nov 2005 17:09:38 -0500
Received: from dexter.citi.umich.edu (dexter.citi.umich.edu [141.211.133.33])
	by citi.umich.edu (Postfix) with ESMTP id 81CF51BBD7;
	Tue, 29 Nov 2005 17:09:38 -0500 (EST)
To: catalin.marinas@gmail.com
In-Reply-To: <20051129220552.9885.41086.stgit@dexter.citi.umich.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/12964>

When trying to apply a series of diffs that was exported from an StGIT
series, it can be convenient to know exactly which base commit the
patches apply to.  Save that commit in a file patchdir/base.

Signed-off-by: Chuck Lever <cel@netapp.com>
---

 stgit/commands/export.py |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/stgit/commands/export.py b/stgit/commands/export.py
index 0ef7d07..167a8d3 100644
--- a/stgit/commands/export.py
+++ b/stgit/commands/export.py
@@ -141,6 +141,10 @@ def func(parser, options, args):
             tmpl = file(patch_tmpl).read()
             break
 
+    # note the base commit for this series
+    write_string(os.path.join(dirname, 'base'), \
+                 crt_series.get_patch(patches[0]).get_bottom())
+
     patch_no = 1;
     for p in patches:
         pname = p
