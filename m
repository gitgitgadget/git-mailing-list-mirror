From: Pavel Roskin <proski@gnu.org>
Subject: [PATCH 2/2] cogito: understand permissions written as "100755"
Date: Tue, 20 Mar 2007 13:04:29 -0400
Message-ID: <20070320170428.9139.69748.stgit@dv.roinet.com>
References: <20070320170423.9139.43914.stgit@dv.roinet.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Petr Baudis <pasky@suse.cz>
X-From: git-owner@vger.kernel.org Tue Mar 20 18:04:54 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HThlP-0004b9-Jo
	for gcvg-git@gmane.org; Tue, 20 Mar 2007 18:04:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965491AbXCTREc (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 20 Mar 2007 13:04:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965489AbXCTREc
	(ORCPT <rfc822;git-outgoing>); Tue, 20 Mar 2007 13:04:32 -0400
Received: from fencepost.gnu.org ([199.232.76.164]:49647 "EHLO
	fencepost.gnu.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965346AbXCTREb (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 Mar 2007 13:04:31 -0400
Received: from proski by fencepost.gnu.org with local (Exim 4.60)
	(envelope-from <proski@gnu.org>)
	id 1HThjD-0006Ql-2y
	for git@vger.kernel.org; Tue, 20 Mar 2007 13:02:31 -0400
Received: from localhost ([127.0.0.1] helo=dv.roinet.com)
	by gnu.org with esmtp (Exim 4.66)
	(envelope-from <proski@gnu.org>)
	id 1HThl7-0002PZ-14; Tue, 20 Mar 2007 13:04:29 -0400
In-Reply-To: <20070320170423.9139.43914.stgit@dv.roinet.com>
User-Agent: StGIT/0.12
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/42752>

The original code only recognized "755", which is not working anymore. 
This fixes t9204-merge-weird-conflicts.sh

Signed-off-by: Pavel Roskin <proski@gnu.org>
---

 cg-Xmergefile |   11 ++++++-----
 1 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/cg-Xmergefile b/cg-Xmergefile
index ac9d356..1219d1f 100755
--- a/cg-Xmergefile
+++ b/cg-Xmergefile
@@ -53,11 +53,12 @@ warning()
 # PlusMinus+XModeChar ;-)
 pmxmc()
 {
-	if [ "$1" = "755" ]; then
-		_pmxmc=+
-	else
-		_pmxmc=-
-	fi
+	case "$1" in
+	*755)
+		_pmxmc=+;;
+	*)
+		_pmxmc=-;;
+	esac
 }
 
 # Set ways[] to the symbolic names of the particular ways
