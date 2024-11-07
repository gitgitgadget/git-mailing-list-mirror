Received: from fout-b2-smtp.messagingengine.com (fout-b2-smtp.messagingengine.com [202.12.124.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E005629CE8
	for <git@vger.kernel.org>; Thu,  7 Nov 2024 12:00:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730980832; cv=none; b=ajSNGTsPjeKYsa7RU1WaRnBDrXbGj9XTXSRaXSbzyBAYyEeSnWNxkwNdG13d44hPoGB2ksKAdFK4dhbKbnfZkWsI6Fn+fIV2nuzvbCTMws7f29Fugag5eKLgI3e8IGYjEXaP+nLi8/3zqZSEiQUYpmFYni4F7YQXM4XXjaWFfMw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730980832; c=relaxed/simple;
	bh=YwNFVLeALH5r59rpqY/qcYndEEYatczzVljAF1GD5/k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GiqpkoX0BbGsNnO06uP8+ocivcru32fDILB5EGUZ6W4MpZXA9tWiTNgh+DMXdiB8xPp6ukTBIrde9nxkUB6lUQp2tEdVevGJGTZyaeQIfhY9czKpE8phuA8nsGZZjLSW7ZYuI3XbBwAlBR0eCVWt0cs5yTgjRJY5HF9X7FVGyT4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=pAo5s1Bk; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=UMm9bFtD; arc=none smtp.client-ip=202.12.124.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="pAo5s1Bk";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="UMm9bFtD"
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfout.stl.internal (Postfix) with ESMTP id C58971140139;
	Thu,  7 Nov 2024 07:00:27 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Thu, 07 Nov 2024 07:00:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1730980827;
	 x=1731067227; bh=RnecmNqvzuDceSh/EyI6mCXF4vrzynSDXdR2e1RavB8=; b=
	pAo5s1BkMLLkjy55w6VJiNfTdjZo3lVUlzRzihvNQ4/VeOYWdZppRRkMsK58FlHM
	iFVcQdOh4TP9VSHlRV95LBxZzhitmjqS2/pLMel4mfDDqafHHDaKuOTFZE4/lXyE
	rFRXTLWjzEa00ZNlAmrpf8SWEIao45MGe9g/L2yUcKvx3S07rf5hyfvjpZ1F23Tm
	77zAQ+sLzXtp7em46Rainxz6LJAoGpoukXWD031qV8uWzcI6BtziYeOvQF/twQMV
	P318DbKmVW9T6Ii+pSB5WV5jftWkSeAtuYFWVDqfgcqsq8p610oL7v8ggU5UE1GN
	xEfVdwkyoxlqBY3mGQQEAQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1730980827; x=
	1731067227; bh=RnecmNqvzuDceSh/EyI6mCXF4vrzynSDXdR2e1RavB8=; b=U
	Mm9bFtDGGtDOErSawDdRpHKM0XaOeF3YmDNnyDphxKCf9bTumoo/HkLhwppmRGFz
	J2DBpsMzpSRC2dbePdN48dKrRB5hRpL1wXrKMteJ9IyOUHrW7fnmtVwu/t5+awbu
	CMyN07gQpfhmrNW6ZT124HancVCjFPeHkjbCQBibcvR3HHxLra7aK1AhHTKP5u4f
	WVg9WnT9UzJHV9nVKu4TUGA2tFwwux1ZwLIu5s1ELnIf7uFhrv5qEB8RdKDQog30
	pdiE0wl2kKxZcqqutF+WaqGce3e3DURxn7OZXBxenQfKogPKFXBLdmq9ltVbB7eP
	sNH0zcJduYc3zkVqgnlvw==
X-ME-Sender: <xms:26ssZ8zVyfftIlzsYN9WntEFiXPi2qO7q19ndFhv0oEx3uOnDS8aPKg>
    <xme:26ssZwRsCx9XAwn_qhggkrL8AUoSenN5axyh0BCshBDQEYj7Q8pkmemHzZ60oXWHf
    7u_lNOers8zUqoDkA>
X-ME-Received: <xmr:26ssZ-Xt-H2W4CKI1wMrAZnROKQA0LohRUd70tU4Jj6qGUV2yoZVsHR-UToRWjEwWKS0XPGwaJZsGpKLNtObrg3H59mPMqbRSVLvwUKYnFZBCQBN_Tp1d9pHqQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrtdeggdefgecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecunecujfgurhephffvvefuff
    fkofgjfhggtgfgsehtkeertdertdejnecuhfhrohhmpehkrhhishhtohhffhgvrhhhrghu
    ghhssggrkhhksehfrghsthhmrghilhdrtghomhenucggtffrrghtthgvrhhnpefhhfevud
    dtledtleevudehvdfhfeeujeehveefgeekueevieeftefggefgkedthfenucffohhmrghi
    nhepshhtrggtkhhovhgvrhhflhhofidrtghomhdptggrnhgrlhhsohhophgvrhgrthgvoh
    hnsghunhgulhgvfhhilhgvshdrihhtpdhkvghrnhgvlhdrohhrghenucevlhhushhtvghr
    ufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehkrhhishhtohhffhgvrhhhrg
    hughhssggrkhhksehfrghsthhmrghilhdrtghomhdpnhgspghrtghpthhtohephedpmhho
    uggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdroh
    hrghdprhgtphhtthhopegtohguvgeskhhhrghughhssggrkhhkrdhnrghmvgdprhgtphht
    thhopegrvhgrrhgrsgesghhmrghilhdrtghomhdprhgtphhtthhopehmvgesthhtrgihlh
    horhhrrdgtohhmpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:26ssZ6h0uHIcV3HIgEiWozOt0010INBCoj4Qm7-V9RD7SMNCbuDp3A>
    <xmx:26ssZ-BffAh2ltefSSFjO0XCg_X_WLD1eLO5jZrvLXhiVBC0EUtcbg>
    <xmx:26ssZ7Kufn64CAgk_oaAcm4gVXc6DiacrORNKg8aXrMuSo2zT1OYSw>
    <xmx:26ssZ1DfmYdWfk2h8guzEcNR_tXeAhJtuF3g4Hg1DhD4gPgCyCRiow>
    <xmx:26ssZ15FbhLhny-RzC4qKg1VCVuUphWuCzys2N_Hj0yyJiLWuYKVf6gr>
Feedback-ID: i8b11424c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 7 Nov 2024 07:00:26 -0500 (EST)
From: kristofferhaugsbakk@fastmail.com
To: git@vger.kernel.org
Cc: Kristoffer Haugsbakk <code@khaugsbakk.name>,
	avarab@gmail.com,
	me@ttaylorr.com,
	gitster@pobox.com
Subject: [PATCH v3 0/4] Documentation/git-bundle.txt: promote --all for full backup
Date: Thu,  7 Nov 2024 12:57:32 +0100
Message-ID: <cover.1730979849.git.code@khaugsbakk.name>
X-Mailer: git-send-email 2.46.1.641.g54e7913fcb6
In-Reply-To: <cover.1730234365.git.code@khaugsbakk.name>
References: <cover.1730234365.git.code@khaugsbakk.name>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Commit-Hash: 0ab05a4cf09ba02016b4493936ad1b092b1326aa
X-Previous-Commits: c50f9d405f9043a03cb5ca1855fbf27f9423c759 63a431537b78e2d84a172b5c837adba6184a1f1b
Content-Transfer-Encoding: 8bit

From: Kristoffer Haugsbakk <code@khaugsbakk.name>

The documentation for git-bundle(1) now prominently covers `--all`, the
option from git-rev-list(1) that can be used to package all refs.  A
"Discussion" section has also been added to address the naive backup
strategy of copying a Git repository manually with cp(1) or some other
non-Git tool.

---

The part above was for the-topic-summary.

I was prompted by SO questions like this one:

    https://stackoverflow.com/questions/5578270/fully-backup-a-git-repo

I then compared VonC’s answer to the man page.

Cheers

§ Changes in v3

After some feedback from Junio I’ve added a disclaimer about what this
“full backup” does not cover, like e.g. repo config.  And since this
requires some introduction and overall space (paragraphs), I’ve moved it
into the Examples section.  To structure this now two-example section it
now starts with a list of what examples are coming up.  The second
example is marked by “For the next example”.

I’ve also noted what the “full backup” does not cover in the Discussion
section.

The details are noted on the patches.

Kristoffer Haugsbakk (4):
  Documentation/git-bundle.txt: mention full backup example
  Documentation/git-bundle.txt: remove old `--all` example
  Documentation/git-bundle.txt: mention --all in spec. refs
  Documentation/git-bundle.txt: discuss naïve backups

 Documentation/git-bundle.txt | 52 +++++++++++++++++++++++++++++-------
 1 file changed, 43 insertions(+), 9 deletions(-)

Interdiff against v2:
diff --git a/Documentation/git-bundle.txt b/Documentation/git-bundle.txt
index 7bffd2e4a05..ad9ab3247f5 100644
--- a/Documentation/git-bundle.txt
+++ b/Documentation/git-bundle.txt
@@ -23,8 +23,9 @@ the "offline" transfer of Git objects without an active "server"
 sitting on the other side of the network connection.
 
 They can be used to create both incremental and full backups of a
-repository (`git bundle create <file> --all`), and to relay the state of
-the references in one repository to another.
+repository (see the "full backup" example in "EXAMPLES"), and to relay
+the state of the references in one repository to another (see the second
+example).
 
 Git commands that fetch or otherwise "read" via protocols such as
 `ssh://` and `https://` can also operate on bundle files. It is
@@ -34,8 +35,6 @@ contained within it with linkgit:git-ls-remote[1]. There's no
 corresponding "write" support, i.e.a 'git push' into a bundle is not
 supported.
 
-See the "EXAMPLES" section below for examples of how to use bundles.
-
 BUNDLE FORMAT
 -------------
 
@@ -214,8 +213,27 @@ bundle.
 EXAMPLES
 --------
 
-Assume you want to transfer the history from a repository R1 on machine A
-to another repository R2 on machine B.
+We'll discuss two cases:
+
+1. Taking a full backup of a repository
+2. Transfer the history of a repository to another machine when the two
+   machines have no direct connection
+
+First let's consider a full backup of the repository.  The following
+command will take a full backup of the repository in the sense that all
+refs are included in the bundle (except `refs/stash`, i.e. the stash):
+
+----------------
+$ git bundle create <file> --all
+----------------
+
+But note again that this is only for the refs, i.e. you will only
+include refs and commits reachable from those refs.  You will not
+include other local state, such as the contents of the index, working
+tree, per-repository configuration, hooks, etc.
+
+For the next example, assume you want to transfer the history from a
+repository R1 on machine A to another repository R2 on machine B.
 For whatever reason, direct connection between A and B is not allowed,
 but we can move data from A to B via some mechanism (CD, email, etc.).
 We want to update R2 with development made on the branch master in R1.
@@ -323,12 +341,16 @@ DISCUSSION
 ----------
 
 A naive way to make a full backup of a repository is to use something to
-the effect of `cp -a <repo> <destination>`.  This is discouraged since
+the effect of `cp -r <repo> <destination>`.  This is discouraged since
 the repository could be written to during the copy operation.  In turn
 some files at `<destination>` could be corrupted.
 
 This is why it is recommended to use Git tooling for making repository
 backups, either with this command or with e.g. linkgit:git-clone[1].
+But keep in mind that these tools will not help you backup state other
+than refs and commits.  In other words they will not help you backup
+contents of the index, working tree, per-repository configuration,
+hooks, etc.
 
 See also linkgit:gitfaq[7], section "TRANSFERS" for a discussion of the
 problems associated with file syncing across systems.
Range-diff against v2:
1:  e9be866f33d ! 1:  b222c6787a7 Documentation/git-bundle.txt: mention full backup example
    @@ Metadata
      ## Commit message ##
         Documentation/git-bundle.txt: mention full backup example
     
    -    Tell the user how to make a full backup of the repository right at the
    -    start of the doc.
    +    Provide an example about how to make a “full backup” with caveats about
    +    what that means in this case.
     
         This is a requested use-case.[1]  But the doc is a bit unassuming
         about it:
     
    -      “ If you want to match `git clone --mirror`, which would include your
    +        If you want to match `git clone --mirror`, which would include your
             refs such as `refs/remotes/*`, use `--all`.
     
         The user cannot be expected to formulate “I want a full backup” as “I
    @@ Commit message
             • https://stackoverflow.com/questions/5578270/fully-backup-a-git-repo
             • https://stackoverflow.com/questions/11792671/how-to-git-bundle-a-complete-repo
     
    +    Helped-by: Junio C Hamano <gitster@pobox.com>
         Signed-off-by: Kristoffer Haugsbakk <code@khaugsbakk.name>
     
     
      ## Notes (series) ##
    +    v3:
    +    • Elaborate on “full backups” in Examples instead
    +    • Just point to the section in the second paragraph where everything is
    +      elaborated
    +    • Incorporate some of Junio’s suggestions:
    +      • Mention what the “full backup” here does not include
    +
    +        Link: https://lore.kernel.org/git/xmqqh68q1l37.fsf@gitster.g/
    +        Link: https://lore.kernel.org/git/xmqqzfmiza69.fsf@gitster.g/#t
    +    • Remove the final paragraph pointing to Examples now that we mention it
    +      in the second paragraph
         v2:
         • Mention as a parenthetical on an existing paragraph (don’t create a
           new sentence and paragraph)
    @@ Notes (series)
     
           Link (both): https://lore.kernel.org/git/ZxbIWEGS1UB3UIg+@nand.local/
     
    +
    + ## Notes (meta-trailers) ##
    +    Helped-by: Junio C Hamano <gitster@pobox.com>
    +        Link: https://lore.kernel.org/git/xmqqzfmiza69.fsf@gitster.g/
    +
      ## Documentation/git-bundle.txt ##
     @@ Documentation/git-bundle.txt: the "offline" transfer of Git objects without an active "server"
      sitting on the other side of the network connection.
    @@ Documentation/git-bundle.txt: the "offline" transfer of Git objects without an a
      They can be used to create both incremental and full backups of a
     -repository, and to relay the state of the references in one repository
     -to another.
    -+repository (`git bundle create <file> --all`), and to relay the state of
    -+the references in one repository to another.
    ++repository (see the "full backup" example in "EXAMPLES"), and to relay
    ++the state of the references in one repository to another (see the second
    ++example).
      
      Git commands that fetch or otherwise "read" via protocols such as
      `ssh://` and `https://` can also operate on bundle files. It is
    -@@ Documentation/git-bundle.txt: It is okay to err on the side of caution, causing the bundle file
    - to contain objects already in the destination, as these are ignored
    - when unpacking at the destination.
    +@@ Documentation/git-bundle.txt: contained within it with linkgit:git-ls-remote[1]. There's no
    + corresponding "write" support, i.e.a 'git push' into a bundle is not
    + supported.
    + 
    +-See the "EXAMPLES" section below for examples of how to use bundles.
    +-
    + BUNDLE FORMAT
    + -------------
    + 
    +@@ Documentation/git-bundle.txt: bundle.
    + EXAMPLES
    + --------
      
    --If you want to match `git clone --mirror`, which would include your
    --refs such as `refs/remotes/*`, use `--all`.
    - If you want to provide the same set of refs that a clone directly
    - from the source repository would get, use `--branches --tags` for
    - the `<git-rev-list-args>`.
    +-Assume you want to transfer the history from a repository R1 on machine A
    +-to another repository R2 on machine B.
    ++We'll discuss two cases:
    ++
    ++1. Taking a full backup of a repository
    ++2. Transfer the history of a repository to another machine when the two
    ++   machines have no direct connection
    ++
    ++First let's consider a full backup of the repository.  The following
    ++command will take a full backup of the repository in the sense that all
    ++refs are included in the bundle (except `refs/stash`, i.e. the stash):
    ++
    ++----------------
    ++$ git bundle create <file> --all
    ++----------------
    ++
    ++But note again that this is only for the refs, i.e. you will only
    ++include refs and commits reachable from those refs.  You will not
    ++include other local state, such as the contents of the index, working
    ++tree, per-repository configuration, hooks, etc.
    ++
    ++For the next example, assume you want to transfer the history from a
    ++repository R1 on machine A to another repository R2 on machine B.
    + For whatever reason, direct connection between A and B is not allowed,
    + but we can move data from A to B via some mechanism (CD, email, etc.).
    + We want to update R2 with development made on the branch master in R1.
-:  ----------- > 2:  f0dbe356ca6 Documentation/git-bundle.txt: remove old `--all` example
2:  f18f8ca453d = 3:  8336b0f451e Documentation/git-bundle.txt: mention --all in spec. refs
3:  c50f9d405f9 ! 4:  0ab05a4cf09 Documentation/git-bundle.txt: discuss naïve backups
    @@ Commit message
     
     
      ## Notes (series) ##
    +    v3:
    +    • Use `cp -r` instead of `cp -a` since the former is more widely
    +      supported (even though it is just an example)
    +    • Mention what this “full backup” does not cover here as well (see first
    +      patch)
         v2:
         • Fix gitfaq(7) link
     
    @@ Documentation/git-bundle.txt: You can also see what references it offers:
     +----------
     +
     +A naive way to make a full backup of a repository is to use something to
    -+the effect of `cp -a <repo> <destination>`.  This is discouraged since
    ++the effect of `cp -r <repo> <destination>`.  This is discouraged since
     +the repository could be written to during the copy operation.  In turn
     +some files at `<destination>` could be corrupted.
     +
     +This is why it is recommended to use Git tooling for making repository
     +backups, either with this command or with e.g. linkgit:git-clone[1].
    ++But keep in mind that these tools will not help you backup state other
    ++than refs and commits.  In other words they will not help you backup
    ++contents of the index, working tree, per-repository configuration,
    ++hooks, etc.
     +
     +See also linkgit:gitfaq[7], section "TRANSFERS" for a discussion of the
     +problems associated with file syncing across systems.

base-commit: 34b6ce9b30747131b6e781ff718a45328aa887d0
-- 
2.46.1.641.g54e7913fcb6

