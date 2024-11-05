Received: from fout-b1-smtp.messagingengine.com (fout-b1-smtp.messagingengine.com [202.12.124.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 187C21D79A0
	for <git@vger.kernel.org>; Tue,  5 Nov 2024 06:17:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730787431; cv=none; b=JEHix2J+dx83diGeGwqXJZWnDiq3WnfyQarHxRXoQo46cb97HRTCD3v55LZvoChPMzG0hZxpIBNiNapkIVDGAkRviM0tCd9qJRtriEuRLfQv1C6u2e+l7n3Hb6g4Ev7KP0TZxmJR5hne1RMgTMG6ljFIpg/HZxt+aHXcerYdKUk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730787431; c=relaxed/simple;
	bh=mdnT9ygrsskBZbcvuAf3VgmBYmZx9tq3nf0qNpRzWnE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OYavzfDA2HOGtI0ztubA5EB49b1KH86O/x+6YnW1vfyLRh+0QSGbTFsWk1yqmIJUIhWiN8YMGMtq3ThM73j5QpwlmH0SDiDO63CXJNwhCsqbJQRdTxvfTKArZeupdJuCHe2irAuvT0f9jUVDYrtrx/Z6FbLfxFzdwMORay6N9nA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=o0DgXMi3; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=dX+SnoXt; arc=none smtp.client-ip=202.12.124.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="o0DgXMi3";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="dX+SnoXt"
Received: from phl-compute-08.internal (phl-compute-08.phl.internal [10.202.2.48])
	by mailfout.stl.internal (Postfix) with ESMTP id 1E220114018C;
	Tue,  5 Nov 2024 01:17:09 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-08.internal (MEProxy); Tue, 05 Nov 2024 01:17:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1730787428; x=1730873828; bh=gbB4E3JCqA
	3GS6dqkfiu9Ldcvc3naSIksPLka8oX0ss=; b=o0DgXMi3hVup+KrewmooUZX/Fx
	yyF2DsQwv4sU1Z/gi2lCEZUM6u0m5THTxx3/s3ZF6d2HvXpyg+LdUfwLsuS0MUXk
	anuhfrM/msKgrf71jjNkytMnCZ3zhSz45fCOZ4xCQj0JqmqF5BNCguIo2aUZ+pJx
	CuRxe6khH03Fy4pV+cogw5GdMyER6xGs/rkFtpZU7tDP3RmnSaFlJz51yCGgMJ2u
	vLoHrQ8+CVMWhdOnRMsaCr95P3gxJMgqjSQ4XDOgZKWZX/Rc4um3g+i838hO6ylQ
	MUN20vnerB+LWTskzjKWHlOGrPZi0+vM14RhtABQyWnzqaoIVX5JsENWLDJw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1730787428; x=1730873828; bh=gbB4E3JCqA3GS6dqkfiu9Ldcvc3naSIksPL
	ka8oX0ss=; b=dX+SnoXtV/Mf8RQ+M73ZpdJy1ZIxnbOkGRTMZstNGpF/zWfhAdy
	RXTfH5aLzhxgzpTC71qIyVtObGYVAslzf9Tv84Hry9wCXmDEuvKB7A29guOFtdj1
	7AZy0inXzfZOWHc/tO4h4HzaBhOsC46pojc2+cLbMVG4szcOFhLCc8Lfx6/gpubF
	OnzpbP8KpU+cRoC4a1Bm/+6nMKJNquBR+7jdd/A8ee6y/V3lmkwkiqHOL+QSMLDG
	F3PEgXYb6+Epzz3ffbO3YCuMZRGbd9eH7ve0YWG+4dhOAB8WCimHEF4CzN2IA02G
	e1IhLwxEqcq1yk85uvq93Q0xjDoQg7wtEJA==
X-ME-Sender: <xms:ZLgpZ5hnGQQ0aPoOl8PDPWUqyrEBCL9zS-XtnZTnzzaA-Mvo_iw0SQ>
    <xme:ZLgpZ-DH-Sk29SEqniAUJslshbY5tYzJmpp3xFF5x0kvOqei47yB4PVsJ14To4MDS
    cwT-kLnvfTVtVTtaw>
X-ME-Received: <xmr:ZLgpZ5GyzcLNKYF-q0gpoX_IPG6wNT6v1rHS-STjV41Ya_uNbdU-uoUuEF-oB_bEchU8UA6scPgcbC-oDJFHWlUYM_2gb8BVX3xrg7sObTDtpg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdeljedgleehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepgfefueeltdfhfefgteehfffhffegieeukeevteefvefg
    udelgeegueevudfhveeknecuffhomhgrihhnpeguihhffhhophhtrdhnohenucevlhhush
    htvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhm
    pdhnsggprhgtphhtthhopeehpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehtoh
    honhesihhothgtlhdrtghomhdprhgtphhtthhopehjlhhtohgslhgvrhesghhmrghilhdr
    tghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpth
    htohepkhhrihhsthhofhhfvghrhhgruhhgshgsrghkkhesfhgrshhtmhgrihhlrdgtohhm
    pdhrtghpthhtohepmhgvsehtthgrhihlohhrrhdrtghomh
X-ME-Proxy: <xmx:ZLgpZ-S5kmBRCXANL5_gZERdrYhH3hiE6d8gyjvT46zOcsID6P-3wg>
    <xmx:ZLgpZ2zC70MG8SwNv0lBLtW64JV0SnmFu5X4tFeaq6F6_NLk4mFENg>
    <xmx:ZLgpZ05sObqGTKHsIeTfreedS4ORTouUC0C353m4pTrdI4pFObZynA>
    <xmx:ZLgpZ7zCRtBVPzzpdv3YPUYT9KW3--2lPr4OOCpGXDGlXJueoUgUwQ>
    <xmx:ZLgpZ9pFljbZT9W07x8hBTQyNRtAgGT8flfVspx5j_F_AAV7q8Jg-agd>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 5 Nov 2024 01:17:07 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id cf3ff7e4 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 5 Nov 2024 06:16:46 +0000 (UTC)
Date: Tue, 5 Nov 2024 07:17:00 +0100
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Taylor Blau <me@ttaylorr.com>, Toon Claes <toon@iotcl.com>,
	Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
	Justin Tobler <jltobler@gmail.com>
Subject: [PATCH v3 06/22] diff-lib: fix leaking diffopts in `do_diff_cache()`
Message-ID: <24d9d9b1358d55dd304aea064515b61830a12b21.1730786196.git.ps@pks.im>
References: <cover.1728624670.git.ps@pks.im>
 <cover.1730786195.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1730786195.git.ps@pks.im>

In `do_diff_cache()` we initialize a new `rev_info` and then overwrite
its `diffopt` with a user-provided set of options. This can leak memory
because `repo_init_revisions()` may end up allocating memory for the
`diffopt` itself depending on the configuration. And since that field is
overwritten we won't ever free it.

Plug the memory leak by releasing the diffopts before we overwrite them.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 diff-lib.c           | 1 +
 t/t7610-mergetool.sh | 1 +
 2 files changed, 2 insertions(+)

diff --git a/diff-lib.c b/diff-lib.c
index 6b14b959629..3cf353946f5 100644
--- a/diff-lib.c
+++ b/diff-lib.c
@@ -661,6 +661,7 @@ int do_diff_cache(const struct object_id *tree_oid, struct diff_options *opt)
 
 	repo_init_revisions(opt->repo, &revs, NULL);
 	copy_pathspec(&revs.prune_data, &opt->pathspec);
+	diff_free(&revs.diffopt);
 	revs.diffopt = *opt;
 	revs.diffopt.no_free = 1;
 
diff --git a/t/t7610-mergetool.sh b/t/t7610-mergetool.sh
index 22b3a85b3e9..5c5e79e9905 100755
--- a/t/t7610-mergetool.sh
+++ b/t/t7610-mergetool.sh
@@ -10,6 +10,7 @@ Testing basic merge tool invocation'
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 # All the mergetool test work by checking out a temporary branch based
-- 
2.47.0.229.g8f8d6eee53.dirty

