From: Pavel Roskin <proski@gnu.org>
Subject: [PATCH] git-remote: support remotes with a dot in the name
Date: Wed, 21 Feb 2007 00:03:36 -0500
Message-ID: <20070221050336.26431.46485.stgit@dv.roinet.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Feb 21 06:03:42 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HJjdm-0000eC-1z
	for gcvg-git@gmane.org; Wed, 21 Feb 2007 06:03:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750991AbXBUFDj (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 21 Feb 2007 00:03:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751121AbXBUFDj
	(ORCPT <rfc822;git-outgoing>); Wed, 21 Feb 2007 00:03:39 -0500
Received: from fencepost.gnu.org ([199.232.76.164]:44612 "EHLO
	fencepost.gnu.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750991AbXBUFDi (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 Feb 2007 00:03:38 -0500
Received: from proski by fencepost.gnu.org with local (Exim 4.60)
	(envelope-from <proski@gnu.org>)
	id 1HJjcI-0005LY-3N
	for git@vger.kernel.org; Wed, 21 Feb 2007 00:02:10 -0500
Received: from localhost ([127.0.0.1] helo=dv.roinet.com)
	by gnu.org with esmtp (Exim 4.66)
	(envelope-from <proski@gnu.org>)
	id 1HJjdg-0006sa-T8
	for git@vger.kernel.org; Wed, 21 Feb 2007 00:03:36 -0500
User-Agent: StGIT/0.12
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/40277>

Ignore configuration data other that "url" and "fetch" for the remote. 
We cannot process it to extract the remote name from it reliably. 
Besides, a remote without "url" is currently invalid, so we are not
missing anything.

Signed-off-by: Pavel Roskin <proski@gnu.org>
---

 git-remote.perl |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/git-remote.perl b/git-remote.perl
index 6e473ec..97b5f6c 100755
--- a/git-remote.perl
+++ b/git-remote.perl
@@ -67,7 +67,7 @@ sub list_remote {
 		$git->command(qw(config --get-regexp), '^remote\.');
 	};
 	for (@remotes) {
-		if (/^remote\.([^.]*)\.(\S*)\s+(.*)$/) {
+		if (/^remote\.(\S*)\.(fetch|url)\s+(.*)$/) {
 			add_remote_config(\%seen, $1, $2, $3);
 		}
 	}
