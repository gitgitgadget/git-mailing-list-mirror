From: Robin Rosenberg <robin.rosenberg@dewire.com>
Subject: [EGIT PATCH 02/10] Rename the objectsUrl in the nested HttpObjectDB to
Date: Mon, 16 Mar 2009 21:14:35 +0100
Message-ID: <1237234483-3405-3-git-send-email-robin.rosenberg@dewire.com>
References: <1237234483-3405-1-git-send-email-robin.rosenberg@dewire.com>
 <1237234483-3405-2-git-send-email-robin.rosenberg@dewire.com>
Cc: git@vger.kernel.org, Robin Rosenberg <robin.rosenberg@dewire.com>
To: spearce@sparce.org
X-From: git-owner@vger.kernel.org Mon Mar 16 21:16:28 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LjJEU-0007a9-At
	for gcvg-git-2@gmane.org; Mon, 16 Mar 2009 21:16:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757784AbZCPUOw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 Mar 2009 16:14:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754429AbZCPUOv
	(ORCPT <rfc822;git-outgoing>); Mon, 16 Mar 2009 16:14:51 -0400
Received: from mail.dewire.com ([83.140.172.130]:5249 "EHLO dewire.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752014AbZCPUOs (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Mar 2009 16:14:48 -0400
Received: from localhost (localhost [127.0.0.1])
	by dewire.com (Postfix) with ESMTP id 3BD03138AD62;
	Mon, 16 Mar 2009 21:14:46 +0100 (CET)
X-Virus-Scanned: by amavisd-new at dewire.com
Received: from dewire.com ([127.0.0.1])
	by localhost (torino.dewire.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id vtj1kJ7ZHnHV; Mon, 16 Mar 2009 21:14:45 +0100 (CET)
Received: from localhost.localdomain (unknown [10.9.0.2])
	by dewire.com (Postfix) with ESMTP id B177C138AD58;
	Mon, 16 Mar 2009 21:14:44 +0100 (CET)
X-Mailer: git-send-email 1.6.1.285.g35d8b
In-Reply-To: <1237234483-3405-2-git-send-email-robin.rosenberg@dewire.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/113365>

It is used for looking at alternate objects, so name it such
---
 .../org/spearce/jgit/transport/TransportHttp.java  |   14 +++++++-------
 1 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/org.spearce.jgit/src/org/spearce/jgit/transport/TransportHttp.java b/org.spearce.jgit/src/org/spearce/jgit/transport/TransportHttp.java
index fe4a437..38d26b3 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/transport/TransportHttp.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/transport/TransportHttp.java
@@ -112,15 +112,15 @@ public void close() {
 	}
 
 	class HttpObjectDB extends WalkRemoteObjectDatabase {
-		private final URL objectsUrl;
+		private final URL alternateObjectsUrl;
 
 		HttpObjectDB(final URL b) {
-			objectsUrl = b;
+			alternateObjectsUrl = b;
 		}
 
 		@Override
 		URIish getURI() {
-			return new URIish(objectsUrl);
+			return new URIish(alternateObjectsUrl);
 		}
 
 		@Override
@@ -143,7 +143,7 @@ URIish getURI() {
 		@Override
 		WalkRemoteObjectDatabase openAlternate(final String location)
 				throws IOException {
-			return new HttpObjectDB(new URL(objectsUrl, location));
+			return new HttpObjectDB(new URL(alternateObjectsUrl, location));
 		}
 
 		@Override
@@ -171,7 +171,7 @@ WalkRemoteObjectDatabase openAlternate(final String location)
 
 		@Override
 		FileStream open(final String path) throws IOException {
-			final URL base = objectsUrl;
+			final URL base = alternateObjectsUrl;
 			final URL u = new URL(base, path);
 			final Proxy proxy = HttpSupport.proxyFor(proxySelector, u);
 			final HttpURLConnection c;
@@ -201,10 +201,10 @@ FileStream open(final String path) throws IOException {
 				}
 			} catch (IOException err) {
 				try {
-					throw new TransportException(new URL(objectsUrl, INFO_REFS)
+					throw new TransportException(new URL(alternateObjectsUrl, INFO_REFS)
 							+ ": cannot read available refs", err);
 				} catch (MalformedURLException mue) {
-					throw new TransportException(objectsUrl + INFO_REFS
+					throw new TransportException(alternateObjectsUrl + INFO_REFS
 							+ ": cannot read available refs", err);
 				}
 			}
-- 
1.6.1.285.g35d8b
