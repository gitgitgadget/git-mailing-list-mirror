From: Gerrit Pape <pape@smarden.org>
Subject: [PATCH] Fix quoting in update hook template
Date: Fri, 2 Mar 2007 12:20:10 +0000
Message-ID: <20070302122010.5110.qmail@fa54d807064c75.315fe32.mid.smarden.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Mar 02 13:20:00 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HN6jr-00080L-9C
	for gcvg-git@gmane.org; Fri, 02 Mar 2007 13:19:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423056AbXCBMTw (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 2 Mar 2007 07:19:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423055AbXCBMTw
	(ORCPT <rfc822;git-outgoing>); Fri, 2 Mar 2007 07:19:52 -0500
Received: from a.ns.smarden.org ([212.42.242.37]:48750 "HELO a.mx.smarden.org"
	rhost-flags-OK-FAIL-OK-OK) by vger.kernel.org with SMTP
	id S1423056AbXCBMTw (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 Mar 2007 07:19:52 -0500
Received: (qmail 5111 invoked by uid 1000); 2 Mar 2007 12:20:10 -0000
Mail-Followup-To: git@vger.kernel.org
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/41202>

By default allowunannotated is unset in the repo config, hence
$allowunannotated is empty, and must be quoted to not break the syntax.

Signed-off-by: Gerrit Pape <pape@smarden.org>
---
 templates/hooks--update |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/templates/hooks--update b/templates/hooks--update
index fd1f73d..170a4de 100644
--- a/templates/hooks--update
+++ b/templates/hooks--update
@@ -64,7 +64,7 @@ case "$refname","$newrev_type" in
 		# un-annotated tag
 		refname_type="tag"
 		short_refname=${refname##refs/tags/}
-		if [ $allowunannotated != "true" ]; then
+		if [ "$allowunannotated" != "true" ]; then
 			echo "*** The un-annotated tag, $short_refname is not allowed in this repository" >&2
 			echo "*** Use 'git tag [ -a | -s ]' for tags you want to propagate." >&2
 			exit 1
-- 
1.5.0.1
