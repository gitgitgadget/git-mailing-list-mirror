From: Robin Rosenberg <robin.rosenberg@dewire.com>
Subject: [EGIT PATCH v5 0/7] Ref rename support again
Date: Wed, 10 Jun 2009 23:22:18 +0200
Message-ID: <1244668945-12622-1-git-send-email-robin.rosenberg@dewire.com>
References: <1241652781-16873-1-git-send-email-robin.rosenberg@dewire.com>
Cc: git@vger.kernel.org, Robin Rosenberg <robin.rosenberg@dewire.com>
To: spearce@spearce.org
X-From: git-owner@vger.kernel.org Wed Jun 10 23:22:48 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MEVFw-0007hX-AA
	for gcvg-git-2@gmane.org; Wed, 10 Jun 2009 23:22:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756909AbZFJVWn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Jun 2009 17:22:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756787AbZFJVWk
	(ORCPT <rfc822;git-outgoing>); Wed, 10 Jun 2009 17:22:40 -0400
Received: from mail.dewire.com ([83.140.172.130]:3883 "EHLO dewire.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754783AbZFJVWc (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Jun 2009 17:22:32 -0400
Received: from localhost (localhost [127.0.0.1])
	by dewire.com (Postfix) with ESMTP id 3BF78147D5B4;
	Wed, 10 Jun 2009 23:22:34 +0200 (CEST)
X-Virus-Scanned: by amavisd-new at dewire.com
Received: from dewire.com ([127.0.0.1])
	by localhost (torino.dewire.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id DvAJPDU7EZR8; Wed, 10 Jun 2009 23:22:29 +0200 (CEST)
Received: from localhost.localdomain (unknown [10.9.0.8])
	by dewire.com (Postfix) with ESMTP id 75735147D59F;
	Wed, 10 Jun 2009 23:22:27 +0200 (CEST)
X-Mailer: git-send-email 1.6.3.2.199.g7340d
In-Reply-To: <1241652781-16873-1-git-send-email-robin.rosenberg@dewire.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/121305>

More tests, leading to fixes of minor bugs, plus corrections
according to Shawn's comments.

-- robin

Robin Rosenberg (6):
  Add methods to RawParseUtils for scanning backwards.
  Add a ref log reader class
  Add ref rename support to JGit
  Add ref rename support to the branch dialog
  Improve error reporting in the branch dialog
  Remove a TAB from the message Egit generates into the reflog on
    commit

Shawn O. Pearce (1):
  Do not write to the reflog unless the refupdate logmessage is set

 .../src/org/spearce/egit/ui/UIText.java            |   18 +
 .../egit/ui/internal/actions/CommitAction.java     |    2 +-
 .../ui/internal/dialogs/BranchSelectionDialog.java |  133 ++++++--
 .../src/org/spearce/egit/ui/uitext.properties      |    7 +
 .../org/spearce/jgit/test/resources/packed-refs    |    1 +
 .../tst/org/spearce/jgit/lib/RefUpdateTest.java    |  348 +++++++++++++++++++-
 .../tst/org/spearce/jgit/lib/ReflogReaderTest.java |  166 ++++++++++
 .../org/spearce/jgit/lib/RepositoryTestCase.java   |   18 +
 .../org/spearce/jgit/transport/TransportTest.java  |    2 +-
 .../src/org/spearce/jgit/lib/RefDatabase.java      |   31 ++
 .../src/org/spearce/jgit/lib/RefLogWriter.java     |   33 ++-
 .../src/org/spearce/jgit/lib/RefRename.java        |  163 +++++++++
 .../src/org/spearce/jgit/lib/RefUpdate.java        |  115 +++++--
 .../src/org/spearce/jgit/lib/ReflogReader.java     |  187 +++++++++++
 .../src/org/spearce/jgit/lib/Repository.java       |   30 ++
 .../src/org/spearce/jgit/util/RawParseUtils.java   |   84 +++++-
 16 files changed, 1269 insertions(+), 69 deletions(-)
 create mode 100644 org.spearce.jgit.test/tst/org/spearce/jgit/lib/ReflogReaderTest.java
 create mode 100644 org.spearce.jgit/src/org/spearce/jgit/lib/RefRename.java
 create mode 100644 org.spearce.jgit/src/org/spearce/jgit/lib/ReflogReader.java


Short log of my patch queue before rebase:

Mine
      Add methods to RawParseUtils for scanning backwards.
      Add a ref log reader class
      Do not write to the reflog unless the refupdate logmessage is set
      Revert "Do not write to the reflog unless the refupdate logmessage is set"
      Add ref rename support to JGit
      Add ref rename support to the branch dialog
      Improve error reporting in the branch dialog
      Shawns comments, except the no-reflog update
      Remove a TAB from the message Egit generated into the reflog on commit
      Follow C Git's format for renames in the reflog
      Improve refupdate comment
      ..ReflogReader
      Move reflog creation to testcase base class
      ..rename tests

Shawn:
      Do not write to the reflog unless the refupdate logmessage is set
