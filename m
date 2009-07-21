From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [JGIT PATCH 03/12] Add setLong to Config
Date: Tue, 21 Jul 2009 13:19:21 -0700
Message-ID: <1248207570-13880-4-git-send-email-spearce@spearce.org>
References: <1248207570-13880-1-git-send-email-spearce@spearce.org>
 <1248207570-13880-2-git-send-email-spearce@spearce.org>
 <1248207570-13880-3-git-send-email-spearce@spearce.org>
Cc: git@vger.kernel.org
To: Robin Rosenberg <robin.rosenberg@dewire.com>
X-From: git-owner@vger.kernel.org Tue Jul 21 22:21:19 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MTLpu-0001jT-J0
	for gcvg-git-2@gmane.org; Tue, 21 Jul 2009 22:21:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756140AbZGUUTi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 21 Jul 2009 16:19:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756133AbZGUUTg
	(ORCPT <rfc822;git-outgoing>); Tue, 21 Jul 2009 16:19:36 -0400
Received: from george.spearce.org ([209.20.77.23]:59245 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756101AbZGUUTc (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 Jul 2009 16:19:32 -0400
Received: by george.spearce.org (Postfix, from userid 1000)
	id 0AA6438239; Tue, 21 Jul 2009 20:19:33 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.2.4 (2008-01-01) on george.spearce.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.3 required=4.0 tests=ALL_TRUSTED,AWL,BAYES_00,
	SUBJECT_FUZZY_TION autolearn=no version=3.2.4
Received: from localhost.localdomain (localhost [127.0.0.1])
	by george.spearce.org (Postfix) with ESMTP id ECEE4381FF;
	Tue, 21 Jul 2009 20:19:31 +0000 (UTC)
X-Mailer: git-send-email 1.6.4.rc1.186.g60aa0c
In-Reply-To: <1248207570-13880-3-git-send-email-spearce@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/123695>

We already support getLong(), but didn't support setting one.  The
setInt() method can be trivially expressed in terms of setLong().

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
 .../src/org/spearce/jgit/lib/Config.java           |   23 ++++++++++++++++++++
 1 files changed, 23 insertions(+), 0 deletions(-)

diff --git a/org.spearce.jgit/src/org/spearce/jgit/lib/Config.java b/org.spearce.jgit/src/org/spearce/jgit/lib/Config.java
index a31796c..6fbdab9 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/lib/Config.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/lib/Config.java
@@ -449,6 +449,29 @@ private Object getRawEntry(final String section, final String subsection,
 	 */
 	public void setInt(final String section, final String subsection,
 			final String name, final int value) {
+		setLong(section, subsection, name, value);
+	}
+
+	/**
+	 * Add or modify a configuration value. The parameters will result in a
+	 * configuration entry like this.
+	 *
+	 * <pre>
+	 * [section &quot;subsection&quot;]
+	 *         name = value
+	 * </pre>
+	 *
+	 * @param section
+	 *            section name, e.g "branch"
+	 * @param subsection
+	 *            optional subsection value, e.g. a branch name
+	 * @param name
+	 *            parameter name, e.g. "filemode"
+	 * @param value
+	 *            parameter value
+	 */
+	public void setLong(final String section, final String subsection,
+			final String name, final long value) {
 		final String s;
 
 		if ((value % (1024 * 1024 * 1024)) == 0)
-- 
1.6.4.rc1.186.g60aa0c
