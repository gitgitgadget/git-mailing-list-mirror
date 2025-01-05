Received: from fhigh-b6-smtp.messagingengine.com (fhigh-b6-smtp.messagingengine.com [202.12.124.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AD3915CD41
	for <git@vger.kernel.org>; Sun,  5 Jan 2025 16:14:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736093652; cv=none; b=bxj+pBOCQ40hJe1a3q2NsDyFJNwPs9g6bmomAwdhno7zId3HLkB9/QdRZ7y+JfbPdfMl9hRB98E4RngwFTa0MeqLe5USK16WErDChenQ613Ig0Yee7gxPti1AyS8tGnoQsUSeEL1RFbysU0sGu9Nmlyf7YNlD0UuQ//e6jwDBX4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736093652; c=relaxed/simple;
	bh=wsakQebgbOZNK2gLZFcFoyW2nE9Jn5gisHxigvHMBzQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=sUKEVbB4VReCqhRZH1gfVhSWtX5+S9r024ZJ7vXG9vIcBVtquncxOIeHpteXfWcutxGAvBbageh5IeYM0TgwnwW+RAx0eU4I0ZCSWxYZqgpZurFMpI4UsUICpfxoCYRWMu5ZyY3L4MNMOVdIrzcUU8Q6TCUbQBIOW6OxxKGU1Wc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=ySFr7oDz; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=xSb0EoC8; arc=none smtp.client-ip=202.12.124.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="ySFr7oDz";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="xSb0EoC8"
Received: from phl-compute-12.internal (phl-compute-12.phl.internal [10.202.2.52])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 02B9F2540162;
	Sun,  5 Jan 2025 11:14:08 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-12.internal (MEProxy); Sun, 05 Jan 2025 11:14:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1736093648;
	 x=1736180048; bh=91xT9jbxHDPEq+SS44glkK/yGbzcJMQppZhzF/RdFYY=; b=
	ySFr7oDzuALPLPsdGjuNzvdu0YZb0sxz2K3D5ZzzgTaGHp+FlbuqsycxGEpePwEq
	V+o+aIbyp8DGxJV70b8YjoTVlVruos6aj+rtnyIedt5YpvFQk5qPs11Hq6On08rx
	Orto3Bq+mb0UnwFRf+VZdR+mUfetJ4GZupC84t4wUDiPomCZ7l/7xey7x2b4Fsfn
	34IGL7/ojPAcGIOR5sKtFucra57N8jm2IycH9BXv3hYdstty1RwAatDT5TRRgmeR
	nIe6ozQ3GoIYlOzxH5L8QOsQDsoRocSEGt2V2aN7IjVhefMMqyE1P7o3kqD2EPV6
	uUefH72AI879bf3xsdK9qg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1736093648; x=
	1736180048; bh=91xT9jbxHDPEq+SS44glkK/yGbzcJMQppZhzF/RdFYY=; b=x
	Sb0EoC8Zh/GycXi+2cdAJKWA+Y0O00pdgc/8dUsBldCOPI7WcQUy8R9ad4zlaNhE
	Xdg0ZDpPhPCVQeXA9e0n4y1sOqSsZ5pZrs6AR7HLK55+XEOU+UkLpdJEBZG9FZAQ
	g2aO1JSXCNB5hr3TMSoYbhbOb121VWw+/BZgyKYcKTGvtB/AKcM4Xn2xKZLz0btu
	wHxXwl05gBsrKPCD0N3xaAwmBCn23kyYPSxF7XOe691sBKWMKldnD/FMzlqLQVXb
	GQILd9vuLiA//ne5qX0hnQL2e5+sRwmAK+xMmnCrFOPgeU/qEfhNasTOpOAXaco5
	FA83LR26NBKp42PWZwMag==
X-ME-Sender: <xms:0K96Z2jaEK8oExI3f3MrHI2BCqtcDGMsCyAAK0B6q86OKxsJjNebBw>
    <xme:0K96Z3CKPH6_Kf26TpkY-TrC02OJ3TgTdLjHLwmlgX96GXpN13an_FH5pKs1vJpCH
    nRHdAdX_RNLO1TJ3w>
X-ME-Received: <xmr:0K96Z-Hpx9rdV6Fi72LbP47VyyTdRZ3Zpau8-4_8BBu1x06vC1bfV63llinLyGJHUJ9YVzSQWsTbzahYfOzkLWZNt8XsGWFh2yxC>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudefkedgkeehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgfgsehtkeertddtreej
    necuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsoh
    igrdgtohhmqeenucggtffrrghtthgvrhhnpedtffdvteegvddtkeetfeevueevlefgkeef
    heeigfehveehvdekheelveevfedtheenucevlhhushhtvghrufhiiigvpedtnecurfgrrh
    grmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgt
    phhtthhopeehpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehgihhtghhithhgrg
    gughgvthesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhn
    vghlrdhorhhgpdhrtghpthhtohepphhssehpkhhsrdhimhdprhgtphhtthhopehnvgifrh
    gvnhesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgt
    ohhm
X-ME-Proxy: <xmx:0K96Z_QmjsFLobIbu_ONBh92Hwp9sV51GpXR0ip3FAMR2jyAsVMkQA>
    <xmx:0K96ZzySud0GhfYprvVmUYP4oSTx_bVEzfcE_SF_UDMr9LDTfAfT-g>
    <xmx:0K96Z97Hm3nUo31zGpRljpy45qhvPjqCa7lrmZfUX5r7XQe5X8DP7Q>
    <xmx:0K96ZwwfK_TV8PZVt3762uhcfnpetmby7t_zXqyfmRNdgMOIdmmQ9A>
    <xmx:0K96Z-ol02o_WLzSY9aGYYYbJ1To7g5TPSMjXfWvtXV3GtPrc3mJ9bY6>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 5 Jan 2025 11:14:08 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Patrick Steinhardt <ps@pks.im>,  Elijah Newren
 <newren@gmail.com>
Subject: Re: [PATCH v2 1/2] object-name: fix resolution of object names
 containing curly braces
In-Reply-To: <13f68bebe90549ba19452f12abb6fea41c2517fb.1735949870.git.gitgitgadget@gmail.com>
	(Elijah Newren via GitGitGadget's message of "Sat, 04 Jan 2025
	00:17:49 +0000")
References: <pull.1844.git.1735699989371.gitgitgadget@gmail.com>
	<pull.1844.v2.git.1735949870.gitgitgadget@gmail.com>
	<13f68bebe90549ba19452f12abb6fea41c2517fb.1735949870.git.gitgitgadget@gmail.com>
Date: Sun, 05 Jan 2025 08:14:06 -0800
Message-ID: <xmqqmsg52q7l.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

"Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com> writes:

> Given a branch name of 'foo{bar', commands like
>
>     git cat-file -p foo{bar:README.md
>
> should succeed (assuming that branch had a README.md file, of course).
> However, the change in cce91a2caef9 (Change 'master@noon' syntax to
> 'master@{noon}'., 2006-05-19) presumed that curly braces would always
> come after an '@' or '^' and be paired, causing e.g. 'foo{bar:README.md'
> to entirely miss the ':' and assume there's no object being referenced.
> In short, git would report:
>
>     fatal: Not a valid object name foo{bar:README.md

Naïvely, it seems that a solution is to parse from left to right,
i.e., (1) notice there is a colon, (2) see if everything before that
colon resolves to a treeish, and (3) see if everything after it is a
path that appears in the treeish.

 - When we are given foo@{some:thing}, if we did that, we realize
   that "foo@{some" is not a valid tree-ish object name (since "@{"
   cannot appear in a refname) and then can backtrack by realizing
   "foo" is a ref, and @{...} could be a reflog reference (most
   likely a way to spell some sort of timestamp), and try that.

 - Similarly, for foo:path-gaffed, we would notice "foo" is a valid
   tree-ish object name, and if path-gaffed is a path in it, we'd be
   happy.  Or foo may not be a tree-ish, or path-gaffed may not
   exist in that tree-ish.  In which case, we can backtrack and see
   foo:path-g is an allowed prefix in a desribe name.

Now in the above description, I have assumed that an alternative
interpretation kicks in only as a fallback when we backtrack, but
we could make sure we try all possibilities and notice ambiguity if
we wanted to.

In any case, such an updated structure of the parsing code paths
(whether alternative interpretations are treated as fallbacks or
equally plausible candidates subject to disambiguation) would be
a vast departure from what we currently have, so a targeted "fix"
like these two patches attempt would be more appropriate as an
initial approach, I think.

Thanks, will queue, but probably we'd look at in any seriousness
after the 2.48 final gets tagged.


