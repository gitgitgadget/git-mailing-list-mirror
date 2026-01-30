Received: from fhigh-a6-smtp.messagingengine.com (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0895D29D26B
	for <git@vger.kernel.org>; Fri, 30 Jan 2026 13:27:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769779681; cv=none; b=mVOT8EpJQvh2LPgAJvT9DrAQFBOk9Ea258NDWPoDIIpeHROivszW8O7ncgxKy0wS+zuMtxmDTCPyo7bsBu5inQL8bi0opELW/3YVs4Jhl2oba22EmQBf9ak5u4vy+SW1Jqghsoy5sHs7wk+mfJLst0BTF2eQ4GXIKjcpP6sEdz0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769779681; c=relaxed/simple;
	bh=Lyc8Soa3NzWH3GoicK2zICehjQ+oZk61fPtodicKx/w=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 In-Reply-To:References:To:Cc; b=KeIXkhRHuDeDvsfqGCIeQuGKU83sO7lUUk6y5lam76bxMi+mEy/bmqfxp7Fj/iMmLV4uJK2JWF/WdcnIv05yvyDZEw2pnxu4heaRNvnMHGUuZXv0yTbp5LrDA0yZOsCop5uGxx5mJkY6D0xmJia8Sx3DmQPF7+5UTVX8/lqoejk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=V5eZ/ILn; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=K9NeV2TT; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="V5eZ/ILn";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="K9NeV2TT"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 55B301400151;
	Fri, 30 Jan 2026 08:27:59 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-03.internal (MEProxy); Fri, 30 Jan 2026 08:27:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1769779679;
	 x=1769866079; bh=CwjPlB8sU56XMF1N//rntcPqCpVTNFCyE9EjM5DA/6w=; b=
	V5eZ/ILnR2MorVnLBOU9ClRJs7/1Gj2p7wSC7wdhB6grj3P9VejQ2Qms14HfkfTE
	OjF2TPif2Fv5Km5WOyi/F+XOwyDf6GDsKS86+uDJPih8wCnJEIpj1vc/MBw3Wyht
	EsyVY4+Yy8mFqI/8xlNjcW3czblxNKJPwyT+DNYlzqdTLU2ht88EdveJQjZhY2Oi
	Nc2VyMQsbW7j1FfrSsWgx4NME6Dlj55CG/oFjkDgb3jMS31EnwrHCW2BD3WNiLwS
	1K5FhuHRuDrTxHobYfOwAaUYOTpIxZyU2vWHgFumyRgGsGxrgjf148aT5vvo6AGi
	QXOlcfBs+yz8+7jJ4XqgvA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1769779679; x=
	1769866079; bh=CwjPlB8sU56XMF1N//rntcPqCpVTNFCyE9EjM5DA/6w=; b=K
	9NeV2TTKRX0sK7Y1m3A2iRWs5tpiJVeiPcY4nXjsyjvb/lOND0701NAzUWmxdLM8
	qpkYfHp0ADujQd+w7BYzCvaAyOuBNVk6YSZV8GmgVj02vBPXDpdfxDbLDB13TqyP
	NzSKSzVD6B05C4DXFR1S3qRMilAIUalYwgzv6QmqOMNLCdUSe54J2z1T4DfQsHGZ
	Ymuk3O/AfbNgKnmHjbe6GNhb/ZyWyzhGr8Cq3D77TNQrawjg8tze42wx1nvP1ik/
	3bhPh7GzNfAUJf/AyUdwl7HpflzAHwmZ1tMLhCH2ywy3FVD0pZFE+nHk+ifVK7zx
	wv3bl2Z6lzUMPGjC86mZA==
X-ME-Sender: <xms:37F8aX43mEXNCU89M6EaDrbp_bs-LBEQoZQQCKYRgUNkQFgDu8XGDA>
    <xme:37F8aUXMpIH_gnW06iZqK1otG_D_Q0yziDgKdoKdMLPFvhsJFBzf-H_UHAPFj0BFi
    hIfXmQhtZeJ-MwLQopKStoguEgrMXuSUa49nCYhY2OF5E1u54Dn2w>
X-ME-Received: <xmr:37F8ab3_ypxWaSZ6Dn8beSB-hGJ9hhcxZSX6je5vbHUG1fWRUMli2bEh1tZlCdsyzxYk7HCpzSX6lZ63hMKZ6LwasLBajGykffjX9tKlXw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdduieeludeiucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefhufffkfggtgfgjghfvfevofesthejre
    dtredtjeenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehp
    khhsrdhimheqnecuggftrfgrthhtvghrnhepteeuueehhffhiedtueehtddtieekfedtud
    ehtdehfefhgeffveeggedthfehuedvnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhmpdhnsggprhgtphhtthhopeefpdhmohguvgepshhmthhpohhuthdprhgtphht
    thhopehpvghffhesphgvfhhfrdhnvghtpdhrtghpthhtohepmhgvsehtthgrhihlohhrrh
    drtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:37F8aR01ObWEJXpC8jrpPaNgDpkaDPMM3o49XK42-QXuKkeNBGKXVg>
    <xmx:37F8ae8mMRbRvFPFfUd3ISblH-_M_WenD1PGFyZzZX5W2W-CizXhCA>
    <xmx:37F8ae3Ozcwnjr-tgQA2VB_P6gZzevD2bWneCsZ-GGC1J3PxJ8El9A>
    <xmx:37F8ab8S2dHp4konMeS_BltuFFlYnMq7tJZnAhYV2PBWpeTORDFiFA>
    <xmx:37F8adwg4e01sLP98rSiskXaD2EJoe00o02g5OKL0wIxUwA-on4g7Ujs>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 30 Jan 2026 08:27:58 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 869e35bd (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 30 Jan 2026 13:27:56 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Subject: [PATCH v2 0/4] Fix misuse of `refs_for_each_ref_in()`
Date: Fri, 30 Jan 2026 14:27:41 +0100
Message-Id: <20260130-b4-pks-fix-for-each-ref-in-misuse-v2-0-0449b198a681@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAM2xfGkC/5WNTQ6CMBCFr0Jm7RhaBH9W3sOwqGUqE0NLOtpgS
 O9u5QYuv/fyvreCUGQSuFQrREosHHwBvavAjsY/CHkoDLrWXa30Ce8HnJ+Cjhd0ISIZO2Ikh+x
 xYnkL4bkz1GlqVGNaKJ651LxsH7e+8MjyCvGzXSb1S/+xJ4U1DmStoYbMUbfXMtjzBH3O+QtuI
 SnBzwAAAA==
X-Change-ID: 20260128-b4-pks-fix-for-each-ref-in-misuse-96ae62e313a5
In-Reply-To: <20260128-b4-pks-fix-for-each-ref-in-misuse-v1-0-deccae3ea725@pks.im>
References: <20260128-b4-pks-fix-for-each-ref-in-misuse-v1-0-deccae3ea725@pks.im>
To: git@vger.kernel.org
Cc: Taylor Blau <me@ttaylorr.com>, Jeff King <peff@peff.net>
X-Mailer: b4 0.14.3

Hi,

this small patch series fixes a bug I have discovered where configuring
"pack.preferBitmapTips" to an exact branch will cause Git to `BUG()`.

The root cause of this bug is misuse of `refs_for_each_ref_in()`: this
function accepts a prefix to yield refs for, and then strips the prefix
for each ref. Consequently, if passed an exact refname, then stripping
the prefix would make us end up with an empty refname, and that is not
supposed to happen.

There was one other caller that got it wrong, too, and which is also
fixed in this patch series.

Changes in v2:
  - Explain my thought process against why I chose to also allow exact
    ref matches in the second commit and clarify the documentation a
    bit. As said, I'm very open to changing this if my spelled-out
    thoughts are not convincing.
  - Apply Peff's patch to further simplify code.
  - Link to v1: https://lore.kernel.org/r/20260128-b4-pks-fix-for-each-ref-in-misuse-v1-0-deccae3ea725@pks.im

Thanks!

Patrick

---
Jeff King (1):
      bisect: simplify string_list memory handling

Patrick Steinhardt (3):
      pack-bitmap: deduplicate logic to iterate over preferred bitmap tips
      pack-bitmap: fix bug with exact ref match in "pack.preferBitmapTips"
      bisect: fix misuse of `refs_for_each_ref_in()`

 Documentation/config/pack.adoc |  7 +++----
 bisect.c                       | 16 +++++++---------
 builtin/pack-objects.c         | 19 ++-----------------
 pack-bitmap.c                  | 18 +++++++++++++++++-
 pack-bitmap.h                  |  9 ++++++++-
 repack-midx.c                  | 14 +++-----------
 t/t5310-pack-bitmaps.sh        | 35 +++++++++++++++++++++++++++++++++++
 t/t5319-multi-pack-index.sh    | 36 ++++++++++++++++++++++++++++++++++++
 8 files changed, 111 insertions(+), 43 deletions(-)

Range-diff versus v1:

1:  dcdc4a5aa2 ! 1:  2a2558bb22 pack-bitmap: deduplicate logic to iterate over preferred bitmap tips
    @@ Commit message
     
         We have two locations that iterate over the preferred bitmap tips as
         configured by the user via "pack.preferBitmapTips". Both of these
    -    callsites are subtly wrong and can lead to a `BUG()`, which we'll fix in
    -    a subsequent commit.
    +    callsites are subtly wrong: when the preferred bitmap tips contain an
    +    exact refname match, then we will hit a `BUG()`.
     
    -    Prepare for this fix by unifying the two callsites into a new
    +    Prepare for the fix by unifying the two callsites into a new
         `for_each_preferred_bitmap_tip()` function.
     
         This removes the last callsite of `bitmap_preferred_tips()` outside of
         "pack-bitmap.c". As such, convert the function to be local to that file
    -    only.
    +    only. Note that the function is still used by a second caller, so we
    +    cannot just inline it.
     
         Signed-off-by: Patrick Steinhardt <ps@pks.im>
     
2:  5b14a8a680 ! 2:  5b4a33a0bd pack-bitmap: fix bug with exact ref match in "pack.preferBitmapTips"
    @@ Commit message
             lead to a somewhat weird result.
     
         Neither of these feel like viable options, so calling `BUG()` feels like
    -    a sensible way out.
    -
    -    The root cause really is that we try to trim the whole refname. We can
    -    thus easily fix the bug itself by calling `refs_for_each_fullref_in()`
    -    instead. This function behaves the same as `refs_for_each_ref_in()`,
    -    except that it doesn't strip the prefix. Consequently, it correctly
    -    yields also exact refnames.
    -
    -    One resulting weirdness is that two refs "refs/heads/base" and
    -    "refs/heads/base-something" would now match if the user configured
    -    "refs/heads/base" as bitmap tips. One could arguably change the
    -    semantics of the configuration such that a string without a trailing
    -    slash needs to be an exact reference match, whereas a string with a
    -    trailing slash indicates a directory hierarchy. But such a change would
    -    potentially cause regressions with dubious benefits, so this issue is
    -    ignored for now.
    +    a sensible way out. The root cause ultimately is that we even try to
    +    trim the whole refname in the first place. There are two possible ways
    +    to fix this issue:
    +
    +      - We can fix the bug by using `refs_for_each_fullref_in()` instead,
    +        which does not strip the prefix at all. Consequently, we would now
    +        start to accept all references that start with the configured
    +        prefix, including exact matches. So if we had "refs/heads/main", we
    +        would both match "refs/heads/main" and "refs/heads/main-branch".
    +
    +      - Or we can fix the bug by appending a slash to the prefix if it
    +        doesn't already have one. This would mean that we only match
    +        ref hierarchies that start with this prefix.
    +
    +    The first fix leaves the user with strictly _more_ configuration
    +    options: they can have prefix matches by not appending a slash to the
    +    configuration, and they can have ref hierarchy matches by appending one.
    +
    +    Apply this fix and clarify the documentation accordingly.
     
         Signed-off-by: Patrick Steinhardt <ps@pks.im>
     
    + ## Documentation/config/pack.adoc ##
    +@@ Documentation/config/pack.adoc: pack.usePathWalk::
    + 
    + pack.preferBitmapTips::
    + 	When selecting which commits will receive bitmaps, prefer a
    +-	commit at the tip of any reference that is a suffix of any value
    +-	of this configuration over any other commits in the "selection
    +-	window".
    ++	commmit at the tip of a reference that matches any of the
    ++	configured prefixes.
    + +
    +-Note that setting this configuration to `refs/foo` does not mean that
    ++Note that setting this configuration to `refs/foo/` does not mean that
    + the commits at the tips of `refs/foo/bar` and `refs/foo/baz` will
    + necessarily be selected. This is because commits are selected for
    + bitmaps from within a series of windows of variable length.
    +
      ## pack-bitmap.c ##
     @@ pack-bitmap.c: void for_each_preferred_bitmap_tip(struct repository *repo,
      		return;
3:  2e1bfb0894 = 3:  1579608b04 bisect: fix misuse of `refs_for_each_ref_in()`
-:  ---------- > 4:  99a80bdb37 bisect: simplify string_list memory handling

---
base-commit: ea717645d199f6f1b66058886475db3e8c9330e9
change-id: 20260128-b4-pks-fix-for-each-ref-in-misuse-96ae62e313a5

