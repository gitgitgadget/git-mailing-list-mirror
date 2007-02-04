From: Pavel Roskin <proski@gnu.org>
Subject: [PATCH] git-config --rename-section could rename wrong section
Date: Sat, 03 Feb 2007 22:01:04 -0500
Message-ID: <20070204030104.26499.77905.stgit@dv.roinet.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Feb 04 04:01:20 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HDXcx-0004T6-O5
	for gcvg-git@gmane.org; Sun, 04 Feb 2007 04:01:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751994AbXBDDBI (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 3 Feb 2007 22:01:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752003AbXBDDBI
	(ORCPT <rfc822;git-outgoing>); Sat, 3 Feb 2007 22:01:08 -0500
Received: from fencepost.gnu.org ([199.232.76.164]:44367 "EHLO
	fencepost.gnu.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751994AbXBDDBG (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 3 Feb 2007 22:01:06 -0500
Received: from proski by fencepost.gnu.org with local (Exim 4.60)
	(envelope-from <proski@gnu.org>)
	id 1HDXbk-000680-MF
	for git@vger.kernel.org; Sat, 03 Feb 2007 22:00:00 -0500
Received: from localhost ([127.0.0.1] helo=dv.roinet.com)
	by gnu.org with esmtp (Exim 4.63)
	(envelope-from <proski@gnu.org>)
	id 1HDXcm-0006tg-Gr
	for git@vger.kernel.org; Sat, 03 Feb 2007 22:01:04 -0500
User-Agent: StGIT/0.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/38641>

The "git-config --rename-section" implementation would match sections
that are substrings of the section name to be renamed.

Signed-off-by: Pavel Roskin <proski@gnu.org>
---

 config.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/config.c b/config.c
index c08c668..d821071 100644
--- a/config.c
+++ b/config.c
@@ -896,7 +896,7 @@ int git_config_rename_section(const char *old_name, const char *new_name)
 				if (buf[i] != old_name[j++])
 					break;
 			}
-			if (buf[i] == ']') {
+			if (buf[i] == ']' && old_name[j] == 0) {
 				/* old_name matches */
 				ret++;
 				store.baselen = strlen(new_name);
