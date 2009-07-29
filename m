From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [JGIT PATCH 2/5] Allow RemoteConfig.getAllRemoteConfigs on any Config object
Date: Wed, 29 Jul 2009 08:50:24 -0700
Message-ID: <1248882627-7285-3-git-send-email-spearce@spearce.org>
References: <1248882627-7285-1-git-send-email-spearce@spearce.org>
 <1248882627-7285-2-git-send-email-spearce@spearce.org>
Cc: git@vger.kernel.org
To: Robin Rosenberg <robin.rosenberg@dewire.com>
X-From: git-owner@vger.kernel.org Wed Jul 29 17:51:05 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MWBQm-0000Sa-NT
	for gcvg-git-2@gmane.org; Wed, 29 Jul 2009 17:51:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755047AbZG2Pub (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 29 Jul 2009 11:50:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754630AbZG2Pub
	(ORCPT <rfc822;git-outgoing>); Wed, 29 Jul 2009 11:50:31 -0400
Received: from george.spearce.org ([209.20.77.23]:45985 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753352AbZG2Pua (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 Jul 2009 11:50:30 -0400
Received: by george.spearce.org (Postfix, from userid 1000)
	id 02C7938222; Wed, 29 Jul 2009 15:50:30 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.2.4 (2008-01-01) on george.spearce.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.4 required=4.0 tests=ALL_TRUSTED,BAYES_00
	autolearn=ham version=3.2.4
Received: from localhost.localdomain (localhost [127.0.0.1])
	by george.spearce.org (Postfix) with ESMTP id 0DA5B381FF;
	Wed, 29 Jul 2009 15:50:29 +0000 (UTC)
X-Mailer: git-send-email 1.6.4.rc3.201.gd9d59
In-Reply-To: <1248882627-7285-2-git-send-email-spearce@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/124358>

Back in 07c8dc6e94729ff4104f0a1c815dd81f3e71c562 I changed the
RemoteConfig class to accept any Config object, but its static
getAllRemoteConfigs() utility method was missed and still used
a RepositoryConfig.  It should take any Config.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
 .../org/spearce/jgit/transport/RemoteConfig.java   |    5 ++---
 1 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/org.spearce.jgit/src/org/spearce/jgit/transport/RemoteConfig.java b/org.spearce.jgit/src/org/spearce/jgit/transport/RemoteConfig.java
index ca84acf..dd7a50c 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/transport/RemoteConfig.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/transport/RemoteConfig.java
@@ -44,7 +44,6 @@
 import java.util.List;
 
 import org.spearce.jgit.lib.Config;
-import org.spearce.jgit.lib.RepositoryConfig;
 
 /**
  * A remembered remote repository, including URLs and RefSpecs.
@@ -96,8 +95,8 @@
 	 * @throws URISyntaxException
 	 *             one of the URIs within the remote's configuration is invalid.
 	 */
-	public static List<RemoteConfig> getAllRemoteConfigs(
-			final RepositoryConfig rc) throws URISyntaxException {
+	public static List<RemoteConfig> getAllRemoteConfigs(final Config rc)
+			throws URISyntaxException {
 		final List<String> names = new ArrayList<String>(rc
 				.getSubsections(SECTION));
 		Collections.sort(names);
-- 
1.6.4.rc3.201.gd9d59
