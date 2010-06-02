From: Sylvain Rabot <srabot@steek.com>
Subject: [PATCH] documentation: git-mergetool updated to warn against builtin tools invocations
Date: Wed,  2 Jun 2010 19:57:33 +0200
Message-ID: <1275501453-13081-1-git-send-email-srabot@steek.com>
Cc: gitster@pobox.com, sylvain@abstraction.fr,
	Sylvain Rabot <srabot@steek.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jun 02 20:07:46 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OJsLy-0003Ig-0e
	for gcvg-git-2@lo.gmane.org; Wed, 02 Jun 2010 20:07:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932580Ab0FBSHk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 2 Jun 2010 14:07:40 -0400
Received: from sarca.steek.com ([62.39.111.200]:44023 "EHLO sarca.steek.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932486Ab0FBSHj (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Jun 2010 14:07:39 -0400
X-Greylist: delayed 563 seconds by postgrey-1.27 at vger.kernel.org; Wed, 02 Jun 2010 14:07:39 EDT
Received: from localhost (localhost [127.0.0.1])
	by sarca.steek.com (Postfix) with ESMTP id ED56B94F5;
	Wed,  2 Jun 2010 19:57:54 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at sarca.steek.com
Received: from sarca.steek.com ([127.0.0.1])
	by localhost (sarca.steek.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id tx+WZigbMuh3; Wed,  2 Jun 2010 19:57:52 +0200 (CEST)
Received: from khety (bdn33-3-82-245-81-137.fbx.proxad.net [82.245.81.137])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by sarca.steek.com (Postfix) with ESMTPS id AAA6F94F8;
	Wed,  2 Jun 2010 19:57:52 +0200 (CEST)
Received: from srabot by khety with local (Exim 4.69)
	(envelope-from <srabot@steek.com>)
	id 1OJsCO-0003PZ-7d; Wed, 02 Jun 2010 19:57:52 +0200
X-Mailer: git-send-email 1.7.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/148267>

For known tools such as meld, diffuse, p4merge, git-mergetool ignores the
mergetool.<tool>.* configurations. It took me a while to understand why my
mergetool.diffuse.cmd configuration was not taken care of.

This documentation update warns against this behavior and explains how
to setup a customized command line invocation for known diff tools.

Signed-off-by: Sylvain Rabot <srabot@steek.com>
---
 Documentation/git-mergetool.txt |   15 +++++++++++++++
 1 files changed, 15 insertions(+), 0 deletions(-)

diff --git a/Documentation/git-mergetool.txt b/Documentation/git-mergetool.txt
index 55735fa..ac41d7c 100644
--- a/Documentation/git-mergetool.txt
+++ b/Documentation/git-mergetool.txt
@@ -45,6 +45,21 @@ Instead of running one of the known merge tool programs,
 by specifying the command line to invoke in a configuration
 variable `mergetool.<tool>.cmd`.
 +
+Be aware that 'git mergetool' has some predefined invocation commands builtin
+for known diff tools like meld, diffuse, p4merge ... etc. It means that if
+you set the merge.tool configuration to one of these tools, the 
+mergetool.<tool>.* configurations will not be taken care of. If you
+really want to customize the invocation of one of these tools, 
+set `merge.tool` to "custom" or whatever you want and `mergetool.custom.cmd` 
+to "/usr/bin/<tool> $LOCAL $MERGED $REMOTE"
++
+-------------
+[merge]
+    tool = diffuse-custom
+[mergetool "diffuse-custom"]
+    cmd = diffuse $LOCAL $MERGED $REMOTE
+-------------
++
 When 'git mergetool' is invoked with this tool (either through the
 `-t` or `--tool` option or the `merge.tool` configuration
 variable) the configured command line will be invoked with `$BASE`
-- 
1.7.1
