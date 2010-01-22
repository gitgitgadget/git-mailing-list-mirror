From: Pal-Kristian Engstad <pal_engstad@naughtydog.com>
Subject: [PATCH] git-p4: Fix sync errors due to new server version
Date: Thu, 21 Jan 2010 18:33:00 -0800
Message-ID: <4B590E5C.9@naughtydog.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Simon Hausmann <simon@lst.de>
X-From: git-owner@vger.kernel.org Fri Jan 22 03:32:37 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NY9K8-0004qD-SP
	for gcvg-git-2@lo.gmane.org; Fri, 22 Jan 2010 03:32:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755770Ab0AVCcd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 21 Jan 2010 21:32:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755720Ab0AVCcd
	(ORCPT <rfc822;git-outgoing>); Thu, 21 Jan 2010 21:32:33 -0500
Received: from ironport01a.scea.com ([160.33.44.41]:20098 "EHLO
	ironport01a.scea.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752640Ab0AVCcc (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Jan 2010 21:32:32 -0500
X-IronPort-AV: E=Sophos;i="4.49,322,1262592000"; 
   d="scan'208";a="10635612"
Received: from inbetweener01.scea.com ([160.33.45.195])
  by ironport01a.scea.com with ESMTP; 21 Jan 2010 18:32:32 -0800
Received: from postal1-dog.naughtydog.com (intmail.naughtydog.com [10.15.0.14])
	by inbetweener01.scea.com (Postfix) with ESMTP id 782D9F017A;
	Thu, 21 Jan 2010 18:32:32 -0800 (PST)
Received: from [127.0.0.1] ([150.0.6.116]) by postal1-dog.naughtydog.com with Microsoft SMTPSVC(6.0.3790.3959);
	 Thu, 21 Jan 2010 18:33:00 -0800
User-Agent: Thunderbird 2.0.0.23 (Windows/20090812)
X-OriginalArrivalTime: 22 Jan 2010 02:33:00.0972 (UTC) FILETIME=[3763E6C0:01CA9B0B]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/137723>

Fix sync errors due to new Perforce servers.

The P4D/NTX64/2009.2/228098 (2009/12/16) server reports
'move/delete' instead of 'delete'. This causes the Perforce
depot and the git repo to get out of sync. Fixed by adding
the new status string.

Signed-off-by: Pal-Kristian Engstad <pal_engstad@naughtydog.com>
---
 contrib/fast-import/git-p4 |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/contrib/fast-import/git-p4 b/contrib/fast-import/git-p4
index 48059d0..1c73e5f 100755
--- a/contrib/fast-import/git-p4
+++ b/contrib/fast-import/git-p4
@@ -1037,7 +1037,7 @@ class P4Sync(Command):
 
             if includeFile:
                 filesForCommit.append(f)
-                if f['action'] not in ('delete', 'purge'):
+                if f['action'] not in ('delete', 'move/delete', 'purge'):
                     filesToRead.append(f)
                 else:
                     filesToDelete.append(f)
-- 
1.6.5.2.6.gc3c1e.dirty
