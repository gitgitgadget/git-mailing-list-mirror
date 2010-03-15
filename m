From: Brandon Casey <casey@nrlssc.navy.mil>
Subject: [PATCH 4/5 v2] t/t1304: set the ACL effective rights mask
Date: Mon, 15 Mar 2010 13:35:03 -0500
Message-ID: <1OHmOAV6PwNgTpkrT1e6TCcWFBFU-8KuDhDpWjm2BlkAUdaqw5vTu9fV5pO66uT2OLcDdYFhZAU@cipher.nrlssc.navy.mil>
References: <YowxgPZqaOkg2MZzY1CxLzeL4DIwxt_o3RKS9xen-cewKbECZA7OIb7mUaY2TbsVR_rHE5GTeU0@cipher.nrlssc.navy.mil>
Cc: Matthieu.Moy@grenoble-inp.fr, Brandon Casey <drafnel@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Mar 15 19:35:35 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NrF8Z-0003aA-IM
	for gcvg-git-2@lo.gmane.org; Mon, 15 Mar 2010 19:35:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757496Ab0COSfa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Mar 2010 14:35:30 -0400
Received: from mail1.nrlssc.navy.mil ([128.160.35.1]:33743 "EHLO
	mail.nrlssc.navy.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752640Ab0COSfa (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Mar 2010 14:35:30 -0400
Received: by mail.nrlssc.navy.mil id o2FIZGpj010972; Mon, 15 Mar 2010 13:35:16 -0500
In-Reply-To: <YowxgPZqaOkg2MZzY1CxLzeL4DIwxt_o3RKS9xen-cewKbECZA7OIb7mUaY2TbsVR_rHE5GTeU0@cipher.nrlssc.navy.mil>
X-OriginalArrivalTime: 15 Mar 2010 18:35:16.0106 (UTC) FILETIME=[41B136A0:01CAC46E]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/142242>

From: Brandon Casey <drafnel@gmail.com>

Some implementations of setfacl do not recalculate the effective rights
mask when the ACL is modified.  So, set the effective rights mask
explicitly to ensure that the ACL's that are set on the directories will
have effect.

Signed-off-by: Brandon Casey <casey@nrlssc.navy.mil>
---


Here's a new patch with an improved commit message (hopefully).

-brandon


 t/t1304-default-acl.sh |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/t/t1304-default-acl.sh b/t/t1304-default-acl.sh
index 52246d7..85351ae 100755
--- a/t/t1304-default-acl.sh
+++ b/t/t1304-default-acl.sh
@@ -33,6 +33,7 @@ dirs_to_set="./ .git/ .git/objects/ .git/objects/pack/"
 
 test_expect_success 'Setup test repo' '
 	setfacl -m d:u::rwx,d:g::---,d:o:---,d:m:rwx $dirs_to_set &&
+	setfacl -m m:rwx               $dirs_to_set &&
 	setfacl -m u:root:rwx          $dirs_to_set &&
 	setfacl -m d:u:"$LOGNAME":rwx  $dirs_to_set &&
 	setfacl -m d:u:root:rwx        $dirs_to_set &&
-- 
1.6.6.2
