Received: from fhigh-b7-smtp.messagingengine.com (fhigh-b7-smtp.messagingengine.com [202.12.124.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 679971A0BD6
	for <git@vger.kernel.org>; Sat, 14 Feb 2026 11:56:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771070189; cv=none; b=tN/DpmKpb439BfgbAG+LW/q2lSgY196isKY7Kv9dvrm/gONGmb/5/lT6J8HeOeRE2tyh0gVdUW1e/oMJXNZE6xr23XwRmNCZn8Yz8oYYKfwFL8rKoMK3t+PIVJQADl+gb5Q9Ub5CJitlSDvYmmwEbIJppZJTOxT7R7uceGsc6cE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771070189; c=relaxed/simple;
	bh=EMTNM09pqll/iE0aBgxVoCdP0VtfJHD1OjCVUh5umb8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eLoifEGSBOrvUU91yAPc4jaW517Fhm4rrIcZI5iN5wDjINh33xVcJCcplJDrS+LsvdHq/isCreHII6uGpgt5Bg/8YzsKQF6/wfRCYw1D6DGZgUKh/9BXNZaf33wU5PpOI3ch/bhJkAQHDdqKslUPXusvIxPcCMzNSgfAauq+sEg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=GGnp8q8C; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=jpR5ty4I; arc=none smtp.client-ip=202.12.124.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="GGnp8q8C";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="jpR5ty4I"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 66B037A0141;
	Sat, 14 Feb 2026 06:56:26 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Sat, 14 Feb 2026 06:56:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1771070186;
	 x=1771156586; bh=MxogQZKPLtYjMJY7WWdvEplGqDk4/fud+TbraUz6jpk=; b=
	GGnp8q8CD1KvVe/e5MGbuxwEza8W5tCgNSZoZ/fcHOPbLALerbmMPvleu5NjIfQT
	021LFWZCFS1KyfUJRVZ0CpSN2mQja1/uGrTf/vdmn3ggN67wiRKYB5REp075Ofa5
	qhVeMR428Ca4KoFl7OS0owlh8w7b+9McLH+ldlNhiDmky7GWMnXV4wjZCgjDcZC2
	/vg0W0FFZl0s0pmVo6lrzP9kJVRxRnACy/cPPOqPt34BEqCkaupzp2NojDjaz/zu
	tupLyHAOZ8B2RQHRU0OVrzagFAa27NRMK32yIpvDIYumPtaBxReJ626wVSbvaqxT
	VwFt8JNFtkZERXZaZu08Eg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1771070186; x=
	1771156586; bh=MxogQZKPLtYjMJY7WWdvEplGqDk4/fud+TbraUz6jpk=; b=j
	pR5ty4I2brU3GhVUjG2uTmQ9FD4Yi8Zri/b5GGq5AVhanluQ0KNOveGKen7OJcqA
	zqHK0hL7dL8N/avM6ybiIL1XMTHUxJP5HkjHLpJdrNHpEA7Lyk5MXrCroVNCbDMM
	UaNVlPw+bo1q2TOgDUfP2hh3lgFIv97wxhibbKv9uJN46bk+W/xRO7MZ5iQYPKwj
	6GbkamX+JA4tyfejKFBmzJVMTHY7hymJLbgxPvZV8tSRXWqXkTwsBA24J81zPd5v
	4kDfBBufXNclwEPUUSHWABkD8AxMrcEJ7GXc8nMCX+xe/54oqb8wp/JR7qYvoEZ4
	4i/BK5t6N4hVpoTd7flwQ==
X-ME-Sender: <xms:6mKQaSC1IFP4FqJUt1GLGUoYvSCLNhsUc9bxNZyf9o7vgi5yNGpz-pc>
    <xme:6mKQaTifVuRFcVcaHd69VhlNAOdAMEJoUs08mGvU71Fh75z8tFE-XLpGKjyCxipwl
    muW_UHwN0mMWXCoe3zMunhSthCP5T2zSNTi-oV9vVmg4cLkwckuwg>
X-ME-Received: <xmr:6mKQaakoeNF-5luh6FITOFR0L6wIzerVfxQtJEN4XBWJ91zGVDRpsdPxWKGlaLSK9724MLY-esisENupuA5z4VcADpTZnzkFxB59b2o>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvuddutdeiucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnegfrh
    hlucfvnfffucdlvdefmdenucfjughrpefhvfevufffkffojghfgggtgfesthekredtredt
    jeenucfhrhhomhepkhhrihhsthhofhhfvghrhhgruhhgshgsrghkkhesfhgrshhtmhgrih
    hlrdgtohhmnecuggftrfgrthhtvghrnhepvddvhfdtueetveevvdegvedtffdvfeehjeej
    ieekfeekgeetgeegjeeuueffvdetnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghdpsh
    htrggtkhhovhgvrhhflhhofidrtghomhenucevlhhushhtvghrufhiiigvpedtnecurfgr
    rhgrmhepmhgrihhlfhhrohhmpehkrhhishhtohhffhgvrhhhrghughhssggrkhhksehfrg
    hsthhmrghilhdrtghomhdpnhgspghrtghpthhtohepgedpmhhouggvpehsmhhtphhouhht
    pdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhope
    gtohguvgeskhhhrghughhssggrkhhkrdhnrghmvgdprhgtphhtthhopehtohhrvhgrlhgu
    sheslhhinhhugidqfhhouhhnuggrthhiohhnrdhorhhgpdhrtghpthhtohepsggvnhdrkh
    hnohgslhgvsehgmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:6mKQafoznQfs5ECXvBxdMizm6B6mEvQX-6n3GCv3YtUFwhQtIw4n-w>
    <xmx:6mKQaTHzWt6D29ds_AkkXD31J6Svvl8QH856pDbcs3Ip7pzCbFwzFA>
    <xmx:6mKQabzf-WBYhoNXe5irMf1sCXaWJn3dTJQ2Y_bL968xYF9_00y6Bg>
    <xmx:6mKQaYo-opo7c4VBlqo8_pviC9WcoUG6o4jNwETIw23D3EfFLyTjBg>
    <xmx:6mKQaVHNgbNavMHQmJiJzVAXGSPlkickLjWQQhBSIybjpjMclyCuEWJV>
Feedback-ID: i8b11424c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 14 Feb 2026 06:56:24 -0500 (EST)
From: kristofferhaugsbakk@fastmail.com
To: git@vger.kernel.org
Cc: Kristoffer Haugsbakk <code@khaugsbakk.name>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	ben.knoble@gmail.com
Subject: [PATCH v2 0/3] doc: patch-id: explain how to map efficiently
Date: Sat, 14 Feb 2026 12:55:40 +0100
Message-ID: <V2_CV_doc_patch-id_4.371@msgid.xyz>
X-Mailer: git-send-email 2.53.0.26.g2afa8602a26
In-Reply-To: <CV_doc_patch-id_4.275@msgid.xyz>
References: <CV_doc_patch-id_4.275@msgid.xyz>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Kristoffer Haugsbakk <code@khaugsbakk.name>

Topic name (applied): kh/doc-patch-id-4

Topic summary: Explain and emphasize how to map commits efficiently and
add an example script.

This is the fourth patch series for git-patch-id(1). This one focuses on
emphasizing how the command is an efficient patch ID–commit mapper and
how to use the patch IDs to join commits in a script.

§ Changes in v2

• Delete temporary files at the end of the script.
• Consistent footnote style: https://lore.kernel.org/git/c70adde6-e3db-4a46-bb29-a19d7aba8c7e@app.fastmail.com/

§ Previous patch series

• Patch series 1:
  • Topic: kh/doc-patch-id-markup-fix
  • https://lore.kernel.org/git/v2-e5ad12cc3b3.1759178715.git.code@khaugsbakk.name/
• Patch series 2:
  • Topic: kh/doc-patch-id-1
  • https://lore.kernel.org/git/v2-38645ea253c.1760369708.git.code@khaugsbakk.name/
• Patch series 3:
  • Topic: kh/doc-patch-id
  • https://lore.kernel.org/git/CV_doc_patch-id_3.1ab@msgid.xyz/

Link to v1: https://lore.kernel.org/git/CV_doc_patch-id_4.275@msgid.xyz/#t

Kristoffer Haugsbakk (3):
  doc: patch-id: emphasize multi-patch processing
  doc: patch-id: add script example
  doc: patch-id: see also git-cherry(1)

 Documentation/git-patch-id.adoc | 51 +++++++++++++++++++++++++++++++--
 1 file changed, 48 insertions(+), 3 deletions(-)

Interdiff against v1:
diff --git a/Documentation/git-patch-id.adoc b/Documentation/git-patch-id.adoc
index fb9ec211bb6..05859990c8e 100644
--- a/Documentation/git-patch-id.adoc
+++ b/Documentation/git-patch-id.adoc
@@ -101,6 +101,8 @@ git rev-list --no-merges $tail_opts |
     git diff-tree --patch --stdin |
     git patch-id  --stable | sort >"$for_upstream"
 join -a1 "$for_branch" "$for_upstream" | cut -d' ' -f2,3
+rm "$for_branch"
+rm "$for_upstream"
 ----
 
 Now the first column shows the commit from your branch and the second
Range-diff against v1:
1:  704dc0ada8f ! 1:  e9319039d5e doc: patch-id: emphasize multi-patch processing
    @@ Commit message
     
         Also drop “the” from “standard input”.
     
    -    [1]: https://stackoverflow.com/a/19758159
    +    † 1: https://stackoverflow.com/a/19758159
         † 2: This is `master` of this repository on 2025-10-02
     
         Signed-off-by: Kristoffer Haugsbakk <code@khaugsbakk.name>
2:  e37c25aa5fc ! 2:  8ba3e71752c doc: patch-id: add script example
    @@ Commit message
         demonstrate generating two lists, sorting them, joining them, and
         finally discarding the patch ID lookup column with cut(1).
     
    -    [1]: https://lore.kernel.org/workflows/CAHk-=wiN+8EUoik4UeAJ-HPSU7hczQP+8+_uP3vtAy_=YfJ9PQ@mail.gmail.com/
    +    † 1: https://lore.kernel.org/workflows/CAHk-=wiN+8EUoik4UeAJ-HPSU7hczQP+8+_uP3vtAy_=YfJ9PQ@mail.gmail.com/
     
         Inspired-by: Linus Torvalds <torvalds@linux-foundation.org>
         Signed-off-by: Kristoffer Haugsbakk <code@khaugsbakk.name>
    @@ Documentation/git-patch-id.adoc: This is the default if `patchid.stable` is set
     +    git diff-tree --patch --stdin |
     +    git patch-id  --stable | sort >"$for_upstream"
     +join -a1 "$for_branch" "$for_upstream" | cut -d' ' -f2,3
    ++rm "$for_branch"
    ++rm "$for_upstream"
     +----
     +
     +Now the first column shows the commit from your branch and the second
3:  2a319a43b2e ! 3:  27cad849312 doc: patch-id: see also git-cherry(1)
    @@ Commit message
         Signed-off-by: Kristoffer Haugsbakk <code@khaugsbakk.name>
     
      ## Documentation/git-patch-id.adoc ##
    -@@ Documentation/git-patch-id.adoc: join -a1 "$for_branch" "$for_upstream" | cut -d' ' -f2,3
    +@@ Documentation/git-patch-id.adoc: rm "$for_upstream"
      Now the first column shows the commit from your branch and the second
      column shows the patch ID equivalent commit, if it exists.
      

base-commit: 67ad42147a7acc2af6074753ebd03d904476118f
-- 
2.53.0.26.g2afa8602a26

