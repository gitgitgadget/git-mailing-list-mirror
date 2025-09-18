Received: from fout-a8-smtp.messagingengine.com (fout-a8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C38C228466C
	for <git@vger.kernel.org>; Thu, 18 Sep 2025 15:18:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758208692; cv=none; b=gLQViuc92+KfLHSSJgG5SPg17tviW9XtZ8NdV6RNjAPK4RAlnfQ7u106ID7MxxxhaubqZvD7CvbfwXFzbDqNC/Qm2YP5Tlu0X2HwKJJgSc1lGnouNlYDdWD/571dUn60y5IvpGmVSCdJSxmhV1WX3/DW4ioDEG8DmT/UEk1yU7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758208692; c=relaxed/simple;
	bh=yCVNq97ZUxYdg6IvHBOOBrY6x7TWMWVg8fmKQx+HLPM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=bp3PocC6tdC2AqOSgRW+YU+IOfcv0P3PQDtoBVVIdLIclqovVIgzYl6QxrCykDlSrG+NIYzirMZk7cPm04BvvqctS15DBEshjgpfVLH1NTyWetP3jYwIX0OHjkM5oDPVmgI7Nf3BfXZEyijYk2qdVlgEV2ala4p9fJzj7jlBIQ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=e8flje/h; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=khwLZ3vK; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="e8flje/h";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="khwLZ3vK"
Received: from phl-compute-12.internal (phl-compute-12.internal [10.202.2.52])
	by mailfout.phl.internal (Postfix) with ESMTP id E3884EC02B4;
	Thu, 18 Sep 2025 11:18:08 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-12.internal (MEProxy); Thu, 18 Sep 2025 11:18:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1758208688; x=1758295088; bh=ozKRrhomR4
	nrwYUK/l+OopCKzzxvFdrZ+MCiiEgSUFo=; b=e8flje/hJSPOcl3XhjYmwsSblw
	SSz5MuuJKmgW+xtV9+ADwVHSl6Ix4I9QpgbqPyyIwRC1LqjvgWxbLS6RX+Gbxlqa
	vZ2dXfNjz9g0HB0VKFnbuKQQ11My0225SDwhHLtfbmNGdt1anWjEAly+c38Rbk9t
	RRwxIsTrn+M9gSFoo973mbLfk6epaf9szvUej8CcQXAK9UMIYkkmQSROgg+wPR74
	qPf7ovodpoNrH48scl8PtA0TmxGN9eZXKu/jHmtApHHlSZGhR1vdUogOQAExNYyc
	wmTdmIH/OpwN0A2Bardak+Mopp6SLUyW1zA47oE1ppvBOxDNiX2AiSIFTUyQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1758208688; x=1758295088; bh=ozKRrhomR4nrwYUK/l+OopCKzzxvFdrZ+MC
	iiEgSUFo=; b=khwLZ3vKlsHldQ2RPo7z4tMEz+Q974j0hSvP0VamELS1NOWMM0i
	lhAwAjglFc0zIQjK4yJXMkiqswdOwuWSKaw/j21eKAb0lyvHW4hQjieh7mSlit/E
	BAQBJOBSQ5PHXh6UCwEzk9d1Pd4yF/jx2/H2prCZdQxuZEctjxLkGojB0jp4g4fq
	iOKWAKSv1r8DZqgkAs2vsZPziMONif8ktRwHVNEc14floaBROXcfux+x/C7+gw3e
	MwZR9ICmoXeHflX4JGwsTjUPUPDKP/GJLej5LiJIrZ3mjqXqLDL7NnybxfRebZw5
	mu618vKTbGGpVcalxB4Ptppi0vBYUmKySfQ==
X-ME-Sender: <xms:ryLMaMXphKNN_rSs4AdNmbiOIHaKuL_oB30sPvHf7nlOhHELwiXPmQ>
    <xme:ryLMaMEZTQR2tqLmtUBTxGxp8KbxpT9wscEur9EnJAqMT7sA-c1jcnlxO1Rm1skUc
    eW7BwaTxfz0Nro6sg>
X-ME-Received: <xmr:ryLMaG2HhLvN8Yc2jGpeA8-3-DFh4uBuOnqOg8TRR7roahhfKvuCeGSHbn4d4MJNpNo34eZT-uAA0fbRUtttBD4fzVSOm_e6zv4PUpk>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdegieeijecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecuhfhrohhmpefluhhnihhoucev
    ucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtth
    gvrhhnpeettddtveffueeiieelffeftdeigfefkeevteevveeutdelhfdtudfgledtjeel
    udenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivgeptd
    enucfrrghrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdp
    nhgspghrtghpthhtohephedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepthhooh
    hnsehiohhttghlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdr
    ohhrghdprhgtphhtthhopehpshesphhkshdrihhmpdhrtghpthhtoheptghhrhhishgtoh
    holhesthhugihfrghmihhlhidrohhrghdprhgtphhtthhopehgihhtshhtvghrsehpohgs
    ohigrdgtohhm
X-ME-Proxy: <xmx:ryLMaGNUq3w_V0DedmpLGbChZ_4VJokB0l_7LMIDG5QBgTKAGQHy2A>
    <xmx:ryLMaN45BKxKuXBrw2xK00gx2tZSPS2NdLkCnj4PouR5NSgfQjeg9A>
    <xmx:ryLMaI1fqzzaXsJDRDq3PHMocmAD9X2es_H8T80jZJsVCJblRVPDYw>
    <xmx:ryLMaGyePSDQszwreTt6VAcd92KIJVBJuHQbfML-IX4Hh90RU2ddwQ>
    <xmx:sCLMaFTUUiw73KHEbACtBgwIjecVYdGUK2KIWPnxLiKEOriFPoWx1fZp>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 18 Sep 2025 11:18:07 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Toon Claes <toon@iotcl.com>
Cc: git@vger.kernel.org,  Patrick Steinhardt <ps@pks.im>,  Christian Couder
 <chriscool@tuxfamily.org>
Subject: Re: [PATCH v3] last-modified: fix bug when some paths remain unhandled
In-Reply-To: <20250918-toon-fix-last-modified-v3-1-0c3910e224f6@iotcl.com>
	(Toon Claes's message of "Thu, 18 Sep 2025 10:00:08 +0200")
References: <20250905-toon-fix-last-modified-v2-1-d859eeed408e@iotcl.com>
	<20250918-toon-fix-last-modified-v3-1-0c3910e224f6@iotcl.com>
Date: Thu, 18 Sep 2025 08:18:06 -0700
Message-ID: <xmqqy0qb94cx.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Toon Claes <toon@iotcl.com> writes:

> The recently introduced new subcommand git-last-modified(1) runs into an
> error in some scenarios. It then would exit with the message:
>
>     BUG: paths remaining beyond boundary in last-modified
>
> This seems to happens for example when criss-cross merges are involved.

"seems to happens for example when" -> "seems to happen, for
example, when".

"In some scenarios" followed by "seems to" is not particularly
convincing that we know what the cause of the problem, though.

> In that scenario, the function diff_tree_combined() gets called.

and in a simpler history that does not exhibit the problem, we
traverse without calling diff_tree_combined()?  What do we use
instead?

> The function diff_tree_combined() copies the `struct diff_options` from
> the input `struct rev_info` to override some flags. One flag is
> `recursive`, which is always set to 1. This has been the case since the
> inception of this function in af3feefa1d (diff-tree -c: show a merge
> commit a bit more sensibly., 2006-01-24).
>
> This behavior is incompatible with git-last-modified(1), when called
> non-recursive (which is the default).

"non-recursively"?

> Changes in v3:
> - Instead of changing diff_tree_combined()'s default behavior, add a
>   flag to modify it's behavior.
> - Overhaul the commit message to match the change in strategy.
> - Link to v2: https://lore.kernel.org/r/20250905-toon-fix-last-modified-v2-1-d859eeed408e@iotcl.com

I agree that this surgical approach may be the safest without
risking regression to all other callers.

Will queue on top of recent 'master' that already has the
tc/last-modified topic.

Thanks.
