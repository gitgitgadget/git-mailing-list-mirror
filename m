From: Tony Finch <dot@dotat.at>
Subject: [PATCH v4 3/4] gitweb: omit the repository owner when it is unset
Date: Tue, 20 Aug 2013 17:59:44 +0100
Message-ID: <e5b90eb96919a30661bcad7ba77aba0b6bfcfa72.1377019362.git.dot@dotat.at>
References: <cover.1377019362.git.dot@dotat.at>
Cc: =?UTF-8?Q?Jakub_Nar=C4=99bski?= <jnareb@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Aug 20 19:28:44 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VBpjW-0004nv-UQ
	for gcvg-git-2@plane.gmane.org; Tue, 20 Aug 2013 19:28:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751638Ab3HTR2j (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 20 Aug 2013 13:28:39 -0400
Received: from ppsw-33.csi.cam.ac.uk ([131.111.8.133]:43272 "EHLO
	ppsw-33.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751532Ab3HTR2h (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 Aug 2013 13:28:37 -0400
X-Cam-AntiVirus: no malware found
X-Cam-ScannerInfo: http://www.cam.ac.uk/cs/email/scanner/
Received: from hermes-2.csi.cam.ac.uk ([131.111.8.54]:51936)
	by ppsw-33.csi.cam.ac.uk (smtp.hermes.cam.ac.uk [131.111.8.157]:25)
	with esmtpa (EXTERNAL:fanf2) id 1VBpjQ-0006By-hL (Exim 4.80_167-5a66dd3)
	(return-path <fanf2@hermes.cam.ac.uk>); Tue, 20 Aug 2013 18:28:36 +0100
Received: from fanf2 by hermes-2.csi.cam.ac.uk (hermes.cam.ac.uk)
	with local id 1VBpjQ-0002mh-Cg (Exim 4.72)
	(return-path <fanf2@hermes.cam.ac.uk>); Tue, 20 Aug 2013 18:28:36 +0100
In-Reply-To: <cover.1377019362.git.dot@dotat.at>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/232616>

On the repository summary page, leave the owner line out if the
repo does not have an owner, rather than displaying a labelled empty
field. This does not affect the owner column in the projects list
page, which is present unless $omit_owner is true.

Signed-off-by: Tony Finch <dot@dotat.at>
---
 gitweb/gitweb.perl | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index 8d69ada..c029b98 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -6463,7 +6463,7 @@ sub git_summary {
 	print "<div class=\"title\">&nbsp;</div>\n";
 	print "<table class=\"projects_list\">\n" .
 	      "<tr id=\"metadata_desc\"><td>description</td><td>" . esc_html($descr) . "</td></tr>\n";
-        unless ($omit_owner) {
+        if ($owner and not $omit_owner) {
 	        print  "<tr id=\"metadata_owner\"><td>owner</td><td>" . esc_html($owner) . "</td></tr>\n";
         }
 	if (defined $cd{'rfc2822'}) {
-- 
1.8.3.1.605.g85318f5
