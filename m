Received: from fhigh-b1-smtp.messagingengine.com (fhigh-b1-smtp.messagingengine.com [202.12.124.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED9C91B87C0
	for <git@vger.kernel.org>; Wed, 16 Jul 2025 14:41:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752676919; cv=none; b=B+f77bFl/dRuP6RN91W7xaDCz0iOJM7q3/G69vbKSwo+QjTNWn+Te9+oozjuwfgHs+Kmlts9EmuzaLTgjkSUFvNvdSYkf4v0Hm6QRJkrFl1x+fg6MEc5lDtk0SiMYcopNyiQEqxeIrWJmrZAc4YviOfWuNX8AWgPIY5usJPHK1w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752676919; c=relaxed/simple;
	bh=TuSptVdZwbrrf/Yu1l6IlTwmeq5FOeqOh/AxZLPQcNg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=M5K/9upzN5n+Hhg3+xH/iiqtBOUOMxSBzvF//nMxtNioJAoCxhMNAu8rGrsNVrsrkED7XGTv0MOqPCqjVOxqEXHZcpzDsgxqMJzQfKC9q8qia2Dq/ngaogQqxEQ/GdGt6qR78YWLcaZKkkBpvFYgnNMpDczwmYq79UGcn2juZVI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=J4KoJgAs; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ilfD5WXG; arc=none smtp.client-ip=202.12.124.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="J4KoJgAs";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ilfD5WXG"
Received: from phl-compute-02.internal (phl-compute-02.phl.internal [10.202.2.42])
	by mailfhigh.stl.internal (Postfix) with ESMTP id D5FB27A0110;
	Wed, 16 Jul 2025 10:41:55 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-02.internal (MEProxy); Wed, 16 Jul 2025 10:41:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1752676915; x=1752763315; bh=8zTOzNSH2J
	C0zZmq1LdcR1tmyeKAEMUr4WGJ+J+E/nc=; b=J4KoJgAsxbwCoRhPCvx8/aSOvz
	6xX4jAjwrErHOeKAL5mtDFFRbZ+flgIfA/EXPfWvKgDkXOuCDBqUquaABnBkUcOu
	GfnWcIpOiKxtolSvhZ5udiqLtU/QZvDBuE3YCNcUORLPuD2+xKDtmQdLcyUTorEc
	WoGaYnyqJ2HoIUZNP2epXqQA880dEyDpANgW/COYuFg6Fajs4nZhCLj3FrVMlOfL
	dlL/OJ6BfQLoibtN/3s4cketFF9Zo4Zm+7F10iPezpOGvHq6L3McFcTxiq0ucbIS
	2b5MHnpS9sFE1uJtr6rKOVZ7u6530zVMXb9p/oeFO5YKU27slzbG8IA9q8Dg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1752676915; x=1752763315; bh=8zTOzNSH2JC0zZmq1LdcR1tmyeKAEMUr4WG
	J+J+E/nc=; b=ilfD5WXGMwXcmKyLgsSbXtTTCGRsIiKDc295xWIjv5Ok4WUO4Qh
	fJ40U+767DAjsX3PhyJloTd7B7lshr8jcyXXUHTZSaFpDwEb0lTaAgne0oPVgEMF
	7Ows6tufRnQJFPrHfQ2O+E47gWM2WbUkWkLKVWWU2WXEBYLvQxQ1KJO5MyQEZKnm
	FbJlfkJsfI12IITrEgazq0YpBMLeD3nkOQ5+sKKErtr/40osZxDqR0BazLUuqbeU
	eoxfrKr6ptUzmkIB8BmmFpvlTJ2LkrU+rbox7WqN0Wdl1tyC6cM/02MY7P8nlBnx
	Fxhj5mr1nb3eCoqNj7BQetKPFOwm490GK4Q==
X-ME-Sender: <xms:M7p3aDXExHbtBo01RR3ItLkx1XkaDhw13S2dfr6y9u_C_A019S5fUA>
    <xme:M7p3aFlG1KUoa2qD08Ygj79PY2BU0zIEOcrfBY5zhwVr_lE4u9QVkrguMC2r8GS-i
    0qv8v9pL_jlMmk00A>
X-ME-Received: <xmr:M7p3aGB44IJhe8q2mPSKghPzPMfle8n_233VE9-dLDpv8i9ZqTdkWkpmlESFWpAfzc1ujKnHKNuy6uyp38wgToyudNGEl2EtcvsOIE4>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdehjeeljecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecuhfhrohhmpefluhhnihhoucev
    ucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtth
    gvrhhnpeeijeeutdeluddvvdegieelgfdutdegvdeukefffeeiueefteffleekvdduledv
    ieenucffohhmrghinhepkhgvrhhnvghlrdhorhhgpdhgihhthhhusgdrtghomhdpuggtoh
    dqghhuihguvghlihhnvghsrdhmugenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgr
    mhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtph
    htthhopeekpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehsrghnuggrlhhssegt
    rhhushhthihtohhothhhphgrshhtvgdrnhgvthdprhgtphhtthhopehgihhtsehvghgvrh
    drkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepphgvfhhfsehpvghffhdrnhgvthdprhgt
    phhtthhopehrvgguohhsthgvsehrvgguohhsthgvrdighiiipdhrtghpthhtohepjhgrtg
    hosgdrkhgvlhhlvghrsehgmhgrihhlrdgtohhmpdhrtghpthhtohepphhhihhllhhiphdr
    fihoohguuddvfeesghhmrghilhdrtghomhdprhgtphhtthhopehmrghrthhinhdrrghgrh
    gvnhesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgt
    ohhm
X-ME-Proxy: <xmx:M7p3aMh-8X6kRK4nZ1iXtzlt0MFzlhjRkQdvMhbsGDyO_CvzXirH5w>
    <xmx:M7p3aLz73ddmPzLjHPk9h02toFrJ-1X0nhS8Qlst4pfVb9mu9W-YSQ>
    <xmx:M7p3aF33sqWwJef_z4-STGQZPDoVAJ2t6YfMZ3hOUEC2JIFl9YeJjA>
    <xmx:M7p3aI-1So5aeyPV46QCX8rV45AFh_bSkrSjcfe10RfhDRd_f7jDbg>
    <xmx:M7p3aNF00aXrDkqD65qTh0u1iN9TK7o5zOqOB9fTAHPkz4GB8Cp2mc3P>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 16 Jul 2025 10:41:54 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "brian m. carlson" <sandals@crustytoothpaste.net>
Cc: <git@vger.kernel.org>,  Jeff King <peff@peff.net>,  redoste
 <redoste@redoste.xyz>,  Jacob Keller <jacob.keller@gmail.com>,  Phillip
 Wood <phillip.wood123@gmail.com>,  Martin =?utf-8?Q?=C3=85gren?=
 <martin.agren@gmail.com>
Subject: Re: [PATCH v2] SubmittingPatches: allow non-real name contributions
In-Reply-To: <20250716002523.1392423-1-sandals@crustytoothpaste.net> (brian
	m. carlson's message of "Wed, 16 Jul 2025 00:25:23 +0000")
References: <20250706163009.335780-1-sandals@crustytoothpaste.net>
	<20250716002523.1392423-1-sandals@crustytoothpaste.net>
Date: Wed, 16 Jul 2025 07:41:53 -0700
Message-ID: <xmqqple0dwpa.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"brian m. carlson" <sandals@crustytoothpaste.net> writes:

> Note that this policy is the same as that of the Linux kernel[0] and the
> CNCF[1], as well as many smaller projects.  The Linux kernel patch was
> Acked-by one of the Linux Foundation's lawyers, Michael Dolan, so it
> appears these changes have had legal review.

I understand what this wants to say, but found it a tiny bit
misleading.  The kernel and CNCF do not agree with the exact
wording, and this one copies from neither, so "policy is the same"
is really "policy is in the same in spirit, even though the text to
spell out that policy used by all these three projects differ".

Which is not a bad thing at all, but was a bit misleading.

> Additionally, retain the section header ID for ease of linking across
> versions.
>
> [0] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=d4563201f33a022fc0353033d9dfeb1606a88330
> [1] https://github.com/cncf/foundation/blob/659fd32c86dc/dco-guidelines.md
>
> Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
> ---
>  Documentation/SubmittingPatches | 11 +++++++++--
>  1 file changed, 9 insertions(+), 2 deletions(-)

The text with the patch applied is great.  Let's merge it down
quickly to 'master'.

Thanks.

> diff --git a/Documentation/SubmittingPatches b/Documentation/SubmittingPatches
> index 958e3cc3d5..86ca7f6a78 100644
> --- a/Documentation/SubmittingPatches
> +++ b/Documentation/SubmittingPatches
> @@ -408,8 +408,15 @@ your patch differs from project to project, so it may be different
>  from that of the project you are accustomed to.
>  
>  [[real-name]]
> -Also notice that a real name is used in the `Signed-off-by` trailer. Please
> -don't hide your real name.
> +Please use a known identity in the `Signed-off-by` trailer, since we cannot
> +accept anonymous contributions. It is common, but not required, to use some form
> +of your real name. We realize that some contributors are not comfortable doing
> +so or prefer to contribute under a pseudonym or preferred name and we can accept
> +your patch either way, as long as the name and email you use are distinctive,
> +identifying, and not misleading.
> +
> +The goal of this policy is to allow us to have sufficient information to contact
> +you if questions arise about your contribution.
>  
>  [[commit-trailers]]
>  If you like, you can put extra trailers at the end:
