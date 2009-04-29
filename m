From: "Sohn, Matthias" <matthias.sohn@sap.com>
Subject: [PATCH JGIT] Equals method should not assume anything about the type of its argument
Date: Wed, 29 Apr 2009 16:54:44 +0200
Message-ID: <366BBB1215D0AB4B8A153AF047A287800302A6F9@dewdfe18.wdf.sap.corp>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="Windows-1252"
Content-Transfer-Encoding: 8BIT
Cc: <git@vger.kernel.org>
To: "Shawn O. Pearce" <spearce@spearce.org>,
	"Robin Rosenberg" <robin.rosenberg@dewire.com>
X-From: git-owner@vger.kernel.org Wed Apr 29 16:55:19 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LzBBi-0007rj-98
	for gcvg-git-2@gmane.org; Wed, 29 Apr 2009 16:55:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752077AbZD2Oy5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 29 Apr 2009 10:54:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751682AbZD2Oy5
	(ORCPT <rfc822;git-outgoing>); Wed, 29 Apr 2009 10:54:57 -0400
Received: from smtpde03.sap-ag.de ([155.56.68.140]:56631 "EHLO
	smtpde03.sap-ag.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751631AbZD2Oy4 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 29 Apr 2009 10:54:56 -0400
Received: from mail.sap.corp
	by smtpde03.sap-ag.de (26) with ESMTP id n3TEsmea021028
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Wed, 29 Apr 2009 16:54:48 +0200 (MEST)
X-MimeOLE: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH JGIT] Equals method should not assume anything about the type of its argument
Thread-Index: AcnHjEysWP+qTjB1Tm2zGBLNNuNqlABTQvvQ
X-OriginalArrivalTime: 29 Apr 2009 14:54:46.0549 (UTC) FILETIME=[70130450:01C9C8DA]
X-Scanner: Virus Scanner virwal08
X-SAP: out
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/117893>

The equals(Object o) method shouldn't make any assumptions about the type of o. It should simply return false if o is not the same type as this.

Signed-off-by: Matthias Sohn <matthias.sohn@sap.com>
---
 .../src/org/spearce/jgit/lib/AnyObjectId.java      |    6 +++++-
 1 files changed, 5 insertions(+), 1 deletions(-)

diff --git a/org.spearce.jgit/src/org/spearce/jgit/lib/AnyObjectId.java b/org.spearce.jgit/src/org/spearce/jgit/lib/AnyObjectId.java
index 2e3a43e..0bd2288 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/lib/AnyObjectId.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/lib/AnyObjectId.java
@@ -253,7 +253,11 @@ public boolean equals(final AnyObjectId other) {
 	}
 
 	public boolean equals(final Object o) {
-		return equals((AnyObjectId) o);
+		if (o instanceof AnyObjectId) {
+			return equals((AnyObjectId) o);
+		} else {
+			return false;
+		}
 	}
 
 	/**
-- 
1.6.2.2.1669.g7eaf8
