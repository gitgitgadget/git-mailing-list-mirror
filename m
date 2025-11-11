Received: from fhigh-b6-smtp.messagingengine.com (fhigh-b6-smtp.messagingengine.com [202.12.124.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FEE03A79B1
	for <git@vger.kernel.org>; Tue, 11 Nov 2025 19:59:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762891144; cv=none; b=c+mWEi34oQ0w2fcugMlZ3GAUKuwHsvT0TedbSNCOFptE1jmMrSgC9Jddmfs2hQPTxk9c2bRXO+xzijkg09s47snTm0sSLBzHcfSZQWiPyDy8J8KB0L5vPoSgbb7DleW3hZC0oqjXS+NvmSzRywIcHhxUADChoK8CskvPAS7MoRs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762891144; c=relaxed/simple;
	bh=rJOKtW8F++6B8IrmA1r62NRYXdQOutNCyNmSesUkoio=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SZ1UjuuUkgTe1EKoWsAbhZozBdgjeDNyC162Z9rQ2xidnlWA1ji2gNspYflRrAib1ywQwTmv47EZBDs0xAVeor4qQjZ8pxiOxjm1YUNv9oRxXcHYDPRuNJ0o/Py5shw4OTBIRE8KsPCSw5SUGQMlVtRqYau7Gid/YdynxeQQC80=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=csMUZMY9; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=F1RZ2xN6; arc=none smtp.client-ip=202.12.124.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="csMUZMY9";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="F1RZ2xN6"
Received: from phl-compute-08.internal (phl-compute-08.internal [10.202.2.48])
	by mailfhigh.stl.internal (Postfix) with ESMTP id BBA577A010D;
	Tue, 11 Nov 2025 14:58:59 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-08.internal (MEProxy); Tue, 11 Nov 2025 14:58:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1762891139; x=
	1762977539; bh=ewJoa7rmZAp0ANcDSPd13TqLfP2ApQnSFt84cDAJICg=; b=c
	sMUZMY9FR0Th9dO+odB0fE9OD991u5hNBTkPR7jsqY1q+uXvNCp1hJLi0ddsUjcw
	UmBXaD5vvlf1nTB/3fPNs+2cOU9zOReyddMNqOKTQCodLIScNZhgD8ougdaRJc71
	UsuYyIfP+o1wDCOHTF4cGDM9TxtypgBKTqVhx1Apm+ELV1sjAGBththd++5HcFho
	KN1ekSDp8pqRKZdPtMqfHQktsB6Ryr8+jVrk8e3SJ1SJJDLyn+2+PoJF30zIT1z9
	5uV5Ix2mukG7CG3rSKEqbNavJ62aG3t8jewFLafjFpECC/s4AwBLxPnynjF3T6Q+
	D1wXBUOXS3C7bxiJoeBXg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:date:date:feedback-id:feedback-id:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1762891139; x=1762977539; bh=ewJoa7rmZAp0ANcDSPd13TqLfP2A
	pQnSFt84cDAJICg=; b=F1RZ2xN6UV+m8ywYAHHuDpj3hE2uOVrar/XUtNx22865
	A9sUl/e3+NvXLvV4PD2MhDd1TPti0C+SX+G8Um5YaGhmdXPf+32KqYbCrYjY/VLp
	JjA9h29hTNedpoLni1QSQKEKNSG+nNxrc8DFjKr2hLYk5Jjm6Iy2c9t4Elj592H2
	020Wygb2YXBZDDiYSrcLSve6wJvIdo9x9u6JPNXNLEK4gMxQitVN5m9LQ1olM07E
	OYLWrdFvrxK3gEUbPvfr90AASzKwVXc8FCsdQs6us+QKqQ2tGt0WY8hLCHBlJbaB
	7FWAlzptQ46FJtDOuOWxe5FlL8xjkrrc2kjhsl+Fyw==
X-ME-Sender: <xms:g5UTaW4kuSju0sP3e4gLGwdeelCluMjVSrr7WKjU6fuTbDXR9kr1fg>
    <xme:g5UTaV72in8jZ6TixVO0Xat-JbdUbfKUlj5dl06uMoHXBQQ9BpoYibM1Y7GsICrlM
    d0dvNDXNDoirWwDQjQpCDmPWI23C60wg3dy3F_wdn5A9DvcbsGHoA>
X-ME-Received: <xmr:g5UTaTFQdP5yg0jXxI7gVuUNDwN0WdsKHISVCWnoQ2CoQXHM8jLSF3RyIiFppqW_FrPXGauNQ4_pLVjE4sM5OFkRUD-E4s35s48X>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvtddvtdelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefhvffufffkofgjfhgggfestdekredtre
    dttdenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphho
    sghogidrtghomheqnecuggftrfgrthhtvghrnhepleevieefieeuffeugefhveeugefgfe
    evvdefleevuedvfedvudefkeehtdeftdegnecuvehluhhsthgvrhfuihiivgeptdenucfr
    rghrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspg
    hrtghpthhtohepvddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithesvhhg
    vghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrd
    gtohhm
X-ME-Proxy: <xmx:g5UTaeRzmGr5IJDbqDWBxWbhwiOL76Ekqmc1x2fySS9vmhxoS1g11w>
    <xmx:g5UTacut_tIYtgDwVGFk1QTOyCtutks_aBxAF5hphJZxwrBpcxlB6Q>
    <xmx:g5UTadxMUIX05GzV2kYOEbWnObSgRkqqqhlf4KQNFNXm-pNpONc69w>
    <xmx:g5UTaW4Uo2b2_rVg5i2Spsb8HYwNSQHlwd7t1SWdCgZFbPYHjrCoyw>
    <xmx:g5UTaaQBTyghCdm6v7l15caKJ0-2FUXjGMKs4fesA4S1_PZkGvSwh-K3>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 11 Nov 2025 14:58:58 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Subject: [PATCH v1 2/3] Documentation: your checkout directory is "working tree" (part 1)
Date: Tue, 11 Nov 2025 11:58:52 -0800
Message-ID: <20251111195853.2511146-3-gitster@pobox.com>
X-Mailer: git-send-email 2.52.0-rc1-455-g30608eb744
In-Reply-To: <20251111195853.2511146-1-gitster@pobox.com>
References: <20251111195853.2511146-1-gitster@pobox.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

As "git help glossary" says, there is "working tree" that is a
directory that holds a checkout, and there is "worktree" (one word)
that is a working tree plus repository metadata.  There is no "work
tree".

Many of these documentation pages that use the phrase "work tree"
were written way before the "worktree" mechanism was introduced, and
they talk about what we call "working tree" these days.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 Documentation/diff-format.adoc     |  2 +-
 Documentation/diff-options.adoc    |  2 +-
 Documentation/git-add.adoc         |  2 +-
 Documentation/git-grep.adoc        |  2 +-
 Documentation/git-hash-object.adoc |  2 +-
 Documentation/git-read-tree.adoc   | 14 +++++++-------
 Documentation/git-rev-parse.adoc   |  4 ++--
 Documentation/git-rm.adoc          |  4 ++--
 Documentation/git-stash.adoc       |  2 +-
 Documentation/git-status.adoc      | 14 +++++++-------
 Documentation/git-submodule.adoc   |  2 +-
 Documentation/gitattributes.adoc   | 16 ++++++++--------
 Documentation/gitcli.adoc          | 10 +++++-----
 Documentation/gitmodules.adoc      |  2 +-
 Documentation/user-manual.adoc     |  8 ++++----
 15 files changed, 43 insertions(+), 43 deletions(-)

diff --git a/Documentation/diff-format.adoc b/Documentation/diff-format.adoc
index 9f7e988241..6b1f9c2124 100644
--- a/Documentation/diff-format.adoc
+++ b/Documentation/diff-format.adoc
@@ -43,7 +43,7 @@ That is, from the left to the right:
 . a space.
 . sha1 for "src"; 0\{40\} if creation or unmerged.
 . a space.
-. sha1 for "dst"; 0\{40\} if deletion, unmerged or "work tree out of sync with the index".
+. sha1 for "dst"; 0\{40\} if deletion, unmerged or "working tree file out of sync with the index".
 . a space.
 . status, followed by optional "score" number.
 . a tab or a NUL when `-z` option is used.
diff --git a/Documentation/diff-options.adoc b/Documentation/diff-options.adoc
index ae31520f7f..cb623a0c7d 100644
--- a/Documentation/diff-options.adoc
+++ b/Documentation/diff-options.adoc
@@ -864,7 +864,7 @@ endif::git-format-patch[]
 	`ignore` option in linkgit:git-config[1] or linkgit:gitmodules[5]. When
 	`untracked` is used submodules are not considered dirty when they only
 	contain untracked content (but they are still scanned for modified
-	content). Using `dirty` ignores all changes to the work tree of submodules,
+	content). Using `dirty` ignores all changes to the working tree of submodules,
 	only changes to the commits stored in the superproject are shown (this was
 	the behavior until 1.7.0). Using `all` hides all changes to submodules.
 
diff --git a/Documentation/git-add.adoc b/Documentation/git-add.adoc
index 6192daeb03..18e7ed9b79 100644
--- a/Documentation/git-add.adoc
+++ b/Documentation/git-add.adoc
@@ -94,7 +94,7 @@ in linkgit:gitglossary[7].
 `-p`::
 `--patch`::
 	Interactively choose hunks of patch between the index and the
-	work tree and add them to the index. This gives the user a chance
+	working tree and add them to the index. This gives the user a chance
 	to review the difference before adding modified contents to the
 	index.
 +
diff --git a/Documentation/git-grep.adoc b/Documentation/git-grep.adoc
index a548585d4c..5be258f1cd 100644
--- a/Documentation/git-grep.adoc
+++ b/Documentation/git-grep.adoc
@@ -33,7 +33,7 @@ SYNOPSIS
 
 DESCRIPTION
 -----------
-Look for specified patterns in the tracked files in the work tree, blobs
+Look for specified patterns in the tracked files in the working tree, blobs
 registered in the index file, or blobs in given tree objects.  Patterns
 are lists of one or more search expressions separated by newline
 characters.  An empty string as search expression matches all lines.
diff --git a/Documentation/git-hash-object.adoc b/Documentation/git-hash-object.adoc
index ef4719ae41..0a02f77004 100644
--- a/Documentation/git-hash-object.adoc
+++ b/Documentation/git-hash-object.adoc
@@ -17,7 +17,7 @@ DESCRIPTION
 -----------
 Computes the object ID value for an object with specified type
 with the contents of the named file (which can be outside of the
-work tree), and optionally writes the resulting object into the
+working tree), and optionally writes the resulting object into the
 object database.  Reports its object ID to its standard output.
 When <type> is not specified, it defaults to "blob".
 
diff --git a/Documentation/git-read-tree.adoc b/Documentation/git-read-tree.adoc
index 1c04bba2b7..9d60badd74 100644
--- a/Documentation/git-read-tree.adoc
+++ b/Documentation/git-read-tree.adoc
@@ -23,7 +23,7 @@ linkgit:git-checkout-index[1])
 Optionally, it can merge a tree into the index, perform a
 fast-forward (i.e. 2-way) merge, or a 3-way merge, with the `-m`
 flag.  When used with `-m`, the `-u` flag causes it to also update
-the files in the work tree with the result of the merge.
+the files in the working tree with the result of the merge.
 
 Only trivial merges are done by 'git read-tree' itself.  Only conflicting paths
 will be in an unmerged state when 'git read-tree' returns.
@@ -158,7 +158,7 @@ fast-forward situation).
 When two trees are specified, the user is telling 'git read-tree'
 the following:
 
-     1. The current index and work tree is derived from $H, but
+     1. The current index and working tree is derived from $H, but
 	the user may have local changes in them since $H.
 
      2. The user wants to fast-forward to $M.
@@ -166,7 +166,7 @@ the following:
 In this case, the `git read-tree -m $H $M` command makes sure
 that no local change is lost as the result of this "merge".
 Here are the "carry forward" rules, where "I" denotes the index,
-"clean" means that index and work tree coincide, and "exists"/"nothing"
+"clean" means that index and working tree coincide, and "exists"/"nothing"
 refer to the presence of a path in the specified commit:
 
 ....
@@ -212,7 +212,7 @@ refer to the presence of a path in the specified commit:
 
 In all "keep index" cases, the index entry stays as in the
 original index file.  If the entry is not up to date,
-'git read-tree' keeps the copy in the work tree intact when
+'git read-tree' keeps the copy in the working tree intact when
 operating under the -u flag.
 
 When this form of 'git read-tree' returns successfully, you can
@@ -317,7 +317,7 @@ end of a successful merge.
 
 When you start a 3-way merge with an index file that is already
 populated, it is assumed that it represents the state of the
-files in your work tree, and you can even have files with
+files in your working tree, and you can even have files with
 changes unrecorded in the index file.  It is further assumed
 that this state is "derived" from the stage 2 tree.  The 3-way
 merge refuses to run if it finds an entry in the original index
@@ -342,7 +342,7 @@ $ git fetch git://.... linus
 $ LT=`git rev-parse FETCH_HEAD`
 ----------------
 
-Your work tree is still based on your HEAD ($JC), but you have
+Your working tree is still based on your HEAD ($JC), but you have
 some edits since.  Three-way merge makes sure that you have not
 added or modified index entries since $JC, and if you haven't,
 then does the right thing.  So with the following sequence:
@@ -355,7 +355,7 @@ $ echo "Merge with Linus" | \
 ----------------
 
 what you would commit is a pure merge between $JC and $LT without
-your work-in-progress changes, and your work tree would be
+your work-in-progress changes, and your working tree would be
 updated to the result of the merge.
 
 However, if you have local changes in the working tree that
diff --git a/Documentation/git-rev-parse.adoc b/Documentation/git-rev-parse.adoc
index 5398691f3f..ced73fa8af 100644
--- a/Documentation/git-rev-parse.adoc
+++ b/Documentation/git-rev-parse.adoc
@@ -261,7 +261,7 @@ The following options are modified by `--path-format`:
 	relative to the current working directory.
 +
 If `$GIT_DIR` is not defined and the current directory
-is not detected to lie in a Git repository or work tree
+is not detected to lie in a Git repository or a working tree,
 print a message to stderr and exit with nonzero status.
 
 --git-common-dir::
@@ -305,7 +305,7 @@ The following options are unaffected by `--path-format`:
 	directory print "true", otherwise "false".
 
 --is-inside-work-tree::
-	When the current working directory is inside the work tree of the
+	When the current working directory is inside the working tree of the
 	repository print "true", otherwise "false".
 
 --is-bare-repository::
diff --git a/Documentation/git-rm.adoc b/Documentation/git-rm.adoc
index b5ead86796..a7a3068381 100644
--- a/Documentation/git-rm.adoc
+++ b/Documentation/git-rm.adoc
@@ -163,12 +163,12 @@ will be staged (unless `--cached` or `-n` are used).
 
 A submodule is considered up to date when the `HEAD` is the same as
 recorded in the index, no tracked files are modified and no untracked
-files that aren't ignored are present in the submodule's work tree.
+files that aren't ignored are present in the submodule's working tree.
 Ignored files are deemed expendable and won't stop a submodule's work
 tree from being removed.
 
 If you only want to remove the local checkout of a submodule from your
-work tree without committing the removal, use linkgit:git-submodule[1] `deinit`
+working tree without committing the removal, use linkgit:git-submodule[1] `deinit`
 instead. Also see linkgit:gitsubmodules[7] for details on submodule removal.
 
 EXAMPLES
diff --git a/Documentation/git-stash.adoc b/Documentation/git-stash.adoc
index 235d57ddd8..78de244390 100644
--- a/Documentation/git-stash.adoc
+++ b/Documentation/git-stash.adoc
@@ -365,7 +365,7 @@ $ git stash pop
 Testing partial commits::
 
 You can use `git stash push --keep-index` when you want to make two or
-more commits out of the changes in the work tree, and you want to test
+more commits out of the changes in the working tree, and you want to test
 each change before committing:
 +
 ----------------------------------------------------------------
diff --git a/Documentation/git-status.adoc b/Documentation/git-status.adoc
index 9a376886a5..b32db372cd 100644
--- a/Documentation/git-status.adoc
+++ b/Documentation/git-status.adoc
@@ -95,7 +95,7 @@ configuration variable documented in linkgit:git-config[1].
 	'ignore' option in linkgit:git-config[1] or linkgit:gitmodules[5]. When
 	"untracked" is used submodules are not considered dirty when they only
 	contain untracked content (but they are still scanned for modified
-	content). Using "dirty" ignores all changes to the work tree of submodules,
+	content). Using "dirty" ignores all changes to the working tree of submodules,
 	only changes to the commits stored in the superproject are shown (this was
 	the behavior before 1.7.0). Using "all" hides all changes to submodules
 	(and suppresses the output of submodule summaries when the config option
@@ -226,12 +226,12 @@ A        [ MTD]  added to index
 D                deleted from index
 R        [ MTD]  renamed in index
 C        [ MTD]  copied in index
-[MTARC]          index and work tree matches
-[ MTARC]    M    work tree changed since index
-[ MTARC]    T    type changed in work tree since index
-[ MTARC]    D    deleted in work tree
-	    R    renamed in work tree
-	    C    copied in work tree
+[MTARC]          index and working tree matches
+[ MTARC]    M    working tree changed since index
+[ MTARC]    T    type changed in working tree since index
+[ MTARC]    D    deleted in working tree
+	    R    renamed in working tree
+	    C    copied in working tree
 -------------------------------------------------
 D           D    unmerged, both deleted
 A           U    unmerged, added by us
diff --git a/Documentation/git-submodule.adoc b/Documentation/git-submodule.adoc
index 95beaee561..bdba17d166 100644
--- a/Documentation/git-submodule.adoc
+++ b/Documentation/git-submodule.adoc
@@ -93,7 +93,7 @@ submodules, and show their status as well.
 If you are only interested in changes of the currently initialized
 submodules with respect to the commit recorded in the index or the HEAD,
 linkgit:git-status[1] and linkgit:git-diff[1] will provide that information
-too (and can also report changes to a submodule's work tree).
+too (and can also report changes to a submodule's working tree).
 
 init [--] [<path>...]::
 	Initialize the submodules recorded in the index (which were
diff --git a/Documentation/gitattributes.adoc b/Documentation/gitattributes.adoc
index f20041a323..39822c42ce 100644
--- a/Documentation/gitattributes.adoc
+++ b/Documentation/gitattributes.adoc
@@ -71,12 +71,12 @@ When deciding what attributes are assigned to a path, Git
 consults `$GIT_DIR/info/attributes` file (which has the highest
 precedence), `.gitattributes` file in the same directory as the
 path in question, and its parent directories up to the toplevel of the
-work tree (the further the directory that contains `.gitattributes`
+working tree (the further the directory that contains `.gitattributes`
 is from the path in question, the lower its precedence). Finally
 global and system-wide files are considered (they have the lowest
 precedence).
 
-When the `.gitattributes` file is missing from the work tree, the
+When the `.gitattributes` file is missing from the working tree, the
 path in the index is used as a fall-back.  During checkout process,
 `.gitattributes` in the index is used and then the file in the
 working tree is used as a fall-back.
@@ -286,18 +286,18 @@ the conversion is reversible for the current setting of
 `core.autocrlf`.  For "true", Git rejects irreversible
 conversions; for "warn", Git only prints a warning but accepts
 an irreversible conversion.  The safety triggers to prevent such
-a conversion done to the files in the work tree, but there are a
+a conversion done to the files in the working tree, but there are a
 few exceptions.  Even though...
 
-- 'git add' itself does not touch the files in the work tree, the
+- 'git add' itself does not touch the files in the working tree, the
   next checkout would, so the safety triggers;
 
 - 'git apply' to update a text file with a patch does touch the files
-  in the work tree, but the operation is about text files and CRLF
+  in the working tree, but the operation is about text files and CRLF
   conversion is about fixing the line ending inconsistencies, so the
   safety does not trigger;
 
-- 'git diff' itself does not touch the files in the work tree, it is
+- 'git diff' itself does not touch the files in the working tree, it is
   often run to inspect the changes you intend to next 'git add'.  To
   catch potential problems early, safety triggers.
 
@@ -1115,7 +1115,7 @@ text::
 
 binary::
 
-	Keep the version from your branch in the work tree, but
+	Keep the version from your branch in the working tree, but
 	leave the path in the conflicted state for the user to
 	sort out.
 
@@ -1180,7 +1180,7 @@ using `%S`, `%X` and `%Y` respectively.
 ^^^^^^^^^^^^^^^^^^^^^^
 
 This attribute controls the length of conflict markers left in
-the work tree file during a conflicted merge.  Only a positive
+the working tree file during a conflicted merge.  Only a positive
 integer has a meaningful effect.
 
 For example, this line in `.gitattributes` can be used to tell the merge
diff --git a/Documentation/gitcli.adoc b/Documentation/gitcli.adoc
index 6815d6bfb7..db88e84aaf 100644
--- a/Documentation/gitcli.adoc
+++ b/Documentation/gitcli.adoc
@@ -37,13 +37,13 @@ arguments.  Here are the rules:
    they can be disambiguated by placing `--` between them.
    E.g. `git diff -- HEAD` is, "I have a file called HEAD in my work
    tree.  Please show changes between the version I staged in the index
-   and what I have in the work tree for that file", not "show the difference
-   between the HEAD commit and the work tree as a whole".  You can say
+   and what I have in the working tree for that file", not "show the difference
+   between the HEAD commit and the working tree as a whole".  You can say
    `git diff HEAD --` to ask for the latter.
 
  * Without disambiguating `--`, Git makes a reasonable guess, but errors
    out and asks you to disambiguate when ambiguous.  E.g. if you have a
-   file called HEAD in your work tree, `git diff HEAD` is ambiguous, and
+   file called HEAD in your working tree, `git diff HEAD` is ambiguous, and
    you have to say either `git diff HEAD --` or `git diff -- HEAD` to
    disambiguate.
 
@@ -100,9 +100,9 @@ scripting Git:
    them do.
 
  * When you give a revision parameter to a command, make sure the parameter is
-   not ambiguous with a name of a file in the work tree.  E.g. do not write
+   not ambiguous with a name of a file in the working tree.  E.g. do not write
    `git log -1 HEAD` but write `git log -1 HEAD --`; the former will not work
-   if you happen to have a file called `HEAD` in the work tree.
+   if you happen to have a file called `HEAD` in the working tree.
 
  * Many commands allow a long option `--option` to be abbreviated
    only to their unique prefix (e.g. if there is no other option
diff --git a/Documentation/gitmodules.adoc b/Documentation/gitmodules.adoc
index d9bec8b187..464f24be9b 100644
--- a/Documentation/gitmodules.adoc
+++ b/Documentation/gitmodules.adoc
@@ -72,7 +72,7 @@ submodule.<name>.ignore::
 	    nonetheless show up in the output of status and commit when it has
 	    been staged).
 
-	dirty;; All changes to the submodule's work tree will be ignored, only
+	dirty;; All changes to the submodule's working tree will be ignored, only
 	    committed differences between the `HEAD` of the submodule and its
 	    recorded state in the superproject are taken into account.
 
diff --git a/Documentation/user-manual.adoc b/Documentation/user-manual.adoc
index 7696987117..4b0aaef6a4 100644
--- a/Documentation/user-manual.adoc
+++ b/Documentation/user-manual.adoc
@@ -1188,7 +1188,7 @@ branch.
 
 A merge is made by combining the changes made in `branchname` and the
 changes made up to the latest commit in your current branch since
-their histories forked. The work tree is overwritten by the result of
+their histories forked. The working tree is overwritten by the result of
 the merge when this combining is done cleanly, or overwritten by a
 half-merged results when this combining results in conflicts.
 Therefore, if you have uncommitted changes touching the same files as
@@ -1299,7 +1299,7 @@ $ git show :3:file.txt	# the version from MERGE_HEAD.
 -------------------------------------------------
 
 When you ask linkgit:git-diff[1] to show the conflicts, it runs a
-three-way diff between the conflicted merge results in the work tree with
+three-way diff between the conflicted merge results in the working tree with
 stages 2 and 3 to show only hunks whose contents come from both sides,
 mixed (in other words, when a hunk's merge results come only from stage 2,
 that part is not conflicting and is not shown.  Same for stage 3).
@@ -2149,7 +2149,7 @@ He uses two public branches:
 He also uses a set of temporary branches ("topic branches"), each
 containing a logical grouping of patches.
 
-To set this up, first create your work tree by cloning Linus's public
+To set this up, first create your working tree by cloning Linus's public
 tree:
 
 -------------------------------------------------
@@ -3667,7 +3667,7 @@ files in a submodule, which silently leads to similar problems as not pushing
 the submodule changes. Starting with Git 1.7.0 both `git status` and `git diff`
 in the superproject show submodules as modified when they contain new or
 modified files to protect against accidentally committing such a state. `git
-diff` will also add a `-dirty` to the work tree side when generating patch
+diff` will also add a `-dirty` to the working tree side when generating patch
 output or used with the `--submodule` option:
 
 -------------------------------------------------
-- 
2.52.0-rc1-455-g30608eb744

