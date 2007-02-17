From: Martin Waitz <tali@admingilde.org>
Subject: [PATCH] Support for large files on 32bit systems.
Date: Sat, 17 Feb 2007 10:13:10 +0100
Message-ID: <20070217091310.GD21842@admingilde.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Feb 17 10:13:17 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HILd6-0005wT-BN
	for gcvg-git@gmane.org; Sat, 17 Feb 2007 10:13:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965089AbXBQJNM (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 17 Feb 2007 04:13:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965090AbXBQJNM
	(ORCPT <rfc822;git-outgoing>); Sat, 17 Feb 2007 04:13:12 -0500
Received: from mail.admingilde.org ([213.95.32.147]:33044 "EHLO
	mail.admingilde.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965089AbXBQJNL (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 17 Feb 2007 04:13:11 -0500
Received: from martin by mail.admingilde.org with local  (Exim 4.50 #1)
	id 1HILd0-0006nn-TE
	for git@vger.kernel.org; Sat, 17 Feb 2007 10:13:10 +0100
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/39979>

Glibc uses the same size for int and off_t by default.
In order to support large pack sizes (>2GB) we force Glibc to a 64bit off_t.

Signed-off-by: Martin Waitz <tali@admingilde.org>
---
 git-compat-util.h |    5 +++++
 1 files changed, 5 insertions(+), 0 deletions(-)

diff --git a/git-compat-util.h b/git-compat-util.h
index bf3ceb8..38f9594 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -19,6 +19,11 @@
 #define _GNU_SOURCE 1
 #define _BSD_SOURCE 1
 
+/* support large files even on 32bit systems */
+#ifdef __GLIBC__
+#define _FILE_OFFSET_BITS=64
+#endif
+
 #include <unistd.h>
 #include <stdio.h>
 #include <sys/stat.h>
-- 
1.5.0.rc2.g08361-dirty

-- 
Martin Waitz
