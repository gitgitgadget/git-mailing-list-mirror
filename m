From: Johannes Sixt <j6t@kdbg.org>
Subject: [PATCH 02/16] test-lib: Work around missing sum on Windows
Date: Sat, 21 Mar 2009 22:26:25 +0100
Message-ID: <5397ea314f612eaaacfb13d978319afd2c724817.1237667830.git.j6t@kdbg.org>
References: <cover.1237667830.git.j6t@kdbg.org>
Cc: Johannes Sixt <j6t@kdbg.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Mar 21 22:28:50 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ll8kH-0003u8-Kg
	for gcvg-git-2@gmane.org; Sat, 21 Mar 2009 22:28:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751399AbZCUV1K (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 21 Mar 2009 17:27:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754435AbZCUV1D
	(ORCPT <rfc822;git-outgoing>); Sat, 21 Mar 2009 17:27:03 -0400
Received: from bsmtp.bon.at ([213.33.87.14]:27948 "EHLO bsmtp.bon.at"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752434AbZCUV07 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 21 Mar 2009 17:26:59 -0400
Received: from dx.sixt.local (unknown [93.83.142.38])
	by bsmtp.bon.at (Postfix) with ESMTP id D7FE02C4005;
	Sat, 21 Mar 2009 22:26:54 +0100 (CET)
Received: from localhost.localdomain (localhost [127.0.0.1])
	by dx.sixt.local (Postfix) with ESMTP id A6B8742689;
	Sat, 21 Mar 2009 22:26:54 +0100 (CET)
X-Mailer: git-send-email 1.6.2.1.224.g2225f
In-Reply-To: <cover.1237667830.git.j6t@kdbg.org>
In-Reply-To: <cover.1237667830.git.j6t@kdbg.org>
References: <cover.1237667830.git.j6t@kdbg.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/114060>

t1002-read-tree-m-u-2way.sh uses 'sum', but it does not rely on the exact
form of the sum, only that it is a hash digest. Therefore, we can sneak
in 'md5sum' under the name 'sum'.

Signed-off-by: Johannes Sixt <j6t@kdbg.org>
---
 t/test-lib.sh |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/t/test-lib.sh b/t/test-lib.sh
index 4eda5ab..4720b9a 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -646,5 +646,8 @@ case $(uname -s) in
 	find () {
 		/usr/bin/find "$@"
 	}
+	sum () {
+		md5sum "$@"
+	}
 	;;
 esac
-- 
1.6.2.1.224.g2225f
