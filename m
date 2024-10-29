Received: from fout-a6-smtp.messagingengine.com (fout-a6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69AF319A2A2
	for <git@vger.kernel.org>; Tue, 29 Oct 2024 20:41:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730234517; cv=none; b=N59gSOHSmJks4q3a0L9saMcV/ppCuumenH0q6Mvnj1+xJdubD32y7mQSJT8uT9RNCzxJmj9ZxUdXayVmdFakAMxi1QvGP9VTMZ4Qg3XCRw6n2CaE7F1UzS9oiSLhZFOKJBr0gZy+F1F/WyL+T6+03M6V4+OGU2o2oP7ibchfO9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730234517; c=relaxed/simple;
	bh=iXIvFRpORUSBlUDkQEEeblo9SGL6/GUWz7VSKVBisCY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=L9fOWSxjxKy+uwx0ts+Zu+tlvtlxwyECx6UuGQDbJX+TIs/ia44HtONmLTteDGAau5t2dSSGcDVU5+Cl25VjytKd1tIiidGKfENuY5u4sDDsUxNi03+6jwA4Hq6NL+h/zUIs5QVe3nH1grX5vlKbaxBESxxfsxWR7amX+rzYWgc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=AAPiQv+K; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Rx/y+ic+; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="AAPiQv+K";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Rx/y+ic+"
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfout.phl.internal (Postfix) with ESMTP id 7A669138010C;
	Tue, 29 Oct 2024 16:41:53 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Tue, 29 Oct 2024 16:41:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1730234513;
	 x=1730320913; bh=DwCIzxCZm/0U8AzIVam3HzwtwGnJ+NhCne3p7urIlWc=; b=
	AAPiQv+KT4CKgeRQnOYhcDGXex8TJI/AN8hlmxwtSv6ODg200EgGK60iy3sAQzsQ
	NpGdY7E4T2na5vqFROFyzDKwtkEeRFIs+mxibti5j6ipgWQ1IiSGXYvsuj1XT5lX
	h6GmAX38IT+ulLZlx2s8rkQXgipMndqkUXQMyLsjse2Bs5HneRZVCk5oOKleJuJ1
	etKldxnT1U0ir10SfsLSGaAgXHINqJgFE4pCCch/2qFMOUA+q3qRmWgHtf/l4/jh
	0q85CRo4Mbug0fz6u3IcESpv7a65Yq+ebWvP9gSJ1V+MpwDXOT4yJEtGhXrZhexJ
	mhMYw6rLVkxPN0r/JCZSyA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1730234513; x=
	1730320913; bh=DwCIzxCZm/0U8AzIVam3HzwtwGnJ+NhCne3p7urIlWc=; b=R
	x/y+ic+qWiA/+4+JRTwcgROYuhU7//mWY6aN58EftgTmYiFLm2JvXsTBLX/ftIV1
	L/NJu3i+GALAeuyU3Qd6RkxpJOypz+9m9JVBWyvSYNKP9Pvi80+/iWV3ivdD/XbF
	FcbQtHBy5S5G95AJQdu+d4y7FryIy4dtjYPvfCmk6bskj1CC4HO0dm/7OxgBFgiU
	vLvNqgc/J/GxTXp9APf1JzdAa3htJW1rBzZKsau5lWOrl7FBgJd4dURf3ZS0pJbt
	NWpFRyT293ovKylD+qbAdXnVeU+jp2Wi8SJWEIe9JlTtKNrLxQk2XOSLfr0ixYUx
	Bk5aBggW1R/xwbYP90VXw==
X-ME-Sender: <xms:kUghZ-exaN-F_PMhVKPji3NXP4BroXYW5OhfrkETvGhBuHkynI-j-wc>
    <xme:kUghZ4NlU8oLKfPbj-GgPt46KWghL1E7zi1q-kbG3mKKl1S3SDZyJ8nsXTb7tBQHv
    LA6h5yAAUcO-UW2hQ>
X-ME-Received: <xmr:kUghZ_hC2jhujHJbjU3wUK5okQoDwaxf0xFzgT0acut4fNQvyAe40WuBwnMe7oQU2c-IzTM8wZv5xN27554kLvzte2LYiEvKWwa1Z1uOW2LayFzNJsWBMu_81w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdekuddgudefhecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecunecujfgurhephffvve
    fufffkofgjfhggtgfgsehtkeertdertdejnecuhfhrohhmpehkrhhishhtohhffhgvrhhh
    rghughhssggrkhhksehfrghsthhmrghilhdrtghomhenucggtffrrghtthgvrhhnpefhhf
    evuddtledtleevudehvdfhfeeujeehveefgeekueevieeftefggefgkedthfenucffohhm
    rghinhepshhtrggtkhhovhgvrhhflhhofidrtghomhdptggrnhgrlhhsohhophgvrhgrth
    gvohhnsghunhgulhgvfhhilhgvshdrihhtpdhkvghrnhgvlhdrohhrghenucevlhhushht
    vghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehkrhhishhtohhffhgvrh
    hhrghughhssggrkhhksehfrghsthhmrghilhdrtghomhdpnhgspghrtghpthhtohepgedp
    mhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlh
    drohhrghdprhgtphhtthhopegtohguvgeskhhhrghughhssggrkhhkrdhnrghmvgdprhgt
    phhtthhopegrvhgrrhgrsgesghhmrghilhdrtghomhdprhgtphhtthhopehmvgesthhtrg
    ihlhhorhhrrdgtohhm
X-ME-Proxy: <xmx:kUghZ7-_nF6e3y3Zbjx4BPVpr7QQLAPxxYMg3CCOmC_GbNuETBRe-Q>
    <xmx:kUghZ6sCW7-aUOUxXVn38juJU_QoUNViYk71nZm2PTo-ugcfM9-r8g>
    <xmx:kUghZyFhsH5Ojym6J9E519JnnCbVfwD-OAs1pdFwHP-SgYdNwV_D6g>
    <xmx:kUghZ5OSZgM1h2EW6jRu3i_Xq_8_p2rmt-rmVYMsTKf6GW_f4P7zQA>
    <xmx:kUghZ8LAcva5AwKI6tbxurvqbHTPO_iA22aoIjE7Wf7GOwPCaRoeFWZK>
Feedback-ID: i8b11424c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 29 Oct 2024 16:41:51 -0400 (EDT)
From: kristofferhaugsbakk@fastmail.com
To: git@vger.kernel.org
Cc: Kristoffer Haugsbakk <code@khaugsbakk.name>,
	avarab@gmail.com,
	me@ttaylorr.com
Subject: [PATCH v2 0/3] Documentation/git-bundle.txt: promote --all for full backup
Date: Tue, 29 Oct 2024 21:41:43 +0100
Message-ID: <cover.1730234365.git.code@khaugsbakk.name>
X-Mailer: git-send-email 2.46.1.641.g54e7913fcb6
In-Reply-To: <cover.1729451376.git.code@khaugsbakk.name>
References: <cover.1729451376.git.code@khaugsbakk.name>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Commit-Hash: c50f9d405f9043a03cb5ca1855fbf27f9423c759
X-Previous-Commits: 63a431537b78e2d84a172b5c837adba6184a1f1b
Content-Transfer-Encoding: 8bit

From: Kristoffer Haugsbakk <code@khaugsbakk.name>

The documentation for git-bundle(1) now properly covers `--all`, the
option from git-rev-list(1) that can be used to package all refs.  A
"Discussions" section has also been added to address the naive backup
strategy of copying a Git repository manually with cp(1) or some other
non-Git tool.

---

The part above was for the-topic-summary.

I was prompted by SO questions like this one:

    https://stackoverflow.com/questions/5578270/fully-backup-a-git-repo

I then compared VonC’s answer to the man page.  The first thing I
noticed was that `--all` wasn’t in the synopsis.

+Cc is just `./contrib/contacts/git-contacts` minus Junio.  (Although he
is inactive (from v1); keeping Cc on the series since it is customary)

Cheers

§ Changes in v2

• Patch v1 1/4: drop
• Patch v2 1/3: combine with previous paragraph and drop “mirror”
  sentence
• Patch v2 3/3: fix `make lint-docs` failure

Kristoffer Haugsbakk (3):
  Documentation/git-bundle.txt: mention full backup example
  Documentation/git-bundle.txt: mention --all in spec. refs
  Documentation/git-bundle.txt: discuss naïve backups

 Documentation/git-bundle.txt | 22 +++++++++++++++++-----
 1 file changed, 17 insertions(+), 5 deletions(-)

Interdiff against v1:
diff --git a/Documentation/git-bundle.txt b/Documentation/git-bundle.txt
index b5cc4746b45..7bffd2e4a05 100644
--- a/Documentation/git-bundle.txt
+++ b/Documentation/git-bundle.txt
@@ -10,7 +10,7 @@ SYNOPSIS
 --------
 [verse]
 'git bundle' create [-q | --quiet | --progress]
-		    [--version=<version>] <file> (<git-rev-list-args> | --all)
+		    [--version=<version>] <file> <git-rev-list-args>
 'git bundle' verify [-q | --quiet] <file>
 'git bundle' list-heads <file> [<refname>...]
 'git bundle' unbundle [--progress] <file> [<refname>...]
@@ -23,11 +23,8 @@ the "offline" transfer of Git objects without an active "server"
 sitting on the other side of the network connection.
 
 They can be used to create both incremental and full backups of a
-repository, and to relay the state of the references in one repository
-to another.
-
-You can use `git bundle create <file> --all` to create a full backup of
-your repository.
+repository (`git bundle create <file> --all`), and to relay the state of
+the references in one repository to another.
 
 Git commands that fetch or otherwise "read" via protocols such as
 `ssh://` and `https://` can also operate on bundle files. It is
@@ -206,8 +203,6 @@ It is okay to err on the side of caution, causing the bundle file
 to contain objects already in the destination, as these are ignored
 when unpacking at the destination.
 
-If you want to match `git clone --mirror`, which would include your
-refs such as `refs/remotes/*`, use `--all`.
 If you want to provide the same set of refs that a clone directly
 from the source repository would get, use `--branches --tags` for
 the `<git-rev-list-args>`.
@@ -335,7 +330,7 @@ some files at `<destination>` could be corrupted.
 This is why it is recommended to use Git tooling for making repository
 backups, either with this command or with e.g. linkgit:git-clone[1].
 
-See also linkgit:gitfaq[1], section "TRANSFERS" for a discussion of the
+See also linkgit:gitfaq[7], section "TRANSFERS" for a discussion of the
 problems associated with file syncing across systems.
 
 FILE FORMAT
diff --git a/builtin/bundle.c b/builtin/bundle.c
index 6d610253575..127518c2a8d 100644
--- a/builtin/bundle.c
+++ b/builtin/bundle.c
@@ -17,7 +17,7 @@
 
 #define BUILTIN_BUNDLE_CREATE_USAGE \
 	N_("git bundle create [-q | --quiet | --progress]\n" \
-	   "                  [--version=<version>] <file> (<git-rev-list-args> | --all)")
+	   "                  [--version=<version>] <file> <git-rev-list-args>")
 #define BUILTIN_BUNDLE_VERIFY_USAGE \
 	N_("git bundle verify [-q | --quiet] <file>")
 #define BUILTIN_BUNDLE_LIST_HEADS_USAGE \
Range-diff against v1:
1:  39bdc5941c7 ! 1:  e9be866f33d Documentation/git-bundle.txt: mention --all in Synopsis
    @@ Metadata
     Author: Kristoffer Haugsbakk <code@khaugsbakk.name>
     
      ## Commit message ##
    -    Documentation/git-bundle.txt: mention --all in Synopsis
    +    Documentation/git-bundle.txt: mention full backup example
     
    -    `--all` is convenient for bundling all refs.  But it is only mentioned
    -    once, halfway through the doc, under the demure section “Object
    -    prerequisites”.  It deserves to be mentioned as an alternative to
    -    `<git-rev-list-args>`.
    +    Tell the user how to make a full backup of the repository right at the
    +    start of the doc.
    +
    +    This is a requested use-case.[1]  But the doc is a bit unassuming
    +    about it:
    +
    +      “ If you want to match `git clone --mirror`, which would include your
    +        refs such as `refs/remotes/*`, use `--all`.
    +
    +    The user cannot be expected to formulate “I want a full backup” as “I
    +    want to match `git clone --mirror`” for a bundle file or something.
    +    Let’s drop this mention of `--all` later in the doc and frontload it.
    +
    +    † 1: E.g.:
    +
    +        • https://stackoverflow.com/questions/5578270/fully-backup-a-git-repo
    +        • https://stackoverflow.com/questions/11792671/how-to-git-bundle-a-complete-repo
     
         Signed-off-by: Kristoffer Haugsbakk <code@khaugsbakk.name>
     
     
      ## Notes (series) ##
    -    Long line in bundle.c now?
    +    v2:
    +    • Mention as a parenthetical on an existing paragraph (don’t create a
    +      new sentence and paragraph)
    +    • Remove the “mirror” mention
    +
    +      Link (both): https://lore.kernel.org/git/ZxbIWEGS1UB3UIg+@nand.local/
     
      ## Documentation/git-bundle.txt ##
    -@@ Documentation/git-bundle.txt: SYNOPSIS
    - --------
    - [verse]
    - 'git bundle' create [-q | --quiet | --progress]
    --		    [--version=<version>] <file> <git-rev-list-args>
    -+		    [--version=<version>] <file> (<git-rev-list-args> | --all)
    - 'git bundle' verify [-q | --quiet] <file>
    - 'git bundle' list-heads <file> [<refname>...]
    - 'git bundle' unbundle [--progress] <file> [<refname>...]
    -
    - ## builtin/bundle.c ##
    -@@
    +@@ Documentation/git-bundle.txt: the "offline" transfer of Git objects without an active "server"
    + sitting on the other side of the network connection.
    + 
    + They can be used to create both incremental and full backups of a
    +-repository, and to relay the state of the references in one repository
    +-to another.
    ++repository (`git bundle create <file> --all`), and to relay the state of
    ++the references in one repository to another.
    + 
    + Git commands that fetch or otherwise "read" via protocols such as
    + `ssh://` and `https://` can also operate on bundle files. It is
    +@@ Documentation/git-bundle.txt: It is okay to err on the side of caution, causing the bundle file
    + to contain objects already in the destination, as these are ignored
    + when unpacking at the destination.
      
    - #define BUILTIN_BUNDLE_CREATE_USAGE \
    - 	N_("git bundle create [-q | --quiet | --progress]\n" \
    --	   "                  [--version=<version>] <file> <git-rev-list-args>")
    -+	   "                  [--version=<version>] <file> (<git-rev-list-args> | --all)")
    - #define BUILTIN_BUNDLE_VERIFY_USAGE \
    - 	N_("git bundle verify [-q | --quiet] <file>")
    - #define BUILTIN_BUNDLE_LIST_HEADS_USAGE \
    +-If you want to match `git clone --mirror`, which would include your
    +-refs such as `refs/remotes/*`, use `--all`.
    + If you want to provide the same set of refs that a clone directly
    + from the source repository would get, use `--branches --tags` for
    + the `<git-rev-list-args>`.
2:  f7d9aa89c95 < -:  ----------- Documentation/git-bundle.txt: mention full backup example
3:  33980a47d13 = 2:  f18f8ca453d Documentation/git-bundle.txt: mention --all in spec. refs
4:  63a431537b7 ! 3:  c50f9d405f9 Documentation/git-bundle.txt: discuss naïve backups
    @@ Commit message
     
     
      ## Notes (series) ##
    +    v2:
    +    • Fix gitfaq(7) link
    +
    +      Link: https://lore.kernel.org/git/ZxfhAAgNlbEq60VB@nand.local/#t
    +    v1:
         Correct mention of the section?  All-caps seems to be the convention.
     
      ## Documentation/git-bundle.txt ##
    @@ Documentation/git-bundle.txt: You can also see what references it offers:
     +This is why it is recommended to use Git tooling for making repository
     +backups, either with this command or with e.g. linkgit:git-clone[1].
     +
    -+See also linkgit:gitfaq[1], section "TRANSFERS" for a discussion of the
    ++See also linkgit:gitfaq[7], section "TRANSFERS" for a discussion of the
     +problems associated with file syncing across systems.
     +
      FILE FORMAT

base-commit: 34b6ce9b30747131b6e781ff718a45328aa887d0
-- 
2.46.1.641.g54e7913fcb6

