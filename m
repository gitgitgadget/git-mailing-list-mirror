From: Philip Oakley <philipoakley@iee.org>
Subject: [PATCH v2] doc: core.ignoreStat update, and clarify the --assume-unchanged effect
Date: Fri,  2 Jan 2015 00:18:30 +0000
Message-ID: <1420157910-2252-1-git-send-email-philipoakley@iee.org>
Cc: GitList <git@vger.kernel.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jan 02 01:17:58 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Y6pwB-000816-TD
	for gcvg-git-2@plane.gmane.org; Fri, 02 Jan 2015 01:17:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751630AbbABARw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 1 Jan 2015 19:17:52 -0500
Received: from out1.ip05ir2.opaltelecom.net ([62.24.128.241]:17169 "EHLO
	out1.ip05ir2.opaltelecom.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751563AbbABARv (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 1 Jan 2015 19:17:51 -0500
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: AmQWAFnipVROl3wVPGdsb2JhbABcgwUBAYEpgjaDeYFXr1qOQoV8BAKBBhcBAQEBAQEFAQEBATg7hGkeBRiBAgoaE4gwwkwsj3eEMAWELZNoijKGEYFnbYE8PjGCQwEBAQ
X-IPAS-Result: AmQWAFnipVROl3wVPGdsb2JhbABcgwUBAYEpgjaDeYFXr1qOQoV8BAKBBhcBAQEBAQEFAQEBATg7hGkeBRiBAgoaE4gwwkwsj3eEMAWELZNoijKGEYFnbYE8PjGCQwEBAQ
X-IronPort-AV: E=Sophos;i="5.07,681,1413241200"; 
   d="scan'208";a="579880835"
Received: from host-78-151-124-21.as13285.net (HELO localhost) ([78.151.124.21])
  by out1.ip05ir2.opaltelecom.net with ESMTP; 02 Jan 2015 00:17:51 +0000
X-Mailer: git-send-email 1.9.5.msysgit.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/261974>

The assume-unchanged bit, and consequently core.ignoreStat, can be
misunderstood. Be assertive about the expectation that file changes should
notified to Git.

Signed-off-by: Philip Oakley <philipoakley@iee.org>
---
Overhaul the general wording thus:
    1. direct description of what is ignored given first.
    2. example instruction of the user manual action required.
    3. use sideways indirection for assume-unchanged and update-index references.
    4. add a 'normally' to give leeway for the change detection.

This version is on top of the current master, and replaces the patch in next.
---
 Documentation/config.txt | 18 +++++++++++-------
 1 file changed, 11 insertions(+), 7 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 6862e3e..32e42dd 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -375,13 +375,17 @@ This is useful for excluding servers inside a firewall from
 proxy use, while defaulting to a common proxy for external domains.
 
 core.ignoreStat::
-	If true, commands which modify both the working tree and the index
-	will mark the updated paths with the "assume unchanged" bit in the
-	index. These marked files are then assumed to stay unchanged in the
-	working tree, until you mark them otherwise manually - Git will not
-	detect the file changes	by lstat() calls. This is useful on systems
-	where those are very slow, such as Microsoft Windows.
-	See linkgit:git-update-index[1].
+	If true, Git will avoid using lstat() calls to detect if files have
+	changed. Git will set the "assume-unchanged" bit for those tracked files
+	which it has updated identically in both the index and working tree.
++
+	When files are modified outside of Git, the user will need to stage
+	the modified files explicitly (e.g. see 'Examples' section in
+	linkgit:git-update-index[1]).
+	Git will not normally detect changes to those files.
++
+	This is useful on systems where lstat() calls are very slow, such as
+	CIFS/Microsoft Windows.
 	False by default.
 
 core.preferSymlinkRefs::
-- 
1.9.5.msysgit.0
