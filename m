Received: from fhigh-a2-smtp.messagingengine.com (fhigh-a2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EA94253F16
	for <git@vger.kernel.org>; Fri, 20 Jun 2025 16:39:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750437557; cv=none; b=XeorEV0lC95dFFDnsDw7EyFsEmKdBbykiI7fp1FgX23mTrQUNFFsuRCyM6QSeumjEjU97pzBcEaMRSmImsYa0Q/RUdLTfqpy18O29GPRN3bFbu+naKqwy4hR2OqhjqOcK/MjC7jT7HUTnDcAZn2HgceMAgQ9urYLiAajs+/a0G8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750437557; c=relaxed/simple;
	bh=irzO5Rag8spPYC8vLP+i8gzC25b21tOJQl7+aihJJ7c=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Fq/eRK1NrINUAWT1ChOiwnCZEya4KQxT6weBwzsoEGSQmt6ANn/SMRdpYKdL61tJp3+1V8vfBJ/dx+ghGXuXdp25hymi+Vp55lwA2nmKWW2FhjpJuoSBIaPk7LSEDyfUmR/42+Q3T7sT3LhHxkXeupYBz8ew9wkpFAOtUb3YKiU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=twCt+WyG; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=NWXkmnGc; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="twCt+WyG";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="NWXkmnGc"
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 7EAEA1140156;
	Fri, 20 Jun 2025 12:39:14 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-01.internal (MEProxy); Fri, 20 Jun 2025 12:39:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1750437554; x=1750523954; bh=M56MDjtosA
	smcVjAD6Bb9xjaDP68UEiA/PL1qeEzhe8=; b=twCt+WyG60taysxPT7TFqcbqLh
	jnuBL5+RwwFrxjzrtAvcKWX2QcSuv/d3Kt3qDL2z2drnk3QNVZ/b0VI39ORSNhhi
	evns33YFCQv0MVVaB+Aj1j16yGR20CInd5Glf0Eci+uzXidLjPQNnVePYx9E0ZtY
	FMKz5eyoIop+VG4eL+r9hKK6vo0lj1s1Mz6MZnz1QghqZemofZyXj5AoOqfEj9KJ
	XO7zLb4g2dNcIIBZ7OJIlnvFo3veFdt/I4KkDyKJcL2+3fylzfd5mIwpVAIm/11I
	FyLAJZ0zs+fyKBfyPomrHpuqoBUD+YoyqijeVFgkXAmjeNezFvYYaUiVNGbQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1750437554; x=1750523954; bh=M56MDjtosAsmcVjAD6Bb9xjaDP68UEiA/PL
	1qeEzhe8=; b=NWXkmnGc6YqgCi96xBcK4ooWRYm4Jc36KLKU6t8prTrpNVdw15a
	qTLyQGOVfpF/u5GIDtxkYg89+6oxK6zG/N4c6oCTUBBU3I+ga9b0GVLzL5wXFTf2
	HPuNGJxm7OFuw6ANJTO4fWH6sTm3rCykKkfYNvycouc30+O86YLpm/wM3EF3UgzY
	IMRPhlRwavnE0z32op5u3O3V+zuVYz8yQCl+FvnEW3VSIm5tWrHV9aWNktENlmdW
	55vo9GDW2E0Bnzr7r1VklhnHewJ+BABndHnTjKLvz4dnq6sszswBZ/eA/zEys3pP
	azXJbp4w8dcpMEx4gZg3r/Jlt2IWh4sBhLA==
X-ME-Sender: <xms:so5VaBtvv_SuE7OgIuvYHaPkRXGU9MeyI9Y-Uj2TmS-TOMKUwbrcKw>
    <xme:so5VaKesLlI5c2bO0-We3yvnKoyQTop-WLakw7MOfkQxHb_t1u9kMnKLiHb9r5t3v
    DvrlRro5UnqWgmnzQ>
X-ME-Received: <xmr:so5VaEzlUeA2h77dZnipwr60BKXbfComHDo8vGrFHaWLeUZHr6wcWgfKB_J8TPczWIaUrRKtNA6lio73_n2HF4_EIx4I-EL-9188>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddvgdekkeelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceurghi
    lhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurh
    ephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcuvecu
    jfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrthhtvg
    hrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeeigeei
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepghhith
    hsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepgedpmhhouggvpehsmhht
    phhouhhtpdhrtghpthhtohepshgthhifrggssehlihhnuhigqdhmieekkhdrohhrghdprh
    gtphhtthhopehmrgigihhmsehguhhigihothhitgdrtghoohhppdhrtghpthhtohepghhi
    thesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehgihhtshhtvghrsehpoh
    gsohigrdgtohhm
X-ME-Proxy: <xmx:so5VaINV1KXbuhebbEv7FJx2GJt4oTvG_i4WNpMcsEnwylJzG30Y8g>
    <xmx:so5VaB_fQwtMzr9ve3hLmnbXyM3QvRKw23KTV-oyY2-CZwS19PaZpA>
    <xmx:so5VaIV21tl_HdGZg360hFmvKh4wWYt5wUMJUI7Ihpll_aFU9_gdDQ>
    <xmx:so5VaCeGBXprLJp9jpr3UEfufGhR_GNBWvwCHHVvmMjiS0LEX8-88w>
    <xmx:so5VaBMwxbuhD2g9xgXKRsVcl0Zkqm_Mr1LOb8GiifW0SFTMP8duSn6a>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 20 Jun 2025 12:39:13 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Andreas Schwab <schwab@linux-m68k.org>
Cc: Maxim Cournoyer <maxim@guixotic.coop>,  git@vger.kernel.org
Subject: Re: [PATCH] contrib: Honor symbolic port in git-credential-netrc.
In-Reply-To: <87pleyijbg.fsf@igel.home> (Andreas Schwab's message of "Fri, 20
	Jun 2025 16:22:43 +0200")
References: <20250620041239.27839-1-maxim@guixotic.coop>
	<xmqqmsa27cdn.fsf@gitster.g> <87pleyijbg.fsf@igel.home>
Date: Fri, 20 Jun 2025 09:39:12 -0700
Message-ID: <xmqqtt4a2wr3.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Andreas Schwab <schwab@linux-m68k.org> writes:

> On Jun 20 2025, Junio C Hamano wrote:
>
>> Do we know symbolic port names are always limited to alnums?  Or on
>> some systems some byte values in the fringe, like "_" or "-", are
>> also allowed?
>
> Valid service names are documented in RFC6335.  Specifically it allows
> hyphens, but not underscores.

Yes, something like that is what I wanted the original contributor
to write in the proposed log message to explain how the loosened
rule for accepted "port" was chosen (and relize that alnum is not
sufficient).

Thanks.
