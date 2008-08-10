From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [EGIT PATCH 00/11] Misc. cleanups and improvements
Date: Sun, 10 Aug 2008 01:46:15 -0700
Message-ID: <1218357986-19671-1-git-send-email-spearce@spearce.org>
Cc: git@vger.kernel.org
To: Robin Rosenberg <robin.rosenberg@dewire.com>,
	Marek Zawirski <marek.zawirski@gmail.com>
X-From: git-owner@vger.kernel.org Sun Aug 10 10:47:48 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KS6aS-0001pt-7M
	for gcvg-git-2@gmane.org; Sun, 10 Aug 2008 10:47:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752172AbYHJIqa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 10 Aug 2008 04:46:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752074AbYHJIq3
	(ORCPT <rfc822;git-outgoing>); Sun, 10 Aug 2008 04:46:29 -0400
Received: from george.spearce.org ([209.20.77.23]:51256 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751977AbYHJIq2 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 Aug 2008 04:46:28 -0400
Received: by george.spearce.org (Postfix, from userid 1000)
	id 193A938378; Sun, 10 Aug 2008 08:46:28 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.2.4 (2008-01-01) on george.spearce.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.4 required=4.0 tests=ALL_TRUSTED,BAYES_00
	autolearn=ham version=3.2.4
Received: from localhost.localdomain (localhost [127.0.0.1])
	by george.spearce.org (Postfix) with ESMTP id 66B58381FD;
	Sun, 10 Aug 2008 08:46:27 +0000 (UTC)
X-Mailer: git-send-email 1.6.0.rc2.219.g1250ab
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/91817>

This really is two parts; the first fixes a couple of bugs and
the latter section expands our treewalk API to handle the Eclipse
workbench natively as well as expose APIs needed to integrate the
DIRC format (.git/index) into the treewalk structure.

Shawn O. Pearce (11):
  Fix RawParseUtils.endOfParagraph to work on all corner cases
  Add test case for the RevCommit parsing code
  Notify AbstractTreeIterator implementations of skipped tree entries
  Allow AbstractTreeIterator subclasses to supply their own path array
  Allow WorkingTreeIterators to define their prefix path when created
  Add getTree to TreeWalk for locating the current iterator instance
  Allow WorkingTreeIterator to track last modified time for entries
  Expose the current entry's length, last modified in
    WorkingTreeIterator
  Expose idBuffer,idOffset in AbstractTreeIterator to applications
  Add a TreeWalk iterator implementation for IContainer
  Teach NB how to encode/decode an unsigned 16 bit integer

 .../spearce/egit/core/ContainerTreeIterator.java   |  181 +++++++++++++++++++
 .../spearce/jgit/revwalk/RevCommitParseTest.java   |  190 ++++++++++++++++++++
 .../jgit/treewalk/AbstractTreeIterator.java        |   79 ++++++++-
 .../spearce/jgit/treewalk/CanonicalTreeParser.java |    4 +-
 .../spearce/jgit/treewalk/EmptyTreeIterator.java   |    4 +-
 .../spearce/jgit/treewalk/FileTreeIterator.java    |    9 +
 .../src/org/spearce/jgit/treewalk/TreeWalk.java    |   36 ++++-
 .../spearce/jgit/treewalk/WorkingTreeIterator.java |   56 ++++++-
 org.spearce.jgit/src/org/spearce/jgit/util/NB.java |   35 ++++
 .../src/org/spearce/jgit/util/RawParseUtils.java   |   11 +-
 10 files changed, 591 insertions(+), 14 deletions(-)
 create mode 100644 org.spearce.egit.core/src/org/spearce/egit/core/ContainerTreeIterator.java
 create mode 100644 org.spearce.jgit.test/tst/org/spearce/jgit/revwalk/RevCommitParseTest.java
