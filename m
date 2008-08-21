From: Mike Ralphson <mike@abacus.co.uk>
Subject: [JGIT PATCH] Typo in implementation of pack protocol
Date: Thu, 21 Aug 2008 11:36:11 +0100
Message-ID: <1219314971-13445-1-git-send-email-mike@abacus.co.uk>
Cc: git@vger.kernel.org, Mike Ralphson <mike.ralphson@gmail.com>,
	Marek Zawirski <marek.zawirski@gmail.com>
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Thu Aug 21 12:30:07 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KW7Qc-00040m-Fn
	for gcvg-git-2@gmane.org; Thu, 21 Aug 2008 12:30:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758464AbYHUK2l (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 21 Aug 2008 06:28:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756259AbYHUK2k
	(ORCPT <rfc822;git-outgoing>); Thu, 21 Aug 2008 06:28:40 -0400
Received: from [82.109.193.99] ([82.109.193.99]:7822 "EHLO orson.abacus.co.uk"
	rhost-flags-FAIL-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1755610AbYHUK2j (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Aug 2008 06:28:39 -0400
Received: by orson.abacus.co.uk (Postfix, from userid 1006)
	id B340C1BD612; Thu, 21 Aug 2008 11:36:11 +0100 (BST)
X-Mailer: git-send-email 1.5.5.1.1.g75d5.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/93133>

cgit's receive-pack.c has never had the corresponding typo.
Fix up method and member names to match.

Signed-off-by: Mike Ralphson <mike@abacus.co.uk>
---
 .../spearce/jgit/transport/BasePackConnection.java |    2 +-
 .../jgit/transport/BasePackPushConnection.java     |    6 +++---
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/org.spearce.jgit/src/org/spearce/jgit/transport/BasePackConnection.java b/org.spearce.jgit/src/org/spearce/jgit/transport/BasePackConnection.java
index 52f3f48..14fffc3 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/transport/BasePackConnection.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/transport/BasePackConnection.java
@@ -144,7 +144,7 @@ for (String c : line.substring(nul + 1).split(" "))
 					line = line.substring(0, nul);
 				}
 
-				if (line.equals("capabilties^{}")) {
+				if (line.equals("capabilities^{}")) {
 					// special line from git-receive-pack to show
 					// capabilities when there are no refs to advertise
 					continue;
diff --git a/org.spearce.jgit/src/org/spearce/jgit/transport/BasePackPushConnection.java b/org.spearce.jgit/src/org/spearce/jgit/transport/BasePackPushConnection.java
index 6d95eaf..a2d5b6f 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/transport/BasePackPushConnection.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/transport/BasePackPushConnection.java
@@ -118,7 +118,7 @@ if (sentCommand && capableReport)
 
 	private void writeCommands(final Collection<RemoteRefUpdate> refUpdates,
 			final ProgressMonitor monitor) throws IOException {
-		final String capabilties = enableCapabilties();
+		final String capabilities = enableCapabilities();
 		for (final RemoteRefUpdate rru : refUpdates) {
 			if (!capableDeleteRefs && rru.isDelete()) {
 				rru.setStatus(Status.REJECTED_NODELETE);
@@ -136,7 +136,7 @@ if (!capableDeleteRefs && rru.isDelete()) {
 			sb.append(rru.getRemoteName());
 			if (!sentCommand) {
 				sentCommand = true;
-				sb.append(capabilties);
+				sb.append(capabilities);
 			}
 
 			pckOut.writeString(sb.toString());
@@ -151,7 +151,7 @@ if (monitor.isCancelled())
 		outNeedsEnd = false;
 	}
 
-	private String enableCapabilties() {
+	private String enableCapabilities() {
 		final StringBuilder line = new StringBuilder();
 		capableReport = wantCapability(line, CAPABILITY_REPORT_STATUS);
 		capableDeleteRefs = wantCapability(line, CAPABILITY_DELETE_REFS);
-- 
1.5.6.4
