From: Robin Rosenberg <robin.rosenberg@dewire.com>
Subject: [EGIT PATCH 3/3] Log decoration problems more silently
Date: Fri, 11 Jul 2008 00:41:08 +0200
Message-ID: <1215729668-26865-4-git-send-email-robin.rosenberg@dewire.com>
References: <1215729668-26865-1-git-send-email-robin.rosenberg@dewire.com>
 <1215729668-26865-2-git-send-email-robin.rosenberg@dewire.com>
 <1215729668-26865-3-git-send-email-robin.rosenberg@dewire.com>
Cc: git@vger.kernel.org, Marek Zawirski <marek.zawirski@gmail.com>,
	Robin Rosenberg <robin.rosenberg@dewire.com>
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Fri Jul 11 00:48:06 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KH4va-0004Lo-HF
	for gcvg-git-2@gmane.org; Fri, 11 Jul 2008 00:47:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755156AbYGJWq0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 10 Jul 2008 18:46:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754031AbYGJWqZ
	(ORCPT <rfc822;git-outgoing>); Thu, 10 Jul 2008 18:46:25 -0400
Received: from [83.140.172.130] ([83.140.172.130]:13180 "EHLO dewire.com"
	rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org with ESMTP
	id S1754297AbYGJWqQ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 Jul 2008 18:46:16 -0400
Received: from localhost (localhost [127.0.0.1])
	by dewire.com (Postfix) with ESMTP id 5B4F4802C0D;
	Fri, 11 Jul 2008 00:46:15 +0200 (CEST)
X-Virus-Scanned: by amavisd-new at dewire.com
Received: from dewire.com ([127.0.0.1])
	by localhost (torino.dewire.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 8L4zBNhE0IAn; Fri, 11 Jul 2008 00:46:14 +0200 (CEST)
Received: from localhost.localdomain (unknown [10.9.0.3])
	by dewire.com (Postfix) with ESMTP id 34405827593;
	Fri, 11 Jul 2008 00:46:14 +0200 (CEST)
X-Mailer: git-send-email 1.5.6.2.220.g44701
In-Reply-To: <1215729668-26865-3-git-send-email-robin.rosenberg@dewire.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/88045>

Seems our logging caused too much alerts in the UI.

Signed-off-by: Robin Rosenberg <robin.rosenberg@dewire.com>
---
 .../internal/decorators/GitResourceDecorator.java  |    4 +++-
 1 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/decorators/GitResourceDecorator.java b/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/decorators/GitResourceDecorator.java
index 8d4a7c7..6d2f88e 100644
--- a/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/decorators/GitResourceDecorator.java
+++ b/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/decorators/GitResourceDecorator.java
@@ -146,7 +146,9 @@ public class GitResourceDecorator extends LabelProvider implements
 				}
 				return Status.OK_STATUS;
 			} catch (Exception e) {
-				return new Status(IStatus.ERROR, Activator.getPluginId(), "Failed to trigger resource decoration", e);
+				// We must be silent here or the UI will panic with lots of error messages
+				Activator.logError("Failed to trigger resource re-decoration", e);
+				return Status.OK_STATUS;
 			}
 		}
 
-- 
1.5.6.2.220.g44701
