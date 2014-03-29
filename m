From: Charles Bailey <cbailey32@bloomberg.net>
Subject: [PATCH 1/2] Remove inline from git_fnmatch in dir.c
Date: Sat, 29 Mar 2014 15:39:00 +0000
Message-ID: <1396107541-22974-2-git-send-email-cbailey32@bloomberg.net>
References: <1396107541-22974-1-git-send-email-cbailey32@bloomberg.net>
Cc: Charles Bailey <cbailey32@bloomberg.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Mar 29 16:39:28 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WTvLz-0001nO-JZ
	for gcvg-git-2@plane.gmane.org; Sat, 29 Mar 2014 16:39:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751902AbaC2PjP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 29 Mar 2014 11:39:15 -0400
Received: from avasout05.plus.net ([84.93.230.250]:54323 "EHLO
	avasout05.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751725AbaC2PjN (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 29 Mar 2014 11:39:13 -0400
Received: from hashpling.plus.com ([212.159.69.125])
	by avasout05 with smtp
	id jTfA1n0062iA9hg01TfBoq; Sat, 29 Mar 2014 15:39:12 +0000
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.1 cv=SYp5d5hu c=1 sm=1 tr=0
 a=wpJ/2au8Z6V/NgdivHIBow==:117 a=wpJ/2au8Z6V/NgdivHIBow==:17 a=EBOSESyhAAAA:8
 a=0Bzu9jTXAAAA:8 a=_ZDuRPUMkI0A:10 a=N2sEI2mohSIA:10 a=BHUvooL90DcA:10
 a=BNFp--SqAAAA:8 a=Ew9TdX-QAAAA:8 a=HZp20tkHsTonxGj_dlgA:9 a=92rhvNbd_XgA:10
Received: from charles by hashpling.plus.com with local (Exim 4.72)
	(envelope-from <charles@hashpling.org>)
	id 1WTvLi-00060M-NN; Sat, 29 Mar 2014 15:39:10 +0000
X-Mailer: git-send-email 1.8.5.1.2.ge5d1dab
In-Reply-To: <1396107541-22974-1-git-send-email-cbailey32@bloomberg.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/245434>

Now that it calls a static inline function, it cannot be an inline
definition with external linkage. Remove inline and make it an
external definition.

Signed-off-by: Charles Bailey <cbailey32@bloomberg.net>
---
 dir.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/dir.c b/dir.c
index 99f5303..eb6f581 100644
--- a/dir.c
+++ b/dir.c
@@ -54,9 +54,9 @@ int fnmatch_icase(const char *pattern, const char *string, int flags)
 			 NULL);
 }
 
-inline int git_fnmatch(const struct pathspec_item *item,
-		       const char *pattern, const char *string,
-		       int prefix)
+int git_fnmatch(const struct pathspec_item *item,
+		const char *pattern, const char *string,
+		int prefix)
 {
 	if (prefix > 0) {
 		if (ps_strncmp(item, pattern, string, prefix))
-- 
1.8.5.1.2.ge5d1dab
