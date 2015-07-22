From: Jacob Keller <jacob.e.keller@intel.com>
Subject: [PATCH 1/2] refs: cleanup comments regarding check_refname_component
Date: Wed, 22 Jul 2015 14:05:32 -0700
Message-ID: <1437599133-13012-2-git-send-email-jacob.e.keller@intel.com>
References: <1437599133-13012-1-git-send-email-jacob.e.keller@intel.com>
Cc: Jacob Keller <jacob.keller@gmail.com>,
	Daniel Barkalow <barkalow@iabervon.iabervon.org>,
	Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jul 22 23:05:50 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZI1D4-0004cH-0O
	for gcvg-git-2@plane.gmane.org; Wed, 22 Jul 2015 23:05:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751895AbbGVVFk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 22 Jul 2015 17:05:40 -0400
Received: from mga03.intel.com ([134.134.136.65]:27486 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750910AbbGVVFi (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 22 Jul 2015 17:05:38 -0400
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga103.jf.intel.com with ESMTP; 22 Jul 2015 14:05:36 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.15,525,1432623600"; 
   d="scan'208";a="769372404"
Received: from jekeller-desk.amr.corp.intel.com ([134.134.3.85])
  by orsmga002.jf.intel.com with ESMTP; 22 Jul 2015 14:05:36 -0700
X-Mailer: git-send-email 2.4.3
In-Reply-To: <1437599133-13012-1-git-send-email-jacob.e.keller@intel.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/274469>

From: Jacob Keller <jacob.keller@gmail.com>

Correctly specify all characters which are rejected under the '4'
disposition, including '*' even though it does gain special treatment by
callers of check_refname_component.

Cleanup comment style for rejected refs by inserting a ", or" at the end
of each statement.

Signed-off-by: Jacob Keller <jacob.keller@gmail.com>
Cc: Daniel Barkalow <barkalow@iabervon.iabervon.org>
Cc: Junio C Hamano <gitster@pobox.com>
---
 refs.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/refs.c b/refs.c
index ce8cd8d45001..8c08fc0489eb 100644
--- a/refs.c
+++ b/refs.c
@@ -19,7 +19,8 @@ struct ref_lock {
  * 1: End-of-component
  * 2: ., look for a preceding . to reject .. in refs
  * 3: {, look for a preceding @ to reject @{ in refs
- * 4: A bad character: ASCII control characters, "~", "^", ":" or SP
+ * 4: A bad character: ASCII control characters, and
+ *    "*", ":", "?", "[", "\", "^", "~", SP, or TAB
  */
 static unsigned char refname_disposition[256] = {
 	1, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4,
@@ -70,10 +71,11 @@ static unsigned char refname_disposition[256] = {
  *
  * - any path component of it begins with ".", or
  * - it has double dots "..", or
- * - it has ASCII control character, "~", "^", ":" or SP, anywhere, or
- * - it ends with a "/".
- * - it ends with ".lock"
- * - it contains a "\" (backslash)
+ * - it has ASCII control characters, or
+ * - it has "*", ":", "?", "[", "\", "^", "~", SP, or TAB anywhere, or
+ * - it ends with a "/", or
+ * - it ends with ".lock", or
+ * - it contains a "@{" portion
  */
 static int check_refname_component(const char *refname, int flags)
 {
-- 
2.4.3
