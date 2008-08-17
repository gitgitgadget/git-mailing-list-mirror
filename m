From: Marek Zawirski <marek.zawirski@gmail.com>
Subject: [EGIT PATCH 13/31] Add getAllRemoteConfigs() to RemoteConfig
Date: Sun, 17 Aug 2008 22:43:54 +0200
Message-ID: <1219005852-21496-14-git-send-email-marek.zawirski@gmail.com>
References: <1219005852-21496-1-git-send-email-marek.zawirski@gmail.com>
 <1219005852-21496-2-git-send-email-marek.zawirski@gmail.com>
 <1219005852-21496-3-git-send-email-marek.zawirski@gmail.com>
 <1219005852-21496-4-git-send-email-marek.zawirski@gmail.com>
 <1219005852-21496-5-git-send-email-marek.zawirski@gmail.com>
 <1219005852-21496-6-git-send-email-marek.zawirski@gmail.com>
 <1219005852-21496-7-git-send-email-marek.zawirski@gmail.com>
 <1219005852-21496-8-git-send-email-marek.zawirski@gmail.com>
 <1219005852-21496-9-git-send-email-marek.zawirski@gmail.com>
 <1219005852-21496-10-git-send-email-marek.zawirski@gmail.com>
 <1219005852-21496-11-git-send-email-marek.zawirski@gmail.com>
 <1219005852-21496-12-git-send-email-marek.zawirski@gmail.com>
 <1219005852-21496-13-git-send-email-marek.zawirski@gmail.com>
Cc: git@vger.kernel.org, Marek Zawirski <marek.zawirski@gmail.com>
To: robin.rosenberg@dewire.com, spearce@spearce.org
X-From: git-owner@vger.kernel.org Sun Aug 17 22:46:50 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KUp97-00038o-Uh
	for gcvg-git-2@gmane.org; Sun, 17 Aug 2008 22:46:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752574AbYHQUpG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 17 Aug 2008 16:45:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752583AbYHQUpF
	(ORCPT <rfc822;git-outgoing>); Sun, 17 Aug 2008 16:45:05 -0400
Received: from fg-out-1718.google.com ([72.14.220.154]:31899 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752574AbYHQUpC (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 17 Aug 2008 16:45:02 -0400
Received: by fg-out-1718.google.com with SMTP id 19so1489141fgg.17
        for <git@vger.kernel.org>; Sun, 17 Aug 2008 13:45:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=ef9ZwbF/lz/WZ97M3KGmSkoyqbXZxEUA2GEbxXgJiCU=;
        b=HOBHsgurdDTJfaSKpIbG6e5fO2SZsD0VjUgZu2udDBCLQP2NR3JNor2S1PA9ySPn3h
         6oc7eVKDD4Baou943L3lbpNwVzuu4SgfsvidALSz8ZYlzIk9dOYICqdtCR1DF2KgrZMk
         wPSRDwgA6nqYpSzPpygnlCLP313KUZtJkCLf8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=kfrOMR5bQQtPkxKFuhNpJopbLltOW89ewpfVRYxBYH/qNnr4rxGN36YX9A4Lp3EbqP
         vRrMnZOXfEuR7YMbIvNpBdm5dKXDNNC0tF17U2ZmC0fgCA5pqbTbKILM2ImGNsoePwny
         Gpx8eD6GRcUUj+D6DfqMAZU9hp85Sx/M+v0nw=
Received: by 10.103.172.7 with SMTP id z7mr3463710muo.40.1219005901465;
        Sun, 17 Aug 2008 13:45:01 -0700 (PDT)
Received: from localhost ( [62.21.19.93])
        by mx.google.com with ESMTPS id j2sm8876178mue.4.2008.08.17.13.44.59
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 17 Aug 2008 13:45:00 -0700 (PDT)
X-Mailer: git-send-email 1.5.6.3
In-Reply-To: <1219005852-21496-13-git-send-email-marek.zawirski@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/92645>

Introduce the method allowing us to parse all configured remotes.

Signed-off-by: Marek Zawirski <marek.zawirski@gmail.com>
---
 .../src/org/spearce/jgit/lib/RepositoryConfig.java |   21 ++++++++++++++++
 .../org/spearce/jgit/transport/RemoteConfig.java   |   26 ++++++++++++++++++++
 2 files changed, 47 insertions(+), 0 deletions(-)

diff --git a/org.spearce.jgit/src/org/spearce/jgit/lib/RepositoryConfig.java b/org.spearce.jgit/src/org/spearce/jgit/lib/RepositoryConfig.java
index 048940d..397c294 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/lib/RepositoryConfig.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/lib/RepositoryConfig.java
@@ -53,9 +53,11 @@ import java.io.PrintWriter;
 import java.util.ArrayList;
 import java.util.Collections;
 import java.util.HashMap;
+import java.util.HashSet;
 import java.util.Iterator;
 import java.util.List;
 import java.util.Map;
+import java.util.Set;
 
 import org.spearce.jgit.util.FS;
 
@@ -277,6 +279,25 @@ public class RepositoryConfig {
 			return baseConfig.getStringList(section, subsection, name);
 		return new String[0];
 	}
+	
+	/**
+	 * @param section
+	 *            section to search for.
+	 * @return set of all subsections of specified section within this
+	 *         configuration and its base configuration; may be empty if no
+	 *         subsection exists.
+	 */
+	public Set<String> getSubsections(final String section) {
+		final Set<String> result = new HashSet<String>();
+
+		for (final Entry e : entries) {
+			if (section.equals(e.base) && e.extendedBase != null)
+				result.add(e.extendedBase);
+		}
+		if (baseConfig != null)
+			result.addAll(baseConfig.getSubsections(section));
+		return result;
+	}
 
 	private String getRawString(final String section, final String subsection,
 			final String name) {
diff --git a/org.spearce.jgit/src/org/spearce/jgit/transport/RemoteConfig.java b/org.spearce.jgit/src/org/spearce/jgit/transport/RemoteConfig.java
index bb21511..cde5d43 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/transport/RemoteConfig.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/transport/RemoteConfig.java
@@ -73,6 +73,32 @@ public class RemoteConfig {
 
 	/** Default value for {@link #getReceivePack()} if not specified. */
 	public static final String DEFAULT_RECEIVE_PACK = "git-receive-pack";
+	
+	/**
+	 * Parse all remote blocks in an existing configuration file, looking for
+	 * remotes configuration.
+	 * 
+	 * @param rc
+	 *            the existing configuration to get the remote settings from.
+	 *            The configuration must already be loaded into memory.
+	 * @return all remotes configurations existing in provided repository
+	 *         configuration. Returned configurations are ordered
+	 *         lexicographically by names.
+	 * @throws URISyntaxException
+	 *             one of the URIs within the remote's configuration is invalid.
+	 */
+	public static List<RemoteConfig> getAllRemoteConfigs(
+			final RepositoryConfig rc) throws URISyntaxException {
+		final List<String> names = new ArrayList<String>(rc
+				.getSubsections(SECTION));
+		Collections.sort(names);
+
+		final List<RemoteConfig> result = new ArrayList<RemoteConfig>(names
+				.size());
+		for (final String name : names)
+			result.add(new RemoteConfig(rc, name));
+		return result;
+	}
 
 	private String name;
 
-- 
1.5.6.3
