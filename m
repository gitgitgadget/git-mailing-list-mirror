From: Alex Chiang <achiang@hp.com>
Subject: [StGit PATCH] fix stg mail %(shortlog)s order
Date: Thu, 18 Jun 2009 23:30:40 -0600
Message-ID: <20090619053040.GE21764@ldl.fc.hp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: catalin.marinas@gmail.com, kha@treskal.com
X-From: git-owner@vger.kernel.org Fri Jun 19 07:30:49 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MHWga-00050r-GK
	for gcvg-git-2@gmane.org; Fri, 19 Jun 2009 07:30:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751705AbZFSFaj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 19 Jun 2009 01:30:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751428AbZFSFai
	(ORCPT <rfc822;git-outgoing>); Fri, 19 Jun 2009 01:30:38 -0400
Received: from g4t0014.houston.hp.com ([15.201.24.17]:16830 "EHLO
	g4t0014.houston.hp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751279AbZFSFai (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Jun 2009 01:30:38 -0400
Received: from g4t0018.houston.hp.com (g4t0018.houston.hp.com [16.234.32.27])
	by g4t0014.houston.hp.com (Postfix) with ESMTP id 259CE247DC;
	Fri, 19 Jun 2009 05:30:41 +0000 (UTC)
Received: from ldl.fc.hp.com (ldl.fc.hp.com [15.11.146.30])
	by g4t0018.houston.hp.com (Postfix) with ESMTP id D2E8F104E0;
	Fri, 19 Jun 2009 05:30:40 +0000 (UTC)
Received: by ldl.fc.hp.com (Postfix, from userid 17609)
	id 98D8139C003; Thu, 18 Jun 2009 23:30:40 -0600 (MDT)
Content-Disposition: inline
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/121883>

When using the %(shortlog)s variable, the patches are listed in
the cover letter in the reverse order of the actual patch series.

We should list them in the actual order of the patch series instead.

Signed-off-by: Alex Chiang <achiang@hp.com>
---
diff --git a/stgit/commands/mail.py b/stgit/commands/mail.py
index 69b19fa..abd42e4 100644
--- a/stgit/commands/mail.py
+++ b/stgit/commands/mail.py
@@ -399,7 +399,7 @@ def __build_cover(tmpl, patches, msg_id, options):
                  'totalnr':      total_nr_str,
                  'number':       number_str,
                  'shortlog':     stack.shortlog(crt_series.get_patch(p)
-                                                for p in patches),
+                                                for p in reversed(patches)),
                  'diffstat':     gitlib.diffstat(git.diff(
                      rev1 = git_id(crt_series, '%s^' % patches[0]),
                      rev2 = git_id(crt_series, '%s' % patches[-1]),
