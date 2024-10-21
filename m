Received: from fhigh-a5-smtp.messagingengine.com (fhigh-a5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEC4816A92E
	for <git@vger.kernel.org>; Mon, 21 Oct 2024 20:47:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729543674; cv=none; b=mVtoqdndHNRLAk2x/95D2Tug9n4XA6CRg08m5W0guv+2PcSBcDxy58YA6fUvMT7x3ZBHpUzh5TZg+P/K/5AoqbsJah/t76LiD1DCPufZ6+Xw7RQe8r7oFYz1y8jz/VE2IYlQF2el5yvg76K9DADo5HSygiJTJKlTlWLWdAGWnFo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729543674; c=relaxed/simple;
	bh=xvoWRZKHww/8qc3DhGxtrZ9anh5juUdXO+eV23VZRHY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AqAXWoBKbpUtgD0WMMU17ZnDkayDg1FOHI1YhMiaeEPjbGQk5cWOYIUEaASXQmTgZzXO6o6KpKZrXEgVazxwY5TgdFaQuBN40Trh+rGYG+fbLMokyi/6LFHUzP9abuM4Wqi5nRH5SnARIqENm2tGj2J2AoxwblFhFU3jLE5dfes=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=qGYSruxN; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=TCon3ytZ; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="qGYSruxN";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="TCon3ytZ"
Received: from phl-compute-08.internal (phl-compute-08.phl.internal [10.202.2.48])
	by mailfhigh.phl.internal (Postfix) with ESMTP id B2A1111401E2;
	Mon, 21 Oct 2024 16:47:50 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-08.internal (MEProxy); Mon, 21 Oct 2024 16:47:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1729543670;
	 x=1729630070; bh=AlBL4yq69z+cvcPZCmSL9kt0jOFgGtSolKY7euGkI9I=; b=
	qGYSruxNCiCSQwIoASRMhVKnFjoA5qQCB8XPW2IxI0P0yldKowqMLRReG0raRwC8
	JO4KxUGxWW8F2zOEksnpk9NMAwA6Zqy6quWncV4D4DsKCBF6CYHCA1/SzHCTWl6h
	01tNMNUAegXABRfDqCHsmFZ832v5/O3ZnGTbj9/ZxrdFzBKI6QY54MjakXjAs8gN
	0jObn6WJd1VFybE3d/0A9pjKknMkU89TJuPwcy+zng7awbtYaillFuWJpjspImfr
	OPIZh/SxiCCt+dMPvZq6uLSJg3gQiZ8gC5hK1h8WypVnZHA77mCcoF89P2MlZH7a
	bMLC155YqTihQzEQY8aKAg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1729543670; x=
	1729630070; bh=AlBL4yq69z+cvcPZCmSL9kt0jOFgGtSolKY7euGkI9I=; b=T
	Con3ytZFEGUFSLvNLZIFf8MSYrODoWst/r15UkRzQjff3oknxfZqVPl+R7sBQxuX
	aAqsFgx89yoQ3UGuY74fYAuxuaeksOK5KErH1hL91qyFZztZRYgoKsZEq+BFNUWM
	I8IgHVBgTDJHQ0NcT9bXCGeIw0UDyxDcbUa3fmVq4MLGCuBSUiu/d5Ji85mui0Al
	bNKJXmfMgZquJ+bWQCYSMHAuKceT7D6dEULW04TEDWnHoDfEAmHt6zqXl5+EnV8o
	kJp0Kvd7CzOo6UeOXlKgz+Koc0eP33kuDlZIz69+f2fr2yKSnfMPmDsRCcxMs9wv
	egWpABdikZMNxaw4ys14Q==
X-ME-Sender: <xms:9b0WZ2qgbdMtsG8FFAZzISwz3_njYxg6qZTu-kY7pVIAyz6f-Kw4fcI>
    <xme:9b0WZ0qlepkIybwwNBzrF3kVmWKJbaOtV8NlHaoueYtDOCuv5-kL_pGLsyOy5Legk
    OsIUSklZIwkRyJAMQ>
X-ME-Received: <xmr:9b0WZ7M0UQ3oVRAteswt3cZVh4ytYZqkz9w_SaYzo_MBoFxeD_1sbxnB6kXuFstGPxY12PjBhaZW71ISEhVoDB73D5CvVIbf0RLhhhjp4VJ64c337vyVFHHefw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdehledgudehgecutefuodetggdotefrod
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
X-ME-Proxy: <xmx:9r0WZ16u07RCyxKrTVOcH84J2rHXCMd3wHlBmExOhj_1OxlSUy3fnA>
    <xmx:9r0WZ152tauV4lroNBtIZ0QYPYs8BB2l4qb_Cbk-R2km1w6cdsfNgw>
    <xmx:9r0WZ1h2KkhSqb-QHpHn0S6U3HveUQf0Oz2fTPRgh44El64FxukAsA>
    <xmx:9r0WZ_4EJbymrQd5sNudMD_uKn02quMa14RXAJotpXEfKrIWzb1RPA>
    <xmx:9r0WZ_uv0jylKwlMOuiSNHT9hnlPDOMF7djf83xiMPSdtyA89KzwUfaY>
Feedback-ID: i8b11424c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 21 Oct 2024 16:47:47 -0400 (EDT)
From: kristofferhaugsbakk@fastmail.com
To: git@vger.kernel.org
Cc: Kristoffer Haugsbakk <code@khaugsbakk.name>,
	phillip.wood@dunelm.org.uk,
	gitster@pobox.com,
	bence@ferdinandy.com,
	karthik.188@gmail.com,
	me@ttaylorr.com,
	sunshine@sunshineco.com
Subject: [PATCH v3 0/6] doc: update-ref: amend old material and discuss symrefs
Date: Mon, 21 Oct 2024 22:47:23 +0200
Message-ID: <cover.1729543007.git.code@khaugsbakk.name>
X-Mailer: git-send-email 2.46.1.641.g54e7913fcb6
In-Reply-To: <cover.1729367469.git.code@khaugsbakk.name>
References: <cover.1729367469.git.code@khaugsbakk.name>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Commit-Hash: aa1ee4a8ee08f623b2b85f68a141f188364243f4
X-Previous-Commits: 9e775a65eb3ff49ded231aeeeddd59ccdce3c8a8 fd3c7585a0f84b26debcc216b86dc09acb219799
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

§ Changes in v3

• Diff changes (see interdiff):
  • Add missing word “that”
• Patch “remove confusing paragraph”
  • Rewrite message to emphasize ref backends
• Patch “drop “flag” ”:
  • Add missing word “that”

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

Interdiff against v2:
diff --git a/Documentation/git-update-ref.txt b/Documentation/git-update-ref.txt
index c64d80f5a2d..8a4281cde9f 100644
--- a/Documentation/git-update-ref.txt
+++ b/Documentation/git-update-ref.txt
@@ -34,7 +34,7 @@ committed in the same transaction.
 If --no-deref is given, <ref> itself is overwritten, rather than
 the result of following the symbolic pointers.
 
-With `-d`, it deletes the named <ref> after verifying it
+With `-d`, it deletes the named <ref> after verifying that it
 still contains <old-oid>.
 
 With `--stdin`, update-ref reads instructions from standard input and
Range-diff against v2:
1:  91c1cae3209 ! 1:  9c40351950f Documentation/git-update-ref.txt: drop “flag”
    @@ Commit message
     
         The other paragraphs on options say “With <option>,”.  Let’s be uniform.
     
    +    Also add missing word “that”.
    +
         Signed-off-by: Kristoffer Haugsbakk <code@khaugsbakk.name>
     
     
      ## Notes (series) ##
    +    v3:
    +    • Also add missing “that”: “after verifying *that*”
    +
    +      Link: https://lore.kernel.org/git/CAOLa=ZTJqcEOQm8Ns58t6DxEXYn2ws__HDRRAaAhsBkJJFLXmg@mail.gmail.com/
         v2:
         • Message: tweak
         • Not done: paragraph wrapping.  I found something else in this
    @@ Documentation/git-update-ref.txt: for reading but not for writing (so we'll neve
      archive by creating a symlink tree).
      
     -With `-d` flag, it deletes the named <ref> after verifying it
    -+With `-d`, it deletes the named <ref> after verifying it
    ++With `-d`, it deletes the named <ref> after verifying that it
      still contains <old-oid>.
      
      With `--stdin`, update-ref reads instructions from standard input and
2:  71d1e6364a2 ! 2:  bb14c427f81 Documentation/git-update-ref.txt: remove safety paragraphs
    @@ Commit message
         Remove paragraphs which explain that using this command is safer than
         echoing the branch name into `HEAD`.
     
    -    These paragraphs have been part of the documentation since the
    -    documentation was created in 129056370ab (Add missing documentation.,
    -    2005-10-04), back when the command synopsis was a lot simpler:
    +    Evoking the echo strategy is wrong now under the reftable backend since
    +    this file does not exist.  And the ref file backend majority user base
    +    use porcelain commands to manage `HEAD` unless they are intentionally
    +    poking at the implementation.
     
    -        `git-update-ref` <ref> <newvalue> [<oldvalue>]
    +    Maybe this warning was relevant for the usage patterns when it was
    +    added[1] but now it just takes up space.
     
    -    These paragraphs don’t interrupt the flow of the document on that
    -    revision since it is at the end.  Now though it is placed after the
    -    description of `--no-deref` and before `-d` and `--stdin`.  Covering all
    -    the options is more generally interesting than a safety note about a
    -    naïve `HEAD` management.
    -
    -    Such a safety warning is also much less relevant now, considering that
    -    everyone who isn’t intentionally poking at the internal implementation
    -    is using porcelain commands to manage `HEAD`.
    +    † 1: 129056370ab (Add missing documentation., 2005-10-04)
     
         Signed-off-by: Kristoffer Haugsbakk <code@khaugsbakk.name>
     
    +
    + ## Notes (series) ##
    +    v3:
    +    • Change commit message: ref backends
    +
    +      Link: https://lore.kernel.org/git/bcb0e2d8-ebee-4835-aa43-05107199ee62@app.fastmail.com/#t
    +
      ## Documentation/git-update-ref.txt ##
     @@ Documentation/git-update-ref.txt: somewhere else with a regular filename).
      If --no-deref is given, <ref> itself is overwritten, rather than
    @@ Documentation/git-update-ref.txt: somewhere else with a regular filename).
     -ref symlink to some other tree, if you have copied a whole
     -archive by creating a symlink tree).
     -
    - With `-d`, it deletes the named <ref> after verifying it
    + With `-d`, it deletes the named <ref> after verifying that it
      still contains <old-oid>.
      
3:  ca786bff978 = 3:  6c8ff72c230 Documentation/git-update-ref.txt: demote symlink to last section
4:  769fd20945d = 4:  f6a70b3f70a Documentation/git-update-ref.txt: remove confusing paragraph
5:  ca5ece5336c = 5:  5033ec82586 Documentation/git-update-ref.txt: discuss symbolic refs
6:  fd3c7585a0f = 6:  aa1ee4a8ee0 Documentation: mutually link update-ref and symbolic-ref

base-commit: ef8ce8f3d4344fd3af049c17eeba5cd20d98b69f
-- 
2.46.1.641.g54e7913fcb6

