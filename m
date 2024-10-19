Received: from fout-b7-smtp.messagingengine.com (fout-b7-smtp.messagingengine.com [202.12.124.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AA5A18D625
	for <git@vger.kernel.org>; Sat, 19 Oct 2024 20:00:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729368014; cv=none; b=pJMFWJLSTXI1vql8pYOAyiQlS5o+KBzrvZNMUSKXlgsYA/sTmsk/oO8mtCqy2RTBkGmP6yX/jdKTZfRGMMa3XKCbKwsIakxuuELaGUTobLJHbf4e0pOyazVFk4qJAkNNUGw8JaG7PR51OjefyHaL7JQQwxiBGlf22ZfLsLPa8sw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729368014; c=relaxed/simple;
	bh=U0CJtzbyXf3vYCgbTJunZITes+tBhoJs0QYiIdpTgpo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dB5vt29J372NOMKrhs0ph8sPdbogysyEoi76vC42EL14oqktddImaLB7Vc9SaoDl58rizD65PVgtaCaywHsvAOHWCLvqRklOk2LTPfUY/d9fz8c0xSIqgbaiRQ7aNuUuRcDrBQbOAELNXmyMV/h3Pnv5+kuLYPcjSdoaTpMRBm0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=nY/c69/c; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=o/x1ljjT; arc=none smtp.client-ip=202.12.124.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="nY/c69/c";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="o/x1ljjT"
Received: from phl-compute-10.internal (phl-compute-10.phl.internal [10.202.2.50])
	by mailfout.stl.internal (Postfix) with ESMTP id 43C131140095;
	Sat, 19 Oct 2024 16:00:10 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-10.internal (MEProxy); Sat, 19 Oct 2024 16:00:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1729368010;
	 x=1729454410; bh=0ywGyW6NFmM6mXv16d8pyB7lOImrqh4DnpUdvsSyyr0=; b=
	nY/c69/ccrN2vPoKHERBw2ROcF/h/dBpvxyItJcuSX/ev7JZ2zym0CI6/qHdYjEO
	Al3At61LSHu91KMzDUAlbFIPeRLxdlvyEv0YLaMy9J4g5G3H5GOkTNN40MA31Vc/
	64CpZXF5MjHbcVAV1W6AdKJcytmzSfk5PukN4FbjdrMQH8g5KVluazLjimHqbI/A
	6wnulkpUTuikuP4LaR6GjjfD29mwzTvP4CjJmMNOtMrbShDTvm1TWWFjYj2gcAgM
	lE0heMWQgBs5K8JdwtpK8CDuunG9g7cQWAbuQw5kuhI/Dm09x1S0FUunGnTFC1cK
	U78R70b0J8dMe8zW5m/oOw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1729368010; x=
	1729454410; bh=0ywGyW6NFmM6mXv16d8pyB7lOImrqh4DnpUdvsSyyr0=; b=o
	/x1ljjTKJ/gmkdcB+xJQskcAwIB6Wmf94acWKhPVHrq40YK5uSoISDpSMY0kRyVs
	lvOOBT5WZTDi0f/8TE0Ccd7RU5/BdoQBuwiwQhK3jwkMTxEnhmCMMQrkbhWd1qb0
	mz0ySPjJuev4EcjjygYAZXk6kurqvg/X3pNjm5zJl84MGE7edHIL2WhfDQTA8vmp
	5Kp+VWY2VWJUet0CwcY3Tpz099CYQJggB64S8mH5pJDBoanDaqmoQWRDzo8ZRxUd
	yiyWn3Ur8WoqKXNmtrF5BibEj3f+vSWiQqbx7/Hq9Tv/V6milWqt0IYrwSYVPFWy
	4TajZWmUjfI/s5fl+yMaw==
X-ME-Sender: <xms:yQ8UZx6al04JLUusejK-7P8fHAXFaes0jLveCewgCErWGHiTl3m58fg>
    <xme:yQ8UZ-6uoQoPGEritomoWeRCcycDu1BDFq7csW5-RCZ5midBaE65Lm66tY6QWDvbR
    OdFswOQMbFZW8_GkQ>
X-ME-Received: <xmr:yQ8UZ4enyWjDaLPFr3dwmB7JAyuGIvgHxnNpbT73lQLi2-9am-S55pcTlR5u5uk2myZs61MDLGCKm12aWR5k_lj14PZeix2y48aWX4d3bxMGjUKRfQpWaJ3MIw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdehhedgudegjecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecunecujfgurhephffvve
    fufffkofgjfhggtgfgsehtkeertdertdejnecuhfhrohhmpehkrhhishhtohhffhgvrhhh
    rghughhssggrkhhksehfrghsthhmrghilhdrtghomhenucggtffrrghtthgvrhhnpedule
    fgueeiueetkeelieefgedufeehteekhfejffekvdeuhedtvefhkeeikefhgfenucffohhm
    rghinhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrg
    hmpehmrghilhhfrhhomhepkhhrihhsthhofhhfvghrhhgruhhgshgsrghkkhesfhgrshht
    mhgrihhlrdgtohhmpdhnsggprhgtphhtthhopeekpdhmohguvgepshhmthhpohhuthdprh
    gtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheptgho
    uggvsehkhhgruhhgshgsrghkkhdrnhgrmhgvpdhrtghpthhtohepphhhihhllhhiphdrfi
    hoohguseguuhhnvghlmhdrohhrghdruhhkpdhrtghpthhtohepghhithhsthgvrhesphho
    sghogidrtghomhdprhgtphhtthhopegsvghntggvsehfvghrughinhgrnhguhidrtghomh
    dprhgtphhtthhopehkrghrthhhihhkrddukeeksehgmhgrihhlrdgtohhmpdhrtghpthht
    ohepmhgvsehtthgrhihlohhrrhdrtghomhdprhgtphhtthhopehsuhhnshhhihhnvgessh
    hunhhshhhinhgvtghordgtohhm
X-ME-Proxy: <xmx:yQ8UZ6IKt5GUoodbDGgb9REierkXhQT3P2fCeq8I2ZlHH1sLz7Acgg>
    <xmx:yQ8UZ1LXGARsJgReSktYDryGuOKWFxPT_T7YsBAkS7fA1PAnWbIqkw>
    <xmx:yQ8UZzz2hSyB8hklrGeVaU-QM8Lib4PfOuF5HseevT5xCAagjarZLA>
    <xmx:yQ8UZxJRMcrbS0mQ2fwSi10zAW8UtJ9IZwstTNSjrdjHYZCLHCbp8w>
    <xmx:yg8UZ89_Xe-Vpn8TC8dWdVGvYQpkxm1RtHuZcvEFfhU_LtLkJeJCqtPL>
Feedback-ID: i8b11424c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 19 Oct 2024 16:00:07 -0400 (EDT)
From: kristofferhaugsbakk@fastmail.com
To: git@vger.kernel.org
Cc: Kristoffer Haugsbakk <code@khaugsbakk.name>,
	phillip.wood@dunelm.org.uk,
	gitster@pobox.com,
	bence@ferdinandy.com,
	karthik.188@gmail.com,
	me@ttaylorr.com,
	sunshine@sunshineco.com
Subject: [PATCH v2 0/6] doc: update-ref: amend old material and discuss symrefs
Date: Sat, 19 Oct 2024 21:59:17 +0200
Message-ID: <cover.1729367469.git.code@khaugsbakk.name>
X-Mailer: git-send-email 2.46.1.641.g54e7913fcb6
In-Reply-To: <cover.1729017728.git.code@khaugsbakk.name>
References: <cover.1729017728.git.code@khaugsbakk.name>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Commit-Hash: fd3c7585a0f84b26debcc216b86dc09acb219799
X-Previous-Commits: 9e775a65eb3ff49ded231aeeeddd59ccdce3c8a8
Content-Transfer-Encoding: 8bit

From: Kristoffer Haugsbakk <code@khaugsbakk.name>

This series removes or moves some old material in the update-ref doc and
improves the discussion of symrefs, opting for a high-level description
with some redundancy (see patch 5/6) in order to avoid a reported
mistake/confusion.

The end goal (after all patches are applied):

• First paragraph (in Description) describes the first form
• Second paragraph the second form
• Third paragraph mentions symrefs and explains why `--stdin` supports
  them
• A new section whither the symlink (FS) vs. symrefs discussion is moved
• Link update-ref to symbolic-ref and vice versa

§ Changes in v2

See notes on the patches for all changes.  Some of the minor ones are
omitted here.

• Diff changes (see interdiff):
  • Fix “the the”
• All: Taylor suggested changing the “area” prefix
  • (but I kept it on the series for consistency)
  • Link: https://lore.kernel.org/git/ZxAoFUDmdfZ8rlLs@nand.local/
• Patch “drop “flag” ”:
  • Not done: Wrap paragraph
• Patch “remove confusing paragraph”
  • (Commit) Message tweak
  • Mention that what a symref is (concretely) is documented elsewhere
• Patch “discuss symbolic refs”:
  • change subject from “symbolic links”
  • Credit Bence

Kristoffer Haugsbakk (6):
  Documentation/git-update-ref.txt: drop “flag”
  Documentation/git-update-ref.txt: remove safety paragraphs
  Documentation/git-update-ref.txt: demote symlink to last section
  Documentation/git-update-ref.txt: remove confusing paragraph
  Documentation/git-update-ref.txt: discuss symbolic refs
  Documentation: mutually link update-ref and symbolic-ref

 Documentation/git-symbolic-ref.txt |  4 +++
 Documentation/git-update-ref.txt   | 48 +++++++++++++-----------------
 2 files changed, 25 insertions(+), 27 deletions(-)

Interdiff against v1:
diff --git a/Documentation/git-update-ref.txt b/Documentation/git-update-ref.txt
index fada3f670eb..c64d80f5a2d 100644
--- a/Documentation/git-update-ref.txt
+++ b/Documentation/git-update-ref.txt
@@ -28,8 +28,8 @@ not exist.
 The final arguments are object names; this command without any options
 does not support updating a symbolic ref to point to another ref (see
 linkgit:git-symbolic-ref[1]).  But `git update-ref --stdin` does have
-the the `symref-*` commands so that regular refs and symbolic refs can
-be committed in the same transaction.
+the `symref-*` commands so that regular refs and symbolic refs can be
+committed in the same transaction.
 
 If --no-deref is given, <ref> itself is overwritten, rather than
 the result of following the symbolic pointers.
Range-diff against v1:
1:  ad9ee00a2a9 ! 1:  91c1cae3209 doc: update-ref: drop “flag”
    @@ Metadata
     Author: Kristoffer Haugsbakk <code@khaugsbakk.name>
     
      ## Commit message ##
    -    doc: update-ref: drop “flag”
    +    Documentation/git-update-ref.txt: drop “flag”
     
    -    The other paragraphs on options say `With <option>,`.  Let’s be uniform.
    +    The other paragraphs on options say “With <option>,”.  Let’s be uniform.
     
         Signed-off-by: Kristoffer Haugsbakk <code@khaugsbakk.name>
     
    +
    + ## Notes (series) ##
    +    v2:
    +    • Message: tweak
    +    • Not done: paragraph wrapping.  I found something else in this
    +      paragraph: missing “that”: “after verifying *that*”.  I will fix that
    +      in an upcoming series since there were four other missing instances of
    +      this word and I did not want to add another patch to this series.
    +
      ## Documentation/git-update-ref.txt ##
     @@ Documentation/git-update-ref.txt: for reading but not for writing (so we'll never write through a
      ref symlink to some other tree, if you have copied a whole
2:  c4bc0553a30 ! 2:  71d1e6364a2 doc: update-ref: remove safety paragraphs
    @@ Metadata
     Author: Kristoffer Haugsbakk <code@khaugsbakk.name>
     
      ## Commit message ##
    -    doc: update-ref: remove safety paragraphs
    +    Documentation/git-update-ref.txt: remove safety paragraphs
     
         Remove paragraphs which explain that using this command is safer than
         echoing the branch name into `HEAD`.
3:  3f43ddfed24 ! 3:  ca786bff978 doc: update-ref: demote symlink to last section
    @@ Metadata
     Author: Kristoffer Haugsbakk <code@khaugsbakk.name>
     
      ## Commit message ##
    -    doc: update-ref: demote symlink to last section
    +    Documentation/git-update-ref.txt: demote symlink to last section
     
         Move the discussion of file system symbolic links to a new “Notes”
         section (inspired by the one in git-symbolic-ref(1)) since this is
4:  dec48e2d37c ! 4:  769fd20945d doc: update-ref: remove confusing paragraph
    @@ Metadata
     Author: Kristoffer Haugsbakk <code@khaugsbakk.name>
     
      ## Commit message ##
    -    doc: update-ref: remove confusing paragraph
    +    Documentation/git-update-ref.txt: remove confusing paragraph
     
    -    This paragraph interrupts the flow of this section by going into detail
    +    This paragraph interrupts the flow of the section by going into detail
         about what a symbolic ref file is and how it is implemented.  It is not
         clear what the purpose is since symbolic refs were already mentioned
         prior (“possibly dereferencing the symbolic refs”).  Worse, it can
    @@ Commit message
         be lead to try `<new-oid>` and then get a confusing error since
         update-ref will just say that it is not a valid SHA1.
     
    +    gitglossary(7) already documents what a symref is, concretely, and quite
    +    well at that.
    +
         Reported-by: Bence Ferdinandy <bence@ferdinandy.com>
         Signed-off-by: Kristoffer Haugsbakk <code@khaugsbakk.name>
     
     
      ## Notes (series) ##
    -    This paragraph is also from the initial documentation: 129056370ab (Add
    -    missing documentation., 2005-10-04).
    +    v2:
    +    • Message: replace “this” with “the”, which avoids two “this” close to
    +      each other
    +    • Message: Mention that what a symref is (concretely) is covered
    +      by gitglossary(7)
     
      ## Documentation/git-update-ref.txt ##
     @@ Documentation/git-update-ref.txt: value is <old-oid>.  You can specify 40 "0" or an empty string
5:  3575fb48c93 ! 5:  ca5ece5336c doc: update-ref: discuss symbolic links
    @@ Metadata
     Author: Kristoffer Haugsbakk <code@khaugsbakk.name>
     
      ## Commit message ##
    -    doc: update-ref: discuss symbolic links
    +    Documentation/git-update-ref.txt: discuss symbolic refs
     
         Add a paragraph which just emphasizes that the command without any
    -    options does not support refs in the final arguments.  This is
    -    clear already from the names `<new-oid>` and `<old-oid>` but the right
    -    balance of redundancy makes documentation robust to stray
    -    interpretation.
    +    options does not support refs in the final arguments.  This is clear
    +    already from the names `<new-oid>` and `<old-oid>` but the right balance
    +    of redundancy makes documentation robust against stray interpretation.
     
         This is also a good place to mention why `--stdin` has those `symref-*`
         commands.
     
    +    Suggested-by: Bence Ferdinandy <bence@ferdinandy.com>
         Signed-off-by: Kristoffer Haugsbakk <code@khaugsbakk.name>
     
    +
    + ## Notes (series) ##
    +    v2:
    +    • Message: grammar: “robust against”
    +    • Message: Apparently the first paragraph wasn’t wrapped properly
    +    • Fix “the the”
    +    • Credit Bence for this suggestion which I forgot to do in v1
    +
    +      Link: https://lore.kernel.org/git/D4U30MD29CJT.3US5SBR598DVY@ferdinandy.com/
    +    • Message: “symbolic refs”, not links
    +
      ## Documentation/git-update-ref.txt ##
     @@ Documentation/git-update-ref.txt: value is <old-oid>.  You can specify 40 "0" or an empty string
      as <old-oid> to make sure that the ref you are creating does
    @@ Documentation/git-update-ref.txt: value is <old-oid>.  You can specify 40 "0" or
     +The final arguments are object names; this command without any options
     +does not support updating a symbolic ref to point to another ref (see
     +linkgit:git-symbolic-ref[1]).  But `git update-ref --stdin` does have
    -+the the `symref-*` commands so that regular refs and symbolic refs can
    -+be committed in the same transaction.
    ++the `symref-*` commands so that regular refs and symbolic refs can be
    ++committed in the same transaction.
     +
      If --no-deref is given, <ref> itself is overwritten, rather than
      the result of following the symbolic pointers.
6:  9e775a65eb3 ! 6:  fd3c7585a0f doc: mutually link update-ref and symbolic-ref
    @@ Metadata
     Author: Kristoffer Haugsbakk <code@khaugsbakk.name>
     
      ## Commit message ##
    -    doc: mutually link update-ref and symbolic-ref
    +    Documentation: mutually link update-ref and symbolic-ref
     
         These two commands are similar enough to acknowledge each other on their
         documentation pages.

base-commit: ef8ce8f3d4344fd3af049c17eeba5cd20d98b69f
-- 
2.46.1.641.g54e7913fcb6

