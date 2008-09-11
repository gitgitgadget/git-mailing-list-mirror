From: Jonas Fonseca <fonseca@diku.dk>
Subject: [JGIT PATCH 2/2] Add test for resolving "tag^{tree}" where "tag"
	points to a tag
Date: Thu, 11 Sep 2008 23:41:25 +0200
Message-ID: <20080911214125.GB20238@diku.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Robin Rosenberg <robin.rosenberg@dewire.com>,
	"Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Thu Sep 11 23:42:37 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kdtvw-0000te-A4
	for gcvg-git-2@gmane.org; Thu, 11 Sep 2008 23:42:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753020AbYIKVl3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Sep 2008 17:41:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753346AbYIKVl3
	(ORCPT <rfc822;git-outgoing>); Thu, 11 Sep 2008 17:41:29 -0400
Received: from mgw2.diku.dk ([130.225.96.92]:48584 "EHLO mgw2.diku.dk"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752951AbYIKVl2 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Sep 2008 17:41:28 -0400
Received: from localhost (localhost [127.0.0.1])
	by mgw2.diku.dk (Postfix) with ESMTP id 5183119BC73;
	Thu, 11 Sep 2008 23:41:27 +0200 (CEST)
Received: from mgw2.diku.dk ([127.0.0.1])
 by localhost (mgw2.diku.dk [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
 id 27777-05; Thu, 11 Sep 2008 23:41:25 +0200 (CEST)
Received: from nhugin.diku.dk (nhugin.diku.dk [130.225.96.140])
	by mgw2.diku.dk (Postfix) with ESMTP id BB6DC19BC77;
	Thu, 11 Sep 2008 23:41:25 +0200 (CEST)
Received: from tyr.diku.dk (tyr.diku.dk [130.225.96.226])
	by nhugin.diku.dk (Postfix) with ESMTP
	id D06256DFAB0; Thu, 11 Sep 2008 23:41:12 +0200 (CEST)
Received: by tyr.diku.dk (Postfix, from userid 3873)
	id 952FC1A4001; Thu, 11 Sep 2008 23:41:25 +0200 (CEST)
Content-Disposition: inline
User-Agent: Mutt/1.5.16 (2007-06-09)
X-Virus-Scanned: amavisd-new at diku.dk
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/95651>

Signed-off-by: Jonas Fonseca <fonseca@diku.dk>
---
 .../spearce/jgit/test/resources/create-second-pack |    4 ++++
 ...ck-9c51502a527e1cc8ad4016629730bd1b90145dd6.idx |  Bin 0 -> 1100 bytes
 ...k-9c51502a527e1cc8ad4016629730bd1b90145dd6.pack |  Bin 0 -> 167 bytes
 .../org/spearce/jgit/test/resources/packed-refs    |    2 ++
 .../org/spearce/jgit/lib/RepositoryTestCase.java   |    1 +
 .../org/spearce/jgit/lib/T0008_testparserev.java   |    7 ++++++-
 6 files changed, 13 insertions(+), 1 deletions(-)
 create mode 100644 org.spearce.jgit.test/tst-rsrc/org/spearce/jgit/test/resources/pack-9c51502a527e1cc8ad4016629730bd1b90145dd6.idx
 create mode 100644 org.spearce.jgit.test/tst-rsrc/org/spearce/jgit/test/resources/pack-9c51502a527e1cc8ad4016629730bd1b90145dd6.pack

diff --git a/org.spearce.jgit.test/tst-rsrc/org/spearce/jgit/test/resources/create-second-pack b/org.spearce.jgit.test/tst-rsrc/org/spearce/jgit/test/resources/create-second-pack
index 03f83dc..ea02240 100755
--- a/org.spearce.jgit.test/tst-rsrc/org/spearce/jgit/test/resources/create-second-pack
+++ b/org.spearce.jgit.test/tst-rsrc/org/spearce/jgit/test/resources/create-second-pack
@@ -130,6 +130,10 @@ git tag -a -m "An annotated tag" B a^
 
 git repack -d
 
+git tag -a -m "An annotated tag tagging a tag" C B
+
+git repack -d
+
 git pack-refs --all
 
 
diff --git a/org.spearce.jgit.test/tst-rsrc/org/spearce/jgit/test/resources/pack-9c51502a527e1cc8ad4016629730bd1b90145dd6.idx b/org.spearce.jgit.test/tst-rsrc/org/spearce/jgit/test/resources/pack-9c51502a527e1cc8ad4016629730bd1b90145dd6.idx
new file mode 100644
index 0000000000000000000000000000000000000000..8405f4c6ec64f8519e17e69702bc35950e128cb6
GIT binary patch
literal 1100
zcmexg;-AdGz`z8=qhK@yMq&ss0zEzA@xEr!YX5(!yhYthes*1{PO|3ZQBbm9xd9k9
wJXUTS*|zl0x>0Br=esNKxZcZ0w+|WWZnu)?y}XifT9^3ql@C8^Ry^GZ0BtNH4FCWD

literal 0
HcmV?d00001

diff --git a/org.spearce.jgit.test/tst-rsrc/org/spearce/jgit/test/resources/pack-9c51502a527e1cc8ad4016629730bd1b90145dd6.pack b/org.spearce.jgit.test/tst-rsrc/org/spearce/jgit/test/resources/pack-9c51502a527e1cc8ad4016629730bd1b90145dd6.pack
new file mode 100644
index 0000000000000000000000000000000000000000..14fa6c4d3abbd372b093f78dc43fe51fa19b7b70
GIT binary patch
literal 167
zcmV;Y09gM}K|@Ob000620005U33!|xj6n**Fc1LmdBuLfvfEU%0TGK|&<AYNB`P*4
zC4&Cm#={JAni8HGE0A*sMn>r^ah%wPAVcK9j_oiYX^(#I(3<*P6sjb%0hi{aD~xc1
z>%FXSl<wWtt<L(9d3k9U%X|VN>OEPq7Ix?mjTtjY&ZSD#sr?%1krT-O{sZeZEQmTr
Vu?Dn{n%HqRUQN1g$1dsO+rk;dPBs7l

literal 0
HcmV?d00001

diff --git a/org.spearce.jgit.test/tst-rsrc/org/spearce/jgit/test/resources/packed-refs b/org.spearce.jgit.test/tst-rsrc/org/spearce/jgit/test/resources/packed-refs
index f67a3ef..fc280c7 100644
--- a/org.spearce.jgit.test/tst-rsrc/org/spearce/jgit/test/resources/packed-refs
+++ b/org.spearce.jgit.test/tst-rsrc/org/spearce/jgit/test/resources/packed-refs
@@ -9,5 +9,7 @@ d86a2aada2f5e7ccf6f11880bfb9ab404e8a8864 refs/heads/pa
 6db9c2ebf75590eef973081736730a9ea169a0c4 refs/tags/A
 17768080a2318cd89bba4c8b87834401e2095703 refs/tags/B
 ^d86a2aada2f5e7ccf6f11880bfb9ab404e8a8864
+be83157b4ffe650d728ba4f98ad47b623b0d0c20 refs/tags/C
+^d86a2aada2f5e7ccf6f11880bfb9ab404e8a8864
 8bbde7aacf771a9afb6992434f1ae413e010c6d8 refs/tags/spearce-gpg-pub
 ^fd608fbe625a2b456d9f15c2b1dc41f252057dd7
diff --git a/org.spearce.jgit.test/tst/org/spearce/jgit/lib/RepositoryTestCase.java b/org.spearce.jgit.test/tst/org/spearce/jgit/lib/RepositoryTestCase.java
index 270b90a..b40d7b1 100644
--- a/org.spearce.jgit.test/tst/org/spearce/jgit/lib/RepositoryTestCase.java
+++ b/org.spearce.jgit.test/tst/org/spearce/jgit/lib/RepositoryTestCase.java
@@ -141,6 +141,7 @@ public void run() {
 				"pack-34be9032ac282b11fa9babdc2b2a93ca996c9c2f",
 				"pack-df2982f284bbabb6bdb59ee3fcc6eb0983e20371",
 				"pack-9fb5b411fe6dfa89cc2e6b89d2bd8e5de02b5745",
+				"pack-9c51502a527e1cc8ad4016629730bd1b90145dd6",
 				"pack-e6d07037cbcf13376308a0a995d1fa48f8f76aaa"
 		};
 		final File packDir = new File(db.getObjectsDirectory(), "pack");
diff --git a/org.spearce.jgit.test/tst/org/spearce/jgit/lib/T0008_testparserev.java b/org.spearce.jgit.test/tst/org/spearce/jgit/lib/T0008_testparserev.java
index 3457574..2a1a4ad 100644
--- a/org.spearce.jgit.test/tst/org/spearce/jgit/lib/T0008_testparserev.java
+++ b/org.spearce.jgit.test/tst/org/spearce/jgit/lib/T0008_testparserev.java
@@ -116,10 +116,15 @@ public void testDerefTagIssue23() throws IOException {
 		assertEquals("d86a2aada2f5e7ccf6f11880bfb9ab404e8a8864",db.resolve("refs/tags/B^0").name());
 	}
 
+	public void testDerefTaggedTagTree() throws IOException {
+		assertEquals("269e1253bad5c247c6bde37aa48ae1e03138206c",db.resolve("refs/tags/C").name());
+		assertEquals("d86a2aada2f5e7ccf6f11880bfb9ab404e8a8864",db.resolve("refs/tags/C^{commit}").name());
+		assertEquals("856ec208ae6cadac25a6d74f19b12bb27a24fe24",db.resolve("refs/tags/C^{tree}").name());
+	}
+
 	public void testDerefBlob() throws IOException {
 		assertEquals("fd608fbe625a2b456d9f15c2b1dc41f252057dd7",db.resolve("fd608fbe625a2b456d9f15c2b1dc41f252057dd7^{}").name());
 		assertEquals("fd608fbe625a2b456d9f15c2b1dc41f252057dd7",db.resolve("fd608fbe625a2b456d9f15c2b1dc41f252057dd7^{blob}").name());
 	}
 
-	// TODO: ^{tree} for a tag pointing to a tag
 }
-- 
1.6.0.336.ga07ba


-- 
Jonas Fonseca
