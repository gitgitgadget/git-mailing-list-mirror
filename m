From: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
Subject: [PATCH 2/6] refs.c: Fix a sparse warning
Date: Sun, 06 Oct 2013 21:49:18 +0100
Message-ID: <5251CCCE.5070006@ramsay1.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: GIT Mailing-list <git@vger.kernel.org>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Sun Oct 06 22:49:25 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VSvGX-0006hh-1U
	for gcvg-git-2@plane.gmane.org; Sun, 06 Oct 2013 22:49:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754286Ab3JFUtU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 6 Oct 2013 16:49:20 -0400
Received: from mdfmta010.mxout.tbr.inty.net ([91.221.168.51]:37883 "EHLO
	smtp.demon.co.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752380Ab3JFUtU (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 6 Oct 2013 16:49:20 -0400
Received: from mdfmta010.tbr.inty.net (unknown [127.0.0.1])
	by mdfmta010.tbr.inty.net (Postfix) with ESMTP id 77F586FBBC3;
	Sun,  6 Oct 2013 21:49:19 +0100 (BST)
Received: from mdfmta010.tbr.inty.net (unknown [127.0.0.1])
	by mdfmta010.tbr.inty.net (Postfix) with ESMTP id 4D83E6FBB78;
	Sun,  6 Oct 2013 21:49:19 +0100 (BST)
Received: from [192.168.254.7] (unknown [80.176.147.220])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mdfmta010.tbr.inty.net (Postfix) with ESMTP;
	Sun,  6 Oct 2013 21:49:19 +0100 (BST)
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:24.0) Gecko/20100101 Thunderbird/24.0
X-MDF-HostID: 3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/235746>


Sparse issues an "Using plain integer as NULL pointer" warning
against a call to update_ref_lock() which passes '0' to the
'int *type_p' parameter. In order to suppress the warning, we
simply change the argument to 'NULL'.

Signed-off-by: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
---
 refs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/refs.c b/refs.c
index ad5d66c..3710748 100644
--- a/refs.c
+++ b/refs.c
@@ -3235,7 +3235,7 @@ int update_ref(const char *action, const char *refname,
 	       int flags, enum action_on_err onerr)
 {
 	struct ref_lock *lock;
-	lock = update_ref_lock(refname, oldval, flags, 0, onerr);
+	lock = update_ref_lock(refname, oldval, flags, NULL, onerr);
 	if (!lock)
 		return 1;
 	return update_ref_write(action, refname, sha1, lock, onerr);
-- 
1.8.4
