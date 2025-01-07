Received: from fout-b5-smtp.messagingengine.com (fout-b5-smtp.messagingengine.com [202.12.124.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 371F818DF6E
	for <git@vger.kernel.org>; Tue,  7 Jan 2025 17:37:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736271451; cv=none; b=b7iTbmw14hrJ5PhQAodhzHATADqIcQS5hnSI3+Us9tG0TiMG/oQ996OrpoOeVMQpTmDZ5aO2qpB0W+ffv7LmYnww6xOdyQG4tSf4PDs/A5nyEUzcsBqxrI/LaDXnDwHX/96mJnZSjcn7tjgihgacMmhtPE3IPdwSat1DWUAdKcc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736271451; c=relaxed/simple;
	bh=cmVLFIx9eLODSlHEVgDxbwuxKumJzBe/JtxNVf5FLvE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=txQpKZnfqjwBcP1jDc7bc16RuAPfjnLHRtb5bJaWuKsNKJx8GZ7FPRFs33cwgpIe6iH8K1OdmNoN9W+XfkYkeel+Ra3+8y9fQc1qkIj2UuWRmDJe+K6AdEtDEjn0L5k0eh8ABk09RvxndbexvopYrdG4l3lwnGmFLZcvFLGw8/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=CvsC85Np; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=jGwXPIOm; arc=none smtp.client-ip=202.12.124.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="CvsC85Np";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="jGwXPIOm"
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfout.stl.internal (Postfix) with ESMTP id CAA8C1140184;
	Tue,  7 Jan 2025 12:37:26 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Tue, 07 Jan 2025 12:37:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:message-id:mime-version:reply-to
	:subject:subject:to:to; s=fm2; t=1736271446; x=1736357846; bh=qy
	YfbKmsVvSBmjOf/Sb6b/7xTHlu7urio9y3gyA0Rj0=; b=CvsC85NprgBfu9NO8l
	1UDAoca+vBdxwuGeI4NAL/dVGp2PqgEdLiLywlANgBOqjvBvK3NwitkjQfxzHKXM
	cQXolDZ7xkiPxHF4/t3nuocfED7eEU7KoP1h9I59BJbAVweV7+KOz9kWHdLnsTgg
	Ub4YaNAaA9m7QWVm/+Ht74coaNE283ynI6zah3KQMPd1uS76Sm12aH2W/5wNCyYZ
	iECmIL0/McRjxKVR5nKi7UeviIouqRqo56h4VgJ5BK/jToYnmFIu7G2BYn+Cbfq3
	nvV4i858qw7y7LmNAre051RKup0emksUSrw254rHzYQiHwuMIYyyvNiy07+lHEKM
	IigA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1736271446; x=1736357846; bh=qyYfbKmsVvSBmjOf/Sb6b/7xTHlu
	7urio9y3gyA0Rj0=; b=jGwXPIOmRPjBLprdtMQoW7JA5kFj53SVKFNr5BIhUruN
	lOpzVNsDn1wiaZqwBqtD7Ypzk2cJ4KlUCnoxuVfbUezLGlFrYLlSxONfosUZRsYN
	hULFl5lNHLyC5P0obG51ZIpnC5NWkm5exgSwjWRS9Vkku6dV2Dc8vWD+t38YGAfZ
	wOH6FJOD9nGhQn2MxPhhx5gCCalb/egPd3IbAJpWONEQFn7+yFRRRMhPITxfuwwF
	FZCK6zUAUKbmVbSFDGL5OmOCiZYNlcOLlQCFSlAlslwwrwAAzumAHqdPTO3Da/jG
	eKDzIirfGnuZjhqtXUl7LSLw2c1XS4Vo0/XJ0+OjAQ==
X-ME-Sender: <xms:VmZ9Z8MyoC37gF-kwGtd2SH-AqB74DYULYwAGkuwzI6EFHA-R4ZZ6jc>
    <xme:VmZ9Zy_riohYPQ261eZV-H10elseQb3wUSoUgEdXPnqbYOtBh6Ozrfd7kec_sYjiW
    8kiDxx_TOdkV9iIAw>
X-ME-Received: <xmr:VmZ9ZzS1Jns66WwV4Bj5vjPWbvin-OST4vc377KjkQbrmWtbj7uBhXXMY11ei2Htcknd0Xpnc7kVLVWJvu4WIxMjFut7bWgaVoBvXXM5bw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudegvddguddtudcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecunecujfgurhephffvve
    fufffkofggtgfgsehtkeertdertdejnecuhfhrohhmpehkrhhishhtohhffhgvrhhhrghu
    ghhssggrkhhksehfrghsthhmrghilhdrtghomhenucggtffrrghtthgvrhhnpeetgfekje
    ffudeffeffgeekvefgvedvgeffueejjeelgeduhfdtffeikeelfefhgfenucevlhhushht
    vghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehkrhhishhtohhffhgvrh
    hhrghughhssggrkhhksehfrghsthhmrghilhdrtghomhdpnhgspghrtghpthhtohepvddp
    mhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlh
    drohhrghdprhgtphhtthhopegtohguvgeskhhhrghughhssggrkhhkrdhnrghmvg
X-ME-Proxy: <xmx:VmZ9Z0tLG584WJL8KIy883Ms_CmeXw7bb3IiVVUZXvpK2zlhAV5weQ>
    <xmx:VmZ9Z0c1rPPDdcDZQ7sa_seSdKCXJJ8_BG3J9TASeTsFDsrLxiU7Og>
    <xmx:VmZ9Z40Vi6hsOZ4jRjo8V81SFQ47-YWQqr-Lt3jz6uQRgA1YcxOeSQ>
    <xmx:VmZ9Z49sLk891c8z9qc5GugMMxEnTdsiS8frZfIvw-EZ68I8gqaXgA>
    <xmx:VmZ9Z1oEWOe9rnJSmxLJeG9SeGLqIVwq9BLY3u947K1tghYqUqpeGXSN>
Feedback-ID: i8b11424c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 7 Jan 2025 12:37:25 -0500 (EST)
From: kristofferhaugsbakk@fastmail.com
To: git@vger.kernel.org
Cc: Kristoffer Haugsbakk <code@khaugsbakk.name>
Subject: [PATCH] RelNotes/2.48.0: fix typos etc.
Date: Tue,  7 Jan 2025 18:37:06 +0100
Message-ID: <04fee3b38052ffb731e2935cd5e8ee06f3d1c69a.1736271065.git.code@khaugsbakk.name>
X-Mailer: git-send-email 2.48.0.rc2
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Kristoffer Haugsbakk <code@khaugsbakk.name>

Correct verb tense, add missing words, avoid double blank lines,
and rephrase things that don’t read well to me like “Turn this linkage
to relative paths”.

Signed-off-by: Kristoffer Haugsbakk <code@khaugsbakk.name>
---
 Documentation/RelNotes/2.48.0.txt | 25 ++++++++++++-------------
 1 file changed, 12 insertions(+), 13 deletions(-)

diff --git a/Documentation/RelNotes/2.48.0.txt b/Documentation/RelNotes/2.48.0.txt
index d62c62dc17a..eff93be37a2 100644
--- a/Documentation/RelNotes/2.48.0.txt
+++ b/Documentation/RelNotes/2.48.0.txt
@@ -47,15 +47,15 @@ Performance, Internal Implementation, Development Support etc.
 
  * The way AsciiDoc is used for SYNOPSIS part of the manual pages has
    been revamped.  The sources, at least for the simple cases, got
-   vastly pleasant to work with.
+   vastly more pleasant to work with.
 
  * The reftable library is now prepared to expect that the memory
    allocation function given to it may fail to allocate and to deal
    with such an error.
 
  * An extra worktree attached to a repository points at each other to
-   allow finding the repository from the worktree and vice versa
-   possible.  Turn this linkage to relative paths.
+   allow finding the repository from the worktree (and vice versa)
+   possible.  Use relative paths for this linkage.
 
  * Enable Windows-based CI in GitLab.
 
@@ -94,7 +94,7 @@ Performance, Internal Implementation, Development Support etc.
  * Update the project's CodingGuidelines to discourage naming functions
    with a "_1()" suffix.
 
- * Updates the '.clang-format' to match project conventions.
+ * Update '.clang-format' to match project conventions.
 
  * Centralize documentation for repository extensions into a single place.
 
@@ -116,7 +116,7 @@ Performance, Internal Implementation, Development Support etc.
  * The migration procedure between two ref backends has been optimized.
 
  * "git fsck" learned to issue warnings on "curiously formatted" ref
-   contents that have always been taken valid but something Git
+   contents that have always been treated as valid but that Git
    wouldn't have written itself (e.g., missing terminating end-of-line
    after the full object name).
 
@@ -127,13 +127,13 @@ Performance, Internal Implementation, Development Support etc.
 
  * Drop support for ancient environments in various CI jobs.
 
- * Isolates the reftable subsystem from the rest of Git's codebase by
+ * Isolate the reftable subsystem from the rest of Git's codebase by
    using fewer pieces of Git's infrastructure.
 
  * Optimize reading random references out of the reftable backend by
    allowing reuse of iterator objects.
 
- * Backport oss-fuzz tests for us to our codebase.
+ * Backport oss-fuzz tests to our codebase.
 
  * Introduce a new repository extension to prevent older Git versions
    from mis-interpreting worktrees created with relative paths.
@@ -173,13 +173,13 @@ Fixes since v2.47
 -----------------
 
  * Doc update to clarify how periodical maintenance are scheduled,
-   spread across time to avoid thundering hurds.
+   spread across time to avoid thundering herds.
 
  * Use after free and double freeing at the end in "git log -L... -p"
    had been identified and fixed.
 
  * On macOS, fsmonitor can fall into a race condition that results in
-   a client waiting forever to be notified for an event that have
+   a client waiting forever to be notified about an event that has
    already happened.  This problem has been corrected.
 
  * "git maintenance start" crashed due to an uninitialized variable
@@ -203,7 +203,7 @@ Fixes since v2.47
  * The dumb-http code regressed when the result of re-indexing a pack
    yielded an *.idx file that differs in content from the *.idx file
    it downloaded from the remote. This has been corrected by no longer
-   relying on: the *.idx file we got from the remote.
+   relying on the *.idx file we got from the remote.
 
  * When called with '--left-right' and '--use-bitmap-index', 'rev-list'
    will produce output without any left/right markers, which has been
@@ -227,7 +227,7 @@ Fixes since v2.47
  * "git gc" discards any objects that are outside promisor packs that
    are referred to by an object in a promisor pack, and we do not
    refetch them from the promisor at runtime, resulting an unusable
-   repository.  Work it around by including these objects in the
+   repository.  Work around it by including these objects in the
    referring promisor pack at the receiving end of the fetch.
 
  * Avoid build/test breakage on a system without working malloc debug
@@ -282,9 +282,8 @@ Fixes since v2.47
    on the path, which was not documented, which has been corrected.
    (merge bc1a980759 kk/doc-ancestry-path later to maint).
 
-
  * "git tag" has been taught to refuse to create refs/tags/HEAD
-   as such a tag will be confusing in the context of UI provided by
+   since such a tag will be confusing in the context of the UI provided by
    the Git Porcelain commands.
    (merge bbd445d5ef jc/forbid-head-as-tagname later to maint).
 

base-commit: b74ff38af58464688b211140b90ec90598d340c6
-- 
2.48.0.rc2

