From: Pete Wyckoff <pw@padd.com>
Subject: [PATCH] stgit namelength is an integer
Date: Mon, 5 Jan 2009 14:03:54 -0500
Message-ID: <20090105190354.GA8295@osc.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jan 05 20:06:08 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LJulx-0003Vo-Ok
	for gcvg-git-2@gmane.org; Mon, 05 Jan 2009 20:05:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753039AbZAETD6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 5 Jan 2009 14:03:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752979AbZAETD5
	(ORCPT <rfc822;git-outgoing>); Mon, 5 Jan 2009 14:03:57 -0500
Received: from marge.padd.com ([99.188.165.110]:51436 "EHLO marge.padd.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752431AbZAETD4 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 Jan 2009 14:03:56 -0500
Received: from oink.padd.com (oink.padd.com [69.36.12.13])
	by marge.padd.com (Postfix) with ESMTPSA id 2309A10F8033
	for <git@vger.kernel.org>; Mon,  5 Jan 2009 11:00:32 -0800 (PST)
Received: by oink.padd.com (Postfix, from userid 7770)
	id 269BFFD4165; Mon,  5 Jan 2009 14:03:54 -0500 (EST)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/104592>

Interpret stgit namelength as an integer, else the use of
name_len will fail with

  File "/usr/lib/python2.5/site-packages/stgit/utils.py", line 206, in patch_name_from_msg
    return re.sub('[\W]+', '-', subject_line).strip('-')[:name_len]
TypeError: slice indices must be integers or None or have an __index__ method

Signed-off-by: Pete Wyckoff <pw@padd.com>
---
 stgit/utils.py |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/stgit/utils.py b/stgit/utils.py
index 81035a5..1fa96c2 100644
--- a/stgit/utils.py
+++ b/stgit/utils.py
@@ -215,7 +215,7 @@ def patch_name_from_msg(msg):
     if not msg:
         return None
 
-    name_len = config.get('stgit.namelength')
+    name_len = config.getint('stgit.namelength')
     if not name_len:
         name_len = 30
 
-- 
1.6.0.6
