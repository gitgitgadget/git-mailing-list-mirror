From: Brandon Casey <casey@nrlssc.navy.mil>
Subject: [PATCH 5/5] t/t1304: make a second colon optional in the mask ACL check
Date: Mon, 15 Mar 2010 12:14:37 -0500
Message-ID: <YowxgPZqaOkg2MZzY1CxL2y9KYLK5N2WFlWwYu3VB6Y3RrTnbp2pATZ27RaMhDiRScZADoVUqz4@cipher.nrlssc.navy.mil>
References: <YowxgPZqaOkg2MZzY1CxL1fbmUZ7CMUf5DgqI3S0X83DgqLNI9AGfI83JRNT8LWYHqXBB-PGS1Q@cipher.nrlssc.navy.mil>
Cc: Matthieu.Moy@imag.fr, Brandon Casey <drafnel@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Mar 15 18:16:08 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NrDtX-0004dk-9Y
	for gcvg-git-2@lo.gmane.org; Mon, 15 Mar 2010 18:15:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965536Ab0CORPc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Mar 2010 13:15:32 -0400
Received: from mail1.nrlssc.navy.mil ([128.160.35.1]:43479 "EHLO
	mail.nrlssc.navy.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965529Ab0CORP0 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Mar 2010 13:15:26 -0400
Received: by mail.nrlssc.navy.mil id o2FHFGpK002288; Mon, 15 Mar 2010 12:15:16 -0500
In-Reply-To: <YowxgPZqaOkg2MZzY1CxL1fbmUZ7CMUf5DgqI3S0X83DgqLNI9AGfI83JRNT8LWYHqXBB-PGS1Q@cipher.nrlssc.navy.mil>
X-OriginalArrivalTime: 15 Mar 2010 17:15:15.0795 (UTC) FILETIME=[147BE230:01CAC463]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/142233>

From: Brandon Casey <drafnel@gmail.com>

Solaris only uses one colon in the listing of the ACL mask, Linux uses two,
so substitute egrep for grep and make the second colon optional.

The -q option for Solaris 7's /usr/xpg4/bin/egrep does not appear to be
implemented, so redirect output to /dev/null.

Signed-off-by: Brandon Casey <casey@nrlssc.navy.mil>
---
 t/t1304-default-acl.sh |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/t/t1304-default-acl.sh b/t/t1304-default-acl.sh
index 85351ae..055ad00 100755
--- a/t/t1304-default-acl.sh
+++ b/t/t1304-default-acl.sh
@@ -25,7 +25,7 @@ check_perms_and_acl () {
 	getfacl "$1" > actual &&
 	grep -q "user:root:rwx" actual &&
 	grep -q "user:${LOGNAME}:rwx" actual &&
-	grep -q "mask::r--" actual &&
+	egrep "mask::?r--" actual > /dev/null 2>&1 &&
 	grep -q "group::---" actual || false
 }
 
-- 
1.6.6.2
