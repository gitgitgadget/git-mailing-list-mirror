Received: from fhigh-b2-smtp.messagingengine.com (fhigh-b2-smtp.messagingengine.com [202.12.124.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFD4E2D8782
	for <git@vger.kernel.org>; Mon,  5 Jan 2026 22:13:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767651190; cv=none; b=LoLGaJVkvbmF2bAZzWNO97fqM242htq5p7SrqyKBKI9LkROp4L+lSeAEPGag2Ow3E1vUGju3kN9E0bWz7vl8WwbPBzcHRU4lmmuwmOFglxIUS7s3tcNuAOti8ypcHknMFLa21/R72m+qEKgVvfutGlWTUpqoh2QYIXjsKFcqKJg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767651190; c=relaxed/simple;
	bh=mjvNrsOFXQVFPODFdo6NYmdzdqYKj8sMcKMK5ljCP3A=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=EYfQaduW0YSZDPpvfkghE7qgour/G20f8Jery5pFX/jVyhtM8LICUUTBMH9HMPpXV0QBKX5I5U9Pm1OJJP+nndp3t6cHx+JAuwcGIF8gOocneoDA7uqmD0YYNe+7/8nKbuONpFyUIZA7ka7VaNJItFnyjMB7SST8pPR51xrEY0c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=Lm+g2pPz; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=nGPeExRB; arc=none smtp.client-ip=202.12.124.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="Lm+g2pPz";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="nGPeExRB"
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 734AE7A00A7;
	Mon,  5 Jan 2026 17:13:06 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-09.internal (MEProxy); Mon, 05 Jan 2026 17:13:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1767651186; x=1767737586; bh=Gdp6KIwlnC
	YcRj2s6o6Okep0Nbj/sU9wTKfGottQklE=; b=Lm+g2pPzs2T+yXHMv0tPcNqGTy
	6rocbds2a7a1Jm5obFFSqNwOIXOJ5bq93TBm8m02V6499z+RG7EBIC/aN8jpCQht
	dy1N8YIZ6rMjkkARiYyLcddqslk8zFzTZMZwLqu4eXxSk9qRfDbp+I15owJS1g6A
	+VGl1Sok5zxGiHCj2Y2asVrslMuH2OI+SdxTxUK9Z6lvbd9bTrNyPPBkWVWbsHaj
	ROdnzfMYHQXuIaCZk9SFnjUopxBnNagmmfd4N8xzB9S628xuFod2nUrebP9U425Q
	tKaMU2aMu9oTUpWTPq72z5uFDmbWY46VdZDLFzZiihEzOnsy18eDj+4Z2xbQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1767651186; x=1767737586; bh=Gdp6KIwlnCYcRj2s6o6Okep0Nbj/sU9wTKf
	GottQklE=; b=nGPeExRBhZhrNmsZ0R1wh2mXYMH11dY4wVsY6kcHIux3Ve5Gc2E
	Y/fdSzy2eLPhqqnqOKJLfERIUZvaXMSUKK8GOGAiTcZKlCyGA4WswE33RQ1vRnya
	5f/1hTmQfQEj6Gxu9DYijRr+n/dRp4pZl6Pr498aOpUUOANLiMYOk5zLiUttpGSr
	szAALZ/JwI1HxSocyWTV6W+Ql/d4nguNaLkqH2k5Qat9GlnCUrtB3dpfq0BlYXrV
	t9Y3lsV4hL43it17ZICWl+aLxoHKG9tpR5wpWPHzK+TcdObNdKsOYkW6m8JCHzNP
	4SAsXuMRdXBvgKXCMpBryiC8iAdYkqhJoDw==
X-ME-Sender: <xms:cjdcaRadx9w04Byec_FLqRNkWXMz_6EOrdizuz25FRuyeO5FHqlORA>
    <xme:cjdcafZmlp_dHUGw6PRSM-dtg1VOInZ6U-pOXLvDK21kxPFai6SoNOs3ZFxnormY1
    aX2G73BdpyGGhJzcJ1TUc29_oEpRLr9XszJwsff0FmAzTgox1UigA>
X-ME-Received: <xmr:cjdcaY_oPMCvL1NPCF-ltJa2OtS2ypnQx5v5fW8VBzC2ed-7qopyRKedDDF2xyvHOBjB7VkslIhepj9J5zRDJ2cDCQRA06fMFIhTXi4>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdelkeegjecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecuhfhrohhmpefluhhnihhoucev
    ucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtth
    gvrhhnpeefveetteejheeugeffledvteeiveffueefjeelueffteeigffgfedthfefieeg
    ieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgih
    htshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeegpdhmohguvgepshhm
    thhpohhuthdprhgtphhtthhopehhrghrrghlughnohhrughgrhgvnhesghhmrghilhdrtg
    homhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthht
    ohepghhithhgihhtghgrughgvghtsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhith
    hsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:cjdcaeiM09EL3G6T795uaiJ59AX7SsIPBGPenBX0ezRB2yJhx2sa7Q>
    <xmx:cjdcaYekzCqSVGnnd_6DFze06Dp8D1x_L3SqoDZDsC3ep4JuLNWq1g>
    <xmx:cjdcaVql_SFA9PHWKxMdvrbbBV3jCiphtF6-_9iKKUdmmGFLVFqwWQ>
    <xmx:cjdcadBWcV6T2AcYr_8XAyNS--edk__5-Khjce_hacbTPxT1punuzw>
    <xmx:cjdcaYe38_ClL0OBJgi0vgI39lqB3eOg99MzY5dBo_Vts7xolT_SIzza>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 5 Jan 2026 17:13:05 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Harald Nordgren <haraldnordgren@gmail.com>
Cc: git@vger.kernel.org,  gitgitgadget@gmail.com
Subject: Re: Another look?
In-Reply-To: <20260105131654.88348-1-haraldnordgren@gmail.com> (Harald
	Nordgren's message of "Mon, 5 Jan 2026 14:16:54 +0100")
References: <xmqqldickzva.fsf@gitster.g>
	<20260105131654.88348-1-haraldnordgren@gmail.com>
Date: Tue, 06 Jan 2026 07:13:04 +0900
Message-ID: <xmqq5x9flndb.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Harald Nordgren <haraldnordgren@gmail.com> writes:

>> Please don't.  Unless my assumption, which is that in the old code
>> "!sti" and "!ours && !theirs" is equivalent, is wrong, all you need
>> to do around that part is to first check "if (!ours && !theirs)" and
>> say "your branch is up to date with...", and then have the check
>> "else if (abf == ABQ)" next.  That way, when we check abf we know
>> the branches are different.
>
> It seems to be an incorrect assumption. This code change breaks several
> tests including old ones:



>
> ```
> diff --git a/remote.c b/remote.c
> index 1f87b85b22..8db4fcd7b5 100644
> --- a/remote.c
> +++ b/remote.c
> @@ -2303,7 +2303,7 @@ static void format_branch_comparison(struct strbuf *sb,
>  				     enum branch_mode_flags advice_flags,
>  				     int show_divergence_advice)
>  {
> -	if (!sti) {
> +	if (!ours && !theirs) {
>  		strbuf_addf(sb,
>  			_("Your branch is up to date with '%s'.\n"),
>  			branch_name);
> ```
>
>
> Harald

That is unexpected.

Looking at what stat_branch_pair() does, before returning 0, the
function always clears *num_theirs and *num_ours, so there is
something else going on.

If your caller is *not* initializing ours and theirs, and if it is
not detecting an error return from stat_tracking_info, and the test
code is trying to see when stat_branch_info() signals failure by
returning -1, then I can understand why the above change makes a
difference (i.e., your code above with or without sti -> ours/theirs
change is broken), but then, that should be handled at the caller of
stat_tracking_info() by noticing its return value being negative, I
would have to say.
