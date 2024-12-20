Received: from fout-b1-smtp.messagingengine.com (fout-b1-smtp.messagingengine.com [202.12.124.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D161B29405
	for <git@vger.kernel.org>; Fri, 20 Dec 2024 16:17:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734711439; cv=none; b=VjRjd1txmOsxoDb8oUNPZqwi2sfLbTmlNq0bdqRo2U/bv5FbAYHBQczFIXpclYTDB6AtctS04NU7DPnAdLMRwlBlcmNL6BOqzrBTjsrTK648sauyNWw2CNevwl4XjXpRv4EQbqUQa+FDfQda2ZdIz/hAwjk+Jro2o4LReBm0Tnk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734711439; c=relaxed/simple;
	bh=ivSF2B7c0y2oM5+kVhKU2SVbgqdbzWQ5rTZLcQApw8E=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=W9E2h99KnbW6/99qa3HVTKnAfAhIlXiUdbLzsRJonhnPerbkdZclmaVBsHyZV4YSSrzAxA1QoYvPGZycgj3c1LXn0NUZB1ls3IO3H2kXB8qfszhmG8uV+IFZ524x+bnfTsY8tjYH4AzOMlkFiuPzlDDB97ikISPm1fjxKVkQRhU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=f83UEYeY; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=jFFmieYv; arc=none smtp.client-ip=202.12.124.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="f83UEYeY";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="jFFmieYv"
Received: from phl-compute-11.internal (phl-compute-11.phl.internal [10.202.2.51])
	by mailfout.stl.internal (Postfix) with ESMTP id 9C3A811401E9;
	Fri, 20 Dec 2024 11:17:16 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-11.internal (MEProxy); Fri, 20 Dec 2024 11:17:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1734711436; x=1734797836; bh=gSlas1XJJH
	PHSXGd4JqCh8tqd8mphnCzzlhEgFokz70=; b=f83UEYeYFPVhmWAKb0qPycQj0m
	bzfCWX/5MfcjGuAYJOt1pp2TkHOP82jX35ktqBXI5ttztKmb8Wg52aeOhXpfH7zM
	Fanq+467NeNqBbj+spaSAPRZcI+Y4kRGiAFxZpIQlAQjX+H3L8Yv9oCJKxNbzL4V
	UShtMVD0BJG/ocLdpAqU2u0sFkr4+ZgaUFLg4AsWArM8pY2ygr8WycnUj44IjPep
	O15JkIjEKuz6PtFYSsiEfSDgYbCnPWjbSzIQgezVVyBvKIkt1aybb5r8eEVCQBgs
	rb66Dw4Fk7Mayho0G0MT6dggRWdlpwMZOTseCapIxXkOO9Kwv948Osk5klzw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1734711436; x=1734797836; bh=gSlas1XJJHPHSXGd4JqCh8tqd8mphnCzzlh
	EgFokz70=; b=jFFmieYvm7jGuK/pOX3e6ApkokioeOBxa3zDaz9pEUvVOjgdx6J
	qJLAkYN0ZGCHO3iQHGNevXCdJsQOX5BJmj0yolfOTxQ1huYt9GaKkgAiX9UpFdiK
	sALZaT0g5SPwimig6r5xIeybwjfdu9WF4vmUm5v/nUyvL585eFJjKsJCzeCwTv4V
	gUH+UEmpSamccePIZ/DZapqavrwVHyhwXof2t25QQGGTyFyOPiBjwPI+m0F6Yb91
	4C5UyaShyD40bgxkgXXpEdIn3IAaz9WzjHwy/ujOitqvMN8Ytp8FLsYOW7Vg1bO4
	K4wpgqe1Vqegt0UNYR2GZjndvDH3p3yrz/A==
X-ME-Sender: <xms:jJhlZzaokL1ikl03lBNnTN6Vj4SnFmFbEghEtxTTg1pP5iEzj9xp2g>
    <xme:jJhlZyY_dtsneT2dfn6HB0cvYnqQ4xTB5dH4axX4ujpgIZUemarNxsiXxdlBACi1A
    0zMA7LwU9em_csplw>
X-ME-Received: <xmr:jJhlZ19ffdD4XwbnNmQtrpvqZTWjrwQ0JwQO6LccTBNkuEyLn69Cn9e3uVXXkTjSuNcbwnLBJ_j8INizbYW43q6xutcADUGfyg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddruddtvddgkeegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgesthdtredttdertden
    ucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogi
    drtghomheqnecuggftrfgrthhtvghrnhepfeevteetjeehueegffelvdetieevffeufeej
    leeuffetiefggfeftdfhfeeigeeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrg
    hmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghp
    thhtohephedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepphgvfhhfsehpvghffh
    drnhgvthdprhgtphhtthhopehpshesphhkshdrihhmpdhrtghpthhtohepghhithesvhhg
    vghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehsphgvtghtrhgrlhesghhoohhglh
    gvrdgtohhmpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:jJhlZ5phiPu2zbGlmhHWrFGFIuBAuqg15AyZJ6ueDkyEMA_BCTxe1g>
    <xmx:jJhlZ-qu_WK8LN7reHvrE-bWR1ZoIhtrVCXVAOpCr_zJRgDiD66xqA>
    <xmx:jJhlZ_RRyL0BDHAsJs35Cig-SiYqMPRYeZP6mLCQfdBfthba8f7YQQ>
    <xmx:jJhlZ2queV__lxT_jDuBsTvzekwrYyt76Cng4ra8woVn5ro5jBm9hg>
    <xmx:jJhlZ7A_r_eMx2af8_laMJAQ5dw_ziB07mtBgUI22Do9qJzfF3uoGCog>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 20 Dec 2024 11:17:15 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
Cc: Patrick Steinhardt <ps@pks.im>,  git@vger.kernel.org,  Kyle Lippincott
 <spectral@google.com>
Subject: Re: [PATCH v2 1/5] GIT-VERSION-GEN: fix overriding version via
 environment
In-Reply-To: <20241220155223.GA152570@coredump.intra.peff.net> (Jeff King's
	message of "Fri, 20 Dec 2024 10:52:23 -0500")
References: <20241220-b4-pks-git-version-via-environment-v2-0-f1457a5e8c38@pks.im>
	<20241220-b4-pks-git-version-via-environment-v2-1-f1457a5e8c38@pks.im>
	<20241220155223.GA152570@coredump.intra.peff.net>
Date: Fri, 20 Dec 2024 08:17:14 -0800
Message-ID: <xmqqpllme3cl.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jeff King <peff@peff.net> writes:

> So I dunno. I like keeping things simple, but I also like skipping
> unnecessary code, too. Maybe if the top hunk were:
>
>   if test -n "$GIT_VERSION"
>   then
>     : do nothing, we will use this value verbatim
>   elif ...
>
> that would make the intended flow more obvious.

True.

> There are probably other ways to structure it, too. The whole $VN thing
> could be inside the:
>
>   if test -z "$GIT_VERSION"
>
> block. Or alternatively, if each block of the if/else just ran expr and
> set $GIT_VERSION itself (perhaps with a one-liner helper function) then
> we wouldn't need $VN at all.

True again.  It has been quite a while since I wrote the original
before the meson topic came up and the script hasn't changed for a
long time (other than DEF_VER line for obvious reasons), but I think
in that ancient version, $VN _was_ the variable to be looked at and
GIT_VERSION did not even exist as a shell variable at all.

If $GIT_VERSION is serving the same role as old $VN in the
mesonified version, perhaps we should get rid of the $VN variable to
clarify the new world order.

> I don't know how much trouble it's worth to refactor all this. Mostly I
> was just surprised to see the first hunk at all in this version.
>
> -Peff
