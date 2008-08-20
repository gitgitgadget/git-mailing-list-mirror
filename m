From: Marek Zawirski <marek.zawirski@gmail.com>
Subject: [EGIT PATCH 1/6] Remove DEFAULT_DRY_RUN constant from Transport
Date: Wed, 20 Aug 2008 04:57:35 +0200
Message-ID: <1219201060-4307-1-git-send-email-marek.zawirski@gmail.com>
References: <48AB84A2.7010905@gmail.com>
Cc: git@vger.kernel.org, Marek Zawirski <marek.zawirski@gmail.com>
To: robin.rosenberg@dewire.com, spearce@spearce.org
X-From: git-owner@vger.kernel.org Wed Aug 20 04:58:52 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KVduN-0001kV-9T
	for gcvg-git-2@gmane.org; Wed, 20 Aug 2008 04:58:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752534AbYHTC5s (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Aug 2008 22:57:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752382AbYHTC5s
	(ORCPT <rfc822;git-outgoing>); Tue, 19 Aug 2008 22:57:48 -0400
Received: from mu-out-0910.google.com ([209.85.134.187]:32303 "EHLO
	mu-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752233AbYHTC5r (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Aug 2008 22:57:47 -0400
Received: by mu-out-0910.google.com with SMTP id w8so321027mue.1
        for <git@vger.kernel.org>; Tue, 19 Aug 2008 19:57:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=7axrFrUaByDyl21hhKkXMTyvSfRy+aw6BhvdYBOg+z4=;
        b=D1+Ocm/H50M6XewH/7iysxSRsmxA8itgX/E/I6pRzhcwFOrohMgVSUI1k0fhpkj5Tt
         rF0zsmtdhv1mJcdH5r1sm7UtkgHvNBg4INz+5R/YfS5roNClNlLWKZzQ9llc4YkLwh55
         le/xMGTr3hdVl+kdxDwwj5EsYp8+8UBJ/KrRk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=hfngsU/OPVqcupPnXaLMxi6QMw3Gkp+NqlcUE+VBxXZxiEM0ZebUgMBn2v0BWHj/Wx
         /5cJV51015vqkZN92BHqi6iVsPMSTmcxIBn41gVVNJMsLSDs6qzqXmU9mpO++gtIkQJp
         l6+/WVchZoArm5+KJfs0a1GDbZNMXL+5mWozM=
Received: by 10.103.233.4 with SMTP id k4mr5334904mur.48.1219201065272;
        Tue, 19 Aug 2008 19:57:45 -0700 (PDT)
Received: from localhost ( [62.21.19.93])
        by mx.google.com with ESMTPS id j9sm4795456mue.3.2008.08.19.19.57.43
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 19 Aug 2008 19:57:44 -0700 (PDT)
X-Mailer: git-send-email 1.5.6.3
In-Reply-To: <48AB84A2.7010905@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/92954>

This constant was pointless as changing it would brake code in the same
way as changing hardcoded value instead.

Signed-off-by: Marek Zawirski <marek.zawirski@gmail.com>
---
 .../src/org/spearce/jgit/pgm/Push.java             |    2 +-
 .../src/org/spearce/jgit/transport/Transport.java  |    7 +------
 2 files changed, 2 insertions(+), 7 deletions(-)

diff --git a/org.spearce.jgit.pgm/src/org/spearce/jgit/pgm/Push.java b/org.spearce.jgit.pgm/src/org/spearce/jgit/pgm/Push.java
index b61071c..d36bf4f 100644
--- a/org.spearce.jgit.pgm/src/org/spearce/jgit/pgm/Push.java
+++ b/org.spearce.jgit.pgm/src/org/spearce/jgit/pgm/Push.java
@@ -87,7 +87,7 @@ void nothin(final boolean ignored) {
 	private String receivePack;
 	
 	@Option(name = "--dry-run")
-	private boolean dryRun = Transport.DEFAULT_DRY_RUN;
+	private boolean dryRun;
 
 	private boolean shownURI;
 
diff --git a/org.spearce.jgit/src/org/spearce/jgit/transport/Transport.java b/org.spearce.jgit/src/org/spearce/jgit/transport/Transport.java
index 939347e..ca68ca6 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/transport/Transport.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/transport/Transport.java
@@ -313,11 +313,6 @@ private static String findTrackingRefName(final String remoteName,
 	public static final RefSpec REFSPEC_PUSH_ALL = new RefSpec(
 			"refs/heads/*:refs/heads/*");
 
-	/**
-	 * Default setting for {@link #dryRun} option.
-	 */
-	public static final boolean DEFAULT_DRY_RUN = false;
-
 	/** The repository this transport fetches into, or pushes out of. */
 	protected final Repository local;
 
@@ -354,7 +349,7 @@ private static String findTrackingRefName(final String remoteName,
 	private boolean pushThin = DEFAULT_PUSH_THIN;
 
 	/** Should push just check for operation result, not really push. */
-	private boolean dryRun = DEFAULT_DRY_RUN;
+	private boolean dryRun;
 
 	/**
 	 * Create a new transport instance.
-- 
1.5.6.3
