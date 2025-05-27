Received: from fout-b1-smtp.messagingengine.com (fout-b1-smtp.messagingengine.com [202.12.124.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4421D1ACEAC
	for <git@vger.kernel.org>; Tue, 27 May 2025 21:19:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748380799; cv=none; b=EEbgR5vNog34JUIZfd6fQZLJDnz5MHlWTmTajVbTo7fdRhHi5dPjy8x2HX1wSvJDrqerHotKwzr0kEoEeh1EtJPcae7uMwAz72Ss0g878a4+R9xFmPdpTL9GGu74/hUchJT4FkQxVXxCCbaCDMSDJbnPvsQnpHsvnoCtmVxSRJU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748380799; c=relaxed/simple;
	bh=PaefMCEByy7FN7PjwmL52puUagcL+0wSuFFFMm333YQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=h7UHG5M2ub2XomreMh4mAWZ07PnBybKURbK+3kcI8K86GRhMnRoQUyLenGv06cXFj/9H2wMZKxGn3wuzcyuw2Jwsndwd/O1bZoz5WuG+xhrrYmVpLzEAy8VrhOFXe2KlwswB81WOWMWSFEc/r+KmtPbuSo1zH23QZT63z8Z/ZgY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=Yzikx1RG; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=LO4+ckuU; arc=none smtp.client-ip=202.12.124.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="Yzikx1RG";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="LO4+ckuU"
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfout.stl.internal (Postfix) with ESMTP id 421661140112;
	Tue, 27 May 2025 17:19:55 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Tue, 27 May 2025 17:19:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1748380795;
	 x=1748467195; bh=fgy9w13B0g+C8vEkF148LNj92GJ34OgYI8fe0V+MYgI=; b=
	Yzikx1RGc1NK+J9/3UketLspfk421N0Tz8xbEuM74G7145gIeX8HA+NVxZSz34q8
	s6/V32EUhZVkkCIRl7zlV8kt6BA+OLFCNxOVd5w92GtsALP02xEuf8Jxq91RBIsy
	lM6YtenP2l0d08+2i4HK3CpoFYXVTv3WjumtQWoRE3r8hTLQ8CO5UvBzeojLT21p
	GM9s/5YIRHl7bCuP4C5ufqOhDCK13uDbSNtlNcVJ2pOWRG8sOADxPbBf+NVjHTaI
	KWE7X3jvPU+6pYVUtAjdoUktsoUbqwRQzxtcDjztW5cvb8CHn/IhYlDwV7sGTqLl
	whgBkb8UZGjLIEoCBLs9pQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1748380795; x=
	1748467195; bh=fgy9w13B0g+C8vEkF148LNj92GJ34OgYI8fe0V+MYgI=; b=L
	O4+ckuU09YyF9ws9RsVvuUhX9n7MjnuD1et9ijoT3q3RA5U6QVrAsPwXTeMSc1aT
	gK2w55OZogkTG84VL4slpoGNFupylqrul6Z6DqfGrTbvI4onRLn7GaXQYrrO4kFy
	C5+Oxi/XftALObzfMNgMMRQPlacSyhFaQqkxlkRo0er4EIETAIukBc5gfaYNJG3E
	9N2DVtxVDxfNTBjtqyJ6nzQZ+sWeuMMsCsMGVWRNe/5XbxMtJFh/xhzL1gbgN77N
	6FVQ59n0en+eSdDNs6vV4YsHWzSpwnGHjIRg9U765hBxkEVU5Vvtczc8rqM/E+Ms
	texOKgeFoZLnc54i1oXOA==
X-ME-Sender: <xms:eiw2aA12nyTjN1a14LneZBi5o_S1_aA8QHjoQtDVH_UJIMf75wQ7lcs>
    <xme:eiw2aLEN5z0vtZQQQQjC9qmO6ZpKSf_MO65cR9FMLgB6mHJzoBdMgBkoTyk3wVqUe
    CL3x2hEs0VFF7wv7g>
X-ME-Received: <xmr:eiw2aI4yOgYfeTo_83qx4Nnwj1Tri3UhlbmOVYN04tuLi3lkToqF8k8qsu7i3-AWBB2ThNgUrnFpi_SHU7n4S4ZPGeID4Q4v3VK8Lw2mW6_qMQqdKVxA6zaAOQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddtgddvudeggeculddtuddrgeefvddrtd
    dtmdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggft
    fghnshhusghstghrihgsvgdpuffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftd
    dtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvfevufffkffo
    jghfgggtgfesthekredtredtjeenucfhrhhomhepkhhrihhsthhofhhfvghrhhgruhhgsh
    gsrghkkhesfhgrshhtmhgrihhlrdgtohhmnecuggftrfgrthhtvghrnhepudelgfeuieeu
    teekleeifeegudefheetkefhjeffkedvueehtdevhfekieekhffgnecuffhomhgrihhnpe
    hkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgr
    ihhlfhhrohhmpehkrhhishhtohhffhgvrhhhrghughhssggrkhhksehfrghsthhmrghilh
    drtghomhdpnhgspghrtghpthhtohephedpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopegtohguvgeskh
    hhrghughhssggrkhhkrdhnrghmvgdprhgtphhtthhopehpvghffhesphgvfhhfrdhnvght
    pdhrtghpthhtohepugihrhhonhgvthgvnhhgsehgmhgrihhlrdgtohhmpdhrtghpthhtoh
    epsggvnhdrkhhnohgslhgvsehgmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:eiw2aJ2G_vMFjFqElsWUX7tbDwejIhBKa5Pr3Yb9zKevPcNXUy36Mg>
    <xmx:eiw2aDEjUAsK9cR_7Vl2IDTgh_akHlpD5H312da8WQ0yzMUYw42SXg>
    <xmx:eiw2aC-ez0CNeDM_NeXaR2c4USgYDBrlV6h3M_IOhMsQBLhqIz08Hg>
    <xmx:eiw2aIkldijM97sjLXj_HNfYa0gKXSvQH4FPrA-SAN8qSJc_eA9n-Q>
    <xmx:eyw2aPz5hAg11WYPfR2VavrKCgbONmfBibEeHhDkBS8ZRyrfDPQ2gKgg>
Feedback-ID: i8b11424c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 27 May 2025 17:19:53 -0400 (EDT)
From: kristofferhaugsbakk@fastmail.com
To: git@vger.kernel.org
Cc: Kristoffer Haugsbakk <code@khaugsbakk.name>,
	Jeff King <peff@peff.net>,
	Teng Long <dyroneteng@gmail.com>,
	"D . Ben Knoble" <ben.knoble@gmail.com>
Subject: [PATCH v3 0/9] doc: --stdin on notes and core.commentChar mentions
Date: Tue, 27 May 2025 23:19:29 +0200
Message-ID: <cover.1748380390.git.code@khaugsbakk.name>
X-Mailer: git-send-email 2.49.0.780.g892193c3f50
In-Reply-To: <cover.1748028010.git.code@khaugsbakk.name>
References: <cover.1748028010.git.code@khaugsbakk.name>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Kristoffer Haugsbakk <code@khaugsbakk.name>

I wanted to fix `--stdin` in the git-notes(1) documentation.  Then I
found some other things on that doc as well as things to do with
`core.commentChar`.

§ Changes in v3

Suggestions on patches 6 and 8 were implemented.  See the patch notes
and the interdiff.

Kristoffer Haugsbakk (9):
  doc: stripspace: mention where the default comes from
  doc: config: mention core.commentChar on commit.cleanup
  doc: notes: split out options with negated forms
  doc: notes: rework --[no-]stripspace
  doc: notes: remove stripspace discussion from other options
  doc: notes: clearly state that --stripspace is the default
  doc: notes: point out copy --stdin use with argv
  doc: notes: treat --stdin equally between copy/remove
  doc: notes: use stuck form throughout

 Documentation/config/commit.adoc  |  7 ++--
 Documentation/git-notes.adoc      | 54 ++++++++++++++++++-------------
 Documentation/git-stripspace.adoc |  3 +-
 3 files changed, 38 insertions(+), 26 deletions(-)

Interdiff against v2:
diff --git a/Documentation/git-notes.adoc b/Documentation/git-notes.adoc
index 43436daeccc..46a232ca718 100644
--- a/Documentation/git-notes.adoc
+++ b/Documentation/git-notes.adoc
@@ -197,7 +197,8 @@ OPTIONS
 `-C`/`--reuse-message`. However, keep in mind that this depends on the
 order of similar options. For example, for `-C <object> -m<message>`,
 `--stripspace` will be used because the default for `-m` overrides the
-previous `-C`.
+previous `-C`. This is a known limitation that may be fixed in the
+future.
 
 `--ref=<ref>`::
 	Manipulate the notes tree in _<ref>_.  This overrides
@@ -211,7 +212,7 @@ previous `-C`.
 	object that does not have notes attached to it.
 
 `--stdin`::
-	For `remove` and `copy`. See the respective subcommands.
+	Only valid for `remove` and `copy`. See the respective subcommands.
 
 `-n`::
 `--dry-run`::
Range-diff against v2:
 1:  bf3ea7f23c0 =  1:  bf3ea7f23c0 doc: stripspace: mention where the default comes from
 2:  e9cf956a824 =  2:  e9cf956a824 doc: config: mention core.commentChar on commit.cleanup
 3:  14dc58120e3 =  3:  14dc58120e3 doc: notes: split out options with negated forms
 4:  c68a91f81ba =  4:  c68a91f81ba doc: notes: rework --[no-]stripspace
 5:  f4755040f38 =  5:  f4755040f38 doc: notes: remove stripspace discussion from other options
 6:  be89c3349d2 !  6:  184cf032abf doc: notes: clearly state that --stripspace is the default
    @@ Commit message
         Clearly state when which of the regular and negated form of the
         option take effect.[1]
     
    +    Also mention the subtle behavior that occurs when you mix options like
    +    `-m` and `-C`, including a note that it might be fixed in the future.
    +    The topic was brought up on v8 of the `--separator` series.[2][3]
    +
         [1]: https://lore.kernel.org/git/xmqqcyct1mtq.fsf@gitster.g/
    +    [2]: https://lore.kernel.org/git/xmqq4jp326oj.fsf@gitster.g/
    +    † 3: v11 was the version that landed
     
    +    Helped-by: Junio C Hamano <gitster@pobox.com>
         Signed-off-by: Kristoffer Haugsbakk <code@khaugsbakk.name>
     
     
      ## Notes (series) ##
    +    v3:
    +    • Mention that it is a bug (“known limitation”) which might be fixed.
    +
    +      Link: https://lore.kernel.org/git/xmqqiklrvwl4.fsf@gitster.g/
    +    • Message: discuss this new “subtle behavior” part
         v2:
         • New
         • The `--` are to prevent the new paragraph from becoming a continuation
    @@ Documentation/git-notes.adoc: OPTIONS
     +`-C`/`--reuse-message`. However, keep in mind that this depends on the
     +order of similar options. For example, for `-C <object> -m<message>`,
     +`--stripspace` will be used because the default for `-m` overrides the
    -+previous `-C`.
    ++previous `-C`. This is a known limitation that may be fixed in the
    ++future.
      
      `--ref <ref>`::
      	Manipulate the notes tree in _<ref>_.  This overrides
 7:  d8a22847a7d =  7:  e18472f735d doc: notes: point out copy --stdin use with argv
 8:  3e8ecf1b668 !  8:  530dd953170 doc: notes: treat --stdin equally between copy/remove
    @@ Commit message
     
     
      ## Notes (series) ##
    +    v3:
    +    • Rephrase to “Only valid for”
    +
    +      Link: https://lore.kernel.org/git/xmqqecwfvwdu.fsf@gitster.g/
         v2:
         • On --stdin: just refer to the respective subcommands and stop there.
           As suggested.
    @@ Documentation/git-notes.adoc: When done, the user can either finalize the merge
      
      `prune`::
      	Remove all notes for non-existing/unreachable objects.
    -@@ Documentation/git-notes.adoc: previous `-C`.
    +@@ Documentation/git-notes.adoc: future.
      	object that does not have notes attached to it.
      
      `--stdin`::
     -	Also read the object names to remove notes from the standard
     -	input (there is no reason you cannot combine this with object
     -	names from the command line).
    -+	For `remove` and `copy`. See the respective subcommands.
    ++	Only valid for `remove` and `copy`. See the respective subcommands.
      
      `-n`::
      `--dry-run`::
 9:  73bdcaecae5 !  9:  7751330daa4 doc: notes: use stuck form throughout
    @@ Notes (series)
     
      ## Documentation/git-notes.adoc ##
     @@ Documentation/git-notes.adoc: order of similar options. For example, for `-C <object> -m<message>`,
    - `--stripspace` will be used because the default for `-m` overrides the
    - previous `-C`.
    + previous `-C`. This is a known limitation that may be fixed in the
    + future.
      
     -`--ref <ref>`::
     +`--ref=<ref>`::

base-commit: cb96e1697ad6e54d11fc920c95f82977f8e438f8
-- 
2.49.0.780.g892193c3f50

