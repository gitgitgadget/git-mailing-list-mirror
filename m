From: Marek Zawirski <marek.zawirski@gmail.com>
Subject: [JGIT PATCH 00/12] Extensions in core needed by PackWriter
Date: Mon,  2 Jun 2008 23:24:31 +0200
Message-ID: <1212441883-12990-1-git-send-email-marek.zawirski@gmail.com>
Cc: git@vger.kernel.org, Marek Zawirski <marek.zawirski@gmail.com>
To: robin.rosenberg@dewire.com, spearce@spearce.org
X-From: git-owner@vger.kernel.org Mon Jun 02 23:25:49 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K3HXF-0006RV-6F
	for gcvg-git-2@gmane.org; Mon, 02 Jun 2008 23:25:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751467AbYFBVYu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 2 Jun 2008 17:24:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751311AbYFBVYu
	(ORCPT <rfc822;git-outgoing>); Mon, 2 Jun 2008 17:24:50 -0400
Received: from fg-out-1718.google.com ([72.14.220.153]:39632 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751292AbYFBVYt (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 Jun 2008 17:24:49 -0400
Received: by fg-out-1718.google.com with SMTP id 19so844313fgg.17
        for <git@vger.kernel.org>; Mon, 02 Jun 2008 14:24:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date:message-id:x-mailer;
        bh=+uhTVL/OsR4ZWTH0RlSkh7/bvkajIswFn8cxVX5UddM=;
        b=KasxkoyctWCWDx7tNiV2Nb417GyX0HIiv0kKxWz2CAeFtskGO1UFRWfm+0gG8qgKV4VfDdNAoPVlU8MHQqqK1En15TZ9zBgqwGjYpsswMazN/5itsEQUG3dL6jV0+Oui5fUxpX2oeiYV9I2HzRY925hu1A1NkKTfeoWjUSqmg0g=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=RfHSbaAqH4u701QVLzUPrOEO6kjXJelphWNrsbEi9X80Ru5G3P9hsspGZleFYrKU6W1m+RENTtIoJxR3eda7Xrrw0PJuBgPB3iQQmg0wHXeUzBBQBdfkZNAiBzT8sNO8tzLSmf44NzzgwlRX450nW6BDt7fi20brK4ByPVpr2BE=
Received: by 10.86.59.18 with SMTP id h18mr1468960fga.67.1212441885804;
        Mon, 02 Jun 2008 14:24:45 -0700 (PDT)
Received: from localhost ( [62.21.19.93])
        by mx.google.com with ESMTPS id l12sm4338441fgb.6.2008.06.02.14.24.44
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 02 Jun 2008 14:24:45 -0700 (PDT)
X-Mailer: git-send-email 1.5.5.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/83566>

Hello,

Here is my first GSoC series - some work from the last week.
It's actually not a PackWriter, but some changes in existing jgit core
related to PackWriting. Some of these added methods/refactors are not yet
used within this series, but are used in my dirty branch in PackWriter
which is under-development, even somewhat usable.

Series start with formatting stuff, as some old files were not
appropriatelly formatted.

This series is also available at my corechanges branch:
http://repo.or.cz/w/egit/zawir.git?a=shortlog;h=refs/heads/corechanges
It's based on Shawn's bsd branch, with new BSD-style license, but I can
rebase if really needed.

If you want to track some PackWriter (itself) development you may want to
have a look at my dirty branch:
http://repo.or.cz/w/egit/zawir.git?a=shortlog;h=refs/heads/dirty

That's all. Although Shawn already reviewed some old version of this patches,
I'm still interested in your comments.

Marek Zawirski (12):
  Format PackFile class
  Format PackIndex class
  Format PackIndexV1 class
  Add getType() method to RevObject hierarchy
  Replace instanceof in WalkFetchConnection with getType()
  Move PackFile.SIGNATURE to Constants.PACK_SIGNATURE
  Add overload of fromRaw() in MutableObjectId accepting int[]
  Copying constructor of MutableObjectId
  Add getSize() method to ObjectIdSubclassMap
  Add getObjectCount() method to PackFile
  Entries iterator in PackIndex and indirectly PackFile
  Add PackIndex specific tests, currently only iterators tests

 .../tst/org/spearce/jgit/lib/PackIndexTest.java    |  152 ++++++++++++++++++++
 .../tst/org/spearce/jgit/lib/PackIndexV1Test.java  |   54 +++++++
 .../tst/org/spearce/jgit/lib/PackIndexV2Test.java  |   54 +++++++
 ...-34be9032ac282b11fa9babdc2b2a93ca996c9c2f.idxV2 |  Bin 0 -> 1296 bytes
 ...-df2982f284bbabb6bdb59ee3fcc6eb0983e20371.idxV2 |  Bin 0 -> 2976 bytes
 .../src/org/spearce/jgit/lib/Constants.java        |    8 +
 .../src/org/spearce/jgit/lib/MutableObjectId.java  |   50 +++++++
 .../org/spearce/jgit/lib/ObjectIdSubclassMap.java  |    9 ++
 .../src/org/spearce/jgit/lib/PackFile.java         |   55 +++++--
 .../src/org/spearce/jgit/lib/PackIndex.java        |   86 +++++++++++-
 .../src/org/spearce/jgit/lib/PackIndexV1.java      |   45 +++++-
 .../src/org/spearce/jgit/lib/PackIndexV2.java      |   36 +++++
 .../src/org/spearce/jgit/revwalk/RevBlob.java      |    6 +
 .../src/org/spearce/jgit/revwalk/RevCommit.java    |    5 +
 .../src/org/spearce/jgit/revwalk/RevObject.java    |    8 +
 .../src/org/spearce/jgit/revwalk/RevTag.java       |    5 +
 .../src/org/spearce/jgit/revwalk/RevTree.java      |    6 +
 .../src/org/spearce/jgit/transport/IndexPack.java  |    8 +-
 .../jgit/transport/WalkFetchConnection.java        |   36 +++--
 19 files changed, 576 insertions(+), 47 deletions(-)
 create mode 100644 org.spearce.jgit.test/tst/org/spearce/jgit/lib/PackIndexTest.java
 create mode 100644 org.spearce.jgit.test/tst/org/spearce/jgit/lib/PackIndexV1Test.java
 create mode 100644 org.spearce.jgit.test/tst/org/spearce/jgit/lib/PackIndexV2Test.java
 create mode 100644 org.spearce.jgit.test/tst/pack-34be9032ac282b11fa9babdc2b2a93ca996c9c2f.idxV2
 create mode 100644 org.spearce.jgit.test/tst/pack-df2982f284bbabb6bdb59ee3fcc6eb0983e20371.idxV2
