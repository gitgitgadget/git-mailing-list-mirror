From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [JGIT PATCH 0/7] Misc. RevWalk, bundle transport improvements
Date: Thu,  4 Sep 2008 16:42:12 -0700
Message-ID: <1220571739-4219-1-git-send-email-spearce@spearce.org>
Cc: git@vger.kernel.org
To: Robin Rosenberg <robin.rosenberg@dewire.com>
X-From: git-owner@vger.kernel.org Fri Sep 05 01:43:32 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KbOU8-0000iN-2I
	for gcvg-git-2@gmane.org; Fri, 05 Sep 2008 01:43:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751784AbYIDXmW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Sep 2008 19:42:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751607AbYIDXmV
	(ORCPT <rfc822;git-outgoing>); Thu, 4 Sep 2008 19:42:21 -0400
Received: from george.spearce.org ([209.20.77.23]:33760 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751388AbYIDXmV (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Sep 2008 19:42:21 -0400
Received: by george.spearce.org (Postfix, from userid 1000)
	id 9809D38269; Thu,  4 Sep 2008 23:42:20 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.2.4 (2008-01-01) on george.spearce.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.4 required=4.0 tests=ALL_TRUSTED,BAYES_00
	autolearn=ham version=3.2.4
Received: from localhost.localdomain (localhost [127.0.0.1])
	by george.spearce.org (Postfix) with ESMTP id 3558E38269;
	Thu,  4 Sep 2008 23:42:20 +0000 (UTC)
X-Mailer: git-send-email 1.6.0.1.319.g9f32b
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/94973>

The bundle transport improvements are needed for another open source
project I'm starting to find myself working on.  Details to be made
available at a later date, but its possibly something quite cool for
the Git community in general.

Anyway...

Shawn O. Pearce (7):
  Cleanup RevWalk.parseCommit, parseTree to not throw
    ClassCastException
  Cleanup RevWalk.parseTree semantics
  Fix potential NullPointerException in RevWalk.parseTree
  Add prerequisite verification to the bundle transport
  Include URIish in bundle transport within any TransportExceptions
  Refactor TransportBundle to not be dependent on FileInputStream
  Refactor bundle transport to permit streaming from application

 .../jgit/pgm/opt/AbstractTreeIteratorHandler.java  |    2 -
 .../org/spearce/jgit/pgm/opt/RevCommitHandler.java |    2 -
 .../org/spearce/jgit/pgm/opt/RevTreeHandler.java   |    2 -
 .../errors/MissingBundlePrerequisiteException.java |   73 ++++++++++
 .../src/org/spearce/jgit/revwalk/RevWalk.java      |   28 +++-
 .../spearce/jgit/transport/BasePackConnection.java |    2 +-
 .../jgit/transport/BasePackFetchConnection.java    |    2 -
 .../src/org/spearce/jgit/transport/IndexPack.java  |   20 ++-
 .../src/org/spearce/jgit/transport/Transport.java  |    4 +-
 .../spearce/jgit/transport/TransportBundle.java    |  150 +++++++++++---------
 .../jgit/transport/TransportBundleFile.java        |   82 +++++++++++
 .../jgit/transport/TransportBundleStream.java      |  105 ++++++++++++++
 12 files changed, 384 insertions(+), 88 deletions(-)
 create mode 100644 org.spearce.jgit/src/org/spearce/jgit/errors/MissingBundlePrerequisiteException.java
 create mode 100644 org.spearce.jgit/src/org/spearce/jgit/transport/TransportBundleFile.java
 create mode 100644 org.spearce.jgit/src/org/spearce/jgit/transport/TransportBundleStream.java
